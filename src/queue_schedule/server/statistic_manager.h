/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_STATISTIC_MANAGER_H
#define QUEUE_SCHEDULE_STATISTIC_MANAGER_H

#include <atomic>
#include <thread>
#include <mutex>
#include <condition_variable>

#include "common/type_def.h"
#include "qs_proc_mem_statistic.h"

namespace bqs {
struct EntityStatisticInfo {
    // call HcclImprobe total times (envelope-probed + non-envelope-probed + failed times)
    uint64_t hcclImprobeTotalTimes;
    // call HcclImprobe succ times (envelope-probed times)
    uint64_t hcclImprobeSuccTimes;
    // call HcclImprobe failed times
    uint64_t hcclImprobeFailTimes;
    // alloc mbuf times
    uint64_t allocMbufTimes;
    // call HcclImrecv succ times
    uint64_t hcclImrecvSuccTimes;
    // call HcclImrecv failed times
    uint64_t hcclImrecvFailTimes;
    // uncompReqQueue push times
    uint64_t uncompReqQueuePushTimes;
    // uncompReqQueue pop times
    uint64_t uncompReqQueuePopTimes;
    // call HcclIsend succ times
    uint64_t hcclIsendSuccTimes;
    // call HcclIsend full times
    uint64_t hcclIsendFullTimes;
    // call HcclIsend fail times
    uint64_t hcclIsendFailTimes;
    // call HcclTestSome succ times
    uint64_t hcclTestSomeSuccTimes;
    // free mbuf times (hccl send succ)
    uint64_t freeMbufTimes;
    // hccl enqueue succ times
    uint64_t hcclEnqueueSuccTimes;
    // hccl dequeue fail times
    uint64_t hcclEnqueueFailTimes;
    // tag or queue dequeue succ times in peek state
    uint64_t dequeueSuccTimes;
    // tag or queue dequeue fail times in peek state
    uint64_t dequeueFailTimes;
    // tag or queue dequeue empty times in peek state
    uint64_t dequeueEmptyTimes;
    // statistic for head transfering on tag
    uint64_t maxCompletionGapTickForHead;
    uint64_t minCompletionGapTickForHead;
    uint64_t totalCompletionGapTickForHead;
    uint64_t totalCompletionCountForHead;
    // statistic for body transfering on tag
    uint64_t maxCompletionGapTickForBody;
    uint64_t minCompletionGapTickForBody;
    uint64_t totalCompletionGapTickForBody;
    uint64_t totalCompletionCountForBody;
    // tag or queue enqueue succ times in peek state
    uint64_t enqueueSuccTimes;

    EntityStatisticInfo()
        : hcclImprobeTotalTimes(0UL),
          hcclImprobeSuccTimes(0UL),
          hcclImprobeFailTimes(0UL),
          allocMbufTimes(0UL),
          hcclImrecvSuccTimes(0UL),
          hcclImrecvFailTimes(0UL),
          uncompReqQueuePushTimes(0UL),
          uncompReqQueuePopTimes(0UL),
          hcclIsendSuccTimes(0UL),
          hcclIsendFullTimes(0UL),
          hcclIsendFailTimes(0UL),
          hcclTestSomeSuccTimes(0UL),
          freeMbufTimes(0UL),
          hcclEnqueueSuccTimes(0UL),
          hcclEnqueueFailTimes(0UL),
          dequeueSuccTimes(0UL),
          dequeueFailTimes(0UL),
          dequeueEmptyTimes(0UL),
          maxCompletionGapTickForHead(0UL),
          minCompletionGapTickForHead(0UL),
          totalCompletionGapTickForHead(0UL),
          totalCompletionCountForHead(0UL),
          maxCompletionGapTickForBody(0UL),
          minCompletionGapTickForBody(0UL),
          totalCompletionGapTickForBody(0UL),
          totalCompletionCountForBody(0UL),
          enqueueSuccTimes(0UL) {}
};

struct StatisticInfo {
    // event schedule times
    std::atomic<uint64_t> eventScheduleTimes;
    // enqueue event false waken times
    std::atomic<uint64_t> enqueueFalseAwakenTimes;
    // event schedule times
    std::atomic<uint64_t> daemonEventScheduleTimes;
    // awaken times
    std::atomic<uint64_t> awakenTimes;
    // data dequeue times
    std::atomic<uint64_t> dataDequeueTimes;
    // sched empty times
    std::atomic<uint64_t> scheduleEmptyTimes;
    // data schedule failed times
    std::atomic<uint64_t> dataScheduleFailedTimes;
    // relation queue enqueue times
    std::atomic<uint64_t> relationEnqueueTimes;
    // relation queue dequeue times
    std::atomic<uint64_t> relationDequeueTimes;
    // async mem queue enqueue times
    std::atomic<uint64_t> asynMemEnqueueTimes;
    // async mem queue dequeue times
    std::atomic<uint64_t> asynMemDequeueTimes;
    // full ot not full queue enqueue times
    std::atomic<uint64_t> f2nfEnqueueTimes;
    // full ot not full queue dequeue times
    std::atomic<uint64_t> f2nfDequeueTimes;
    // bind relation request times
    std::atomic<uint64_t> bindTimes;
    // unbind relation request times
    std::atomic<uint64_t> unbindTimes;
    // get bind relation request times
    std::atomic<uint64_t> getBindTimes;
    // get all bind relation request times
    std::atomic<uint64_t> getAllBindTimes;
    // relation response times
    std::atomic<uint64_t> responseTimes;
    // enqueue success times
    std::atomic<uint64_t> dataEnqueueSuccTimes;
    // enqueue fail times
    std::atomic<uint64_t> dataEnqueueFailTimes;
    // enqueue full times
    std::atomic<uint64_t> dataEnqueueFullTimes;
    // hccl mpi recv request event times
    std::atomic<uint64_t> hcclMpiRecvRequestEventTimes;
    // hccl mpi recv request event false awaken times
    std::atomic<uint64_t> hcclMpiRecvReqFalseAwakenTimes;
    // hccl mpi recv request event empty sched times
    std::atomic<uint64_t> hcclMpiRecvReqEmptySchedTimes;
    // hccl mpi recv request event callback times
    std::atomic<uint64_t> hcclMpiRecvReqCallbackTimes;
    // hccl mpi send completion event times
    std::atomic<uint64_t> hcclMpiSendCompEventTimes;
    // hccl mpi send completion event false awaken times
    std::atomic<uint64_t> hcclMpiSendCompFalseAwakenTimes;
    // hccl mpi send completion event empty sched times
    std::atomic<uint64_t> hcclMpiSendCompEmptySchedTimes;
    // hccl mpi recv request event callback times
    std::atomic<uint64_t> hcclMpiSendCompCallbackTimes;
    // hccl mpi recv completion event times
    std::atomic<uint64_t> hcclMpiRecvCompEventTimes;
    // hccl mpi recv completion event false awaken times
    std::atomic<uint64_t> hcclMpiRecvCompFalseAwakenTimes;
    // hccl mpi recv completion event empty sched times
    std::atomic<uint64_t> hcclMpiRecvCompEmptySchedTimes;
    // hccl mpi recv completion event callback times
    std::atomic<uint64_t> hcclMpiRecvCompCallbackTimes;
    // f2nf event times
    std::atomic<uint64_t> f2nfEventTimes;
    // f2nf event false awaken times
    std::atomic<uint64_t> f2nfFalseAwakenTimes;
    // hccl mpi call recv success times
    std::atomic<uint64_t> hcclMpiRecvSuccTimes;
    // hccl mpi call recv failed taimes
    std::atomic<uint64_t> hcclMpiRecvFailTimes;
    // hccl mpi call send success times
    std::atomic<uint64_t> hcclMpiSendSuccTimes;
    // hccl mpi call send failed taimes
    std::atomic<uint64_t> hcclMpiSendFailTimes;
    // hccl mpi call send full taimes
    std::atomic<uint64_t> hcclMpiSendFullTimes;
    // hccl mpi congestion relief event times
    std::atomic<uint64_t> hcclMpiF2nfEventTimes;
    // mbuf alloc size
    std::atomic<uint64_t> mbufAllocSize;
    // mbuf alloc times
    std::atomic<uint64_t> mbufAllocTimes;
    // mbuf free size
    std::atomic<uint64_t> mbufFreeSize;
    // mbuf free times
    std::atomic<uint64_t> mbufFreeTimes;
    // supply recv request event times
    std::atomic<uint64_t> supplyRecvReqEventTimes;

    StatisticInfo()
    {
        Reset();
    }

    void Reset()
    {
        eventScheduleTimes.store(0UL);
        enqueueFalseAwakenTimes.store(0UL);
        daemonEventScheduleTimes.store(0UL);
        awakenTimes.store(0UL);
        dataDequeueTimes.store(0UL);
        scheduleEmptyTimes.store(0UL);
        dataScheduleFailedTimes.store(0UL);
        relationEnqueueTimes.store(0UL);
        relationDequeueTimes.store(0UL);
        asynMemEnqueueTimes.store(0UL);
        asynMemDequeueTimes.store(0UL);
        f2nfEnqueueTimes.store(0UL);
        f2nfDequeueTimes.store(0UL);
        bindTimes.store(0UL);
        unbindTimes.store(0UL);
        getBindTimes.store(0UL);
        getAllBindTimes.store(0UL);
        responseTimes.store(0UL);
        dataEnqueueSuccTimes.store(0UL);
        dataEnqueueFailTimes.store(0UL);
        dataEnqueueFullTimes.store(0UL);
        hcclMpiRecvRequestEventTimes.store(0UL);
        hcclMpiRecvReqFalseAwakenTimes.store(0UL);
        hcclMpiRecvReqEmptySchedTimes.store(0UL);
        hcclMpiRecvReqCallbackTimes.store(0UL);
        hcclMpiSendCompEventTimes.store(0UL);
        hcclMpiSendCompFalseAwakenTimes.store(0UL);
        hcclMpiSendCompEmptySchedTimes.store(0UL);
        hcclMpiSendCompCallbackTimes.store(0UL);
        hcclMpiRecvCompEventTimes.store(0UL);
        hcclMpiRecvCompFalseAwakenTimes.store(0UL);
        hcclMpiRecvCompEmptySchedTimes.store(0UL);
        hcclMpiRecvCompCallbackTimes.store(0UL);
        f2nfEventTimes.store(0UL);
        f2nfFalseAwakenTimes.store(0UL);
        hcclMpiRecvSuccTimes.store(0UL);
        hcclMpiRecvFailTimes.store(0UL);
        hcclMpiSendSuccTimes.store(0UL);
        hcclMpiSendFailTimes.store(0UL);
        hcclMpiSendFullTimes.store(0UL);
        hcclMpiF2nfEventTimes.store(0UL);
        mbufAllocSize.store(0UL);
        mbufAllocTimes.store(0UL);
        mbufFreeSize.store(0UL);
        mbufFreeTimes.store(0UL);
        supplyRecvReqEventTimes.store(0UL);
    };
};

class ScheduleStatistic {
public:
    ScheduleStatistic()
    {
        Reset();
    };

    ~ScheduleStatistic() = default;

    void Reset();

    void UpdateProcessCost(const float64_t cost);

    void UpdateScheduleDelay(const float64_t delay);

    float64_t GetMaxProcessCost();

    float64_t GetSecondProcessCost();

    float64_t GetMaxScheduleDelay();

    float64_t GetAvgProcessCost();

private:
    float64_t maxProcessCostUs_;
    float64_t secondMaxProcessUs_;
    float64_t maxScheduleDelayUs_;
    std::mutex mutex_;
    float64_t totalProcessCostUs_;
    uint64_t totalProcessCount_;
};

class StatisticManager {
public:
    static StatisticManager &GetInstance();

    ~StatisticManager();

    StatisticManager(const StatisticManager &) = delete;

    StatisticManager &operator=(const StatisticManager &) = delete;

    StatisticManager(StatisticManager &&) = delete;

    StatisticManager &operator=(StatisticManager &&) = delete;

public:
    /**
     * event schedule statistic.
     * @param scheduleNum schedule num, default is 1.
     */
    uint64_t EventScheduleStat(const uint32_t scheduleNum = 1U);

