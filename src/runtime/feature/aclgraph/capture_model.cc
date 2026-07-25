/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capture_model.hpp"
#include "capture_model_enum_desc.hpp"
#include "capture_model_utils.hpp"
#include "context.hpp"
#include "stream_sqcq_manage.hpp"
#include "event.hpp"
#include "event_task.h"
#include "notify.hpp"
#include "profiler.hpp"
#include "api_impl.hpp"
#include "api.hpp"
#include "runtime.hpp"
#include "capture_adapt.hpp"
#include "thread_local_container.hpp"
#include "stream_task.h"
#include "device_sq_cq_pool.hpp"
#include "sq_addr_memory_pool.hpp"
#include "inner_thread_local.hpp"
#include "drv/driver.hpp"
#include "task_recycle.hpp"
#include "aclgraph_cond_task.h"
#include "common_task.h"
#include "memory_task.h"
#include "memcpy_c.hpp"
#include "notify_c.hpp"
#include <securec.h>

namespace cce {
namespace runtime {

constexpr uint8_t RT_MODEL_CAPTURE_EXECUTE_DEFAULT = 0U; /* async and with timeout */
constexpr uint8_t RT_MODEL_CAPTURE_EXECUTE_ASYNC = 1U;   /* async */

static rtError_t RetainRecordedEventForExternalWait(Event* event, uint64_t* eventAddr, EventResource* resource)
{
    NULL_PTR_RETURN(eventAddr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN(resource, RT_ERROR_INVALID_VALUE);
    *eventAddr = 0U;
    resource->event = nullptr;
    resource->eventId = INVALID_EVENT_ID;
    resource->eventAddr = 0U;
    if (event == nullptr) {
        return RT_ERROR_EVENT_NULL;
    }

    void* const addr = event->GetEventAddr();
    const int32_t eventId = event->EventId_();
    if ((addr != nullptr) && (eventId != INVALID_EVENT_ID) && event->HasRecord() && !event->HasReset()) {
        event->EventIdCountAdd(eventId);
        *eventAddr = RtPtrToValue(addr);
        resource->event = event;
        resource->eventId = eventId;
        resource->eventAddr = *eventAddr;
    }
    return RT_ERROR_NONE;
}

static rtError_t InitExternalRecordTask(TaskInfo* taskInfo, const void* const entryAddr)
{
    const rtError_t ret = WriteValuePtrTaskInit(taskInfo, entryAddr, TASK_WR_CQE_DEFAULT);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    taskInfo->typeName = "CAPTURE_RECORD_EXTERNAL";
    taskInfo->type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    return RT_ERROR_NONE;
}

CaptureModel::CaptureModel(ModelType type) : Model(type) { beginCaptureTimeStamp_ = MsprofSysCycleTime(); }
CaptureModel::~CaptureModel() noexcept
{
    Runtime* const rt = Runtime::Instance();
    if (Runtime::IsProcessExiting(rt)) {
        FinalizeHostStateOnExit();
        return;
    }
    ReleaseExternalRefreshTable();

    // 清空capturestream和单算子流关系
    singleOperStmIdAndCaptureStmIdMap_.clear();

    for (Event* evt : captureEvents_) {
        evt->SetCaptureStream(nullptr);
        TryToFreeEventIdAndDestroyEvent(&evt, evt->EventId_(), true, true);
    }
    captureEvents_.clear();
    refCount_ = 0U;
    (void)ReleaseAllJetty();
    DeconstructSqCq();
    ClearStreamActiveTask();
    DELETE_A(switchInfo_);
    SetIsSendSqe(false);

    const std::list<Stream*> streamsCpy(StreamList_());
    // all stream need unbind first
    for (Stream* const streamObj : streamsCpy) {
        (void)UnBindSqPerStream(streamObj);
        (void)DelStream(streamObj);
        Context_()->InsertStreamList(streamObj);
    }

    // model bind with no stream, then destroy stream.
    for (Stream* const streamObj : streamsCpy) {
        (void)Context_()->StreamDestroy(streamObj, true);
    }
    (void)Context_()->Device_()->ClearEndGraphNotifyInfoByModel(this);

    ReleaseNotifyListOnDestroy(addStreamNotifyList_);
    ReleaseNotifyListOnDestroy(executeNotifyList_);
    ReleaseArgLoaderBackupOnDestroy();
    for (auto condHandle : condHandles_) {
        DELETE_O(condHandle);
    }
    condHandles_.clear();

    cachedAllSubModels_.clear();
}

rtError_t CaptureModel::SetNotifyBeforeExecute(Stream* const exeStm, CaptureModel* const captureMdl)
{
    rtError_t error = RT_ERROR_NONE;
    auto& addStreams = captureMdl->GetAddStreamMap();
    RT_LOG(
        RT_LOG_DEBUG, "streamsSize=%lu, executeNotifyList_.size()=%lu.", addStreams.size(), executeNotifyList_.size());
    Api* const apiObj = Runtime::Instance()->ApiImpl_();
    NULL_PTR_RETURN_MSG(apiObj, RT_ERROR_API_NULL);
    {
        const std::unique_lock<std::mutex> lk(notifyMutex_);
        COND_RETURN_ERROR(
            ((addStreams.size() + addStreams.size()) > executeNotifyList_.size()), RT_ERROR_INVALID_VALUE,
            "executeEventList size[%u] is less than addStreams size[%u].", executeNotifyList_.size(),
            addStreams.size());

        size_t i = 0U;
        for (auto& streamObj : addStreams) {
            Notify* notify = executeNotifyList_[i];
            COND_RETURN_ERROR_MSG_INNER((notify == nullptr), RT_ERROR_NOTIFY_NULL, "Get notify failed.");
            error = apiObj->NotifyRecord(notify, streamObj.first);
            COND_RETURN_ERROR(
                (error != RT_ERROR_NONE), error,
                "Notify record failed, exe stream_id=%d, notify id=%d, add stream_id=%d, retCode=%#x.", exeStm->Id_(),
                notify->GetNotifyId(), streamObj.first->Id_(), error);

            error = apiObj->NotifyWait(notify, exeStm, MAX_UINT32_NUM);
            COND_RETURN_ERROR(
                (error != RT_ERROR_NONE), error,
                "Notify wait failed, exe stream_id=%d, notify id=%d, add stream_id=%d, retCode=%#x.", exeStm->Id_(),
                notify->GetNotifyId(), streamObj.first->Id_(), error);
            i++;
        }
    }
    return error;
}
rtError_t CaptureModel::SetNotifyAfterExecute(
    Stream* const exeStm, CaptureModel* const captureMdl, ExternalEventRefreshInfo* refreshInfo)
{
    rtError_t error = RT_ERROR_NONE;
    auto& addStreams = captureMdl->GetAddStreamMap();
    size_t exeNotifySize = addStreams.size();
    RT_LOG(RT_LOG_DEBUG, "streamsSize=%lu, executeNotifyList size=%lu.", addStreams.size(), executeNotifyList_.size());
    Api* const apiObj = Runtime::Instance()->ApiImpl_();
    NULL_PTR_RETURN_MSG(apiObj, RT_ERROR_API_NULL);
    {
        const std::unique_lock<std::mutex> lk(notifyMutex_);
        COND_RETURN_ERROR(
            ((addStreams.size() + exeNotifySize) > executeNotifyList_.size()), RT_ERROR_INVALID_VALUE,
            "executeNotifyList size[%u] is less than addStreams size[%u].", executeNotifyList_.size(),
            addStreams.size());

        size_t i = 0U;
        for (auto& streamObj : addStreams) {
            Notify* notify = executeNotifyList_[exeNotifySize + i];
            COND_RETURN_ERROR_MSG_INNER((notify == nullptr), RT_ERROR_NOTIFY_NULL, "Get notify failed.");
            error = apiObj->NotifyRecord(notify, exeStm);
            COND_RETURN_ERROR(
                (error != RT_ERROR_NONE), error,
                "Notify record failed, exe stream_id=%d, notify_id=%d, add stream_id=%d, retCode=%#x.", exeStm->Id_(),
                notify->GetNotifyId(), streamObj.first->Id_(), error);
            std::vector<EventResource>* retainedResources =
                (refreshInfo == nullptr) ? nullptr : &refreshInfo->retainedWaitResources;
            error = NtyWait(notify, streamObj.first, MAX_UINT32_NUM, true, this, retainedResources);
            COND_RETURN_ERROR(
                (error != RT_ERROR_NONE), error,
                "Notify wait failed, exe stream_id=%d, notify_id=%d, add stream_id=%d, retCode=%#x.", exeStm->Id_(),
                notify->GetNotifyId(), streamObj.first->Id_(), error);
            i++;
        }
    }
    return error;
}
bool CaptureModel::IsAddStream(const Stream* stm) const
{
    for (auto& addStreams : addStreamMap_) {
        for (auto& addStream : addStreams.second) {
            if (addStream == stm) {
                return true;
            }
        }
    }
    return false;
}

void CaptureModel::ReportTrackData(Profiler* profiler)
{
    for (const auto& s : StreamList_()) {
        if (s == nullptr) {
            continue;
        }

        for (const auto& taskId : s->GetCacheCaptureTaskId()) {
            profiler->ReportTrackData(s, taskId);
        }
    }

    trackDataReportFlag_ = true;
}

void CaptureModel::ReportTrackDataForAllModels(Profiler* profiler)
{
    std::vector<CaptureModel*> models;
    models.push_back(this);
    auto& subs = GetAllSubCaptureModels();
    models.insert(models.end(), subs.begin(), subs.end());

    for (CaptureModel* curMdl : models) {
        curMdl->ReportTrackData(profiler);
    }

    return;
}

void CaptureModel::ReportCacheTrackData()
{
    if (trackDataReportFlag_) {
        return;
    }
    Profiler* profilerPtr = Runtime::Instance()->Profiler_();
    if ((profilerPtr == nullptr) || !(profilerPtr->GetTrackProfEnable())) {
        return;
    }
    ReportTrackDataForAllModels(profilerPtr);
    ReportedStreamInfoForProfilingForAllModels();
    ReportShapeInfoForProfilingForAllModels();
}

std::vector<CaptureModel*>& CaptureModel::GetAllSubCaptureModels()
{
    if (!cachedAllSubModels_.empty()) {
        return cachedAllSubModels_;
    }

    std::vector<CaptureModel*> stack;
    stack.push_back(this);

    do {
        CaptureModel* cur = stack.back();
        stack.pop_back();
        if (cur != this) {
            cachedAllSubModels_.push_back(cur);
        }

        for (const auto& it : cur->condHandleTaskMap_) {
            for (auto* mdl : it.second->GetSubCaptureModels()) {
                CaptureModel* subModel = dynamic_cast<CaptureModel*>(mdl);
                if (subModel != nullptr) {
                    stack.push_back(subModel);
                }
            }
        }
    } while (!stack.empty());

    return cachedAllSubModels_;
}

void CaptureModel::ClearCachedAllSubModels() { cachedAllSubModels_.clear(); }

rtError_t CaptureModel::InitAllSubCaptureModelCondTaskByDefValue()
{
    for (const auto& it : condHandleTaskMap_) {
        rtError_t error = it.second->InitCondTaskByDefValue();
        ERROR_RETURN(
            error, "Init cond task default value failed, model_id=%u, retCode=%#x.", Id_(),
            static_cast<uint32_t>(error));
    }

    auto& allSubModels = GetAllSubCaptureModels();
    for (CaptureModel* subModel : allSubModels) {
        for (const auto& it : subModel->condHandleTaskMap_) {
            rtError_t error = it.second->InitCondTaskByDefValue();
            ERROR_RETURN(
                error, "Sub model init cond task default value failed, root model_id=%u, sub model_id=%u, retCode=%#x.",
                Id_(), subModel->Id_(), static_cast<uint32_t>(error));
        }
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::CheckExecuteReady(void) const
{
    if (IsCapturing()) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1017, __func__, "modelRI",
            RtFmtMsg("ModelRI (model_id=%u) is in capturing state, status=CAPTURING", Id_()));
        return RT_ERROR_MODEL_CAPTURED;
    }

    if (captureModelStatus_ != RtCaptureModelStatus::READY) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1017, __func__, "modelRI",
            RtFmtMsg(
                "ModelRI (model_id=%u) is not ready, status=%s", Id_(),
                CaptureModelStatusToString(captureModelStatus_).c_str()));
        return RT_ERROR_MODEL_EXE_FAILED;
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::PreModelExecute(Stream* const stm, ExternalEventRefreshInfo* refreshInfo)
{
    rtError_t error = SetNotifyBeforeExecute(stm, this);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error,
        "Set notify before model execute failed, stream_id=%d, model_id=%u, retCode=%#x.", stm->Id_(), Id_(),
        static_cast<uint32_t>(error));
    error = BuildSqCq(stm);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "Build SQ/CQ failed, stream_id=%d, model_id=%u, retCode=%#x.", stm->Id_(), Id_(),
        static_cast<uint32_t>(error));

    error = InitAllSubCaptureModelCondTaskByDefValue();
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error,
        "Failed to initial sub acl graph condition value, stream_id=%d, model_id=%u, retCode=%#x.", stm->Id_(), Id_(),
        static_cast<uint32_t>(error));

    error = PrepareExternalEventRefreshInfo(refreshInfo);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error,
        "Prepare external launch refresh failed, stream_id=%d, model_id=%u, retCode=%#x.", stm->Id_(), Id_(),
        static_cast<uint32_t>(error));

    error = SubmitExternalEventRefreshInfo(
        stm, refreshInfo, externalEventRefreshDeviceBase_, externalEventRefreshLayout_.totalSize, Id_());
    if (error != RT_ERROR_NONE) {
        RollbackExternalEventRefreshInfo(refreshInfo);
        RT_LOG_INNER_MSG(
            RT_LOG_ERROR, "Submit external launch refresh failed, stream_id=%d, model_id=%u, retCode=%#x.", stm->Id_(),
            Id_(), static_cast<uint32_t>(error));
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ExecuteModel(
    Stream* const stm, int32_t timeout, const uint8_t executeMode, ExternalEventRefreshInfo* refreshInfo)
{
    ReportCacheTrackData();
    rtError_t error =
        (executeMode == RT_MODEL_CAPTURE_EXECUTE_DEFAULT) ? Model::Execute(stm, timeout) : Model::ExecuteAsync(stm);
    if (error != RT_ERROR_NONE) {
        RollbackExternalEventRefreshInfo(refreshInfo);
        RT_LOG_INNER_MSG(
            RT_LOG_ERROR, "Model execute failed, stream_id=%d, model_id=%u, retCode=%#x.", stm->Id_(), Id_(),
            static_cast<uint32_t>(error));
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::PostModelExecute(Stream* const stm, ExternalEventRefreshInfo* refreshInfo)
{
    CommitExternalEventRecords(refreshInfo);

    rtError_t error = SetNotifyAfterExecute(stm, this, refreshInfo);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Set notify after model execute failed, stream_id=%d, model_id=%u, retCode=%#x.",
        stm->Id_(), Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ExecuteCommon(Stream* const stm, int32_t timeout, const uint8_t executeMode)
{
    RT_LOG(RT_LOG_INFO, "capture model execute, model_id=%u!", Id_());
    rtError_t error = CheckExecuteReady();
    if (error != RT_ERROR_NONE) {
        return error;
    }

    ExternalEventRefreshInfo refreshInfo = {};
    error = PreModelExecute(stm, &refreshInfo);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    error = ExecuteModel(stm, timeout, executeMode, &refreshInfo);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    return PostModelExecute(stm, &refreshInfo);
}
rtError_t CaptureModel::Execute(Stream* const stm, int32_t timeout)
{
    return ExecuteCommon(stm, timeout, RT_MODEL_CAPTURE_EXECUTE_DEFAULT);
}
rtError_t CaptureModel::ExecuteAsync(Stream* const stm)
{
    return ExecuteCommon(stm, -1, RT_MODEL_CAPTURE_EXECUTE_ASYNC);
}

void CaptureModel::ReleaseNotifyListOnDestroy(std::vector<Notify*>& notifyList)
{
    for (Notify* notify : notifyList) {
        DELETE_O(notify);
    }
    notifyList.clear();
}

void CaptureModel::ReleaseArgLoaderBackupOnDestroy()
{
    ArgLoader* const argLoaderObj = Context_()->Device_()->ArgLoader_();
    for (auto argHandle : argLoaderBackup_) {
        (void)argLoaderObj->Release(argHandle);
    }
    argLoaderBackup_.clear();
}

rtError_t CaptureModel::TearDown()
{
    Runtime* const rt = Runtime::Instance();
    if (Runtime::IsProcessExiting(rt)) {
        return Model::TearDown();
    }

    Profiler* profilerPtr = Runtime::Instance()->Profiler_();
    if (profilerPtr != nullptr) {
        if (profilerPtr->GetTrackProfEnable()) {
            EraseStreamInfoForProfiling();
        }
    }
    return Model::TearDown();
}

void CaptureModel::FinalizeHostStateOnExit() noexcept
{
    singleOperStmIdAndCaptureStmIdMap_.clear();
    singleOperEvents_.clear();
    captureEvents_.clear();
    addStreamMap_.clear();
    addStreamNotifyList_.clear();
    executeNotifyList_.clear();
    externalRecordEventItems_.clear();
    externalWaitEventItems_.clear();
    externalEventRefreshHostTemplate_.reset();
    externalEventRefreshDeviceBase_ = nullptr;
    externalEventRefreshLayout_ = {};
    taskGroupStmIds_.clear();
    rdmaPiValueModifyTaskInfoMap_.clear();
    argLoaderBackup_.clear();
    isNeedUpdateEndGraph_ = false;
    trackDataReportFlag_ = false;
}

rtError_t CaptureModel::ResetCaptureEvents(Stream* const stm) const { return ResetCaptureEventsProc(this, stm); }

rtError_t CaptureModel::AddExternalRecordEvent(Event* event, uint32_t captureStreamId, uint32_t taskId)
{
    NULL_PTR_RETURN_MSG(event, RT_ERROR_EVENT_NULL);
    ExternalEventTaskItem taskRef = {event, captureStreamId, taskId};
    externalRecordEventItems_.push_back(taskRef);
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::AddExternalWaitEvent(Event* event, uint32_t captureStreamId, uint32_t taskId)
{
    NULL_PTR_RETURN_MSG(event, RT_ERROR_EVENT_NULL);
    ExternalEventTaskItem taskRef = {event, captureStreamId, taskId};
    externalWaitEventItems_.push_back(taskRef);
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::AllocateExternalRefreshTable()
{
    externalEventRefreshHostTemplate_ = std::shared_ptr<uint8_t[]>(
        new (std::nothrow) uint8_t[externalEventRefreshLayout_.totalSize](), std::default_delete<uint8_t[]>());
    COND_RETURN_ERROR_MSG_INNER(
        externalEventRefreshHostTemplate_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Allocate external refresh host template failed, model_id=%u, size=%lu.", Id_(),
        externalEventRefreshLayout_.totalSize);
    Device* const dev = Context_()->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    Driver* const driver = dev->Driver_();
    NULL_PTR_RETURN_MSG(driver, RT_ERROR_DRV_NULL);
    const rtError_t error = driver->DevMemAlloc(
        &externalEventRefreshDeviceBase_, externalEventRefreshLayout_.totalSize, RT_MEMORY_DEFAULT, dev->Id_());
    if (error != RT_ERROR_NONE) {
        const uint64_t totalSize = externalEventRefreshLayout_.totalSize;
        externalEventRefreshHostTemplate_.reset();
        externalEventRefreshDeviceBase_ = nullptr;
        externalEventRefreshLayout_ = {};
        ERROR_RETURN_MSG_INNER(
            error, "Allocate external refresh device table failed, model_id=%u, size=%lu, retCode=%#x.", Id_(),
            totalSize, error);
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::BuildActualExternalRecordTasks()
{
    const uint64_t recordEntrySize = static_cast<uint64_t>(GetExternalRecordRefreshEntrySize());
    for (size_t i = 0U; i < externalRecordEventItems_.size(); i++) {
        const ExternalEventTaskItem& taskRef = externalRecordEventItems_[i];
        TaskInfo* const taskInfo = GetTaskInfo(Context_()->Device_(), taskRef.captureStreamId, taskRef.taskId);
        const auto entryAddr = RtValueToPtr<const void*>(
            RtPtrToValue(externalEventRefreshDeviceBase_) + externalEventRefreshLayout_.recordOffset +
            i * recordEntrySize);
        const rtError_t error = InitExternalRecordTask(taskInfo, entryAddr);
        if (error != RT_ERROR_NONE) {
            ReleaseExternalRefreshTable();
            ERROR_RETURN(error, "Build actual external record Ttasks failed, model_id=%u, retCode=%#x.", Id_(), error);
        }
        taskInfo->u.memWriteValueTask.event = taskRef.event;
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::BuildActualExternalWaitTasks()
{
    for (size_t i = 0U; i < externalWaitEventItems_.size(); i++) {
        const ExternalEventTaskItem& taskRef = externalWaitEventItems_[i];
        TaskInfo* taskInfo = GetTaskInfo(Context_()->Device_(), taskRef.captureStreamId, taskRef.taskId);
        const auto entryAddr = RtValueToPtr<const void*>(
            RtPtrToValue(externalEventRefreshDeviceBase_) + externalEventRefreshLayout_.waitOffset +
            i * EXTERNAL_WAIT_REFRESH_ENTRY_SIZE);
        const rtError_t error = CaptureWaitExternalTaskInit(taskInfo, entryAddr);
        if (error != RT_ERROR_NONE) {
            ReleaseExternalRefreshTable();
            ERROR_RETURN(error, "Build actual external wait tasks failed, model_id=%u, retCode=%#x.", Id_(), error);
        }
        taskInfo->u.memWaitValueTask.event = taskRef.event;
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::RebuildAllExternalTaskSqes() const
{
    for (const ExternalEventTaskItem& taskRef : externalRecordEventItems_) {
        TaskInfo* const taskInfo = GetTaskInfo(Context_()->Device_(), taskRef.captureStreamId, taskRef.taskId);
        COND_RETURN_ERROR_MSG_INNER(
            (taskInfo == nullptr) || (taskInfo->type != TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL), RT_ERROR_INVALID_VALUE,
            "External record task is invalid, model_id=%u, stream_id=%u, task_id=%u.", Id_(), taskRef.captureStreamId,
            taskRef.taskId);
        const rtError_t error = RebuildExternalTaskSqe(taskInfo);
        ERROR_RETURN(
            error, "Failed to rebuild external record SQE, model_id=%u, retCode=%#x.", Id_(),
            static_cast<uint32_t>(error));
    }
    for (const ExternalEventTaskItem& taskRef : externalWaitEventItems_) {
        TaskInfo* const taskInfo = GetTaskInfo(Context_()->Device_(), taskRef.captureStreamId, taskRef.taskId);
        COND_RETURN_ERROR_MSG_INNER(
            (taskInfo == nullptr) || (taskInfo->type != TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL), RT_ERROR_INVALID_VALUE,
            "External wait task is invalid, model_id=%u, stream_id=%u, task_id=%u.", Id_(), taskRef.captureStreamId,
            taskRef.taskId);
        const rtError_t error = RebuildExternalTaskSqe(taskInfo);
        ERROR_RETURN(
            error, "Failed to rebuild external wait SQE, model_id=%u, retCode=%#x.", Id_(),
            static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::FinalizeExternalRefreshTable()
{
    rtError_t error = CalculateExternalEventRefreshLayout(
        externalRecordEventItems_.size(), externalWaitEventItems_.size(), &externalEventRefreshLayout_);
    ERROR_RETURN(error, "Calculate external refresh table failed, model_id=%u, retCode=%#x.", Id_(), error);
    if (externalEventRefreshLayout_.totalSize == 0U) {
        return RT_ERROR_NONE;
    }

    error = AllocateExternalRefreshTable();
    ERROR_RETURN(error, "Allocate external refresh table failed, model_id=%u, retCode=%#x.", Id_(), error);
    error = BuildActualExternalRecordTasks();
    ERROR_RETURN(error, "Build actual external record tasks failed, model_id=%u, retCode=%#x.", Id_(), error);
    error = BuildActualExternalWaitTasks();
    ERROR_RETURN(error, "Build actual external wait tasks failed, model_id=%u, retCode=%#x.", Id_(), error);
    return RT_ERROR_NONE;
}

void CaptureModel::ReleaseExternalRefreshTable()
{
    if (externalEventRefreshDeviceBase_ != nullptr) {
        Device* const dev = Context_()->Device_();
        if ((dev != nullptr) && (dev->Driver_() != nullptr)) {
            (void)dev->Driver_()->DevMemFree(externalEventRefreshDeviceBase_, dev->Id_());
        }
    }
    externalEventRefreshHostTemplate_.reset();
    externalEventRefreshDeviceBase_ = nullptr;
    externalEventRefreshLayout_ = {};
}

rtError_t CaptureModel::PrepareExternalRecordsForReplay(ExternalEventRefreshInfo* refreshInfo)
{
    NULL_PTR_RETURN_MSG(refreshInfo, RT_ERROR_INVALID_VALUE);
    rtError_t error = RT_ERROR_NONE;
    const uint64_t recordEntrySize = static_cast<uint64_t>(GetExternalRecordRefreshEntrySize());
    ScopeGuard rollbackGuard([refreshInfo]() { RollbackExternalEventRefreshInfo(refreshInfo); });
    for (size_t i = 0U; i < externalRecordEventItems_.size(); i++) {
        EventResource record = {externalRecordEventItems_[i].event, 0U, INVALID_EVENT_ID};
        void* eventAddr = nullptr;
        if ((record.event == nullptr) || (record.event->Device_() == nullptr)) {
            error = RT_ERROR_EVENT_NULL;
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "External record event is invalid, model_id=%u.", Id_());
            return error;
        }
        error = record.event->Device_()->AllocExpandingPoolEvent(&eventAddr, &record.eventId);
        ERROR_RETURN_MSG_INNER(error, "Allocate external record event failed, model_id=%u, retCode=%#x.", Id_(), error);
        record.eventAddr = RtPtrToValue(eventAddr);
        void* recordEntry = RtValueToPtr<void*>(
            RtPtrToValue(refreshInfo->hostRefresh.get()) + externalEventRefreshLayout_.recordOffset +
            i * recordEntrySize);
        error = FillExternalRecordRefreshEntry(recordEntry, record.eventAddr);
        ERROR_RETURN_MSG_INNER(
            error, "Fill external record refresh entry failed, model_id=%u, retCode=%#x.", Id_(), error);
        refreshInfo->preparedRecords.push_back(record);
    }
    rollbackGuard.ReleaseGuard();
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::PrepareExternalWaitsForReplay(ExternalEventRefreshInfo* refreshInfo)
{
    NULL_PTR_RETURN_MSG(refreshInfo, RT_ERROR_INVALID_VALUE);
    rtError_t error = RT_ERROR_NONE;
    ScopeGuard rollbackGuard([refreshInfo]() { RollbackExternalEventRefreshInfo(refreshInfo); });
    for (size_t i = 0U; i < externalWaitEventItems_.size(); i++) {
        uint64_t eventAddr = 0U;
        EventResource resource = {};
        if (externalWaitEventItems_[i].event == nullptr) {
            error = RT_ERROR_EVENT_NULL;
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "External wait event is null, model_id=%u.", Id_());
            return error;
        }
        error = RetainRecordedEventForExternalWait(externalWaitEventItems_[i].event, &eventAddr, &resource);
        ERROR_RETURN_MSG_INNER(error, "Retain external wait producer failed, model_id=%u, retCode=%#x.", Id_(), error);
        uint64_t* waitEntry = RtValueToPtr<uint64_t*>(
            RtPtrToValue(refreshInfo->hostRefresh.get()) + externalEventRefreshLayout_.waitOffset +
            i * EXTERNAL_WAIT_REFRESH_ENTRY_SIZE);
        *waitEntry = eventAddr;
        if (resource.event != nullptr) {
            refreshInfo->retainedWaitResources.push_back(resource);
        }
    }
    rollbackGuard.ReleaseGuard();
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::PrepareExternalEventRefreshInfo(ExternalEventRefreshInfo* refreshInfo)
{
    NULL_PTR_RETURN_MSG(refreshInfo, RT_ERROR_INVALID_VALUE);
    // Prepare阶段失败时只回收本轮已暂存资源：record event id、retained wait资源和host refresh buffer。
    RollbackExternalEventRefreshInfo(refreshInfo);
    if (externalEventRefreshLayout_.totalSize == 0U) {
        return RT_ERROR_NONE;
    }

    rtError_t error = InitExternalEventHostRefresh(
        refreshInfo, externalEventRefreshHostTemplate_.get(), externalEventRefreshLayout_.totalSize, Id_());
    ERROR_RETURN(error, "Init external refresh host buffer failed, model_id=%u, retCode=%#x.", Id_(), error);
    error = PrepareExternalRecordsForReplay(refreshInfo);
    ERROR_RETURN(error, "Prepare external refresh records failed, model_id=%u, retCode=%#x.", Id_(), error);
    error = PrepareExternalWaitsForReplay(refreshInfo);
    ERROR_RETURN(error, "Prepare external refresh waits failed, model_id=%u, retCode=%#x.", Id_(), error);
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::AddStreamToCaptureModel(Stream* const stm)
{
    int32_t streamId = stm->Id_();
    auto it = addStreamMap_.find(stm);
    if (it == addStreamMap_.end()) {
        rtError_t error = Context_()->StreamAddToCaptureModelProc(stm, this);
        if ((error != RT_ERROR_NONE) || (stm->GetCaptureStream() == nullptr)) {
            RT_LOG(
                RT_LOG_ERROR,
                "add stream to capture model failed, model_id=%u, device_id=%u, add stream_id=%d, retCode=%#x.", Id_(),
                Context_()->Device_()->Id_(), streamId, error);
            TerminateCapture();
            return error;
        }
        SetAddStreamMap(stm, stm->GetCaptureStream());
        RT_LOG(
            RT_LOG_INFO,
            "add stream to capture model, device_id=%u, model_id=%u, "
            "add stream_id=%d, stream_status=%d, capture stream_id=%d, retCode=%#x.",
            Context_()->Device_()->Id_(), Id_(), streamId, stm->GetCaptureStatus(), stm->GetCaptureStream()->Id_(),
            error);
    } else {
        RT_LOG(
            RT_LOG_WARNING, "already add stream_id=%d to capture model, device_id=%u, model_id=%u.", streamId,
            Context_()->Device_()->Id_(), Id_());
    }
    return RT_ERROR_NONE;
}

void CaptureModel::EnterCaptureNotify(const int32_t singleOperStmId, const int32_t captureStmId)
{
    SetCaptureModelStatus(RtCaptureModelStatus::CAPTURE_ACTIVE);
    InsertSingleOperStmIdAndCaptureStmId(singleOperStmId, captureStmId);
}

void CaptureModel::ExitCaptureNotify()
{
    SetCaptureModelStatus(RtCaptureModelStatus::READY);

    Device* const dev = Context_()->Device_();
    for (const auto& iter : singleOperStmIdAndCaptureStmIdMap_) {
        Stream* oriStm = nullptr;
        (void)dev->GetStreamSqCqManage()->GetStreamById(static_cast<uint32_t>(iter.first), &oriStm);
        if (oriStm != nullptr) {
            oriStm->ResetCaptureInfo();
        }
    }

    for (Stream* const streamObj : StreamList_()) {
        (void)streamObj->ResetTaskGroup();
    }
    for (Event* const evt : singleOperEvents_) {
        evt->SetCaptureEvent(nullptr);
    }
    singleOperEvents_.clear();
}
const TaskGroup* CaptureModel::GetTaskGroup(uint16_t streamId, uint16_t taskId)
{
    const std::unique_lock<std::mutex> lk(taskGroupListMutex_);
    for (const auto& taskGroup : taskGroupList_) {
        for (const auto& streamIdAndTaskId : taskGroup->taskIds) {
            if (streamIdAndTaskId.first == streamId && streamIdAndTaskId.second == taskId) {
                return taskGroup.get();
            }
        }
    }
    return nullptr;
}
void CaptureModel::DebugDotPrintTaskGroups(const uint32_t deviceId) const
{
    uint16_t taskGroupId = 0U;

    for (const auto& taskGroup : taskGroupList_) {
        uint16_t preTaskId = UINT16_MAX;
        uint16_t preStreamId = UINT16_MAX;
        uint16_t curTaskId = UINT16_MAX;
        uint16_t curStreamId = UINT16_MAX;

        const auto& taskVec = taskGroup->taskIds;
        if (taskVec.empty()) {
            RT_LOG(RT_LOG_EVENT, "device_id=%u, model_id=%u, taskGroupId=%u is empty.", deviceId, Id_(), taskGroupId);
            taskGroupId++;
            continue;
        }

        for (const auto& task : taskVec) {
            curStreamId = task.first;
            curTaskId = task.second;
            if ((task == (*(taskVec.cbegin()))) || (task == (*(taskVec.crbegin())))) {
                RT_LOG(
                    RT_LOG_EVENT, "device_id=%u, model_id=%u, taskGroupId=%u, stream_id=%hu, task_id=%hu.", deviceId,
                    Id_(), taskGroupId, curStreamId, curTaskId);
                preTaskId = curTaskId;
                preStreamId = curStreamId;
                continue;
            }

            if (curStreamId != preStreamId) {
                RT_LOG(
                    RT_LOG_EVENT, "device_id=%u, model_id=%u, taskGroupId=%u, stream_id=%hu, task_id=%hu.", deviceId,
                    Id_(), taskGroupId, preStreamId, preTaskId);
                RT_LOG(
                    RT_LOG_EVENT, "device_id=%u, model_id=%u, taskGroupId=%u, stream_id=%hu, task_id=%hu.", deviceId,
                    Id_(), taskGroupId, curStreamId, curTaskId);
            }
            preTaskId = curTaskId;
            preStreamId = curStreamId;
        }
        taskGroupId++;
    }
}
bool CaptureModel::ReportSingleCaptureStreamInfo(
    uint16_t captureStatus, uint32_t captureStmId, uint32_t singleOperStmId, uint64_t timeStamp) const
{
    const uint16_t deviceId = static_cast<uint16_t>(Context_()->Device_()->Id_());

    MsprofCompactInfo compactInfo{};
    compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    compactInfo.type = RT_PROFILE_TYPE_CAPTURE_STREAM_INFO;
    compactInfo.timeStamp = timeStamp;
    compactInfo.threadId = GetCurrentTid();
    compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofCaptureStreamInfo));
    compactInfo.data.captureStreamInfo.captureStatus = captureStatus;
    compactInfo.data.captureStreamInfo.modelStreamId = static_cast<uint16_t>(captureStmId);
    compactInfo.data.captureStreamInfo.originalStreamId = static_cast<uint16_t>(singleOperStmId);
    compactInfo.data.captureStreamInfo.modelId = static_cast<uint16_t>(Id_());
    compactInfo.data.captureStreamInfo.deviceId = deviceId;

    const int32_t v1Error = MsprofReportCompactInfo(0, &compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
    if (v1Error != MSPROF_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Reported capture stream info for profiling failed, retCode=%#x.", v1Error);
    }

    MsprofCompactInfo compactInfoV2{};
    compactInfoV2.level = compactInfo.level;
    compactInfoV2.type = RT_PROFILE_TYPE_CAPTURE_STREAM_INFO_V2;
    compactInfoV2.timeStamp = compactInfo.timeStamp;
    compactInfoV2.threadId = compactInfo.threadId;
    compactInfoV2.dataLen = static_cast<uint32_t>(sizeof(MsprofCaptureStreamInfoV2));
    compactInfoV2.data.captureStreamInfoV2.captureStatus = static_cast<uint8_t>(captureStatus);
    compactInfoV2.data.captureStreamInfoV2.streamId = captureStmId;
    compactInfoV2.data.captureStreamInfoV2.originalStreamId = singleOperStmId;
    compactInfoV2.data.captureStreamInfoV2.modelId = Id_();
    compactInfoV2.data.captureStreamInfoV2.deviceId = deviceId;

    const int32_t v2Error =
        MsprofReportCompactInfo(0, &compactInfoV2, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
    if (v2Error != MSPROF_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Reported capture stream info v2 for profiling failed, retCode=%#x.", v2Error);
    }

    return (v1Error == MSPROF_ERROR_NONE);
}

void CaptureModel::ReportedStreamInfoForProfiling() const
{
    for (const auto& iter : singleOperStmIdAndCaptureStmIdMap_) {
        for (int32_t captureStmId : iter.second) {
            if (!ReportSingleCaptureStreamInfo(
                    0U, static_cast<uint32_t>(captureStmId), static_cast<uint32_t>(iter.first),
                    beginCaptureTimeStamp_)) {
                return;
            }
        }
    }
}

void CaptureModel::ReportedStreamInfoForProfilingForAllModels()
{
    std::vector<CaptureModel*> models;
    models.push_back(this);
    auto& subs = GetAllSubCaptureModels();
    models.insert(models.end(), subs.begin(), subs.end());

    for (CaptureModel* curMdl : models) {
        curMdl->ReportedStreamInfoForProfiling();
    }

    return;
}

void CaptureModel::EraseStreamInfoForProfiling() const
{
    (void)ReportSingleCaptureStreamInfo(1U, 0xFFFFFFFFU, 0xFFFFFFFFU, MsprofSysCycleTime());
}
Stream* CaptureModel::GetOriginalCaptureStream(void) const
{
    for (auto stm : StreamList_()) {
        if (stm->IsOrigCaptureStream() && stm->IsLastLevelCaptureStream()) {
            return stm;
        }
    }

    return nullptr;
}
rtError_t CaptureModel::ReleaseNotifyId(uint32_t& releaseNum)
{
    rtError_t error = RT_ERROR_NOTIFY_NOT_COMPLETE;
    if ((GetEndGraphNotify() != nullptr) && (refCount_ == 0U)) {
        RT_LOG(RT_LOG_WARNING, "model_id=%u free endgraph notify_id=%u", Id_(), GetEndGraphNotify()->GetNotifyId());
        error = GetEndGraphNotify()->FreeId();
        COND_PROC(
            error != RT_ERROR_NONE,
            RT_LOG(RT_LOG_WARNING, "Free notify %u failed", GetEndGraphNotify()->GetNotifyId()));
        COND_PROC(error == RT_ERROR_NONE, isNeedUpdateEndGraph_ = true; releaseNum++;);
    }

    auto& allSubModels = GetAllSubCaptureModels();
    for (CaptureModel* subModel : allSubModels) {
        if (subModel->GetEndGraphNotify() != nullptr) {
            rtError_t subError = subModel->GetEndGraphNotify()->FreeId();
            subModel->isNeedUpdateEndGraph_ = true;
            COND_PROC(
                subError != RT_ERROR_NONE, RT_LOG(
                                               RT_LOG_DEBUG, "Model model_id=%u, free notify %u failed",
                                               subModel->Id_(), subModel->GetEndGraphNotify()->GetNotifyId()));
            COND_PROC(subError == RT_ERROR_NONE, releaseNum++;);
        }
    }

    return error;
}
rtError_t CaptureModel::AllocSqCqProc(const uint32_t streamNum) const
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t totalResNum = 0U;
    rtError_t errorTmp = RT_ERROR_NONE;

    do {
        error = Context_()->CheckStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
        error = Context_()->Device_()->GetDeviceSqCqManage()->AllocSqCq(streamNum, sqCqArray_);
        totalResNum = Context_()->Device_()->GetDeviceSqCqManage()->GetSqCqPoolTotalResNum();
        COND_PROC(error != RT_ERROR_NONE, errorTmp = Context_()->TryRecycleCaptureModelResource(streamNum, 0U, this));
        COND_RETURN_ERROR(
            (errorTmp != RT_ERROR_NONE), errorTmp, "release resource failed, model_id=%u, retCode=%#x.", Id_(),
            static_cast<uint32_t>(errorTmp));
        COND_PROC(error != RT_ERROR_NONE, (void)mmSleep(1U)); // sleep 1ms
    } while (((error != RT_ERROR_NONE) && (streamNum <= totalResNum)));

    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error,
        "sq cq res alloc failed, model_id=%u, alloc num=%u, total res num=%u, retCode=%#x.", Id_(), streamNum,
        totalResNum, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}
rtError_t CaptureModel::UpdateNotifyId(Stream* const exeStream)
{
    Stream* origCaptureStream = GetOriginalCaptureStream();
    Notify* ntf = GetEndGraphNotify();
    COND_RETURN_ERROR_MSG_INNER(
        (origCaptureStream == nullptr || ntf == nullptr), RT_ERROR_STREAM_NULL,
        "Origin capture stream and end graph notify cannot be NULL pointers, model_id=%u.", Id_());

    rtError_t error = RT_ERROR_NONE;
    rtError_t errorTmp = RT_ERROR_NONE;
    do {
        COND_PROC(ntf->GetNotifyId() != MAX_UINT32_NUM,
                  break;); // 所有子模型共用一个notify，其中一个申请，其他的就不用再申请了
        error = ntf->AllocId();
        COND_PROC(error != RT_ERROR_NONE, errorTmp = Context_()->TryRecycleCaptureModelResource(0U, 1U, this));
        COND_PROC(errorTmp != RT_ERROR_NONE, mmSleep(1U));
    } while (error != RT_ERROR_NONE);

    if (!this->IsSubCaptureModel()) { // 只有根模型才刷新，其他各层级子模型发给ts的notify
                                      // id均为根模型的id，异常时直接解执行流的endgraph wait
        loadCompleteNotifyId_ = ntf->GetNotifyId();
    }

    Context* context = origCaptureStream->Context_();
    return context->UpdateEndGraphTask(origCaptureStream, exeStream, ntf);
}

void CaptureModel::GetSqCqTotalNum(uint32_t& streamNum)
{
    streamNum = static_cast<uint32_t>(StreamList_().size());

    auto& allSubModels = GetAllSubCaptureModels();
    for (CaptureModel* subModel : allSubModels) {
        streamNum += static_cast<uint32_t>(subModel->StreamList_().size());
    }

    return;
}

rtError_t CaptureModel::BuildSqCq(Stream* const exeStream)
{
    COND_PROC(!IsSoftwareSqEnable(), return RT_ERROR_NONE);
    const std::unique_lock<std::mutex> lk(sqBindMutex_);

    SetRootExeStreamIdAll(static_cast<uint32_t>(exeStream->Id_()));
    rtError_t error = BindJettyForUbdma();
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "bind jettys for streams failed, stream_id=%d, model_id=%u", exeStream->Id_(),
        Id_());

    /* model execute repeat */
    COND_PROC_RETURN_WARN(
        (sqCqArray_ != nullptr) && (sqCqNum_ != 0U), RT_ERROR_NONE, refCount_++, "sqCqNum_=%u", sqCqNum_);

    const uint32_t streamNum = static_cast<uint32_t>(StreamList_().size());
    COND_RETURN_AND_MSG_OUTER(
        streamNum == 0U, RT_ERROR_INVALID_VALUE, ErrorCode::EE1009, std::to_string(Id_()),
        RtFmtMsg(
            "The current aclgraph model (model_id=%u) running instance neither contains any executable task nor "
            "contains any executable stream",
            Id_()));

    uint32_t totalSqcqNum = 0;
    const uint32_t sqcqPoolResNum = Context_()->Device_()->GetDeviceSqCqManage()->GetSqCqPoolTotalResNum();
    GetSqCqTotalNum(totalSqcqNum);
    COND_PROC_RETURN_AND_MSG_OUTER(
        (totalSqcqNum > RT_DEVICE_SQCQ_RES_MAX_NUM), RT_ERROR_DRV_NO_RESOURCES, ErrorCode::EE1023,
        RT_LOG(
            RT_LOG_ERROR, "exestream_id=%d, model_id=%u, totalSqcqNum=%u, sqcqPoolResNum=%u", exeStream->Id_(), Id_(),
            totalSqcqNum, sqcqPoolResNum),
        "Check Stream resource capacity", "Too many streams are captured to the ACL Graph");

    // 阶段一：Notify申请
    error = SendLoadCompleteEndGraph();
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "alloc all notify failed, stream_id=%d, model_id=%u, retCode=%#x.", exeStream->Id_(), Id_(),
            static_cast<uint32_t>(error));
        return error;
    }

    // 阶段二：SqCq申请
    error = AllocAllSqCq();
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "alloc all sqcq failed, stream_id=%d, model_id=%u, retCode=%#x.", exeStream->Id_(), Id_(),
            static_cast<uint32_t>(error));
        return error;
    }

    // 阶段三：LoadComplete 刷notify record与子model notify wait sqe
    error = UpdateNotifyIdAll(exeStream);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "update all notify id failed, stream_id=%d, model_id=%u, retCode=%#x.", exeStream->Id_(),
            Id_(), static_cast<uint32_t>(error));
        return error;
    }

    error = LoadCompleteAll(loadCompleteNotifyId_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "load complete all failed, stream_id=%d, model_id=%u, retCode=%#x.", exeStream->Id_(), Id_(),
            static_cast<uint32_t>(error));
        return error;
    }

    UpdateIsNeedUpdateEndGraphFlagAll();
    error = UpdateStreamActiveTaskFuncCallMemAll();
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "update all stream active task failed, stream_id=%d, model_id=%u, retCode=%#x.",
            exeStream->Id_(), Id_(), static_cast<uint32_t>(error));
        return error;
    }

    error = UpdateCondTaskFuncCallMemAll();
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "update all cond task failed, stream_id=%d, model_id=%u, retCode=%#x.", exeStream->Id_(),
            Id_(), static_cast<uint32_t>(error));
        return error;
    }

    refCount_++;

    return RT_ERROR_NONE;
}

void CaptureModel::DeconstructSqCq(void)
{
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0U;
    const std::unique_lock<std::mutex> lk(sqBindMutex_);

    (void)ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);
    return;
}

rtError_t CaptureModel::ReleaseSqCqAndNotifyId(uint32_t& releaseSqNum, uint32_t& releaseNtyNum)
{
    releaseSqNum = 0U;
    releaseNtyNum = 0U;
    if ((sqCqNum_ == 0U) || (refCount_ != 0U)) {
        RT_LOG(
            RT_LOG_DEBUG, "model cannot be released, model_id=%u, sqCqNum=%u, refCount=%u.", Id_(), sqCqNum_,
            refCount_);
        return RT_ERROR_NONE;
    }

    // 先递归释放子模型资源
    rtError_t error = ReleaseAllSubModelSqCq(releaseSqNum);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "release all sub models sqcq failed, model_id=%u, retCode=%#x.", Id_(),
            static_cast<uint32_t>(error));
        return error;
    }

    error = UnBindSqCq();
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "unbind sq cq failed, model_id=%u, retCode=%#x.", Id_(),
        static_cast<uint32_t>(error));

    error = Context_()->Device_()->GetDeviceSqCqManage()->FreeSqCqLazy(sqCqArray_, sqCqNum_);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "free sq cq failed, model_id=%u, retCode=%#x.", Id_(),
        static_cast<uint32_t>(error));

    releaseSqNum += sqCqNum_;
    DELETE_A(sqCqArray_);
    sqCqNum_ = 0U;

    (void)ReleaseNotifyId(releaseNtyNum);

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::BindStreamToModel(void)
{
    rtError_t error = RT_ERROR_NONE;
    /* bind stream to model */
    for (auto stm : StreamList_()) {
        uint32_t streamFlag = static_cast<uint32_t>(RT_INVALID_FLAG);
        COND_PROC(IsModelHeadStream(stm), streamFlag = RT_HEAD_STREAM);

        error = BindSqPerStream(stm, streamFlag);
        COND_PROC(error != RT_ERROR_NONE, break);
    }
    return error;
}

