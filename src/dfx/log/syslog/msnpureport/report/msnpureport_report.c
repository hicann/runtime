/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msnpureport_report.h"
#include "mmpa_api.h"
#include "adx_api.h"
#include "adcore_api.h"
#include "ascend_hal.h"
#include "dsmi_common_interface.h"
#include "msnpureport_print.h"
#include "msnpureport_utils.h"
#include "msnpureport_filedump.h"
#include "msnpureport_config.h"
#include "msnpureport_file_mgr.h"
#include "log_common.h"
#include "bbox_dump_lib.h"
#include "log_communication.h"
#include "extra_config.h"
#include "ide_daemon_api.h"

#define SLOG_PATH           "slog"
#define STACKCORE_PATH      "stackcore"
#define MESSAGE_PATH        "message"
#define EVENT_PATH          "event_sched"
#define SYSTEM_INFO_PATH    "system_info"
#define DRV_DSMI_LIB        "libdrvdsmi_host.so"
#define TIME_SIZE 128
#define DEFAULT_JOINABLE_THREAD_ATTR { 0, 0, 0, 0, 0, 1, 128 * 1024 } // Default ThreadSize(128KB), joinable
#define BLOCK_RETURN_CODE 4 // device check hdc-client is in docker
#define TMP_STR_SIZE 16
#define DEFAULT_TIMEOUT 10000U // 10000ms
#define MAX_DIR_NUM 4
#define ACK_LEN 64
#define RECV_BUFF_SIZE (1024 * 1024 + sizeof(LogReportMsg))
#define MAX_RETRY_TIME 3
#define RETRY_WAIT_TIME 10000
#define SLOGD_WAIT_TIME 9        // 9s
#define MAX_RECV_TIMEOUT_COUNT 5
#define INVALID_DEV_ID (-1)     // BboxStartDump input this id means all device
#define PERMANENT_TIMEOUT 1000U
#define WAIT_ALL_DEVICE_UPDATE_TIME 10
#define INVALID_MASTER_ID (-1)

typedef int32_t (*DsmiSubscribeFaultEvent) (int, struct dsmi_event_filter, fault_event_callback);

typedef struct {
    int32_t logType;
    uint32_t logicId;
    int64_t devOsId;
    uint32_t phyId;
    bool isThreadExit;
} ThreadArgInfo;

typedef struct {
    mmUserBlock_t block;
    mmThread tid;
} ThreadInfo;

typedef struct {
    uint32_t magic;
    uint32_t version;
    int32_t retCode;
    uint8_t reserve[116];  // reserve 124 bytes
    char retMsg[128]; // msg length 128 bytes
} MsnServerResultInfo;

typedef struct {
    uint32_t devId;                 // user input logic id
    uint32_t phyId;
    int64_t masterId;
    uint32_t devNum;
    bool isSMPEnv;
    uint32_t devIds[MAX_DEV_NUM];   // all device logic id
    uint32_t phyIds[MAX_DEV_NUM];   // map logic id to physical id
    int64_t masterIds[MAX_DEV_NUM]; // map logic id to master id
} MsnDeviceInfo;

STATIC char g_logPath[MMPA_MAX_PATH + 1] = { 0 };
STATIC ThreadInfo g_slogdThread[MAX_DEV_NUM];
STATIC ThreadInfo g_logDaemonThread[MAX_DEV_NUM];
static ThreadArgInfo g_threadArgInfo[MAX_DEV_NUM];
static void *g_drvDsmiLibHandle = NULL;
static MsnDeviceInfo g_msnDeviceInfo = { 0 };

static bool IsScriptDumpLabel(const char *label)
{
    size_t itemNum = sizeof(MSNPUREPORT_FILE_DUMP_INFO) / sizeof(MSNPUREPORT_FILE_DUMP_INFO[0]);
    for (size_t i = 0; i < itemNum; ++i) {
        if (strcmp(label, MSNPUREPORT_FILE_DUMP_INFO[i].label) == 0) {
            return true;
        }
    }
    return false;
}

/**
 * @brief MsnReportInitDevInfo: get and save all device info
 * @param [in]devId: user input logic device id
 * @return EN_OK: success EN_ERROR: failed
 */
STATIC int32_t MsnReportInitDevInfo(uint32_t devId)
{
    int32_t ret = 0;
    g_msnDeviceInfo.devId = devId;
    if (devId == MAX_DEV_NUM) {
        g_msnDeviceInfo.masterId = MAX_DEV_NUM;
    } else {
        ret = MsnGetDevMasterId(devId, &g_msnDeviceInfo.phyId, &g_msnDeviceInfo.masterId);
        ONE_ACT_ERR_LOG(ret != EN_OK, return EN_ERROR, "Get master id failed, devId:%u, ret:%d", devId, ret);
    }

    ret = MsnGetDevIDs(&g_msnDeviceInfo.devNum, g_msnDeviceInfo.devIds, MAX_DEV_NUM);
    ONE_ACT_ERR_LOG(ret != EN_OK, return EN_ERROR, "Get all device id failed, ret:%d", ret);

    int32_t masterIdArr[MAX_DEV_NUM] = {0};
    int64_t masterId = 0;
    uint32_t phyId = 0;
    g_msnDeviceInfo.isSMPEnv = false;
    for (uint32_t i = 0; i < g_msnDeviceInfo.devNum; i++) {
        uint32_t logicId = g_msnDeviceInfo.devIds[i];
        ret = MsnGetDevMasterId(logicId, &phyId, &masterId);
        if (ret != EN_OK) {
            g_msnDeviceInfo.masterIds[logicId] = INVALID_MASTER_ID;
            continue;
        }
        g_msnDeviceInfo.masterIds[logicId] = masterId;
        g_msnDeviceInfo.phyIds[logicId] = phyId;

        if (masterIdArr[masterId] == 1) {
            g_msnDeviceInfo.isSMPEnv = true;
        } else {
            masterIdArr[masterId] = 1;
        }
    }

    return EN_OK;
}

/**
 * @brief GetSpecificLogs: get specific logs
 * @param [in]threadArgInfo: thread arg info
 * @param [in]fullPath: splice g_logPath and logPath eg: 2021-12-30-03-19-54/message
 * @param [in]logicId: logicId
 * @param [in]logType: logType
 * @param [in]logPath: logPath
 * @return EN_OK/EN_ERROR
 */
