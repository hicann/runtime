/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "event.hpp"
#include "device.hpp"
#include "osal.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "npu_driver.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "stream_sqcq_manage.hpp"
#include "capture_model.hpp"
#include "stub_task.hpp"
#include "memory_task.h"
namespace cce {
namespace runtime {
Event::Event()
    : NoCopy(), device_(nullptr), isNeedDestroy_(false), eventId_(INVALID_EVENT_ID), recordPos_(UINT16_MAX),
      timestamp_(UINT64_MAX), isNewMode_(false),  context_(nullptr), freeEventId_(INVALID_EVENT_ID), timeline_(UINT64_MAX),
      isNotify_(false), isEventSyncTimeout_(false), isIdAllocFromDrv_(false), isSync_(false),
      hasRecord_(false), hasReset_(false), isDestroySync_(false)
{
    latestRecord_.streamId = -1;
    latestRecord_.taskId = UINT32_MAX;
    latestRecord_.state = INIT;
    eventFlag_ = Runtime::Instance()->GetDisableThread() ? UINT64_MAX : RT_EVENT_DEFAULT;
}

Event::Event(Device * device, uint64_t eventFlag, Context *ctx, bool isSync, bool isNewMode)
    : NoCopy(), device_(device), isNeedDestroy_(false), eventId_(INVALID_EVENT_ID), recordPos_(UINT16_MAX),
      eventFlag_(eventFlag), timestamp_(UINT64_MAX), isNewMode_(isNewMode), context_(ctx),
      freeEventId_(INVALID_EVENT_ID), timeline_(UINT64_MAX), isNotify_(false), isEventSyncTimeout_(false),
      isIdAllocFromDrv_(false), isSync_(isSync), hasRecord_(false), hasReset_(false), isDestroySync_(false)
{
    latestRecord_.streamId = -1;
    latestRecord_.taskId = UINT32_MAX;
    latestRecord_.state = INIT;
}

Event::~Event() noexcept
{
    if (eventId_ != INVALID_EVENT_ID && isIdAllocFromDrv_) {
        device_->FreeEventIdFromDrv(eventId_, eventFlag_, GetDestroySync());
    }
    if (!IsEventTaskEmpty()) {
#ifndef CFG_DEV_PLATFORM_PC
        RT_LOG(RT_LOG_ERROR, "device_id=%u, Event task not empty, recordSize=%d, waitSize=%d, idSize=%d",
               device_->Id_(), recordResetMap_.size(), waitTaskMap_.size(), idMap_.size());
#endif
    }
    if (device_ != nullptr) {
        RT_LOG(RT_LOG_INFO, "event destructor, device_id=%u, recordSize=%u, waitSize=%u, idSize=%u",
               device_->Id_(), recordResetMap_.size(), waitTaskMap_.size(), idMap_.size());
        device_ = nullptr;
    }
}

void Event::TryFreeLastEventId()
{
    const std::lock_guard<std::mutex> lock(idMapMutex_);
    if (isNewMode_ || freeEventId_ == INVALID_EVENT_ID) {
        RT_LOG(RT_LOG_INFO, "NewMode free in DoComplete, oldMode only free at second record.");
        return;
    }
    if (device_->IsSupportEventPool()) {
        device_->PushNextPoolFreeEventId(freeEventId_);
        device_->WakeUpRecycleThread();
        RT_LOG(RT_LOG_INFO, "pool push recycle event_id=%d.", freeEventId_);
    } else {
        device_->FreeEventIdFromDrv(freeEventId_);
    }
    freeEventId_ = INVALID_EVENT_ID;
}

void Event::EventIdCountSub(const int32_t id, bool isFreeId)
{
    const std::lock_guard<std::mutex> lock(idMapMutex_);
    if (idMap_.find(id) == idMap_.end()) {
        RT_LOG(RT_LOG_ERROR, "event_id=%d not in idMap", id);
        return;
    }
    if (idMap_[id] > 0U) {
        idMap_[id]--;
    } else {
        RT_LOG(RT_LOG_ERROR, "event_id=%d, count already is zero", id);
    }
    if (idMap_[id] == 0U) {
        if (isFreeId && isIdAllocFromDrv_) {
            device_->FreeEventIdFromDrv(id);
            RT_LOG(RT_LOG_ERROR, "event_id=%d, error free", id);
            eventId_ = (eventId_ == id) ? INVALID_EVENT_ID : eventId_;
        }
        idMap_.erase(id);
    }
}

bool Event::TryFreeEventIdAndCheckCanBeDelete(const int32_t id, bool isNeedDestroy)
{
    const std::lock_guard<std::mutex> lock(idMapMutex_);
#ifndef CFG_DEV_PLATFORM_PC
    if (device_ == nullptr) {
        return false;
    }
#endif
    if (isNeedDestroy) { // call from EventDestroy
        SetIsNeedDestroy(isNeedDestroy_.Value() || isNeedDestroy);
        return idMap_.empty();
    }
    if (idMap_.find(id) == idMap_.end()) { // invalid id return.
        RT_LOG(RT_LOG_ERROR, "device_id=%u, invalid event_id=%d not in map.", device_->Id_(), id);
        return false;
    }

    if (idMap_[id] > 0U) { // do complete success call
        idMap_[id]--;
    } else {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, event_id=%d, count already is zero", device_->Id_(), id);
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, map_count=%d, isNewMode=%d, isIdFromDrv=%d, newestId=%d",
           device_->Id_(), id, idMap_[id], isNewMode_, isIdAllocFromDrv_, eventId_);
    if (idMap_[id] == 0) { // delete
        if (isIdAllocFromDrv_ && (isNewMode_ || eventId_ != id)) {
            if (device_->IsSupportEventPool()) {
                device_->PushNextPoolFreeEventId(id);
                RT_LOG(RT_LOG_INFO, "pool push recycle event_id=%d.", id);
            } else {
                device_->FreeEventIdFromDrv(id);
            }
            eventId_ = (eventId_ == id) ? INVALID_EVENT_ID : eventId_;
        }
        idMap_.erase(id);
    }
    return isNeedDestroy_.Value() && idMap_.empty();
}

bool Event::IsEventTaskEmpty()
{
    const std::lock_guard<std::mutex> isEmptyLock(taskMapMutex_);
    return waitTaskMap_.empty() && recordResetMap_.empty();
}

void Event::InsertWaitToMap(TaskInfo *tsk)
{
    const std::lock_guard<std::mutex> insertLock(taskMapMutex_);
    std::pair<Stream*, uint32_t> value;
    value.first = tsk->stream;
    value.second = tsk->id;
    waitTaskMap_[tsk] = value;
}

void Event::DeleteWaitFromMap(TaskInfo *tsk)
{
    const std::lock_guard<std::mutex> deleteLock(taskMapMutex_);
    const auto it = waitTaskMap_.find(tsk);
    if (it == waitTaskMap_.end()) {
        return;
    }
    waitTaskMap_.erase(tsk);
}

void Event::InsertRecordResetToMap(TaskInfo *tsk)
{
    const std::lock_guard<std::mutex> insertLock(taskMapMutex_);
    std::pair<Stream*, uint32_t> value;
    value.first = tsk->stream;
    value.second = tsk->id;
    recordResetMap_[tsk] = value;
}

void Event::DeleteRecordResetFromMap(TaskInfo *tsk)
{
    const std::lock_guard<std::mutex> deleteLock(taskMapMutex_);
    const auto it = recordResetMap_.find(tsk);
    if (it == recordResetMap_.end()) {
        return;
    }
    recordResetMap_.erase(tsk);
}

Notifier* Event::FindFromNotifierMap(uint32_t streamId, uint16_t taskId)
{
    COND_RETURN_WITH_NOLOG(Runtime::Instance()->GetDisableThread(), nullptr);
    uint32_t key = (streamId << 16U) | static_cast<uint32_t>(taskId);
    const auto it = notifierMap_.find(key);
    if (it == notifierMap_.end()) {
        RT_LOG(RT_LOG_DEBUG, "nullptr device_id=%u stream_id=%u, task_id=%hu.", device_->Id_(), streamId, taskId);
        return nullptr;
    } else {
        RT_LOG(RT_LOG_INFO, "trigger device_id=%u, stream_id=%u, task_id=%hu.", device_->Id_(), streamId, taskId);
        return notifierMap_[key];
    }
}

void Event::InsertToNotifierMap(uint32_t streamId, uint16_t taskId, Notifier *value)
{
    if (Runtime::Instance()->GetDisableThread()) {
        return;
    }
    uint32_t key = (streamId << 16U) | static_cast<uint32_t>(taskId);
    const auto it = notifierMap_.find(key);
    if (it != notifierMap_.end()) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%u, task_id=%hu notifier already exist.", device_->Id_(),
            streamId, taskId);
        return;
    } else {
        notifierMap_[key] = value;
        RT_LOG(RT_LOG_INFO, "wait device_id=%u, stream_id=%u, task_id=%hu.", device_->Id_(), streamId, taskId);
    }
}

