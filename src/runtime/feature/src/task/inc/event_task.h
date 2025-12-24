/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_EVENT_TASK_H
#define RUNTIME_EVENT_TASK_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
void EventRecordTaskUnInit(TaskInfo *const taskInfo);
void SetResultForEventRecordTask(TaskInfo *const taskInfo, const void *const data, const uint32_t dataSize);
void SetStarsResultForEventRecordTask(TaskInfo *const taskInfo, const rtLogicCqReport_t &logicCq);
void ToCommandBodyForEventRecordTask(TaskInfo *const taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForEventRecordTask(TaskInfo *const taskInfo, const uint32_t devId);
void ConstructSqeForEventRecordTask(TaskInfo *const taskInfo, rtStarsSqe_t *const command);
void EventResetTaskUnInit(TaskInfo *const taskInfo);
void ToCommandBodyForEventResetTask(TaskInfo *const taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForEventResetTask(TaskInfo *const taskInfo, const uint32_t devId);
void ConstructSqeForEventResetTask(TaskInfo *const taskInfo, rtStarsSqe_t *const command);
void RemoteEventWaitTaskUnInit(TaskInfo *const taskInfo);
void ToCommandBodyForRemoteEventWaitTask(TaskInfo *const taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForRemoteEventWaitTask(TaskInfo *const taskInfo, const uint32_t devId);
void ToCommandBodyForEventWaitTask(TaskInfo *const taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForEventWaitTask(TaskInfo *const taskInfo, const uint32_t devId);
void ConstructSqeForEventWaitTask(TaskInfo *const taskInfo, rtStarsSqe_t *const command);
void PrintErrorInfoForEventWaitTask(TaskInfo *const taskInfo, const uint32_t devId);
void SetStarsResultForEventWaitTask(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq);
}  // namespace runtime
}  // namespace cce
#endif
