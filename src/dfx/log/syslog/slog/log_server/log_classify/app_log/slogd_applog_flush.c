/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_applog_flush.h"
#include "log_common.h"
#include "slogd_buffer.h"
#include "slogd_config_mgr.h"

#define MAX_NODE_COUNT 512

STATIC AppLogList *g_appLogList = NULL;
static ToolMutex g_appLogMutex = TOOL_MUTEX_INITIALIZER;

void SlogdAppLogLock(void)
{
    (void)ToolMutexLock(&g_appLogMutex);
}

void SlogdAppLogUnLock(void)
{
    (void)ToolMutexUnLock(&g_appLogMutex);
}

AppLogList *SlogdGetAppLogBufList(void)
{
    return g_appLogList;
}

uint32_t SlogdGetAppNodeNum(void)
{
    uint32_t num = 0;
    AppLogList *node = g_appLogList;
    while (node != NULL) {
        num++;
        node = node->next;
    }
    return num;
}

static bool SlogdAppLogBufCheck(void *srcAttr, void *dstAttr)
{
    return srcAttr == dstAttr;
}

static AppLogList *SlogdAppLogInitBuf(uint32_t devId, LogType type)
{
    AppLogList *node = (AppLogList *)LogMalloc(sizeof(AppLogList));
    if (node == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return NULL;
    }
    uint32_t bufSize = SlogdConfigMgrGetBufSize(DEBUG_APP_LOG_TYPE + (int32_t)type);
    SlogdBufAttr attr = { node, SlogdAppLogBufCheck };
    LogStatus ret = SlogdBufferInit(DEBUG_APP_LOG_TYPE + (int32_t)type, bufSize, devId, &attr);
    if (ret != LOG_SUCCESS) {
        XFREE(node);
        SELF_LOG_ERROR("init buf for applog[%u] failed.", devId);
        return NULL;
    }
    return node;
}

// inner interface without lock, cannot use by other source file
STATIC AppLogList *InnerInsertAppNode(const LogInfo *info)
{
    ONE_ACT_WARN_LOG(info->deviceId >= HOST_MAX_DEV_NUM, return NULL, "deviceId[%u] invalid.", info->deviceId);
    
    AppLogList *node = SlogdAppLogInitBuf(info->deviceId, info->type);
    if (node == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return NULL;
    }
    node->pid = info->pid;
    node->type = info->type;
    node->deviceId = info->deviceId;
    node->aosType = info->aosType;
    node->writeWaitTime = 0;
    node->next = g_appLogList;
    g_appLogList = node;
    return node;
}

// inner interface without lock, cannot use by other source file
STATIC AppLogList *InnerGetAppNode(const LogInfo *info, bool *isFull)
{
    ONE_ACT_WARN_LOG(info->deviceId >= HOST_MAX_DEV_NUM, return NULL, "deviceId[%u] is invalid.", info->deviceId);
    AppLogList *tmp = g_appLogList;
    int32_t count = 0;
    while (tmp != NULL) {
        if ((tmp->pid == info->pid) && (tmp->deviceId == info->deviceId) &&
            (tmp->type == info->type) && (tmp->aosType == info->aosType)) {
            return tmp;
        }
        tmp = tmp->next;
        count++;
        if (count < MAX_NODE_COUNT) {
            continue;
        }
        *isFull = true;
        break;
    }
    return NULL;
}

AppLogList *SlogdApplogGetNode(const LogInfo *info)
{
    bool isFull = false;
    AppLogList *node = InnerGetAppNode(info, &isFull);
    if (isFull) {
        return NULL;
    } else if (node == NULL) {
        return InnerInsertAppNode(info);
    } else {
        return node;
    }
}

// inner interface without lock, cannot use by other source file
#if (defined APP_LOG_WATCH) || (defined APP_LOG_REPORT)
STATIC bool IsToDeleteNode(const AppLogList *input, const AppLogList *targetNode)
{
    if ((input == NULL) || (targetNode == NULL)) {
        return false;
    }
    if ((input->pid == targetNode->pid) && (input->deviceId == targetNode->deviceId) &&
        (input->type == targetNode->type)) {
        return true;
    } else {
        return false;
    }
}

