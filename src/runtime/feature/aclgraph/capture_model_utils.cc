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
#include "common/enum_to_string_utils.hpp"
#include "inner_thread_local.hpp"
#include "raw_device.hpp"
#include "context.hpp"
#include <sstream>
#include "notify.hpp"
#include "capture_model.hpp"

namespace cce {
namespace runtime {

constexpr uint32_t HARD_EVENT_RESVERD_MAX = 8U * 1024U;

bool NeedReBuildSqe(const TaskInfo *const task)
{
    const tsTaskType_t type = task->type;
    // mem wait类型task在sqe中会使用到当前stream的PosTail，在task更新后需要重新构造sqe
    if ((type == TS_TASK_TYPE_MEM_WAIT_VALUE) || (type == TS_TASK_TYPE_CAPTURE_WAIT) ||
        (type == TS_TASK_TYPE_IPC_WAIT) || (type == TS_TASK_TYPE_CAPTURE_CONDITION)) {
        return true;
    }
    return false;
}

bool IsUseHardwareEvent(Device * const dev)
{
    const Runtime * const rt = Runtime::Instance();
    const rtChipType_t chipType = rt->GetChipType();
    uint32_t eventCount = 0U;

    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_VALUE_WAIT)) {
        return true;
    }

    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_RESOURCE_NUM_DYNAMIC)) {
        return false;
    }

    (void)dev->Driver_()->GetAvailEventNum(dev->Id_(), dev->DevGetTsId(), &eventCount);
    if (eventCount > HARD_EVENT_RESVERD_MAX) {
        return true;
    }

    return false;
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
bool IsSoftwareSqCaptureModel(const Model * const mdl)
{
    if (mdl->GetModelType() != ModelType::RT_MODEL_CAPTURE_MODEL) {
        return false;
    }
    const CaptureModel *capMdl = dynamic_cast<const CaptureModel *>(mdl);
    return capMdl != nullptr && capMdl->IsSoftwareSqEnable();
}
rtError_t CheckCaptureModelSupportSoftwareSq(Device* const dev)
{
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    if (!(dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH_SOFTWARE_ENABLE))) {
        const rtChipType_t chipType = Runtime::Instance()->GetChipType();
        RT_LOG(RT_LOG_WARNING, "chipType=%d does not support", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    if (!(dev->CheckFeatureSupport(TS_FEATURE_SOFTWARE_SQ_ENABLE))) {
        RT_LOG(RT_LOG_WARNING, "tsfw does not support");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    if (!(NpuDriver::CheckIsSupportFeature(dev->Id_(), FEATURE_TRSDRV_SQ_SUPPORT_DYNAMIC_BIND))) {
        RT_LOG(RT_LOG_WARNING, "drv does not support");
        return RT_ERROR_DRV_NOT_SUPPORT;
    }

    return RT_ERROR_NONE;
}
rtError_t CheckCaptureModelForUpdate(const Stream* stm) {
    Device* dev = stm->Device_();
    static rtError_t isSupportResult = CheckCaptureModelSupportSoftwareSq(dev);
    COND_RETURN_WITH_NOLOG((isSupportResult != RT_ERROR_NONE), isSupportResult);

    Model* const mdl = stm->Model_();
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_MODEL_NULL);
    COND_RETURN_AND_MSG_OUTER(mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_FEATURE_NOT_SUPPORT, 
        ErrorCode::EE1016, __func__, "Non ACL Graph mode is not supported");
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    COND_RETURN_WARN(((captureModel != nullptr) && captureModel->IsSubCaptureModel()),
        RT_ERROR_FEATURE_NOT_SUPPORT, "stream belongs to sub ACL Graph, does not support update operations");
    if (!captureModel->CanUpdate()) {
        RawDevice* const rawDev = dynamic_cast<RawDevice *>(dev);
        rawDev->PollEndGraphNotifyInfoByModelId(mdl->Id_());
        if (!captureModel->CanUpdate()) {
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1017, __func__, "model",
                RtFmtMsg("Model (model_id=%u) is in running or capture state, status=%s",
                    captureModel->Id_(), CaptureModelStatusToString(captureModel->GetCaptureModelStatus()).c_str()));
            return RT_ERROR_MODEL_UPDATE_FAILED;    
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CheckCaptureModelSupportCondOp(Device * const dev)
{
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);

    const rtError_t ret = CheckCaptureModelSupportSoftwareSq(dev);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "aclgraph condop depends on software sq, device_id=%u, retCode=%#x.",
            dev->Id_(), static_cast<uint32_t>(ret));
        return ret;
    }

    if (!(dev->CheckFeatureSupport(TS_FEATURE_ACLGRAPH_CONDOP))) {
        RT_LOG(RT_LOG_WARNING, "tsfw does not support aclgraph condop, device_id=%u.", dev->Id_());
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    return RT_ERROR_NONE;
}

static void ReportCaptureModeError(const Context* ctx, const char* funcName)
{
    const rtStreamCaptureMode threadCaptureMode = InnerThreadLocalContainer::GetThreadCaptureMode();
    const rtStreamCaptureMode contextCaptureMode = ctx->GetContextCaptureMode();
    const uint32_t threadId = PidTidFetcher::GetCurrentTid();
    
    std::ostringstream oss;
    
    if (threadCaptureMode == RT_STREAM_CAPTURE_MODE_RELAXED) {
        oss << "Other threads of the current context are in the capture state. "
            << "As a result, the current operation cannot be performed on thread " << threadId << ". "
            << "To perform this operation in the current thread, call aclmdlRICaptureThreadExchangeMode to change the capture mode of the current thread. "
            << "The mode set using the aclmdlRICaptureBegin API is " << StreamCaptureModeToString(contextCaptureMode) << ", "
            << "and the capture mode of the current thread is " << StreamCaptureModeToString(threadCaptureMode);
    } else {
        oss << "The current thread " << threadId << " is in the capture state and the current operation cannot be performed. "
            << "Check whether the mode set by the aclmdlRICaptureBegin API supports the current operation. "
            << "This operation is supported only in the RELAXED mode. "
            << "The mode set using the aclmdlRICaptureBegin API is " << StreamCaptureModeToString(contextCaptureMode) << ", "
            << "and the capture mode of the current thread is " << StreamCaptureModeToString(threadCaptureMode);
    }
    
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1016, funcName, oss.str());
}

