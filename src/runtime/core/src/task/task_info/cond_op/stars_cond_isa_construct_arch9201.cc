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
#include "stars_cond_isa_define.hpp"

namespace cce {
namespace runtime {
namespace {

#pragma pack(push)
#pragma pack(1)

struct RtStarsCondOpLoadArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t immd : 12;
};

struct RtStarsCondOpLoadImmArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved : 1;
    uint32_t func3 : 3;
    uint32_t immdAddrHigh : 17;
    uint32_t immdAddrLow;
};

struct RtStarsCondOpStoreArch9201 {
    uint32_t opCode : 7;
    uint32_t immdLow : 5;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t rs2 : 4;
    uint32_t reserved2 : 1;
    uint32_t immdHigh : 7;
};

struct RtStarsCondOpImmArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t immd : 12;
};

struct RtStarsCondOpImmSLLIArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t shamt : 6;
    uint32_t func7 : 6;
};

struct RtStarsCondOpOpArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t rs2 : 4;
    uint32_t reserved3 : 1;
    uint32_t func7 : 7;
};

using RtStarsCondOpNopArch9201 = RtStarsCondOpImmArch9201;

struct RtStarsCondOpLHWIArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t reserved1 : 2;
    uint32_t immd : 15;
};

struct RtStarsCondOpLLWIArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t immdHigh : 17;
    uint32_t immdLow : 32;
};

struct RtStarsCondOpBranchArch9201 {
    uint32_t opCode : 7;
    uint32_t jumpInstrOffset : 4;
    uint32_t rsvd : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t rsvd1 : 1;
    uint32_t rs2 : 4;
    uint32_t rsvd2 : 1;
    uint32_t rsvd3 : 7;
};

struct RtStarsCondOpStreamActiveIArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t reserved1 : 5;
    uint32_t sqId : 12;
};

using RtStarsCondOpStreamDeActiveIArch9201 = RtStarsCondOpStreamActiveIArch9201;

struct RtStarsCondOpStreamActiveRArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t reserved2 : 12;
};

using RtStarsCondOpStreamDeActiveRArch9201 = RtStarsCondOpStreamActiveRArch9201;

struct RtStarsCondOpStreamGotoIArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t reserved1 : 17;
    uint32_t sqId : 11;
    uint32_t reserved2 : 5;
    uint32_t sqHead : 16;
};

struct RtStarsCondOpStreamGotoRArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t reserved2 : 12;
};

struct RtStarsCondOpLoopArch9201 {
    uint32_t opCode : 7;
    uint32_t jumpInstrOffset : 4;
    uint32_t rsvd : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t delayCycle : 13;
};

struct RtStarsCondOpSystemCsrArch9201 {
    uint32_t opCode : 7;
    uint32_t rd : 4;
    uint32_t reserved0 : 1;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved1 : 1;
    uint32_t csrReg : 12;
};

struct RtStarsCondOpFuncCallArch9201 {
    uint32_t opCode : 7;
    uint32_t reserved0 : 3;
    uint32_t reserved1 : 2;
    uint32_t func3 : 3;
    uint32_t rs1 : 4;
    uint32_t reserved2 : 1;
    uint32_t rs2 : 4;
    uint32_t reserved3 : 1;
    uint32_t reserved4 : 7;
};

struct RtStarsCondOpErrorInstrArch9201 {
    uint32_t err;
};

#pragma pack(pop)

static_assert(sizeof(RtStarsCondOpLoadArch9201) == sizeof(RtStarsCondOpLoad), "RtStarsCondOpLoad size mismatch");
static_assert(
    sizeof(RtStarsCondOpLoadImmArch9201) == sizeof(RtStarsCondOpLoadImm), "RtStarsCondOpLoadImm size mismatch");
static_assert(sizeof(RtStarsCondOpStoreArch9201) == sizeof(RtStarsCondOpStore), "RtStarsCondOpStore size mismatch");
static_assert(sizeof(RtStarsCondOpImmArch9201) == sizeof(RtStarsCondOpImm), "RtStarsCondOpImm size mismatch");
static_assert(
    sizeof(RtStarsCondOpImmSLLIArch9201) == sizeof(RtStarsCondOpImmSLLI), "RtStarsCondOpImmSLLI size mismatch");
