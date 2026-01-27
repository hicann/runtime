/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_postpare.h"

#include "aicpusd_status.h"
#include "aicpusd_profiler.h"
#include "aicpusd_resource_manager.h"
#include "control_flow/operator_kernel_model_repeat.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_POSTPARE = "modelPostpare";
}  // namespace

int32_t OperatorKernelModelPostpare::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    auto postpareInfo = PtrToPtr<void, AicpuPostpareInfo>(ValueToPtr(kernelTaskInfo.paraBase));
    if (postpareInfo == nullptr) {
        aicpusd_err("ModelPostpare kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u].",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (postpareInfo->aicpuPareInfoSize != sizeof(AicpuPostpareInfo)) {
        aicpusd_err("Failed check AicpuPostpareInfo size. msgInfo.aicpuPareInfoSize is [%u], "
            "calc AicpuPostpareInfo is [%zu].",
            postpareInfo->aicpuPareInfoSize, sizeof(AicpuPostpareInfo));
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (postpareInfo->outQueueNum == 0U) {
        aicpusd_err("outQueueNum is zero!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (postpareInfo->outQueueNum > MAX_SIZE_NUM) {
        aicpusd_err("outQueueNum:[%u] out of max size:[%u]!", postpareInfo->outQueueNum, MAX_SIZE_NUM);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (postpareInfo->outQueueIdList == 0UL) {
        aicpusd_err("outQueueIdList pointers is nullptr!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (postpareInfo->mbufPtrlist == 0UL) {
        aicpusd_err("mbufPtrlist pointers is nullptr!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (!CheckPointListNullptr(PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(postpareInfo->mbufPtrlist))),
        postpareInfo->outQueueNum)) {
        aicpusd_err("mbufPtrlist has null pointers!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    g_aicpuProfiler.SetEndGraph();
    return DoPostpare(*postpareInfo, taskContext);
}

bool OperatorKernelModelPostpare::CheckPointListNullptr(const uint64_t * const pointList, const uint32_t pointSize) const
{
    for (uint32_t i = 0U; i < pointSize; i++) {
        if (*(pointList + i) == 0UL) {
            return false;
        }
    }
    return true;
}

int32_t OperatorKernelModelPostpare::DoPostpare(AicpuPostpareInfo &msgInfo, const RunContext &taskContext) const
{
    // force convert to mbuf** or uint64_t *
    uint64_t * const mbufPtrlist = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(msgInfo.mbufPtrlist)));
    const uint32_t * const outQueueIdList =
        PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(msgInfo.outQueueIdList)));

    std::vector<uint64_t> mbufPtrVector;
    for (uint32_t i = 0; i < msgInfo.outQueueNum; ++i) {
        mbufPtrVector.emplace_back(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(mbufPtrlist + i)));
    }
    const auto ret = BatchEnque(taskContext, mbufPtrVector.data(), outQueueIdList, msgInfo.outQueueNum);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    return OperatorKernelModelRepeat::SendModelRepeatEvent(taskContext.modelId);
}


REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_POSTPARE, OperatorKernelModelPostpare);
}  // namespace AicpuSchedule