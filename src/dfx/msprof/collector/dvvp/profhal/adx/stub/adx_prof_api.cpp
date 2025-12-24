/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_prof_api.h"
#include "msprof_dlog.h"
#include "memory_utils.h"

namespace Analysis {
namespace Dvvp {
namespace Adx {
using namespace analysis::dvvp::common::error;

int32_t DoAdxIdeCreatePacket(CmdClassT type, IdeString value, uint32_t valueLen, IdeRecvBuffT buf, IdeI32Pt bufLen)
{
    if (value == nullptr || buf == nullptr || bufLen == nullptr) {
        MSPROF_LOGE("input invalid parameter");
        return IDE_DAEMON_ERROR;
    }

    if ((uint64_t)valueLen + sizeof(struct tlv_req) + 1 > UINT32_MAX) {
        MSPROF_LOGE("bigger than UINT32_MAX, value_len: %u, tlv_len: %lu", valueLen, sizeof(struct tlv_req));
        return IDE_DAEMON_ERROR;
    }

    uint32_t mallocValueLen = valueLen + 1;
    const uint32_t sendLen = sizeof(struct tlv_req) + mallocValueLen;
    IdeStringBuffer sendBuf = static_cast<IdeStringBuffer>(IdeXmalloc(sendLen));
    IDE_CTRL_VALUE_FAILED(sendBuf != nullptr, return IDE_DAEMON_ERROR, "malloc memory failed");
    IdeTlvReq req = (IdeTlvReq)sendBuf;
    req->type = type;
    req->dev_id = 0;
    req->len = valueLen;
    const errno_t err = memcpy_s(req->value, mallocValueLen, value, valueLen);
    if (err != EOK) {
        MSPROF_LOGE("memory copy failed, err: %d", err);
        IDE_XFREE_AND_SET_NULL(req);
        return IDE_DAEMON_ERROR;
    }

    *buf = static_cast<IdeMemHandle>(sendBuf);
    *bufLen = static_cast<int32_t>(sizeof(struct tlv_req)) + static_cast<int32_t>(valueLen);

    return IDE_DAEMON_OK;
}

int32_t AdxIdeCreatePacket(CONST_VOID_PTR buffer, int32_t length, IdeBuffT &outPut, int32_t &outLen)
{
    int32_t len = 0;
    IdeBuffT out = nullptr;
    int32_t ret = DoAdxIdeCreatePacket(IDE_PROFILING_REQ, static_cast<CONST_CHAR_PTR>(buffer),
        static_cast<uint32_t>(length), &out, &len);
    outLen = len;
    outPut = out;

    return ret;
}

void AdxIdeFreePacket(IdeBuffT &out)
{
    if (out != nullptr) {
        free(out);
        out = nullptr;
    }
}

HDC_CLIENT AdxHdcClientCreate(drvHdcServiceType type)
{
    return Analysis::Dvvp::Adx::HdcClientCreate(type);
}

int32_t AdxHdcClientDestroy(HDC_CLIENT client)
{
    return Analysis::Dvvp::Adx::HdcClientDestroy(client);
}

HDC_SERVER AdxHdcServerCreate(int32_t logDevId, drvHdcServiceType type)
{
    return Analysis::Dvvp::Adx::HdcServerCreate(logDevId, type);
}

void AdxHdcServerDestroy(HDC_SERVER server)
{
    Analysis::Dvvp::Adx::HdcServerDestroy(server);
}

HDC_SESSION AdxHdcServerAccept(HDC_SERVER server)
{
    return Analysis::Dvvp::Adx::HdcServerAccept(server);
}

int32_t AdxHdcSessionConnect(int32_t peerNode, int32_t peerDevid, HDC_CLIENT client, HDC_SESSION_PTR session)
{
    return Analysis::Dvvp::Adx::HdcSessionConnect(peerNode, peerDevid, client, session);
}

int32_t AdxHalHdcSessionConnect(int32_t peerNode, int32_t peerDevid,
    int32_t hostPid, HDC_CLIENT client, HDC_SESSION_PTR session)
{
    return Analysis::Dvvp::Adx::HalHdcSessionConnect(peerNode, peerDevid, hostPid, client, session);
}

int32_t AdxHdcSessionClose(HDC_SESSION session)
{
    return Analysis::Dvvp::Adx::HdcSessionClose(session);
}

int32_t AdxIdeGetDevIdBySession(HDC_SESSION session, IdeI32Pt devId)
{
    return Analysis::Dvvp::Adx::IdeGetDevIdBySession(session, devId);
}

int32_t AdxIdeGetVfIdBySession(HDC_SESSION session, int32_t &vfId)
{
    return Analysis::Dvvp::Adx::IdeGetVfIdBySession(session, vfId);
}

int32_t AdxHdcSessionDestroy(HDC_SESSION session)
{
    return Analysis::Dvvp::Adx::HdcSessionDestroy(session);
}

int32_t AdxHdcWrite(HDC_SESSION session, IdeSendBuffT buf, int32_t len)
{
    return Analysis::Dvvp::Adx::HdcWrite(session, buf, len);
}

int32_t AdxHdcRead(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen, uint32_t timeout)
{
    return Analysis::Dvvp::Adx::HdcRead(session, recvBuf, recvLen, timeout);
}
}  // namespace Adx
}  // namespace Dvvp
}  // namespace Analysis
