/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_ADX_API_H
#define ANALYSIS_DVVP_DEVICE_ADX_API_H
#include "utils/utils.h"
#include "hdc_api.h"
namespace Analysis {
namespace Dvvp {
namespace Adx {
using namespace analysis::dvvp::common::utils;
using HDC_SESSION_PTR = HDC_SESSION *;
int32_t AdxIdeCreatePacket(CONST_VOID_PTR buffer, int32_t length, IdeBuffT &outPut, int32_t &outLen);
void AdxIdeFreePacket(IdeBuffT &out);
HDC_CLIENT AdxHdcClientCreate(drvHdcServiceType type);
int32_t AdxHdcClientDestroy(HDC_CLIENT client);
HDC_SERVER AdxHdcServerCreate(int32_t logDevId, drvHdcServiceType type);
void AdxHdcServerDestroy(HDC_SERVER server);
HDC_SESSION AdxHdcServerAccept(HDC_SERVER server);
int32_t AdxHdcSessionConnect(int32_t peerNode, int32_t peerDevid, HDC_CLIENT client, HDC_SESSION_PTR session);
int32_t AdxHalHdcSessionConnect(int32_t peerNode, int32_t peerDevid,
    int32_t hostPid, HDC_CLIENT client, HDC_SESSION_PTR session);
int32_t AdxHdcSessionClose(HDC_SESSION session);
int32_t AdxIdeGetDevIdBySession(HDC_SESSION session, IdeI32Pt devId);
int32_t AdxIdeGetVfIdBySession(HDC_SESSION session, int32_t &vfId);
int32_t AdxHdcSessionDestroy(HDC_SESSION session);
int32_t AdxHdcWrite(HDC_SESSION session, IdeSendBuffT buf, int32_t len);
int32_t AdxHdcRead(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen, uint32_t timeout = 0);
int32_t DoAdxIdeCreatePacket(CmdClassT type, IdeString value, uint32_t valueLen, IdeRecvBuffT buf, IdeI32Pt bufLen);
}  // namespace Adx
}  // namespace Dvvp
}  // namespace Analysis
#endif
