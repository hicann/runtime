/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "event_david.hpp"
#include "stream_david.hpp"
#include "device.hpp"
#include "osal.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "npu_driver.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "task_recycle.hpp"
#include "stream_sqcq_manage.hpp"
namespace cce {
namespace runtime {

DavidEvent::DavidEvent(Device * device, uint64_t eventFlag, Context *ctx, bool isNewMode)
    : Event(device, eventFlag, ctx, false, isNewMode)
{
    if (isNewMode || eventFlag == RT_EVENT_DEFAULT) {
        isCntNotify_ = true;
    }
    SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    if (isNewMode) {
        SetRecordStatus(DavidEventState_t::EVT_RECORDED);
    }
}

DavidEvent::~DavidEvent() noexcept
{
    if ((eventId_ != INVALID_EVENT_ID) && !isCntNotify_) {
        RT_LOG(RT_LOG_DEBUG, "DavidEvent FreeEventIdFromDrv");
        (void)device_->FreeEventIdFromDrv(eventId_, static_cast<uint32_t>(eventFlag_));
        eventId_ = INVALID_EVENT_ID;
    }
    RT_LOG(RT_LOG_INFO, "event destructor, device_id=%u, recordSize=%llu, waitSize=%llu",
        device_->Id_(), recordResetMap_.size(), waitTaskMap_.size());
}

bool DavidEvent::TryFreeEventIdAndCheckCanBeDelete(const int32_t id, bool isNeedDestroy)
{
    UNUSED(id);
    const std::lock_guard<std::mutex> lock(taskMapMutex_);
    if (isNeedDestroy) { // call from EventDestroy
        SetIsNeedDestroy(isNeedDestroy_.Value() || isNeedDestroy);
        return waitTaskMap_.empty() && recordResetMap_.empty();
    }
    return isNeedDestroy_.Value() && waitTaskMap_.empty() && recordResetMap_.empty();
}

bool DavidEvent::DavidUpdateRecordMapAndDestroyEvent(TaskInfo *taskInfo)
{
    const std::lock_guard<std::mutex> lock(taskMapMutex_);
    const auto it = recordResetMap_.find(taskInfo);
    if (it == recordResetMap_.end()) {
        return false;
    }
    recordResetMap_.erase(taskInfo);
    return isNeedDestroy_.Value() && waitTaskMap_.empty() && recordResetMap_.empty();
}

bool DavidEvent::DavidUpdateWaitMapAndDestroyEvent(TaskInfo *taskInfo)
{
    const std::lock_guard<std::mutex> lock(taskMapMutex_);
    const auto it = waitTaskMap_.find(taskInfo);
    if (it == waitTaskMap_.end()) {
        return false;
    }
    waitTaskMap_.erase(taskInfo);
    return isNeedDestroy_.Value() && waitTaskMap_.empty() && recordResetMap_.empty();
}

rtError_t DavidEvent::GenEventId()
{
    if (IsEventWithoutWaitTask()) { // stream mark or timeline.
        RT_LOG(RT_LOG_INFO, "Stars not need to alloc id in this flag=%u", eventFlag_);
        return RT_ERROR_NONE;
    }

    Runtime * const rt = Runtime::Instance();
    Driver *devDrv =  rt->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(devDrv, RT_ERROR_DRV_NULL);

    const uint32_t eventFlag = (eventFlag_ == RT_EVENT_MC2) ? RT_NOTIFY_MC2 : 0U;
    const rtError_t error = devDrv->NotifyIdAlloc(device_->Id_(), RtPtrToPtr<uint32_t *>(&eventId_),
        device_->DevGetTsId(), eventFlag, false, true);

    ERROR_RETURN(error, "Event id alloc error, device_id=%u, tsId=%u, retCode=%#x!",
        device_->Id_(), device_->DevGetTsId(), error);
    RT_LOG(RT_LOG_INFO, "Event id alloc success, device_id=%u, tsId=%u, eventFlag=%u, event_id=%d",
        device_->Id_(), device_->DevGetTsId(), eventFlag_, eventId_);

    isCntNotify_ = false;
    return error;
}

rtError_t DavidEvent::AllocEventIdResource(Stream * const stm, int32_t &eventId)
{
    rtError_t error = RT_ERROR_NONE;
    if (IsEventWithoutWaitTask()) { // stream mark or timeline
        RT_LOG(RT_LOG_INFO, "Stars not need to alloc id in this flag=%u", eventFlag_);
        return error;
    }

    stm->GetCntNotifyId(eventId);
    if (eventId == MAX_INT32_NUM) {
        (void)stm->ApplyCntNotifyId(eventId);
        return RT_ERROR_NONE;
    }

    if (unlikely(stm->IsCntNotifyReachThreshold() == true)) {
        bool waitStatus = false;
        while ((error == RT_ERROR_NONE) && (!waitStatus)) {
            error = stm->CheckContextStatus();
            COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
            error = QueryEventWaitStatus(true, waitStatus);
        }
        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_ERROR,
                "Event wait status, device_id=%u, tsId=%u, stream_id=%d, waitStatus=%u, retCode=%#x!",
                device_->Id_(), device_->DevGetTsId(), stm->Id_(), waitStatus, error);
            return error;
        }
    }
    return RT_ERROR_NONE;
}

bool DavidEvent::WaitSendCheck(const Stream * const stm, int32_t &eventId)
{
    // lock id and state
    const std::lock_guard<std::mutex> latestStateLock(recordStateMutex_);

    eventId = eventId_;
    if (stm->GetBindFlag()) {
        return true;
    }
    // new mode
    if (isNewMode_) {
        if (status_ == DavidEventState_t::EVT_RECORDED) {
            RT_LOG(RT_LOG_INFO, "wait first, return suc. device_id=%u, event_id=%d", device_->Id_(), eventId_);
            return false;
        }
        if (eventId == INVALID_EVENT_ID) {
            RT_LOG(RT_LOG_ERROR, "error status, event_id=-1, device_id=%u, stream_id=%d, task_id=%hu",
                device_->Id_(), stm->Id_(), latestRecordTask_.taskId);
            return false;
        }
    }

    const bool isWaitSend = (status_ == DavidEventState_t::EVT_NOT_RECORDED) ||
        (status_ == DavidEventState_t::EVT_RECORDED && HasReset()) ||
        ((eventFlag_ & (RT_EVENT_DDSYNC_NS | RT_EVENT_EXTERNAL)) != 0U);
    if (isWaitSend) {
        return true;
    }
    return false;
}

void DavidEvent::UpdateLatestRecord(const DavidRecordTaskInfo &recordInfo, const DavidEventState_t latestStatus,
    const uint64_t timeStamp)
{
    const std::lock_guard<std::mutex> lock(recordStateMutex_);
    if (latestStatus == DavidEventState_t::EVT_NOT_RECORDED) {
        status_ = latestStatus;
        SetRecord(true);
        SetHasReset(false);
        SetTimeStamp(UINT64_MAX);
        SetLatestRecordInfo(recordInfo.taskId, recordInfo.streamId);
    } else if (latestStatus == DavidEventState_t::EVT_RECORDED) {
        if ((recordInfo.streamId == latestRecordTask_.streamId) && (recordInfo.taskId == latestRecordTask_.taskId)) {
            SetTimeStamp(timeStamp);
            status_ = DavidEventState_t::EVT_RECORDED;
        } else {
            // no operation
        }
    } else {
        // no operation
    }
}

void DavidEvent::RecordDavidEventComplete(const TaskInfo * const tsk, const uint64_t recTimestamp)
{
    DavidRecordTaskInfo latestRecord = {tsk->stream->Id_(), tsk->id};
    UpdateLatestRecord(latestRecord, DavidEventState_t::EVT_RECORDED, recTimestamp);
}

rtError_t DavidEvent::ReclaimTask(const bool evtWaitTask)
{
    // Reclaim may modify , so make a copy first.
    UNUSED(evtWaitTask);
    std::unordered_map<TaskInfo *, std::pair<Stream*, uint32_t>> eventTaskMaps;
    {
        const std::lock_guard<std::mutex> reclaimLock(taskMapMutex_);
        eventTaskMaps = waitTaskMap_;
        eventTaskMaps.insert(recordResetMap_.begin(), recordResetMap_.end());
    }

    for (auto &item : eventTaskMaps) {
        Stream * const stm = item.second.first;
        rtError_t error = stm->CheckContextStatus();
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));
        stm->StreamSyncLock();
        (void)TaskReclaimByStream(stm, true);
        stm->StreamSyncUnLock();
    }
    return RT_ERROR_NONE;
}

rtError_t DavidEvent::QueryEventTask(rtEventStatus_t * const status)
{
    Stream *stm = nullptr;
    DavidRecordTaskInfo latestState = GetLatestRecordInfo();
    const uint32_t streamId = static_cast<uint32_t>(latestState.streamId);
    const uint32_t taskId = latestState.taskId;
    rtError_t error = device_->GetStreamSqCqManage()->GetStreamById(static_cast<uint32_t>(streamId), &stm);

    COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (stm == nullptr)), error,
                                "Query stream failed, device_id=%u, stream_id=%u, retCode=%#x.",
                                device_->Id_(), streamId, static_cast<uint32_t>(error));
    error = stm->CheckContextStatus();
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));
    error = stm->JudgeHeadTailPos(status, this->recordPos_);
    if (error != RT_ERROR_NONE) { // confirm
        return RT_ERROR_NONE;
    }
    if (*status == RT_EVENT_RECORDED && (eventFlag_ & RT_EVENT_TIME_LINE) != 0) {
        const uint64_t curUs = TimeStamp();
        if (curUs == UINT64_MAX) {
            *status = RT_EVENT_INIT;
            stm->StreamSyncLock();
            (void)TaskReclaimByStream(stm, false);
            stm->StreamSyncUnLock();
        }
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, status=%d, stream_id=%u, record task_id=%hu", 
        device_->Id_(), eventId_, *status, streamId, taskId);
    return RT_ERROR_NONE;
}

rtError_t DavidEvent::WaitTask(const int32_t timeout)
{
    DavidRecordTaskInfo latestState = GetLatestRecordInfo();
    const int32_t streamId = latestState.streamId;
    const uint32_t taskId = latestState.taskId;
    if (status_ == DavidEventState_t::EVT_RECORDED) {
        return RT_ERROR_NONE;
    }
    std::shared_ptr<Stream> stm = nullptr;
    rtError_t error = device_->GetStreamSqCqManage()->GetStreamSharedPtrById(static_cast<uint32_t>(streamId), stm);
    COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (stm == nullptr)), error,
                                "Query stream failed, stream_id=%d, retCode=%#x.",
                                streamId, static_cast<uint32_t>(error));
    // if set stream fail mode, need to reclaim task to update error info
    bool isReclaim = (stm->Context_()->GetCtxMode() == STOP_ON_FAILURE);    
    error = stm->WaitTask(isReclaim, taskId, timeout);
    stm.reset();
    return error;
}

rtError_t DavidEvent::Synchronize(int32_t timeout)
{
    if (!HasRecord()) {
        const int32_t deviceId = (device_ == nullptr) ? -1 : static_cast<int32_t>(device_->Id_());
        RT_LOG(RT_LOG_INFO, "No record to be synchronize, return suc. device_id=%d, event_id=%d", deviceId, eventId_);
        return RT_ERROR_NONE;
    }

    rtError_t error = WaitTask(timeout);
    if (error == RT_ERROR_STREAM_SYNC_TIMEOUT) {
        SetEventSyncTimeoutFlag(true);
        error = RT_ERROR_EVENT_SYNC_TIMEOUT;
    } else {
        SetEventSyncTimeoutFlag(false);
    }
    return error;
}

rtError_t DavidEvent::Query(void) // not support query after reset
{
    rtError_t error = ReclaimTask(false);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));
    // record(recording) , return RT_ERROR_NONE. record(recorded) return Not complete
    const rtError_t queryResult =
        ((status_ == DavidEventState_t::EVT_NOT_RECORDED) && HasRecord()) ? RT_ERROR_EVENT_NOT_COMPLETE : RT_ERROR_NONE;
    RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, lateststate=%d, result=%d",
        device_->Id_(), eventId_, status_, queryResult);
    return queryResult;
}

rtError_t DavidEvent::QueryEventStatus(rtEventStatus_t * const status)
{
    rtError_t error = RT_ERROR_NONE;
    // No record , newMode return RT_EVENT_RECORDED oldMode return RT_EVENT_INIT
    if (!HasRecord()) {
        RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d no record to be query, return recorded.",
            device_->Id_(), eventId_);
        *status = (isNewMode_) ? RT_EVENT_RECORDED : RT_EVENT_INIT;
        return error;
    }

    if (GetRecordStatus() != DavidEventState_t::EVT_RECORDED) {
        error = QueryEventTask(status);
    } else {
        *status = RT_EVENT_RECORDED;
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, lateststate=%d, status=%d",
           device_->Id_(), eventId_, status_, *status);
    return error;
}

rtError_t DavidEvent::QueryEventWaitStatus(const bool disableThread, bool &waitFlag)
{
    UNUSED(disableThread);
    const std::lock_guard<std::mutex> queryLock(taskMapMutex_);
    waitFlag = true;
    if (IsEventWithoutWaitTask() || waitTaskMap_.empty()) {
        RT_LOG(RT_LOG_INFO, "waitTaskNum=%u, flag=%u", waitTaskMap_.size(), eventFlag_);
        return RT_ERROR_NONE;
    }

    for (auto &waitMapItem : waitTaskMap_) {
        Stream * const stm = waitMapItem.second.first;
        waitFlag = false;
        const rtError_t error = stm->QueryWaitTask(waitFlag, waitMapItem.second.second);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Query wait status failed, device_id=%u, retCode=%#x.", device_->Id_(), static_cast<uint32_t>(error));
        if (!waitFlag) {
            RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, not complete wait stream_id=%d, task_id=%hu",
                device_->Id_(), eventId_, stm->Id_(), waitMapItem.second.second);
            break;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t DavidEvent::ElapsedTime(float32_t * const timeInterval, Event * const base)
{
    DavidEvent *baseEvt = dynamic_cast<DavidEvent *>(base);
    if ((!HasRecord()) || (!base->HasRecord())) {
        return RT_ERROR_EVENT_RECORDER_NULL;
    }
    const uint64_t deltaNs = TimeStamp() - baseEvt->TimeStamp();
    RT_LOG(RT_LOG_DEBUG, "curNs=%#" PRIx64 ", baseNs=%#" PRIx64 ", curEventId=%d, baseEventId=%d.",
        TimeStamp(), baseEvt->TimeStamp(), eventId_, baseEvt->EventId_());
    *timeInterval = static_cast<float32_t>(static_cast<float64_t>(deltaNs) / RT_DEFAULT_TIMESTAMP_FREQ);

    return RT_ERROR_NONE;
}

rtError_t DavidEvent::GetTimeStamp(uint64_t * const recTimestamp)
{
    if (!HasRecord()) {
        return RT_ERROR_EVENT_RECORDER_NULL;
    }
    const uint64_t curUs = TimeStamp();
    RT_LOG(RT_LOG_DEBUG, "event_id=%d, timeline=%#" PRIx64 ".", eventId_, curUs);
    if (curUs == UINT64_MAX) {
        return RT_ERROR_EVENT_TIMESTAMP_INVALID;
    }
    *recTimestamp = curUs / (static_cast<uint64_t>(RT_DEFAULT_TIMESTAMP_FREQ) / 1000U);
    return RT_ERROR_NONE;
}

rtError_t DavidEvent::ClearRecordStatus()
{
    latestRecordTask_.streamId = -1;
    latestRecordTask_.taskId = UINT32_MAX;
    SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    if (isNewMode_) {
        SetRecordStatus(DavidEventState_t::EVT_RECORDED);
    }
    timestamp_ = UINT64_MAX;
    SetRecord(false);
    SetIsNeedDestroy(false);
    SetHasReset(false);
    return RT_ERROR_NONE;
}

bool DavidEvent::IsEventIdAndCntValueExist(int32_t eventId, uint32_t cntValue)
{
    auto id_iter = eventIdAndCntValueMap_.find(eventId);
    if (id_iter == eventIdAndCntValueMap_.end()) {
        RT_LOG(RT_LOG_ERROR, "event id is not found in the event wait map, event_id=%d, cnt_value=%u.",
            eventId, cntValue);
        return false;
    }

    const auto& value = id_iter->second;
    if (value.find(cntValue) == value.end()) {
        RT_LOG(RT_LOG_ERROR, "cnt value is not found in the event wait map, event_id=%d, cnt_value=%u.",
            eventId, cntValue);
        return false;
    }

    return true;
}
}
}