/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cond_op_manager.hpp"

namespace cce {
namespace runtime {
namespace {

static void ConstructNop(void* const nopAddr)
{
    auto& nop = *static_cast<RtStarsCondOpNop*>(nopAddr);
    nop.opCode = RT_STARS_COND_ISA_OP_CODE_NOP;
    nop.rd = RT_STARS_COND_ISA_REGISTER_R0;
    nop.func3 = RT_STARS_COND_ISA_OP_IMM_FUNC3_NOP;
    nop.rs1 = RT_STARS_COND_ISA_REGISTER_R0;
    nop.immd = 0U;
}

static void ConstructLoad(
    const rtStarsCondIsaRegister_t rs1Reg, const uint16_t imd, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondIsaLoadFunc3_t func3, void* const loadAddr)
{
    auto& load = *static_cast<RtStarsCondOpLoad*>(loadAddr);
    load.opCode = RT_STARS_COND_ISA_OP_CODE_LOAD;
    load.rd = dstReg;
    load.func3 = func3;
    load.rs1 = rs1Reg;
    load.immd = imd;
}

static void ConstructLoadImm(
    const rtStarsCondIsaRegister_t dstReg, const uint64_t addr, const rtStarsCondIsaLoadImmFunc3_t func3,
    void* const loadImmAddr)
{
    auto& loadImm = *static_cast<RtStarsCondOpLoadImm*>(loadImmAddr);
    loadImm.opCode = RT_STARS_COND_ISA_OP_CODE_LOAD_IMM;
    loadImm.rd = dstReg;
    loadImm.func3 = func3;
    loadImm.immdAddrHigh = static_cast<uint32_t>((addr >> 32U) & 0X1FFFFU);
    loadImm.immdAddrLow = static_cast<uint32_t>(addr & 0xFFFFFFFFU);
}

static void ConstructOpImmAndi(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, const uint32_t immd,
    const RtStarsCondIsaOpImmFunc3 func3, void* const opImmAndiAddr)
{
    auto& opImmAndi = *static_cast<RtStarsCondOpImm*>(opImmAndiAddr);
    opImmAndi.opCode = RT_STARS_COND_ISA_OP_CODE_OP_IMM;
    opImmAndi.rd = dstReg;
    opImmAndi.func3 = func3;
    opImmAndi.rs1 = rs1Reg;
    opImmAndi.immd = static_cast<uint32_t>(immd & 0xFFFU);
}

static void ConstructOpImmSlli(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, const uint8_t shamt,
    const RtStarsCondIsaOpImmFunc3 func3, const rtStarsCondIsaOpImmFunc7_t func7, void* const opImmSlliAddr)
{
    auto& opImmSlli = *static_cast<RtStarsCondOpImmSLLI*>(opImmSlliAddr);
    opImmSlli.opCode = RT_STARS_COND_ISA_OP_CODE_OP_IMM;
    opImmSlli.rd = dstReg;
    opImmSlli.func3 = func3;
    opImmSlli.rs1 = rs1Reg;
    opImmSlli.shamt = shamt;
    opImmSlli.func7 = func7;
}

static void ConstructOpOp(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondIsaOpFunc3_t func3, const RtStarsCondIsaOpFunc7 func7, void* const opOpAddr)
{
    auto& opOp = *static_cast<RtStarsCondOpOp*>(opOpAddr);
    opOp.opCode = RT_STARS_COND_ISA_OP_CODE_OP;
    opOp.rd = dstReg;
    opOp.func3 = func3;
    opOp.rs1 = rs1Reg;
    opOp.rs2 = rs2Reg;
    opOp.func7 = func7;
}

static void ConstructLhwi(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, void* const opLhwiAddr)
{
    auto& opLhwi = *static_cast<RtStarsCondOpLHWI*>(opLhwiAddr);
    opLhwi.opCode = RT_STARS_COND_ISA_OP_CODE_LWI;
    opLhwi.func3 = RT_STARS_COND_ISA_LWI_FUNC3_LHWI;
    opLhwi.rd = dstReg;
    opLhwi.immd = static_cast<uint32_t>((immd >> 49U) & 0x7FFFU);
}

static void ConstructLlwi(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, void* const opLlwiAddr)
{
    auto& opLlwi = *static_cast<RtStarsCondOpLLWI*>(opLlwiAddr);
    opLlwi.opCode = RT_STARS_COND_ISA_OP_CODE_LWI;
    opLlwi.func3 = RT_STARS_COND_ISA_LWI_FUNC3_LLWI;
    opLlwi.rd = dstReg;
    opLlwi.immdHigh = static_cast<uint32_t>((immd >> 32U) & 0x1FFFFU);
    opLlwi.immdLow = static_cast<uint32_t>(immd & 0xFFFFFFFFU);
}

static void ConstructBranch(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
    const rtStarsCondIsaBranchFunc3_t func3, const uint8_t instrOffset, void* const opBranchAddr)
{
    auto& opBranch = *static_cast<RtStarsCondOpBranch*>(opBranchAddr);
    opBranch.opCode = RT_STARS_COND_ISA_OP_CODE_BRANCH;
    opBranch.func3 = func3;
    opBranch.rs1 = rs1Reg;
    opBranch.rs2 = rs2Reg;
    opBranch.jumpInstrOffset = instrOffset & 0xFU;
}

static void ConstructLoop(
    const rtStarsCondIsaRegister_t rs1Reg, const uint16_t delayCycle, const uint8_t instrOffset, void* const opLoopAddr)
{
    auto& opLoop = *static_cast<RtStarsCondOpLoop*>(opLoopAddr);
    opLoop.opCode = RT_STARS_COND_ISA_OP_CODE_LOOP;
    opLoop.func3 = 0U;
    opLoop.rs1 = rs1Reg;
    opLoop.jumpInstrOffset = instrOffset & 0xFU;
    opLoop.delayCycle = delayCycle & 0x1FFFU;
}

static void ConstructActiveI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, void* const opActiveIAddr)
{
    auto& opActiveI = *static_cast<RtStarsCondOpStreamActiveI*>(opActiveIAddr);
    opActiveI.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opActiveI.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_I;
    opActiveI.rd = dstReg;
    opActiveI.sqId = activeStreamSqId;
}

static void ConstructDeActiveI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t deActiveStreamSqId, void* const opDeActiveIAddr)
{
    auto& opDeActiveI = *static_cast<RtStarsCondOpStreamDeActiveI*>(opDeActiveIAddr);
    opDeActiveI.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opDeActiveI.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_I;
    opDeActiveI.rd = dstReg;
    opDeActiveI.sqId = deActiveStreamSqId;
}

static void ConstructActiveR(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, void* const opActiveRAddr)
{
    auto& opActiveR = *static_cast<RtStarsCondOpStreamActiveR*>(opActiveRAddr);
    opActiveR.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opActiveR.rd = dstReg;
    opActiveR.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_R;
    opActiveR.rs1 = rs1Reg;
}

static void ConstructDeActiveR(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, void* const opDeActiveRAddr)
{
    auto& opDeActiveR = *static_cast<RtStarsCondOpStreamDeActiveR*>(opDeActiveRAddr);
    opDeActiveR.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opDeActiveR.rd = dstReg;
    opDeActiveR.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_R;
    opDeActiveR.rs1 = rs1Reg;
}

static void ConstructGotoI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, const uint16_t head,
    void* const opGotoIAddr)
{
    auto& opGotoI = *static_cast<RtStarsCondOpStreamGotoI*>(opGotoIAddr);
    opGotoI.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opGotoI.rd = dstReg;
    opGotoI.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_I;
    opGotoI.sqId = activeStreamSqId;
    opGotoI.sqHead = head;
}

