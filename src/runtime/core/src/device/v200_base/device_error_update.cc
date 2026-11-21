/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device_error_proc.hpp"
#include "device_error_proc_c.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "task_recycle.hpp"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

static void UpdateFusionKernelErrorInfoStreamId(StarsDeviceErrorInfo* const errorInfo, const uint32_t streamId)
{
    if (errorInfo->u.fusionKernelErrorInfo.comm.streamId == UINT16_MAX) {
        errorInfo->u.fusionKernelErrorInfo.comm.streamId = static_cast<uint16_t>(streamId);
    }

    /* 处理子任务 */
    StarsDeviceErrorInfo* errInfoTmp = nullptr;
    if (errorInfo->u.fusionKernelErrorInfo.aicpuError == 1U) {
        errInfoTmp = RtPtrToPtr<StarsDeviceErrorInfo*>(&(errorInfo->u.fusionKernelErrorInfo.u.aicpuInfo));
        if (errInfoTmp->u.aicpuErrorInfo.comm.streamId == UINT16_MAX) {
            errInfoTmp->u.aicpuErrorInfo.comm.streamId = static_cast<uint16_t>(streamId);
        }

        const uint16_t type = errInfoTmp->u.aicpuErrorInfo.comm.type;
        if (type == static_cast<uint16_t>(AICPU_ERROR)) {
            if (errInfoTmp->u.aicpuErrorInfo.aicpu.rspErrorInfo.streamId == UINT16_MAX) {
                errInfoTmp->u.aicpuErrorInfo.aicpu.rspErrorInfo.streamId = streamId;
            }
        }
    } else if (errorInfo->u.fusionKernelErrorInfo.ccuError == 1U) {
        errInfoTmp = RtPtrToPtr<StarsDeviceErrorInfo*>(&(errorInfo->u.fusionKernelErrorInfo.u.ccuInfo));
        if (errInfoTmp->u.ccuErrorInfo.comm.streamId == UINT16_MAX) {
            errInfoTmp->u.ccuErrorInfo.comm.streamId = static_cast<uint16_t>(streamId);
        }
    } else if (errorInfo->u.fusionKernelErrorInfo.aicError == 1U) {
        errInfoTmp = RtPtrToPtr<StarsDeviceErrorInfo*>(&(errorInfo->u.fusionKernelErrorInfo.aicInfo));
        if (errInfoTmp->u.davidCoreErrorInfo.comm.streamId == UINT16_MAX) {
            errInfoTmp->u.davidCoreErrorInfo.comm.streamId = static_cast<uint16_t>(streamId);
        }
    } else if (errorInfo->u.fusionKernelErrorInfo.aivError == 1U) {
        errInfoTmp = RtPtrToPtr<StarsDeviceErrorInfo*>(&(errorInfo->u.fusionKernelErrorInfo.aivInfo));
        if (errInfoTmp->u.davidCoreErrorInfo.comm.streamId == UINT16_MAX) {
            errInfoTmp->u.davidCoreErrorInfo.comm.streamId = static_cast<uint16_t>(streamId);
        }
    } else {
        ; // do nothing
    }
}
void UpdateDeviceErrorInfoHookFunc(std::map<uint64_t, DeviceErrorProc::ErrorInfoUpdateProc>& funcMap)
{
    const std::map<uint64_t, DeviceErrorProc::ErrorInfoUpdateProc> davidHookMap = {
        {AICORE_ERROR, &UpdateCommErrorInfoStreamId},
        {AIVECTOR_ERROR, &UpdateCommErrorInfoStreamId},
        {WAIT_TIMEOUT_ERROR, &UpdateWaitTimeoutErrorInfoStreamId},
        {SDMA_ERROR, &UpdateCommErrorInfoStreamId},
        {AICPU_ERROR, &UpdateAicpuErrorInfoStreamId},
        {DVPP_ERROR, &UpdateDvppErrorInfoStreamId},
        {SQE_ERROR, &UpdateSqeErrorInfoStreamId},
        {FUSION_KERNEL_ERROR, &UpdateFusionKernelErrorInfoStreamId},
        {CCU_ERROR, &UpdateCommErrorInfoStreamId},
        {AICORE_TIMEOUT_DFX, &UpdateCommErrorInfoStreamId},
        {NOCORE_TIMEOUT_ERROR, &UpdateCommErrorInfoStreamId}};
    funcMap = davidHookMap;
    return;
}

} // namespace runtime
} // namespace cce
