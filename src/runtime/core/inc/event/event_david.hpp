/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_EVENT_DAVID_HPP
#define CCE_RUNTIME_EVENT_DAVID_HPP

#include <string>
#include <atomic>
#include <shared_mutex>
#include "event.hpp"

namespace cce {
namespace runtime {

class CntNotifyRes;

enum class DavidEventState_t : uint8_t {
    EVT_NOT_RECORDED,
    EVT_RECORDED,
};

struct DavidRecordTaskInfo {
    int32_t streamId;
    uint32_t taskId;
    uint64_t expectCqeNo{0ULL};
};

class DavidEvent : public Event {
public:
    DavidEvent(Device* device, uint64_t eventFlag, Context* ctx, bool isNewMode = false);
    ~DavidEvent() noexcept override;
    rtError_t Query(void) override;
    rtError_t QueryEventStatus(rtEventStatus_t* const status) override;
    rtError_t QueryEventWaitStatus(const bool disableThread, bool& waitFlag) override;
    rtError_t Synchronize(int32_t timeout = -1) override;
    rtError_t ElapsedTime(float32_t* const timeInterval, Event* const base) override;
    rtError_t GetTimeStamp(uint64_t* const recTimestamp) override;
    rtError_t QueryEventTask(rtEventStatus_t* const status) override;
    rtError_t WaitTask(const int32_t timeout) override;
    rtError_t ReclaimTask(const bool evtWaitTask) override;
    void RecordComplete(
        TaskInfo* const tsk, const uint64_t recTimestamp, const uint64_t recTimeline,
        const uint64_t cqeNo = 0ULL) override;
    void PublishSoftwareRecordResource(
        void* const eventAddr, int32_t eventId, int32_t streamId, uint32_t taskId, uint64_t cqeNo) override;
    bool WaitSendCheck(const Stream* const stm, int32_t& eventId) override;
    bool TryFreeEventIdAndCheckCanBeDelete(const int32_t id, bool isNeedDestroy) override;
    bool DavidUpdateRecordMapAndDestroyEvent(TaskInfo* taskInfo);
    bool DavidUpdateWaitMapAndDestroyEvent(TaskInfo* taskInfo);
    rtError_t ClearRecordStatus() override;
    rtError_t AllocEventIdResource(Stream* const stm, int32_t& newEventId) override;
    void UpdateLatestRecord(
        const DavidRecordTaskInfo& recordInfo, const DavidEventState_t latestStatus, const uint64_t timeStamp,
        const int32_t newEventId = INVALID_EVENT_ID, void* const newEventAddr = nullptr);
    uint64_t ExpectCqeNo_() const override;
    rtError_t GenEventId() override;
    bool IsEventInModel() override;
    rtError_t ReAllocId() override;
    bool IsEventWithoutWaitTask() const override
    {
        return (
            ((eventFlag_ & (RT_EVENT_DDSYNC | RT_EVENT_DDSYNC_NS | RT_EVENT_MC2 | RT_EVENT_EXTERNAL | RT_EVENT_IPC)) ==
             0U));
    }
    bool IsCntNotify() const { return isCntNotify_; }
    uint32_t CntValue() const { return cntValue_; }
    void SetCntValue(uint32_t val) { cntValue_ = val; }
    // 仅只读/UT 使用
    CntNotifyRes* GetCntNotifyRes() const { return cntRes_.load(std::memory_order_acquire); }
    // 锁内读取当前绑定资源并持有一份任务引用，供 wait/reset 任务 SQE 构造使用；
    // 事件之后换绑/销毁都不影响该任务对旧资源的引用
    CntNotifyRes* AcquireTaskRef();
    void SetRecordStatus(DavidEventState_t status) { status_ = status; }
    DavidEventState_t GetRecordStatus() const { return status_; }
    void SetLatestRecordInfo(uint32_t taskId, int32_t stmId, uint64_t expectCqeNo = 0ULL)
    {
        latestRecordTask_.taskId = taskId;
        latestRecordTask_.streamId = stmId;
        latestRecordTask_.expectCqeNo = expectCqeNo;
    }
    DavidRecordTaskInfo GetLatestRecordInfo() { return latestRecordTask_; }

private:
    bool isCntNotify_{false};
    uint32_t cntValue_{0U};
    DavidEventState_t status_;
    DavidRecordTaskInfo latestRecordTask_{0, 0U, 0ULL};
    std::atomic<CntNotifyRes*> cntRes_{nullptr}; // 当前绑定的计数通知资源（count-notify 模式）
    std::shared_mutex cntResMutex_;              // 换绑/析构独占写；wait/reset 任务取引用共享读
};
} // namespace runtime
} // namespace cce
#endif // CCE_RUNTIME_EVENT_DAVID_HPP
