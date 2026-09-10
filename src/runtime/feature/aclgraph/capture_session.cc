/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capture_session.hpp"

#include <new>
#include "aclgraph_cond_task.h"
#include "buffer_allocator.hpp"
#include "capture_adapt.hpp"
#include "capture_model.hpp"
#include "capture_model_enum_desc.hpp"
#include "capture_model_utils.hpp"
#include "capture_ops.hpp"
#include "cond_handle.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "event.hpp"
#include "inner_thread_local.hpp"
#include "memcpy_c.hpp"
#include "notify.hpp"
#include "npu_driver.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "stream_jetty_handler.h"
#include "task.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr size_t NOTIFY_INDEX = 2U;
} // namespace

bool CaptureSession::IsCaptureModeSupport(void) const
{
    const rtStreamCaptureMode contextCaptureMode = GetContextCaptureMode();
    /* no capture scene, support */
    if (contextCaptureMode == RT_STREAM_CAPTURE_MODE_MAX) {
        return true;
    }

    const rtStreamCaptureMode threadCaptureMode = InnerThreadLocalContainer::GetThreadCaptureMode();
    const rtStreamCaptureMode exchangeCaptureMode = InnerThreadLocalContainer::GetThreadExchangeCaptureMode();
    if (exchangeCaptureMode == RT_STREAM_CAPTURE_MODE_RELAXED) {
        return true;
    }

    if (exchangeCaptureMode == RT_STREAM_CAPTURE_MODE_GLOBAL) {
        if ((contextCaptureMode == RT_STREAM_CAPTURE_MODE_GLOBAL) ||
            (threadCaptureMode == RT_STREAM_CAPTURE_MODE_THREAD_LOCAL)) {
            return false;
        }
    }

    if (exchangeCaptureMode == RT_STREAM_CAPTURE_MODE_THREAD_LOCAL) {
        if ((threadCaptureMode == RT_STREAM_CAPTURE_MODE_GLOBAL) ||
            (threadCaptureMode == RT_STREAM_CAPTURE_MODE_THREAD_LOCAL)) {
            return false;
        }
    }

    return true;
}

void CaptureSession::CaptureModeEnter(Stream* const stm, rtStreamCaptureMode mode)
{
    stm->SetStreamCaptureMode(mode);
    stm->SetBeginCaptureThreadId(runtime::GetCurrentTid());
    captureModeRefNum_[mode]++;
    InnerThreadLocalContainer::ThreadCaptureModeEnter(mode);

    if (mode < captureMode_) {
        captureMode_ = mode;
    }
}

void CaptureSession::CaptureModeExit(Stream* const stm)
{
    const rtStreamCaptureMode streamCaptureMode = stm->GetStreamCaptureMode();
    stm->SetStreamCaptureMode(RT_STREAM_CAPTURE_MODE_MAX);
    stm->SetBeginCaptureThreadId(UINT32_MAX);

    if (static_cast<uint32_t>(streamCaptureMode) >= RT_STREAM_CAPTURE_MODE_MAX) {
        return;
    }

    if (captureModeRefNum_[streamCaptureMode] > 0U) {
        captureModeRefNum_[streamCaptureMode]--;
    }

    InnerThreadLocalContainer::ThreadCaptureModeExit(streamCaptureMode);

    if (captureModeRefNum_[RT_STREAM_CAPTURE_MODE_GLOBAL] != 0U) {
        return;
    }
    if (captureModeRefNum_[RT_STREAM_CAPTURE_MODE_THREAD_LOCAL] != 0U) {
        captureMode_ = RT_STREAM_CAPTURE_MODE_THREAD_LOCAL;
        return;
    }
    if (captureModeRefNum_[RT_STREAM_CAPTURE_MODE_RELAXED] != 0U) {
        captureMode_ = RT_STREAM_CAPTURE_MODE_RELAXED;
        return;
    }
    captureMode_ = RT_STREAM_CAPTURE_MODE_MAX;
}

