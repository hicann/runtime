/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "event.hpp"
#include "error_message_manage.hpp"
#include "inner_thread_local.hpp"
#include "task_info.hpp"
#include "memory_task.h"

namespace cce {
namespace runtime {

static rtError_t SubmitMemWaitValueTask(Event* const event, Stream* const stm, const bool captureWait)
{
    rtError_t error = RT_ERROR_NONE;
    Device* const dev = stm->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason = RT_ERROR_NONE;
    const tsTaskType_t allocType = captureWait ? TS_TASK_TYPE_STREAM_WAIT_EVENT : TS_TASK_TYPE_MEM_WAIT_VALUE;
    TaskInfo* tsk = stm->AllocTask(&submitTask, allocType, errorReason, MEM_WAIT_SQE_NUM);
    COND_RETURN_ERROR_MSG_INNER(
        tsk == nullptr, errorReason, "Failed to allocate mem wait task, retCode=%#x.",
        static_cast<uint32_t>(errorReason));
    std::function<void()> const errRecycle = [&dev, &tsk]() {
        MemWaitTaskUnInit(tsk);
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    void* const eventAddr = event->GetEventAddr();
    COND_RETURN_ERROR_MSG_INNER(
        eventAddr == nullptr, RT_ERROR_EVENT_RECORDER_NULL, "Event addr is null, event_id=%d.", event->EventId_());

    tsk->typeName = captureWait ? "EVENT_WAIT" : "EXTERNAL_EVENT_WAIT";
    tsk->type = captureWait ? TS_TASK_TYPE_CAPTURE_WAIT : TS_TASK_TYPE_MEM_WAIT_VALUE;
    error = MemWaitValueTaskInit(tsk, eventAddr, 1UL, 0U);
    ERROR_RETURN_MSG_INNER(error, "Failed to initialize mem wait task, retCode=%#x.", static_cast<uint32_t>(error));
    MemWaitValueTaskInfo* const memWaitValueTask = &tsk->u.memWaitValueTask;
    memWaitValueTask->event = event;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    if (!captureWait) {
        const int32_t eventId = event->EventId_();
        event->EventIdCountAdd(eventId);
        memWaitValueTask->retainedEventId = eventId;
    }
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit mem wait task, retCode=%#x.", static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;
}

rtError_t Event::RecordSoftwareEvent(Stream* const stm)
{
    rtError_t error = RT_ERROR_NONE;
    void* eventAddr = nullptr;
    rtError_t errorReason;
    int32_t newEventId = INVALID_EVENT_ID;
    Device* const dev = stm->Device_();
    TaskInfo submitTask = {};
    TaskInfo* tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_EVENT_RECORD, errorReason);
    COND_RETURN_ERROR_MSG_INNER(
        (tsk == nullptr), errorReason, "Failed to alloc task when event record, stream_id=%d.", stm->Id_());
    std::function<void()> const errRecycle = [&dev, &tsk]() { (void)dev->GetTaskFactory()->Recycle(tsk); };
    ScopeGuard tskErrRecycle(errRecycle);
    error = dev->AllocExpandingPoolEvent(&eventAddr, &newEventId);
    ERROR_RETURN_MSG_INNER(
        error, "Capture addr error, deviceId=%u, tsId=%u, retCode=%#x.", device_->Id_(), device_->DevGetTsId(), error);
    PublishSoftwareRecordResource(eventAddr, newEventId);
    (void)MemWriteValueTaskInit(tsk, eventAddr, static_cast<uint64_t>(1U));
    tsk->typeName = "EVENT_RECORD";
    tsk->type = (!stm->GetBindFlag()) ? TS_TASK_TYPE_MEM_WRITE_VALUE : TS_TASK_TYPE_CAPTURE_RECORD;
    MemWriteValueTaskInfo* memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->event = this;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit capture task, retCode=%#x.", static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    SetRecord(true);
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    RT_LOG(
        RT_LOG_INFO, "capture event task submit success, device_id=%u, stream_id=%d, task_id=%d, event_id=%d",
        device_->Id_(), stm->Id_(), tsk->id, eventId_);
    return error;
}

rtError_t Event::CaptureWaitProcess(Stream* const stm)
{
    const rtError_t error = SubmitMemWaitValueTask(this, stm, true);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit wait task, retCode=%#x.", static_cast<uint32_t>(error));
    RT_LOG(
        RT_LOG_INFO, "Capture wait task submit success, device_id=%u, stream_id=%d, task_id=%d, event_id=%d",
        device_->Id_(), stm->Id_(), stm->GetLastTaskId(), eventId_);
    return error;
}

rtError_t Event::ExternalEventWaitProcess(Stream* const stm)
{
    const rtError_t error = SubmitMemWaitValueTask(this, stm, false);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit mem wait task, retCode=%#x.", static_cast<uint32_t>(error));
    RT_LOG(
        RT_LOG_INFO, "External event wait task submit success, device_id=%u, stream_id=%d, task_id=%d, event_id=%d",
        device_->Id_(), stm->Id_(), stm->GetLastTaskId(), eventId_);
    return RT_ERROR_NONE;
}

rtError_t Event::ResetSoftwareEvent(Stream* const stm)
{
    void* eventAddr = this->GetEventAddr();
    COND_RETURN_ERROR_MSG_INNER(
        eventAddr == nullptr, RT_ERROR_EVENT_RECORDER_NULL, "eventAddr is null, event_id=%d.", EventId_());
    rtError_t errorReason;
    Device* const dev = stm->Device_();
    TaskInfo submitTask = {};
    TaskInfo* tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_EVENT_RESET, errorReason);
    COND_RETURN_ERROR_MSG_INNER(
        (tsk == nullptr), errorReason, "Alloc task failed, retCode=%#x.", static_cast<uint32_t>(errorReason));
    std::function<void()> const errRecycle = [&dev, &tsk]() { (void)dev->GetTaskFactory()->Recycle(tsk); };
    ScopeGuard tskErrRecycle(errRecycle);

    (void)MemWriteValueTaskInit(tsk, eventAddr, static_cast<uint64_t>(0));
    tsk->typeName = "EVENT_RESET";
    tsk->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    MemWriteValueTaskInfo* memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    memWriteValueTask->event = this;
    const rtError_t error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit reset task, retCode=%#x.", static_cast<uint32_t>(error));
    // capture场景下reset任务在图执行时写0，这里只更新host侧software event状态，供后续external wait绑定判断。
    SetHasReset(true);
    RT_LOG(
        RT_LOG_INFO, "reset task submit, device_id=%u, stream_id=%d, task_id=%d, event_id=%d", device_->Id_(),
        stm->Id_(), tsk->id, eventId_);
    tskErrRecycle.ReleaseGuard();
    return error;
}

} // namespace runtime
} // namespace cce
