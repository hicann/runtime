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

void ConstructSqeForDataDumpLoadInfoTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void DoCompleteSuccessForDataDumpLoadInfoTask(TaskInfo* taskInfo, const uint32_t devId);
void ConstructSqeForDebugRegisterTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForDebugUnRegisterTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForDebugRegisterForStreamTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForDebugUnRegisterForStreamTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);

void ConstructSqeForProfilingEnableTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForProfilingDisableTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForProfilerTraceExTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);

void ConstructSqeForStreamSwitchTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForLabelSetTask(TaskInfo* taskInfo, rtStarsSqe_t * const command);

void ConstructSqeForMemcpyAsyncTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
rtError_t WaitAsyncCopyCompleteForMemcpyTask(TaskInfo* taskInfo);
void MemcpyAsyncTaskUnInit(TaskInfo * const taskInfo);
void DoCompleteSuccessForMemcpyAsyncTask(TaskInfo * const taskInfo, const uint32_t devId);
void ConstructSqeForMemWriteValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForMemWaitValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);

void ConstructSqeForModelExecuteTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command);
void SetResultForModelExecuteTask(TaskInfo * const taskInfo, const void * const data, const uint32_t dataSize);
void ConstructSqeForModelMaintainceTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command);
void ConstructSqeForModelToAicpuTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForModelUpdateTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForAddEndGraphTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForAicpuInfoLoadTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void DoCompleteSuccessForAicpuInfoLoadTask(TaskInfo* taskInfo, const uint32_t devId);
void ConstructSqeForNopTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);

void SetResultForEventRecordTask(TaskInfo *const taskInfo, const void *const data, const uint32_t dataSize);
void ConstructSqeForEventRecordTask(TaskInfo *const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForEventResetTask(TaskInfo *const taskInfo, rtStarsSqe_t *const command);
void DoCompleteSuccessForRemoteEventWaitTask(TaskInfo *const taskInfo, const uint32_t devId);
void ConstructSqeForEventWaitTask(TaskInfo *const taskInfo, rtStarsSqe_t *const command);

void ConstructSqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsSqe_t *const command);
void SetResultForNotifyRecordTask(TaskInfo *const taskInfo, const void *const data, const uint32_t dataSize);
void ConstructSqeForNotifyWaitTask(TaskInfo *taskInfo, rtStarsSqe_t *const command);

}  // namespace runtime
}  // namespace cce
#endif  // TASK_INFO_V100_H
