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
constexpr uint32_t kElementCount = 8;
constexpr int32_t kMainBias = 10;
constexpr int32_t kPostScale = 2;
} // namespace

extern "C" __global__ __aicore__ void fallback_main(__gm__ int32_t* input, __gm__ int32_t* output)
{
    for (uint32_t i = 0; i < kElementCount; ++i) {
        output[i] = input[i] + kMainBias;
    }
#if __NPU_ARCH__ == 3510
    dcci(reinterpret_cast<__gm__ int64_t*>(output), cache_line_t::ENTIRE_DATA_CACHE, dcci_dst_t::CACHELINE_OUT);
#endif
}

extern "C" __global__ __aicore__ void fallback_postprocess(__gm__ int32_t* input, __gm__ int32_t* output)
{
    for (uint32_t i = 0; i < kElementCount; ++i) {
        output[i] = input[i] * kPostScale;
    }
#if __NPU_ARCH__ == 3510
    dcci(reinterpret_cast<__gm__ int64_t*>(output), cache_line_t::ENTIRE_DATA_CACHE, dcci_dst_t::CACHELINE_OUT);
#endif
}
