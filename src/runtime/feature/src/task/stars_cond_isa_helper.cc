/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_cond_isa_helper.hpp"
#include "runtime.hpp"
#include <map>

namespace cce {
namespace runtime {
rtCondition_t GetNotCondition(const rtCondition_t condition)
{
    static const std::map<rtCondition_t, rtCondition_t> notConditions = {{RT_EQUAL,            RT_NOT_EQUAL},
                                                                         {RT_NOT_EQUAL,        RT_EQUAL},
                                                                         {RT_GREATER,          RT_LESS_OR_EQUAL},
                                                                         {RT_GREATER_OR_EQUAL, RT_LESS},
                                                                         {RT_LESS,             RT_GREATER_OR_EQUAL},
                                                                         {RT_LESS_OR_EQUAL,    RT_GREATER}};
    const auto notCondition = notConditions.find(condition);
    if (notCondition == notConditions.end()) {
        return condition;
    }
    return notCondition->second;
}

void ConvertConditionToBranchFunc3(const rtCondition_t condition,
                                                       rtStarsCondIsaBranchFunc3_t &func3, bool &isNeedReverseCmpReg)
{
    /*
     * stars cond op is not same as runtime.
     * attention-1: when condition is true, it jump to end adn do nothing, but runtime is need jump to true stream.
     * attention-2: some op is not exits.
     */
    const rtCondition_t notCondition = GetNotCondition(condition);
    switch (notCondition) {
        case RT_EQUAL:
            // BEQ need convert to BNE as attention-1.
            func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
            isNeedReverseCmpReg = false;
            break;
        case RT_NOT_EQUAL:
            // BEQ need convert to BNE as attention-1.
            func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BNE;
            isNeedReverseCmpReg = false;
            break;
        case RT_GREATER:
            // rs1 > rs2 need convert to rs2 < rs1
            func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BLT;
            isNeedReverseCmpReg = true;
            break;
        case RT_GREATER_OR_EQUAL:
            func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BGE;
            isNeedReverseCmpReg = false;
            break;
        case RT_LESS:
            func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BLT;
            isNeedReverseCmpReg = false;
            break;
        case RT_LESS_OR_EQUAL:
            // rs1 <= rs2 need convert to rs2 >= rs1
            func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BGE;
            isNeedReverseCmpReg = true;
            break;
        default:
            RT_LOG(RT_LOG_WARNING, "condition=%d does not support, use equal instead.", condition);
            func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
            isNeedReverseCmpReg = false;
            break;
    }
}

void ConstructNop(RtStarsCondOpNop &nop)
{
    nop.opCode = RT_STARS_COND_ISA_OP_CODE_NOP;
    nop.rd = RT_STARS_COND_ISA_REGISTER_R0;
    nop.func3 = RT_STARS_COND_ISA_OP_IMM_FUNC3_NOP;
    nop.rs1 = RT_STARS_COND_ISA_REGISTER_R0;
    nop.immd = 0U;
}

// func3: LDR(LD_R)
void ConstructLoad(const rtStarsCondIsaRegister_t rs1Reg, const uint16_t imd,
                                       const rtStarsCondIsaRegister_t dstReg, const rtStarsCondIsaLoadFunc3_t func3,
                                       RtStarsCondOpLoad &load)
{
    load.opCode = RT_STARS_COND_ISA_OP_CODE_LOAD;
    load.rd = dstReg;
    load.func3 = func3;
    load.rs1 = rs1Reg;
    load.immd = imd;
}

void ConstructLoadImm(const rtStarsCondIsaRegister_t dstReg, const uint64_t addr,
                                          const rtStarsCondIsaLoadImmFunc3_t func3, RtStarsCondOpLoadImm &loadImm)
{
    loadImm.opCode = RT_STARS_COND_ISA_OP_CODE_LOAD_IMM;
    loadImm.rd = dstReg;
    loadImm.func3 = func3;
    loadImm.immdAddrHigh = static_cast<uint32_t>((addr >> 32U) & 0X1FFFFU); // bit[48:32]
    loadImm.immdAddrLow = static_cast<uint32_t>(addr & 0xFFFFFFFFU); // bit[31:0]
}

// func3 :ADDI/SLTI[U]/ANDI/ORI/XORI
void ConstructOpImmAndi(const rtStarsCondIsaRegister_t rs1Reg,
                                            const rtStarsCondIsaRegister_t dstReg, const uint32_t immd,
                                            const RtStarsCondIsaOpImmFunc3 func3, RtStarsCondOpImm &opImmAndi)
{
    opImmAndi.opCode = RT_STARS_COND_ISA_OP_CODE_OP_IMM;
    opImmAndi.rd = dstReg;
    opImmAndi.func3 = func3;
    opImmAndi.rs1 = rs1Reg;
    opImmAndi.immd = static_cast<uint32_t>(immd & 0xFFFU);
}

void ConstructOpImmSlli(const rtStarsCondIsaRegister_t rs1Reg,
                                            const rtStarsCondIsaRegister_t dstReg,
                                            const uint8_t shamt, const RtStarsCondIsaOpImmFunc3 func3,
                                            const rtStarsCondIsaOpImmFunc7_t func7, RtStarsCondOpImmSLLI &opImmSlli)
{
    opImmSlli.opCode = RT_STARS_COND_ISA_OP_CODE_OP_IMM;
    opImmSlli.rd = dstReg;
    opImmSlli.func3 = func3;
    opImmSlli.rs1   = rs1Reg;
    opImmSlli.shamt = shamt;
    opImmSlli.func7 = func7;
}

void ConstructOpOp(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
                                       const rtStarsCondIsaRegister_t dstReg, const rtStarsCondIsaOpFunc3_t func3,
                                       const RtStarsCondIsaOpFunc7 func7, RtStarsCondOpOp &opOp)
{
    opOp.opCode = RT_STARS_COND_ISA_OP_CODE_OP;
    opOp.rd     = dstReg;
    opOp.func3  = func3;
    opOp.rs1    = rs1Reg;
    opOp.rs2    = rs2Reg;
    opOp.func7  = func7;
}

void ConstructLHWI(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd,
                                       RtStarsCondOpLHWI &opLHWI)
{
    opLHWI.opCode = RT_STARS_COND_ISA_OP_CODE_LWI;
    opLHWI.func3 = RT_STARS_COND_ISA_LWI_FUNC3_LHWI;
    opLHWI.rd = dstReg;
    opLHWI.immd = static_cast<uint32_t>((immd >> 49U) & 0x7FFFU);    // High15-immd[63:49]
}

void ConstructLLWI(const rtStarsCondIsaRegister_t dstReg, const uint64_t immd,
                                       RtStarsCondOpLLWI &opLLWI)
{
    opLLWI.opCode = RT_STARS_COND_ISA_OP_CODE_LWI;
    opLLWI.func3 = RT_STARS_COND_ISA_LWI_FUNC3_LLWI;
    opLLWI.rd = dstReg;
    opLLWI.immdHigh = static_cast<uint32_t>((immd >> 32U) & 0x1FFFFU);   // Low49-immd[48:32]
    opLLWI.immdLow = static_cast<uint32_t>(immd & 0xFFFFFFFFU); // Low49-immd[31:0]
}

void ConstructBranch(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
                                         const rtStarsCondIsaBranchFunc3_t func3, const uint8_t instrOffset,
                                         RtStarsCondOpBranch &opBranch)
{
    opBranch.opCode = RT_STARS_COND_ISA_OP_CODE_BRANCH;
    opBranch.func3 = func3;
    opBranch.rs1 = rs1Reg;
    opBranch.rs2 = rs2Reg;
    opBranch.jumpInstrOffset = instrOffset & 0xFU;        // Jump-immd[3:0]
}

void ConstructLoop(const rtStarsCondIsaRegister_t rs1Reg, const uint16_t delayCycle,
                                       const uint8_t instrOffset, RtStarsCondOpLoop &opLoop)
{
    opLoop.opCode = RT_STARS_COND_ISA_OP_CODE_LOOP;
    opLoop.func3 = 0U;   // loop is only one func
    opLoop.rs1 = rs1Reg;
    opLoop.jumpInstrOffset = instrOffset & 0xFU;        // Jump-immd[3:0]
    opLoop.delayCycle = delayCycle & 0x1FFFU;  // delayCycle[12:0]
}

void ConstructGotoI(const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId,
                                        const uint16_t head, RtStarsCondOpStreamGotoI &opGotoI)
{
    opGotoI.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opGotoI.rd     = dstReg;
    opGotoI.func3  = RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_I;
    opGotoI.sqId   = activeStreamSqId;
    opGotoI.sqHead = head;
}

void ConstructActiveI(const rtStarsCondIsaRegister_t dstReg, const uint16_t activeStreamSqId,
                                          RtStarsCondOpStreamActiveI &opActiveI)
{
    opActiveI.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opActiveI.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_I;
    opActiveI.rd = dstReg;
    opActiveI.sqId = activeStreamSqId;
}

void ConstructDeActiveI(const rtStarsCondIsaRegister_t dstReg, const uint16_t deActiveStreamSqId,
                                            RtStarsCondOpStreamDeActiveI &opDeActiveI)
{
    opDeActiveI.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opDeActiveI.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_I;
    opDeActiveI.rd = dstReg;
    opDeActiveI.sqId = deActiveStreamSqId;
}

void ConstructActiveR(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t dstReg,
                                          RtStarsCondOpStreamActiveR &opActiveR)
{
    opActiveR.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opActiveR.rd = dstReg;
    opActiveR.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_R;
    opActiveR.rs1 = rs1Reg;
}

void ConstructDeActiveR(const rtStarsCondIsaRegister_t rs1Reg,
                                            const rtStarsCondIsaRegister_t dstReg,
                                            RtStarsCondOpStreamDeActiveR &opDeActiveR)
{
    opDeActiveR.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opDeActiveR.rd = dstReg;
    opDeActiveR.func3 = RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_R;
    opDeActiveR.rs1 = rs1Reg;
}

void ConstructGotoR(const rtStarsCondIsaRegister_t sr1Reg, const rtStarsCondIsaRegister_t dstReg,
                                        RtStarsCondOpStreamGotoR &opGotoR)
{
    opGotoR.opCode = RT_STARS_COND_ISA_OP_CODE_STREAM;
    opGotoR.rd     = dstReg;
    opGotoR.func3  = RT_STARS_COND_ISA_STREAM_FUNC3_GOTO_R;
    opGotoR.rs1    = sr1Reg;
}

void ConstructStore(const rtStarsCondIsaRegister_t addrReg, const rtStarsCondIsaRegister_t valReg,
                                        const uint16_t immdOffset, const RtStarsCondIsaStoreFunc3 func3,
                                        RtStarsCondOpStore &opStore)
{
    opStore.opCode = RT_STARS_COND_ISA_OP_CODE_STORE;
    opStore.immdLow = static_cast<uint8_t>(immdOffset & 0x1FU); // S-immd[4:0]
    opStore.func3 = func3;
    opStore.rs1 = addrReg;
    opStore.rs2 = valReg;
    opStore.immdHigh = static_cast<uint8_t>((immdOffset & 0xFE0U) >> 5U); // S-immd[11:5]
}


void ConstructSystemCsr(const rtStarsCondIsaRegister_t srReg, const rtStarsCondIsaRegister_t dstReg,
                                            const rtStarsCondCsrRegister_t csrReg,
                                            const rtStarsCondIsaSystemFunc3_t func3, RtStarsCondOpSystemCsr &opCsr)
{
    opCsr.opCode = RT_STARS_COND_ISA_OP_CODE_SYSTEM;
    opCsr.rd     = dstReg;
    opCsr.func3  = func3;
    opCsr.rs1    = srReg;
    opCsr.csrReg = csrReg;
}

void ConstructFuncCall(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
                                           RtStarsCondOpFuncCall &opFuncCall)
{
    opFuncCall.opCode = RT_STARS_COND_ISA_OP_CODE_FUNC_CALL;
    opFuncCall.func3  = RT_STARS_COND_FUNC_CALL_FUNC3;
    opFuncCall.rs1 = rs1Reg;
    opFuncCall.rs2 = rs2Reg;
}

void ConstructErrorInstr(RtStarsCondOpErrorInstr &opErrInstr)
{
    opErrInstr.err = 0U;
}

void ConstructRdmaPiValueModifyInstr(
    uint64_t piValueArrAddr, uint64_t piValueVecLength, uint64_t dfxAddr, RtStarsPivalueModifyFuncCall &fc)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    // ADDI, Assignment 0 to R2. As an piValueArrAddr index, index = 0
    ConstructOpImmAndi(r0, r2, 0, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);

