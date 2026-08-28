/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dlog_core.h"

#include <stdatomic.h>

#include "securec.h"
#include "log_platform.h"
#include "log_common.h"
#include "dlog_shm_control.h"
#include "dlog_socket.h"
#include "dlog_attr.h"
#include "dlog_message.h"
#include "dlog_level_mgr.h"
#include "dlog_console.h"
#include "dlog_time.h"
#include "log_time.h"
#include "alog_to_slog.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

STATIC DlogCallback g_dlogCallback = {0};
STATIC bool g_dlogIsInited = false;
STATIC ToolMutex g_slogMutex = TOOL_MUTEX_INITIALIZER;
STATIC bool g_hasRegistered = false;

/**
 * @brief       : check dlog init or not
 * @return      : true inited; false not-inited
 */
STATIC INLINE bool DlogIsInited(void) { return g_dlogIsInited; }

/**
 * @brief       : set dlog init flag
 * @param [in]  : initFlag      init flag setted
 */
STATIC INLINE void DlogSetInited(bool initFlag) { g_dlogIsInited = initFlag; }

STATIC void SlogUnlock(void) { UNLOCK_WARN_LOG(&g_slogMutex); }

STATIC void SlogLock(void) { LOCK_WARN_LOG(&g_slogMutex); }

/**
 * @brief       : parent_process will call it before fork()
 */
STATIC void DlogAtForkParpare(void)
{
    SlogLock();
    if (g_dlogCallback.funcAtFork != NULL) {
        g_dlogCallback.funcAtFork(ATFORK_PREPARE);
    }
}

/**
 * @brief       : parent_process will call it after fork()
 */
STATIC void DlogAtForkParent(void)
{
    if (g_dlogCallback.funcAtFork != NULL) {
        g_dlogCallback.funcAtFork(ATFORK_PARENT);
    }
    SlogUnlock();
}

/**
 * @brief       : child_process will call it after fork()
 */
STATIC void DlogAtForkChild(void)
{
    if (g_dlogCallback.funcAtFork != NULL) {
        g_dlogCallback.funcAtFork(ATFORK_CHILD);
    }
    SlogUnlock();
}

static atomic_bool g_logCtrlSwitch = false;
static int32_t g_writePrintNum = 0;
static atomic_int_fast64_t g_lastLogCtrlMs = 0;
static atomic_int g_logCtrlLevel = DLOG_GLOABLE_DEFAULT_LEVEL;
static atomic_uint g_levelCount[LOG_MAX_LEVEL] = {0, 0, 0, 0}; // debug, info, warn, error

STATIC bool DlogGetMonotonicMs(int64_t* currentMs)
{
    ONE_ACT_NO_LOG(currentMs == NULL, return false);

    struct timespec currentTv = {0, 0};
    LogStatus result = LogGetMonotonicTime(&currentTv);
    if (result != LOG_SUCCESS) {
        return false;
    }

    *currentMs = (int64_t)currentTv.tv_sec * S_TO_MS + (int64_t)(currentTv.tv_nsec / NS_TO_MS);
    return true;
}

STATIC int64_t DlogAtomicTimeDiff(int64_t lastMs)
{
    ONE_ACT_NO_LOG(lastMs <= 0, return LOG_CTRL_TOTAL_INTERVAL + 1);

    int64_t currentMs = 0;
    ONE_ACT_NO_LOG(!DlogGetMonotonicMs(&currentMs), return LOG_CTRL_TOTAL_INTERVAL + 1);
    return (currentMs > lastMs) ? (currentMs - lastMs) : 0;
}

STATIC unsigned int LogCtrlGetLevelCount(int32_t level)
{
    ONE_ACT_NO_LOG((level < DLOG_DEBUG) || (level >= LOG_MAX_LEVEL), return 0);
    return atomic_load_explicit(&g_levelCount[level], memory_order_relaxed);
}

STATIC void LogCtrlIncLevelCount(int32_t level)
{
    ONE_ACT_NO_LOG((level < DLOG_DEBUG) || (level >= LOG_MAX_LEVEL), return);
    (void)atomic_fetch_add_explicit(&g_levelCount[level], 1U, memory_order_relaxed);
}

STATIC void LogCtrlDecLogic(void)
{
    int64_t lastMs = atomic_load_explicit(&g_lastLogCtrlMs, memory_order_relaxed);
    int64_t timeValue = DlogAtomicTimeDiff(lastMs);
    if (timeValue >= LOG_WARN_INTERVAL) {
        if (timeValue < LOG_INFO_INTERVAL) {
            if (atomic_load_explicit(&g_logCtrlLevel, memory_order_relaxed) != DLOG_WARN) {
                atomic_store_explicit(&g_logCtrlLevel, DLOG_WARN, memory_order_relaxed);
                SELF_LOG_WARN(
                    "log control down to level=WARNING, pid=%d, pid_name=%s, log loss condition: "
                    "error_num=%u, warn_num=%u, info_num=%u, debug_num=%u.",
                    DlogGetCurrPid(), DlogGetPidName(), LogCtrlGetLevelCount(DLOG_ERROR),
                    LogCtrlGetLevelCount(DLOG_WARN), LogCtrlGetLevelCount(DLOG_INFO), LogCtrlGetLevelCount(DLOG_DEBUG));
            }
        } else if (timeValue < LOG_CTRL_TOTAL_INTERVAL) {
            if (atomic_load_explicit(&g_logCtrlLevel, memory_order_relaxed) != DLOG_INFO) {
                atomic_store_explicit(&g_logCtrlLevel, DLOG_INFO, memory_order_relaxed);
                SELF_LOG_WARN(
                    "log control down to level=INFO, pid=%d, pid_name=%s, log loss condition: "
                    "error_num=%u, warn_num=%u, info_num=%u, debug_num=%u.",
                    DlogGetCurrPid(), DlogGetPidName(), LogCtrlGetLevelCount(DLOG_ERROR),
                    LogCtrlGetLevelCount(DLOG_WARN), LogCtrlGetLevelCount(DLOG_INFO), LogCtrlGetLevelCount(DLOG_DEBUG));
            }
        } else {
            atomic_store_explicit(&g_logCtrlSwitch, false, memory_order_release);
            atomic_store_explicit(
                &g_logCtrlLevel, GetGlobalLogTypeLevelVar(DLOG_GLOBAL_TYPE_MASK), memory_order_relaxed);
            atomic_store_explicit(&g_lastLogCtrlMs, 0, memory_order_relaxed);
            SELF_LOG_WARN(
                "clear log control switch, pid=%d, pid_name=%s, log loss condition: "
                "error_num=%u, warn_num=%u, info_num=%u, debug_num=%u.",
                DlogGetCurrPid(), DlogGetPidName(), LogCtrlGetLevelCount(DLOG_ERROR), LogCtrlGetLevelCount(DLOG_WARN),
                LogCtrlGetLevelCount(DLOG_INFO), LogCtrlGetLevelCount(DLOG_DEBUG));
        }
    }
}

STATIC void LogCtrlIncLogic(void)
{
    int64_t currentMs = 0;
    ONE_ACT_NO_LOG(!DlogGetMonotonicMs(&currentMs), return);

    /*
     * Level-control state transitions are reached from the socket write path
     * under SlogLock(); DlogCheckLogLevel() is the lock-free reader. Publish
     * switch after level/time so readers never observe a new switch with stale
     * control data.
     */
    if (!atomic_load_explicit(&g_logCtrlSwitch, memory_order_relaxed)) {
        atomic_store_explicit(&g_logCtrlLevel, DLOG_ERROR, memory_order_relaxed);
        atomic_store_explicit(&g_lastLogCtrlMs, currentMs, memory_order_relaxed);
        atomic_store_explicit(&g_logCtrlSwitch, true, memory_order_release);
        SELF_LOG_WARN(
            "set log control switch to level=ERROR, pid=%d, pid_name=%s, log loss condition: "
            "error_num=%u, warn_num=%u, info_num=%u, debug_num=%u.",
            DlogGetCurrPid(), DlogGetPidName(), LogCtrlGetLevelCount(DLOG_ERROR), LogCtrlGetLevelCount(DLOG_WARN),
            LogCtrlGetLevelCount(DLOG_INFO), LogCtrlGetLevelCount(DLOG_DEBUG));
    } else {
        int32_t ctrlLevel = atomic_load_explicit(&g_logCtrlLevel, memory_order_relaxed);
        if (ctrlLevel < DLOG_ERROR) {
            int32_t newLevel = ctrlLevel + 1;
            atomic_store_explicit(&g_logCtrlLevel, newLevel, memory_order_relaxed);
            SELF_LOG_WARN(
                "log control up to level=%s, pid=%d, pid_name=%s, log loss condition: "
                "error_num=%u, warn_num=%u, info_num=%u, debug_num=%u.",
                DlogGetBasicLevelNameById(newLevel), DlogGetCurrPid(), DlogGetPidName(),
                LogCtrlGetLevelCount(DLOG_ERROR), LogCtrlGetLevelCount(DLOG_WARN), LogCtrlGetLevelCount(DLOG_INFO),
                LogCtrlGetLevelCount(DLOG_DEBUG));
        }
    }
    atomic_store_explicit(&g_lastLogCtrlMs, currentMs, memory_order_relaxed);
}

STATIC int32_t SafeWrites(int32_t fd, const void* buf, uint32_t count, uint32_t moduleId, int32_t level)
{
    int32_t n, err;
    int32_t retryTimes = 0;

    do {
        n = ToolWrite(fd, buf, count);
        err = ToolGetErrorCode();
        if (n < 0) {
            if (err == EINTR) {
                continue;
            } else if ((err == EAGAIN) && (level == DLOG_ERROR)) {
                retryTimes++;
                LogCtrlIncLogic();
                continue;
            }
            break;
        }
    } while ((n < 0) && (retryTimes != WRITE_MAX_RETRY_TIMES));

    if ((n > 0) && atomic_load_explicit(&g_logCtrlSwitch, memory_order_acquire)) {
        LogCtrlDecLogic();
    } else if (n < 0) {
        LogCtrlIncLevelCount(level);
        SELF_LOG_ERROR_N(
            &g_writePrintNum, WRITE_E_PRINT_NUM,
            "write failed, print every %d times, result=%d, strerr=%s, pid=%d, pid_name=%s, "
            "module=%u, log loss condition: error_num=%u, warn_num=%u, info_num=%u, debug_num=%u.",
            WRITE_E_PRINT_NUM, n, strerror(err), DlogGetCurrPid(), DlogGetPidName(), moduleId,
            LogCtrlGetLevelCount(DLOG_ERROR), LogCtrlGetLevelCount(DLOG_WARN), LogCtrlGetLevelCount(DLOG_INFO),
            LogCtrlGetLevelCount(DLOG_DEBUG));
    }
    return n;
}

STATIC int32_t FullWrites(int32_t fd, const char* buf, uint32_t len, uint32_t moduleId, int32_t level)
{
    int32_t total = 0;
    const char* dataBuf = buf;
    uint32_t dataLen = len;
    while (dataLen > 0) {
        int32_t cc = SafeWrites(fd, (const void*)dataBuf, dataLen, moduleId, level);
        if (cc < 0) {
            if (total != 0) {
                return total;
            }
            return cc;
        }

        dataBuf = dataBuf + cc;
        if (dataLen >= (uint32_t)cc) {
            total += cc;
            dataLen -= (uint32_t)cc;
        } else {
            break;
        }
    }
    return total;
}

