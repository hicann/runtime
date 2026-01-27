/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel.hpp"
#include "program.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {

rtError_t GetPrefetchCnt(const Program *prog, Kernel * const kernel)
{
    uint32_t machine = prog->Machine();
    if (machine == Program::MACH_AI_CPU) {
        return RT_ERROR_NONE;
    }
    if (machine == Program::MACH_AI_MIX_KERNEL) {
        machine = kernel->KernelType_();
    }

    uint32_t icachePrefetchCnt1 = 0U;
    uint32_t icachePrefetchCnt2 = 0U;
    // 32KB, K=1024. aicore can prefetch 32KB at most.
    constexpr uint32_t aicoreIcachePrefetchSizeMax = 32768U;
    // 16KB, K=1024. aivector can prefetch 16KB at most.
    constexpr uint32_t aivectorIcachePrefetchSizeMax = 16384U;
    constexpr uint32_t prefetchUnits = 2048U;

    uint32_t restSize1 = 0U;
    uint32_t restSize2 = 0U;
    kernel->GetKernelLength(restSize1, restSize2);
    uint32_t prefetchMaxSize1 = 0U;
    uint32_t prefetchMaxSize2 = 0U;

    const uint8_t mixtype = kernel->GetMixType();
    switch (mixtype) {
        case static_cast<uint8_t>(MIX_AIC):
            prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
            break;
        case static_cast<uint8_t>(MIX_AIV):
            prefetchMaxSize1 = aivectorIcachePrefetchSizeMax;
            break;
        case static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC):
            prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
            prefetchMaxSize2 = aivectorIcachePrefetchSizeMax;
            break;
        default:
        switch (machine) {
            case Program::MACH_AI_CORE:
                prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
                break;
            case Program::MACH_AI_CVMIX:
                prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
                break;
            case Program::MACH_AI_VECTOR:
                prefetchMaxSize1 = aivectorIcachePrefetchSizeMax;
                break;
            default:
                RT_LOG(RT_LOG_ERROR, "get prefetch cnt failed, machine=%u.", machine);
                return RT_ERROR_INVALID_VALUE;
        }
    }

    // Icache_prefetch_cnt:aic aiv prefetch instruction length, the unit is 2KB, K=1024
    const uint32_t restSizeCnt1 = restSize1 / prefetchUnits;
    const uint32_t prefetchMaxSizeCnt1 = prefetchMaxSize1 / prefetchUnits;
    icachePrefetchCnt1 = (restSizeCnt1 > prefetchMaxSizeCnt1) ? prefetchMaxSizeCnt1 : restSizeCnt1;
    if (mixtype == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC)) {
        const uint32_t restSizeCnt2 = restSize2 / prefetchUnits;
        const uint32_t prefetchMaxSizeCnt2 = prefetchMaxSize2 / prefetchUnits;
        icachePrefetchCnt2 = (restSizeCnt2 > prefetchMaxSizeCnt2) ? prefetchMaxSizeCnt2 : restSizeCnt2;
    }

    kernel->SetPrefetchCnt1_(icachePrefetchCnt1);
    kernel->SetPrefetchCnt2_(icachePrefetchCnt2);
    RT_LOG(RT_LOG_DEBUG, "get prefetch cnt success, kernel_name=%s, prefetchCnt1=%u, prefetchCnt2=%u, mixtype=%hu.",
           kernel->Name_().c_str(), kernel->PrefetchCnt1_(), kernel->PrefetchCnt2_(), mixtype);
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
