/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device_debug_c.hpp"
#include "capability.hpp"
#include "device.hpp"
#include "driver.hpp"
#include "error_message_manage.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {

rtError_t SendAndRecvDebugTask(
    RtDebugSendInfo* const sendInfo, rtDebugReportInfo_t* const reportInfo, const Device* const device)
{
    Driver* const devDrv = device->Driver_();
    auto ret = devDrv->DebugSqTaskSend(
        device->GetDebugSqId(), RtPtrToPtr<uint8_t*, RtDebugSendInfo*>(sendInfo), device->Id_(), device->DevGetTsId());
    ERROR_RETURN(ret, "DebugSqTaskSend fail, retCode=%#x.", ret);

    uint32_t realReportCnt = 0U;
    ret = devDrv->DebugCqReport(
        device->Id_(), device->DevGetTsId(), device->GetDebugCqId(),
        RtPtrToPtr<uint8_t*, rtDebugReportInfo_t*>(reportInfo), realReportCnt);
    ERROR_RETURN(ret, "DebugCqReport fail, retCode=%#x.", ret);
    return RT_ERROR_NONE;
}

rtError_t DebugSetDumpMode(const uint64_t mode, Device* const device)
{
    COND_RETURN_ERROR(
        !device->CheckFeatureSupport(TS_FEATURE_COREDUMP), RT_ERROR_DRV_NOT_SUPPORT,
        "Current device does not support core dump!");
    Driver* const devDrv = device->Driver_();
    COND_RETURN_ERROR((devDrv == nullptr), RT_ERROR_DRV_NULL, "devDrv is null!");
    RT_LOG(RT_LOG_INFO, "Start to create debug dump sqcq.");
    uint32_t debugSqId = 0U;
    uint32_t debugCqId = 0U;
    auto ret = devDrv->DebugSqCqAllocate(device->Id_(), device->DevGetTsId(), debugSqId, debugCqId);
    ERROR_RETURN(ret, "DebugSqCqAllocate fail, retCode=%#x.", ret);
    RT_LOG(RT_LOG_INFO, "Create debug dump sqcq success, sq_id is %u, cq_id is %u.", debugSqId, debugCqId);
    device->SetDebugSqId(debugSqId);
    device->SetDebugCqId(debugCqId);

    RtDebugSendInfo sendInfo = {};
    sendInfo.reqId = SET_DEBUG_MODE;
    sendInfo.isReturn = true;
    sendInfo.dataLen = static_cast<uint32_t>(sizeof(int64_t));
    uint64_t* param = RtPtrToPtr<uint64_t*, uint8_t*>(sendInfo.params);
    *param = mode;

    rtDebugReportInfo_t reportInfo = {};
    ret = SendAndRecvDebugTask(&sendInfo, &reportInfo, device);
    ERROR_RETURN(ret, "SendAndRecvDebugTask fail, retCode=%#x.", ret);
    COND_RETURN_ERROR(
        (reportInfo.returnVal != 0U), RT_ERROR_INVALID_VALUE, "SendAndRecvDebugTask get report val %u invalid!.",
        reportInfo.returnVal);
    device->SetCoredumpEnable();
    RT_LOG(RT_LOG_INFO, "Set dump mode success.");
    return RT_ERROR_NONE;
}

rtError_t DebugGetStalledCore(rtDbgCoreInfo_t* const coreInfo, const Device* const device)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        coreInfo, RT_ERROR_INVALID_VALUE, "Obtaining the physical ID of the stalled AI Core in the current process");
    COND_RETURN_ERROR((!device->IsCoredumpEnable()), RT_ERROR_INVALID_VALUE, "Coredump mode is disabled!");
    RT_LOG(RT_LOG_INFO, "Start to get core info.");
    RtDebugSendInfo sendInfo = {};
    sendInfo.reqId = GET_STALLED_AICINFO_BY_PID;
    sendInfo.isReturn = true;

    rtDebugReportInfo_t reportInfo = {};
    const auto ret = SendAndRecvDebugTask(&sendInfo, &reportInfo, device);
    ERROR_RETURN(ret, "SendAndRecvDebugTask fail, retCode=%#x.", ret);
    COND_RETURN_ERROR(
        (reportInfo.returnVal != 0U), RT_ERROR_INVALID_VALUE, "Get core info get report val %u invalid!.",
        reportInfo.returnVal);
    rtDbgCoreInfo_t* tmp = RtPtrToPtr<rtDbgCoreInfo_t*, uint8_t*>(reportInfo.data);
    *coreInfo = *tmp;
    RT_LOG(
        RT_LOG_INFO, "Get core info, bitmap info is 0x%llx 0x%llx 0x%llx 0x%llx", coreInfo->aicBitmap0,
        coreInfo->aicBitmap1, coreInfo->aivBitmap0, coreInfo->aivBitmap1);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
