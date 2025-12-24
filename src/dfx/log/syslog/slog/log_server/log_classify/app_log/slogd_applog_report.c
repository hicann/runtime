/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifdef APP_LOG_REPORT
#include "slogd_applog_report.h"
#include "slogd_applog_flush.h"
#include "log_hdc_server.h"
#include "log_print.h"
#include "slogd_dev_mgr.h"
#include "slogd_config_mgr.h"
#include "log_session_manage.h"

STATIC uint32_t g_writeAppFilePrintNum = 0;

/**
 * @brief            : send log data to client on docker
 * @param [in]       : logInfo          log info include log type, process type and pid
 * @param [in]       : handle           log buffer handle
 * @return           : 0 success; others failed
 */
STATIC int32_t DevLogReport(const LogInfo *logInfo, void *handle)
{
    ONE_ACT_NO_LOG(logInfo == NULL, return -1);
    ONE_ACT_NO_LOG(handle == NULL, return -1);
    // get log msg from buffer
    uint32_t bufSize = SlogdBufferGetBufSize(DEBUG_APP_LOG_TYPE + (int32_t)logInfo->type);
    char *data = (char *)LogMalloc((size_t)bufSize + 1U);
    if (data == NULL) {
        SELF_LOG_ERROR("malloc failed, write buffer log failed.");
        SlogdBufferReset(handle);
        return -1;
    }
    int32_t dataLen = SlogdBufferRead(handle, data, bufSize);
    if (dataLen == 0) {
        XFREE(data);
        return 0;
    }
    if ((dataLen < 0) || ((uint32_t)dataLen > bufSize)) {
        XFREE(data);
        SELF_LOG_ERROR("read log from ring buffer failed, write buffer log failed, ret = %d.", dataLen);
        return -1;
    }

    // log info's device id is host side
    // session node's device id is device side
    uint32_t hostDevId = logInfo->deviceId;
    uint32_t devId = GetDeviceSideDeviceId(hostDevId);
    int32_t ret = SendDataToSessionNode(logInfo->pid, devId, data, strlen(data));
    if (ret != 0) {
        uint32_t res = LogAgentWriteDeviceApplicationLog(data, LogStrlen(data), logInfo, GetGlobalLogFileList());
        SELF_LOG_WARN("can not send data to hdc session, ret=%d, pid=%u, devId=%u, res=%u", ret, logInfo->pid,
                       hostDevId, res);
    }
    XFREE(data);
    return ret;
}

/**
 * @brief       : send all type log data to client, if session timeout, delete logNode
 * @param [in]  : pid         pid of deleted session node from list
 * @param [in]  : devId       devId of deleted session node from list
 * @param [in]  : timeout     timeout of deleted session node from list
 */
STATIC void SendLogNodeToClient(uint32_t pid, uint32_t devId, int32_t timeout)
{
    int32_t ret = 0;
    // log-info's device id is host side
    // session-node's device id is device side
    uint32_t hostDevId = GetHostSideDeviceId(devId);
    int32_t type;
    SlogdAppLogLock();
    for (type = (int32_t)DEBUG_LOG; type < (int32_t)LOG_TYPE_NUM; ++type) {
        LogInfo info = { (LogType)type, APPLICATION, pid, hostDevId, 0, 0, 0 };
        AppLogList *logNode = SlogdApplogGetNode((const LogInfo *)(&info));
        if (logNode != NULL) {
            void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE + type, (void *)logNode,
                LOG_BUFFER_WRITE_MODE, logNode->deviceId);
            uint32_t bufSize = SlogdBufferGetBufSize(DEBUG_APP_LOG_TYPE + type);
            char *data = (char *)LogMalloc((size_t)bufSize + 1U);
            if (data == NULL) {
                SlogdBufferReset(handle);
                SlogdBufferHandleClose(&handle);
                SELF_LOG_ERROR("malloc failed, write buffer log failed.");
                continue;
            }
            int32_t dataLen = SlogdBufferRead(handle, data, bufSize);
            SlogdBufferHandleClose(&handle);
            if (dataLen == 0) {
                XFREE(data);
                continue;
            }
            if ((dataLen < 0) || ((uint32_t)dataLen > bufSize)) {
                XFREE(data);
                SELF_LOG_ERROR("read log from ring buffer failed, write buffer log failed, ret = %d.", dataLen);
                continue;
            }
            // send log node to client
            ret = SendDataToSessionNode(pid, devId, data, strlen(data));
            if (ret != 0) {
                // get dev id about host side
                uint32_t res = LogAgentWriteDeviceApplicationLog(data, LogStrlen(data),
                    &info, GetGlobalLogFileList());
                SELF_LOG_ERROR("write log to hdc failed, ret=%d, pid=%u, devId=%u, res=%u, type=%d.",
                               ret, pid, hostDevId, res, type);
            }
            if (timeout <= 0) {
                InnerDeleteAppNode(logNode);
            }
            XFREE(data);
        }
    }
    SlogdAppLogUnLock();
}

/**
* @brief FlushLogBufToHost: send log data to host
* @return: NA
*/
STATIC void FlushLogBufToHost(void)
{
    AppLogList *node = NULL;
    SlogdAppLogLock();
    AppLogList *tmp = SlogdGetAppLogBufList();
    while (tmp != NULL) {
        node = tmp;
        tmp = tmp->next;
        void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE + (int32_t)node->type, (void *)node,
            LOG_BUFFER_WRITE_MODE, node->deviceId);
        if (!SlogdBufferCheckEmpty(handle)) {
            LogInfo info = { node->type, APPLICATION, node->pid, node->deviceId, 0, 0, 0 };
            if (node->writeWaitTime < MAX_WRITE_WAIT_TIME) {
                node->writeWaitTime++;
                SlogdBufferHandleClose(&handle);
                continue;
            }
            node->writeWaitTime = 0;
            int32_t ret = DevLogReport(&info, handle);
            if (ret != OK) {
                SELF_LOG_WARN_N(&g_writeAppFilePrintNum, GENERAL_PRINT_NUM,
                                "can not report log to process, result=%d, strerr=%s, print once every %u times.",
                                ret, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
            }
            SlogdBufferHandleClose(&handle);
            continue;
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

LogStatus SlogdAppLogReport(void)
{
    HandleDeletedSessionNode(SendLogNodeToClient);
    HandleInvalidSessionNode();
    FlushLogBufToHost();
    return LOG_SUCCESS;
}

/**
 * @brief       : save log to slogd_applog buffer, if buffer is full, send buffer log to host by log_server
 * @param[in]   : msg           log from client
 * @param[in]   : info          info of log
 * @param[in]   : msgLen        log length
 * @return      : LOG_SUCCESS  save to buffer success; LOG_FAILURE failure
 */
LogStatus SlogdAppLogFlushToBufByReport(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    ONE_ACT_ERR_LOG((msg == NULL) || (info == NULL),
                    return LOG_FAILURE, "flush applog to buffer for report failed, input msg is null.")
    SlogdAppLogLock();
    AppLogList *node = SlogdApplogGetNode(info);
    TWO_ACT_WARN_LOG(node == NULL, SlogdAppLogUnLock(), return LOG_FAILURE,
        "device log node null, type=%d", (int32_t)info->processType);
    node->noAppDataCount = 0;
    void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE + (int32_t)info->type, (void *)node,
        LOG_BUFFER_WRITE_MODE, node->deviceId);
    if (SlogdBufferCheckFull(handle, msgLen)) {
        uint32_t ret = (uint32_t)DevLogReport(info, handle);
        if (ret != OK) {
            SELF_LOG_ERROR_N(&g_writeAppFilePrintNum, GENERAL_PRINT_NUM,
                             "report log to process failed, result=%u, strerr=%s, print once every %u times.",
                             ret, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
        }
    }
    if (SlogdBufferCheckEmpty(handle)) {
        char type[2] = { 0 };
        type[0] = (char)node->type + '0';
        LogStatus ret = SlogdBufferWrite(handle, type, LogStrlen(type));
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "write report log type failed, ret = %d.", ret);
    }
    LogStatus ret = SlogdBufferWrite(handle, msg, msgLen);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "write app log to buffer failed, ret = %d.", ret);
    SlogdBufferHandleClose(&handle);
    SlogdAppLogUnLock();
    return LOG_SUCCESS;
}

/**
 * @brief       : slogd init adx hdc server, will create HDC server thread
 * @param [in]  : devId        device id
 * @return      : NA
 */
STATIC void SlogdInitHdcServer(int32_t devId)
{
    int32_t mode = (devId == -1) ? 0 : 1;   // 0 denotes pf slogd, 1 denotes vf slogd
    struct LogServerInitInfo info = { mode, devId };
    if (LogHdcServerInit(&info) != SYS_OK) {
        SELF_LOG_ERROR("log hdc server init failed");
    } else {
        SELF_LOG_INFO("log hdc server init success");
    }
}

LogStatus SlogdAppLogReportInit(int32_t devId)
{
    if (InitSessionList() != SUCCESS) {
        SELF_LOG_ERROR("init session pid map failed");
        return SYS_ERROR;
    }
    SlogdInitHdcServer(devId);
    return LOG_SUCCESS;
}

void SlogdAppLogReportExit(void)
{
    FreeSessionList();
}
#endif // APP_LOG_REPORT
