/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_batch_dequeue.h"

#include "aicpusd_status.h"
#include "aicpusd_profiler.h"
#include "aicpusd_model_execute.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_BATCH_DEQUEUE = "modelBatchDequeue";
}  // namespace

int32_t OperatorKernelModelBatchDequeue::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Begin to batch dequeue. modelId[%u].", taskContext.modelId);
    BatchDequeueInfo batchDeqInfo = {};
    auto ret = CheckAndParseBatchDequeueParams(kernelTaskInfo, taskContext, batchDeqInfo);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    auto &inputsIsDequeue = AicpuModelManager::GetInstance().GetModel(taskContext.modelId)->MutableInputsIsDequeue();
    aicpusd_info("batch dequeue for %u queues.", batchDeqInfo.inputNums);
    for (uint32_t i = 0U; i < batchDeqInfo.inputNums; ++i) {
        if (inputsIsDequeue[i]) {
            aicpusd_info("the [%u]th queue has been dequed successfully", i);
            continue;
        }
        BufEnQueueInfo queueInfo = { batchDeqInfo.queueIds[i], batchDeqInfo.mbufAddrs[i] };
        ret = DoModelDequeue(queueInfo, taskContext);
        if (ret != AICPU_SCHEDULE_OK) {
            inputsIsDequeue.assign(inputsIsDequeue.size(), false);
            return ret;
        }
        if (taskContext.pending) {
            return AICPU_SCHEDULE_OK;
        }
        inputsIsDequeue[i] = true;
    }
    if (batchDeqInfo.alignOffsets != nullptr) {
        ret = AlignBatchDequeue(batchDeqInfo, taskContext);
        if ((ret != AICPU_SCHEDULE_OK) || (taskContext.pending)) {
            return ret;
        }
    }

    inputsIsDequeue.assign(inputsIsDequeue.size(), false);
    return ret;
}

int32_t OperatorKernelModelBatchDequeue::CheckAndParseBatchDequeueParams(const AicpuTaskInfo &kernelTaskInfo,
    const RunContext &taskContext, BatchDequeueInfo &batchDeqInfo) const
{
    const BatchDequeueDesc *const batchDeqDesc =
        PtrToPtr<void, BatchDequeueDesc>(ValueToPtr(kernelTaskInfo.paraBase));
    if (batchDeqDesc == nullptr) {
        aicpusd_err("KernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u].",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("Cannot get model by modelId:[%u], streamId[%u], taskId[%u].",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    auto &inputsIsDequeue = model->MutableInputsIsDequeue();
    if (batchDeqDesc->inputNums != inputsIsDequeue.size()) {
        aicpusd_err("KernelTaskInfo inputNums[%u] is not equal model input queue size[%u],"
            "modelId[%u], streamId[%u], taskId[%u]", batchDeqDesc->inputNums, inputsIsDequeue.size(),
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    batchDeqInfo.inputNums = batchDeqDesc->inputNums;
    batchDeqInfo.alignInterval = batchDeqDesc->alignInterval;
    batchDeqInfo.alignOffsets = PtrToPtr<void, uint32_t>(ValueToPtr(batchDeqDesc->alignOffsetsAddr));
    batchDeqInfo.queueIds = PtrToPtr<void, uint32_t>(ValueToPtr(batchDeqDesc->queueIdsAddr));
    if (batchDeqInfo.queueIds == nullptr) {
        aicpusd_err("KernelTaskInfo queueIds is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    batchDeqInfo.mbufAddrs = PtrToPtr<void, uint64_t>(ValueToPtr(batchDeqDesc->mbufAddrsAddr));
    if (batchDeqInfo.mbufAddrs == nullptr) {
        aicpusd_err("KernelTaskInfo mbufAddrs is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelBatchDequeue::DoModelDequeue(BufEnQueueInfo &bufInfo, const RunContext &taskContext) const {
    return DequeueTask(bufInfo, taskContext, true);
}

// if max(inputs timestamp-alignOffset)-min(inputs timestamp-alignOffset) < alignInterval, return ok
// else delete oldest data, then re-dequeue data until inputs timestamp alignment is satisfied or the queue is empty.
int32_t OperatorKernelModelBatchDequeue::AlignBatchDequeue(BatchDequeueInfo &batchDeqInfo,
                                                           const RunContext &taskContext)
{
    // model has been checked, not nullptr
    auto &inputsIsDequeue =
        AicpuModelManager::GetInstance().GetModel(taskContext.modelId)->MutableInputsIsDequeue();
    while (true) {
        uint32_t maxAlignTimestamp = 0U;
        uint32_t minAlignTimestamp = UINT32_MAX;
        uint32_t minTimestampIndex = 0U;
        auto ret = AlignTimestamp(batchDeqInfo, taskContext, maxAlignTimestamp, minAlignTimestamp, minTimestampIndex);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        if ((maxAlignTimestamp - minAlignTimestamp) <= batchDeqInfo.alignInterval) {
            return AICPU_SCHEDULE_OK;
        }
        BufEnQueueInfo queueInfo = {
            batchDeqInfo.queueIds[minTimestampIndex], batchDeqInfo.mbufAddrs[minTimestampIndex] };
        ret = DoModelDequeue(queueInfo, taskContext);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        if (taskContext.pending) {
            inputsIsDequeue[minTimestampIndex] = false;
            return AICPU_SCHEDULE_OK;
        }
    }
    return AICPU_SCHEDULE_OK;
}

REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_BATCH_DEQUEUE, OperatorKernelModelBatchDequeue);
}  // namespace AicpuSchedule