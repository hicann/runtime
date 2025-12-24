/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "capture_model_utils.hpp"

namespace cce {
namespace runtime {
bool IsEventCapturing(const Event * const evt, const Stream * const stm)
{
    if (evt->GetEventFlag() == RT_EVENT_EXTERNAL) {
        return false;
    }
    CaptureModel *mdl = nullptr;
    const Event *captureEvt = evt->GetCaptureEvent();
    if (captureEvt != nullptr) {
         const Stream *captureEvtStm = captureEvt->GetCaptureStream();
         if (captureEvtStm != nullptr) {
            mdl = dynamic_cast<CaptureModel *>(captureEvtStm->Model_());
            if ((mdl != nullptr) && (mdl->IsCapturing())) {
                return true;
            }
         }
    }
    const Stream *captureStm = stm->GetCaptureStream();
    if (captureStm != nullptr) {
        mdl = dynamic_cast<CaptureModel *>(captureStm->Model_());
        if ((mdl != nullptr) && (mdl->IsCapturing())) {
            return true;
        }
    }
    return false;
}

bool IsCrossCaptureModel(const Event * const evt, const Stream * const stm)
{
    CaptureModel *evtMdl = nullptr;
    const Stream * const captureStm = evt->GetCaptureStream();
    if (captureStm != nullptr) {
        evtMdl = dynamic_cast<CaptureModel *>(captureStm->Model_());
    }
    CaptureModel *stmMdl = dynamic_cast<CaptureModel *>(stm->Model_());
    // stmMdl and evtMdl must not be nullptr at this time.
    return (stmMdl != evtMdl);
}

void TerminateCapture(const Event * const evt, const Stream * const stm)
{
    CaptureModel *stmMdl = nullptr;
    const Stream *captureStm = stm->GetCaptureStream();
    if (captureStm != nullptr) {
        stmMdl = dynamic_cast<CaptureModel *>(captureStm->Model_());
    }
    CaptureModel *evtMdl = evt->GetCaptureModel();
    if (evtMdl != nullptr) {
        evtMdl->TerminateCapture();
    }
    if ((stmMdl != nullptr) && (stmMdl != evtMdl)) {
        stmMdl->TerminateCapture();
    }
}

rtError_t GetCaptureStream(Context * const ctx, Stream * const stm, const Event * const evt, Stream ** const captureStm)
{
    Stream *curStm = stm->GetCaptureStream();
    if (curStm != nullptr) {
        *captureStm = curStm;
        RT_LOG(RT_LOG_INFO, "Capture stream has been created, stream_id=[%d->%d].",
            stm->Id_(), curStm->Id_());
        return RT_ERROR_NONE;
    }

    Event *captureEvt = evt->GetCaptureEvent();
    COND_RETURN_ERROR_MSG_INNER((captureEvt == nullptr), RT_ERROR_EVENT_NULL,
        "Capture event is invalid, stream_id=%d, event_id=%d.",
        stm->Id_(), evt->EventId_());

    Stream *evtCaptureStm = captureEvt->GetCaptureStream();
    COND_RETURN_ERROR_MSG_INNER(evtCaptureStm == nullptr, RT_ERROR_MODEL_NULL,
        "Event capture stream is invalid, stream_id=%d, event_id=[%d->%d].",
        stm->Id_(), evt->EventId_(), captureEvt->EventId_());

    CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(evtCaptureStm->Model_());
    COND_RETURN_ERROR_MSG_INNER(captureMdl == nullptr, RT_ERROR_MODEL_NULL,
        "Capture model is invalid, stream_id=%d, event_id=[%d->%d].",
        stm->Id_(), evt->EventId_(), captureEvt->EventId_());

    const rtError_t error = ctx->StreamAddToCaptureModelProc(stm, captureMdl);
    ERROR_RETURN_MSG_INNER(error, "New capture stream failed, stream_id=%d, event_id=[%d->%d].",
        stm->Id_(), evt->EventId_(), captureEvt->EventId_());

    curStm = stm->GetCaptureStream();
    COND_RETURN_ERROR_MSG_INNER(curStm == nullptr, RT_ERROR_STREAM_NULL,
        "Capture stream is invalid, stream_id=%d, event_id=[%d->%d].",
        stm->Id_(), evt->EventId_(), captureEvt->EventId_());

    RT_LOG(RT_LOG_INFO, "Capture event_id=%d, stream_id=[%d->%d] bounded to model_id=%u.",
        captureEvt->EventId_(), stm->Id_(), curStm->Id_(), captureMdl->Id_());
    *captureStm = curStm;
    return RT_ERROR_NONE;
}

bool IsCapturedTask(const Stream * const launchStm, const TaskInfo *submitTask)
{
    return (launchStm != submitTask->stream);
}

rtError_t CheckCaptureStreamThreadIsMatch(const Stream * const stm)
{
    const rtStreamCaptureMode streamCaptureMode = stm->GetStreamCaptureMode();
    const uint32_t threadId = stm->GetBeginCaptureThreadId();
    if (threadId == runtime::GetCurrentTid()) {
        return RT_ERROR_NONE;
    }
    if (streamCaptureMode != RT_STREAM_CAPTURE_MODE_RELAXED) {
        RT_LOG(RT_LOG_ERROR, "end capture in the wrong thread.");
        return RT_ERROR_STREAM_CAPTURE_WRONG_THREAD;
    }
    return RT_ERROR_NONE;
}

}
}