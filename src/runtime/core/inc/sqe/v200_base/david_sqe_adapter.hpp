/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_DAVID_SQE_ADAPTER_HPP
#define CCE_RUNTIME_DAVID_SQE_ADAPTER_HPP

#include "runtime.hpp"
#include "stars_david.hpp"
#include "task_res_da.hpp"

namespace cce {
namespace runtime {

inline void ConstructDavidSqeForTaskId(const TaskInfo* const taskInfo, rtDavidSqe_t* const sqe)
{
    sqe->commonSqe.sqeHeader.taskId = taskInfo->taskSn;
}

inline void ConstructDavidSqeForHeadCommon(const TaskInfo* const taskInfo, rtDavidSqe_t* const sqe)
{
    Stream* const stream = taskInfo->stream;
    (void)memset_s(sqe, sizeof(rtDavidSqe_t), 0, sizeof(rtDavidSqe_t));
    sqe->commonSqe.sqeHeader.wrCqe = stream->GetStarsWrCqeFlag();
    sqe->commonSqe.sqeHeader.taskId = taskInfo->taskSn;
    PostProcessTaskSqeHeader(&(sqe->commonSqe.sqeHeader));
}

constexpr uint8_t GetDavidHeadUpdateFlag(const uint64_t allocTimes)
{
    return ((allocTimes % DAVID_TASK_NUM_FOR_HEAD_UPDATE) == 0U) ? 1U : 0U;
}

inline void UpdateDavidSqeHeadUpdate(TaskInfo* const taskInfo, void* const sqe)
{
    rtDavidSqe_t* const davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    if (Runtime::Instance()->GetConnectUbFlag() && (davidSqe->commonSqe.sqeHeader.headUpdate == 0U)) {
        uint64_t allocTimes = taskInfo->id;
        if (taskInfo->stream->taskResMang_ != nullptr) {
            allocTimes = RtPtrToPtr<TaskResManageDavid*>(taskInfo->stream->taskResMang_)->GetAllocNum();
        }
        davidSqe->commonSqe.sqeHeader.headUpdate = GetDavidHeadUpdateFlag(allocTimes);
    }
}

inline void ConstructDavidSqeUpdateHeadOnly(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo&)
{
    UpdateDavidSqeHeadUpdate(taskInfo, sqe);
}

// Used when composing a task from several SQEs; the registered callback updates headUpdate once.
void ConstructDavidPlaceHolderSqe(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_DAVID_SQE_ADAPTER_HPP