void Event::DeleteFromNotifierMap(uint32_t streamId, uint16_t taskId)
{
    if (Runtime::Instance()->GetDisableThread()) {
        return;
    }
    uint32_t key = (streamId << 16U) | static_cast<uint32_t>(taskId);
    const auto it = notifierMap_.find(key);
    if (it == notifierMap_.end()) {
        return;
    }
    DELETE_O(notifierMap_[key]);
    notifierMap_.erase(key);
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%u, task_id=%hu.", device_->Id_(), streamId, taskId);
}

void Event::UpdateLatestRecord(RecordTaskInfo &latestRecord, const int32_t newEventId,
    const uint64_t timeLine, const uint64_t timeStamp)
{
    std::vector<std::string> latestRecordName = {"init", "recording", "recorded"};
    const std::lock_guard<std::mutex> updateLock(recordStateMutex_);
    if (latestRecord.state == RECORDING) {
        latestRecord_ = latestRecord;
        RefreshEventId(newEventId);
        SetRecord(true);
        SetHasReset(false);
        timeline_ = UINT64_MAX;
        timestamp_ = UINT64_MAX;
    } else if (latestRecord.state == RECORDED) {
        if ((latestRecord.streamId == latestRecord_.streamId) && (latestRecord.taskId == latestRecord_.taskId)) {
            timeline_ = timeLine;
            timestamp_ = timeStamp;
            latestRecord_.state = RECORDED;
        }
    } else {
        // no op
    }

    if (latestRecord_.state > RECORDED) {
        RT_LOG(RT_LOG_INFO, "invalid status=%d", latestRecord_.state);
        return;
    }

    RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, cur stream_id=%d, cur task_id=%u, "
        "latest stream_id=%d, latest task_id=%u, status=%d(%s)",
        device_->Id_(), eventId_, latestRecord_.streamId, latestRecord_.taskId, latestRecord.streamId,
        latestRecord.taskId, latestRecord_.state,
        (latestRecordName.at(latestRecord_.state)).c_str());
}

void Event::RefreshEventId(int32_t eventid)
{
    // refresh new id, must be lock, may be conflict with TryFreeEventIdAndCheckCanBeDelete.
    const std::lock_guard<std::mutex> lock(idMapMutex_);
    if (isNewMode_ || eventFlag_ == RT_EVENT_DEFAULT) {
        if (idMap_.find(eventId_) == idMap_.end()) {
            freeEventId_ = eventId_;
        }
        RT_LOG(RT_LOG_INFO, "old event_id=%d, fresh event_id=%d", eventId_, eventid);
        eventId_ = eventid;
    }
}

rtError_t Event::CreateEventNotifier(Notifier* &notifier)
{
    const std::lock_guard<std::mutex> initLock(initMutex_);
    notifier = OsalFactory::CreateNotifier();
    NULL_PTR_RETURN_MSG(notifier, RT_ERROR_NOTIFY_NEW);
    return RT_ERROR_NONE;
}

rtError_t Event::AllocEventIdResource(const Stream * const stm, int32_t &newEventId) const 
{
    rtError_t error = RT_ERROR_NONE;
    rtError_t errorAbort = RT_ERROR_NONE;
    uint32_t taskId = 0U;
    uint16_t tryCount = 0U;
    const bool isDisableThreadFlag = Runtime::Instance()->GetDisableThread();
    do {
        error = device_->IsSupportEventPool() ? device_->AllocPoolEvent(&newEventId) :
                device_->Driver_()->EventIdAlloc(&newEventId, device_->Id_(), device_->DevGetTsId());
        if (unlikely(error == RT_ERROR_DRV_NO_EVENT_RESOURCES)) {
            tryCount++;
            (void)device_->TaskReclaimAllForNoRes(false, taskId);
            errorAbort = stm->CheckContextStatus();
            ERROR_RETURN(errorAbort, "context is abort, status=%#x.", static_cast<uint32_t>(errorAbort));
        }
        RT_LOG(RT_LOG_INFO, "alloc_id=%d, event_id=%d, err_code=%d.", newEventId, eventId_, error);
    } while ((error == RT_ERROR_DRV_NO_EVENT_RESOURCES) && (device_->GetDevStatus() == RT_ERROR_NONE) &&
            ((!isDisableThreadFlag || (tryCount < 1000U))));
    return error;
}

