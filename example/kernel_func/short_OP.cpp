/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel_operator.h"
#include "kernel_ops.h"
// 核函数，自乘2
extern "C" __global__ __aicore__ void ShortOPf(__gm__ uint32_t* x)
{
    int idx = block_idx;
    x[idx] *= 2;
#if __NPU_ARCH__ == 3510
    dcci(reinterpret_cast<__gm__ int64_t*>(x),
        cache_line_t::ENTIRE_DATA_CACHE,
        dcci_dst_t::CACHELINE_OUT);
#endif
}

void ShortOP(uint32_t blockDim, void *stream, uint32_t* x)
{
    ShortOPf<<<blockDim, nullptr, stream>>>(x);
}
