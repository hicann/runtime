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
#include "stars_cond_isa_struct.hpp"
#include "tsch_cmd.h"

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
constexpr uint64_t AXI_USER_VA_CFG_MASK = 0x900000009ULL;

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

// GQM CMD
constexpr uint32_t RT_STARS_COND_GQM_COMMAND_POP = 0B000101;
constexpr uint64_t RT_DQS_MBUF_INVALID = 0x20000ULL; // max + 1: 0x1FFFF + 1

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

static void InitMbufOpCnt(const rtStarsCondIsaRegister_t dstReg, uint64_t cntAddr,
    RtStarsCondOpLLWI &llwiCntAddr, RtStarsCondOpLHWI &lhwiCntAddr, RtStarsCondOpStore &initCnt)
{
    constexpr rtStarsCondIsaRegister_t r0 = RT_STARS_COND_ISA_REGISTER_R0;

    ConstructLLWI(dstReg, cntAddr, llwiCntAddr);
    ConstructLHWI(dstReg, cntAddr, lhwiCntAddr);
    ConstructStore(dstReg, r0, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SB, initCnt);

    return;
}

static void ConstructMbufTrace(CondMbufTraceFc &fc, const CondMbufTraceParam &funcCallPara, MbufTraceRegParam &param, const uint32_t traceFcNop)
{
    // mbuf_handle_reg 为mbuf handle
    // loop_index_reg不可修改，只读
    constexpr uint64_t traceAddrOffset = 8ULL;                   // 地址为U64
    constexpr uint64_t qidOffset = 2ULL;
    constexpr uint64_t blkSizeOffset = 4ULL;
    constexpr uint64_t traceStreamIdOcupySize = 4ULL; // owner_id

    ConstructLLWI(param.avail_reg0, dqsBlockIdMask, fc.llwiBlkIdMask);
    ConstructLHWI(param.avail_reg0, dqsBlockIdMask, fc.lhwiBlkIdMask);
    ConstructOpAnd(param.avail_reg0, param.mbuf_handle_reg, param.avail_reg0, fc.andWithBlkIdMask);
    ConstructOpImmSlli(param.avail_reg0, param.avail_reg0, dqsBlockIdOffset, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srliForGetBlkId);

    // 加载trace地址偏移，在ctrl space中为u64数组，偏移为8个字节
    ConstructLLWI(param.avail_reg1, traceAddrOffset, fc.llwiAddrOffset);
    ConstructLHWI(param.avail_reg1, traceAddrOffset, fc.lhwiAddrOffset);
    // 计算基于基地址的偏移存入avail_reg1 = 地址偏移[8] * loop_index
    ConstructOpMul(param.avail_reg1, param.loop_index_reg, param.avail_reg1, fc.multGetAddrOffset);

    // 执行执行完后，avail_reg2为trace地址数组的基地址
    ConstructLLWI(param.avail_reg2, funcCallPara.traceBaseAddr, fc.llwiTraceBaseAddr);
    ConstructLHWI(param.avail_reg2, funcCallPara.traceBaseAddr, fc.lhwiTraceBaseAddr);
    // 基地址 + avail_reg1（地址偏移）= 实际在ctrl space trace地址数组偏移后的地址, 记录到avail_reg2
    ConstructOpAdd(param.avail_reg2, param.avail_reg1, param.avail_reg2, fc.addiGetRealOpTraceAddr);
    // 此运算完成后avail_reg2为对应qid trace在share pool中数据的基地址
    ConstructLoad(param.avail_reg2, 0U, param.avail_reg2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrTraceOpAddr);

    // 如果地址为0跳转到Trace Fc的Nop指令退出Mbuf Trace的录入逻辑，目的是初始化异常时不要影响正常的逻辑运行
    ConstructSetJumpPcFc(param.avail_reg3, traceFcNop, fc.jumpTraceNop);
    ConstructBranch(param.avail_reg2, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, traceFcNop, fc.beqForBranch);

    // 读取TraceBlockSize基地址到avail_reg3，在ctrl space为数组
    ConstructLLWI(param.avail_reg3, funcCallPara.traceBlockSizeAddr, fc.llwiTraceBlockSizeAddr);
    ConstructLHWI(param.avail_reg3, funcCallPara.traceBlockSizeAddr, fc.lhwiTraceBlockSizeAddr);
    // 加载blk size offset偏移
    ConstructLLWI(param.avail_reg1, blkSizeOffset, fc.llwiBlkSizeOffset);
    ConstructLHWI(param.avail_reg1, blkSizeOffset, fc.lhwiBlkSizeOffset);
    // 计算基于基地址的blk size offset偏移存入avail_reg1 = 地址偏移 * loop_index
    ConstructOpMul(param.avail_reg1, param.loop_index_reg, param.avail_reg1, fc.multGetBlkSizeOffset);

    // 基地址avail_reg3 + avail_reg1（地址偏移）= 在ctrl space中的数组地址偏移avail_reg3
    ConstructOpAdd(param.avail_reg3, param.avail_reg1, param.avail_reg3, fc.addiGetRealOpBlockAddr);

    // 读取当前qid对应的的mbuf blk size值到avail_reg3
    ConstructLoad(param.avail_reg3, 0U, param.avail_reg3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrTraceBlockSizeAddr);

    // 计算偏移trace_blk_size * blk_id，结果存储到avail_reg3
    ConstructOpMul(param.avail_reg0, param.avail_reg3, param.avail_reg3, fc.muliGetOffset);
    // 计算当前需要操作trace share pool地址，结果存储到avail_reg2 [后续都基于此地址在结构体内做操作]
    ConstructOpAdd(param.avail_reg3, param.avail_reg2, param.avail_reg2, fc.addiGetTraceAddr);

    // 计算opTypeOffset的地址并存储在avail_reg3， 【avail_reg2为trace结构体基地址】
    ConstructLLWI(param.avail_reg3, funcCallPara.opTypeOffset, fc.llwiOpTypeOffset);
    ConstructLHWI(param.avail_reg3, funcCallPara.opTypeOffset, fc.lhwiOpTypeOffset);
    ConstructOpAdd(param.avail_reg2, param.avail_reg3, param.avail_reg3, fc.addiGetOpTypeAddr);

    // 读取opType到avail_reg1
    ConstructLLWI(param.avail_reg1, funcCallPara.opTypeVal, fc.llwiOpType);
    ConstructLHWI(param.avail_reg1, funcCallPara.opTypeVal, fc.lhwiOpType);
    // avail_reg3为trace中op type的地址， 将avail_reg1中的op type内存写入avail_reg3
    ConstructStore(param.avail_reg3, param.avail_reg1, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SB, fc.storeOpType);

    // 加载owner_id数组在ctrl space的偏移, 占40个bit, streamId 32个bit
    ConstructLLWI(param.avail_reg3, funcCallPara.ownerIdOffset, fc.llwiOwnIdAddr);
    ConstructLHWI(param.avail_reg3, funcCallPara.ownerIdOffset, fc.lhwiOwnIdAddr);
    ConstructLLWI(param.avail_reg1, funcCallPara.streamId, fc.llwiStreamId);
    ConstructLHWI(param.avail_reg1, funcCallPara.streamId, fc.lhwiStreamId);
    ConstructOpAdd(param.avail_reg2, param.avail_reg3, param.avail_reg3, fc.addiGetOwnIdOpAddr);
    ConstructStore(param.avail_reg3, param.avail_reg1, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.storeOwnerId);

    // 剩余8bit写0
    ConstructLLWI(param.avail_reg1, traceStreamIdOcupySize, fc.llwiOwnIdOccpySize);
    ConstructLHWI(param.avail_reg1, traceStreamIdOcupySize, fc.lhwiOwnIdOccpySize);
    ConstructOpAdd(param.avail_reg3, param.avail_reg1, param.avail_reg3, fc.addiGetLeft1BitOpAddr);
    ConstructStore(param.avail_reg3, r0, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SB, fc.storeLeft1BitTo0);

    // 加载qid数组偏移, qid 类型为U16
    ConstructLLWI(param.avail_reg3, qidOffset, fc.llwiQidAddrOffset);
    ConstructLHWI(param.avail_reg3, qidOffset, fc.lhwiQidAddrOffset);
    // 计算基于基地址的偏移存入avail_reg3 = 地址偏移【2字节】 * loop_index
    ConstructOpMul(param.loop_index_reg, param.avail_reg3, param.avail_reg3, fc.multGetQidOffset);

    // 获取qid地址到avail_reg1
    ConstructLLWI(param.avail_reg1, funcCallPara.qidAddr, fc.llwiQidBaseAddr);
    ConstructLHWI(param.avail_reg1, funcCallPara.qidAddr, fc.lhwiQidBaseAddr);
    ConstructOpAdd(param.avail_reg1, param.avail_reg3, param.avail_reg1, fc.addiGetOpQidAddr);
    // 读取qid的值到avail_reg1
    ConstructLoad(param.avail_reg1, 0U, param.avail_reg1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrDstQid);
    // avail_reg2为mbuf trace数据结构的基地址， 将opQidOffset读取到avail_reg3
    ConstructLLWI(param.avail_reg3, funcCallPara.opQidOffset, fc.llwiQidOffset);
    ConstructLHWI(param.avail_reg3, funcCallPara.opQidOffset, fc.lhwiQidOffset);
    // avail_reg3为真正qid在trace结构体中的地址
    ConstructOpAdd(param.avail_reg2, param.avail_reg3, param.avail_reg3, fc.addiGetQidAddr);
    // avail_reg1为trace中op_qid的地址，avail_reg1为qid的值
    ConstructStore(param.avail_reg3, param.avail_reg1, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SH, fc.storeQid);

    ConstructLLWI(param.avail_reg1, funcCallPara.updateTimeOffset, fc.llwiUpdateTimeOffset);
    ConstructLHWI(param.avail_reg1, funcCallPara.updateTimeOffset, fc.lhwiUpdateTimeOffset);
    ConstructOpAdd(param.avail_reg2, param.avail_reg1, param.avail_reg1,  fc.addiGetUpdateTimeAddr);
    // read immd reg va cfg mask
    ConstructLLWI(param.avail_reg0, AXI_USER_VA_CFG_MASK, fc.llwiAxiUserVaCfgMask);
    ConstructLLWI(param.avail_reg3, funcCallPara.lpSysCntAddr, fc.llwiLpSysCntAddr);
    ConstructLHWI(param.avail_reg3, funcCallPara.lpSysCntAddr, fc.lhwiLpSysCntAddr);
    ConstructLoad(param.avail_reg3, 0U, param.avail_reg3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrLpSysCntAddr);

    // cfg use PA
    ConstructSystemCsr(param.avail_reg0, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrcForLpSysCntAddr);
    // 读取sys cnt
    ConstructLoad(param.avail_reg3, 0U, param.avail_reg3, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrLpSysCnt);
    // restore to use VA
    ConstructSystemCsr(param.avail_reg0, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrsForLpSysCntAddr);
    // avail_reg1为trace中更新时间的地址, avail_reg3为lp syscnt值
    ConstructStore(param.avail_reg1, param.avail_reg3, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SD, fc.storeUpdateTime);
    ConstructNop(fc.nop);

    return;
}