    // piValueArr是device地址
    // LHWI/LLWI: load piValue array address as the immediate to R1
    ConstructLHWI(r1, piValueArrAddr, fc.lhwi1);
    ConstructLLWI(r1, piValueArrAddr, fc.llwi1);

    // LHWI/LLWI: load length of piValueVec sa immediate to R4
    ConstructLHWI(r4, piValueVecLength, fc.lhwi2);
    ConstructLLWI(r4, piValueVecLength, fc.llwi2);

    // LHWI/LLWI: load goto instr num as a immediate to R5
    const uint64_t toEnd = (RtPtrToValue(&fc.nop) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to end, instr:%" PRIu64, toEnd);

    ConstructLHWI(r5, (toEnd >> 4UL), fc.lhwi3);  // {19, 4}bit save in jump_pc
    ConstructLLWI(r5, (toEnd >> 4UL), fc.llwi3);

    // CSRRW: set goto instr num to jump_pc reg
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_JUMP_PC_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW, fc.csrrw);

    // BGEU: if piValueArrAddr index >= piValueVecLength, go to end
    uint8_t instrOffset = static_cast<uint8_t>(toEnd & 0xFUL);
    ConstructBranch(r2, r4, RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU, instrOffset, fc.bgeu);

    // SLLI: R2 left 3 bit is offset and assigned to the R3
    // piValueArrAddr是uint64_t, 8个字节，所以将r2左移3位，即r2*8，然后加上piValueArrAddr，得到当前存储pi
    // value地址的地址
    ConstructOpImmSlli(r2, r3, 0x3U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli);

    // ADD: r4 is addr saving cur pi value addr
    ConstructOpOp(r1, r3, r4, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add);

    // LD_R: get cur pi value addr r5
    ConstructLoad(r4, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr1);  // virtual address read

    // load dfx ptr and store pi value virtual addr
    ConstructLHWI(r4, dfxAddr, fc.lhwi4);
    ConstructLLWI(r4, dfxAddr, fc.llwi4);

    // ADD: r4 is addr saving cur dfx value addr
    ConstructOpOp(r4, r3, r4, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add1);

    // AD_R: read cur pi value, r3 is cur pi value ： value_00(低位) 与 value_01(高位)拼成的一个64位的值
    ConstructLoad(r5, 0U, r3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);  // virtual address read

    ConstructStore(r4, r3, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.swdfx);

    ConstructLHWI(r1, 0xFFFF0000FFFFFFFFUL, fc.lhwi5);
    ConstructLLWI(r1, 0xFFFF0000FFFFFFFFUL, fc.llwi5);

    // 剔除掉piValue的值，r4=value_01_value_00[64:48]与value_01_value_00[31:0]拼接的值
    ConstructOpOp(r3, r1, r4, RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, fc.and1);

    ConstructLHWI(r1, 0x0000FFFF00000000UL, fc.lhwi6);
    ConstructLLWI(r1, 0x0000FFFF00000000UL, fc.llwi6);

    // 获取到piValue的值，r1=value_01_value_00[47:32]
    ConstructOpOp(r3, r1, r1, RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, fc.and2);

    // AD_R: read value_add0, r3 is value_add0(低位) 与
    // value_add1(高位)拼成的uint64位的值，目前hccl会将value_add1填充成0
    ConstructLoad(r5, 16U, r3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr3);  // virtual address read

    // 计算新的piValue值，r3 = value_01_value_00[47:32] +
    // value_add1_value_add0(这个uint64，hccl保证[47:32]有效，其它位是0)
    ConstructOpOp(r1, r3, r3, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add2);

    ConstructLHWI(r1, 0x0000FFFF00000000UL, fc.lhwi7);
    ConstructLLWI(r1, 0x0000FFFF00000000UL, fc.llwi7);
    // 获取相加后的值，且只保留[47:32] 16bit的值
    ConstructOpOp(r3, r1, r3, RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, fc.and3);

    // 计算最终piValue，其中[47:32]是计算后的值，其它位保持原始值
    ConstructOpOp(r3, r4, r3, RT_STARS_COND_ISA_OP_FUNC3_OR, RT_STARS_COND_ISA_OP_FUNC7_OR, fc.or1);

    // SH: save cnt r3 to r5
    ConstructStore(r5, r3, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.sh);  // virtual address write

    // ************************ 进行下次循环 *************************
    // ADDI, r2,piValueArrAddr index++
    ConstructOpImmAndi(r2, r2, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi3);

    // LHWI/LLWI: load goto instr num as a immediate to r4
    const uint64_t toScanpiValueArr = (RtPtrToValue(&fc.lhwi1) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to scan piValueArrAddr, instr:%" PRIu64 "", toScanpiValueArr);

    ConstructLHWI(r4, (toScanpiValueArr >> 4ULL), fc.lhwi8);  // {19, 4}bit save in jump_pc
    ConstructLLWI(r4, (toScanpiValueArr >> 4ULL), fc.llwi8);

    // CSRRW: set goto instr num to jump_pc reg
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_JUMP_PC_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW, fc.csrrw2);

    // BNE: goto scan piValueArrAddr
    instrOffset = static_cast<uint8_t>(toScanpiValueArr & 0xFUL);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, instrOffset, fc.beq);

    ConstructNop(fc.nop);

    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        const uint32_t *const cmd = RtPtrToPtr<const uint32_t *>(&fc);
        for (size_t i = 0UL; i < (sizeof(RtStarsPivalueModifyFuncCall) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute pi value modify instr[%zu]=0x%08x", i, cmd[i]);
        }
    }
}

/* top half of rdma task sqe, designed to re-calculate PI in sink mode */
void ConstructRdmaSink1Instr(const uint32_t piInit, const uint8_t sqDepthBitWidth,
                                                 const uint64_t svmAddr, RtStarsRdmaSinkSqe1 &sqe)
{
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;

    // i = *svm_addr(ushort)
    ConstructLoadImm(r1, svmAddr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LHU, sqe.lhu);

    // i_cal = i * sq_depth = i << sqDepthBitWidth[3:0]
    ConstructOpImmSlli(r1, r1, sqDepthBitWidth, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI,
                       RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, sqe.slli1);

    // pi = i_cal + pi_init[11:0]
    ConstructOpImmAndi(r1, r1, piInit, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, sqe.addi);

    // read immd 0xFFFF, pi &= 0xFFFF
    ConstructLHWI(r2, 0xFFFFULL, sqe.lhwi);
    ConstructLLWI(r2, 0xFFFFULL, sqe.llwi);
    ConstructOpOp(r1, r2, r1, RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, sqe.and1);

    // pi = pi << 32
    ConstructOpImmSlli(r1, r1, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI,
        sqe.slli2);

    // NOP
    for (RtStarsCondOpNop &nop : sqe.nop) {
        ConstructNop(nop);
    }
}

/* bottom half of rdma task sqe, designed to refresh db value(contains new PI) and write to dbAddr */
void ConstructRdmaSink2Instr(const uint64_t dbAddr, const uint64_t dbInfoWithoutPi,
                                                 RtStarsRdmaSinkSqe2 &sqe)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr uint64_t axiUserVaCfgMask = 0x100000001ULL;

    // read immd dbInfoWithoutPi[63:0]
    ConstructLHWI(r3, dbInfoWithoutPi, sqe.lhwi1);
    ConstructLLWI(r3, dbInfoWithoutPi, sqe.llwi1);

    // dbInfo = dbInfoWithoutPi | pi
    ConstructOpOp(r3, r1, r3, RT_STARS_COND_ISA_OP_FUNC3_OR, RT_STARS_COND_ISA_OP_FUNC7_OR, sqe.or1);

    // read immd dbAddr[63:0]
    ConstructLHWI(r4, dbAddr, sqe.lhwi2);
    ConstructLLWI(r4, dbAddr, sqe.llwi2);

    // read immd reg va cfg mask
    ConstructLLWI(r5, axiUserVaCfgMask, sqe.llwi3);
    // cfg use PA
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, sqe.csrrc);
    // write_value dbInfo[63:0] to dbAddr[63:0]
    ConstructStore(r4, r3, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, sqe.sd);
    // restore to use VA
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, sqe.csrrs);
}