rtError_t CaptureSession::ThreadExchangeCaptureMode(rtStreamCaptureMode* const mode) const
{
    const rtStreamCaptureMode exchangeCaptureModeOld = InnerThreadLocalContainer::GetThreadExchangeCaptureMode();
    InnerThreadLocalContainer::SetThreadExchangeCaptureMode(*mode);
    *mode = exchangeCaptureModeOld;
    return RT_ERROR_NONE;
}

rtError_t CaptureSession::UpdateEndGraphTask(
    Stream* const origCaptureStream, Stream* const exeStream, Notify* ntf) const
{
    const uint16_t taskId = origCaptureStream->GetLastTaskId();
    TaskInfo* rtNotifyRecord =
        origCaptureStream->Device_()->GetTaskFactory()->GetTask(origCaptureStream->Id_(), taskId);
    COND_RETURN_ERROR(rtNotifyRecord == nullptr, RT_ERROR_STREAM_CAPTURED, "EndGraph task is NULL");

    COND_RETURN_ERROR(
        rtNotifyRecord->type != TS_TASK_TYPE_NOTIFY_RECORD, RT_ERROR_STREAM_INVALID,
        "EndGraph stream_id=%d, task_id=%u, task type=%s(%u)", rtNotifyRecord->stream->Id_(), rtNotifyRecord->id,
        GetTaskDescByType(rtNotifyRecord->type), rtNotifyRecord->type);
    rtNotifyRecord->u.notifyrecordTask.notifyId = ntf->GetNotifyId();
    uint8_t sqeMem[RT_STARS_SQE_LEN] = {0};
    ConstructStarsSqeForNotifyRecordTask(rtNotifyRecord, sqeMem);

    void* targetAddrOfUpdatedSqe = origCaptureStream->GetDeviceSqeAddrByPos(rtNotifyRecord->pos);
    COND_RETURN_ERROR(
        targetAddrOfUpdatedSqe == nullptr, RT_ERROR_INVALID_VALUE,
        "Get device sqe addr failed, device_id=%u, stream_id=%d, task_pos=%u.", origCaptureStream->Device_()->Id_(),
        origCaptureStream->Id_(), rtNotifyRecord->pos);
    uint64_t realSize = 0U;
    const rtError_t error = MemcopyAsync(
        targetAddrOfUpdatedSqe, sizeof(rtStarsSqe_t), sqeMem, sizeof(sqeMem), RT_MEMCPY_HOST_TO_DEVICE_EX, exeStream,
        &realSize);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "update task fail error=0x%x", error);
    RT_LOG(
        RT_LOG_WARNING, "exec stream_id=%d target stream_id=%u pos=%u", exeStream->Id_(), origCaptureStream->Id_(),
        rtNotifyRecord->pos);
    return error;
}

rtError_t CaptureSession::UpdateSuModelExeStreamNotifyWaitSqe(TaskInfo* taskInfo, Stream* const exeStream) const
{
    Notify* ntf = taskInfo->u.captureConditionTask.condHandle->GetSubModelNotify();
    rtStarsSqe_t sqeMem = {};

    ConstructStarsSqeForConditionNotifyWait(taskInfo, RtPtrToPtr<uint8_t*>(&sqeMem));
    void* condTaskAddr = taskInfo->stream->GetDeviceSqeAddrByPos(taskInfo->pos);
    COND_RETURN_ERROR(
        condTaskAddr == nullptr, RT_ERROR_INVALID_VALUE,
        "Get device sqe addr failed, device_id=%u, stream_id=%d, task_pos=%u.", taskInfo->stream->Device_()->Id_(),
        taskInfo->stream->Id_(), taskInfo->pos);
    void* targetAddrOfUpdatedSqe = RtPtrToPtr<uint8_t*>(condTaskAddr) + SQE_SIZE_UNIT;

    uint64_t realSize = 0U;
    auto error = MemcopyAsync(
        targetAddrOfUpdatedSqe, sizeof(rtStarsSqe_t), &sqeMem, sizeof(sqeMem), RT_MEMCPY_HOST_TO_DEVICE_EX, exeStream,
        &realSize);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "update sqe fail error=0x%x", error);
    RT_LOG(
        RT_LOG_DEBUG, "exec stream_id=%d target stream_id=%u, ntyId=%u", exeStream->Id_(), taskInfo->stream->Id_(),
        ntf->GetNotifyId());
    return error;
}

