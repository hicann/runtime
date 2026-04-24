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
#include "rt_inner_task.h"

namespace cce {
namespace runtime {
rtError_t EventRecordTaskInit(TaskInfo * const taskInfo, Event *const eventPtr,
                              const bool isNotifyRecordFlag, const int32_t newEventId);
void EventRecordTaskUnInit(TaskInfo *const taskInfo);
void SetStarsResultForEventRecordTask(TaskInfo *const taskInfo, const rtLogicCqReport_t &logicCq);
void ToCommandBodyForEventRecordTask(TaskInfo *const taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForEventRecordTask(TaskInfo *const taskInfo, const uint32_t devId);

rtError_t EventResetTaskInit(TaskInfo * const taskInfo, Event *const eventPtr,
                             const bool isNotifyFlag, const int32_t eventIndex);
void EventResetTaskUnInit(TaskInfo *const taskInfo);
void ToCommandBodyForEventResetTask(TaskInfo *const taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForEventResetTask(TaskInfo *const taskInfo, const uint32_t devId);
rtError_t RemoteEventWaitTaskInit(TaskInfo * const taskInfo, Event *const eventRec,
                                  const int32_t srcDeviceId, const int32_t eventIndex);

void RemoteEventWaitTaskUnInit(TaskInfo *const taskInfo);
void ToCommandBodyForRemoteEventWaitTask(TaskInfo *const taskInfo, rtCommand_t *const command);
rtError_t EventWaitTaskInit(TaskInfo * const taskInfo, Event *const eventRec, const int32_t eventIndex,
                            const uint32_t timeout, const uint8_t waitFlag);
void ToCommandBodyForEventWaitTask(TaskInfo *const taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForEventWaitTask(TaskInfo *const taskInfo, const uint32_t devId);
void PrintErrorInfoForEventWaitTask(TaskInfo *const taskInfo, const uint32_t devId);
void SetStarsResultForEventWaitTask(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq);

rtError_t GetEventRecordTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
rtError_t GetEventWaitTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
rtError_t GetEventResetTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
}  // namespace runtime
}  // namespace cce
#endif
