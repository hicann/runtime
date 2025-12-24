/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_memory.h"
#include <stdlib.h>
#include "scd_log.h"
#include "scd_memory_remote.h"
#include "scd_memory_local.h"

typedef struct {
    size_t (*read)(uintptr_t addr, void *dst, size_t size);
} ScdMemoryHandler;

static const ScdMemoryHandler SCD_MEMORY_HANDLE = {
#ifdef ENABLE_SCD
    ScdMemoryRemoteRead
#else
    ScdMemoryLocalRead
#endif
};

void ScdMemoryInitLocal(ScdMemory *memory)
{
    memory->handlers.read = ScdMemoryLocalRead;
    memory->data = 0;
    memory->size = 0;
}

void ScdMemoryInitRemote(ScdMemory *memory)
{
    memory->handlers.read = ScdMemoryRemoteRead;
    memory->data = 0;
    memory->size = 0;
}

size_t ScdMemoryRead(ScdMemory *memory, uintptr_t addr, void *dst, size_t size)
{
    if (memory == NULL) {
        return SCD_MEMORY_HANDLE.read(addr, dst, size);
    }
    if (addr < memory->data || addr >= memory->data + memory->size) {
        SCD_DLOG_ERR("Invalid address, addr 0x%llx out of memory range[0x%llx, 0x%llx],",
            addr, memory->data, memory->data + memory->size);
        return 0;
    }
    return memory->handlers.read(addr, dst, size);
}

void *ScdMemoryGetAddr(ScdMemory *memory, uintptr_t offset, size_t size)
{
    if (offset + size > memory->size) {
        SCD_DLOG_ERR("read memory failed, read size is out of memory range.");
        return NULL;
    }
    return (void *)(memory->data + offset);
}

size_t ScdMemoryReadString(ScdMemory *memory, uintptr_t addr, char *dst, size_t size)
{
    if ((memory == NULL) || (dst == NULL) || (size <= 1U)) {
        return 0;
    }

    size_t i = 0;
    while (i < size) {
        char *value = ScdMemoryGetAddr(memory, addr + i, 1U);
        if ((value == NULL) || (*value == '\0')) {
            dst[i] = '\0';
            return i;
        }
        dst[i] = *value;
        i++;
    }
    dst[size - 1U] = '\0';
    return size - 1U;
}