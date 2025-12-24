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

#include <pthread.h>
#include "securec.h"
#include "trace_system_api.h"
#include "stacktrace_unwind.h"
#include "stacktrace_unwind_instr.h"
#include "stacktrace_unwind_inner.h"
#include "stacktrace_safe_recorder.h"
#include "scd_dwarf.h"
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

typedef struct TraceEhFrameFde {
    uint32_t fdeLengh;
    uint32_t cieOffset;
    uint8_t pcBegin[16];
} TraceEhFrameFde;

typedef struct TraceEhFrameCie {
    uint32_t cieLengh;       /* the length of CIE excpet itself */
    uint32_t cieId;          /* the ID of CIE  0 */
    uint8_t version;         /* the version of CIE */
    int8_t augmentation[15]; /* the string of cAugmentation */
} TraceEhFrameCie;

typedef struct FdeEntry {
    int32_t initLocOffset;
    int32_t fdeTableOffset;
} FdeEntry;
extern "C" {
    TraStatus TraceParseFrameHdrAddr(ScdDwarf *dwarf, TraceUnwindEhFrameHdrInfo *ehFrameHdrInfo);
    TraStatus TraceParseCie(ScdDwarf *dwarf, uintptr_t CIEAddr, TraceAddrRange* initIns, TraceFrameRegStateInfo *frameRegState);
    TraStatus TraceParseFde(ScdDwarf *dwarf, uintptr_t FDEAddr, TraceFrameRegStateInfo *frameRegState, TraceAddrRange* initIns,
        TraceAddrRange* ins);
    void CallStackRegUpdate(ScdDwarf *dwarf, uint32_t uiIndex, ScdRegs *pstCoreRegsOld, ScdRegs *pstCoreRegs,
        uintptr_t uvCFAAddr, TraceStagRegInfo *pstRegInfo, ScdDwarfStepArgs *pstStackLimit);
    TraStatus TraceUnwinRegUpdate(ScdDwarf *dwarf, TraceFrameRegStateInfo *frameRegState,
        ScdRegs *coreRegArray, ScdDwarfStepArgs *stackAddr);
    FdeEntry *TraceSearchFdeOffsetTable(uintptr_t enFrameAddr, uintptr_t uvTblStatAddr, uintptr_t pc);
}

class TraceUnwindUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        ScdMemoryInitLocal(&memory);
        dwarf.memory = &memory;
        memory.data = NULL;
        memory.size = UINT32_MAX;
        dwarf.ehFrameHdrOffset = 0;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
    ScdMemory memory;
    ScdDwarf dwarf;
};

TEST_F(TraceUnwindUtest, TestTraceStackUnwind_failed)
{
    TraStatus ret = TRACE_FAILURE;
    ThreadArgument arg = { 0 };
    TraceStackInfo info = { 0 };
    uintptr_t regs[TRACE_CORE_REG_NUM] = { 0 };

    // arg==NULL
    ret = TraceStackUnwind(NULL, regs, TRACE_CORE_REG_NUM, &info);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // stackInfo==NULL
    ret = TraceStackUnwind(&arg, regs, TRACE_CORE_REG_NUM, NULL);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // regs==NULL
    ret = TraceStackUnwind(&arg, NULL, TRACE_CORE_REG_NUM, &info);
    EXPECT_EQ(TRACE_FAILURE, ret);

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    ret = TraceStackUnwind(&arg, regs, TRACE_CORE_REG_NUM, &info);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceUnwindUtest, TestTraceGetStackBaseAddrLibc_failed)
{
    TraStatus ret = TRACE_FAILURE;
    ThreadArgument arg = { 0 };
    TraceStackInfo info = { 0 };
    uintptr_t regs[TRACE_CORE_REG_NUM] = { 0 };
    MOCKER(pthread_getattr_np).stubs().will(returnValue(-1));

    ret = TraceStackUnwind(&arg, regs, TRACE_CORE_REG_NUM, &info);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceUnwindUtest, TestTraceParseFrameHdrAddr)
{
    uint8_t version = 0;
    uint8_t data[64] = { 0 };
    TraceUnwindEhFrameHdrInfo info = {0};
    uint8_t addr = 1;

    // invalid version
    version = 0;
    data[0] = version;
    memory.data = (uintptr_t)&data[0];
    MOCKER(TraceReadEncodeValue).expects(never());
    TraceParseFrameHdrAddr(&dwarf, &info);
    EXPECT_EQ(version, info.ucVersion);
    GlobalMockObject::verify();

    MOCKER(memcpy_s).stubs().will(returnValue(TRACE_FAILURE));
    data[0] = 1;
    EXPECT_EQ(TraceParseFrameHdrAddr(&dwarf, &info), TRACE_FAILURE);
    GlobalMockObject::verify();
}

TEST_F(TraceUnwindUtest, TestTraceParseFDE)
{
    TraceEhFrameFde stFDEHeadInfo = { 0 };
    uintptr_t addr = (uintptr_t)&stFDEHeadInfo;
    TraceAddrRange range = { 0 };
    TraceFrameRegStateInfo regState = { 0 };
    const uint8_t *mockerPtr = 0;
    TraStatus ret = TRACE_FAILURE;

    MOCKER(TraceParseCie).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(TraceReadEncodeValue).stubs().will(returnValue(mockerPtr));
    ret = TraceParseFde(&dwarf, addr, &regState, &range, &range);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    regState.flag = 1;
    MOCKER(TraceParseCie).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(TraceReadEncodeValue).stubs().will(returnValue(mockerPtr));
    ret = TraceParseFde(&dwarf, addr, &regState, &range, &range);
    EXPECT_EQ(TRACE_FAILURE, ret);
    
    GlobalMockObject::verify();

    MOCKER(TraceParseCie).stubs().will(returnValue(TRACE_FAILURE));
    ret = TraceParseFde(&dwarf, addr, &regState, &range, &range);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceUnwindUtest, TestTraceParseCIEStrcpyFailed)
{
    TraceEhFrameCie ehFrameCIEHdr = {0};
    uintptr_t addr = (uintptr_t)&ehFrameCIEHdr;
    TraceAddrRange range = {0};
    TraceFrameRegStateInfo regState = {0};

    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    MOCKER(TraceReadUleb128).expects(never());

    TraceParseCie(&dwarf, addr, &range, &regState);
    EXPECT_EQ(range.start, 0);
    EXPECT_EQ(range.end, 0);
}

TEST_F(TraceUnwindUtest, TestTraceParseCIEEh)
{
    TraceEhFrameCie ehFrameCIEHdr = {0};
    uintptr_t addr = (uintptr_t)&ehFrameCIEHdr;
    uint8_t data[4] = { 0 };
    dwarf.memory->data = addr;
    TraceAddrRange range = {0};
    TraceFrameRegStateInfo regState = {0};

    ehFrameCIEHdr.augmentation[0] = 'e';
    ehFrameCIEHdr.augmentation[1] = 'h';
    MOCKER(TraceReadUleb128).stubs().will(returnValue((const uint8_t *)&data[0]));
    MOCKER(TraceReadLeb128).stubs().will(returnValue((const uint8_t *)&data[0]));

    TraceParseCie(&dwarf, addr, &range, &regState);
    EXPECT_EQ((uintptr_t)&data[0], range.start);
    EXPECT_EQ((uintptr_t)(addr + ehFrameCIEHdr.cieLengh + sizeof(uint32_t)), range.end);
}

TEST_F(TraceUnwindUtest, TestTraceParseCIE)
{
    TraceEhFrameCie ehFrameCIEHdr = {0};
    uintptr_t addr = (uintptr_t)&ehFrameCIEHdr;
    uint8_t data[4] = { 0 };
    dwarf.memory->data = addr;
    TraceAddrRange range = {0};
    TraceFrameRegStateInfo regState = {0};

    ehFrameCIEHdr.augmentation[0] = 'R';
    MOCKER(TraceReadUleb128).stubs().will(returnValue((const uint8_t *)&data[0]));
    MOCKER(TraceReadLeb128).stubs().will(returnValue((const uint8_t *)&data[0]));

    TraceParseCie(&dwarf, addr, &range, &regState);
    EXPECT_NE(0, range.start);
    EXPECT_EQ((uintptr_t)(addr + ehFrameCIEHdr.cieLengh + sizeof(uint32_t)), range.end);

    ehFrameCIEHdr.augmentation[0] = 'S';
    EXPECT_EQ(TraceParseCie(&dwarf, addr, &range, &regState), TRACE_FAILURE);
}

TEST_F(TraceUnwindUtest, TestTraceUnwinRegUpdate)
{
    TraceFrameRegStateInfo regState = {0};
    ScdRegs regArr = {0};
    ScdDwarfStepArgs args = {0};
    TraStatus ret = TRACE_FAILURE;

    // case VOS_CFA_EXP
    regState.frameStateInfo.cfaHow = VOS_CFA_EXP;
    uintptr_t mockResult = 0; // invalid stack addr
    MOCKER(TraceReadUleb128).stubs()
        .will(returnValue((const uint8_t *)0))
        .then(returnValue((const uint8_t *)1))
        .then(returnValue((const uint8_t *)0));
    MOCKER(TraceStackOpExc).stubs().with(any(), any(), any(), any(), outBoundP(&mockResult, sizeof(uintptr_t *)), any(), any())
        .will(returnValue((int32_t)0));
    ret = TraceUnwinRegUpdate(&dwarf, &regState, &regArr, &args);
    EXPECT_EQ(TRACE_FAILURE, ret);
    ret = TraceUnwinRegUpdate(&dwarf, &regState, &regArr, &args);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // case VOS_CFA_UNSET
    regState.frameStateInfo.cfaHow = VOS_CFA_UNSET;
    ret = TraceUnwinRegUpdate(&dwarf, &regState, &regArr, &args);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceUnwindUtest, TestCallStackRegUpdate)
{
    uint32_t index = 0;
    ScdRegs oldRegArr = {0};
    ScdRegs regArr = {0};
    uintptr_t cfaAddr = 0;
    TraceStagRegInfo regInfo = {0};
    ScdDwarfStepArgs args = {0};
    uintptr_t expResult = 0;
    uintptr_t mockResult = 0;
    TraStatus ret = TRACE_FAILURE;

    // case REG_UNSAVED
    regInfo.regHow = REG_UNSAVED;
    CallStackRegUpdate(&dwarf, index, &oldRegArr, &regArr, cfaAddr, &regInfo, &args);
    EXPECT_EQ(0, regArr.r[index & REG_VAILD_MASK]);
    // case REG_UNDEFINED
    regInfo.regHow = REG_UNDEFINED;
    CallStackRegUpdate(&dwarf, index, &oldRegArr, &regArr, cfaAddr, &regInfo, &args);
    EXPECT_EQ(0, regArr.r[index & REG_VAILD_MASK]);

    // case REG_UNSAVED
    regInfo.regHow = REG_UNSAVED;
    CallStackRegUpdate(&dwarf, index, &oldRegArr, &regArr, cfaAddr, &regInfo, &args);
    EXPECT_EQ(0, regArr.r[index & REG_VAILD_MASK]); // invalid addr

    // case REG_SAVED_VAL_OFFSET
    regInfo.regHow = REG_SAVED_VAL_OFFSET;
    intptr_t sOffset = 0x10;
    regInfo.regLoc.offset = sOffset;
    cfaAddr = 0x08;
    index = 0;
    CallStackRegUpdate(&dwarf, index, &oldRegArr, &regArr, cfaAddr, &regInfo, &args);
    EXPECT_EQ(cfaAddr + sOffset, regArr.r[index & REG_VAILD_MASK]);

    // case REG_SAVED_REG
    regInfo.regHow = REG_SAVED_REG;
    uintptr_t regNum = 0x02;
    expResult = 0x08;
    regInfo.regLoc.reg = regNum;
    oldRegArr.r[regNum & REG_VAILD_MASK] = expResult;
    index = 0;
    CallStackRegUpdate(&dwarf, index, &oldRegArr, &regArr, cfaAddr, &regInfo, &args);
    EXPECT_EQ(expResult, regArr.r[index & REG_VAILD_MASK]);

    // case REG_SAVED_EXP
    expResult = 0x10;
    regInfo.regHow = REG_SAVED_EXP;
    uintptr_t data[2] = { expResult, 0 };
    index = 0;
    mockResult = (uintptr_t)&data[0];
    MOCKER(TraceReadUleb128).stubs().will(returnValue((const uint8_t *)1));
    MOCKER(TraceStackOpExc).stubs().with(any(), any(), any(), any(), outBoundP(&mockResult, sizeof(uintptr_t *)), any(), any())
        .will(returnValue((int32_t)0));
    CallStackRegUpdate(&dwarf, index, &oldRegArr, &regArr, cfaAddr, &regInfo, &args);
    EXPECT_EQ(expResult, regArr.r[index & REG_VAILD_MASK]);
    GlobalMockObject::verify();

    index = 0;
    expResult = regArr.r[index & REG_VAILD_MASK];
    mockResult = 0; // invalid result
    MOCKER(TraceReadUleb128).stubs().will(returnValue((const uint8_t *)1));
    MOCKER(TraceStackOpExc).stubs().with(any(), any(), any(), any(), outBoundP(&mockResult, sizeof(uintptr_t *)), any(), any())
        .will(returnValue((int32_t)0));
    CallStackRegUpdate(&dwarf, index, &oldRegArr, &regArr, cfaAddr, &regInfo, &args);
    EXPECT_EQ(expResult, regArr.r[index & REG_VAILD_MASK]);
    GlobalMockObject::verify();

    // case REG_SAVED_VAL_EXP
    regInfo.regHow = REG_SAVED_VAL_EXP;
    expResult = 0x12;
    mockResult = expResult;
    index = 0;
    MOCKER(TraceReadUleb128).stubs().will(returnValue((const uint8_t *)1));
    MOCKER(TraceStackOpExc).stubs().with(any(), any(), any(), any(), outBoundP(&mockResult, sizeof(uintptr_t *)), any(), any())
        .will(returnValue((int32_t)0));
    CallStackRegUpdate(&dwarf, index, &oldRegArr, &regArr, cfaAddr, &regInfo, &args);
    EXPECT_EQ(expResult, regArr.r[index & REG_VAILD_MASK]);
    GlobalMockObject::verify();
}

