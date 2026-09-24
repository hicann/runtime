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
struct TaskSqeInfo;

void ConstructSqeBase(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

void ConstructSqeForStarsCommonTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForBarrierTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForCmoTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void PrintErrorInfoForCmoTask(TaskInfo* taskInfo, const uint32_t devId);

void SetResultForCreateStreamTask(TaskInfo* const taskInfo, const void* const data, const uint32_t dataSize);
void ConstructSqeForSetSqLockUnlockTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForStreamActiveTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForOverflowSwitchSetTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForStreamTagSetTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

void ConstructSqeForProfilingEnableTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForProfilingDisableTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForProfilerTraceExTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

void ConstructSqeForStreamSwitchTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForLabelSetTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

void FillMemWaitFunctionCallSqe(TaskInfo* taskInfo, RtStarsFunctionCallSqe& sqe, const uint64_t funcCallSize);
void ConstructSqeForMemcpyAsyncTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void DoCompleteSuccessForMemWaitValueTask(TaskInfo* taskInfo, const uint32_t devId);
uint32_t GetSendSqeNumForMemWaitTask(const TaskInfo* const taskInfo);
void ConstructSecondSqeForMemWaitValueTask(TaskInfo* taskInfo, rtStarsSqe_t* const command);
void ConstructPhSqeForMemWaitValueTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command);
void InitFuncCallParaForMemWaitTask(TaskInfo* taskInfo, RtStarsMemWaitValueInstrFcPara& fcPara);
void RegisterCaptureExternalTaskFuncForV100(rtChipType_t chip);

void ConstructSqeForNopTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

void ConstructSqeForNotifyRecordTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

void SetStarsResultForDavinciTask(TaskInfo* taskInfo, const rtCqReport_t& logicCq);
void DoCompleteSuccessForDavinciTask(TaskInfo* taskInfo, const uint32_t devId);
void DavinciTaskUnInit(TaskInfo* taskInfo);
void FillFftsMixSqeForDavinciTask(
    TaskInfo* taskInfo, rtStarsSqe_t* const command, uint32_t minStackSize, rtError_t copyRet);
void FillFftsPlusMixSqeSubtask(const AicTaskInfo* taskInfo, uint8_t* const subtype);
void ConstructFftsMixSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t* const command);
void ConstructAICpuSqeForDavinciTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructAicAivSqeForDavinciTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void FillFftsAicAivCtxForDavinciTask(
    TaskInfo* const taskInfo, rtFftsPlusMixAicAivCtx_t* fftsCtx, uint32_t& minStackSize);
void ConstructAICoreSqeForDavinciTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ShowDavinciTaskMixDebug(const rtFftsPlusMixAicAivCtx_t* const fftsCtx);

rtError_t MixKernelUpdatePrepare(TaskInfo* const updateTask, void** const hostAddr, const uint64_t allocSize);
rtError_t NormalKernelUpdatePrepare(TaskInfo* const updateTask, void** const hostAddr, const uint64_t allocSize);

void ConstructSqeForDavinciMultipleTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

void ConstructSqeForRdmaDbSendTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

void SetStarsResultForStarsVersionTask(TaskInfo* taskInfo, const rtCqReport_t& logicCq);
void DoCompleteSuccessForStarsVersionTask(TaskInfo* taskInfo, const uint32_t devId);

void ConstructSqeForCallbackLaunchTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForFlipTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

rtError_t WaitAsyncCopyCompleteForUpdateTask(TaskInfo* taskInfo);

void ConstructSqeForWriteValueTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);
void ConstructSqeForCommonCmdTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo);

void Construct2ndSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t* sqe);
} // namespace runtime
} // namespace cce
#endif // TASK_INFO_V100_H
