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

#include "stacktrace_unwind_instr.h"
#include "stacktrace_unwind_inner.h"
#include "atrace_types.h"

#define VOS_ERRNO_URC_FAILURE (-1)
extern "C" {
    TraStatus TraceOpStackTwoDataParseBasic(uint8_t enOpType, uintptr_t uvSwapTmp1,
        uintptr_t uvSwapTmp2, uintptr_t *puvResult);
    const uint8_t *TraceOpStackOneDataParse(ScdDwarf *dwarf, uint8_t enOpType, uintptr_t uvTmpRes,
        const uint8_t *pucInsAddr, const ScdDwarfStepArgs *pstStackLimit, uintptr_t *puvResult);
    const uint8_t *TraceOpStackDataOpt(uint8_t enOpType, uintptr_t auvStackContent[VOS_OP_STACK_DEPTH],
        uint32_t *puiIndex, const uint8_t *pucInsAddr, uintptr_t *puvResult);
    const uint8_t *TraceOpConstNumGet(ScdDwarf *dwarf, uint8_t enOpType, const uint8_t *pucInsAddr, uintptr_t *puvResult);
    TraStatus TraceOpStackTwoDataOpt(uint8_t enOpType, uintptr_t auvStackContent[VOS_OP_STACK_DEPTH],
                                uint32_t *puiIndex, uintptr_t *puvResult);
    const uint8_t *TraceOpStackOneDataOpt(ScdDwarf *dwarf, uint8_t enOpType, uintptr_t auvStackContent[VOS_OP_STACK_DEPTH],
        uint32_t *puiIndex, const uint8_t *pucInsAddr, const ScdDwarfStepArgs *pstStackLimit,
        uintptr_t *puvResult);
    const uint8_t *TraceUnwindRegDefParse(ScdDwarf *dwarf,uint8_t ucOpcode, const uint8_t *pucInstr, TraceFrameRegStateInfo *pstInfo);
    const uint8_t *TraceUnwindOpcodeParse(ScdDwarf *dwarf,uint8_t ucOpcode, const uint8_t *pucInstr,
        TraceFrameRegStateInfo *pstFrameRInfo);
    const uint8_t *TraceUnwindPCLocParse(ScdDwarf *dwarf,uint8_t ucOpcode, const uint8_t *pucInstr,
        TraceFrameRegStateInfo *pstFrameRInfo);
    const uint8_t *TraceUnwindCFADefParse(ScdDwarf *dwarf,uint8_t ucOpcode, const uint8_t *pucInstr,
        TraceFrameRegStateInfo *pstFrameRInfo);
    const uint8_t *TraceUnwindRegValueDefParse(ScdDwarf *dwarf,uint8_t ucOpcode, const uint8_t *pucInstr,
        TraceFrameRegStateInfo *pstFrameRInfo);
    const uint8_t *TraceUnwindOtherCodeParse(ScdDwarf *dwarf,uint8_t ucOpcode, const uint8_t *pucInstr,
        TraceFrameStateInfo *pstStoreFrameRegState, TraceFrameRegStateInfo *pstFrameRInfo);
}

class StackTraceUnwindInstrUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        ScdMemoryInitRemote(&memory);
        ScdMemoryInitLocal(&memory);
        dwarf.memory = &memory;
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

#define LOG_EXPECT_EQ(X, Y, msg, ...) do {  \
    if ((X) != (Y)) {                       \
        printf(msg "\n", ##__VA_ARGS__);    \
    }                                       \
    EXPECT_EQ((X), (Y));                    \
} while (0)

