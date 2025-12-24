/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DLG_QUEUE_H
#define DLG_QUEUE_H

#include <stdbool.h>
#include "log_system_api.h"
#include "log_error_code.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define MSG_MAX_LEN   1024

enum {
    FORWARD_MSG_TYPE = 1,
    FEEDBACK_MSG_TYPE,
    GET_MSG_REQ_TYPE,
    GET_LEVEL_REP_TYPE,
    GET_LOGPATH_REP_TYPE
};

typedef struct LogCmdMsg {
    long msgType;
    int32_t phyDevId;
    char msgData[MSG_MAX_LEN];
} LogCmdMsg;

LogStatus MsgQueueOpen(toolMsgid *queueId);
LogStatus MsgQueueSend(toolMsgid queueId, const Buff *data, uint32_t length, bool isWait);
LogStatus MsgQueueRecv(toolMsgid queueId, Buff *recvData, uint32_t bufLen, bool isWait, long msgType);
void MsgQueueRemove(void);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif
