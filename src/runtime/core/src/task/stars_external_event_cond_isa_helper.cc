/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_cond_isa_helper.hpp"
#include "stars_external_event_cond_isa_helper.hpp"

#include <cstdint>

namespace cce {
namespace runtime {
// 构造external wait在software SQ/dynamic bind流程下读取SQ ID及确定SQ head的指令块。
// capture阶段stream还没有真实SQ ID，execute前BindSqCq把真实SQ ID写入sqIdMemAddr。function-call中运行时读取sqIdMemAddr。
// 普通mem value wait的software SQ路径也采用相同模式，参考：
// MemWaitInstrSqePreForSoftwareSq
// MemWaitInstrSqeNextForSoftwareSq
// MemWaitInstrSqePreForSoftwareSqAndDynamicProf
void ConstructDynamicSqHeadGotoR(const uint64_t sqIdMemAddr, const uint32_t sqHead, const uint8_t endOffset,
    RtStarsDynamicSqHeadGotoR &gotoBlock)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    // r3 = *sqIdMemAddr，读取BindSqCq写入的运行时真实SQ ID。
    ConstructLoadImm(r3, sqIdMemAddr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD, gotoBlock.loadSqId);
    // r4 = sqHead，目标SQ head来自capture阶段记录的task位置。
    ConstructLHWI(r4, static_cast<uint64_t>(sqHead), gotoBlock.lhwiSqHead);
    ConstructLLWI(r4, static_cast<uint64_t>(sqHead), gotoBlock.llwiSqHead);
    // r4 = sqHead << 16，goto_r操作数中高16位承载目标head。
    ConstructOpImmSlli(r4, r4, static_cast<uint8_t>(UINT16_BIT_NUM), RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, gotoBlock.slliSqHead);
    // r3 = sqId | (sqHead << 16)，低位保留运行时SQ ID，高位写入目标head。
    ConstructOpOp(r3, r4, r3, RT_STARS_COND_ISA_OP_FUNC3_OR, RT_STARS_COND_ISA_OP_FUNC7_OR,
        gotoBlock.opSqHead);
    // 根据r3动态修改SQ head，避免goto_i固化capture阶段无效SQ ID。
    ConstructGotoR(r3, r5, gotoBlock.gotoDynamic);
    // 当前动态goto块不再继续执行，直接跳到function-call end。
    ConstructSetJumpPcFc(r1, endOffset, gotoBlock.jumpEnd);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, endOffset, gotoBlock.endBranch);
}

void ConstructExternalWaitFuncCall(RtStarsExternalWaitFuncCall &fc,
    const RtStarsExternalWaitFuncCallPara &fcPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    constexpr uint8_t waitRefreshLoadOffset = static_cast<uint8_t>(
        offsetof(RtStarsExternalWaitFuncCall, lhwiWaitRefreshAddr) / sizeof(uint32_t));
    constexpr uint8_t waitFailedOffset = static_cast<uint8_t>(
        offsetof(RtStarsExternalWaitFuncCall, gotoPreDynamic) / sizeof(uint32_t));
    constexpr uint8_t waitSuccessOffset = static_cast<uint8_t>(
        offsetof(RtStarsExternalWaitFuncCall, gotoNextDynamic) / sizeof(uint32_t));
    constexpr uint8_t endOffset = static_cast<uint8_t>(offsetof(RtStarsExternalWaitFuncCall, end) / sizeof(uint32_t));

    ConstructOpImmAndi(r0, r4, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.initLoopIndex);
    ConstructOpImmAndi(r0, r5, static_cast<uint32_t>(fcPara.maxLoop), RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI,
        fc.loadMaxLoop);
    ConstructLHWI(r1, fcPara.waitRefreshAddr, fc.lhwiWaitRefreshAddr);
    ConstructLLWI(r1, fcPara.waitRefreshAddr, fc.llwiWaitRefreshAddr);
    ConstructLoad(r1, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.loadWaitAddrFromRefresh);
    ConstructSetJumpPcFc(r1, waitSuccessOffset, fc.jumpZeroSatisfied);
    ConstructBranch(r2, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, waitSuccessOffset, fc.zeroSatisfied);
    ConstructLoad(r2, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.loadActual);
    ConstructOpImmAndi(r1, r3, UINT8_MAX, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.maskLow8);
    ConstructOpImmAndi(r0, r2, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.loadExpected);
    ConstructSetJumpPcFc(r1, waitSuccessOffset, fc.jumpWaitSatisfied);
    ConstructBranch(r3, r2, RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU, waitSuccessOffset, fc.waitSatisfied);
    ConstructOpImmAndi(r4, r4, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.incrementLoopIndex);
    ConstructSetJumpPcFc(r1, waitFailedOffset, fc.jumpWaitFailed);
    ConstructBranch(r4, r5, RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU, waitFailedOffset, fc.loopLimit);
    ConstructSetJumpPcFc(r1, waitRefreshLoadOffset, fc.jumpRetry);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, waitRefreshLoadOffset, fc.retryBranch);
    ConstructDynamicSqHeadGotoR(fcPara.sqIdMemAddr, fcPara.sqHeadPre, endOffset, fc.gotoPreDynamic);
    ConstructDynamicSqHeadGotoR(fcPara.sqIdMemAddr, fcPara.sqHeadNext, endOffset, fc.gotoNextDynamic);
    ConstructSetJumpPcFc(r1, endOffset, fc.jumpEnd);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, endOffset, fc.endBranch);
    ConstructNop(fc.end);
}
} // namespace runtime
} // namespace cce
