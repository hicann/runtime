/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_QUEUE_SCHEDULE_H
#define QUEUE_SCHEDULE_QUEUE_SCHEDULE_H

#include <vector>
#include <thread>
#include <atomic>
#include <set>
#include <string>
#include <condition_variable>
#include "driver/ascend_hal.h"
#include "common/bqs_status.h"
#include "common/bqs_msg.h"
#include "bind_relation.h"
namespace bqs {
class QueueSchedule {
public:
    /**
     * QueueSchedule construct.
     * @param deviceId device chip id.
     * @param enqueGroupId enqueue group id.
     * @param f2nfGroupId full to not full group id.
     */
    explicit QueueSchedule(const InitQsParams &params) : deviceId_(params.deviceId),
                                                         enqueGroupId_(params.enqueGroupId),
                                                         f2nfGroupId_(params.f2nfGroupId),
                                                         running_(false),
                                                         hasAICPU_(true),
                                                         isZeroSizeAicpuNum_(false),
                                                         reschedInterval_(params.reschedInterval),
                                                         runMode_(params.runMode),
                                                         qsInitGroupName_(params.qsInitGrpName),
                                                         initQsParams_(params),
                                                         abnormalInterval_(0U)                                                   
    {}

    ~QueueSchedule();

    QueueSchedule(const QueueSchedule &) = delete;

    QueueSchedule &operator=(const QueueSchedule &) = delete;

    QueueSchedule(QueueSchedule &&) = delete;

    QueueSchedule &operator=(QueueSchedule &&) = delete;

public:
    /**
     * Init and start working.
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus StartQueueSchedule();

    /* *
     * stop working.
     */
    void StopQueueSchedule();

    /**
     * destroy source.
     */
    void Destroy() const;

    /**
     * enqueue event working thread function
     * @param threadIndex: thread index
     * @param bindCpuIndex: bind cpu index
     * @param groupId: wait event group
     */
    void EnqueueThreadTask(const uint32_t deviceId, const uint32_t threadIndex, const uint32_t bindCpuIndex,
                           const uint32_t groupId, const uint32_t index);

    /**
     * full to not full working thread function
     * @param threadIndex: thread index
     * @param bindCpuIndex: bind cpu index
     * @param groupId: wait event group
     */
    void F2NFThreadTask(const uint32_t threadIndex, const uint32_t bindCpuIndex, const uint32_t groupId);

    /**
     * daemon thread run function
     */
    void DaemonThreadTask(const uint32_t index);

    /**
     * wait for stop.
     */
    void WaitForStop();

    void ReportAbnormal() const;
private:
    /**
     * handle enqueue event.
     * @param threadIndex thread index
     * @param event event
     */
    void ProcessEnqueueEvent(const uint32_t threadIndex, const event_info &event, const uint32_t index = 0U,
        const bool procF2NF = false);

    /**
     * process enqueue event loop.
     * @param threadIndex thread index
     * @param groupId groupId
     */
    void LoopProcessEnqueueEvent(const uint32_t threadIndex, const uint32_t deviceId, const uint32_t groupId,
                                 const uint32_t index);

    /**
     * start enqueue thread.
     * @param threadNum thread total num
     * @param aicpuBeginIndex begin index
     */
    BqsStatus StartThreadGroup(const uint32_t threadNum, const uint32_t deviceId, const uint32_t enqueGroupId,
                               const uint32_t index);

    /**
     * start enqueue thread.
     * @param threadIndex thread id
     * @param bindCpuIndex cpu index
     */
    void BindAicpu(const uint32_t threadIndex, const uint32_t bindCpuIndex);

    /**
     * handle enqueue event in daemon thread
     */
    void DaemonEnqueueEvent(const uint32_t index);

    /**
     * schedule data buff for all queue.
     * @param dataEnqueue true means data enqueue, false means relation or f2nf enqueue
     */
    void ScheduleDataBuffAll(const bool dataEnqueue, const uint32_t index = 0U) const;

    /**
     * process full entity
     * @param entity entity
     */
    dgw::FsmStatus ProcessDstEntity(const EntityInfo &entity, const uint32_t index) const;

    /**
     * init drv event scheduler.
     * @return BQS_STATUS_OK: success, other: error
     */
    BqsStatus InitDrvSchedModule(const uint32_t deviceId, const uint32_t enqueGroupId,
        const uint32_t f2nfGroupId) const;

    /**
     * process event
     * @param event esched event info
     */
    BqsStatus ProcessEvent(const uint32_t threadIndex, event_info &event, const uint32_t index);

    void CheckIfRecover(uint32_t &errCount, const char_t * const identity, const uint32_t threadIndex,
        const uint32_t groupId) const;

    void DynamicSchedule(const uint32_t index) const;

    void ProcessFullToNotFullEvent(const uint32_t index);

    BqsStatus InitExtraSchedule(const std::set<uint32_t> &resDevids, uint32_t threadNum);

    /**
     * device chip id.
     */
    uint32_t deviceId_;

    /**
     * enqueue event group id.
     */
    uint32_t enqueGroupId_;

    /**
     * full to not full event group id.
     */
    uint32_t f2nfGroupId_;

    /**
     * thread run flag.
     */
    volatile bool running_;

    /**
     * daemon thread sleep for a while.
     */
    std::condition_variable daemonWait_;

    /**
     * run on aicpu flag.
     */
    bool hasAICPU_;

    /**
     * run on aicpu flag.
     */
    bool isZeroSizeAicpuNum_;

    /**
     * working threads.
     */
    std::vector<std::thread> workThreads_;

    /**
     * enqueue event working mutual exclusion
     */
    std::atomic_flag queueEventAtomicFlag_ = ATOMIC_FLAG_INIT;

    std::atomic_flag queueEventAtomicFlagExtra_ = ATOMIC_FLAG_INIT;

    /**
     * daemon threads wait mtx.
     */
    std::mutex daemonWaitMtx_;

    /**
     * daemon threads reschedule interval
     */
    uint32_t reschedInterval_;

    /**
     * qs run mode
     */
    bqs::QueueSchedulerRunMode runMode_;

    /**
     * group name send by tsd used for qs to attach when start
     */
    std::string qsInitGroupName_;

    /**
     * queue schedule initialization parameters
     */
    InitQsParams initQsParams_;

    /**
     * f2nf event working mutual exclusion
     */
    std::atomic_flag f2nfEventAtomicFlag_ = ATOMIC_FLAG_INIT;

    bool aicpuFeatureDisableRecvRequestEvent_ {false};

    bool aicpuFeatureSetPidPriority_ {false};

    uint32_t abnormalInterval_;
};
} // namespace bqs
#endif // QUEUE_SCHEDULE_QUEUE_SCHEDULE_H
