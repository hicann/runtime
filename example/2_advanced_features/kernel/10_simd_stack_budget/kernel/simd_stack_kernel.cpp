/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel_operator.h"

namespace {
constexpr uint32_t kStackElementCount = 12U * 1024U;
} // namespace

extern "C" __global__ __vector__ void ValidateSimdStackKernel(__gm__ uint32_t* output, uint32_t seed)
{
    volatile uint32_t stackValues[kStackElementCount];
    uint32_t checksum = 0U;
    for (uint32_t index = 0U; index < kStackElementCount; ++index) {
        stackValues[index] = seed + index % 97U;
    }
    for (uint32_t index = 0U; index < kStackElementCount; ++index) {
        checksum += stackValues[index];
    }
    output[0] = checksum;
#if __NPU_ARCH__ == 3510
    dcci(reinterpret_cast<__gm__ int64_t*>(output), cache_line_t::ENTIRE_DATA_CACHE, dcci_dst_t::CACHELINE_OUT);
#endif
}
