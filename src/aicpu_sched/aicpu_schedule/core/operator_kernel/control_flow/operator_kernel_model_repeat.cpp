/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_repeat.h"

#include "aicpusd_status.h"
#include "aicpusd_profiler.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_REPEAT = "modelRepeat";
}  // namespace

int32_t OperatorKernelModelRepeat::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
        const auto modelIdPtr = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(kernelTaskInfo.paraBase)));
    if (modelIdPtr == nullptr) {
        aicpusd_err("ModelRepeat kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (*modelIdPtr != taskContext.modelId) {
        aicpusd_warn(
            "ModelRepeat kernelTaskInfo modelId[%u] is diff with context, modelId[%u], streamId[%u], taskId[%u]",
            *modelIdPtr, taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
    }
    ResetStaticNNModelOutputIndex(taskContext.modelId);
    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if ((model != nullptr) && (model->GetModelRetCode() != 0) && (model->AbnormalNeedBreak())) {
        aicpusd_err("Model execute failed, need to break. modelId=%u, modelRetCode=%d.",
                    taskContext.modelId, model->GetModelRetCode());
        return AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED;
    }
    return OperatorKernelModelRepeat::SendModelRepeatEvent(*modelIdPtr);
}

uint32_t OperatorKernelModelRepeat::SendModelRepeatEvent(const uint32_t modelId)
{
    uint32_t iterCount = 0U;
    uint32_t activeStreamNum = 0U;
    const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
    if (model != nullptr) {
        iterCount = model->GetIteratorId();
        activeStreamNum = model->GetActiveStreamNum();
    }
    aicpusd_info("Begin to execute ModelRepeat. modelId[%u], activeStreamNum[%u], iterCount[%u]",
        modelId, activeStreamNum, iterCount);
    AICPUSubEventInfo subEventInfo = {};
    subEventInfo.modelId = modelId;
    g_aicpuProfiler.SetRepeatStart();
    const int32_t ret = OperatorKernelCommon::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, char_t>(&subEventInfo),
        static_cast<uint32_t>(sizeof(AICPUSubEventInfo)), AICPU_SUB_EVENT_REPEAT_MODEL);
    g_aicpuProfiler.SetRepeatEnd();

    return ret;
}

void OperatorKernelModelRepeat::ResetStaticNNModelOutputIndex(const uint32_t modelId) const
{
    const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
    if (model == nullptr) {
        return;
    }
    model->ResetStaticNNModelOutputIndex();
}

REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_REPEAT, OperatorKernelModelRepeat);
}  // namespace AicpuSchedule