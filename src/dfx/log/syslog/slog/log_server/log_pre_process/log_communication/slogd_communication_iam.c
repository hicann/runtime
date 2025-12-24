/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_communication.h"
#include "slog.h"
#include "log_print.h"
#include "log_ring_buffer.h"
#include "log_iam_pub.h"
#include "log_to_file.h"
#include "log_file_info.h"
#include "log_file_util.h"
#include "slogd_collect_log.h"
#include "log_level_parse.h"
#include "slogd_flush.h"

#define MAX_BUFNODE_NUM 16384
#define MAX_PATH_NAME_LEN (CFG_LOGAGENT_PATH_MAX_LENGTH)
#define MAX_APP_FILEPATH_LEN (CFG_LOGAGENT_PATH_MAX_LENGTH + MAX_FILENAME_LEN)
#define IAM_TIME_OUT   80       // timeout for read/write/ioctl/close except open

STATIC ToolMutex g_listMutex = PTHREAD_MUTEX_INITIALIZER;
STATIC unsigned int g_bufListNodeNum = 0;

typedef struct BufList {
    LogHead logHead;
    char buf[MSG_LENGTH];
    unsigned int len;
    struct BufList *next;
} BufList;

STATIC BufList *g_bufHead = NULL;
STATIC BufList *g_bufTail = NULL;

STATIC void SyncOsLogToDisk(const StSubLogFileList *pstSubInfo)
{
    ONE_ACT_NO_LOG(pstSubInfo == NULL, return);
    ONE_ACT_NO_LOG(LogStrlen(pstSubInfo->fileName) == 0, return);

    char fileName[MAX_FULLPATH_LEN + 1U] = { 0 };
    unsigned int ret = FilePathSplice(pstSubInfo, fileName, MAX_FULLPATH_LEN);
    ONE_ACT_NO_LOG(ret != OK, return);
    FsyncLogToDisk(fileName);
}

STATIC int AppLogFlushFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if (LogStrStartsWith(dir->d_name, DEVICE_APP_HEAD) != false) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

STATIC void SyncAppLogToDisk(const char* path, int appPid)
{
    ONE_ACT_NO_LOG(path == NULL, return);
    char appLogPath[MAX_PATH_NAME_LEN + 1U] = { 0 };
    char appLogFileName[MAX_APP_FILEPATH_LEN + 1U] = { 0 };
    const char* sortDirName[LOG_TYPE_NUM] = { DEBUG_DIR_NAME, SECURITY_DIR_NAME, RUN_DIR_NAME };
    int logType = DEBUG_LOG;
    for (; logType < (int)LOG_TYPE_NUM; logType++) {
        (void)memset_s(appLogPath, MAX_PATH_NAME_LEN + 1U, 0, MAX_PATH_NAME_LEN + 1U);
        (void)memset_s(appLogFileName, MAX_APP_FILEPATH_LEN + 1U, 0, MAX_APP_FILEPATH_LEN + 1U);
        int ret = snprintf_s(appLogPath, MAX_PATH_NAME_LEN + 1U, MAX_PATH_NAME_LEN, "%s%s%s%s%s-%d", path,
                             FILE_SEPARATOR, sortDirName[logType], FILE_SEPARATOR, DEVICE_APP_HEAD, appPid);
        if (ret == -1) {
            SELF_LOG_INFO("get applog path failed, pid=%d, result=%d, strerr=%s.",
                appPid, ret, strerror(ToolGetErrorCode()));
            continue;
        }
        if (ToolAccess(appLogPath) != SYS_OK) {
            continue;
        }
        ToolDirent **namelist = NULL;
        int toatalNum = ToolScandir((const char *)appLogPath, &namelist, AppLogFlushFilter, alphasort);
        if ((toatalNum <= 0) || (namelist == NULL)) {
            continue;
        }
        ret = snprintf_s(appLogFileName, MAX_APP_FILEPATH_LEN + 1U, MAX_APP_FILEPATH_LEN, "%s/%s",
                         appLogPath, namelist[toatalNum - 1]->d_name);
        if (ret == -1) {
            ToolScandirFree(namelist, toatalNum);
            SELF_LOG_INFO("can not snprintf, strerr=%s.", strerror(ToolGetErrorCode()));
            continue;
        }
        FsyncLogToDisk(appLogFileName);
        ToolScandirFree(namelist, toatalNum);
        SELF_LOG_INFO("Fsync App Log %s To Disk.", appLogFileName);
    }
}

STATIC void SyncAllToDisk(int appPid)
{
    const StLogFileList *fileList = GetGlobalLogFileList();
    if (fileList == NULL) {
        return;
    }
    if (appPid != INVALID) {
        SyncAppLogToDisk(fileList->aucFilePath, appPid);
    } else {
        for (uint32_t type = 0; type < (uint32_t)LOG_TYPE_NUM; type++) {
            SyncOsLogToDisk(&(fileList->sortDeviceOsLogList[type]));
        }
    }
}

