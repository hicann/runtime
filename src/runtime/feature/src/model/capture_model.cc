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
#include "context.hpp"
#include "stream_sqcq_manage.hpp"
#include "task_info.h"
#include "event.hpp"
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

namespace cce {
namespace runtime {
constexpr uint8_t RT_MODEL_CAPTURE_EXECUTE_DEFAULT = 0U; /* async and with timeout */
constexpr uint8_t RT_MODEL_CAPTURE_EXECUTE_ASYNC = 1U;   /* async */

CaptureModel::CaptureModel(ModelType type) : Model(type)
{
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
    DeconstructSqCq();
    ClearStreamActiveTask();
    DELETE_A(switchInfo_);
    isSqeSendFinish_ = false;

    if (!GlobalContainer::IsEventHardMode()) {
        std::set<int32_t> & captureAddrInder = GetCaptureEventIndex();
        for (auto it = captureAddrInder.begin(); it != captureAddrInder.end() && !captureAddrInder.empty(); ++it) {
            void *eventAddr = nullptr; 
            (void)Context_()->Device_()->FindExpandingEventAddrById(&eventAddr, *it);
            if (eventAddr != nullptr) {
                (void)Context_()->Device_()->FreeExpandingPoolEvent(eventAddr, *it);
            }
            RT_LOG(RT_LOG_INFO, "erase, event_id=%d.", *it);
        }
        captureAddrInder.clear();
    }
    
    const std::list<Stream *> streamsCpy(StreamList_());
    for (Stream * const streamObj : streamsCpy) {
        (void)UnBindSqPerStream(streamObj);
        (void)DelStream(streamObj);
        Context_()->InsertStreamList(streamObj);
        (void)Context_()->StreamDestroy(streamObj, true);
    }
    (void)Context_()->Device_()->ClearEndGraphNotifyInfoByModel(this);

    for (Notify *notify : addStreamNotifyList_) {
         DELETE_O(notify);
    }
    addStreamNotifyList_.clear();
 
    for (Notify *notify : executeNotifyList_) {
         DELETE_O(notify);
    }
    executeNotifyList_.clear();
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
                " Notify wait failed, exe stream_id=%d, notify id=%d, add stream_id=%d, retCode=%#x.",
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
                " Notify wait failed, exe stream_id=%d, notify_id=%d, add stream_id=%d, retCode=%#x.",
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

rtError_t CaptureModel::ExecuteCommon(Stream * const stm, int32_t timeout, const uint8_t executeMode)
{
    RT_LOG(RT_LOG_INFO, "capture model execute, model_id=%u!", Id_());

    if (IsCapturing()) {
        RT_LOG(RT_LOG_ERROR, "model is capturing, can't execute, model_id=%u!", Id_());
        return RT_ERROR_MODEL_CAPTURED;
    }

    rtError_t error;
    // begin execute
    error = SetNotifyBeforeExecute(stm, this);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "before model execute set notify failed, stream_id=%d, model_id=%u", stm->Id_(), Id_());

    error = BuildSqCq(stm);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "build sq cq failed, stream_id=%d, model_id=%u", stm->Id_(), Id_());  

    if (executeMode == RT_MODEL_CAPTURE_EXECUTE_DEFAULT) {
        error = Model::Execute(stm, timeout);
    } else {
        error = Model::ExecuteAsync(stm);
    }

    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "model execute failed, stream_id=%d, model_id=%u", stm->Id_(), Id_());

    // after execute
    error = SetNotifyAfterExecute(stm, this);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "after model execute set notify failed, stream_id=%d, model_id=%u", stm->Id_(), Id_());
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

void CaptureModel::EnterCaptureNotify(const int32_t singleOperStmId, const int32_t captureStmId)
{
    SetModelCaptureStatus(RT_MODEL_CAPTURE_STATUS_ACTIVE);
    InsertSingleOperStmIdAndCaptureStmId(singleOperStmId, captureStmId);
}

void CaptureModel::ExitCaptureNotify()
{
    SetModelCaptureStatus(RT_MODEL_CAPTURE_STATUS_FINISH);

    Device * const dev = Context_()->Device_();
    for (const auto& iter: singleOperStmIdAndCaptureStmIdMap_) {
        Stream *oriStm = nullptr;
        (void)dev->GetStreamSqCqManage()->GetStreamById(static_cast<uint32_t>(iter.first), &oriStm);
        if (oriStm != nullptr) {
            oriStm->ResetCaptureInfo();
        }
    }

    for (Event * const evt : singleOperEvents_) {
        evt->SetCaptureEvent(nullptr);
    }
    singleOperEvents_.clear();
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
        RT_LOG(RT_LOG_DEBUG,
               "add stream to capture model, model_id=%u, "
               "device_id=%u, add stream_id=%d, capture stream_id=%d, retCode=%#x.",
               Id_(), Context_()->Device_()->Id_(), streamId, stm->GetCaptureStream()->Id_(),error);
    } else {
        RT_LOG(RT_LOG_WARNING,
            "already add stream_id=%d to capture model, device_id=%u, model_id=%u.", streamId, Context_()->Device_()->Id_(), Id_());
    }
    return RT_ERROR_NONE;
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

/* 上报capture stream和原始stream的关系*/
void CaptureModel::ReportedStreamInfoForProfiling() const
{
    MsprofCompactInfo compactInfo;
    compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    compactInfo.type = RT_PROFILE_TYPE_CAPTURE_STREAM_INFO;
    compactInfo.timeStamp = MsprofSysCycleTime();
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
                "original_stream_id=%hu, model_id=%hu, device_id=%hu.",
                compactInfo.data.captureStreamInfo.captureStatus,
                compactInfo.data.captureStreamInfo.modelStreamId,
                compactInfo.data.captureStreamInfo.originalStreamId,
                compactInfo.data.captureStreamInfo.modelId,
                compactInfo.data.captureStreamInfo.deviceId);
        }
    }
    return;
}

/* 解除capture stream和原始stream的关系*/
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

rtError_t CaptureModel::ReleaseNotifyId(void)
{
    rtError_t error = RT_ERROR_NOTIFY_NOT_COMPLETE;
    if (GetEndGraphNotify() != nullptr && refCount_ == 0U) {
        RT_LOG(RT_LOG_WARNING, "model_id=%u free endgraph notify_id=%u", Id_(), GetEndGraphNotify()->GetNotifyId());
        error = GetEndGraphNotify()->FreeId();
        COND_PROC(error != RT_ERROR_NONE, RT_LOG(RT_LOG_WARNING, "Free notify %u failed", GetEndGraphNotify()->GetNotifyId()));
        COND_PROC(error == RT_ERROR_NONE, isNeedUpdateEndGraph_ = true);
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
    COND_RETURN_ERROR((origCaptureStream == nullptr || ntf == nullptr), RT_ERROR_STREAM_NULL,
        "capture stream is null, model_id=%u.", Id_());

    rtError_t error = RT_ERROR_NONE;
    do {
        error = ntf->AllocId();
        COND_PROC(error != RT_ERROR_NONE, error = Context_()->TryRecycleCaptureModelResource(0U, 1U, this));
        COND_PROC(error != RT_ERROR_NONE, mmSleep(1U));
    } while (error != RT_ERROR_NONE);

    Context *context = origCaptureStream->Context_();
    return context->UpdateEndGraphTask(origCaptureStream, exeStream, ntf);
}

rtError_t CaptureModel::BuildSqCq(Stream * const exeStream)
{
    COND_PROC(!IsSoftwareSqEnable(), return RT_ERROR_NONE);
    uint32_t loopCnt = 0U;

    const std::unique_lock<std::mutex> lk(sqBindMutex_);
    /* model execute repeat */
    COND_PROC_RETURN_WARN((sqCqArray_ != nullptr) && (sqCqNum_ != 0U),
        RT_ERROR_NONE,
        refCount_++,
        "sqCqNum_=%u", sqCqNum_);

    const uint32_t streamNum = static_cast<uint32_t>(StreamList_().size());
    COND_RETURN_ERROR(streamNum == 0U, RT_ERROR_INVALID_VALUE,
        "stream num is 0, model_id=%u.", Id_());

    if (!IsModelLoadComplete()) {
        Stream *origCaptureStream = GetOriginalCaptureStream();
        COND_RETURN_ERROR((origCaptureStream == nullptr), RT_ERROR_STREAM_NULL,
            "capture stream is null, model_id=%u.", Id_());

        Api * const apiObj = Runtime::Instance()->ApiImpl_();
        rtError_t error = RT_ERROR_NONE;
        do {
            error = Context_()->CheckStatus();
            ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
            loopCnt++;
            error = apiObj->ModelEndGraph(this, origCaptureStream, 0U);
            COND_PROC(error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES && loopCnt == 1U, RT_LOG(RT_LOG_EVENT,
                "Begain for trying free Notify for model %u", Id_()));
            COND_PROC(error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES, (void)mmSleep(1U));
            COND_PROC(error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES, (void)Context_()->TryRecycleCaptureModelResource(0U, 1U, this));
        } while (error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES && loopCnt < 3000U); // loop 3000 times and wait
        COND_PROC(loopCnt > 1U, RT_LOG(RT_LOG_EVENT, "End for trying free Notify"));
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "capture model end graph failed, device_id=%u, "
            "capture model_id=%u, original capture stream_id=%d, retCode=%#x.",
            Context_()->Device_()->Id_(), Id_(), origCaptureStream->Id_(), static_cast<uint32_t>(error));
    }

    sqCqArray_ = new (std::nothrow) rtDeviceSqCqInfo_t[streamNum];
    COND_RETURN_ERROR(sqCqArray_ == nullptr, RT_ERROR_STREAM_NEW,
        "new sq cq array failed, sqNum=%u", streamNum);

    rtError_t error = AllocSqCqProc(streamNum);
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_A(sqCqArray_);,
        "alloc sq resource failed, model_id=%u, required number=%u, current available number=%u, "
        "maximum number=%u, retCode=%#x.",
        Id_(), streamNum, Context_()->Device_()->GetDeviceSqCqManage()->GetSqCqPoolFreeResNum(),
        Context_()->Device_()->GetDeviceSqCqManage()->GetSqCqPoolTotalResNum(),
        static_cast<uint32_t>(error));

    /* assign streamNum to sqCqNum_ after sq cq is allocated successfully */
    sqCqNum_ = streamNum;

    error = AllocSqAddr();
    ERROR_PROC_RETURN_MSG_INNER(error,
        DELETE_A(sqCqArray_);
        sqCqNum_ = 0U;,
        "alloc sq addr failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = SendSqe();
    ERROR_PROC_RETURN_MSG_INNER(error,
        DELETE_A(sqCqArray_);
        sqCqNum_ = 0U;,
        "send sqe failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindSqCq();
    ERROR_PROC_RETURN_MSG_INNER(error,
        DELETE_A(sqCqArray_);
        sqCqNum_ = 0U;,
        "bind sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    /* reconstruct the model execute instr */
    SetFirstExecute(true);

    if (isNeedUpdateEndGraph_) {
        error = UpdateNotifyId(exeStream);
        ERROR_PROC_RETURN_MSG_INNER(error,
            DELETE_A(sqCqArray_);
            sqCqNum_ = 0U;,
            "capture model update notify failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_WARNING, "model_id=%u Alloc endgraph notify_id=%u", Id_(), GetEndGraphNotify()->GetNotifyId());
    }

    if (!IsModelLoadComplete() || isNeedUpdateEndGraph_) { // send notify id to tsch
        error = LoadComplete();
        ERROR_PROC_RETURN_MSG_INNER(error,
            DELETE_A(sqCqArray_);
            sqCqNum_ = 0U;,
            "capture model load complete failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
    }

    error = UpdateStreamActiveTaskFuncCallMem();
    ERROR_PROC_RETURN_MSG_INNER(error,
        DELETE_A(sqCqArray_);
        sqCqNum_ = 0U;,
        "update stream active task failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

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
        RT_LOG(RT_LOG_DEBUG, "model can not be released, model_id=%u, sqCqNum=%u, refCount=%u.",
            Id_(), sqCqNum_, refCount_);
        return RT_ERROR_NONE;
    }

    rtError_t error = UnBindSqCq();
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
                "unbind sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = Context_()->Device_()->GetDeviceSqCqManage()->FreeSqCqLazy(sqCqArray_, sqCqNum_);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
                "free sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    releaseNum = sqCqNum_;
    DELETE_A(sqCqArray_);
    sqCqNum_ = 0U;

    // stream active task中的activeStreamSqId, 为提升性能，release后不在这里reset了
    // 待模型重新执行时, 通过UpdateStreamActiveTaskFuncCallMem完成更新
    (void)ReleaseNotifyId();

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::BindSqCq(void)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t index = 0U;
    const uint32_t streamNum = static_cast<uint32_t>(StreamList_().size());
    Device * const dev = Context_()->Device_();

    COND_RETURN_ERROR((sqCqNum_ != streamNum), RT_ERROR_INVALID_VALUE,
        "sq num is not equal to stream num, sq num=%u, stream num=%u", sqCqNum_, streamNum);

    if (switchInfo_ == nullptr) {
        switchInfo_ = new (std::nothrow) struct sq_switch_stream_info[sqCqNum_]();
        COND_RETURN_ERROR(switchInfo_ == nullptr, RT_ERROR_STREAM_NEW,
            "new sq switch info failed, sqNum=%u", sqCqNum_);
    }

    /* bind sq to stream */
    for (auto stm : StreamList_()) {
        /* update sq cq info */
        stm->UpdateSqCq(&(sqCqArray_[index]));

        /* prepare sq switch Info */
        switchInfo_[index].stream_id = static_cast<uint32_t>(stm->Id_());
        switchInfo_[index].sq_id = stm->GetSqId();
        switchInfo_[index].sq_depth = stm->GetSqDepth();
        error = dev->Driver_()->MemCopySync(RtValueToPtr<void *>(stm->GetSqIdMemAddr()),
            sizeof(uint64_t), RtPtrToPtr<void *>(&(switchInfo_[index].sq_id)),
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

    /* bind stream to model */
    for (auto stm : StreamList_()) {
        uint32_t streamFlag = static_cast<uint32_t>(RT_INVALID_FLAG);
        COND_PROC(IsModelHeadStream(stm), streamFlag = RT_HEAD_STREAM);

        error = BindSqPerStream(stm, streamFlag);
        COND_PROC(error != RT_ERROR_NONE, break);
    }

    /* config sq tail */
    for (auto stm : StreamList_()) {
        error = dev->Driver_()->SetSqTail(dev->Id_(), dev->DevGetTsId(), stm->GetSqId(), stm->GetCurSqPos());
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "set sq tail failed, device_id=%u, model_id=%u, stream_id=%d, sqId=%u, retCode=%#x.",
            dev->Id_(), Id_(), stm->Id_(), stm->GetSqId(), static_cast<uint32_t>(error));
    }

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
            RT_LOG(RT_LOG_ERROR, "task is nullptr, device_id=%u, model_id=%u.",
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

void CaptureModel::ClearStreamActiveTask(void)
{
    const std::unique_lock<std::mutex> lk(streamActiveTaskListMutex_);
    streamActiveTaskList_.clear();
}

void CaptureModel::CaptureModelExecuteFinish(void)
{
    const std::unique_lock<std::mutex> lk(sqBindMutex_);
    COND_PROC(refCount_ < 1U, return);
    refCount_--;

    return;
}

rtError_t CaptureModel::AllocSqAddr(void) const
{
    const uint32_t deviceId = Context_()->Device_()->Id_();

    for (auto stm : StreamList_()) {
        rtError_t ret = stm->AllocSoftwareSqAddr(1U);    // additional pos is used for tail
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "AllocSoftwareSqAddr failed. device_id=%u, stream_id=%d, "
            "model_id=%u, retCode=%#x.", deviceId, stm->Id_(), Id_(), static_cast<uint32_t>(ret));
    }

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::SendSqe(void)
{
    COND_PROC((isSqeSendFinish_ == true), return RT_ERROR_NONE);
    const uint32_t deviceId = Context_()->Device_()->Id_();

    for (auto stm : StreamList_()) {
        const uint32_t totalSqeNum = stm->GetDelayRecycleTaskSqeNum();
        if (totalSqeNum != 0U) {
            const rtError_t ret = Context_()->Device_()->Driver_()->StreamTaskFill(deviceId,
                static_cast<uint32_t>(stm->Id_()),
                RtValueToPtr<void *>(stm->GetSqBaseAddr()), RtPtrToPtr<void *, uint8_t *>(stm->GetSqeBuffer()),
                totalSqeNum);
            COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "StreamTaskFill fail. device_id=%u, "
                "stream_id=%d, model_id=%u, retCode=%#x.", deviceId, stm->Id_(), Id_(), static_cast<uint32_t>(ret));
        }

        RT_LOG(RT_LOG_INFO, "send sqe success, device_id=%u, stream_id=%d, model_id=%u, sqeNum=%u, sqAddr=0x%llx.",
            deviceId, stm->Id_(), Id_(), totalSqeNum, stm->GetSqBaseAddr());
    }

    isSqeSendFinish_ = true;
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

rtError_t CaptureModel::FillShapeInfo(const TaskInfo* const taskInfo, const VOID * const infoPtr, const size_t infoSize,
    MsprofShapeInfo * const shapeInfo) const
{
    MsprofShapeHeader header;
    header.modelId  = taskInfo->stream->Model_()->Id_();
    header.deviceId = static_cast<uint32_t>(taskInfo->stream->Device_()->Id_());
    header.streamId = static_cast<uint32_t>(taskInfo->stream->Id_());
    header.taskId   = static_cast<uint32_t>(taskInfo->id);

    MsprofShapeInfo tempShape;
    shapeInfo->magicNumber = tempShape.magicNumber;
    shapeInfo->level = MSPROF_REPORT_RUNTIME_LEVEL;
    shapeInfo->type = RT_PROFILE_TYPE_SHAPE_INFO;
    shapeInfo->threadId = taskInfo->tid;
    shapeInfo->timeStamp = MsprofSysCycleTime();

    uint8_t* headerCursor = shapeInfo->data;
    auto err = memcpy_s(headerCursor, MS_PROF_SHAPE_HEADER_SIZE, &header, MS_PROF_SHAPE_HEADER_SIZE);
    if (err != EOK) {
        RT_LOG(RT_LOG_ERROR, "Memcpy header failed, err=%d", err);
        return RT_ERROR_SEC_HANDLE;
    }
    
    const uint64_t offset = RtPtrToValue(shapeInfo->data) + MS_PROF_SHAPE_HEADER_SIZE;
    err = memcpy_s(RtValueToPtr<void *>(offset), infoSize, infoPtr, infoSize);
    if (err != EOK) {
        RT_LOG(RT_LOG_ERROR, "Memcpy shapeInfo data failed, device_id=%u, stream_id=%u, task_id=%u, size=%zu,"
            "error=%d.", header.deviceId, header.streamId, header.taskId, infoSize, err);
        return RT_ERROR_SEC_HANDLE;
    }

    shapeInfo->dataLen = static_cast<uint32_t>(MS_PROF_SHAPE_HEADER_SIZE + infoSize);

    return RT_ERROR_NONE;
}

rtError_t CaptureModel::CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize, const Stream * const stm)
{
    if (GetModelCacheOpInfoSwitch() == 0U) {
        RT_LOG(RT_LOG_ERROR, "Cache op info switch is off, model_id=%u, stream_id=%d.", Id_(), stm->Id_());
        return RT_ERROR_MODEL_OP_CACHE_CLOSED;
    }

    Device * const dev = Context_()->Device_();
    const uint32_t lastTaskId = InnerThreadLocalContainer::GetLastTaskId();
    TaskInfo* taskInfo = dev->GetTaskFactory()->GetTask(stm->Id_(), static_cast<uint16_t>(lastTaskId));
    if (unlikely(taskInfo == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "Stream or task is invalid, stream_id=%u, task_id=%u.", stm->Id_(), lastTaskId);
        return RT_ERROR_TASK_NULL;
    }

    const size_t totalSize = MS_PROF_SHAPE_INFO_SIZE + MS_PROF_SHAPE_HEADER_SIZE + infoSize;
    auto rawMemPtr = std::make_unique<uint8_t []>(totalSize);
    if (unlikely(rawMemPtr == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "New memory failed, stream_id=%d, task_id=%u.", stm->Id_(), lastTaskId);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    MsprofShapeInfo *shapeInfo = RtPtrToPtr<MsprofShapeInfo *, uint8_t *>(rawMemPtr.get());

    const rtError_t ret = FillShapeInfo(taskInfo, infoPtr, infoSize, shapeInfo);
    ERROR_RETURN(ret, "FillShapeInfo failed, stream_id=%d, task_id=%u.", stm->Id_(), lastTaskId);
 
    AddShapeInfo(rawMemPtr);
    return RT_ERROR_NONE;
}

void CaptureModel::ReportShapeInfoForProfiling() const
{
    for (const auto& shapeInfoPtr : shapeInfoList_) {
        MsprofShapeInfo *shapeInfo = RtPtrToPtr<MsprofShapeInfo *, uint8_t *>(shapeInfoPtr.get());
 
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
            "model_id=%u, device_id=%u, total_len=%u, shape_len=%u, ret=%d.", header.streamId, header.taskId,
                header.modelId, header.deviceId, shapeInfo->dataLen, shapeSize, err);
            continue;
        }
        
        RT_LOG(RT_LOG_DEBUG, "Report capture shape info for profiling successfully, stream_id=%u, task_id=%u, "
            "model_id=%u, device_id=%u, total_len=%u, shape_len=%u.", header.streamId, header.taskId, header.modelId,
            header.deviceId, shapeInfo->dataLen, shapeSize);
    }
}
} // namespace runtime
} // namespace cce