rtError_t CaptureModel::BindSqCq(void)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t index = 0U;
    const uint32_t streamNum = static_cast<uint32_t>(StreamList_().size());
    Device* const dev = Context_()->Device_();

    COND_RETURN_ERROR_MSG_INNER(
        (sqCqNum_ != streamNum), RT_ERROR_INVALID_VALUE,
        "SQ/CQ numbers must be equal to stream numbers, sq num=%u, stream num=%u.", sqCqNum_, streamNum);

    if (switchInfo_ == nullptr) {
        switchInfo_ = new (std::nothrow) struct sq_switch_stream_info[sqCqNum_]();
        COND_RETURN_AND_MSG_OUTER(
            switchInfo_ == nullptr, RT_ERROR_STREAM_NEW, ErrorCode::EE1013, sizeof(sq_switch_stream_info) * sqCqNum_,
            "new");
    }

    /* bind sq to stream */
    for (auto stm : StreamList_()) {
        /* update sq cq info */
        stm->UpdateSqCq(&(sqCqArray_[index]));

        /* prepare sq switch Info */
        switchInfo_[index].stream_id = static_cast<uint32_t>(stm->Id_());
        switchInfo_[index].sq_id = stm->GetSqId();
        switchInfo_[index].sq_depth = stm->GetSqDepth();
        uint64_t sqIdTmp = stm->GetSqId();
        // only for A5
        switchInfo_[index].stream_mem = RtValueToPtr<void*>(stm->GetSqBaseAddr());
        error = dev->Driver_()->MemCopySync(
            RtValueToPtr<void*>(stm->GetSqIdMemAddr()), sizeof(uint64_t), RtPtrToPtr<void*>(&(sqIdTmp)),
            sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error,
            "stream set sq id failed, device_id=%u, model_id=%u, stream_id=%u, sqId=%u, retCode=%#x.", dev->Id_(),
            Id_(), stm->Id_(), stm->GetSqId(), static_cast<uint32_t>(error));
        index++;
        RT_LOG(
            RT_LOG_INFO, "stream bind sq, device_id=%u, model_id=%u, stream_id=%d, sqId=%u, sqTail=%u, sqDepth=%u.",
            dev->Id_(), Id_(), stm->Id_(), stm->GetSqId(), stm->GetCurSqPos(), stm->GetSqDepth());
    }

    /* switch stream to sq */
    error = dev->Driver_()->SqSwitchStreamBatch(dev->Id_(), switchInfo_, sqCqNum_);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "stream bind sq failed, device_id=%u, model_id=%u, sqNum=%u, retCode=%#x.",
        dev->Id_(), Id_(), sqCqNum_, static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "stream bind sq success, device_id=%u, model_id=%u, num=%u.", dev->Id_(), Id_(), sqCqNum_);

    return error;
}
rtError_t CaptureModel::UnBindSqCq(void)
{
    rtError_t error = RT_ERROR_NONE;
    Device* const dev = Context_()->Device_();

    COND_RETURN_ERROR((switchInfo_ == nullptr), RT_ERROR_INVALID_VALUE, "switch info is null");

    /* unbind stream from model */
    for (auto stm : StreamList_()) {
        error = UnBindSqPerStream(stm);
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error,
            "model unbind stream failed, device_id=%u, model_id=%u, stream_id=%d, retCode=%#x.", dev->Id_(), Id_(),
            stm->Id_(), static_cast<uint32_t>(error));
    }

    for (uint32_t index = 0U; index < sqCqNum_; index++) {
        RT_LOG(
            RT_LOG_INFO, "stream unbind sq, device_id=%u, model_id=%u, stream_id=%d, sqId=%u.", dev->Id_(), Id_(),
            switchInfo_[index].stream_id, switchInfo_[index].sq_id);
        switchInfo_[index].stream_id = UINT32_MAX;
    }

    /* stream unbind sq */
    error = dev->Driver_()->SqSwitchStreamBatch(dev->Id_(), switchInfo_, sqCqNum_);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "stream unbind sq failed, device_id=%u, model_id=%u, retCode=%#x.", dev->Id_(),
        Id_(), static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "stream unbind sq success, device_id=%u, model_id=%u, num=%u.", dev->Id_(), Id_(), sqCqNum_);

    /* stream reset sq cq info */
    for (auto stm : StreamList_()) {
        stm->ResetSqCq();
    }

    return error;
}
rtError_t CaptureModel::MarkStreamActiveTask(TaskInfo* streamActiveTask)
{
    const std::unique_lock<std::mutex> lk(streamActiveTaskListMutex_);
    streamActiveTaskList_.push_back(streamActiveTask);

    return RT_ERROR_NONE;
}
rtError_t CaptureModel::UpdateStreamActiveTaskFuncCallMem(void)
{
    rtError_t error = RT_ERROR_NONE;
    const std::unique_lock<std::mutex> lk(streamActiveTaskListMutex_);

    for (auto task : streamActiveTaskList_) {
        if (task == nullptr) {
            RT_LOG_INNER_MSG(
                RT_LOG_ERROR, "Task cannot be a NULL pointer, device_id=%u, model_id=%u.", Context_()->Device_()->Id_(),
                Id_());
            return RT_ERROR_TASK_NULL;
        }

        COND_PROC((task->type != TS_TASK_TYPE_STREAM_ACTIVE), return RT_ERROR_TASK_BASE);

        StreamActiveTaskInfo* streamActiveTask = &(task->u.streamactiveTask);
        if (streamActiveTask->activeStream != nullptr) {
            streamActiveTask->activeStreamSqId = streamActiveTask->activeStream->GetSqId();
            error = ReConstructStreamActiveTaskFc(task);
            if (error != RT_ERROR_NONE) {
                RT_LOG(
                    RT_LOG_ERROR,
                    "reconstruct stream active task failed, device_id=%u, "
                    "model_id=%u, retCode=%#x,.",
                    Context_()->Device_()->Id_(), Id_(), static_cast<uint32_t>(error));
                break;
            }
        }
    }

    return error;
}