static int GetSpecificLogs(const ThreadArgInfo *threadArgInfo, int logType, const char *logPath, uint32_t timeout)
{
    if ((threadArgInfo->logType != (int32_t)ALL_LOG) && (threadArgInfo->logType != (int32_t)logType)) {
        return EN_OK;
    }

    int32_t ret = 0;
    const char *hostFilePath = logPath;
    char subDir[TMP_STR_SIZE] = {0};
    if (IsScriptDumpLabel(logPath)) {
        hostFilePath = SYSTEM_INFO_PATH;
    } else if (strcmp(logPath, SINGLE_EXPORT_LOG) == 0) {
        hostFilePath = SLOG_PATH;
    } else if (strcmp(logPath, EVENT_PATH) == 0) {
        hostFilePath = SYSTEM_INFO_PATH;
        ret = snprintf_s(subDir, TMP_STR_SIZE, TMP_STR_SIZE - 1, "/%s", EVENT_PATH);
        ONE_ACT_ERR_LOG(ret == -1, return EN_ERROR, "snprintf_s failed for %s, strerr=%s.",
                        EVENT_PATH, strerror(mmGetErrorCode()));
    }
    char fullPath[MMPA_MAX_PATH + 1] = { 0 };
    ret = snprintf_s(fullPath, MMPA_MAX_PATH + 1, MMPA_MAX_PATH, "%s/%s/dev-os-%ld%s", g_logPath, hostFilePath,
        threadArgInfo->devOsId, subDir);
    ONE_ACT_ERR_LOG(ret == -1, return EN_ERROR, "copy path failed, device os %ld, strerr=%s.",
                    threadArgInfo->devOsId, strerror(mmGetErrorCode()));
    if (MsnMkdirMulti(fullPath) != EN_OK) {
        return EN_ERROR;
    }
    if (strcmp(logPath, SINGLE_EXPORT_LOG) == 0) {
        ret = AdxGetSpecifiedFile((uint16_t)(threadArgInfo->phyId), fullPath, logPath,
            (int32_t)HDC_SERVICE_TYPE_LOG, (int32_t)COMPONENT_SYS_GET);
    } else {
        ret = AdxGetDeviceFileTimeout((uint16_t)(threadArgInfo->phyId), fullPath, logPath, timeout);
    }
    if (ret != 0) {
        if (ret == BLOCK_RETURN_CODE) {
            SELF_LOG_ERROR("export files failed, can not export files in docker.");
        } else {
            SELF_LOG_ERROR("get device files failed by adx, device os %ld.", threadArgInfo->devOsId);
        }
        return EN_ERROR;
    }
    SELF_LOG_INFO("Export logs to dir succeed: %s/dev-os-%ld", hostFilePath, threadArgInfo->devOsId);
    return EN_OK;
}

