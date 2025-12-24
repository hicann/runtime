/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_cmd.h"
#include "log_common.h"
#include "config_common.h"
#include "msg_queue.h"
#include "log_system_api.h"
#include "log_print.h"

#define MSG_RETRY_TIMES     90

static ToolMutex g_logconfigLock;

STATIC int32_t LogCmdRecvLogMsg(LogCmdMsg *rcvMsg, int32_t queueId)
{
    int32_t rcvRes = -1;
    int32_t retryTimes = 0;
    do {
        rcvRes = MsgQueueRecv(queueId, (void *)rcvMsg, MSG_MAX_LEN, true, FEEDBACK_MSG_TYPE);
        if (rcvRes == LOG_SUCCESS) {
            break;
        }
        int32_t errCode = ToolGetErrorCode();
        if (errCode == ENOMSG) {
            retryTimes++;
            if (retryTimes == MSG_RETRY_TIMES) {
                break;
            }
            (void)ToolSleep(100); // sleep 100ms
            continue;
        }
        if (errCode == EINTR) { // interrupted system call
            continue;
        }
        break;
    } while (true);

    if (rcvRes != LOG_SUCCESS) {
        SELF_LOG_ERROR("receive level setting result failed from slogd, result=%d, strerr=%s, retry_time=%d.",
                       rcvRes, strerror(ToolGetErrorCode()), retryTimes);
        return CONFIG_LOG_MSGQUEUE_FAILED;
    }
    SELF_LOG_INFO("receive msg from slogd, type:%ld data:%s, device id:%d",
                  rcvMsg->msgType, rcvMsg->msgData, rcvMsg->phyDevId);
    return CONFIG_OK;
}

int32_t LogCmdSendLogMsg(LogCmdMsg *rcvMsg, const char *msg, uint16_t devId)
{
    // get message queue
    LogCmdMsg stMsg = {FORWARD_MSG_TYPE, devId, ""};
    if (strcpy_s(stMsg.msgData, MSG_MAX_LEN, msg) != EOK) {
        return CONFIG_MEM_WRITE_FAILED;
    }
    SELF_LOG_INFO("request_value=%s, request_devId=%d.", msg, devId);
    toolMsgid queueId = -1;
    if (MsgQueueOpen(&queueId) != LOG_SUCCESS) {
        SELF_LOG_ERROR("Get message queue failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return CONFIG_LOG_MSGQUEUE_FAILED;
    }

    LOCK_WARN_LOG(&g_logconfigLock);
    // clear message queue
    do {
        int32_t rcvRes = MsgQueueRecv(queueId, (void *)(rcvMsg), MSG_MAX_LEN, true, FEEDBACK_MSG_TYPE);
        if ((rcvRes != LOG_SUCCESS) && (ToolGetErrorCode() != EINTR)) {
            break;
        }
    } while (true);

    // send message to notify the slog
    if (MsgQueueSend(queueId, (void *)(&stMsg), MSG_MAX_LEN, true) != LOG_SUCCESS) {
        SELF_LOG_ERROR("Send level info to slogd failed, strerr=%s.", strerror(ToolGetErrorCode()));
        UNLOCK_WARN_LOG(&g_logconfigLock);
        return CONFIG_LOG_MSGQUEUE_FAILED;
    }
    SELF_LOG_INFO("Send level info to slogd succeed.");

    // receive result from slog
    int32_t rcvRes = LogCmdRecvLogMsg(rcvMsg, queueId);
    UNLOCK_WARN_LOG(&g_logconfigLock);
    return rcvRes;
}

int32_t LogCmdGetLogLevel(char *resultBuf, uint32_t *resultLen, uint16_t devId)
{
    LogCmdMsg rcvMsg = {0, -1, ""};
    const char *getLogLevelMsg = "GetLogLevelTableFormat";
    int32_t ret = LogCmdSendLogMsg(&rcvMsg, getLogLevelMsg, devId);
    if (ret != CONFIG_OK) {
        SELF_LOG_ERROR("Get log level failed, return:%d", ret);
        return ret;
    }

    uint32_t valueLen = (uint32_t)strlen(rcvMsg.msgData);
    uint32_t capacity = RESULT_BUFFER_LEN - *resultLen;
    if (valueLen > capacity) {
        SELF_LOG_ERROR("resultBuf not enough");
        return CONFIG_BUFFER_NOT_ENOUGH;
    }
    ret = memcpy_s(resultBuf + *resultLen, capacity, rcvMsg.msgData, valueLen);
    ONE_ACT_ERR_LOG(ret != EOK, return CONFIG_MEM_WRITE_FAILED, "memcpy_s error return:%d", ret);
    *resultLen += valueLen;

    return CONFIG_OK;
}

int32_t LogCmdSetLogLevel(const char *msg, uint16_t devId)
{
    LogCmdMsg rcvMsg = {0, -1, ""};
    int32_t ret = LogCmdSendLogMsg(&rcvMsg, msg, devId);
    if (ret != CONFIG_OK || strcmp(rcvMsg.msgData, LEVEL_SETTING_SUCCESS) != 0) {
        return CONFIG_ERROR;
    }
    SELF_LOG_INFO("set device level succeed.");
    return CONFIG_OK;
}

int32_t LogCmdInitMutex(void)
{
    int32_t ret = ToolMutexInit(&g_logconfigLock);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return CONFIG_MUTEX_ERROR,
                    "init config log command mutex failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    return CONFIG_OK;
}

int32_t LogCmdDestoryMutex(void)
{
    int32_t ret = ToolMutexDestroy(&g_logconfigLock);
    if (ret != SYS_OK) {
        return CONFIG_MUTEX_ERROR;
    }
    return CONFIG_OK;
}