/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_dqs_cond_isa_helper.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_cond_isa_batch_struct.hpp"

namespace cce {
namespace runtime {

constexpr uint64_t dqsBlockIdMask = 0x1FC00ULL;      // block_id in mbuf handle. bit[16:10]
constexpr uint8_t dqsBlockIdOffset = 10U;            // block_id in mbuf handle. bit[16:10]
constexpr uint64_t dqsErrCodeMask = 0xE0000000ULL;   // error code in mbuf handle. bit[31:29]
constexpr uint64_t dqsPoolIdBlkIdMask = 0x1FFFFULL;  // pool_id_block_id in mbuf_handle. bit[16:0]
constexpr uint8_t dqsErrCodeRightShift = 61U;        // error code in mbuf handle. bit[31:29]
constexpr uint64_t dqsErrorQueueNotEnable = 0x2ULL;  // queue is not enable
constexpr uint64_t dqsErrorOWNotEnable = 0x3ULL;  // overWrite is not enable
constexpr uint64_t gqmEmptyErrCode = 0x5A5AULL;
constexpr uint64_t mbufInvalidErrCode = 0x5B5BULL;
constexpr uint64_t QUEUE_NOT_ENABLE_ERR_CODE = 0x6A6AULL;
constexpr uint64_t OW_NOT_ENABLE_ERR_CODE = 0x6B6BULL;
constexpr uint64_t INVALID_CONDITION_ERR_CODE = 0x7A7BULL;
// GQM CMD
constexpr uint32_t RT_STARS_COND_GQM_COMMAND_POP = 0B000101;

static void ConstructGqmPopInstr(RtStarsCondGqmOp &opGqmPop)
{
    opGqmPop.command = RT_STARS_COND_GQM_COMMAND_POP;
    opGqmPop.wakeUp = 0U;
}

static void ConstructLaunchGqmInstr(const rtStarsCondIsaRegister_t dstReg, const rtStarsCondIsaRegister_t srcReg1,
    const rtStarsCondIsaRegister_t srcReg2, RtStarsCondGqm &opLaunchGqmInstr)
{
    opLaunchGqmInstr.opCode = RT_STARS_COND_ISA_OP_CODE_GQM;
    opLaunchGqmInstr.rs1 = srcReg1;
    opLaunchGqmInstr.rs2 = srcReg2;
    opLaunchGqmInstr.rd = dstReg;
}

static void ConstructOpMul(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
                                        const rtStarsCondIsaRegister_t dstReg, RtStarsCondOpOp &opOp)
{
    ConstructOpOp(rs1Reg, rs2Reg, dstReg, RT_STARS_COND_ISA_OP_FUNC3_MUL, RT_STARS_COND_ISA_OP_FUNC7_MUL, opOp);
}

static void ConstructOpAdd(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
                                        const rtStarsCondIsaRegister_t dstReg, RtStarsCondOpOp &opOp)
{
    ConstructOpOp(rs1Reg, rs2Reg, dstReg, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, opOp);
}

static void ConstructOpAnd(const rtStarsCondIsaRegister_t rs1Reg, const rtStarsCondIsaRegister_t rs2Reg,
    const rtStarsCondIsaRegister_t dstReg, RtStarsCondOpOp &opOp)
{
    ConstructOpOp(rs1Reg, rs2Reg, dstReg, RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, opOp);
}

void ConstructMbufFreeInstrFc(RtStarsDqsMbufFreeFc &fc, const RtDqsMbufFreeFcPara &funcCallPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr rtStarsCondIsaRegister_t r7 = RT_STARS_COND_ISA_REGISTER_R7;
    constexpr rtStarsCondIsaRegister_t r8 = RT_STARS_COND_ISA_REGISTER_R8;
    constexpr uint64_t axiUserVaCfgMask = 0x100000001ULL;

    // read immd reg va cfg mask
    ConstructLLWI(r8, axiUserVaCfgMask, fc.llwi);
    // r6 作为inpu queue num 的下标，从0开始
    ConstructOpImmAndi(r0, r6, 0, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.andi);

    // 加载mbuf pool操作寄存器的地址到 r1 寄存器 (input_mbuf_free_addrs)
    ConstructLLWI(r1, funcCallPara.mbufFreeAddr, fc.llwi1);
    ConstructLHWI(r1, funcCallPara.mbufFreeAddr, fc.lhwi1);

    // 加载mbuf handle的地址到 r2 寄存器中 (input_mbuf_list)
    ConstructLLWI(r2, funcCallPara.mbufHandleAddr, fc.llwi2);
    ConstructLHWI(r2, funcCallPara.mbufHandleAddr, fc.lhwi2);

    // 加载 mbufPoolIndexMax 到 r3 寄存器中
    ConstructLLWI(r3, funcCallPara.mbufPoolIndexMax, fc.llwi3);
    ConstructLHWI(r3, funcCallPara.mbufPoolIndexMax, fc.lhwi3);

    // 根据mbufHandleAddr的地址 r2 读mbuf handle 到 r4 寄存器中, LOAD 64bit数据，而mbuf handle是32bit的, 存在读越界风险(数组多开4Byte)
    ConstructLoad(r2, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr1);

    // 根据mbufFreeAddr的地址 r1 读mbuf pool 到 r5 寄存器中
    ConstructLoad(r1, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);

    // cfg use PA
    ConstructSystemCsr(r8, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrc);

    // 将mbuf handle r4 写入 mbuf pool寄存器 r5中 SW R4, R5, 0
    ConstructStore(r5, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.sw);

    // restore to use VA
    ConstructSystemCsr(r8, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrs);

    // r2 mbufHandleAddr + 4， 下一个mbuf handle 的地址
    ConstructOpImmAndi(r2, r2, 4, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);

    // r1 mbufFreeAddr + 8，下一个mbuf pool的寄存器地址
    ConstructOpImmAndi(r1, r1, 8, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi2);

    // r6自增1, index ++
    ConstructOpImmAndi(r6, r6, 1, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi3);

    // Jump pc 在 Func call 中，跳转指令大于15时，需要借助 CSR寄存器(JUMP_PC)完成跳转
    uint64_t offset = offsetof(RtStarsDqsMbufFreeFc, ldr1);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc1);

    // 构造 branch 指令，  index(r6) < mbufPoolIndexMax(r3)  时，跳转到LOAD1
    ConstructBranch(r6, r3, RT_STARS_COND_ISA_BRANCH_FUNC3_BLT, offset, fc.blt1);

    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsMbufFreeFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsEnqueueFc(RtStarsDqsEnqueueFc &fc, const RtStarsDqsFcPara &funcCallPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr rtStarsCondIsaRegister_t r7 = RT_STARS_COND_ISA_REGISTER_R7;
    constexpr rtStarsCondIsaRegister_t r8 = RT_STARS_COND_ISA_REGISTER_R8;
    constexpr rtStarsCondIsaRegister_t r9 = RT_STARS_COND_ISA_REGISTER_R9;
    constexpr rtStarsCondIsaRegister_t r10 = RT_STARS_COND_ISA_REGISTER_R10;

    // r10 作为output queue num 的下标，从0开始
    ConstructOpImmAndi(r0, r10, 0, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.andi1);

    // load overWriteAddr into R1
    ConstructLHWI(r1, funcCallPara.prodqOwAddr, fc.lhwi1);
    ConstructLLWI(r1, funcCallPara.prodqOwAddr, fc.llwi1);

    // load mbufHandle addr into R2
    ConstructLHWI(r2, funcCallPara.ouputMbufHandleAddr, fc.lhwi2);
    ConstructLLWI(r2, funcCallPara.ouputMbufHandleAddr, fc.llwi2);

    // load enqueOpAddr into R3
    ConstructLHWI(r3, funcCallPara.enqueOpAddr, fc.lhwi3);
    ConstructLLWI(r3, funcCallPara.enqueOpAddr, fc.llwi3);

    // free mbuf handle // 加载 mbuf pool 操作寄存器的地址到 r9 寄存器 (output_mbuf_free_addrs)
    ConstructLLWI(r9, funcCallPara.mbufFreePara.mbufFreeAddr, fc.llwi7);
    ConstructLHWI(r9, funcCallPara.mbufFreePara.mbufFreeAddr, fc.lhwi7);

    // 加载 mbufPoolIndexMax 到 r4 寄存器中
    ConstructLLWI(r4, funcCallPara.mbufPoolIndexMax, fc.llwi4);
    ConstructLHWI(r4, funcCallPara.mbufPoolIndexMax, fc.lhwi4);

    // 加载 QMGR_PRODQ_OW 寄存器内容到r5
    ConstructLoad(r1, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr1);
    ConstructLoad(r5, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);

    // 通过右移和左移 获取handle[31:29] bit的数据
    ConstructOpImmSlli(r5, r6, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli1);
    ConstructOpImmSlli(r6, r6, dqsErrCodeRightShift, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli1);

    ConstructLLWI(r7, dqsErrorQueueNotEnable, fc.llwi5);
    ConstructLHWI(r7, dqsErrorQueueNotEnable, fc.lhwi5);
    // if queue not enable, goto err1
    uint64_t offset = offsetof(RtStarsDqsEnqueueFc, llwi9);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpPc1);
    ConstructBranch(r7, r6, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq1);

