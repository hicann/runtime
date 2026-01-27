/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operator_kernel_wait_notify.h"

#include "aicpusd_status.h"
#include "aicpusd_resource_manager.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_WAIT_NOTIFY = "waitNotify";
}  // namespace

int32_t OperatorKernelWaitNotify::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    const auto info = PtrToPtr<void, TsAicpuNotify>(ValueToPtr(kernelTaskInfo.paraBase));
    if (info == nullptr) {
        aicpusd_err("ModelWait kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return DoCompute(info->notify_id, taskContext);
}

int32_t OperatorKernelWaitNotify::DoCompute(const uint32_t notifyId, const RunContext &taskContext) const
{
    bool needWait = false;
    EventWaitManager::NotifyWaitManager().WaitEvent(static_cast<size_t>(notifyId), taskContext.streamId, needWait);
    if (needWait) {
        bool * const pending = const_cast<bool *>(&taskContext.pending);
        *pending = true;
    }
    return AICPU_SCHEDULE_OK;
}

REGISTER_OPERATOR_KERNEL(KERNEL_WAIT_NOTIFY, OperatorKernelWaitNotify);
}  // namespace AicpuSchedule