static void ConstructMbufFreeDssDelayPart(RtStarsDqsMbufFreeFc &fc, const RtDqsMbufFreeFcPara &funcCallPara)
{
    // 获取当前任务type
    ConstructLLWI(r9, static_cast<uint64_t>(funcCallPara.schedType), fc.llwi4);
    ConstructLHWI(r9, static_cast<uint64_t>(funcCallPara.schedType), fc.lhwi4);
    ConstructLLWI(r10, static_cast<uint64_t>(RT_DQS_SCHED_TYPE_DSS), fc.llwi5);
    ConstructLHWI(r10, static_cast<uint64_t>(RT_DQS_SCHED_TYPE_DSS), fc.lhwi5);

    uint64_t offset = offsetof(RtStarsDqsMbufFreeFc, ldr3);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc1);
    // 如果不是DSS则直接跳到mbuf free
    ConstructBranch(r9, r10, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, offset, fc.bne);

    // r5 = invalid mbuf handle
    ConstructLLWI(r5, RT_DQS_MBUF_INVALID, fc.llwiMaxMbuf);
    ConstructLHWI(r5, RT_DQS_MBUF_INVALID, fc.lhwiMaxMbuf);

    // 如果当前路没有新数据到达，跳转到下个input队列
    offset = offsetof(RtStarsDqsMbufFreeFc, addi2);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc2);
    ConstructBranch(r4, r5, RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU, offset, fc.bgeu1);

    ConstructLLWI(r9, funcCallPara.lastMbufHandleAddr, fc.llwi6);
    ConstructLHWI(r9, funcCallPara.lastMbufHandleAddr, fc.lhwi6);

    ConstructLLWI(r10, static_cast<uint64_t>(funcCallPara.sizeofHandleCache), fc.llwi7);
    ConstructLHWI(r10, static_cast<uint64_t>(funcCallPara.sizeofHandleCache), fc.lhwi7);

    ConstructOpMul(r10, r6, r10, fc.mult);
    // r10 = last_used_handle 在CtrlSpace中的地址
    ConstructOpAdd(r9, r10, r10, fc.add);

    // r9 = last_used_handle
    ConstructLoad(r10, 0U, r9, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);
    // trim high 32 bit
    ConstructOpImmSlli(r9, r9, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli2);
    ConstructOpImmSlli(r9, r9, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli2);

    // 将当前的handle存入last_used_handle，只存32bit
    ConstructStore(r10, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.sw1);

    // 将当前mbuf handle地址中的内容置为无效值，表示已使用
    ConstructStore(r2, r5, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.sw2);

    // 将last_used_handle挪到r4，供后续释放
    ConstructOpImmAndi(r9, r4, 0U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);

    offset = offsetof(RtStarsDqsMbufFreeFc, addi2);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc3);
    // 如果last_used_handle大于mbuf handle最大值，代表是第一次执行mbuf free，需要跳过
    ConstructBranch(r9, r5, RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU, offset, fc.bgeu2);
}