TEST_F(StackTraceUnwindInstrUtest, TestTraceUnwindOpcodeParse)
{
    uint8_t opCode = 0;
    uint8_t data[4] = { 0 };
    const uint8_t *instr = &data[0];
    const uint8_t *mockValue = &data[1];
    TraceFrameRegStateInfo regInfo = { 0 };
    const uint8_t *ret = NULL;

    // case DW_CFA_ADVANCE_LOC
    opCode = 0x40;
    ret = TraceUnwindOpcodeParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(instr, ret);

    // case DW_CFA_OFFSET
    opCode = 0x80;
    MOCKER(TraceReadUleb128).expects(once()).will(returnValue(mockValue));
    ret = TraceUnwindOpcodeParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue, ret);
    GlobalMockObject::verify();

    // case DW_CFA_RESTORE
    opCode = 0xc0;
    ret = TraceUnwindOpcodeParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(instr, ret);
    GlobalMockObject::verify();

    // default
    opCode = 0x00;
    ret = TraceUnwindOpcodeParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(NULL, ret);
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceUnwindPCLocParse)
{
    uint8_t opCode = 0;
    uint8_t data[4] = { 0 };
    const uint8_t *instr = &data[0];
    const uint8_t *mockValue = &data[1];
    TraceFrameRegStateInfo regInfo = { 0 };
    const uint8_t *ret = NULL;

    // case DW_CFA_SET_LOC
    opCode = DW_CFA_SET_LOC;
    MOCKER(TraceReadEncodeValue).expects(once()).will(returnValue((const uint8_t *)0));
    ret = TraceUnwindPCLocParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(NULL, ret);
    GlobalMockObject::verify();
    MOCKER(TraceReadEncodeValue).expects(once()).then(returnValue(mockValue));
    ret = TraceUnwindPCLocParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue, ret);
    GlobalMockObject::verify();

    // case DW_CFA_ADVANCE_LOC1
    opCode = DW_CFA_ADVANCE_LOC1;
    ret = TraceUnwindPCLocParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(instr + sizeof(uint8_t), ret);

    // case DW_CFA_ADVANCE_LOC2
    opCode = DW_CFA_ADVANCE_LOC2;
    ret = TraceUnwindPCLocParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(instr + sizeof(uint16_t), ret);

    // case DW_CFA_ADVANCE_LOC4
    opCode = DW_CFA_ADVANCE_LOC4;
    ret = TraceUnwindPCLocParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(instr + sizeof(uint32_t), ret);

    // default
    opCode = 0x00;
    ret = TraceUnwindPCLocParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(NULL, ret);
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceUnwindCFADefParse)
{
    uint8_t opCode = 0;
    uint8_t data[4] = { 0 };
    const uint8_t *instr = &data[0];
    const uint8_t *mockValue = &data[1];
    TraceFrameRegStateInfo regInfo = { 0 };
    uintptr_t offset = 10;
    const uint8_t *ret = NULL;

    // case DW_CFA_DEF_CFA
    opCode = DW_CFA_DEF_CFA;
    MOCKER(TraceReadUleb128).expects(exactly(2)).will(returnValue(mockValue)).then(returnValue(mockValue + 1));
    ret = TraceUnwindCFADefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue + 1, ret);
    GlobalMockObject::verify();

    // case DW_CFA_DEF_CFA_SF
    opCode = DW_CFA_DEF_CFA_SF;
    MOCKER(TraceReadUleb128).expects(once()).will(returnValue(mockValue));
    MOCKER(TraceReadLeb128).expects(once()).will(returnValue(mockValue + 1));
    ret = TraceUnwindCFADefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue + 1, ret);
    GlobalMockObject::verify();

    // case DW_CFA_DEF_CFA_REGISTER
    opCode = DW_CFA_DEF_CFA_REGISTER;
    MOCKER(TraceReadUleb128).expects(once()).will(returnValue(mockValue));
    ret = TraceUnwindCFADefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue, ret);
    GlobalMockObject::verify();

    // case DW_CFA_DEF_CFA_OFFSET
    opCode = DW_CFA_DEF_CFA_OFFSET;
    MOCKER(TraceReadUleb128).expects(once()).will(returnValue(mockValue));
    ret = TraceUnwindCFADefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue, ret);
    GlobalMockObject::verify();

    // case DW_CFA_DEF_CFA_OFFSET_SF
    opCode = DW_CFA_DEF_CFA_OFFSET_SF;
    MOCKER(TraceReadLeb128).expects(once()).will(returnValue(mockValue + 1));
    ret = TraceUnwindCFADefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue + 1, ret);
    GlobalMockObject::verify();

    // case DW_CFA_DEF_CFA_EXPRESSION
    opCode = DW_CFA_DEF_CFA_EXPRESSION;
    MOCKER(TraceReadUleb128).stubs().with(any(), any(), outBoundP(&offset, sizeof(uintptr_t *)))
                            .will(returnValue(mockValue));
    ret = TraceUnwindCFADefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue + offset, ret);
    GlobalMockObject::verify();

    // default
    opCode = 0x00;
    ret = TraceUnwindCFADefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(NULL, ret);
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceUnwindRegValueDefParse)
{
    uint8_t opCode = 0;
    uint8_t data[4] = { 0 };
    const uint8_t *instr = &data[0];
    const uint8_t *mockValue = &data[1];
    TraceFrameRegStateInfo regInfo = { 0 };
    uintptr_t offset = 10;
    const uint8_t *ret = NULL;

    // case DW_CFA_VAL_OFFSET
    opCode = DW_CFA_VAL_OFFSET;
    MOCKER(TraceReadUleb128).expects(exactly(2)).will(returnValue(mockValue)).then(returnValue(mockValue + 1));
    ret = TraceUnwindRegValueDefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue + 1, ret);
    GlobalMockObject::verify();

    // case DW_CFA_VAL_OFFSET_SF
    opCode = DW_CFA_VAL_OFFSET_SF;
    MOCKER(TraceReadUleb128).expects(once()).will(returnValue(mockValue));
    MOCKER(TraceReadLeb128).expects(once()).will(returnValue(mockValue + 1));
    ret = TraceUnwindRegValueDefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue + 1, ret);
    GlobalMockObject::verify();

    // case DW_CFA_VAL_EXPRESSION
    opCode = DW_CFA_VAL_EXPRESSION;
    MOCKER(TraceReadUleb128).stubs().with(any(), any(), outBoundP(&offset, sizeof(uintptr_t *)))
        .will(returnValue(mockValue)).then(returnValue(mockValue + 1));
    ret = TraceUnwindRegValueDefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(mockValue + 1 + offset, ret);
    GlobalMockObject::verify();

    // default
    opCode = 0x00;
    ret = TraceUnwindRegValueDefParse(&dwarf, opCode, instr, &regInfo);
    EXPECT_EQ(NULL, ret);
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceUnwindOtherCodeParse)
{
    uint8_t opCode = 0;
    uint8_t data[4] = { 0 };
    const uint8_t *instr = &data[0];
    const uint8_t *mockValue = &data[1];
    TraceFrameStateInfo info = { 0 };
    TraceFrameRegStateInfo regInfo = { 0 };
    uintptr_t offset = 10;
    const uint8_t *ret = NULL;

    // case DW_CFA_NOP
    opCode = DW_CFA_NOP;
    ret = TraceUnwindOtherCodeParse(&dwarf, opCode, instr, &info, &regInfo);
    EXPECT_EQ(instr, ret);

    // case DW_CFA_REMEMBER_STATE
    opCode = DW_CFA_REMEMBER_STATE;
    ret = TraceUnwindOtherCodeParse(&dwarf, opCode, instr, &info, &regInfo);
    EXPECT_EQ(instr, ret);

    // case DW_CFA_RESTORE_STATE
    opCode = DW_CFA_RESTORE_STATE;
    ret = TraceUnwindOtherCodeParse(&dwarf, opCode, instr, &info, &regInfo);
    EXPECT_EQ(instr, ret);

    // case DW_CFA_GNU_WIN_SAVE
    opCode = DW_CFA_GNU_WIN_SAVE;
    ret = TraceUnwindOtherCodeParse(&dwarf, opCode, instr, &info, &regInfo);
    EXPECT_EQ(instr, ret);

    // case DW_CFA_GNU_ARG_SIZE
    opCode = DW_CFA_GNU_ARG_SIZE;
    MOCKER(TraceReadUleb128).stubs().will(returnValue(mockValue));
    ret = TraceUnwindOtherCodeParse(&dwarf, opCode, instr, &info, &regInfo);
    EXPECT_EQ(mockValue, ret);
    GlobalMockObject::verify();

    // default
    opCode = 0xFF;
    ret = TraceUnwindOtherCodeParse(&dwarf, opCode, instr, &info, &regInfo);
    EXPECT_EQ(NULL, ret);
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceUnwindRegDefParse)
{
    uint8_t data[4] = { 0 };
    const uint8_t *instr = &data[0];
    const uint8_t *mockValue = &data[1];
    TraceFrameRegStateInfo regInfo = { 0 };
    uintptr_t offset = 10;
    const uint8_t *ret = NULL;

    for (uint8_t opCode = 0x00; opCode < 0xFF - 1; opCode++) {
        // case DW_CFA_OFFSET_EXTENDED
        if (opCode == DW_CFA_OFFSET_EXTENDED) {
            MOCKER(TraceReadUleb128).expects(exactly(2)).will(returnValue(mockValue)).then(returnValue(mockValue + 1));
            ret = TraceUnwindRegDefParse(&dwarf, opCode, instr, &regInfo);
            EXPECT_EQ(mockValue + 1, ret);
            GlobalMockObject::verify();
            continue;
        }

        // case DW_CFA_OFF_EXTENDED_SF
        if (opCode == DW_CFA_OFF_EXTENDED_SF) {
            MOCKER(TraceReadUleb128).expects(once()).will(returnValue(mockValue));
            MOCKER(TraceReadLeb128).expects(once()).will(returnValue(mockValue + 1));
            ret = TraceUnwindRegDefParse(&dwarf, opCode, instr, &regInfo);
            EXPECT_EQ(mockValue + 1, ret);
            GlobalMockObject::verify();
            continue;
        }

        // case DW_CFA_GNU_NEG_OFF_EXT
        if (opCode == DW_CFA_GNU_NEG_OFF_EXT) {
            MOCKER(TraceReadUleb128).expects(exactly(2)).will(returnValue(mockValue)).then(returnValue(mockValue + 1));
            ret = TraceUnwindRegDefParse(&dwarf, opCode, instr, &regInfo);
            EXPECT_EQ(mockValue + 1, ret);
            GlobalMockObject::verify();
            continue;
        }

        // case DW_CFA_SAME_VALUE
        if (opCode == DW_CFA_SAME_VALUE) {
            MOCKER(TraceReadUleb128).expects(once()).will(returnValue(mockValue));
            ret = TraceUnwindRegDefParse(&dwarf, opCode, instr, &regInfo);
            EXPECT_EQ(mockValue, ret);
            GlobalMockObject::verify();
            continue;
        }

        // case DW_CFA_RESTORE_EXTENDED
        if (opCode == DW_CFA_RESTORE_EXTENDED) {
            MOCKER(TraceReadUleb128).expects(once()).will(returnValue(mockValue));
            ret = TraceUnwindRegDefParse(&dwarf, opCode, instr, &regInfo);
            EXPECT_EQ(mockValue, ret);
            GlobalMockObject::verify();
            continue;
        }

        // case DW_CFA_UNDEFINED
        if (opCode == DW_CFA_UNDEFINED) {
            MOCKER(TraceReadUleb128).expects(once()).will(returnValue(mockValue));
            ret = TraceUnwindRegDefParse(&dwarf, opCode, instr, &regInfo);
            EXPECT_EQ(mockValue, ret);
            GlobalMockObject::verify();
            continue;
        }

        // case DW_CFA_REGISTER
        if (opCode == DW_CFA_REGISTER) {
            MOCKER(TraceReadUleb128).expects(exactly(2)).will(returnValue(mockValue)).then(returnValue(mockValue + 1));
            ret = TraceUnwindRegDefParse(&dwarf, opCode, instr, &regInfo);
            EXPECT_EQ(mockValue + 1, ret);
            GlobalMockObject::verify();
            continue;
        }

        // case DW_CFA_EXPRESSION
        if (opCode == DW_CFA_EXPRESSION) {
            MOCKER(TraceReadUleb128).stubs().with(any(), any(), outBoundP(&offset, sizeof(uintptr_t *)))
                .will(returnValue(mockValue)).then(returnValue(mockValue + 1));
            ret = TraceUnwindRegDefParse(&dwarf, opCode, instr, &regInfo);
            EXPECT_EQ(mockValue + 1 + offset, ret);
            GlobalMockObject::verify();
            continue;
        }

        // default
        MOCKER(TraceReadUleb128).stubs().will(returnValue(mockValue));
        ret = TraceUnwindRegDefParse(&dwarf, opCode, instr, &regInfo);
        LOG_EXPECT_EQ((const uint8_t *)0, ret, "test TraceUnwindRegDefParse failed, opCode=0x%02hhx.", opCode);
        GlobalMockObject::verify();
    }
}

