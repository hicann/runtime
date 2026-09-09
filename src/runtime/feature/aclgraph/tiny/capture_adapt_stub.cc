/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capture_adapt.hpp"
#include "event.hpp"
#include "capture_model.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {

bool StreamFlagIsSupportCapture(uint32_t flag)
{
    UNUSED(flag);
    return true;
}

rtError_t GetCaptureEventFromTask(
    const Device* const dev, uint32_t streamId, uint32_t pos, Event*& eventPtr, CaptureCntNotify& cntInfo)
{
    UNUSED(dev);
    UNUSED(streamId);
    UNUSED(pos);
    UNUSED(eventPtr);
    UNUSED(cntInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ResetCaptureEventsProc(const CaptureModel* const captureModel, Stream* const stm)
{
    UNUSED(captureModel);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SendNopTask(const Context* const curCtx, Stream* const stm)
{
    UNUSED(curCtx);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

bool TaskTypeIsSupportTaskGroup(const TaskInfo* const task)
{
    UNUSED(task);
    return false;
}

TaskInfo* GetStreamTaskInfo(const Device* const dev, uint16_t streamId, uint16_t pos)
{
    UNUSED(dev);
    UNUSED(streamId);
    UNUSED(pos);
    return nullptr;
}

bool NeedCascadeExpandStream(Stream* captureStm)
{
    UNUSED(captureStm);
    return false;
}

rtError_t AllocCaptureTaskByTaskRes(Stream* captureStm, uint32_t sqeNum, TaskInfo** task)
{
    UNUSED(captureStm);
    UNUSED(sqeNum);
    UNUSED(task);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t AllocAutoSplitTaskInfo(TaskInfo** taskInfo, Stream* const stm, uint32_t sqeNum)
{
    UNUSED(taskInfo);
    UNUSED(stm);
    UNUSED(sqeNum);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

TaskInfo* AllocNonCaptureTask(
    Stream* stm, TaskInfo* pTask, tsTaskType_t taskType, rtError_t& errorReason, uint32_t sqeNum)
{
    UNUSED(sqeNum);
    if (stm->taskResMang_ == nullptr) {
        return stm->Device_()->GetTaskFactory()->Alloc(stm, taskType, errorReason);
    } else {
        NULL_PTR_RETURN(pTask, nullptr);
        pTask->stream = stm;
        return pTask;
    }
}

} // namespace runtime
} // namespace cce