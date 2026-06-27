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
#include "common/enum_to_string_utils.hpp"
#include "context.hpp"
#include "stream_sqcq_manage.hpp"
#include "event.hpp"
#include "event_task.h"
#include "notify.hpp"
#include "profiler.hpp"
#include "api_impl.hpp"
#include "api.hpp"
#include "capture_adapt.hpp"
#include "thread_local_container.hpp"
#include "stream_task.h"
#include "device_sq_cq_pool.hpp"
#include "sq_addr_memory_pool.hpp"
#include "inner_thread_local.hpp"
#include "drv/driver.hpp"
#include "task_recycle.hpp"
#include "aclgraph_cond_task.h"

namespace cce {
namespace runtime {

constexpr uint8_t RT_MODEL_CAPTURE_EXECUTE_DEFAULT = 0U; /* async and with timeout */
constexpr uint8_t RT_MODEL_CAPTURE_EXECUTE_ASYNC = 1U;   /* async */

CaptureModel::CaptureModel(ModelType type) : Model(type)
{
    beginCaptureTimeStamp_ = MsprofSysCycleTime();
}
CaptureModel::~CaptureModel() noexcept
{
    // 清空capturestream和单算子流关系
    singleOperStmIdAndCaptureStmIdMap_.clear();

    for (Event *evt : captureEvents_) {
        evt->SetCaptureStream(nullptr);
        TryToFreeEventIdAndDestroyEvent(&evt, evt->EventId_(), true, true);
    }
    captureEvents_.clear();
    refCount_ = 0U;
    ReleaseAllJetty();
    DeconstructSqCq();
    ClearStreamActiveTask();
    DELETE_A(switchInfo_);
    SetIsSendSqe(false);
    
    const std::list<Stream *> streamsCpy(StreamList_());
    // all stream need unbind first
    for (Stream * const streamObj : streamsCpy) {
        (void)UnBindSqPerStream(streamObj);
        (void)DelStream(streamObj);
        Context_()->InsertStreamList(streamObj);
    }

    // model bind with no stream, then destroy stream.
    for (Stream * const streamObj : streamsCpy) {
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
}

rtError_t CaptureModel::SetNotifyBeforeExecute(Stream * const exeStm, CaptureModel* const captureMdl)
{
    rtError_t error = RT_ERROR_NONE;
    auto &addStreams = captureMdl->GetAddStreamMap();
    RT_LOG(RT_LOG_DEBUG, "streamsSize=%lu, executeNotifyList_.size()=%lu.",
           addStreams.size(), executeNotifyList_.size());
    Api * const apiObj = Runtime::Instance()->ApiImpl_();
    NULL_PTR_RETURN_MSG(apiObj, RT_ERROR_API_NULL);
    {
        const std::unique_lock<std::mutex> lk(notifyMutex_);
        COND_RETURN_ERROR(((addStreams.size() + addStreams.size()) > executeNotifyList_.size()), RT_ERROR_INVALID_VALUE,
            "executeEventList size[%u] is less than addStreams size[%u].",
            executeNotifyList_.size(), addStreams.size());

        size_t i = 0U;
        for (auto &streamObj : addStreams) {
            Notify *notify = executeNotifyList_[i];
            COND_RETURN_ERROR_MSG_INNER((notify == nullptr), RT_ERROR_NOTIFY_NULL, "Get notify failed.");
            error = apiObj->NotifyRecord(notify, streamObj.first);
            COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
                "Notify record failed, exe stream_id=%d, notify id=%d, add stream_id=%d, retCode=%#x.",
                exeStm->Id_(), notify->GetNotifyId(), streamObj.first->Id_(), error);
 
            error = apiObj->NotifyWait(notify, exeStm, MAX_UINT32_NUM);
            COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
                "Notify wait failed, exe stream_id=%d, notify id=%d, add stream_id=%d, retCode=%#x.",
                exeStm->Id_(), notify->GetNotifyId(), streamObj.first->Id_(), error);
            i++;
        }
    }
    return error;
}
rtError_t CaptureModel::SetNotifyAfterExecute(Stream * const exeStm, CaptureModel* const captureMdl)
{
    rtError_t error = RT_ERROR_NONE;
    auto &addStreams = captureMdl->GetAddStreamMap();
    size_t exeNotifySize = addStreams.size();
    RT_LOG(RT_LOG_DEBUG, "streamsSize=%lu, executeNotifyList size=%lu.",
           addStreams.size(), executeNotifyList_.size());
    Api * const apiObj = Runtime::Instance()->ApiImpl_();
    NULL_PTR_RETURN_MSG(apiObj, RT_ERROR_API_NULL);
    {
        const std::unique_lock<std::mutex> lk(notifyMutex_);
        COND_RETURN_ERROR(((addStreams.size() + exeNotifySize) > executeNotifyList_.size()), RT_ERROR_INVALID_VALUE,
            "executeNotifyList size[%u] is less than addStreams size[%u].",
            executeNotifyList_.size(), addStreams.size());
 
        size_t i = 0U;
        for (auto &streamObj : addStreams) {
            Notify *notify = executeNotifyList_[exeNotifySize + i];
            COND_RETURN_ERROR_MSG_INNER((notify == nullptr), RT_ERROR_NOTIFY_NULL, "Get notify failed.");
            error = apiObj->NotifyRecord(notify, exeStm);
            COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
                "Notify record failed, exe stream_id=%d, notify_id=%d, add stream_id=%d, retCode=%#x.",
                exeStm->Id_(), notify->GetNotifyId(), streamObj.first->Id_(), error);
            error = apiObj->NotifyWait(notify, streamObj.first, MAX_UINT32_NUM);
            COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
                "Notify wait failed, exe stream_id=%d, notify_id=%d, add stream_id=%d, retCode=%#x.",
                exeStm->Id_(), notify->GetNotifyId(), streamObj.first->Id_(), error);
            i++;
        }
    }
    return error;
}
bool CaptureModel::IsAddStream(const Stream *stm) const
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
void CaptureModel::ReportCacheTrackData()
{
    if (trackDataReportFlag_) {
        return;
    }
    Profiler* profilerPtr = Runtime::Instance()->Profiler_();
    if ((profilerPtr == nullptr) || !(profilerPtr->GetTrackProfEnable())) {
        return;
    }
    for (const auto &s : StreamList_()) {
        if (s == nullptr) {
            continue;
        }
        for (const auto &taskId : s->GetCacheCaptureTaskId()) {
            profilerPtr->ReportTrackData(s, taskId);
        }
    }
    ReportedStreamInfoForProfiling();
    ReportShapeInfoForProfiling();
    trackDataReportFlag_ = true;
}

rtError_t CaptureModel::InitAllSubCaptureModelCondTaskByDefValue()
{
    for (const auto &it : condHandleTaskMap_) {
        CondHandle *condHandle = it.second;
        rtError_t error = condHandle->InitCondTaskByDefValue();
        ERROR_RETURN(error, "Init cond task default value failed, model_id=%u, retCode=%#x.",
            Id_(), static_cast<uint32_t>(error));

        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            COND_PROC((subModel == nullptr), continue;);

            error = subModel->InitAllSubCaptureModelCondTaskByDefValue();
            ERROR_RETURN(error, "Sub model init cond task default value failed, model_id=%u, sub model_id=%u, retCode=%#x.",
                Id_(), subModel->Id_(), static_cast<uint32_t>(error));
        }
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ExecuteCommon(Stream * const stm, int32_t timeout, const uint8_t executeMode)
{
    RT_LOG(RT_LOG_INFO, "capture model execute, model_id=%u!", Id_());

    if (IsCapturing()) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1017, __func__, "model", RtFmtMsg("Model (model_id=%u) is in capturing state, status=CAPTURING", Id_()));
        return RT_ERROR_MODEL_CAPTURED;
    }

    if (captureModelStatus_ != RtCaptureModelStatus::READY) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1017, __func__, "model",
            RtFmtMsg("Model (model_id=%u) is not ready, status=%s", Id_(), CaptureModelStatusToString(captureModelStatus_).c_str()));
        return RT_ERROR_MODEL_EXE_FAILED;
    }

    rtError_t error = SetNotifyBeforeExecute(stm, this);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Set notify before model execute failed, stream_id=%d, model_id=%u, retCode=%#x.",
        stm->Id_(), Id_(), static_cast<uint32_t>(error));
    error = BuildSqCq(stm);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Build SQ/CQ failed, stream_id=%d, model_id=%u, retCode=%#x.",
        stm->Id_(), Id_(), static_cast<uint32_t>(error));  

    error = InitAllSubCaptureModelCondTaskByDefValue();
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Failed to initial sub acl graph condition value, stream_id=%d, model_id=%u, retCode=%#x.",
        stm->Id_(), Id_(), static_cast<uint32_t>(error));  

    ReportCacheTrackData();
    if (executeMode == RT_MODEL_CAPTURE_EXECUTE_DEFAULT) {
        error = Model::Execute(stm, timeout);
    } else {
        error = Model::ExecuteAsync(stm);
    }

    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Model execute failed, stream_id=%d, model_id=%u, retCode=%#x.",
        stm->Id_(), Id_(), static_cast<uint32_t>(error));

    error = SetNotifyAfterExecute(stm, this);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Set notify after model execute failed, stream_id=%d, model_id=%u, retCode=%#x.",
        stm->Id_(), Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}
rtError_t CaptureModel::Execute(Stream * const stm, int32_t timeout)
{
    return ExecuteCommon(stm, timeout, RT_MODEL_CAPTURE_EXECUTE_DEFAULT);
}
rtError_t CaptureModel::ExecuteAsync(Stream * const stm)
{
    return ExecuteCommon(stm, -1, RT_MODEL_CAPTURE_EXECUTE_ASYNC);
}

void CaptureModel::ReleaseNotifyListOnDestroy(std::vector<Notify *> &notifyList)
{
    for (Notify *notify : notifyList) {
        DELETE_O(notify);
    }
    notifyList.clear();
}

void CaptureModel::ReleaseArgLoaderBackupOnDestroy()
{
    ArgLoader * const argLoaderObj = Context_()->Device_()->ArgLoader_();
    for (auto argHandle : argLoaderBackup_) {
        (void)argLoaderObj->Release(argHandle);
    }
    argLoaderBackup_.clear();
}

rtError_t CaptureModel::TearDown()
{
    Profiler *profilerPtr = Runtime::Instance()->Profiler_();
    if (profilerPtr != nullptr) {
        if (profilerPtr->GetTrackProfEnable()) {
            EraseStreamInfoForProfiling();
        }
    }
    return Model::TearDown();
}
rtError_t CaptureModel::ResetCaptureEvents(Stream * const stm) const
{
    return ResetCaptureEventsProc(this, stm);
}

rtError_t CaptureModel::AddStreamToCaptureModel(Stream * const stm)
{
    int32_t streamId = stm->Id_();
    auto it = addStreamMap_.find(stm);
    if (it == addStreamMap_.end()) { 
        rtError_t error = Context_()->StreamAddToCaptureModelProc(stm, this);
        if ((error != RT_ERROR_NONE) || (stm->GetCaptureStream() == nullptr)) {
            RT_LOG(RT_LOG_ERROR,
                "add stream to capture model failed, model_id=%u, device_id=%u, add stream_id=%d, retCode=%#x.",
                Id_(), Context_()->Device_()->Id_(), streamId, error);
            TerminateCapture();
            return error;
        }
        SetAddStreamMap(stm, stm->GetCaptureStream());
        RT_LOG(RT_LOG_INFO,
 	        "add stream to capture model, device_id=%u, model_id=%u, "
 	        "add stream_id=%d, stream_status=%d, capture stream_id=%d, retCode=%#x.", Context_()->Device_()->Id_(),
 	        Id_(), streamId, stm->GetCaptureStatus(), stm->GetCaptureStream()->Id_(), error);
    } else {
        RT_LOG(RT_LOG_WARNING,
            "already add stream_id=%d to capture model, device_id=%u, model_id=%u.", streamId, Context_()->Device_()->Id_(), Id_());
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

    Device * const dev = Context_()->Device_();
    for (const auto& iter: singleOperStmIdAndCaptureStmIdMap_) {
        Stream *oriStm = nullptr;
        (void)dev->GetStreamSqCqManage()->GetStreamById(static_cast<uint32_t>(iter.first), &oriStm);
        if (oriStm != nullptr) {
            oriStm->ResetCaptureInfo();
        }
    }

    for (Stream * const streamObj : StreamList_()) {
        (void)streamObj->ResetTaskGroup();
    }
    for (Event * const evt : singleOperEvents_) {
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

    for (const auto &taskGroup : taskGroupList_) {
        uint16_t preTaskId = UINT16_MAX;
        uint16_t preStreamId = UINT16_MAX;
        uint16_t curTaskId = UINT16_MAX;
        uint16_t curStreamId = UINT16_MAX;

        const auto &taskVec = taskGroup->taskIds;
        if (taskVec.empty()) {
            RT_LOG(RT_LOG_EVENT, "device_id=%u, model_id=%u, taskGroupId=%u is empty.",
                deviceId, Id_(), taskGroupId);
            taskGroupId++;
            continue;
        }

        for (const auto &task : taskVec) {
            curStreamId = task.first;
            curTaskId = task.second;
            if ((task == (*(taskVec.cbegin()))) || (task == (*(taskVec.crbegin())))) {
                RT_LOG(RT_LOG_EVENT, "device_id=%u, model_id=%u, taskGroupId=%u, stream_id=%hu, task_id=%hu.",
                    deviceId, Id_(), taskGroupId, curStreamId, curTaskId);
                preTaskId = curTaskId;
                preStreamId = curStreamId;
                continue;
            }

            if (curStreamId != preStreamId) {
                RT_LOG(RT_LOG_EVENT, "device_id=%u, model_id=%u, taskGroupId=%u, stream_id=%hu, task_id=%hu.",
                    deviceId, Id_(), taskGroupId, preStreamId, preTaskId);
                RT_LOG(RT_LOG_EVENT, "device_id=%u, model_id=%u, taskGroupId=%u, stream_id=%hu, task_id=%hu.",
                    deviceId, Id_(), taskGroupId, curStreamId, curTaskId);
            }
            preTaskId = curTaskId;
            preStreamId = curStreamId;
        }
        taskGroupId++;
    }
}
void CaptureModel::ReportedStreamInfoForProfiling() const
{
    MsprofCompactInfo compactInfo;
    compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    compactInfo.type = RT_PROFILE_TYPE_CAPTURE_STREAM_INFO;
    compactInfo.timeStamp = beginCaptureTimeStamp_;
    compactInfo.threadId = GetCurrentTid();
    compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofCaptureStreamInfo));
    for (const auto &iter : singleOperStmIdAndCaptureStmIdMap_) {
        const int32_t singleOperStmId = iter.first;
        const auto& captureStmIds = iter.second;
        for (int32_t captureStmId : captureStmIds) {
            compactInfo.data.captureStreamInfo.captureStatus = 0U;
            compactInfo.data.captureStreamInfo.modelStreamId = static_cast<uint16_t>(captureStmId);
            compactInfo.data.captureStreamInfo.originalStreamId = static_cast<uint16_t>(singleOperStmId);
            compactInfo.data.captureStreamInfo.modelId = static_cast<uint16_t>(Id_());
            compactInfo.data.captureStreamInfo.deviceId = static_cast<uint16_t>(Context_()->Device_()->Id_());
            const auto error =
                MsprofReportCompactInfo(0, &compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
            if (error != MSPROF_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "Reported capture stream info for profiling failed, ret=%d.", error);
                return;
            }
            RT_LOG(RT_LOG_DEBUG,
                "Reported capture stream info for profiling successfully, captureStatus=%hu, stream_id=%hu, "
                "original_stream_id=%hu, model_id=%hu, device_id=%hu, beginCaptureTimeStamp_=%" PRIu64 ".",
                compactInfo.data.captureStreamInfo.captureStatus,
                compactInfo.data.captureStreamInfo.modelStreamId,
                compactInfo.data.captureStreamInfo.originalStreamId,
                compactInfo.data.captureStreamInfo.modelId,
                compactInfo.data.captureStreamInfo.deviceId,
                beginCaptureTimeStamp_);
        }
    }
    return;
}
void CaptureModel::EraseStreamInfoForProfiling() const
{
    MsprofCompactInfo compactInfo;
    compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    compactInfo.type = RT_PROFILE_TYPE_CAPTURE_STREAM_INFO;
    compactInfo.timeStamp = MsprofSysCycleTime();
    compactInfo.threadId = GetCurrentTid();
    compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofCaptureStreamInfo));
    compactInfo.data.captureStreamInfo.captureStatus = 1U;
    compactInfo.data.captureStreamInfo.modelStreamId = 0xFFFFU;
    compactInfo.data.captureStreamInfo.originalStreamId = 0xFFFFU;
    compactInfo.data.captureStreamInfo.modelId = static_cast<uint16_t>(Id_());
    compactInfo.data.captureStreamInfo.deviceId = static_cast<uint16_t>(Context_()->Device_()->Id_());
    const auto error = MsprofReportCompactInfo(0, &compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
    if (error != MSPROF_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Reported capture stream info for profiling failed, ret=%d.", error);
    } else {
        RT_LOG(RT_LOG_DEBUG,
            "Reported capture stream info for profiling successfully, captureStatus=%hu, stream_id=%hu, "
            "original_stream_id=%hu, model_id=%hu, device_id=%hu.",
            compactInfo.data.captureStreamInfo.captureStatus,
            compactInfo.data.captureStreamInfo.modelStreamId,
            compactInfo.data.captureStreamInfo.originalStreamId,
            compactInfo.data.captureStreamInfo.modelId,
            compactInfo.data.captureStreamInfo.deviceId);
    }
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
rtError_t CaptureModel::ReleaseNotifyId(uint32_t &releaseNum)
{
    // 递归释放子模型的 notify
    for (const auto &it : condHandleTaskMap_) {
        CondHandle *condHandle = it.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if ((subModel != nullptr) && (subModel->GetEndGraphNotify() != nullptr) &&
                (subModel->GetEndGraphNotify()->GetNotifyId() != MAX_UINT32_NUM)) {
                (void)subModel->ReleaseNotifyId(releaseNum);
            }
        }
    }

    rtError_t error = RT_ERROR_NOTIFY_NOT_COMPLETE;
    if ((GetEndGraphNotify() != nullptr) && (refCount_ == 0U)) {
        RT_LOG(RT_LOG_WARNING, "model_id=%u free endgraph notify_id=%u", Id_(), GetEndGraphNotify()->GetNotifyId());
        error = GetEndGraphNotify()->FreeId();
        COND_PROC(error != RT_ERROR_NONE, RT_LOG(RT_LOG_WARNING, "Free notify %u failed", GetEndGraphNotify()->GetNotifyId()));
        COND_PROC(error == RT_ERROR_NONE, isNeedUpdateEndGraph_ = true; releaseNum++;);
        return error;
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
        COND_RETURN_ERROR((errorTmp != RT_ERROR_NONE), errorTmp,
            "release resource failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(errorTmp));
        COND_PROC(error != RT_ERROR_NONE, (void)mmSleep(1U)); // sleep 1ms
    } while (((error != RT_ERROR_NONE) && (streamNum <= totalResNum)));

    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "sq cq res alloc failed, model_id=%u, alloc num=%u, total res num=%u, retCode=%#x.",
        Id_(), streamNum, totalResNum, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}
rtError_t CaptureModel::UpdateNotifyId(Stream * const exeStream)
{
    Stream *origCaptureStream = GetOriginalCaptureStream();
    Notify *ntf = GetEndGraphNotify();
    COND_RETURN_ERROR_MSG_INNER((origCaptureStream == nullptr || ntf == nullptr), RT_ERROR_STREAM_NULL,
        "Origin capture stream and end graph notify cannot be NULL pointers, model_id=%u.", Id_());

    rtError_t error = RT_ERROR_NONE;
    do {
        COND_PROC(ntf->GetNotifyId() != MAX_UINT32_NUM, break;); // 所有子模型共用一个notify，其中一个申请，其他的就不用再申请了
        error = ntf->AllocId();
        COND_PROC(error != RT_ERROR_NONE, error = Context_()->TryRecycleCaptureModelResource(0U, 1U, this));
        COND_PROC(error != RT_ERROR_NONE, mmSleep(1U));
    } while (error != RT_ERROR_NONE);

    if (!this->IsSubCaptureModel()) { // 只有根模型才刷新，其他各层级子模型发给ts的notify id均为根模型的id，异常时直接解执行流的endgraph wait
        loadCompleteNotifyid_ = ntf->GetNotifyId();
    }

    Context *context = origCaptureStream->Context_();
    return context->UpdateEndGraphTask(origCaptureStream, exeStream, ntf);
}

void CaptureModel::GetSqCqTotalNum(uint32_t &streamNum)
{
    streamNum += static_cast<uint32_t>(StreamList_().size());

    for (const auto &it : condHandleTaskMap_) {
        CondHandle *condHandle = it.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if (subModel == nullptr) {
                continue;
            }

            subModel->GetSqCqTotalNum(streamNum);
        }
    }

    return;
}

