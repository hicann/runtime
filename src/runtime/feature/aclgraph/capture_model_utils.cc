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
#include "capture_model_enum_desc.hpp"
#include "inner_thread_local.hpp"
#include "raw_device.hpp"
#include "context.hpp"
#include <sstream>
#include "notify.hpp"
#include "capture_model.hpp"
#include "common_task.h"
#include "memcpy_c.hpp"

namespace cce {
namespace runtime {

static void CommitPreparedExternalRecordToEvent(Event* event, const uint64_t eventAddr, const int32_t eventId)
{
    if ((event == nullptr) || (eventAddr == 0U) || (eventId == INVALID_EVENT_ID)) {
        RT_LOG(RT_LOG_ERROR, "Invalid event record resource, event addr=%lu, event id=%d.", eventAddr, eventId);
        return;
    }
    event->PublishSoftwareRecordResource(RtValueToPtr<void*>(eventAddr), eventId);
    event->SetRecord(true);
    event->SetHasReset(false);
}

constexpr uint32_t HARD_EVENT_RESVERD_MAX = 8U * 1024U;

bool NeedReBuildSqe(const TaskInfo* const task)
{
    const tsTaskType_t type = task->type;
    // wait类function-call SQE会固化stream SQ位置，切到目标下发流时需要重建。
    // external record只在launch时刷新record entry地址，capture阶段保存的SQE字节可复用。
    if ((type == TS_TASK_TYPE_MEM_WAIT_VALUE) || (type == TS_TASK_TYPE_CAPTURE_WAIT) ||
        (type == TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL) || (type == TS_TASK_TYPE_IPC_WAIT) ||
        (type == TS_TASK_TYPE_CAPTURE_CONDITION)) {
        return true;
    }
    return false;
}

bool IsUseHardwareEvent(Device* const dev)
{
    const Runtime* const rt = Runtime::Instance();
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

rtError_t CheckCaptureStreamThreadIsMatch(const Stream* const stm)
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

bool IsEventCapturing(const Event* const evt, const Stream* const stm)
{
    if (evt->GetEventFlag() == RT_EVENT_EXTERNAL) {
        return false;
    }
    CaptureModel* mdl = nullptr;
    const Event* captureEvt = evt->GetCaptureEvent();
    if (captureEvt != nullptr) {
        const Stream* captureEvtStm = captureEvt->GetCaptureStream();
        if (captureEvtStm != nullptr) {
            mdl = dynamic_cast<CaptureModel*>(captureEvtStm->Model_());
            if ((mdl != nullptr) && (mdl->IsCapturing())) {
                return true;
            }
        }
    }
    const Stream* captureStm = stm->GetCaptureStream();
    if (captureStm != nullptr) {
        mdl = dynamic_cast<CaptureModel*>(captureStm->Model_());
        if ((mdl != nullptr) && (mdl->IsCapturing())) {
            return true;
        }
    }
    return false;
}
bool IsCrossCaptureModel(const Event* const evt, const Stream* const stm)
{
    CaptureModel* evtMdl = nullptr;
    const Stream* const captureStm = evt->GetCaptureStream();
    if (captureStm != nullptr) {
        evtMdl = dynamic_cast<CaptureModel*>(captureStm->Model_());
    }
    CaptureModel* stmMdl = dynamic_cast<CaptureModel*>(stm->Model_());
    // stmMdl and evtMdl must not be nullptr at this time.
    return (stmMdl != evtMdl);
}
void TerminateCapture(const Event* const evt, const Stream* const stm)
{
    CaptureModel* stmMdl = nullptr;
    const Stream* captureStm = stm->GetCaptureStream();
    if (captureStm != nullptr) {
        stmMdl = dynamic_cast<CaptureModel*>(captureStm->Model_());
    }
    CaptureModel* evtMdl = evt->GetCaptureModel();
    if (evtMdl != nullptr) {
        evtMdl->TerminateCapture();
    }
    if ((stmMdl != nullptr) && (stmMdl != evtMdl)) {
        stmMdl->TerminateCapture();
    }
}
rtError_t GetCaptureStream(Context* const ctx, Stream* const stm, const Event* const evt, Stream** const captureStm)
{
    Stream* curStm = stm->GetCaptureStream();
    if (curStm != nullptr) {
        *captureStm = curStm;
        RT_LOG(RT_LOG_INFO, "Capture stream has been created, stream_id=[%d->%d].", stm->Id_(), curStm->Id_());
        return RT_ERROR_NONE;
    }

    Event* captureEvt = evt->GetCaptureEvent();
    COND_RETURN_ERROR_MSG_INNER(
        (captureEvt == nullptr), RT_ERROR_EVENT_NULL, "Capture event is invalid, stream_id=%d, event_id=%d.",
        stm->Id_(), evt->EventId_());

    Stream* evtCaptureStm = captureEvt->GetCaptureStream();
    COND_RETURN_ERROR_MSG_INNER(
        evtCaptureStm == nullptr, RT_ERROR_MODEL_NULL,
        "Event capture stream is invalid, stream_id=%d, event_id=[%d->%d].", stm->Id_(), evt->EventId_(),
        captureEvt->EventId_());

    CaptureModel* captureMdl = dynamic_cast<CaptureModel*>(evtCaptureStm->Model_());
    COND_RETURN_ERROR_MSG_INNER(
        captureMdl == nullptr, RT_ERROR_MODEL_NULL, "Capture model is invalid, stream_id=%d, event_id=[%d->%d].",
        stm->Id_(), evt->EventId_(), captureEvt->EventId_());

    const rtError_t error = ctx->StreamAddToCaptureModelProc(stm, captureMdl);
    ERROR_RETURN_MSG_INNER(
        error, "New capture stream failed, stream_id=%d, event_id=[%d->%d].", stm->Id_(), evt->EventId_(),
        captureEvt->EventId_());

    curStm = stm->GetCaptureStream();
    COND_RETURN_ERROR_MSG_INNER(
        curStm == nullptr, RT_ERROR_STREAM_NULL, "Capture stream is invalid, stream_id=%d, event_id=[%d->%d].",
        stm->Id_(), evt->EventId_(), captureEvt->EventId_());

    RT_LOG(
        RT_LOG_INFO, "Capture event_id=%d, stream_id=[%d->%d] bounded to model_id=%u.", captureEvt->EventId_(),
        stm->Id_(), curStm->Id_(), captureMdl->Id_());
    *captureStm = curStm;
    return RT_ERROR_NONE;
}
bool IsCapturedTask(const Stream* const launchStm, const TaskInfo* submitTask)
{
    return (launchStm != submitTask->stream);
}
bool IsSoftwareSqCaptureModel(const Model* const mdl)
{
    if (mdl->GetModelType() != ModelType::RT_MODEL_CAPTURE_MODEL) {
        return false;
    }
    const CaptureModel* capMdl = dynamic_cast<const CaptureModel*>(mdl);
    return capMdl != nullptr && capMdl->IsSoftwareSqEnable();
}
static rtError_t CheckCaptureModelSupportValueWaitTask(const bool isRecord)
{
    const Runtime* const rt = Runtime::Instance();
    NULL_PTR_RETURN(rt, RT_ERROR_INVALID_VALUE);
    const rtChipType_t chipType = rt->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_VALUE_WAIT)) {
        if (isRecord) {
            RT_LOG(
                RT_LOG_WARNING,
                "Current chip does not support value write task which required by external event record.");
        } else {
            RT_LOG(
                RT_LOG_WARNING,
                "Current chip does not support value wait task, which required by external event wait.");
        }
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}
rtError_t CheckCaptureModelSupportExternalEvent(const Device* const dev, const bool isRecord)
{
    const rtError_t ret = CheckCaptureModelSupportValueWaitTask(isRecord);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    return CheckCaptureModelSupportSoftwareSq(dev);
}
rtError_t CheckCaptureModelSupportSoftwareSq(const Device* const dev)
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
rtError_t CheckCaptureModelForUpdate(const Stream* stm)
{
    Device* dev = stm->Device_();
    static rtError_t isSupportResult = CheckCaptureModelSupportSoftwareSq(dev);
    COND_RETURN_WITH_NOLOG((isSupportResult != RT_ERROR_NONE), isSupportResult);

    Model* const mdl = stm->Model_();
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        mdl, RT_ERROR_MODEL_NULL, "Checking whether the capture model is updatable");
    COND_RETURN_AND_MSG_OUTER(
        mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016,
        "Checking whether the capture model is updatable", "Non ACL Graph mode is not supported");
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    COND_RETURN_WARN(
        ((captureModel != nullptr) && captureModel->IsSubCaptureModel()), RT_ERROR_FEATURE_NOT_SUPPORT,
        "stream belongs to sub ACL Graph, does not support update operations");
    if (!captureModel->CanUpdate()) {
        RawDevice* const rawDev = dynamic_cast<RawDevice*>(dev);
        rawDev->PollEndGraphNotifyInfoByModelId(mdl->Id_());
        if (!captureModel->CanUpdate()) {
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1017, __func__, "modelRI",
                RtFmtMsg(
                    "ModelRI (model_id=%u) is in running or capture state, status=%s", captureModel->Id_(),
                    CaptureModelStatusToString(captureModel->GetCaptureModelStatus()).c_str()));
            return RT_ERROR_MODEL_UPDATE_FAILED;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CheckCaptureModelSupportCondOp(Device* const dev)
{
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);

    const rtError_t ret = CheckCaptureModelSupportSoftwareSq(dev);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_WARNING, "aclgraph condition operator depends on software sq, device_id=%u, retCode=%#x.",
            dev->Id_(), static_cast<uint32_t>(ret));
        return ret;
    }

    if (!(dev->CheckFeatureSupport(TS_FEATURE_ACLGRAPH_COND_OP))) {
        RT_LOG(RT_LOG_WARNING, "tsfw does not support aclgraph condition operator, device_id=%u.", dev->Id_());
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
            << "To perform this operation in the current thread, call aclmdlRICaptureThreadExchangeMode to change the "
               "capture mode of the current thread. "
            << "The mode set using the aclmdlRICaptureBegin API is " << StreamCaptureModeToString(contextCaptureMode)
            << ", "
            << "and the capture mode of the current thread is " << StreamCaptureModeToString(threadCaptureMode);
    } else {
        oss << "The current thread " << threadId
            << " is in the capture state and the current operation cannot be performed. "
            << "Check whether the mode set by the aclmdlRICaptureBegin API supports the current operation. "
            << "This operation is supported only in the RELAXED mode. "
            << "The mode set using the aclmdlRICaptureBegin API is " << StreamCaptureModeToString(contextCaptureMode)
            << ", "
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

rtError_t AllocNotifyIdForSubModel(Model* const mdl, Notify* notify)
{
    if ((mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL) || (notify->GetNotifyId() != MAX_UINT32_NUM)) {
        return RT_ERROR_NONE;
    }

    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    if (captureModel->IsSubCaptureModel()) {
        rtError_t error = notify->AllocId();
        COND_RETURN_WARN(error != RT_ERROR_NONE, error, "Alloc notify Id, retCode=%#x", error);
    }

    return RT_ERROR_NONE;
}

rtError_t ReleaseNotify(Model* const mdl, Notify* notify)
{
    /* 非aclgraph的，走老流程 */
    if (mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL) {
        DELETE_O(notify);
        mdl->SetEndGraphNotify(nullptr);
        return RT_ERROR_NONE;
    }

    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
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

uint32_t FindStreamIdInSubModels(CaptureModel* const parentModel, const uint16_t sqId)
{
    if (parentModel == nullptr) {
        return UINT32_MAX;
    }

    for (const auto& entry : parentModel->GetCondHandleTaskMap()) {
        CondHandle* condHandle = entry.second;
        if (condHandle == nullptr) {
            continue;
        }
        for (Model* subModel : condHandle->GetSubCaptureModels()) {
            CaptureModel* subCaptureModel = dynamic_cast<CaptureModel*>(subModel);
            if (subCaptureModel == nullptr) {
                continue;
            }
            uint32_t subStreamId = subCaptureModel->GetStreamIdBySqId(sqId);
            if (subStreamId != UINT32_MAX) {
                RT_LOG(
                    RT_LOG_WARNING,
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

bool IsTaskBelongToSubCaptureMdl(const TaskInfo* const task)
{
    Stream* stm = task->stream;
    COND_PROC((stm == nullptr), return false);

    Model* const mdl = stm->Model_();
    COND_PROC(mdl == nullptr, return false;);

    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    COND_PROC(captureModel == nullptr, return false;);

    COND_RETURN_WARN(
        captureModel->IsSubCaptureModel(), true, "model is sub ACL Graph, does not support current operation.");

    return false;
}

bool IsStreamBindWithSubModel(const Stream* const stream)
{
    COND_PROC(stream == nullptr, return false;);

    Stream* captureStream = stream->GetCaptureStream();
    COND_PROC(captureStream == nullptr, return false;);

    Model* mdl = captureStream->Model_();
    COND_PROC(mdl == nullptr, return false;);

    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    COND_PROC(captureModel == nullptr, return false;);

    COND_RETURN_WARN(
        captureModel->IsSubCaptureModel(), true,
        "stream_id=%d, capture stream_id=%d, model_id=%u, stream belongs to sub ACL Graph, does not support current "
        "operation.",
        stream->Id_(), captureStream->Id_(), captureModel->Id_());

    return false;
}

bool IsUbDma(Stream* const stm, const uint32_t kind, const void* const srcAddr, const void* const desAddr)
{
    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    rtError_t error = ConvertCpyType(&taskInfo, kind, srcAddr, RtPtrToUnConstPtr<void*>(desAddr));
    COND_RETURN_ERROR(error != RT_ERROR_NONE, false, "Failed to convert copy type, kind=%u.", kind);

    MemcpyAsyncTaskInfo memcpyAsyncTaskInfo = taskInfo.u.memcpyAsyncTaskInfo;
    if (IsDavidUbDma(memcpyAsyncTaskInfo.copyType)) {
        return true;
    }

    return false;
}

bool IsUbDmaWithSubModel(
    const Stream* const stm, const uint32_t kind, const void* const srcAddr, const void* const desAddr)
{
    COND_PROC(stm == nullptr, return false;);
    bool flag = IsUbDma(RtPtrToUnConstPtr<Stream*>(stm), kind, srcAddr, desAddr);
    COND_PROC(!flag, return false;);

    flag = IsStreamBindWithSubModel(stm);
    COND_PROC(!flag, return false;);

    return true;
}

rtError_t CalculateExternalEventRefreshLayout(size_t recordCount, size_t waitCount, ExternalEventRefreshLayout* layout)
{
    NULL_PTR_RETURN_MSG(layout, RT_ERROR_INVALID_VALUE);
    const uint64_t recordEntrySize = static_cast<uint64_t>(GetExternalRecordRefreshEntrySize());
    layout->recordOffset = 0U;
    layout->waitOffset = static_cast<uint64_t>(recordCount) * recordEntrySize;
    const uint64_t waitSize = static_cast<uint64_t>(waitCount) * EXTERNAL_WAIT_REFRESH_ENTRY_SIZE;
    layout->totalSize = layout->waitOffset + waitSize;
    return RT_ERROR_NONE;
}

void ReleaseRetainedEventResources(std::vector<EventResource>* resources)
{
    COND_PROC(resources == nullptr, return;);
    for (const auto& resource : *resources) {
        if ((resource.event != nullptr) && (resource.eventId != INVALID_EVENT_ID) && (resource.eventAddr != 0U)) {
            resource.event->EventIdCountSub(resource.eventId);
        }
    }
    resources->clear();
}

void RollbackExternalEventRefreshInfo(ExternalEventRefreshInfo* refreshInfo)
{
    COND_PROC(refreshInfo == nullptr, return;);
    for (const auto& record : refreshInfo->preparedRecords) {
        if ((record.event != nullptr) && (record.event->Device_() != nullptr) && (record.eventId != INVALID_EVENT_ID)) {
            record.event->Device_()->FreeExpandingPoolEvent(record.eventId);
        }
    }
    refreshInfo->preparedRecords.clear();
    ReleaseRetainedEventResources(&refreshInfo->retainedWaitResources);
    refreshInfo->hostRefresh.reset();
}

rtError_t InitExternalEventHostRefresh(
    ExternalEventRefreshInfo* refreshInfo, const uint8_t* hostTemplate, uint64_t totalSize, uint32_t modelId)
{
    NULL_PTR_RETURN_MSG(refreshInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(
        hostTemplate == nullptr, RT_ERROR_INVALID_VALUE, "External refresh host template is null, model_id=%u.",
        modelId);

    refreshInfo->hostRefresh =
        std::shared_ptr<uint8_t[]>(new (std::nothrow) uint8_t[totalSize](), std::default_delete<uint8_t[]>());
    COND_RETURN_ERROR_MSG_INNER(
        refreshInfo->hostRefresh == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Allocate external refresh host buffer failed, model_id=%u, size=%lu.", modelId, totalSize);
    const errno_t ret = memcpy_s(refreshInfo->hostRefresh.get(), totalSize, hostTemplate, totalSize);
    COND_RETURN_ERROR_MSG_INNER(
        ret != EOK, RT_ERROR_SEC_HANDLE, "Copy external refresh host template failed, model_id=%u, retCode=%d.",
        modelId, ret);
    return RT_ERROR_NONE;
}

rtError_t SubmitExternalEventRefreshInfo(
    Stream* launchStream, ExternalEventRefreshInfo* refreshInfo, void* deviceBase, uint64_t totalSize, uint32_t modelId)
{
    if (totalSize == 0U) {
        return RT_ERROR_NONE;
    }
    NULL_STREAM_PTR_RETURN_MSG(launchStream);
    NULL_PTR_RETURN_MSG(refreshInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(
        deviceBase == nullptr, RT_ERROR_INVALID_VALUE, "External refresh device table is null, model_id=%u.", modelId);
    COND_RETURN_ERROR_MSG_INNER(
        refreshInfo->hostRefresh == nullptr, RT_ERROR_INVALID_VALUE,
        "External refresh host buffer is null, model_id=%u.", modelId);
    uint64_t realSize = 0U;
    return MemcopyAsync(
        deviceBase, totalSize, refreshInfo->hostRefresh.get(), totalSize, RT_MEMCPY_HOST_TO_DEVICE, launchStream,
        &realSize, refreshInfo->hostRefresh);
}

void CommitExternalEventRecords(ExternalEventRefreshInfo* refreshInfo)
{
    COND_PROC(refreshInfo == nullptr, return;);
    for (const auto& record : refreshInfo->preparedRecords) {
        if (record.event != nullptr) {
            CommitPreparedExternalRecordToEvent(record.event, record.eventAddr, record.eventId);
        }
    }
    refreshInfo->preparedRecords.clear();
}

rtError_t CreateExternalWaitPlaceholder(Event* const, Stream* const stm, ExternalPlaceholderSubmitter submitPlaceholder)
{
    Device* const dev = stm->Device_();

    TaskInfo phTask = {};
    phTask.type = TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL;
    auto sqeNum = GetSendSqeNum(&phTask);

    rtError_t errorReason = RT_ERROR_NONE;
    TaskInfo* tsk = stm->AllocTask(&phTask, TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL, errorReason, sqeNum);
    COND_RETURN_ERROR_MSG_INNER(
        tsk == nullptr, errorReason, "Failed to alloc placeholder task for external wait, stream_id=%d, retCode=%#x.",
        stm->Id_(), errorReason);
    std::function<void()> const errRecycle = [&dev, &tsk]() { (void)dev->GetTaskFactory()->Recycle(tsk); };
    ScopeGuard tskErrRecycle(errRecycle);
    tsk->typeName = "CAPTURE_WAIT_EXTERNAL_PLACEHOLDER";
    tsk->sqeNum = static_cast<uint8_t>(sqeNum);
    const rtError_t error = submitPlaceholder(dev, tsk);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit placeholder task for  external wait, stream_id=%d, task_id=%hu, retCode=%#x.",
        stm->Id_(), tsk->id, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;
}

rtError_t CreateExternalRecordPlaceholder(Stream* const stm, ExternalPlaceholderSubmitter submitPlaceholder)
{
    Device* const dev = stm->Device_();

    TaskInfo phTask = {};
    phTask.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    auto sqeNum = GetSendSqeNum(&phTask);

    rtError_t errorReason = RT_ERROR_NONE;
    TaskInfo* tsk = stm->AllocTask(&phTask, TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL, errorReason, sqeNum);
    COND_RETURN_ERROR_MSG_INNER(
        tsk == nullptr, errorReason, "Failed to alloc placeholder task for external record, stream_id=%d, retCode=%#x.",
        stm->Id_(), errorReason);
    std::function<void()> const errRecycle = [&dev, &tsk]() { (void)dev->GetTaskFactory()->Recycle(tsk); };
    ScopeGuard tskErrRecycle(errRecycle);
    tsk->typeName = "CAPTURE_RECORD_EXTERNAL_PLACEHOLDER";
    tsk->sqeNum = static_cast<uint8_t>(sqeNum);
    rtError_t error = submitPlaceholder(dev, tsk);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit placeholder task for external record, stream_id=%d, task_id=%hu, retCode=%#x.",
        stm->Id_(), tsk->id, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;
}

rtError_t SubmitExternalEventTaskCommon(
    Event* evt, Stream* stm, bool isRecord, ExternalPlaceholderSubmitter submitPlaceholder)
{
    NULL_PTR_RETURN_MSG(evt, RT_ERROR_EVENT_NULL);
    NULL_STREAM_PTR_RETURN_MSG(stm);
    NULL_PTR_RETURN_MSG(submitPlaceholder, RT_ERROR_INVALID_VALUE);

    Stream* const captureStm = stm->GetCaptureStream();
    NULL_STREAM_PTR_RETURN_MSG(captureStm);
    Model* const mdl = captureStm->Model_();
    NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODEL_NULL);
    CaptureModel* const captureMdl = dynamic_cast<CaptureModel*>(mdl);
    NULL_PTR_RETURN_MSG(captureMdl, RT_ERROR_MODEL_NULL);

    rtError_t error = evt->TrySwitchToSoftwareMode();
    ERROR_RETURN_MSG_INNER(error, "Switch event to software mode failed, retCode=%#x.", error);
    error = isRecord ? CreateExternalRecordPlaceholder(stm, submitPlaceholder) :
                       CreateExternalWaitPlaceholder(evt, stm, submitPlaceholder);
    ERROR_RETURN_MSG_INNER(error, "Create external event placeholder failed, retCode=%#x.", error);

    const uint32_t taskId = captureStm->GetLastTaskId();
    error = isRecord ? captureMdl->AddExternalRecordEvent(evt, static_cast<uint32_t>(captureStm->Id_()), taskId) :
                       captureMdl->AddExternalWaitEvent(evt, static_cast<uint32_t>(captureStm->Id_()), taskId);
    ERROR_RETURN_MSG_INNER(error, "Submit external event task failed, retCode=%#x.", error);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
