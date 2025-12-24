/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOS_ATOMIC_STUB_H
#define LOS_ATOMIC_STUB_H

#include <stdint.h>
#include <stdbool.h>

#if __cplusplus
extern "C" {
#endif  // __cpluscplus

void LOS_AtomicSet(volatile int32_t *ptr, int32_t val);
int32_t LOS_AtomicRead(volatile int32_t *ptr);
bool LOS_AtomicCmpXchg32bits(volatile int32_t *ptr, int32_t desired, int32_t expected);
int32_t LOS_AtomicAdd(volatile int32_t *ptr,int32_t val);

#if __cplusplus
}
#endif  // __cpluscplus

#endif