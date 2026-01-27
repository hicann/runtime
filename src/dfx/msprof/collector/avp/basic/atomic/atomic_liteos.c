/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "atomic.h"
#include "los_atomic.h"

void AtomicInit(volatile int32_t *ptr, int32_t val)
{
    LOS_AtomicSet(ptr, val);
}

int32_t AtomicLoad(volatile int32_t *ptr)
{
    return LOS_AtomicRead(ptr);
}

bool AtomicCompareExchangeWeak(volatile int32_t *ptr, int32_t desired, int32_t expected)
{
    return LOS_AtomicCmpXchg32bits(ptr, desired, expected);
}

int32_t AtomicAdd(volatile int32_t *ptr, int32_t val)
{
    return LOS_AtomicAdd(ptr, val);
}