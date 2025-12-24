/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "driver_api.h"
#include "log_print.h"

drvError_t LogdrvHdcSessionClose(HDC_SESSION session)
{
    return drvHdcSessionClose(session);
}

drvError_t LogdrvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count)
{
    return drvHdcAllocMsg(session, ppMsg, count);
}

drvError_t LogdrvHdcFreeMsg(struct drvHdcMsg *msg)
{
    return drvHdcFreeMsg(msg);
}

drvError_t LogdrvHdcReuseMsg(struct drvHdcMsg *msg)
{
    return drvHdcReuseMsg(msg);
}

drvError_t LogdrvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len)
{
    return drvHdcAddMsgBuffer(msg, pBuf, len);
}

drvError_t LogdrvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    return drvHdcGetCapacity(capacity);
}

drvError_t LogdrvHdcGetSessionAttr(HDC_SESSION session, int attr, int *value)
{
    return halHdcGetSessionAttr(session, attr, value);
}

hdcError_t LogdrvHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout)
{
    return halHdcSend(session, pMsg, flag, timeout);
}

int32_t LogSetDfxParam(uint32_t devId, uint32_t channelType, void *data, uint32_t dataLen)
{
    int32_t ret = log_set_dfx_param(devId, channelType, data, dataLen);
    SELF_LOG_INFO("call log_set_dfx_param with devId:%u, channelType:%u, return:%d", devId, channelType, ret);
    return ret;
}

int32_t LogGetDfxParam(uint32_t devId, uint32_t channelType, void *data, uint32_t dataLen)
{
    int32_t ret = log_get_dfx_param(devId, channelType, data, dataLen);
    SELF_LOG_INFO("call log_get_dfx_param with devId:%u, channelType:%u, return:%d", devId, channelType, ret);
    return ret;
}
