/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_impl_david.hpp"
#include "runtime/dev.h"
#include "aix_c.hpp"
#include "context.hpp"
#include "stream_c.hpp"
#include "para_convertor.hpp"

namespace cce {
namespace runtime {
rtError_t ApiImplDavid::SetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplDavid::GetXpuDevCount(const rtXpuDevType devType, uint32_t *devCount)
{
    UNUSED(devType);
    UNUSED(devCount);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplDavid::ResetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplDavid::LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
                                  Stream * const stm, const rtKernelLaunchCfg_t * const cfg)
{
    TaskCfg taskCfg = {};
    rtError_t error = ConvertLaunchCfgToTaskCfg(taskCfg, cfg);
    ERROR_RETURN(error, "convert task cfg failed, retCode=%#x.", error);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch with handle failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    if (!kernel->Program_()->IsDeviceSoAndNameValid(curCtx->Device_()->Id_())) {
        RT_LOG(RT_LOG_WARNING, "kernel is invalid, device_id=%d", curCtx->Device_()->Id_());
        return RT_ERROR_KERNEL_INVALID;
    }
    // For the new launch logic, the nop task delivery is hidden in the launchKernel. only for aic/aiv kernel

    if ((kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU) && (taskCfg.isExtendValid == 1U) && (taskCfg.extend.blockTaskPrefetch)) {
        const uint8_t prefetchCnt = PREFETCH_CNT_CLOUD_V2;
        for (uint8_t cntIdx = 0U; cntIdx < prefetchCnt; cntIdx++) {
            error = NopTask(curStm);
            ERROR_RETURN_MSG_INNER(error, "launch nop task error, error=%#x.", error);
        }
    }

    return LaunchKernelByArgsWithType(kernel, blockDim, curStm, argsWithType, taskCfg);
}
}
}