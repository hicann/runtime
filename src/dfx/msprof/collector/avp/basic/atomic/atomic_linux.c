/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdatomic.h>
#include "atomic.h"

void AtomicInit(volatile int32_t *ptr, int32_t val)
{
    atomic_init((volatile atomic_int *)ptr, val);
}

int32_t AtomicLoad(volatile int32_t *ptr)
{
    return atomic_load((volatile atomic_int *)ptr);
}

bool AtomicCompareExchangeWeak(volatile int32_t *ptr, int32_t desired, int32_t expected)
{
    return !atomic_compare_exchange_weak((volatile atomic_int *)ptr, &expected, desired);
}

int32_t AtomicAdd(volatile int32_t *ptr, int32_t val)
{
    return atomic_fetch_add((volatile atomic_int *)ptr, val);
}