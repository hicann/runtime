/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_stream_repeat.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_STREAM_REPEAT = "streamRepeat";
}  // namespace

int32_t OperatorKernelStreamRepeat::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start repeat model stream. modelId=%u, streamId=%u, taskId=%u",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    const StreamRepeatTaskParam * const repeatStreamInfo =
        PtrToPtr<void, StreamRepeatTaskParam>(ValueToPtr(kernelTaskInfo.paraBase));
    if (repeatStreamInfo == nullptr) {
        aicpusd_err("Model repeat stream info is nullptr. modelId=%u, streamId=%u, taskId=%u",
                    taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if ((repeatStreamInfo->modelId != taskContext.modelId) || (repeatStreamInfo->streamId != taskContext.streamId)) {
        aicpusd_warn("Model repeat stream is diff with context. rptModelId=%u, modelId=%u, rptStreamId=%u, streamId=%u",
                     repeatStreamInfo->modelId, taskContext.modelId,
                     repeatStreamInfo->streamId, taskContext.streamId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const AicpuModel *model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if ((model != nullptr) && (model->GetModelRetCode() != 0) && (model->AbnormalNeedBreak())) {
        aicpusd_err("Model stream repeat failed, model execute failed. modelId=%d.", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED;
    }
    *(const_cast<int32_t *>(&taskContext.gotoTaskIndex)) = 0;
    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_STREAM_REPEAT, OperatorKernelStreamRepeat);
}  // namespace AicpuSchedule