/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_MEMORY_H
#define SCD_MEMORY_H

#include <stddef.h>
#include "atrace_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct ScdMemoryHanders {
    size_t (*read)(uintptr_t addr, void *dst, size_t size);
} ScdMemoryHanders;

typedef struct ScdMemory {
    uintptr_t data;  // memory data ptr
    size_t size;  // memory size
    ScdMemoryHanders handlers; // memory handler functions
} ScdMemory;

void ScdMemoryInitLocal(ScdMemory *memory);
void ScdMemoryInitRemote(ScdMemory *memory);
size_t ScdMemoryRead(ScdMemory *memory, uintptr_t addr, void *dst, size_t size);
void *ScdMemoryGetAddr(ScdMemory *memory, uintptr_t offset, size_t size);
size_t ScdMemoryReadString(ScdMemory *memory, uintptr_t addr, char *dst, size_t size);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif