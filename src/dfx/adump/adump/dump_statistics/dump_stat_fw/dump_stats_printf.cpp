/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_stats_printf.h"

namespace kfc_dump_stats {
void KfcDumpPrintf::PrintKfcDumpInitParam(KfcDumpOpInitParam* kfcInitParam)
{
    KfcDumpStreamInfo* streamInfo = &kfcInitParam->streamInfo;
    KfcDumpWorkSpace* workSpace = &kfcInitParam->kfcWorkSpace;
    KfcDumpOpConfig* opConfig = &kfcInitParam->config;
    IDE_LOGI(
        "[KfcDumpOpInitParam][KfcDumpStreamInfo] streamId[%u] sqId[%u] cqId[%u] logicCqid[%u] deviceId[%u]",
        streamInfo->streamIds, streamInfo->sqIds, streamInfo->cqIds, streamInfo->logicCqIds, streamInfo->deviceId);
    IDE_LOGI(
        "[KfcDumpOpInitParam][KfcDumpWorkSpace] msgQ[0x%lx] msgQSize[%lu] output[0x%lx] outputSize[%lu] "
        "workspace[0x%lx] workspaceSize[%lu] stackPhyBase32K[0x%lx] stackPhyBase32KSize[%lu]",
        workSpace->msgQ, workSpace->msgQSize, workSpace->output, workSpace->outputSize, workSpace->workspace,
        workSpace->workspaceSize, workSpace->stackPhyBase32k, workSpace->stackPhyBase32kSize);
    IDE_LOGI(
        "[KfcDumpOpInitParam][KfcDumpOpConfig] aiCoreNum[%lu] vectorCoreNum[%lu] "
        "ubSize[%lu] dumpStatPcAddr[0x%lx] statsType[%lu] chipType[%lu]",
        opConfig->aiCoreNum, opConfig->vectorCoreNum, opConfig->ubSize, opConfig->dumpStatPcAddr, opConfig->statsType,
        opConfig->chipType);
}

void KfcDumpPrintf::PrintKfcDumpStreamCtx(KfcDumpStreamCtx* streamCtx)
{
    IDE_LOGI(
        "[KfcDumpStreamCtx] devId[%u] chipType[%u] sqHead[%u] sqTail[%u] sqDepth[%u] sqBaseAddr[%p]", streamCtx->devId,
        streamCtx->chipType, streamCtx->sqHead, streamCtx->sqTail, streamCtx->sqDepth, streamCtx->sqBaseAddr);
}

void KfcDumpPrintf::PrintSqeV1(uint8_t* sqeIn)
{
    rtFftsPlusKernelSqe_t* sqe = (rtFftsPlusKernelSqe_t*)sqeIn;
    IDE_LOGI(
        "Header:type[%u] l1_lock[%u] l1_unlock[%u] ie[%u] pre_p[%u]", sqe->header.type, sqe->header.l1_lock,
        sqe->header.l1_unlock, sqe->header.ie, sqe->header.pre_p);
    IDE_LOGI(
        "post_p [%u] wr_cqe[%u] reserved[%u] block_dim[%u] rt_stream_id[%u] task_id[%u]", sqe->header.post_p,
        sqe->header.wr_cqe, sqe->header.reserved, sqe->header.block_dim, sqe->header.rt_stream_id, sqe->header.task_id);
    IDE_LOGI(
        "SQE:ffts_type[%u] wrr_ratio[%u] sqe_index[%u] kernel_credit[%u]", sqe->ffts_type, sqe->wrr_ratio,
        sqe->sqe_index, sqe->kernel_credit);
    IDE_LOGI(
        "stack_phy_base_high[0x%x] res4[%u] pmg[%u] ns[%u]", sqe->stack_phy_base_high, sqe->res4, sqe->pmg, sqe->ns);
    IDE_LOGI("part_id[%u] res5[%u] qos[%u] res6[%u]", sqe->part_id, sqe->res5, sqe->qos, sqe->res6);
    IDE_LOGI(
        "pc_addr_low[0x%x] pc_addr_high[0x%x] res7[%u] param_addr_low[0x%x] param_addr_high[0x%x]", sqe->pc_addr_low,
        sqe->pc_addr_high, sqe->res7, sqe->param_addr_low, sqe->param_addr_high);
}

void KfcDumpPrintf::PrintSqeV2(uint8_t* sqeIn)
{
    auto sqe = (hwts_kernel_sqe_t*)sqeIn;
    IDE_LOGI(
        "type[%u] graph_lock[%u] graph_unlock[%u] ie[%u] pre_p[%u]", sqe->type, sqe->graph_lock, sqe->graph_unlock,
        sqe->ie, sqe->pre_p);
    IDE_LOGI(
        "post_p[%u] wr_cqe[%u] rd_cond[%u] reserved[%u] l2_lock[%u]", sqe->post_p, sqe->wr_cqe, sqe->rd_cond,
        sqe->reserved, sqe->l2_lock);
    IDE_LOGI(
        "l2_unlock[%u] block_dim[%u] rt_stream_id[%u] task_id[%u] pc_addr_low[0x%x] pc_addr_high[0x%x]", sqe->l2_unlock,
        sqe->block_dim, sqe->rt_stream_id, sqe->task_id, sqe->pc_addr_low, sqe->pc_addr_high);
    IDE_LOGI(
        "kernel_credit[%u] res0[%u] prefetch_cnt[%u] param_addr_low[0x%x] param_addr_high[0x%x]", sqe->kernel_credit,
        sqe->res0, sqe->prefetch_cnt, sqe->param_addr_low, sqe->param_addr_high);
    IDE_LOGI(
        "l2_in_main[%u] res1[%u] literal_addr_low[0x%x] literal_addr_high[0x%x] res2[%u]", sqe->l2_in_main, sqe->res1,
        sqe->literal_addr_low, sqe->literal_addr_high, sqe->res2);
    IDE_LOGI(
        "literal_base_ub[%u] res3[%u] sta_mode[%u] literal_buff_len[%u] res4[%u]", sqe->literal_base_ub, sqe->res3,
        sqe->sta_mode, sqe->literal_buff_len, sqe->res4);
    IDE_LOGI(
        "p2_l2ctrl_low[0x%x] p_l2ctrl_high[0x%x] res5[%u] res6[%u] res7[%u]", sqe->p_l2ctrl_low, sqe->p_l2ctrl_high,
        sqe->res5, sqe->res6, sqe->res7);
}

void KfcDumpPrintf::PrintSqeCloudV4(uint8_t* sqeIn)
{
    rtDavidStarsAicAivSqeCloudV4* sqe = reinterpret_cast<rtDavidStarsAicAivSqeCloudV4*>(sqeIn);
    IDE_LOGI(
        "Header: type[%u] lock[%u] unlock[%u] ie[%u] preP[%u] postP[%u] wrCqe[%u]", sqe->header.type, sqe->header.lock,
        sqe->header.unlock, sqe->header.ie, sqe->header.preP, sqe->header.postP, sqe->header.wrCqe);
    IDE_LOGI(
        "ptrMode[%u] rttMode[%u] headUpdate[%u] blockDim[%u] rtStreamId[%u] taskId[%u]", sqe->header.ptrMode,
        sqe->header.rttMode, sqe->header.headUpdate, sqe->header.blockDim, sqe->header.rtStreamId, sqe->header.taskId);
    IDE_LOGI(
        "SQE: groupDim[%u] groupBlockDim[%u] featureFlag[%u] kernelCredit[%u]", sqe->groupDim, sqe->groupBlockDim,
        sqe->featureFlag, sqe->kernelCredit);
    IDE_LOGI("dieFriendly[%u] mix[%u] loose[%u] sqeLength[%u]", sqe->dieFriendly, sqe->mix, sqe->loose, sqe->sqeLength);
    IDE_LOGI(
        "stackPhyBaseLow[%x] stackPhyBaseHigh[%x] aicPmg[%u] aicNs[%u] aicPartId[%u]", sqe->stackPhyBaseLow,
        sqe->stackPhyBaseHigh, sqe->aicPmg, sqe->aicNs, sqe->aicPartId);
    IDE_LOGI(
        "piMix[%u] aicQos[%u] aicWrrRd[%u] aicWrrWr[%u] aicIcachePrefetchCnt[%u] aivIcachePrefetchCnt[%u]", sqe->piMix,
        sqe->aicQos, sqe->aicWrrRd, sqe->aicWrrWr, sqe->aicIcachePrefetchCnt, sqe->aivIcachePrefetchCnt);
    IDE_LOGI(
        "aivPmg[%u] aivNs[%u] aivPartId[%u] aivQos[%u] aivWrrRd[%u] aivWrrWr[%u] schem[%u] ratio[%u]", sqe->tail.aivPmg,
        sqe->tail.aivNs, sqe->tail.aivPartId, sqe->tail.aivQos, sqe->tail.aivWrrRd, sqe->tail.aivWrrWr, sqe->tail.schem,
        sqe->tail.ratio);
    IDE_LOGI(
        "aicStartPcLow[%u] aivStartPcLow[%u] aicStartPcHigh[%u] aivStartPcHigh[%u] aivSimtDcuSmSize[%u]",
        sqe->tail.aicStartPcLow, sqe->tail.aivStartPcLow, sqe->tail.aicStartPcHigh, sqe->tail.aivStartPcHigh,
        sqe->tail.aivSimtDcuSmSize);
    IDE_LOGI(
        "aicTaskParamPtrLow[%x] aicTaskParamPtrHigh[%x] aivTaskParamPtrLow[%x] aivTaskParamPtrHigh[%x]",
        sqe->tail.aicTaskParamPtrLow, sqe->tail.aicTaskParamPtrHigh, sqe->tail.aivTaskParamPtrLow,
        sqe->tail.aivTaskParamPtrHigh);
}

void KfcDumpPrintf::PrintSqeCloudV5(uint8_t* sqeIn)
{
    rtDavidStarsAicAivSqeCloudV5* sqe = reinterpret_cast<rtDavidStarsAicAivSqeCloudV5*>(sqeIn);
    IDE_LOGI(
        "Header: type[%u] lock[%u] unlock[%u] ie[%u] preP[%u] postP[%u] wrCqe[%u]", sqe->header.type, sqe->header.lock,
        sqe->header.unlock, sqe->header.ie, sqe->header.preP, sqe->header.postP, sqe->header.wrCqe);
    IDE_LOGI(
        "ptrMode[%u] rttMode[%u] headUpdate[%u] blockDim[%u] rtStreamId[%u] taskId[%u]", sqe->header.ptrMode,
        sqe->header.rttMode, sqe->header.headUpdate, sqe->header.blockDim, sqe->header.rtStreamId, sqe->header.taskId);
    IDE_LOGI(
        "SQE: groupDim[%u] groupBlockdim[%u] featureFlag[%u] kernelCredit[%u] "
        "dieFriendly[%u] mix[%u] loose[%u] ost[%u] sqeLength[%u]",
        sqe->groupDim, sqe->groupBlockdim, sqe->featureFlag, sqe->kernelCredit, sqe->dieFriendly, sqe->mix, sqe->loose,
        sqe->ost, sqe->sqeLength);
    IDE_LOGI(
        "aicMtePortArOstd[%u] aicMtePortAwOstd[%u] aivMtePortArOstd[%u] aivMtePortAwOstd[%u]", sqe->aicMtePortArOstd,
        sqe->aicMtePortAwOstd, sqe->aivMtePortArOstd, sqe->aivMtePortAwOstd);
    IDE_LOGI(
        "aivDcachePrefetchCnt[%u] aicDcachePrefetchCnt[%u] aivIcachePrefetchCnt[%u] "
        "aicIcachePrefetchCnt[%u]",
        sqe->aivDcachePrefetchCnt, sqe->aicDcachePrefetchCnt, sqe->aivIcachePrefetchCnt, sqe->aicIcachePrefetchCnt);
    IDE_LOGI(
        "aicPmg[%u] aicNs[%u] aicPartId[%u] piMix[%u] aicQos[%u] aicWrrRd[%u] aicWrrWr[%u] "
        "getNxtTaskMode[%u] aicPreAllocateDisable[%u] aivPreAllocateDisable[%u]",
        sqe->aicPmg, sqe->aicNs, sqe->aicPartId, sqe->piMix, sqe->aicQos, sqe->aicWrrRd, sqe->aicWrrWr,
        sqe->getNxtTaskMode, sqe->aicPreAllocateDisable, sqe->aivPreAllocateDisable);
    IDE_LOGI(
        "aivPmg[%u] aivNs[%u] aivPartId[%u] aivQos[%u] aivWrrRd[%u] aivWrrWr[%u] schem[%u] ratio[%u]", sqe->tail.aivPmg,
        sqe->tail.aivNs, sqe->tail.aivPartId, sqe->tail.aivQos, sqe->tail.aivWrrRd, sqe->tail.aivWrrWr, sqe->tail.schem,
        sqe->tail.ratio);
    IDE_LOGI(
        "aicStartPcLow[0x%x] aivStartPcLow[0x%x] aicStartPcHigh[0x%x] aivStartPcHigh[0x%x] "
        "aivSimtDcuSmSize[%u]",
        sqe->tail.aicStartPcLow, sqe->tail.aivStartPcLow, sqe->tail.aicStartPcHigh, sqe->tail.aivStartPcHigh,
        sqe->tail.aivSimtDcuSmSize);
    IDE_LOGI(
        "aicTaskParamPtrLow[0x%x] aicTaskParamPtrHigh[0x%x] aivTaskParamPtrLow[0x%x] aivTaskParamPtrHigh[0x%x]",
        sqe->tail.aicTaskParamPtrLow, sqe->tail.aicTaskParamPtrHigh, sqe->tail.aivTaskParamPtrLow,
        sqe->tail.aivTaskParamPtrHigh);
}

void KfcDumpPrintf::PrintMsg(KfcDumpStatsMsg& msg)
{
    IDE_LOGI(
        "[KfcDumpStatsMsg] msgType[%u] dataType[%u] dataCount[%lu] dataAddr[0x%lx] dumpStatClass[%lu] "
        "outputAddr[0x%lx] outputAddrSize[%lu] valid[%u] result[%u]",
        msg.msgType, msg.dataType, msg.dataCount, msg.dataAddr, msg.dumpStatClass, msg.outputAddr, msg.outputAddrSize,
        msg.valid, msg.result);
}

void KfcDumpPrintf::PrintDumpContext(KfcDumpContext* dumpContext)
{
    IDE_LOGI(
        "[KfcDumpContext] msgQ[0x%lx] workspace[0x%lx] workspaceSize[%lu] workspaceSizeAddr[0x%lx] "
        "aiCoreNum[%lu] aiCoreNumAddr[0x%lx] ubSize[%lu] ubSizeAddr[0x%lx] syncSpace[0x%lx]",
        dumpContext->msgQ, dumpContext->workspace, dumpContext->workspaceSize, dumpContext->workspaceSizeAddr,
        dumpContext->aiCoreNum, dumpContext->aiCoreNumAddr, dumpContext->ubSize, dumpContext->ubSizeAddr,
        dumpContext->syncSpace);
}
} // namespace kfc_dump_stats
