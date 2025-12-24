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
#include "memory_utils.h"

namespace Analysis {
namespace Dvvp {
namespace Adx {
using namespace analysis::dvvp::common::error;

int AdxIdeCreatePacket(CONST_VOID_PTR buffer, int length, IdeBuffT &outPut, int &outLen)
{
    return IDE_DAEMON_ERROR;
}

void AdxIdeFreePacket(IdeBuffT &out)
{
    return;
}

HDC_CLIENT AdxHdcClientCreate(drvHdcServiceType type)
{
    return nullptr;
}

int32_t AdxHdcClientDestroy(HDC_CLIENT client)
{
    return IDE_DAEMON_ERROR;
}

HDC_SERVER AdxHdcServerCreate(int32_t logDevId, drvHdcServiceType type)
{
    return nullptr;
}

void AdxHdcServerDestroy(HDC_SERVER server)
{
    return;
}

HDC_SESSION AdxHdcServerAccept(HDC_SERVER server)
{
    return nullptr;
}

int32_t AdxHdcSessionConnect(int32_t peerNode, int32_t peerDevid, HDC_CLIENT client, HDC_SESSION_PTR session)
{
    return IDE_DAEMON_ERROR;
}

int32_t AdxHalHdcSessionConnect(int32_t peerNode, int32_t peerDevid,
    int32_t hostPid, HDC_CLIENT client, HDC_SESSION_PTR session)
{
    return IDE_DAEMON_ERROR;
}

int32_t AdxHdcSessionClose(HDC_SESSION session)
{
    return IDE_DAEMON_ERROR;
}

int32_t AdxIdeGetDevIdBySession(HDC_SESSION session, IdeI32Pt devId)
{
    return IDE_DAEMON_ERROR;
}

int32_t AdxIdeGetVfIdBySession(HDC_SESSION session, int32_t &vfId)
{
    return IDE_DAEMON_ERROR;
}

int32_t AdxHdcSessionDestroy(HDC_SESSION session)
{
    return IDE_DAEMON_ERROR;
}

int32_t AdxHdcWrite(HDC_SESSION session, IdeSendBuffT buf, int32_t len)
{
    return IDE_DAEMON_ERROR;
}

int AdxHdcRead(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen, uint32_t timeout)
{
    return IDE_DAEMON_ERROR;
}
}  // namespace Adx
}  // namespace Dvvp
}  // namespace Analysis