void ConstrucStreamResetInstr(const uint32_t sqId, const uint64_t sqEnReg,
                                                  RtStarsStreamResetHeadSqe &sqe)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr uint64_t axiUserVaCfgMask = 0x100000001ULL;

    // read immd STARS_P0_SQ_CFG5[63:0]
    ConstructLHWI(r1, sqEnReg, sqe.lhwi1);
    ConstructLLWI(r1, sqEnReg, sqe.llwi1);

    // read immd reg va cfg mask
    ConstructLLWI(r2, axiUserVaCfgMask, sqe.llwi2);
    // cfg use PA
    ConstructSystemCsr(r2, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, sqe.csrrc);

    // write_value 0 to STARS_P0_SQ_CFG5
    ConstructStore(r1, r0, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, sqe.sw);

    // restore to use VA
    ConstructSystemCsr(r2, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, sqe.csrrs);

    // reset rtsq head
    ConstructGotoI(r3, static_cast<uint16_t>(sqId), 0U, sqe.goto_i);

    // NOP
    for (RtStarsCondOpNop &nop : sqe.nop) {
        ConstructNop(nop);
    }
}

void ConstrucModelExeScanSq(rtStarsModelExeFuncCallPara_t &funcCallPara,
                                                RtStarsModelExeScanSq &scanSq)
{
    // After Function  R2: index + 1, R3 : CurSqid , R4: CurSqid Addr
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    // ADDI, Assignment 0 to R2. As an headsqArrAddr index, index = 0
    ConstructOpImmAndi(r0, r2, 0, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, scanSq.addi1);

    // LHWI/LLWI: load headsqArr array address as the immediate to R1
    ConstructLHWI(r1, funcCallPara.headSqArrAddr, scanSq.lhwi1);
    ConstructLLWI(r1, funcCallPara.headSqArrAddr, scanSq.llwi1);

    // LHWI/LLWI: load headsqMax sa immediate to R4, headsqMax = length(headsqArrAddr)
    ConstructLHWI(r4, funcCallPara.headSqArrMax, scanSq.lhwi2);
    ConstructLLWI(r4, funcCallPara.headSqArrMax, scanSq.llwi2);

    // LHWI/LLWI: load goto instr num as a immediate to R5
    RtStarsModelExeFuncCall fc;
    const uint64_t toEnd = (RtPtrToValue(&(fc.endInstr.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to end, instr:%" PRIu64, toEnd);

    ConstructLHWI(r5, (toEnd >> 4ULL), scanSq.lhwi3); // {19, 4}bit save in jump_pc
    ConstructLLWI(r5, (toEnd >> 4ULL), scanSq.llwi3);

    // CSRRW: set goto instr num to jump_pc reg
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_JUMP_PC_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW, scanSq.csrrw);

    // BGEU: if headSqArrAddr index >= sqMax, go to scanHeadSqArrInit
    const uint8_t instrOffset = static_cast<uint8_t>(toEnd & 0xFULL);
    ConstructBranch(r2, r4, RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU, instrOffset, scanSq.bgeu);

    // SLLI: R2 left 3 bit is offset and assigned to the R3
    ConstructOpImmSlli(r2, r3, 0x3U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI,
        scanSq.slli);

    // ADD: r4 is cur sq id addr
    ConstructOpOp(r1, r3, r4, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, scanSq.add);

    // AD_R: read cur sq id, r3 is cur sq id
    ConstructLoad(r4, 0U, r3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, scanSq.ldr);  // virtual address read

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&scanSq);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        for (size_t i = 0UL; i < (sizeof(RtStarsModelExeScanSq) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute scanSq instr[%zu]=0x%08x", i, cmd[i]);
        }
    }
}

void ConstrucModelExeCheckSqFsm(rtStarsModelExeFuncCallPara_t &funcCallPara,
                                                    RtStarsModelExeCheckSqFsm &checkSqFsm)
{
    // After Function  R2: index + 1, R3 : CurSqid , R4: sq fsm status bits
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    // ************************* check sq fsm status ********************************************
    // LHWI/LLWI: load sq fsm cfg address as the immediate to R4
    ConstructLHWI(r4, funcCallPara.sqFsmSelBasAddr, checkSqFsm.lhwi0);
    ConstructLLWI(r4, funcCallPara.sqFsmSelBasAddr, checkSqFsm.llwi0);

    // ******************* Begin change to phyical address access*******************
    constexpr uint64_t axiUserVaCfgMask = 0x100000001ULL;
    // LHWI/LLWI: read immd reg va cfg mask
    ConstructLHWI(r1, axiUserVaCfgMask, checkSqFsm.lhwi1);
    ConstructLLWI(r1, axiUserVaCfgMask, checkSqFsm.llwi1);
    // cfg use PA
    ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, checkSqFsm.csrrc);

    // write_value sqid to sq fsm cfg addr
    ConstructStore(r4, r3, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, checkSqFsm.sw); // phyical address write

    // LHWI/LLWI: load sq fsm cfg address as the immediate to R4
    ConstructLHWI(r4, funcCallPara.sqFsmSelBasAddr, checkSqFsm.lhwi2);
    ConstructLLWI(r4, funcCallPara.sqFsmSelBasAddr, checkSqFsm.llwi2);

    // LD_R: read fsm status
    ConstructLoad(r4, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, checkSqFsm.ldr);  // phyical address read

    // LHWI/LLWI: read immd reg va cfg mask
    ConstructLHWI(r1, axiUserVaCfgMask, checkSqFsm.lhwi3);
    ConstructLLWI(r1, axiUserVaCfgMask, checkSqFsm.llwi3);
    // restore to use VA
    ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, checkSqFsm.csrrs);
    // ******************* End change to phyical address access*******************

    // *******************start add loop finding if sq fsm idle *******************
    /* Do not go to lhwi0 cause Offset1 > 15 Loop instruction will high-order truncation.  */
    RtStarsModelExeFuncCall fc;
    constexpr uint32_t cycle = 1100U;
    const uint64_t offset1 = (RtPtrToValue(&(fc.checkSqFsm.lhwi0)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to offset1:%" PRIu64, offset1);

    /* r1 = r4 */
    ConstructOpImmAndi(r4, r1, 0, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, checkSqFsm.addi);
    
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    DevProperties prop;
    rtError_t error = GET_DEV_PROPERTIES(chipType, prop);
    RT_LOG(RT_LOG_DEBUG, "GetDevProperties, ret = %u", error);
    uint32_t shamt = prop.rtsqShamt;

    // r1 is sqid
    ConstructOpImmAndi(r1, r1, shamt, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, checkSqFsm.andi1);

    /* r1 != r3 goto offset1 sq id not same */
    ConstructOpOp(r1, r3, r1, RT_STARS_COND_ISA_OP_FUNC3_XOR, RT_STARS_COND_ISA_OP_FUNC7_XOR, checkSqFsm.xor1);
    ConstructSetJumpPcFc(r5, offset1, checkSqFsm.jumpPc0);
    ConstructLoop(r1, cycle, static_cast<uint8_t>(offset1), checkSqFsm.loop0);
    //这个是右移，因为r4现在是64bit的，低位代表了STARS_RTSQ_FSM_SEL，高位代表了STARS_RTSQ_FSM_STATE，所以需要右移
    ConstructOpImmSlli(r4, r4, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI,
                       checkSqFsm.srli1);
    // {3:0} dfx_rtsq_fsm_state
    ConstructOpImmAndi(r4, r4, 0xFU, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, checkSqFsm.andi2);
    ConstructSetJumpPcFc(r1, offset1, checkSqFsm.jumpPc1);
    ConstructLoop(r4, cycle, static_cast<uint8_t>(offset1), checkSqFsm.loop);
    // *******************end add loop finding if sq fsm idle *******************

    // LHWI/LLWI: load goto instr num as a immediate to R1
    const uint64_t errorInstr = (RtPtrToValue(&(fc.errInstr.err)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to errorInstr, instr:%" PRIu64, errorInstr);
    // BNE: if sq fsm status is not equal idle(0), goto error
    ConstructSetJumpPcFc(r1, errorInstr, checkSqFsm.jumpPc2);
    const uint8_t instrOffset = static_cast<uint8_t>(errorInstr & 0xFFULL);
    ConstructBranch(r4, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, instrOffset, checkSqFsm.bne);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&checkSqFsm);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        for (size_t i = 0UL; i < (sizeof(RtStarsModelExeCheckSqFsm) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute checkSqFsm, instr[%zu]=0x%08x", i, cmd[i]);
        }
    }
}
void ConstrucModelExeCheckSqDisable(rtStarsModelExeFuncCallPara_t &funcCallPara,
                                                        RtStarsModelExeCheckSqDisable &checkSqDisable)
{
    // After Function  R1: enable flag, R2: index + 1, R3 : CurSqid , R4: sq simple_address
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    // R3 is sqid, get offset to R5 : R3 << 3, R5 = sqid * 8
    ConstructOpImmSlli(r3, r5, 3U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI,
                       checkSqDisable.slli1);

    // LHWI/LLWI : read the starting addr of the virtual addr array to R4
    ConstructLHWI(r4, funcCallPara.sqVirtualAddr, checkSqDisable.lhwi1);
    ConstructLLWI(r4, funcCallPara.sqVirtualAddr, checkSqDisable.llwi1);

    // ADD : get "sq virtual addr" addr:  virtual addr arry head + sqid * 8
    ConstructOpOp(r4, r5, r4, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, checkSqDisable.add1);

    // LD_R: read sq simple virutual addr from R4 to R4
    ConstructLoad(r4, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, checkSqDisable.ldr1);

    // LHWI/LLWI: load goto instr num as a immediate to R5
    RtStarsModelExeFuncCall fc;
    const uint64_t errorInstr = (RtPtrToValue(&(fc.checkSqDisableErrInstr.lhwi0)) - RtPtrToValue(&fc))
            / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to errorInstr, instr:%" PRIu64, errorInstr);

    ConstructLHWI(r5, (errorInstr >> 4ULL), checkSqDisable.lhwi3); // {19, 4}bit save in jump_pc
    ConstructLLWI(r5, (errorInstr >> 4ULL), checkSqDisable.llwi3);

    // CSRRW: set goto instr num to jump_pc reg
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_JUMP_PC_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       checkSqDisable.csrrw1);

    // BNE: sq Virtual Addr = 0 go to error
    uint8_t instrOffset = errorInstr & 0xFULL;
    ConstructBranch(r4, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, instrOffset, checkSqDisable.beq1);

    // LD_R: read sq head to R1,  from R4 + offset(STARS_SIMPLE_SQ_HEAD_OFFSET)
    ConstructLoad(r4, funcCallPara.sqHeadOffset, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR,
                  checkSqDisable.ldr2);   // virtual address read

    // SLLI/SRLI: get sq enable flag: R1<<31, then R1>>63
    ConstructOpImmSlli(r1, r1, 31U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI,
                        checkSqDisable.slli2);
    ConstructOpImmSlli(r1, r1, 63U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI,
                        checkSqDisable.srli2);

    // LHWI/LLWI: load goto instr num as a immediate to r5
    const uint64_t setSqHead0 = (RtPtrToValue(&(fc.deactiveSq.gotoR)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to setSqHead0, instr:%" PRIu64, setSqHead0);

    ConstructLHWI(r5, (setSqHead0 >> 4ULL), checkSqDisable.lhwi4); // {19, 4}bit save in jump_pc
    ConstructLLWI(r5, (setSqHead0 >> 4ULL), checkSqDisable.llwi4);

    // CSRRW: set goto instr num to jump_pc reg
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_JUMP_PC_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       checkSqDisable.csrrw2);

    // BEQ: if sq enable flag is disable(0), goto setSqHead0
    instrOffset = setSqHead0 & 0xFULL;
    ConstructBranch(r1, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ,
                    instrOffset, checkSqDisable.beq2);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&checkSqDisable);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        for (size_t i = 0UL; i < (sizeof(RtStarsModelExeCheckSqDisable) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute checkSqDisable, instr[%zu]=0x%08x", i, cmd[i]);
        }
    }
}

void ConstrucModelExeCheckSqHeadTail(const rtStarsModelExeFuncCallPara_t &funcCallPara,
    RtStarsModelExeCheckSqHeadTail &checkSqHeadTail)
{
    // After Function  R1: head == tail flag, R2: index + 1, R3 : CurSqid  R4: sq simple_address
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    // LD_R: read sq head to R5,  from R4 + offset(STARS_SIMPLE_SQ_HEAD_OFFSET)
    ConstructLoad(r4, funcCallPara.sqHeadOffset, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR,
                  checkSqHeadTail.ldr1);    // virtual address read

    // SLLI/SRLI: get sq head r5: r5<<48, then r5>>48
    ConstructOpImmSlli(r5, r5, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI,
                       checkSqHeadTail.slli1);
    ConstructOpImmSlli(r5, r5, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI,
                       checkSqHeadTail.srli1);

    // LD_R: read sq tail to R1, from R4 + offset(STARS_SIMPLE_SQ_TAIL_OFFSET)
    ConstructLoad(r4, funcCallPara.sqTailOffset, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR,
                  checkSqHeadTail.ldr2);  // virtual address read

    // SLLI/SRLI: get sq tail r1: r1<<48, then r1>>48
    ConstructOpImmSlli(r1, r1, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI,
                       checkSqHeadTail.slli2);
    ConstructOpImmSlli(r1, r1, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI,
                       checkSqHeadTail.srli2);

    // XOR: head is equal tail r1 =r1^r5
    ConstructOpOp(r1, r5, r1, RT_STARS_COND_ISA_OP_FUNC3_XOR,
                  RT_STARS_COND_ISA_OP_FUNC7_XOR, checkSqHeadTail.xor1);

    // LHWI/LLWI: load goto instr num as a immediate to R5
    RtStarsModelExeFuncCall fc;
    const uint64_t errorInstr = (RtPtrToValue(&(fc.checkSqHeadTailErrInstr.lhwi0)) - RtPtrToValue(&fc))
            / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to errorInstr, instr:%" PRIu64, errorInstr);

    ConstructLHWI(r5, (errorInstr >> 4ULL), checkSqHeadTail.lhwi1); // {19, 4}bit save in jump_pc
    ConstructLLWI(r5, (errorInstr >> 4ULL), checkSqHeadTail.llwi1);

    // CSRRW: set goto instr num to jump_pc reg
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_JUMP_PC_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       checkSqHeadTail.csrrw);

    // BNE: head is not equal tail, R1 is not equal R0, goto error
    const uint8_t instrOffset = static_cast<uint8_t>(errorInstr & 0xFULL);
    ConstructBranch(r1, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, instrOffset, checkSqHeadTail.bne);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&checkSqHeadTail);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        for (size_t i = 0UL; i < (sizeof(RtStarsModelExeCheckSqHeadTail) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute checkSqHeadTail, instr[%zu]=0x%08x", i, cmd[i]);
        }
    }
}

void ConstrucModelExeDeactiveSq(RtStarsModelExeDeactiveSq &deactiveSq)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;

    // SW: write_value 0U to STARS_P0_SQ_CFG5, deactive sq
    ConstructStore(r4, r0, STARS_SIMPLE_SQ_ENABLE_OFFSET,
                   RT_STARS_COND_ISA_STORE_FUNC3_SW, deactiveSq.sw); // virtual address write

    // GOTO_R4: set sq head is 0U
    ConstructGotoR(r3, r4, deactiveSq.gotoR);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&deactiveSq);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        for (size_t i = 0UL; i < (sizeof(RtStarsModelExeDeactiveSq) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute deactiveSq, instr[%zu]=0x%08x", i, cmd[i]);
        }
    }
}

void ConstrucModelExeActiveHeadSq(rtStarsModelExeFuncCallPara_t &funcCallPara,
                                                      RtStarsModelExeActiveSq &activeHeadSq)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    // ************************ update stream svm info / active sq*********************
    // SLLI: get stream svm addr offset R2 left 3 bit is offset and assigned to the r5
    ConstructOpImmSlli(r2, r5, 0x3U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI,
                       activeHeadSq.slli);

    // ADDI, r2,headSqArrAddr index++
    ConstructOpImmAndi(r2, r2, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, activeHeadSq.addi0);

    // LHWI/LLWI: load stream svm base addr sa immediate to R4
    ConstructLHWI(r4, funcCallPara.streamSvmArrAddr, activeHeadSq.lhwi1);
    ConstructLLWI(r4, funcCallPara.streamSvmArrAddr, activeHeadSq.llwi1);

    // ADD: r5 is addr saving stream svm addr
    ConstructOpOp(r4, r5, r5, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, activeHeadSq.add);

    // LD_R: get stream svm addr r4
    ConstructLoad(r5, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, activeHeadSq.ldr1);  // virtual address read

    // LD_R: get cnt in stream svm addr to r5
    ConstructLoad(r4, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, activeHeadSq.ldr2);  // virtual address read

    // ADDI: r5, cnt++
    ConstructOpImmAndi(r5, r5, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, activeHeadSq.addi1);

    // SH: save cnt r5 to r4
    ConstructStore(r4, r5, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SH, activeHeadSq.sh);  // virtual address write

    // Active_R: acitive sq r3
    ConstructActiveR(r3, r5, activeHeadSq.activeR);

    // ************************ continue, goto ScanHeadSqArr *************************
    // LHWI/LLWI: load goto instr num as a immediate to r4
    RtStarsModelExeFuncCall fc;
    const uint64_t toScanSqArr = (RtPtrToValue(&(fc.scanSq.lhwi1)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to ScanSqArr, instr:%" PRIu64 "", toScanSqArr);

    ConstructLHWI(r4, (toScanSqArr >> 4ULL), activeHeadSq.lhwi2); // {19, 4}bit save in jump_pc
    ConstructLLWI(r4, (toScanSqArr >> 4ULL), activeHeadSq.llwi2);

    // CSRRW: set goto instr num to jump_pc reg
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_JUMP_PC_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
        activeHeadSq.csrrw1);

    // BNE: goto scanHeadSqArr
    const uint8_t instrOffset = static_cast<uint8_t>(toScanSqArr & 0xFULL);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, instrOffset, activeHeadSq.beq);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&activeHeadSq);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        for (size_t i = 0UL; i < (sizeof(RtStarsModelExeActiveSq) / sizeof(uint32_t)); i++) {
            RT_LOG(RT_LOG_DEBUG, "model execute activeHeadSq, instr[%zu]=0x%08x", i, cmd[i]);
        }
    }
}

void ConstrucModelExeErrInstr(RtStarsModelExeExeErrInstr &errInstr)
{
    ConstructErrorInstr(errInstr.err);
}

void ConstrucModelExeCheckSqDisableErrInstr(const rtStarsModelExeFuncCallPara_t &funcCallPara,
                                                                RtStarsModelExeCheckSqErrInstr &errInstr)
{
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    // load dfx ptr and store sq sumple virtual addr
    ConstructLHWI(r5, funcCallPara.dfxAddr, errInstr.lhwi0);
    ConstructLLWI(r5, funcCallPara.dfxAddr, errInstr.llwi0);
    ConstructStore(r5, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, errInstr.swdfx);

    errInstr.err = 0U;
}

void ConstrucModelExeCheckSqHeadTailErrInstr(const rtStarsModelExeFuncCallPara_t &funcCallPara,
                                                                 RtStarsModelExeCheckSqErrInstr &errInstr)
{
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    // Load dfx ptr and store head == tail
    ConstructLHWI(r5, funcCallPara.dfxAddr, errInstr.lhwi0);
    ConstructLLWI(r5, funcCallPara.dfxAddr, errInstr.llwi0);
    ConstructStore(r5, r1, 8U, RT_STARS_COND_ISA_STORE_FUNC3_SW, errInstr.swdfx);

    errInstr.err = 0U;
}

void ConstrucModelExeEndInstrr(RtStarsModelExeExeEndInstr &endInstr)

{
    ConstructNop(endInstr.nop);
}

