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
#include "log_to_file.h"

STATIC uint32_t g_writeOsFilePrintNum = 0;
static const char* const SORT_DIR_NAME[(int32_t)LOG_TYPE_NUM] = {DEBUG_DIR_NAME, SECURITY_DIR_NAME, RUN_DIR_NAME};

STATIC bool SlogdSysLogCheckLogType(const LogInfo* info) { return info->processType == SYSTEM; }

#ifdef STATIC_BUFFER
#include "log_session_manage.h"
STATIC void SlogdSysLogGet(SessionItem* handle, void* buffer, uint32_t bufferLen, uint32_t devId)
{
    ONE_ACT_ERR_LOG(buffer == NULL, return, "buffer is NULL");
    (void)devId;
    int32_t readLen = 0;
    int32_t ret = 0;
    char fileName[MAX_FILENAME_LEN] = {0};
    const char* fileDir[LOG_TYPE_NUM] = {"debug", "security", "run"};
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        void* bufHandle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE + i, NULL, LOG_BUFFER_READ_MODE, 0);
        while (true) {
            readLen = SlogdBufferRead(bufHandle, (char*)buffer, bufferLen);
            if (readLen <= 0) {
                break;
            }
            SlogdMsgData* msgData = (SlogdMsgData*)buffer;
            ret = snprintf_s(
                fileName, MAX_FILENAME_LEN, MAX_FILENAME_LEN - 1, "%s/device-os/device-os_%s.log", fileDir[i],
                msgData->timeStr);
            ONE_ACT_ERR_LOG(
                ret == -1, continue, "snprintf_s for %s device os log failed, timestamp:%s", fileDir[i],
                msgData->timeStr);

            SELF_LOG_INFO("send file:%s, readLen:%d", fileName, readLen);
            ret = SessionMgrSendMsg(handle, fileName, (uint32_t)strlen(fileName));
            ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, continue, "send file name failed, fileName:%s.", fileName);
            ret = SessionMgrSendMsg(handle, msgData->data, (uint32_t)readLen);
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
STATIC void SlogdWriteDeviceOsLog(void* handle, int32_t type, char* buffer, uint32_t bufferLen)
{
    SessionItem item = {NULL, SESSION_CONTINUES_EXPORT};
    if (SessionMgrGetSession(&item) != LOG_SUCCESS) {
        return;
    }
    LogReportMsg* msg = (LogReportMsg*)buffer;
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
        int32_t ret = SessionMgrSendMsg(&item, buffer, (uint32_t)dataLen + LOG_SIZEOF(LogReportMsg));
        if (ret != LOG_SUCCESS) {
            SELF_LOG_ERROR_N(
                &g_writeOsFilePrintNum, GENERAL_PRINT_NUM,
                "send syslog to host failed, result=%d, strerr=%s, print once every %u times.", ret,
                strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
        }
        retry++;
    }
}

#else

STATIC void SlogdSysLogGet(SessionItem* handle, void* buffer, uint32_t bufferLen, uint32_t devId)
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
STATIC void SlogdWriteDeviceOsLog(void* handle, int32_t type, char* buffer, uint32_t bufferLen)
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
    StLogFileList* logList = GetGlobalLogFileList();
    StSubLogFileList* sysFileList = &logList->sortDeviceOsLogList[type];
    (void)ToolMutexLock(&sysFileList->lock);
    uint32_t ret = LogAgentWriteDeviceOsLog(type, sysFileList, buffer, LogStrlen(buffer));
    (void)ToolMutexUnLock(&sysFileList->lock);
    if (ret != OK) {
        SELF_LOG_ERROR_N(
            &g_writeOsFilePrintNum, GENERAL_PRINT_NUM,
            "write device system log failed, result=%u, strerr=%s, print once every %u times.", ret,
            strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
    }
}

#endif

