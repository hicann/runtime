/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_MODEL_EXECUTE_TASK_H
#define RUNTIME_MODEL_EXECUTE_TASK_H

#include "task_info.hpp"

namespace cce {
namespace runtime {

rtError_t ModelExecuteTaskInit(TaskInfo * const taskInfo, Model *const modelPtr, const uint32_t modelIndex,
                               const uint32_t firstTaskIndex);
void ToCommandBodyForModelExecuteTask(TaskInfo * const taskInfo, rtCommand_t * const command);
void ModelExecuteTaskUnInit(TaskInfo * const taskInfo);
void DoCompleteSuccessForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId);
void PrintErrorInfoForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId);
void SetStarsResultForModelExecuteTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq);
TaskInfo *GetRealReportFaultTaskForModelExecuteTask(TaskInfo* const taskInfo);
void PrintErrorModelExecuteTaskFuncCall(TaskInfo *const task);
rtError_t AllocFuncCallMemForModelExecuteTask(TaskInfo * const taskInfo, rtStarsModelExeFuncCallPara_t &funcCallPara);
rtError_t PrepareSqeInfoForModelExecuteTask(TaskInfo * const taskInfo);
rtError_t FreeFuncCallHostMemAndSvmMem(TaskInfo * const taskInfo);
void ReportModelEndGraphErrorForNotifyWaitTask(TaskInfo *taskInfo, const uint32_t devId);
void ReportErrorInfoForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId);
rtError_t WaitExecFinishForModelExecuteTask(const TaskInfo *const taskInfo);

}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_MODEL_EXECUTE_TASK_H