static_assert(sizeof(RtStarsCondOpOpArch9201) == sizeof(RtStarsCondOpOp), "RtStarsCondOpOp size mismatch");
static_assert(sizeof(RtStarsCondOpLHWIArch9201) == sizeof(RtStarsCondOpLHWI), "RtStarsCondOpLHWI size mismatch");
static_assert(sizeof(RtStarsCondOpLLWIArch9201) == sizeof(RtStarsCondOpLLWI), "RtStarsCondOpLLWI size mismatch");
static_assert(sizeof(RtStarsCondOpBranchArch9201) == sizeof(RtStarsCondOpBranch), "RtStarsCondOpBranch size mismatch");
static_assert(
    sizeof(RtStarsCondOpStreamActiveIArch9201) == sizeof(RtStarsCondOpStreamActiveI),
    "RtStarsCondOpStreamActiveI size mismatch");
static_assert(
    sizeof(RtStarsCondOpStreamActiveRArch9201) == sizeof(RtStarsCondOpStreamActiveR),
    "RtStarsCondOpStreamActiveR size mismatch");
static_assert(
    sizeof(RtStarsCondOpStreamGotoIArch9201) == sizeof(RtStarsCondOpStreamGotoI),
    "RtStarsCondOpStreamGotoI size mismatch");
static_assert(
    sizeof(RtStarsCondOpStreamGotoRArch9201) == sizeof(RtStarsCondOpStreamGotoR),
    "RtStarsCondOpStreamGotoR size mismatch");
static_assert(sizeof(RtStarsCondOpLoopArch9201) == sizeof(RtStarsCondOpLoop), "RtStarsCondOpLoop size mismatch");
static_assert(
    sizeof(RtStarsCondOpSystemCsrArch9201) == sizeof(RtStarsCondOpSystemCsr), "RtStarsCondOpSystemCsr size mismatch");
static_assert(
    sizeof(RtStarsCondOpFuncCallArch9201) == sizeof(RtStarsCondOpFuncCall), "RtStarsCondOpFuncCall size mismatch");
static_assert(
    sizeof(RtStarsCondOpErrorInstrArch9201) == sizeof(RtStarsCondOpErrorInstr),
    "RtStarsCondOpErrorInstr size mismatch");

static void ConstructNop(void* const nopAddr)
{
    auto* const nop = static_cast<RtStarsCondOpNopArch9201*>(nopAddr);
    nop->opCode = RT_STARS_COND_ISA_OP_CODE_NOP;
    nop->rd = RT_STARS_COND_ISA_REGISTER_R0;
    nop->func3 = RT_STARS_COND_ISA_OP_IMM_FUNC3_NOP;
    nop->rs1 = RT_STARS_COND_ISA_REGISTER_R0;
    nop->immd = 0U;
}

static void ConstructLoad(
    const rtStarsCondIsaRegister_t rs1Reg, const uint16_t imd, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondIsaLoadFunc3_t func3, void* const loadAddr)
{
    auto* const load = static_cast<RtStarsCondOpLoadArch9201*>(loadAddr);
    load->opCode = RT_STARS_COND_ISA_OP_CODE_LOAD;
    load->rd = dstReg;
    load->func3 = func3;
    load->rs1 = rs1Reg;
    load->immd = imd;
}

static void ConstructLoadImm(
    const rtStarsCondIsaRegister_t dstReg, const uint64_t addr, const rtStarsCondIsaLoadImmFunc3_t func3,
    void* const loadImmAddr)
{
    auto* const loadImm = static_cast<RtStarsCondOpLoadImmArch9201*>(loadImmAddr);
    loadImm->opCode = RT_STARS_COND_ISA_OP_CODE_LOAD_IMM;
    loadImm->rd = dstReg;
    loadImm->func3 = func3;
    loadImm->immdAddrHigh = static_cast<uint32_t>((addr >> 32U) & 0x1FFFFU);
    loadImm->immdAddrLow = static_cast<uint32_t>(addr & 0xFFFFFFFFU);
}

static void ConstructOpImmAndi(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, const uint32_t immd,
    const RtStarsCondIsaOpImmFunc3 func3, void* const opImmAndiAddr)
{
    auto* const opImmAndi = static_cast<RtStarsCondOpImmArch9201*>(opImmAndiAddr);
    opImmAndi->opCode = RT_STARS_COND_ISA_OP_CODE_OP_IMM;
    opImmAndi->rd = dstReg;
    opImmAndi->func3 = func3;
    opImmAndi->rs1 = rs1Reg;
    opImmAndi->immd = static_cast<uint32_t>(immd & 0xFFFU);
}

