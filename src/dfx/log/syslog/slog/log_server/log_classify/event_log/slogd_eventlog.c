/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_eventlog.h"
#include <poll.h>
#include "slogd_recv_core.h"
#include "slogd_flush.h"
#include "slogd_config_mgr.h"
#include "log_level_parse.h"
#include "log_communication.h"
#include "ascend_hal.h"
#include "log_config_block.h"

#define SLOGD_EVENT_DEFAULT_DEVID           0
#define SLOGD_EVENT_RECV_MAX_LEN            4096U // 4kb
#define SLOGD_EVENT_RECV_TIMEOUT            1000 // 1 second
typedef struct {
    struct pollfd pollFd;
    char *recvBuf;
} SlogdEventLogMgr;

STATIC uint32_t g_writeEventFilePrintNum = 0;
STATIC SlogdEventLogMgr g_eventMgr = {0};

#ifdef EP_MODE
STATIC bool SlogdEventlogCheckLogType(const LogInfo *info)
{
    if ((info->processType == SYSTEM) && (info->level == DLOG_EVENT)) {
        return true;
    }
    return false;
}

#else
STATIC bool SlogdEventlogCheckLogType(const LogInfo *info)
{
    if (info->level == DLOG_EVENT) {
        return true;
    }
    return false;
}
#endif


#ifdef STATIC_BUFFER
#include "log_session_manage.h"
STATIC void SlogdEventlogGet(SessionItem *handle, void *buffer, uint32_t bufferLen, int32_t devId)
{
    ONE_ACT_ERR_LOG(buffer == NULL, return, "buffer is NULL");
    (void)devId;
    int32_t readLen = 0;
    int32_t ret = 0;
    char fileName[MAX_FILENAME_LEN] = {0};
    void *bufHandle = SlogdBufferHandleOpen(EVENT_LOG_TYPE, NULL, LOG_BUFFER_READ_MODE, 0);
    while (true) {
        readLen = SlogdBufferRead(bufHandle, (char *)buffer, bufferLen);
        if (readLen == 0) {
            break;
        }
        SlogdMsgData *msgData = (SlogdMsgData *)buffer;
        ret = snprintf_s(fileName, MAX_FILENAME_LEN, MAX_FILENAME_LEN - 1, "run/event/event_%s.log", msgData->timeStr);
        ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf_s for event log failed, timestamp:%s", msgData->timeStr);

        SELF_LOG_INFO("send file:%s, readLen:%d", fileName, readLen);
        ret = SessionMgrSendMsg(handle, fileName, (uint32_t)strlen(fileName));
        ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, continue, "send file name failed, fileName:%s.", fileName);
        ret = SessionMgrSendMsg(handle, msgData->data, readLen);
        ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, continue, "send file content failed, fileName:%s.", fileName);
        (void)memset_s(fileName, MAX_FILENAME_LEN, 0, MAX_FILENAME_LEN);
    }
    SlogdBufferHandleClose(&bufHandle);
}

/**
 * @brief       : write log from slogd_eventlog buffer to file [event]
 * @param[in]   : handle        buffer handle
 * @param[in]   : fileList      target file list
 */
STATIC void SlogdWriteEventLog(void *handle, char *buffer, uint32_t bufferLen)
{
    SessionItem item = { NULL, SESSION_CONTINUES_EXPORT };
    if (SessionMgrGetSession(&item) != LOG_SUCCESS) {
        return;
    }
    LogReportMsg *msg = (LogReportMsg *)buffer;
    msg->magic = LOG_REPORT_MAGIC;
    msg->logType = EVENT_LOG_TYPE;
    int32_t retry = 0;
    int32_t dataLen = 0;
    while (retry < MAX_WRITE_WAIT_TIME) {
        dataLen = SlogdBufferRead(handle, buffer + sizeof(LogReportMsg), bufferLen - LOG_SIZEOF(LogReportMsg));
        if (dataLen == 0) {
            return;
        }
        if ((dataLen < 0) || ((uint32_t)dataLen > bufferLen - LOG_SIZEOF(LogReportMsg))) {
            SELF_LOG_ERROR("read log from ring buffer failed, write buffer log failed, ret = %d.", dataLen);
            return;
        }
        msg->bufLen = (uint32_t)dataLen;
        int32_t ret = SessionMgrSendMsg(&item, buffer, dataLen + LOG_SIZEOF(LogReportMsg));
        if (ret != LOG_SUCCESS) {
            SELF_LOG_ERROR_N(&g_writeEventFilePrintNum, GENERAL_PRINT_NUM,
                             "send event log to host failed, result=%d, strerr=%s, print once every %u times.",
                             ret, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
        }
        retry++;
    }
}
#else

STATIC void SlogdEventlogGet(SessionItem *handle, void *buffer, uint32_t bufferLen, int32_t devId)
{
    (void)handle;
    (void)buffer;
    (void)bufferLen;
    (void)devId;
}

/**
 * @brief       : write log from slogd_eventlog buffer to file [event]
 * @param[in]   : handle        buffer handle
 * @param[in]   : fileList      target file list
 */
STATIC void SlogdWriteEventLog(void *handle, char *buffer, uint32_t bufferLen)
{
    (void)memset_s(buffer, bufferLen, 0, bufferLen);
    int32_t dataLen = SlogdBufferRead(handle, buffer, bufferLen);
    if (dataLen == 0) {
        return;
    }
    if ((dataLen < 0) || ((uint32_t)dataLen > bufferLen)) {
        SELF_LOG_ERROR("read log from ring buffer failed, write buffer log failed, ret = %d.", dataLen);
        return;
    }
    StLogFileList *fileList = GetGlobalLogFileList();
    StSubLogFileList *eventFileList = &(fileList->eventLogList);
    (void)ToolMutexLock(&eventFileList->lock);
    uint32_t ret = LogAgentWriteEventLog(eventFileList, buffer, LogStrlen(buffer));
    (void)ToolMutexUnLock(&eventFileList->lock);
    if (ret != OK) {
        SELF_LOG_ERROR_N(&g_writeEventFilePrintNum, GENERAL_PRINT_NUM,
                         "write event log failed, result=%u, strerr=%s, print once every %u times.",
                         ret, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
    }
}

#endif

/**
 * @brief       : save log to slogd_eventlog buffer, if buffer is full, write buffer log to file [event]
 * @param[in]   : msg           log from client
 * @param[in]   : msgLen        log length
 * @return      : LOG_SUCCESS  save to buffer success; LOG_FAILURE failure
 */
STATIC int32_t SlogdEventlogWrite(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    (void)(info);
    ONE_ACT_ERR_LOG(msg == NULL, return LOG_FAILURE, "flush event log to buffer failed, input msg is null.")

    void *handle = SlogdBufferHandleOpen(EVENT_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    if (SlogdBufferCheckFull(handle, msgLen)) {
        uint32_t bufSize = SlogdBufferGetBufSize(EVENT_LOG_TYPE);
        char *buffer = (char *)LogMalloc((size_t)bufSize + 1U);
        if (buffer == NULL) {
            SELF_LOG_ERROR("malloc failed, strerror = %s.", strerror(ToolGetErrorCode()));
            SlogdBufferReset(handle);
        } else {
            SlogdWriteEventLog(handle, buffer, bufSize);
            XFREE(buffer);
        }
    }
    LogStatus ret = SlogdBufferWrite(handle, msg, msgLen);
    SlogdBufferHandleClose(&handle);
    ONE_ACT_WARN_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "write log to buffer failed, ret = %d.", ret);
    return LOG_SUCCESS;
}

STATIC int32_t SlogdEventlogFlush(void *buffer, uint32_t bufferLen, bool flushFlag)
{
    (void)flushFlag;
    StLogFileList *logList = GetGlobalLogFileList();
    ONE_ACT_WARN_LOG(logList == NULL, return LOG_FAILURE, "loglist is null.");
    if (logList->eventLogList.storage.period != 0) {
        logList->eventLogList.storage.curTime++;
        LogFileMgrStorage(&logList->eventLogList);
    }
    void *handle = SlogdBufferHandleOpen(EVENT_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    if (SlogdBufferCheckEmpty(handle)) {
        SlogdBufferHandleClose(&handle);
        return LOG_SUCCESS;
    }
    SlogdWriteEventLog(handle, (char *)buffer, bufferLen);
    SlogdBufferHandleClose(&handle);
    return LOG_SUCCESS;
}

#ifdef DRV_EVENT_LOG
STATIC void SlogdEventlogReceive(void *args)
{
    (void)args;
    (void)memset_s(g_eventMgr.recvBuf, SLOGD_EVENT_RECV_MAX_LEN, 0, SLOGD_EVENT_RECV_MAX_LEN);

    uint32_t len = SLOGD_EVENT_RECV_MAX_LEN;
    int32_t ret = log_read_by_type(SLOGD_EVENT_DEFAULT_DEVID, g_eventMgr.recvBuf, &len, SLOGD_EVENT_RECV_TIMEOUT, LOG_CHANNEL_TYPE_EVENT);
    if (ret == (int32_t)LOG_NOT_READY) {
        ;
    } else if (ret != (int32_t)LOG_OK) {
        SELF_LOG_WARN("can not read event log by driver, ret = %d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        (void)ToolSleep((uint32_t)SLOGD_EVENT_RECV_TIMEOUT);
    } else {
        if (SlogdGetEventLevel() == 1) {
            (void)SlogdEventlogWrite(g_eventMgr.recvBuf, len, NULL);
        }
    }
}
#endif

STATIC int32_t SlogdEventlogRegister(void)
{
    int32_t ret = 0;
    LogDistributeNode distributeNode = {EVENT_LOG_PRIORITY, SlogdEventlogCheckLogType, SlogdEventlogWrite};
    ret = SlogdDistributeRegister(&distributeNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "event log register distribute node failed, ret=%d.", ret);

#ifdef DRV_EVENT_LOG
    g_eventMgr.recvBuf = (char *)LogMalloc(SLOGD_EVENT_RECV_MAX_LEN);
    if (g_eventMgr.recvBuf == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    LogReceiveNode recvNode = {EVENT_LOG_PRIORITY, SlogdEventlogReceive};
    ret = SlogdComReceiveRegister(&recvNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "event log register distribute node failed, ret=%d.", ret);
#endif

    LogFlushNode flushNode = {COMMON_THREAD_TYPE, EVENT_LOG_PRIORITY, SlogdEventlogFlush, SlogdEventlogGet};
    ret = SlogdFlushRegister(&flushNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "event log register flush node failed, ret=%d.", ret);

    return LOG_SUCCESS;
}

LogStatus SlogdEventlogInit(int32_t devId, bool isDocker)
{
    if (isDocker || (devId != -1)) {
        return LOG_SUCCESS;
    }
    uint32_t bufSize = SlogdConfigMgrGetBufSize(EVENT_LOG_TYPE);
    LogStatus ret = SlogdBufferInit(EVENT_LOG_TYPE, bufSize, 0, NULL);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("init buf for eventlog failed.");
        return LOG_FAILURE;
    }

    ret = SlogdEventlogRegister();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

void SlogdEventlogExit(void)
{
    SlogdBufferExit(EVENT_LOG_TYPE, NULL);
    XFREE(g_eventMgr.recvBuf);
}

STATIC LogStatus LogAgentInitEventMaxFileNum(StSubLogFileList* list, const char* filePath)
{
    ONE_ACT_WARN_LOG(list == NULL, return LOG_FAILURE, "[input] list is null.");

    if ((list->maxFileSize == 0) && (list->totalMaxFileSize == 0)) {
        list->totalMaxFileSize = EVENT_FILE_SIZE * (EVENT_FILE_NUM - 1U);
        list->maxFileSize = EVENT_FILE_SIZE;
    }
    if ((LogStrlen(list->fileHead) == 0) &&
        (snprintf_s(list->fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s_", EVENT_HEAD) == -1)) {
            SELF_LOG_ERROR("get event header failed, strerr=%s.", strerror(ToolGetErrorCode()));
            return LOG_FAILURE;
    }

    char eventLogPath[MAX_FILEPATH_LEN + 1U] = { 0 };
    int32_t err = snprintf_s(eventLogPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s%s%s%s", filePath,
        FILE_SEPARATOR, RUN_DIR_NAME, FILE_SEPARATOR, EVENT_HEAD);
    if (err == -1) {
        SELF_LOG_ERROR("get event log dir path failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    uint32_t ret = LogAgentInitMaxFileNumHelper(list, eventLogPath, MAX_FILEPATH_LEN);
    ONE_ACT_ERR_LOG(ret != OK, return LOG_FAILURE, "init max device filename list failed, result=%u.", ret);
    (void)ToolMutexInit(&list->lock);

    return LOG_SUCCESS;
}

STATIC LogStatus LogAgentInitEventWriteLimit(StSubLogFileList *logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return LOG_FAILURE, "[input] log file list info is null.");
    if (!SlogdConfigMgrGetWriteFileLimit()) {
        return LOG_SUCCESS;
    }

    uint32_t typeSize = SlogdConfigMgrGetTypeSpace(RUN_LOG);
    ONE_ACT_ERR_LOG(typeSize == 0U, return LOG_FAILURE, "get run type total space failed.");
    if (WriteFileLimitInit(&logList->limit, (int32_t)RUN_LOG, typeSize,
        logList->totalMaxFileSize + logList->maxFileSize) != LOG_SUCCESS) {
        SELF_LOG_ERROR("create event write file limit param list failed.");
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

LogStatus SlogdEventMgrInit(StLogFileList *logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return LOG_FAILURE, "[input] log file list info is null.");
    LogConfClass *confClass = LogConfGetClass(EVENT_LOG_TYPE);
    ONE_ACT_ERR_LOG(confClass == NULL, return LOG_FAILURE, "get event class failed.");

    StSubLogFileList* list = &(logList->eventLogList);
    LogFileMgrInitClass(list, confClass);
    if (LogAgentInitEventMaxFileNum(list, logList->aucFilePath) != OK) {
        SELF_LOG_ERROR("init event file list failed.");
        return LOG_FAILURE;
    }
    if (LogAgentGetFileListForModule(list, list->filePath) != OK) {
        SELF_LOG_ERROR("get current event file list failed.");
        return LOG_FAILURE;
    }
    if (LogAgentInitEventWriteLimit(list) != LOG_SUCCESS) {
        SELF_LOG_ERROR("init event file list write limit failed.");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}