/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_FUSION_TASK_H
#define CCE_RUNTIME_FUSION_TASK_H

#include <string>
#include "task_info.hpp"
#include "stars_david.hpp"

namespace cce {
namespace runtime {

std::string BuildFusionKernelTaskName(FusionTaskInfo* fusionTaskInfo);

void DoCompleteSuccessForFusionKernelTask(TaskInfo* taskInfo, const uint32_t devId);
void FusionKernelTaskUnInit(TaskInfo* taskInfo);
void PrintErrorInfoForFusionKernelTask(TaskInfo* taskInfo, const uint32_t devId);
void SetStarsResultForFusionKernelTask(TaskInfo* taskInfo, const rtCqReport_t& logicCq);

void ConstructAicpuSubSqeBase(
    TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint32_t& sqeIndex, uint32_t aicpuIndex, uint32_t taskIdx,
    uint64_t sqBaseAddr);
void ConstructAicpuSubSqe(
    TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint32_t& sqeIndex, uint32_t aicpuIndex, uint32_t taskIdx,
    uint64_t sqBaseAddr);
void ConstructDavidSqeForFusionKernelTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_FUSION_TASK_H