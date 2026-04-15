/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TASK_INFO_V100_H
#define TASK_INFO_V100_H

#include "stars.hpp"

namespace cce {
namespace runtime {
void ConstructSqeForBarrierTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForCmoTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void PrintErrorInfoForCmoTask(TaskInfo* taskInfo, const uint32_t devId);

void SetResultForCreateStreamTask(TaskInfo * const taskInfo, const void *const data, const uint32_t dataSize);
void ConstructSqeForSetSqLockUnlockTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStreamActiveTask(TaskInfo* taskInfo, rtStarsSqe_t * const command);
void ConstructSqeForOverflowSwitchSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStreamTagSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
}  // namespace runtime
}  // namespace cce
#endif  // TASK_INFO_V100_H
