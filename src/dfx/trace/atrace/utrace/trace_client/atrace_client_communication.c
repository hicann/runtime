/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "atrace_client_communication.h"
#include "adcore_api.h"
#include "adiag_print.h"
#include "securec.h"
#include "trace_msg.h"

#define MSG_MAX_LEN     1024U

STATIC TraStatus AtraceClientCreatePacket(int32_t devId, const char *value, uint32_t valueLen,
    void **buf, uint32_t *bufLen)
{
    if (value == NULL || buf == NULL || bufLen == NULL) {
        ADIAG_ERR("input invalid parameter");
        return TRACE_FAILURE;
    }

    if (valueLen + sizeof(struct tlv_req) + 1U > INT32_MAX) {
        ADIAG_ERR("bigger than INT32_MAX, value_len: %u bytes, tlv_len: %zu bytes", valueLen, sizeof(struct tlv_req));
        return TRACE_FAILURE;
    }

    uint32_t mallocValueLen = valueLen + 1U;
    uint32_t sendLen = (uint32_t)sizeof(struct tlv_req) + mallocValueLen;
    char *sendBuf = (char *)AdiagMalloc(sendLen);
    if (sendBuf == NULL) {
        ADIAG_ERR("malloc memory failed");
        return TRACE_FAILURE;
    }
    IdeTlvReq req = (IdeTlvReq)sendBuf;
    req->type = IDE_TRACE_REQ;
    req->dev_id = devId;
    req->len = (int32_t)valueLen;
    int32_t err = memcpy_s(req->value, mallocValueLen, value, valueLen);
    if (err != EOK) {
        ADIAG_ERR("memory copy failed, err: %d", err);
        ADIAG_SAFE_FREE(req);
        return TRACE_FAILURE;
    }

    *buf = (void *)sendBuf;
    *bufLen = (uint32_t)sizeof(struct tlv_req) + valueLen;

    return TRACE_SUCCESS;
}

STATIC TraStatus AtraceClientSendMsg(const struct tlv_req *req, char *result, uint32_t resultLen)
{
    char *resultBuf = (char *)AdiagMalloc(MSG_MAX_LEN);
    if (resultBuf == NULL) {
        ADIAG_ERR("malloc failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    ADIAG_INF("send msg by adx[begin], resultLen=%u bytes.", resultLen);
    int32_t err = AdxSendMsgAndGetResultByType(HDC_SERVICE_TYPE_BBOX, req, resultBuf, MSG_MAX_LEN);
    ADIAG_INF("send msg by adx[finish], ret=%d.", err);

    TraStatus ret = TRACE_SUCCESS;
    if (err != IDE_DAEMON_OK) {
        ADIAG_WAR("can not receive server message, ret=%d.", err);
        ret = TRACE_FAILURE;
    } else {
        err = memcpy_s(result, resultLen, resultBuf, resultLen);
        if (err != EOK) {
            ADIAG_ERR("memcpy failed, ret=%d.", err);
            ret = TRACE_FAILURE;
        }
    }

    // release resource
    ADIAG_SAFE_FREE(resultBuf);
    return ret;
}

STATIC TraStatus AtraceClientCheckHelloMsg(char *buffer, uint32_t len)
{
    if (len < sizeof(TraceHelloMsg)) {
        ADIAG_ERR("check hello msg failed, len=%u bytes, size=%zu bytes.", len, sizeof(TraceHelloMsg));
        return TRACE_FAILURE;
    }
    TraceHelloMsg *msg = (TraceHelloMsg *)buffer;
    if ((msg->msgType != TRACE_HELLO_MSG) ||
        (msg->magic != TRACE_HEAD_MAGIC) ||
        (msg->version != TRACE_HEAD_VERSION)) {
        ADIAG_ERR("msgType=%hhu, magic=%hu, version=%hu.", msg->msgType, msg->magic, msg->version);
        return TRACE_FAILURE;
    }
    ADIAG_INF("msgType=%hhu, magic=%hu, version=%hu.", msg->msgType, msg->magic, msg->version);
    return TRACE_SUCCESS;
}

TraStatus AtraceClientSendHello(int32_t devId)
{
    ADIAG_INF("send [hello] msg.");
    TraceHelloMsg msg = { 0 };
    msg.msgType = TRACE_HELLO_MSG;
    msg.magic = TRACE_HEAD_MAGIC;
    msg.version = TRACE_HEAD_VERSION;

    uint32_t sendLen = 0;
    void *reqBuf = NULL;

    TraStatus ret = AtraceClientCreatePacket(devId, (const char *)&msg, (uint32_t)sizeof(msg), &reqBuf, &sendLen);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("create [hello] msg failed, ret=%d", ret);
        ADIAG_SAFE_FREE(reqBuf);
        return TRACE_FAILURE;
    }

    struct tlv_req *req = (struct tlv_req *)reqBuf;
    char result[MSG_MAX_LEN] = { 0 };
    ret = AtraceClientSendMsg(req, result, MSG_MAX_LEN);
    if (ret != TRACE_SUCCESS) {
        ADIAG_WAR("can not send [hello] msg, ret=%d", ret);
        ADIAG_SAFE_FREE(reqBuf);
        return TRACE_FAILURE;
    }
    // check result pkg
    ret = AtraceClientCheckHelloMsg(result, MSG_MAX_LEN);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("check [hello] msg failed, ret=%d", ret);
        ADIAG_SAFE_FREE(reqBuf);
        return TRACE_SUCCESS;
    }
    ADIAG_SAFE_FREE(reqBuf);
    ADIAG_INF("send [hello] msg successfully.");
    return TRACE_SUCCESS;
}

