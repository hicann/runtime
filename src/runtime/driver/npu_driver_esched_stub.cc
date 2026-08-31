/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"

namespace cce {
namespace runtime {

rtError_t NpuDriver::EschedSubmitEventSync(
    const int32_t devId, rtEschedEventSummary_t* const evt, rtEschedEventReply_t* const ack)
{
    UNUSED(devId);
    UNUSED(evt);
    UNUSED(ack);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::EschedAttachDevice(const uint32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::EschedDettachDevice(const uint32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::EschedWaitEvent(
    const int32_t devId, const uint32_t grpId, const uint32_t threadId, const int32_t timeout,
    rtEschedEventSummary_t* const evt)
{
    UNUSED(devId);
    UNUSED(grpId);
    UNUSED(threadId);
    UNUSED(timeout);
    UNUSED(evt);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type)
{
    UNUSED(devId);
    UNUSED(grpId);
    UNUSED(type);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::EschedSubmitEvent(const int32_t devId, const rtEschedEventSummary_t* const evt)
{
    UNUSED(devId);
    UNUSED(evt);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::EschedSubscribeEvent(
    const int32_t devId, const uint32_t grpId, const uint32_t threadId, const uint64_t eventBitmap)
{
    UNUSED(devId);
    UNUSED(grpId);
    UNUSED(threadId);
    UNUSED(eventBitmap);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::EschedAckEvent(
    const int32_t devId, const rtEventIdType_t evtId, const uint32_t subeventId, char_t* const msg, const uint32_t len)
{
    UNUSED(devId);
    UNUSED(evtId);
    UNUSED(subeventId);
    UNUSED(msg);
    UNUSED(len);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NpuDriver::EschedCreateGrpEx(const uint32_t devId, const uint32_t maxThreadNum, uint32_t* const grpId)
{
    UNUSED(devId);
    UNUSED(maxThreadNum);
    UNUSED(grpId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

drvError_t NpuDriver::DrvEschedManage(
    const uint32_t devId, const int32_t timeout, const uint32_t eschedTid, const uint32_t grpId,
    struct halReportRecvInfo* info)
{
    UNUSED(devId);
    UNUSED(timeout);
    UNUSED(eschedTid);
    UNUSED(grpId);
    UNUSED(info);
    return DRV_ERROR_NOT_SUPPORT;
}

rtError_t NpuDriver::EschedQueryInfo(
    const uint32_t devId, const rtEschedQueryType type, rtEschedInputInfo* inPut, rtEschedOutputInfo* outPut)
{
    UNUSED(devId);
    UNUSED(type);
    UNUSED(inPut);
    UNUSED(outPut);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