    ConstructLLWI(r8, dqsErrorOWNotEnable, fc.llwi6);
    ConstructLHWI(r8, dqsErrorOWNotEnable, fc.lhwi6);
    // if overWrite not enable, goto err2
    offset = offsetof(RtStarsDqsEnqueueFc, llwi10);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc2);
    ConstructBranch(r8, r6, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq2);

    // if no over write, goto enqueue (ldr4)
    offset = offsetof(RtStarsDqsEnqueueFc, ldr4);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc3);
    ConstructBranch(r0, r6, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.bne);
    
    // 根据 mbufFreeAddr 的地址 r9 读 mbuf pool 到 r7 寄存器中
    ConstructLoad(r9, 0U, r7, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr3);
    
    // r8 = ow mbufHandle
    ConstructLLWI(r8, dqsPoolIdBlkIdMask, fc.llwi8);
    ConstructLHWI(r8, dqsPoolIdBlkIdMask, fc.lhwi8);
    ConstructOpAnd(r5, r8, r8, fc.and1);

    constexpr uint64_t axiUserVaCfgMask = 0x100000001ULL;
    // read immd reg va cfg mask
    ConstructLLWI(r5, axiUserVaCfgMask, fc.llwi);
    ConstructLHWI(r5, axiUserVaCfgMask, fc.lhwi);
    // cfg use PA
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrc);
    // 释放 ow mbuf handle
    ConstructStore(r7, r8, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.owfree);
    // restore to use VA
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrs);

    // load mbufHandle into R6
    ConstructLoad(r2, 0U, r6, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr4);
    // 通过右移和左移 获取handle[31:0] bit的数据
    ConstructOpImmSlli(r6, r5, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli2);
    ConstructOpImmSlli(r5, r5, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli2);

    // load enqueOpAddr into R7
    ConstructLoad(r3, 0U, r7, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr5);

    // Qmanager enqueue
    ConstructStore(r7, r5, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.enquei);

    // r1 prodqOwAddr + 8， 下一个prodqOwAddr
    ConstructOpImmAndi(r1, r1, 8, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);

    // r2 mbufHandleAddr + 4， 下一个mbuf handle 的地址
    ConstructOpImmAndi(r2, r2, 4, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi2);

    // r3 enqueOpAddr + 8，下一个enqueOpAddr
    ConstructOpImmAndi(r3, r3, 8, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi3);

    // r9 output_mbuf_free_addrs + 8，下一个output_mbuf_free_addrs
    ConstructOpImmAndi(r9, r9, 8, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi4);

    // r10自增1, index ++
    ConstructOpImmAndi(r10, r10, 1, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi5);

    // Jump pc 在 Func call 中，跳转指令大于15时，需要借助 CSR寄存器(JUMP_PC)完成跳转
    offset = offsetof(RtStarsDqsEnqueueFc, ldr1);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpPc4);

    // 构造 branch 指令，  index(r10) < mbufPoolIndexMax(r4)  时，跳转到LOAD1
    ConstructBranch(r10, r4, RT_STARS_COND_ISA_BRANCH_FUNC3_BLT, static_cast<uint8_t>(offset), fc.blt1);

    // skip error
    offset = offsetof(RtStarsDqsEnqueueFc, end);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc5);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq3);

    // error instr1
    ConstructLLWI(r7, QUEUE_NOT_ENABLE_ERR_CODE, fc.llwi9);
    ConstructLHWI(r7, QUEUE_NOT_ENABLE_ERR_CODE, fc.lhwi9);
    ConstructSystemCsr(r7, r0, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       fc.dfxFsm1);
    ConstructErrorInstr(fc.err1);
    // error instr2
    ConstructLLWI(r8, OW_NOT_ENABLE_ERR_CODE, fc.llwi10);
    ConstructLHWI(r8, OW_NOT_ENABLE_ERR_CODE, fc.lhwi10);
    ConstructSystemCsr(r8, r0, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       fc.dfxFsm2);
    ConstructErrorInstr(fc.err2);

    // end instr
    ConstructNop(fc.end);

    const uint32_t *const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsEnqueueFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsDequeueFc(RtStarsDqsDequeueFc &fc, const RtStarsDqsFcPara &funcCallPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr rtStarsCondIsaRegister_t r7 = RT_STARS_COND_ISA_REGISTER_R7;
    constexpr rtStarsCondIsaRegister_t r8 = RT_STARS_COND_ISA_REGISTER_R8;
    constexpr rtStarsCondIsaRegister_t r9 = RT_STARS_COND_ISA_REGISTER_R9;
    RtStarsCondGqmOpFc gqmPopi;
 
    // load GQM inst into R1
    ConstructGqmPopInstr(gqmPopi.inst);
    ConstructLLWI(r1, static_cast<uint64_t>(gqmPopi.value), fc.llwi1);
    ConstructLHWI(r1, static_cast<uint64_t>(gqmPopi.value), fc.lhwi1);
    // load GQMAddr addr into R2
    ConstructLLWI(r2, funcCallPara.gqmAddr, fc.llwi2);
    ConstructLHWI(r2, funcCallPara.gqmAddr, fc.lhwi2);
    // load inputMbufHandleAddr addr into R8
    ConstructLLWI(r8, funcCallPara.inputMbufHandleAddr, fc.llwi3);
    ConstructLHWI(r8, funcCallPara.inputMbufHandleAddr, fc.lhwi3);
    // load GQMAddr into R3
    ConstructLoad(r2, 0U, r3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr1);
    // launch GQM instr
    ConstructLaunchGqmInstr(r6, r1, r3, fc.gqm);

    // check pop result status, result status in R6
    ConstructLLWI(r3, funcCallPara.dfxAddr, fc.llwi4);
    ConstructLHWI(r3, funcCallPara.dfxAddr, fc.lhwi4);
    ConstructStore(r3, r6, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swdfx1);
    // pop status [63:23] reserve, [22:8] remain counter, [7:0] return code
    ConstructOpImmSlli(r6, r6, 56U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli);
    // Jump pc set err instr
    uint64_t offset = static_cast<uint64_t>(
        RtPtrToPtr<const uint32_t *>(&fc.llwi5) - RtPtrToPtr<const uint32_t *>(&fc));
    ConstructSetJumpPcFc(r5, offset, fc.jumpPc1);
    // BEQ R0 R6, else run err instr
    // check pop result status, result status in R6
    ConstructBranch(r0, r6, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.bne1);
    // R7 pop data: mbuf handle
    ConstructStore(r3, r7, 4U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swdfx2);
    // check mbuf handle valid
    // mbufferHandle valid [16:0], if [63:17] not equal 0, jump to err
    offset = static_cast<uint64_t>(RtPtrToPtr<const uint32_t *>(&fc.llwi6) - RtPtrToPtr<const uint32_t *>(&fc));
    ConstructSetJumpPcFc(r5, offset, fc.jumpPc2);
    ConstructOpImmSlli(r7, r9, 17U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli1);
    ConstructBranch(r0, r9, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.bne2);

    // write mbuffer into mbuf handle addr
    ConstructStore(r8, r7, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store);

    offset = static_cast<uint64_t>(RtPtrToPtr<const uint32_t *>(&fc.end) - RtPtrToPtr<const uint32_t *>(&fc));
    /* go to nop */
    ConstructSetJumpPcFc(r5, offset, fc.jumpPc3);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq1);

    /* error code cqe status*/
    ConstructLLWI(r4, gqmEmptyErrCode, fc.llwi5);
    ConstructSystemCsr(r4, r1, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       fc.dfxFsm1);
    ConstructErrorInstr(fc.err1);

    ConstructLLWI(r4, mbufInvalidErrCode, fc.llwi6);
    ConstructSystemCsr(r4, r1, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       fc.dfxFsm2);
    ConstructErrorInstr(fc.err2);

    ConstructNop(fc.end);

    const uint32_t *const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsDequeueFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsBatchDequeueFc(RtStarsDqsBatchDequeueFc &fc, const RtStarsDqsBatchDeqFcPara &funcCallPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr rtStarsCondIsaRegister_t r7 = RT_STARS_COND_ISA_REGISTER_R7;
    constexpr rtStarsCondIsaRegister_t r8 = RT_STARS_COND_ISA_REGISTER_R8;
    constexpr rtStarsCondIsaRegister_t r9 = RT_STARS_COND_ISA_REGISTER_R9;
    constexpr rtStarsCondIsaRegister_t r10 = RT_STARS_COND_ISA_REGISTER_R10;

    // 加载 gqmAddr 到 r2 寄存器中
    ConstructLLWI(r2, funcCallPara.gqmAddr, fc.llwiGqmAddr);
    ConstructLHWI(r2, funcCallPara.gqmAddr, fc.lhwiGqmAddr);

    // 加载 inputMbufHandleAddr 到 r3 寄存器中
    ConstructLLWI(r3, funcCallPara.inputMbufHandleAddr, fc.llwiInputMbufHandleAddr);
    ConstructLHWI(r3, funcCallPara.inputMbufHandleAddr, fc.lhwiInputMbufHandleAddr);

    // 加载 mbufFreeAddr 到 r4 寄存器中
    ConstructLLWI(r4, funcCallPara.mbufFreeAddr, fc.llwiMbufFreeAddr);
    ConstructLHWI(r4, funcCallPara.mbufFreeAddr, fc.lhwiMbufFreeAddr);

    ConstructLLWI(r7, 0U, fc.llwiIndex); // r7赋值为index
    // 循环开始，后续流程R2\3\4\7寄存器都不可写，因为存储了临时变量作为索引

    /* pa和va的相关配置 */
    constexpr uint64_t axiUserVaCfgMask = 0x100000001ULL;
    ConstructLLWI(r1, axiUserVaCfgMask, fc.llwiAddrMask);
    ConstructLHWI(r1, axiUserVaCfgMask, fc.lhwiAddrMask);

    /* GQM相关配置 */
    RtStarsCondGqmOpFc gqmPopi;
    // load GQM inst into r8
    ConstructGqmPopInstr(gqmPopi.inst);
    ConstructLLWI(r8, gqmPopi.value, fc.llwi1GqmCmd);
    ConstructLHWI(r8, gqmPopi.value, fc.lhwi1GqmCmd);

    // 加载 cntNotifyReadAddr 到 r5 寄存器中， r5 = cntNotifyStatAddr;
    ConstructLLWI(r5, funcCallPara.cntNotifyReadAddr, fc.llwicntNotifyReadAddr);
    ConstructLHWI(r5, funcCallPara.cntNotifyReadAddr, fc.lhwicntNotifyReadAddr);
    // cfg use PA
    ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrcCntNotfiy);

    ConstructLoad(r5, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrCntNotifyStat);
    ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrsCntNotfiy);
    /* 通过先左移32位，再右移32位，实现清除高位的目的 */
    ConstructOpImmAndi(r5, r5, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, fc.left1); /* 左移32位 */
    ConstructOpImmAndi(r5, r5, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, fc.right1); /* 右移32位 */

    // 加载 mbufPoolIndexMax 到 r6 寄存器中
    ConstructLLWI(r6, static_cast<uint64_t>(funcCallPara.mbufPoolIndexMax), fc.llwiMbufPoolIndexMax);
    ConstructLHWI(r6, static_cast<uint64_t>(funcCallPara.mbufPoolIndexMax), fc.lhwiMbufPoolIndexMax);

    // 获取当前索引队列的状态
	ConstructLLWI(r10, 1U, fc.llwiOne);
    ConstructLHWI(r10, 1U, fc.lhwiOne);
	ConstructOpOp(r10, r7, r10, RT_STARS_COND_ISA_OP_FUNC3_SLL, RT_STARS_COND_ISA_OP_FUNC7_SLL, fc.LeftQueueStatus);
	ConstructOpOp(r10, r5, r10, RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, fc.AndQueueStatus);

    uint64_t offset = offsetof(RtStarsDqsBatchDequeueFc, addi1UpdateGqmAddr);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r9, offset, fc.jumpNextIteration);
	ConstructBranch(r10, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.eqNoData);  // 如果当前input没数据，则继续下一个循环

    // 加载 cntNotifyClearAddr 到 r9 寄存器中， r9 = llwicntNotifyClearAddr;用于清除对应的标记位
    ConstructLLWI(r9, funcCallPara.cntNotifyClearAddr, fc.llwicntNotifyClearAddr);
    ConstructLHWI(r9, funcCallPara.cntNotifyClearAddr, fc.lhwicntNotifyClearAddr);
    // cfg use PA
    ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrcClearNotify);
    ConstructStore(r9, r10, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swClearNotify); /* 清除对应的件标记位 */
    // restore to use VA
    ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrsClearNotify);

    // 从GQM中获取handle
	ConstructLoad(r2, 0U, r10, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrGqmRealAddr); /* 加载每个队列gqm的地址到r10中 */
    // launch GQM instr
    ConstructLaunchGqmInstr(r5, r8, r10, fc.gqm); // dst = r5[r5存放返回状态，r6存放返回值],  src1 = r8, src2 = 10

    // check pop result status, result status in r5
    ConstructLLWI(r10, funcCallPara.dfxAddr, fc.llwiDfxAddr);
    ConstructLHWI(r10, funcCallPara.dfxAddr, fc.lhwiDfxAddr);
    ConstructStore(r10, r5, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swdfxGqmPopRes);
    // // pop status [63:23] reserve, [22:8] remain counter, [7:0] return code
    ConstructOpImmSlli(r5, r5, 56U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slliGqmErrcode);

	// Jump pc set err instr
    offset = offsetof(RtStarsDqsBatchDequeueFc, wPopErr);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r9, offset, fc.jumpPopError);
    // // BEQ R0 r5, else run err instr
    ConstructBranch(r0, r5, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.bneErrPop);

    // r6 pop data: mbuf handle,将r6写到dfx里
    ConstructStore(r10, r6, 4U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swdfxHandle);
    // check mbuf handle valid
    offset = offsetof(RtStarsDqsBatchDequeueFc, wHandleErr);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r9, offset, fc.jumpPcHandleErr);
    // mbufferHandle valid [16:0], if [63:17] not equal 0, jump to stream head
    ConstructOpImmSlli(r6, r9, 17U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srliHandleValue);
    ConstructBranch(r0, r9, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.bneErrHandle);

	/* 此时r6存储的是合法的handle。可用寄存器：R1\5\8\9\10 */
    /* If the value of MAX_CACHE_SIZE is changed, the corresponding algorithm also needs to be changed. */
	ConstructOpImmAndi(r3, r10, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.ldrHandleCacheAddr);
	ConstructLLWI(r5, static_cast<uint64_t>(funcCallPara.cntOffset), fc.llwiHandleCnt); // r5 = offsetOfCnt;
    ConstructLHWI(r5, static_cast<uint64_t>(funcCallPara.cntOffset), fc.lhwiHandleCnt); // r5 = offsetOfCnt;
	ConstructOpOp(r5, r10, r5, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.AddQueueStatus); // r5 = r10 + r5
	ConstructLoad(r5, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrHandleCacheCnt);
    ConstructOpImmAndi(r5, r5, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, fc.left2); /* 左移48位 */
    ConstructOpImmAndi(r5, r5, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, fc.right2); /* 右移48位，取低16位 */

	offset = offsetof(RtStarsDqsBatchDequeueFc, llwiHandleCnt1);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r1, offset, fc.jumpNotFull);
	ConstructBranch(r5, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.bneCacheSize0);

	ConstructLoad(r10, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrNewValue); /* r1 = newValue;最新的元素的下标恒为0 */
    ConstructOpImmAndi(r1, r1, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, fc.left3); /* 左移32位 */
    ConstructOpImmAndi(r1, r1, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, fc.right3); /* 右移32位，取低32位 */
	ConstructOpImmAndi(r10, r9, 4U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1GetOldAddr); /* 老元素的下标为4 */
	ConstructLoad(r9, 0U, r8, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrOldValue); /* 加载到偏移为0的地方 */
    ConstructOpImmAndi(r8, r8, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, fc.left4); /* 左移32位 */
    ConstructOpImmAndi(r8, r8, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, fc.right4); /* 右移32位，取低32位 */
	ConstructStore(r9, r1, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swNew); /* 把newValue写到索引为1的地方; */
	
    ConstructLLWI(r9, 2U, fc.llwiHandleCacheDeep); // r9 是 2，为数组的总大小
    ConstructLHWI(r9, 2U, fc.lhwiHandleCacheDeep); // r9 是 2，为数组的总大小
	offset = offsetof(RtStarsDqsBatchDequeueFc, llwiHandleCnt1);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r1, offset, fc.jumpNotFull2);
	ConstructBranch(r5, r9, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.bneCacheSize1);

    ConstructStore(r10, r6, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swHandle); /* 把新的handle写到索引为0的地方 */

    /* free被覆盖的handle */
	offset = offsetof(RtStarsDqsBatchDequeueFc, ldrMbuffMangAddr);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r1, offset, fc.jumpFreeHandle);
	ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beqFreeHandle);

    // cache_not_full: 
	ConstructLLWI(r1, static_cast<uint64_t>(funcCallPara.cntOffset), fc.llwiHandleCnt1);
    ConstructLHWI(r1, static_cast<uint64_t>(funcCallPara.cntOffset), fc.lhwiHandleCnt1);
	ConstructOpOp(r1, r10, r1, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.AddQueueStatus1);
	ConstructOpImmAndi(r5, r5, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1CntAdd);
	ConstructStore(r1, r5, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SH, fc.swNew1); /* 更新cnt的值 */
	ConstructStore(r10, r6, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swHandle1); /* 把新的handle写到索引为0的地方 */

    offset = offsetof(RtStarsDqsBatchDequeueFc, addi1UpdateGqmAddr);
	offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r9, offset, fc.jumpNextIteration1);
	ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.eqNoDataPorcess);  // 继续下一个循环

    // free_handle:
    ConstructLoad(r4, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrMbuffMangAddr);
	ConstructLLWI(r1, axiUserVaCfgMask, fc.llwiAddrMask1);
	ConstructLHWI(r1, axiUserVaCfgMask, fc.lhwiAddrMask1);
	ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrcMbufManag);
	ConstructStore(r5, r8, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swHanleForFree);
	ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrsMbufManag);

    // NEXT_ITERATION:
    ConstructOpImmAndi(r2, r2, 8U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1UpdateGqmAddr); //指针为8字节
    ConstructOpImmAndi(r3, r3, funcCallPara.sizeofHandleCache, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1UpdateInputMbufHandleAddr);
    ConstructOpImmAndi(r4, r4, 8U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1UpdateMbufFreeAddr); //指针为8字节
    ConstructOpImmAndi(r7, r7, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1UpdateIndex); // index增加1

    ConstructLLWI(r6, static_cast<uint64_t>(funcCallPara.mbufPoolIndexMax), fc.llwiMbufPoolIndexMax1);
    ConstructLHWI(r6, static_cast<uint64_t>(funcCallPara.mbufPoolIndexMax), fc.lhwiMbufPoolIndexMax1);

    offset = offsetof(RtStarsDqsBatchDequeueFc, llwiAddrMask);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r1, offset, fc.jumpStartLoop);
    // if index < queueNums, go to llwiAddrMask
    ConstructBranch(r7, r6, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU, static_cast<uint8_t>(offset), fc.bltStartLoop);

    offset = offsetof(RtStarsDqsBatchDequeueFc, end);  
	offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r9, offset, fc.jumpEnd);
	ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.EqJumpEnd);  // 结束

    // todo:定义错误码，增加错误类型。
    // pop_error:
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                      fc.wPopErr);
    // Jump pc set err instr
    offset = offsetof(RtStarsDqsBatchDequeueFc, err);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r5, offset, fc.jumpPcErr);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.EqJumpErr);  // 跳转到异常

    // handle_error:
    ConstructSystemCsr(r9, r0, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                      fc.wHandleErr);
    ConstructLoad(r4, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrMbuffMangAddr1);
	ConstructLLWI(r1, axiUserVaCfgMask, fc.llwiAddrMask2);
	ConstructLHWI(r1, axiUserVaCfgMask, fc.lhwiAddrMask2);
	ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrcMbufManag1);
	ConstructStore(r4, r8, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.swHanleForFree1);
	ConstructSystemCsr(r1, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrsMbufManag1);

    ConstructErrorInstr(fc.err);
    // end:
    ConstructNop(fc.end);

    const uint32_t *const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsBatchDequeueFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_INFO, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsFrameAlignFc(RtStarsDqsFrameAlignFc &fc, const RtStarsDqsFrameAlignFcPara &fcPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;

    ConstructLLWI(r1, fcPara.frameAlignResAddr, fc.llwi1);
    ConstructLHWI(r1, fcPara.frameAlignResAddr, fc.lhwi1);
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load1);

    uint64_t offset = offsetof(RtStarsDqsFrameAlignFc, end);
    offset = offset / sizeof(uint32_t);
    // if frame_align_res != 0, goto end (frame align success)
    ConstructSetJumpPcFc(r2, offset, fc.jumpPc1);
    ConstructBranch(r1, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, offset, fc.bne);

    ConstructLLWI(r1, fcPara.sqId, fc.llwi2);
    ConstructLHWI(r1, fcPara.sqId, fc.lhwi2);
    ConstructGotoR(r1, r0, fc.gotor);  // stream goto head

    ConstructNop(fc.end);

    const uint32_t *const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsFrameAlignFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_INFO, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsPrepareFc(RtStarsDqsPrepareOutFc &fc, const RtStarsDqsPrepareFcPara &fcPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr rtStarsCondIsaRegister_t r7 = RT_STARS_COND_ISA_REGISTER_R7;
    constexpr rtStarsCondIsaRegister_t r8 = RT_STARS_COND_ISA_REGISTER_R8;

    /* 计算input_private_info_addr，存入r1 */ 
    ConstructLLWI(r1, fcPara.csPtrInputMbufHandleAddr, fc.llwi1);
    ConstructLHWI(r1, fcPara.csPtrInputMbufHandleAddr, fc.lhwi1);
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load1);
    ConstructLLWI(r2, dqsBlockIdMask, fc.llwi2);
    ConstructLHWI(r2, dqsBlockIdMask, fc.lhwi2);
    ConstructOpAnd(r1, r2, r2, fc.and1);
    // r2 = block_id
    ConstructOpImmSlli(r2, r2, dqsBlockIdOffset, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli11);

    ConstructLLWI(r1, fcPara.csPtrInputHeadPoolBlockSize, fc.llwi3);
    ConstructLHWI(r1, fcPara.csPtrInputHeadPoolBlockSize, fc.lhwi4);
    // r1 = head_pool_block_size, load 64 bit
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load2);
    // trim high 32 bit
    ConstructOpImmSlli(r1, r1, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli6);
    ConstructOpImmSlli(r1, r1, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli6);
    // r1 = head_pool_block_size*block_id
    ConstructOpMul(r1, r2, r1, fc.mult1);
    ConstructLLWI(r2, fcPara.csPtrInputHeadPoolBaseAddr, fc.llwi5);
    ConstructLHWI(r2, fcPara.csPtrInputHeadPoolBaseAddr, fc.lhwi5);
    // r2 = head_pool_base_addr(含offset)
    ConstructLoad(r2, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load3);
    // r1 = input_private_info_addr
    ConstructOpAdd(r1, r2, r1, fc.add1);

    /* Loop1: 对所有的output进行do-while循环, r2 < r3 */
    // r2 = loop1_index
    ConstructOpImmAndi(r0, r2, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);
    // r3 = loop1_max
    ConstructOpImmAndi(r0, r3, fcPara.outputQueueNum, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi2);

    /* 申请output mbuf，并判断mbuf的合法性 */
    ConstructLLWI(r4, fcPara.csPtrOutputMbufAllocAddr, fc.llwi9);
    ConstructLHWI(r4, fcPara.csPtrOutputMbufAllocAddr, fc.lhwi9);
    ConstructOpImmSlli(r2, r5, 3U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli1);
    ConstructOpAdd(r4, r5, r4, fc.add2);
    // r4 = mbuf_alloc寄存器地址
    ConstructLoad(r4, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load5);
    // r4 = alloc结果
    ConstructLoad(r4, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load6);
    ConstructLLWI(r5, dqsErrCodeMask, fc.llwi10);
    ConstructLHWI(r5, dqsErrCodeMask, fc.lhwi10);
    // r5 = error_code
    ConstructOpAnd(r4, r5, r5, fc.and2);
    ConstructLLWI(r6, fcPara.dfxMbufAllocResult, fc.llwi11);
    ConstructLHWI(r6, fcPara.dfxMbufAllocResult, fc.lhwi11);
    // 保存mbuf申请error_code到DFX
    ConstructStore(r6, r5, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store1);
    ConstructLLWI(r6, fcPara.dfxMbufAllocPoolIdx, fc.llwi12);
    ConstructLHWI(r6, fcPara.dfxMbufAllocPoolIdx, fc.lhwi12);
    // 保存output_idx到DFX
    ConstructStore(r6, r2, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store2);
    uint64_t offset = offsetof(RtStarsDqsPrepareOutFc, err);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc1);
    ConstructBranch(r5, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, offset, fc.bne);

    /* 将output mbuf 存入ctrlSpace output_mbuf_list */
    ConstructLLWI(r5, dqsPoolIdBlkIdMask, fc.llwi13);
    ConstructLHWI(r5, dqsPoolIdBlkIdMask, fc.lhwi13);
    // r4 = mbuf_handle
    ConstructOpAnd(r4, r5, r4, fc.and3);
    ConstructLLWI(r5, fcPara.csPtrOutputMbufHandleAddr, fc.llwi14);
    ConstructLHWI(r5, fcPara.csPtrOutputMbufHandleAddr, fc.lhwi14);
    // r6 = loop1_index * 4, 将当前数组元素(uint32_t)[i]地址偏移存入r6
    ConstructOpImmSlli(r2, r6, 2U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli2);
    // r5 = output_mbuf_list[i]在CtrlSpace中的地址
    ConstructOpAdd(r5, r6, r5, fc.add3);
    // 存入mbuf_handle
    ConstructStore(r5, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store3);

    /* 计算output_private_info_addr[i]，存入r4 */
    ConstructLLWI(r5, fcPara.csPtrOutputHeadPoolBlockSize, fc.llwi15);
    ConstructLHWI(r5, fcPara.csPtrOutputHeadPoolBlockSize, fc.lhwi15);
    // r8 = loop1_index * 4, 将当前数组元素(uint32_t)[i]地址偏移存入r8
    ConstructOpImmSlli(r2, r8, 2U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli3);
    ConstructOpAdd(r5, r8, r5, fc.add4);
    // r5 = output_mbuf_head_pool_block_size[i]
    ConstructLoad(r5, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load8);
    // trim high 32 bit
    ConstructOpImmSlli(r5, r5, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli4);
    ConstructOpImmSlli(r5, r5, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli4);

    ConstructLLWI(r7, fcPara.csPtrOutputHeadPoolBaseAddr, fc.llwi16);
    ConstructLHWI(r7, fcPara.csPtrOutputHeadPoolBaseAddr, fc.lhwi16);
    ConstructOpAdd(r7, r6, r7, fc.add5);
    // r7 = output_mbuf_head_pool_base_addr[i]
    ConstructLoad(r7, 0U, r7, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load9);
    ConstructLLWI(r8, dqsBlockIdMask, fc.llwi17);
    ConstructLHWI(r8, dqsBlockIdMask, fc.lhwi17);
    ConstructOpAnd(r4, r8, r4, fc.and4);
    // r4 = block_id
    ConstructOpImmSlli(r4, r4, dqsBlockIdOffset, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli14);

    // r4 = head_pool_block_size*block_id
    ConstructOpMul(r4, r5, r4, fc.mult2);
    // r4 = output_private_info_addr[i]
    ConstructOpAdd(r4, r7, r4, fc.add6);

    /* Loop2: do-while循环拷贝256B的privateinfo，每次拷8B, r5 < r6 */
    // r5 = loop2_index
    ConstructOpImmAndi(r0, r5, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi3);
    // r6 = loop2_max
    ConstructOpImmAndi(r0, r6, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi4);
    // r7 = r1
    ConstructOpAdd(r0, r1, r7, fc.add7);
    ConstructLoad(r7, 0U, r8, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load10);
    ConstructStore(r4, r8, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.store4);
    // 拷贝地址+8
    ConstructOpImmAndi(r4, r4, sizeof(uint64_t), RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi5);
    ConstructOpImmAndi(r7, r7, sizeof(uint64_t), RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi6);
    // loop2_index++
    ConstructOpImmAndi(r5, r5, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi7);
    // 如果 r5 < r6，跳转到继续拷贝
    offset = offsetof(RtStarsDqsPrepareOutFc, load10);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpPc2);
    ConstructBranch(r5, r6, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU, offset, fc.bltu1);  // Loop2 end
    // loop1_index++
    ConstructOpImmAndi(r2, r2, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi8);
    // 如果 r2 < r3，跳转到mbuf alloc
    offset = offsetof(RtStarsDqsPrepareOutFc, llwi9);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpPc3);
    ConstructBranch(r2, r3, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU, offset, fc.bltu2);  // Loop1 end

    // skip error
    offset = offsetof(RtStarsDqsPrepareOutFc, end);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpPc4);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, offset, fc.beq);

    // error instr
    ConstructErrorInstr(fc.err);

    // end instr
    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsPrepareOutFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsZeroCopyFc(RtStarsDqsZeroCopyFc &fc, const RtStarsDqsZeroCopyPara &funcCallPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr rtStarsCondIsaRegister_t r7 = RT_STARS_COND_ISA_REGISTER_R7;
    constexpr rtStarsCondIsaRegister_t r8 = RT_STARS_COND_ISA_REGISTER_R8;

    // r1: dataPoolBlkSize
    ConstructLLWI(r1, funcCallPara.blockSizeAddr, fc.llwi1);
    ConstructLHWI(r1, funcCallPara.blockSizeAddr, fc.lhwi1);
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr1);
    ConstructOpImmSlli(r1, r1, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli1);
    ConstructOpImmSlli(r1, r1, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli1);

    // r2: mbufHandle
    ConstructLLWI(r2, funcCallPara.mbufHandleAddr, fc.llwi2);
    ConstructLHWI(r2, funcCallPara.mbufHandleAddr , fc.lhwi2);
    ConstructLoad(r2, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);
    ConstructOpImmSlli(r2, r2, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli2);
    ConstructOpImmSlli(r2, r2, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli2);

    // r4: block_id, and with the effective bit
    ConstructLLWI(r3, dqsBlockIdMask, fc.llwi3);
    ConstructLHWI(r3, dqsBlockIdMask, fc.lhwi3);
    ConstructOpOp(r2, r3, r4, RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, fc.and1);
    ConstructOpImmSlli(r4, r4, dqsBlockIdOffset, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli3);

    // r3: temp1 = dataPoolBlkSize * block_id = r1 * r4
    ConstructOpOp(r1, r4, r3, RT_STARS_COND_ISA_OP_FUNC3_MUL, RT_STARS_COND_ISA_OP_FUNC7_MUL, fc.mul1);

    // r4: temp2 = mbufBaseAddr
    ConstructLLWI(r4, funcCallPara.mbufBaseAddr, fc.llwi4); 
    ConstructLHWI(r4, funcCallPara.mbufBaseAddr, fc.lhwi4);
    ConstructLoad(r4, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr3);

    // r1: data_base = temp1 + temp2 = r3 + r4
    ConstructOpOp(r3, r4, r1, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add1);
 
    // r5: count
    ConstructLLWI(r5, funcCallPara.count, fc.llwi5);
    ConstructLHWI(r5, funcCallPara.count, fc.lhwi5);
    // r6: index = 0
    ConstructOpOp(r0, r0, r6, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add2);

    // r7: 无条件跳转
    uint64_t offset = offsetof(RtStarsDqsZeroCopyFc, jumpPc2);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc1);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq1);

    // r8: index << 3 == index * 8
    ConstructOpImmSlli(r6, r8, 3U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI,
                       RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli3);

    // r2: offset[i]
    ConstructLLWI(r2, funcCallPara.offsetAddr, fc.llwi6);
    ConstructLHWI(r2, funcCallPara.offsetAddr, fc.lhwi6);
    ConstructOpOp(r2, r8, r2, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add3);
    ConstructLoad(r2, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr4);
 
    // r3: dest_addr1 = dest[i]
    ConstructLLWI(r3, funcCallPara.destAddr, fc.llwi7);
    ConstructLHWI(r3, funcCallPara.destAddr, fc.lhwi7);
    ConstructOpOp(r3, r8, r3, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add4);
    ConstructLoad(r3, 0U, r3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr5);
 
    // r4: offset_data_addr = offset[i] + data_base = r2 + r1
    ConstructOpOp(r2, r1, r4, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add5);
 
    // 将offset_data_addr拷贝到dest_addr1中，根据参数确定高低32bit存入的位置
    if (funcCallPara.isCpyAddrLow32First) {
        ConstructStore(r3, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store1);    // store low32 in r3
        ConstructOpImmSlli(r4, r4, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
            RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli4);
        ConstructStore(r3, r4, 4U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store2);    // store high32 in (r3 + 4)
    } else {
        ConstructStore(r3, r4, 4U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store1);    // store low32 in (r3 + 4)
        ConstructOpImmSlli(r4, r4, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
            RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli4);
        ConstructStore(r3, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store2);    // store high32 in r3
    }

    // r6: index = index + 1
    ConstructOpImmAndi(r6, r6, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);
    offset = offsetof(RtStarsDqsZeroCopyFc, slli3);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc2);
    // if index < count, go to slli3
    ConstructBranch(r6, r5, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU, static_cast<uint8_t>(offset), fc.bltu1);

    // end
    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsZeroCopyFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructConditionCopyFc(RtStarsDqsConditionCopyFc &fc, const RtStarsDqsConditionCopyPara &funcCallPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr rtStarsCondIsaRegister_t r7 = RT_STARS_COND_ISA_REGISTER_R7;
    constexpr uint64_t dqsConditionValue = 1ULL;

    // r1: conditionAddr
    ConstructLLWI(r1, funcCallPara.conditionAddr, fc.llwi1);
    ConstructLHWI(r1, funcCallPara.conditionAddr, fc.lhwi1);
    // r2: condition
    ConstructLoad(r1, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr1);
    uint64_t offset = offsetof(RtStarsDqsConditionCopyFc, end);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc1);
    // if condition == 0, go to end
    ConstructBranch(r2, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, offset, fc.beq1);
    offset = offsetof(RtStarsDqsConditionCopyFc, llwi6);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc2);
    // r4: dqsConditionValue = 1
    ConstructLLWI(r4, dqsConditionValue, fc.llwi2);
    ConstructLHWI(r4, dqsConditionValue, fc.lhwi2);
    // if condition != 1, go to err
    ConstructBranch(r2, r4, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, offset, fc.bne1);

    // r2: count
    ConstructLLWI(r2, funcCallPara.count, fc.llwi3);
    ConstructLHWI(r2, funcCallPara.count, fc.lhwi3);
    // r3: index = 0
    ConstructOpOp(r0, r0, r3, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add1);
    // r6: 无条件跳转
    offset = offsetof(RtStarsDqsConditionCopyFc, jumpPc4);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc3);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq2);

    // r4: r4 = srcAddr[index]
    ConstructLLWI(r4, funcCallPara.srcAddr, fc.llwi4);
    ConstructLHWI(r4, funcCallPara.srcAddr, fc.lhwi4);
    // r5: index << 3 == index * 8
    ConstructOpImmSlli(r3, r5, 3U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli1);
    ConstructOpOp(r4, r5, r4, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add2);
    // r4: srcData = load srcAddr[index]
    ConstructLoad(r4, 0U, r4, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);

    // r6: r6 = destAddr[index]
    ConstructLLWI(r6, funcCallPara.dstAddr, fc.llwi5);
    ConstructLHWI(r6, funcCallPara.dstAddr, fc.lhwi5);
    ConstructOpOp(r6, r5, r6, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add3);

    // STORE(destAddr, srcData) 将srcAddr中的内容srcData拷贝到destAddr中
    ConstructStore(r6, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.store1);

    // r3: index = index + 1
    ConstructOpImmAndi(r3, r3, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);
    offset = offsetof(RtStarsDqsConditionCopyFc, llwi4);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc4);
    // if index < count, go to llwi4
    ConstructBranch(r3, r2, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU, static_cast<uint8_t>(offset), fc.bltu1);
    // 将condition写成0
    ConstructStore(r1, r0, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.store2);

    // go to end
    offset = offsetof(RtStarsDqsConditionCopyFc, end);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc5);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, offset, fc.beq3);

    // err_code
    ConstructLLWI(r7, INVALID_CONDITION_ERR_CODE, fc.llwi6);
    ConstructLHWI(r7, INVALID_CONDITION_ERR_CODE, fc.lhwi6);
    ConstructSystemCsr(r7, r1, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       fc.dfxFsm1);
    ConstructErrorInstr(fc.err);

    // end
    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsConditionCopyFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsInterChipPreProcFc(RtStarsDqsInterChipPreProcFc &fc, const RtStarsDqsInterChipPreProcPara &funcCallPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr rtStarsCondIsaRegister_t r7 = RT_STARS_COND_ISA_REGISTER_R7;

    constexpr uint64_t axiUserVaCfgMask = 0x900000009ULL; // [0]VA, [3]Read-Allocate
    // read immd reg va cfg mask
    ConstructLLWI(r6, axiUserVaCfgMask, fc.llwi);

    // r1: dstMbufAllocAddr
    ConstructLLWI(r1, funcCallPara.dstMbuffAllocAddr, fc.llwi1);
    ConstructLHWI(r1, funcCallPara.dstMbuffAllocAddr, fc.lhwi1);
    // r1: dstMbufHandle
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr1);
    // cfg use PA
    ConstructSystemCsr(r6, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrc);
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);
    // restore to use VA
    ConstructSystemCsr(r6, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrs);

    // r2: error_code = mbufHandle[31:29]
    ConstructOpImmSlli(r1, r2, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli1);
    ConstructOpImmSlli(r2, r2, 61U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli1);
    // if error_code != 0, goto err
    uint64_t offset = offsetof(RtStarsDqsInterChipPreProcFc, dfxFsm1);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc1);
    ConstructBranch(r2, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, offset, fc.bne1);
    // r1：mbuf_handle=[block_id:pool_id], bits[16:0]
    ConstructOpImmSlli(r1, r1, 47U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli2);
    ConstructOpImmSlli(r1, r1, 47U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli2);

    // r2: dstMbufHandleAddr
    ConstructLLWI(r2, funcCallPara.dstMbufHandleAddr, fc.llwi2);
    ConstructLHWI(r2, funcCallPara.dstMbufHandleAddr, fc.lhwi2);
    // STORE(dstMbufHandle, dstMbufHandleAddr); 将dstMbufHandle拷贝到dstMbufHandleAddr中
    ConstructStore(r2, r1, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store1);

    // r3: dqsBlockIdMask
    ConstructLLWI(r3, dqsBlockIdMask, fc.llwi3);
    ConstructLHWI(r3, dqsBlockIdMask, fc.lhwi3);
    // r4: dstMbufHeadId/dstMbufDataId = (r1 & r3) >> dqsBlockIdOffset
    ConstructOpOp(r1, r3, r4, RT_STARS_COND_ISA_OP_FUNC3_AND, RT_STARS_COND_ISA_OP_FUNC7_AND, fc.and1);
    ConstructOpImmSlli(r4, r4, dqsBlockIdOffset, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
                       RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli3);

    // r3: dstMbufHeadBaseAddr
    ConstructLLWI(r3, funcCallPara.dstMbufHeadBaseAddr, fc.llwi4);
    ConstructLHWI(r3, funcCallPara.dstMbufHeadBaseAddr, fc.lhwi4);
    ConstructLoad(r3, 0U, r3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr4);
    // r2: dstMbufHeadBlockSizeAddr
    ConstructLLWI(r2, funcCallPara.dstMbufHeadBlockSizeAddr, fc.llwi5);
    ConstructLHWI(r2, funcCallPara.dstMbufHeadBlockSizeAddr, fc.lhwi5);
    // r2: dstMbufHeadBlockSize
    ConstructLoad(r2, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr5);
    ConstructOpImmSlli(r2, r2, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli3);
    ConstructOpImmSlli(r2, r2, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli4);

    // r5: temp1 = dstMbufHeadBlockSize * dstMbufHeadId = r2 * r4
    ConstructOpOp(r2, r4, r5, RT_STARS_COND_ISA_OP_FUNC3_MUL, RT_STARS_COND_ISA_OP_FUNC7_MUL, fc.mul1);

    // r2: dstMbufHeadAddr = temp1 + dstMbufHeadBaseAddr = r5 + r3
    ConstructOpOp(r5, r3, r2, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add1);

    // r6: mbufHeadSdmaSqeAddr
    ConstructLLWI(r6, funcCallPara.mbufHeadSdmaSqeAddr, fc.llwi6);
    ConstructLHWI(r6, funcCallPara.mbufHeadSdmaSqeAddr, fc.lhwi6);
    ConstructStore(r6, r2, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.store2);

    // r3: dstMbufDataBaseAddr
    ConstructLLWI(r3, funcCallPara.dstMbufDataBaseAddr, fc.llwi7);
    ConstructLHWI(r3, funcCallPara.dstMbufDataBaseAddr, fc.lhwi7);
    ConstructLoad(r3, 0U, r3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr6);

    // r2: dstMbufDataBlockSizeAddr
    ConstructLLWI(r2, funcCallPara.dstMbufDataBlockSizeAddr, fc.llwi8);
    ConstructLHWI(r2, funcCallPara.dstMbufDataBlockSizeAddr, fc.lhwi8);
    // r2: dstMbufDataBlockSize
    ConstructLoad(r2, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr7);
    ConstructOpImmSlli(r2, r2, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli4);
    ConstructOpImmSlli(r2, r2, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli5);

    // r5: temp1 = dstMbufDataBlockSize * dstMbufDataId = r2 * r4
    ConstructOpOp(r2, r4, r5, RT_STARS_COND_ISA_OP_FUNC3_MUL, RT_STARS_COND_ISA_OP_FUNC7_MUL, fc.mul2);
    // r2: dstMbufDataAddr = temp1 + dstMbufDataBaseAddr = r5 + r3
    ConstructOpOp(r5, r3, r2, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.add2);
    // r6: mbufDataSdmaSqeAddr
    ConstructLLWI(r6, funcCallPara.mbufDataSdmaSqeAddr, fc.llwi9);
    ConstructLHWI(r6, funcCallPara.mbufDataSdmaSqeAddr, fc.lhwi9);
    ConstructStore(r6, r2, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.store3);

    // go to end
    offset = offsetof(RtStarsDqsInterChipPreProcFc, end);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc2);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, offset, fc.beq1);

    // err_code
    ConstructSystemCsr(r2, r1, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       fc.dfxFsm1);
    ConstructErrorInstr(fc.err);

    // end
    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsInterChipPreProcFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsInterChipPostProcFc(RtStarsDqsInterChipPostProcFc &fc, const RtStarsDqsInterChipPostProcPara &funcCallPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr uint64_t axiUserVaCfgMask = 0x900000009ULL;
    // r4: read immd reg va cfg mask
    ConstructLLWI(r4, axiUserVaCfgMask, fc.llwi1);
    ConstructLHWI(r4, axiUserVaCfgMask, fc.lhwi1);

    // r5: dstQmngrOwAddr
    ConstructLHWI(r5, funcCallPara.dstQmngrOwAddr, fc.lhwi2);
    ConstructLLWI(r5, funcCallPara.dstQmngrOwAddr, fc.llwi2);
    ConstructLoad(r5, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr1);
    // cfg use PA
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrcow);
    ConstructLoad(r5, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);
    // restore to use VA
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrsow);

    // r1: 获取handle[31:29] bit的数据
    ConstructOpImmSlli(r5, r1, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli1);
    ConstructOpImmSlli(r1, r1, dqsErrCodeRightShift, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
                       RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli1);
    // r2: dqsErrorQueueNotEnable
    ConstructLLWI(r2, dqsErrorQueueNotEnable, fc.llwi3);
    ConstructLHWI(r2, dqsErrorQueueNotEnable, fc.lhwi3);
    // r3: dqsErrorOWNotEnable
    ConstructLLWI(r3, dqsErrorOWNotEnable, fc.llwi4);
    ConstructLHWI(r3, dqsErrorOWNotEnable, fc.lhwi4);

    // if queue not enable, go to err1
    uint64_t offset = offsetof(RtStarsDqsInterChipPostProcFc, llwi11);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc1);
    ConstructBranch(r2, r1, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq1);

    // if overWrite not enable, go to err2
    offset = offsetof(RtStarsDqsInterChipPostProcFc, llwi12);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc2);
    ConstructBranch(r3, r1, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq2);

    // if no over write, go to llwi7
    offset = offsetof(RtStarsDqsInterChipPostProcFc, llwi7);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc3);
    ConstructBranch(r0, r1, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.bne);

    ConstructLLWI(r2, funcCallPara.dstMbufFreeAddr, fc.llwi5);
    ConstructLHWI(r2, funcCallPara.dstMbufFreeAddr, fc.lhwi5);
    ConstructLoad(r2, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr3);

    // r8 = ow mbufHandle
    ConstructLLWI(r3, dqsPoolIdBlkIdMask, fc.llwi6);
    ConstructLHWI(r3, dqsPoolIdBlkIdMask, fc.lhwi6);
    ConstructOpAnd(r5, r3, r3, fc.and1);

    // cfg use PA
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrc1);
    // 释放 ow mbuf handle
    ConstructStore(r2, r3, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.sw1);
    // restore to use VA
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrs1);

    // r1: dstMbufHandleAddr
    ConstructLLWI(r1, funcCallPara.dstMbufHandleAddr, fc.llwi7);
    ConstructLHWI(r1, funcCallPara.dstMbufHandleAddr, fc.lhwi7);

    // r1: dstMbufHandle, 会读64bit, handle只用到32bit
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr4);

    // r2: dstQueueAddr
    ConstructLLWI(r2, funcCallPara.dstQueueAddr, fc.llwi8);
    ConstructLHWI(r2, funcCallPara.dstQueueAddr, fc.lhwi8);
    ConstructLoad(r2, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr5);

    // cfg use PA
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrc2);
    // dstMbufHandle enqueue
    ConstructStore(r2, r1, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.sw2);
    // restore to use VA
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrs2);

    // r3: srcMbufHandleAddr
    ConstructLLWI(r3, funcCallPara.srcMbufHandleAddr, fc.llwi9);
    ConstructLHWI(r3, funcCallPara.srcMbufHandleAddr, fc.lhwi9);

    // r3: srcMbufHandle, 会读64bit, handle只用到32bit
    ConstructLoad(r3, 0U, r3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr6);

    // r1: srcMbufFreeAddr
    ConstructLLWI(r1, funcCallPara.srcMbufFreeAddr, fc.llwi10);
    ConstructLHWI(r1, funcCallPara.srcMbufFreeAddr, fc.lhwi10);
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr7);

    // cfg use PA
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrc3);
    // srcMbufHandle free
    ConstructStore(r1, r3, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.sw3);
    // restore to use VA
    ConstructSystemCsr(r4, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrs3);

    // skip error
    offset = offsetof(RtStarsDqsInterChipPostProcFc, end);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r6, offset, fc.jumpPc4);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq3);

    // error1
    ConstructLLWI(r2, QUEUE_NOT_ENABLE_ERR_CODE, fc.llwi11);
    ConstructLHWI(r2, QUEUE_NOT_ENABLE_ERR_CODE, fc.lhwi11);
    ConstructSystemCsr(r2, r0, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       fc.dfxFsm1);
    ConstructErrorInstr(fc.err1);

    // error2
    ConstructLLWI(r3, OW_NOT_ENABLE_ERR_CODE, fc.llwi12);
    ConstructLHWI(r3, OW_NOT_ENABLE_ERR_CODE, fc.lhwi12);
    ConstructSystemCsr(r3, r0, RT_STARS_COND_CSR_CSQ_STATUS_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW,
                       fc.dfxFsm2);
    ConstructErrorInstr(fc.err2);

    // end
    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsInterChipPostProcFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsAdspcFc(RtStarsDqsAdspcFc &fc, const RtStarsDqsAdspcFcPara &fcPara)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;
    constexpr rtStarsCondIsaRegister_t r1 = RT_STARS_COND_ISA_REGISTER_R1;
    constexpr rtStarsCondIsaRegister_t r2 = RT_STARS_COND_ISA_REGISTER_R2;
    constexpr rtStarsCondIsaRegister_t r3 = RT_STARS_COND_ISA_REGISTER_R3;
    constexpr rtStarsCondIsaRegister_t r4 = RT_STARS_COND_ISA_REGISTER_R4;
    constexpr rtStarsCondIsaRegister_t r5 = RT_STARS_COND_ISA_REGISTER_R5;
    constexpr rtStarsCondIsaRegister_t r6 = RT_STARS_COND_ISA_REGISTER_R6;
    constexpr rtStarsCondIsaRegister_t r7 = RT_STARS_COND_ISA_REGISTER_R7;
    constexpr rtStarsCondIsaRegister_t r8 = RT_STARS_COND_ISA_REGISTER_R8;

    constexpr uint16_t dfxSqHeadOffset = 0U;
    constexpr uint16_t dfxSqTailOffset = 4U;
    constexpr uint16_t dfxQmngrOwValOffst = 8U;

    // r1 = cq head reg addr
    ConstructLLWI(r1, fcPara.cqHeadRegAddr, fc.llwi1);
    ConstructLHWI(r1, fcPara.cqHeadRegAddr, fc.lhwi1);
    // r2 = cqHead
    ConstructLoad(r1, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load1);
    ConstructOpImmAndi(r2, r2, static_cast<uint32_t>(fcPara.cqeHeadTailMask), RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.andi1);

    // r3 = cqTail
    ConstructLLWI(r3, fcPara.cqTailRegAddr, fc.llwi2);
    ConstructLHWI(r3, fcPara.cqTailRegAddr, fc.lhwi2);
    ConstructLoad(r3, 0U, r3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load2);
    ConstructOpImmAndi(r3, r3, static_cast<uint32_t>(fcPara.cqeHeadTailMask), RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.andi2);

    // r8 = dfx addr
    ConstructLLWI(r8, fcPara.dfxAddr, fc.llwiDfx);
    ConstructLHWI(r8, fcPara.dfxAddr, fc.lhwiDfx);
    ConstructStore(r8, r2, dfxSqHeadOffset, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.storeCqHead);
    ConstructStore(r8, r3, dfxSqTailOffset, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.storeCqTail);

    // if cqHead = cqTail，goto err
    size_t offset = offsetof(RtStarsDqsAdspcFc, err);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r4, offset, fc.jumpPc1);
    ConstructBranch(r2, r3, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq);

    // 根据cqeBaseAddr和cqeSize、cqeHead计算cqe地址
    // r3 = cqeBaseAddr
    ConstructLLWI(r3, fcPara.cqeBaseAddr, fc.llwi3);
    ConstructLHWI(r3, fcPara.cqeBaseAddr, fc.lhwi3);
    // r4 = cqeSize
    ConstructLLWI(r4, static_cast<uint64_t>(fcPara.cqeSize), fc.llwi4);
    ConstructLHWI(r4, static_cast<uint64_t>(fcPara.cqeSize), fc.lhwi4);
    // r4 = cqHead * cqeSize
    ConstructOpMul(r2, r4, r4, fc.mult);
    // r3 = cqeBaseAddr + cqeSize * cqHead
    ConstructOpAdd(r3, r4, r3, fc.add);

    // Loop: do-while 拷贝cqe到cqeCopyAddr，梳理为cqeSize，每次拷贝8B。 隐含约束：拷贝的数据总量必须为8B的倍数
    // r4 = loop_index
    ConstructOpImmAndi(r0, r4, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);
    // r5 = loop_max
    ConstructOpImmAndi(r0, r5, static_cast<uint32_t>(fcPara.cqeSize), RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi2);
    // r6 = copyDestAddr
    ConstructLLWI(r6, fcPara.cqeCopyAddr, fc.llwi5);
    ConstructLHWI(r6, fcPara.cqeCopyAddr, fc.lhwi5);
    ConstructLoad(r3, 0U, r7, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load3);
    ConstructStore(r6, r7, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.store1);
    // 拷贝地址+8
    ConstructOpImmAndi(r3, r3, 8U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi3);
    ConstructOpImmAndi(r6, r6, 8U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi4);
    // loop_index+=8
    ConstructOpImmAndi(r4, r4, 8U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi5);
    // 如果 r4 < r5，跳转并继续拷贝
    offset = offsetof(RtStarsDqsAdspcFc, load3);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc2);
    ConstructBranch(r4, r5, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU, static_cast<uint8_t>(offset), fc.bltu);
    /* -------- Loop end -------- */

    // 更新cqHead
    // cqHead = (cqHead + 1) % cqDepth
    ConstructOpImmAndi(r2, r2, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi6);
    ConstructOpImmAndi(r2, r2, static_cast<uint32_t>(fcPara.cqeHeadTailMask), RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI, fc.andi3);
    // store cqHead
    ConstructStore(r1, r2, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.store2);

    // 将mbufHandle入队到生产者队列，如果OW中包含有效的mbufHandle，需要先对OW mbufHandle进行释放
    // r1 = qmngrOwOp ret
    ConstructLLWI(r1, fcPara.qmngrOwRegAddr, fc.llwi6);
    ConstructLHWI(r1, fcPara.qmngrOwRegAddr, fc.lhwi6);
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.load4);
    // dfx：记录ow读取结果，忽略高32位
    ConstructStore(r8, r1, dfxQmngrOwValOffst, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store3);

    // r2 = qmngrOwOp error code
    // 通过右移和左移 获取handle[31:29] bit的数据
    ConstructOpImmSlli(r1, r2, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli1);
    ConstructOpImmSlli(r2, r2, dqsErrCodeRightShift, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli1);
    ConstructLLWI(r3, dqsErrorQueueNotEnable, fc.llwi7);
    ConstructLHWI(r3, dqsErrorQueueNotEnable, fc.lhwi7);
    // if queue not enable, goto err
    offset = offsetof(RtStarsDqsAdspcFc, err);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r4, offset, fc.jumpPc3);
    ConstructBranch(r2, r3, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq1);

    // if no over write, goto enqueue
    offset = offsetof(RtStarsDqsAdspcFc, llwi10);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc4);
    ConstructBranch(r0, r2, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.bneq);

    // free mbuf handle
    ConstructLLWI(r3, fcPara.mbufFreeRegAddr, fc.llwi8);
    ConstructLHWI(r3, fcPara.mbufFreeRegAddr, fc.lhwi8);
    ConstructLLWI(r4, dqsPoolIdBlkIdMask, fc.llwi9);
    ConstructLHWI(r4, dqsPoolIdBlkIdMask, fc.lhwi9);
    // r4 = ow mbufHandle
    ConstructOpAnd(r1, r4, r4, fc.and1);
    // 释放 ow mbuf handle
    ConstructStore(r3, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store4);

    // 将mbuf入队
    ConstructLLWI(r5, static_cast<uint64_t>(fcPara.mbufHandle), fc.llwi10);
    ConstructLHWI(r5, static_cast<uint64_t>(fcPara.mbufHandle), fc.lhwi10);
    ConstructLLWI(r6, fcPara.qmngrEnqRegAddr, fc.llwi11);
    ConstructLHWI(r6, fcPara.qmngrEnqRegAddr, fc.lhwi11);
    // enqueue
    ConstructStore(r6, r5, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store5);

    // skip error
    offset = offsetof(RtStarsDqsAdspcFc, end);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc5);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beq2);

    // error instr
    ConstructErrorInstr(fc.err);

    // end instr
    ConstructNop(fc.end);

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsAdspcFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_DEBUG, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

} // namespace runtime
} // namespace cce 