STATIC int32_t SlogdSysLogFlush(void* buffer, uint32_t bufferLen, bool flushFlag)
{
    (void)flushFlag;
    ONE_ACT_ERR_LOG(buffer == NULL, return LOG_FAILURE, "input buffer is NULL.");
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        void* handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE + i, NULL, LOG_BUFFER_WRITE_MODE, 0);
        if (SlogdBufferCheckEmpty(handle)) {
            SlogdBufferHandleClose(&handle);
            continue;
        }
        SlogdWriteDeviceOsLog(handle, i, (char*)buffer, bufferLen);
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
STATIC int32_t SlogdSysLogWrite(const char* msg, uint32_t msgLen, const LogInfo* info)
{
    ONE_ACT_ERR_LOG(
        (msg == NULL) || (info == NULL), return LOG_FAILURE, "flush syslog to buffer failed, input msg is null.")
    void* handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE + (int32_t)info->type, NULL, LOG_BUFFER_WRITE_MODE, 0);
    if (SlogdBufferCheckFull(handle, msgLen)) {
        uint32_t bufSize = SlogdBufferGetBufSize(DEBUG_SYS_LOG_TYPE + (int32_t)info->type);
        char* buffer = (char*)LogMalloc((size_t)bufSize + 1U);
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

STATIC uint32_t LogAgentInitDeviceOsMaxFileNum(StLogFileList* logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list is null.");
    const int32_t typeMap[LOG_TYPE_NUM] = {
        [DEBUG_LOG] = DEBUG_SYS_LOG_TYPE, [SECURITY_LOG] = SEC_SYS_LOG_TYPE, [RUN_LOG] = RUN_SYS_LOG_TYPE};
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        StSubLogFileList* list = &(logList->sortDeviceOsLogList[i]);
        ONE_ACT_WARN_LOG(list == NULL, return NOK, "[input] list is null.");
        if (i == (int32_t)DEBUG_LOG) {
            list->totalMaxFileSize = LogCalTotalFileSize(logList->ulMaxOsFileSize, logList->maxOsFileNum);
            list->maxFileSize = logList->ulMaxOsFileSize;
        } else if (i == (int32_t)SECURITY_LOG) {
            list->totalMaxFileSize = SECURITY_FILE_SIZE * (SECURITY_FILE_NUM - 1U);
            list->maxFileSize = SECURITY_FILE_SIZE;
        } else {
            list->totalMaxFileSize = LogCalTotalFileSize(logList->ulMaxNdebugFileSize, logList->maxNdebugFileNum);
            list->maxFileSize = logList->ulMaxNdebugFileSize;
        }
        LogConfClass* confClass = LogConfGetClass(typeMap[i]);
        ONE_ACT_ERR_LOG(confClass == NULL, return LOG_FAILURE, "get event class failed.");
        if (confClass->logClassify == typeMap[i]) {
            LogFileMgrInitClass(list, confClass);
        }
        int32_t err = 0;
        if (strlen(list->fileHead) == 0) {
            err = snprintf_s(list->fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s_", DEVICE_OS_HEAD);
            ONE_ACT_ERR_LOG(
                err == -1, return NOK, "get device os header failed, result=%d, strerr=%s.", err,
                strerror(ToolGetErrorCode()));
        }
        char deviceOsLogPath[MAX_FILEPATH_LEN + 1U] = {0};
        (void)memset_s(deviceOsLogPath, MAX_FILEPATH_LEN + 1U, 0, MAX_FILEPATH_LEN + 1U);
        err = snprintf_s(
            deviceOsLogPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s%s%s%s", logList->aucFilePath,
            FILE_SEPARATOR, SORT_DIR_NAME[i], FILE_SEPARATOR, DEVICE_OS_HEAD);
        ONE_ACT_ERR_LOG(
            err == -1, return NOK, "get device os log dir path failed, result=%d, strerr=%s.", err,
            strerror(ToolGetErrorCode()));
        unsigned int ret = LogAgentInitMaxFileNumHelper(list, deviceOsLogPath, MAX_FILEPATH_LEN);
        ONE_ACT_ERR_LOG(ret != OK, return NOK, "init max device os filename list failed, result=%u.", ret);
        (void)ToolMutexInit(&list->lock);
    }

    return OK;
}

STATIC int32_t LogAgentGetDeviceOsFileList(StLogFileList* logList)
{
    if (logList == NULL) {
        SELF_LOG_WARN("[input] log file info is null.");
        return NOK;
    }
    int32_t ret = 0;
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        StSubLogFileList* list = &(logList->sortDeviceOsLogList[i]);
        if (i == (int32_t)SECURITY_LOG) {
            char scanPath[MAX_FILEPATH_LEN + 1U] = {0};
            ret = snprintf_s(
                scanPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s/%s", logList->aucFilePath, SORT_DIR_NAME[i]);
            ONE_ACT_ERR_LOG(
                ret == -1, return NOK, "get device os log dir path failed, result=%d, strerr=%s.", ret,
                strerror(ToolGetErrorCode()));
            ret = LogAgentGetDirList(list, scanPath, AppLogPidDirFilter);
            if (ret != LOG_SUCCESS) {
                return NOK;
            }
        }
        if (LogAgentGetFileListForModule(list, list->filePath) != OK) {
            SELF_LOG_ERROR("get device os log file list failed, directory=%s", logList->aucFilePath);
            return NOK;
        }
    }

    return OK;
}

STATIC uint32_t LogAgentInitDeviceOsWriteLimit(StLogFileList* logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list is null.");
    if (!SlogdConfigMgrGetWriteFileLimit()) {
        return OK;
    }
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        StSubLogFileList* list = &(logList->sortDeviceOsLogList[i]);
        ONE_ACT_WARN_LOG(list == NULL, return NOK, "[input] list is null.");
        uint32_t typeSize = SlogdConfigMgrGetTypeSpace(i);
        if (typeSize == 0) {
            continue;
        }
        if (i == (int32_t)SECURITY_LOG) {
            typeSize = list->totalMaxFileSize + list->maxFileSize;
        }

        if (WriteFileLimitInit(&list->limit, i, typeSize, list->totalMaxFileSize + list->maxFileSize) != LOG_SUCCESS) {
            SELF_LOG_ERROR("create device os write file limit param list failed.");
            return NOK;
        }
    }
    return OK;
}

LogStatus SlogdSyslogMgrInit(StLogFileList* logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return LOG_FAILURE, "[input] log file list info is null.");

    if (LogAgentInitDeviceOsMaxFileNum(logList) != OK) {
        SELF_LOG_ERROR("init device os file list failed.");
        return LOG_FAILURE;
    }
    if (LogAgentGetDeviceOsFileList(logList) != OK) {
        SELF_LOG_ERROR("get current device os file list failed.");
        return LOG_FAILURE;
    }
    if (LogAgentInitDeviceOsWriteLimit(logList) != OK) {
        SELF_LOG_ERROR("init device os file list write limit failed.");
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}