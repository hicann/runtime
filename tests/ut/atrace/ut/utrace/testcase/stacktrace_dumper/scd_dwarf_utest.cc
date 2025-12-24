/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "scd_dl.h"
#include "scd_maps.h"
#include "scd_dwarf.h"
#include "adiag_utils.h"
#include <elf.h>
#include <link.h>
#include "stacktrace_unwind_instr.h"

extern "C" {
    typedef struct FDECtrlBlock {
        uintptr_t funcStart;
        void *unwindEntryAddr;
    } FDECtrlBlock;
    // FDE entry in the binary search table
    typedef struct FdeEntry {
        int32_t initLocOffset;    // location addr offset relative to eh_frame_hdr addr
        int32_t fdeTableOffset;
    } FdeEntry;
    typedef struct TraceUnwindEhFrameHdrInfo {
        uint8_t ucVersion;       /* the version of eh_frame_hdr always 1 */
        uint8_t ucEhframeptrEnc; /* the encode type of eh_frame_hdr */
        uint8_t ucFDECountEnc;   /* the encode type of FDE count */
        uint8_t ucTabEnc;        /* the encode type of table */
        uint8_t ucSearchTblFlag; /* the flag of table present 1:present 0:no present */
        uint8_t ucReserved[3];   /* the reserved */
        uintptr_t uvFrameAddr;   /* the start of frame */
        size_t uvFDECount;     /* the num of FDE */
        uintptr_t uvTblStatAddr; /* the table addr */
    } TraceUnwindEhFrameHdrInfo;
    TraStatus TraceGetEhFrameHdrAddr(uintptr_t pc, ScdDwarf *dwarf);
    TraStatus TraceParseFrameHdrAddr(uintptr_t ehFrameHdrAddr, TraceUnwindEhFrameHdrInfo *ehFrameHdrInfo);
    TraStatus TraceParseFde(ScdDwarf *dwarf, uintptr_t fdeAddr, TraceFrameRegStateInfo *frameRegState, TraceAddrRange* initIns,
        TraceAddrRange* ins);
    FdeEntry *TraceSearchFdeOffsetTable(ScdDwarf *dwarf, uintptr_t uvTblStatAddr, uintptr_t pc);
    TraStatus TraceCallstackParse(ScdDwarf *dwarf, uintptr_t pc, const ScdDwarfStepArgs *args,
        ScdRegs *regs, TraceFrameRegStateInfo *frameRegState, FDECtrlBlock *ctrlBlock);
    TraStatus TraceUnwinRegUpdate(ScdDwarf *dwarf, TraceFrameRegStateInfo *frameRegState, ScdRegs *regs, const ScdDwarfStepArgs *args);
}

class ScdDwarfUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        dwarf.memory = &memory;
        ScdMemoryInitLocal(&memory);
        system("rm -rf " LLT_TEST_DIR "/*");
        system("mkdir -p " LLT_TEST_DIR );
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
    ScdDwarf dwarf;
    ScdMemory memory;
};

TEST_F(ScdDwarfUtest, TestScdDwarfStep)
{
    ScdRegs regs;
    ScdDwarfStepArgs args;
    uintptr_t pc;
    uintptr_t nextPc;
    TraceUnwindEhFrameHdrInfo ehFrameHdrInfo;
    MOCKER(TraceGetEhFrameHdrAddr).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(TraceParseFrameHdrAddr)
        .stubs()
        .will(returnValue(TRACE_FAILURE))
        .then(returnValue(TRACE_SUCCESS));
    EXPECT_EQ(ScdDwarfStep(&dwarf, &regs, &args, pc, &nextPc), TRACE_FAILURE);
    EXPECT_EQ(ScdDwarfStep(&dwarf, &regs, &args, pc, &nextPc), TRACE_FAILURE);
    GlobalMockObject::verify();
    MOCKER(TraceGetEhFrameHdrAddr).stubs().will(returnValue(TRACE_SUCCESS));
    ehFrameHdrInfo.ucSearchTblFlag = 1;
    MOCKER(TraceParseFrameHdrAddr)
        .stubs()
        .with(any(), outBoundP(&ehFrameHdrInfo, sizeof(TraceUnwindEhFrameHdrInfo *)))
        .will(returnValue(TRACE_SUCCESS));
    FdeEntry entry = {1, 1};
    MOCKER(TraceSearchFdeOffsetTable)
        .stubs()
        .will(returnValue(&entry));
    MOCKER(TraceCallstackParse)
        .stubs()
        .will(returnValue(TRACE_FAILURE));        
    EXPECT_EQ(ScdDwarfStep(&dwarf, &regs, &args, pc, &nextPc), TRACE_FAILURE);
    EXPECT_EQ(ScdDwarfStep(&dwarf, &regs, &args, pc, &nextPc), TRACE_FAILURE);
    EXPECT_EQ(ScdDwarfStep(&dwarf, &regs, &args, pc, &nextPc), TRACE_FAILURE);
}

TEST_F(ScdDwarfUtest, TestTraceCallstackParse)
{
    uintptr_t pc = 5;
    ScdDwarfStepArgs args;
    FDECtrlBlock ctrlBlock;
    ScdRegs regs;
    TraceFrameRegStateInfo frameRegState;
    frameRegState.pc = 1;
    frameRegState.range = 2;
    MOCKER(TraceParseFde)
        .stubs()
        .with(any(), any(), outBoundP(&frameRegState, sizeof(TraceFrameRegStateInfo *)), any(), any())
        .will(returnValue(TRACE_SUCCESS));
    EXPECT_EQ(TraceCallstackParse(&dwarf, pc, &args, &regs, &frameRegState, &ctrlBlock), TRACE_FAILURE);
    GlobalMockObject::verify();

    frameRegState.pc = 4;
    frameRegState.range = 2;
    MOCKER(TraceParseFde)
        .stubs()
        .with(any(), any(), outBoundP(&frameRegState, sizeof(TraceFrameRegStateInfo *)), any(), any())
        .will(returnValue(TRACE_FAILURE))
        .then(returnValue(TRACE_SUCCESS));

    MOCKER(TraceUnwindParseFn)
        .stubs()
        .will(returnValue(TRACE_FAILURE))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE))
        .then(returnValue(TRACE_SUCCESS));
    MOCKER(TraceUnwinRegUpdate).stubs().will(returnValue(TRACE_FAILURE)).then(returnValue(TRACE_SUCCESS));
    EXPECT_EQ(TraceCallstackParse(&dwarf, pc, &args, &regs, &frameRegState, &ctrlBlock), TRACE_FAILURE);
    EXPECT_EQ(TraceCallstackParse(&dwarf, pc, &args, &regs, &frameRegState, &ctrlBlock), TRACE_FAILURE);
    EXPECT_EQ(TraceCallstackParse(&dwarf, pc, &args, &regs, &frameRegState, &ctrlBlock), TRACE_FAILURE);
    EXPECT_EQ(TraceCallstackParse(&dwarf, pc, &args, &regs, &frameRegState, &ctrlBlock), TRACE_FAILURE);
}