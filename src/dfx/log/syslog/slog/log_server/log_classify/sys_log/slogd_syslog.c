/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_syslog.h"
#include "log_common.h"
#include "slogd_buffer.h"
#include "slogd_config_mgr.h"
#include "slogd_recv_core.h"
#include "slogd_flush.h"
#include "slogd_kernel_log.h"
#include "log_communication.h"

STATIC uint32_t g_writeOsFilePrintNum = 0;

STATIC bool SlogdSysLogCheckLogType(const LogInfo *info)
{
    return info->processType == SYSTEM;
}

#ifdef STATIC_BUFFER
#include "log_session_manage.h"
STATIC void SlogdSysLogGet(SessionItem *handle, void *buffer, uint32_t bufferLen, int32_t devId)
{
    ONE_ACT_ERR_LOG(buffer == NULL, return, "buffer is NULL");
    (void)devId;
    int32_t readLen = 0;
    int32_t ret = 0;
    char fileName[MAX_FILENAME_LEN] = {0};
    const char *fileDir[LOG_TYPE_NUM] = {"debug", "security", "run"};
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        void *bufHandle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE + i, NULL, LOG_BUFFER_READ_MODE, 0);
        while (true) {
            readLen = SlogdBufferRead(bufHandle, (char *)buffer, bufferLen);
            if (readLen == 0) {
                break;
            }
            SlogdMsgData *msgData = (SlogdMsgData *)buffer;
            ret = snprintf_s(fileName, MAX_FILENAME_LEN, MAX_FILENAME_LEN - 1, "%s/device-os/device-os_%s.log",
                fileDir[i], msgData->timeStr);
            ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf_s for %s device os log failed, timestamp:%s",
                fileDir[i], msgData->timeStr);

            SELF_LOG_INFO("send file:%s, readLen:%d", fileName, readLen);
            ret = SessionMgrSendMsg(handle, fileName, (uint32_t)strlen(fileName));
            ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, continue, "send file name failed, fileName:%s.", fileName);
            ret = SessionMgrSendMsg(handle, msgData->data, readLen);
            ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, continue, "send file content failed, fileName:%s.", fileName);
            (void)memset_s(fileName, MAX_FILENAME_LEN, 0, MAX_FILENAME_LEN);
        }
        SlogdBufferHandleClose(&bufHandle);
        SELF_LOG_INFO("send %s finish", fileDir[i]);
    }
}

/**
 * @brief       : send log from slogd_syslog buffer to host [device-os]
 * @param[in]   : handle        syslog buffer handle
 * @param[in]   : type          log type
 * @param[in]   : buffer        log buffer to send
 * @param[in]   : bufferLen     log buffer length
 * @return      : NA
 */
STATIC void SlogdWriteDeviceOsLog(void *handle, int32_t type, char *buffer, uint32_t bufferLen)
{
    SessionItem item = { NULL, SESSION_CONTINUES_EXPORT };
    if (SessionMgrGetSession(&item) != LOG_SUCCESS) {
        return;
    }
    LogReportMsg *msg = (LogReportMsg *)buffer;
    msg->magic = LOG_REPORT_MAGIC;
    msg->logType = DEBUG_SYS_LOG_TYPE + (uint16_t)type;
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
            SELF_LOG_ERROR_N(&g_writeOsFilePrintNum, GENERAL_PRINT_NUM,
                             "send syslog to host failed, result=%d, strerr=%s, print once every %u times.",
                             ret, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
        }
        retry++;
    }
}

#else

STATIC void SlogdSysLogGet(SessionItem *handle, void *buffer, uint32_t bufferLen, int32_t devId)
{
    (void)handle;
    (void)buffer;
    (void)bufferLen;
    (void)devId;
}

/**
 * @brief       : send log from slogd_syslog buffer to host [device-os]
 * @param[in]   : handle        syslog buffer handle
 * @param[in]   : type          log type
 * @param[in]   : buffer        log buffer to send
 * @param[in]   : bufferLen     log buffer length
 * @return      : NA
 */
STATIC void SlogdWriteDeviceOsLog(void *handle, int32_t type, char *buffer, uint32_t bufferLen)
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
    StLogFileList *logList = GetGlobalLogFileList();
    StSubLogFileList *sysFileList = &logList->sortDeviceOsLogList[type];
    (void)ToolMutexLock(&sysFileList->lock);
    uint32_t ret = LogAgentWriteDeviceOsLog(type, sysFileList, buffer, LogStrlen(buffer));
    (void)ToolMutexUnLock(&sysFileList->lock);
    if (ret != OK) {
        SELF_LOG_ERROR_N(&g_writeOsFilePrintNum, GENERAL_PRINT_NUM,
                         "write device system log failed, result=%u, strerr=%s, print once every %u times.",
                         ret, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
    }
}

#endif

STATIC int32_t SlogdSysLogFlush(void *buffer, uint32_t bufferLen, bool flushFlag)
{
    (void)flushFlag;
    ONE_ACT_ERR_LOG(buffer == NULL, return LOG_FAILURE, "input buffer is NULL.");
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE + i, NULL, LOG_BUFFER_WRITE_MODE, 0);
        if (SlogdBufferCheckEmpty(handle)) {
            SlogdBufferHandleClose(&handle);
            continue;
        }
        SlogdWriteDeviceOsLog(handle, i, (char *)buffer, bufferLen);
        SlogdBufferHandleClose(&handle);
    }
    return LOG_SUCCESS;
}

/**
 * @brief       : save log to slogd_syslog buffer, if buffer is full, write buffer log to file [device-os]
 * @param[in]   : msg           log from client
 * @param[in]   : msgLen        log length
 * @param[in]   : info          info of log
 * @return      : LOG_SUCCESS  save to buffer success; LOG_FAILURE failure
 */
STATIC int32_t SlogdSysLogWrite(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    ONE_ACT_ERR_LOG((msg == NULL) || (info == NULL),
                    return LOG_FAILURE, "flush syslog to buffer failed, input msg is null.")
    void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE + (int32_t)info->type,
        NULL, LOG_BUFFER_WRITE_MODE, 0);
    if (SlogdBufferCheckFull(handle, msgLen)) {
        uint32_t bufSize = SlogdBufferGetBufSize(DEBUG_SYS_LOG_TYPE + (int32_t)info->type);
        char *buffer = (char *)LogMalloc((size_t)bufSize + 1U);
        if (buffer == NULL) {
            SELF_LOG_ERROR("malloc failed, strerror = %s.", strerror(ToolGetErrorCode()));
            SlogdBufferReset(handle);
        } else {
            SlogdWriteDeviceOsLog(handle, (int32_t)info->type, buffer, bufSize);
            XFREE(buffer);
        }
    }
    LogStatus ret = SlogdBufferWrite(handle, msg, msgLen);
    SlogdBufferHandleClose(&handle);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("write log to buffer failed, ret = %d.", ret);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

static int32_t SlogdSysLogRegister(void)
{
    int32_t ret = 0;
    LogDistributeNode distributeNode = {SYS_LOG_PRIORITY, SlogdSysLogCheckLogType, SlogdSysLogWrite};
    ret = SlogdDistributeRegister(&distributeNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "sys log register distribute node failed, ret=%d.", ret);

    LogFlushNode flushNode = {COMMON_THREAD_TYPE, SYS_LOG_PRIORITY, SlogdSysLogFlush, SlogdSysLogGet};
    ret = SlogdFlushRegister(&flushNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "sys log register flush node failed, ret=%d.", ret);

    return LOG_SUCCESS;
}

LogStatus SlogdSyslogInit(int32_t devId, bool isDocker)
{
    if (isDocker || (devId != -1)) {
        return LOG_SUCCESS;
    }
    LogStatus ret = LOG_FAILURE;
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        uint32_t bufSize = SlogdConfigMgrGetBufSize(DEBUG_SYS_LOG_TYPE + i);
        ret = SlogdBufferInit(DEBUG_SYS_LOG_TYPE + i, bufSize, 0, NULL);
        if (ret != LOG_SUCCESS) {
            SELF_LOG_ERROR("init buf for syslog[%d] failed.", i);
            for (int32_t j = 0; j < i; j++) {
                SlogdBufferExit(DEBUG_SYS_LOG_TYPE + j, NULL);
            }
            return LOG_FAILURE;
        }
    }

    ret = SlogdSysLogRegister();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }

    ret = SlogdKernelLogInit(SlogdSysLogWrite);
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

void SlogdSyslogExit(void)
{
    SlogdKernelLogExit();
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        SlogdBufferExit(DEBUG_SYS_LOG_TYPE + i, NULL);
    }
}

