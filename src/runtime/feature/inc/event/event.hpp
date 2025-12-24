/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_EVENT_HPP
#define CCE_RUNTIME_EVENT_HPP

#include <set>
#include <string>
#include <utility>
#include <unordered_map>
#include "reference.hpp"
#include "context.hpp"
#include "device.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {
class Stream;
class Context;
class Device;
class Notifier;
class CaptureModel;
class EventRecordTask;

constexpr int32_t INVALID_EVENT_ID = -1;
constexpr int32_t TIMELINE_EVENT_ID = 1023;
constexpr uint32_t RT_EVENT_FLAG_MAX = (RT_EVENT_DDSYNC_NS | RT_EVENT_STREAM_MARK | RT_EVENT_DDSYNC |
                                        RT_EVENT_TIME_LINE | RT_EVENT_MC2 | RT_EVENT_EXTERNAL);
constexpr uint32_t MEM_WAIT_SPLIT_SIZE = 512U;

enum rtEventState_t {
    INIT,
    RECORDING,
    RECORDED,
};

struct RecordTaskInfo {
    int32_t streamId;
    uint32_t taskId;
    rtEventState_t state;
};

class Event : public NoCopy {
public:
    Event();
    Event(Device *device, uint64_t eventFlag, Context *ctx, bool isSync = false, bool isNewMode = false);
    ~Event() noexcept override;

    // interface for api_imp
    virtual rtError_t GenEventId();
    virtual rtError_t GetEventID(uint32_t * const evtId) const;
    virtual rtError_t ReAllocId();
    rtError_t Record(Stream * const stm, const bool isApiCall = false);
    rtError_t Wait(Stream * const stm, const uint32_t timeout);
    rtError_t Reset(Stream * const stm);
    virtual rtError_t Query(void);
    virtual rtError_t QueryEventStatus(rtEventStatus_t * const status);
    virtual rtError_t QueryEventWaitStatus(const bool disableThread, bool &waitFlag);
    virtual rtError_t Synchronize(int32_t timeout = -1);
    virtual rtError_t ElapsedTime(float32_t * const timeInterval, Event * const base);
    virtual rtError_t GetTimeStamp(uint64_t * const recTimestamp);

    // tools for api_imp interface
    virtual rtError_t QueryEventTask(rtEventStatus_t * const status);
    virtual rtError_t Setup();
    rtError_t WaitForBusy();
    virtual rtError_t ReclaimTask(const bool evtWaitTask);
    rtError_t GetFailureStatus();
    void RecordComplete(TaskInfo * const tsk, const uint64_t recTimestamp, const uint64_t recTimeline);
    void UpdateTimeline();
    virtual rtError_t WaitTask(const int32_t timeout);

    // for notifier special interface
    rtError_t NotifierSync(Notifier* notifier, int32_t timeout);
    rtError_t CreateEventNotifier(Notifier* &notifier);
    rtError_t RecordForNotify(Stream * const stm);
    // tools for task map
    bool IsEventTaskEmpty();
    void InsertWaitToMap(TaskInfo *tsk);
    void DeleteWaitFromMap(TaskInfo *tsk);
    void InsertRecordResetToMap(TaskInfo *tsk);
    void DeleteRecordResetFromMap(TaskInfo *tsk);
    void UpdateLatestRecord(RecordTaskInfo &latestRecord, const int32_t newEventId = INVALID_EVENT_ID,
        const uint64_t timeLine = UINT64_MAX, const uint64_t timeStamp = UINT64_MAX);
    virtual bool WaitSendCheck(const Stream * const stm, int32_t &eventId);
    rtError_t AllocEventIdResource(const Stream * const stm, int32_t &newEventId) const;
    void InitEventAllocFlag(int32_t streamId = -1);
    rtError_t CaptureEventProcess(Stream * const stm);
    rtError_t CaptureWaitProcess(Stream * const stm);
    rtError_t CaptureResetProcess(Stream * const stm);
    // simple tools for access private.
    void SetName(const char_t *name)
    {
        if (name != nullptr) {
            (void)name_.assign(name);
        }
    }
    const char_t *Name_() const
    {
        return name_.c_str();
    }
    uint64_t Timeline_() const {
        return timeline_;
    }
    uint64_t TimeStamp() const {
        return timestamp_;
    }
    void SetTimeStamp(uint64_t timestamp)
    {
        timestamp_ = timestamp;
    }
    virtual uint64_t GetEventFlag() const {
        return eventFlag_;
    }
    int32_t EventId_() const {
        return eventId_;
    }
    void SetEventId(int32_t newEventId) {
        eventId_ = newEventId;
    }
    RecordTaskInfo GetLatestRecord() {
        const std::lock_guard<std::mutex> latestStateLock(recordStateMutex_);
        return latestRecord_;
    }
    void SetEventSyncTimeoutFlag(const bool isTimeout)
    {
        isEventSyncTimeout_ = isTimeout;
    }
    virtual bool IsEventWithoutWaitTask() const {
        return (((eventFlag_ & (RT_EVENT_DDSYNC | RT_EVENT_DDSYNC_NS | RT_EVENT_EXTERNAL | RT_EVENT_IPC)) == 0U));
    }
    bool IsNotify() const {
        return isNotify_;
    }
    bool GetSyncFlag() const
    {
        return isSync_.Value();
    }
    bool HasRecord() const
    {
        return hasRecord_.Value();
    }
    void SetRecord(bool flag)
    {
        return hasRecord_.Set(flag);
    }
    bool HasReset() const
    {
        return hasReset_.Value();
    }
    void SetHasReset(bool flag)
    {
        return hasReset_.Set(flag);
    }
    bool IsNewMode() const {
        return isNewMode_;
    }
	bool IsIdAllocFromDrv() const
    {
        return isIdAllocFromDrv_;
    }
    void SetDestroySync(bool flag) {
        isDestroySync_ = flag;
    }
    bool GetDestroySync() const {
        return isDestroySync_;
    }
    void EventIdCountAdd(const int32_t id) {
        const std::lock_guard<std::mutex> lock(idMapMutex_);
        if (idMap_.find(id) != idMap_.end()) {
            idMap_[id]++;
        } else {
            idMap_[id] = 1;
        }
    }
	void SetRecordPos(uint16_t pos)
    {
        recordPos_ = pos;
    }

    std::mutex &GetWaitStmLock()
    {
        return waitStmMutex_;
    }

    void EventIdCountSub(const int32_t id, bool isFreeId = false);
    virtual void TryFreeLastEventId();
    virtual bool TryFreeEventIdAndCheckCanBeDelete(const int32_t id, bool isNeedDestroy);
    virtual void SetIsNeedDestroy(bool flag) {
        isNeedDestroy_.Set(flag);
    }
    Notifier* FindFromNotifierMap(uint32_t streamId, uint16_t taskId);
    void InsertToNotifierMap(uint32_t streamId, uint16_t taskId, Notifier *value);
    void DeleteFromNotifierMap(uint32_t streamId, uint16_t taskId);
    void RefreshEventId(int32_t eventid);
    virtual rtError_t ClearRecordStatus();
    virtual Device *Device_() const
    {
        return device_;
    }
    virtual Context *Context_() const
    {
        return context_;
    }
    void SetCaptureEvent(Event *captureEvt)
    {
        captureEvent_ = captureEvt;
    }
    Event *GetCaptureEvent(void) const
    {
        return captureEvent_;
    }
    void SetCaptureStream(Stream * const stream)
    {
        captureStream_ = stream;
    }
    Stream *GetCaptureStream(void) const
    {
        return captureStream_;
    }
    std::mutex &GetCaptureMutex(void) {
        return captureMutex_;
    }

    bool IsCaptureStreamWaited(void) const
    {
        /* 经与SE确认, 不考虑Event在同一条流上先下wait后下record的情况 */
        return waitTskStreamList_.size();
    }

    void InsertWaitTaskStream(Stream * const stm)
    {
        const std::lock_guard<std::mutex> lock(waitStmMutex_);
        waitTskStreamList_.insert(stm);
    }

    std::set<Stream *> &GetWaitStreamList()
    {
        return waitTskStreamList_;
    }

    CaptureModel *GetCaptureModel(void) const;
    bool IsCapturing() const;
    bool IsRecordOrigCaptureStream(const Stream * const stm) const;
    bool ToBeCaptured(const Stream * const stm) const;

protected:
    Device           *device_;
    RecordTaskInfo   latestRecord_;
    Atomic<bool>     isNeedDestroy_;
    int32_t          eventId_;
    uint16_t         recordPos_;
    uint64_t         eventFlag_;
    uint64_t         timestamp_;
    bool             isNewMode_;
    std::unordered_map<TaskInfo *, std::pair<Stream*, uint32_t>> waitTaskMap_;
    std::unordered_map<TaskInfo *, std::pair<Stream*, uint32_t>> recordResetMap_;
    std::mutex       eventLock_;
    std::mutex       eventLockForRecord_;
    std::mutex       idMapMutex_;
    std::mutex       recordStateMutex_;
    std::mutex       taskMapMutex_;
    std::mutex       initMutex_;
    Context          *context_;

private:
    int32_t          freeEventId_;
    uint64_t         timeline_;
    bool             isNotify_;
    bool             isEventSyncTimeout_;
    bool             isIdAllocFromDrv_;
    Atomic<bool>     isSync_;
    Atomic<bool>     hasRecord_;
    std::string      name_;
    Atomic<bool>     hasReset_;
    bool             isDestroySync_;
    Event            *captureEvent_{nullptr};   // only for single-operator event
    Stream           *captureStream_{nullptr};  // only for capture event
    std::set<Stream *> waitTskStreamList_;      // only for capture event
    std::mutex captureMutex_;
    std::mutex waitStmMutex_;
    std::unordered_map<int32_t, uint32_t> idMap_;
    std::unordered_map<uint32_t, Notifier *> notifierMap_;
};
}
}

#endif  // CCE_RUNTIME_EVENT_HPP