STATIC int32_t IamRead(char *recvBuf, uint32_t recvBufLen, int *logType)
{
    int readLength;
    if ((recvBuf == NULL) || (recvBufLen == 0) || (logType == NULL)) {
        SELF_LOG_WARN("Input invalid, recvBuf is null or invalid recvBufLen=%u.", recvBufLen);
        return SYS_ERROR;
    }

    LOCK_WARN_LOG(&g_listMutex);
    if (g_bufHead == NULL) {
        UNLOCK_WARN_LOG(&g_listMutex);
        return SYS_INVALID_PARAM;
    }

    BufList *curHeadBuf = g_bufHead;
    if (recvBufLen < (curHeadBuf->len + LOGHEAD_LEN)) {
        SELF_LOG_WARN("list buffer length(%u), input length(%u), canot copy", curHeadBuf->len, recvBufLen);
        UNLOCK_WARN_LOG(&g_listMutex);
        return SYS_ERROR;
    }

    int32_t ret = memcpy_s(recvBuf, recvBufLen, (char *)&curHeadBuf->logHead, LOGHEAD_LEN);
    if (ret != EOK) {
        SELF_LOG_ERROR("memcpy failed, strerr=%s.", strerror(ToolGetErrorCode()));
        UNLOCK_WARN_LOG(&g_listMutex);
        return SYS_ERROR;
    }

    ret = memcpy_s(recvBuf + LOGHEAD_LEN, recvBufLen - LOGHEAD_LEN, curHeadBuf->buf, curHeadBuf->len);
    if (ret != EOK) {
        SELF_LOG_ERROR("memcpy failed, strerr=%s.", strerror(ToolGetErrorCode()));
        UNLOCK_WARN_LOG(&g_listMutex);
        return SYS_ERROR;
    }

    *logType = curHeadBuf->logHead.logType;
    g_bufHead = g_bufHead->next;
    readLength = (curHeadBuf->len + LOGHEAD_LEN > INT_MAX) ? 0 : (int32_t)(curHeadBuf->len + LOGHEAD_LEN);
    XFREE(curHeadBuf);
    if (g_bufListNodeNum > 0) {
        g_bufListNodeNum--;
    }
    UNLOCK_WARN_LOG(&g_listMutex);
    return readLength;
}

/**
 * @brief       : secondary verification of level because first log maybe earlier than ioctl log level
 * @param [in]  : LogHead       messages head
 * @return      : SYS_OK level verification success; SYS_ERROR level verification failed, this log is to be skipped
 */
STATIC LogStatus SlogdCheckLogLevel(LogHead msgRes)
{
    if (msgRes.logLevel == DLOG_EVENT) {
        if (SlogdGetEventLevel() == 1) {
            return LOG_SUCCESS;
        }
        return LOG_FAILURE;
    }
    uint32_t mask = SLOGD_GLOBAL_TYPE_MASK;
    if (msgRes.logType == (uint8_t)DEBUG_LOG) {
        mask = DEBUG_LOG_MASK;
    } else if (msgRes.logType == (uint8_t)SECURITY_LOG) {
        return LOG_SUCCESS;
    } else if (msgRes.logType == (uint8_t)RUN_LOG) {
        mask = RUN_LOG_MASK;
    } else {
        mask = SLOGD_GLOBAL_TYPE_MASK;
    }
    int moduleLevel = SlogdGetGlobalLevel(mask);
    if ((msgRes.moduleId >= 0U) && (msgRes.moduleId < (uint16_t)INVLID_MOUDLE_ID)) {
        moduleLevel = SlogdGetModuleLevel(msgRes.moduleId, mask);
        if ((moduleLevel < LOG_MIN_LEVEL) || (moduleLevel > LOG_MAX_LEVEL)) {
            moduleLevel = SlogdGetGlobalLevel(mask);
        }
    }

    // check module loglevel
    if ((msgRes.logLevel >= moduleLevel) && (msgRes.logLevel < LOG_MAX_LEVEL)) {
        return LOG_SUCCESS;
    }
    return LOG_FAILURE;
}

STATIC LogStatus SlogdCheckLog(const RingBufferCtrl *ringBufferCtrl, LogHead msgRes)
{
    // secondary verification of log level
    if ((ringBufferCtrl->levelFilter == LEVEL_FILTER_OPEN) && (SlogdCheckLogLevel(msgRes) != LOG_SUCCESS)) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

// log Iam ops, include read, write, ioctl, open and close
STATIC ssize_t LogIamOpsRead(struct IAMMgrFile *file, char *buf, size_t len, loff_t *pos)
{
    (void)file;
    (void)buf;
    (void)len;
    (void)pos;
    return SYS_OK;
}

STATIC void LogAddToBufList(const char *tmpBuf, LogHead msgRes)
{
    BufList *bufList = (BufList *)LogMalloc(sizeof(BufList));
    if (bufList == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return;
    }
    bufList->len = (uint32_t)msgRes.msgLength;
    bufList->next = NULL;
    int32_t ret = memcpy_s(&bufList->logHead, LOGHEAD_LEN, &msgRes, LOGHEAD_LEN);
    if (ret != EOK) {
        SELF_LOG_ERROR("memcpy failed, strerr=%s.", strerror(ToolGetErrorCode()));
        XFREE(bufList);
        return;
    }

    ret = strncpy_s(bufList->buf, MSG_LENGTH, tmpBuf, msgRes.msgLength);
    if (ret != EOK) {
        SELF_LOG_ERROR("strncpy_s failed, strerr=%s.", strerror(ToolGetErrorCode()));
        XFREE(bufList);
        return;
    }
    if (g_bufHead == NULL) {
        g_bufHead = bufList;
    } else {
        g_bufTail->next = bufList;
    }
    g_bufTail = bufList;
    g_bufListNodeNum++;
    return;
}

/*
* @brief: log write callback
* @return: len: SUCCEED; SYS_ERROR: failed and log control; others: failed
*/
STATIC ssize_t LogIamOpsWrite(struct IAMMgrFile *file, const char *buf, size_t len, loff_t *pos)
{
    ONE_ACT_NO_LOG(len > SSIZE_MAX, return SYS_ERROR);
    (void)file;
    (void)pos;
    if (buf == NULL) {
        return SYS_OK;
    }
    const RingBufferCtrl *ringBufferCtrl = (const RingBufferCtrl *)buf;
    ReadContext readContext;
    LogBufReStart(ringBufferCtrl, &readContext);
    int32_t readRes = 0;
    char tmpBuf[MSG_LENGTH];
    LogHead msgRes;
    LOCK_WARN_LOG(&g_listMutex);
    while (true) {
        readRes = LogBufRead(&readContext, ringBufferCtrl, tmpBuf, MSG_LENGTH, &msgRes);
        if (readRes < 0) {
            NO_ACT_ERR_LOG((readRes != (-(int32_t)BUFFER_READ_FINISH)), "LogIamOpsWrite err = %d check", readRes);
            break;
        }
        if (g_bufListNodeNum > MAX_BUFNODE_NUM) {
            SELF_LOG_WARN("buf list node num(%d) is more than %d, log loss...", g_bufListNodeNum, MAX_BUFNODE_NUM);
            UNLOCK_WARN_LOG(&g_listMutex);
            return SYS_ERROR;
        }
        // secondary verification of log
        if (SlogdCheckLog(ringBufferCtrl, msgRes) != LOG_SUCCESS) {
            continue;
        }
        LogAddToBufList(tmpBuf, msgRes);
    }
    UNLOCK_WARN_LOG(&g_listMutex);
    return (ssize_t)len;
}

STATIC int LogIamOpsIoctlGetLevel(LogLevelConfInfo *levelConfInfo)
{
    LogRt ret;
    char configValue[CONF_VALUE_MAX_LEN + 1] = { 0 };
    ONE_ACT_WARN_LOG(levelConfInfo == NULL, return SYS_ERROR, "levelConfInfo invalid.");
    // global level or event value
    if (strcmp(levelConfInfo->configName, GLOBALLEVEL_KEY) == 0) {
        levelConfInfo->configValue[0] = SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK);
        levelConfInfo->configValue[1] = SlogdGetEventLevel();
    }
    if (strcmp(levelConfInfo->configName, IOCTL_MODULE_NAME) == 0) {
        const ModuleInfo *moduleInfo = GetModuleInfos();
        for (; moduleInfo->moduleName != NULL; moduleInfo++) {
            if ((moduleInfo->moduleId < 0) || (moduleInfo->moduleId >= INVLID_MOUDLE_ID)) {
                continue;
            }
            (void)memset_s(configValue, sizeof(configValue), 0, sizeof(configValue));
            levelConfInfo->configValue[moduleInfo->moduleId] = LOG_MAX_LEVEL + 1;
            ret = LogConfListGetValue(moduleInfo->moduleName, LogStrlen(moduleInfo->moduleName),
                                      configValue, CONF_VALUE_MAX_LEN);
            if (ret != SUCCESS) {
                continue;
            }
            int64_t value = -1;
            if ((LogStrToInt(configValue, &value) == LOG_SUCCESS) &&
                (value >= LOG_MIN_LEVEL) && (value <= LOG_MAX_LEVEL)) {
                levelConfInfo->configValue[moduleInfo->moduleId] = (int32_t)value;
            }
        }
    }
    return SYS_OK;
}

STATIC int LogIamOpsIoctl(struct IAMMgrFile *file, unsigned cmd, struct IAMIoctlArg *arg)
{
    (void)file;
    int ret = SYS_OK;
    switch (cmd) {
        case IAM_CMD_FLUSH_LOG:
            {
                const FlushInfo *flushInfo = (FlushInfo *)(arg->argData);
                ONE_ACT_WARN_LOG(flushInfo == NULL, return SYS_ERROR, "flushInfo invalid.");
                if (SlogdGetStatus() != SLOGD_EXIT) {
                    SlogdFlushToFile(false);
                } else {
                    SELF_LOG_INFO("slogd is about to exit, stop callback to flush log data.");
                }
                SyncAllToDisk(flushInfo->appPid);
                break;
            }
        case IAM_CMD_GET_LEVEL:
            {
                LogLevelConfInfo *levelConfInfo = (LogLevelConfInfo *)(arg->argData);
                ret = LogIamOpsIoctlGetLevel(levelConfInfo);
                break;
            }
        case IAM_CMD_COLLECT_LOG:
            {
                const char *path = (const char *)arg->argData;
                uint32_t len = (uint32_t)arg->size;
                ONE_ACT_NO_LOG(!SlogdCheckCollectValid(path, len), return SYS_ERROR);
                SlogdCollectNotify(path, len);
                break;
            }
        case IAM_CMD_COLLECT_LOG_PATTERN:
            {
                LogConfigInfo *configInfo = (LogConfigInfo *)(arg->argData);
                ONE_ACT_ERR_LOG(configInfo == NULL, return SYS_ERROR, "collect pattern invalid.");
                ret = SlogdGetLogPatterns(configInfo);
                break;
            }
        default:
            break;
    }
    return ret;
}

STATIC int LogIamOpsOpen(struct IAMMgrFile *file)
{
    (void)file;
    return SYS_OK;
}

STATIC int LogIamOpsClose(struct IAMMgrFile *file)
{
    (void)file;
    return SYS_OK;
}

STATIC struct IAMFileOps g_logIamOps = {
    .read = LogIamOpsRead,
    .write = LogIamOpsWrite,
    .ioctl = LogIamOpsIoctl,
    .open = LogIamOpsOpen,
    .close = LogIamOpsClose,
};

STATIC int32_t RegisterIamService(const char *serviceName, uint32_t serviceNameLen, const struct IAMFileOps *ops)
{
    int retry = 0;
    int ret = SYS_ERROR;
    if ((serviceName == NULL) || (ops == NULL) || (serviceNameLen > IAM_SERVICE_NAME_MAX_LENGTH)) {
        SELF_LOG_WARN("Input invalid, serviceNameLen=%u", serviceNameLen);
        return SYS_ERROR;
    }
    struct IAMFileConfig iamFileConfig;
    iamFileConfig.serviceName = serviceName;
    iamFileConfig.ops = ops;
    iamFileConfig.timeOut = IAM_TIME_OUT;
    while ((ret != SYS_OK) && (retry < IAM_RETRY_TIMES)) {
        ret = IAMRegisterService(&iamFileConfig);
        retry++;
    }
    return (ret == SYS_OK) ? SYS_OK : SYS_ERROR;
}

STATIC LogStatus RegisterIamTotalService(void)
{
    int ret = RegisterIamService(LOGOUT_IAM_SERVICE_PATH, LogStrlen(LOGOUT_IAM_SERVICE_PATH), &g_logIamOps);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("Iam register %s failed, strerr=%s.", LOGOUT_IAM_SERVICE_PATH, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    SELF_LOG_INFO("Iam register total service succeed");
    return LOG_SUCCESS;
}

/**
 * @brief       : init for communication server
 * @return      : LOG_SUCCESS: success; LOG_FAILURE: failure
 */
LogStatus SlogdRmtServerInit(void)
{
    // create thread to collect newest log
    SlogdStartCollectThread();
    // register callback to iam
    return RegisterIamTotalService();
}

/**
 * @brief       : exit for communication server
 */
void SlogdRmtServerExit(void)
{
    SlogdCollectThreadExit();
    // no need to unregister callback, iam release by IAMRetrieveService()
    return;
}

/**
 * @brief       : it doesn't work when iam
 */
int32_t SlogdRmtServerCreate(int32_t devId, uint32_t *fileNum)
{
    (void)devId;
    *fileNum = 1;
    return SYS_OK;
}

/**
 * @brief       : read messages by iam
 */
int32_t SlogdRmtServerRecv(uint32_t fileNum, char *buf, uint32_t bufLen, int32_t *logType)
{
    (void)fileNum;
    return IamRead(buf, bufLen, logType);
}

/**
 * @brief      nothing to close when iam
 */
void SlogdRmtServerClose(int32_t devId, uint32_t fileNum)
{
    (void)devId;
    (void)fileNum;
}