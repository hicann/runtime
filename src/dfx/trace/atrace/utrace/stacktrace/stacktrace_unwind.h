/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKCORE_UNWIND_H
#define STACKCORE_UNWIND_H

#include <stddef.h>
#include <signal.h>
#include "atrace_types.h"
#include "stacktrace_fp.h"
#include "stacktrace_unwind_reg.h"
#include "stacktrace_safe_recorder.h"
#include "scd_dwarf.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define TRACE_MAX_CODE_SEGMENT_NUM 100
#define TRACE_MAX_OBJ_NAME_LENGTH 200

typedef struct TraceLoadProgSegInfo {
    uintptr_t loadProgSegAddr;           // load program segment sddr
    uint32_t segSize;                    // load program segment size
} TraceLoadProgSegInfo;

// unwind map info for each elf file
typedef struct TraceUnwindMapInfo {
    uintptr_t loadBase;                                              // load base add for elf
    uintptr_t unwindSegStart;                                        // eh_frame segment address of elf file
    size_t size;                                                     // eh_frame segment size
    char objName[TRACE_MAX_OBJ_NAME_LENGTH];                         // name of dynamic library
    TraceLoadProgSegInfo codeList[TRACE_MAX_CODE_SEGMENT_NUM];       // code segment info
    uint32_t codeListNum;                                            // num of code segment
    size_t count;                                                  // FDE count
} TraceUnwindMapInfo;
TraStatus TraceStackUnwind(const ThreadArgument *arg, uintptr_t *regsAddr, uint32_t regNum, TraceStackInfo *stackInfo);
void TraceStackUnwindInit(void);
TraStatus TraceGetEhFrameHdrAddr(uintptr_t pc, ScdDwarf *dwarf);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif

