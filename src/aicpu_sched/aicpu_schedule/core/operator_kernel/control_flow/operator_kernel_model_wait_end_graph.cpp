/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_wait_end_graph.h"

#include "aicpusd_info.h"
#include "aicpusd_status.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_model_statistic.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_WAIT_END_GRAPH = "modelWaitEndGraph";
}  // namespace

int32_t OperatorKernelModelWaitEndGraph::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
const auto modelIdPtr = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(kernelTaskInfo.paraBase)));
    if (modelIdPtr == nullptr) {
        aicpusd_err("ModelWaitEndGraph kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const uint32_t modelId = *modelIdPtr;
    if (*modelIdPtr != taskContext.modelId) {
        aicpusd_warn("ModelWaitEndGraph kernelTaskInfo modelId[%u] is diff with context, "
            "modelId[%u], streamId[%u], taskId[%u]",
            modelId, taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
    }

    aicpusd_info("Begin to execute WaitEndGraph. modelId[%u].", modelId);
    bool needWait = false;
    EventWaitManager::EndGraphWaitManager().WaitEvent(static_cast<size_t>(modelId), taskContext.streamId, needWait);
    if (needWait) {
        bool * const pending = const_cast<bool *>(&taskContext.pending);
        *pending = true;
    } else {
        AicpuSdModelStatistic::GetInstance().StatNNModelExecTime(modelId);
        aicpusd_info("WaitEndGraph Over, modelId[%u], streamId[%u]", taskContext.modelId, taskContext.streamId);
    }

    return AICPU_SCHEDULE_OK;
}

REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_WAIT_END_GRAPH, OperatorKernelModelWaitEndGraph);
}  // namespace AicpuSchedule