rtError_t CaptureModel::UpdateCondTaskFuncCallMemAll(void)
{
    rtError_t error = RT_ERROR_NONE;

    std::vector<CaptureModel*> models;
    models.push_back(this);
    auto& subs = GetAllSubCaptureModels();
    models.insert(models.end(), subs.begin(), subs.end());

    for (CaptureModel* cur : models) {
        const std::lock_guard<std::mutex> lk(cur->condHandleTaskMapLock_);
        for (const auto& entry : cur->condHandleTaskMap_) {
            CondHandle* condHandle = entry.second;
            const int32_t streamId = std::get<0>(entry.first);
            const uint16_t taskId = std::get<1>(entry.first);

            RT_LOG(RT_LOG_DEBUG, "stream_id=%d, task_id=%hu, model_id=%u.", streamId, taskId, cur->Id_());
            if (condHandle == nullptr) {
                RT_LOG(RT_LOG_WARNING, "CondHandle is null, stream_id=%d, task_id=%hu.", streamId, taskId);
                continue;
            }

            TaskInfo* taskInfo = GetTaskInfo(cur->Context_()->Device_(), static_cast<uint32_t>(streamId), taskId);
            if (taskInfo == nullptr) {
                RT_LOG(
                    RT_LOG_WARNING, "TaskInfo not found for cond task, stream_id=%d, task_id=%hu.", streamId, taskId);
                continue;
            }

            error = ReConstructCaptureConditionTaskFc(taskInfo, condHandle);
            if (error != RT_ERROR_NONE) {
                RT_LOG(
                    RT_LOG_ERROR, "Construct capture condition task fc failed, stream_id=%d, task_id=%hu, retCode=%#x.",
                    streamId, taskId, static_cast<uint32_t>(error));
                return error;
            }
        }
    }

    return error;
}
void CaptureModel::ClearStreamActiveTask(void)
{
    const std::unique_lock<std::mutex> lk(streamActiveTaskListMutex_);
    streamActiveTaskList_.clear();
}