void Event::InitEventAllocFlag(int32_t streamId)
{
    UNUSED(streamId);
    if (HasRecord()) { // create or first record will Set isIdAllocFromDrv_
        return;
    }
    Runtime * const rt = Runtime::Instance();
    // isSync is true only when stream sync
    if (eventFlag_ == RT_EVENT_MC2) {
        isIdAllocFromDrv_ = true;
        return;
    }
    if (IsEventWithoutWaitTask()) { // stream mark or timeline.
        if (device_->IsStarsPlatform()) { // stars not alloc id
            RT_LOG(RT_LOG_INFO, "Stars not need to alloc id in this flag=%" PRIu64 "", eventFlag_);
            return;
        }
        if (rt->GetDisableThread()) {
            eventId_ = device_->GetDevProperties().timelineEventId;
        } else {
            // In 1980+virtual, 1910,  use fixEventId TIMELINE_EVENT_ID when flag is RT_EVENT_TIME_LINE
            // stream mark should alloc id.
            eventId_ = (eventFlag_ == RT_EVENT_TIME_LINE) ? TIMELINE_EVENT_ID : INVALID_EVENT_ID;
        }
    }
    isIdAllocFromDrv_ = (eventId_ == INVALID_EVENT_ID);
}

rtError_t Event::GenEventId()
{
    Driver *devDrv = nullptr;
    Runtime * const rt = Runtime::Instance();
    rtError_t error = RT_ERROR_NONE;
    const uint32_t deviceId = device_->Id_();
    const uint32_t tsId = device_->DevGetTsId();
    InitEventAllocFlag();
    if (!isIdAllocFromDrv_) {
        return RT_ERROR_NONE;
    }
    devDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(devDrv, RT_ERROR_DRV_NULL);
    const uint32_t eventFlag = ((eventFlag_ == RT_EVENT_MC2) &&
        (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DRIVER_EVENT_MC2))) ?
        static_cast<uint32_t>(eventFlag_) : 0U;
    error = devDrv->EventIdAlloc(&eventId_, deviceId, tsId, eventFlag, true);
    ERROR_RETURN(error, "Event id alloc error, device_id=%u, tsId=%u, retCode=%#x!", deviceId, tsId, error);

    RT_LOG(RT_LOG_INFO, "Event id alloc success, device_id=%u, tsId=%u, eventFlag=%" PRIu64 ", event_id=%d",
           deviceId, tsId, eventFlag_, eventId_);
    return error;
}

rtError_t Event::ReAllocId()
{
    InitEventAllocFlag();
    if (!isIdAllocFromDrv_ || eventId_ == INVALID_EVENT_ID) {
        return RT_ERROR_NONE;
    }

    Runtime * const rt = Runtime::Instance();
    Driver *devDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(devDrv, RT_ERROR_DRV_NULL);
    const rtError_t error = devDrv->ReAllocResourceId(device_->Id_(), device_->DevGetTsId(), 0U,
        static_cast<uint32_t>(eventId_), DRV_EVENT_ID);
    ERROR_RETURN(error, "Realloc event id failed, eventId=%d, deviceId=%u, retCode=%d.",
        eventId_, device_->Id_(), error);

    RT_LOG(RT_LOG_INFO, "Event id re alloc success, device_id=%u, tsId=%u, event_id=%d",
           device_->Id_(), device_->DevGetTsId(), eventId_);
    return error;
}

rtError_t Event::GetEventID(uint32_t * const evtId) const
{
    if (eventId_ == INVALID_EVENT_ID) { // stream mark / timeline no use
        RT_LOG(RT_LOG_ERROR, "eventFlag=%" PRIu64 ", event id is invalid.", eventFlag_);
        return RT_ERROR_EVENT_RECORDER_NULL;
    }
    *evtId = static_cast<uint32_t>(eventId_);
    return RT_ERROR_NONE;
}

rtError_t Event::CaptureEventProcess(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    void *eventAddr = nullptr;
    rtError_t errorReason;
    int32_t newEventId = INVALID_EVENT_ID;
    Device * const dev = stm->Device_();
    TaskInfo submitTask = {};
    TaskInfo *tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_EVENT_RECORD, errorReason);
    COND_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
                                "Failed to alloc task when event record, stream_id=%d.", stm->Id_());
    CaptureModel * const mdl = dynamic_cast<CaptureModel *>(captureStream_->Model_());
    std::function<void()> const errRecycle = [&dev, &tsk, &eventAddr, &newEventId]() {
        if (newEventId != INVALID_EVENT_ID) {
            dev->FindExpandingEventAddrById(&eventAddr, newEventId);
        }
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    error = dev->AllocExpandingPoolEvent(&eventAddr, &newEventId);
    ERROR_RETURN_MSG_INNER(error, "capture addr error, deviceId=%u, tsId=%u, retCode=%#x!",
                            device_->Id_(), device_->DevGetTsId(), error);
    {
        const std::lock_guard<std::mutex> lock(eventLock_);
        mdl->GetCaptureEventIndex().insert(newEventId);
        eventId_ = newEventId;
        RT_LOG(RT_LOG_INFO, "insert event id in capture model, event_id=%d.", eventId_);
    }
    (void)MemWriteValueTaskInit(tsk, eventAddr, static_cast<uint64_t>(1U));
    tsk->typeName = "EVENT_RECORD";
    tsk->type = TS_TASK_TYPE_CAPTURE_RECORD;
    MemWriteValueTaskInfo *memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->event = this;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit capture task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    SetRecord(true);
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    RT_LOG(RT_LOG_INFO, "capture event task submit success, device_id=%u, stream_id=%d, task_id=%d, event_id=%d",
        device_->Id_(), stm->Id_(), tsk->id, eventId_);
    return error;
}

