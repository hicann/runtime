/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "scd_elf.h"
#include "scd_regs.h"
#include "scd_dwarf.h"

namespace {
constexpr uintptr_t SCD_UT_TEST_PC = 0x4000000ULL;              // 测试用当前帧 PC
constexpr uintptr_t SCD_UT_SENTINEL_PC = 0x1234567890abcdefULL; // 哨兵 PC，用于检测失败路径是否污染寄存器上下文
constexpr size_t SCD_UT_EH_FRAME_HDR_OFFSET = 0x1000U; // 非零 eh_frame_hdr 偏移
constexpr size_t SCD_UT_EH_FRAME_HDR_SIZE = 0x40U;     // eh_frame_hdr 大小
} // namespace

class ScdElfUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        elf.ehFrameHdrOffset = SCD_UT_EH_FRAME_HDR_OFFSET;
        elf.ehFrameHdrSize = SCD_UT_EH_FRAME_HDR_SIZE;
        ScdRegsSetPc(&regs, SCD_UT_SENTINEL_PC);
    }

    virtual void TearDown() { GlobalMockObject::verify(); }

    ScdElf elf = {0};
    ScdRegs regs = {0};
};

// 缺陷用例：ScdDwarfStep 失败路径不写 nextPc 出参，ScdElfStep 不得使用未初始化的 nextPc 污染寄存器上下文
TEST_F(ScdElfUtest, TestScdElfStepDwarfFailureKeepsPc)
{
    // 模拟失败路径：直接返回 TRACE_FAILURE，不写 nextPc 出参
    MOCKER(ScdDwarfStep).stubs().will(returnValue(TRACE_FAILURE));
    EXPECT_EQ(ScdElfStep(&elf, SCD_UT_TEST_PC, &regs, false), TRACE_FAILURE);
    // 失败路径不得修改寄存器上下文中的 PC
    EXPECT_EQ(ScdRegsGetPc(&regs), SCD_UT_SENTINEL_PC);
}

// 正常路径：ScdDwarfStep 成功写出 nextPc，ScdElfStep 更新 PC
TEST_F(ScdElfUtest, TestScdElfStepDwarfSuccessUpdatesPc)
{
    uintptr_t nextPc = 0x5000ULL;
    MOCKER(ScdDwarfStep)
        .stubs()
        .with(any(), any(), any(), any(), outBoundP(&nextPc, sizeof(uintptr_t)))
        .will(returnValue(TRACE_SUCCESS));
    EXPECT_EQ(ScdElfStep(&elf, SCD_UT_TEST_PC, &regs, true), TRACE_SUCCESS);
    EXPECT_EQ(ScdRegsGetPc(&regs), nextPc);
}

// 终止语义：ScdDwarfStep 成功且 nextPc 为 0，ScdElfStep 应将 PC 置 0（调用方依赖 PC==0 停止回溯）
TEST_F(ScdElfUtest, TestScdElfStepDwarfSuccessZeroPc)
{
    uintptr_t nextPc = 0;
    MOCKER(ScdDwarfStep)
        .stubs()
        .with(any(), any(), any(), any(), outBoundP(&nextPc, sizeof(uintptr_t)))
        .will(returnValue(TRACE_SUCCESS));
    EXPECT_EQ(ScdElfStep(&elf, SCD_UT_TEST_PC, &regs, false), TRACE_SUCCESS);
    EXPECT_EQ(ScdRegsGetPc(&regs), 0U);
}

// 早退路径：无 eh_frame_hdr 段时直接失败，不应调用 ScdDwarfStep
TEST_F(ScdElfUtest, TestScdElfStepNoEhFrameHdr)
{
    elf.ehFrameHdrOffset = 0;
    MOCKER(ScdDwarfStep).expects(never());
    EXPECT_EQ(ScdElfStep(&elf, SCD_UT_TEST_PC, &regs, false), TRACE_FAILURE);
}
