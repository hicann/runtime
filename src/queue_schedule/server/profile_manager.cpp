/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "profile_manager.h"

#include <ctime>
#include "bqs_util.h"
#include "bind_cpu_utils.h"
#include "queue_schedule_feature_ctrl.h"
#ifdef USE_PROFILER
#include "hiperf_exception.h"
#include "hiperf_marker.h"
#endif

namespace bqs {
namespace {
    constexpr float64_t SECOND_TO_NANO = 1000000000.0;
    constexpr float64_t PROF_THRESHOLD_MS = 0.20;
    constexpr float64_t ERROR_LOG_THRESHOLD_MS = 20.0;
    const uint32_t MARKER_ENQUEUE_EVENT = 7U;
    // event time cost threshold(ms)
    const float64_t EVENT_TIME_COST_THRESHOLD_MS = 500.0;
}

ProfileManager::ProfileManager()
    : enqueEventTrack_({}),
      frequence_(0.0),
      profThresholdTick_(0UL),
      logThresholdTick_(0UL),
      oneUsForTick_(0.0),
      profMode_(ProfilingMode::PROFILING_CLOSE),
      schedInfoTrack_({}),
      recvReqEventTrack_({}),
      recvCompEventTrack_({}),
      sendCompEventTrack_({}),
      aicpuFeatureUseErrorLogThreshold_(true),
      recvReqEventCount_(0UL),
      sendCompEventCount_(0UL),
      recvCompEventCount_(0UL),
      enqueueEventCount_(0UL)
{}

void ProfileManager::Uninit() const
{
#ifdef USE_PROFILER
    ::FiniMarker();
#endif
}

ProfileManager &ProfileManager::GetInstance(const uint32_t resIndex)
{
    if (resIndex == 0U) {
        static ProfileManager instance;
        return instance;
    }
    static ProfileManager instanceExtra;
    return instanceExtra;
}

void ProfileManager::InitProfileManager(const uint32_t deviceId)
{
    constexpr float64_t oneMs = 1000000.0;  // ns of one ms
    constexpr float64_t oneUs = 1000.0;  // ns of one us
    frequence_ = static_cast<float64_t>(GetSystemFreq());
    oneUsForTick_ = oneUs / (SECOND_TO_NANO / frequence_);

    const float64_t oneMsForTickTemp = oneMs / (SECOND_TO_NANO / frequence_);
    const float64_t profThresholdTickTemp = PROF_THRESHOLD_MS * oneMsForTickTemp;
    profThresholdTick_ = static_cast<uint64_t>(profThresholdTickTemp);

    aicpuFeatureUseErrorLogThreshold_ = (bqs::GetRunContext() == bqs::RunContext::HOST) ? false : QSFeatureCtrl::UseErrorLogThreshold(deviceId);
    const float64_t logThresholdTickTemp = aicpuFeatureUseErrorLogThreshold_ ?
        (ERROR_LOG_THRESHOLD_MS * oneMsForTickTemp) : (EVENT_TIME_COST_THRESHOLD_MS * oneMsForTickTemp);
    logThresholdTick_ = static_cast<uint64_t>(logThresholdTickTemp);
    BQS_LOG_RUN_INFO("ProfileManager logThresholdTick is [%lu]", logThresholdTick_);

#ifdef USE_PROFILER
    ::InitMarker();
#endif
}

void ProfileManager::InitMaker(const uint64_t schedTimes, const uint64_t schedDelay)
{
#ifndef USE_PROFILER
    enqueEventTrack_.event = 0U;
#else
    enqueEventTrack_.event = MARKER_ENQUEUE_EVENT;
#endif
    enqueEventTrack_.schedTimes = schedTimes;
    enqueEventTrack_.schedDelay = schedDelay;
    enqueEventTrack_.state = 0U;
    enqueEventTrack_.recordThreshold = 0U;
    enqueEventTrack_.dequeueNum = 0UL;
    enqueEventTrack_.enqueueNum = 0UL;
    enqueEventTrack_.fullQueueNum = 0U;
    enqueEventTrack_.srcQueueNum = 0U;
    enqueEventTrack_.startStamp = 0UL;
    enqueEventTrack_.copyCost = 0UL;
    enqueEventTrack_.relationCost = 0UL;
    enqueEventTrack_.f2NFCost = 0UL;
    enqueEventTrack_.totalCost = 0UL;
}

void ProfileManager::SetSrcQueueNum(const uint32_t srcQueueNum)
{
    enqueEventTrack_.srcQueueNum = srcQueueNum;
}

void ProfileManager::AddEnqueueNum()
{
    enqueEventTrack_.enqueueNum++;
}

void ProfileManager::AddDequeueNum()
{
    enqueEventTrack_.dequeueNum++;
}

void ProfileManager::AddCopyTotalCost(const uint64_t copyCost)
{
    enqueEventTrack_.copyCost += copyCost;
}

void ProfileManager::SetRelationCost(const uint64_t relationCost)
{
    enqueEventTrack_.relationCost = relationCost;
}

void ProfileManager::Setf2NFCost(const uint64_t f2NFCost)
{
    enqueEventTrack_.f2NFCost = f2NFCost;
}

void ProfileManager::InitMarkerForRecvReqEvent(const uint64_t schedTimes, const uint64_t schedDelay)
{
    recvReqEventTrack_.schedTimes = schedTimes;
    recvReqEventTrack_.schedDelay = schedDelay;
    recvReqEventTrack_.hcclImprobeNum = 0UL;
    recvReqEventTrack_.totalHcclImprobeCost = 0UL;
    recvReqEventTrack_.maxHcclImprobeCost = 0UL;
    recvReqEventTrack_.hcclGetCountNum = 0UL;
    recvReqEventTrack_.totalHcclGetCountCost = 0UL;
    recvReqEventTrack_.maxHcclGetCountCost = 0UL;
    recvReqEventTrack_.hcclImrecvNum = 0UL;
    recvReqEventTrack_.totalHcclImrecvCost = 0UL;
    recvReqEventTrack_.maxHcclImrecvCost = 0UL;
    recvReqEventTrack_.mbufAllocNum = 0UL;
    recvReqEventTrack_.totalMbufAllocCost = 0UL;
    recvReqEventTrack_.maxMbufAllocCost = 0UL;
}

void ProfileManager::InitMarkerForRecvCompEvent(const uint64_t schedTimes, const uint64_t schedDelay)
{
    recvCompEventTrack_.schedTimes = schedTimes;
    recvCompEventTrack_.schedDelay = schedDelay;
    recvCompEventTrack_.hcclTestSomeNum = 0UL;
    recvCompEventTrack_.totalHcclTestSomeCost = 0UL;
    recvCompEventTrack_.maxHcclTestSomeCost = 0UL;
    recvCompEventTrack_.enqueueNum = 0UL;
    recvCompEventTrack_.totalEnqueueCost = 0UL;
    recvCompEventTrack_.maxEnqueueCost = 0UL;
    recvCompEventTrack_.reqProcCompNum = 0UL;
    recvCompEventTrack_.totalReqProcCompCost = 0UL;
    recvCompEventTrack_.maxReqProcCompCost = 0UL;
}

void ProfileManager::InitMarkerForSendCompEvent(const uint64_t schedTimes, const uint64_t schedDelay)
{
    sendCompEventTrack_.schedTimes = schedTimes;
    sendCompEventTrack_.schedDelay = schedDelay;
    sendCompEventTrack_.hcclTestSomeNum = 0UL;
    sendCompEventTrack_.totalHcclTestSomeCost = 0UL;
    sendCompEventTrack_.maxHcclTestSomeCost = 0UL;
    sendCompEventTrack_.reqProcCompNum = 0UL;
    sendCompEventTrack_.totalReqProcCompCost = 0UL;
    sendCompEventTrack_.maxReqProcCompCost = 0UL;
    sendCompEventTrack_.mbufFreeNum = 0UL;
    sendCompEventTrack_.totalMbufFreeCost = 0UL;
    sendCompEventTrack_.maxMbufFreeCost = 0UL;
}

void ProfileManager::AddHcclImprobeCost(const uint64_t cost)
{
    recvReqEventTrack_.hcclImprobeNum++;
    recvReqEventTrack_.totalHcclImprobeCost += cost;
    recvReqEventTrack_.maxHcclImprobeCost = (recvReqEventTrack_.maxHcclImprobeCost > cost) ?
        recvReqEventTrack_.maxHcclImprobeCost : cost;
}

void ProfileManager::AddHcclGetCountCost(const uint64_t cost)
{
    recvReqEventTrack_.hcclGetCountNum++;
    recvReqEventTrack_.totalHcclGetCountCost += cost;
    recvReqEventTrack_.maxHcclGetCountCost = (recvReqEventTrack_.maxHcclGetCountCost > cost) ?
        recvReqEventTrack_.maxHcclGetCountCost : cost;
}

void ProfileManager::AddHcclImrecvCost(const uint64_t cost)
{
    recvReqEventTrack_.hcclImrecvNum++;
    recvReqEventTrack_.totalHcclImrecvCost += cost;
    recvReqEventTrack_.maxHcclImrecvCost = (recvReqEventTrack_.maxHcclImrecvCost > cost) ?
        recvReqEventTrack_.maxHcclImrecvCost : cost;

    schedInfoTrack_.hcclImrecvNum++;
    schedInfoTrack_.totalHcclImrecvCost += cost;
    schedInfoTrack_.maxHcclImrecvCost = (schedInfoTrack_.maxHcclImrecvCost > cost) ?
        schedInfoTrack_.maxHcclImrecvCost : cost;
}

void ProfileManager::AddHcclTestSomeCost(const uint64_t cost, const bool isRecvCompEvent)
{
    if (isRecvCompEvent) {
        recvCompEventTrack_.hcclTestSomeNum++;
        recvCompEventTrack_.totalHcclTestSomeCost += cost;
        recvCompEventTrack_.maxHcclTestSomeCost = (recvCompEventTrack_.maxHcclTestSomeCost > cost) ?
            recvCompEventTrack_.maxHcclTestSomeCost : cost;
    } else {
        sendCompEventTrack_.hcclTestSomeNum++;
        sendCompEventTrack_.totalHcclTestSomeCost += cost;
        sendCompEventTrack_.maxHcclTestSomeCost = (sendCompEventTrack_.maxHcclTestSomeCost > cost) ?
            sendCompEventTrack_.maxHcclTestSomeCost : cost;
    }
}

const float64_t ProfileManager::AddReqProcCompCost(const uint64_t cost, const bool isRecvCompEvent)
{
    if (isRecvCompEvent) {
        recvCompEventTrack_.reqProcCompNum++;
        recvCompEventTrack_.totalReqProcCompCost += cost;
        recvCompEventTrack_.maxReqProcCompCost = (recvCompEventTrack_.maxReqProcCompCost > cost) ?
            recvCompEventTrack_.maxReqProcCompCost : cost;
    } else {
        sendCompEventTrack_.reqProcCompNum++;
        sendCompEventTrack_.totalReqProcCompCost += cost;
        sendCompEventTrack_.maxReqProcCompCost = (sendCompEventTrack_.maxReqProcCompCost > cost) ?
            sendCompEventTrack_.maxReqProcCompCost : cost;
    }
    return (static_cast<float64_t>(cost) / oneUsForTick_);
}

void ProfileManager::AddHcclIsendCost(const uint64_t cost)
{
    schedInfoTrack_.hcclIsendNum++;
    schedInfoTrack_.totalHcclIsendCost += cost;
    schedInfoTrack_.maxHcclIsendCost = (schedInfoTrack_.maxHcclIsendCost > cost) ?
        schedInfoTrack_.maxHcclIsendCost : cost;
}

void ProfileManager::AddMbufAllocCost(const uint64_t cost)
{
    recvReqEventTrack_.mbufAllocNum++;
    recvReqEventTrack_.totalMbufAllocCost += cost;
    recvReqEventTrack_.maxMbufAllocCost = (recvReqEventTrack_.maxMbufAllocCost > cost) ?
        recvReqEventTrack_.maxMbufAllocCost : cost;
}

void ProfileManager::AddHcclEnqueueCost(const uint64_t cost)
{
    recvCompEventTrack_.enqueueNum++;
    recvCompEventTrack_.totalEnqueueCost += cost;
    recvCompEventTrack_.maxEnqueueCost = (recvCompEventTrack_.maxEnqueueCost > cost) ?
        recvCompEventTrack_.maxEnqueueCost : cost;
}

void ProfileManager::AddMbufFreeCost(const uint64_t cost)
{
    sendCompEventTrack_.mbufFreeNum++;
    sendCompEventTrack_.totalMbufFreeCost += cost;
    sendCompEventTrack_.maxMbufFreeCost = (sendCompEventTrack_.maxMbufFreeCost > cost) ?
        sendCompEventTrack_.maxMbufFreeCost : cost;
}

void ProfileManager::DoMarkerForRecvReqEvent(const uint64_t startTick)
{
    // print profiling data
    if (profMode_ == bqs::ProfilingMode::PROFILING_OPEN) {
        const uint64_t totalCostTick = GetCpuTick() - startTick;
        schedInfoTrack_.recvReqEventTotalDelay += recvReqEventTrack_.schedDelay;
        if (recvReqEventTrack_.schedDelay > schedInfoTrack_.recvReqEventMaxDelay) {
            schedInfoTrack_.recvReqEventMaxDelay = recvReqEventTrack_.schedDelay;
        }
        if ((recvReqEventTrack_.schedDelay < schedInfoTrack_.recvReqEventMinDelay) || (recvReqEventCount_ == 0U)) {
            schedInfoTrack_.recvReqEventMinDelay = recvReqEventTrack_.schedDelay;
        }
        recvReqEventCount_++;
        const uint64_t count = recvReqEventCount_.load();

        const float64_t totalCost = static_cast<float64_t>(totalCostTick) / oneUsForTick_;

        // calculate average cost for HcclImprobe
        const float64_t totalHcclImprobeCost =
            static_cast<float64_t>(recvReqEventTrack_.totalHcclImprobeCost) / oneUsForTick_;
        const uint64_t hcclImprobeNum = recvReqEventTrack_.hcclImprobeNum;
        const float64_t avgHcclImprobeCost = (hcclImprobeNum == 0UL) ? 0.0 :
            (totalHcclImprobeCost / static_cast<float64_t>(hcclImprobeNum));
        const float64_t maxHcclImprobeCost =
            static_cast<float64_t>(recvReqEventTrack_.maxHcclImprobeCost) / oneUsForTick_;

        // calculate average cost for HcclGetCount
        const float64_t totalHcclGetCountCost =
            static_cast<float64_t>(recvReqEventTrack_.totalHcclGetCountCost) / oneUsForTick_;
        const uint64_t hcclGetCountNum = recvReqEventTrack_.hcclGetCountNum;
        const float64_t avgHcclGetCountCost = (hcclGetCountNum == 0UL) ? 0.0 :
            (totalHcclGetCountCost / static_cast<float64_t>(hcclGetCountNum));
        const float64_t maxHcclGetCountCost =
            static_cast<float64_t>(recvReqEventTrack_.maxHcclGetCountCost) / oneUsForTick_;

        // calcuate average cost for HcclImrecv
        const float64_t totalHcclImrecvCost =
            static_cast<float64_t>(recvReqEventTrack_.totalHcclImrecvCost) / oneUsForTick_;
        const uint64_t hcclImrecvNum = recvReqEventTrack_.hcclImrecvNum;
        const float64_t avgHcclImrecvCost = (hcclImrecvNum == 0UL) ? 0.0 :
            (totalHcclImrecvCost / static_cast<float64_t>(hcclImrecvNum));
        const float64_t maxHcclImrecvCost =
            static_cast<float64_t>(recvReqEventTrack_.maxHcclImrecvCost) / oneUsForTick_;

        // calcuate average cost for mbuf alloc
        const float64_t totalMbufAllocCost =
            static_cast<float64_t>(recvReqEventTrack_.totalMbufAllocCost) / oneUsForTick_;
        const uint64_t mbufAllocNum = recvReqEventTrack_.mbufAllocNum;
        const float64_t avgMbufAllocCost = (mbufAllocNum == 0UL) ? 0.0 :
            (totalMbufAllocCost / static_cast<float64_t>(mbufAllocNum));
        const float64_t maxMbufAllocCost =
            static_cast<float64_t>(recvReqEventTrack_.maxMbufAllocCost) / oneUsForTick_;

        BQS_LOG_RUN_INFO("Hccl time cost info: {recv request event, count[%lu], "
            "schedTimes[%lu], schedDelay[%lu]ticks, totalCost[%.2f]us, startStamp[%lu], "
            "hcclImprobe[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus], "
            "hcclGetCount[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus], "
            "hcclImrecv[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus], "
            "mbufAlloc[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus]}.",
            count, recvReqEventTrack_.schedTimes, recvReqEventTrack_.schedDelay, totalCost, startTick,
            hcclImprobeNum, totalHcclImprobeCost, avgHcclImprobeCost, maxHcclImprobeCost,
            hcclGetCountNum, totalHcclGetCountCost, avgHcclGetCountCost, maxHcclGetCountCost,
            hcclImrecvNum, totalHcclImrecvCost, avgHcclImrecvCost, maxHcclImrecvCost,
            mbufAllocNum, totalMbufAllocCost, avgMbufAllocCost, maxMbufAllocCost);
    }
}

void ProfileManager::DoMarkerForRecvCompEvent(const uint64_t startTick)
{
    // print profiling data
    if (profMode_ == bqs::ProfilingMode::PROFILING_OPEN) {
        const uint64_t totalCostTick = GetCpuTick() - startTick;
        schedInfoTrack_.recvCompEventTotalDelay += recvCompEventTrack_.schedDelay;
        if (recvCompEventTrack_.schedDelay > schedInfoTrack_.recvCompEventMaxDelay) {
            schedInfoTrack_.recvCompEventMaxDelay = recvCompEventTrack_.schedDelay;
        }
        if ((recvCompEventTrack_.schedDelay < schedInfoTrack_.recvCompEventMinDelay) || (recvCompEventCount_ == 0U)) {
            schedInfoTrack_.recvCompEventMinDelay = recvCompEventTrack_.schedDelay;
        }
        recvCompEventCount_++;
        const uint64_t count = recvCompEventCount_.load();
        const float64_t totalCost = static_cast<float64_t>(totalCostTick) / oneUsForTick_;
        // calculate average cost for HcclTestSome
        const float64_t totalHcclTestSomeCost =
            static_cast<float64_t>(recvCompEventTrack_.totalHcclTestSomeCost) / oneUsForTick_;
        const uint64_t hcclTestSomeNum = recvCompEventTrack_.hcclTestSomeNum;
        const float64_t avgHcclTestSomeCost = (hcclTestSomeNum == 0UL) ? 0.0 :
            (totalHcclTestSomeCost / static_cast<float64_t>(hcclTestSomeNum));
        const float64_t maxHcclTestSomeCost =
            static_cast<float64_t>(recvCompEventTrack_.maxHcclTestSomeCost) / oneUsForTick_;

        // calcuate average cost for enqueue
        const float64_t totalEnqueueCost = static_cast<float64_t>(recvCompEventTrack_.totalEnqueueCost) / oneUsForTick_;
        const uint64_t enqueueNum = recvCompEventTrack_.enqueueNum;
        const float64_t avgEnqueueCost = (enqueueNum == 0UL) ? 0.0 :
            (totalEnqueueCost / static_cast<float64_t>(enqueueNum));
        const float64_t maxEnqueueCost = static_cast<float64_t>(recvCompEventTrack_.maxEnqueueCost) / oneUsForTick_;

        // calculate average cost for request process completed
        const float64_t totalReqProcCompCost =
            static_cast<float64_t>(recvCompEventTrack_.totalReqProcCompCost) / oneUsForTick_;
        const uint64_t reqProcCompNum = recvCompEventTrack_.reqProcCompNum;
        const float64_t avgReqProcCompCost = (reqProcCompNum == 0UL) ? 0.0 :
            (totalReqProcCompCost / static_cast<float64_t>(reqProcCompNum));
        const float64_t maxReqProcCompCost =
            static_cast<float64_t>(recvCompEventTrack_.maxReqProcCompCost) / oneUsForTick_;

        // calculate average cost for test some success one request
        const float64_t avgSuccTestSomeOneReqCost = (reqProcCompNum == 0UL) ? 0.0 :
            (totalHcclTestSomeCost / static_cast<float64_t>(reqProcCompNum));

        BQS_LOG_RUN_INFO("Hccl time cost info: {recv completion event, count[%lu], "
            "schedTimes[%lu], schedDelay[%lu]ticks, totalCost[%.2f]us, startStamp[%lu], "
            "hcclTestSome[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus], "
            "enqueue[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus], "
            "reqProcComp[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus], "
            "testSomeReq[count:%lu, total:%.2fus, average:%.2fus]}.",
            count, recvCompEventTrack_.schedTimes, recvCompEventTrack_.schedDelay, totalCost, startTick,
            hcclTestSomeNum, totalHcclTestSomeCost, avgHcclTestSomeCost, maxHcclTestSomeCost,
            enqueueNum, totalEnqueueCost, avgEnqueueCost, maxEnqueueCost,
            reqProcCompNum, totalReqProcCompCost, avgReqProcCompCost, maxReqProcCompCost,
            reqProcCompNum, totalHcclTestSomeCost, avgSuccTestSomeOneReqCost);
    }
}

void ProfileManager::DoMarkerForSendCompEvent(const uint64_t startTick)
{
    // print profiling data
    if (profMode_ == bqs::ProfilingMode::PROFILING_OPEN) {
        const uint64_t totalCostTick = GetCpuTick() - startTick;
        schedInfoTrack_.sendCompEventTotalDelay += sendCompEventTrack_.schedDelay;
        if (sendCompEventTrack_.schedDelay > schedInfoTrack_.sendCompEventMaxDelay) {
            schedInfoTrack_.sendCompEventMaxDelay = sendCompEventTrack_.schedDelay;
        }
        if ((sendCompEventTrack_.schedDelay < schedInfoTrack_.sendCompEventMinDelay) || (sendCompEventCount_ == 0U)) {
            schedInfoTrack_.sendCompEventMinDelay = sendCompEventTrack_.schedDelay;
        }
        sendCompEventCount_++;
        const uint64_t count = sendCompEventCount_.load();

        const float64_t totalCost = static_cast<float64_t>(totalCostTick) / oneUsForTick_;
        // calculate average cost for HcclTestSome
        const float64_t totalHcclTestSomeCost =
            static_cast<float64_t>(sendCompEventTrack_.totalHcclTestSomeCost) / oneUsForTick_;
        const uint64_t hcclTestSomeNum = sendCompEventTrack_.hcclTestSomeNum;
        const float64_t avgHcclTestSomeCost = (hcclTestSomeNum == 0UL) ? 0.0 :
            (totalHcclTestSomeCost / static_cast<float64_t>(hcclTestSomeNum));
        const float64_t maxHcclTestSomeCost =
            static_cast<float64_t>(sendCompEventTrack_.maxHcclTestSomeCost) / oneUsForTick_;

        // calcuate average cost for mbufFree
        const float64_t totalMbufFreeCost =
            static_cast<float64_t>(sendCompEventTrack_.totalMbufFreeCost) / oneUsForTick_;
        const uint64_t mbufFreeNum = sendCompEventTrack_.mbufFreeNum;
        const float64_t avgMbufFreeCost = (mbufFreeNum == 0UL) ? 0.0 :
            (totalMbufFreeCost / static_cast<float64_t>(mbufFreeNum));
        const float64_t maxMbufFreeCost = static_cast<float64_t>(sendCompEventTrack_.maxMbufFreeCost) / oneUsForTick_;

        // calculate average for request process completed cost
        const float64_t totalReqProcCompCost =
            static_cast<float64_t>(sendCompEventTrack_.totalReqProcCompCost) / oneUsForTick_;
        const uint64_t reqProcCompNum = sendCompEventTrack_.reqProcCompNum;
        const float64_t avgReqProcCompCost = (reqProcCompNum == 0UL) ? 0.0 :
            (totalReqProcCompCost / static_cast<float64_t>(reqProcCompNum));
        const float64_t maxReqProcCompCost =
            static_cast<float64_t>(sendCompEventTrack_.maxReqProcCompCost) / oneUsForTick_;

        // calculate average cost for test some success one request
        const float64_t avgSuccTestSomeOneReqCost = (reqProcCompNum == 0UL) ? 0.0 :
            (totalHcclTestSomeCost / static_cast<float64_t>(reqProcCompNum));

        BQS_LOG_RUN_INFO("Hccl time cost info: {send completion event, count[%lu], "
            "schedTimes[%lu], schedDelay[%lu]ticks, totalCost[%.2f]us, startStamp[%lu], "
            "hcclTestSome[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus], "
            "mbufFree[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus], "
            "reqProcComp[count:%lu, total:%.2fus, average:%.2fus, max:%.2fus], "
            "testSomeReq[count:%lu, total:%.2fus, average:%.2fus]}.",
            count, sendCompEventTrack_.schedTimes, sendCompEventTrack_.schedDelay, totalCost, startTick,
            hcclTestSomeNum, totalHcclTestSomeCost, avgHcclTestSomeCost, maxHcclTestSomeCost,
            mbufFreeNum, totalMbufFreeCost, avgMbufFreeCost, maxMbufFreeCost,
            reqProcCompNum, totalReqProcCompCost, avgReqProcCompCost, maxReqProcCompCost,
            reqProcCompNum, totalHcclTestSomeCost, avgSuccTestSomeOneReqCost);
    }
}

void ProfileManager::TryMarker(const uint64_t startTick)
{
    const uint64_t totalCost = GetCpuTick() - startTick;
    // profile_end value:1
    enqueEventTrack_.state = 1U;
    enqueEventTrack_.totalCost = totalCost;
    enqueEventTrack_.startStamp = startTick;
    DoMarker();
    if ((enqueEventTrack_.totalCost > logThresholdTick_) || (enqueEventTrack_.schedDelay > logThresholdTick_)) {
        DoErrorLog();
    }
}

void ProfileManager::DoMarker()
{
#ifndef USE_PROFILER
    BQS_LOG_INFO("Time cost info: {event:%u, state:%u, schedTimes:%lu, schedDelay:%lu ticks, "
        "startStamp:%lu, dequeueNum:%lu, enqueueNum:%lu, "
        "copyCost:%lu ticks, fullQueueNum:%u, srcQueueNum:%u, "
        "relationCost:%lu ticks, f2NFCost:%lu ticks, totalCost:%lu ticks}.",
        enqueEventTrack_.event, enqueEventTrack_.state, enqueEventTrack_.schedTimes, enqueEventTrack_.schedDelay,
        enqueEventTrack_.startStamp, enqueEventTrack_.dequeueNum, enqueEventTrack_.enqueueNum,
        enqueEventTrack_.copyCost, enqueEventTrack_.fullQueueNum, enqueEventTrack_.srcQueueNum,
        enqueEventTrack_.relationCost, enqueEventTrack_.f2NFCost, enqueEventTrack_.totalCost);

    if (profMode_ == bqs::ProfilingMode::PROFILING_OPEN) {
        enqueueEventCount_++;
        uint64_t count = enqueueEventCount_.load();
        const float64_t totalHcclIsendCost =
            static_cast<float64_t>(schedInfoTrack_.totalHcclIsendCost) / oneUsForTick_;
        const uint64_t hcclIsendNum = schedInfoTrack_.hcclIsendNum;
        const float64_t avgHcclIsendCost = (hcclIsendNum == 0U) ?
            0.0 : totalHcclIsendCost / static_cast<float64_t>(hcclIsendNum);
        const float64_t maxHcclIsendCost =
            static_cast<float64_t>(schedInfoTrack_.maxHcclIsendCost) / oneUsForTick_;

        const float64_t totalHcclImrecvCost =
            static_cast<float64_t>(schedInfoTrack_.totalHcclImrecvCost) / oneUsForTick_;
        const uint64_t hcclImrecvNum = schedInfoTrack_.hcclImrecvNum;
        const float64_t avgHcclImrecvCost = (hcclImrecvNum == 0U) ?
            0.0 : totalHcclImrecvCost / static_cast<float64_t>(hcclImrecvNum);
        const float64_t maxHcclImrecvCost =
            static_cast<float64_t>(schedInfoTrack_.maxHcclImrecvCost) / oneUsForTick_;

        const auto maxRecvReqEventDelay = static_cast<float64_t>(schedInfoTrack_.recvReqEventMaxDelay) / oneUsForTick_;
        const auto minRecvReqEventDelay = static_cast<float64_t>(schedInfoTrack_.recvReqEventMinDelay) / oneUsForTick_;
        const float64_t avgRecvReqEventDelay = (recvReqEventCount_ == 0U) ? 0.0 :
            static_cast<float64_t>(schedInfoTrack_.recvReqEventTotalDelay) / recvReqEventCount_ / oneUsForTick_;

        const auto maxRecvCompEventDelay =
            static_cast<float64_t>(schedInfoTrack_.recvCompEventMaxDelay) / oneUsForTick_;
        const auto minRecvCompEventDelay =
            static_cast<float64_t>(schedInfoTrack_.recvCompEventMinDelay) / oneUsForTick_;
        const float64_t avgRecvCompEventDelay = (recvCompEventCount_ == 0U) ? 0.0 :
            static_cast<float64_t>(schedInfoTrack_.recvCompEventTotalDelay) / recvCompEventCount_ / oneUsForTick_;

        const auto maxSendCompEventDelay =
            static_cast<float64_t>(schedInfoTrack_.sendCompEventMaxDelay) / oneUsForTick_;
        const auto minSendCompEventDelay =
            static_cast<float64_t>(schedInfoTrack_.sendCompEventMinDelay) / oneUsForTick_;
        const float64_t avgSendCompEventDelay = (sendCompEventCount_ == 0U) ? 0.0 :
            static_cast<float64_t>(schedInfoTrack_.sendCompEventTotalDelay) / sendCompEventCount_ / oneUsForTick_;

        BQS_LOG_RUN_INFO("Hccl time cost info: {schedTimes[%lu], "
            "hcclIsend[HcomSendInfNum:%lu, HcomSendInfCost:%.2fus, average:%.2fus, max:%.2fus]}, "
            "HcclImrecv[HcomRecvInfNum:%lu, HcomRecvInfCost:%.2fus, average:%.2fus, max:%.2fus]}, "
            "recvReqEschedDelay[max: %.2fus, average: %.2fus, min: %.2fus], "
            "recvCompEschedDelay[max: %.2fus, average: %.2fus, min: %.2fus], "
            "sendCompEschedDelay[max: %.2fus, average: %.2fus, min: %.2fus].",
            count, hcclIsendNum, totalHcclIsendCost, avgHcclIsendCost, maxHcclIsendCost,
            hcclImrecvNum, totalHcclImrecvCost, avgHcclImrecvCost, maxHcclImrecvCost,
            maxRecvReqEventDelay, avgRecvReqEventDelay, minRecvReqEventDelay,
            maxRecvCompEventDelay, avgRecvCompEventDelay, minRecvCompEventDelay,
            maxSendCompEventDelay, avgSendCompEventDelay, minSendCompEventDelay);
    }
#else
    (void)Hiva::MarkerQueueSchedule(enqueEventTrack_);
#endif
}

void ProfileManager::DoErrorLog() const
{
    BQS_LOG_RUN_INFO("DoErrorLog:Time out info:{event:%u, state:%u, schedTimes:%lu, schedDelay:%lu ticks, "
        "startStamp:%lu, dequeueNum:%lu, enqueueNum:%lu, "
        "copyCost:%lu ticks, fullQueueNum:%u, srcQueueNum:%u, "
        "relationCost:%lu ticks, f2NFCost:%lu ticks, totalCost:%lu ticks}",
        enqueEventTrack_.event, enqueEventTrack_.state, enqueEventTrack_.schedTimes, enqueEventTrack_.schedDelay,
        enqueEventTrack_.startStamp, enqueEventTrack_.dequeueNum, enqueEventTrack_.enqueueNum,
        enqueEventTrack_.copyCost, enqueEventTrack_.fullQueueNum, enqueEventTrack_.srcQueueNum,
        enqueEventTrack_.relationCost, enqueEventTrack_.f2NFCost, enqueEventTrack_.totalCost);
}

BqsStatus ProfileManager::UpdateProfilingMode(const ProfilingMode mode)
{
    profMode_ = mode;
    if (profMode_ == bqs::ProfilingMode::PROFILING_OPEN) {
        ResetProfiling();
    }
    BQS_LOG_RUN_INFO("Success to update profiling mode:[%u].", static_cast<uint32_t>(mode));
    return BqsStatus::BQS_STATUS_OK;
}

ProfilingMode ProfileManager::GetProfilingMode() const
{
    return profMode_;
}

void ProfileManager::ResetProfiling()
{
    recvReqEventCount_.store(0UL);
    sendCompEventCount_.store(0UL);
    recvCompEventCount_.store(0UL);
    enqueueEventCount_.store(0UL);
    schedInfoTrack_.hcclIsendNum = 0UL;
    schedInfoTrack_.totalHcclIsendCost = 0UL;
    schedInfoTrack_.maxHcclIsendCost = 0UL;
    schedInfoTrack_.hcclImrecvNum = 0UL;
    schedInfoTrack_.totalHcclImrecvCost = 0UL;
    schedInfoTrack_.maxHcclImrecvCost = 0UL;
    schedInfoTrack_.recvReqEventTotalDelay = 0U;
    schedInfoTrack_.recvReqEventMaxDelay = 0U;
    schedInfoTrack_.recvReqEventMinDelay = 0U;
    schedInfoTrack_.recvCompEventTotalDelay = 0U;
    schedInfoTrack_.recvCompEventMaxDelay = 0U;
    schedInfoTrack_.recvCompEventMinDelay = 0U;
    schedInfoTrack_.sendCompEventTotalDelay = 0U;
    schedInfoTrack_.sendCompEventMaxDelay = 0U;
    schedInfoTrack_.sendCompEventMinDelay = 0U;
}
}  // namespace bqs