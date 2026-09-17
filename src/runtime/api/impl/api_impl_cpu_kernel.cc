/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_impl.hpp"

#include "aicpu_c.hpp"
#include "capability.hpp"
#include "context.hpp"
#include "kernel.hpp"
#include "runtime.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImpl::CpuKernelLaunchEx(
    const Kernel* const kernel, const uint32_t coreDim, const rtCpuKernelArgs_t* const argsInfo, const TaskCfg& taskCfg,
    Stream* const stm, const uint32_t flag)
{
    const rtError_t error = AiCpuTaskSupportCheck();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream* curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Delivering the AI CPU operator task");
    if (kernel->GetAicpuKernelType_() == static_cast<uint32_t>(KERNEL_TYPE_AICPU_KFC)) {
        Device* const dev = curCtx->Device_();
        COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");
        if (!CheckSupportMC2Feature(dev)) {
            RT_LOG(
                RT_LOG_WARNING, "Current ts version[%u] does not support aicpu kfc kernel launch.",
                dev->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    Runtime* const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null.");
    ERROR_RETURN_MSG_INNER(
        rtInstance->StartAicpuSd(curCtx->Device_()),
        "Cpu kernel launch ex with args failed, check and start tsd open aicpu sd error.");

    return StreamLaunchCpuKernelExWithArgs(
        coreDim, &argsInfo->baseArgs, &taskCfg, curStm, flag, kernel->GetAicpuKernelType_(), kernel,
        argsInfo->cpuParamHeadOffset);
}

} // namespace runtime
} // namespace cce
