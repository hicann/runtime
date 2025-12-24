/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_PROCESS_H
#define SCD_PROCESS_H

#include "atrace_types.h"
#include "stacktrace_common.h"
#include "scd_maps.h"
#include "scd_regs.h"
#include "scd_threads.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define SCD_MAX_SHDR_NUM            10U
#define SCD_SECTION_NAME_LEN        32U
#define SCD_PNAME_LEN               256U

typedef struct ScdProcInfo {
    uint32_t    offset;
    uint32_t    size;
} ScdProcInfo;
 
typedef enum ScdShdrType {
    SCD_SHDR_TYPE_INVALID,
    SCD_SHDR_TYPE_LIST,
    SCD_SHDR_TYPE_FD,
} ScdShdrType;

typedef struct ScdSection {
    bool        use;
    char        name[SCD_SECTION_NAME_LEN];
    uint32_t    offset;
    uint32_t    num;
    uint32_t    entSize;
    uint32_t    totalSize;
    ScdShdrType type;
    uintptr_t   org;
} ScdSection;

typedef struct ScdProcess {
    ScdProcessArgs  args;
    char            pname[SCD_PNAME_LEN];
    ScdMaps         maps;
    ScdThreads      thds;
    bool            shdrUsed;
    ScdSection      shdr[SCD_MAX_SHDR_NUM];
} ScdProcess;

TraStatus ScdProcessDump(const ScdProcessArgs *args);
TraStatus ScdProcessParseCore(const char *filePath, uint32_t len);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif