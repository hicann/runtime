/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "trace_server_mgr.h"
#include "trace_system_api.h"
#include "adiag_print.h"
#include "trace_session_mgr.h"
#include "trace_msg.h"

#define MSG_STATUS_LONG_LINK    12
#define MSG_STATUS_SHORT_LINK   13

#define RECV_BUFF_SIZE          (512 *1024) // 512K
#define MAX_RECV_TIMEOUT        3000 // timeout 3s
typedef struct {
    unsigned short headInfo;    // head magic data, judge to little
    unsigned char headVer;      // head version
    unsigned char order;        // packet order (reserved)
    unsigned short reqType;     // request type of proto
    unsigned short devId;       // request device Id
    unsigned int totalLen;      // whole message length, only all data[0] length
    unsigned int sliceLen;      // one slice length, only data[0] length
    unsigned int offset;        // offset
    unsigned short msgType;     // message type
    unsigned short status;      // message status data
    unsigned char data[0];      // message data
} TraceDataMsg;
 
int32_t TraceDeviceInit(void)
{
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceHandleHelloMsg(const void *handle, const TraceHelloMsg *msg)
{
    if ((msg->magic != TRACE_HEAD_MAGIC) || (msg->version != TRACE_HEAD_VERSION)) {
        ADIAG_ERR("msg head check failed, msg->magic=%u, msg->version=%u.", msg->magic, msg->version);
        return TRACE_FAILURE;
    }

    // get pid from handle
    int32_t pid = 0;
    int32_t rt = TraceAdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_PEER_CREATE_PID, &pid);
    if (rt != TRACE_SUCCESS) {
        ADIAG_ERR("get pid failed, ret = %d.", rt);
        return TRACE_FAILURE;
    }
    ADIAG_INF("hello msg pid = %d.", pid);
    TraceHelloMsg *sendMsg = NULL;
    sendMsg = (TraceHelloMsg *)AdiagMalloc(sizeof(TraceHelloMsg));
    if (sendMsg == NULL) {
        ADIAG_ERR("malloc failed.");
        return TRACE_FAILURE;
    }
    sendMsg->msgType = TRACE_HELLO_MSG;
    sendMsg->magic = TRACE_HEAD_MAGIC;
    sendMsg->version = TRACE_HEAD_VERSION;
    // short link need to send end msg
    TraStatus ret = TraceAdxSendMsg(handle, (const char *)sendMsg, (uint32_t)sizeof(TraceHelloMsg));
    TraStatus retEnd = TraceAdxSendMsg(handle, HDC_END_MSG, strlen(HDC_END_MSG));
    ADIAG_SAFE_FREE(sendMsg);
    if ((ret != TRACE_SUCCESS) || (retEnd != TRACE_SUCCESS)) {
        ADIAG_ERR("send hello msg failed.");
        return TRACE_FAILURE;
    }
    ADIAG_INF("send hello msg successfully.");
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceHandleStartMsg(const void *handle, const TraceStartMsg *msg)
{
    // get devId from handle
    int32_t devId = 0;
    TraStatus ret = TraceAdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_DEV_ID, &devId);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("get device id failed, ret = %d.", ret);
        return TRACE_FAILURE;
    }

    // get pid from handle
    int32_t pid = 0;
    ret = TraceAdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_PEER_CREATE_PID, &pid);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("get pid failed, ret = %d.", ret);
        return TRACE_FAILURE;
    }
    ret = TraceServerInsertSessionNode(handle, pid, devId, msg->timeout);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    ADIAG_INF("trace server insert session node successfully, pid = %d, devId = %d, msgtype = %d, timeout = %dms.",
        pid, devId, (int32_t)msg->msgType, msg->timeout);
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceHandleLinkMsg(const void *handle)
{
    uint32_t dataMaxLen = RECV_BUFF_SIZE;
    char *data = (char *)AdiagMalloc(dataMaxLen);
    if (data == NULL) {
        ADIAG_ERR("malloc failed, strerr = %s.", strerror(AdiagGetErrorCode()));
        TraceAdxDestroyCommHandle(handle);
        return TRACE_FAILURE;
    }
    TraStatus ret = TraceAdxRecvMsg(handle, &data, &dataMaxLen, MAX_RECV_TIMEOUT);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("adx receive message failed, ret = %d", ret);
        TraceAdxDestroyCommHandle(handle);
        ADIAG_SAFE_FREE(data);
        return TRACE_FAILURE;
    }

    ret = TraceHandleStartMsg(handle, (const TraceStartMsg *)data);
    ADIAG_SAFE_FREE(data);
    if (ret != TRACE_SUCCESS) {
        TraceAdxDestroyCommHandle(handle);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceHandleEndMsg(const void *handle, const TraceEndMsg *msg)
{
    (void)msg;
    // get devId from handle
    int32_t devId = 0;
    TraStatus ret = TraceAdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_DEV_ID, &devId);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("get device id failed, ret = %d.", ret);
        return TRACE_FAILURE;
    }

    // get pid from handle
    int32_t pid = 0;
    ret = TraceAdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_PEER_CREATE_PID, &pid);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("get pid failed, ret = %d.", ret);
        return TRACE_FAILURE;
    }
    ret = TraceServerDeleteSessionNode(handle, pid, devId);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("delete session node failed, ret = %d.", ret);
        return TRACE_FAILURE;
    }

    ADIAG_INF("delete session node successfully, pid = %d.", pid);
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceHandleCmd(const void *handle, const TraceDataMsg *msg, uint32_t len)
{
    if (msg->status == MSG_STATUS_LONG_LINK) {
        ADIAG_INF("trace long link.");
        return TraceHandleLinkMsg(handle);
    } else {
        TraStatus ret = TRACE_FAILURE;
        if ((msg->data[0] == TRACE_HELLO_MSG) && (len >= sizeof(TraceHelloMsg))) {
            ADIAG_INF("trace hello msg.");
            ret = TraceHandleHelloMsg(handle, (const TraceHelloMsg *)msg->data);
        } else if ((msg->data[0] == TRACE_END_MSG) && (len >= sizeof(TraceEndMsg))) {
            ADIAG_INF("trace end msg.");
            ret = TraceHandleEndMsg(handle, (const TraceEndMsg *)msg->data);
        } else {
            ADIAG_INF("invalid trace cmd, msgType = %c.", msg->data[0]);
            ret = TRACE_FAILURE;
        }
        TraceAdxDestroyCommHandle(handle);
        return ret;
    }
}

int32_t TraceDeviceProcess(AdxCommConHandle handle, const void *value, uint32_t len)
{
    if (TraceAdxIsCommHandleValid(handle) != TRACE_SUCCESS) {
        ADIAG_ERR("handle is invalid.");
        return TRACE_FAILURE;
    }
    if ((value == NULL) || (len < sizeof(TraceDataMsg))) {
        TraceAdxDestroyCommHandle(handle);
        ADIAG_ERR("value is invalid, len = %u bytes.", len);
        return TRACE_FAILURE;
    }
    TraStatus ret = TraceHandleCmd(handle, (const TraceDataMsg *)value, len);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

int32_t TraceDeviceExit(void)
{
    return TRACE_SUCCESS;
}