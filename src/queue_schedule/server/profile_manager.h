/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROFILE_MANAGER_H
#define PROFILE_MANAGER_H

#include <atomic>
#include <cstdint>
#include "queue_schedule/dgw_client.h"
#include "common/bqs_log.h"
#include "common/bqs_status.h"
#ifndef USE_PROFILER
#else
#include "hiperf_common.h"
#endif

namespace bqs {
#ifndef USE_PROFILER
struct QueueScheduleTrackTag {
    uint64_t schedDelay;
    uint64_t startStamp;
    uint64_t schedTimes;
    uint32_t event;
    uint32_t state;
    uint32_t recordThreshold;
    uint64_t dequeueNum;
    uint64_t enqueueNum;
    uint64_t copyCost;
    uint32_t fullQueueNum;
    uint32_t srcQueueNum;
    uint64_t relationCost;
    uint64_t f2NFCost;
    uint64_t totalCost;
};
using QueueScheduleTrack = QueueScheduleTrackTag;
#endif

// supplementary information in schedule track, only called in ENQUEUE thread
struct SchedInfoTrack {
    uint64_t hcclIsendNum;
    uint64_t totalHcclIsendCost;
    uint64_t maxHcclIsendCost;
    uint64_t hcclImrecvNum;
    uint64_t totalHcclImrecvCost;
    uint64_t maxHcclImrecvCost;
    uint64_t recvReqEventTotalDelay;
    uint64_t recvReqEventMaxDelay;
    uint64_t recvReqEventMinDelay;
    uint64_t recvCompEventTotalDelay;
    uint64_t recvCompEventMaxDelay;
    uint64_t recvCompEventMinDelay;
    uint64_t sendCompEventTotalDelay;
    uint64_t sendCompEventMaxDelay;
    uint64_t sendCompEventMinDelay;
};

// recv request info track, only called in RECEIVE_REQUEST_PROCESSED thread
struct EnvelopeProbeTrack {
    uint64_t schedTimes;  // event scheduled times
    uint64_t schedDelay;  // event scheduled delay
    uint64_t hcclImprobeNum;
    uint64_t totalHcclImprobeCost;
    uint64_t maxHcclImprobeCost;
    uint64_t hcclGetCountNum;
    uint64_t totalHcclGetCountCost;
    uint64_t maxHcclGetCountCost;
    uint64_t hcclImrecvNum;
    uint64_t totalHcclImrecvCost;
    uint64_t maxHcclImrecvCost;
    uint64_t mbufAllocNum;
    uint64_t totalMbufAllocCost;
    uint64_t maxMbufAllocCost;
};

// test some info track, called in RECEIVE_COMPLETION or SEND_COMPLETION thread
struct TestSomeInfoTrack {
    uint64_t schedTimes;  // event scheduled times
    uint64_t schedDelay;  // event scheduled delay
    uint64_t hcclTestSomeNum;
    uint64_t totalHcclTestSomeCost;
    uint64_t maxHcclTestSomeCost;
    uint64_t enqueueNum;
    uint64_t totalEnqueueCost;
    uint64_t maxEnqueueCost;
    uint64_t reqProcCompNum;
    uint64_t totalReqProcCompCost;
    uint64_t maxReqProcCompCost;
    uint64_t mbufFreeNum;
    uint64_t totalMbufFreeCost;
    uint64_t maxMbufFreeCost;
};

class ProfileManager {
public:
    static ProfileManager &GetInstance(const uint32_t resIndex = 0U);

    ProfileManager(const ProfileManager &) = delete;

    ProfileManager(ProfileManager &&) = delete;

    ProfileManager &operator=(const ProfileManager &) = delete;

    ProfileManager &operator=(ProfileManager &&) = delete;

    inline uint64_t GetCpuTick() const
    {
        uint64_t tick = 0UL;
#ifndef RUN_ON_X86
        GetAsmCpuTick(tick);
#else
        struct timespec ts;
        clock_gettime(CLOCK_MONOTONIC, &ts);
        tick = (ts.tv_sec * 1000000UL + ts.tv_nsec / 1000UL);
#endif
        return tick;
    };

    inline uint64_t GetSystemFreq() const
    {
        uint64_t freq = 1UL;
#ifndef RUN_ON_X86
        GetAsmSysFreq(freq);
#else
        freq = 1000000UL;
#endif
        return freq;
    };

    inline const float64_t GetTimeCost(const uint64_t tick) const
    {
        return static_cast<const float64_t>(tick) / oneUsForTick_;
    }

    void InitProfileManager(const uint32_t deviceId);

    /**
     * init maker
     * @return NA
     */
    void InitMaker(const uint64_t schedTimes, const uint64_t schedDelay);

    void SetSrcQueueNum(const uint32_t srcQueueNum);

    void AddEnqueueNum();

    void AddDequeueNum();

    void AddCopyTotalCost(const uint64_t copyCost);

    void SetRelationCost(const uint64_t relationCost);

    void Setf2NFCost(const uint64_t f2NFCost);

    /**
     * Init marker for receive request event
     * @param schedTimes event sched times
     * @param schedDelay event sched delay
     */
    void InitMarkerForRecvReqEvent(const uint64_t schedTimes, const uint64_t schedDelay);

    /**
     * Init marker for receive completion event
     * @param schedTimes event sched times
     * @param schedDelay event sched delay
     */
    void InitMarkerForRecvCompEvent(const uint64_t schedTimes, const uint64_t schedDelay);

    /**
     * Init marker for send completion event
     * @param schedTimes event sched times
     * @param schedDelay event sched delay
     */
    void InitMarkerForSendCompEvent(const uint64_t schedTimes, const uint64_t schedDelay);

    /**
     * Do marker for recv request event
     * @param startTick start tick
     */
    void DoMarkerForRecvReqEvent(const uint64_t startTick);

    /**
     * Do marker for recv completion event
     * @param startTick start tick
     */
    void DoMarkerForRecvCompEvent(const uint64_t startTick);

    /**
     * Do marker for send completion event
     * @param startTick start tick
     */
    void DoMarkerForSendCompEvent(const uint64_t startTick);

    /**
     * Add HcclImprobe cost
     * @param cost api cost
     */
    void AddHcclImprobeCost(const uint64_t cost);

    /**
     * Add HcclGetCount cost
     * @param cost api cost
     */
    void AddHcclGetCountCost(const uint64_t cost);

    /**
     * Add HcclImrecv cost
     * @param cost api cost
     */
    void AddHcclImrecvCost(const uint64_t cost);

    /**
     * Add HcclTestSome cost
     * @param cost api cost
     * @param isRecvCompEvent is receive completion event
     */
    void AddHcclTestSomeCost(const uint64_t cost, const bool isRecvCompEvent);

    /**
     * Add request process completed cost
     * @param cost api cost
     * @param isRecvCompEvent is receive completion event
     * @return time cost (us)
     */
    const float64_t AddReqProcCompCost(const uint64_t cost, const bool isRecvCompEvent);

    /**
     * Add HcclIsend cost
     * @param cost api cost
     */
    void AddHcclIsendCost(const uint64_t cost);

    /**
     * Add mbuf alloc cost
     * @param cost api cost
     */
    void AddMbufAllocCost(const uint64_t cost);

    /**
     * Add enqueue cost for hccl
     * @param cost api cost
     */
    void AddHcclEnqueueCost(const uint64_t cost);

    /**
     * Add mbuf free cost
     * @param cost api cost
     */
    void AddMbufFreeCost(const uint64_t cost);

    /**
     * maker profile
     * @return NA
     */
    void DoMarker();

    /**
     * try to profile
     * @return NA
     */
    void TryMarker(const uint64_t startTick);

    void DoErrorLog() const;

    /**
     * process update profiling mode
     * @return BQS_STATUS_OK: success, other: failed.
     */
    BqsStatus UpdateProfilingMode(const ProfilingMode mode);

    /**
     * get profiling mode
     * @return ProfilingMode
     */
    ProfilingMode GetProfilingMode() const;

    /**
     * reset profiling
     */
    void ResetProfiling();

    void Uninit() const;

private:
    ProfileManager();

    ~ProfileManager() = default;

    inline void GetAsmSysFreq(uint64_t &freq) const
    {
#ifndef RUN_ON_X86
        asm volatile("mrs %0, CNTFRQ_EL0" : "=r"(freq) :);
#endif
    }

    inline void GetAsmCpuTick(uint64_t &tick) const
    {
#ifndef RUN_ON_X86
        asm volatile("mrs %0, CNTVCT_EL0" : "=r"(tick) :);
#endif
    }

#ifndef USE_PROFILER
    QueueScheduleTrack enqueEventTrack_;
#else
    Hiva::QueueScheduleTrack enqueEventTrack_;
#endif

    float64_t frequence_;
    uint64_t profThresholdTick_;
    uint64_t logThresholdTick_;
    float64_t oneUsForTick_;
    // profiling mode
    ProfilingMode profMode_;
    // schedule supplementary information
    SchedInfoTrack schedInfoTrack_;
    // receive request info track
    EnvelopeProbeTrack recvReqEventTrack_;
    // receive completion info track
    TestSomeInfoTrack recvCompEventTrack_;
    // send completion info track
    TestSomeInfoTrack sendCompEventTrack_;
    //need strict profiling threshold
    bool aicpuFeatureUseErrorLogThreshold_;
    // recv request event count
    std::atomic<uint64_t> recvReqEventCount_;
    // send completion event count
    std::atomic<uint64_t> sendCompEventCount_;
    // recv completion event count
    std::atomic<uint64_t> recvCompEventCount_;
    // enqueue event count
    std::atomic<uint64_t> enqueueEventCount_;
};
}      // namespace bqs
#endif  // PROFILE_MANAGER_H