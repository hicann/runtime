/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context.hpp"
#include "stars.hpp"
#include "davinci_multiple_task.h"
#include "task_execute_time.h"

namespace cce {
namespace runtime {

#if F_DESC("DavinciMultipleTask")

rtError_t DavinciMultipleTaskInit(TaskInfo* taskInfo, const void* const multipleTaskInfo, const uint32_t flag)
{
    TaskCommonInfoInit(taskInfo);
    DavinciMultiTaskInfo* multiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    const rtMultipleTaskInfo_t* info = static_cast<const rtMultipleTaskInfo_t*>(multipleTaskInfo);

    taskInfo->type = TS_TASK_TYPE_MULTIPLE_TASK;
    taskInfo->typeName = "MULTIPLE_TASK";
    taskInfo->needPostProc = true;
    multiTaskInfo->multipleTaskInfo = const_cast<void*>(multipleTaskInfo);
    multiTaskInfo->multipleTaskCqeNum = 0U;
    multiTaskInfo->sqeType = 0U;
    multiTaskInfo->errorType = 0U;
    multiTaskInfo->cqeErrorCode = 0U;
    multiTaskInfo->hasUnderstudyTask = false;
    multiTaskInfo->sqeNum = info->taskNum;
    multiTaskInfo->cmdListVec = new (std::nothrow) std::vector<void*>();
    multiTaskInfo->flag = flag;
    COND_RETURN_AND_MSG_OUTER(
        multiTaskInfo->cmdListVec == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(std::vector<void*>),
        "new");

    multiTaskInfo->argHandleVec = new (std::nothrow) std::vector<void*>();
    COND_PROC_RETURN_AND_MSG_OUTER(
        multiTaskInfo->argHandleVec == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        DELETE_O(multiTaskInfo->cmdListVec), sizeof(std::vector<void*>), "new");

    return RT_ERROR_NONE;
}

void ResetCmdList(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo* davMulTask = &taskInfo->u.davinciMultiTaskInfo;
    if (davMulTask->cmdListVec == nullptr) {
        RT_LOG(RT_LOG_INFO, "davMulTask->cmdListVec is nullptr.");
        return;
    }
    RT_LOG(RT_LOG_INFO, "cmdListVec.size() = %u, flag=%u", davMulTask->cmdListVec->size(), davMulTask->flag);
    if (davMulTask->cmdListVec->empty()) {
        delete davMulTask->cmdListVec;
        davMulTask->cmdListVec = nullptr;
        return;
    }

    if ((davMulTask->flag & RT_KERNEL_CMDLIST_NOT_FREE) == 0U) {
        const auto dev = taskInfo->stream->Device_();
        for (auto iter : *davMulTask->cmdListVec) {
            (void)(dev->Driver_())->DevMemFree(iter, dev->Id_());
        }
    }

    davMulTask->cmdListVec->clear();
    delete davMulTask->cmdListVec;
    davMulTask->cmdListVec = nullptr;
}

void IncMultipleTaskCqeNum(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo* davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    if (davinciMultiTaskInfo->multipleTaskCqeNum == 0xFFU) {
        RT_LOG(
            RT_LOG_WARNING,
            "Skipping CQE count increment because the counter is at its maximum. "
            "multipleTaskCqeNum_=%u, expected range before increment is [0, 254].",
            davinciMultiTaskInfo->multipleTaskCqeNum);
        return;
    }

    davinciMultiTaskInfo->multipleTaskCqeNum++;
    return;
}

uint32_t GetSendSqeNumForDavinciMultipleTask(const TaskInfo* const taskInfo)
{
    const DavinciMultiTaskInfo* multiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    RT_LOG(RT_LOG_INFO, "sqe num is %u", multiTaskInfo->sqeNum);
    return multiTaskInfo->sqeNum;
}

uint8_t GetMultipleTaskCqeNum(TaskInfo* const taskInfo)
{
    DavinciMultiTaskInfo* multiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    return multiTaskInfo->multipleTaskCqeNum;
}

void DecMultipleTaskCqeNum(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo* davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    if (davinciMultiTaskInfo->multipleTaskCqeNum == 0U) {
        RT_LOG(
            RT_LOG_WARNING,
            "Skipping CQE count decrement because the counter is 0. "
            "multipleTaskCqeNum_=%u, expected range before decrement is [1, 255].",
            davinciMultiTaskInfo->multipleTaskCqeNum);
        return;
    }

    davinciMultiTaskInfo->multipleTaskCqeNum--;
    return;
}

void SetMultipleTaskCqeErrorInfo(TaskInfo* taskInfo, uint8_t sqeType, uint8_t errorType, uint32_t errorCode)
{
    DavinciMultiTaskInfo* davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    if (davinciMultiTaskInfo->sqeType == 0U) { // first cqe
        davinciMultiTaskInfo->sqeType = sqeType;
        davinciMultiTaskInfo->errorType = errorType;
        davinciMultiTaskInfo->cqeErrorCode = errorCode;
    } else {
        if (errorType == 0) { // CqReport Success
            davinciMultiTaskInfo->errorType = davinciMultiTaskInfo->errorType & errorType;
            davinciMultiTaskInfo->cqeErrorCode = davinciMultiTaskInfo->cqeErrorCode & errorCode;
        } else { // CqReport fail
            davinciMultiTaskInfo->sqeType = sqeType;
            davinciMultiTaskInfo->errorType = davinciMultiTaskInfo->errorType | errorType;
            davinciMultiTaskInfo->cqeErrorCode = davinciMultiTaskInfo->cqeErrorCode | errorCode;
        }
    }

    RT_LOG(
        RT_LOG_DEBUG,
        "sqeType=%u, errorType=%u, errorCode=%u, MultiSqeType=%u, MultiErrorType=%u, MultiCqeErrorCode=%u", sqeType,
        errorType, errorCode, davinciMultiTaskInfo->sqeType, davinciMultiTaskInfo->errorType,
        davinciMultiTaskInfo->cqeErrorCode);
    return;
}

void GetMultipleTaskCqeErrorInfo(
    TaskInfo* const taskInfo, volatile uint8_t& sqeType, volatile uint8_t& errorType, volatile uint32_t& errorCode)
{
    DavinciMultiTaskInfo* davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    sqeType = davinciMultiTaskInfo->sqeType;
    errorType = davinciMultiTaskInfo->errorType;
    errorCode = davinciMultiTaskInfo->cqeErrorCode;
    return;
}

#endif

} // namespace runtime
} // namespace cce