static void ConstructOpImmSlli(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, const uint8_t shamt,
    const RtStarsCondIsaOpImmFunc3 func3, const rtStarsCondIsaOpImmFunc7_t func7, void* const opImmSlliAddr)
{
    auto* const opImmSlli = static_cast<RtStarsCondOpImmSLLIArch9201*>(opImmSlliAddr);
    opImmSlli->opCode = RT_STARS_COND_ISA_OP_CODE_OP_IMM;
    opImmSlli->rd = dstReg;
    opImmSlli->func3 = func3;
    opImmSlli->rs1 = rs1Reg;
    opImmSlli->shamt = shamt;
    opImmSlli->func7 = func7;
}

static void ConstructOpOp(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondIsaOpFunc3_t func3, const RtStarsCondIsaOpFunc7 func7, void* const opOpAddr)
{
    auto* const opOp = static_cast<RtStarsCondOpOpArch9201*>(opOpAddr);
    opOp->opCode = RT_STARS_COND_ISA_OP_CODE_OP;
    opOp->rd = dstReg;
    opOp->func3 = func3;
    opOp->rs1 = rs1Reg;
    opOp->rs2 = rs2Reg;
    opOp->func7 = func7;
}

static void ConstructLhwi(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, void* const opLHWIAddr)
{
    auto* const opLHWI = static_cast<RtStarsCondOpLHWIArch9201*>(opLHWIAddr);
    opLHWI->opCode = RT_STARS_COND_ISA_OP_CODE_LWI;
    opLHWI->func3 = RT_STARS_COND_ISA_LWI_FUNC3_LHWI;
    opLHWI->rd = dstReg;
    opLHWI->immd = static_cast<uint32_t>((immd >> 49U) & 0x7FFFU);
}

static void ConstructLlwi(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, void* const opLLWIAddr)
{
    auto* const opLLWI = static_cast<RtStarsCondOpLLWIArch9201*>(opLLWIAddr);
    opLLWI->opCode = RT_STARS_COND_ISA_OP_CODE_LWI;
    opLLWI->func3 = RT_STARS_COND_ISA_LWI_FUNC3_LLWI;
    opLLWI->rd = dstReg;
    opLLWI->immdHigh = static_cast<uint32_t>((immd >> 32U) & 0x1FFFFU);
    opLLWI->immdLow = static_cast<uint32_t>(immd & 0xFFFFFFFFU);
}

static void ConstructBranch(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
    const rtStarsCondIsaBranchFunc3_t func3, const uint8_t instrOffset, void* const opBranchAddr)
{
    auto* const opBranch = static_cast<RtStarsCondOpBranchArch9201*>(opBranchAddr);
    opBranch->opCode = RT_STARS_COND_ISA_OP_CODE_BRANCH;
    opBranch->func3 = func3;
    opBranch->rs1 = rs1Reg;
    opBranch->rs2 = rs2Reg;
    opBranch->jumpInstrOffset = instrOffset & 0xFU;
}

static void ConstructLoop(
    const rtStarsCondIsaRegister_t rs1Reg, const uint16_t delayCycle, const uint8_t instrOffset, void* const opLoopAddr)
{
    auto* const opLoop = static_cast<RtStarsCondOpLoopArch9201*>(opLoopAddr);
    opLoop->opCode = RT_STARS_COND_ISA_OP_CODE_LOOP;
    opLoop->func3 = 0U;
    opLoop->rs1 = rs1Reg;
    opLoop->jumpInstrOffset = instrOffset & 0xFU;
    opLoop->delayCycle = delayCycle & 0x1FFFU;
}

static void ConstructActiveI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, void* const opActiveIAddr)
{
    auto* const opActiveI = static_cast<RtStarsCondOpStreamActiveIArch9201*>(opActiveIAddr);
    opActiveI->opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opActiveI->func3 = RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_I;
    opActiveI->rd = dstReg;
    opActiveI->sqId = activeStreamSqId;
}

static void ConstructDeActiveI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t deActiveStreamSqId, void* const opDeActiveIAddr)
{
    auto* const opDeActiveI = static_cast<RtStarsCondOpStreamDeActiveIArch9201*>(opDeActiveIAddr);
    opDeActiveI->opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opDeActiveI->func3 = RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_I;
    opDeActiveI->rd = dstReg;
    opDeActiveI->sqId = deActiveStreamSqId;
}

static void ConstructActiveR(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, void* const opActiveRAddr)
{
    auto* const opActiveR = static_cast<RtStarsCondOpStreamActiveRArch9201*>(opActiveRAddr);
    opActiveR->opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opActiveR->rd = dstReg;
    opActiveR->func3 = RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_R;
    opActiveR->rs1 = rs1Reg;
}