TraStatus AtraceClientSendEnd(int32_t devId)
{
    ADIAG_INF("send [end] msg.");
    TraceEndMsg msg = { 0 };
    msg.msgType = TRACE_END_MSG;

    uint32_t sendLen = 0;
    void *reqBuf = NULL;

    TraStatus ret = AtraceClientCreatePacket(devId, (const char *)&msg, (uint32_t)sizeof(msg), &reqBuf, &sendLen);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("create [end] msg failed, ret=%d", ret);
        ADIAG_SAFE_FREE(reqBuf);
        return TRACE_FAILURE;
    }

    struct tlv_req *req = (struct tlv_req *)reqBuf;
    int32_t err = AdxSendMsgAndNoResultByType(HDC_SERVICE_TYPE_BBOX, req);
    if (err != IDE_DAEMON_OK) {
        ADIAG_WAR("can not send [end] message, ret=%d.", err);
        ADIAG_SAFE_FREE(reqBuf);
        return TRACE_FAILURE;
    }

    ADIAG_SAFE_FREE(reqBuf);
    ADIAG_INF("send [end] msg successfully.");
    return TRACE_SUCCESS;
}

TraStatus AtraceClientCreateLongLink(int32_t devId, int32_t timeout, void **handle)
{
    AdxCommHandle adxHandle = AdxCreateCommHandle(HDC_SERVICE_TYPE_BBOX, devId, COMPONENT_TRACE);
    int32_t ret = AdxIsCommHandleValid(adxHandle);
    if (ret != IDE_DAEMON_OK) {
        ADIAG_ERR("adx create handle failed, ret=%d", ret);
        return TRACE_FAILURE;
    }

    ADIAG_INF("send [start] msg.");
    TraceStartMsg msg = { 0 };
    msg.msgType = TRACE_START_MSG;
    msg.timeout = timeout;
    ret = AdxSendMsg(adxHandle, (const char*)&msg, (uint32_t)sizeof(TraceStartMsg));
    if (ret != IDE_DAEMON_OK) {
        AdxDestroyCommHandle(adxHandle);
        ADIAG_ERR("send [start] messages failed, ret=%d", ret);
        return TRACE_FAILURE;
    }

    *handle = (void *)adxHandle;
    ADIAG_INF("send [start] msg successfully.");
    return TRACE_SUCCESS;
}

bool AtraceClientIsHandleValid(void *handle)
{
    AdxCommHandle adxHandle = (AdxCommHandle)handle;
    if (AdxIsCommHandleValid(adxHandle) == IDE_DAEMON_OK) {
        return true;
    }
    return false;
}
TraStatus AtraceClientRecv(void *handle, char **data, uint32_t *len, int32_t timeout)
{
    int32_t ret = AdxRecvMsg((AdxCommHandle)handle, data, len, (uint32_t)timeout);
    if (ret != IDE_DAEMON_OK) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

void AtraceClientReleaseHandle(void **handle)
{
    AdxDestroyCommHandle((AdxCommHandle)(*handle));
    *handle = NULL;
}

bool AtraceClientIsEventMsg(char *data, uint32_t len)
{
    if (len < sizeof(TraceEventMsg)) {
        return false;
    }
    TraceEventMsg *msg = (TraceEventMsg *)data;
    if (msg->msgType == TRACE_EVENT_MSG) {
        return true;
    }
    return false;
}

bool AtraceClientIsEndMsg(char *data, uint32_t len)
{
    if (len < sizeof(TraceEndMsg)) {
        return false;
    }
    TraceEndMsg *msg = (TraceEndMsg *)data;
    if (msg->msgType == TRACE_END_MSG) {
        return true;
    }
    return false;
}

TraStatus AtraceClientParseEventMsg(char *data, uint32_t len, TraceMsgInfo *info)
{
    if (len < sizeof(TraceEventMsg)) {
        ADIAG_ERR("AtraceClientParseEventMsg receive length(%u bytes) < msg min length(%zu bytes).",
            len, sizeof(TraceEventMsg));
        return TRACE_FAILURE;
    }
    TraceEventMsg *msg = (TraceEventMsg *)data;
    info->eventName = msg->eventName;
    info->eventTime = msg->eventTime;
    info->buf = msg->buf;
    info->bufLen = msg->bufLen;
    info->devPid = msg->pid;
    info->saveType = msg->saveType;
    if ((msg->seqFlag == TRACE_MSG_SEQFLAG_END) || (msg->seqFlag == TRACE_MSG_SEQFLAG_SINGLE)) {
        info->endFlag = true;
    } else {
        info->endFlag = false;
    }
    ADIAG_DBG("AtraceClientParseEventMsg: info->eventName=%s, info->eventTime=%s, info->saveType=%u.",
        info->eventName, info->eventTime, (uint32_t)info->saveType);
    return TRACE_SUCCESS;
}