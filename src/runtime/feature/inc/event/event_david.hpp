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
#include "event.hpp"

namespace cce {
namespace runtime {

enum class DavidEventState_t : uint8_t {
    EVT_NOT_RECORDED,
    EVT_RECORDED,
};

struct DavidRecordTaskInfo {
    int32_t streamId;
    uint32_t taskId;
};

class DavidEvent : public Event {
public:
    DavidEvent(Device *device, uint64_t eventFlag, Context *ctx, bool isNewMode = false);
    ~DavidEvent() noexcept override;
    rtError_t Query(void) override;
    rtError_t QueryEventStatus(rtEventStatus_t * const status) override;
    rtError_t QueryEventWaitStatus(const bool disableThread, bool &waitFlag) override;
    rtError_t Synchronize(int32_t timeout = -1) override;
    rtError_t ElapsedTime(float32_t * const timeInterval, Event * const base) override;
    rtError_t GetTimeStamp(uint64_t * const recTimestamp) override;
    rtError_t QueryEventTask(rtEventStatus_t * const status) override;
    rtError_t WaitTask(const int32_t timeout) override;
    rtError_t ReclaimTask(const bool evtWaitTask) override;
    void RecordDavidEventComplete(const TaskInfo * const tsk, const uint64_t recTimestamp);
    bool WaitSendCheck(const Stream * const stm, int32_t &eventId) override;
    bool TryFreeEventIdAndCheckCanBeDelete(const int32_t id, bool isNeedDestroy) override;
    bool DavidUpdateRecordMapAndDestroyEvent(TaskInfo *taskInfo);
    bool DavidUpdateWaitMapAndDestroyEvent(TaskInfo *taskInfo);
    rtError_t ClearRecordStatus() override;
    rtError_t AllocEventIdResource(Stream * const stm, int32_t &eventId);
    void UpdateLatestRecord(const DavidRecordTaskInfo &recordInfo, const DavidEventState_t latestStatus,
        const uint64_t timeStamp);
    rtError_t GenEventId() override;
    bool IsEventWithoutWaitTask() const override {
        return (((eventFlag_ & (RT_EVENT_DDSYNC | RT_EVENT_DDSYNC_NS | RT_EVENT_MC2 | RT_EVENT_EXTERNAL)) == 0U));
    }
    bool IsCntNotify() const
    {
        return isCntNotify_;
    }
    uint32_t CntValue() const
    {
        return cntValue_;
    }
    void SetCntValue(uint32_t val)
    {
        cntValue_ = val;
    }
    void SetRecordStatus(DavidEventState_t status)
    {
        status_ = status;
    }
    DavidEventState_t GetRecordStatus() const
    {
        return status_;
    }
    void SetLatestRecordInfo(uint32_t taskId, int32_t stmId)
    {
        latestRecordTask_.taskId = taskId;
        latestRecordTask_.streamId = stmId;
    }
    DavidRecordTaskInfo GetLatestRecordInfo()
    {
        return latestRecordTask_;
    }

private:
    bool              isCntNotify_{false};
    uint32_t          cntValue_{0U};
    DavidEventState_t status_;
    DavidRecordTaskInfo latestRecordTask_{0, 0U};
};
}
}
#endif  // CCE_RUNTIME_EVENT_DAVID_HPP
