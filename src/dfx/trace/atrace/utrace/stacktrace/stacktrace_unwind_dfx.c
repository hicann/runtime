/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stacktrace_unwind_dfx.h"
#include <fcntl.h>
#include "stacktrace_logger.h"
#include "trace_system_api.h"
#include "adiag_utils.h"

#define TMP_DUMP_STACK_PATH "/tmp/stack.bin"
#define TMP_DUMP_ELF_PATH "/tmp/elf_%zu.bin"
#define MAX_FILE_PATH_LENGTH 100U
#ifdef ENABLE_DUMP_DFX_INFO
static void DumpToFile(const char *filePath, uintptr_t addr, size_t size)
{
    #define TRACE_FILE_MODE         0640U
    int32_t fd = TraceOpen(filePath, (uint32_t)O_CREAT | (uint32_t)O_WRONLY | (uint32_t)O_APPEND,
        TRACE_FILE_MODE);
    if (fd == -1) {
        return;
    }
    write(fd, (void *)addr, size);
    close(fd);
    fd = -1;
}
#endif

void DumpStackToFile(uintptr_t addr, size_t size)
{
#ifndef ENABLE_DUMP_DFX_INFO
    (void)addr;
    (void)size;
#else
    DumpToFile(TMP_DUMP_STACK_PATH, addr, size);
#endif
}

void DumpMemory(uintptr_t addr, size_t size)
{
#ifndef ENABLE_DUMP_DFX_INFO
    (void)addr;
    (void)size;
#else
    static size_t cnt = 0;
    static uintptr_t addrList[20] = {0};
    for (size_t i = 0; i < cnt; i++) {
        if (addr == addrList[i]) {
            return;
        }
    }
    addrList[cnt] = addr;
    cnt++;
    char filePath[MAX_FILE_PATH_LENGTH];
    int32_t ret = sprintf_s(filePath, MAX_FILE_PATH_LENGTH, TMP_DUMP_ELF_PATH, cnt);
    if (ret == -1) {
        LOGE("snprintf_s elf path failed, strerr=%s", strerror(AdiagGetErrorCode()));
        return;
    }
    DumpToFile(filePath, addr, size);
    LOGI("[LLT] write elf to %s , size : %zu", filePath, size);
#endif
}
