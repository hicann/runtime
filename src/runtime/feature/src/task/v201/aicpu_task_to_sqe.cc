/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime.hpp"
#include "event_david.hpp"
#include "task_manager.h"
#include "stars.hpp"
#include "stars_david.hpp"
#include "device.hpp"
#include "task_info.h"
#include "error_code.h"
namespace cce {
namespace runtime {

void ConstructDavidAICpuSqeForDavinciTask(TaskInfo *const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    ConstructDavidAICpuSqeForDavinciTaskBase(taskInfo, davidSqe, sqBaseAddr);
    RtDavidStarsAicpuKernelSqe *const sqe = &(davidSqe->aicpuSqe);

    // swap buffer use host pid
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_SRC_PID;

    PrintDavidSqe(davidSqe, "AICpuTask");
    RT_LOG(RT_LOG_INFO, "topic_type=%hu, kernel_type=%u, dump_en=%u",
        sqe->topicType, sqe->kernelType,  sqe->debugDumpEn);

    return;
}

void ConstructAicpuSubSqe(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t &sqeIndex,
    uint32_t aicpuIndex, uint32_t taskIdx, uint64_t sqBaseAddr)
{
    ConstructAicpuSubSqeBase(taskInfo, davidSqe, sqeIndex, aicpuIndex, taskIdx, sqBaseAddr);

    rtDavidSqe_t *sqeAddr = &davidSqe[sqeIndex];
    RtDavidStarsAicpuKernelSqe *const sqe = &(sqeAddr->aicpuSqe);
    // swap buffer use host pid
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_SRC_PID;

    if (taskIdx == 0U) {
        sqe->header.type = RT_DAVID_SQE_TYPE_FUSION;
    }

    PrintDavidSqe(sqeAddr, "FusionKernelTask-Aicpu");
    sqeIndex++;

    return;
}

}  // namespace runtime
}  // namespace cce