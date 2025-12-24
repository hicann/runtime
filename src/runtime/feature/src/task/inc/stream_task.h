/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_STREAM_TASK_H
#define RUNTIME_STREAM_TASK_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
void ToCommandBodyForCreateStreamTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCmdBodyForActiveAicpuStreamTask(TaskInfo* const taskInfo, rtCommand_t *const command);
void ToCmdBodyForSetStreamModeTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForStreamActiveTask(TaskInfo* taskInfo, rtCommand_t * const command);
void ConstructSqeForOverflowSwitchSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStreamTagSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStreamActiveTask(TaskInfo* taskInfo, rtStarsSqe_t * const command);
void ConstructSqeForSetSqLockUnlockTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void SetResultForCreateStreamTask(TaskInfo * const taskInfo, const void *const data, const uint32_t dataSize);
void PrintErrorInfoForStreamActiveTask(TaskInfo* taskInfo, const uint32_t devId);
void StreamActiveTaskUnInit(TaskInfo * const taskInfo);
rtError_t ReConstructStreamActiveTaskFc(TaskInfo* taskInfo);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_STREAM_TASK_H