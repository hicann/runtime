/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_stats_task.h"

namespace kfc_dump_stats {
void AddOneStatDumpTaskV1(uint8_t* sqeIn, KfcDumpOpInitParam* dumpParam, KfcDumpContext* dumpContext)
{
    rtFftsPlusKernelSqe_t sqe = {};
    sqe.header.ie = 0;
    sqe.header.type = 0;
    sqe.header.pre_p = 0;
    sqe.header.post_p = 0;
    sqe.header.task_id = 0;
    sqe.ffts_type = static_cast<uint16_t>(KfcDumpTaskType::FFTS_TASK);
    sqe.header.wr_cqe = 0;
    sqe.header.block_dim = dumpContext->aiCoreNum;
    sqe.header.rt_stream_id = dumpParam->streamInfo.streamIds;
    sqe.res1 = 0;
    sqe.wrr_ratio = 1;
    sqe.res2 = 0;
    sqe.sqe_index = 0;
    sqe.kernel_credit = KERNEL_TIMEOUT_CONSTANT;
    sqe.schem = 1;
    sqe.res3 = 0;
    sqe.icache_prefetch_cnt = 0;
    sqe.stack_phy_base_low = static_cast<uint32_t>(dumpParam->kfcWorkSpace.stackPhyBase32k & LOW_ADDR_MASK);
    sqe.stack_phy_base_high = static_cast<uint32_t>(dumpParam->kfcWorkSpace.stackPhyBase32k >> TS_UINT32_BIT_NUM);
    sqe.res4 = 0;
    sqe.pmg = 0;
    sqe.ns = 1;
    sqe.part_id = 0;
    sqe.res5 = 0;
    sqe.qos = 0;
    sqe.res6 = 0;
    uint64_t pcAddr = dumpParam->config.dumpStatPcAddr;
    sqe.pc_addr_low = static_cast<uint32_t>(pcAddr & LOW_ADDR_MASK);
    sqe.pc_addr_high = static_cast<uint16_t>((pcAddr & HIGH_ADDR_MASK) >> TS_UINT32_BIT_NUM);
    uint64_t paramAddr = reinterpret_cast<uint64_t>(dumpContext);
    sqe.param_addr_low = static_cast<uint32_t>(paramAddr & LOW_ADDR_MASK);
    sqe.param_addr_high = static_cast<uint32_t>(paramAddr >> TS_UINT32_BIT_NUM);
    (void)memcpy_s(sqeIn, AC_SQE_SIZE, &sqe, AC_SQE_SIZE);
}
void AddOneStatDumpTaskV2(uint8_t* sqeIn, KfcDumpOpInitParam* dumpParam, KfcDumpContext* dumpContext)
{
    hwts_kernel_sqe_t sqe = {};
    sqe.type = static_cast<uint16_t>(KfcDumpTaskType::AIVECTOR_TASK);
    sqe.graph_lock = 0;
    sqe.graph_unlock = 0;
    sqe.ie = 0;
    sqe.pre_p = 0;
    sqe.post_p = 0;
    sqe.wr_cqe = 0;
    sqe.rd_cond = 0;
    sqe.l2_lock = 0;
    sqe.l2_unlock = 0;
    sqe.block_dim = dumpContext->aiCoreNum;
    sqe.rt_stream_id = static_cast<uint16_t>(dumpParam->streamInfo.streamIds);
    sqe.task_id = 0;
    uint64_t pcAddr = dumpParam->config.dumpStatPcAddr;
    sqe.pc_addr_low = static_cast<uint32_t>(pcAddr & LOW_ADDR_MASK);
    sqe.pc_addr_high = static_cast<uint16_t>((pcAddr & HIGH_ADDR_MASK) >> TS_UINT32_BIT_NUM);
    sqe.kernel_credit = KERNEL_TIMEOUT_CONSTANT;
    AddOneStatDumpTaskV2Part2(sqe, dumpContext);
    (void)memcpy_s(sqeIn, AC_SQE_SIZE, &sqe, AC_SQE_SIZE);
}
void AddOneStatDumpTaskV2Part2(hwts_kernel_sqe_t& sqe, KfcDumpContext* dumpContext)
{
    sqe.res0 = 0;
    sqe.prefetch_cnt = 1;
    auto paramAddr = reinterpret_cast<uint64_t>(dumpContext);
    sqe.param_addr_low = static_cast<uint32_t>(paramAddr & LOW_ADDR_MASK);
    sqe.param_addr_high = static_cast<uint32_t>(paramAddr >> TS_UINT32_BIT_NUM);
    sqe.l2_in_main = MAX_L2_MAIN_CACHE;
    sqe.res1 = 0;
    sqe.literal_addr_low = 0;
    sqe.literal_addr_high = 0;
    sqe.res2 = 0;
    sqe.literal_base_ub = 0;
    sqe.literal_buff_len = 0;
    sqe.sta_mode = 0;
    sqe.res3 = 0;
    sqe.res4 = 0;
    sqe.res5 = 0;
    sqe.p_l2ctrl_low = 0;
    sqe.p_l2ctrl_high = 0;
    sqe.res6 = 0;
    sqe.res7 = 0;
}

void AddStatDumpTaskCloudV4(uint8_t* sqeIn, KfcDumpOpInitParam* dumpParam, KfcDumpContext* dumpContext)
{
    rtDavidStarsAicAivSqeCloudV4* sqe = reinterpret_cast<rtDavidStarsAicAivSqeCloudV4*>(sqeIn);
    sqe->header.type = 1U; // AIV
    sqe->header.blockDim = dumpContext->aiCoreNum;
    sqe->header.rtStreamId = dumpParam->streamInfo.streamIds;
    // blockDim小于2，groupDim指定为1，否则groupBlockdim为0不合法
    sqe->groupDim = (sqe->header.blockDim < GROUP_DIM_DEFAULT) ? 1U : GROUP_DIM_DEFAULT;
    sqe->groupBlockDim = sqe->header.blockDim / sqe->groupDim;
    sqe->kernelCredit = KERNEL_TIMEOUT_CONSTANT; // max 254
    sqe->stackPhyBaseLow = static_cast<uint32_t>(dumpParam->kfcWorkSpace.stackPhyBase32k & LOW_ADDR_MASK);
    sqe->stackPhyBaseHigh = static_cast<uint32_t>(dumpParam->kfcWorkSpace.stackPhyBase32k >> TS_UINT32_BIT_NUM);
    sqe->tail.aivNs = 1U;
    sqe->tail.aivWrrRd = 2U;
    sqe->tail.aivWrrWr = 2U;
    sqe->tail.ratio = 1U;
    sqe->tail.schem = 1U;
    uint64_t pcAddr = dumpParam->config.dumpStatPcAddr;
    sqe->tail.aivStartPcLow = static_cast<uint32_t>(pcAddr & LOW_ADDR_MASK);
    sqe->tail.aivStartPcHigh = static_cast<uint16_t>((pcAddr & HIGH_ADDR_MASK) >> TS_UINT32_BIT_NUM);
    uint64_t paramAddr = reinterpret_cast<uint64_t>(dumpContext);
    sqe->tail.aivTaskParamPtrLow = static_cast<uint32_t>(paramAddr & LOW_ADDR_MASK);
    sqe->tail.aivTaskParamPtrHigh = static_cast<uint32_t>(paramAddr >> TS_UINT32_BIT_NUM);
}

void AddStatDumpTaskCloudV5(uint8_t* sqeIn, KfcDumpOpInitParam* dumpParam, KfcDumpContext* dumpContext)
{
    rtDavidStarsAicAivSqeCloudV5* sqe = reinterpret_cast<rtDavidStarsAicAivSqeCloudV5*>(sqeIn);

    sqe->header.type = 1U; // RT_DAVID_SQE_TYPE_AIV
    sqe->header.blockDim = dumpContext->aiCoreNum;
    sqe->header.rtStreamId = dumpParam->streamInfo.streamIds;
    // blockDim小于2，groupDim指定为1，否则groupBlockdim为0不合法
    sqe->groupDim = (sqe->header.blockDim < GROUP_DIM_DEFAULT) ? 1U : GROUP_DIM_DEFAULT;
    sqe->groupBlockdim = sqe->header.blockDim / sqe->groupDim;
    sqe->kernelCredit = KERNEL_TIMEOUT_CONSTANT; // max 254
    sqe->aicPreAllocateDisable = 1U;
    sqe->aivPreAllocateDisable = 0U;
    sqe->tail.aivNs = 1U;
    sqe->tail.aivWrrRd = 2U; // RT_DAVID_AIV_WRR_RD
    sqe->tail.aivWrrWr = 2U; // RT_DAVID_AIV_WRR_WR
    sqe->tail.schem = 1U;    // RT_SCHEM_MODE_NORMAL
    sqe->tail.ratio = 1U;    // only ratio is 1

    uint64_t pcAddr = dumpParam->config.dumpStatPcAddr;
    sqe->tail.aivStartPcLow = static_cast<uint32_t>(pcAddr & LOW_ADDR_MASK);
    sqe->tail.aivStartPcHigh = static_cast<uint16_t>((pcAddr & HIGH_ADDR_MASK) >> TS_UINT32_BIT_NUM);
    uint64_t paramAddr = reinterpret_cast<uint64_t>(dumpContext);
    sqe->tail.aivTaskParamPtrLow = static_cast<uint32_t>(paramAddr & LOW_ADDR_MASK);
    sqe->tail.aivTaskParamPtrHigh = static_cast<uint32_t>(paramAddr >> TS_UINT32_BIT_NUM);
}

KfcDumpResult KfcDumpTaskDispatcher::QuerySqBaseAddr(uint32_t devId, uint32_t sqId, uint64_t& outVal)
{
    halSqCqQueryInfo queryInfo = {};
    queryInfo.tsId = 0;
    queryInfo.sqId = sqId;
    queryInfo.cqId = 0;
    queryInfo.type = DRV_NORMAL_TYPE;
    queryInfo.prop = DRV_SQCQ_PROP_SQ_BASE;
    uint32_t ret = halSqCqQuery(devId, &queryInfo);
    if (ret != 0) {
        IDE_LOGE("Failed to query sq base address, ret[%u] sqId[%u]", ret, queryInfo.sqId);
        return KFC_DUMP_E_DRIVE;
    }
    outVal = ((static_cast<uint64_t>(queryInfo.value[1])) << TS_UINT32_BIT_NUM) | queryInfo.value[0];
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpTaskDispatcher::QuerySqStatusByType(
    int32_t devId, uint32_t sqId, drvSqCqPropType_t type, uint32_t& outVal)
{
    halSqCqQueryInfo queryInfo = {};
    queryInfo.tsId = 0;
    queryInfo.sqId = sqId;
    queryInfo.cqId = 0;
    queryInfo.type = DRV_NORMAL_TYPE;
    queryInfo.prop = type;
    uint32_t ret = halSqCqQuery(devId, &queryInfo);
    if (ret != 0) {
        IDE_LOGE("Failed to query sq property[%d], ret[%u] sqId[%u]", type, ret, queryInfo.sqId);
        return KFC_DUMP_E_DRIVE;
    }
    outVal = queryInfo.value[0];
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpTaskDispatcher::ConfigSqStatusByType(
    int32_t devId, uint32_t sqId, drvSqCqPropType_t type, uint32_t value)
{
    halSqCqConfigInfo configInfo = {};
    configInfo.tsId = 0;
    configInfo.sqId = sqId;
    configInfo.cqId = 0;
    configInfo.type = DRV_NORMAL_TYPE;
    configInfo.prop = type;
    configInfo.value[0] = value;
    uint32_t ret = halSqCqConfig(devId, &configInfo);
    if (ret != 0) {
        IDE_LOGE("Failed to config sq property[%d] to value[%u], ret[%u] sqId[%u]", type, value, ret, configInfo.sqId);
        return KFC_DUMP_E_DRIVE;
    }
    return KFC_DUMP_SUCCESS;
}

static inline uint32_t GetUsedSqSlotNum(uint32_t head, uint32_t tail, uint32_t sqDepth)
{
    return (tail < head ? sqDepth : 0U) + tail - head;
}

static inline bool IsSqFull(uint32_t head, uint32_t tail, uint32_t sqDepth)
{
    return GetUsedSqSlotNum(head, tail, sqDepth) + 1U >= sqDepth;
}

KfcDumpResult KfcDumpTaskDispatcher::LaunchTask(uint8_t* sqeAddr, KfcDumpStreamCtx* kfcDumpStreamInfo)
{
    uint32_t& head = kfcDumpStreamInfo->sqHead;
    uint32_t& tail = kfcDumpStreamInfo->sqTail;
    const uint32_t sqDepth = kfcDumpStreamInfo->sqDepth;
    uint32_t newTail = (tail + 1) % sqDepth;
    IDE_LOGI(
        "Launch kfc dump statistics operator: sqId[%u] sqHead[%u] sqTail[%u] newSqTail[%u]", kfcDumpStreamInfo->sqId,
        head, tail, newTail);
    uint64_t startLaunchTime = GetCurCpuTimestamp();
    while (IsSqFull(head, tail, sqDepth)) {
        DUMP_STATS_CHK_RET(
            QuerySqStatusByType(kfcDumpStreamInfo->devId, kfcDumpStreamInfo->sqId, DRV_SQCQ_PROP_SQ_HEAD, head));

        if (CheckTimeOut(startLaunchTime) != KFC_DUMP_SUCCESS) {
            IDE_LOGE(
                "Wait for free sq slot timeout, sqId[%u] sqHead[%u] sqTail[%u] sqDepth[%u]", kfcDumpStreamInfo->sqId,
                head, tail, sqDepth);
            return KFC_DUMP_E_TIMEOUT;
        }
    }
    errno_t ret = memcpy_s(
        reinterpret_cast<uint8_t*>(kfcDumpStreamInfo->sqBaseAddr) + tail * AC_SQE_SIZE, AC_SQE_SIZE, sqeAddr,
        AC_SQE_SIZE);
    if (ret != EOK) {
        IDE_LOGE("Failed to write sqe into sq, sqTail[%u] ret[%d]", tail, ret);
        return KFC_DUMP_E_MEMORY;
    }
    DUMP_STATS_CHK_RET(
        ConfigSqStatusByType(kfcDumpStreamInfo->devId, kfcDumpStreamInfo->sqId, DRV_SQCQ_PROP_SQ_TAIL, newTail));
    tail = newTail;
    return KFC_DUMP_SUCCESS;
}
} // namespace kfc_dump_stats
