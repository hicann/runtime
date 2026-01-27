/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_batch_dequeue_buff.h"

#include "aicpusd_status.h"
#include "aicpusd_monitor.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_BATCH_DEQUEUE_BUFF = "modelBatchDequeueBuff";
}  // namespace

int32_t OperatorKernelModelBatchDequeueBuff::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Begin to batch dequeue buff. modelId[%u].", taskContext.modelId);
    const BatchDequeueBuffDesc *const batchDeqBufDesc =
        PtrToPtr<void, BatchDequeueBuffDesc>(ValueToPtr(kernelTaskInfo.paraBase));
    if (batchDeqBufDesc == nullptr) {
        aicpusd_err("KernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u].",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    BatchDequeueBuffInfo batchDeqBufInfo = {};
    auto ret = CheckAndParseBatchDeqBufParams(batchDeqBufDesc, kernelTaskInfo, taskContext, batchDeqBufInfo);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    aicpusd_info("batch dequeue for %u queues", batchDeqBufInfo.inputNums);
    for (uint32_t i = 0U; i < batchDeqBufInfo.inputNums; ++i) {
        BufEnQueueBuffInfo queueInfo = {
            batchDeqBufInfo.queueIds[i], batchDeqBufInfo.deviceIds[i], batchDeqBufInfo.mbufAddrs[i]};
        const auto res = ModelAttachAndDequeueBuff(queueInfo, taskContext);
        if (res == AICPU_SCHEDULE_ERROR_MODEL_UNLOAD) {
            aicpusd_warn("model is destroy");
            bool * const pending = const_cast<bool *>(&taskContext.pending);
            *pending = true;
            return AICPU_SCHEDULE_OK;
        }
    }

    if (batchDeqBufInfo.alignOffsets != nullptr) {
        ret = AlignBatchDequeueBuff(batchDeqBufInfo, taskContext);
    }
    return ret;
}

int32_t OperatorKernelModelBatchDequeueBuff::CheckAndParseBatchDeqBufParams(
    const BatchDequeueBuffDesc *const batchDeqBufDesc, const AicpuTaskInfo &kernelTaskInfo,
    const RunContext &taskContext, BatchDequeueBuffInfo &batchDeqBufInfo) const
{
    batchDeqBufInfo.inputNums = batchDeqBufDesc->inputNums;
    batchDeqBufInfo.alignInterval = batchDeqBufDesc->alignInterval;
    batchDeqBufInfo.alignOffsets = PtrToPtr<void, uint32_t>(ValueToPtr(batchDeqBufDesc->alignOffsetsAddr));
    batchDeqBufInfo.queueIds = PtrToPtr<void, uint32_t>(ValueToPtr(batchDeqBufDesc->queueIdsAddr));
    if (batchDeqBufInfo.queueIds == nullptr) {
        aicpusd_err("KernelTaskInfo queueIds is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    batchDeqBufInfo.mbufAddrs = PtrToPtr<void, uint64_t>(ValueToPtr(batchDeqBufDesc->mbufAddrsAddr));
    if (batchDeqBufInfo.mbufAddrs == nullptr) {
        aicpusd_err("KernelTaskInfo mbufAddrs is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    batchDeqBufInfo.deviceIds = PtrToPtr<void, int32_t>(ValueToPtr(batchDeqBufDesc->deviceIdAddr));
    if (batchDeqBufInfo.deviceIds == nullptr) {
        aicpusd_err("KernelTaskInfo deviceIds is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelBatchDequeueBuff::ModelAttachAndDequeueBuff(BufEnQueueBuffInfo &queueInfo,
                                                                       const RunContext &taskContext,
                                                                       bool tryOnce) const
{
    const auto drvRet = halQueueAttach(static_cast<uint32_t>(queueInfo.deviceId), queueInfo.queueID, 0);
    if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
        aicpusd_err("Aicpusd attached queue[%u] failed ret[%d]", queueInfo.queueID, drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    aicpusd_info("queue id %u device id %d.", queueInfo.queueID, queueInfo.deviceId);
    return ModelDequeueBuffTaskKernel(queueInfo, taskContext, tryOnce);
}

int32_t OperatorKernelModelBatchDequeueBuff::ModelDequeueBuffTaskKernel(BufEnQueueBuffInfo &bufInfo,
                                                                        const RunContext &taskContext,
                                                                        bool tryOnce) const
{
    Mbuf ** const mBufPptr = PtrToPtr<void, Mbuf*>(ValueToPtr(bufInfo.mBufPtr));
    if (mBufPptr == nullptr) {
        aicpusd_err("param mBufPptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("Cannot get model by modelId:[%u], streamId[%u].",
            taskContext.modelId, taskContext.streamId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const uint32_t queueId = bufInfo.queueID;
    const int32_t deviceId = bufInfo.deviceId;
    uint64_t respLen = 0U;
    while (true) {
        if (model->GetModelDestroyStatus()) {
            aicpusd_info("model is unloading, exit");
            return AICPU_SCHEDULE_ERROR_MODEL_UNLOAD;
        }
        const auto ret = halQueuePeek(static_cast<uint32_t>(deviceId), queueId, &respLen, 0);
        if ((ret == DRV_ERROR_NONE) && (respLen != 0U)) {
            aicpusd_info("halQueuePeek success");
            break;
        }
        if (tryOnce) {
            return AICPU_SCHEDULE_OK;
        }
    }

    const int32_t deqRet = DequeueBuff(bufInfo, taskContext, respLen, queueId, deviceId);
    if (deqRet != AICPU_SCHEDULE_OK) {
        aicpusd_warn("DequeueBuff failed from queue[%u] in device[%u] failed, deqRet[%d], respLen[%u]",
            queueId, deviceId, static_cast<int32_t>(deqRet), respLen);
    }
    return deqRet;
}

int32_t OperatorKernelModelBatchDequeueBuff::DequeueBuff(BufEnQueueBuffInfo &bufInfo, const RunContext &taskContext,
                                                         const uint64_t respLen, const uint32_t queueId,
                                                         const int32_t deviceId) const
{
    // mBufPptr在之前已经做过判空处理，此处不在进行校验
    Mbuf ** const mBufPptr = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(bufInfo.mBufPtr));
    Mbuf *outMBuf = BufManager::GetInstance().MallocAndGuardBuf(respLen, taskContext.modelId);
    if (outMBuf == nullptr) {
        aicpusd_err("Failed to alloc mbuf, respLen[%u], modelId[%u].", respLen, taskContext.modelId);
        AicpuMonitor::GetInstance().SendKillMsgToTsd();
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    auto drvRet = halMbufSetDataLen(outMBuf, static_cast<uint64_t>(respLen));
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("halMbufSetDataLen error, queue id:%u, drvRet=%d", queueId, drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    uint32_t headSize = 0U;
    void *headBuf = nullptr;
    drvRet = halMbufGetPrivInfo(outMBuf, &headBuf, &headSize);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get head info in input information, ret[%d].", drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    void *dataAddrPtr = nullptr;
    drvRet = OperatorKernelCommon::GetMbufDataPtr(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&outMBuf)),
                                                  &dataAddrPtr);
    if (drvRet != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to get mbuf data addr. ret is [%d]", drvRet);
        return drvRet;
    }

    constexpr size_t totalLen = sizeof(struct buff_iovec) + sizeof(struct iovec_info);
    std::unique_ptr<char_t[]> vecUniquePtr(new (std::nothrow) char_t[totalLen], std::default_delete<char_t[]>());
    if (vecUniquePtr == nullptr) {
        aicpusd_err("failed to alloc memory for vecUniquePtr, size[%zu].", totalLen);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    buff_iovec * const buffvec = reinterpret_cast<buff_iovec *>(vecUniquePtr.get());
    buffvec->context_base = headBuf;
    buffvec->context_len = headSize;
    buffvec->count = 1U;
    buffvec->ptr[0U].iovec_base = dataAddrPtr;
    buffvec->ptr[0U].len = respLen;
    drvRet = halQueueDeQueueBuff(static_cast<uint32_t>(deviceId), queueId, buffvec, -1);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("halQueueDeQueueBuff to queue[%u] in device[%d] failed, error[%d]",
            queueId, deviceId, static_cast<int32_t>(drvRet));
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    *mBufPptr = PtrToPtr<void, Mbuf>(outMBuf);

    (void)ProcessMbufHeadInDequeueTask(taskContext.modelId, headBuf, headSize);
    (void)SetModelEndOfSequence(taskContext.modelId, headBuf, headSize);

    OperatorKernelCommon::TraceQueueData(taskContext, headBuf, headSize, "DequeuedBuff");
    return AICPU_SCHEDULE_OK;
}

// if max(inputs timestamp-alignOffset)-min(inputs timestamp-alignOffset) < alignInterval, return ok
// else delete oldest data, then re-dequeue data until inputs timestamp alignment is satisfied or the queue is empty.
int32_t OperatorKernelModelBatchDequeueBuff::AlignBatchDequeueBuff(BatchDequeueBuffInfo &batchDeqBufInfo,
                                                                   const RunContext &taskContext) const
{
    BatchDequeueInfo batchDeqInfo = {batchDeqBufInfo.inputNums, batchDeqBufInfo.alignInterval,
        batchDeqBufInfo.alignOffsets, batchDeqBufInfo.queueIds, batchDeqBufInfo.mbufAddrs};
    while (true) {
        uint32_t maxAlignTimestamp = 0U;
        uint32_t minAlignTimestamp = UINT32_MAX;
        uint32_t minTimestampIndex = 0U;
        auto ret = AlignTimestamp(batchDeqInfo, taskContext, maxAlignTimestamp, minAlignTimestamp, minTimestampIndex);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("AlignTimestamp failed! ret[%ld]", ret);
            return ret;
        }
        if ((maxAlignTimestamp - minAlignTimestamp) <= batchDeqInfo.alignInterval) {
            return AICPU_SCHEDULE_OK;
        }
        BufEnQueueBuffInfo queBuffInfo = {batchDeqBufInfo.queueIds[minTimestampIndex],
            batchDeqBufInfo.deviceIds[minTimestampIndex], batchDeqBufInfo.mbufAddrs[minTimestampIndex]};
        ret = ModelDequeueBuffTaskKernel(queBuffInfo, taskContext);
        if (ret == AICPU_SCHEDULE_ERROR_MODEL_UNLOAD) {
            bool * const pending = const_cast<bool *>(&taskContext.pending);
            *pending = true;
            return AICPU_SCHEDULE_OK;
        }
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("ModelDequeueBuffTaskKernel failed! ret[%ld]", ret);
            return ret;
        }
    }
    return AICPU_SCHEDULE_OK;
}

REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_BATCH_DEQUEUE_BUFF, OperatorKernelModelBatchDequeueBuff);
}  // namespace AicpuSchedule