/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef EXAMPLE_0_QUICKSTART_4_CUSTOM_KERNEL_LAUNCH_VECTOR_ADD_KERNEL_H_
#define EXAMPLE_0_QUICKSTART_4_CUSTOM_KERNEL_LAUNCH_VECTOR_ADD_KERNEL_H_

#include <cstdint>

void VectorAddDo(
    uint32_t blockDim, void* stream, float* srcA, float* srcB, float* dst, float alpha, uint32_t elementCount);

#endif // EXAMPLE_0_QUICKSTART_4_CUSTOM_KERNEL_LAUNCH_VECTOR_ADD_KERNEL_H_