static void ConstructDeActiveR(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg, void* const opDeActiveRAddr)
{
    auto* const opDeActiveR = static_cast<RtStarsCondOpStreamDeActiveRArch9201*>(opDeActiveRAddr);
    opDeActiveR->opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opDeActiveR->rd = dstReg;
    opDeActiveR->func3 = RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_R;
    opDeActiveR->rs1 = rs1Reg;
}

static void ConstructGotoI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, const uint16_t head,
    void* const opGotoIAddr)
{
    auto* const opGotoI = static_cast<RtStarsCondOpStreamGotoIArch9201*>(opGotoIAddr);
    opGotoI->opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opGotoI->rd = dstReg;
    opGotoI->func3 = RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_I;
    opGotoI->sqId = activeStreamSqId;
    opGotoI->sqHead = head;
}

static void ConstructGotoR(
    const rtStarsCondIsaRegister_t sr1Reg, const rtStarsCondIsaRegister_t dstReg, void* const opGotoRAddr)
{
    auto* const opGotoR = static_cast<RtStarsCondOpStreamGotoRArch9201*>(opGotoRAddr);
    opGotoR->opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opGotoR->rd = dstReg;
    opGotoR->func3 = RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_R;
    opGotoR->rs1 = sr1Reg;
}

static void ConstructStore(
    const rtStarsCondIsaRegister_t addrReg, const rtStarsCondIsaRegister_t valReg, const uint16_t immdOffset,
    const RtStarsCondIsaStoreFunc3 func3, void* const opStoreAddr)
{
    auto* const opStore = static_cast<RtStarsCondOpStoreArch9201*>(opStoreAddr);
    opStore->opCode = RT_STARS_COND_ISA_OP_CODE_STORE;
    opStore->immdLow = static_cast<uint8_t>(immdOffset & 0x1FU);
    opStore->func3 = func3;
    opStore->rs1 = addrReg;
    opStore->rs2 = valReg;
    opStore->immdHigh = static_cast<uint8_t>((immdOffset & 0xFE0U) >> 5U);
}

static void ConstructSystemCsr(
    const rtStarsCondIsaRegister_t srReg, const rtStarsCondIsaRegister_t dstReg, const rtStarsCondCsrRegister_t csrReg,
    const rtStarsCondIsaSystemFunc3_t func3, void* const opCsrAddr)
{
    auto* const opCsr = static_cast<RtStarsCondOpSystemCsrArch9201*>(opCsrAddr);
    opCsr->opCode = RT_STARS_COND_ISA_OP_CODE_SYSTEM;
    opCsr->rd = dstReg;
    opCsr->func3 = func3;
    opCsr->rs1 = srReg;
    opCsr->csrReg = csrReg;
}

static void ConstructFuncCall(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg, void* const opFuncCallAddr)
{
    auto* const opFuncCall = static_cast<RtStarsCondOpFuncCallArch9201*>(opFuncCallAddr);
    opFuncCall->opCode = RT_STARS_COND_ISA_OP_CODE_FUNC_CALL;
    opFuncCall->func3 = RT_STARS_COND_FUNC_CALL_FUNC3;
    opFuncCall->rs1 = rs1Reg;
    opFuncCall->rs2 = rs2Reg;
}

static void ConstructErrorInstr(void* const opErrInstrAddr)
{
    static_cast<RtStarsCondOpErrorInstrArch9201*>(opErrInstrAddr)->err = 0U;
}

static bool CondIsaConstructRegister()
{
    static const CondIsaConstructFuncs funcs = {
        &ConstructNop,     &ConstructLoad,      &ConstructLoadImm,   &ConstructOpImmAndi, &ConstructOpImmSlli,
        &ConstructOpOp,    &ConstructLhwi,      &ConstructLlwi,      &ConstructBranch,    &ConstructLoop,
        &ConstructActiveI, &ConstructDeActiveI, &ConstructActiveR,   &ConstructDeActiveR, &ConstructGotoI,
        &ConstructGotoR,   &ConstructStore,     &ConstructSystemCsr, &ConstructFuncCall,  &ConstructErrorInstr,
    };
    RegCondIsaConstructFunc(CHIP_CLOUD_V5, funcs);
    return true;
}

static bool g_condIsaConstructRegister = CondIsaConstructRegister();

} // namespace

} // namespace runtime
} // namespace cce