rtError_t Event::Record(Stream * const stm, const bool isApiCall)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    const std::lock_guard<std::mutex> lockRecord(eventLockForRecord_);
    if ((!GlobalContainer::IsEventHardMode()) && (captureStream_ != nullptr)) {
        return CaptureEventProcess(stm);
    }
    rtError_t error = RT_ERROR_NONE;
    Device *const dev = stm->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *tsk = nullptr;
    TaskFactory *const tskFactory = dev->GetTaskFactory();
    const bool oldHasReset = HasReset(); // for task send fail rollback.
    const bool oldHasRecord = HasRecord();
    int32_t newEventId = INVALID_EVENT_ID;
    rtTaskGenCallback callback = nullptr;
    tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_EVENT_RECORD, errorReason);
    COND_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
                                "Failed to alloc task when event record, stream_id=%d.", stm->Id_());
    if (isNewMode_ || eventFlag_ == RT_EVENT_DEFAULT) {
        InitEventAllocFlag(stm->Id_());
        if (isIdAllocFromDrv_) {
            error = AllocEventIdResource(stm, newEventId);
            ERROR_GOTO_MSG_INNER(error, TASK_RECYCLE, "Event id alloc error, deviceId=%u, tsId=%u, retCode=%#x!",
                                 device_->Id_(), device_->DevGetTsId(), error);
        } else {
            const std::lock_guard<std::mutex> lock(idMapMutex_);
            newEventId = eventId_;
        }
    } else {
        const std::lock_guard<std::mutex> lock(idMapMutex_);
        newEventId = eventId_;
    }
    {
        const std::lock_guard<std::mutex> lock(eventLock_);
        error = EventRecordTaskInit(tsk, this, false, newEventId);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to init record task, retCode=%#x.",
                             static_cast<uint32_t>(error));
    }
    error = UpdateEventTimeLine(tsk, this); // can not in task init because maybe deadlock
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Get timeline buffer failed, retCode=%#x.",
        static_cast<uint32_t>(error));
    callback = (stm->Context_() == nullptr) ? nullptr : stm->Context_()->TaskGenCallback_();
    error = dev->SubmitTask(tsk, callback);
    TryFreeLastEventId();
    if (error == RT_ERROR_NONE) {
        stm->InsertEventTask(tsk);
    }
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit record task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    if (isApiCall) {
        GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    }
    isNotify_ = false;
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    DeleteRecordResetFromMap(tsk);
    EventIdCountSub(newEventId, (newEventId != INVALID_EVENT_ID && !IsAbortError(error)));
    SetRecord(oldHasRecord);
    SetHasReset(oldHasReset);
TASK_RECYCLE:
    if (tsk != nullptr) {
        tskFactory->Recycle(tsk);
    }
    return error;
}

bool Event::WaitSendCheck(const Stream * const stm, int32_t &eventId)
{
    // lock id and state
    const std::lock_guard<std::mutex> latestStateLock(recordStateMutex_);
    eventId = eventId_;
    if (stm->GetBindFlag()) {
        EventIdCountAdd(eventId);
        return true;
    }
    // new mode
    if (isNewMode_) {
        if (!HasRecord()) {
            RT_LOG(RT_LOG_INFO, "wait first, return suc. device_id=%u, event_id=%d", device_->Id_(), eventId_);
            return false;
        }
        if ((latestRecord_.streamId == stm->Id_()) && (HasRecord())) {
            RT_LOG(RT_LOG_INFO, "if record first and wait in same stm, return suc, "
                                "device_id=%u, event_id=%d, stream_id=%d", device_->Id_(), eventId_, stm->Id_());
            return false;
        }
        if (latestRecord_.state == RECORDED) {
            RT_LOG(RT_LOG_INFO, "record has been execute, wait return suc, device_id=%u, event_id=%d, stream_id=%d,"
                                " task_id=%hu", device_->Id_(), eventId_, stm->Id_(), latestRecord_.taskId);
            return false;
        }
        if (eventId == INVALID_EVENT_ID) {
            RT_LOG(RT_LOG_ERROR, "error status, event_id=-1, device_id=%u, stream_id=%d, task_id=%hu",
                   device_->Id_(), stm->Id_(), latestRecord_.taskId);
            return false;
        }
    }
    // record not complete  or (record complete, and reset)
    const bool isWaitSend = (latestRecord_.state != RECORDED) || (latestRecord_.state == RECORDED && HasReset()) ||
            ((eventFlag_ & (RT_EVENT_DDSYNC_NS | RT_EVENT_EXTERNAL)) != 0U);
    if (isWaitSend) {
        EventIdCountAdd(eventId);
        return true;
    }
    return false;
}