void ConstructMbufFreeInstrFc(RtStarsDqsMbufFreeFc &fc, const RtDqsMbufFreeFcPara &funcCallPara)
{
    // realFreeMbufCnt = 0
    InitMbufOpCnt(r1, funcCallPara.realFreeMbufCntAddr, fc.llwiCntAddr1, fc.lhwiCntAddr1, fc.initCnt1);

    // r8 = read immd reg va cfg mask
    ConstructLLWI(r8, AXI_USER_VA_CFG_MASK, fc.llwi);
    ConstructLHWI(r8, AXI_USER_VA_CFG_MASK, fc.lhwi);
    // r6 作为input queue num 的下标，从0开始
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
    // trim high 32 bit
    ConstructOpImmSlli(r4, r4, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli1);
    ConstructOpImmSlli(r4, r4, 32U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srli1);

    ConstructMbufFreeDssDelayPart(fc, funcCallPara);

    // r5 = mbuf_free_op_addr，根据mbufFreeAddr的地址 r1 读mbuf pool 到 r5 寄存器中
    ConstructLoad(r1, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr3);

    // cfg use PA
    ConstructSystemCsr(r8, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrc);

    // 将mbuf handle r4 写入 mbuf pool寄存器 r5中 SW R4, R5, 0
    ConstructStore(r5, r4, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.sw3);

    // restore to use VA
    ConstructSystemCsr(r8, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrs);

    // r4位mbuf handle value寄存器， 结合上下文mbuf_handle_reg可复用
    MbufTraceRegParam freeRegParam = {
        .loop_index_reg = r6, .mbuf_handle_reg = r4, .avail_reg0 = r5, .avail_reg1 = r7, .avail_reg2 = r9, .avail_reg3 = r10
    };

    const uint32_t mbufTraceNop = (RtPtrToValue(&(fc.freeMbufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.freeMbufTracefc, funcCallPara.freeMbufTracePara, freeRegParam, mbufTraceNop);

    // r2 mbufHandleAddr + 4， 下一个mbuf handle 的地址
    ConstructOpImmAndi(r2, r2, 4, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi2);

    // r1 mbufFreeAddr + 8，下一个mbuf pool的寄存器地址
    ConstructOpImmAndi(r1, r1, 8, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi3);

    // r6自增1, index ++
    ConstructOpImmAndi(r6, r6, 1, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi4);

    // increment realFreeMbufCntAddr
    ConstructLLWI(r10, static_cast<uint64_t>(funcCallPara.realFreeMbufCntAddr), fc.llwiCntAddr2);
    ConstructLHWI(r10, static_cast<uint64_t>(funcCallPara.realFreeMbufCntAddr), fc.lhwiCntAddr2);
    ConstructLoad(r10, 0U, r9, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrCntAddr1);
    ConstructOpImmAndi(r9, r9, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addiCnt1);
    ConstructStore(r10, r9, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SB, fc.incCnt1);

    // Jump pc 在 Func call 中，跳转指令大于15时，需要借助 CSR寄存器(JUMP_PC)完成跳转
    uint64_t offset = offsetof(RtStarsDqsMbufFreeFc, ldr1);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPc4);

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
    // realEnqueMbufCntAddr = 0
    InitMbufOpCnt(r1, funcCallPara.realEnqueMbufCntAddr, fc.llwiCntAddr0, fc.lhwiCntAddr0, fc.initCnt0);

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

    // read immd reg va cfg mask
    ConstructLLWI(r5, AXI_USER_VA_CFG_MASK, fc.llwi);
    ConstructLHWI(r5, AXI_USER_VA_CFG_MASK, fc.lhwi);
    // cfg use PA
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRC, fc.csrrc);
    // 释放 ow mbuf handle
    ConstructStore(r7, r8, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.owfree);
    // restore to use VA
    ConstructSystemCsr(r5, r0, RT_STARS_COND_CSR_AXI_USER_REG, RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRS, fc.csrrs);

    // r8位当前mbuf handle value寄存器，结合上下文mbuf_handle_reg可复用
    MbufTraceRegParam owFreeRegInfo = {
        .loop_index_reg = r10, .mbuf_handle_reg = r8, .avail_reg0 = r4, .avail_reg1 = r5, .avail_reg2 = r6, .avail_reg3 = r7
    };
    uint32_t mbufTraceNop = (RtPtrToValue(&(fc.owFreeMbufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.owFreeMbufTracefc, funcCallPara.owFreeMbufTracePara, owFreeRegInfo, mbufTraceNop);

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

    // r5为当前操作mbuf handle value寄存器，集合上下文mbuf_handle_reg可复用
    MbufTraceRegParam enqueRegInfo = {
        .loop_index_reg = r10, .mbuf_handle_reg = r5, .avail_reg0 = r4, .avail_reg1 = r6, .avail_reg2 = r7, .avail_reg3 = r8
    };
    mbufTraceNop = (RtPtrToValue(&(fc.enqueMbufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.enqueMbufTracefc, funcCallPara.enqueMbufTracePara, enqueRegInfo, mbufTraceNop);

    // increment realEnqueMbufCntAddr
    ConstructLLWI(r5, static_cast<uint64_t>(funcCallPara.realEnqueMbufCntAddr), fc.llwiCntAddr1);
    ConstructLHWI(r5, static_cast<uint64_t>(funcCallPara.realEnqueMbufCntAddr), fc.lhwiCntAddr1);
    ConstructLoad(r5, 0U, r7, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrCntAddr1);
    ConstructOpImmAndi(r7, r7, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addiCntAddr1);
    ConstructStore(r5, r7, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SB, fc.incCnt1);

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

    // 加载 mbufPoolIndexMax 到 r4 寄存器中
    ConstructLLWI(r4, funcCallPara.mbufPoolIndexMax, fc.llwi4);
    ConstructLHWI(r4, funcCallPara.mbufPoolIndexMax, fc.lhwi4);

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
    RtStarsCondGqmOpFc gqmPopi;
 
    // realInputMbufCntAddr = 0
    InitMbufOpCnt(r4, funcCallPara.realInputMbufCntAddr, fc.llwiCntAddr0, fc.lhwiCntAddr0, fc.initCnt0); 
    
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

    // r7位当前操作mbuf handle value寄存器，结合上下文mbuf_handle_reg不可复用
    MbufTraceRegParam param = {
        .loop_index_reg = r0, .mbuf_handle_reg = r7, .avail_reg0 = r3, .avail_reg1 = r5, .avail_reg2 = r9, .avail_reg3 = r10
    };
    const uint32_t mbufTraceNop = (RtPtrToValue(&(fc.dequeMbufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.dequeMbufTracefc, funcCallPara.dequeMbufTracePara, param, mbufTraceNop);

    // write mbuffer into mbuf handle addr
    ConstructStore(r8, r7, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.store);

    // r4 is cnt addr
    ConstructLoad(r4, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr2);
    // increment count: R5 = R5 + 1
    ConstructOpImmAndi(r5, r5, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addi1);
    // store updated count back
    ConstructStore(r4, r5, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SB, fc.initCnt1);

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
    ConstructLHWI(r7, 0U, fc.lhwiIndex);
    // 循环开始，后续流程R2\3\4\7寄存器都不可写，因为存储了临时变量作为索引

    /* pa和va的相关配置 */
    ConstructLLWI(r1, AXI_USER_VA_CFG_MASK, fc.llwiAddrMask);
    ConstructLHWI(r1, AXI_USER_VA_CFG_MASK, fc.lhwiAddrMask);

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
    // r6为mbuf handle value寄存器，结合上下文，mbuf_handle_reg不可复用
    MbufTraceRegParam mbufTraceRegInfo = {
        .loop_index_reg = r7, .mbuf_handle_reg = r6, .avail_reg0 = r1, .avail_reg1 = r5, .avail_reg2 = r8, .avail_reg3 = r9
    };
    const uint32_t mbufTraceNop = (RtPtrToValue(&(fc.dequeMbufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.dequeMbufTracefc, funcCallPara.dequeMbufTracePara, mbufTraceRegInfo, mbufTraceNop);

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
	
    ConstructLLWI(r9, MAX_CACHE_SIZE, fc.llwiHandleCacheDeep);
    ConstructLHWI(r9, MAX_CACHE_SIZE, fc.lhwiHandleCacheDeep);
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
	ConstructLLWI(r1, AXI_USER_VA_CFG_MASK, fc.llwiAddrMask1);
	ConstructLHWI(r1, AXI_USER_VA_CFG_MASK, fc.lhwiAddrMask1);
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
	ConstructLLWI(r1, AXI_USER_VA_CFG_MASK, fc.llwiAddrMask2);
	ConstructLHWI(r1, AXI_USER_VA_CFG_MASK, fc.lhwiAddrMask2);
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

/* 针对DSS场景做帧对齐操作：无需帧对齐，只要任意一路有数据，从input_mbuf_cache_list.handle_array[0]取数据，放入input_mbuf_list */
void ConstructDqsFrameAlignForDssFc(RtStarsDqsFrameAlignForDssFc &fc, const RtStarsDqsFrameAlignFcPara &fcPara)
{
    // r1 = input_mbuf_list当前写入地址
    ConstructLLWI(r1, fcPara.inputMbufListAddr, fc.llwiInputMbufListAddr);
    ConstructLHWI(r1, fcPara.inputMbufListAddr, fc.lhwiInputMbufListAddr);
    // r2 = input_mbuf_cache_list当前读取地址
    ConstructLLWI(r2, fcPara.inputMbufCacheListAddr, fc.llwiInputMbufCacheListAddr);
    ConstructLHWI(r2, fcPara.inputMbufCacheListAddr, fc.lhwiInputMbufCacheListAddr);
    // r3 = input_queue_num
    ConstructLLWI(r3, static_cast<uint64_t>(fcPara.inputQueueNum), fc.llwiInputQueueNum);
    ConstructLHWI(r3, static_cast<uint64_t>(fcPara.inputQueueNum), fc.lhwiInputQueueNum);
    // r4 = 当前queue索引
    ConstructLLWI(r4, 0ULL, fc.llwiIndex);
    ConstructLHWI(r4, 0ULL, fc.lhwiIndex);

    // 从input_mbuf_cache_t.cnt读取缓存深度，cnt字段为uint16_t，使用移位清理高位。
    // r5 = cnt字段地址，r6 = 当前queue的cnt值
    ConstructLLWI(r5, static_cast<uint64_t>(fcPara.cntOffset), fc.llwiCntOffset);
    ConstructLHWI(r5, static_cast<uint64_t>(fcPara.cntOffset), fc.lhwiCntOffset);
    ConstructOpOp(r2, r5, r5, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.addCntAddr);
    ConstructLoad(r5, 0U, r6, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrCnt);
    ConstructOpImmSlli(r6, r6, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slliCnt);
    ConstructOpImmSlli(r6, r6, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srliCnt);

    // cnt为0表示该queue无缓存数据，直接跳到next处理下一个queue。
    uint64_t offset = offsetof(RtStarsDqsFrameAlignForDssFc, addiInputMbufListAddr) / sizeof(uint32_t);
    // r7 = jump pc临时寄存器
    ConstructSetJumpPcFc(r7, offset, fc.jumpNextIfCntZero);
    ConstructBranch(r6, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beqCntZero);

    // DSS场景无需等待多路帧对齐，直接将handle_array[0]写入对应input_mbuf_list。
    // r8 = mbuf handle临时寄存器
    ConstructLoad(r2, 0U, r8, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrHandle0);
    ConstructStore(r1, r8, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.storeInputMbuf);

    // cache深度为2时，将handle_array[1]前移到handle_array[0]，保持下一次读取仍从0号槽位取数。
    // r9 = cache深度比较值
    ConstructLLWI(r9, MAX_CACHE_SIZE, fc.llwiCacheDeep);
    ConstructLHWI(r9, MAX_CACHE_SIZE, fc.lhwiCacheDeep);
    offset = offsetof(RtStarsDqsFrameAlignForDssFc, llwiOne) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpDecCnt);
    ConstructBranch(r6, r9, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset), fc.bneCntNotTwo);
    ConstructLoad(r2, sizeof(uint32_t), r8, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrHandle1);
    ConstructStore(r2, r8, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.storeHandle1To0);

    // 当前queue已消耗一个缓存handle，cnt减1后按uint16_t写回cnt字段。
    // r9 = cnt递减值
    ConstructLLWI(r9, 1ULL, fc.llwiOne);
    ConstructLHWI(r9, 1ULL, fc.lhwiOne);
    ConstructOpOp(r6, r9, r6, RT_STARS_COND_ISA_OP_FUNC3_SUB, RT_STARS_COND_ISA_OP_FUNC7_SUB, fc.subCnt);
    ConstructStore(r5, r6, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SH, fc.storeCnt);

    // next: 推进到下一个queue的input_mbuf_list和input_mbuf_cache_list。
    ConstructOpImmAndi(r1, r1, sizeof(uint32_t), RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addiInputMbufListAddr);
    ConstructOpImmAndi(r2, r2, fcPara.sizeofHandleCache, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI,
        fc.addiInputMbufCacheListAddr);
    ConstructOpImmAndi(r4, r4, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addiIndex);

    // index < input_queue_num时回到循环起点，继续处理下一路输入。
    offset = offsetof(RtStarsDqsFrameAlignForDssFc, llwiCntOffset) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpStartLoop);
    ConstructBranch(r4, r3, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU, static_cast<uint8_t>(offset), fc.bltuStartLoop);

    ConstructNop(fc.end);

    const uint32_t *const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsFrameAlignForDssFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_INFO, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

static void ConstructDqsFrameAlignCheckPhase(RtStarsDqsFrameAlignFc &fc, const RtStarsDqsFrameAlignFcPara &fcPara)
{
    // Check phase: 只检查所有input queue是否都有缓存数据，不消费handle。
    ConstructLLWI(r2, fcPara.inputMbufCacheListAddr, fc.llwiCheckCacheListAddr);
    ConstructLHWI(r2, fcPara.inputMbufCacheListAddr, fc.lhwiCheckCacheListAddr);
    ConstructLLWI(r3, static_cast<uint64_t>(fcPara.inputQueueNum), fc.llwiQueueNum);
    ConstructLHWI(r3, static_cast<uint64_t>(fcPara.inputQueueNum), fc.lhwiQueueNum);
    ConstructLLWI(r4, 0ULL, fc.llwiCheckIndex);
    ConstructLHWI(r4, 0ULL, fc.lhwiCheckIndex);

    // r5 = 当前input_mbuf_cache_t.cnt地址，r6 = cnt值。cnt是uint16_t，LDR后必须裁剪高位。
    ConstructLLWI(r5, static_cast<uint64_t>(fcPara.cntOffset), fc.llwiCheckCntOffset);
    ConstructLHWI(r5, static_cast<uint64_t>(fcPara.cntOffset), fc.lhwiCheckCntOffset);
    ConstructOpOp(r2, r5, r5, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.addCheckCntAddr);
    ConstructLoad(r5, 0U, r6, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrCheckCnt);
    ConstructOpImmSlli(r6, r6, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slliCheckCnt);
    ConstructOpImmSlli(r6, r6, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srliCheckCnt);

    // 任一路cnt为0表示对齐失败，跳转到stream head等待下一次调度。
    // SetJumpPc/Branch的offset单位是4B指令字，不是字节。
    uint64_t offset = offsetof(RtStarsDqsFrameAlignFc, llwiSqId) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpGotoHeadIfCheckCntZero);
    ConstructBranch(r6, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beqCheckCntZero);

    // 当前queue检查通过后，推进到下一路input_mbuf_cache_t继续检查。
    ConstructOpImmAndi(r2, r2, fcPara.sizeofHandleCache, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI,
        fc.addiCheckCacheListAddr);
    ConstructOpImmAndi(r4, r4, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addiCheckIndex);
    offset = offsetof(RtStarsDqsFrameAlignFc, llwiCheckCntOffset) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpCheckStartLoop);
    ConstructBranch(r4, r3, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU, static_cast<uint8_t>(offset), fc.bltuCheckStartLoop);
}

static void ConstructDqsFrameAlignCommitPhase(RtStarsDqsFrameAlignFc &fc, const RtStarsDqsFrameAlignFcPara &fcPara)
{
    // Commit phase: 此时已确认所有queue都有数据，可以逐路写input_mbuf_list并递减cnt。
    ConstructLLWI(r1, fcPara.inputMbufListAddr, fc.llwiCommitMbufListAddr);
    ConstructLHWI(r1, fcPara.inputMbufListAddr, fc.lhwiCommitMbufListAddr);
    ConstructLLWI(r2, fcPara.inputMbufCacheListAddr, fc.llwiCommitCacheListAddr);
    ConstructLHWI(r2, fcPara.inputMbufCacheListAddr, fc.lhwiCommitCacheListAddr);
    ConstructLLWI(r4, 0ULL, fc.llwiCommitIndex);
    ConstructLHWI(r4, 0ULL, fc.lhwiCommitIndex);

    // cnt为1时取handle_array[0]，cnt大于1时取handle_array[1]。
    // 选择handle时不移动handle_array内容：cnt递减后，下次cnt==1会自然取handle_array[0]。
    ConstructLLWI(r5, static_cast<uint64_t>(fcPara.cntOffset), fc.llwiCommitCntOffset);
    ConstructLHWI(r5, static_cast<uint64_t>(fcPara.cntOffset), fc.lhwiCommitCntOffset);
    ConstructOpOp(r2, r5, r5, RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, fc.addCommitCntAddr);
    ConstructLoad(r5, 0U, r6, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrCommitCnt);
    ConstructOpImmSlli(r6, r6, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slliCommitCnt);
    ConstructOpImmSlli(r6, r6, 48U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SRLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SRLI, fc.srliCommitCnt);
    ConstructLLWI(r7, 1ULL, fc.llwiCntStep);
    ConstructLHWI(r7, 1ULL, fc.lhwiCntStep);
    uint64_t offset = offsetof(RtStarsDqsFrameAlignFc, ldrCacheHandle1) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpLoadHandle1IfCntNotOne);
    ConstructBranch(r6, r7, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, static_cast<uint8_t>(offset),
        fc.bneLoadHandle1IfCntNotOne);

    // cnt==1时加载handle_array[0]；加载后用无条件跳转跳过handle_array[1]分支。
    ConstructLoad(r2, 0U, r9, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrCacheHandle0);
    offset = offsetof(RtStarsDqsFrameAlignFc, storeSelectedHandle) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpStoreSelectedHandle);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset),
        fc.beqStoreSelectedHandle);

    // cnt!=1时加载handle_array[1]，与cnt==1分支共用后续写input_mbuf_list逻辑。
    ConstructLoad(r2, sizeof(uint32_t), r9, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrCacheHandle1);
    ConstructStore(r1, r9, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SW, fc.storeSelectedHandle);

    // 已提交一路handle到input_mbuf_list，对应cache cnt减1并按uint16_t写回。
    ConstructOpOp(r6, r7, r6, RT_STARS_COND_ISA_OP_FUNC3_SUB, RT_STARS_COND_ISA_OP_FUNC7_SUB, fc.subCommitCnt);
    ConstructStore(r5, r6, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SH, fc.storeCommitCnt);

    // 推进到下一路input_mbuf_list和input_mbuf_cache_list，直到所有输入queue完成提交。
    ConstructOpImmAndi(r1, r1, sizeof(uint32_t), RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addiCommitMbufListAddr);
    ConstructOpImmAndi(r2, r2, fcPara.sizeofHandleCache, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI,
        fc.addiCommitCacheListAddr);
    ConstructOpImmAndi(r4, r4, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addiCommitIndex);
    offset = offsetof(RtStarsDqsFrameAlignFc, llwiCommitCntOffset) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpCommitStartLoop);
    ConstructBranch(r4, r3, RT_STARS_COND_ISA_BRANCH_FUNC3_BLTU, static_cast<uint8_t>(offset),
        fc.bltuCommitStartLoop);
}