STATIC bool CheckLogLevelInner(const LogMsgArg* msgArg)
{
    if (msgArg->level == DLOG_EVENT) {
        return GetGlobalEnableEventVar();
    }
    // get module loglevel by moduleId
    int32_t moduleLevel = DlogGetLogTypeLevelByModuleId(msgArg->moduleId, msgArg->typeMask);
    if ((msgArg->level < moduleLevel) || (msgArg->level >= LOG_MAX_LEVEL)) {
        return false;
    }
    return (DlogCheckLogLevel(msgArg->level) == TRUE) ? true : false;
}

/**
 * @brief       : init ,then check log level
 * @param [in]  : msgArg  LogMsgArg struct pointer
 * @return      : TRUE/FALSE
 */
STATIC int32_t InitLogAndCheckLogLevel(const LogMsgArg* msgArg)
{
    if (!DlogIsInited()) {
        DlogInit();
        if (!CheckLogLevelInner(msgArg)) {
            return FALSE;
        }
    }
    return TRUE;
}

/**
 * @brief       : write to plog by callback
 * @param [in]  : logMsg        struct of log message
 */
STATIC int32_t DlogWriteToPlog(LogMsg* logMsg)
{
    DlogSetMessageNl(logMsg);

    int32_t ret = g_dlogCallback.funcWrite(logMsg->logContent, logMsg->contentLength, logMsg->type);
    if (ret != 0) {
        return FALSE;
    }
    return TRUE;
}

STATIC bool CheckLogLevelAfterInited(const LogMsgArg* msgArg)
{
    if (DlogIsInited()) {
        return CheckLogLevelInner(msgArg);
    }
    return true;
}

/**
 * @brief DlogFlush: flush log buffer to file
 * @return: void
 */
void DlogRefreshCache(void)
{
    if (g_dlogCallback.funcFlush != NULL) {
        g_dlogCallback.funcFlush();
    }
}

/**
 * @brief RegisterCallback: register DlogCallback
 * @param [in]callback: function pointer
 * @return: 0: SUCCEED, others: FAILED
 */
int RegisterCallback(const ArgPtr callback, const CallbackType funcType)
{
    SlogLock();
    switch (funcType) {
        case LOG_WRITE:
            g_dlogCallback.funcWrite = (DlogWriteCallback)callback;
            if (g_dlogCallback.funcWrite != NULL) {
                g_hasRegistered = true;
            }
            break;
        case LOG_FLUSH:
            ToolMemBarrier();
            g_dlogCallback.funcFlush = (DlogFlushCallback)callback;
            break;
        case LOG_FORK:
            g_dlogCallback.funcFork = (DlogForkCallback)callback;
            break;
        case LOG_ATFORK:
            g_dlogCallback.funcAtFork = (DlogAtForkCallback)callback;
            break;
        default:
            break;
    }
    SlogUnlock();
    return SUCCESS;
}

/**
 * @brief DlogCheckLogLevel: check log allow output or not
 * @param [in]logLevel: log level
 * @return: TRUE/FALSE
 */
int32_t DlogCheckLogLevel(int32_t logLevel)
{
    // check module loglevel and log control, check time diff to make switch back to false
    if (logLevel < LOG_MAX_LEVEL) {
        if (atomic_load_explicit(&g_logCtrlSwitch, memory_order_acquire)) {
            int64_t lastMs = atomic_load_explicit(&g_lastLogCtrlMs, memory_order_relaxed);
            if (DlogAtomicTimeDiff(lastMs) <= LOG_CTRL_TOTAL_INTERVAL) {
                int32_t ctrlLevel = atomic_load_explicit(&g_logCtrlLevel, memory_order_relaxed);
                TWO_ACT_NO_LOG(logLevel < ctrlLevel, LogCtrlIncLevelCount(logLevel), return FALSE);
            }
        }
        return TRUE;
    }
    return FALSE;
}

