/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_batch_enqueue.h"

#include "aicpusd_status.h"
#include "aicpusd_profiler.h"
#include "aicpusd_model_execute.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_BATCH_ENQUEUE = "modelBatchEnqueue";
}  // namespace

int32_t OperatorKernelModelBatchEnqueue::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start ModelBatchEnque. modelId=%u, streamId=%u, taskId=%u.",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    if (kernelTaskInfo.paraBase == 0UL) {
        aicpusd_err("kernelTaskInfo.paraBase is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const BatchDequeueDesc * const param = PtrToPtr<void, BatchDequeueDesc>(ValueToPtr(kernelTaskInfo.paraBase));
    const uint64_t * const mbufPtrlist = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(param->mbufAddrsAddr)));
    const uint32_t * const outQueueIdList =
        PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(param->queueIdsAddr)));
    const uint32_t &outputNum = param->inputNums;

    if ((outputNum > 0U) && ((mbufPtrlist == nullptr) || (outQueueIdList == nullptr))) {
        aicpusd_err("outputNum[%u], but mbufAddrsAddr or queueIdsAddr is null.", outputNum);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    return BatchEnque(taskContext, mbufPtrlist, outQueueIdList, outputNum);
}

int32_t OperatorKernelModelBatchEnqueue::BatchEnque(const RunContext &taskContext, const uint64_t * const mbufPtrlist,
                                                    const uint32_t * const outQueueIdList,
                                                    const uint32_t outQueueNum) const
{
    BufEnQueueInfo enqueueInfo;
    AicpuModel *const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    int32_t ret = AICPU_SCHEDULE_OK;
    g_aicpuProfiler.SetEqStart();
    ModelPostpareData &postpareData = model->GetModelPostpareData();
    for (; postpareData.enqueueIndex < outQueueNum; postpareData.enqueueIndex++) {
        enqueueInfo.mBufPtr = *(mbufPtrlist + postpareData.enqueueIndex);
        enqueueInfo.queueID = outQueueIdList[postpareData.enqueueIndex];

        ret = EnqueueTask(enqueueInfo, taskContext);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        if (taskContext.pending) {
            aicpusd_info("pending is true, wait for event.");
            return ret;
        }
    }

    postpareData.enqueueIndex = 0;
    g_aicpuProfiler.SetEqEnd();
    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_BATCH_ENQUEUE, OperatorKernelModelBatchEnqueue);
}  // namespace AicpuSchedule