rtError_t CaptureSession::StreamAddToCaptureModelProc(Stream* const stm, Model* const captureMdl, const bool isOriginal)
{
    Stream* captureStream = nullptr;
    const int32_t streamId = stm->Id_();
    if (captureMdl == nullptr) {
        RT_LOG(
            RT_LOG_ERROR, "Capture model is null, device_id=%u, original stream_id=%d.", ctx_->Device_()->Id_(),
            streamId);
        return RT_ERROR_MODEL_NULL;
    }

    if (captureMdl->GetModelType() != RT_MODEL_CAPTURE_MODEL) {
        RT_LOG(
            RT_LOG_ERROR, "model type not match, device_id=%u, original stream_id=%d, model_id=%u.",
            ctx_->Device_()->Id_(), streamId, captureMdl->Id_());
        return RT_ERROR_INVALID_VALUE;
    }

    CaptureModel* captureModelTmp = dynamic_cast<CaptureModel*>(captureMdl);
    if (captureModelTmp->IsCaptureFinish() || captureModelTmp->IsCaptureInvalid()) {
        RT_LOG(
            RT_LOG_ERROR, "model capture status mismatch, device_id=%u, original stream_id=%d, model_id=%u.",
            ctx_->Device_()->Id_(), streamId, captureMdl->Id_());
        return RT_ERROR_MODEL_CAPTURE_STATUS;
    }

    /* create capture stream */
    rtError_t error =
        ctx_->StreamCreate(0U, RT_STREAM_PERSISTENT, &captureStream, nullptr, captureModelTmp->IsSoftwareSqEnable());
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Capture stream create failed, device_id=%u, original stream_id=%d, retCode=%#x.",
            ctx_->Device_()->Id_(), streamId, error);
        return error;
    }

    if (captureModelTmp->IsSoftwareSqEnable()) {
        /* add stream to model */
        error = ctx_->ModelAddStream(captureMdl, captureStream, RT_HEAD_STREAM);
    } else {
        /* bind stream to model */
        error = ctx_->ModelBindStream(captureMdl, captureStream, RT_HEAD_STREAM);
    }

    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "Bind capture stream failed, device_id=%u, model_id=%u, stream_id=%d, "
            "original stream_id=%d, retCode=%#x.",
            ctx_->Device_()->Id_(), captureMdl->Id_(), captureStream->Id_(), streamId, error);
        (void)ctx_->StreamDestroy(captureStream);
        return error;
    }

    /* stm begin capture */
    const rtStreamCaptureStatus status = stm->GetCaptureStatus();
    /* check capture status again */
    if (status != RT_STREAM_CAPTURE_STATUS_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "stream is already in capture status, device_id=%u, stream_id=%d, status=%s.",
            ctx_->Device_()->Id_(), streamId, ((status == RT_STREAM_CAPTURE_STATUS_ACTIVE) ? "active" : "invalidated"));

        if (captureModelTmp->IsSoftwareSqEnable()) {
            /* steam is add to model, only need destroy model */
            (void)ctx_->ModelDelStream(captureMdl, captureStream);
        } else {
            /* steam is bind to model, only need destroy model */
            (void)ctx_->ModelUnbindStream(captureMdl, captureStream);
        }
        (void)ctx_->StreamDestroy(captureStream);
        return RT_ERROR_STREAM_CAPTURED;
    }

    captureStream->MarkOrigCaptureStream(isOriginal);
    stm->EnterCapture(captureStream);
    return RT_ERROR_NONE;
}

rtError_t CaptureSession::CheckCaptureModelIsCaptured(Model* const mdl) const
{
    COND_PROC((mdl == nullptr), return RT_ERROR_NONE);
    CaptureModel* captureModelTmp = dynamic_cast<CaptureModel*>(mdl);
    if (captureModelTmp->GetCaptureModelStatus() != RtCaptureModelStatus::NONE) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1017, "rtStreamBeginCaptureToModel", "modelRI",
            RtFmtMsg("ModelRI (model_id=%u) is already captured", mdl->Id_()));
        return RT_ERROR_MODEL_CAPTURED;
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureSession::StreamBeginCapture(Stream* const stm, const rtStreamCaptureMode mode, Model* const mdl)
{
    Model* captureModel = mdl;

    BufferAllocator::OpenHugeBuff();
    std::unique_lock<std::mutex> taskLock(ctx_->GetCaptureLock());
    rtError_t error = CheckCaptureModelIsCaptured(mdl);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "stream begin captured failed, stream_id=%d, model_id=%u.", stm->Id_(),
        mdl->Id_());

    const rtStreamCaptureStatus status = stm->GetCaptureStatus();
    const int32_t streamId = stm->Id_();

    RT_LOG(RT_LOG_INFO, "capture begin, device_id=%u, original stream_id=%d.", ctx_->Device_()->Id_(), streamId);

    /* check capture status */
    COND_RETURN_AND_MSG_OUTER(
        status != RT_STREAM_CAPTURE_STATUS_NONE, RT_ERROR_STREAM_CAPTURED, ErrorCode::EE1016, "Stream begin capture",
        RtFmtMsg(
            "Stream is already in capture status, device_id=%u, stream_id=%d, status=%s", ctx_->Device_()->Id_(),
            streamId, ((status == RT_STREAM_CAPTURE_STATUS_ACTIVE) ? "active" : "invalidated")));

    /* create capture model */
    if (captureModel == nullptr) {
        error = ctx_->ModelCreate(&captureModel, RT_MODEL_CAPTURE_MODEL);
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "Capture model create failed, device_id=%u, original stream_id=%d, retCode=%#x.",
                ctx_->Device_()->Id_(), streamId, error);
            return error;
        }
    }

    if ((stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH_SOFTWARE_ENABLE)) &&
        (stm->Device_()->CheckFeatureSupport(TS_FEATURE_SOFTWARE_SQ_ENABLE)) &&
        (NpuDriver::CheckIsSupportFeature(ctx_->Device_()->Id_(), FEATURE_TRSDRV_SQ_SUPPORT_DYNAMIC_BIND))) {
        CaptureModel* captureModelTmp = dynamic_cast<CaptureModel*>(captureModel);
        captureModelTmp->SetSoftwareSqEnable();
        RT_LOG(
            RT_LOG_DEBUG, "Capture model set software sq enable, device_id=%u, model_id=%u", ctx_->Device_()->Id_(),
            captureModel->Id_());
    }

    error = StreamAddToCaptureModelProc(stm, captureModel, true);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "add stream to capture model failed, device_id=%u, model_id=%u, "
            "original stream_id=%d, retCode=%#x.",
            ctx_->Device_()->Id_(), captureModel->Id_(), streamId, error);
        (void)ctx_->ModelDestroy(captureModel);
        return error;
    }

    CaptureModeEnter(stm, mode);

    CondHandle* condHandle = nullptr;
    /* 父model取到的condHandle是nullptr，接口不返错 */
    CaptureModel* captureMdl = dynamic_cast<CaptureModel*>(captureModel);
    (void)GetValidatedObject<CondHandle>(captureMdl->GetCondHandle(), condHandle);

    RT_LOG(
        RT_LOG_EVENT,
        "capture begin success, device_id=%u, model_id=%u"
        " original stream_id=%d, capture stream_id=%d, stream_status=%s, isSubmodel=%u, parent model_id=%u.",
        ctx_->Device_()->Id_(), captureMdl->Id_(), streamId, stm->GetCaptureStream()->Id_(),
        StreamCaptureStatusToString(stm->GetCaptureStatus()).c_str(), captureMdl->IsSubCaptureModel(),
        (condHandle != nullptr) ? condHandle->GetParentModel()->Id_() : MAX_UINT32_NUM);

    return RT_ERROR_NONE;
}