static void Mocker_TraceOpConstNumGet(uint8_t enOpType, const uint8_t *pucInsAddr, uintptr_t *puvResult)
{
    const uint8_t *mockValue = pucInsAddr;
    uintptr_t uOffset = 0x08;
    intptr_t sOffset = 0x12;
    const uint8_t *pucInsAddrTmp = pucInsAddr;
    uintptr_t *puvResultTmp = puvResult;

    switch (enOpType) {
        case DW_OP_COUST1U:
            *puvResultTmp = (uintptr_t)(*(uint8_t *)(uintptr_t)pucInsAddrTmp);
            break;
        case DW_OP_COUST1S:
            *puvResultTmp = (uintptr_t)(*(int8_t *)(uintptr_t)pucInsAddrTmp);
            break;
        case DW_OP_COUST2U:
            memcpy(puvResultTmp, pucInsAddrTmp, sizeof(uint16_t));
            break;
        case DW_OP_COUST2S:
            memcpy(puvResultTmp, pucInsAddrTmp, sizeof(int16_t));
            break;
        case DW_OP_COUST4U:
            memcpy(puvResultTmp, pucInsAddrTmp, sizeof(uint32_t));
            break;
        case DW_OP_COUST4S:
            memcpy(puvResultTmp, pucInsAddrTmp, sizeof(int32_t));
            break;
        case DW_OP_COUST8U:
            memcpy(puvResultTmp, pucInsAddrTmp, sizeof(uint64_t));
            break;
        case DW_OP_COUST8S:
            memcpy(puvResultTmp, pucInsAddrTmp, sizeof(int64_t));
            break;
        case DW_OP_COUSTU:
            MOCKER(TraceReadUleb128).stubs().with(any(), any(), outBoundP(&uOffset, sizeof(uintptr_t *)))
                .will(returnValue(mockValue));
            *puvResultTmp = uOffset;
            break;
        case DW_OP_COUSTS:
            MOCKER(TraceReadLeb128).stubs().with(any(), any(), outBoundP(&sOffset, sizeof(intptr_t *)))
                .will(returnValue(mockValue));
            *puvResultTmp = (uintptr_t)sOffset;
            break;
        default:
            *puvResultTmp = 0;
            return;
    }
    return;
}

