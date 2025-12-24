/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKTRACE_SAFE_RECORDER_H
#define STACKTRACE_SAFE_RECORDER_H

#include <stddef.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include "atrace_types.h"
#include "stacktrace_logger.h"

#define SELF_MAP_PATH                       "/proc/self/maps"
#define CORE_BUFFER_LEN         256U
#define LIB_PATH_LEN            256U
#define MAX_STACK_LAYER         0x20 // 0 ~ 31 : 32 layer

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct {
    uint64_t crashTime; // crash timestamp
    int32_t signo; // signal number
    int32_t pid; // crash process id
    int32_t tid; // crash thread id
} TraceStackRecorderInfo;

typedef struct {
    int32_t signo; // signal number
    int32_t pid; // crash process id
    int32_t tid; // crash thread id
    uint64_t crashTime; // crash timestamp
    uintptr_t baseAddr; // stack base addr
    uintptr_t topAddr; // stack top addr
} TraceStackProcessInfo;

typedef struct {
    char info[CORE_BUFFER_LEN];
} TraceFrameInfo;

typedef struct {
    uint32_t threadIdx;
    int32_t threadTid;
    char threadName[THREAD_NAME_LEN];
    int32_t layer;
    char errLog[CORE_BUFFER_LEN];
    TraceFrameInfo frame[MAX_STACK_LAYER];
} TraceStackInfo;

TraStatus TraceSafeGetFd(const TraceStackRecorderInfo *info, const char *suffix, int32_t *fd);
TraceStackInfo *TraceSafeGetStackBuffer(void);
TraStatus TraceSafeWriteSystemInfo(int32_t fd, int32_t pid);
TraStatus TraceSafeWriteStackInfo(int32_t fd, const TraceStackInfo *info);
TraStatus TraceSafeWriteProcessInfo(int32_t fd, const TraceStackProcessInfo *info);

ssize_t TraceSafeReadLine(int32_t fd, char *data, uint32_t len);
const char* TraceSafeGetFilePath(void);
TraStatus TraceSaveStackInfo(const TraceStackInfo *info);
TraStatus TraceSaveProcessInfo(const TraceStackProcessInfo *info);
TraStatus TraceSaveProcessReg(uintptr_t *regs, uint32_t regSize);
TraStatus TraceSafeWriteBuff(int32_t fd);

TraStatus TraceSafeGetDirPath(const TraceStackRecorderInfo *info, char *path, size_t len);
TraStatus TraceSafeGetFileName(const TraceStackRecorderInfo *info, char *name, size_t len);
TraStatus TraceSafeMkdirPath(const TraceStackRecorderInfo *info);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif