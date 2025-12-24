/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_MODEL_MAINTAINCE_TASK_H
#define RUNTIME_MODEL_MAINTAINCE_TASK_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
void ConstructSqeForModelMaintainceTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command);
void ToCommandBodyForModelMaintainceTask(TaskInfo * const taskInfo, rtCommand_t * const command);
void DoCompleteSuccessForModelMaintainceTask(TaskInfo * const taskInfo, const uint32_t devId);
void PrintErrorInfoForModelMaintainceTask(TaskInfo * const taskInfo, const uint32_t devId);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_MODEL_MAINTAINCE_TASK_H