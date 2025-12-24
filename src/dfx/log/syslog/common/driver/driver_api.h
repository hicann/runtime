/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DRIVER_API_H
#define DRIVER_API_H

#include "ascend_hal.h"

drvError_t LogdrvHdcSessionClose(HDC_SESSION session);

drvError_t LogdrvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count);

drvError_t LogdrvHdcFreeMsg(struct drvHdcMsg *msg);

drvError_t LogdrvHdcReuseMsg(struct drvHdcMsg *msg);

drvError_t LogdrvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len);

drvError_t LogdrvHdcGetCapacity(struct drvHdcCapacity *capacity);

drvError_t LogdrvHdcGetSessionAttr(HDC_SESSION session, int attr, int *value);

hdcError_t LogdrvHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout);

int32_t LogSetDfxParam(uint32_t devId, uint32_t channelType, void *data, uint32_t dataLen);

int32_t LogGetDfxParam(uint32_t devId, uint32_t channelType, void *data, uint32_t dataLen);

#endif