rtError_t Event::CaptureWaitProcess(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    void *eventAddr = nullptr;
    Device * const dev = stm->Device_();
    TaskInfo *tsk = nullptr;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_STREAM_WAIT_EVENT, errorReason, MEM_WAIT_SQE_NUM);
    COND_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
        "task alloc fail err:%#x", static_cast<uint32_t>(errorReason));
    std::function<void()> const errRecycle = [&dev, &tsk]() {
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    error = device_->FindExpandingEventAddrById(&eventAddr, eventId_);
    ERROR_RETURN_MSG_INNER(error, "Failed to find event addr, event_id=%d, retCode=%#x.",
                         eventId_, static_cast<uint32_t>(error));

    tsk->typeName = "EVENT_WAIT";
    tsk->type = TS_TASK_TYPE_CAPTURE_WAIT;
    error = MemWaitValueTaskInit(tsk, eventAddr, 1, 0x0);
    ERROR_RETURN_MSG_INNER(error, "mem wait value init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        stm->Id_(), tsk->id, static_cast<uint32_t>(error));
    MemWaitValueTaskInfo *memWaitValueTask = &tsk->u.memWaitValueTask;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit wait task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    RT_LOG(RT_LOG_INFO, "capture wait task submit success, device_id=%u, stream_id=%d, task_id=%d, event_id=%d",
        device_->Id_(), stm->Id_(), tsk->id, eventId_);
    return error;
}

rtError_t Event::Wait(Stream * const stm, const uint32_t timeout)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    if ((!GlobalContainer::IsEventHardMode()) && (captureStream_ != nullptr)) {
        return CaptureWaitProcess(stm);
    }
    int32_t eventId = INVALID_EVENT_ID;
    if (!WaitSendCheck(stm, eventId)) {
        RT_LOG(RT_LOG_INFO, "no need wait, return suc. device_id=%u, event_id=%d", device_->Id_(), eventId);
        return RT_ERROR_NONE;
    }
    const uint32_t recDevId = device_->Id_();
    if ((!isNotify_) && ((eventFlag_ & (RT_EVENT_DDSYNC_NS | RT_EVENT_EXTERNAL)) == 0U) &&
        (!HasRecord() || (eventId == INVALID_EVENT_ID))) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "The wait event cannot be submitted before the record event. device_id=%u, "
            "stream_id=%d, flag=%" PRIu64 ", model=%s.",
            recDevId, stm->Id_(), eventFlag_, stm->GetModelNum() != 0 ? "yes" : "no");
        EventIdCountSub(eventId);
        return RT_ERROR_INVALID_VALUE;
    }
    rtError_t error = RT_ERROR_NONE;
    Device * const dev = stm->Device_();
    RT_LOG(RT_LOG_INFO, "record device_id=%u, wait device_id=%u, event_id=%d.", recDevId, dev->Id_(), eventId);
    TaskInfo *tsk = nullptr;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    const bool isRemoteEventWait = (recDevId != dev->Id_());

    tsk = isRemoteEventWait ? stm->AllocTask(&submitTask, TS_TASK_TYPE_REMOTE_EVENT_WAIT, errorReason) :
          stm->AllocTask(&submitTask, TS_TASK_TYPE_STREAM_WAIT_EVENT, errorReason);
    COND_PROC_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
                                     EventIdCountSub(eventId), "task alloc fail err:%#x",
                                     static_cast<uint32_t>(errorReason));

    isRemoteEventWait ? (void)RemoteEventWaitTaskInit(tsk, this, static_cast<int32_t>(recDevId), eventId) :
    (void)EventWaitTaskInit(tsk, this, eventId, timeout);
    rtTaskGenCallback const callback = (stm->Context_() == nullptr) ? nullptr : stm->Context_()->TaskGenCallback_();
    error = dev->SubmitTask(tsk, callback);

    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit wait task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    DeleteWaitFromMap(tsk);
    EventIdCountSub(eventId);
    (void)dev->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t Event::CaptureResetProcess(Stream * const stm)
{
    void *eventAddr = nullptr;
    rtError_t error = RT_ERROR_NONE;
    rtError_t errorReason;
    Device * const dev = stm->Device_();
    TaskInfo submitTask = {};
    TaskInfo *tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_EVENT_RESET, errorReason);
    COND_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
                                "task alloc fail err:%#x",
                                     static_cast<uint32_t>(errorReason));
    std::function<void()> const errRecycle = [&dev, &tsk]() {
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    error = device_->FindExpandingEventAddrById(&eventAddr, eventId_);
    ERROR_RETURN_MSG_INNER(error, "Failed to find event addr, event_id=%d, retCode=%#x.",
                         eventId_, static_cast<uint32_t>(error));
    (void)MemWriteValueTaskInit(tsk, eventAddr, static_cast<uint64_t>(0));
    tsk->typeName = "EVENT_RESET";
    tsk->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit reset task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "reset task submit, device_id=%u, stream_id=%d, task_id=%d, event_id=%d", device_->Id_(), stm->Id_(), tsk->id, eventId_);
    tskErrRecycle.ReleaseGuard();
    return error;
}

// new mode not call
rtError_t Event::Reset(Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    if ((!GlobalContainer::IsEventHardMode()) && (captureStream_ != nullptr)) { // capture mode
        return CaptureResetProcess(stm);
    }
    rtError_t error;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *tsk = nullptr;
    Device * const dev = stm->Device_();
    const bool oldHasReset = HasReset();
    const int32_t eventId = eventId_;
    EventIdCountAdd(eventId);

    tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_EVENT_RESET, errorReason);
    COND_PROC_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
                                     EventIdCountSub(eventId),
                                     "task alloc fail err:%#x", static_cast<uint32_t>(errorReason));
    
    SetHasReset(true);
    (void)EventResetTaskInit(tsk, this, isNotify_, eventId);
    error = dev->SubmitTask(tsk, (stm->Context_())->TaskGenCallback_());

    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit reset task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    DeleteRecordResetFromMap(tsk);
    EventIdCountSub(eventId);
    SetHasReset(oldHasReset);
    (void)dev->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t Event::NotifierSync(Notifier* notifier, int32_t timeout)
{
    rtError_t error = GetFailureStatus();
    COND_PROC(error != RT_ERROR_NONE, return error);
    if (notifier != nullptr) {
        error = notifier->Wait(timeout);
        COND_PROC(error != RT_ERROR_NONE, return error);
    }

    error = GetFailureStatus();
    COND_PROC(error != RT_ERROR_NONE, return error);

    return RT_ERROR_NONE;
}

rtError_t Event::GetFailureStatus()
{
    const std::lock_guard<std::mutex> queryRecordLock(taskMapMutex_);
    for (const auto &item : recordResetMap_) {
        Stream *const stm = item.second.first;
        if (item.first->type == TS_TASK_TYPE_EVENT_RECORD) {
            COND_RETURN_ERROR((stm->GetFailureMode() == ABORT_ON_FAILURE), stm->GetError(),
                              "device_id=%u, the stream_id=%d is ABORT", device_->Id_(), stm->Id_());
        }
    }
    return RT_ERROR_NONE;
}

void Event::RecordComplete(TaskInfo * const tsk, const uint64_t recTimestamp, const uint64_t recTimeline)
{
    const std::lock_guard<std::mutex> lock(eventLock_);
    RecordTaskInfo latestRecord = {tsk->stream->Id_(), tsk->id, RECORDED};
    UpdateLatestRecord(latestRecord, INVALID_EVENT_ID, recTimeline, recTimestamp);
    MEMORY_FENCE();
    Notifier *notifier = FindFromNotifierMap(static_cast<uint32_t>(tsk->stream->Id_()), tsk->id);
    if (notifier != nullptr) {
        notifier->Triger();
        RT_LOG(RT_LOG_INFO, "notifier trigger, device_id=%u, stream_id=%d, task_id=%hu.",
               device_->Id_(), tsk->stream->Id_(), tsk->id);
    }
    DeleteRecordResetFromMap(tsk);
}

rtError_t Event::ReclaimTask(const bool evtWaitTask)
{
    // Reclaim may modify , so make a copy first.
    std::unordered_map<TaskInfo *, std::pair<Stream*, uint32_t>> eventTaskMaps;
    {
        const std::lock_guard<std::mutex> reclaimLock(taskMapMutex_);
        eventTaskMaps = waitTaskMap_;
        eventTaskMaps.insert(recordResetMap_.begin(), recordResetMap_.end());
    }

    for (auto &item : eventTaskMaps) {
        Stream * const stm = item.second.first;
        Device * const dev = stm->Device_();
        const rtError_t error = stm->CheckContextStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<int32_t>(error));

        if (evtWaitTask) {
            if (stm->GetAbortStatus() ==  RT_ERROR_STREAM_ABORT) {
                return RT_ERROR_STREAM_ABORT;
            }
            (void)stm->WaitTask(true, item.second.second);
        } else {
            uint32_t taskId = MAX_UINT16_NUM;
            stm->StreamSyncLock();
            (void)dev->TaskReclaim(static_cast<uint32_t>(stm->Id_()), true, taskId);
            stm->StreamSyncUnLock();
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Event::QueryEventTask(rtEventStatus_t * const status)
{
    rtError_t error = RT_ERROR_NONE;
    Stream *stm = nullptr;
    RecordTaskInfo latestState = GetLatestRecord();
    uint32_t streamId = latestState.streamId;
    uint32_t taskId = latestState.taskId;
    error = device_->GetStreamSqCqManage()->GetStreamById(static_cast<uint32_t>(streamId), &stm);
    COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (stm == nullptr)), error,
                                "Query stream failed, device_id=%u, stream_id=%u, retCode=%#x.",
                                device_->Id_(), streamId, static_cast<uint32_t>(error));
    error = stm->CheckContextStatus();
    ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<int32_t>(error));
    if (device_->IsStarsPlatform()) {
        error = stm->JudgeHeadTailPos(status, this->recordPos_);
        if (error != RT_ERROR_NONE) { // confirm
            return RT_ERROR_NONE;
        }
        if (*status == RT_EVENT_RECORDED && (eventFlag_ & RT_EVENT_TIME_LINE) != 0) {
            const uint64_t curUs =
                (Runtime::Instance()->GetDisableThread() && (!Runtime::Instance()->ChipIsHaveStars())) ?
                Timeline_() : TimeStamp();
            if (curUs == UINT64_MAX) {
                *status = RT_EVENT_INIT;
                stm->TaskReclaim();
            }
        }
        RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, status=%d, stream_id=%u, record task_id=%hu", 
            device_->Id_(), eventId_, *status, streamId, taskId);
    } else {
        uint32_t lastTaskId = 0U;
        error = stm->GetLastTaskIdFromCqShm(lastTaskId);
        ERROR_RETURN(error, "Query wait status failed.");
        if ((taskId != UINT32_MAX) && (TASK_ID_LEQ(taskId, lastTaskId))) {
            *status = RT_EVENT_RECORDED;
        } else {
            *status = RT_EVENT_INIT;
        }
        RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, status=%d, stream_id=%u, record task_id=%hu, "
                            "last task_id=%hu", device_->Id_(), eventId_, *status, streamId, taskId, lastTaskId);
    }
    return RT_ERROR_NONE;
}

rtError_t Event::WaitTask(const int32_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    RecordTaskInfo latestState = GetLatestRecord();
    int32_t streamId = latestState.streamId;
    uint32_t taskId = latestState.taskId;
    if (latestState.state == RECORDED) {
        return RT_ERROR_NONE;
    }
    std::shared_ptr<Stream> stm = nullptr;
    error = device_->GetStreamSqCqManage()->GetStreamSharedPtrById(static_cast<uint32_t>(streamId), stm);
    COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (stm == nullptr)), error,
                                "Query stream failed, stream_id=%d, retCode=%#x.",
                                streamId, static_cast<uint32_t>(error));
    // if set stream fail mode, need to reclaim task to update error info
    bool isReclaim = (stm->Context_()->GetCtxMode() == STOP_ON_FAILURE);
    error = stm->WaitTask(isReclaim, taskId, timeout);
    stm.reset();
    return error;
}

void Event::UpdateTimeline()
{
    if ((!Runtime::Instance()->GetDisableThread()) || Runtime::Instance()->ChipIsHaveStars() ||
        ((eventFlag_ & RT_EVENT_TIME_LINE) == 0U) || (GetLatestRecord().state != RECORDED)) {
        return;
    }
    rtError_t error = RT_ERROR_NONE;
    RecordTaskInfo latestRecordInfo = GetLatestRecord();
    const std::lock_guard<std::mutex> isEmptyLock(taskMapMutex_);
    std::shared_ptr<Stream> stm = nullptr;
    error = device_->GetStreamSqCqManage()->GetStreamSharedPtrById(static_cast<uint32_t>(latestRecordInfo.streamId),
                                                                   stm);
    COND_RETURN_NORMAL(((error != RT_ERROR_NONE) || (stm == nullptr)), "Query stream fail, stream_id=%d, retCode=%#x.",
                       latestRecordInfo.streamId, static_cast<uint32_t>(error));
    bool updateFlag = false;
    for (auto &item : recordResetMap_) {
        Stream *stmTmp = stm.get();
        if (item.first->id == latestRecordInfo.taskId && item.second.first == stmTmp) {
            updateFlag = true;
            break;
        }
    }
    if (!updateFlag) {
        stm.reset();
        return;
    }
    TaskInfo * const tsk =
            device_->GetTaskFactory()->GetTask(stm->Id_(), static_cast<uint16_t>(latestRecordInfo.taskId));
    if (tsk == nullptr) {
        stm.reset();
        RT_LOG(RT_LOG_WARNING, "Find task error, stream_id=%d, task_id=%hu.", stm->Id_(), latestRecordInfo.taskId);
        return;
    }

    if (tsk->type == TS_TASK_TYPE_EVENT_RECORD) {
        EventRecordTaskInfo * const recTask = &(tsk->u.eventRecordTaskInfo);
        if (recTask == nullptr) {
            stm.reset();
            RT_LOG(RT_LOG_INFO, "can't dynamic_cast recordTask.");
            return;
        }
        const uint64_t timelineBase = recTask->timelineBase;
        const uint32_t timelineOffset = recTask->timelineOffset;
        timeline_ = stm->GetTimelineValue(timelineBase, timelineOffset);
    }
    stm.reset();
}

rtError_t Event::Setup()
{
    rtError_t error;
    Driver *devDrv = nullptr;
    const uint32_t deviceId = device_->Id_();
    const uint32_t tsId = device_->DevGetTsId();
    Runtime * const rt = Runtime::Instance();
    devDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);

    NULL_PTR_RETURN_MSG(devDrv, RT_ERROR_DRV_NULL);
    error = devDrv->EventIdAlloc(&eventId_, deviceId, tsId, 0, true);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Event id alloc error, device_id=%u, tsId=%u, retCode=%#x!", deviceId, tsId, error);
        eventId_ = INVALID_EVENT_ID;
        return error;
    }
    isIdAllocFromDrv_ = true;
    isNotify_ = true;
    RT_LOG(RT_LOG_DEBUG, "Setup suc device_id=%u, event_id=%d", deviceId, eventId_);
    return RT_ERROR_NONE;
}