/**
 * @brief: check sub process, restart thread
 * @return: void
 */
STATIC void CheckPid(void)
{
    if (DlogCheckCurrPid() == false) {
#if !defined LOG_CPP && !defined APP_LOG
        DlogLevelReInit();
#endif
        if (g_dlogCallback.funcFork != NULL) {
            g_dlogCallback.funcFork();
        }
        DlogSetCurrPid();
    }
}

/**
 * @brief       : write to socket fd
 * @param [in/out]logMsg: struct of log message
 * @param [in]msgArg: LogMsgArg struct pointer
 */
STATIC void DlogWriteToSocket(LogMsg* logMsg, const LogMsgArg* msgArg)
{
    struct sigaction action, oldaction;
    (void)memset_s(&oldaction, sizeof(oldaction), 0, sizeof(oldaction));
    (void)memset_s(&action, sizeof(action), 0, sizeof(action));

    action.sa_handler = SIG_IGN;
    int32_t result = sigemptyset(&action.sa_mask);
    ONE_ACT_ERR_LOG(
        result < 0, return, "call sigemptyset failed, result=%d, strerr=%s.", result, strerror(ToolGetErrorCode()));
    int32_t sigpipe = sigaction(SIGPIPE, &action, &oldaction);

    char buffer[(uint32_t)MSG_LENGTH + LOGHEAD_LEN] = {0};
    // pooling:rsyslogd.  except for APPLICATION type, used slogd
    if (DlogIsPoolingDevice() && msgArg->attr.type != APPLICATION) {
        result =
            snprintf_s(buffer, sizeof(buffer), sizeof(buffer) - 1U, "<7>%s", logMsg->msg); // priority 7 means debug
        ONE_ACT_ERR_LOG(
            result == -1, goto RESTORE_SIGPIPE, "snprintf_s failed, strerr=%s.", strerror(ToolGetErrorCode()));
        (void)FullWrites(
            GetRsyslogSocketFd(msgArg->typeMask), buffer, LogStrlen(buffer), logMsg->moduleId, logMsg->level);
        goto RESTORE_SIGPIPE;
    }
    // construct message for socket
    if (DlogGetMsgType() == MSGTYPE_STRUCT) {
        result = DlogAddMessageHead(logMsg, buffer, (uint32_t)MSG_LENGTH + (uint32_t)LOGHEAD_LEN);
    } else {
        result = DlogAddMessageTag(logMsg, msgArg, buffer, (uint32_t)MSG_LENGTH + (uint32_t)LOGHEAD_LEN);
    }

    ONE_ACT_ERR_LOG(
        result != LOG_SUCCESS, goto RESTORE_SIGPIPE, "set message failed before write to socket, result=%d, strerr=%s.",
        result, strerror(ToolGetErrorCode()));

    result = FullWrites(GetSocketFd(), buffer, logMsg->msgLength, logMsg->moduleId, logMsg->level);
    if (result < 0) {
        CloseLogInternal();
    }
RESTORE_SIGPIPE:
    if (sigpipe == 0) {
        if (sigaction(SIGPIPE, &oldaction, (struct sigaction*)NULL) < 0) {
            SELF_LOG_ERROR(
                "examine and change a signal action failed, strerr=%s, pid=%d, module=%u.",
                strerror(ToolGetErrorCode()), DlogGetCurrPid(), logMsg->moduleId);
        }
    }
}

/**
 * @brief DlogWriteInner: write log to log socket or stdout
 * @param [in]msgArg: LogMsgArg struct pointer
 * @param [in]fmt: pointer to first value in va_list
 * @param [in]v: variable list
 */
