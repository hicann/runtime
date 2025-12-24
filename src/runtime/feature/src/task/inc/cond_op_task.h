/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_COND_OP_TASK_H
#define RUNTIME_COND_OP_TASK_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
void ToCmdBodyForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCmdBodyForStreamLabelGotoTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForStreamSwitchTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForStreamSwitchNTask(TaskInfo *taskInfo, rtCommand_t *const command);
void ToCommandBodyForLabelSetTask(TaskInfo* taskInfo, rtCommand_t * const command);
void ToCommandBodyForLabelSwitchTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForLabelGotoTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ConstructSqeForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStreamSwitchTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForLabelSetTask(TaskInfo* taskInfo, rtStarsSqe_t * const command);
void StreamSwitchTaskUnInit(TaskInfo * const taskInfo);
void StreamLabelSwitchByIndexTaskUnInit(TaskInfo * const taskInfo);
void PrintErrorInfoForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForStreamSwitchTask(TaskInfo* taskInfo, const uint32_t devId);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_COND_OP_TASK_H