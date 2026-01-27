/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_DEBUG_TASK_H
#define RUNTIME_DEBUG_TASK_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
void ToCommandBodyForDynamicProfilingEnableTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForDynamicProfilingDisableTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForProfilingEnableTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForProfilingDisableTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForOnlineProfEnableTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForOnlineProfDisableTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForAdcProfTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForProfilerTraceTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForProfilerTraceExTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForFusionDumpAddrSetTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForDataDumpLoadInfoTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForDebugRegisterTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForDebugUnRegisterTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForDebugRegisterForStreamTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCmdBodyForDebugUnRegisterForStreamTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ConstructSqeForProfilingEnableTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForProfilingDisableTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForProfilerTraceExTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForDebugRegisterForStreamTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForDebugUnRegisterForStreamTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForDataDumpLoadInfoTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForDebugRegisterTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForDebugUnRegisterTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void DoCompleteSuccessForDataDumpLoadInfoTask(TaskInfo* taskInfo, const uint32_t devId);
void SetStarsResultForDataDumpLoadInfoTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq);
}  // namespace runtime
}  // namespace cce
#endif
