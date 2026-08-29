/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <atomic>

#include "dump_stats_process.h"
#include "adx_log.h"

namespace kfc_dump_stats {
static std::atomic<bool> g_isInitialized(false);
static PrintSqeInfo g_printSqeInfo = nullptr;
static AddOneStatDumpTask g_addOneStatDumpTask = nullptr;
uint32_t g_tensorCount = 0;
KfcDumpOpInitParam g_dumpParam;
KfcDumpContext g_dumpContext;
KfcDumpStreamCtx g_kfcDumpStreamInfo;

bool KfcDumpProcess::GetStatsOpInitStatus() { return g_isInitialized; }

void KfcDumpProcess::ResetForTest()
{
    g_isInitialized = false;
    g_printSqeInfo = nullptr;
    g_addOneStatDumpTask = nullptr;
    g_tensorCount = 0;
    g_dumpParam = {};
    g_dumpContext = {};
    g_kfcDumpStreamInfo = {};
}

KfcDumpResult InitSqCqFunction()
{
    if (g_kfcDumpStreamInfo.chipType == CHIP_DC) {
        g_addOneStatDumpTask = AddOneStatDumpTaskV2;
        g_printSqeInfo = KfcDumpPrintf::PrintSqeV2;
    } else if (g_kfcDumpStreamInfo.chipType == CHIP_CLOUD_V2) {
        g_addOneStatDumpTask = AddOneStatDumpTaskV1;
        g_printSqeInfo = KfcDumpPrintf::PrintSqeV1;
    } else if (g_kfcDumpStreamInfo.chipType == CHIP_CLOUD_V4) {
        g_addOneStatDumpTask = AddStatDumpTaskCloudV4;
        g_printSqeInfo = KfcDumpPrintf::PrintSqeCloudV4;
    } else if (g_kfcDumpStreamInfo.chipType == CHIP_CLOUD_V5) {
        g_addOneStatDumpTask = AddStatDumpTaskCloudV5;
        g_printSqeInfo = KfcDumpPrintf::PrintSqeCloudV5;
    } else {
        IDE_LOGE(
            "Kfc dump does not support chip type[%u], only chip type[%d,%d,%d,%d] are supported",
            g_kfcDumpStreamInfo.chipType, CHIP_DC, CHIP_CLOUD_V2, CHIP_CLOUD_V4, CHIP_CLOUD_V5);
        return KFC_DUMP_E_NOT_SUPPORT;
    }
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpProcess::InitKfcDumpInfo(KfcDumpOpInitParam* dumpParam)
{
    KfcDumpPrintf::PrintKfcDumpInitParam(dumpParam);
    g_isInitialized = false;
    IDE_CTRL_VALUE_FAILED(
        dumpParam->kfcWorkSpace.outputSize >= STAT_LEN, return KFC_DUMP_E_PARA,
        "Output buffer size[%lu] is less than the required statistics length[%zu]", dumpParam->kfcWorkSpace.outputSize,
        STAT_LEN);
    // 不能用 constexpr：vectorCoreNum 是运行期入参。msgQ 布局为
    // msgBody + syncSpace(每核 SYNC_SPACE_BYTES_PER_CORE) + 尾部 KfcDumpContext，故下限随核数变化。
    const uint64_t minMsgQSize =
        MSG_BODY_SIZE + dumpParam->config.vectorCoreNum * SYNC_SPACE_BYTES_PER_CORE + sizeof(KfcDumpContext);
    IDE_CTRL_VALUE_FAILED(
        dumpParam->kfcWorkSpace.msgQSize >= minMsgQSize, return KFC_DUMP_E_PARA,
        "Msg queue size[%lu] is less than the required minimum[%lu]", dumpParam->kfcWorkSpace.msgQSize, minMsgQSize);
    IDE_CTRL_VALUE_FAILED(
        dumpParam->config.vectorCoreNum != 0U && dumpParam->config.ubSize != 0U, return KFC_DUMP_E_PARA,
        "Invalid platform config, vectorCoreNum[%lu] and ubSize[%lu] must be positive", dumpParam->config.vectorCoreNum,
        dumpParam->config.ubSize);

    g_dumpParam = *dumpParam;
    g_kfcDumpStreamInfo.chipType = g_dumpParam.config.chipType;
    g_kfcDumpStreamInfo.streamId = g_dumpParam.streamInfo.streamIds;
    g_kfcDumpStreamInfo.sqId = g_dumpParam.streamInfo.sqIds;
    g_kfcDumpStreamInfo.cqId = g_dumpParam.streamInfo.cqIds;
    g_kfcDumpStreamInfo.logicCqId = g_dumpParam.streamInfo.logicCqIds;
    IDE_CTRL_VALUE_FAILED(
        drvGetLocalDevIDByHostDevID != nullptr, return KFC_DUMP_E_NOT_SUPPORT,
        "drvGetLocalDevIDByHostDevID is unresolved, driver does not support device id conversion");

    drvError_t drvRet = drvGetLocalDevIDByHostDevID(g_dumpParam.streamInfo.deviceId, &(g_kfcDumpStreamInfo.devId));
    IDE_CTRL_VALUE_FAILED(
        drvRet == DRV_ERROR_NONE, return KFC_DUMP_E_DRIVE,
        "Failed to convert host device id[%u] to local device id, ret[%d]", g_dumpParam.streamInfo.deviceId,
        static_cast<int32_t>(drvRet));
    uint64_t sqAddr;
    DUMP_STATS_CHK_RET(
        KfcDumpTaskDispatcher::QuerySqBaseAddr(g_kfcDumpStreamInfo.devId, g_kfcDumpStreamInfo.sqId, sqAddr));
    g_kfcDumpStreamInfo.sqBaseAddr = reinterpret_cast<void*>(sqAddr);
    DUMP_STATS_CHK_RET(KfcDumpTaskDispatcher::QuerySqStatusByType(
        g_kfcDumpStreamInfo.devId, g_kfcDumpStreamInfo.sqId, DRV_SQCQ_PROP_SQ_DEPTH, g_kfcDumpStreamInfo.sqDepth));
    IDE_CTRL_VALUE_FAILED(
        g_kfcDumpStreamInfo.sqDepth != 0U, return KFC_DUMP_E_DRIVE,
        "Invalid sq depth[0] queried from driver, devId[%u] sqId[%u]", g_kfcDumpStreamInfo.devId,
        g_kfcDumpStreamInfo.sqId);

    DUMP_STATS_CHK_RET(KfcDumpTaskDispatcher::QuerySqStatusByType(
        g_kfcDumpStreamInfo.devId, g_kfcDumpStreamInfo.sqId, DRV_SQCQ_PROP_SQ_HEAD, g_kfcDumpStreamInfo.sqHead));
    DUMP_STATS_CHK_RET(KfcDumpTaskDispatcher::QuerySqStatusByType(
        g_kfcDumpStreamInfo.devId, g_kfcDumpStreamInfo.sqId, DRV_SQCQ_PROP_SQ_TAIL, g_kfcDumpStreamInfo.sqTail));
    KfcDumpPrintf::PrintKfcDumpStreamCtx(&g_kfcDumpStreamInfo);
    DUMP_STATS_CHK_RET(InitSqCqFunction());
    g_isInitialized = true;
    IDE_LOGI("Success to initialize the kfc dump server");
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpProcess::GetAivDumpContext()
{
    g_dumpContext.msgQ = g_dumpParam.kfcWorkSpace.msgQ;
    g_dumpContext.workspace = g_dumpParam.kfcWorkSpace.workspace;
    g_dumpContext.workspaceSize = g_dumpParam.kfcWorkSpace.workspaceSize;
    g_dumpContext.aiCoreNum = g_dumpParam.config.vectorCoreNum;
    g_dumpContext.ubSize = g_dumpParam.config.ubSize;
    g_dumpContext.syncSpace = g_dumpParam.kfcWorkSpace.msgQ + MSG_BODY_SIZE;
    errno_t ret = memset_s(
        reinterpret_cast<uint8_t*>(g_dumpParam.kfcWorkSpace.msgQ),
        static_cast<size_t>(g_dumpParam.kfcWorkSpace.msgQSize), 0,
        static_cast<size_t>(g_dumpParam.kfcWorkSpace.msgQSize));
    if (ret != EOK) {
        IDE_LOGE("Failed to reset kfc dump message queue, ret[%d]", ret);
        return KFC_DUMP_E_MEMORY;
    }
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpProcess::PostDumpResults(OpStatsResult& opStatsResult, KfcDumpTask* dumpTask, uint32_t resultNum)
{
    if (AicpuDumpOpTaskData == nullptr) {
        IDE_LOGE("AicpuDumpOpTaskData is unresolved, statistics result cannot be reported");
        return KFC_DUMP_E_NOT_SUPPORT;
    }
    auto dumpOpTaskDataStartTime = GetCurCpuTimestamp();
    opStatsResult.tensorNum = resultNum;
    uint32_t ret = AicpuDumpOpTaskData(*dumpTask, &opStatsResult, sizeof(OpStatsResult));
    if (ret != 0) {
        IDE_LOGE("Failed to report statistics result to aicpu scheduler, ret[%u]", ret);
        return KFC_DUMP_E_INTERNAL;
    }
    IDE_LOGI(
        "Report[%u] statistics results, time cost[%lu us]", resultNum,
        (GetCurCpuTimestamp() - dumpOpTaskDataStartTime) / NSEC_PER_USEC);
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpProcess::FillAivArgs(KfcDumpContext* kfcAivArgs)
{
    g_dumpContext.workspaceSizeAddr = reinterpret_cast<uint64_t>(&kfcAivArgs->workspaceSize);
    g_dumpContext.aiCoreNumAddr = reinterpret_cast<uint64_t>(&kfcAivArgs->aiCoreNum);
    g_dumpContext.ubSizeAddr = reinterpret_cast<uint64_t>(&kfcAivArgs->ubSize);
    errno_t ret = memcpy_s(kfcAivArgs, sizeof(KfcDumpContext), &g_dumpContext, sizeof(KfcDumpContext));
    if (ret != EOK) {
        IDE_LOGE("Failed to fill statistics operator arguments, ret[%d]", ret);
        return KFC_DUMP_E_MEMORY;
    }
    KfcDumpPrintf::PrintDumpContext(kfcAivArgs);
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpProcess::WaitTaskFinish()
{
    uint32_t curSqHead = g_kfcDumpStreamInfo.sqHead;
    auto waitTaskTimeStart = GetCurCpuTimestamp();
    while (g_kfcDumpStreamInfo.sqHead <= curSqHead) {
        DUMP_STATS_CHK_RET(KfcDumpTaskDispatcher::QuerySqStatusByType(
            g_kfcDumpStreamInfo.devId, g_kfcDumpStreamInfo.sqId, DRV_SQCQ_PROP_SQ_HEAD, g_kfcDumpStreamInfo.sqHead));
        if ((curSqHead == (g_kfcDumpStreamInfo.sqDepth - 1)) && g_kfcDumpStreamInfo.sqHead == 0) {
            IDE_LOGD("Sq head wrapped around to[%u]", g_kfcDumpStreamInfo.sqHead);
            break;
        }
        if (CheckTimeOut(waitTaskTimeStart) != KFC_DUMP_SUCCESS) {
            IDE_LOGE(
                "Wait for statistics task finish timeout, devId[%u] sqId[%u] sqHead[%u]", g_kfcDumpStreamInfo.devId,
                g_kfcDumpStreamInfo.sqId, g_kfcDumpStreamInfo.sqHead);
            return KFC_DUMP_E_TIMEOUT;
        }
    }
    IDE_LOGI("Statistics dump task finished, sqHead[%u]", g_kfcDumpStreamInfo.sqHead);
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpProcess::KfcDumpRunStatServer(KfcDumpTask* dumpTask, KfcDumpInfo* dumpInfo)
{
    if (!g_isInitialized) {
        IDE_LOGE("Kfc dump server is not initialized, cannot launch dump statistics task");
        return KFC_DUMP_E_INTERNAL;
    }

    OpStatsResult dumpResult = {};
    dumpResult.statItem = g_dumpParam.config.statsType;
    uint32_t tensorNum = dumpInfo->inputDumpInfo.size() + dumpInfo->outputDumpInfo.size();
    if (tensorNum == 0) {
        return KFC_DUMP_SUCCESS;
    }
    IDE_LOGI("Kfc dump server received %u tensors to dump", tensorNum);
    DUMP_STATS_CHK_RET(GetAivDumpContext());
    static KfcDumpStatsServer dump;
    dump.Init(g_dumpParam.kfcWorkSpace.msgQ);

    if (g_addOneStatDumpTask == nullptr || g_printSqeInfo == nullptr) {
        IDE_LOGE("Sqe construct function is null, chip type may be unsupported");
        return KFC_DUMP_E_INTERNAL;
    }
    uint8_t sqeBuffer[AC_SQE_SIZE] = {0};
    // msgQ长度1M，后半部分(+0x800)分配给syncSpace，尾部72B(KfcDumpContext)分配给kfc算子作为输入参数
    KfcDumpContext* kfcStatOpArgs = reinterpret_cast<KfcDumpContext*>(
        g_dumpParam.kfcWorkSpace.msgQ + g_dumpParam.kfcWorkSpace.msgQSize - sizeof(KfcDumpContext));
    DUMP_STATS_CHK_RET(FillAivArgs(kfcStatOpArgs));
    // 根据不同的芯片类型构造Sqe参数
    g_addOneStatDumpTask(sqeBuffer, &g_dumpParam, kfcStatOpArgs);
    g_printSqeInfo(sqeBuffer);
    // 下发Sqe拉起kfc算子
    DUMP_STATS_CHK_RET(KfcDumpTaskDispatcher::LaunchTask(sqeBuffer, &g_kfcDumpStreamInfo));

    // 算子已拉起：此后无论统计阶段成败，都必须发 FINISHED 让 AIV 退出循环，
    // 否则该实例永久占核，且下一次 Launch 拉起的新实例会与它争抢同一消息队列。
    KfcDumpResult statsRet = RunStatsExchange(dumpTask, dumpInfo, dump, dumpResult, tensorNum);
    KfcDumpResult finishRet = FinishStatsTask(dump);
    // 保留首个业务错误码，避免被收尾结果掩盖
    return (statsRet != KFC_DUMP_SUCCESS) ? statsRet : finishRet;
}

KfcDumpResult KfcDumpProcess::RunStatsExchange(
    KfcDumpTask* dumpTask, KfcDumpInfo* dumpInfo, KfcDumpStatsServer& dump, OpStatsResult& dumpResult,
    uint32_t tensorNum)
{
    // 通知kfc算子做tensor统计任务。
    g_tensorCount = 0;
    DUMP_STATS_CHK_RET(
        KfcDumpStatClientProcess(dumpTask, dumpInfo->inputDumpInfo, dump, dumpResult, TENSOR_TYPE_INPUT));
    DUMP_STATS_CHK_RET(
        KfcDumpStatClientProcess(dumpTask, dumpInfo->outputDumpInfo, dump, dumpResult, TENSOR_TYPE_OUTPUT));

    // 未满STEP上报给aicpu
    if (tensorNum % STEP_COUNT != 0) {
        DUMP_STATS_CHK_RET(PostDumpResults(dumpResult, dumpTask, tensorNum % STEP_COUNT));
    }
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpProcess::FinishStatsTask(KfcDumpStatsServer& dump)
{
    // 通知kfc算子结束退出
    IDE_LOGD("All tensor dump finished, unlaunch dump statistics task");
    KfcDumpStatsMsg gMsg = {};
    gMsg.msgType = DumpStatMsgType::KFC_DUMP_MSG_FINISHED;
    // PostMsg 失败也要继续 WaitTaskFinish：AIV 可能已消费到 FINISHED 而仅是本次投递超时，
    // 直接返回会漏掉等待，使下一次 Launch 与未退出的实例重叠。
    KfcDumpResult postRet = dump.PostMsg(&gMsg);
    if (postRet != KFC_DUMP_SUCCESS) {
        IDE_LOGE("Failed to post KFC_DUMP_MSG_FINISHED, result=%d", postRet);
    }
    KfcDumpResult waitRet = KfcDumpProcess::WaitTaskFinish();
    return (postRet != KFC_DUMP_SUCCESS) ? postRet : waitRet;
}

KfcDumpResult KfcDumpProcess::KfcDumpStatClientProcess(
    KfcDumpTask* dumpTask, const std::vector<InputOutputKfcDumpInfo>& dumpTensorList, KfcDumpStatsServer& dump,
    OpStatsResult& dumpResult, TensorType tensorType)
{
    if (dumpTensorList.size() == 0) {
        IDE_LOGW(
            "No tensor in this task, streamId=%u, taskId=%u, index=%u, tensorType=%u", dumpTask->streamId_,
            dumpTask->taskId_, dumpTask->index_, static_cast<uint32_t>(tensorType));
        return KFC_DUMP_SUCCESS;
    }

    KfcDumpStatsMsg gMsg = {};
    for (size_t tensorIndex = 0; tensorIndex < dumpTensorList.size(); tensorIndex++) {
        const auto& dumpTensor = dumpTensorList[tensorIndex];
        gMsg.msgType = DumpStatMsgType::KFC_DUMP_MSG_REQUEST;
        gMsg.dataType = dumpTensor.data_type;
        gMsg.dataCount = dumpTensor.size;
        gMsg.dataAddr = dumpTensor.address;
        gMsg.dumpStatClass = g_dumpParam.config.statsType;
        gMsg.outputAddr = g_dumpParam.kfcWorkSpace.output;
        gMsg.outputAddrSize = g_dumpParam.kfcWorkSpace.outputSize;
        KfcDumpPrintf::PrintMsg(gMsg);
        uint64_t computeStartTime = GetCurCpuTimestamp();
        DUMP_STATS_CHK_RET(dump.PostMsg(&gMsg));
        DUMP_STATS_CHK_RET(dump.RcvMsg(&gMsg));
        IDE_LOGI(
            "Aiv statistics computation finished, time cost[%lu us]",
            (GetCurCpuTimestamp() - computeStartTime) / NSEC_PER_USEC);
        KfcDumpPrintf::PrintMsg(gMsg);
        if (gMsg.msgType != KFC_DUMP_MSG_RESPONSE) {
            IDE_LOGW("Received unexpected msgType[%u], expect KFC_DUMP_MSG_RESPONSE[2]", gMsg.msgType);
            return KFC_DUMP_E_PARA;
        }
        dump.CheckDumpResult(&gMsg);
        DUMP_STATS_CHK_RET(
            UpdateDumpResult(dumpTensor, dumpResult.stat[g_tensorCount % STEP_COUNT], &gMsg, tensorType));
        g_tensorCount++;
        // 满STEP上报给aicpu
        if (g_tensorCount % STEP_COUNT == 0) {
            DUMP_STATS_CHK_RET(PostDumpResults(dumpResult, dumpTask, STEP_COUNT));
        }
    }
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpProcess::UpdateDumpResult(
    const InputOutputKfcDumpInfo& dumpTensor, TensorStatsResult& statsResult, KfcDumpStatsMsg* gMsg,
    TensorType tensorType)
{
    IDE_LOGI("Update statistics result of one tensor");
    if (dumpTensor.shape.size() > SHAPE_SIZE) {
        IDE_LOGE(
            "Tensor shape size[%zu] exceeds the upper limit[%u], index[%d]", dumpTensor.shape.size(), SHAPE_SIZE,
            dumpTensor.index);
        return KFC_DUMP_E_PARA;
    }
    if (gMsg->outputAddr != g_dumpParam.kfcWorkSpace.output) {
        IDE_LOGE(
            "Aiv returned unexpected output address, expect[0x%lx] actual[0x%lx]", g_dumpParam.kfcWorkSpace.output,
            gMsg->outputAddr);
        return KFC_DUMP_E_PARA;
    }
    statsResult.size = gMsg->dataCount;
    statsResult.dType = gMsg->dataType;
    statsResult.format = dumpTensor.format;
    statsResult.shapeSize = static_cast<int32_t>(dumpTensor.shape.size());
    for (size_t index = 0; index < dumpTensor.shape.size(); ++index) {
        statsResult.shape[index] = static_cast<uint32_t>(dumpTensor.shape[index]);
    }
    statsResult.result = gMsg->result;
    statsResult.statsLen = STAT_LEN;
    statsResult.io = static_cast<int32_t>(tensorType);
    statsResult.index = dumpTensor.index;
    IDE_LOGD(
        "dataSize[%ld] dataType[%u] shapeSize[%d] tensorType[%u] index[%d]", statsResult.size, statsResult.dType,
        statsResult.shapeSize, static_cast<uint32_t>(tensorType), statsResult.index);
    errno_t ret = memcpy_s(
        reinterpret_cast<uint8_t*>(statsResult.stats), STAT_LEN,
        reinterpret_cast<uint8_t*>(g_dumpParam.kfcWorkSpace.output), STAT_LEN);
    if (ret != EOK) {
        IDE_LOGE("Failed to copy statistics data to result buffer, ret[%d]", ret);
        return KFC_DUMP_E_MEMORY;
    }
    return KFC_DUMP_SUCCESS;
}
} // namespace kfc_dump_stats
