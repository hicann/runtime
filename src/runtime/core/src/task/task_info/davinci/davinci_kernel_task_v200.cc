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

void ConstructDavidAICpuSqeForDavinciTask(TaskInfo *const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    ConstructDavidAICpuSqeForDavinciTaskBase(taskInfo, davidSqe, sqBaseAddr);

    RtDavidStarsAicpuKernelSqe *const sqe = &(davidSqe->aicpuSqe);
    PrintDavidSqe(davidSqe, "AICpuTask");
    RT_LOG(RT_LOG_INFO, "topic_type=%hu, kernel_type=%u, dump_en=%u",
        sqe->topicType, sqe->kernelType,  sqe->debugDumpEn);
    return;
}

void UpdateDavidAICoreSqeForDavinciTask(RtDavidStarsAicAivKernelSqe * const sqe)
{
    UNUSED(sqe);
}

void UpdateDavidAICpuSqeForDavinciTask(RtDavidStarsAicpuKernelSqe * const sqe)
{
 	UNUSED(sqe);
}

void UpdateDavidAICpuControlSqeForDavinciTask(RtDavidStarsAicpuControlSqe * const sqe)
{
 	UNUSED(sqe);
}

#endif

}  // namespace runtime
}  // namespace cce
