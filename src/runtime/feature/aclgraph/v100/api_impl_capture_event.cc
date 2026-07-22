/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"
#include "context.hpp"
#include "event.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "internal_error_define.hpp"

namespace cce {
namespace runtime {

static rtError_t SubmitExternalEventTask(Event* const evt, Stream* const stm, const bool isRecord)
{
    return SubmitExternalEventTaskCommon(
        evt, stm, isRecord, [](Device* dev, TaskInfo* task) { return dev->SubmitTask(task); });
}

rtError_t ApiImpl::GetCaptureEvent(
    const Stream* const stm, Event* const evt, Event** const captureEvt, const bool isNewEvt)
{
    std::lock_guard<std::mutex> lock(evt->GetCaptureMutex());
    Event* curEvent = evt->GetCaptureEvent();
    if ((!isNewEvt) && (curEvent != nullptr)) {
        RT_LOG(
            RT_LOG_INFO, "Capture event has been created, event_id=[%d->%d].", evt->EventId_(), curEvent->EventId_());
        *captureEvt = curEvent;
        return RT_ERROR_NONE;
    }
    rtError_t error = RT_ERROR_NONE;
    const int32_t eventId = (curEvent != nullptr) ? curEvent->EventId_() : INVALID_EVENT_ID;
    Stream* captureStm = stm->GetCaptureStream();
    COND_RETURN_ERROR_MSG_INNER(
        (captureStm == nullptr), RT_ERROR_STREAM_NULL, "Capture stream is invalid, stream_id=%d, event_id=[%d->%d].",
        stm->Id_(), evt->EventId_(), eventId);

    Model* mdl = captureStm->Model_();
    COND_RETURN_ERROR_MSG_INNER(
        (mdl == nullptr), RT_ERROR_MODEL_NULL, "Capture model is invalid, stream_id=[%d->%d], event_id=[%d->%d].",
        stm->Id_(), captureStm->Id_(), evt->EventId_(), eventId);

    Event* newEvent = nullptr;
    const bool isHardwareEvent = IsUseHardwareEvent(stm->Device_());
    if (isHardwareEvent) {
        error = EventCreate(&newEvent, RT_EVENT_WITH_FLAG);
    } else {
        error = EventCreateEx(&newEvent, RT_EVENT_WITH_FLAG);
    }

    COND_RETURN_ERROR_MSG_INNER(
        (error != RT_ERROR_NONE || newEvent == nullptr), error,
        "Create capture event failed, stream_id=[%d->%d], event_id=[%d->%d], error=%d.", stm->Id_(), captureStm->Id_(),
        evt->EventId_(), eventId, error);

    if (!isHardwareEvent) {
        newEvent->SoftwareModeEnable();
    }
    evt->SetCaptureEvent(newEvent);
    CaptureModel* captureMdl = dynamic_cast<CaptureModel*>(mdl);
    captureMdl->InsertSingleOperEvent(evt);
    newEvent->SetCaptureStream(captureStm);
    captureMdl->InsertCaptureEvent(newEvent);

    RT_LOG(
        RT_LOG_INFO, "Capture event_id=[%d->%d], model_id=%u, isNewEvt=%d, stream_id=[%d->%d].",
        ((curEvent != nullptr) ? eventId : evt->EventId_()), newEvent->EventId_(), captureMdl->Id_(), isNewEvt,
        stm->Id_(), captureStm->Id_());
    *captureEvt = newEvent;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CaptureEventWait(Context* const ctx, Stream* const stm, Event* const evt, const uint32_t timeout)
{
    Stream* captureStm = nullptr;
    rtError_t error = GetCaptureStream(ctx, stm, evt, &captureStm);
    ERROR_RETURN_MSG_INNER(
        error, "Create capture stream failed, stream_id=%d, event_id=%d, error=%d.", stm->Id_(), evt->EventId_(),
        error);
    Event* captureEvt = nullptr;
    error = GetCaptureEvent(stm, evt, &captureEvt);
    ERROR_RETURN_MSG_INNER(
        error, "Create capture event failed, stream_id=%d, event_id=%d, error=%d.", stm->Id_(), evt->EventId_(), error);
    COND_RETURN_ERROR_MSG_INNER(
        IsCrossCaptureModel(captureEvt, captureStm), RT_ERROR_STREAM_CAPTURE_CONFLICT,
        "Capture event and capture stream is cross-model.");

    error = stm->WaitEvent(captureEvt, timeout);
    ERROR_RETURN_MSG_INNER(
        error, "Capture stream wait event failed, stream_id=[%d->%d], error=%d.", stm->Id_(), captureStm->Id_(), error);
    captureEvt->InsertWaitTaskStream(captureStm);
    RT_LOG(
        RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].", stm->Id_(), captureStm->Id_(), evt->EventId_(),
        captureEvt->EventId_());
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CaptureExternalEventWait(Event* const evt, Stream* const stm) const
{
    return SubmitExternalEventTask(evt, stm, false);
}

rtError_t ApiImpl::CaptureExternalEventRecord(Event* const evt, Stream* const stm) const
{
    return SubmitExternalEventTask(evt, stm, true);
}

rtError_t ApiImpl::CaptureEventRecord(Context* const ctx, Event* const evt, Stream* const stm)
{
    Stream* captureStm = nullptr;
    rtError_t error = GetCaptureStream(ctx, stm, evt, &captureStm);
    ERROR_RETURN_MSG_INNER(
        error, "Create capture stream failed, stream_id=%d, event_id=%d, error=%d.", stm->Id_(), evt->EventId_(),
        error);

    bool isNewEvt = false;
    bool isHardwareMode;
    if (evt->GetCaptureEvent() != nullptr) {
        isHardwareMode = evt->GetCaptureEvent()->IsHardwareMode();
    } else {
        isHardwareMode = IsUseHardwareEvent(stm->Device_());
    }

    if (isHardwareMode) {
        Event* const captureEvt = evt->GetCaptureEvent();
        if ((captureEvt == nullptr) || (!(captureEvt->HasRecord()))) {
            evt->InitEventAllocFlag(stm->Id_());
        }
        if ((captureEvt == nullptr) || (captureEvt->HasRecord())) {
            isNewEvt = evt->IsIdAllocFromDrv();
        }
    } else {
        isNewEvt = true;
    }

    Event* captureEvt = nullptr;
    error = GetCaptureEvent(stm, evt, &captureEvt, isNewEvt);
    ERROR_RETURN_MSG_INNER(
        error, "Create capture event failed, stream_id=%d, event_id=%d, error=%d.", stm->Id_(), evt->EventId_(), error);

    COND_RETURN_ERROR_MSG_INNER(
        IsCrossCaptureModel(captureEvt, captureStm), RT_ERROR_STREAM_CAPTURE_CONFLICT,
        "Capture event and capture stream is cross-model.");

    error = captureEvt->Record(stm, true);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Stream record capture event failed, stream_id=[%d->%d], error=%d.", stm->Id_(),
            captureStm->Id_(), error);
    } else {
        RT_LOG(
            RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].", stm->Id_(), captureStm->Id_(), evt->EventId_(),
            captureEvt->EventId_());
    }
    return error;
}

rtError_t ApiImpl::CaptureEventReset(const Event* const evt, Stream* const stm)
{
    Event* const captureEvt = evt->GetCaptureEvent();
    NULL_PTR_RETURN_MSG(captureEvt, RT_ERROR_EVENT_NULL);

    const Stream* const captureStm = stm->GetCaptureStream();
    NULL_STREAM_PTR_RETURN_MSG(captureStm);

    COND_RETURN_ERROR_MSG_INNER(
        IsCrossCaptureModel(captureEvt, captureStm), RT_ERROR_STREAM_CAPTURE_CONFLICT,
        "Capture event and capture stream is cross-model.");

    const rtError_t error = captureEvt->Reset(stm);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Stream reset capture event failed, stream_id=[%d->%d], error=%d.", stm->Id_(),
            captureStm->Id_(), error);
    } else {
        RT_LOG(
            RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].", stm->Id_(), captureStm->Id_(), evt->EventId_(),
            captureEvt->EventId_());
    }
    return error;
}

} // namespace runtime
} // namespace cce
