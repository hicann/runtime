/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"

namespace cce {
namespace runtime {
#if F_DESC("DavinciKernelTask")

void ConstructDavidAICpuSqeForDavinciTask(TaskInfo *const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    ConstructDavidAICpuSqeForDavinciTaskBase(taskInfo, davidSqe, sqBaseAddr);
    RtDavidStarsAicpuKernelSqe *const sqe = &(davidSqe->aicpuSqe);

    // swap buffer use host pid
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    UpdateDavidAICpuKernelSqeForDavinciTask(sqe);

    PrintDavidSqe(davidSqe, "AICpuTask");
    RT_LOG(RT_LOG_INFO, "type=%hu, topic_type=%hu, kernel_type=%u, dump_en=%u",
        sqe->header.type, sqe->topicType, sqe->kernelType,  sqe->debugDumpEn);
    return;
}

void UpdateDavidAICoreSqeForDavinciTask(RtDavidStarsAicAivKernelSqe * const sqe)
{
    sqe->piMix = 1U;
    return;
}

void UpdateDavidAICpuControlSqeForDavinciTask(RtDavidStarsAicpuControlSqe * const sqe)
{
 	sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_SRC_PID;
 	return;
}

void UpdateDavidAICpuKernelSqeForDavinciTask(RtDavidStarsAicpuKernelSqe * const sqe)
{
 	sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_SRC_PID;
 	return;
}

#endif

}  // namespace runtime
}  // namespace cce
