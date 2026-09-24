/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_DQS_TASK_INFO_HPP__
#define __CCE_RUNTIME_DQS_TASK_INFO_HPP__

#include "task_info.hpp"
#include "task_dqs.hpp"
#include "stars_david.hpp"

namespace cce {
namespace runtime {
// DQS Task Init
rtError_t DqsEnqueueTaskInit(TaskInfo* taskInfo, const Stream* const stream, const DqsTaskConfig* const cfg);
rtError_t DqsDequeueTaskInit(TaskInfo* taskInfo, const Stream* const stream, const DqsTaskConfig* const cfg);
rtError_t DqsFrameAlignTaskInit(TaskInfo* taskInfo, const Stream* const stream, const DqsTaskConfig* const cfg);
rtError_t DqsZeroCopyTaskInit(TaskInfo* taskInfo, const Stream* const stream, const DqsTaskConfig* const cfg);
rtError_t DqsConditionCopyTaskInit(TaskInfo* taskInfo, const Stream* const stream, const DqsTaskConfig* const cfg);
rtError_t DqsMbufFreeTaskInit(TaskInfo* taskInfo, const Stream* const stream, const DqsTaskConfig* const cfg);
rtError_t DqsSchedEndTaskInit(TaskInfo* taskInfo, const Stream* const stream, const DqsTaskConfig* const cfg);
rtError_t DqsPrepareTaskInit(TaskInfo* taskInfo, const Stream* const stream, const DqsTaskConfig* const cfg);

rtError_t DqsInterChipPreProcTaskInit(TaskInfo* taskInfo, const uint32_t groupIdx, const DqsInterChipTaskType type);
rtError_t DqsInterChipPostProcTaskInit(TaskInfo* taskInfo, const uint32_t groupIdx, const DqsInterChipTaskType type);
rtError_t DqsInterChipMemcpyTaskInit(TaskInfo* taskInfo, const uint32_t groupIdx, const DqsInterChipTaskType type);
rtError_t DqsInterChipNopTaskInit(TaskInfo* taskInfo, const uint32_t groupIdx, const DqsInterChipTaskType type);
rtError_t DqsAdspcTaskInit(TaskInfo* taskInfo, const Stream* const stream, const DqsTaskConfig* const cfg);

// DQS Sqe Construct
void ConstructSqeForDqsMbufFreeTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsEnqueueTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsDequeueTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsZeroCopyTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsConditionCopyTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsSchedEndTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsPrepareTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsInterChipPreProcTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsInterChipPostProcTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsAdspcTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsBatchDequeueTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForDqsFrameAlignTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);

// DQS Print Error Info
void PrintErrorInfoForDqsMbufFreeTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForDqsPrepareTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForDqsZeroCopyTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForDqsConditionCopyTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForDqsInterChipPreProcTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForDqsInterChipPostProcTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForDqsAdspcTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForDqsBatchDequeueTask(TaskInfo* taskInfo, const uint32_t devId);

// DQS Task UnInit
void DqsEnqueueTaskUnInit(TaskInfo* const taskInfo);
void DqsDequeueTaskUnInit(TaskInfo* const taskInfo);
void DqsMbufFreeTaskUnInit(TaskInfo* const taskInfo);
void DqsPrepareTaskUnInit(TaskInfo* const taskInfo);
void DqsZeroCopyTaskUnInit(TaskInfo* const taskInfo);
void DqsConditionCopyTaskUnInit(TaskInfo* const taskInfo);
void DqsInterChipPreProcTaskUnInit(TaskInfo* const taskInfo);
void DqsInterChipPostProcTaskUnInit(TaskInfo* const taskInfo);
void DqsAdspcTaskUnInit(TaskInfo* const taskInfo);
void DqsBatchDequeTaskUnInit(TaskInfo* const taskInfo);
void DqsFrameAlignTaskUnInit(TaskInfo* const taskInfo);

template <typename T>
void InitDqsFunctionCallSqe(T& sqe, const bool isWrCqe, const uint32_t taskId, const RtCondsSubType subType)
{
    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.header.lock = 0U;
    sqe.header.unlock = 0U;
    sqe.header.ie = 0U;
    sqe.header.preP = 0U;
    sqe.header.postP = 0U;
    sqe.header.wrCqe = isWrCqe;
    sqe.header.ptrMode = 0U;
    sqe.header.rttMode = 0U;
    sqe.header.headUpdate = 0U;
    sqe.header.reserved = 0U;
    sqe.header.blockDim = 0U;
    sqe.header.taskId = taskId;
    sqe.condsSubType = subType;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;

    return;
}
} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_DQS_TASK_INFO_HPP__