rtError_t Event::RecordForNotify(Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);

    Device * const dev = stm->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *tsk = nullptr;

    rtError_t error;
    const bool oldHasReset = HasReset(); // for task send fail rollback.
    const bool oldHasRecord = HasRecord();

    if (!isNotify_) {
        RT_LOG(RT_LOG_DEBUG, "record notify, there is no event need record.");
        return RT_ERROR_EVENT_RECORDER_NULL;
    }
    if (oldHasRecord && oldHasReset) {
        RT_LOG(RT_LOG_ERROR, "event for notify can only be used once in one stream, stream_id=%d", stm->Id_());
        return RT_ERROR_INVALID_VALUE;
    }
    const auto tskFactory = dev->GetTaskFactory();

    tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_EVENT_RECORD, errorReason);
    COND_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
                                "task alloc fail err:%#x", static_cast<uint32_t>(errorReason));
 
    error = EventRecordTaskInit(tsk, this, true, EventId_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to init record task, retCode=%#x.",
                         static_cast<uint32_t>(error));

    error = dev->SubmitTask(tsk, (stm->Context_())->TaskGenCallback_());

    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit record task, retCode=%#x.",
                         static_cast<uint32_t>(error));
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    DeleteRecordResetFromMap(tsk);
    EventIdCountSub(eventId_);
    SetRecord(oldHasRecord);
    SetHasReset(oldHasReset);
    if (tsk != nullptr) {
        (void)tskFactory->Recycle(tsk);
    }
    return error;
}

rtError_t Event::Synchronize(int32_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    if (!HasRecord()) {
        const int32_t device_id = (device_ == nullptr) ? -1 : static_cast<int32_t>(device_->Id_());
        RT_LOG(RT_LOG_INFO, "No record to be synchronize, return suc. device_id=%d, event_id=%d", device_id, eventId_);
        return RT_ERROR_NONE;
    }

    if (Runtime::Instance()->GetDisableThread()) {
        error = WaitTask(timeout);
        if (error == RT_ERROR_STREAM_SYNC_TIMEOUT) {
            SetEventSyncTimeoutFlag(true);
            error = RT_ERROR_EVENT_SYNC_TIMEOUT;
        } else {
            SetEventSyncTimeoutFlag(false);
        }
        return error;
    }

    int32_t remainTime = timeout;
    bool isNotified = false;
    rtError_t devStatus = RT_ERROR_NONE;
    SetEventSyncTimeoutFlag(false);
    mmTimespec beginTimeSpec = mmGetTickCount();
    const uint64_t beginCnt = ((static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S) +
                               (static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS));

    if (device_ == nullptr) {
        isNotified = true;
    }
    Notifier* newNotifer = nullptr;
    int32_t streamId;
    uint32_t taskId;
    {
        const std::lock_guard<std::mutex> lock(eventLock_);
        RecordTaskInfo latestState = GetLatestRecord();
        streamId = latestState.streamId;
        taskId = latestState.taskId;
        if (latestState.state == RECORDED) {
            return RT_ERROR_NONE;
        }
        error = CreateEventNotifier(newNotifer);
        COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE), error,
                                    "Notifier create failed, stream_id=%d, task_id=%u, retCode=%#x",
                                    streamId, taskId, static_cast<uint32_t>(error));
        InsertToNotifierMap(static_cast<uint32_t>(streamId), static_cast<uint16_t>(taskId), newNotifer);
    }

    while (!isNotified) {
        int32_t irqWait = RT_REPORT_TIMEOUT_TIME; // default
        // default = 5000ms
        COND_PROC(remainTime > 0, (irqWait = (remainTime >= RT_REPORT_TIMEOUT_TIME) ?
            RT_REPORT_TIMEOUT_TIME : remainTime));
        error = NotifierSync(newNotifer, irqWait);
        if (error != RT_ERROR_REPORT_TIMEOUT) {
            break;
        }

        devStatus = device_->GetDevStatus();
        if (devStatus != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Task Wait: device status wrong, devStatus=%d, device_id=%u",
                devStatus, device_->Id_());
            error = devStatus;
            break;
        }

        if (timeout > 0) {
            mmTimespec endTimeSpec = mmGetTickCount();
            uint64_t endCnt = static_cast<uint64_t>((endTimeSpec.tv_sec * 1000UL) +
                                       (endTimeSpec.tv_nsec / RT_MS_TO_NS));
            uint64_t count = endCnt > beginCnt ? (endCnt - beginCnt) : 0ULL;
            int32_t spendTime = static_cast<int32_t>(count);
            remainTime = timeout > spendTime ? (timeout - spendTime) : 0;
            if (count >= static_cast<uint64_t>(timeout)) {
#ifndef CFG_DEV_PLATFORM_PC
                RT_LOG(RT_LOG_ERROR, "event sync timeout, time=%lums, timeout=%dms", count, timeout);
#endif
                SetEventSyncTimeoutFlag(true);
                error = RT_ERROR_EVENT_SYNC_TIMEOUT;
                break;
            }
        }
    }
    {
        const std::lock_guard<std::mutex> lock(eventLock_);
        DeleteFromNotifierMap(static_cast<uint32_t>(streamId), static_cast<uint16_t>(taskId));
    }
    return error;
}

rtError_t Event::Query(void) // not support query after reset
{
    rtError_t queryResult;
    if (Runtime::Instance()->GetDisableThread()) {
        const rtError_t error = ReclaimTask(false);
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<int32_t>(error));
    }
    RecordTaskInfo latestRecord = GetLatestRecord();
    // record(recording) , return RT_ERROR_NONE. record(recorded) return Not complete
    queryResult = (latestRecord.state == RECORDING) ? RT_ERROR_EVENT_NOT_COMPLETE : RT_ERROR_NONE;
    RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, latest state=%d, result=%d",
           device_->Id_(), eventId_, latestRecord.state, queryResult);
    return queryResult;
}

rtError_t Event::QueryEventStatus(rtEventStatus_t * const status)
{
    RecordTaskInfo latestRecord = GetLatestRecord();
    rtError_t error = RT_ERROR_NONE;
    // No record , newMode return RT_EVENT_RECORDED oldMode return RT_EVENT_INIT
    if (!HasRecord()) {
        RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d no record to be query, return recorded.",
               device_->Id_(), eventId_);
        *status = (isNewMode_) ? RT_EVENT_RECORDED : RT_EVENT_INIT;
        return error;
    }
    const bool isDisableThreadFlag = Runtime::Instance()->GetDisableThread();
    if (isDisableThreadFlag) {
        if (latestRecord.state != RECORDED) {
            error = QueryEventTask(status);
        } else {
            *status = RT_EVENT_RECORDED;
        }
    } else {
        *status = (latestRecord.state == RECORDING) ? RT_EVENT_INIT : RT_EVENT_RECORDED;
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, latest state=%d, status=%d",
           device_->Id_(), eventId_, latestRecord.state, *status);
    return error;
}