void InnerDeleteAppNode(const AppLogList *input)
{
    ONE_ACT_NO_LOG(input == NULL, return);
    AppLogList *tmp = g_appLogList;
    if (tmp == NULL) {
        return;
    }
    if (IsToDeleteNode((const AppLogList *)tmp, input) == true) {
        g_appLogList = g_appLogList->next;
        SlogdBufferExit(DEBUG_APP_LOG_TYPE + (int32_t)tmp->type, (void *)tmp);
        XFREE(tmp);
    } else {
        while ((tmp != NULL) && (IsToDeleteNode((const AppLogList *)tmp->next, input) == false)) {
            tmp = tmp->next;
        }
        if ((tmp != NULL) && (IsToDeleteNode((const AppLogList *)tmp->next, input) == true)) {
            AppLogList *node = tmp->next;
            tmp->next = tmp->next->next;
            SlogdBufferExit(DEBUG_APP_LOG_TYPE + (int32_t)node->type, (void *)node);
            XFREE(node);
        }
    }
    return;
}
#endif

#ifdef APP_LOG_WATCH
/**
 * @brief           : write log to slogd app buffer, if buffer is full, write buffer log to file first
 * @param[in]       : handle        log buffer handle
 * @param[in]       : info          log info
 * @param[in]       : bufSize       log buffer size
 * @param[in]       : fileList      target file list
 */
STATIC void SlogdWriteDeviceAppLog(void *handle, const LogInfo *info, void *buffer, uint32_t bufSize)
{
    ONE_ACT_ERR_LOG(handle == NULL, return, "input args is null, write buffer log failed.");
    int32_t dataLen = SlogdBufferRead(handle, buffer, bufSize);
    if (dataLen == 0) {
        return;
    }
    if ((dataLen < 0) || ((uint32_t)dataLen > bufSize)) {
        SELF_LOG_ERROR("read log from ring buffer failed, write buffer log failed, ret = %d.", dataLen);
        return;
    }
    StLogFileList *fileList = GetGlobalLogFileList();
    uint32_t ret = LogAgentWriteDeviceApplicationLog(buffer, LogStrlen(buffer), info, fileList);
    if (ret != OK) {
        SELF_LOG_ERROR("write device app log failed, result=%u, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    }
}

static int32_t SlogdFlushToAppNode(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    SlogdAppLogLock();
    AppLogList *node = SlogdApplogGetNode(info);
    TWO_ACT_WARN_LOG(node == NULL, (SlogdAppLogUnLock()), return LOG_FAILURE,
        "device log node null, type=%d", (int32_t)info->processType);

    node->noAppDataCount = 0;
    void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE + (int32_t)info->type, (void *)node,
        LOG_BUFFER_WRITE_MODE, node->deviceId);
    if (handle == NULL) {
        SlogdAppLogUnLock();
        SELF_LOG_ERROR("get app buffer handle failed.");
        return LOG_FAILURE;
    }
    if (SlogdBufferCheckFull(handle, msgLen)) {
        uint32_t bufSize = SlogdBufferGetBufSize(DEBUG_APP_LOG_TYPE + (int32_t)info->type);
        void *buffer = LogMalloc((size_t)bufSize + 1U);
        if (buffer == NULL) {
            SELF_LOG_ERROR("malloc failed, strerror = %s.", strerror(ToolGetErrorCode()));
            SlogdBufferReset(handle);
        } else {
            SlogdWriteDeviceAppLog(handle, info, buffer, bufSize);
            XFREE(buffer);
        }
    }
    LogStatus ret = SlogdBufferWrite(handle, msg, msgLen);
    SlogdBufferHandleClose(&handle);
    SlogdAppLogUnLock();
    return ret;
}

static int32_t SlogdFlushToAppAll(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE + (int32_t)info->type,
        NULL, LOG_BUFFER_WRITE_MODE, 0);
    if (SlogdBufferCheckFull(handle, msgLen)) {
        uint32_t bufSize = SlogdBufferGetBufSize(DEBUG_APP_LOG_TYPE + (int32_t)info->type);
        void *buffer = LogMalloc((size_t)bufSize + 1U);
        if (buffer == NULL) {
            SELF_LOG_ERROR("malloc failed, strerror = %s.", strerror(ToolGetErrorCode()));
            SlogdBufferReset(handle);
        } else {
            SlogdWriteDeviceAppLog(handle, info, buffer, bufSize);
            XFREE(buffer);
        }
    }
    LogStatus ret = SlogdBufferWrite(handle, msg, msgLen);
    SlogdBufferHandleClose(&handle);
    return ret;
}