static void ConstructDqsFrameAlignGotoHead(RtStarsDqsFrameAlignFc &fc, const RtStarsDqsFrameAlignFcPara &fcPara)
{
    // 对齐成功后跳到end，避免继续执行下面的stream goto head失败处理。
    uint64_t offset = offsetof(RtStarsDqsFrameAlignFc, end) / sizeof(uint32_t);
    ConstructSetJumpPcFc(r8, offset, fc.jumpEnd);
    ConstructBranch(r0, r0, RT_STARS_COND_ISA_BRANCH_FUNC3_BEQ, static_cast<uint8_t>(offset), fc.beqEnd);

    // Check phase发现任一路无缓存数据时会跳到这里，回到stream head等待后续调度。
    ConstructLLWI(r1, fcPara.sqId, fc.llwiSqId);
    ConstructLHWI(r1, fcPara.sqId, fc.lhwiSqId);
    ConstructGotoR(r1, r0, fc.gotor);  // stream goto head
}

/* 针对NN/VPC场景的基础对齐，所有路都有数据输入时才对齐成功，从input_mbuf_cache_list将数据放入input_mbuf_list；对齐失败时跳转到head */
void ConstructDqsFrameAlignFc(RtStarsDqsFrameAlignFc &fc, const RtStarsDqsFrameAlignFcPara &fcPara)
{
    ConstructDqsFrameAlignCheckPhase(fc, fcPara);
    ConstructDqsFrameAlignCommitPhase(fc, fcPara);
    ConstructDqsFrameAlignGotoHead(fc, fcPara);
    ConstructNop(fc.end);

    const uint32_t *const cmd = RtPtrToPtr<const uint32_t *>(&fc);
    for (size_t i = 0UL; i < (sizeof(RtStarsDqsFrameAlignFc) / sizeof(uint32_t)); i++) {
        RT_LOG(RT_LOG_INFO, "func call: instr[%zu]=0x%08x", i, *(cmd + i));
    }
}

void ConstructDqsPrepareFc(RtStarsDqsPrepareOutFc &fc, const RtStarsDqsPrepareFcPara &fcPara)
{
    // realOutputAllocMbufCnt = 0
    InitMbufOpCnt(r9, fcPara.realOutputAllocMbufCntAddr, fc.llwiCntAddr1, fc.lhwiCntAddr1, fc.initCnt1); 

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

    // r4 当前操作mbuf handle value寄存器, mbuf_handle_reg不可复用
    MbufTraceRegParam param = {
        .loop_index_reg = r2, .mbuf_handle_reg = r4, .avail_reg0 = r5, .avail_reg1 = r6, .avail_reg2 = r7, .avail_reg3 = r8
    };
    const uint32_t mbufTraceNop = (RtPtrToValue(&(fc.allocMbufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.allocMbufTracefc, fcPara.allocMbufTracePara, param, mbufTraceNop);

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

    // 如果mbuf存入output_mbuf_list完成realOutputAllocMbufCnt递增
    ConstructLoad(r9, 0U, r5, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldrCntAddr1);
    ConstructOpImmAndi(r5, r5, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_ADDI, fc.addiCnt);
    ConstructStore(r9, r5, 0U, RT_STARS_COND_ISA_STORE_FUNC3_SB, fc.incCnt1);

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
    // r6 << 1: output_mbuf_head_pool_base_addr数组元素大小为8，r6 = (loop1_index * 4) * 2 = loop1_index * 8
    ConstructOpImmSlli(r6, r6, 1U, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI, RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, fc.slli5);
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

    // 如果mbufHandle的值大于等于RT_DQS_MBUF_INVALID，直接跳转结束
    ConstructLLWI(r3, RT_DQS_MBUF_INVALID, fc.llwiInvalidMbuf);
    ConstructLHWI(r3, RT_DQS_MBUF_INVALID, fc.lhwiInvalidMbuf);
    uint64_t offset = offsetof(RtStarsDqsZeroCopyFc, end);
    offset = offset / sizeof(uint32_t);
    ConstructSetJumpPcFc(r7, offset, fc.jumpPcInvalidMbuf);
    ConstructBranch(r2, r3, RT_STARS_COND_ISA_BRANCH_FUNC3_BGEU, static_cast<uint8_t>(offset), fc.bgeuInvalidMbuf);

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
    offset = offsetof(RtStarsDqsZeroCopyFc, jumpPc2);
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
    // read immd reg va cfg mask
    ConstructLLWI(r6, AXI_USER_VA_CFG_MASK, fc.llwi);

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

    // r1为mbuf handle value寄存器， 如果结合上下文，当前mbuf_handle_reg不可复用
    MbufTraceRegParam dstProdAllocRegInfo = {
        .loop_index_reg = r0, .mbuf_handle_reg = r1, .avail_reg0 = r2, .avail_reg1 = r8, .avail_reg2 = r9, .avail_reg3 = r10
    };
    const uint32_t mbufTraceNop = (RtPtrToValue(&(fc.allocMbufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.allocMbufTracefc, funcCallPara.allocMbufTracePara, dstProdAllocRegInfo, mbufTraceNop);

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
    // r4: read immd reg va cfg mask
    ConstructLLWI(r4, AXI_USER_VA_CFG_MASK, fc.llwi1);
    ConstructLHWI(r4, AXI_USER_VA_CFG_MASK, fc.lhwi1);

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

    // r3为mbuf handle value寄存器， 结合上下文，mbuf_handle_reg可以复用
    MbufTraceRegParam dstProdFreePara = {
        .loop_index_reg = r0, .mbuf_handle_reg = r3, .avail_reg0 = r1, .avail_reg1 = r2, .avail_reg2 = r7, .avail_reg3 = r9
    };
    uint32_t mbufTraceNop = (RtPtrToValue(&(fc.dstProdFreeMbufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.dstProdFreeMbufTracefc, funcCallPara.dstProdFreeMbufTracePara, dstProdFreePara, mbufTraceNop);

    // r1: dstMbufHandleAddr
    ConstructLLWI(r1, funcCallPara.dstMbufHandleAddr, fc.llwi7);
    ConstructLHWI(r1, funcCallPara.dstMbufHandleAddr, fc.lhwi7);

    // r1: dstMbufHandle, 会读64bit, handle只用到32bit
    ConstructLoad(r1, 0U, r1, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr4);

    // r2: dstQueueAddr
    ConstructLLWI(r2, funcCallPara.dstQueueAddr, fc.llwi8);
    ConstructLHWI(r2, funcCallPara.dstQueueAddr, fc.lhwi8);
    ConstructLoad(r2, 0U, r2, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, fc.ldr5);

    // r1为mbuf handle value寄存器， 结合上下文mbuf_handle_reg可以复用
    MbufTraceRegParam dstProdEnqueRegInfo = {
        .loop_index_reg = r0, .mbuf_handle_reg = r1, .avail_reg0 = r3, .avail_reg1 = r8, .avail_reg2 = r9, .avail_reg3 = r10
    };
    mbufTraceNop = (RtPtrToValue(&(fc.dstProdEnquembufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.dstProdEnquembufTracefc, funcCallPara.dstProdEnqueMbufTracePara, dstProdEnqueRegInfo, mbufTraceNop);

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

    // r3为mbuf handle value寄存器，结合上下文mbuf_handle_reg可以复用
    MbufTraceRegParam srcConsFreePara = {
        .loop_index_reg = r0, .mbuf_handle_reg = r3, .avail_reg0 = r1, .avail_reg1 = r2, .avail_reg2 = r6, .avail_reg3 = r7
    };
    mbufTraceNop = (RtPtrToValue(&(fc.srcConsFreembufTracefc.nop)) - RtPtrToValue(&fc)) / sizeof(uint32_t);
    ConstructMbufTrace(fc.srcConsFreembufTracefc, funcCallPara.srcConsFreeMbufTracePara, srcConsFreePara, mbufTraceNop);

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
