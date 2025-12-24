/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_STARS_COND_ISA_HELPER_HPP__
#define __CCE_RUNTIME_STARS_COND_ISA_HELPER_HPP__

#include "stars_cond_isa_define.hpp"
#include "stars_cond_isa_struct.hpp"
#include "stars.hpp"
#include "runtime/base.h"

namespace cce {
namespace runtime {

void ConstructRdmaSink1Instr(
    const uint32_t piInit, const uint8_t sqDepthBitWidth, const uint64_t svmAddr, RtStarsRdmaSinkSqe1 &sqe);
void ConstructRdmaSink2Instr(const uint64_t dbAddr, const uint64_t dbInfoWithoutPi, RtStarsRdmaSinkSqe2 &sqe);
void ConstrucStreamResetInstr(const uint32_t sqId, const uint64_t sqEnReg, RtStarsStreamResetHeadSqe &sqe);
void ConstrucModelExeScanSq(rtStarsModelExeFuncCallPara_t &funcCallPara, RtStarsModelExeScanSq &scanSq);
void ConstrucModelExeCheckSqFsm(rtStarsModelExeFuncCallPara_t &funcCallPara, RtStarsModelExeCheckSqFsm &checkSqFsm);
void ConstrucModelExeCheckSqDisable(
    rtStarsModelExeFuncCallPara_t &funcCallPara, RtStarsModelExeCheckSqDisable &checkSqDisable);
void ConstrucModelExeCheckSqHeadTail(
    const rtStarsModelExeFuncCallPara_t &funcCallPara, RtStarsModelExeCheckSqHeadTail &checkSqHeadTail);
void ConstrucModelExeDeactiveSq(RtStarsModelExeDeactiveSq &deactiveSq);
void ConstrucModelExeActiveHeadSq(rtStarsModelExeFuncCallPara_t &funcCallPara, RtStarsModelExeActiveSq &activeHeadSq);
void ConstrucModelExeCheckSqDisableErrInstr(
    const rtStarsModelExeFuncCallPara_t &funcCallPara, RtStarsModelExeCheckSqErrInstr &errInstr);
void ConstrucModelExeCheckSqHeadTailErrInstr(
    const rtStarsModelExeFuncCallPara_t &funcCallPara, RtStarsModelExeCheckSqErrInstr &errInstr);
void ConstrucModelExeErrInstr(RtStarsModelExeExeErrInstr &errInstr);
void ConstrucModelExeEndInstrr(RtStarsModelExeExeEndInstr &endInstr);
void ConstrucModelExeFuncCall(rtStarsModelExeFuncCallPara_t &funcCallPara, RtStarsModelExeFuncCall &funcCall);
void ConstructStreamActiveFc(
    RtStarsStreamActiveFc &fc, const rtStarsStreamActiveFcPara_t &fcPara, const uint32_t offsetStart);
void ConstructStreamSwitchFc(rtStarsStreamSwitchFc_t &fc, const rtStarsStreamSwitchFcPara_t &fcPara);
void ConstructStreamSwitchExFc(rtStarsStreamSwitchExFc_t &fc, const rtStarsStreamSwitchExFcPara_t &fcPara);
void ConstructLabelSwitchByIndexFc(rtStarsLabelSwitchByIndexFc_t &fc, const rtStarsLabelSwitchByIndexFcPara_t &fcPara,
    const uint16_t currentStreamSqId);
void ConstructMemWaitValueInstr2(RtStarsMemWaitValueLastInstrFc &fc, const RtStarsMemWaitValueInstrFcPara &fcPara);
void ConstructMemWaitValueInstr2Ex(RtStarsMemWaitValueLastInstrFcEx &fc, const RtStarsMemWaitValueInstrFcPara &fcPara);
void ConvertConditionToOpAndBranchFunc(const RtStarsMemWaitValueInstrFcPara &fcPara,
    rtStarsCondIsaBranchFunc3_t &branchFunc, rtStarsCondIsaOpFunc3_t &opFunc3, RtStarsCondIsaOpFunc7 &opFunc7,
    uint64_t &value1, uint64_t &value2);
void ConvertOpToReverseOp(const rtStarsCondIsaBranchFunc3_t branchFunc, rtStarsCondIsaBranchFunc3_t &reverseBranchFunc);

void ConstructRdmaPiValueModifyInstr(
    uint64_t piValueArrAddr, uint64_t piValueVecLength, uint64_t dfxAddr, RtStarsPivalueModifyFuncCall &fc);

void ConstructNop(RtStarsCondOpNop &nop);

void ConstructLoad(const rtStarsCondIsaRegister_t rs1Reg, const uint16_t imd, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondIsaLoadFunc3_t func3, RtStarsCondOpLoad &load);

void ConstructLoadImm(const rtStarsCondIsaRegister_t dstReg, const uint64_t addr,
    const rtStarsCondIsaLoadImmFunc3_t func3, RtStarsCondOpLoadImm &loadImm);

void ConstructOpImmAndi(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg,
    const uint32_t immd, const RtStarsCondIsaOpImmFunc3 func3, RtStarsCondOpImm &opImmAndi);

void ConstructOpImmSlli(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg,
    const uint8_t shamt, const RtStarsCondIsaOpImmFunc3 func3, const rtStarsCondIsaOpImmFunc7_t func7,
    RtStarsCondOpImmSLLI &opImmSlli);

void ConstructOpOp(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
    const rtStarsCondIsaRegister_t dstReg, const rtStarsCondIsaOpFunc3_t func3, const RtStarsCondIsaOpFunc7 func7,
    RtStarsCondOpOp &opOp);

void ConstructLHWI(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, RtStarsCondOpLHWI &opLHWI);

void ConstructLLWI(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd, RtStarsCondOpLLWI &opLLWI);

void ConstructBranch(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
    const rtStarsCondIsaBranchFunc3_t func3, const uint8_t instrOffset, RtStarsCondOpBranch &opBranch);

void ConstructLoop(const rtStarsCondIsaRegister_t rs1Reg, const uint16_t delayCycle, const uint8_t instrOffset,
    RtStarsCondOpLoop &opLoop);

void ConstructActiveI(
    const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, RtStarsCondOpStreamActiveI &opActiveI);

void ConstructDeActiveI(const rtStarsCondIsaRegister_t dstReg, const uint16_t deActiveStreamSqId,
    RtStarsCondOpStreamDeActiveI &opDeActiveI);

void ConstructActiveR(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg,
    RtStarsCondOpStreamActiveR &opActiveR);
void ConstructDeActiveR(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg,
    RtStarsCondOpStreamDeActiveR &opDeActiveR);

void ConstructGotoI(const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId, const uint16_t head,
    RtStarsCondOpStreamGotoI &opGotoI);

void ConstructGotoR(
    const rtStarsCondIsaRegister_t sr1Reg, const rtStarsCondIsaRegister_t dstReg, RtStarsCondOpStreamGotoR &opGotoR);

void ConvertConditionToBranchFunc3(
    const rtCondition_t condition, rtStarsCondIsaBranchFunc3_t &func3, bool &isNeedReverseCmpReg);

void ConstructStore(const rtStarsCondIsaRegister_t addrReg, const rtStarsCondIsaRegister_t valReg,
    const uint16_t immdOffset, const RtStarsCondIsaStoreFunc3 func3, RtStarsCondOpStore &opStore);

void ConstructSystemCsr(const rtStarsCondIsaRegister_t srReg, const rtStarsCondIsaRegister_t dstReg,
    const rtStarsCondCsrRegister_t csrReg, const rtStarsCondIsaSystemFunc3_t func3, RtStarsCondOpSystemCsr &opCsr);

void ConstructFuncCall(
    const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg, RtStarsCondOpFuncCall &opFuncCall);

void ConstructErrorInstr(RtStarsCondOpErrorInstr &opErrInstr);

rtCondition_t GetNotCondition(const rtCondition_t condition);

void ConstructGetSqFsmStateFcI(const rtStarsCondIsaRegister_t sqFsmStateReg, const rtStarsCondIsaRegister_t sqIdReg,
    const rtStarsCondIsaRegister_t maskReg, const uint32_t sqId, const uint64_t addr,
    RtStarsGetSqFsmStateI &getSqFsmState);

void ConstructSetJumpPcFc(
    const rtStarsCondIsaRegister_t offsetReg, const uint64_t offset, RtStarsSetCsrJumpPc &setCsrJumpPc);

void ConstructSetCqeStatus(
    const rtStarsCondIsaRegister_t srReg, const rtStarsCondIsaRegister_t dstReg, RtStarsSetCqeStatus &setCqeStatus);

void ConstructGetSqEnableFcI(
    const rtStarsCondIsaRegister_t sqEnableReg, const uint64_t addr, RtStarsGetSqEnableI &getSqEnable);

void ConstructGetSqHeadAndTailFcI(const rtStarsCondIsaRegister_t headReg, const rtStarsCondIsaRegister_t tailReg,
    const uint64_t tailAddr, const uint64_t headAddr, RtStarsGetSqHeadAndTailI &getSqheadAndTail);

void ConstructDisableStreamFcI(
    const rtStarsCondIsaRegister_t addrReg, const uint64_t addr, RtStarsDisableStreamI &disableStream);

void ConstructAddStreamActiveTimesFcI(const rtStarsCondIsaRegister_t svmAddrReg, const rtStarsCondIsaRegister_t valReg,
    const uint64_t svmAddr, RtStarsAddStreamActiveTimes &addStreamActiveTimes);

void ConstructLabelSwitchByIdxCheckFc(const uint64_t indexPtr, const uint32_t maxVal, const uint64_t addr,
    RtStarsLabelSwitchByIdxCheck &labelSwitchByIdx);

void ConstructSwitchGetSqHeadAndTailFcI(const rtStarsCondIsaRegister_t headReg, const rtStarsCondIsaRegister_t tailReg,
    const rtStarsCondIsaRegister_t addrReg, RtStarsSwitchGetSqHeadAndTailI &getSqheadAndTail,
    const rtStarsLabelSwitchByIndexFcPara_t &fcPara);
void ConstructSwitchGetSqVirtualAddrFcI(const rtStarsCondIsaRegister_t sqIdReg,
    const rtStarsCondIsaRegister_t sqVirtualAddrReg, const uint64_t deviceMemForVirAddr,
    rtStarsLabelSwitchByIndexFc_t &labelSwitchByIdxFc);

void ConstructSwitchGetSqEnableFcI(const rtStarsCondIsaRegister_t sqEnableReg, const rtStarsCondIsaRegister_t sqAddrReg,
    RtStarsSwitchGetSqEnableI &getSqEnable);

void ConstructSwitchDisableStreamFcI(
    const rtStarsCondIsaRegister_t addrReg, RtStarsSwitchDisableStreamI &disableStream);

void ConstructAddExecTimesFc(const uint64_t indexPtr, const uint64_t labelInfoPtr, RtStarsAddExecTimesFc &fc);

template <typename T>
void ConstructGetFloatStatusInstr(const uint64_t svmAddr, const uint64_t svmSize, T &sqe)
{
    (void)svmSize;
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;

    ConstructLoadImm(r1, svmAddr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD, sqe.ldi);

    ConstructLLWI(r2, 0U, sqe.llwi);

    ConstructStore(r1, r2, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, sqe.sdOverflowCnt);

    uint16_t offset = 8U;  // SD write by 8byte
    for (RtStarsCondOpStore &sd : sqe.sdZero) {
        ConstructStore(r1, r0, offset, RT_STARS_COND_ISA_STORE_FUNC3_SD, sd);
        offset += 8U;  // SD write by 8byte
    }
}

template <typename T>
void ConstructFunctionCallInstr(const uint64_t funcAddr, const uint64_t funcCallSize, T &sqe)
{
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;

    // load Func_call instructions address as a immediate to r1
    ConstructLHWI(r1, funcAddr, sqe.lhwi1);
    ConstructLLWI(r1, funcAddr, sqe.llwi1);

    // load the memory size of func_call instructions as a immediate to r2
    ConstructLHWI(r2, funcCallSize, sqe.lhwi2);
    ConstructLLWI(r2, funcCallSize, sqe.llwi2);

    // Construct func_call instruction
    ConstructFuncCall(r1, r2, sqe.funcCall);

    // NOP
    for (RtStarsCondOpNop &nop : sqe.nop) {
        ConstructNop(nop);
    }
}

}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_STARS_COND_ISA_HELPER_HPP__
