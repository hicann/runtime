/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_active_model.h"

#include "aicpusd_info.h"
#include "aicpusd_status.h"
#include "aicpusd_event_process.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_resource_manager.h"

namespace AicpuSchedule {
namespace {
const std::string KERNEL_ACTIVE_MODEL = "activeModel";
constexpr uint32_t GE_GROUP_ID = 10U;
}  // namespace

int32_t OperatorKernelActiveModel::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    const auto modelIdPtr = PtrToPtr<void, uint32_t>(ValueToPtr(kernelTaskInfo.paraBase));
    if (modelIdPtr == nullptr) {
        aicpusd_err("ModelActive kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    aicpusd_info("Begin to active modelId[%u].", *modelIdPtr);
    AICPUSubEventInfo subEventInfo = {};
    subEventInfo.modelId = taskContext.modelId;
    return AicpuMsgSend::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
        static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
        AICPU_SUB_EVENT_ACTIVE_MODEL,
        GE_GROUP_ID,
        true);
}


REGISTER_OPERATOR_KERNEL(KERNEL_ACTIVE_MODEL, OperatorKernelActiveModel);
}  // namespace AicpuSchedule