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
    for (uint32_t idx = 0; idx < elementCount; ++idx) {
        dst[idx] = srcA[idx] + alpha * srcB[idx];
    }

    // A5 编译时，生成器会在 kernel tail 中追加 dci()。关闭自动 DCCI 后，scalar store 产生的脏数据
    // 尚未回写到 GM 就被 dci() 失效，导致输出全为 0，因此需要显式调用 dcci() 将数据回写到 GM。
#if __NPU_ARCH__ == 3510
    dcci(reinterpret_cast<__gm__ int64_t*>(dst),
        cache_line_t::ENTIRE_DATA_CACHE,
        dcci_dst_t::CACHELINE_OUT);
#endif
}

int32_t VectorAddDo(
    uint32_t blockDim, void* stream, float* srcA, float* srcB, float* dst, float alpha, uint32_t elementCount)
{
    return static_cast<int32_t>(VectorAddKernel<<<blockDim, nullptr, stream>>>(srcA, srcB, dst, alpha, elementCount));
}
