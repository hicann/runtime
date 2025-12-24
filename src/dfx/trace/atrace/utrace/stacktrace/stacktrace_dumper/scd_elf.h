/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCD_ELF_H
#define SCD_ELF_H

#include "atrace_types.h"
#include "adiag_list.h"
#include "scd_util.h"
#include "scd_memory.h"
#include "scd_regs.h"

#define SCD_FUNC_NAME_LENGTH 128U
#define SCD_DL_NAME_LENGTH 512U

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/*
 * ***************************
 * File Header        *
 * ***************************
 * Prog Header(optional)  *
 * ***************************
 * Section 1          *
 * ***************************
 * Section 2          *
 * ***************************
 * Section ...        *
 * ***************************
 * Section Header Table   *
 * ***************************
 */

typedef struct ScdDlSymbol {
    size_t symOffset; // symbol section offset index
    size_t symEnd; // symbol section end index
    size_t symEntrySize; // entry size for each symbol
    size_t strOffset; // string table offset index
    size_t strEnd; // string table end index
} ScdDlSymbol;

typedef struct ScdElf {
    int32_t                  pid;
    ScdMemory               *memory;
    uintptr_t                loadBias;  // load_bias是一个地址偏移量，用于修正动态链接器和程序之间的地址差异。
    bool                     loadBiasSave;

    // symbols (.dynsym with .dynstr, .symtab with .strtab)
    uint32_t                 symbolOffset;
    uint32_t                 symbolNum;
    struct AdiagList         symbolList;

    // .note.gnu.build-id
    size_t                   buildIdOffset;
    size_t                   buildIdSize;

    // .eh_frame without option .eh_frame_hdr
    size_t                   ehFrameOffset;
    size_t                   ehFrameSize;
    uintptr_t                ehFrameLoadBias;

    // .eh_frame with option .eh_frame_hdr
    size_t                   ehFrameHdrOffset;
    size_t                   ehFrameHdrSize;
    uintptr_t                ehFrameHdrLoadBias;

    // .debug_frame
    size_t                   debugFrameOffset;
    size_t                   debugFrameSize;

    // .gnu_debugdata
    size_t                   gnuDebugdataOffset;
    size_t                   gnuDebugdataSize;

    // .dynamic
    size_t                   dynamicOffset;
    size_t                   dynamicSize;
} ScdElf;


uintptr_t ScdElfGetLoadBias(const ScdElf *elf);
TraStatus ScdElfStep(ScdElf *elf, uintptr_t pc, ScdRegs *regs, bool isFirstStack);
size_t ScdElfGetFdeNum(const ScdElf *elf);
void ScdElfGetFunctionInfo(ScdElf *elf, uintptr_t pc, char *funcName, size_t len, size_t *funcOffset);

TraStatus ScdElfLoad(ScdElf *elf, int32_t pid, ScdMemory *memory);
TraStatus ScdElfInit(ScdElf *elf);
void ScdElfUninit(ScdElf *elf);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif