/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

 /*
 * Using the Ascend kernel to write the value at devPtrA and read the value at devPtrB
 */

#include "kernel_operator.h"

extern "C" __global__ __aicore__ void DeviceWrite(__gm__ int* devPtr, int value)
{
    int32_t idx = block_idx;
    devPtr[idx] = value;
    AscendC::printf("Source data: %d\n", value);
}

void WriteDo(uint32_t blockDim, void *stream, int* devPtr, int value)
{
    DeviceWrite<<<blockDim, nullptr, stream>>>(devPtr, value);
}

extern "C" __global__ __aicore__ void DeviceRead(__gm__ int* devPtr)
{
    int32_t idx = block_idx;
    int value = devPtr[idx];
    AscendC::printf("Destination data: %d\n", value);
}

void ReadDo(uint32_t blockDim, void *stream, int* devPtr)
{
    DeviceRead<<<blockDim, nullptr, stream>>>(devPtr);
}