void CaptureModel::CaptureModelExecuteFinish(const uint32_t errCode)
{
    const std::unique_lock<std::mutex> lk(sqBindMutex_);
    if (refCount_ >= 1U) {
        refCount_--;
    }
    // 模型执行出现异常,要释放所有jetty
    if (refCount_ == 0 && errCode != RT_ERROR_NONE) {
        (void)ReleaseAllJetty();
    }
    return;
}

rtError_t CaptureModel::AllocSqAddr(void) const
{
    const uint32_t deviceId = Context_()->Device_()->Id_();

    for (auto stm : StreamList_()) {
        rtError_t ret =
            stm->AllocSoftwareSqAddr(Context_()->Device_()->GetDevProperties().expandStreamAdditionalSqeNum);
        COND_RETURN_ERROR(
            (ret != RT_ERROR_NONE), ret,
            "AllocSoftwareSqAddr failed. device_id=%u, stream_id=%d, "
            "model_id=%u, retCode=%#x.",
            deviceId, stm->Id_(), Id_(), static_cast<uint32_t>(ret));
    }

    return RT_ERROR_NONE;
}

void CaptureModel::BackupArgHandle(const uint16_t streamId, const uint16_t taskId)
{
    void* argHandle = GetAndEraseArgHandle(streamId, taskId);
    if (argHandle != nullptr) {
        (void)argLoaderBackup_.insert(argHandle);
    }
}