const uint8_t *Mocker_TraceOpStackOtherOpt(uint8_t enOpType, const uintptr_t auvStackContent[VOS_OP_STACK_DEPTH],
    uint32_t *puiIndex, const uint8_t *pucInsAddr, const ScdRegs *pstCoreRegs, uintptr_t *puvResult)
{
    const uint8_t *mockValue = pucInsAddr;
    uintptr_t uOffset = 0x08;
    intptr_t sOffset = 0x12;
    const uint8_t *pucInsAddrTmp = pucInsAddr;
    uintptr_t uvTmpRes = 0;
    uint32_t  uiIdx = *puiIndex;

    switch (enOpType) {
        case DW_OP_REGX:
            MOCKER(TraceReadUleb128).stubs().with(any(), any(), outBoundP(&uOffset, sizeof(uintptr_t *)))
                .will(returnValue(mockValue));
            uvTmpRes = (uintptr_t)pstCoreRegs->r[uOffset & REG_VAILD_MASK];
            break;
        case DW_OP_BREGX:
            MOCKER(TraceReadUleb128).stubs().with(any(), any(), outBoundP(&uOffset, sizeof(uintptr_t *)))
                .will(returnValue(mockValue));
            MOCKER(TraceReadLeb128).stubs().with(any(), any(), outBoundP(&sOffset, sizeof(intptr_t *)))
                .will(returnValue(mockValue));
            uvTmpRes = pstCoreRegs->r[uOffset & REG_VAILD_MASK] + (uintptr_t)sOffset;
            break;
        case DW_OP_ADDR:
            memcpy(&uvTmpRes, pucInsAddrTmp, sizeof(uintptr_t));
            break;
        case DW_OP_GNU_ENC_ADDR:
            MOCKER(TraceReadEncodeValue).stubs().with(any(), any(), any(), outBoundP(&uOffset, sizeof(uintptr_t *)))
                .will(returnValue(mockValue));
            uvTmpRes = uOffset;
            break;
        case DW_OP_SKIP:
            break;
        case DW_OP_BRA:
            TRACE_STACK_INDEX_CHECK_RET(uiIdx, 1, { return NULL; });
            uiIdx  = uiIdx - 1;
            break;
        case DW_OP_NOP:
        default:
            break;
    }

    *puvResult = uvTmpRes;
    *puiIndex = uiIdx;

    return pucInsAddrTmp;
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceStackOpExc)
{
    uint8_t data[0xFF + 1] = { 0 };
    for (uint32_t i = 0x00; i <= 0xFF; i++) {
        data[i] = i;
    }
    const uint8_t *opStart = &data[0];
    const uint8_t *opEnd = &data[0xFF + 1];
    ScdRegs coreRegs = { 0 };
    uintptr_t result = 0;
    uintptr_t initial = 0x001234;
    ScdDwarfStepArgs args = { 0 };
    uint32_t ret = TRACE_FAILURE;

    // opStart == NULL
    ret = TraceStackOpExc(&dwarf, NULL, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // enOpType 0x00~0xFF
    uintptr_t exceptResult = 0;
    uint8_t enOpType = DW_OP_ADDR;
    for (uint32_t j = 0x00; j <= 0xFF; j++) {
        enOpType = data[j];
        opStart = &data[j];
        opEnd = &data[j + 1];
        result = 0;
        uint32_t uiIndex = 0;
        uiIndex++;
        if (VOS_ENC_OP_LIT(enOpType)) {
            exceptResult = (uintptr_t)(enOpType - DW_OP_LIT0);
        } else if (VOS_ENC_OP_REG(enOpType)) {
            exceptResult = 0x00FE;
            coreRegs.r[(enOpType - DW_OP_REG0) & REG_VAILD_MASK] = exceptResult;
        } else if (VOS_ENC_OP_BREG(enOpType)) {
            intptr_t offset = 0x10;
            MOCKER(TraceReadLeb128).stubs().with(any(), any(), outBoundP(&offset, sizeof(intptr_t *)))
                .will(returnValue(opEnd));
            exceptResult = coreRegs.r[(enOpType - DW_OP_BREG0) & REG_VAILD_MASK] + (uintptr_t)offset;
        } else if (VOS_ENC_OP_CONST(enOpType)) {
            Mocker_TraceOpConstNumGet(enOpType, opStart + 1, &exceptResult);
        } else if (VOS_ENC_OP_STACK_OPR(enOpType)) {
            continue; // in TestCase TestTraceStackOpExc_TraceOpStackDataOpt
        } else if (VOS_ENC_OP_ONE_DATA(enOpType)) {
            continue; // in TestCase TestTraceStackOpExc_TraceOpStackOneDataOpt
        } else if (VOS_ENC_OP_TWO_DATA(enOpType)) {
            MOCKER(TraceOpStackTwoDataOpt).stubs().will(returnValue(TRACE_SUCCESS)); // in TestCase TestTraceStackOpExc_TraceOpStackTwoDataOpt
            ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
            LOG_EXPECT_EQ(TRACE_SUCCESS, ret, "test TraceStackOpExc failed, enOpType=0x%02hhx.", enOpType);
            continue;
        } else if (VOS_ENC_OP_OTHER_OPR(enOpType)) {
            exceptResult = 0;
            uintptr_t uvStackContent[VOS_OP_STACK_DEPTH] = {0};
            uvStackContent[0] = initial;
            Mocker_TraceOpStackOtherOpt(enOpType, uvStackContent, &uiIndex, opStart + 1, &coreRegs, &exceptResult);
        } else {
            exceptResult = result;
            ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
            // printf("%s:%d enOpType[0x%02hhx], exceptResult[%d], result[%d]\n", __FILE__, __LINE__, enOpType, exceptResult, result);
            LOG_EXPECT_EQ(exceptResult, result, "test TraceStackOpExc failed, enOpType=0x%02hhx.", enOpType);
            LOG_EXPECT_EQ(TRACE_FAILURE, ret, "test TraceStackOpExc failed, enOpType=0x%02hhx.", enOpType);
            continue;
        }

        if (uiIndex < 1 || uiIndex >= VOS_OP_STACK_DEPTH) {
            ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
            // printf("%s:%d enOpType[0x%02hhx], exceptResult[%d], result[%d]\n", __FILE__, __LINE__, enOpType, exceptResult, result);
            LOG_EXPECT_EQ(TRACE_FAILURE, ret, "test TraceStackOpExc failed, enOpType=0x%02hhx.", enOpType);
            continue;
        }

        if ((VOS_IS_NO_PUSH_CODE(enOpType))) {
            exceptResult = initial;
        }

        ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
        // printf("%s:%d enOpType[0x%02hhx], exceptResult[%d], result[%d]\n", __FILE__, __LINE__, enOpType, exceptResult, result);
        LOG_EXPECT_EQ(exceptResult, result, "test TraceStackOpExc failed, enOpType=0x%02hhx.", enOpType);
        LOG_EXPECT_EQ(TRACE_SUCCESS, ret, "test TraceStackOpExc failed, enOpType=0x%02hhx.", enOpType);
        GlobalMockObject::verify();
    }
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceStackOpExc_TraceOpStackDataOpt)
{
    // for VOS_ENC_OP_STACK_OPR, from DW_OP_DUP(0x12) ot DW_OP_ROT(0x17)
    const uint8_t *opStart = 0;
    const uint8_t *opEnd = 0;
    ScdRegs coreRegs = { 0 };
    uintptr_t result = 0;
    uintptr_t initial = 0x001234;
    ScdDwarfStepArgs args = { 0 };
    uint32_t ret = TRACE_FAILURE;

    // case DW_OP_DUP
    uint8_t dataDup[4] = { DW_OP_DUP, DW_OP_DUP, DW_OP_DUP, DW_OP_DUP }; // Index++, = 5
    opStart = &dataDup[0];
    opEnd = &dataDup[4];
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(initial, result);

    // case DW_OP_DROP
    uint8_t dataDrop[4] = { DW_OP_DUP, // Index++, = 2
        DW_OP_DROP, // Index--, =1, success
        DW_OP_DROP, // Index--, =0
        DW_OP_DROP }; // Index--, =-1
    opStart = &dataDrop[0];
    opEnd = &dataDrop[2];
    result = 0;
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(initial, result);

    result = 0;
    opEnd = &dataDrop[3];
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_FAILURE, ret); // Index < 1

    result = 0;
    opEnd = &dataDrop[4];
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_FAILURE, ret); // check Index fail

    // case DW_OP_PICK
    uint8_t dataPick[8] = { DW_OP_DUP, DW_OP_DUP, DW_OP_DUP, DW_OP_DUP, // Index++, = 5
        DW_OP_PICK, 0x03, // Index(0x05) >= offset(0x03) + 2, success; Index++ for DW_OP_PICK, =6
        DW_OP_PICK, 0x05 }; // Index(0x06) < offset(0x05) + 2, failure
    opStart = &dataPick[0];
    opEnd = &dataPick[6];
    result = 0;
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(initial, result);

    opStart = &dataPick[0];
    opEnd = &dataPick[8];
    result = 0;
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // case DW_OP_OVER
    uint8_t dataOver1[1] = { DW_OP_OVER }; // Index(0x01) < 2, failure
    opStart = &dataOver1[0];
    opEnd = &dataOver1[1];
    result = 0;
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_FAILURE, ret);

    uint8_t dataOver2[2] = { DW_OP_DUP, // Index++, = 2
        DW_OP_OVER }; // Index(0x02) >= 2, success;
    opStart = &dataOver2[0];
    opEnd = &dataOver2[2];
    result = 0;
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(initial, result);


    // case DW_OP_SWAP
    uint8_t dataSwap1[1] = { DW_OP_SWAP }; // Index(0x01) < 2, failure
    opStart = &dataSwap1[0];
    opEnd = &dataSwap1[1];
    result = 0;
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_FAILURE, ret);

    uint8_t dataSwap2[2] = { DW_OP_DUP, // Index++
        DW_OP_SWAP }; // Index(0x02) >= 2, success;
    opStart = &dataSwap2[0];
    opEnd = &dataSwap2[2];
    result = 0;
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(initial, result);

    // case DW_OP_ROT
    uint8_t dataRot1[2] = { DW_OP_DUP, // Index++, = 2
        DW_OP_ROT }; // Index(0x02) < 3, failure
    opStart = &dataRot1[0];
    opEnd = &dataRot1[2];
    result = 0;
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_FAILURE, ret);

    uint8_t dataRot2[3] = { DW_OP_DUP, DW_OP_DUP, // Index++, = 3
        DW_OP_ROT }; // Index(0x03) >= 3, success;
    opStart = &dataRot2[0];
    opEnd = &dataRot2[3];
    result = 0;
    ret = TraceStackOpExc(&dwarf, opStart, opEnd, &coreRegs, &result, initial, &args);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(initial, result);
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceStackOpExc_TraceOpStackOneDataOpt)
{
    // for VOS_ENC_OP_ONE_DATA
    uintptr_t value = 0x12345678;
    uint8_t addr[5] = { 1, 2, 4, 8, 0 };
    uintptr_t data[4] = { 0, value, 0, 0 };
    uintptr_t dataAddr = 0;
    uint32_t index = 2;
    const uint8_t *insAddr = 0;
    uintptr_t stackContent[VOS_OP_STACK_DEPTH] = { 0 };
    uint8_t enOpType = DW_OP_ADDR;
    ScdDwarfStepArgs args = { 0 };
    const uint8_t *ret = NULL;
    uintptr_t result = 0;
    uint32_t exceptRet = TRACE_FAILURE;
    uintptr_t exceptResult = 0;

    // invalid type
    enOpType = DW_OP_ADDR;
    ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
    EXPECT_EQ((const uint8_t *)0, ret);

    // case DW_OP_DEREF
    enOpType = DW_OP_DEREF;
    index = 2;
    result = 0;
    insAddr = &addr[0];
    stackContent[(index - 1) & VOS_OP_STACK_MASK] = 0; // invalid addr
    ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
    EXPECT_EQ((const uint8_t *)0, ret);

    index = 2;
    result = 0;
    dataAddr = (uintptr_t)&data[1];
    stackContent[(index - 1) & VOS_OP_STACK_MASK] = dataAddr;
    args.stackMaxAddr = dataAddr + 8;
    args.stackMinAddr = dataAddr - 8;
    insAddr = &addr[0];
    ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
    EXPECT_EQ(insAddr, ret);
    EXPECT_EQ(value, result);

    // case DW_OP_DEREF_SIZE
    enOpType = DW_OP_DEREF_SIZE;
    index = 2;
    result = 0;
    stackContent[(index - 1) & VOS_OP_STACK_MASK] = 0; // invalid addr
    insAddr = &addr[0];
    ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
    EXPECT_EQ((const uint8_t *)0, ret);

    {   // test for TraceDefSizeGet
        // case VOS_OP_DATA_TYPE_UINT8
        index = 2;
        result = 0;
        dataAddr = (uintptr_t)&data[1];
        stackContent[(index - 1) & VOS_OP_STACK_MASK] = dataAddr;
        args.stackMaxAddr = dataAddr + 8;
        args.stackMinAddr = dataAddr - 8;
        insAddr = &addr[0]; // data type uint8_t
        ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
        EXPECT_EQ(insAddr + 1, ret);
        EXPECT_EQ(*(uint8_t *)dataAddr , result);

        // case VOS_OP_DATA_TYPE_UINT16
        index = 2;
        result = 0;
        dataAddr = (uintptr_t)&data[1];
        stackContent[(index - 1) & VOS_OP_STACK_MASK] = dataAddr;
        args.stackMaxAddr = dataAddr + 8;
        args.stackMinAddr = dataAddr - 8;
        insAddr = &addr[1]; // data type uint16_t
        ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
        EXPECT_EQ(insAddr + 1, ret);
        EXPECT_EQ(*(uint16_t *)dataAddr , result);

        // case VOS_OP_DATA_TYPE_UINT32
        index = 2;
        result = 0;
        dataAddr = (uintptr_t)&data[1];
        stackContent[(index - 1) & VOS_OP_STACK_MASK] = dataAddr;
        args.stackMaxAddr = dataAddr + 8;
        args.stackMinAddr = dataAddr - 8;
        insAddr = &addr[2]; // data type uint32_t
        ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
        EXPECT_EQ(insAddr + 1, ret);
        EXPECT_EQ(*(uint32_t *)dataAddr , result);

        // case VOS_OP_DATA_TYPE_UINT64
        index = 2;
        result = 0;
        dataAddr = (uintptr_t)&data[1];
        stackContent[(index - 1) & VOS_OP_STACK_MASK] = dataAddr;
        args.stackMaxAddr = dataAddr + 8;
        args.stackMinAddr = dataAddr - 8;
        insAddr = &addr[3]; // data type uint64_t
        ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
        EXPECT_EQ(insAddr + 1, ret);
        EXPECT_EQ(*(uint64_t *)dataAddr , result);

        // default
        index = 2;
        result = 0;
        dataAddr = (uintptr_t)&data[1];
        stackContent[(index - 1) & VOS_OP_STACK_MASK] = dataAddr;
        args.stackMaxAddr = dataAddr + 8;
        args.stackMinAddr = dataAddr - 8;
        insAddr = &addr[4]; // invalid data type
        ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
        EXPECT_EQ((const uint8_t *)0, ret);
    }

    // case DW_OP_ABS
    enOpType = DW_OP_ABS;
    index = 2;
    result = 0;
    dataAddr = (uintptr_t)&data[1];
    stackContent[(index - 1) & VOS_OP_STACK_MASK] = 0 - dataAddr; // < 0
    insAddr = &addr[0];
    ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
    EXPECT_EQ(insAddr, ret);
    EXPECT_EQ(dataAddr, result);

    // case DW_OP_NEG
    enOpType = DW_OP_NEG;
    index = 2;
    result = 0;
    dataAddr = (uintptr_t)&data[1];
    stackContent[(index - 1) & VOS_OP_STACK_MASK] = dataAddr;
    insAddr = &addr[0];
    ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
    EXPECT_EQ(insAddr, ret);
    EXPECT_EQ((uintptr_t)(-(intptr_t)dataAddr), result);

    // case DW_OP_NOT
    enOpType = DW_OP_NOT;
    index = 2;
    result = 0;
    dataAddr = (uintptr_t)&data[1];
    stackContent[(index - 1) & VOS_OP_STACK_MASK] = dataAddr;
    insAddr = &addr[0];
    ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
    EXPECT_EQ(insAddr, ret);
    EXPECT_EQ(~dataAddr, result);

    // case DW_OP_PLUS_UCONST
    enOpType = DW_OP_PLUS_UCONST;
    index = 2;
    result = 0;
    dataAddr = (uintptr_t)&data[1];
    stackContent[(index - 1) & VOS_OP_STACK_MASK] = dataAddr;
    insAddr = &addr[0];
    const uint8_t *mockValue = insAddr + 2;
    uintptr_t uOffset = 0x08;
    MOCKER(TraceReadUleb128).stubs().with(any(), any(), outBoundP(&uOffset, sizeof(uintptr_t *)))
        .will(returnValue(mockValue));
    ret =  TraceOpStackOneDataOpt(&dwarf, enOpType, stackContent, &index, insAddr, &args, &result);
    EXPECT_EQ(mockValue, ret);
    EXPECT_EQ(dataAddr + uOffset, result);
}

