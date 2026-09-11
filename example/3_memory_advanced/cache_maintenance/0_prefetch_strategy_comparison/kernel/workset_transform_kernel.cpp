/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>

#include "kernel_operator.h"

extern "C" __global__ __aicore__ void TransformWorksetKernel(
    __gm__ uint32_t* input, __gm__ uint32_t* output, uint32_t elementCount, uint32_t scale, uint32_t offset)
{
    for (uint32_t index = 0; index < elementCount; ++index) {
        output[index] = input[index] * scale + offset;
    }

#if __NPU_ARCH__ == 3510
    dcci(reinterpret_cast<__gm__ int64_t*>(output), cache_line_t::ENTIRE_DATA_CACHE, dcci_dst_t::CACHELINE_OUT);
#endif
}

int32_t TransformWorksetDo(
    uint32_t blockDim, void* stream, uint32_t* input, uint32_t* output, uint32_t elementCount, uint32_t scale,
    uint32_t offset)
{
    return static_cast<int32_t>(
        TransformWorksetKernel<<<blockDim, nullptr, stream>>>(input, output, elementCount, scale, offset));
}
