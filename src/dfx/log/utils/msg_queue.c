/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msg_queue.h"
#include <sys/msg.h>
#include "log_common.h"
#include "log_print.h"

#define MSG_QUEUE_KEY   0x474f4c44
#define MSG_AUTHORITY   0600
#define M_MSG_CREAT     IPC_CREAT
#define M_MSG_NOWAIT    IPC_NOWAIT

/*
 * @brief: open the message queue
 * @param [in]key: queue key
 * @param [in]msgFlag: message flag
 * @return: queue id; -1: failed;
 */
STATIC INLINE toolMsgid ToolMsgOpen(toolKey key, int32_t msgFlag)
{
    return (toolMsgid)msgget(key, msgFlag);
}

/*
 * @brief: send message to queue
 * @param [in]msqid: queue id
 * @param [in]buf: data buffer
 * @param [in]bufLen: data length
 * @param [in]msgFlag: message flag
 * @return: 0: succeed; -1: failed
 */
STATIC INLINE int32_t ToolMsgSnd(toolMsgid msqid, const void *buf, uint32_t bufLen, int32_t msgFlag)
{
    return (int32_t)msgsnd(msqid, buf, bufLen, msgFlag);
}

/*
 * @brief: receive message from queue
 * @param [in]msqid: queue id
 * @param [in]buf: data buffer
 * @param [in]bufLen: data length
 * @param [in]msgFlag: message flag
 * @param [in]msgType: message queue type
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
STATIC INLINE int32_t ToolMsgRcv(toolMsgid msqid, void *buf, uint32_t bufLen, int32_t msgFlag, long msgType)
{
    return (int32_t)msgrcv(msqid, buf, bufLen, msgType, msgFlag);
}

/*
 * @brief: close message queue
 * @param [in]msqid: queue id
 * @return: SYS_OK: succeed; SYS_ERROR: failed;
 */
STATIC INLINE int32_t ToolMsgClose(toolMsgid msqid)
{
    return (int32_t)msgctl(msqid, IPC_RMID, NULL);
}

/**
 * @brief        : open message queue to communicate with another process
 * @param [out]  : queueId      message queue id
 * @return       : LOG_SUCCESS: success, others: failure
 */
LogStatus MsgQueueOpen(toolMsgid *queueId)
{
    ONE_ACT_NO_LOG(queueId == NULL, return LOG_INVALID_PTR);
    toolMsgid msgId = ToolMsgOpen(MSG_QUEUE_KEY, (uint32_t)MSG_AUTHORITY | (uint32_t)M_MSG_CREAT);
    if (msgId == -1) {
        return LOG_FAILURE_CREATE_MSG_QUEUE;
    }
    *queueId = msgId;
    return LOG_SUCCESS;
}

/**
 * @brief        : delete message queue
 * @param [in]   : queueId      queue id to delete
 * @return       : LOG_SUCCESS: success, others: failure
 */
STATIC LogStatus MsgQueueDelete(toolMsgid queueId)
{
    ONE_ACT_NO_LOG(queueId < 0, return LOG_INVALID_QUEUE_ID);
    ONE_ACT_NO_LOG(ToolMsgClose(queueId) != SYS_OK, return LOG_FAILURE_DELETE_MSG_QUEUE);
    return LOG_SUCCESS;
}

/**
 * @brief        : remove message queue
 * @return       : NA
 */
void MsgQueueRemove(void)
{
    toolMsgid msgId = ToolMsgOpen(MSG_QUEUE_KEY, 0);
    if (msgId < 0) {
        SELF_LOG_WARN("can not open msg_queue, maybe not exist.");
        return;
    }

    int32_t ret = MsgQueueDelete(msgId);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("remove msg queue failed.");
    }
}

/**
 * @brief        : write data to message queue
 * @param [in]   : queueId      message queue id
 * @param [in]   : data         data to send
 * @param [in]   : length       data length(byte), exclude long int part
 * @param [in]   : isWait       whether wait when queue is full
 * @return       : LOG_SUCCESS: success, others: failure
 */
LogStatus MsgQueueSend(toolMsgid queueId, const Buff *data, uint32_t length, bool isWait)
{
    ONE_ACT_NO_LOG(queueId < 0, return LOG_INVALID_QUEUE_ID);
    ONE_ACT_NO_LOG(data == NULL, return LOG_INVALID_DATA);
    ONE_ACT_NO_LOG(length == 0, return LOG_INVALID_DATA);

    int32_t msgFlag = (isWait == false) ? 0 : M_MSG_NOWAIT;
    if (ToolMsgSnd(queueId, data, length, msgFlag) != 0) {
        return LOG_FAILURE_SEND_MSG;
    }
    return LOG_SUCCESS;
}

/**
 * @brief        : receive message data from a queue
 * @param [in]   : queueId      message queue id
 * @param [in]   : recvData     a buffer to store data received from queue
 * @param [in]   : bufLen       length of data part(byte), exclude long int msgType
 * @param [in]   : isWait       whether suspend when call recv api here
 * @param [in]   : msgType      message type
 * @return       : LOG_SUCCESS: success, others: failure
 */
LogStatus MsgQueueRecv(toolMsgid queueId, Buff *recvData, uint32_t bufLen, bool isWait, long msgType)
{
    ONE_ACT_NO_LOG(queueId < 0, return LOG_INVALID_QUEUE_ID);
    ONE_ACT_NO_LOG(recvData == NULL, return LOG_INVALID_DATA);
    ONE_ACT_NO_LOG(bufLen == 0, return LOG_INVALID_DATA);

    int32_t msgFlag = (isWait == false) ? 0 : M_MSG_NOWAIT;
    if (ToolMsgRcv(queueId, (void *)recvData, bufLen, msgFlag, msgType) == -1) {
        return LOG_FAILURE_RECV_MSG;
    }
    return LOG_SUCCESS;
}

