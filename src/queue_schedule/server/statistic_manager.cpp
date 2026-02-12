/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "statistic_manager.h"
#include <thread>
#include "common/bqs_log.h"
#include "server/hccl_process.h"
#include "server/qs_interface_process.h"

namespace bqs {
namespace {
// statistic period in seconds
constexpr const float64_t STATISTIC_PERIOD = 80.0;
// entity statistic period in seconds
constexpr const uint64_t ENTITY_STATISTIC_PERIOD = 30UL;
// supply event period in seconds
constexpr const uint64_t SUPPLY_EVENT_PERIOD = 1UL;
// wake up statistic thread in milliseconds (100ms)
constexpr const uint64_t WAKEUP_PERIOD_IN_MS = 100UL;
// 1s = 1000ms
constexpr const uint64_t MS_IN_ONE_SECOND = 1000UL;
constexpr const char_t *STATISTIC_THREAD_NAME_PREFIX = "statistic";
// proc mem stat period 10s
constexpr const uint64_t PROC_MEM_STAT_PERIOD = 10UL;
}  // namespace

StatisticManager &StatisticManager::GetInstance()
{
    static StatisticManager instance;
    return instance;
}

uint64_t StatisticManager::EventScheduleStat(const uint32_t scheduleNum)
{
    totalStat_.eventScheduleTimes += static_cast<uint64_t>(scheduleNum);
    periodStat_.eventScheduleTimes += static_cast<uint64_t>(scheduleNum);
    return totalStat_.eventScheduleTimes;
}

void StatisticManager::EnqueueEventFalseAwakenStat()
{
    ++totalStat_.enqueueFalseAwakenTimes;
}

uint64_t StatisticManager::GetEventScheduleStat() const
{
    return totalStat_.eventScheduleTimes;
}

void StatisticManager::DaemonEventScheduleStat()
{
    ++totalStat_.daemonEventScheduleTimes;
}

void StatisticManager::AwakenAdd()
{
    ++totalStat_.awakenTimes;
}

uint64_t StatisticManager::GetAwakenTimes() const
{
    return totalStat_.awakenTimes;
}

void StatisticManager::AddScheduleEmpty()
{
    ++totalStat_.scheduleEmptyTimes;
}

void StatisticManager::DataScheduleFailedStat(const uint64_t failedNum)
{
    totalStat_.dataScheduleFailedTimes += failedNum;
}

void StatisticManager::RelationEnqueueStat()
{
    ++totalStat_.relationEnqueueTimes;
}

void StatisticManager::RelationDequeueStat()
{
    ++totalStat_.relationDequeueTimes;
}

uint64_t StatisticManager::GetRelationEnqueCnt() const
{
    return totalStat_.relationEnqueueTimes;
}

uint64_t StatisticManager::GetRelationDequeCnt() const
{
    return totalStat_.relationDequeueTimes;
}

void StatisticManager::AsynMemEnqueueStat()
{
    ++totalStat_.asynMemEnqueueTimes;
}

void StatisticManager::AsynMemDequeueStat()
{
    ++totalStat_.asynMemDequeueTimes;
}

uint64_t StatisticManager::GetAsynMemEnqueCnt() const
{
    return totalStat_.asynMemEnqueueTimes;
}

uint64_t StatisticManager::GetAsynMemDequeCnt() const
{
    return totalStat_.asynMemDequeueTimes;
}

void StatisticManager::F2nfEnqueueStat()
{
    ++totalStat_.f2nfEnqueueTimes;
}

void StatisticManager::F2nfDequeueStat()
{
    ++totalStat_.f2nfDequeueTimes;
}

uint64_t StatisticManager::HcclMpiRecvRequestEventStat()
{
    return ++totalStat_.hcclMpiRecvRequestEventTimes;
}

void StatisticManager::HcclMpiRecvReqFalseAwakenStat()
{
    ++totalStat_.hcclMpiRecvReqFalseAwakenTimes;
}

void StatisticManager::HcclMpiRecvReqEmptySchedStat()
{
    ++totalStat_.hcclMpiRecvReqEmptySchedTimes;
}

void StatisticManager::HcclMpiRecvReqCallbackStat()
{
    ++totalStat_.hcclMpiRecvReqCallbackTimes;
}

uint64_t StatisticManager::HcclMpiSendCompEventStat()
{
    return ++totalStat_.hcclMpiSendCompEventTimes;
}

void StatisticManager::HcclMpiSendCompFalseAwakenStat()
{
    ++totalStat_.hcclMpiSendCompFalseAwakenTimes;
}

void StatisticManager::HcclMpiSendCompEmptySchedStat()
{
    ++totalStat_.hcclMpiSendCompEmptySchedTimes;
}

void StatisticManager::HcclMpiSendCompCallbackStat()
{
    ++totalStat_.hcclMpiSendCompCallbackTimes;
}

uint64_t StatisticManager::HcclMpiRecvCompEventStat()
{
    return ++totalStat_.hcclMpiRecvCompEventTimes;
}

void StatisticManager::HcclMpiRecvCompFalseAwakenStat()
{
    ++totalStat_.hcclMpiRecvCompFalseAwakenTimes;
}

void StatisticManager::HcclMpiRecvCompEmptySchedStat()
{
    ++totalStat_.hcclMpiRecvCompEmptySchedTimes;
}

void StatisticManager::HcclMpiRecvCompCallbackStat()
{
    ++totalStat_.hcclMpiRecvCompCallbackTimes;
}

void StatisticManager::F2nfEventStat()
{
    ++totalStat_.f2nfEventTimes;
}

void StatisticManager::F2nfEventFalseAwakenStat()
{
    ++totalStat_.f2nfFalseAwakenTimes;
}

void StatisticManager::HcclMpiRecvSuccStat()
{
    ++totalStat_.hcclMpiRecvSuccTimes;
}

void StatisticManager::HcclMpiRecvFailStat()
{
    ++totalStat_.hcclMpiRecvFailTimes;
}

void StatisticManager::HcclMpiSendSuccStat()
{
    ++totalStat_.hcclMpiSendSuccTimes;
}

void StatisticManager::HcclMpiSendFailStat()
{
    ++totalStat_.hcclMpiSendFailTimes;
}

void StatisticManager::HcclMpiSendFullStat()
{
    ++totalStat_.hcclMpiSendFullTimes;
}

void StatisticManager::HcclMpiF2nfEventStat()
{
    ++totalStat_.hcclMpiF2nfEventTimes;
}

void StatisticManager::MbufAllocStat(const uint64_t size)
{
    ++totalStat_.mbufAllocTimes;
    totalStat_.mbufAllocSize += size;
}

void StatisticManager::MbufFreeStat(const uint64_t size)
{
    ++totalStat_.mbufFreeTimes;
    totalStat_.mbufFreeSize += size;
}

void StatisticManager::RecvReqEventSupplyStat()
{
    ++totalStat_.supplyRecvReqEventTimes;
}

void StatisticManager::DataDequeueStat()
{
    ++totalStat_.dataDequeueTimes;
}

void StatisticManager::DataQueueEnqueueSuccStat()
{
    ++totalStat_.dataEnqueueSuccTimes;
    ++periodStat_.dataEnqueueSuccTimes;
}

void StatisticManager::DataQueueEnqueueFailStat()
{
    ++totalStat_.dataEnqueueFailTimes;
}

void StatisticManager::DataQueueEnqueueFullStat()
{
    ++totalStat_.dataEnqueueFullTimes;
}

void StatisticManager::BindStat()
{
    ++totalStat_.bindTimes;
}

void StatisticManager::UnbindStat()
{
    ++totalStat_.unbindTimes;
}

void StatisticManager::GetBindStat()
{
    ++totalStat_.getBindTimes;
}

void StatisticManager::GetAllBindStat()
{
    ++totalStat_.getAllBindTimes;
}

void StatisticManager::ResponseStat()
{
    ++totalStat_.responseTimes;
}

void StatisticManager::BindNum(const uint32_t bindNum)
{
    bindNum_.store(bindNum);
}

void StatisticManager::AbnormalBindNum(const uint32_t bindNum)
{
    abnormalBindNum_.store(bindNum);
}

void StatisticManager::SubscribeNum(const uint32_t subscribeNum)
{
    subscribeNum_.store(subscribeNum);
}

void StatisticManager::PauseSubscribe()
{
    ++pauseSubscribeNum_;
}

void StatisticManager::ResumeSubscribe()
{
    --pauseSubscribeNum_;
}

void StatisticManager::RefreshEnqueHeartBeat()
{
    ++enqueThreadHearBeat_;
}

void StatisticManager::StartStatisticManager(const uint32_t abnormalInterval, const uint32_t hostPid,
                                             const bool numaFlag, const uint32_t deviceIdExtra,
                                             const uint32_t enqueGroupIdExtra)
{
    runFlag_ = true;
    abnormalInterval_ = abnormalInterval;
    numaFlag_ = numaFlag;
    deviceIdExtra_ = deviceIdExtra;
    enqueGroupIdExtra_ = enqueGroupIdExtra;
    procMemStat_.InitProcMemStatistic();
    hostPid_ = hostPid;
    BQS_LOG_RUN_INFO("StartStatisticManager, abnormalInterval: %u, numaFlag: %d", abnormalInterval, numaFlag);
    timerThread_ = std::thread(&StatisticManager::ThreadFunc, this);
}

StatisticManager::~StatisticManager()
{
    DumpStatistic();
    StopStatisticManager();
}

void StatisticManager::StopStatisticManager()
{
    runFlag_ = false;

    const std::unique_lock<std::mutex> waitLock(timerMutex_);
    if (timerThread_.joinable()) {
        timerThread_.join();
    }
}

void StatisticManager::DumpStatistic()
{
    const uint64_t awakenTimes = totalStat_.awakenTimes;
    const uint64_t eventScheduleTimes = totalStat_.eventScheduleTimes;
    const uint64_t enqueueFlaseAwakenTimes = totalStat_.enqueueFalseAwakenTimes;
    const uint64_t daemonEventScheduleTimes = totalStat_.daemonEventScheduleTimes;
    const uint64_t periodEventScheduleTimes = periodStat_.eventScheduleTimes.exchange(0UL);
    const uint64_t dataEnqueueTimes = totalStat_.dataEnqueueSuccTimes;
    const uint64_t dataDequeueTimes = totalStat_.dataDequeueTimes;
    const uint64_t scheduleEmptyTimes = totalStat_.scheduleEmptyTimes;
    const uint64_t dataScheduleFailedTimes = totalStat_.dataScheduleFailedTimes;
    const uint64_t relationEnqueueTimes = totalStat_.relationEnqueueTimes;
    const uint64_t relationDequeueTimes = totalStat_.relationDequeueTimes;
    const uint64_t asynMemEnqueueTimes = totalStat_.asynMemEnqueueTimes;
    const uint64_t asynMemDequeueTimes = totalStat_.asynMemDequeueTimes;
    const uint64_t periodDataEnqueueTimes = periodStat_.dataEnqueueSuccTimes.exchange(0UL);
    const uint64_t dataEnqueueSuccTimes = totalStat_.dataEnqueueSuccTimes;
    const uint64_t dataEnqueueFailTimes = totalStat_.dataEnqueueFailTimes;
    const uint64_t dataEnqueueFullTimes = totalStat_.dataEnqueueFullTimes;
    const uint64_t mpiRecvSuccTimes = totalStat_.hcclMpiRecvSuccTimes;
    const uint64_t mpiRecvFailTimes = totalStat_.hcclMpiRecvFailTimes;
    const uint64_t mpiSendSuccTimes = totalStat_.hcclMpiSendSuccTimes;
    const uint64_t mpiSendFailTimes = totalStat_.hcclMpiSendFailTimes;
    const uint64_t mpiSendFullTimes = totalStat_.hcclMpiSendFullTimes;
    const uint64_t supplyRecvReqEventTimes = totalStat_.supplyRecvReqEventTimes;
    const uint64_t f2nfEventTimes = totalStat_.f2nfEventTimes;
    const uint64_t f2nfFalseAwakenTimes = totalStat_.f2nfFalseAwakenTimes;
    const uint64_t f2nfEnqueueTimes = totalStat_.f2nfEnqueueTimes;
    const uint64_t f2nfDequeueTimes = totalStat_.f2nfDequeueTimes;
    const float64_t maxProcessCostUs = scheduleStatistic_.GetMaxProcessCost();
    const float64_t maxScheduleDelayUs = scheduleStatistic_.GetMaxScheduleDelay();
    const float64_t secProcessCostUs = scheduleStatistic_.GetSecondProcessCost();
    const float64_t avgProcessCostUs = scheduleStatistic_.GetAvgProcessCost();
    scheduleStatistic_.Reset();

    BQS_LOG_RUN_INFO("Statistic info: queue={bind:%u, abnormal_bind:%u, subscribe:%u, pause:%u},"
        "event={awaken:%lu, aicpu schedule:%lu, "
        "incorrect waken:%lu, control schedule:%lu, period:%lu, %.2f/s}, data={total enqueue:%lu, total dequeue:%lu, "
        "total sched empty:%lu, total n-success:%lu, period:%lu, %.2f/s}, relation queue={enqueue:%lu, dequeue:%lu}, "
        "AsynMem queue={enqueue:%lu, dequeue:%lu}, dst queue={success:%lu, n-success:%lu, full:%lu}, "
        "queue f2nf=[success:%lu, incorrect awaken:%lu, enqueue:%lu, dequeue:%lu], "
        "hcclImrecv=[success:%lu, n-success:%lu], hcclIsend=[success:%lu, full:%lu, n-success:%lu], "
        "supply recv request event times=%lu}, maxProcessCostUs[%.2f/%.2f], maxSchedDelayUs[%.2f], avgCostUs[%.2f].",
        bindNum_.load(), abnormalBindNum_.load(), subscribeNum_.load(), pauseSubscribeNum_.load(),
        awakenTimes, eventScheduleTimes,
        enqueueFlaseAwakenTimes, daemonEventScheduleTimes, periodEventScheduleTimes,
        static_cast<float64_t>(static_cast<float64_t>(periodEventScheduleTimes) / STATISTIC_PERIOD), dataEnqueueTimes,
        dataDequeueTimes, scheduleEmptyTimes, dataScheduleFailedTimes, periodDataEnqueueTimes,
        static_cast<float64_t>(static_cast<float64_t>(periodDataEnqueueTimes) / STATISTIC_PERIOD), relationEnqueueTimes,
        relationDequeueTimes, asynMemEnqueueTimes, asynMemDequeueTimes,
        dataEnqueueSuccTimes, dataEnqueueFailTimes, dataEnqueueFullTimes,
        f2nfEventTimes, f2nfFalseAwakenTimes, f2nfEnqueueTimes, f2nfDequeueTimes,
        mpiRecvSuccTimes, mpiRecvFailTimes, mpiSendSuccTimes, mpiSendFullTimes, mpiSendFailTimes,
        supplyRecvReqEventTimes, maxProcessCostUs, secProcessCostUs, maxScheduleDelayUs, avgProcessCostUs);
}

void StatisticManager::ResetStatistic()
{
    DumpStatistic();
    // clear old statistic info
    totalStat_.Reset();
    periodStat_.Reset();
}

void StatisticManager::DumpChannelStatistic()
{
    // dump src entity statistic info
    dgw::CommChannels &srcChannels = dgw::EntityManager::Instance(0U).GetCommChannels(true);
    (void)pthread_rwlock_rdlock(&srcChannels.lock);
    for (auto &entity : srcChannels.entities) {
        entity->Dump();
    }
    (void)pthread_rwlock_unlock(&srcChannels.lock);

    // dump dst entity statistic info
    dgw::CommChannels &dstChannels = dgw::EntityManager::Instance(0U).GetCommChannels(false);
    (void)pthread_rwlock_rdlock(&dstChannels.lock);
    for (auto &entity : dstChannels.entities) {
        entity->Dump();
    }
    (void)pthread_rwlock_unlock(&dstChannels.lock);

    if (numaFlag_) {
        // dump src entity statistic info
        dgw::CommChannels &srcChannelsExtra = dgw::EntityManager::Instance(1U).GetCommChannels(true);
        BQS_LOG_INFO("EntityManager[1]'s srcChannelsExtra size is %zu", srcChannelsExtra.entities.size());
        (void)pthread_rwlock_rdlock(&srcChannelsExtra.lock);
        for (auto &entity : srcChannelsExtra.entities) {
            entity->Dump();
        }
        (void)pthread_rwlock_unlock(&srcChannelsExtra.lock);

        // dump dst entity statistic info
        dgw::CommChannels &dstChannelsExtra = dgw::EntityManager::Instance(1U).GetCommChannels(false);
        BQS_LOG_INFO("EntityManager[1]'s dstChannelsExtra size is %zu", dstChannelsExtra.entities.size());
        (void)pthread_rwlock_rdlock(&dstChannelsExtra.lock);
        for (auto &entity : dstChannelsExtra.entities) {
            entity->Dump();
        }
        (void)pthread_rwlock_unlock(&dstChannelsExtra.lock);
    }
}

void StatisticManager::ThreadFunc()
{
    static uint64_t count = 0UL;
    static uint64_t countForSupplyEvent = 0UL;

    static uint64_t statisticPeriod = static_cast<uint64_t>(STATISTIC_PERIOD) * MS_IN_ONE_SECOND / WAKEUP_PERIOD_IN_MS;
    static uint64_t channelStatisticPeriod = ENTITY_STATISTIC_PERIOD * MS_IN_ONE_SECOND / WAKEUP_PERIOD_IN_MS;
    static uint64_t supplyEventPeriod = SUPPLY_EVENT_PERIOD * MS_IN_ONE_SECOND / WAKEUP_PERIOD_IN_MS;
    static uint64_t procMemPeriod = PROC_MEM_STAT_PERIOD * MS_IN_ONE_SECOND / WAKEUP_PERIOD_IN_MS;
    const uint64_t abnormalCheckPeriod = abnormalInterval_ * MS_IN_ONE_SECOND / WAKEUP_PERIOD_IN_MS;
    BQS_LOG_INFO("statistic thread start, statisticPeriod [%lu], channelStatisticPeriod[%lu], "
        "supplyEventPeriod[%lu]", statisticPeriod, channelStatisticPeriod, supplyEventPeriod);
    (void)pthread_setname_np(pthread_self(), STATISTIC_THREAD_NAME_PREFIX);
    uint64_t enqueThreadHeartBeat = 0UL;
    while (runFlag_) {
        // only supply event when exist entity
        if (existEntityFlag_.load()) {
            if ((unLinkTagNum_.load() > 0U) ||
                ((countForSupplyEvent % supplyEventPeriod == 0UL) && (totalTagNum_.load() > 0U))) {
                (void)dgw::HcclProcess::GetInstance().SupplyEvents(0U);
                if (numaFlag_) {
                    (void)dgw::HcclProcess::GetInstance().SupplyEvents(1U);
                }
            }
            countForSupplyEvent++;
        } else {
            countForSupplyEvent = 0UL;
        }
        // dump total statistic and channel statistic
        if (count % statisticPeriod == 0UL) {
            DumpStatistic();
        }
        if (count % channelStatisticPeriod == 0UL) {
            DumpChannelStatistic();
        }
        if ((count + 1) % abnormalCheckPeriod == 0UL) {
            const auto currentEnqueHeartBeat = enqueThreadHearBeat_.load();
            if (enqueThreadHeartBeat == currentEnqueHeartBeat) {
                QueueScheduleInterface::GetInstance().ReportAbnormal();
            } else {
                enqueThreadHeartBeat = currentEnqueHeartBeat;
            }
        }
        if (count % procMemPeriod == 0) {
            RecordProcMemInfo();
        }

        count++;
        usleep(WAKEUP_PERIOD_IN_MS * 1000U);
    }
    BQS_LOG_INFO("statistic thread end.");
}

void StatisticManager::SetExistEntityFlag(const bool flag)
{
    existEntityFlag_.store(flag);
}

const uint32_t StatisticManager::AddUnlinkCount()
{
    ++unLinkTagNum_;
    return unLinkTagNum_.load();
}

const uint32_t StatisticManager::ReduceUnlinkCount()
{
    --unLinkTagNum_;
    return unLinkTagNum_.load();
}

void StatisticManager::AddTagCount()
{
    ++totalTagNum_;
}

void StatisticManager::ReduceTagCount()
{
    --totalTagNum_;
}

void StatisticManager::UpdateScheuleStatistic(const float64_t delay, const float64_t cost)
{
    scheduleStatistic_.UpdateScheduleDelay(delay);
    scheduleStatistic_.UpdateProcessCost(cost);
}

void StatisticManager::DumpOutProcMemStatInfo()
{
    procMemStat_.PrintOutProcMemInfo(hostPid_);
}

void StatisticManager::RecordProcMemInfo()
{
    procMemStat_.StatisticProcMemInfo();
}

void ScheduleStatistic::Reset()
{
    std::unique_lock<std::mutex> lock(mutex_);
    maxProcessCostUs_ = 0.0;
    maxScheduleDelayUs_ = 0.0;
    secondMaxProcessUs_ = 0.0;
    totalProcessCostUs_ = 0.0;
    totalProcessCount_ = 0U;
}

void ScheduleStatistic::UpdateProcessCost(const float64_t cost)
{
    std::unique_lock<std::mutex> lock(mutex_);
    if (cost > maxProcessCostUs_) {
        secondMaxProcessUs_ = maxProcessCostUs_;
        maxProcessCostUs_ = cost;
    }
    totalProcessCostUs_ += cost;
    ++totalProcessCount_;
}

void ScheduleStatistic::UpdateScheduleDelay(const float64_t delay)
{
    std::unique_lock<std::mutex> lock(mutex_);
    if (delay > maxScheduleDelayUs_) {
        maxScheduleDelayUs_ = delay;
    }
}

float64_t ScheduleStatistic::GetMaxProcessCost()
{
    std::unique_lock<std::mutex> lock(mutex_);
    return maxProcessCostUs_;
}

float64_t ScheduleStatistic::GetSecondProcessCost()
{
    std::unique_lock<std::mutex> lock(mutex_);
    return secondMaxProcessUs_;
}

float64_t ScheduleStatistic::GetMaxScheduleDelay()
{
    std::unique_lock<std::mutex> lock(mutex_);
    return maxScheduleDelayUs_;
}

float64_t ScheduleStatistic::GetAvgProcessCost()
{
    std::unique_lock<std::mutex> lock(mutex_);
    return totalProcessCount_ > 0U ? totalProcessCostUs_ / totalProcessCount_ : totalProcessCostUs_;
}

}  // namespace bqs