uint32_t Mocker_TraceOpStackTwoDataParse(uint8_t enOpType, uintptr_t uvSwapTmp1,
    uintptr_t uvSwapTmp2, uintptr_t *puvResult)
{
    uintptr_t uvTmpRes = 0;

    switch (enOpType) {
        case DW_OP_AND:
            uvTmpRes = uvSwapTmp1 & uvSwapTmp2;
            break;
        case DW_OP_DIV:
            if (uvSwapTmp2 == 0) {
                return -1;
            }
            uvTmpRes = (uintptr_t)((intptr_t)uvSwapTmp1 / (intptr_t)uvSwapTmp2);
            break;

        case DW_OP_MINUS:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 - uvSwapTmp2);
            break;
        case DW_OP_MOD:
            if (uvSwapTmp2 == 0) {
                return -1;
            }
            uvTmpRes = (uintptr_t)(uvSwapTmp1 % uvSwapTmp2);
            break;
        case DW_OP_MUL:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 * uvSwapTmp2);
            break;
        case DW_OP_OR:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 | uvSwapTmp2);
            break;
        case DW_OP_PLUS:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 + uvSwapTmp2);
            break;
        case DW_OP_SHL:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 << uvSwapTmp2);
            break;
        case DW_OP_SHR:
        case DW_OP_SHRA:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 >> uvSwapTmp2);
            break;
        case DW_OP_XOR:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 ^ uvSwapTmp2);
            break;
        case DW_OP_LE:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 <= uvSwapTmp2);
            break;
        case DW_OP_GE:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 >= uvSwapTmp2);
            break;
        case DW_OP_EQ:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 == uvSwapTmp2);
            break;
        case DW_OP_LT:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 < uvSwapTmp2);
            break;
        case DW_OP_GT:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 > uvSwapTmp2);
            break;
        case DW_OP_NE:
            uvTmpRes = (uintptr_t)(uvSwapTmp1 != uvSwapTmp2);
            break;
        default:
            return -1;
    }

    *puvResult = uvTmpRes;

    return 0;
}
TEST_F(StackTraceUnwindInstrUtest, TestTraceStackOpExc_TraceOpStackTwoDataOpt)
{
    // for VOS_ENC_OP_TWO_DATA
    uintptr_t result = 0;
    uintptr_t initial = 0x001234;
    uint32_t index = 2;
    uint32_t ret = TRACE_FAILURE;
    uintptr_t stackContent[VOS_OP_STACK_DEPTH] = { 0 };
    uint8_t enOpType = DW_OP_ADDR;
    uint32_t exceptRet = TRACE_FAILURE;
    uintptr_t exceptResult = 0;

    // invalid type
    for (uint32_t i = 0x00; i <= 0xFF; i++) {
        enOpType = (uint8_t)i;
        if (VOS_ENC_OP_TWO_DATA(enOpType)) {
            continue;
        }
        index = 2;
        ret = TraceOpStackTwoDataOpt(enOpType, stackContent, &index, &result);
        LOG_EXPECT_EQ(VOS_ERRNO_URC_FAILURE, ret, "test TraceOpStackTwoDataOpt failed, enOpType=0x%02hhx.", enOpType);
    }

    // invalid index
    index = 1;
    enOpType = DW_OP_AND;
    ret = TraceOpStackTwoDataOpt(enOpType, stackContent, &index, &result);
    EXPECT_EQ(VOS_ERRNO_URC_FAILURE, ret);

    // tmp2 is 0
    stackContent[0] = initial;
    stackContent[1] = 0;
    for (uint32_t i = 0x1a; i <= 0x2e; i++) {
        index = 2;
        enOpType = (uint8_t)i;
        exceptResult = 0;
        result = 0;
        exceptRet = Mocker_TraceOpStackTwoDataParse(enOpType, stackContent[0], stackContent[1], &exceptResult);
        ret = TraceOpStackTwoDataOpt(enOpType, stackContent, &index, &result);
        LOG_EXPECT_EQ(exceptRet, ret, "test TraceOpStackTwoDataOpt failed, enOpType=0x%02hhx.", enOpType);
        if (ret == TRACE_SUCCESS) {
            LOG_EXPECT_EQ(exceptResult, result, "test TraceOpStackTwoDataOpt failed, enOpType=0x%02hhx.", enOpType);
        }
    }

    // tmp2 is not 0
    stackContent[0] = initial;
    stackContent[1] = 1;
    for (uint32_t i = 0x1a; i <= 0x2e; i++) {
        index = 2;
        enOpType = (uint8_t)i;
        exceptResult = 0;
        result = 0;
        exceptRet = Mocker_TraceOpStackTwoDataParse(enOpType, stackContent[0], stackContent[1], &exceptResult);
        ret = TraceOpStackTwoDataOpt(enOpType, stackContent, &index, &result);
        LOG_EXPECT_EQ(exceptRet, ret, "test TraceOpStackTwoDataOpt failed, enOpType=0x%02hhx.", enOpType);
        if (ret == TRACE_SUCCESS) {
            LOG_EXPECT_EQ(exceptResult, result, "test TraceOpStackTwoDataOpt failed, enOpType=0x%02hhx.", enOpType);
        }
    }
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceEncValueSizeGet)
{
    uint32_t ret = 0;

    for (uint8_t enCode = 0x00; enCode < 0xFF; enCode++) {
        // case DW_EH_PE_ABSPTR
        if ((enCode & 0x07) == DW_EH_PE_ABSPTR) {
            ret = TraceEncValueSizeGet(enCode);
            EXPECT_EQ(sizeof(void *), ret);
            continue;
        }

        // case DW_EH_PE_UDATA2
        if ((enCode & 0x07) == DW_EH_PE_UDATA2) {
            ret = TraceEncValueSizeGet(enCode);
            EXPECT_EQ(sizeof(uint16_t), ret);
            continue;
        }

        // case DW_EH_PE_UDATA4
        if ((enCode & 0x07) == DW_EH_PE_UDATA4) {
            ret = TraceEncValueSizeGet(enCode);
            EXPECT_EQ(sizeof(uint32_t), ret);
            continue;
        }

        // case DW_EH_PE_UDATA8
        if ((enCode & 0x07) == DW_EH_PE_UDATA8) {
            ret = TraceEncValueSizeGet(enCode);
            EXPECT_EQ(sizeof(uint64_t), ret);
            continue;
        }

        // default
        ret = TraceEncValueSizeGet(enCode);
        LOG_EXPECT_EQ(0, ret, "test TraceEncValueSizeGet failed, enCode=0x%02hhx.", enCode);
    }
}

