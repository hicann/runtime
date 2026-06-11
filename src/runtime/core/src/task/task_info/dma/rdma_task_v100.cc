/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_v100.h"
#include "rdma_task.h"
#include "task_manager.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "stars_cond_isa_helper.hpp"
#include "context.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "notify.hpp"

namespace cce {
namespace runtime {

#if F_DESC("RdmaDbSendTask")
static uint64_t GetRoceDbAddrForRdmaDbSendTask(const TaskInfo* const taskInfo)
{
    int64_t chipId = 0U;
    const uint32_t deviceId = taskInfo->stream->Device_()->Id_();
    const rtError_t error = taskInfo->stream->Device_()->Driver_()->GetDevInfo(deviceId, MODULE_TYPE_SYSTEM,
        INFO_TYPE_PHY_CHIP_ID, &chipId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get chip failed!, device_id=%u", deviceId);
        return 0ULL;
    }
    const uint64_t chipAddr = taskInfo->stream->Device_()->GetChipAddr();
    const uint64_t chipOffset = taskInfo->stream->Device_()->GetChipOffset();
    const uint64_t dieOffset  = taskInfo->stream->Device_()->GetDieOffset();

    const uint64_t dbAddr = RT_ROCEE_BASE_ADDR_128G + RT_ROCEE_VF_DB_CFG0_REG_230 +
        chipOffset * static_cast<uint64_t>(chipId) +
        dieOffset * (taskInfo->u.rdmaDbSendTask.taskDbIndex.dbIndexStars.dieId) +
        chipAddr;
    return dbAddr;
}

/* top half of rdma task sqe, designed to re-calculate PI in sink mode */
static void ConstructRdmaSink1Instr(const uint32_t piInit, const uint8_t sqDepthBitWidth,
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
static void ConstructRdmaSink2Instr(const uint64_t dbAddr, const uint64_t dbInfoWithoutPi,
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

static void ConstructSqeSinkModeForRdmaDb1SendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    RdmaDbSendTaskInfo *rdmaDbSendTask = &(taskInfo->u.rdmaDbSendTask);
    Stream * const stream = taskInfo->stream;

    // Construct sqe1
    const uint8_t sqDepthBitWidth = rdmaDbSendTask->taskDbIndex.dbIndexStars.sqDepthBitWidth;
    rtRdmaDbInfo_t dbInfo;
    dbInfo.value = rdmaDbSendTask->taskDbInfo.value;
    RtStarsRdmaSinkSqe1 &sqe1 = command->rdmaSinkSqe1;
    const uint16_t currentStreamId = static_cast<uint16_t>(stream->Id_());
    uint16_t * const execTimesSvm = stream->GetExecutedTimesSvm();
    const uint64_t svmAddr = RtPtrToValue<uint16_t *>(execTimesSvm);

    (void)memset_s(&sqe1, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    ConstructRdmaSink1Instr(static_cast<uint32_t>(dbInfo.cmd.sqProducerIdx),
        sqDepthBitWidth, svmAddr, sqe1);
    sqe1.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe1.csc = 1U;
    sqe1.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe1.sqeHeader.l1_lock = 1U;
    sqe1.sqeHeader.l1_unlock = 0U;
    sqe1.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe1.sqeHeader.block_dim = 0U;  // block_dim is not used by C-Conds
    sqe1.sqeHeader.rt_stream_id = currentStreamId;
    sqe1.sqeHeader.task_id = taskInfo->id;
    sqe1.condsSubType = CONDS_SUB_TYPE_RDMA_1;
    PrintSqe(command, "RdmaDbSendSink1");
}

static void ConstructSqeSinkModeForRdmaDb2SendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    RdmaDbSendTaskInfo *rdmaDbSendTask = &(taskInfo->u.rdmaDbSendTask);
    Stream * const stream = taskInfo->stream;
    rtRdmaDbInfo_t dbInfo;
    dbInfo.value = rdmaDbSendTask->taskDbInfo.value;
    const uint16_t currentStreamId = static_cast<uint16_t>(stream->Id_());

    // Construct sqe2
    RtStarsRdmaSinkSqe2 &sqe2 = command->rdmaSinkSqe2;
    const uint64_t dbAddr = GetRoceDbAddrForRdmaDbSendTask(taskInfo);
    if (dbAddr == 0ULL) {
        sqe2.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }
    dbInfo.cmd.sqProducerIdx = 0U;

    (void)memset_s(&sqe2, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    ConstructRdmaSink2Instr(dbAddr, dbInfo.value, sqe2);
    sqe2.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe2.csc = 0U;
    sqe2.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe2.sqeHeader.l1_lock = 0U;
    sqe2.sqeHeader.l1_unlock = 1U;
    sqe2.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe2.sqeHeader.block_dim = 0U;  // block_dim is not used by C-Conds
    sqe2.sqeHeader.rt_stream_id = currentStreamId;
    sqe2.sqeHeader.task_id = taskInfo->id;
    sqe2.condsSubType = CONDS_SUB_TYPE_RDMA_2;

    PrintSqe(command, "RdmaDbSendSink2");
}

static void ConstructSqeNoSinkModeForRdmaDbSendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    Stream * const stream = taskInfo->stream;
    RtStarsWriteValueSqe * const sqe = &(command->writeValueSqe);

    (void)memset_s(sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->va = 0U;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;

    sqe->sub_type = RT_STARS_WRITE_VALUE_SUB_TYPE_RDMA_DB_SEND;

    const uint64_t dbVal = taskInfo->u.rdmaDbSendTask.taskDbInfo.value; // GetRoceDbVal();
    const uint64_t dbAddr = GetRoceDbAddrForRdmaDbSendTask(taskInfo);   // GetRoceDbAddr();
    if (dbAddr == 0ULL) {
        sqe->header.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }
    sqe->write_value_part0 = static_cast<uint32_t>(dbVal & MASK_32_BIT);
    sqe->write_value_part1 = static_cast<uint32_t>(dbVal >> UINT32_BIT_NUM);
    sqe->write_addr_low = static_cast<uint32_t>(dbAddr & MASK_32_BIT);
    sqe->write_addr_high = static_cast<uint32_t>((dbAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintSqe(command, "RdmaDbSendNoSink");
    RT_LOG(RT_LOG_INFO, "RdmaDbSendTask no-sink device_id=%d, stream_id=%d, die_id=%u, task_id=%hu, sqProducerIdx=%u,"
        " dbAddr=%#" PRIx64" dbVal:%#" PRIx64,
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->u.rdmaDbSendTask.taskDbIndex.dbIndexStars.dieId,
        taskInfo->id, taskInfo->u.rdmaDbSendTask.taskDbInfo.cmd.sqProducerIdx, dbAddr, dbVal);
}

void ConstructSqeForRdmaDbSendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    RdmaDbSendTaskInfo *rdmaDbSendTask = &(taskInfo->u.rdmaDbSendTask);
    if (taskInfo->bindFlag != 0U) {
        if (rdmaDbSendTask->taskSeq == 1U) {
            return ConstructSqeSinkModeForRdmaDb1SendTask(taskInfo, command);
        } else if (rdmaDbSendTask->taskSeq == 2U) {
            return ConstructSqeSinkModeForRdmaDb2SendTask(taskInfo, command);
        } else {
            RT_LOG(RT_LOG_ERROR, "model taskSeq must be [1, 2], but taskSeq=%u", rdmaDbSendTask->taskSeq);
        }
    }
    return ConstructSqeNoSinkModeForRdmaDbSendTask(taskInfo, command);
}

#endif

static bool RdmaTaskRegister()
{
    TaskFuncSingle rdmaSendFuncs = {
        .toCommandFunc = &ToCommandBodyForRdmaSendTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle rdmaDbSendFuncs = {
        .toCommandFunc = &ToCommandBodyForRdmaDbSendTask,
        .toSqeFunc = &ConstructSqeForRdmaDbSendTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto &chips = GetV100Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_RDMA_SEND, rdmaSendFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_RDMA_DB_SEND, rdmaDbSendFuncs);
    }

    return true;
}

static bool g_rdmaTaskRegister = RdmaTaskRegister();

}
}
