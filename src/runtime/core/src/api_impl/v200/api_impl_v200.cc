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
#include "base.hpp"
#include "runtime.hpp"
#include "runtime/dev.h"
#include "error_message_manage.hpp"
#include "para_convertor.hpp"
#include "aix_c.hpp"
#include "stream_c.hpp"
#include "xpu_aicpu_c.hpp"
#include "task_fail_callback_manager.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImplDavid::LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
                                  Stream * const stm, const rtKernelLaunchCfg_t * const cfg)
{
    TaskCfg taskCfg = {};
    rtError_t error = ConvertLaunchCfgToTaskCfg(taskCfg, cfg);
    ERROR_RETURN(error, "convert task cfg failed, retCode=%#x.", error);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);

    Stream *curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);

    COND_RETURN_AND_MSG_OUTER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        ErrorCode::EE1010, __func__, "stream");
    
    if (IS_SUPPORT_CHIP_FEATURE(dev->GetChipType(), RtOptionalFeatureType::RT_FEATURE_XPU)) {
        return XpuLaunchKernelV2(kernel, blockDim, argsWithType, stm, taskCfg);
    }

    if (!kernel->Program_()->IsDeviceSoAndNameValid(curCtx->Device_()->Id_())) {
        RT_LOG(RT_LOG_WARNING, "Failed to validate kernel program, device_id=%d.", curCtx->Device_()->Id_());
        return RT_ERROR_KERNEL_INVALID;
    }
    // For the new launch logic, the nop task delivery is hidden in the launchKernel. only for aic/aiv kernel
    if ((kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU) && (taskCfg.isExtendValid == 1U) && (taskCfg.extend.blockTaskPrefetch)) {
        const uint8_t prefetchCnt = PREFETCH_CNT_CLOUD_V2;
        for (uint8_t cntIdx = 0U; cntIdx < prefetchCnt; cntIdx++) {
            error = NopTask(curStm);
            ERROR_RETURN_MSG_INNER(error, "Failed to launch NOP task, error=%#x.", error);
        }
    }

    return LaunchKernelByArgsWithType(kernel, blockDim, curStm, argsWithType, taskCfg);
}

rtError_t ApiImplDavid::XpuSetTaskFailCallback(const rtXpuDevType devType, const char_t *moduleName, void *callback)
{
    UNUSED(devType);
    return XpuTaskFailCallbackReg(moduleName, callback);
}

}
}