TEST_F(StackTraceUnwindInstrUtest, TraceUnwindParseFnOpcodeParseFailed)
{
    int tmp = 0xC0;
    TraceAddrRange range;
    range.start = (uintptr_t)&tmp;
    range.end = (uintptr_t)&tmp + sizeof(int);
    TraceFrameRegStateInfo regState;
    bool isFEDTable = false;
    const uint8_t *retPtr = 0;
    MOCKER(TraceUnwindOpcodeParse).stubs().will(returnValue((const uint8_t *)NULL));
    auto ret = TraceUnwindParseFn(&dwarf, &range, &regState, isFEDTable);
    EXPECT_EQ(ret, TRACE_FAILURE);
}

TEST_F(StackTraceUnwindInstrUtest, TraceUnwindParseFnParseReg)
{
    int tmp = 0x14;
    TraceAddrRange range;
    range.start = (uintptr_t)&tmp;
    range.end = (uintptr_t)&tmp + sizeof(int);
    dwarf.memory->data = (uintptr_t)&tmp;
    TraceFrameRegStateInfo regState;
    bool isFEDTable = false;
    const uint8_t *retPtr = 0;
    MOCKER(TraceUnwindOpcodeParse).stubs().will(returnValue((const uint8_t *)range.end));
    auto ret = TraceUnwindParseFn(&dwarf, &range, &regState, isFEDTable);
    EXPECT_EQ(ret, TRACE_SUCCESS);
}