bool CheckCaptureModeSupport(const Context* ctx, const char* funcName)
{
    if (!ctx->IsCaptureModeSupport()) {
        ReportCaptureModeError(ctx, funcName);
        return false;
    }
    return true;
}

rtError_t AllocNotifyIdForSubModel(Model * const mdl, Notify *notify)
{
    if ((mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL) || (notify->GetNotifyId() != MAX_UINT32_NUM)) {
        return RT_ERROR_NONE;
    }

    CaptureModel *captureModel = dynamic_cast<CaptureModel *>(mdl);
    if (captureModel->IsSubCaptureModel()) {
        rtError_t error = notify->AllocId();
        COND_RETURN_WARN(error != RT_ERROR_NONE, error, "Alloc notify Id, retCode=%#x", error);
    }

    return RT_ERROR_NONE;
}

rtError_t ReleaseNotify(Model * const mdl, Notify *notify)
{
    /* 非aclgraph的，走老流程 */
    if (mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL) {
        DELETE_O(notify);
        mdl->SetEndGraphNotify(nullptr);
        return RT_ERROR_NONE;
    }

    CaptureModel *captureModel = dynamic_cast<CaptureModel *>(mdl);
    COND_PROC(captureModel == nullptr, DELETE_O(notify); mdl->SetEndGraphNotify(nullptr); return RT_ERROR_NONE;);

    /* 非sub aclgraph的，释放notify句柄，下次重新申请 */
    if (!captureModel->IsSubCaptureModel()) {
        DELETE_O(notify);
        mdl->SetEndGraphNotify(nullptr);
        return RT_ERROR_NONE;
    }

    /* sub aclgraph的，不能释放notify句柄，因为其他sub graph还存的是当前这个notify句柄 */
    rtError_t error = notify->FreeId();
    COND_RETURN_WARN(error != RT_ERROR_NONE, error, "free notify id=%u, retCode=%#x", notify->GetNotifyId(), error);

    return RT_ERROR_NONE;
}

uint32_t FindStreamIdInSubModels(CaptureModel * const parentModel, const uint16_t sqId)
{
    if (parentModel == nullptr) {
        return UINT32_MAX;
    }

    for (const auto &entry : parentModel->GetCondHandleTaskMap()) {
        CondHandle *condHandle = entry.second;
        if (condHandle == nullptr) {
            continue;
        }
        for (Model *subModel : condHandle->GetSubCaptureModels()) {
            CaptureModel *subCaptureModel = dynamic_cast<CaptureModel *>(subModel);
            if (subCaptureModel == nullptr) {
                continue;
            }
            uint32_t subStreamId = subCaptureModel->GetStreamIdBySqId(sqId);
            if (subStreamId != UINT32_MAX) {
                RT_LOG(RT_LOG_WARNING,
                    "Found stream id in submodel, parent_model_id=%u, sub_model_id=%u, sq_id=%hu, stream_id=%u",
                    parentModel->Id_(), subCaptureModel->Id_(), sqId, subStreamId);
                return subStreamId;
            }
            subStreamId = FindStreamIdInSubModels(subCaptureModel, sqId);
            if (subStreamId != UINT32_MAX) {
                return subStreamId;
            }
        }
    }
    return UINT32_MAX;
}

bool IsTaskBelongToSubCaptureMdl(const TaskInfo * const task)
{
    Stream *stm = task->stream;
    COND_PROC((stm == nullptr), return false);

    Model* const mdl = stm->Model_();
    COND_PROC(mdl == nullptr, return false;);

    CaptureModel *captureModel = dynamic_cast<CaptureModel *>(mdl);
    COND_PROC(captureModel == nullptr, return false;);

    COND_RETURN_WARN(captureModel->IsSubCaptureModel(), true,
        "model is sub ACL Graph, does not support current operation.");

    return false;
}

bool IsStreamBindWithSubModel(Stream * const stream)
{
    COND_PROC(stream == nullptr, return false;);

    Stream *captureStream = stream->GetCaptureStream();
    COND_PROC(captureStream == nullptr, return false;);

    Model *mdl = captureStream->Model_();
    COND_PROC(mdl == nullptr, return false;);

    CaptureModel *captureModel = dynamic_cast<CaptureModel *>(mdl);
    COND_PROC(captureModel == nullptr, return false;);

    COND_RETURN_WARN(captureModel->IsSubCaptureModel(), true,
        "stream belongs to sub ACL Graph, does not support current operation.");

    return false;
}

} // namespace runtime
} // namespace cce
