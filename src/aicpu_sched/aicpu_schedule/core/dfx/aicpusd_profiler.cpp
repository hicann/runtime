/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_profiler.h"
#include "hiperf_marker.h"
#include "hiperf_exception.h"
#include "aicpusd_common.h"

namespace AicpuSchedule {
    namespace {
        constexpr float64_t SECOND_TO_NANO = 1000000000.0;
        constexpr float64_t ONE_MS = 1000000.0;
        constexpr uint32_t HIGH_POISTION_OFFSET_64_BIT = 32U;
        constexpr uint32_t HIGH_POISTION_OFFSET_32_BIT = 16U;
        constexpr uint32_t LOW_POISTION_MASK_32_BIT = 0x0000ffffU;
        const std::string HIPERF_LIB_PATH = "/usr/lib64/libhiperf_executor.so";
    }

    /**
     * @ingroup AicpuProfiler
     * @brief it is used to construct a object of AicpuScheduleCore.
     */
    AicpuProfiler::AicpuProfiler() noexcept
        : pid_(0),
          tid_(0),
          kernelTrack_({0UL}),
          frequence_(0.0),
          hiperfExisted_(false),
          accessHiperfSo_(false),
          oneMsForTick_(0UL),
          tenMsForTick_(0UL) {}

    /**
     * @ingroup AicpuProfiler
     * @brief it is used to destructor a object of AicpuProfiler.
     */
    void AicpuProfiler::Uninit()
    {
        ::FiniMarker();
    }

    void AicpuProfiler::InitProfiler(const pid_t processId, const pid_t threadId)
    {
        if (!accessHiperfSo_) {
            if (access(HIPERF_LIB_PATH.c_str(), F_OK) == 0) {
                hiperfExisted_ = true;
            }
            accessHiperfSo_ = true;
        } else {
            if (!hiperfExisted_) {
                return;
            }
        }
        kernelTrack_ = {0UL};
        pid_ = processId;
        tid_ = threadId;

        if (tenMsForTick_ == 0UL) {
            frequence_ = static_cast<float64_t>(GetAicpuSysFreq());
            const float64_t oneMsForTickTemp = ONE_MS / (SECOND_TO_NANO / frequence_);
            oneMsForTick_ = static_cast<uint64_t>(oneMsForTickTemp);
            tenMsForTick_ = oneMsForTick_ * 10UL;
        }
    }

    void AicpuProfiler::ProfilerAgentInit()
    {
        ::InitMarker();
    }

    void AicpuProfiler::Profiler()
    {
        if (!hiperfExisted_) {
            return;
        }
        kernelTrack_.pid = pid_;
        kernelTrack_.tid = static_cast<int32_t>(GetTid());
        (void)Hiva::MarkerAicpuScheduler(kernelTrack_);
        const uint64_t prefKey = BuildKey();
        if (kernelTrack_.activeStream != 0UL) {
            (void)Hiva::PerfDurationBegin(prefKey, kernelTrack_.activeStream);
        } else if (kernelTrack_.endGraph != 0UL) {
            (void)Hiva::PerfDurationEnd(prefKey, kernelTrack_.endGraph, tenMsForTick_, kernelTrack_);
        } else {
            return;
        }
    }

    uint64_t AicpuProfiler::BuildKey()
    {
        const uint64_t key = (static_cast<uint64_t>(kernelTrack_.modelId) << HIGH_POISTION_OFFSET_64_BIT) |
            ((static_cast<uint64_t>(kernelTrack_.rawStamp.tv_sec) & LOW_POISTION_MASK_32_BIT) <<
            HIGH_POISTION_OFFSET_32_BIT) |
            (static_cast<uint64_t>(kernelTrack_.rawStamp.tv_nsec) & LOW_POISTION_MASK_32_BIT);
        return key;
    }

    uint64_t AicpuProfiler::SchedGetCurCpuTick(void) const
    {
        uint64_t cnt = 0UL;
#ifndef RUN_TEST
            asm volatile("mrs %0, CNTVCT_EL0" : "=r"(cnt) :);
#endif
        return cnt;
    }

    uint64_t AicpuProfiler::GetAicpuSysFreq() const
    {
        uint64_t freq = 1UL;
#ifndef RUN_TEST
            asm volatile("mrs %0, CNTFRQ_EL0" : "=r"(freq) :);
#endif
        return freq;
    }

    thread_local AicpuProfiler g_aicpuProfiler;
}
