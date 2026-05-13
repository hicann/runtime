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

rtError_t Event::CaptureEventProcess(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    void *eventAddr = nullptr;
    rtError_t errorReason;
    int32_t newEventId = INVALID_EVENT_ID;
    Device * const dev = stm->Device_();
    TaskInfo submitTask = {};
    TaskInfo *tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_EVENT_RECORD, errorReason);
    COND_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
                                "Failed to alloc task when event record, stream_id=%d.", stm->Id_());
    std::function<void()> const errRecycle = [&dev, &tsk]() {
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    error = dev->AllocExpandingPoolEvent(&eventAddr, &newEventId);
    ERROR_RETURN_MSG_INNER(error, "Capture addr error, deviceId=%u, tsId=%u, retCode=%#x.",
                            device_->Id_(), device_->DevGetTsId(), error);
    eventAddr_ = eventAddr;
    eventId_ = newEventId;
    (void)MemWriteValueTaskInit(tsk, eventAddr, static_cast<uint64_t>(1U));
    tsk->typeName = "EVENT_RECORD";
    tsk->type = TS_TASK_TYPE_CAPTURE_RECORD;
    MemWriteValueTaskInfo *memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->event = this;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit capture task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    SetRecord(true);
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    RT_LOG(RT_LOG_INFO, "capture event task submit success, device_id=%u, stream_id=%d, task_id=%d, event_id=%d",
        device_->Id_(), stm->Id_(), tsk->id, eventId_);
    return error;
}

rtError_t Event::CaptureWaitProcess(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    Device * const dev = stm->Device_();
    TaskInfo *tsk = nullptr;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_STREAM_WAIT_EVENT, errorReason, MEM_WAIT_SQE_NUM);
    COND_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
        "task alloc fail err:%#x", static_cast<uint32_t>(errorReason));
    std::function<void()> const errRecycle = [&dev, &tsk]() {
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    void *eventAddr = this->GetEventAddr();
 	COND_RETURN_ERROR_MSG_INNER(eventAddr == nullptr, RT_ERROR_EVENT_RECORDER_NULL,
        "eventAddr is null, event_id=%d.", EventId_());

    tsk->typeName = "EVENT_WAIT";
    tsk->type = TS_TASK_TYPE_CAPTURE_WAIT;
    error = MemWaitValueTaskInit(tsk, eventAddr, 1, 0x0);
    ERROR_RETURN_MSG_INNER(error, "mem wait value init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        stm->Id_(), tsk->id, static_cast<uint32_t>(error));
    MemWaitValueTaskInfo *memWaitValueTask = &tsk->u.memWaitValueTask;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    memWaitValueTask->event = this;
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit wait task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    RT_LOG(RT_LOG_INFO, "capture wait task submit success, device_id=%u, stream_id=%d, task_id=%d, event_id=%d",
        device_->Id_(), stm->Id_(), tsk->id, eventId_);
    return error;
}

rtError_t Event::CaptureResetProcess(Stream * const stm)
{
    void *eventAddr = this->GetEventAddr();
 	COND_RETURN_ERROR_MSG_INNER(eventAddr == nullptr, RT_ERROR_EVENT_RECORDER_NULL, 
        "eventAddr is null, event_id=%d.", EventId_());
    rtError_t errorReason;
    Device * const dev = stm->Device_();
    TaskInfo submitTask = {};
    TaskInfo *tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_EVENT_RESET, errorReason);
    COND_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
                                "task alloc fail err:%#x",
                                     static_cast<uint32_t>(errorReason));
    std::function<void()> const errRecycle = [&dev, &tsk]() {
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    
    (void)MemWriteValueTaskInit(tsk, eventAddr, static_cast<uint64_t>(0));
    tsk->typeName = "EVENT_RESET";
    tsk->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    MemWriteValueTaskInfo *memWriteValueTask = &tsk->u.memWriteValueTask;
 	memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    memWriteValueTask->event = this;
 	const rtError_t error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit reset task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "reset task submit, device_id=%u, stream_id=%d, task_id=%d, event_id=%d", device_->Id_(), stm->Id_(), tsk->id, eventId_);
    tskErrRecycle.ReleaseGuard();
    return error;
}


} // namespace runtime
} // namespace cce
