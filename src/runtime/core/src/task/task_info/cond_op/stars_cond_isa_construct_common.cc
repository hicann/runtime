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

void ConstructNop(RtStarsCondOpNop& nop)
{
    nop.opCode = RT_STARS_COND_ISA_OP_CODE_NOP;
    nop.rd = RT_STARS_COND_ISA_REGISTER_R0;
    nop.func3 = RT_STARS_COND_ISA_OP_IMM_FUNC3_NOP;
    nop.rs1 = RT_STARS_COND_ISA_REGISTER_R0;
    nop.immd = 0U;
}

// func3: LDR(LD_R)
void ConstructLoad(
    const rtStarsCondIsaRegister_t rs1Reg, const uint16_t imd, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondIsaLoadFunc3_t func3, RtStarsCondOpLoad& load)
{
    load.opCode = RT_STARS_COND_ISA_OP_CODE_LOAD;
    load.rd = dstReg;
    load.func3 = func3;
    load.rs1 = rs1Reg;
    load.immd = imd;
}

void ConstructLoadImm(
    const rtStarsCondIsaRegister_t dstReg, const uint64_t addr, const rtStarsCondIsaLoadImmFunc3_t func3,
    RtStarsCondOpLoadImm& loadImm)
{
    loadImm.opCode = RT_STARS_COND_ISA_OP_CODE_LOAD_IMM;
    loadImm.rd = dstReg;
    loadImm.func3 = func3;
    loadImm.immdAddrHigh = static_cast<uint32_t>((addr >> 32U) & 0X1FFFFU); // bit[48:32]
    loadImm.immdAddrLow = static_cast<uint32_t>(addr & 0xFFFFFFFFU);        // bit[31:0]
}

// func3 :ADDI/SLTI[U]/ANDI/ORI/XORI
void ConstructOpImmAndi(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, const uint32_t immd,
    const RtStarsCondIsaOpImmFunc3 func3, RtStarsCondOpImm& opImmAndi)
{
    opImmAndi.opCode = RT_STARS_COND_ISA_OP_CODE_OP_IMM;
    opImmAndi.rd = dstReg;
    opImmAndi.func3 = func3;
    opImmAndi.rs1 = rs1Reg;
    opImmAndi.immd = static_cast<uint32_t>(immd & 0xFFFU);
}

void ConstructOpImmSlli(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, const uint8_t shamt,
    const RtStarsCondIsaOpImmFunc3 func3, const rtStarsCondIsaOpImmFunc7_t func7, RtStarsCondOpImmSLLI& opImmSlli)
{
    opImmSlli.opCode = RT_STARS_COND_ISA_OP_CODE_OP_IMM;
    opImmSlli.rd = dstReg;
    opImmSlli.func3 = func3;
    opImmSlli.rs1 = rs1Reg;
    opImmSlli.shamt = shamt;
    opImmSlli.func7 = func7;
}

void ConstructOpOp(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondIsaOpFunc3_t func3, const RtStarsCondIsaOpFunc7 func7, RtStarsCondOpOp& opOp)
{
    opOp.opCode = RT_STARS_COND_ISA_OP_CODE_OP;
    opOp.rd = dstReg;
    opOp.func3 = func3;
    opOp.rs1 = rs1Reg;
    opOp.rs2 = rs2Reg;
    opOp.func7 = func7;
}

void ConstructLHWI(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, RtStarsCondOpLHWI& opLHWI)
{
    opLHWI.opCode = RT_STARS_COND_ISA_OP_CODE_LWI;
    opLHWI.func3 = RT_STARS_COND_ISA_LWI_FUNC3_LHWI;
    opLHWI.rd = dstReg;
    opLHWI.immd = static_cast<uint32_t>((immd >> 49U) & 0x7FFFU); // High15-immd[63:49]
}

void ConstructLLWI(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, RtStarsCondOpLLWI& opLLWI)
{
    opLLWI.opCode = RT_STARS_COND_ISA_OP_CODE_LWI;
    opLLWI.func3 = RT_STARS_COND_ISA_LWI_FUNC3_LLWI;
    opLLWI.rd = dstReg;
    opLLWI.immdHigh = static_cast<uint32_t>((immd >> 32U) & 0x1FFFFU); // Low49-immd[48:32]
    opLLWI.immdLow = static_cast<uint32_t>(immd & 0xFFFFFFFFU);        // Low49-immd[31:0]
}

