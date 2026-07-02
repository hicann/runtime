/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_david.hpp"
#include "context.hpp"
#include "event_c.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "common_task.h"
#include "memory_task.h"
#include "task_david.hpp"

namespace cce {
namespace runtime {

namespace {
rtError_t CreateExternalWaitPlaceholder(Event* const evt, Stream* const stm)
{
    Device* const dev = stm->Device_();
    TaskInfo submitTask = {};
    submitTask.type = TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL;
    rtError_t errorReason = RT_ERROR_NONE;
    TaskInfo* tsk = stm->AllocTask(
        &submitTask, TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL, errorReason, GetSendSqeNum(&submitTask));
    COND_RETURN_ERROR_MSG_INNER(
        tsk == nullptr, errorReason, "Alloc external event wait task failed, stream_id=%d, retCode=%#x.", stm->Id_(),
        errorReason);
    std::function<void()> const errRecycle = [&dev, &tsk]() { (void)dev->GetTaskFactory()->Recycle(tsk); };
    ScopeGuard tskErrRecycle(errRecycle);
    tsk->typeName = "CAPTURE_WAIT_EXTERNAL";
    tsk->type = TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL;
    MemWaitValueTaskInfo* memWaitValueTask = &tsk->u.memWaitValueTask;
    memWaitValueTask->value = 1U;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    memWaitValueTask->event = evt;
    tsk->sqeNum = static_cast<uint8_t>(GetSendSqeNum(tsk));
    const rtError_t error = DavidSendTask(tsk, tsk->stream);
    ERROR_RETURN_MSG_INNER(
        error, "Submit external wait placeholder failed, stream_id=%d, task_id=%hu, retCode=%#x.", stm->Id_(), tsk->id,
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;
}

rtError_t CreateExternalRecordPlaceholder(Stream* const stm)
{
    Device* const dev = stm->Device_();
    TaskInfo submitTask = {};
    submitTask.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    rtError_t errorReason = RT_ERROR_NONE;
    TaskInfo* tsk = stm->AllocTask(
        &submitTask, TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL, errorReason, GetSendSqeNum(&submitTask));
    COND_RETURN_ERROR_MSG_INNER(
        tsk == nullptr, errorReason, "Alloc external event record task failed, stream_id=%d, retCode=%#x.", stm->Id_(),
        errorReason);
    std::function<void()> const errRecycle = [&dev, &tsk]() { (void)dev->GetTaskFactory()->Recycle(tsk); };
    ScopeGuard tskErrRecycle(errRecycle);
    rtError_t error = CaptureRecordExternalTaskInit(tsk, nullptr, TASK_WR_CQE_DEFAULT);
    ERROR_RETURN_MSG_INNER(
        error, "Init external record task failed, stream_id=%d, task_id=%hu, retCode=%#x.", stm->Id_(), tsk->id,
        static_cast<uint32_t>(error));
    tsk->sqeNum = static_cast<uint8_t>(GetSendSqeNum(tsk));
    error = DavidSendTask(tsk, tsk->stream);
    ERROR_RETURN_MSG_INNER(
        error, "Submit external record placeholder failed, stream_id=%d, task_id=%hu, retCode=%#x.", stm->Id_(),
        tsk->id, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;
}

rtError_t RegisterExternalEventTask(Event* const evt, Stream* const stm, const bool isRecord)
{
    NULL_PTR_RETURN_MSG(evt, RT_ERROR_EVENT_NULL);
    NULL_STREAM_PTR_RETURN_MSG(stm);

    Stream* const captureStm = stm->GetCaptureStream();
    NULL_STREAM_PTR_RETURN_MSG(captureStm);
    Model* const mdl = captureStm->Model_();
    NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODEL_NULL);
    CaptureModel* const captureMdl = dynamic_cast<CaptureModel*>(mdl);
    NULL_PTR_RETURN_MSG(captureMdl, RT_ERROR_MODEL_NULL);

    rtError_t error = evt->TrySwitchToSoftwareMode();
    ERROR_RETURN_MSG_INNER(error, "Switch event to software mode failed, retCode=%#x.", error);
    if (isRecord) {
        error = CreateExternalRecordPlaceholder(stm);
        ERROR_RETURN_MSG_INNER(error, "Create external record placeholder failed, retCode=%#x.", error);
    } else {
        error = CreateExternalWaitPlaceholder(evt, stm);
        ERROR_RETURN_MSG_INNER(error, "Create external wait placeholder failed, retCode=%#x.", error);
    }
    const uint32_t taskId = captureStm->GetLastTaskId();
    error = isRecord ? captureMdl->AddExternalRecordEvent(evt, static_cast<uint32_t>(captureStm->Id_()), taskId) :
                       captureMdl->AddExternalWaitEvent(evt, static_cast<uint32_t>(captureStm->Id_()), taskId);
    ERROR_RETURN_MSG_INNER(error, "Register external event task failed, retCode=%#x.", error);
    return RT_ERROR_NONE;
}
} // namespace

rtError_t ApiImplDavid::GetCaptureEvent(const Stream * const stm, Event * const evt, Event ** const captureEvt, const bool isNewEvt)
{
    std::lock_guard<std::mutex> lock(evt->GetCaptureMutex());
    Event *curEvent = evt->GetCaptureEvent();
    if ((!isNewEvt) && (curEvent != nullptr)) {
        RT_LOG(RT_LOG_INFO, "Capture event has been created, event_id=[%d->%d].",
            evt->EventId_(), curEvent->EventId_());
        *captureEvt = curEvent;
        return RT_ERROR_NONE;
    }

    Stream *captureStm = stm->GetCaptureStream();
    COND_RETURN_ERROR_MSG_INNER((captureStm == nullptr), RT_ERROR_STREAM_NULL,
        "Capture stream is invalid, stream_id=%d, event_id=%d.", stm->Id_(), evt->EventId_());

    Model* mdl = captureStm->Model_();
    COND_RETURN_ERROR_MSG_INNER((mdl == nullptr), RT_ERROR_MODEL_NULL,
        "Capture model is invalid, stream_id=[%d->%d], event_id=%d.", stm->Id_(), captureStm->Id_(), evt->EventId_());

    Event *newEvent = nullptr;
    rtError_t error;
    const bool isHardwareEvent = IsUseHardwareEvent(stm->Device_());
    if (isHardwareEvent) {
         // hardware mode, use single bit notify
        error = EventCreate(&newEvent, RT_EVENT_WITH_FLAG);
    } else {
        // software mode, use memory wait
        error = EventCreate(&newEvent, RT_EVENT_DEFAULT);
    }
    COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE || newEvent == nullptr), error,
        "Create capture event failed, stream_id=[%d->%d], event_id=%d, error=%d.",
        stm->Id_(), captureStm->Id_(), evt->EventId_(), error);

