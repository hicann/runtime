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
#include "vector_add_kernel.h"

extern "C" __global__ __aicore__ void VectorAddKernel(
    __gm__ float* srcA, __gm__ float* srcB, __gm__ float* dst, float alpha, uint32_t elementCount)
{
    uint32_t idx = block_idx;
    if (idx < elementCount) {
        dst[idx] = srcA[idx] + alpha * srcB[idx];
    }
}

void VectorAddDo(
    uint32_t blockDim, void* stream, float* srcA, float* srcB, float* dst, float alpha, uint32_t elementCount)
{
    VectorAddKernel<<<blockDim, nullptr, stream>>>(srcA, srcB, dst, alpha, elementCount);
}
