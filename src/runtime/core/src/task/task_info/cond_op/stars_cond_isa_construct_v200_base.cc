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
#include "inner_thread_local.hpp"
#include "stars_cond_isa_helper.hpp"

namespace cce {
namespace runtime {
namespace {

template <typename Func, typename... Args>
static void InvokeCondIsaConstruct(Func CondIsaConstructFuncs::*const funcMember, Args... args)
{
    const rtChipType_t chipType = InnerThreadLocalContainer::GetCurrentChipType();
    if (unlikely((chipType < CHIP_BEGIN) || (chipType >= CHIP_END))) {
        RT_LOG(RT_LOG_ERROR, "Invalid chipType = %d, valid range: [%d, %d).", chipType, CHIP_BEGIN, CHIP_END);
        return;
    }

    Func const func = g_condIsaConstructFunc[chipType].*funcMember;
    if (unlikely(func == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "Cond ISA construct function is not registered, chipType = %d.", chipType);
        return;
    }
    func(args...);
}

} // namespace

void ConstructNop(RtStarsCondOpNop& nop) { InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructNop, &nop); }

void ConstructLoad(
    const rtStarsCondIsaRegister_t rs1Reg, const uint16_t imd, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondIsaLoadFunc3_t func3, RtStarsCondOpLoad& load)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructLoad, rs1Reg, imd, dstReg, func3, &load);
}

void ConstructLoadImm(
    const rtStarsCondIsaRegister_t dstReg, const uint64_t addr, const rtStarsCondIsaLoadImmFunc3_t func3,
    RtStarsCondOpLoadImm& loadImm)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructLoadImm, dstReg, addr, func3, &loadImm);
}

void ConstructOpImmAndi(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, const uint32_t immd,
    const RtStarsCondIsaOpImmFunc3 func3, RtStarsCondOpImm& opImmAndi)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructOpImmAndi, rs1Reg, dstReg, immd, func3, &opImmAndi);
}

void ConstructOpImmSlli(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, const uint8_t shamt,
    const RtStarsCondIsaOpImmFunc3 func3, const rtStarsCondIsaOpImmFunc7_t func7, RtStarsCondOpImmSLLI& opImmSlli)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructOpImmSlli, rs1Reg, dstReg, shamt, func3, func7, &opImmSlli);
}

void ConstructOpOp(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondIsaOpFunc3_t func3, const RtStarsCondIsaOpFunc7 func7, RtStarsCondOpOp& opOp)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructOpOp, rs1Reg, rs2Reg, dstReg, func3, func7, &opOp);
}

void ConstructLHWI(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, RtStarsCondOpLHWI& opLhwi)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructLhwi, dstReg, immd, &opLhwi);
}

void ConstructLLWI(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, RtStarsCondOpLLWI& opLlwi)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructLlwi, dstReg, immd, &opLlwi);
}

void ConstructBranch(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
    const rtStarsCondIsaBranchFunc3_t func3, const uint8_t instrOffset, RtStarsCondOpBranch& opBranch)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructBranch, rs1Reg, rs2Reg, func3, instrOffset, &opBranch);
}

void ConstructLoop(
    const rtStarsCondIsaRegister_t rs1Reg, const uint16_t delayCycle, const uint8_t instrOffset,
    RtStarsCondOpLoop& opLoop)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructLoop, rs1Reg, delayCycle, instrOffset, &opLoop);
}

void ConstructGotoI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, const uint16_t head,
    RtStarsCondOpStreamGotoI& opGotoI)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructGotoI, dstReg, activeStreamSqId, head, &opGotoI);
}

void ConstructActiveI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, RtStarsCondOpStreamActiveI& opActiveI)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructActiveI, dstReg, activeStreamSqId, &opActiveI);
}

void ConstructDeActiveI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t deActiveStreamSqId, RtStarsCondOpStreamDeActiveI& opDeActiveI)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructDeActiveI, dstReg, deActiveStreamSqId, &opDeActiveI);
}

void ConstructActiveR(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, RtStarsCondOpStreamActiveR& opActiveR)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructActiveR, rs1Reg, dstReg, &opActiveR);
}

void ConstructDeActiveR(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg,
    RtStarsCondOpStreamDeActiveR& opDeActiveR)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructDeActiveR, rs1Reg, dstReg, &opDeActiveR);
}

void ConstructGotoR(
    const rtStarsCondIsaRegister_t sr1Reg, const rtStarsCondIsaRegister_t dstReg, RtStarsCondOpStreamGotoR& opGotoR)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructGotoR, sr1Reg, dstReg, &opGotoR);
}

void ConstructStore(
    const rtStarsCondIsaRegister_t addrReg, const rtStarsCondIsaRegister_t valReg, const uint16_t immdOffset,
    const RtStarsCondIsaStoreFunc3 func3, RtStarsCondOpStore& opStore)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructStore, addrReg, valReg, immdOffset, func3, &opStore);
}

void ConstructSystemCsr(
    const rtStarsCondIsaRegister_t srReg, const rtStarsCondIsaRegister_t dstReg, const rtStarsCondCsrRegister_t csrReg,
    const rtStarsCondIsaSystemFunc3_t func3, RtStarsCondOpSystemCsr& opCsr)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructSystemCsr, srReg, dstReg, csrReg, func3, &opCsr);
}

void ConstructFuncCall(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg, RtStarsCondOpFuncCall& opFuncCall)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructFuncCall, rs1Reg, rs2Reg, &opFuncCall);
}

void ConstructErrorInstr(RtStarsCondOpErrorInstr& opErrInstr)
{
    InvokeCondIsaConstruct(&CondIsaConstructFuncs::constructErrorInstr, &opErrInstr);
}

} // namespace runtime
} // namespace cce