int32_t DlogWriteInner(LogMsgArg* msgArg, const char* fmt, va_list v)
{
    // Fast path: skip formatting and the socket/file-handle lock when the log is filtered.
    ONE_ACT_NO_LOG(CheckLogLevelAfterInited(msgArg) == false, return LOG_FAILURE);

    // construct log content
    DlogGetTime(msgArg->timestamp, TIMESTAMP_LEN);
    msgArg->selfPid = DlogGetCurrPid();
    DlogGetUserAttr(&msgArg->attr);

    LogMsg logMsg = {DEBUG_LOG, 0, 0, 0, NULL, 0, {0}};
    DlogParseLogMsg(msgArg, &logMsg);
    int32_t result = DlogSetMessage(&logMsg, msgArg, fmt, v);
    ONE_ACT_ERR_LOG(result != SYS_OK, return LOG_FAILURE, "construct log content failed.");

    if ((msgArg->typeMask == STDOUT_LOG_MASK) || DlogCheckEnvStdout()) {
        DlogWriteToConsole(&logMsg);
        return LOG_SUCCESS;
    }

    // lock, To prevent the leaked of file handle.(socket)
    SlogLock();

    // if callback from not null to null, discarding log
    TWO_ACT_NO_LOG((g_hasRegistered == true) && (g_dlogCallback.funcWrite == NULL), (SlogUnlock()), return LOG_FAILURE);
    CheckPid();

    // check log level and log inited status
    result = InitLogAndCheckLogLevel(msgArg);
    TWO_ACT_NO_LOG(result == FALSE, (SlogUnlock()), return LOG_FAILURE);

    if (g_dlogCallback.funcWrite != NULL) {
        if (DlogWriteToPlog(&logMsg) == FALSE) {
            goto WRITE_CONSOLE;
        }
        SlogUnlock();
        return LOG_SUCCESS;
    }
    if (IsSocketConnected() == FALSE) {
        DlogInitMsgType();
        SetSocketFd(CreatSocket(DlogGetAttrDeviceId()));
        SetSocketConnectedStatus(TRUE);
    }
    if (!IsSocketFdValid()) {
        SetSocketConnectedStatus(FALSE);
        goto WRITE_CONSOLE;
    }
    DlogWriteToSocket(&logMsg, msgArg);
    SlogUnlock();
    return LOG_SUCCESS;

WRITE_CONSOLE:
#ifdef CONSOLE_WRITE
    DlogWriteToConsole(&logMsg);
#endif
    SlogUnlock();
    return LOG_SUCCESS;
}

/**
 * @brief       : check dlog has been inited or not
 * @return      : true      has been inited;
 *                false     not inited
 */
STATIC INLINE bool DlogCheckInit(void)
{
    if (DlogIsInited() && DlogCheckCurrPid()) {
        return true;
    }
    return false;
}

/**
 * @brief       : initialize dynamic library
 * @return      : NA
 */
void DlogInit(void)
{
    ONE_ACT_INFO_LOG(DlogCheckInit(), return, "dlog has been inited.");

    if (!DlogIsInited()) {
        // fix deadlock because of fork
        int32_t result = pthread_atfork(
            (ThreadAtFork)DlogAtForkParpare, (ThreadAtFork)DlogAtForkParent, (ThreadAtFork)DlogAtForkChild);
        ONE_ACT_ERR_LOG(
            result != 0, return, "register atFork fail, result=%d, strerr=%s.", result, strerror(ToolGetErrorCode()));
    }

    // sync time zone
    DlogInitGlobalAttr();
    DlogLevelInit();

    DlogSetInited(true);
}

STATIC CONSTRUCTOR void DllMain(void)
{
#ifdef LOG_CPP
    if (!DlogIsInited()) {
        if (AlogTryUseSlog() == LOG_SUCCESS) {
            DlogSetInited(true);
            return;
        }
    }
#endif
    DlogInit();
}

STATIC DESTRUCTOR void DlogFree(void)
{
    SlogLock();
    CloseLogInternal();
    SlogUnlock();
    AlogCloseSlogLib();
    AlogCloseDrvLib();
    DlogSetInited(false);
}

#ifdef __cplusplus
}
#endif // __cplusplus