/**
 * @brief       : save log to slogd_applog buffer, if buffer is full, write buffer log to file [device-app-x]
 * @param[in]   : msg           log from client
 * @param[in]   : msgLen        log length
 * @param[in]   : info          info of log
 * @return      : LOG_SUCCESS  save to buffer success; LOG_FAILURE failure
 */
LogStatus SlogdFlushToAppBuf(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    ONE_ACT_ERR_LOG((msg == NULL) || (info == NULL),
                    return LOG_FAILURE, "flush app log to buffer failed, input msg is null.")
    int32_t ret = 0;
    if (SlogdConfigMgrGetStorageMode(DEBUG_APP_LOG_TYPE + (int32_t)info->type) == STORAGE_RULE_COMMON) {
        ret = SlogdFlushToAppAll(msg, msgLen, info);
    } else {
        ret = SlogdFlushToAppNode(msg, msgLen, info);
    }
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "write app log to buffer failed, ret = %d.", ret);
    return LOG_SUCCESS;
}

static void SlogdApplogNodeFlushToFile(void *buffer, uint32_t bufLen)
{
    SlogdAppLogLock();
    AppLogList *tmp = g_appLogList;
    while (tmp != NULL) {
        AppLogList *node = tmp;
        tmp = tmp->next;
        void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE + (int32_t)node->type, (void *)node,
            LOG_BUFFER_WRITE_MODE, node->deviceId);
        if (handle == NULL) {
            SELF_LOG_ERROR("get app buffer handle[pid = %u] failed.", node->pid);
            continue;
        }
        if (!SlogdBufferCheckEmpty(handle)) {
            LogInfo info = { node->type, APPLICATION, node->pid, node->deviceId, 0, node->aosType, 0 };
            SlogdWriteDeviceAppLog(handle, &info, buffer, bufLen);
        } else {
            node->noAppDataCount++;
            if (node->noAppDataCount >= NO_APP_DATA_MAX_COUNT) {
                InnerDeleteAppNode(node);
                continue;
            }
        }
        SlogdBufferHandleClose(&handle);
    }
    SlogdAppLogUnLock();
}

static void SlogdApplogAllFlushToFile(void *buffer, uint32_t bufLen)
{
    const LogType type[LOG_TYPE_NUM] = { DEBUG_LOG, SECURITY_LOG, RUN_LOG };
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE + i, NULL, LOG_BUFFER_WRITE_MODE, 0);
        if (SlogdBufferCheckEmpty(handle)) {
            SlogdBufferHandleClose(&handle);
            continue;
        }
        LogInfo info = { type[i], APPLICATION, 0, 0, 0, 0, 0 };
        SlogdWriteDeviceAppLog(handle, &info, (char *)buffer, bufLen);
        SlogdBufferHandleClose(&handle);
    }
}

LogStatus SlogdApplogFlushToFile(void *buffer, uint32_t bufLen)
{
    ONE_ACT_ERR_LOG(buffer == NULL, return LOG_FAILURE, "input buffer is NULL.");
    SlogdApplogNodeFlushToFile(buffer, bufLen);
    SlogdApplogAllFlushToFile(buffer, bufLen);
    return LOG_SUCCESS;
}
#endif // APP_LOG_WATCH

LogStatus SlogdApplogFlushInit(void)
{
    return LOG_SUCCESS;
}

void SlogdApplogFlushExit(void)
{
    AppLogList *tmp = g_appLogList;
    AppLogList *node = NULL;
    while (tmp != NULL) {
        node = tmp;
        tmp = tmp->next;
        XFREE(node);
    }
    g_appLogList = NULL;
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        SlogdBufferExit(DEBUG_APP_LOG_TYPE + i, NULL);
    }
}