void ConstrucModelExeFuncCall(rtStarsModelExeFuncCallPara_t &funcCallPara,
                                                  RtStarsModelExeFuncCall &funcCall)
{
    ConstrucModelExeScanSq(funcCallPara, funcCall.scanSq);
    ConstrucModelExeCheckSqFsm(funcCallPara, funcCall.checkSqFsm);
    ConstrucModelExeCheckSqDisable(funcCallPara, funcCall.checkSqDisable);
    ConstrucModelExeCheckSqHeadTail(funcCallPara, funcCall.checkSqHeadTail);
    ConstrucModelExeDeactiveSq(funcCall.deactiveSq);
    ConstrucModelExeActiveHeadSq(funcCallPara, funcCall.activeHeadSq);
    ConstrucModelExeCheckSqDisableErrInstr(funcCallPara, funcCall.checkSqDisableErrInstr);
    ConstrucModelExeCheckSqHeadTailErrInstr(funcCallPara, funcCall.checkSqHeadTailErrInstr);
    ConstrucModelExeErrInstr(funcCall.errInstr);
    ConstrucModelExeEndInstrr(funcCall.endInstr);
}

void ConstructGetSqFsmStateFcI(const rtStarsCondIsaRegister_t sqFsmStateReg,
                                                   const rtStarsCondIsaRegister_t sqIdReg,
                                                   const rtStarsCondIsaRegister_t maskReg,
                                                   const uint32_t sqId,
                                                   const uint64_t addr,
                                                   RtStarsGetSqFsmStateI &getSqFsmState)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr uint64_t axiUserVaCfgMask = 0x100000001ULL;

    // read va cfg mask
    ConstructLHWI(maskReg, axiUserVaCfgMask, getSqFsmState.lhwi1);
    ConstructLLWI(maskReg, axiUserVaCfgMask, getSqFsmState.llwi1);

    // read fsm state addr
    ConstructLHWI(sqFsmStateReg, addr, getSqFsmState.lhwi2);
    ConstructLLWI(sqFsmStateReg, addr, getSqFsmState.llwi2);

    // read sqid
    ConstructLHWI(sqIdReg, sqId, getSqFsmState.lhwi3);
    ConstructLLWI(sqIdReg, sqId, getSqFsmState.llwi3);

    // cfg use PA
    ConstructSystemCsr(maskReg, r0,
        RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, getSqFsmState.csrrc);

    // write value sqid to sq fsm cfg addr
    ConstructStore(sqFsmStateReg, sqIdReg, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SH, getSqFsmState.sh);

    // reset reg
    ConstructOpOp(sqFsmStateReg, r0, sqFsmStateReg,
        RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, getSqFsmState.and1);

    // read fsm status, the offset for reading the fsm state is 4
    ConstructLoadImm(sqFsmStateReg, addr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD, getSqFsmState.ldi);

    // cfg use VA
    ConstructSystemCsr(maskReg, r0, RT_STARS_COND_CSR_AXI_USER_REG,
        RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, getSqFsmState.csrrs);
}


void ConstructSetJumpPcFc(const rtStarsCondIsaRegister_t offsetReg,
                                              const uint64_t offset,
                                              RtStarsSetCsrJumpPc &setCsrJumpPc)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;

    // {19, 4} bit save in jump_pc
    ConstructLHWI(offsetReg, (offset >> 4ULL), setCsrJumpPc.lhwi);
    ConstructLLWI(offsetReg, (offset >> 4ULL), setCsrJumpPc.llwi);

    // set goto instr num to jump_pc reg
    ConstructSystemCsr(offsetReg, r0, RT_STARS_COND_CSR_JUMP_PC_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       setCsrJumpPc.csrrw);
}

void ConstructSetCqeStatus(const rtStarsCondIsaRegister_t srReg,
                                               const rtStarsCondIsaRegister_t dstReg,
                                               RtStarsSetCqeStatus &setCqeStatus)
{
    // get cqeStatus(32bit)to dstReg and set srReg to cqeStatus, the value can be read by ts
    ConstructSystemCsr(srReg, dstReg, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       setCqeStatus.csrrw);
}

void ConstructGetSqEnableFcI(const rtStarsCondIsaRegister_t sqEnableReg,
                                                 const uint64_t addr,
                                                 RtStarsGetSqEnableI &getSqEnable)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;

    // reset reg
    ConstructOpOp(sqEnableReg, r0, sqEnableReg,
        RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, getSqEnable.and1);

    ConstructLoadImm(sqEnableReg, addr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LBU, getSqEnable.ldi);

    // {0, 0} p0_sq_en
    ConstructOpImmAndi(sqEnableReg, sqEnableReg, 0x1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, getSqEnable.andi);
}


void ConstructGetSqHeadAndTailFcI(const rtStarsCondIsaRegister_t headReg,
                                                      const rtStarsCondIsaRegister_t tailReg,
                                                      const uint64_t tailAddr,
                                                      const uint64_t headAddr,
                                                      RtStarsGetSqHeadAndTailI &getSqheadAndTail)
{
    // {15, 0} get tail
    ConstructLoadImm(tailReg, tailAddr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LHU, getSqheadAndTail.ldi1);
    ConstructOpImmAndi(tailReg, tailReg, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, getSqheadAndTail.andtail);

    // {15, 0} get head, the address offset of head and tail is 8.
    ConstructLoadImm(headReg, headAddr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LHU, getSqheadAndTail.ldi2);
    ConstructOpImmAndi(headReg, headReg, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, getSqheadAndTail.andhead);
}

void ConstructDisableStreamFcI(const rtStarsCondIsaRegister_t addrReg,
                                                   const uint64_t addr,
                                                   RtStarsDisableStreamI &disableStream)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;

    // read stream enable addr
    ConstructLHWI(addrReg, addr, disableStream.lhwi1);
    ConstructLLWI(addrReg, addr, disableStream.llwi1);

    ConstructStore(addrReg, r0, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, disableStream.sw);
}

void ConstructAddStreamActiveTimesFcI(const rtStarsCondIsaRegister_t svmAddrReg,
                                                          const rtStarsCondIsaRegister_t valReg,
                                                          const uint64_t svmAddr,
                                                          RtStarsAddStreamActiveTimes &addStreamActiveTimes)
{
    // i = *svm_addr(ushort)
    ConstructLoadImm(valReg, svmAddr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LWU, addStreamActiveTimes.lwu);

    // i++
    ConstructOpImmAndi(valReg, valReg, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, addStreamActiveTimes.addi);

    // read immd svmAddr
    ConstructLHWI(svmAddrReg, svmAddr, addStreamActiveTimes.lhwi);
    ConstructLLWI(svmAddrReg, svmAddr, addStreamActiveTimes.llwi);

    // store i(ushort) to svm
    ConstructStore(svmAddrReg, valReg, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SH, addStreamActiveTimes.sh);
}

void ConstructLabelSwitchByIdxCheckFc(const uint64_t indexPtr, const uint32_t maxVal,
                                                          const uint64_t addr,
                                                          RtStarsLabelSwitchByIdxCheck &labelSwitchByIdx)
{
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;

    uint8_t instrOffset;

    // 0.LD_I  R1 &ptr[48:0]
    ConstructLoadImm(r1, indexPtr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LWU, labelSwitchByIdx.ldi);

    // 2.LHWI  R2  max[63:49]
    ConstructLHWI(r2, static_cast<uint64_t>(maxVal), labelSwitchByIdx.lhwi1);

    // 3.LLWI  R2  max[48:0]
    ConstructLLWI(r2, static_cast<uint64_t>(maxVal), labelSwitchByIdx.llwi1);

    instrOffset = offsetof(RtStarsLabelSwitchByIdxCheck, ldi1);
    instrOffset = instrOffset/sizeof(uint32_t);
    // 5.BLT 9  R1  R2
    ConstructBranch(r1, r2, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU,
        instrOffset, labelSwitchByIdx.blt);

    // arraySize minus 1
    const uint64_t maxIndex = (maxVal > 0UL) ? (maxVal - 1UL) : 0UL;

    // 6.LHWI  R1  max[63:49]
    ConstructLHWI(r1, maxIndex, labelSwitchByIdx.lhwi2);

    // 7.LLWI  R1  max[48:0]
    ConstructLLWI(r1, maxIndex, labelSwitchByIdx.llwi2);

    // 9.LD_I  R2 label count
    ConstructLoadImm(r2, addr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LWU, labelSwitchByIdx.ldi1);

    // 10 store label count in model to Cqe status
    ConstructSetCqeStatus(r1, RT_STARS_COND_ISA_REGISTER_R0, labelSwitchByIdx.dfxLabelIndex);

    instrOffset = offsetof(RtStarsLabelSwitchByIdxCheck, err);
    instrOffset = instrOffset/sizeof(uint32_t);
    // 11.BLT 13  R1  R2
    ConstructBranch(r1, r2, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU,
        instrOffset + 1U, labelSwitchByIdx.blt1);

    // 12 err
    ConstructErrorInstr(labelSwitchByIdx.err);
}

void ConstructSwitchDisableStreamFcI(const rtStarsCondIsaRegister_t addrReg,
                                                         RtStarsSwitchDisableStreamI &disableStream)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    ConstructStore(addrReg, r0, STARS_SIMPLE_SQ_ENABLE_OFFSET, RT_STARS_COND_ISA_STORE_FUNC3_SW, disableStream.sw);
}