rtError_t CaptureModel::Update(void)
{
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0U;
    rtError_t error = ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);
    ERROR_RETURN(error, "release sq cq failed, model_id=%d.", Id_());
    for (Stream* stm : StreamList_()) {
        const int32_t streamId = stm->Id_();
        error = stm->ReBuildDriverStreamResource();
        ERROR_RETURN(error, "free stream id and realloc stream id failed, stream_id=%d, model_id=%d.", streamId, Id_());
        error = stm->UpdateAllPersistentTask();
        ERROR_RETURN(error, "stream update failed, stream_id=%d, model_id=%d.", streamId, Id_());
        if (stm->GetDelayRecycleTaskSqeNum() == 0U) {
            error = Context_()->ModelDelStream(this, stm);
            ERROR_RETURN(error, "remove stream from model failed, stream_id=%d, model_id=%d.", streamId, Id_());
            error = Context_()->StreamDestroy(stm, true);
            ERROR_RETURN(error, "destroy stream failed, stream_id=%d, model_id=%d.", streamId, Id_());
        }
    }

    SetIsSendSqe(false);
    RT_LOG(
        RT_LOG_INFO, "update finish, model_id=%u, releaseSqNum=%u, releaseNtyNum=%u.", Id_(), releaseSqNum,
        releaseNtyNum);
    return RT_ERROR_NONE;
}
void CaptureModel::SetModelCacheOpInfoSwitch(const uint32_t status) const
{
    RT_LOG(
        RT_LOG_INFO, "Set model cache op info switch status, model_id=%u, status=(%u -> %u).", Id_(),
        cacheOpInfoSwitch_, status);

    if (cacheOpInfoSwitch_ != status) {
        cacheOpInfoSwitch_ = status;
        StreamSqCqManage* const streamSqCqManagePtr = Context_()->Device_()->GetStreamSqCqManage();
        for (const auto& iter : singleOperStmIdAndCaptureStmIdMap_) {
            Stream* stm = nullptr;
            (void)streamSqCqManagePtr->GetStreamById(static_cast<uint32_t>(iter.first), &stm);
            if (stm != nullptr) {
                stm->SetStreamCacheOpInfoSwitch(status);
            }
        }
    }
}
void CaptureModel::ClearShapeInfo(const int32_t streamId, const uint32_t taskId)
{
    const auto& it = shapeInfos_.find(streamId);
    if (it != shapeInfos_.end()) {
        const auto& it2 = it->second.find(taskId);
        if (it2 != it->second.end()) {
            (void)it->second.erase(it2);
        }
    }
}
rtError_t CaptureModel::SetShapeInfo(
    const Stream* const stm, const uint32_t taskId, const void* const infoPtr, const size_t infoSize)
{
    const size_t totalSize = MS_PROF_SHAPE_INFO_SIZE + MS_PROF_SHAPE_HEADER_SIZE + infoSize;
    auto rawMemPtr = std::make_unique<uint8_t[]>(totalSize);
    if (unlikely(rawMemPtr == nullptr)) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, totalSize, "new");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    MsprofShapeInfo* shapeInfo = RtPtrToPtr<MsprofShapeInfo*, uint8_t*>(rawMemPtr.get());

    MsprofShapeHeader header;
    header.modelId = stm->Model_()->Id_();
    header.deviceId = Context_()->Device_()->Id_();
    header.streamId = stm->Id_();
    header.taskId = taskId;

    MsprofShapeInfo tempShape;
    shapeInfo->magicNumber = tempShape.magicNumber;
    shapeInfo->level = MSPROF_REPORT_RUNTIME_LEVEL;
    shapeInfo->type = RT_PROFILE_TYPE_SHAPE_INFO;
    shapeInfo->threadId = stm->GetCurrentTid();
    shapeInfo->timeStamp = MsprofSysCycleTime();

    uint8_t* headerCursor = shapeInfo->data;
    auto err = memcpy_s(headerCursor, MS_PROF_SHAPE_HEADER_SIZE, &header, MS_PROF_SHAPE_HEADER_SIZE);
    COND_RETURN_ERROR_MSG_INNER(
        err != EOK, RT_ERROR_SEC_HANDLE,
        "Failed to call memcpy_s to copy header, dest=%p, dest_max=%u, src=%p, count=%u, retCode=%d.", headerCursor,
        MS_PROF_SHAPE_HEADER_SIZE, &header, MS_PROF_SHAPE_HEADER_SIZE, err);

    const uint64_t offset = RtPtrToValue(shapeInfo->data) + MS_PROF_SHAPE_HEADER_SIZE;
    err = memcpy_s(RtValueToPtr<void*>(offset), infoSize, infoPtr, infoSize);
    COND_RETURN_ERROR_MSG_INNER(
        err != EOK, RT_ERROR_SEC_HANDLE,
        "Failed to call memcpy_s to copy shapeInfo data, dest=%p, dest_max=%zu, src=%p, count=%zu, retCode=%d.",
        RtValueToPtr<void*>(offset), infoSize, infoPtr, infoSize, err);

    shapeInfo->dataLen = static_cast<uint32_t>(MS_PROF_SHAPE_HEADER_SIZE + infoSize);

    shapeInfos_[stm->Id_()][taskId] = std::move(rawMemPtr);
    return RT_ERROR_NONE;
}
void* CaptureModel::GetShapeInfo(const int32_t streamId, const uint32_t taskId, size_t& infoSize) const
{
    void* infoPtr = nullptr;
    infoSize = 0;
    const auto& it = shapeInfos_.find(streamId);
    if (it != shapeInfos_.end()) {
        const auto& it2 = it->second.find(taskId);
        if (it2 != it->second.end()) {
            MsprofShapeInfo* shapeInfo = RtPtrToPtr<MsprofShapeInfo*, uint8_t*>(it2->second.get());
            if (shapeInfo != nullptr) {
                uint8_t* headerCursor = shapeInfo->data;
                infoPtr = RtPtrToPtr<void*, uint8_t*>(headerCursor + MS_PROF_SHAPE_HEADER_SIZE);
                infoSize = static_cast<size_t>(shapeInfo->dataLen - MS_PROF_SHAPE_HEADER_SIZE);
            }
        }
    }

    return infoPtr;
}