    /**
     * enqueue event false awaken times
     */
    void EnqueueEventFalseAwakenStat();

    /**
     * get event schedule statistic.
     */
    uint64_t GetEventScheduleStat() const;

    /**
     * daemon event schedule statistic.
     */
    void DaemonEventScheduleStat();

    /**
     * awaken count add.
     */
    void AwakenAdd();

    /**
     * return awaken times.
     */
    uint64_t GetAwakenTimes() const;

    /**
     * data sched empty statistic.
     */
    void AddScheduleEmpty();

    /**
     * data schedule failed statistic.
     * @param failedNum: data schedule failed, default is 1
     */
    void DataScheduleFailedStat(const uint64_t failedNum = 1UL);

    /**
     * relation queue enqueue statistic.
     */
    void RelationEnqueueStat();

    /**
     * relation queue dequeue statistic.
     */
    void RelationDequeueStat();

    /**
     * get relation queue enqueue statistic.
     */
    uint64_t GetRelationEnqueCnt() const;

    /**
     * get relation queue dequeue statistic.
     */
    uint64_t GetRelationDequeCnt() const;

    /**
     * asyn mem queue enqueue statistic.
     */
    void AsynMemEnqueueStat();

    /**
     * asyn mem queue dequeue statistic.
     */
    void AsynMemDequeueStat();

    /**
     * get asyn mem queue enqueue statistic.
     */
    uint64_t GetAsynMemEnqueCnt() const;

    /**
     * get asyn mem queue dequeue statistic.
     */
    uint64_t GetAsynMemDequeCnt() const;

    /**
     * full to not full queue enqueue statistic.
     */
    void F2nfEnqueueStat();

    /**
     * full to not full queue dequeue statistic.
     */
    void F2nfDequeueStat();

    /**
     * hccl mpi recv request event times statistic.
     */
    uint64_t HcclMpiRecvRequestEventStat();

    /**
     * hccl mpi recv request event false awaken times statistic.
     */
    void HcclMpiRecvReqFalseAwakenStat();

    /**
     * hccl mpi recv request event empty sched times statistic.
     */
    void HcclMpiRecvReqEmptySchedStat();

    /**
     * hccl mpi recv request event callback times statistic.
     */
    void HcclMpiRecvReqCallbackStat();

    /**
     * hccl mpi send completion event times statistic.
     */
    uint64_t HcclMpiSendCompEventStat();

    /**
     * hccl mpi send completion event false awaken times statistic.
     */
    void HcclMpiSendCompFalseAwakenStat();

    /**
     * hccl mpi send completion event empty sched times statistic.
     */
    void HcclMpiSendCompEmptySchedStat();

    /**
     * hccl mpi send completion event callback times statistic.
     */
    void HcclMpiSendCompCallbackStat();

    /**
     * hccl mpi recv completion event times statistic.
     */
    uint64_t HcclMpiRecvCompEventStat();

    /**
     * hccl mpi recv completion event false awaken times statistic.
     */
    void HcclMpiRecvCompFalseAwakenStat();

    /**
     * hccl mpi recv completion event empty sched times statistic.
     */
    void HcclMpiRecvCompEmptySchedStat();

    /**
     * hccl mpi recv completion event callback times statistic.
     */
    void HcclMpiRecvCompCallbackStat();

    /**
     * hccl mpi call hcclImrecv success times statistic.
     */
    void HcclMpiRecvSuccStat();

    /**
     * hccl mpi call hcclImrecv failed times statistic.
     */
    void HcclMpiRecvFailStat();

    /**
     * hccl mpi call hcclIsend success times statistic.
     */
    void HcclMpiSendSuccStat();

    /**
     * hccl mpi call hcclIsend failed times statistic.
     */
    void HcclMpiSendFailStat();

    /**
     * hccl mpi call hcclIsend full times statistic.
     */
    void HcclMpiSendFullStat();

    /**
     * hccl mpi congestion relief event times statistic
     */
    void HcclMpiF2nfEventStat();

    /**
     * mbuf alloc statistic
     */
    void MbufAllocStat(const uint64_t size);

