/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKTRACE_FILE_STRUCT_H
#define STACKTRACE_FILE_STRUCT_H

#define STACK_HEAD_MAGIC        0xAC23U
#define STACK_HEAD_VERSION      0x0001U

#include <stdint.h>
#include "stacktrace_unwind_reg.h"
typedef struct ScBlockLayout {
    int32_t type;
    int32_t offset;
    int32_t size;
    int32_t reseve; 
} ScBlockLayout;

typedef struct ScHead { // 1k
    uint16_t magic;
    uint16_t version;
    int8_t blockNum;
    ScBlockLayout block[32];
    int8_t reserve[507];
} ScHead;

typedef struct ScProcessInfo {
    char task[256];
    pid_t pid;
    pid_t crashTid;
    int32_t signo;
    uint64_t crashTime;
    uintptr_t baseAddr;
    uintptr_t topAddr;
    uintptr_t regs[TRACE_CORE_REG_NUM];
} ScProcessInfo;

typedef struct ScdFrames {
    char frame[256];
} ScdFrames;

typedef struct ScThreadInfo { // 1k
    pid_t tid;
    char name[16];
    int32_t layer;
    ScdFrames frames[32]; // 256 * 32
} ScThreadInfo;

typedef struct ScLog { // 16k
    int32_t logNum;
    int32_t logIndex;
    char logItem[127][128];
    int8_t reserve[120];
} ScLog;

struct StackcoreBuffer {
    ScHead head;               // 1k
    ScProcessInfo process;     // 1k
    ScThreadInfo thread[1024]; // 1k * 1024
    ScLog logData;                 // 16k
};

#endif