static int32_t GetSystemInfoLogs(const ThreadArgInfo *threadArgInfo)
{
    size_t itemNum = sizeof(MSNPUREPORT_FILE_DUMP_INFO) / sizeof(MSNPUREPORT_FILE_DUMP_INFO[0]);
    uint32_t mask = 1U << threadArgInfo->logType;
    for (size_t i = 0; i < itemNum; ++i) {
        if ((MSNPUREPORT_FILE_DUMP_INFO[i].type & mask) == 0) {
            continue;
        }
        if (GetSpecificLogs(threadArgInfo, threadArgInfo->logType,
            MSNPUREPORT_FILE_DUMP_INFO[i].label, MSNPUREPORT_FILE_DUMP_INFO[i].timeout) != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

STATIC void* SlogSyncThread(void *arg)
{
    ONE_ACT_ERR_LOG(arg == NULL, return NULL, "arg of SlogSyncThread is null.");
    ThreadArgInfo *threadArgInfo = (ThreadArgInfo *)arg;
    char threadName[TMP_STR_SIZE] = {0};
    int32_t ret = 0;
    ret = sprintf_s(threadName, TMP_STR_SIZE, "MsnLogRecv%ld", threadArgInfo->devOsId);
    ONE_ACT_ERR_LOG(ret == -1, return NULL, "Call sprintf_s failed for thread name %ld.", threadArgInfo->devOsId);
    ret = ToolSetThreadName(threadName);
    NO_ACT_WARN_LOG(ret != SYS_OK, "can not set thread name %s.", threadName);

    bool successFlag = true;
    if (!MsnIsPoolEnv()) {
        // create slog path and receive slog files
        if (GetSpecificLogs(threadArgInfo, (int32_t)SLOG_LOG, SLOG_PATH, DEFAULT_TIMEOUT) != EN_OK) {
            SELF_LOG_ERROR("export device app failed, device os %ld", threadArgInfo->devOsId);
            successFlag = false;
        }
        if (GetSpecificLogs(threadArgInfo, (int32_t)SLOG_LOG, SINGLE_EXPORT_LOG, DEFAULT_TIMEOUT) != EN_OK) {
            SELF_LOG_ERROR("export slog failed, device os %ld", threadArgInfo->devOsId);
            successFlag = false;
        }
    }

    // create stackcore path and receive stackcore files
    if (GetSpecificLogs(threadArgInfo, (int32_t)STACKCORE_LOG, STACKCORE_PATH, DEFAULT_TIMEOUT) != EN_OK) {
        SELF_LOG_ERROR("export stackcore failed, device os %ld", threadArgInfo->devOsId);
        successFlag = false;
    }
    // create message path and receive message files
    if (GetSpecificLogs(threadArgInfo, (int32_t)SLOG_LOG, MESSAGE_PATH, DEFAULT_TIMEOUT) != EN_OK) {
        SELF_LOG_ERROR("export message failed, device os %ld", threadArgInfo->devOsId);
        successFlag = false;
    }
    // create system_info path and receive system_info files
    if (GetSystemInfoLogs(threadArgInfo) != EN_OK) {
        SELF_LOG_ERROR("export system_info failed, device os %ld", threadArgInfo->devOsId);
        successFlag = false;
    }
    // create event_sched path and receive event_sched files
    if (GetSpecificLogs(threadArgInfo, (int32_t)SLOG_LOG, EVENT_PATH, DEFAULT_TIMEOUT) != EN_OK) {
        SELF_LOG_ERROR("export event_sched failed, device os %ld", threadArgInfo->devOsId);
        successFlag = false;
    }

    if (!successFlag) {
        MSNPU_FPRINTF("ERROR: export device os %ld files failed, check syslog for more information.\n",
            threadArgInfo->devOsId);
    }
    return NULL;
}

static int32_t MsnReportCreateThreadForAllDevice(ThreadInfo *threadInfo, uint32_t threadNum, bool isUseMasterId)
{
    (void)threadNum;
    mmThreadAttr threadAttr = DEFAULT_JOINABLE_THREAD_ATTR;

    bool devFlag[MAX_DEV_NUM] = { false };
    int64_t devOsId = 0;
    uint32_t i;
    for (i = 0; i < g_msnDeviceInfo.devNum; i++) {
        uint32_t logicId = g_msnDeviceInfo.devIds[i];
        if (isUseMasterId) {
            if (g_msnDeviceInfo.masterIds[logicId] == INVALID_MASTER_ID) {
                continue;
            }
            devOsId = g_msnDeviceInfo.masterIds[logicId];
        } else {
            if (logicId >= threadNum) {
                continue;
            }
            devOsId = (int64_t)logicId;
        }
        if (devFlag[devOsId] == true) {
            continue;
        }
        int32_t ret = mmCreateTaskWithThreadAttr(&threadInfo[logicId].tid, &threadInfo[logicId].block, &threadAttr);
        if (ret != EN_OK) {
            SELF_LOG_ERROR("create task(SlogSyncThread) failed, dev_id=%u, strerr=%s.",
                           g_msnDeviceInfo.devIds[i], strerror(mmGetErrorCode()));
            continue;
        }
        devFlag[devOsId] = true;
    }
    // all threads failed to be created, return ERROR
    for (i = 0; i < MAX_DEV_NUM; i++) {
        if (devFlag[i]) {
            return EN_OK;
        }
    }
    SELF_LOG_ERROR("All device thread create failed");
    return EN_ERROR;
}

static uint32_t MsnGetAllLogicIdByMatserId(int64_t masterId, uint32_t *logicIds, uint32_t size)
{
    uint32_t idNum = 0;
    for (uint32_t i = 0; i < g_msnDeviceInfo.devNum; i++) {
        if ((g_msnDeviceInfo.masterIds[g_msnDeviceInfo.devIds[i]] == masterId) && (idNum < size)) {
            logicIds[idNum] = g_msnDeviceInfo.devIds[i];
            idNum++;
        }
    }
    return idNum;
}

static void MsnSetThreadInfo(ThreadInfo *threadInfo, ThreadArgInfo *threadArg, void * (*func)(void *), int32_t logType)
{
    for (uint32_t i = 0; i < g_msnDeviceInfo.devNum; i++) {
        uint32_t logicId = g_msnDeviceInfo.devIds[i];
        threadArg[logicId].devOsId = g_msnDeviceInfo.masterIds[logicId];
        threadArg[logicId].phyId = g_msnDeviceInfo.phyIds[logicId];
        threadArg[logicId].logicId = logicId;
        threadArg[logicId].isThreadExit = false;
        threadArg[logicId].logType = logType;
        threadInfo[logicId].block.procFunc = func;
        threadInfo[logicId].block.pulArg = (void *)&threadArg[logicId];
    }
}

STATIC int32_t MsnReportCreateThreadSingle(uint32_t devId, ThreadInfo *threadInfo)
{
    mmThreadAttr threadAttr = DEFAULT_JOINABLE_THREAD_ATTR;
    int32_t ret = mmCreateTaskWithThreadAttr(&threadInfo[devId].tid, &threadInfo[devId].block, &threadAttr);
    if (ret != EN_OK) {
        SELF_LOG_ERROR("Create Report Thread failed, dev_id=%u, strerr=%s.", devId, strerror(mmGetErrorCode()));
        return EN_ERROR;
    }
    return EN_OK;
}

STATIC int32_t MsnReportCreateThreadSingleOs(uint32_t devId, ThreadInfo *threadInfo, bool isUseMasterId)
{
    int64_t devOsId = g_msnDeviceInfo.masterIds[devId];
    if (devOsId == INVALID_MASTER_ID) {
        return EN_ERROR;
    }

    uint32_t logicIds[MAX_DEV_NUM] = { 0 };
    uint32_t logicNum = MsnGetAllLogicIdByMatserId(devOsId, logicIds, MAX_DEV_NUM);
    int32_t ret = EN_ERROR;
    for (uint32_t i = 0; i < logicNum; i++) {
        if (MsnReportCreateThreadSingle(logicIds[i], threadInfo) != EN_OK) {
            continue;
        }
        // all threads failed to be created, return ERROR
        ret = EN_OK;
        if (isUseMasterId) {
            return EN_OK;
        }
    }
    return ret;
}

/**
 * @brief SlogStartSyncFile: start thread to sync device log files
 * @param [in]logType: log type
 * @return EN_OK/EN_ERROR
 */
static int SlogStartSyncFile(uint32_t logicId, int32_t logType)
{
    if (MsnReportInitDevInfo(logicId) != EN_OK) {
        return EN_ERROR;
    }
    errno_t err = memset_s(g_slogdThread, MAX_DEV_NUM * sizeof(ThreadInfo), 0, MAX_DEV_NUM * sizeof(ThreadInfo));
    if (err != EOK) {
        SELF_LOG_ERROR("Memset for g_slogdThread failed, ret:%d", err);
        return EN_ERROR;
    }
    MsnSetThreadInfo(g_slogdThread, g_threadArgInfo, SlogSyncThread, logType);
    if (logicId == MAX_DEV_NUM) {
        return MsnReportCreateThreadForAllDevice(g_slogdThread, MAX_DEV_NUM, true);
    } else {
        return MsnReportCreateThreadSingleOs(logicId, g_slogdThread, true);
    }
}

static void MsnJoinThreads(ThreadInfo *threadInfo, uint32_t threadNum)
{
    int32_t ret = 0;
    for (uint32_t i = 0; i < threadNum; i++) {
        if (threadInfo[i].tid == 0) {
            continue;
        }
        ret = mmJoinTask(&threadInfo[i].tid);
        if (ret != EN_OK) {
            SELF_LOG_ERROR("pthread join failed, dev_id=%u, strerr=%s.", i, strerror(mmGetErrorCode()));
        }
        threadInfo[i].tid = 0;
    }
}

static void* ExportRegisterThread(void *arg)
{
    ONE_ACT_ERR_LOG(arg == NULL, return NULL, "arg is null.");
    ThreadArgInfo *threadArgInfo = (ThreadArgInfo *)arg;
    ArgInfo argInfo = {REPORT, 0, threadArgInfo->logicId, 0, -1, 0, 0, 0, 0, {0}};
    if (MsnConfig(&argInfo) == EN_OK) {
        MSNPU_WAR("Need reboot after export register.");
    }
    return NULL;
}

static void ExportDeviceRegister(uint32_t logicId)
{
    ThreadInfo threadInfo[MAX_DEV_NUM];
    ThreadArgInfo threadArgInfo[MAX_DEV_NUM];
    (void)memset_s(threadInfo, MAX_DEV_NUM * sizeof(ThreadInfo), 0, MAX_DEV_NUM * sizeof(ThreadInfo));
    (void)memset_s(threadArgInfo, MAX_DEV_NUM * sizeof(ThreadArgInfo), 0, MAX_DEV_NUM * sizeof(ThreadArgInfo));
    MsnSetThreadInfo(threadInfo, threadArgInfo, ExportRegisterThread, 0);
    int32_t ret = 0;
    if (logicId == MAX_DEV_NUM) {
        ret = MsnReportCreateThreadForAllDevice(threadInfo, MAX_DEV_NUM, false);
    } else {
        ret = MsnReportCreateThreadSingleOs(logicId, threadInfo, false);
    }
    if (ret != EN_OK) {
        return;
    }
    MsnJoinThreads(threadInfo, MAX_DEV_NUM);
}

/**
 * @brief BboxStartSyncFile: start to sync bbox files
 * @param [in]opt: bbox dump opt
 * @return EN_OK/EN_ERROR
 */
static int BboxStartSyncFile(uint32_t logicId, const struct BboxDumpOpt *opt, int32_t logType)
{
    if (logType == (int32_t)HISILOGS_LOG) {
        ExportDeviceRegister(logicId);
    }
    int32_t ret = 0;
    if (logicId == MAX_DEV_NUM) {
        ret = BboxStartDump(INVALID_DEV_ID, g_logPath, (int32_t)strlen(g_logPath), opt);
        ONE_ACT_ERR_LOG(ret != 0, return EN_ERROR, "start bbox dump failed.");
        // wait bbox sync thread stop
        BboxStopDump();
    } else {
        uint32_t logicIds[MAX_DEV_NUM] = { 0 };
        uint32_t logicNum = MsnGetAllLogicIdByMatserId(g_msnDeviceInfo.masterId, logicIds, MAX_DEV_NUM);
        for (uint32_t i = 0; i < logicNum; i++) {
            // the bbox interface does not support multiple device concurrency
            ret = BboxStartDump((int32_t)logicIds[i], g_logPath, (int32_t)strlen(g_logPath), opt);
            ONE_ACT_ERR_LOG(ret != BBOX_SUCCESS, return EN_ERROR, "Start bbox dump failed.");
            BboxStopDump();
        }
    }
    return EN_OK;
}

STATIC void GetHostDrvLog(void)
{
    char *fullPath = (char *)calloc(1, MMPA_MAX_PATH + 1);
    ONE_ACT_ERR_LOG(fullPath == NULL, return, "calloc failed for host drv, strerr=%s.", strerror(mmGetErrorCode()));
    int32_t ret = 0;
    do {
        ret = snprintf_s(fullPath, MMPA_MAX_PATH + 1, MMPA_MAX_PATH, "%s/%s/host", g_logPath, SLOG_PATH);
        ONE_ACT_ERR_LOG(ret == -1, break, "copy path failed, strerr=%s.", strerror(mmGetErrorCode()));

        if (MsnMkdirMulti(fullPath) != EN_OK) {
            break;
        }

        int32_t len = (int32_t)strlen(fullPath);
        drvError_t err = halGetDeviceInfoByBuff(0, MODULE_TYPE_LOG, INFO_TYPE_HOST_KERN_LOG, (void *)fullPath, &len);
        if (err != DRV_ERROR_NONE) {
            if (err == DRV_ERROR_NOT_SUPPORT) {
                SELF_LOG_WARN("Current environment not support export host driver log.");
            } else {
                SELF_LOG_ERROR("get host driver log failed, return: %d", (int32_t)err);
            }
        }
    } while (0);
    free(fullPath);
}

/**
 * @brief MsnReportStop: wait all thread stop
 * @return void
 */
static void MsnReportStop(void)
{
    int ret;
    // wait slog sync thread stop
    unsigned int i;
    for (i = 0; i < MAX_DEV_NUM; i++) {
        if (g_slogdThread[i].tid == 0) {
            continue;
        }
        ret = mmJoinTask(&g_slogdThread[i].tid);
        if (ret != EN_OK) {
            SELF_LOG_ERROR("pthread join failed, dev_id=%u, strerr=%s.", i, strerror(mmGetErrorCode()));
        }
        g_slogdThread[i].tid = 0;
    }
}

/**
 * @brief MsnSyncDeviceLog: start thread to receive files from device
 * @param [in]opt: bbox dump opt
 * @param [in]logType: log type
 * @return EN_OK/EN_ERROR
 */
static int32_t MsnSyncDeviceLog(uint32_t logicId, const struct BboxDumpOpt *opt, int logType)
{
    int32_t ret = SlogStartSyncFile(logicId, logType);
    if (ret != EN_OK) {
        if (MsnIsDockerEnv()) {
            SELF_LOG_ERROR("export files failed, can not export files in docker.");
        } else {
            SELF_LOG_ERROR("export files failed, please check error message.");
        }
    }
    int32_t err = 0;
    if ((logType == (int32_t)ALL_LOG) || (logType == (int32_t)HISILOGS_LOG) || (logType == (int32_t)VMCORE_FILE)) {
        err = BboxStartSyncFile(logicId, opt, logType);
        if (err != EN_OK) {
            SELF_LOG_ERROR("start to sync bbox dump failed.");
        }
    }
    MsnReportStop();
    return ((ret == EN_OK) && (err == EN_OK)) ? EN_OK : EN_ERROR;
}

/**
 * @brief GetLocalTimeForPath: get current timestamp
 * @param [in]bufLen: time buffer size
 * @param [in/out]timeBuffer: timestamp buffer
 * @return EN_OK/EN_ERROR
 */
static int GetLocalTimeForPath(unsigned int bufLen, char *timeBuffer)
{
    mmTimeval currentTimeval = { 0 };
    struct tm timeInfo = { 0 };

    int32_t ret = mmGetTimeOfDay(&currentTimeval, NULL);
    ONE_ACT_ERR_LOG(ret != EN_OK, return EN_ERROR, "get times failed.");

    const time_t sec = currentTimeval.tv_sec;
    ret = mmLocalTimeR(&sec, &timeInfo);
    ONE_ACT_ERR_LOG(ret != EN_OK, return EN_ERROR, "get timestamp failed.");

    ret = snprintf_s(timeBuffer, bufLen, bufLen - 1, "%04d-%02d-%02d-%02d-%02d-%02d",
                     timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday,
                     timeInfo.tm_hour, timeInfo.tm_min, timeInfo.tm_sec);
    ONE_ACT_ERR_LOG(ret == -1, return EN_ERROR, "copy time buffer failed, strerr=%s.", strerror(mmGetErrorCode()));

    return EN_OK;
}

/**
 * @brief CreateLogRootPath: mkdir slog root path for device log syncing
 * @return EN_OK/EN_ERROR
 */
STATIC int32_t CreateLogRootPath(void)
{
    char timer[TIME_SIZE + 1] = { 0 };
    if (GetLocalTimeForPath(TIME_SIZE, timer) != EN_OK) {
        return EN_ERROR;
    }
    char *currentPath = (char *)calloc(1, MMPA_MAX_PATH + 1);
    ONE_ACT_ERR_LOG(currentPath == NULL, return EN_ERROR, "calloc failed, strerr=%s.", strerror(mmGetErrorCode()));

    bool flag = false;
    do {
        if (mmGetCwd(currentPath, MMPA_MAX_PATH) != EN_OK) {
            SELF_LOG_ERROR("get current path failed, strerr=%s.", strerror(mmGetErrorCode()));
            break;
        }

        if (sprintf_s(g_logPath, MMPA_MAX_PATH + 1, "%s/%s", currentPath, timer) == -1) {
            SELF_LOG_ERROR("sprintf_s for root path failed, strerr=%s.", strerror(mmGetErrorCode()));
            break;
        }
        if (MsnMkdirMulti(g_logPath) != EN_OK) {
            SELF_LOG_ERROR("mkdir failed, strerr=%s.", strerror(mmGetErrorCode()));
            break;
        }

        MSNPU_FPRINTF("Start exporting logs and files to path: %s\n", g_logPath);
        flag = true;
    } while (0);

    free(currentPath);
    return flag == true ? EN_OK : EN_ERROR;
}

STATIC bool IsHaveExecPermission(void)
{
#if (OS_TYPE == LINUX)
    return geteuid() == 0;
#else
    return false;
#endif
}

/**
 * @brief export device log
 * @param [in]opt: bboxdump info
 * @param [in]logType: log type
 * @return EN_OK: succ EN_ERROR: failed
 */
STATIC int32_t SyncDeviceLog(uint32_t logicId, const struct BboxDumpOpt *opt, int32_t logType)
{
    if (!IsHaveExecPermission()) {
        SELF_LOG_ERROR("Not have permission to export files.");
        return EN_ERROR;
    }

    if (CreateLogRootPath() != EN_OK) {
        return EN_ERROR;
    }

    if (logType == (int32_t)ALL_LOG) {
        GetHostDrvLog();
    }

    // run thread to connect device for log
    int32_t ret = MsnSyncDeviceLog(logicId, opt, logType);
    if (ret == EN_OK) {
        MSNPU_FPRINTF("Export finished.\n");
    }
    return ret;
}

static int32_t MsnReportCreateLongLink(uint32_t devId, uint32_t timeout, void **handle, int32_t serverType,
    ComponentType compType)
{
    AdxCommHandle adxHandle = AdxCreateCommHandle(serverType, (int32_t)devId, compType);
    int32_t ret = AdxIsCommHandleValid(adxHandle);
    if (ret != IDE_DAEMON_OK) {
        SELF_LOG_ERROR("Adx create handle is invalid, devId=%u, ret=%d.", devId, ret);
        return EN_ERROR;
    }

    // receive ack
    char *buffer = (char *)MsnMalloc(ACK_LEN);
    ONE_ACT_ERR_LOG(buffer == NULL, return EN_ERROR, "Malloc for ack buffer failed, devId=%u, strerr=%s.", devId,
                    strerror(ToolGetErrorCode()));
    uint32_t bufLen = ACK_LEN;
    do {
        ret = AdxRecvMsg(adxHandle, &buffer, &bufLen, timeout);
        if ((ret != IDE_DAEMON_OK) || (bufLen == 0U)) {
            SELF_LOG_ERROR("AdxRecvMsg failed, ret=%d, bufLen=%u bytes.", ret, bufLen);
            ret = EN_ERROR;
            break;
        }
        if (strcmp(buffer, HDC_END_MSG) == 0) {
            ret = EN_OK;
            break;
        }
        ret = EN_ERROR;
        if (strcmp(buffer, CONNECT_OCCUPIED_MESSAGE) == 0) {
            MSNPU_FPRINTF("Another msnpureport process is exporting logs of device os %u.\n", devId);
        } else if (strcmp(buffer, CONTAINER_NO_SUPPORT_MESSAGE) == 0) {
            MSNPU_FPRINTF("Not support export device log in container environment.\n");
        } else {
            SELF_LOG_ERROR("Get start messages failed, devId=%u, serverType=%d.", devId, serverType);
        }
    } while (0);

    XFREE(buffer);
    if (ret != EN_OK) {
        AdxDestroyCommHandle(adxHandle);
        return EN_ERROR;
    }

    *handle = (void *)adxHandle;
    return EN_OK;
}

static int32_t MsnReportServerLongLink(uint32_t devId, uint32_t timeout, void **handle, int32_t serverType,
    ComponentType compType)
{
    AdxCommHandle adxHandle = AdxCreateCommHandle(serverType, (int32_t)devId, compType);
    int32_t ret = AdxIsCommHandleValid(adxHandle);
    if (ret != IDE_DAEMON_OK) {
        SELF_LOG_ERROR("Adx create handle is invalid, devId=%u, ret=%d.", devId, ret);
        return EN_ERROR;
    }

    // receive ack
    MsnServerResultInfo *buffer = (MsnServerResultInfo *)MsnMalloc(sizeof(MsnServerResultInfo));
    ONE_ACT_ERR_LOG(buffer == NULL, return EN_ERROR, "Malloc for ack buffer failed, devId=%u, strerr=%s.", devId,
                    strerror(ToolGetErrorCode()));
    uint32_t bufLen = sizeof(MsnServerResultInfo);
    do {
        ret = AdxRecvMsg(adxHandle, (char **)&buffer, &bufLen, timeout);
        if ((ret != IDE_DAEMON_OK) || (bufLen == 0U)) {
            SELF_LOG_ERROR("AdxRecvMsg failed, ret=%d, length=%u bytes.", ret, bufLen);
            ret = EN_ERROR;
            break;
        }
        if (buffer->retCode != 0) {
            SELF_LOG_ERROR("Get error message, devId=%u, ret=%d, errmsg=%s.", devId, buffer->retCode, buffer->retMsg);
            ret = EN_ERROR;
            break;
        }
        ret = EN_OK;
    } while (0);

    XFREE(buffer);
    if (ret != EN_OK) {
        AdxDestroyCommHandle(adxHandle);
        return EN_ERROR;
    }

    *handle = (void *)adxHandle;
    return EN_OK;
}

static void MsnReportReleaseHandle(void **handle)
{
    AdxDestroyCommHandle((AdxCommHandle)(*handle));
    *handle = NULL;
}

static void MsnReportSaveSlog(uint32_t devId, uint32_t timeout, void **handle, ThreadArgInfo *threadArgInfo)
{
    void *buffer = MsnMalloc(RECV_BUFF_SIZE);
    ONE_ACT_ERR_LOG(buffer == NULL, return, "Malloc slog receive buffer failed, devId=%u, strerr=%s", devId,
                    strerror(ToolGetErrorCode()));

    uint32_t bufLen = 0;
    int32_t retryTime = 0;
    int32_t ret = 0;
    while ((retryTime < MAX_RETRY_TIME) && !threadArgInfo->isThreadExit) {
        if (AdxIsCommHandleValid(*handle) != IDE_DAEMON_OK) {
            retryTime++;
            ret = MsnReportCreateLongLink(devId, timeout, handle, HDC_SERVICE_TYPE_LOG, COMPONENT_SYS_REPORT);
            if (ret == EN_OK) {
                retryTime = 0;
                continue;
            }
            sleep(SLOGD_WAIT_TIME);
            continue;
        }
        bufLen = RECV_BUFF_SIZE;
        ret = AdxRecvMsg((AdxCommHandle)(*handle), (char **)&buffer, &bufLen, timeout);
        if ((ret != IDE_DAEMON_OK) || (bufLen == 0U)) {
            if (ret == IDE_DAEMON_SOCK_CLOSE) {        // 对端不存在, slogd 进程退出, 等待9s slogd重新被拉起
                SELF_LOG_WARN("Can not receive data, slogd process exit, try to connect again.");
                MsnReportReleaseHandle(handle);
                sleep(SLOGD_WAIT_TIME);
                continue;
            }
            usleep(RETRY_WAIT_TIME);
            continue;
        }

        if (AdxSendMsg((AdxCommHandle)(*handle), HDC_END_MSG, strlen(HDC_END_MSG)) != EN_OK) {
            SELF_LOG_WARN("Can not send response message.");
        }
        (void)MsnFileMgrWriteDeviceSlog(buffer, bufLen, (uint32_t)threadArgInfo->devOsId);
        (void)memset_s(buffer, bufLen, 0, bufLen);
    }
    XFREE(buffer);
}

STATIC void *MsnReportRecvSlogd(void *args)
{
    ONE_ACT_ERR_LOG(args == NULL, return NULL, "args of MsnReportRecvSlogd is null, thead exit.");
    ThreadArgInfo *threadArgInfo = (ThreadArgInfo *)args;

    char threadName[TMP_STR_SIZE] = {0};
    int32_t ret = 0;
    ret = sprintf_s(threadName, TMP_STR_SIZE, "MsnRecvSlog%ld", threadArgInfo->devOsId);
    ONE_ACT_ERR_LOG(ret == -1, return NULL, "Call sprintf_s failed for slogd thread name %ld.",
        threadArgInfo->devOsId);
    ret = ToolSetThreadName(threadName);
    NO_ACT_WARN_LOG(ret != SYS_OK, "can not set thread name %s.", threadName);

    uint32_t logicId = threadArgInfo->logicId;
    void *handle = NULL;
    uint32_t timeout = 1000;
    ret = MsnReportCreateLongLink(logicId, timeout, &handle, HDC_SERVICE_TYPE_LOG, COMPONENT_SYS_REPORT);
    if (ret != EN_OK) {
        threadArgInfo->isThreadExit = true;
        SELF_LOG_ERROR("Create long link to slogd failed, dev os %ld.", threadArgInfo->devOsId);
        return NULL;
    }

    SELF_LOG_INFO("start export log, dev os %ld", threadArgInfo->devOsId);
    MsnReportSaveSlog(logicId, timeout, &handle, threadArgInfo);
    // destory connect
    MsnReportReleaseHandle(&handle);
    threadArgInfo->isThreadExit = true;
    SELF_LOG_WARN("Receive slogd thread exited, dev os %ld, logic id %u.", threadArgInfo->devOsId, logicId);
    return NULL;
}

static int32_t MsnReportConnectToLogDaemon(void **handle, uint32_t timeout, int32_t devMasterId, uint32_t logicId)
{
    int32_t ret = 0;
    char threadName[TMP_STR_SIZE] = {0};
    ret = sprintf_s(threadName, TMP_STR_SIZE, "MsnRecvFile%d", devMasterId);
    ONE_ACT_ERR_LOG(ret == -1, return EN_ERROR, "Call sprintf_s failed for log daemon thread name %d.", devMasterId);
    ret = ToolSetThreadName(threadName);
    NO_ACT_WARN_LOG(ret != SYS_OK, "Can not set thread name %s.", threadName);

    ret = MsnReportServerLongLink(logicId, timeout, handle, HDC_SERVICE_TYPE_IDE_FILE_TRANS, COMPONENT_FILE_REPORT);
    ONE_ACT_ERR_LOG(ret != EN_OK, return EN_ERROR,
                    "Create long link to log deamon failed, devId=%u.", logicId);

    // send device os id
    char devOsId[ACK_LEN] = {0};
    ret = sprintf_s(devOsId, ACK_LEN, "dev-os-%d", devMasterId);
    ONE_ACT_ERR_LOG(ret == -1, return EN_ERROR, "Call sprintf_s failed for devOsId.");
    ret = AdxSendMsg(*handle, devOsId, (uint32_t)strlen(devOsId));
    if (ret != IDE_DAEMON_OK) {
        SELF_LOG_ERROR("Send dev os id failed.");
        MsnReportReleaseHandle(handle);
        return EN_ERROR;
    }
    return EN_OK;
}

/**
 * @brief MsnReportBboxHBL: export bbox when device heart beat lost
 * @param [in]threadArgs: thread args
 */
static void MsnReportBboxHBL(uint32_t logicId, ThreadArgInfo *threadArgs)
{
    struct BboxDumpOpt opt = { false, false, false, true, MsnGetLogPrintMode(), MsnPrintGetLogLevel() };
    int32_t ret = 0;
    if (!g_msnDeviceInfo.isSMPEnv) {     // not SMP env
        ret = BboxStartDump((int32_t)logicId, g_logPath, (int32_t)strlen(g_logPath), &opt);
        ONE_ACT_ERR_LOG(ret != BBOX_SUCCESS, return, "Start bbox dump device %u failed.", logicId);
        BboxStopDump();
        return;
    }

    // SMP env
    sleep(WAIT_ALL_DEVICE_UPDATE_TIME);      // wait 10s for all device update status
    for (uint32_t i = 0; i < g_msnDeviceInfo.devNum; i++) {
        if (g_msnDeviceInfo.masterIds[g_msnDeviceInfo.devIds[i]] == threadArgs->devOsId) {
            ret = BboxStartDump((int32_t)g_msnDeviceInfo.devIds[i], g_logPath, (int32_t)strlen(g_logPath), &opt);
            ONE_ACT_ERR_LOG(ret != BBOX_SUCCESS, continue, "Start bbox dump failed.");
            BboxStopDump();
        }
    }
}

STATIC bool MsnReportCheckDeviceAlive(uint32_t logicId)
{
    drvStatus_t deviceStatus = DRV_STATUS_INITING;
    drvError_t err = drvDeviceStatus(logicId, &deviceStatus);
    if (err != DRV_ERROR_NONE) {
        SELF_LOG_ERROR("Get device %u status failed.", logicId);
        return false;
    }

    if (deviceStatus == DRV_STATUS_COMMUNICATION_LOST) {
        SELF_LOG_WARN("Device %u heart beat lost.", logicId);
        return false;
    }
    return true;
}

STATIC void *MsnReportRecvLogDaemon(void *args)
{
    ONE_ACT_ERR_LOG(args == NULL, return NULL, "args of MsnReportRecvLogDaemon is null, thead exit.");
    ThreadArgInfo *threadArgs = (ThreadArgInfo *)args;
    uint32_t logicId = threadArgs->logicId;

    void *handle = NULL;
    int32_t ret = MsnReportConnectToLogDaemon(&handle, PERMANENT_TIMEOUT, (int32_t)threadArgs->devOsId, logicId);
    TWO_ACT_ERR_LOG(ret != EN_OK, threadArgs->isThreadExit = true, return NULL, "Connect to log daemon failed");

    char filename[MMPA_MAX_PATH] = {0};
    int32_t retryTime = 0;
    int32_t timeoutCount = 0;
    while ((retryTime < MAX_RETRY_TIME) && !threadArgs->isThreadExit) {
        if (AdxIsCommHandleValid(handle) != IDE_DAEMON_OK) {
            retryTime++;
            ret = MsnReportConnectToLogDaemon(&handle, PERMANENT_TIMEOUT, (int32_t)threadArgs->devOsId, logicId);
            if (ret == EN_OK) {
                retryTime = 0;
                continue;
            }
            sleep(SLOGD_WAIT_TIME);
            continue;
        }
        (void)memset_s(filename, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
        ret = AdxRecvDevFileTimeout(handle, g_logPath, PERMANENT_TIMEOUT, filename, MMPA_MAX_PATH);
        if (ret == IDE_DAEMON_OK) {
            timeoutCount = 0;
            (void)MsnFileMgrSaveFile(filename, MMPA_MAX_PATH, logicId);
        } else if (ret == IDE_DAEMON_SOCK_CLOSE) {        // 对端不存在, log daemon 进程退出, 等待9s log daemon重新被拉起
            SELF_LOG_WARN("Can not receive data, log daemon process exit, try to connect again.");
            MsnReportReleaseHandle(&handle);
            sleep(SLOGD_WAIT_TIME);
        } else if (ret == (int32_t)IDE_DAEMON_HDC_TIMEOUT) {
            usleep(RETRY_WAIT_TIME);
            if ((timeoutCount == MAX_RECV_TIMEOUT_COUNT - 1) && (!MsnReportCheckDeviceAlive(logicId))) {
                threadArgs->isThreadExit = true;
            }
            timeoutCount = (timeoutCount + 1) % MAX_RECV_TIMEOUT_COUNT;
        } else {
            usleep(RETRY_WAIT_TIME);
        }
    }
    MsnReportBboxHBL(logicId, threadArgs);
    threadArgs->isThreadExit = true;
    MsnReportReleaseHandle(&handle);
    SELF_LOG_WARN("Receive log daemon thread exited, device os %ld", threadArgs->devOsId);
    return NULL;
}

STATIC void MsnReportFaultEventHandle(struct dsmi_event *event)
{
    uint32_t devId = event->event_t.dms_event.deviceid;
    SELF_LOG_INFO("Receive fault event, event_id:0x%X, device id:%u, assertion:%u", event->event_t.dms_event.event_id, 
                  devId, (uint8_t)event->event_t.dms_event.assertion);
    if (event->event_t.dms_event.assertion == 0) {  // 故障恢复
        return;
    }

    // 筛选出要监控的 device
    if ((g_msnDeviceInfo.devId != MAX_DEV_NUM) && (g_msnDeviceInfo.masterIds[devId] != g_msnDeviceInfo.masterId)) {
        return;
    }

    uint32_t phyId = 0;
    drvError_t err = DRV_ERROR_NONE;
    err = drvDeviceGetPhyIdByIndex(devId, &phyId);
    ONE_ACT_ERR_LOG(err != DRV_ERROR_NONE, return, "Get physical id failed, logic id:%u", devId);

    char relativePath[MMPA_MAX_PATH] = {0};
    char absolutePath[MMPA_MAX_PATH] = {0};
    int32_t ret = 0;
    ret = sprintf_s(relativePath, MMPA_MAX_PATH, "%s/device-%u/fault_event_0x%X_", SYSTEM_INFO_PATH, phyId,
        event->event_t.dms_event.event_id);
    ONE_ACT_ERR_LOG(ret == -1, return, "Call sprintf_s failed.");
    ret = MsnGetTimeStr(relativePath + (int32_t)strlen(relativePath), MMPA_MAX_PATH - (int32_t)strlen(relativePath));
    ONE_ACT_ERR_LOG(ret == EN_ERROR, return, "Get time stamp failed.");
    (void)MsnFileMgrSaveFile(relativePath, MMPA_MAX_PATH, phyId);

    ret = sprintf_s(absolutePath, MMPA_MAX_PATH, "%s/%s", g_logPath, relativePath);
    ONE_ACT_ERR_LOG(ret == -1, return, "Call sprintf_s failed.");
    size_t itemNum = sizeof(MSNPUREPORT_FILE_DUMP_INFO) / sizeof(MsnpureportFileDumpTable);
    for (uint32_t i = 0; i < (uint32_t)itemNum; i++) {
        ret = AdxGetDeviceFileTimeout((uint16_t)phyId, absolutePath, MSNPUREPORT_FILE_DUMP_INFO[i].label,
            MSNPUREPORT_FILE_DUMP_INFO[i].timeout);
        NO_ACT_WARN_LOG(ret != IDE_DAEMON_OK, "Get %s failed.", MSNPUREPORT_FILE_DUMP_INFO[i].label);
    }

    (void)memset_s(absolutePath, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    ret = sprintf_s(absolutePath, MMPA_MAX_PATH, "%s/%s/%s", g_logPath, relativePath, MESSAGE_PATH);
    ONE_ACT_ERR_LOG(ret == -1, return, "Call sprintf_s for message failed.");
    ret = AdxGetDeviceFileTimeout((uint16_t)phyId, absolutePath, MESSAGE_PATH, DEFAULT_TIMEOUT);
    NO_ACT_WARN_LOG(ret != IDE_DAEMON_OK, "Get message failed.");

    (void)memset_s(absolutePath, MMPA_MAX_PATH, 0, MMPA_MAX_PATH);
    ret = sprintf_s(absolutePath, MMPA_MAX_PATH, "%s/%s/%s", g_logPath, relativePath, EVENT_PATH);
    ONE_ACT_ERR_LOG(ret == -1, return, "Call sprintf_s for event_sched failed.");
    ret = AdxGetDeviceFileTimeout((uint16_t)phyId, absolutePath, EVENT_PATH, DEFAULT_TIMEOUT);
    NO_ACT_WARN_LOG(ret != IDE_DAEMON_OK, "Get event_sched failed.");
    SELF_LOG_INFO("Save file %s finish.", relativePath);
}

static int32_t MsnReportSubscribeFaultEvent(void)
{
    g_drvDsmiLibHandle = dlopen(DRV_DSMI_LIB, RTLD_NOW | RTLD_GLOBAL | RTLD_NODELETE);
    ONE_ACT_ERR_LOG(g_drvDsmiLibHandle == NULL, return EN_ERROR, "Dlopen api from %s failed, dlopen error: %s",
                    DRV_DSMI_LIB, dlerror())
    DsmiSubscribeFaultEvent func = (DsmiSubscribeFaultEvent)dlsym(g_drvDsmiLibHandle, "dsmi_subscribe_fault_event");
    ONE_ACT_ERR_LOG(func == NULL, return EN_ERROR, "Dlsym api dsmi_read_fault_event failed.");
    struct dsmi_event_filter filter = { 0 };
    int32_t ret = func(-1, filter, MsnReportFaultEventHandle);
    ONE_ACT_ERR_LOG(ret != 0, return EN_ERROR, "Call dsmi_subscribe_fault_event failed, ret:%d", ret);

    return EN_OK;
}

STATIC void MsnReportPermanentStop(void)
{
    int32_t ret = 0;
    for (int32_t i = 0; i < MAX_DEV_NUM; i++) {
        if (g_slogdThread[i].tid != 0) {
            ret = mmJoinTask(&g_slogdThread[i].tid);
            if (ret != EN_OK) {
                SELF_LOG_ERROR("Join slogd thread failed, dev_id=%d, strerr=%s.", i, strerror(mmGetErrorCode()));
            }
            g_slogdThread[i].tid = 0;
        }
        if (g_logDaemonThread[i].tid != 0) {
            ret = mmJoinTask(&g_logDaemonThread[i].tid);
            if (ret != EN_OK) {
                SELF_LOG_ERROR("Join log daemon thread failed, dev_id=%d, strerr=%s.", i, strerror(mmGetErrorCode()));
            }
            g_logDaemonThread[i].tid = 0;
        }
    }
}

STATIC int32_t MsnReportCreateThread(uint32_t devId)
{
    int32_t ret = 0;
    MsnSetThreadInfo(g_slogdThread, g_threadArgInfo, MsnReportRecvSlogd, ALL_LOG);
    MsnSetThreadInfo(g_logDaemonThread, g_threadArgInfo, MsnReportRecvLogDaemon, ALL_LOG);
    if (devId != MAX_DEV_NUM) {
        ret = MsnReportCreateThreadSingleOs(devId, g_slogdThread, true);
        ONE_ACT_ERR_LOG(ret == EN_ERROR, return EN_ERROR, "Create slogd Thread failed.");
        ret = MsnReportCreateThreadSingleOs(devId, g_logDaemonThread, true);
        // if failed, return EN_OK to ensure the slogd thread can be joined
        ONE_ACT_ERR_LOG(ret == EN_ERROR, return EN_OK, "Create log daemon Thread failed.");
    } else {
        ret = MsnReportCreateThreadForAllDevice(g_slogdThread, MAX_DEV_NUM, true);
        ONE_ACT_ERR_LOG(ret == EN_ERROR, return EN_ERROR, "Create slogd Thread failed.");
        ret = MsnReportCreateThreadForAllDevice(g_logDaemonThread, MAX_DEV_NUM, true);
        ONE_ACT_ERR_LOG(ret == EN_ERROR, return EN_OK, "Create log daemon Thread failed.");
    }

    return EN_OK;
}

STATIC int32_t MsnReportPermanent(uint32_t devId, FileAgeingParam *param)
{
    // Verifying the root Permission
    if (!IsHaveExecPermission()) {
        SELF_LOG_ERROR("Not have permission to export files.");
        return EN_ERROR;
    }

    // create directory
    if (CreateLogRootPath() != EN_OK) {
        return EN_ERROR;
    }

    if (MsnReportInitDevInfo(devId) != EN_OK) {
        return EN_ERROR;
    }

    // init param
    if (MsnFileMgrInit(param, g_logPath) != EN_OK) {
        return EN_ERROR;
    }

    // subscriber fault event
    int32_t ret = MsnReportSubscribeFaultEvent();
    if (ret == EN_OK) {
        // create thread
        ret = MsnReportCreateThread(devId);
        if (ret == EN_OK) {
            MsnReportPermanentStop();
        }
    }

    if (g_drvDsmiLibHandle != NULL) {
        dlclose(g_drvDsmiLibHandle);
    }
    MsnFileMgrExit();
    MSNPU_FPRINTF("ERROR: Continuous export failed, check syslog for more information.\n");
    return ret;
}

int32_t MsnReport(ArgInfo *argInfo)
{
    if (argInfo->cmdType == REPORT_PERMANENT) {
        return MsnReportPermanent(argInfo->deviceId, (FileAgeingParam *)argInfo->value);
    }

    struct BboxDumpOpt bboxDumpOpt = { false, false, false, false, argInfo->printMode, argInfo->selfLogLevel };
    if (argInfo->subCmd == REPORT_ALL) {
        bboxDumpOpt.all = true;
    } else if ((argInfo->subCmd == REPORT_FORCE) ||
               ((argInfo->subCmd == REPORT_TYPE) && (argInfo->reportType == HISILOGS_LOG))) {
        bboxDumpOpt.force = true;
    } else if (argInfo->reportType == VMCORE_FILE) {
        bboxDumpOpt.vmcore = true;
    }
    return SyncDeviceLog(argInfo->deviceId, &bboxDumpOpt, argInfo->reportType);
}