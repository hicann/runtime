/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlog_async_process.h"
#include "log_ring_buffer.h"
#include "dlog_time.h"
#include "dlog_level_mgr.h"
#include "log_time.h"
#include "dlog_unified_timer_api.h"
#include "unified_timer_error_code.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define LOG_TIMER_PERIOD                        1000U // 1s
#define LOG_TIMER_TRIGER_COST_MAX_TIME          2U * LOG_TIMER_PERIOD * US_TO_MS
#define LOG_SEND_COST_MAX_TIME                  150000U // 150ms
#define LOG_LOCK_COST_MAX_TIME                  50000U //50ms
#define LOG_LOST_PRINT_PERIOD_TIME              900000000UL // 15min
#define LOG_MAX_COVERED_LOSS_NUM                10000UL
#define LOG_SYNC_PERIOD                         1 // unified_timer minimum period: 100ms
#define LOG_BUF_NUM                             4U

#define LOG_MONITOR_TIME_OUT_PRINT(cost, threshold, format, ...)  \
    NO_ACT_WARN_LOG((cost) / LogGetCpuFrequency() * TICK_TO_US >= (threshold), \
        format " timeout, cost time = %llu us", ##__VA_ARGS__, (cost) / LogGetCpuFrequency() * TICK_TO_US)

#define LOG_MONITOR_TIME_OUT(action, threshold, format, ...)  \
    do {    \
        uint64_t start = LogGetCpuCycleCounter();   \
        action; \
        uint64_t end = LogGetCpuCycleCounter(); \
        uint64_t cost = end - start;    \
        LOG_MONITOR_TIME_OUT_PRINT(cost, threshold, format, ##__VA_ARGS__);   \
    } while (0)

// timer name
#if defined LOG_CPP || defined APP_LOG
#define DLOG_TIMER_NAME                         "alog_send_task_timer"
#define DLOG_SYNC_TIMER_NAME                    "alog_sync_task_timer"
#else
#define DLOG_TIMER_NAME                         "slog_send_task_timer"
#define DLOG_SYNC_TIMER_NAME                    "slog_sync_task_timer"
#endif

typedef struct DlogBufferMgr {
    RingBufferStat *dlogBuf[LOG_BUF_NUM];
    uint64_t lossCount; // covered log loss count
    uint64_t lastPrintTime; // record log loss print time
    uint32_t writeBufIndex; // current buffer index to write
    uint32_t sendBufIndex; // current buffer index to send
} DlogBufferMgr;

typedef struct DlogLevelCtrlMgr {
    bool ctrlSwitch;
    int32_t ctrlLevel;
    uint64_t lossCount; // level ctrl log loss count
    struct timespec ctrlLastTv; // record level ctrl trigger time
} DlogLevelCtrlMgr;

typedef struct DlogNsycMgr {
    bool initFlag;  // init flag, indicates whether async module is initialized
    bool syncFlag; // sync flag, indicates whether sync task is registered
    DlogBufferMgr bufMgr;
    ToolMutex mutex;
    DlogLevelCtrlMgr levelCtrl; // traffic limiting mechanism level control
    int32_t himemFd; // high memory fd
} DlogNsycMgr;

STATIC DlogNsycMgr g_dlogAsyncMgr = {false, false, {{NULL, NULL, NULL, NULL}, 0, 0, 0, 0}, PTHREAD_MUTEX_INITIALIZER,
    {false, DLOG_DEBUG, 0, {0, 0}}, -1};

/**
 * @brief       : init mutex, set robust
 */
STATIC void DlogInitMutex(void)
{
    pthread_mutexattr_t mAttr;
    (void)pthread_mutexattr_init(&mAttr);
    // PTHREAD_MUTEX_ROBUST means mutex's owner is dead before unlock it, the mutex can still be locked successfully.
    (void)pthread_mutexattr_setrobust(&mAttr, PTHREAD_MUTEX_ROBUST);
    (void)pthread_mutex_init(&g_dlogAsyncMgr.mutex, &mAttr);
    (void)pthread_mutexattr_destroy(&mAttr);
}

STATIC void DlogLock(void)
{
    int32_t ret = pthread_mutex_lock(&g_dlogAsyncMgr.mutex);
    // EOWNERDEAD means mutex's owner does not exist, mutex is in an inconsistent state.
    // It's necessary to make mutex consistent again before use it.
    if (ret == EOWNERDEAD) {
        (void)pthread_mutex_consistent(&g_dlogAsyncMgr.mutex);
    } else if (ret != SYS_OK) {
        SELF_LOG_WARN("can not lock, strerr=%s", strerror(ToolGetErrorCode()));
    } else {
        ;
    }
}

STATIC void DlogUnLock(void)
{
    UNLOCK_WARN_LOG(&g_dlogAsyncMgr.mutex);
}

/**
 * @brief       : exec this function in child process after fork
 * @return      : SYS_OK    unlock success; others  unlock failed and reinit
 */
STATIC void DlogChildUnLock(void)
{
    int32_t ret = pthread_mutex_unlock(&g_dlogAsyncMgr.mutex);
    if (ret != SYS_OK) {
        (void)pthread_mutex_destroy(&g_dlogAsyncMgr.mutex);
        DlogInitMutex();
    }
    return;
}

/**
 * @brief        : get log num in buffer
 * @return       : log count
 */
STATIC uint64_t DlogGetBufNodeCount(RingBufferStat *ringBuffer)
{
    if ((ringBuffer == NULL) || (ringBuffer->ringBufferCtrl == NULL)) {
        return 0;
    }
    uint64_t nodeCount;
    RingBufferCtrl *ringBufferCtrl = ringBuffer->ringBufferCtrl;
    if (ringBufferCtrl->logNextSeq < ringBufferCtrl->lastSeq) {
        ringBufferCtrl->lastSeq = ringBufferCtrl->logNextSeq;
        nodeCount = 0;
    } else {
        nodeCount = ringBufferCtrl->logNextSeq - ringBufferCtrl->lastSeq - LogBufLost(ringBuffer->ringBufferCtrl);
    }
    return nodeCount;
}

STATIC void LogCtrlDecLogic(void)
{
    const int64_t timeValue = DlogTimeDiff(&g_dlogAsyncMgr.levelCtrl.ctrlLastTv);
    if (timeValue >= LOG_WARN_INTERVAL) {
        if (timeValue < LOG_INFO_INTERVAL) {
            if (g_dlogAsyncMgr.levelCtrl.ctrlLevel != DLOG_WARN) {
                g_dlogAsyncMgr.levelCtrl.ctrlLevel = DLOG_WARN;
                SELF_LOG_WARN("log control down to level=WARNING, pid=%d, pid_name=%s,"
                              "log level control loss num is %lu",
                              DlogGetCurrPid(), DlogGetPidName(), g_dlogAsyncMgr.levelCtrl.lossCount);
            }
        } else if (timeValue < LOG_CTRL_TOTAL_INTERVAL) {
            if (g_dlogAsyncMgr.levelCtrl.ctrlLevel != DLOG_INFO) {
                g_dlogAsyncMgr.levelCtrl.ctrlLevel = DLOG_INFO;
                SELF_LOG_WARN("log control down to level=INFO, pid=%d, pid_name=%s, log level control loss num is %lu",
                              DlogGetCurrPid(), DlogGetPidName(), g_dlogAsyncMgr.levelCtrl.lossCount);
            }
        } else {
            g_dlogAsyncMgr.levelCtrl.ctrlSwitch = false;
            g_dlogAsyncMgr.levelCtrl.ctrlLevel = DLOG_DEBUG;
            g_dlogAsyncMgr.levelCtrl.ctrlLastTv.tv_sec = 0;
            g_dlogAsyncMgr.levelCtrl.ctrlLastTv.tv_nsec = 0;
            SELF_LOG_WARN("clear log control switch, pid=%d, pid_name=%s, log level control loss num is %lu",
                          DlogGetCurrPid(), DlogGetPidName(), g_dlogAsyncMgr.levelCtrl.lossCount);
            g_dlogAsyncMgr.levelCtrl.lossCount = 0;
        }
    }
}

STATIC void LogCtrlIncLogic(void)
{
    if (!g_dlogAsyncMgr.levelCtrl.ctrlSwitch) {
        g_dlogAsyncMgr.levelCtrl.ctrlSwitch = true;
        g_dlogAsyncMgr.levelCtrl.ctrlLevel = DLOG_ERROR;
        SELF_LOG_WARN("set log control switch to level=ERROR, pid=%d, pid_name=%s, log loss num=%lu.",
                      DlogGetCurrPid(), DlogGetPidName(), g_dlogAsyncMgr.levelCtrl.lossCount);
    } else {
        if (g_dlogAsyncMgr.levelCtrl.ctrlLevel < DLOG_ERROR) {
            g_dlogAsyncMgr.levelCtrl.ctrlLevel++;
            if (g_dlogAsyncMgr.levelCtrl.ctrlLevel == DLOG_ERROR) {
                SELF_LOG_WARN("log control up to level=ERROR, pid=%d, pid_name=%s, log loss num=%lu.",
                              DlogGetCurrPid(), DlogGetPidName(), g_dlogAsyncMgr.levelCtrl.lossCount);
            } else {
                SELF_LOG_WARN("log control up to level=WARNING, pid=%d, pid_name=%s, log loss num=%lu.",
                              DlogGetCurrPid(), DlogGetPidName(), g_dlogAsyncMgr.levelCtrl.lossCount);
            }
        }
    }
    (void)LogGetMonotonicTime(&g_dlogAsyncMgr.levelCtrl.ctrlLastTv);
}

/**
 * @brief        : write log from buffer to iam
 * @return       : >= 0 success; < 0 failure
 */
STATIC int32_t DlogWriteBufToIam(RingBufferStat *ringBuffer)
{
    return DlogIamWrite((void *)(ringBuffer->ringBufferCtrl), ringBuffer->logBufSize);
}

/**
 * @brief        : write log from buffer to himem
 * @return       : >= 0 success; < 0 failure
 */
STATIC int32_t DlogWriteBufToHiMem(RingBufferStat *ringBuffer)
{
    return HiMemWriteIamLog(g_dlogAsyncMgr.himemFd, ringBuffer);
}

STATIC void CountLogLoss(void)
{
    for (uint32_t i = 0; i < LOG_BUF_NUM; i++) {
        g_dlogAsyncMgr.bufMgr.lossCount += DlogGetBufNodeCount(g_dlogAsyncMgr.bufMgr.dlogBuf[i]);
    }
}

/**
 * @brief        : reinit log buffer to 0
 */
STATIC void DlogBufReInit(RingBufferStat *ringBuffer)
{
    LogBufReInit(ringBuffer);
}

/**
 * @brief        : if level is already sync, refresh level filter status once
 */
STATIC void DlogFilterStatus(RingBufferStat *ringBuffer)
{
    LogBufSetLevelFilter(ringBuffer->ringBufferCtrl, LEVEL_FILTER_CLOSE);
}

STATIC void SafeWritesByIam(RingBufferStat *ringBuffer)
{
    int32_t n = -1;
    int32_t err = 0;
    int32_t retryTimes = 0;
    static int32_t printNum = 0U;
    do {
        LOG_MONITOR_TIME_OUT(n = DlogWriteBufToIam(ringBuffer), LOG_SEND_COST_MAX_TIME, "iam send msg");
        if (n > 0) {
            break;
        }
        err = ToolGetErrorCode();
        if (err == EINTR) {
            continue;
        } else if (IS_BADFD(err)) {
            if (DlogIamOpenService() == SYS_OK) {
                SELF_LOG_INFO("reopen iam service fd done.");
            } else {
                (void)ToolSleep(10); // sleep 10ms for faill reopen fd
            }
            continue;
        } else {
            break;
        }
    } while (++retryTimes < WRITE_MAX_RETRY_TIMES);
    if (n > 0) {
        DlogFilterStatus(ringBuffer); // if level is setted, no more check
        DlogBufReInit(ringBuffer);
    } else {
        SELF_LOG_WARN_N_AO(&printNum, WRITE_E_PRINT_NUM,
                           "can not write to server, print every %d times, result=%d, strerr=%s, pid=%d, pid_name=%s.",
                           WRITE_E_PRINT_NUM, n, strerror(err), DlogGetCurrPid(), DlogGetPidName());
        if (DlogIsAosCore()) {
            // no need to reinit buffer, to avoid log loss when slogd not ready rather than linux faults
            (void)DlogWriteBufToHiMem(ringBuffer);
        }
    }
    return;
}

static inline void DlogModifySendBuf(uint32_t sendIdx)
{
    if (!LogBufCheckEmpty(g_dlogAsyncMgr.bufMgr.dlogBuf[sendIdx])) {
        SafeWritesByIam(g_dlogAsyncMgr.bufMgr.dlogBuf[sendIdx]);
    }
}

STATIC void DlogSyncAllSendBuf(uint32_t *sendIdx, uint32_t writeIdx)
{
    while (*sendIdx != writeIdx) {
        DlogModifySendBuf(*sendIdx);
        *sendIdx = (*sendIdx + 1U) % LOG_BUF_NUM;
    }
}

static void DlogMonitorTimerDelay(void)
{
    static uint64_t lastRoundTime = 0;
    if (lastRoundTime == 0) {
        lastRoundTime = LogGetCpuCycleCounter();
    }
    uint64_t now = LogGetCpuCycleCounter();
    LOG_MONITOR_TIME_OUT_PRINT((now - lastRoundTime), LOG_TIMER_TRIGER_COST_MAX_TIME, "trigger %s", DLOG_TIMER_NAME);
    lastRoundTime = now;
}

static bool DlogCheckWriteBufModify(uint32_t writeBufIndex)
{
    bool ret = false;
    DlogLock();
    if ((g_dlogAsyncMgr.bufMgr.writeBufIndex == writeBufIndex) &&
        !LogBufCheckEmpty(g_dlogAsyncMgr.bufMgr.dlogBuf[writeBufIndex])) {
        g_dlogAsyncMgr.bufMgr.writeBufIndex = (writeBufIndex + 1U) % LOG_BUF_NUM;
        ret = true;
    }
    DlogUnLock();
    return ret;
}

static void DlogUnifiedTimerCb(void)
{
    DlogMonitorTimerDelay();
    if (!DlogIamServiceIsValid()) {
        return;
    }
    // if write buffer is not empty and service is ready, exchange buffer and send data
    uint32_t writeBufIndex = g_dlogAsyncMgr.bufMgr.writeBufIndex;
    LOG_MONITOR_TIME_OUT(DlogSyncAllSendBuf(&g_dlogAsyncMgr.bufMgr.sendBufIndex, writeBufIndex), LOG_SEND_COST_MAX_TIME,
        "%s send all buffer", DLOG_TIMER_NAME);

    bool ret = false;
    LOG_MONITOR_TIME_OUT(ret = DlogCheckWriteBufModify(writeBufIndex), LOG_LOCK_COST_MAX_TIME,
        "%s buffer switch get lock", DLOG_TIMER_NAME);
    if (ret) {
        LOG_MONITOR_TIME_OUT(DlogModifySendBuf(writeBufIndex), LOG_SEND_COST_MAX_TIME,
            "%s send newest buffer", DLOG_TIMER_NAME);
        g_dlogAsyncMgr.bufMgr.sendBufIndex = (writeBufIndex + 1U) % LOG_BUF_NUM;
    }
    return;
}

static void DlogSyncUnifiedTimerCb(void)
{
    DlogUnifiedTimerCb();
    (void)__sync_lock_test_and_set(&g_dlogAsyncMgr.syncFlag, false);
    return;
}

static void DlogAddSyncTask(void)
{
    if (!__sync_bool_compare_and_swap(&g_dlogAsyncMgr.syncFlag, false, true)) {
        return;
    }
    if (DlogLoadTimerDll() != LOG_SUCCESS) {
        SELF_LOG_ERROR("dlog load unified_timer library failed, pid = %d, strerr = %s.",
                       ToolGetPid(), strerror(ToolGetErrorCode()));
        (void)__sync_lock_test_and_set(&g_dlogAsyncMgr.syncFlag, false);
        return;
    }
    uint32_t ret = DlogAddUnifiedTimer(DLOG_SYNC_TIMER_NAME, DlogSyncUnifiedTimerCb, LOG_SYNC_PERIOD, ONESHOT_TIMER);
    if ((ret != 0) && (ret != UNIFILED_TIMER_NAME_DUPLICATE)) {
        SELF_LOG_ERROR("add unified timer failed, ret = %u, errno = %d, pid = %d, timerName = %s.",
            ret, ToolGetErrorCode(), ToolGetPid(), DLOG_SYNC_TIMER_NAME);
        (void)__sync_lock_test_and_set(&g_dlogAsyncMgr.syncFlag, false);
    }
    return;
}

static LogStatus DlogStartSendTask(void)
{
    if (DlogLoadTimerDll() != LOG_SUCCESS) {
        SELF_LOG_ERROR("dlog load unified_timer library failed, pid = %d, strerr = %s.",
                       ToolGetPid(), strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    uint32_t ret = DlogAddUnifiedTimer(DLOG_TIMER_NAME, DlogUnifiedTimerCb, LOG_TIMER_PERIOD, PERIODIC_TIMER);
    if (ret != 0) {
        SELF_LOG_ERROR("add unified timer failed, ret = %u, errno = %d, pid = %d, timerName = %s.",
            ret, ToolGetErrorCode(), ToolGetPid(), DLOG_TIMER_NAME);
        return LOG_FAILURE;
    }
    SELF_LOG_INFO("add unified timer success, pid = %d, timerName = %s.", ToolGetPid(), DLOG_TIMER_NAME);
    return LOG_SUCCESS;
}

/**
 * @brief: check sub process, restart thread
 * @return: void
 */
void CheckPid(void)
{
    if (DlogCheckCurrPid()) {
        return;
    }

    DlogLock();
    if (DlogCheckCurrPid() == false) {
        DlogSetCurrPid();
        (void)DlogStartSendTask();
    }
    DlogUnLock();
}

/**
 * @brief       : notify thread synchronize, when buffer is empty or time out, return
 * @return      : void
 */
STATIC void DlogSyncNotify(void)
{
    int32_t retry = 0;
    const uint32_t retryWaitTime = 50U;
    bool isExit = false;
    // if sendBufIndex != writeBufIndex, means there are some send buf is wait to send, wait until send done
    if (g_dlogAsyncMgr.bufMgr.sendBufIndex != g_dlogAsyncMgr.bufMgr.writeBufIndex) {
        DlogAddSyncTask();
    }
    do {
        // if sendBufIndex == writeBufIndex, means no send buf is wait to send, send write buf right now
        // to avoid flush occupying lock, only moving write index is locked
        // check before lock to ensure perfamance
        if (g_dlogAsyncMgr.bufMgr.sendBufIndex == g_dlogAsyncMgr.bufMgr.writeBufIndex) {
            ONE_ACT_NO_LOG(isExit, return);
            DlogLock();
            if (g_dlogAsyncMgr.bufMgr.sendBufIndex == g_dlogAsyncMgr.bufMgr.writeBufIndex) {
                g_dlogAsyncMgr.bufMgr.writeBufIndex = (g_dlogAsyncMgr.bufMgr.writeBufIndex + 1U) % LOG_BUF_NUM;
            }
            DlogUnLock();
            DlogAddSyncTask();
            isExit = true;
        }
        (void)ToolSleep(retryWaitTime);
        retry++;
    } while (retry <= WRITE_MAX_RETRY_TIMES);
}

void DlogFlushBuf(void)
{
    if (!g_dlogAsyncMgr.initFlag) {
        return;
    }
    if (!DlogIamServiceIsValid()) {
        SELF_LOG_WARN("slogd is not ready, please flush later.");
        return;
    }
    FlushInfo info;
    struct IAMIoctlArg arg;

    DlogSyncNotify();

#if defined LOG_CPP || defined APP_LOG
    info.appPid = DlogGetCurrPid();
#else
    info.appPid = INVALID;
#endif
    arg.size = sizeof(FlushInfo);
    arg.argData = (void *)&info;
    const int32_t ret = DlogIamIoctlFlushLog(&arg);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("log flush failed, ret=%d, strerr=%s, pid=%d.",
                       ret, strerror(ToolGetErrorCode()), DlogGetCurrPid());
        return;
    }
}

void DlogUpdateFlierLevelStatus(void)
{
    if (!g_dlogAsyncMgr.initFlag) {
        return;
    }
    DlogLock();
    uint32_t curIdx = g_dlogAsyncMgr.bufMgr.writeBufIndex;
    if (LogBufCheckEmpty(g_dlogAsyncMgr.bufMgr.dlogBuf[curIdx])) { // if current buf is empty, not switch write index
        DlogFilterStatus(g_dlogAsyncMgr.bufMgr.dlogBuf[curIdx]);
    } else {
        uint32_t nextIdx = (curIdx + 1U) % LOG_BUF_NUM;
        if (LogBufCheckEmpty(g_dlogAsyncMgr.bufMgr.dlogBuf[nextIdx])) {
            g_dlogAsyncMgr.bufMgr.writeBufIndex = nextIdx;
            DlogFilterStatus(g_dlogAsyncMgr.bufMgr.dlogBuf[nextIdx]);
        } else {    // if next buf is not empty, means buf is full, clear current buf to save new log
            LogBufReInit(g_dlogAsyncMgr.bufMgr.dlogBuf[curIdx]);
            DlogFilterStatus(g_dlogAsyncMgr.bufMgr.dlogBuf[curIdx]);
        }
    }
    // set all empty buf level filter close
    for (uint32_t i = 0; i < LOG_BUF_NUM; i++) {
        if (LogBufCheckEmpty(g_dlogAsyncMgr.bufMgr.dlogBuf[i])) {
            DlogFilterStatus(g_dlogAsyncMgr.bufMgr.dlogBuf[i]);
        }
    }

    DlogUnLock();
}

STATIC void DlogInitHead(LogHead *head, const LogMsg *logMsg)
{
    (void)memset_s(head, sizeof(LogHead), 0, sizeof(LogHead));
    head->magic = HEAD_MAGIC;
    head->version = HEAD_VERSION;
    head->aosType = (uint8_t)DlogGetAosType(); // AOS_GEA/AOS_SEA
    head->processType = (uint8_t)DlogGetProcessType();  // APPLICATION/SYSTEM
    head->logType = (uint8_t)logMsg->type;     // debug/run/security
    head->logLevel = (uint8_t)logMsg->level;   // debug/info/warning/error/event
    head->hostPid = DlogGetHostPid();
    head->devicePid = (uint32_t)DlogGetCurrPid();
    head->deviceId = (uint16_t)DlogGetAttrDeviceId();
    head->moduleId = (uint16_t)logMsg->moduleId;
    head->allLength = 0;
    head->msgLength = (uint16_t)logMsg->msgLength;
    head->tagSwitch = 0; // 0:without tag; 1:with tag
    head->saveMode = 0;
}

STATIC void DlogPrintLogLoss(void)
{
    if (g_dlogAsyncMgr.bufMgr.lossCount > LOG_MAX_COVERED_LOSS_NUM) {
        g_dlogAsyncMgr.bufMgr.lossCount = LOG_MAX_COVERED_LOSS_NUM;
    }
    uint64_t costTime = 0;
    uint64_t currTime = LogGetCpuCycleCounter();
    const uint64_t periodTime = LOG_LOST_PRINT_PERIOD_TIME / TICK_TO_US * LogGetCpuFrequency();
    if (g_dlogAsyncMgr.bufMgr.lastPrintTime == 0) {
        costTime = periodTime;
    } else {
        costTime = currTime - g_dlogAsyncMgr.bufMgr.lastPrintTime;
    }
    if (costTime >= periodTime) {
        SELF_LOG_WARN("dlog buffer covered log loss num = %lu, print every %lu seconds.",
            g_dlogAsyncMgr.bufMgr.lossCount, LOG_LOST_PRINT_PERIOD_TIME / (uint64_t)S_TO_MS);
        g_dlogAsyncMgr.bufMgr.lastPrintTime = currTime;
        g_dlogAsyncMgr.bufMgr.lossCount = 0;
    }
}

STATIC RingBufferStat *DlogGetWriteBuf(bool *isBufSwitch, uint32_t msgLen)
{
    uint32_t curIdx = g_dlogAsyncMgr.bufMgr.writeBufIndex;
    uint32_t nextIdx = (curIdx + 1U) % LOG_BUF_NUM;
    RingBufferStat *bufMgr = g_dlogAsyncMgr.bufMgr.dlogBuf[curIdx];
    if (!LogBufCheckEnough(bufMgr, msgLen)) {
        if (LogBufCheckEmpty(g_dlogAsyncMgr.bufMgr.dlogBuf[nextIdx])) {
            g_dlogAsyncMgr.bufMgr.writeBufIndex = nextIdx;
            *isBufSwitch = true;
            ONE_ACT_NO_LOG(g_dlogAsyncMgr.levelCtrl.ctrlSwitch, LogCtrlDecLogic());
        } else {
            LogCtrlIncLogic();
        }
    } else {
        ONE_ACT_NO_LOG(g_dlogAsyncMgr.levelCtrl.ctrlSwitch, LogCtrlDecLogic());
    }
    return g_dlogAsyncMgr.bufMgr.dlogBuf[g_dlogAsyncMgr.bufMgr.writeBufIndex];
}

/**
 * @brief        : write log to buffer
 * @param [in]   : logMsg      log messages
 */
void DlogWriteToBuf(const LogMsg *logMsg)
{
    if (!g_dlogAsyncMgr.initFlag) {
        return;
    }
    if ((logMsg == NULL) || (logMsg->msgLength == 0)) {
        SELF_LOG_ERROR("log messaegs is null, pid = %d", ToolGetPid());
        return;
    }
    DlogLock();
    bool isBufSwitch = false;
    RingBufferStat *bufMgr = DlogGetWriteBuf(&isBufSwitch, logMsg->msgLength);
    TWO_ACT_NO_LOG(bufMgr == NULL, DlogUnLock(), return);

    if (g_dlogAsyncMgr.levelCtrl.ctrlSwitch && (logMsg->type == DEBUG_LOG)
        && (logMsg->level < g_dlogAsyncMgr.levelCtrl.ctrlLevel)) {
        g_dlogAsyncMgr.levelCtrl.lossCount++;
        DlogUnLock();
        return;
    }

    LogHead head = { 0 };
    DlogInitHead(&head, logMsg);
    uint64_t coverCount = 0;
    int32_t res = LogBufWrite(bufMgr->ringBufferCtrl, logMsg->msg, &head, &coverCount);
    if (res < 0) {
        SELF_LOG_ERROR("DlogWriteToBuf fail res %d", res);
    } else {
        if (coverCount > 0) {
            g_dlogAsyncMgr.bufMgr.lossCount += coverCount;
            DlogPrintLogLoss();
        }
    }
    DlogUnLock();
    // if sync task add failed, retry next time
    if (isBufSwitch) {
        DlogAddSyncTask();
    }
    return;
}

STATIC void DlogStopSendTask(void)
{
    if (g_dlogAsyncMgr.initFlag && (DlogCheckCurrPid())) {
        uint32_t ret = DlogRemoveUnifiedTimer(DLOG_TIMER_NAME);
        (void)DlogRemoveUnifiedTimer(DLOG_SYNC_TIMER_NAME); // remove one shot unified timer, if it not exist, ignore it
        NO_ACT_ERR_LOG(DlogCloseTimerDll() != LOG_SUCCESS,
            "close unified_timer library failed, pid = %d, timer name = %s.", ToolGetPid(), DLOG_TIMER_NAME);
        if (ret != 0) {
            SELF_LOG_ERROR("remove unified timer failed, ret = %u, errno = %d, pid = %d, timer name = %s.",
                ret, ToolGetErrorCode(), ToolGetPid(), DLOG_TIMER_NAME);
            return;
        }
        SELF_LOG_INFO("remove unified timer success, pid = %d, timer name = %s.", ToolGetPid(), DLOG_TIMER_NAME);
    }
}

STATIC void DlogRingBufExit(RingBufferStat **ringBuffer)
{
    if (*ringBuffer != NULL) {
        XFREE((*ringBuffer)->ringBufferCtrl);
        XFREE(*ringBuffer);
    }
}

/**
 * @brief        : free log buffer
 */
STATIC void DlogBufExit(void)
{
    for (uint32_t i = 0; i < LOG_BUF_NUM; i++) {
        DlogRingBufExit(&g_dlogAsyncMgr.bufMgr.dlogBuf[i]);
    }
}

STATIC int32_t DlogRingBufInit(RingBufferStat **ringBuffer, uint32_t size)
{
    *ringBuffer = (RingBufferStat *)LogMalloc(sizeof(RingBufferStat));
    if (*ringBuffer == NULL) {
        SELF_LOG_ERROR("malloc for log buffer failed, strerr = %s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    (*ringBuffer)->logBufSize = size;
    // malloc but not memset, memory is not actually occupied, to ensure memory baseline is met
    (*ringBuffer)->ringBufferCtrl = (RingBufferCtrl *)malloc((*ringBuffer)->logBufSize);
    if ((*ringBuffer)->ringBufferCtrl == NULL) {
        SELF_LOG_ERROR("malloc for log buffer ctrl failed, strerr = %s.", strerror(ToolGetErrorCode()));
        XFREE(*ringBuffer);
        return LOG_FAILURE;
    }
    int32_t err = LogBufInitHead((*ringBuffer)->ringBufferCtrl, (*ringBuffer)->logBufSize, 0);
    if (err != LOG_SUCCESS) {
        SELF_LOG_ERROR("init log buffer head failed, err = %d, strerr = %s, pid = %d.",
            err, strerror(ToolGetErrorCode()), ToolGetPid());
        DlogRingBufExit(ringBuffer);
        return LOG_FAILURE;
    }
    // only when libslog.so is linked, secondary verification of level is required
    LogBufSetLevelFilter((*ringBuffer)->ringBufferCtrl, LEVEL_FILTER);
    return LOG_SUCCESS;
}

/**
 * @brief        : init log buffer, malloc for buffer
 * @return       : LOG_SUCCESS success; LOG_FAILURE failure
 */
STATIC int32_t DlogBufInit(void)
{
    int32_t ret = 0;
    uint32_t size = DEF_SIZE / LOG_BUF_NUM;
    for (uint32_t i = 0; i < LOG_BUF_NUM; i++) {
        ret = DlogRingBufInit(&g_dlogAsyncMgr.bufMgr.dlogBuf[i], size);
        if (ret != LOG_SUCCESS) {
            SELF_LOG_ERROR("init buffer[%u] failed.", i);
            return LOG_FAILURE;
        }
    }
    return LOG_SUCCESS;
}

/**
 * @brief        : init nsyc process, apply for resource
 * @return       : SYS_OK success; SYS_ERROR failure
 */
int32_t DlogAsyncInit(void)
{
    if (DlogIsAosCore()) {
        (void)HiMemInit(&g_dlogAsyncMgr.himemFd);
    }
    DlogInitMutex();
    int32_t ret = pthread_atfork((ThreadAtFork)DlogLock, (ThreadAtFork)DlogUnLock, (ThreadAtFork)DlogChildUnLock);
    NO_ACT_WARN_LOG(ret != 0, "can not register fork, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));

    ret = DlogIamInit();
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    ret = DlogBufInit();
    if (ret != SYS_OK) {
        DlogBufExit();
        DlogIamExit();
        return SYS_ERROR;
    }
    if (!g_dlogAsyncMgr.initFlag) {
        if (DlogStartSendTask() == LOG_SUCCESS) {
            g_dlogAsyncMgr.initFlag = true;
        }
    }
    return SYS_OK;
}

/**
 * @brief        : exit nsyc process, release resource
 */
void DlogAsyncExit(void)
{
    DlogStopSendTask();
    DlogLock();
    CountLogLoss();
    // log loss selflog print
    SELF_LOG_INFO("pid=%d, pid_name=%s quit, log covered loss num is %lu, log level control loss num is %lu.",
                  DlogGetCurrPid(), DlogGetPidName(),
                  g_dlogAsyncMgr.bufMgr.lossCount, g_dlogAsyncMgr.levelCtrl.lossCount);
    DlogBufExit();
    DlogUnLock();
    if (DlogIsAosCore()) {
        (void)HiMemFree(&g_dlogAsyncMgr.himemFd);
    }
    DlogIamExit();
    g_dlogAsyncMgr.initFlag = false;
}

#ifdef __cplusplus
}
#endif // __cplusplus