static void ConstructGotoR(
    const rtStarsCondIsaRegister_t sr1Reg, const rtStarsCondIsaRegister_t dstReg, void* const opGotoRAddr)
{
    auto& opGotoR = *static_cast<RtStarsCondOpStreamGotoR*>(opGotoRAddr);
    opGotoR.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opGotoR.rd = dstReg;
    opGotoR.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_R;
    opGotoR.rs1 = sr1Reg;
}

static void ConstructStore(
    const rtStarsCondIsaRegister_t addrReg, const rtStarsCondIsaRegister_t valReg, const uint16_t immdOffset,
    const RtStarsCondIsaStoreFunc3 func3, void* const opStoreAddr)
{
    auto& opStore = *static_cast<RtStarsCondOpStore*>(opStoreAddr);
    opStore.opCode = RT_STARS_COND_ISA_OP_CODE_STORE;
    opStore.immdLow = static_cast<uint8_t>(immdOffset & 0x1FU);
    opStore.func3 = func3;
    opStore.rs1 = addrReg;
    opStore.rs2 = valReg;
    opStore.immdHigh = static_cast<uint8_t>((immdOffset & 0xFE0U) >> 5U);
}

static void ConstructSystemCsr(
    const rtStarsCondIsaRegister_t srReg, const rtStarsCondIsaRegister_t dstReg, const rtStarsCondCsrRegister_t csrReg,
    const rtStarsCondIsaSystemFunc3_t func3, void* const opCsrAddr)
{
    auto& opCsr = *static_cast<RtStarsCondOpSystemCsr*>(opCsrAddr);
    opCsr.opCode = RT_STARS_COND_ISA_OP_CODE_SYSTEM;
    opCsr.rd = dstReg;
    opCsr.func3 = func3;
    opCsr.rs1 = srReg;
    opCsr.csrReg = csrReg;
}

static void ConstructFuncCall(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg, void* const opFuncCallAddr)
{
    auto& opFuncCall = *static_cast<RtStarsCondOpFuncCall*>(opFuncCallAddr);
    opFuncCall.opCode = RT_STARS_COND_ISA_OP_CODE_FUNC_CALL;
    opFuncCall.func3 = RT_STARS_COND_FUNC_CALL_FUNC3;
    opFuncCall.rs1 = rs1Reg;
    opFuncCall.rs2 = rs2Reg;
}

static void ConstructErrorInstr(void* const opErrInstrAddr)
{
    static_cast<RtStarsCondOpErrorInstr*>(opErrInstrAddr)->err = 0U;
}

static bool CondIsaConstructRegister()
{
    static const CondIsaConstructFuncs funcs = {
        &ConstructNop,     &ConstructLoad,      &ConstructLoadImm,   &ConstructOpImmAndi, &ConstructOpImmSlli,
        &ConstructOpOp,    &ConstructLhwi,      &ConstructLlwi,      &ConstructBranch,    &ConstructLoop,
        &ConstructActiveI, &ConstructDeActiveI, &ConstructActiveR,   &ConstructDeActiveR, &ConstructGotoI,
        &ConstructGotoR,   &ConstructStore,     &ConstructSystemCsr, &ConstructFuncCall,  &ConstructErrorInstr,
    };
    RegCondIsaConstructFunc(CHIP_DAVID, funcs);
    RegCondIsaConstructFunc(CHIP_ASCEND_350, funcs);
    return true;
}

static bool g_condIsaConstructRegister = CondIsaConstructRegister();

} // namespace
} // namespace runtime
} // namespace cce