void ConstructSwitchGetSqVirtualAddrFcI(const rtStarsCondIsaRegister_t sqIdReg,
                                                            const rtStarsCondIsaRegister_t sqVirtualAddrReg,
                                                            const uint64_t deviceMemForVirAddr,
                                                            rtStarsLabelSwitchByIndexFc_t &labelSwitchByIdxFc)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    RtStarsSwitchGetSqVirtualAddrI &getVirAddr = labelSwitchByIdxFc.getVirAddr_i;
    // R2 is the sqid get offset R5 : R2 << 3
    ConstructOpImmSlli(sqIdReg, r4, 3U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI,
                       getVirAddr.slli1);

    // LHWI/LLWI : read the starting addr of the virtual addr array to R5
    ConstructLHWI(sqVirtualAddrReg, deviceMemForVirAddr, getVirAddr.lhwi1);
    ConstructLLWI(sqVirtualAddrReg, deviceMemForVirAddr, getVirAddr.llwi1);

    // ADD : get "sq virtual addr" addr:  virtual addr arry head + sqid * 8
    ConstructOpOp(sqVirtualAddrReg, r4, sqVirtualAddrReg, RT_STARS_COND_ISA_OP_FUNC3_ADD,
                  RT_STARS_COND_ISA_OP_FUNC7_ADD, getVirAddr.add1);

    // LD_R: read sq simple virutual addr from R5 to R5
    ConstructLoad(sqVirtualAddrReg, 0U, sqVirtualAddrReg, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, getVirAddr.ldr1);

    // LHWI/LLWI: load goto instr num as a immediate to R4
    const uint64_t errorInstr = (RtPtrToValue(&(labelSwitchByIdxFc.err)) - RtPtrToValue(&labelSwitchByIdxFc))
            / sizeof(uint32_t);
    RT_LOG(RT_LOG_DEBUG, "go to errorInstr, instr:%" PRIu64, errorInstr);

    ConstructLHWI(r4, (errorInstr >> 4ULL), getVirAddr.lhwi2); // {19, 4}bit save in jump_pc
    ConstructLLWI(r4, (errorInstr >> 4ULL), getVirAddr.llwi2);

    // CSRRW: set goto instr num to jump_pc reg
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_JUMP_PC_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       getVirAddr.csrrw1);

    // BNE: sq Virtual Addr = 0 go to error
    const uint8_t instrOffset = static_cast<uint8_t>(errorInstr & 0xFULL);
    ConstructBranch(sqVirtualAddrReg, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, instrOffset, getVirAddr.beq1);
}


void ConstructSwitchGetSqEnableFcI(const rtStarsCondIsaRegister_t sqEnableReg,
                                                       const rtStarsCondIsaRegister_t sqAddrReg,
                                                       RtStarsSwitchGetSqEnableI &getSqEnable)
{
    // getenable
    ConstructLoad(sqAddrReg, STARS_SIMPLE_SQ_ENABLE_OFFSET, sqEnableReg, RT_STARS_COND_ISA_LOAD_FUNC3_LDR,
                  getSqEnable.ldr);

    // {0, 0} p0_sq_en
    ConstructOpImmAndi(sqEnableReg, sqEnableReg, 0x1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, getSqEnable.andi1);
}

void ConstructSwitchGetSqHeadAndTailFcI(const rtStarsCondIsaRegister_t headReg,
                                                            const rtStarsCondIsaRegister_t tailReg,
                                                            const rtStarsCondIsaRegister_t addrReg,
                                                            RtStarsSwitchGetSqHeadAndTailI &getSqheadAndTail,
                                                            const rtStarsLabelSwitchByIndexFcPara_t &fcPara)
{
    // {15, 0} get tail
    ConstructLoad(addrReg, fcPara.sqTailOffset,
                  tailReg, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, getSqheadAndTail.ldr1);
    ConstructOpImmAndi(tailReg, tailReg, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, getSqheadAndTail.andtail);

    // {15, 0} get head, the address offset of head and tail is 8.
    ConstructLoad(addrReg, fcPara.sqHeadOffset,
                  headReg, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, getSqheadAndTail.ldr2);
    ConstructOpImmAndi(headReg, headReg, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, getSqheadAndTail.andhead);
}

void ConstructLabelSwitchByIndexFc(rtStarsLabelSwitchByIndexFc_t &fc,
                                                       const rtStarsLabelSwitchByIndexFcPara_t &fcPara,
                                                       const uint16_t currentStreamSqId)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    uint64_t offset;

    /* r1: index r2: maxIndex, and r1 is less than r2 */
    ConstructLabelSwitchByIdxCheckFc(fcPara.indexPtr, fcPara.maxVal, fcPara.labelCountPtr, fc.labelSwitchCheckIndex_i);

    // store index
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx);
    ConstructStore(r3, r1, 0x20U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx);

    // A label takes up 16 bytes, Index moves 4 bits to the left
    ConstructOpImmSlli(r1, r1, 4U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI,
                       RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli);

    // LLWI  R3  &TrueStreamPTR
    ConstructLLWI(r3, fcPara.labelInfoPtr, fc.llwi);
    // LLWI  R3  &TrueStreamPTR
    ConstructLHWI(r3, fcPara.labelInfoPtr, fc.lhwi);

    // ADD    R1  R1  R3
    ConstructOpOp(r1, r3, r1, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add);

    // LD_R   R1  R1 get labelinfo (pos + sqid)
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr);

    // get sqid: R2
    ConstructOpImmAndi(r1, r2, 0x7FFU, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.andi1);

    // Load dfx ptr and store labelinfo
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx0);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx0);
    ConstructStore(r3, r1, 0x0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx0);

    // XORI check if same sqid
    ConstructOpImmAndi(r2, r5, static_cast<uint32_t>(currentStreamSqId), RT_STARS_COND_ISA_OP_IMM_FUNC3_XORI, fc.xori);
    // current stream
    offset = offsetof(rtStarsLabelSwitchByIndexFc_t, goto_r2);
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r3, offset, fc.jumpPc1);
    ConstructBranch(r5, RT_STARS_COND_ISA_REGISTER_R0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ,
                    offset, fc.beq1);
    /* Accroding to sqid, get virtual addr to R5 */
    ConstructSwitchGetSqVirtualAddrFcI(r2, r5, fcPara.sqVirtualAddr, fc);

    /* if not same sqid, get enable flag. r4: enable flag, r5: virtual addr base */
    ConstructSwitchGetSqEnableFcI(r4, r5, fc.getSqEnable_i);

    // Load dfx ptr and store enable flag
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx1);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx1);
    ConstructStore(r3, r4, 0x8U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx1);

    offset = offsetof(rtStarsLabelSwitchByIndexFc_t, goto_r1);
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r3, offset, fc.jumpPc2);
    /* if rtsq is disable, go to goto_r */
    ConstructBranch(r4, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, offset, fc.beq2);

    /* if enable, r2: tail << 48 , r4: head << 48, r5: virtual addr base */
    ConstructSwitchGetSqHeadAndTailFcI(r4, r2, r5, fc.getSqHeadAndTail_i, fcPara);

    // Load dfx ptr and store enable flag
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx2);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx2);
    ConstructStore(r3, r2, 0x10U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx2_0);
    ConstructStore(r3, r4, 0x18U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx2_1);

    offset = offsetof(rtStarsLabelSwitchByIndexFc_t, disableSq_i);
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r3, offset, fc.jumpPc3);
    /* if head eq tail, go to disable else report error */
    ConstructBranch(r4, r2, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, offset, fc.beq3);
    ConstructErrorInstr(fc.err);

    // disable stream
    ConstructSwitchDisableStreamFcI(r5, fc.disableSq_i);

    // GoTo_R R4  R1
    ConstructGotoR(r1, r4, fc.goto_r1);

    // LOOP   4   R4  delay N cycle
    constexpr uint16_t delayCycle = 0B1111111111111U;
    offset = offsetof(rtStarsLabelSwitchByIndexFc_t, goto_r1);
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r3, offset, fc.jumpPc4);
    ConstructLoop(r4, delayCycle, static_cast<uint8_t>(offset), fc.loop);
    // use stored index in dfxAddr+0x20U
    ConstructAddExecTimesFc(fcPara.dfxAddr + 0x20U, fcPara.labelInfoPtr, fc.addExecTimes_1);

    // Active_R   R4    R1
    ConstructActiveR(r1, r4, fc.active_r);

    // DeActive_I     Stream-itself
    ConstructDeActiveI(r5, currentStreamSqId, fc.deActiveI);

    offset = offsetof(rtStarsLabelSwitchByIndexFc_t, end);
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r3, offset, fc.jumpPc5);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, offset, fc.beq4);

    ConstructAddExecTimesFc(fcPara.indexPtr, fcPara.labelInfoPtr, fc.addExecTimes_2);

    ConstructGotoR(r1, r4, fc.goto_r2);

    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(rtStarsLabelSwitchByIndexFc_t) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, cmd[i]);
    }
}

void ConstructAddExecTimesFc(const uint64_t indexPtr, const uint64_t labelInfoPtr,
                                                 RtStarsAddExecTimesFc &fc)
{
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    ConstructLoadImm(r4, indexPtr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LWU, fc.ldi);

    // LLWI  R5  &TrueStreamPTR
    ConstructLLWI(r5, labelInfoPtr, fc.llwi1);
    // LLWI  R5  &TrueStreamPTR
    ConstructLHWI(r5, labelInfoPtr, fc.lhwi1);

    // A label takes up 16 bytes, Index moves 4 bits to the left
    ConstructOpImmSlli(r4, r4, 4U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI,
                       RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli1);
    // ADD    R4  R5  R4
    ConstructOpOp(r4, r5, r4, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add1);

    // LD_R   R4  R5 get labelinfo execAddr
    ConstructLoad(r4, 8U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr1);
    // get exec times
    ConstructLoad(r5, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);

    ConstructOpImmAndi(r4, r4, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);

    ConstructStore(r5, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SH, fc.sh);
    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsAddExecTimesFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, cmd[i]);
    }
}

void ConstructStreamActiveFc(RtStarsStreamActiveFc &fc,
                                                 const rtStarsStreamActiveFcPara_t &fcPara,
                                                 const uint32_t offsetStart)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3; // for mask reg
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4; // for jump pc reg
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    uint64_t offset;
    /* get rtsq fsm state */
    ConstructGetSqFsmStateFcI(r1, r2, r3, fcPara.sqId, fcPara.rtSqFsmStateAddr, fc.getSqFsmState_i);

    // store fsm to Cqe status
    ConstructSetCqeStatus(r1, r0, fc.dfxFsm);
    // Load dfx ptr and store fsm
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx0);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx0);
    ConstructStore(r3, r1, 0x0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx0);
    uint64_t offset1 = offsetof(RtStarsStreamActiveFc, getSqFsmState_i) + offsetStart;
    offset1 = offset1/sizeof(uint32_t);
    constexpr uint32_t cycle = 10000U;

    /* r5 = r1 */
    ConstructOpImmAndi(r1, r5, 0, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi);

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    DevProperties prop;
    rtError_t error = GET_DEV_PROPERTIES(chipType, prop);
    RT_LOG(RT_LOG_DEBUG, "GetDevProperties, ret = %u", error);
    uint32_t shamt = prop.rtsqShamt;
    
    ConstructOpImmAndi(r5, r5, shamt, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.andi1);
    /* r3 = fcPara.sqId */
    ConstructLLWI(r3, fcPara.sqId, fc.llwi1);
    ConstructLHWI(r3, fcPara.sqId, fc.lhwi1);
    /* r5 != r3 goto offset1 */
    ConstructOpOp(r3, r5, r5, RT_STARS_COND_ISA_OP_FUNC3_XOR, RT_STARS_COND_ISA_OP_FUNC7_XOR, fc.xor1);
    ConstructSetJumpPcFc(r4, offset1, fc.jumpPc0);
    ConstructLoop(r5, static_cast<uint16_t>(cycle), static_cast<uint8_t>(offset1), fc.sqNEloop);

    // {3:0} dfx_rtsq_fsm_state
    ConstructOpImmSlli(r1, r1, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI,
                       fc.srli);
    ConstructOpImmAndi(r1, r1, 0xFU, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.andi2);

    /* if fsm is 9 go to error */
    offset = offsetof(RtStarsStreamActiveFc, err) + offsetStart;
    offset = offset/sizeof(uint32_t);
    ConstructOpImmAndi(r1, r5, 0x9U, RT_STARS_COND_ISA_OP_IMM_FUNC3_XORI, fc.andi9);
    ConstructSetJumpPcFc(r4, offset, fc.jumpErr0);
    ConstructBranch(r5, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.fsm9err);
    /* else fsm is not 0 go to back */
    ConstructSetJumpPcFc(r4, offset1, fc.jumpPc1);
    ConstructLoop(r1, static_cast<uint16_t>(cycle), static_cast<uint8_t>(offset1), fc.loop);

    /* get rtsq enable value */
    ConstructGetSqEnableFcI(r1, fcPara.rtSqEnableAddr, fc.getSqEnable_i);
    offset = offsetof(RtStarsStreamActiveFc, goto_i) + offsetStart;
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r4, offset, fc.jumpPc2);

    // Load dfx ptr and store enable flag
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx1);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx1);
    ConstructStore(r3, r1, 0x8U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx1);

    /* if rtsq is disable, go to reset rtsq head */
    ConstructBranch(r1, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, offset, fc.beq1);

    /* get rtsq head and tail */
    ConstructGetSqHeadAndTailFcI(r1, r2, fcPara.rtSqTailAddr, fcPara.rtSqHeadAddr, fc.getSqHeadAndTail_i);
    offset = offsetof(RtStarsStreamActiveFc, err) + offsetStart;
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r4, offset, fc.jumpPc3);

    // Load dfx ptr and store enable flag
    ConstructLLWI(r3, fcPara.dfxAddr, fc.llwiDfx2);
    ConstructLHWI(r3, fcPara.dfxAddr, fc.lhwiDfx2);
    ConstructStore(r3, r1, 0x10U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx2_0);
    ConstructStore(r3, r2, 0x18U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.stdDfx2_1);
    /* if the head and tail are not equal, go to error */
    ConstructBranch(r1, r2, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, offset, fc.bne2);

    /* disable stream */
    ConstructDisableStreamFcI(r1, fcPara.rtSqEnableAddr, fc.disableSq_i);

    /* reset rtsq head */
    ConstructGotoI(r0, static_cast<uint16_t>(fcPara.sqId), 0U, fc.goto_i);

    /* add stream active times */
    ConstructAddStreamActiveTimesFcI(r1, r2, fcPara.streamExecTimesAddr, fc.addStreamActiveTimes);

    /* active stream */
    ConstructActiveI(r0, static_cast<uint16_t>(fcPara.sqId), fc.active_i);
    offset = offsetof(RtStarsStreamActiveFc, end) + offsetStart;
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r4, offset, fc.jumpPc4);
    /* go to nop */
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, offset, fc.beq2);

    ConstructErrorInstr(fc.err);

    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsStreamActiveFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, cmd[i]);
    }
}

void ConstructStreamSwitchFc(rtStarsStreamSwitchFc_t &fc, const rtStarsStreamSwitchFcPara_t &fcPara)
{
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;

    rtStarsCondIsaBranchFunc3_t func3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
    bool isNeedReverseCmpReg = false;
    ConvertConditionToBranchFunc3(fcPara.condition, func3, isNeedReverseCmpReg);

    // LD_I R1 &ptr
    ConstructLoadImm(r1, fcPara.varPtr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD, fc.load_i);

    // LHWI R2 immd[63:49]
    ConstructLHWI(r2, static_cast<uint64_t>(fcPara.val), fc.lhwi);
    // LLWI R2 immd[48:0]
    ConstructLLWI(r2, static_cast<uint64_t>(fcPara.val), fc.llwi);

    uint64_t offset = offsetof(rtStarsStreamSwitchFc_t, end);
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r3, offset, fc.jumpPc0);

    // BNE 11 R1 R2
    if (isNeedReverseCmpReg) {
        // if need converse, swap vae reg and value reg
        ConstructBranch(r2, r1, func3, offset, fc.bne0);
    } else {
        ConstructBranch(r1, r2, func3, offset, fc.bne0);
    }

    // streamActive
    rtStarsStreamActiveFcPara_t streamActivefcPara = {};
    streamActivefcPara.sqId = fcPara.trueSqId;
    streamActivefcPara.streamExecTimesAddr = fcPara.streamExecTimesAddr;
    streamActivefcPara.rtSqFsmStateAddr = fcPara.rtSqFsmStateAddr;
    streamActivefcPara.rtSqEnableAddr = fcPara.rtSqEnableAddr;
    streamActivefcPara.rtSqTailAddr = fcPara.rtSqTailAddr;
    streamActivefcPara.dfxAddr = fcPara.dfxAddr;
    streamActivefcPara.rtSqHeadAddr = fcPara.rtSqHeadAddr;
    offset = offsetof(rtStarsStreamSwitchFc_t, streamActiveFc);

    ConstructStreamActiveFc(fc.streamActiveFc, streamActivefcPara, offset);

    // deactive current stream
    ConstructDeActiveI(r2, fcPara.currentSqId, fc.deActiveI);

    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(rtStarsStreamSwitchFc_t) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, cmd[i]);
    }
}

void ConstructStreamSwitchExFc(rtStarsStreamSwitchExFc_t &fc,
                                                   const rtStarsStreamSwitchExFcPara_t &fcPara)
{
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;

    rtStarsCondIsaBranchFunc3_t branchFunc3 = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
    bool isNeedReverse = false;
    ConvertConditionToBranchFunc3(fcPara.condition, branchFunc3, isNeedReverse);

    const rtStarsCondIsaLoadImmFunc3_t loadImmFunc3 =
        (fcPara.dataType == RT_SWITCH_INT32) ? RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LW :
        RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD;

    // LD_I R1 var ptr
    ConstructLoadImm(r1, fcPara.varPtr, loadImmFunc3, fc.loadVar_i);

    // LD_I R2 value ptr
    ConstructLoadImm(r2, fcPara.valPtr, loadImmFunc3, fc.loadVal_i);

    uint64_t offset = offsetof(rtStarsStreamSwitchExFc_t, end);
    offset = offset/sizeof(uint32_t);
    ConstructSetJumpPcFc(r3, offset, fc.jumpPc0);

    // BNE R1 R2
    if (isNeedReverse) {
        // if need converse, swap var reg and value reg
        ConstructBranch(r2, r1, branchFunc3, offset, fc.bne0);
    } else {
        ConstructBranch(r1, r2, branchFunc3, offset, fc.bne0);
    }

    // streamActive
    rtStarsStreamActiveFcPara_t streamActivefcPara = {};
    streamActivefcPara.sqId = fcPara.trueSqId;
    streamActivefcPara.streamExecTimesAddr = fcPara.streamExecTimesAddr;
    streamActivefcPara.rtSqFsmStateAddr = fcPara.rtSqFsmStateAddr;
    streamActivefcPara.rtSqEnableAddr = fcPara.rtSqEnableAddr;
    streamActivefcPara.rtSqTailAddr = fcPara.rtSqTailAddr;
    streamActivefcPara.dfxAddr = fcPara.dfxAddr;
    streamActivefcPara.rtSqHeadAddr = fcPara.rtSqHeadAddr;
    offset = offsetof(rtStarsStreamSwitchExFc_t, streamActiveFc);
    ConstructStreamActiveFc(fc.streamActiveFc, streamActivefcPara, offset);

    // deactive current stream
    ConstructDeActiveI(r2, fcPara.currentSqId, fc.deActiveI);

    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(rtStarsStreamSwitchExFc_t) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, cmd[i]);
    }
}

void ConvertConditionToOpAndBranchFunc(const RtStarsMemWaitValueInstrFcPara &fcPara,
    rtStarsCondIsaBranchFunc3_t &branchFunc, rtStarsCondIsaOpFunc3_t &opFunc3,
    RtStarsCondIsaOpFunc7 &opFunc7, uint64_t &value1, uint64_t &value2)
{
    /*
     * (*addr opFunc value1) branchFunc value2
     * MEM_WAIT_VALUE_TYPE_GEQ = 0U,    // Wait until (*addr >= value)       (*addr | 0) >= value
     * MEM_WAIT_VALUE_TYPE_EQ  = 1U,    // Wait until (*addr == value)       (*addr | 0) == value
     * MEM_WAIT_VALUE_TYPE_AND = 2U,    // Wait until (*addr & value) != 0   (*addr & value) != 0
     * MEM_WAIT_VALUE_TYPE_NOR = 3U,    // Wait until ~(*addr | value) != 0  (*addr | value) != 0xffffffffffffffff
     */

    switch (fcPara.flag) {
        case MEM_WAIT_VALUE_TYPE_GEQ:
            // (*addr | 0) >= value
            opFunc3 = RT_STARS_COND_ISA_OP_FUNC3_OR;
            opFunc7 = RT_STARS_COND_ISA_OP_FUNC7_OR;
            branchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BGE;
            value1 = 0ULL;
            value2 = fcPara.value;
            break;
        case MEM_WAIT_VALUE_TYPE_EQ:
            // (*addr | 0) == value
            opFunc3 = RT_STARS_COND_ISA_OP_FUNC3_OR;
            opFunc7 = RT_STARS_COND_ISA_OP_FUNC7_OR;
            branchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
            value1 = 0ULL;
            value2 = fcPara.value;
            break;
        case MEM_WAIT_VALUE_TYPE_AND:
            // (*addr & value) != 0
            opFunc3 = RT_STARS_COND_ISA_OP_FUNC3_AND;
            opFunc7 = RT_STARS_COND_ISA_OP_FUNC7_AND;
            branchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BNE;
            value1 = fcPara.value;
            value2 = 0ULL;
            break;
        case MEM_WAIT_VALUE_TYPE_NOR:
            // (*addr | value) != 0xffffffffffffffff
            opFunc3 = RT_STARS_COND_ISA_OP_FUNC3_OR;
            opFunc7 = RT_STARS_COND_ISA_OP_FUNC7_OR;
            branchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BNE;
            value1 = fcPara.value;
            value2 = MAX_UINT64_NUM;
            break;

        default:
            RT_LOG(RT_LOG_WARNING, "condition=%u does not support.", fcPara.flag);
            break;
    }
}

