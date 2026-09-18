/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CAPABILITY_BASED_AGGREGATION_H
#define CAPABILITY_BASED_AGGREGATION_H

#include <cstdint>

constexpr uint32_t kRecordCount = 1024;
constexpr uint32_t kCategoryCount = 8;
constexpr uint32_t kMaxBlocks = 8;

int32_t AggregateCountersDo(uint32_t blockDim, void* stream, void* input, void* output, bool hostAtomic);

#endif
