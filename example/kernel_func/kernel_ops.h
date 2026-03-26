/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef EXAMPLE_KERNEL_FUNC_KERNEL_OPS_H_
#define EXAMPLE_KERNEL_FUNC_KERNEL_OPS_H_

#include <cstdint>

void EasyOP(uint32_t blockDim, void* stream, uint32_t* x);
void ErrorOP(uint32_t blockDim, void* stream);
void LongOP(uint32_t blockDim, void* stream, uint32_t* x);
void ShortOP(uint32_t blockDim, void* stream, uint32_t* x);
void WriteDo(uint32_t blockDim, void* stream, int* devPtr, int value);
void ReadDo(uint32_t blockDim, void* stream, int* devPtr);
void PrintDo(uint32_t blockDim, void* stream);

#endif // EXAMPLE_KERNEL_FUNC_KERNEL_OPS_H_