void CaptureModel::RestoreJettyForSnapshot()
{
    COND_PROC((!IsSoftwareSqEnable()) || (!Runtime::Instance()->GetConnectUbFlag()), return);
    ClearH2dJettyInfoList();
    ClearD2dJettyInfoList();
    SetNeedUpdateUBPi(false);
    SetJettyBindFlag(false);
}

rtError_t CaptureModel::CacheLastTaskOpInfo(const void* const infoPtr, const size_t infoSize, const Stream* const stm)
{
    if (GetModelCacheOpInfoSwitch() == 0U) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1018, "rtCacheLastTaskOpInfo",
            "The operator information cache function is not enabled. "
            "Call the rtSetStreamAttribute API to enable the operator information cache function first, "
            "model_id=" +
                std::to_string(Id_()) + ", stream_id=" + std::to_string(stm->Id_()));
        return RT_ERROR_MODEL_OP_CACHE_CLOSED;
    }

    const uint32_t lastTaskId = InnerThreadLocalContainer::GetLastTaskId();
    const rtError_t ret = SetShapeInfo(stm, lastTaskId, infoPtr, infoSize);
    ERROR_RETURN(ret, "SetShapeInfo failed, streamId=%d, taskId=%u.", stm->Id_(), lastTaskId);
    return RT_ERROR_NONE;
}
void CaptureModel::ReportShapeInfoForProfiling() const
{
    for (const auto& it1 : shapeInfos_) {
        for (const auto& it2 : it1.second) {
            if (it2.second == nullptr) {
                continue;
            }
            MsprofShapeInfo* shapeInfo = RtPtrToPtr<MsprofShapeInfo*, uint8_t*>(it2.second.get());

            if (shapeInfo->dataLen < MS_PROF_SHAPE_HEADER_SIZE) {
                RT_LOG(
                    RT_LOG_ERROR, "Report capture shape info for profiling failed, data length = %u, header size = %u",
                    shapeInfo->dataLen, MS_PROF_SHAPE_HEADER_SIZE);
                continue;
            }

            MsprofShapeHeader header = {};
            auto err = memcpy_s(&header, MS_PROF_SHAPE_HEADER_SIZE, shapeInfo->data, MS_PROF_SHAPE_HEADER_SIZE);
            if (err != EOK) {
                RT_LOG(RT_LOG_ERROR, "Memcpy shape header failed.");
                continue;
            }
            const uint32_t shapeSize = shapeInfo->dataLen - MS_PROF_SHAPE_HEADER_SIZE;

            const uint32_t totalSize = MS_PROF_SHAPE_INFO_SIZE + shapeInfo->dataLen;
            err = MsprofReportAdditionalInfo(0, shapeInfo, totalSize);
            if (err != MSPROF_ERROR_NONE) {
                RT_LOG(
                    RT_LOG_ERROR,
                    "Report capture shape info for profiling failed, stream_id=%u, task_id=%u, "
                    "model_id=%u, device_id=%u, thread_id=%u, total_len=%u, shape_len=%u, retCode=%#x.",
                    header.streamId, header.taskId, header.modelId, header.deviceId, shapeInfo->threadId,
                    shapeInfo->dataLen, shapeSize, err);
                continue;
            }

            RT_LOG(
                RT_LOG_DEBUG,
                "Report capture shape info for profiling successfully, stream_id=%u, task_id=%u, "
                "model_id=%u, device_id=%u, thread_id=%u, total_len=%u, shape_len=%u.",
                header.streamId, header.taskId, header.modelId, header.deviceId, shapeInfo->threadId,
                shapeInfo->dataLen, shapeSize);
        }
    }
}

void CaptureModel::ReportShapeInfoForProfilingForAllModels()
{
    std::vector<CaptureModel*> models;
    models.push_back(this);
    auto& subs = GetAllSubCaptureModels();
    models.insert(models.end(), subs.begin(), subs.end());

    for (CaptureModel* curMdl : models) {
        curMdl->ReportShapeInfoForProfiling();
    }

    return;
}

rtError_t CaptureModel::RestoreForSoftwareSqForOneModels(Device* const dev)
{
    RT_LOG(RT_LOG_INFO, "Begin restore capture model, modelId=%u, deviceId=%u.", Id_(), dev->Id_());
    for (auto& stream : StreamList_()) {
        const rtError_t error = stream->RestoreForSoftwareSq();
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error, "Restore capture stream failed, streamId=%d, deviceId=%u, retCode=%#x.",
            stream->Id_(), dev->Id_(), error);
    }
    DELETE_A(sqCqArray_);
    sqCqNum_ = 0U;
    DELETE_A(switchInfo_);
    SetIsSendSqe(false);
    refCount_ = 0;
    RestoreJettyForSnapshot();
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::RestoreForSoftwareSq(Device* const dev)
{
    std::vector<CaptureModel*> models;
    models.push_back(this);
    auto& subs = GetAllSubCaptureModels();
    models.insert(models.end(), subs.begin(), subs.end());

    for (CaptureModel* curMdl : models) {
        rtError_t error = curMdl->RestoreForSoftwareSqForOneModels(dev);
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error, "Restore capture stream failed, model_Id=%u, ret=%d.", curMdl->Id_(),
            error);
    }

    return RT_ERROR_NONE;
}

bool CaptureModel::CheckSubModelsIsEndCapture()
{
    auto& allSubModels = GetAllSubCaptureModels();
    for (CaptureModel* subModel : allSubModels) {
        if (subModel->GetCaptureModelStatus() != RtCaptureModelStatus::READY) {
            RT_LOG(
                RT_LOG_ERROR, "sub ACL Graph is not end capture, root model_id=%u, sub model_id=%u.", Id_(),
                subModel->Id_());
            return false;
        }
    }

    return true;
}

rtError_t CaptureModel::StoreCondHandleTaskInfo(const int32_t streamId, const uint16_t taskId, CondHandle* condHandle)
{
    auto key = std::make_tuple(streamId, taskId);
    const std::lock_guard<std::mutex> lk(condHandleTaskMapLock_);

    auto it = condHandleTaskMap_.find(key);
    if (it == condHandleTaskMap_.end()) {
        (void)condHandleTaskMap_.emplace(key, condHandle);
    } else {
        RT_LOG(RT_LOG_ERROR, "Repeat store stream_id=%d task_Id=%u capture model_id=%u.", streamId, taskId, Id_());
        return RT_ERROR_INVALID_VALUE;
    }

    RT_LOG(RT_LOG_INFO, "Store stream_id=%d task_Id=%u capture model_id=%u.", streamId, taskId, Id_());
    return RT_ERROR_NONE;
}

// ========== 子模型资源管理相关方法实现 ==========

rtError_t CaptureModel::ModelEndGraph()
{
    Stream* origCaptureStream = GetOriginalCaptureStream();
    COND_RETURN_ERROR_MSG_INNER(
        (origCaptureStream == nullptr), RT_ERROR_STREAM_NULL, "Original capture stream is a NULL pointer, model_id=%u.",
        Id_());

    Api* apiObj = Runtime::Instance()->ApiImpl_();
    rtError_t error = RT_ERROR_NONE;
    uint32_t loopCnt = 0U;

    do {
        error = Context_()->CheckStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
        loopCnt++;
        error = apiObj->ModelEndGraph(this, origCaptureStream, 0U);
        COND_PROC(
            error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES && loopCnt == 1U,
            RT_LOG(RT_LOG_EVENT, "Begin for trying free Notify for model %u", Id_()));
        COND_PROC(error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES, mmSleep(1U));
        COND_PROC(error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES, Context_()->TryRecycleCaptureModelResource(0U, 1U, this));
    } while (error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES && loopCnt < 3000U);

    COND_PROC(loopCnt > 1U, RT_LOG(RT_LOG_EVENT, "End for trying free Notify"));
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "capture model end graph failed, device_id=%u, capture model_id=%u, original capture stream_id=%d, "
            "retCode=%#x.",
            Context_()->Device_()->Id_(), Id_(), origCaptureStream->Id_(), static_cast<uint32_t>(error));
        if ((error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES) || (error == RT_ERROR_DRV_NO_RESOURCES)) {
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1023, "Alloc Notify resource", "Too many ACL graphs are executed concurrently");
        }
        return error;
    }

    if (!this->IsSubCaptureModel()) { // 只有根模型才刷新，其他各层级子模型发给ts的notify
                                      // id均为根模型的id，异常时直接解执行流的endgraph wait
        loadCompleteNotifyId_ = this->GetEndGraphNotify()->GetNotifyId();
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::SendLoadCompleteEndGraph()
{
    if (IsModelLoadComplete()) {
        return RT_ERROR_NONE;
    }

    rtError_t error = ModelEndGraph();
    if (error != RT_ERROR_NONE) {
        return error;
    }

    auto& allSubModels = GetAllSubCaptureModels();
    for (CaptureModel* subModel : allSubModels) {
        if (!subModel->IsModelLoadComplete()) {
            rtError_t subError = subModel->ModelEndGraph();
            if (subError != RT_ERROR_NONE) {
                return subError;
            }
        }
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::AllocSqCqAndBindInternal()
{
    const uint32_t streamNum = static_cast<uint32_t>(StreamList_().size());
    COND_RETURN_ERROR(streamNum == 0U, RT_ERROR_INVALID_VALUE, "stream num is 0, model_id=%u.", Id_());

    COND_RETURN_INFO(
        (sqCqArray_ != nullptr) && (sqCqNum_ != 0U), RT_ERROR_NONE, "model_id=%u, sqCqNum_=%u, stream num=%u", Id_(),
        sqCqNum_, streamNum);

    sqCqArray_ = new (std::nothrow) rtDeviceSqCqInfo_t[streamNum];
    COND_RETURN_AND_MSG_OUTER(
        sqCqArray_ == nullptr, RT_ERROR_STREAM_NEW, ErrorCode::EE1013,
        std::to_string(sizeof(rtDeviceSqCqInfo_t) * streamNum), "new");

    rtError_t error = AllocSqCqProc(streamNum);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "alloc sq resource failed, model_id=%u, required number=%u, current available number=%u, "
            "maximum number=%u, retCode=%#x.",
            Id_(), streamNum, Context_()->Device_()->GetDeviceSqCqManage()->GetSqCqPoolFreeResNum(),
            Context_()->Device_()->GetDeviceSqCqManage()->GetSqCqPoolTotalResNum(), static_cast<uint32_t>(error));
        if ((error == RT_ERROR_DRV_NO_RESOURCES) || (error == RT_ERROR_DEVICE_SQCQ_POOL_RESOURCE_FULL)) {
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1023, "Alloc Stream resource", "Too many streams are captured to the ACL Graph");
        }
        DELETE_A(sqCqArray_);
        return error;
    }

    sqCqNum_ = streamNum;
    error = AllocSqAddr();
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_A(sqCqArray_); sqCqNum_ = 0U;
                                , "alloc sq addr failed, model_id=%u, retCode=%#x.", Id_(),
                                static_cast<uint32_t>(error));

    error = BindSqCqAndSendSqe();
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_A(sqCqArray_); sqCqNum_ = 0U;
                                , "bind sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    SetFirstExecute(true);
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::AllocAllSqCq()
{
    rtError_t error = AllocSqCqAndBindInternal();
    if (error != RT_ERROR_NONE) {
        return error;
    }

    auto& allSubModels = GetAllSubCaptureModels();
    for (CaptureModel* subModel : allSubModels) {
        error = subModel->AllocSqCqAndBindInternal();
        if (error != RT_ERROR_NONE) {
            return error;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ReleaseSqCqInternal(uint32_t& releaseNum)
{
    if (refCount_ > 0U) {
        refCount_--;
        return RT_ERROR_NONE;
    }

    if ((sqCqNum_ == 0U) || (sqCqArray_ == nullptr)) {
        return RT_ERROR_NONE;
    }

    rtError_t error = UnBindSqCq();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "unbind sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
        return error;
    }

    error = Context_()->Device_()->GetDeviceSqCqManage()->FreeSqCqLazy(sqCqArray_, sqCqNum_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "free sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
        return error;
    }

    releaseNum += sqCqNum_;
    DELETE_A(sqCqArray_);
    sqCqNum_ = 0U;

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ReleaseAllSubModelSqCq(uint32_t& releaseNum)
{
    auto& allSubModels = GetAllSubCaptureModels();
    for (CaptureModel* subModel : allSubModels) {
        rtError_t error = subModel->ReleaseSqCqInternal(releaseNum);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, error,
            "release all sqcq failed. root model_id=%u, sub model_id=%u, sqCqNum=%u, releaseNum=%u", Id_(),
            subModel->Id_(), subModel->sqCqNum_, releaseNum);
    }

    return RT_ERROR_NONE;
}

void CaptureModel::UpdateIsNeedUpdateEndGraphFlagAll()
{
    std::vector<CaptureModel*> models;
    models.push_back(this);
    auto& subs = GetAllSubCaptureModels();
    models.insert(models.end(), subs.begin(), subs.end());

    for (CaptureModel* curMdl : models) {
        curMdl->isNeedUpdateEndGraph_ = false;
    }

    return;
}

rtError_t CaptureModel::LoadCompleteAll(uint32_t loadCompltetNotifyId)
{
    std::vector<CaptureModel*> models;
    models.push_back(this);
    auto& subs = GetAllSubCaptureModels();
    models.insert(models.end(), subs.begin(), subs.end());

    for (CaptureModel* curMdl : models) {
        if (!curMdl->IsModelLoadComplete() || curMdl->isNeedUpdateEndGraph_) {
            curMdl->loadCompleteNotifyId_ = loadCompltetNotifyId;
            rtError_t error = curMdl->LoadComplete();
            if (error != RT_ERROR_NONE) {
                RT_LOG(
                    RT_LOG_ERROR, "load complete failed, model_id=%u, retCode=%#x.", curMdl->Id_(),
                    static_cast<uint32_t>(error));
                return error;
            }
        }
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::UpdateNotifyIdAll(Stream* const exeStream)
{
    /* 更新所有图的endgraph notify record sqe */
    rtError_t error = UpdateNotifyIdForAllModels(exeStream);
    ERROR_RETURN_MSG_INNER(
        error, "update notify id for each model failed, model_id=%u, retCode=%#x.", Id_(),
        static_cast<uint32_t>(error));

    /* 更新所有条件算子后面的notify wait sqe */
    error = UpdateCondTaskNotifyWaitSqe(exeStream);
    ERROR_RETURN_MSG_INNER(
        error, "update cond task notify wait sqe failed, model_id=%u, retCode=%#x.", Id_(),
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::UpdateNotifyIdForAllModels(Stream* const exeStream)
{
    std::vector<CaptureModel*> models;
    models.push_back(this);
    auto& subs = GetAllSubCaptureModels();
    models.insert(models.end(), subs.begin(), subs.end());

    rtError_t error = RT_ERROR_NONE;
    for (CaptureModel* curMdl : models) {
        if (curMdl->isNeedUpdateEndGraph_) {
            error = curMdl->UpdateNotifyId(exeStream);
            ERROR_RETURN_MSG_INNER(
                error, "capture model update notify failed, model_id=%u, retCode=%#x.", curMdl->Id_(),
                static_cast<uint32_t>(error));
            RT_LOG(
                RT_LOG_DEBUG, "model_id=%u Alloc endgraph notify_id=%u", curMdl->Id_(),
                curMdl->GetEndGraphNotify()->GetNotifyId());
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::UpdateCondTaskNotifyWaitSqe(Stream* const exeStream)
{
    std::vector<CaptureModel*> models;
    models.push_back(this);
    auto& subs = GetAllSubCaptureModels();
    models.insert(models.end(), subs.begin(), subs.end());

    rtError_t error = RT_ERROR_NONE;
    for (CaptureModel* curMdl : models) {
        for (const auto& it : curMdl->condHandleTaskMap_) {
            CondHandle* condHandle = it.second;
            Stream* dstStream = nullptr;
            for (Model* mdl : condHandle->GetSubCaptureModels()) {
                CaptureModel* subModel = dynamic_cast<CaptureModel*>(mdl);
                if (subModel != nullptr) {
                    dstStream = subModel->GetExeStream();
                    break;
                }
            }

            COND_PROC(dstStream == nullptr, continue;);

            int32_t streamId = 0U;
            uint16_t taskId = 0U;
            std::tie(streamId, taskId) = it.first;
            COND_RETURN_ERROR(
                dstStream->Id_() != streamId, RT_ERROR_INVALID_VALUE,
                "stream_id=%d, sub ACL Graph exec stream_id=%d, model_id=%u.", streamId, dstStream->Id_(),
                curMdl->Id_());

            TaskInfo* taskInfo = dstStream->Device_()->GetTaskFactory()->GetTask(streamId, taskId);
            COND_RETURN_ERROR(
                taskInfo == nullptr, RT_ERROR_TASK_NULL, "stream_id=%d, submodel task_id=%u.", streamId, taskId);
            COND_RETURN_ERROR(
                taskInfo->type != TS_TASK_TYPE_CAPTURE_CONDITION, RT_ERROR_INVALID_VALUE,
                "task type is not capture condition, stream_id=%d, task_id=%u.", streamId, taskId);

            taskInfo->u.captureConditionTask.notifyId = condHandle->GetSubModelNotify()->GetNotifyId();
            Context* context = dstStream->Context_();
            error = context->UpdateSuModelExeStreamNotifyWaitSqe(taskInfo, exeStream);
            COND_RETURN_ERROR(
                error != RT_ERROR_NONE, error, "update cond task notify wait sqe failed, stream_id=%d, task_id=%u.",
                streamId, taskId);
        }
    }
    return RT_ERROR_NONE;
}

void CaptureModel::SetRootExeStreamIdAll(uint16_t rootExeStreamId)
{
    SetRootExeStreamId(rootExeStreamId);
    auto& allSubModels = GetAllSubCaptureModels();
    for (CaptureModel* subModel : allSubModels) {
        subModel->SetRootExeStreamId(rootExeStreamId);
    }
}

rtError_t CaptureModel::UpdateStreamActiveTaskFuncCallMemAll()
{
    rtError_t error = UpdateStreamActiveTaskFuncCallMem();
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "update stream active task failed, model_id=%u, retCode=%#x.", Id_(),
            static_cast<uint32_t>(error));
        return error;
    }

    auto& allSubModels = GetAllSubCaptureModels();
    for (CaptureModel* subModel : allSubModels) {
        error = subModel->UpdateStreamActiveTaskFuncCallMem();
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "update stream active task failed, model_id=%u, retCode=%#x.", subModel->Id_(),
                static_cast<uint32_t>(error));
            return error;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::EndCaptureAdapterProc()
{
    const rtError_t error = FinalizeExternalRefreshTable();
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to finalize external refresh table, retCode=%#x.",
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