void ConstructBranch(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
    const rtStarsCondIsaBranchFunc3_t func3, const uint8_t instrOffset, RtStarsCondOpBranch& opBranch)
{
    opBranch.opCode = RT_STARS_COND_ISA_OP_CODE_BRANCH;
    opBranch.func3 = func3;
    opBranch.rs1 = rs1Reg;
    opBranch.rs2 = rs2Reg;
    opBranch.jumpInstrOffset = instrOffset & 0xFU; // Jump-immd[3:0]
}

void ConstructLoop(
    const rtStarsCondIsaRegister_t rs1Reg, const uint16_t delayCycle, const uint8_t instrOffset,
    RtStarsCondOpLoop& opLoop)
{
    opLoop.opCode = RT_STARS_COND_ISA_OP_CODE_LOOP;
    opLoop.func3 = 0U;                           // loop is only one func
    opLoop.rs1 = rs1Reg;
    opLoop.jumpInstrOffset = instrOffset & 0xFU; // Jump-immd[3:0]
    opLoop.delayCycle = delayCycle & 0x1FFFU;    // delayCycle[12:0]
}

void ConstructGotoI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, const uint16_t head,
    RtStarsCondOpStreamGotoI& opGotoI)
{
    opGotoI.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opGotoI.rd = dstReg;
    opGotoI.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_I;
    opGotoI.sqId = activeStreamSqId;
    opGotoI.sqHead = head;
}

void ConstructActiveI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, RtStarsCondOpStreamActiveI& opActiveI)
{
    opActiveI.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opActiveI.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_I;
    opActiveI.rd = dstReg;
    opActiveI.sqId = activeStreamSqId;
}

void ConstructDeActiveI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t deActiveStreamSqId, RtStarsCondOpStreamDeActiveI& opDeActiveI)
{
    opDeActiveI.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opDeActiveI.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_I;
    opDeActiveI.rd = dstReg;
    opDeActiveI.sqId = deActiveStreamSqId;
}

void ConstructActiveR(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, RtStarsCondOpStreamActiveR& opActiveR)
{
    opActiveR.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opActiveR.rd = dstReg;
    opActiveR.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_R;
    opActiveR.rs1 = rs1Reg;
}

void ConstructDeActiveR(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg,
    RtStarsCondOpStreamDeActiveR& opDeActiveR)
{
    opDeActiveR.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opDeActiveR.rd = dstReg;
    opDeActiveR.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_R;
    opDeActiveR.rs1 = rs1Reg;
}

void ConstructGotoR(
    const rtStarsCondIsaRegister_t sr1Reg, const rtStarsCondIsaRegister_t dstReg, RtStarsCondOpStreamGotoR& opGotoR)
{
    opGotoR.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opGotoR.rd = dstReg;
    opGotoR.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_R;
    opGotoR.rs1 = sr1Reg;
}

void ConstructStore(
    const rtStarsCondIsaRegister_t addrReg, const rtStarsCondIsaRegister_t valReg, const uint16_t immdOffset,
    const RtStarsCondIsaStoreFunc3 func3, RtStarsCondOpStore& opStore)
{
    opStore.opCode = RT_STARS_COND_ISA_OP_CODE_STORE;
    opStore.immdLow = static_cast<uint8_t>(immdOffset & 0x1FU); // S-immd[4:0]
    opStore.func3 = func3;
    opStore.rs1 = addrReg;
    opStore.rs2 = valReg;
    opStore.immdHigh = static_cast<uint8_t>((immdOffset & 0xFE0U) >> 5U); // S-immd[11:5]
}

void ConstructSystemCsr(
    const rtStarsCondIsaRegister_t srReg, const rtStarsCondIsaRegister_t dstReg, const rtStarsCondCsrRegister_t csrReg,
    const rtStarsCondIsaSystemFunc3_t func3, RtStarsCondOpSystemCsr& opCsr)
{
    opCsr.opCode = RT_STARS_COND_ISA_OP_CODE_SYSTEM;
    opCsr.rd = dstReg;
    opCsr.func3 = func3;
    opCsr.rs1 = srReg;
    opCsr.csrReg = csrReg;
}

void ConstructFuncCall(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg, RtStarsCondOpFuncCall& opFuncCall)
{
    opFuncCall.opCode = RT_STARS_COND_ISA_OP_CODE_FUNC_CALL;
    opFuncCall.func3 = RT_STARS_COND_FUNC_CALL_FUNC3;
    opFuncCall.rs1 = rs1Reg;
    opFuncCall.rs2 = rs2Reg;
}

void ConstructErrorInstr(RtStarsCondOpErrorInstr& opErrInstr) { opErrInstr.err = 0U; }

} // namespace runtime
} // namespace cce
