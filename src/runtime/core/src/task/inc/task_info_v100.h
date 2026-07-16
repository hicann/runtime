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
void ConstructSqeBase(TaskInfo *const taskInfo, rtStarsSqe_t *const command);

void ConstructSqeForStarsCommonTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForBarrierTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForCmoTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void PrintErrorInfoForCmoTask(TaskInfo* taskInfo, const uint32_t devId);

void SetResultForCreateStreamTask(TaskInfo * const taskInfo, const void *const data, const uint32_t dataSize);
void ConstructSqeForSetSqLockUnlockTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStreamActiveTask(TaskInfo* taskInfo, rtStarsSqe_t * const command);
void ConstructSqeForOverflowSwitchSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStreamTagSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);

void ConstructSqeForProfilingEnableTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForProfilingDisableTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForProfilerTraceExTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void PCTraceTaskUnInit(TaskInfo * const taskInfo);

void ConstructSqeForStreamSwitchTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForLabelSetTask(TaskInfo* taskInfo, rtStarsSqe_t * const command);

void FillMemWaitFunctionCallSqe(TaskInfo* taskInfo, RtStarsFunctionCallSqe &sqe, const uint64_t funcCallSize);
void ConstructSqeForMemcpyAsyncTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);

void ConstructSqeForNopTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);

void ConstructSqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsSqe_t *const command);

void SetStarsResultForDavinciTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq);
void DoCompleteSuccessForDavinciTask(TaskInfo* taskInfo, const uint32_t devId);
void DavinciTaskUnInit(TaskInfo *taskInfo);
void FillFftsMixSqeForDavinciTask(
    TaskInfo *taskInfo, rtStarsSqe_t *const command, uint32_t minStackSize, rtError_t copyRet);
void FillFftsPlusMixSqeSubtask(const AicTaskInfo *taskInfo, uint8_t *const subtype);
void ConstructFftsMixSqeForDavinciTask(TaskInfo *taskInfo, rtStarsSqe_t *const command);
void ConstructAICpuSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructAicAivSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void FillFftsAicAivCtxForDavinciTask(TaskInfo* const taskInfo, rtFftsPlusMixAicAivCtx_t *fftsCtx, uint32_t& minStackSize);
void ConstructAICoreSqeForDavinciTask(TaskInfo* const taskInfo, rtStarsSqe_t *const command);
void ShowDavinciTaskMixDebug(const rtFftsPlusMixAicAivCtx_t * const fftsCtx);

rtError_t MixKernelUpdatePrepare(TaskInfo * const updateTask, void ** const hostAddr, const uint64_t allocSize);
rtError_t NormalKernelUpdatePrepare(TaskInfo * const updateTask, void ** const hostAddr, const uint64_t allocSize);


void ConstructSqeForDavinciMultipleTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);

void ConstructSqeForRdmaDbSendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command);

void SetStarsResultForStarsVersionTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq);
void DoCompleteSuccessForStarsVersionTask(TaskInfo* taskInfo, const uint32_t devId);

void ConstructSqeForCallbackLaunchTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForFlipTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);

rtError_t WaitAsyncCopyCompleteForUpdateTask(TaskInfo* taskInfo);

void ConstructSqeForWriteValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForCommonCmdTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);

void Construct2ndSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *sqe);
}  // namespace runtime
}  // namespace cce
#endif  // TASK_INFO_V100_H