    /**
     * mbuf free statistic
     */
    void MbufFreeStat(const uint64_t size);

    /**
     * recv request event supply statistic
     */
    void RecvReqEventSupplyStat();

    /**
     * f2nf event times statistic.
     */
    void F2nfEventStat();

    /**
     * f2nf event false awaken times statistic.
     */
    void F2nfEventFalseAwakenStat();

    /**
     * total dequeue times statistic.
     */
    void DataDequeueStat();

    void DataQueueEnqueueSuccStat();

    void DataQueueEnqueueFailStat();

    void DataQueueEnqueueFullStat();

    /**
     * bind relation request statistic
     */
    void BindStat();

    /**
     * unbind relation request statistic
     */
    void UnbindStat();

    /**
     * get bind relation request statistic
     */
    void GetBindStat();

    /**
     * get all bind relation request statistic
     */
    void GetAllBindStat();

    /**
     * relation response statistic
     */
    void ResponseStat();

    /**
     * subscribe queue statistic
     */
    void SubscribeNum(const uint32_t subscribeNum);

    /**
     * pause subscribe queue statistic, pause then +1
     */
    void PauseSubscribe();

    /**
     * pause subscribe queue statistic, resume then -1
     */
    void ResumeSubscribe();

    /**
     * bind relation number statistic
     */
    void BindNum(const uint32_t bindNum);

    /**
     * abnormal bind relation number statistic
     */
    void AbnormalBindNum(const uint32_t bindNum);

    /**
     * start dump static thread.
     */
    void StartStatisticManager(const uint32_t abnormalInterval, const uint32_t hostPid, const bool numaFlag = false,
        const uint32_t deviceIdExtra = 0U, const uint32_t enqueGroupIdExtra = 0U);

    /**
     * stop dump static thread.
     */
    void StopStatisticManager();

    /**
     * dump static thread function.
     */
    void ThreadFunc();

    /**
     * set exist entity flag
     */
    void SetExistEntityFlag(const bool flag);

    /**
     * Dump statistic info
     */
    void DumpStatistic();

    /**
     * Reset statistic info
     */
    void ResetStatistic();

    /**
     * Add unlink tag count
     * @return unlink tag count
     */
    const uint32_t AddUnlinkCount();

    /**
     * Reduce unlink tag count
     * @return unlink tag count
     */
    const uint32_t ReduceUnlinkCount();

    void RefreshEnqueHeartBeat();

    void AddTagCount();

    void ReduceTagCount();

    void UpdateScheuleStatistic(const float64_t delay, const float64_t cost);

    void DumpOutProcMemStatInfo();

    void RecordProcMemInfo();

private:
    StatisticManager() = default;

    /**
     * dump channel statistic info
     */
    void DumpChannelStatistic();

private:
    // lock for timerThread_
    std::mutex timerMutex_;
    // thread for record static
    std::thread timerThread_;

    // thread run flag
    volatile bool runFlag_ = false;

    // total statistic
    StatisticInfo totalStat_;
    // period statistic
    StatisticInfo periodStat_;
    // bind relation number
    std::atomic<uint32_t> bindNum_ = {0U};
    // need subscribe number
    std::atomic<uint32_t> subscribeNum_ = {0U};
    // need pause subscribe number
    std::atomic<uint32_t> pauseSubscribeNum_ = {0U};

    // exist entity flag
    std::atomic<bool> existEntityFlag_ = {false};
    // unlink tag number
    std::atomic<uint32_t> unLinkTagNum_ = {0U};
    // abnormal bind relation number
    std::atomic<uint32_t> abnormalBindNum_ = {0U};
    std::atomic<uint32_t> enqueThreadHearBeat_ = {0U};
    uint32_t abnormalInterval_;
    std::atomic<uint32_t> totalTagNum_ = {0U};
    ScheduleStatistic scheduleStatistic_{};

    bool numaFlag_{false};
    uint32_t deviceIdExtra_{0U};
    uint32_t enqueGroupIdExtra_{0U};

    QsProcMemStatistic procMemStat_;
    uint32_t hostPid_{0U};
};
}  // namespace bqs
#endif  // QUEUE_SCHEDULE_STATISTIC_MANAGER_H
