/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_mark_step.h"

#include "aicpusd_status.h"
#include "aicpusd_util.h"
#include "aicpusd_model_execute.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MARK_STEP = "markStep";
}  // namespace

int32_t OperatorKernelMarkStep::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Begin to execute MarkStep modelId[%u].", taskContext.modelId);
    MarkStepInfo * const bufInfo =
        PtrToPtr<void, MarkStepInfo>(ValueToPtr(static_cast<uintptr_t>(kernelTaskInfo.paraBase)));
    if (CheckMarkStepPara(bufInfo) != AICPU_SCHEDULE_OK) {
        aicpusd_err("MarkStep para check failed, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    // bufInfo parse
    AicpuModel * const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    uint64_t * const stepIdAddr = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(bufInfo->stepIdAddr)));
    if (static_cast<uint32_t>(bufInfo->headFlag) == 1U) {
        aicpusd_debug("Not is head node, modelId=%u", taskContext.modelId);
        model->SetHeadNodeFlag(false);
        model->SetStepIdInfo(std::move(StepIdInfo(stepIdAddr, 0U)));
        return AICPU_SCHEDULE_OK;
    }

    const uint64_t iteratorCount = model->GetIteratorId();
    if (AicpuUtil::IsUint64MulOverflow(iteratorCount, bufInfo->groupTotalCount)) {
        aicpusd_err("modelId[%u], iteratorCount:[%lu], groupIndex:%u, totalCnt:%u!",
                    taskContext.modelId, iteratorCount, bufInfo->groupIndex, bufInfo->groupTotalCount);
        return AICPU_SCHEDULE_ERROR_OVERFLOW;
    }
    uint64_t tempCnt = iteratorCount * bufInfo->groupTotalCount;
    if ((std::numeric_limits<uint64_t>::max() - tempCnt) <= bufInfo->groupIndex) {
        aicpusd_err("modelId[%u], iteratorCount:[%lu], groupIndex:%u, totalCnt:%u!",
                    taskContext.modelId, iteratorCount, bufInfo->groupIndex, bufInfo->groupTotalCount);
        return AICPU_SCHEDULE_ERROR_OVERFLOW;
    }
    tempCnt += bufInfo->groupIndex;
    if ((std::numeric_limits<uint64_t>::max() - tempCnt) <= static_cast<uint64_t>(bufInfo->groupTotalCount - 1U)) {
        aicpusd_err("modelId[%u], iteratorCount:[%lu], groupIndex:%u, totalCnt:%u!",
                    taskContext.modelId, iteratorCount, bufInfo->groupIndex, bufInfo->groupTotalCount);
        return AICPU_SCHEDULE_ERROR_OVERFLOW;
    }

    // because transId starts from 1, the following operations is needed
    const uint64_t stepId = (bufInfo->groupIndex == 0U) ?
                            tempCnt + static_cast<uint64_t>(bufInfo->groupTotalCount - 1U) : tempCnt - 1UL;
    aicpusd_info("[MarkStep] headFlag[true], iteratorCount[%lu], totalCnt[%u], groupIndex[%u], stepId:[%lu].",
                 iteratorCount, bufInfo->groupTotalCount, bufInfo->groupIndex, stepId);
    *stepIdAddr = stepId;

    model->SetHeadNodeFlag(true);
    model->SetStepIdInfo(std::move(StepIdInfo(stepIdAddr, stepId)));
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelMarkStep::CheckMarkStepPara(const MarkStepInfo * const markStepInfo) const
{
    if ((markStepInfo == nullptr) || (markStepInfo->stepIdAddr == 0UL) || (markStepInfo->groupTotalCount == 0U)) {
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    return AICPU_SCHEDULE_OK;
}

REGISTER_OPERATOR_KERNEL(KERNEL_MARK_STEP, OperatorKernelMarkStep);
}  // namespace AicpuSchedule