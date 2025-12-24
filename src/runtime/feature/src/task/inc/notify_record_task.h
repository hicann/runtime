/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_NOTIFY_RECORD_TASK_H
#define RUNTIME_NOTIFY_RECORD_TASK_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
void ConstructSqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsSqe_t *const command);
void ToCommandBodyForNotifyRecordTask(TaskInfo *taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForNotifyRecordTask(TaskInfo *taskInfo, const uint32_t devId);
void SetResultForNotifyRecordTask(TaskInfo *const taskInfo, const void *const data, const uint32_t dataSize);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_NOTIFY_RECORD_TASK_H