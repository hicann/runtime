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

// 核函数，长时间任务
extern "C" __global__ __aicore__ void LongOPf(__gm__ uint32_t* x)
{
    float temp = 0.0f;
    int idx = block_idx;
    //复杂的浮点运算来模拟长时间任务
    for (int i = 0; i < 10000; i++) {
        temp += 0.00002f;
        temp *= 0.02f;
        for (int j = 0; j < 25000; j++){
            temp = temp * temp - 0.000002f;
            temp = temp + (temp * 0.05f);
            temp = temp * temp + 0.00001f;
            temp = temp > 1.0f ? 0.0f : temp;
        }
        temp -= 0.00003f * temp;
    }
    x[idx] += temp > 0.0f ? 1:0;
}

void LongOP(uint32_t blockDim, void *stream, uint32_t* x)
{
    LongOPf<<<blockDim, nullptr, stream>>>(x);
}