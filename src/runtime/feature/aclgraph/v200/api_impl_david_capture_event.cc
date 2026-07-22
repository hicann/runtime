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
#include "internal_error_define.hpp"
#include "task_david.hpp"

namespace cce {
namespace runtime {

static rtError_t SubmitExternalEventTask(Event* const evt, Stream* const stm, const bool isRecord)
{
    return SubmitExternalEventTaskCommon(
        evt, stm, isRecord, [](Device*, TaskInfo* task) { return DavidSendTask(task, task->stream); });
}

rtError_t ApiImplDavid::GetCaptureEvent(
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

    Stream* captureStm = stm->GetCaptureStream();
    COND_RETURN_ERROR_MSG_INNER(
        (captureStm == nullptr), RT_ERROR_STREAM_NULL, "Capture stream is invalid, stream_id=%d, event_id=%d.",
        stm->Id_(), evt->EventId_());

    Model* mdl = captureStm->Model_();
    COND_RETURN_ERROR_MSG_INNER(
        (mdl == nullptr), RT_ERROR_MODEL_NULL, "Capture model is invalid, stream_id=[%d->%d], event_id=%d.", stm->Id_(),
        captureStm->Id_(), evt->EventId_());

    Event* newEvent = nullptr;
    rtError_t error;
    const bool isHardwareEvent = IsUseHardwareEvent(stm->Device_());
    if (isHardwareEvent) {
        // hardware mode, use single bit notify
        error = EventCreate(&newEvent, RT_EVENT_WITH_FLAG);
    } else {
        // software mode, use memory wait
        error = EventCreate(&newEvent, RT_EVENT_DEFAULT);
    }
    COND_RETURN_ERROR_MSG_INNER(
        (error != RT_ERROR_NONE || newEvent == nullptr), error,
        "Create capture event failed, stream_id=[%d->%d], event_id=%d, error=%d.", stm->Id_(), captureStm->Id_(),
        evt->EventId_(), error);

    if (!isHardwareEvent) {
        newEvent->SoftwareModeEnable();
    }
    evt->SetCaptureEvent(newEvent);
    CaptureModel* captureMdl = dynamic_cast<CaptureModel*>(mdl);
    captureMdl->InsertSingleOperEvent(evt);
    newEvent->SetCaptureStream(captureStm);
    captureMdl->InsertCaptureEvent(newEvent);

    RT_LOG(
        RT_LOG_INFO, "Capture event_id=[%d->%d], model_id=%u, stream_id=[%d->%d].", evt->EventId_(),
        newEvent->EventId_(), captureMdl->Id_(), stm->Id_(), captureStm->Id_());
    *captureEvt = newEvent;
    return RT_ERROR_NONE;
}
rtError_t ApiImplDavid::CaptureRecordEvent(Context* const ctx, Event* const evt, Stream* const stm)
{
    Stream* captureStm = nullptr;
    rtError_t error = GetCaptureStream(ctx, stm, evt, &captureStm);
    ERROR_RETURN_MSG_INNER(
        error, "Create capture stream failed, stream_id=%d, event_id=%d, error=%d.", stm->Id_(), evt->EventId_(),
        error);

    Event* captureEvt = nullptr;
    error = GetCaptureEvent(stm, evt, &captureEvt, true);
    ERROR_RETURN_MSG_INNER(
        error, "Create capture event failed, stream_id=%d, event_id=%d, error=%d.", stm->Id_(), evt->EventId_(), error);

    COND_RETURN_ERROR_MSG_INNER(
        IsCrossCaptureModel(captureEvt, captureStm), RT_ERROR_STREAM_CAPTURE_CONFLICT,
        "Capture event and capture stream is cross-model.");

    if (captureEvt->IsHardwareMode()) {
        error = EvtRecord(captureEvt, stm);
    } else {
        error = EvtRecordSoftwareMode(captureEvt, stm);
    }

    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Stream record capture event failed, stream_id=[%d->%d], error=%d.", stm->Id_(),
            captureStm->Id_(), error);
    } else {
        const Stream* const newCaptureStm = stm->GetCaptureStream();
        RT_LOG(
            RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].", stm->Id_(), newCaptureStm->Id_(), evt->EventId_(),
            captureEvt->EventId_());
    }

    return error;
}
rtError_t ApiImplDavid::CaptureResetEvent(const Event* const evt, Stream* const stm)
{
    Event* const captureEvt = evt->GetCaptureEvent();
    NULL_PTR_RETURN_MSG(captureEvt, RT_ERROR_EVENT_NULL);

    const Stream* const captureStm = stm->GetCaptureStream();
    NULL_STREAM_PTR_RETURN_MSG(captureStm);

    COND_RETURN_ERROR_MSG_INNER(
        IsCrossCaptureModel(captureEvt, captureStm), RT_ERROR_STREAM_CAPTURE_CONFLICT,
        "Capture event and capture stream is cross-model.");

    rtError_t error;
    if (captureEvt->IsHardwareMode()) {
        error = EvtReset(captureEvt, stm);
    } else {
        error = EvtResetSoftwareMode(captureEvt, stm);
    }
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Stream reset capture event failed, stream_id=[%d->%d], error=%d.", stm->Id_(),
            captureStm->Id_(), error);
    } else {
        const Stream* const newCaptureStm = stm->GetCaptureStream();
        RT_LOG(
            RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].", stm->Id_(), newCaptureStm->Id_(), evt->EventId_(),
            captureEvt->EventId_());
    }
    return error;
}
rtError_t ApiImplDavid::CaptureWaitEvent(
    Context* const ctx, Stream* const stm, Event* const evt, const uint32_t timeout)
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
    if (captureEvt->IsHardwareMode()) {
        error = EvtWait(captureEvt, stm, timeout);
    } else {
        error = EvtWaitSoftwareMode(captureEvt, stm);
    }
    ERROR_RETURN_MSG_INNER(
        error, "Capture stream wait event failed, stream_id=[%d->%d], error=%d.", stm->Id_(), captureStm->Id_(), error);
    captureEvt->InsertWaitTaskStream(captureStm);
    Stream* const newCaptureStm = stm->GetCaptureStream();
    RT_LOG(
        RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].", stm->Id_(), newCaptureStm->Id_(), evt->EventId_(),
        captureEvt->EventId_());
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::Starsv2CaptureExternalEventRecord(Event* const evt, Stream* const stm) const
{
    return SubmitExternalEventTask(evt, stm, true);
}

rtError_t ApiImplDavid::Starsv2CaptureExternalEventWait(Event* const evt, Stream* const stm) const
{
    return SubmitExternalEventTask(evt, stm, false);
}

} // namespace runtime
} // namespace cce