rtError_t CaptureSession::CheckCaptureModelValidity(Model* const captureMdl) const
{
    NULL_PTR_RETURN(captureMdl, RT_ERROR_MODEL_NULL);
    std::list<Stream*> streams = captureMdl->StreamList_();
    COND_RETURN_ERROR(
        (streams.empty() == true), RT_ERROR_STREAM_UNJOINED, "No streams is bound to the capture model, model_id=%u.",
        captureMdl->Id_());

    CaptureModel* const mdl = dynamic_cast<CaptureModel* const>(captureMdl);
    std::set<uint16_t>& streamIds = mdl->GetTaskGroupStreamIds();
    COND_RETURN_ERROR(
        (!streamIds.empty()), RT_ERROR_STREAM_TASKGRP_STATUS,
        "A task group is not closed in the capture model, model_id=%u.", captureMdl->Id_());

    bool isOnlyOrigStream = true;
    bool hasRecordOrigStream = false;
    int32_t origStreamId = -1;
    for (auto it = streams.begin(); it != streams.end(); it++) {
        if ((*it)->IsOrigCaptureStream()) {
            origStreamId = (*it)->Id_();
        }
        if (((*it)->IsOrigCaptureStream()) || ((*it)->IsLastLevelCaptureStream() == false) || (mdl->IsAddStream(*it))) {
            continue;
        }

        isOnlyOrigStream = false;
        const int32_t streamId = (*it)->Id_();
        const uint32_t taskId = (*it)->GetLastTaskId();
        Event* event = nullptr;
        CaptureCntNotify cntInfo = {0, 0U};
        const rtError_t ret =
            GetCaptureEventFromTask(ctx_->Device_(), static_cast<uint32_t>(streamId), taskId, event, cntInfo);
        COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE), ret);
        COND_RETURN_ERROR(
            (event == nullptr), RT_ERROR_EVENT_NULL, "No event object, stream_id=%d, task_id=%u.", streamId, taskId);
        COND_RETURN_AND_MSG_OUTER(
            (event->GetEventFlag() == RT_EVENT_EXTERNAL), RT_ERROR_STREAM_UNJOINED, ErrorCode::EE1017,
            "Capture model validity check", "capture model",
            RtFmtMsg(
                "In the cross-stream capture scenario, the last task (task_id=%u) on the sub stream (stream_id=%d) is "
                "not an event record task. Call aclrtRecordEvent on the sub stream to deliver an event record task",
                taskId, streamId));
        COND_RETURN_AND_MSG_OUTER(
            (event->IsCaptureStreamWaited() == false), RT_ERROR_STREAM_UNJOINED, ErrorCode::EE1017,
            "Capture model validity check", "capture model",
            RtFmtMsg(
                "In the cross-stream capture scenario, the last task (task_id=%u, event_id=%d) on the sub stream "
                "(stream_id=%d) lacks the corresponding event wait task",
                taskId, event->EventId_(), streamId));
        if (event->IsRecordOrigCaptureStream(*it)) {
            hasRecordOrigStream = true;
        }
    }
    COND_RETURN_AND_MSG_OUTER(
        ((isOnlyOrigStream == false) && (hasRecordOrigStream == false)), RT_ERROR_STREAM_UNJOINED, ErrorCode::EE1017,
        "Capture model validity check", "capture model",
        RtFmtMsg(
            "In the cross-stream capture scenario, the origin stream (stream_id=%u) has no event wait task, "
            "indicating that the sub stream is not joined back to the origin stream",
            static_cast<uint32_t>(origStreamId)));
    return RT_ERROR_NONE;
}

rtError_t CaptureSession::AddNotifyToAddedCaptureStream(Stream* const oriSingleStm, CaptureModel* const captureMdl)
{
    rtError_t error = RT_ERROR_NONE;
    auto& streams = captureMdl->GetAddStreamMap();
    Api* const apiObj = Runtime::Instance()->ApiImpl_();
    NULL_PTR_RETURN_MSG(apiObj, RT_ERROR_API_NULL);
    for (auto& streamObj : streams) {
        Notify* notify = nullptr;
        error = ctx_->CreateNotify(&notify, RT_NOTIFY_DEFAULT);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error); // notify在模型销毁时，统一进行释放
        captureMdl->AddNotify(notify);
        Stream* const lastStm = streamObj.second.back();
        error = apiObj->NotifyRecord(notify, lastStm);
        ERROR_RETURN(
            error,
            "Notify record failed, device_id=%u, original stream_id=%d, "
            "capture model_id=%u, stream_id=%d, notify_id=%u, retCode=%#x",
            ctx_->Device_()->Id_(), oriSingleStm->Id_(), captureMdl->Id_(), streamObj.second.back()->Id_(),
            notify->GetNotifyId(), error);
        error = apiObj->NotifyWait(notify, oriSingleStm, MAX_UINT32_NUM);
        ERROR_RETURN(
            error,
            "Notify wait failed, device_id=%u, original stream_id=%d, "
            "capture model_id=%u, stream_id=%d, notify_id=%u, retCode=%#x",
            ctx_->Device_()->Id_(), oriSingleStm->Id_(), captureMdl->Id_(), streamObj.second.back()->Id_(),
            notify->GetNotifyId(), error);
    }
    return error;
}

rtError_t CaptureSession::SetNotifyForExeModel(CaptureModel* const captureMdl)
{
    /* for exe stream and add stream alloc notify */
    rtError_t error = RT_ERROR_NONE;
    const std::map<Stream*, std::vector<Stream*>>& streams = captureMdl->GetAddStreamMap();
    for (size_t i = 0U; i < (streams.size() * NOTIFY_INDEX); i++) {
        Notify* notify = nullptr;
        error = ctx_->CreateNotify(&notify, RT_NOTIFY_DEFAULT);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        captureMdl->AddExeNotify(notify);
        RT_LOG(RT_LOG_DEBUG, "create notify_id=%u", notify->GetNotifyId());
    }
    return error;
}

void CaptureSession::ClearCaptureModel(Stream* const stm, Model* mdl)
{
    stm->ExitCapture();
    /* steam is bound to model, only need destroy model */

    if (mdl != nullptr) {
        CaptureModel* captureModel = dynamic_cast<CaptureModel* const>(mdl);
        COND_PROC(captureModel == nullptr, return;);

        /* 子model不在这里单独销毁，随父model销毁 */
        COND_PROC(captureModel->IsSubCaptureModel(), return;);
        (void)ctx_->ModelDestroy(mdl);
    }
}

bool CaptureSession::CheckSubModelsIsEndCapture(const Stream* const captureStream) const
{
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(captureStream->Model_());
    COND_RETURN_ERROR(
        captureModel == nullptr, false, "capture model is null, capture stream_id=%d.", captureStream->Id_());

    captureModel->ClearCachedAllSubModels();
    bool isEndCapture = captureModel->CheckSubModelsIsEndCapture();
    COND_RETURN_ERROR(
        !isEndCapture, false, "sub capture model has not ended capture, capture model_id=%d.", captureModel->Id_());

    return true;
}

rtError_t CaptureSession::StreamEndCapture(Stream* const stm, Model** const captureMdl)
{
    RT_LOG(RT_LOG_INFO, "capture end, device_id=%u, original stream_id=%d.", ctx_->Device_()->Id_(), stm->Id_());
    *captureMdl = nullptr;
    std::unique_lock<std::mutex> taskLock(ctx_->GetCaptureLock());
    const rtStreamCaptureStatus status = stm->GetCaptureStatus();
    /* check capture status */
    COND_RETURN_AND_MSG_OUTER(
        status == RT_STREAM_CAPTURE_STATUS_NONE, RT_ERROR_STREAM_NOT_CAPTURED, ErrorCode::EE1018, "Stream end capture",
        RtFmtMsg(
            "The stream (stream_id=%d) is not in capture status, call rtStreamBeginCapture API to capture stream first",
            stm->Id_()));

    Stream* captureStream = stm->GetCaptureStream();
    NULL_STREAM_PTR_RETURN_MSG(captureStream);
    if (!(captureStream->IsOrigCaptureStream())) {
        RT_LOG(
            RT_LOG_ERROR, "The capture was not initiated in this stream. device_id=%u, stream_id=%d.",
            ctx_->Device_()->Id_(), stm->Id_());
        return RT_ERROR_STREAM_CAPTURE_UNMATCHED;
    }

    rtError_t error = CheckCaptureStreamThreadIsMatch(stm);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, CaptureModeExit(stm); ClearCaptureModel(stm);
                           , "end capture in the wrong thread.");
    CaptureModeExit(stm);

    Model* captureModel = captureStream->Model_();
    if (captureModel == nullptr) {
        RT_LOG(
            RT_LOG_ERROR, "captureModel is null, device_id=%u, origin stream_id=%d, status=%s.", ctx_->Device_()->Id_(),
            stm->Id_(), ((status == RT_STREAM_CAPTURE_STATUS_ACTIVE) ? "active" : "invalidated"));
        ClearCaptureModel(stm);
        return RT_ERROR_MODEL_NULL;
    }

    CaptureModel* captureModelTmp = RtPtrToPtr<CaptureModel*, Model*>(captureModel);
    if (status == RT_STREAM_CAPTURE_STATUS_INVALIDATED) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1016, "Stream end capture",
            RtFmtMsg(
                "The current stream (stream_id=%d, model_id=%u) is invalid because an error occurred during model "
                "capture",
                stm->Id_(), captureModel->Id_()));
        ClearCaptureModel(stm, captureModel);
        return RT_ERROR_STREAM_CAPTURE_INVALIDATED;
    }
    if (captureModelTmp->IsCaptureInvalid()) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1016, "Stream end capture",
            RtFmtMsg(
                "The current model (model_id=%u) is invalid because an error occurred during model capture",
                captureModel->Id_()));
        ClearCaptureModel(stm, captureModel);
        return RT_ERROR_STREAM_CAPTURE_INVALIDATED;
    }

    const bool isCaptureFinished = CheckSubModelsIsEndCapture(captureStream);

    COND_PROC_RETURN_AND_MSG_OUTER(
        !isCaptureFinished, RT_ERROR_STREAM_SUB_ACLGRAPH_IS_CAPTURING, ErrorCode::EE1016,
        ClearCaptureModel(stm, captureModel), "Stream end capture",
        RtFmtMsg("Sub ACL Graph is capturing, stream_id=%d, capture stream_id=%d", stm->Id_(), captureStream->Id_()));

    error = CheckCaptureModelValidity(captureModel);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, ClearCaptureModel(stm, captureModel),
        "Failed to verify the validity of the capture model, retCode=%#x.", static_cast<uint32_t>(error));

    captureStream = stm->GetCaptureStream();
    NULL_PTR_PROC_RETURN_ERROR(captureStream, RT_ERROR_STREAM_NULL, ClearCaptureModel(stm, captureModel));
    error = AddNotifyToAddedCaptureStream(stm, static_cast<CaptureModel*>(captureModelTmp));
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "set notify for add capture stream failed, device_id=%u, origin stream_id=%d, "
            "capture model_id=%u, stream_id=%d, retCode=%#x.",
            ctx_->Device_()->Id_(), stm->Id_(), captureModel->Id_(), captureStream->Id_(), error);
        ClearCaptureModel(stm, captureModel);
        return error;
    }

    error = SetNotifyForExeModel(captureModelTmp);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "set notify for capture model failed, device_id=%u, origin stream_id=%d, "
            "capture model_id=%u, stream_id=%d, retCode=%#x.",
            ctx_->Device_()->Id_(), stm->Id_(), captureModel->Id_(), captureStream->Id_(), error);
        ClearCaptureModel(stm, captureModel);
        return error;
    }

    error = captureModelTmp->ResetCaptureEvents(stm);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, ClearCaptureModel(stm, captureModel),
        "Failed to reset capture events, retCode=%#x.", static_cast<uint32_t>(error));

    Api* const apiObj = Runtime::Instance()->ApiImpl_();
    // 重新取一下capture 流，前面可能会在capture 流上下任务，导致级联
    captureStream = stm->GetCaptureStream();
    NULL_PTR_PROC_RETURN_ERROR(captureStream, RT_ERROR_STREAM_NULL, ClearCaptureModel(stm, captureModel));
    error = apiObj->ModelEndGraph(captureModel, captureStream, 0U);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, ClearCaptureModel(stm, captureModel),
        "capture model end graph failed, device_id=%u, origin stream_id=%d, "
        "capture model_id=%u, stream_id=%d, retCode=%#x.",
        ctx_->Device_()->Id_(), stm->Id_(), captureModel->Id_(), captureStream->Id_(), error);

    error = captureModelTmp->EndCaptureAdapterProc();
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, ClearCaptureModel(stm, captureModel),
        "Failed to run end capture proc, retCode=%#x.", static_cast<uint32_t>(error));

    if (!captureModelTmp->IsSoftwareSqEnable()) {
        error = captureModel->LoadComplete();
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, ClearCaptureModel(stm, captureModel),
            "capture model load complete failed, device_id=%u, origin stream_id=%d, "
            "capture model_id=%u, stream_id=%d, retCode=%#x.",
            ctx_->Device_()->Id_(), stm->Id_(), captureModel->Id_(), captureStream->Id_(), error);
    } else if (Runtime::Instance()->GetConnectUbFlag()) {
        // ub + software sq enable
        for (Stream* innerStm : captureModelTmp->StreamList_()) {
            if (innerStm != nullptr) {
                error = StreamJettyHandler::FillNopWqeOnCaptureEnd(innerStm, JettyType::JETTY_TYPE_H2D);
                COND_PROC_RETURN_ERROR(
                    error != RT_ERROR_NONE, error, ClearCaptureModel(stm, captureModel),
                    "Failed to fill nop wqe, retCode=%#x.", static_cast<uint32_t>(error));

                error = StreamJettyHandler::FillNopWqeOnCaptureEnd(innerStm, JettyType::JETTY_TYPE_D2D_IN_BOARD);
                COND_PROC_RETURN_ERROR(
                    error != RT_ERROR_NONE, error, ClearCaptureModel(stm, captureModel),
                    "Failed to fill nop wqe, retCode=%#x.", static_cast<uint32_t>(error));

                error = StreamJettyHandler::FillNopWqeOnCaptureEnd(innerStm, JettyType::JETTY_TYPE_D2D_CROSS_BOARD);
                COND_PROC_RETURN_ERROR(
                    error != RT_ERROR_NONE, error, ClearCaptureModel(stm, captureModel),
                    "Failed to fill nop wqe, retCode=%#x.", static_cast<uint32_t>(error));
            }
        }
    } else {
        // no operation
    }

    (void)captureModel->ModelExecuteType();
    /* stm end capture */
    stm->ExitCapture();
    *captureMdl = captureModel;

    RT_LOG(
        RT_LOG_EVENT,
        "capture end success, device_id=%u, original stream_id=%d, capture stream_id=%d, capture model_id=%u.",
        ctx_->Device_()->Id_(), stm->Id_(), captureStream->Id_(), captureModel->Id_());

    return RT_ERROR_NONE;
}

rtError_t CaptureSession::StreamAddToModel(Stream* const stm, Model* const captureMdl)
{
    std::unique_lock<std::mutex> taskLock(ctx_->GetCaptureLock());
    return static_cast<CaptureModel*>(captureMdl)->AddStreamToCaptureModel(stm);
}

namespace {

ContextExtension* CreateCaptureSession(Context* const ctx)
{
    if (ctx == nullptr) {
        return nullptr;
    }
    return new (std::nothrow) CaptureSession(ctx);
}

const CaptureOps g_aclgraphCaptureOps = {CreateCaptureSession};

class CaptureOpsRegistrar {
public:
    CaptureOpsRegistrar() { RegisterCaptureOps(&g_aclgraphCaptureOps); }
};

CaptureOpsRegistrar g_captureOpsRegistrar;

} // namespace

bool IsCaptureSessionExist(const Context* const ctx)
{
    if (ctx == nullptr) {
        return false;
    }
    return (dynamic_cast<CaptureSession*>(ctx->GetExtension()) != nullptr);
}

CaptureSession* GetCaptureSession(const Context* const ctx)
{
    if (ctx == nullptr) {
        return nullptr;
    }
    ContextExtension* const extension = ctx->EnsureExtension();
    return dynamic_cast<CaptureSession*>(extension);
}

} // namespace runtime
} // namespace cce