void ConvertOpToReverseOp(const rtStarsCondIsaBranchFunc3_t branchFunc,
    rtStarsCondIsaBranchFunc3_t &reverseBranchFunc)
{
    switch (branchFunc) {
        case RT_STARS_COND_ISA_BRANCH_FUNC3_BGE:
            reverseBranchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BLT;
            break;
        case RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ:
            reverseBranchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BNE;
            break;
        case RT_STARS_COND_ISA_BRANCH_FUNC3_BNE:
            reverseBranchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
            break;

        default:
            RT_LOG(RT_LOG_WARNING, "branchFunc=%u does not support.", branchFunc);
            break;
    }
}

/* used for none-sofeware sq */
void ConstructMemWaitValueInstr2(RtStarsMemWaitValueLastInstrFc &fc,
                                                     const RtStarsMemWaitValueInstrFcPara &fcPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    rtStarsCondIsaBranchFunc3_t branchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
    rtStarsCondIsaBranchFunc3_t reverseBranchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BNE;
    rtStarsCondIsaOpFunc3_t opFunc3 = RT_STARS_COND_ISA_OP_FUNC3_OR;
    RtStarsCondIsaOpFunc7 opFunc7 = RT_STARS_COND_ISA_OP_FUNC7_OR;
    rtStarsCondIsaLoadImmFunc3_t opFunc8 = (fcPara.awSize == RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT) ?
                RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LBU : RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD;
    uint64_t value1 = 0ULL;
    uint64_t value2 = fcPara.value;

    ConvertConditionToOpAndBranchFunc(fcPara, branchFunc, opFunc3, opFunc7, value1, value2);
    ConvertOpToReverseOp(branchFunc, reverseBranchFunc);

    // init loop index, r3 = r0 + 0 = 0
    ConstructOpImmAndi(r0, r3, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi0);

    // read value2 to r5
    ConstructLHWI(r5, value2, fc.lhwi1);
    ConstructLLWI(r5, value2, fc.llwi1);

    // init r4, r4 = r0 + 0 = 0
    ConstructOpImmAndi(r0, r4, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);

    // load max loop num to r4
    ConstructLLWI(r4, static_cast<uint64_t>(fcPara.maxLoop), fc.llwi2);

    uint64_t loadValueOffset = offsetof(RtStarsMemWaitValueLastInstrFc, loadValue);
    loadValueOffset = loadValueOffset / sizeof(uint32_t);

    uint64_t modifySqHeadOffset = offsetof(RtStarsMemWaitValueLastInstrFc, goto_i);
    modifySqHeadOffset = modifySqHeadOffset / sizeof(uint32_t);

    uint64_t endOffset = offsetof(RtStarsMemWaitValueLastInstrFc, end);
    endOffset = endOffset / sizeof(uint32_t);

    // load devAddr data from hbm to r2
    ConstructLoadImm(r2, fcPara.devAddr, opFunc8, fc.loadValue);

    // read value1 to r1
    ConstructLHWI(r1, value1, fc.lhwi3);
    ConstructLLWI(r1, value1, fc.llwi3);

    // r2 = r2 op value1(r1)
    ConstructOpOp(r2, r1, r2, opFunc3, opFunc7, fc.op);

    // r2 == r5, goto endOffset
    ConstructSetJumpPcFc(r1, endOffset, fc.jumpPc1);
    ConstructBranch(r2, r5, branchFunc, static_cast<uint8_t>(endOffset), fc.branch1);

    // r2 != r5, loop index++ r3 = r3 + 1
    ConstructOpImmAndi(r3, r3, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi2);

    // r3 >= r4, goto modifySqHeadOffset
    ConstructSetJumpPcFc(r1, modifySqHeadOffset, fc.jumpPc2);
    ConstructBranch(r3, r4, RT_STARS_COND_ISA_BRANCH_FUNC3_BGE, static_cast<uint8_t>(modifySqHeadOffset), fc.bge);

    // nop
    ConstructNop(fc.nop1);
    ConstructNop(fc.nop2);

    // r2 != r5, goto loadValueOffset, continue load devAddr data from hbm to r2
    ConstructSetJumpPcFc(r1, loadValueOffset, fc.jumpPc3);
    ConstructBranch(r2, r5, reverseBranchFunc, static_cast<uint8_t>(loadValueOffset), fc.branch2);

    // modifySqHeadOffset
    ConstructGotoI(r5, static_cast<uint16_t>(fcPara.sqId), static_cast<uint16_t>(fcPara.sqHeadPre), fc.goto_i);

    // end
    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsMemWaitValueLastInstrFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, cmd[i]);
    }
}

/* used for sofeware sq */
void ConstructMemWaitValueInstr2Ex(RtStarsMemWaitValueLastInstrFcEx &fc,
                                   const RtStarsMemWaitValueInstrFcPara &fcPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;

    rtStarsCondIsaBranchFunc3_t branchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ;
    rtStarsCondIsaBranchFunc3_t reverseBranchFunc = RT_STARS_COND_ISA_BRANCH_FUNC3_BNE;
    rtStarsCondIsaOpFunc3_t opFunc3 = RT_STARS_COND_ISA_OP_FUNC3_OR;
    RtStarsCondIsaOpFunc7 opFunc7 = RT_STARS_COND_ISA_OP_FUNC7_OR;
    rtStarsCondIsaLoadImmFunc3_t opFunc8 = (fcPara.awSize == RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT) ?
                    RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LBU : RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD;
    uint64_t value1 = 0ULL;
    uint64_t value2 = fcPara.value;

    ConvertConditionToOpAndBranchFunc(fcPara, branchFunc, opFunc3, opFunc7, value1, value2);
    ConvertOpToReverseOp(branchFunc, reverseBranchFunc);

    // init loop index, r3 = r0 + 0 = 0
    ConstructOpImmAndi(r0, r3, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi0);

    // read value2 to r5
    ConstructLHWI(r5, value2, fc.lhwi1);
    ConstructLLWI(r5, value2, fc.llwi1);

    // init r4, r4 = r0 + 0 = 0
    ConstructOpImmAndi(r0, r4, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);

    // load max loop num to r4
    ConstructLLWI(r4, static_cast<uint64_t>(fcPara.maxLoop), fc.llwi2);

    uint64_t loadValueOffset = offsetof(RtStarsMemWaitValueLastInstrFcEx, loadValue);
    loadValueOffset = loadValueOffset / sizeof(uint32_t);

    uint64_t modifySqHeadOffset = offsetof(RtStarsMemWaitValueLastInstrFcEx, loadSqId);
    modifySqHeadOffset = modifySqHeadOffset / sizeof(uint32_t);

    uint64_t endOffset = offsetof(RtStarsMemWaitValueLastInstrFcEx, end);
    endOffset = endOffset / sizeof(uint32_t);

    // load devAddr data from hbm to r2
    ConstructLoadImm(r2, fcPara.devAddr, opFunc8, fc.loadValue);

    // read value1 to r1
    ConstructLHWI(r1, value1, fc.lhwi3);
    ConstructLLWI(r1, value1, fc.llwi3);

    // r2 = r2 op value1(r1)
    ConstructOpOp(r2, r1, r2, opFunc3, opFunc7, fc.op);

    // r2 == r5, goto endOffset
    ConstructSetJumpPcFc(r1, endOffset, fc.jumpPc1);
    ConstructBranch(r2, r5, branchFunc, static_cast<uint8_t>(endOffset), fc.branch1);

    // r2 != r5, loop index++ r3 = r3 + 1
    ConstructOpImmAndi(r3, r3, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi2);

    // r3 >= r4, goto modifySqHeadOffset
    ConstructSetJumpPcFc(r1, modifySqHeadOffset, fc.jumpPc2);
    ConstructBranch(r3, r4, RT_STARS_COND_ISA_BRANCH_FUNC3_BGE, static_cast<uint8_t>(modifySqHeadOffset), fc.bge);

    // nop
    ConstructNop(fc.nop1);
    ConstructNop(fc.nop2);

    // r2 != r5, goto loadValueOffset, continue load devAddr data from hbm to r2
    ConstructSetJumpPcFc(r1, loadValueOffset, fc.jumpPc3);
    ConstructBranch(r2, r5, reverseBranchFunc, static_cast<uint8_t>(loadValueOffset), fc.branch2);

    // modifySqHeadOffset
    // load sqid from virtual addr to r3
    ConstructLoadImm(r3, fcPara.sqIdMemAddr, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD, fc.loadSqId);

    // load sqHead to r4
    ConstructLHWI(r4, static_cast<uint64_t>(fcPara.sqHeadPre), fc.lhwi4);
    ConstructLLWI(r4, static_cast<uint64_t>(fcPara.sqHeadPre), fc.llwi4);

    // r4 = r4 < 16
    ConstructOpImmSlli(r4, r4, 16U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli);

    // r3 = r3 | r4, sqId=[10:0], head=[31:16]
    ConstructOpOp(r3, r4, r3, RT_STARS_COND_ISA_OP_FUNC3_OR, RT_STARS_COND_ISA_OP_FUNC7_OR, fc.op2);

    // modify sq head by goto_r
    ConstructGotoR(r3, r5, fc.goto_r);

    // end
    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsMemWaitValueLastInstrFcEx) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}
}  // namespace runtime
}  // namespace cce