TEST_F(TraceUnwindUtest, TestTraceSearchFdeOffsetTable)
{
    // test pc eq left value of pc range
    uintptr_t pc = 0xffff00000000;
    uintptr_t pcOffset = 0x0000;
    dwarf.memory->data = pc - pcOffset;
    dwarf.fdeCount = 100;
    FdeEntry fdeItem[100];
    uintptr_t uvTblStatAddr = (uintptr_t)&fdeItem;
    for (int i = 1; i < dwarf.fdeCount; i++) {
        fdeItem[i].initLocOffset = fdeItem[i - 1].initLocOffset + 0x18;
    }

    for (int i = 1; i < dwarf.fdeCount; i++) {
        pc = (uintptr_t)dwarf.memory->data + fdeItem[i].initLocOffset - 1;
        EXPECT_EQ(TraceSearchFdeOffsetTable((uintptr_t)&dwarf, uvTblStatAddr, pc), &fdeItem[i - 1]);
        pc = (uintptr_t)dwarf.memory->data + fdeItem[i].initLocOffset;
#ifdef __x86_64__
        EXPECT_EQ(TraceSearchFdeOffsetTable((uintptr_t)&dwarf, uvTblStatAddr, pc), &fdeItem[i]);
#else
        EXPECT_EQ(TraceSearchFdeOffsetTable((uintptr_t)&dwarf, uvTblStatAddr, pc), &fdeItem[i - 1]);
#endif

        pc = (uintptr_t)dwarf.memory->data + fdeItem[i].initLocOffset + 1;
        EXPECT_EQ(TraceSearchFdeOffsetTable((uintptr_t)&dwarf, uvTblStatAddr, pc), &fdeItem[i]);
    }
}