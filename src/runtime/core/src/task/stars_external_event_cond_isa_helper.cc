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

namespace cce {
namespace runtime {
void ConstructExternalWaitFuncCall(RtStarsExternalWaitFuncCall &fc,
    const RtStarsExternalWaitFuncCallPara &fcPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    const uint64_t waitRefreshLoadOffset = offsetof(RtStarsExternalWaitFuncCall, lhwiWaitRefreshAddr) / sizeof(uint32_t);
    const uint64_t waitFailedOffset = offsetof(RtStarsExternalWaitFuncCall, gotoPre) / sizeof(uint32_t);
    const uint64_t waitSuccessOffset = offsetof(RtStarsExternalWaitFuncCall, gotoNext) / sizeof(uint32_t);
    const uint64_t endOffset = offsetof(RtStarsExternalWaitFuncCall, end) / sizeof(uint32_t);

    ConstructOpImmAndi(r0, r4, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.initLoopIndex);
    ConstructOpImmAndi(r0, r5, fcPara.maxLoop, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.loadMaxLoop);
    ConstructLHWI(r1, fcPara.waitRefreshAddr, fc.lhwiWaitRefreshAddr);
    ConstructLLWI(r1, fcPara.waitRefreshAddr, fc.llwiWaitRefreshAddr);
    ConstructLoad(r1, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.loadWaitAddrFromRefresh);
    ConstructSetJumpPcFc(r1, waitSuccessOffset, fc.jumpZeroSatisfied);
    ConstructBranch(r2, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(waitSuccessOffset),
        fc.zeroSatisfied);
    ConstructLoad(r2, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.loadActual);
    ConstructOpImmAndi(r1, r3, 0xFFU, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.maskLow8);
    ConstructOpImmAndi(r0, r2, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.loadExpected);
    ConstructSetJumpPcFc(r1, waitSuccessOffset, fc.jumpWaitSatisfied);
    ConstructBranch(r3, r2, RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU, static_cast<uint8_t>(waitSuccessOffset),
        fc.waitSatisfied);
    ConstructOpImmAndi(r4, r4, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.incrementLoopIndex);
    ConstructSetJumpPcFc(r1, waitFailedOffset, fc.jumpWaitFailed);
    ConstructBranch(r4, r5, RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU, static_cast<uint8_t>(waitFailedOffset), fc.loopLimit);
    ConstructSetJumpPcFc(r1, waitRefreshLoadOffset, fc.jumpRetry);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(waitRefreshLoadOffset), fc.retryBranch);
    ConstructGotoI(r5, static_cast<uint16_t>(fcPara.sqId), static_cast<uint16_t>(fcPara.sqHeadPre), fc.gotoPre);
    ConstructGotoI(r5, static_cast<uint16_t>(fcPara.sqId), static_cast<uint16_t>(fcPara.sqHeadNext), fc.gotoNext);
    ConstructSetJumpPcFc(r1, endOffset, fc.jumpEnd);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(endOffset), fc.endBranch);
    ConstructNop(fc.end);
}
} // namespace runtime
} // namespace cce
