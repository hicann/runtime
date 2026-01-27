/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_enqueue.h"

#include "aicpusd_status.h"
#include "aicpusd_profiler.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_ENQUEUE = "modelEnqueue";
}  // namespace

int32_t OperatorKernelModelEnqueue::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    auto bufInfo = PtrToPtr<void, BufEnQueueInfo>(ValueToPtr(kernelTaskInfo.paraBase));
    if (bufInfo == nullptr) {
        aicpusd_err("ModelEnqueue kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    g_aicpuProfiler.SetEndGraph();
    g_aicpuProfiler.SetEqStart();
    const int32_t ret = EnqueueTask(*bufInfo, taskContext);
    g_aicpuProfiler.SetEqEnd();
    g_aicpuProfiler.SetModelEnd();
    return static_cast<uint32_t>(ret);
}


REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_ENQUEUE, OperatorKernelModelEnqueue);
}  // namespace AicpuSchedule