    if (!isHardwareEvent) {
        newEvent->SoftwareModeEnable();
    }
    evt->SetCaptureEvent(newEvent);
    CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(mdl);
    captureMdl->InsertSingleOperEvent(evt);
    newEvent->SetCaptureStream(captureStm);
    captureMdl->InsertCaptureEvent(newEvent);

    RT_LOG(RT_LOG_INFO, "Capture event_id=[%d->%d], model_id=%u, stream_id=[%d->%d].",
        evt->EventId_(), newEvent->EventId_(), captureMdl->Id_(), stm->Id_(), captureStm->Id_());
    *captureEvt = newEvent;
    return RT_ERROR_NONE;
}
rtError_t ApiImplDavid::CaptureRecordEvent(Context * const ctx, Event * const evt, Stream * const stm)
{
    Stream *captureStm = nullptr;
    rtError_t error = GetCaptureStream(ctx, stm, evt, &captureStm);
    ERROR_RETURN_MSG_INNER(error, "Create capture stream failed, stream_id=%d, event_id=%d, error=%d.",
            stm->Id_(), evt->EventId_(), error);

    Event *captureEvt = nullptr;
    error = GetCaptureEvent(stm, evt, &captureEvt, true);
    ERROR_RETURN_MSG_INNER(error, "Create capture event failed, stream_id=%d, event_id=%d, error=%d.",
        stm->Id_(), evt->EventId_(), error);

    COND_RETURN_ERROR_MSG_INNER(IsCrossCaptureModel(captureEvt, captureStm),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture event and capture stream is cross-model.");

    if (captureEvt->IsHardwareMode()) {
        error = EvtRecord(captureEvt, stm);
    } else {
        error = EvtRecordSoftwareMode(captureEvt, stm);
    }
    
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,
            "Stream record capture event failed, stream_id=[%d->%d], error=%d.",
            stm->Id_(), captureStm->Id_(), error);
    } else {
        const Stream * const newCaptureStm = stm->GetCaptureStream();
        RT_LOG(RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].",
            stm->Id_(), newCaptureStm->Id_(), evt->EventId_(), captureEvt->EventId_());
    }

    return error;
}
rtError_t ApiImplDavid::CaptureResetEvent(const Event * const evt, Stream * const stm)
{
    Event * const captureEvt = evt->GetCaptureEvent();
    NULL_PTR_RETURN_MSG(captureEvt, RT_ERROR_EVENT_NULL);

    const Stream * const captureStm = stm->GetCaptureStream();
    NULL_STREAM_PTR_RETURN_MSG(captureStm);

    COND_RETURN_ERROR_MSG_INNER(IsCrossCaptureModel(captureEvt, captureStm),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture event and capture stream is cross-model.");

    rtError_t error;
    if (captureEvt->IsHardwareMode()) {
        error = EvtReset(captureEvt, stm);
    } else {
        error = EvtResetSoftwareMode(captureEvt, stm);
    }
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,
            "Stream reset capture event failed, stream_id=[%d->%d], error=%d.",
            stm->Id_(), captureStm->Id_(), error);
    } else {
        const Stream * const newCaptureStm = stm->GetCaptureStream();
        RT_LOG(RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].",
            stm->Id_(), newCaptureStm->Id_(), evt->EventId_(), captureEvt->EventId_());
    }
    return error;
}
rtError_t ApiImplDavid::CaptureWaitEvent(Context * const ctx, Stream * const stm, Event * const evt,
    const uint32_t timeout)
{
    Stream *captureStm = nullptr;
    rtError_t error = GetCaptureStream(ctx, stm, evt, &captureStm);
    ERROR_RETURN_MSG_INNER(error, "Create capture stream failed, stream_id=%d, event_id=%d, error=%d.",
        stm->Id_(), evt->EventId_(), error);

    Event *captureEvt = nullptr;
    error = GetCaptureEvent(stm, evt, &captureEvt);
    ERROR_RETURN_MSG_INNER(error, "Create capture event failed, stream_id=%d, event_id=%d, error=%d.",
        stm->Id_(), evt->EventId_(), error);

    COND_RETURN_ERROR_MSG_INNER(IsCrossCaptureModel(captureEvt, captureStm),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture event and capture stream is cross-model.");
    if (captureEvt->IsHardwareMode()) {
        error = EvtWait(captureEvt, stm, timeout);
    } else {
        error = EvtWaitSoftwareMode(captureEvt, stm);
    }
    ERROR_RETURN_MSG_INNER(error, "Capture stream wait event failed, stream_id=[%d->%d], error=%d.",
        stm->Id_(), captureStm->Id_(), error);
    captureEvt->InsertWaitTaskStream(captureStm);
    Stream * const newCaptureStm = stm->GetCaptureStream();
    RT_LOG(RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].",
        stm->Id_(), newCaptureStm->Id_(), evt->EventId_(), captureEvt->EventId_());
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::Starsv2CaptureExternalEventRecord(Event* const evt, Stream* const stm) const
{
    return RegisterExternalEventTask(evt, stm, true);
}

rtError_t ApiImplDavid::Starsv2CaptureExternalEventWait(Event* const evt, Stream* const stm) const
{
    return RegisterExternalEventTask(evt, stm, false);
}

} // namespace runtime
} // namespace cce