rtError_t Event::QueryEventWaitStatus(const bool disableThread, bool &waitFlag)
{
    const std::lock_guard<std::mutex> queryLock(taskMapMutex_);
    waitFlag = true;
    if (IsEventWithoutWaitTask() || waitTaskMap_.empty()) {
        RT_LOG(RT_LOG_INFO, "waitTaskNum=%u, flag=%" PRIu64 "", waitTaskMap_.size(), eventFlag_);
        return RT_ERROR_NONE;
    }
    if (!disableThread) { // !disableThread not support QueryCqShm
        waitFlag = false;
    } else {
        for (auto &waitMapItem : waitTaskMap_) {
            Stream * const stm = waitMapItem.second.first;
            waitFlag = false;
            const rtError_t error = stm->QueryWaitTask(waitFlag, waitMapItem.second.second);
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query wait status failed, "
            "device_id=%u, retCode=%#x.", device_->Id_(), static_cast<uint32_t>(error));
            if (!waitFlag) {
                RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, not complete wait stream_id=%d, task_id=%hu",
                       device_->Id_(), eventId_, stm->Id_(), waitMapItem.second.second);
                break;
            }
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Event::ElapsedTime(float32_t * const timeInterval, Event * const base)
{
    if ((!HasRecord()) || (!base->HasRecord())) {
        return RT_ERROR_EVENT_RECORDER_NULL;
    }

    uint64_t curNs;
    uint64_t baseNs;
    if (Runtime::Instance()->GetDisableThread() && (!Runtime::Instance()->ChipIsHaveStars())) {
        UpdateTimeline();
        curNs = Timeline_();
        base->UpdateTimeline();
        baseNs = base->Timeline_();
    } else {
        curNs = TimeStamp();
        baseNs = base->TimeStamp();
    }

    if ((curNs == UINT64_MAX) || (baseNs == UINT64_MAX)) {
        RT_LOG(RT_LOG_ERROR, "curNs=%#" PRIx64 ", baseNs=%#" PRIx64 ", curEventId=%d, baseEventId=%d.",
            curNs, baseNs, eventId_, base->EventId_());
        return RT_ERROR_EVENT_TIMESTAMP_INVALID;
    }

    float32_t freq = device_->GetDevProperties().eventTimestampFreq;
    RT_LOG(RT_LOG_INFO, "curNs=%#" PRIx64 ", baseNs=%#" PRIx64 ", curEventId=%d, baseEventId=%d.",
        curNs, baseNs, eventId_, base->EventId_());
    *timeInterval =
        static_cast<float32_t>((static_cast<float64_t>(curNs) - static_cast<float64_t>(baseNs)) / freq);

    return RT_ERROR_NONE;
}

rtError_t Event::WaitForBusy()
{
    rtError_t error = RT_ERROR_NONE;
    const Runtime * const rtInstance = Runtime::Instance();
    while (!IsEventTaskEmpty() || !idMap_.empty()) {
        if (rtInstance->GetDisableThread()) {
            error = ReclaimTask(true);
            if (error != RT_ERROR_NONE) {
                return error;
            }
        } else {
            error = GetFailureStatus();
            if (error != RT_ERROR_NONE) {
                return error;
            }
        }
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d finished map already empty.", device_->Id_(), eventId_);
    return error;
}

rtError_t Event::GetTimeStamp(uint64_t * const recTimestamp)
{
    if (!HasRecord()) {
        return RT_ERROR_EVENT_RECORDER_NULL;
    }
    UpdateTimeline();
    const uint64_t curUs = (Runtime::Instance()->GetDisableThread() && (!Runtime::Instance()->ChipIsHaveStars())) ?
        Timeline_() : TimeStamp();
    if (curUs == UINT64_MAX) {
        return RT_ERROR_EVENT_TIMESTAMP_INVALID;
    }
    float32_t freq = device_->GetDevProperties().eventTimestampFreq;
    *recTimestamp = curUs / (static_cast<uint64_t>(freq) / 1000U);
    RT_LOG(RT_LOG_DEBUG, "event_id=%d, timeline=%" PRIu64 ".", eventId_, *recTimestamp);
    return RT_ERROR_NONE;
}

rtError_t Event::ClearRecordStatus()
{
    latestRecord_.streamId = -1;
    latestRecord_.taskId = UINT32_MAX;
    latestRecord_.state = INIT;
    freeEventId_ = INVALID_EVENT_ID;
    timestamp_ = UINT64_MAX;
    timeline_ = UINT64_MAX;
    SetRecord(false);
    SetIsNeedDestroy(false);
    SetHasReset(false);
    return RT_ERROR_NONE;
}

bool Event::IsRecordOrigCaptureStream(const Stream * const stm) const
{
    for (Stream * const obj : waitTskStreamList_) {
        if (obj->Id_() == stm->Id_()) {
            continue;
        }
        if (obj->IsOrigCaptureStream()) {
            return true;
        }
    }
    return false;
}

CaptureModel *Event::GetCaptureModel(void) const
{
    if (captureEvent_ != nullptr) {
        const Stream * const stm = captureEvent_->GetCaptureStream();
        if (stm != nullptr) {
            return dynamic_cast<CaptureModel *>(stm->Model_());
        }
    }
    return nullptr;
}

bool Event::IsCapturing() const
{
    if (eventFlag_ == RT_EVENT_EXTERNAL) {
        return false;
    }
    const CaptureModel * const mdl = GetCaptureModel();
    return ((mdl != nullptr) && (mdl->IsCapturing()));
}

bool Event::ToBeCaptured(const Stream * const stm) const
{
    if (eventFlag_ == RT_EVENT_EXTERNAL) {
        return false;
    }
    const Stream *captureStm = stm->GetCaptureStream();
    if (captureStm != nullptr) {
        const CaptureModel * const mdl = dynamic_cast<CaptureModel *>(captureStm->Model_());
        if ((mdl != nullptr) && (mdl->IsCapturing())) {
            return true;
        }
    }
    return false;
}

}
}