TEST_F(StackTraceUnwindInstrUtest, TraceUnwindParseFnInvalidOpCode)
{
    int tmp = 0x3f;
    TraceAddrRange range;
    range.start = (uintptr_t)&tmp;
    range.end = (uintptr_t)&tmp + sizeof(int);
    TraceFrameRegStateInfo regState;
    bool isFEDTable = false;
    const uint8_t *retPtr = 0;
    MOCKER(TraceUnwindOpcodeParse).stubs().will(returnValue((const uint8_t *)range.end));
    auto ret = TraceUnwindParseFn(&dwarf, &range, &regState, isFEDTable);
    EXPECT_EQ(ret, TRACE_FAILURE);
}

TEST_F(StackTraceUnwindInstrUtest, Test)
{
    int tmp = 0x3f;
    TraceAddrRange range;
    range.start = (uintptr_t)&tmp;
    range.end = (uintptr_t)&tmp + sizeof(int);
    TraceFrameRegStateInfo regState;
    bool isFEDTable = false;
    const uint8_t *retPtr = 0;
    MOCKER(TraceUnwindOpcodeParse).stubs().will(returnValue((const uint8_t *)range.end));
    auto ret = TraceUnwindParseFn(&dwarf, &range, &regState, isFEDTable);
    EXPECT_EQ(ret, TRACE_FAILURE);
}

