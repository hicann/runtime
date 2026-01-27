/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_end_graph.h"

#include "aicpusd_info.h"
#include "aicpusd_status.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_END_GRAPH = "endGraph";
}  // namespace

int32_t OperatorKernelEndGraph::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    const auto modelIdPtr = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(kernelTaskInfo.paraBase)));
    if (modelIdPtr == nullptr) {
        aicpusd_err("ModelEndGraph kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const uint32_t modelId = *modelIdPtr;
    if (modelId != taskContext.modelId) {
        aicpusd_warn("ModelEndGraph kernelTaskInfo modelId[%u] is diff with context, "
                     "modelId[%u], streamId[%u], taskId[%u]", modelId, taskContext.modelId, taskContext.streamId,
                     kernelTaskInfo.taskID);
    }

    aicpusd_info("Begin to execute EndGraph. modelId[%u].", modelId);
    bool hasWait = false;
    uint32_t waitStreamId = 0U;
    EventWaitManager::EndGraphWaitManager().Event(static_cast<size_t>(modelId), hasWait, waitStreamId);
    if (hasWait) {
        AICPUSubEventInfo subEventInfo = {};
        subEventInfo.modelId = modelId;
        subEventInfo.para.streamInfo.streamId = waitStreamId;
        const int32_t ret = OperatorKernelCommon::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, char_t>(&subEventInfo),
            static_cast<uint32_t>(sizeof(AICPUSubEventInfo)), AICPU_SUB_EVENT_RECOVERY_STREAM);
        return ret;
    }

    return AICPU_SCHEDULE_OK;
}

REGISTER_OPERATOR_KERNEL(KERNEL_END_GRAPH, OperatorKernelEndGraph);
}  // namespace AicpuSchedule