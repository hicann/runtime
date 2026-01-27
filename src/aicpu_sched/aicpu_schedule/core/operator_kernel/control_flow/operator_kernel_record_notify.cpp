/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_record_notify.h"

#include "aicpusd_status.h"
#include "aicpusd_info.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_event_process.h"
#include "operator_kernel_common.h"

namespace AicpuSchedule {
namespace {
const std::string KERNEL_RECORD_NOTIFY = "recordNotify";
}  // namespace

int32_t OperatorKernelRecordNotify::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    const auto info = PtrToPtr<void, TsAicpuNotify>(ValueToPtr(static_cast<uintptr_t>(kernelTaskInfo.paraBase)));
    if (info == nullptr) {
        aicpusd_err("ModelRecord kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
                    taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return DoCompute(info->notify_id, taskContext);
}

int32_t OperatorKernelRecordNotify::DoCompute(const uint32_t notifyId, const RunContext &taskContext) const
{
    // now only support notify aicpusd, when and tsid in TsAicpuNotify, it can notify hwts.
    bool hasWait = false;
    uint32_t waitStreamId = INVALID_NUMBER;
    // if has wait, set hasWait true and set waitStreamId, or else save notify come.
    EventWaitManager::NotifyWaitManager().Event(static_cast<size_t>(notifyId), hasWait, waitStreamId);
    if (!hasWait) {
        return AICPU_SCHEDULE_OK;
    }
    AICPUSubEventInfo subEventInfo = {};
    subEventInfo.modelId = taskContext.modelId;
    subEventInfo.para.streamInfo.streamId = waitStreamId;
    return OperatorKernelCommon::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, char_t>(&subEventInfo),
        static_cast<uint32_t>(sizeof(AICPUSubEventInfo)), AICPU_SUB_EVENT_RECOVERY_STREAM);
}

REGISTER_OPERATOR_KERNEL(KERNEL_RECORD_NOTIFY, OperatorKernelRecordNotify);
}  // namespace AicpuSchedule