rtError_t CaptureModel::BuildSqCq(Stream * const exeStream)
{
    COND_PROC(!IsSoftwareSqEnable(), return RT_ERROR_NONE);
    const std::unique_lock<std::mutex> lk(sqBindMutex_);

    rtError_t error = BindJettyForUbdma();
    ERROR_RETURN_MSG_INNER(error, "bind jettys for streams failed, stream_id=%d, model_id=%u", exeStream->Id_(), Id_());

    /* model execute repeat */
    COND_PROC_RETURN_WARN((sqCqArray_ != nullptr) && (sqCqNum_ != 0U),
        RT_ERROR_NONE, refCount_++, "sqCqNum_=%u", sqCqNum_);

    const uint32_t streamNum = static_cast<uint32_t>(StreamList_().size());
    COND_RETURN_AND_MSG_OUTER(streamNum == 0U, RT_ERROR_INVALID_VALUE, ErrorCode::EE1009, std::to_string(Id_()),
        RtFmtMsg("The current aclgraph model (model_id=%u) running instance neither contains any executable task nor contains any executable stream", Id_()));

    uint32_t totalSqcqNum = 0;
    uint32_t sqcqPoolResNum = Context_()->Device_()->GetDeviceSqCqManage()->GetSqCqPoolTotalResNum();
    GetSqCqTotalNum(totalSqcqNum);
    COND_RETURN_ERROR((totalSqcqNum > RT_DEVICE_SQCQ_RES_MAX_NUM), RT_ERROR_DEVICE_SQCQ_POOL_RESOURCE_FULL,
        "exestream_id=%d, model_id=%u, totalSqcqNum=%u, sqcqPoolResNum=%u", exeStream->Id_(), Id_(), totalSqcqNum, sqcqPoolResNum);

    // 阶段一：Notify申请
    error = SendLoadCompleteEndGraph();
    if (error != RT_ERROR_NONE) {
       RT_LOG(RT_LOG_ERROR, "alloc all notify failed, stream_id=%d, model_id=%u, retCode=%#x.",
            exeStream->Id_(), Id_(), static_cast<uint32_t>(error));
       return error;
    }

    // 阶段二：SqCq申请
    error = AllocAllSqCq();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "alloc all sqcq failed, stream_id=%d, model_id=%u, retCode=%#x.",
            exeStream->Id_(), Id_(), static_cast<uint32_t>(error));
        return error;
    }

    // 阶段三：LoadComplete 刷notify record与子model notify wait sqe
    error = UpdateNotifyIdAll(exeStream);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "update all notify id failed, stream_id=%d, model_id=%u, retCode=%#x.",
            exeStream->Id_(), Id_(), static_cast<uint32_t>(error));
        return error;
    }

    SetRootExeStreamIdAll(static_cast<uint32_t>(exeStream->Id_()));
    error = LoadCompleteAll(loadCompleteNotifyid_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "load complete all failed, stream_id=%d, model_id=%u, retCode=%#x.",
            exeStream->Id_(), Id_(), static_cast<uint32_t>(error));
        return error;
    }

    error = UpdateStreamActiveTaskFuncCallMemAll();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "update all stream active task failed, stream_id=%d, model_id=%u, retCode=%#x.",
            exeStream->Id_(), Id_(), static_cast<uint32_t>(error));
        return error;
    }

    error = UpdateCondTaskFuncCallMemAll();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "update all cond task failed, stream_id=%d, model_id=%u, retCode=%#x.",
            exeStream->Id_(), Id_(), static_cast<uint32_t>(error));
        return error;
    }

    refCount_++;
    isNeedUpdateEndGraph_ = false;

    return RT_ERROR_NONE;
}

void CaptureModel::DeconstructSqCq(void)
{
    uint32_t releaseNum = 0U;
    const std::unique_lock<std::mutex> lk(sqBindMutex_);

    (void)ReleaseSqCq(releaseNum);
    return;
}

rtError_t CaptureModel::ReleaseSqCq(uint32_t &releaseNum)
{
    releaseNum = 0U;
    if ((sqCqNum_ == 0U) || (refCount_ != 0U)) {
        RT_LOG(RT_LOG_DEBUG, "model cannot be released, model_id=%u, sqCqNum=%u, refCount=%u.",
            Id_(), sqCqNum_, refCount_);
        return RT_ERROR_NONE;
    }

    // 先递归释放子模型资源
    rtError_t error = ReleaseAllSqCq(releaseNum);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "release all sub models sqcq failed, model_id=%u, retCode=%#x.",
            Id_(), static_cast<uint32_t>(error));
        return error;
    }

    error = UnBindSqCq();
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
                "unbind sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = Context_()->Device_()->GetDeviceSqCqManage()->FreeSqCqLazy(sqCqArray_, sqCqNum_);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
                "free sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    releaseNum += sqCqNum_;
    DELETE_A(sqCqArray_);
    sqCqNum_ = 0U;

    uint32_t notifReleaseNum = 0;
    (void)ReleaseNotifyId(notifReleaseNum);

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
    Device * const dev = Context_()->Device_();

    COND_RETURN_ERROR_MSG_INNER((sqCqNum_ != streamNum), RT_ERROR_INVALID_VALUE,
        "SQ/CQ numbers must be equal to stream numbers, sq num=%u, stream num=%u.", sqCqNum_, streamNum);

    if (switchInfo_ == nullptr) {
        switchInfo_ = new (std::nothrow) struct sq_switch_stream_info[sqCqNum_]();
        COND_RETURN_AND_MSG_OUTER(switchInfo_ == nullptr, RT_ERROR_STREAM_NEW, ErrorCode::EE1013, sizeof(sq_switch_stream_info) * sqCqNum_, "new");
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
        switchInfo_[index].stream_mem = RtValueToPtr<void *>(stm->GetSqBaseAddr());
        error = dev->Driver_()->MemCopySync(RtValueToPtr<void *>(stm->GetSqIdMemAddr()),
            sizeof(uint64_t), RtPtrToPtr<void *>(&(sqIdTmp)),
            sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "stream set sq id failed, device_id=%u, model_id=%u, stream_id=%u, sqId=%u, retCode=%#x.",
            dev->Id_(), Id_(), stm->Id_(), stm->GetSqId(), static_cast<uint32_t>(error));
        index++;
        RT_LOG(RT_LOG_INFO, "stream bind sq, device_id=%u, model_id=%u, stream_id=%d, sqId=%u, sqTail=%u, sqDepth=%u.",
            dev->Id_(), Id_(), stm->Id_(), stm->GetSqId(), stm->GetCurSqPos(), stm->GetSqDepth());
    }

    /* switch stream to sq */
    error = dev->Driver_()->SqSwitchStreamBatch(dev->Id_(), switchInfo_, sqCqNum_);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "stream bind sq failed, device_id=%u, model_id=%u, sqNum=%u, retCode=%#x.",
        dev->Id_(), Id_(), sqCqNum_, static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "stream bind sq success, device_id=%u, model_id=%u, num=%u.",
        dev->Id_(), Id_(), sqCqNum_);

    return error;
}
rtError_t CaptureModel::UnBindSqCq(void)
{
    rtError_t error = RT_ERROR_NONE;
    Device * const dev = Context_()->Device_();

    COND_RETURN_ERROR((switchInfo_ == nullptr), RT_ERROR_INVALID_VALUE, "switch info is null");

    /* unbind stream from model */
    for (auto stm : StreamList_()) {
        error = UnBindSqPerStream(stm);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "model unbind stream failed, device_id=%u, model_id=%u, stream_id=%d, retCode=%#x.",
            dev->Id_(), Id_(), stm->Id_(), static_cast<uint32_t>(error));
    }

    for (uint32_t index = 0U; index < sqCqNum_; index++) {
        RT_LOG(RT_LOG_INFO, "stream unbind sq, device_id=%u, model_id=%u, stream_id=%d, sqId=%u.",
            dev->Id_(), Id_(), switchInfo_[index].stream_id, switchInfo_[index].sq_id);
        switchInfo_[index].stream_id = UINT32_MAX;
    }

    /* stream unbind sq */
    error = dev->Driver_()->SqSwitchStreamBatch(dev->Id_(), switchInfo_, sqCqNum_);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "stream unbind sq failed, device_id=%u, model_id=%u, retCode=%#x.",
        dev->Id_(), Id_(), static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "stream unbind sq success, device_id=%u, model_id=%u, num=%u.",
        dev->Id_(), Id_(), sqCqNum_);

    /* stream reset sq cq info */
    for (auto stm : StreamList_()) {
        stm->ResetSqCq();
    }

    return error;
}
rtError_t CaptureModel::MarkStreamActiveTask(TaskInfo *streamActiveTask)
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
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Task cannot be a NULL pointer, device_id=%u, model_id=%u.",
                Context_()->Device_()->Id_(), Id_());
            return RT_ERROR_TASK_NULL;
        }

        COND_PROC((task->type != TS_TASK_TYPE_STREAM_ACTIVE), return RT_ERROR_TASK_BASE);

        StreamActiveTaskInfo *streamActiveTask = &(task->u.streamactiveTask);
        if (streamActiveTask->activeStream != nullptr) {
            streamActiveTask->activeStreamSqId = streamActiveTask->activeStream->GetSqId();
            error = ReConstructStreamActiveTaskFc(task);
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "reconstruct stream active task failed, device_id=%u, "
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
    const std::lock_guard<std::mutex> lk(condHandleTaskMapLock_);

    for (const auto &entry : condHandleTaskMap_) {
        CondHandle *condHandle = entry.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if (subModel != nullptr) {
                error = subModel->UpdateCondTaskFuncCallMemAll();
                if (error != RT_ERROR_NONE) {
                    return error;
                }
            }
        }

        const int32_t streamId = std::get<0>(entry.first);
        const uint16_t taskId = std::get<1>(entry.first);

        RT_LOG(RT_LOG_DEBUG, "stream_id=%d, task_id=%hu, model_id=%u.", streamId, taskId, Id_());
        if (condHandle == nullptr) {
            RT_LOG(RT_LOG_ERROR, "CondHandle is null, stream_id=%d, task_id=%hu.", streamId, taskId);
            continue;
        }

        TaskInfo *taskInfo = GetTaskInfo(Context_()->Device_(), static_cast<uint32_t>(streamId), taskId);
        if (taskInfo == nullptr) {
            RT_LOG(RT_LOG_ERROR, "TaskInfo not found for cond task, stream_id=%d, task_id=%hu.", streamId, taskId);
            continue;
        }

        error = ReConstructCaptureConditionTaskFc(taskInfo, condHandle);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "ReConstructCaptureConditionTaskFc failed, stream_id=%d, task_id=%hu, retCode=%#x.",
                streamId, taskId, static_cast<uint32_t>(error));
            break;
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
    COND_PROC(refCount_ < 1U, return);
    refCount_--;
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
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "AllocSoftwareSqAddr failed. device_id=%u, stream_id=%d, "
            "model_id=%u, retCode=%#x.", deviceId, stm->Id_(), Id_(), static_cast<uint32_t>(ret));
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
    uint32_t releaseNum = 0U;
    rtError_t error = ReleaseSqCq(releaseNum);
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
    RT_LOG(RT_LOG_INFO, "update finish, model_id=%u, releaseNum=%u.", Id_(), releaseNum);
    return RT_ERROR_NONE;
}
void CaptureModel::SetModelCacheOpInfoSwitch(const uint32_t status) const {
    RT_LOG(RT_LOG_INFO, "Set model cache op info switch status, model_id=%u, status=(%u -> %u).", Id_(),
        cacheOpInfoSwitch_, status);

    if (cacheOpInfoSwitch_ != status) {
        cacheOpInfoSwitch_ = status;
        StreamSqCqManage * const streamSqCqManagePtr = Context_()->Device_()->GetStreamSqCqManage();
        for (const auto& iter: singleOperStmIdAndCaptureStmIdMap_) {
            Stream *stm = nullptr;
            (void)streamSqCqManagePtr->GetStreamById(static_cast<uint32_t>(iter.first), &stm);
            if (stm != nullptr) {
                stm->SetStreamCacheOpInfoSwitch(status);
            }
        }
    }
}
void CaptureModel::ClearShapeInfo(const int32_t streamId, const uint32_t taskId)
{
    const auto &it = shapeInfos_.find(streamId);
    if (it != shapeInfos_.end()) {
        const auto &it2 = it->second.find(taskId);
        if (it2 != it->second.end()) {
            (void)it->second.erase(it2);
        }
    }
}
rtError_t CaptureModel::SetShapeInfo(const Stream* const stm, const uint32_t taskId, const void * const infoPtr,
    const size_t infoSize)
{
    const size_t totalSize = MS_PROF_SHAPE_INFO_SIZE + MS_PROF_SHAPE_HEADER_SIZE + infoSize;
    auto rawMemPtr = std::make_unique<uint8_t []>(totalSize);
    if (unlikely(rawMemPtr == nullptr)) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, totalSize, "new");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    MsprofShapeInfo *shapeInfo = RtPtrToPtr<MsprofShapeInfo *, uint8_t *>(rawMemPtr.get());

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
    COND_RETURN_ERROR_MSG_INNER(err != EOK, RT_ERROR_SEC_HANDLE,
        "Failed to call memcpy_s to copy header, dest=%p, dest_max=%u, src=%p, count=%u, retCode=%d.",
        headerCursor, MS_PROF_SHAPE_HEADER_SIZE, &header, MS_PROF_SHAPE_HEADER_SIZE, err);

    const uint64_t offset = RtPtrToValue(shapeInfo->data) + MS_PROF_SHAPE_HEADER_SIZE;
    err = memcpy_s(RtValueToPtr<void *>(offset), infoSize, infoPtr, infoSize);
    COND_RETURN_ERROR_MSG_INNER(err != EOK, RT_ERROR_SEC_HANDLE,
        "Failed to call memcpy_s to copy shapeInfo data, dest=%p, dest_max=%zu, src=%p, count=%zu, retCode=%d.",
        RtValueToPtr<void *>(offset), infoSize, infoPtr, infoSize, err);

    shapeInfo->dataLen = static_cast<uint32_t>(MS_PROF_SHAPE_HEADER_SIZE + infoSize);

    shapeInfos_[stm->Id_()][taskId] = std::move(rawMemPtr);
    return RT_ERROR_NONE;
}
void* CaptureModel::GetShapeInfo(const int32_t streamId, const uint32_t taskId, size_t &infoSize) const
{
    void *infoPtr = nullptr;
    infoSize = 0;
    const auto &it = shapeInfos_.find(streamId);
    if (it != shapeInfos_.end()) {
        const auto &it2 = it->second.find(taskId);
        if (it2 != it->second.end()) {
            MsprofShapeInfo *shapeInfo = RtPtrToPtr<MsprofShapeInfo *, uint8_t *>(it2->second.get());
            if (shapeInfo != nullptr) {
                uint8_t *headerCursor = shapeInfo->data;
                infoPtr = RtPtrToPtr<void *, uint8_t *>(headerCursor + MS_PROF_SHAPE_HEADER_SIZE);
                infoSize = static_cast<size_t>(shapeInfo->dataLen - MS_PROF_SHAPE_HEADER_SIZE);
            }
        }
    }

    return infoPtr;
}
rtError_t CaptureModel::CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize, const Stream * const stm)
{
    if (GetModelCacheOpInfoSwitch() == 0U) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1018, "rtCacheLastTaskOpInfo",
            "The operator information cache function is not enabled. "
            "Call the rtSetStreamAttribute API to enable the operator information cache function first, "
            "model_id=" + std::to_string(Id_()) + ", stream_id=" + std::to_string(stm->Id_()));
        return RT_ERROR_MODEL_OP_CACHE_CLOSED;
    }

    const uint32_t lastTaskId = InnerThreadLocalContainer::GetLastTaskId();
    const rtError_t ret = SetShapeInfo(stm, lastTaskId, infoPtr, infoSize);
    ERROR_RETURN(ret, "SetShapeInfo failed, streamId=%d, taskId=%u.", stm->Id_(), lastTaskId);
    return RT_ERROR_NONE;
}
void CaptureModel::ReportShapeInfoForProfiling() const
{
    for (const auto &it1 : shapeInfos_) {
        for (const auto &it2 : it1.second) {
            if (it2.second == nullptr) {
                continue;
            }
            MsprofShapeInfo *shapeInfo = RtPtrToPtr<MsprofShapeInfo *, uint8_t *>(it2.second.get());

            if (shapeInfo->dataLen < MS_PROF_SHAPE_HEADER_SIZE) {
                RT_LOG(RT_LOG_ERROR, "Report capture shape info for profiling failed, data length = %u, header size = %u",
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
                RT_LOG(RT_LOG_ERROR, "Report capture shape info for profiling failed, stream_id=%u, task_id=%u, "
                "model_id=%u, device_id=%u, thread_id=%u, total_len=%u, shape_len=%u, ret=%d.", header.streamId, header.taskId,
                    header.modelId, header.deviceId, shapeInfo->threadId, shapeInfo->dataLen, shapeSize, err);
                continue;
            }

            RT_LOG(RT_LOG_DEBUG, "Report capture shape info for profiling successfully, stream_id=%u, task_id=%u, "
                "model_id=%u, device_id=%u, thread_id=%u, total_len=%u, shape_len=%u.", header.streamId, header.taskId, 
                header.modelId, header.deviceId, shapeInfo->threadId, shapeInfo->dataLen, shapeSize);
        }
    }
}
rtError_t CaptureModel::RestoreForSoftwareSq(Device * const dev)
{
    RT_LOG(RT_LOG_INFO, "Begin restore capture model, modelId=%u, deviceId=%u.", Id_(), dev->Id_());
    for (auto &stream : StreamList_()) {
        rtError_t error = stream->RestoreForSoftwareSq();
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Restore capture stream failed, streamId=%d, deviceId=%u, ret=%d.",
            stream->Id_(), dev->Id_(), error);
    }
    DELETE_A(sqCqArray_);
    sqCqNum_ = 0U;
    DELETE_A(switchInfo_);
    SetIsSendSqe(false);
    refCount_ = 0;
    return RT_ERROR_NONE;
}

bool CaptureModel::CheckSubModelsIsEndCapture()
{
    bool isEndCapture = true;
    for (const auto &it : this->GetCondHandleTaskMap()) {
        for (const auto &mdl : it.second->GetSubCaptureModels()) {
            CaptureModel *captureModel = RtPtrToPtr<CaptureModel *, Model *>(mdl);
            if (captureModel == nullptr) {
                continue;
            }

            isEndCapture = captureModel->CheckSubModelsIsEndCapture();
            COND_RETURN_ERROR(!isEndCapture, false,
                "sub ACL Graph is not end capture, capture model_id=%u.", captureModel->Id_());
            if (captureModel->GetCaptureModelStatus() != RtCaptureModelStatus::READY) {
                RT_LOG(RT_LOG_ERROR, "sub ACL Graph is not end capture, parent model_id=%u, sub model_id=%u.",
                    Id_(), captureModel->Id_());
                return false;
            }
        }
    }

    return isEndCapture;
}

rtError_t CaptureModel::StoreCondHandleTaskInfo(const int32_t streamId, const uint16_t taskId, CondHandle *condHandle)
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
    Stream *origCaptureStream = GetOriginalCaptureStream();
    COND_RETURN_ERROR_MSG_INNER((origCaptureStream == nullptr), RT_ERROR_STREAM_NULL,
        "Original capture stream is a NULL pointer, model_id=%u.", Id_());

    Api *apiObj = Runtime::Instance()->ApiImpl_();
    rtError_t error = RT_ERROR_NONE;
    uint32_t loopCnt = 0U;
    
    do {
        error = Context_()->CheckStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
        loopCnt++;
        error = apiObj->ModelEndGraph(this, origCaptureStream, 0U);
        COND_PROC(error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES && loopCnt == 1U,
            RT_LOG(RT_LOG_EVENT, "Begin for trying free Notify for model %u", Id_()));
        COND_PROC(error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES, mmSleep(1U));
        COND_PROC(error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES,
            Context_()->TryRecycleCaptureModelResource(0U, 1U, this));
    } while (error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES && loopCnt < 3000U);
    
    COND_PROC(loopCnt > 1U, RT_LOG(RT_LOG_EVENT, "End for trying free Notify"));
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error,
        "capture model end graph failed, device_id=%u, capture model_id=%u, original capture stream_id=%d, retCode=%#x.",
        Context_()->Device_()->Id_(), Id_(), origCaptureStream->Id_(), static_cast<uint32_t>(error));

    if (!this->IsSubCaptureModel()) { // 只有根模型才刷新，其他各层级子模型发给ts的notify id均为根模型的id，异常时直接解执行流的endgraph wait
        loadCompleteNotifyid_ = this->GetEndGraphNotify()->GetNotifyId();
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

    for (const auto &it : condHandleTaskMap_) {
        CondHandle *condHandle = it.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if (subModel == nullptr) {
                continue;
            }

            rtError_t error = subModel->SendLoadCompleteEndGraph();
            if (error != RT_ERROR_NONE) {
                return error;
            }
        }
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::AllocSqCqAndBindInternal()
{
    const uint32_t streamNum = static_cast<uint32_t>(StreamList_().size());
    COND_RETURN_ERROR(streamNum == 0U, RT_ERROR_INVALID_VALUE,
        "stream num is 0, model_id=%u.", Id_());

    COND_RETURN_INFO((sqCqArray_ != nullptr) && (sqCqNum_ != 0U),
        RT_ERROR_NONE, "model_id=%u, sqCqNum_=%u, stream num=%u", Id_(), sqCqNum_, streamNum);

    sqCqArray_ = new (std::nothrow) rtDeviceSqCqInfo_t[streamNum];
    COND_RETURN_AND_MSG_OUTER(sqCqArray_ == nullptr, RT_ERROR_STREAM_NEW, ErrorCode::EE1013, 
        std::to_string(sizeof(rtDeviceSqCqInfo_t) * streamNum), "new");

    rtError_t error = AllocSqCqProc(streamNum);
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_A(sqCqArray_);,
        "alloc sq resource failed, model_id=%u, required number=%u, current available number=%u, "
        "maximum number=%u, retCode=%#x.",
        Id_(), streamNum, Context_()->Device_()->GetDeviceSqCqManage()->GetSqCqPoolFreeResNum(),
        Context_()->Device_()->GetDeviceSqCqManage()->GetSqCqPoolTotalResNum(),
        static_cast<uint32_t>(error));

    sqCqNum_ = streamNum;
    error = AllocSqAddr();
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_A(sqCqArray_); sqCqNum_ = 0U;,
        "alloc sq addr failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
    
    error = BindSqCqAndSendSqe();
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_A(sqCqArray_); sqCqNum_ = 0U;,
        "bind sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    SetFirstExecute(true);
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::AllocAllSqCq()
{
    rtError_t error = AllocSqCqAndBindInternal();
    if (error != RT_ERROR_NONE) {
        return error;
    }
    
    for (const auto &it : condHandleTaskMap_) {
        CondHandle *condHandle = it.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if (subModel == nullptr) {
                continue;
            }
            
            error = subModel->AllocAllSqCq();
            if (error != RT_ERROR_NONE) {
                return error;
            }
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ReleaseSqCqInternal(uint32_t &releaseNum)
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
        RT_LOG(RT_LOG_ERROR, "unbind sq cq failed, model_id=%u, retCode=%#x.",
            Id_(), static_cast<uint32_t>(error));
        return error;
    }

    error = Context_()->Device_()->GetDeviceSqCqManage()->FreeSqCqLazy(sqCqArray_, sqCqNum_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "free sq cq failed, model_id=%u, retCode=%#x.",
            Id_(), static_cast<uint32_t>(error));
        return error;
    }

    releaseNum += sqCqNum_;
    DELETE_A(sqCqArray_);
    sqCqNum_ = 0U;

    uint32_t notifReleaseNum = 0;
    (void)ReleaseNotifyId(notifReleaseNum);
    
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ReleaseAllSqCq(uint32_t &releaseNum)
{
    for (const auto &it : condHandleTaskMap_) {
        rtError_t error;
        CondHandle *condHandle = it.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if (subModel == nullptr) {
                continue;
            }

            error = subModel->ReleaseAllSqCq(releaseNum);
            COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "release all sqcq failed. model_id=%u, releaseNum=%u",
                Id_(), releaseNum);
            error = subModel->ReleaseSqCqInternal(releaseNum);
            COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "release all sqcq failed. model_id=%u, sqCqNum_=%u, releaseNum=%u",
                Id_(), sqCqNum_, releaseNum);
        }
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::LoadCompleteAll(uint32_t loadCompltetNotifyid)
{
    if (!IsModelLoadComplete() || isNeedUpdateEndGraph_) {
        loadCompleteNotifyid_ = loadCompltetNotifyid;
        rtError_t error = LoadComplete();
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "load complete failed, model_id=%u, retCode=%#x.",
                Id_(), static_cast<uint32_t>(error));
            return error;
        }
    }
    
    for (const auto &it : condHandleTaskMap_) {
        CondHandle *condHandle = it.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if (subModel != nullptr) {
                rtError_t error = subModel->LoadCompleteAll(loadCompltetNotifyid);
                if (error != RT_ERROR_NONE) {
                    return error;
                }
            }
        }
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::UpdateNotifyIdAll(Stream * const exeStream)
{
    if (isNeedUpdateEndGraph_) {
        rtError_t error = UpdateNotifyId(exeStream);
        ERROR_RETURN_MSG_INNER(error, "capture model update notify failed, model_id=%u, retCode=%#x.",
            Id_(), static_cast<uint32_t>(error));

        RT_LOG(RT_LOG_WARNING, "model_id=%u Alloc endgraph notify_id=%u",
            Id_(), GetEndGraphNotify()->GetNotifyId());
    }

    Stream *dstStream = nullptr;
    rtError_t error;
    for (const auto &it : condHandleTaskMap_) {
        CondHandle *condHandle = it.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if (subModel != nullptr) {
                dstStream = subModel->GetExeStream();
                error = subModel->UpdateNotifyIdAll(exeStream);
                if (error != RT_ERROR_NONE) {
                    return error;
                }
            }
        }

        COND_PROC(dstStream == nullptr, continue;);

        int32_t streamId = 0U;
        uint16_t taskId = 0U;
        std::tie(streamId, taskId) = it.first;
        COND_PROC(dstStream->Id_() != streamId, RT_LOG(RT_LOG_WARNING,
            "stream_id=%d, sub ACL Graph exec stream_id=%d, model_id=%u.", streamId, dstStream->Id_(), Id_()); continue;);

        TaskInfo *taskInfo = dstStream->Device_()->GetTaskFactory()->GetTask(streamId, taskId);
        COND_PROC(taskInfo == nullptr, RT_LOG(RT_LOG_WARNING,
            "stream_id=%d, submodel task_id=%u.", streamId, taskId); continue;);
        COND_PROC(taskInfo->type != TS_TASK_TYPE_CAPTURE_CONDITION, RT_LOG(RT_LOG_WARNING,
            "task type is not capture condition, stream_id=%d, task_id=%u.", streamId, taskId); continue;);

        taskInfo->u.captureConditionTask.notifyId = condHandle->GetSubModelNotify()->GetNotifyId();
        Context *context = dstStream->Context_();
        error = context->UpdateSuModelExeStreamNotifyWaitSqe(taskInfo, exeStream);
        COND_PROC(error != RT_ERROR_NONE, RT_LOG(RT_LOG_WARNING,
            "update cond task notify wait sqe failed, stream_id=%d, task_id=%u.", streamId, taskId); continue;);
    }
    return RT_ERROR_NONE;
}

void CaptureModel::SetRootExeStreamIdAll(uint16_t rootExeStreamId)
{
    SetRootExeStreamId(rootExeStreamId);
    for (const auto &it : condHandleTaskMap_) {
        CondHandle *condHandle = it.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if (subModel != nullptr) {
                subModel->SetRootExeStreamIdAll(rootExeStreamId);
            }
        }
    }
}

rtError_t CaptureModel::UpdateStreamActiveTaskFuncCallMemAll()
{
    rtError_t error = UpdateStreamActiveTaskFuncCallMem();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "update stream active task failed, model_id=%u, retCode=%#x.",
            Id_(), static_cast<uint32_t>(error));
        return error;
    }
    
    for (const auto &it : condHandleTaskMap_) {
        CondHandle *condHandle = it.second;
        for (Model *mdl : condHandle->GetSubCaptureModels()) {
            CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
            if (subModel != nullptr) {
                error = subModel->UpdateStreamActiveTaskFuncCallMemAll();
                if (error != RT_ERROR_NONE) {
                    return error;
                }
            }
        }
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