TEST_F(StackTraceUnwindInstrUtest, TestTraceOpStackTwoDataOptWithInvalidOpcode)
{
    uint8_t enOpType = DW_OP_HI_USER;
    uintptr_t uvSwapTmp1 = 0;
    uintptr_t uvSwapTmp2 = 0;
    uintptr_t puvResult;
    auto ret = TraceOpStackTwoDataParseBasic(enOpType, uvSwapTmp1, uvSwapTmp2, &puvResult);
    EXPECT_EQ(ret, TRACE_FAILURE);

    const ScdDwarfStepArgs *pstStackLimit = NULL;
    const uint8_t pucInsAddr = 0;
    auto addr = TraceOpStackOneDataParse(&dwarf, enOpType, uvSwapTmp1, &pucInsAddr, pstStackLimit, &puvResult);
    EXPECT_EQ(addr, (const void *)NULL);

    uint32_t puiIndex;
    uintptr_t auvStackContent[] = {0};
    addr = TraceOpStackDataOpt(enOpType, auvStackContent, &puiIndex, &pucInsAddr, &puvResult);
    EXPECT_EQ(addr, (const void *)NULL);

    addr = TraceOpConstNumGet(&dwarf, enOpType, &pucInsAddr, &puvResult);
    EXPECT_EQ(addr, (const void *)NULL);
}


