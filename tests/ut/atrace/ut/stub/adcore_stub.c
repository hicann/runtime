/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adcore_api.h"
#include "trace_msg.h"

int32_t AdxSendMsgAndGetResultByType(AdxHdcServiceType type, IdeTlvConReq req, AdxStringBuffer const result,
    uint32_t resultLen)
{
    if (type != HDC_SERVICE_TYPE_BBOX) {
        return IDE_DAEMON_ERROR;
    }

    usleep(10);
    memcpy_s(result, resultLen, req->value, req->len);
    return IDE_DAEMON_OK;
}

int32_t AdxSendMsgAndNoResultByType(AdxHdcServiceType type, IdeTlvConReq req)
{
    if (type != HDC_SERVICE_TYPE_BBOX) {
        return IDE_DAEMON_ERROR;
    }

    usleep(10);
    return IDE_DAEMON_OK;
}

AdxCommHandle AdxCreateCommHandle(AdxHdcServiceType type, int32_t devId, ComponentType compType)
{
    (void)devId;
    (void)compType;
    if (type != HDC_SERVICE_TYPE_BBOX) {
        return (AdxCommHandle)0;
    }

    return (AdxCommHandle)1;
}

int32_t AdxIsCommHandleValid(AdxCommConHandle handle)
{
    (void)handle;
    return IDE_DAEMON_OK;
}

int32_t AdxSendMsg(AdxCommConHandle handle, AdxString data, uint32_t len)
{
    (void)handle;
    (void)data;
    (void)len;
    return IDE_DAEMON_OK;
}

int32_t AdxRecvMsg(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    if ((len == NULL) || (data == NULL) || (handle == NULL)) {
        return IDE_DAEMON_ERROR;
    }
    if (*data == NULL) {
        return IDE_DAEMON_ERROR;
    }

    (void)timeout;
    static int32_t i = 0;
    i++;
    if (i == 1) { // length is 0
        *len = 0;
        return IDE_DAEMON_OK;
    } else if (i == 2) { // receive event msg(start)
        *len = sizeof(TraceEventMsg);
        TraceEventMsg msg = { 0 };
        msg.msgType = TRACE_EVENT_MSG;
        msg.seqFlag = TRACE_MSG_SEQFLAG_START;
        memcpy_s(*data, sizeof(TraceEventMsg), &msg, sizeof(TraceEventMsg));
        return IDE_DAEMON_OK;
    } else if (i == 3) { // receive event msg(end)
        *len = sizeof(TraceEventMsg);
        TraceEventMsg msg = { 0 };
        msg.msgType = TRACE_EVENT_MSG;
        msg.seqFlag = TRACE_MSG_SEQFLAG_END;
        memcpy_s(*data, sizeof(TraceEventMsg), &msg, sizeof(TraceEventMsg));
        return IDE_DAEMON_OK;
    } else if (i == 4) { // receive event msg
        *len = sizeof(TraceEndMsg);
        TraceEndMsg msg = { 0 };
        msg.msgType = TRACE_END_MSG;
        memcpy_s(*data, sizeof(TraceEndMsg), &msg, sizeof(TraceEndMsg));
        return IDE_DAEMON_OK;
    } else if (i == 5) {
        *len = 1024;
        memcpy_s(*data, 1024, 0, 1024);
        return IDE_DAEMON_OK;
    }
    return IDE_DAEMON_ERROR;
}

void AdxDestroyCommHandle(AdxCommHandle handle)
{
    (void)handle;
}
