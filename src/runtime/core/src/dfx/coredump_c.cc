/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "coredump_c.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "inner_kernel.h"
#include "context.hpp"
#include "program.hpp"

namespace cce {
namespace runtime {

constexpr uint32_t MAX_WARP_NUM_PER_VECTOR = 64U;

static rtError_t CheckCoreParam(
    const Device* device, const uint32_t stackType, const uint32_t coreType, const uint32_t coreId)
{
    if (coreType == RT_CORE_TYPE_AIC && stackType == RT_STACK_TYPE_SIMT) {
        RT_LOG(RT_LOG_WARNING, "stackType=%u and coreType=%u is not supported.", stackType, coreType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        ((stackType > RT_STACK_TYPE_SIMT)), RT_ERROR_INVALID_VALUE,
        "Verifying the validity of the compute core type and stack type", stackType,
        "[0, " + std::to_string(RT_STACK_TYPE_SIMT) + "]");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        ((coreType > RT_CORE_TYPE_AIV)), RT_ERROR_INVALID_VALUE,
        "Verifying the validity of the compute core type and stack type", coreType,
        "[0, " + std::to_string(RT_CORE_TYPE_AIV) + "]");

    uint32_t aicNum = device->GetDevProperties().aicNum;
    uint32_t aivNum = device->GetDevProperties().aivNum;
    if (coreType == RT_CORE_TYPE_AIC) {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
            (coreId >= aicNum), RT_ERROR_INVALID_VALUE,
            "Verifying the validity of the compute core type and stack type", coreId,
            "[0, " + std::to_string(aicNum) + ")");
    } else {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
            (coreId >= aivNum), RT_ERROR_INVALID_VALUE,
            "Verifying the validity of the compute core type and stack type", coreId,
            "[0, " + std::to_string(aivNum) + ")");
    }
    return RT_ERROR_NONE;
}

static uint32_t GetDieOffset(const Device* device, const uint32_t coreType, const uint32_t coreId)
{
    const uint32_t aicNumPerDie = device->GetDevProperties().aicNumPerDie;
    const uint32_t aivNumPerDie = device->GetDevProperties().aivNumPerDie;
    const uint32_t dieId = (coreType == 0U) ? (coreId / aicNumPerDie) : (coreId / aivNumPerDie);
    const uint32_t coreIdOnDie = (coreType == 0U) ? (coreId % aicNumPerDie) : (coreId % aivNumPerDie);
    const uint32_t offsetBase = coreIdOnDie + (aicNumPerDie + aivNumPerDie) * dieId;
    return (coreType == 0U) ? offsetBase : offsetBase + aicNumPerDie;
}

rtError_t GetStackBufferInfo(
    const rtBinHandle binHandle, uint32_t deviceId, const uint32_t stackType, const uint32_t coreType,
    const uint32_t coreId, const void** stack, uint32_t* stackSize)
{
    UNUSED(deviceId);
    const Runtime* const rt = Runtime::Instance();
    Context* curCtx = rt->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device* device = curCtx->Device_();
    NULL_PTR_RETURN(device, RT_ERROR_DEVICE_NULL);
    const auto ret = CheckCoreParam(device, stackType, coreType, coreId);
    COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE), ret);
    Program* const programHdl = RtPtrToPtr<Program*>(binHandle);
    if (stackType == RT_STACK_TYPE_SIMT) {
        const uint32_t simtWarpStkSize = device->GetSimtWarpStkSize();
        const uint32_t simtDvgWarpStkSize = device->GetSimtDvgWarpStkSize();
        *stackSize = MAX_WARP_NUM_PER_VECTOR * (simtWarpStkSize + simtDvgWarpStkSize);
        const void* stackPhyBase = device->GetSimtStackPhyBase();
        *stack = ValueToPtr(PtrToValue(stackPhyBase) + (*stackSize) * coreId);
    } else {
        *stackSize = KERNEL_STACK_SIZE_32K;
        const void* stackPhyBase = device->GetStackPhyBase32k();
        const uint32_t maxMinStackSize = programHdl->GetMaxMinStackSize();
        const uint32_t deviceCustomerStackSize = device->GetDeviceAllocStackSize();
        if ((deviceCustomerStackSize != 0U) && (maxMinStackSize > KERNEL_STACK_SIZE_32K)) {
            *stackSize = deviceCustomerStackSize;
            stackPhyBase = device->GetCustomerStackPhyBase();
        }
        *stack = ValueToPtr(PtrToValue(stackPhyBase) + (*stackSize) * GetDieOffset(device, coreType, coreId));
    }
    RT_LOG(RT_LOG_DEBUG, "coreType=%u, coreId=%u, stackSize=%u", coreType, coreId, *stackSize);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
