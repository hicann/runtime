/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_PROFILER_H
#define CORE_AICPUSD_PROFILER_H

#include <thread>
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "hiperf_common.h"
#include "aicpusd_feature_ctrl.h"

namespace AicpuSchedule {
    class AicpuProfiler {
    public:
        AicpuProfiler() noexcept;

        ~AicpuProfiler() = default;

        void Uninit();

        void Profiler();

        __attribute__((visibility("default"))) static void ProfilerAgentInit();

        void InitProfiler(const pid_t processId, const pid_t threadId);

        Hiva::KernelTrack GetKernelTrack() const
        {
            return kernelTrack_;
        }

        void SetEventId(const uint32_t kernelTrackEventId)
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.eventId = kernelTrackEventId;
        }

        void SetMbufHead(const void *const mbuf)
        {
            if (!hiperfExisted_) {
                return;
            }
            if (mbuf != nullptr) {
                // 40/44 is the offset of timestamp, 36 is the offset of sequenece id (ROS)
                uint32_t *const seqId = reinterpret_cast<uint32_t *>(reinterpret_cast<uintptr_t>(mbuf) + 36UL);
                uint32_t *const sec = reinterpret_cast<uint32_t *>(reinterpret_cast<uintptr_t>(mbuf) + 40UL);
                uint32_t *const nsec = reinterpret_cast<uint32_t *>(reinterpret_cast<uintptr_t>(mbuf) + 44UL);
                // Take the upper eight bits of data
                kernelTrack_.sensorId = (*seqId) >> 24U;
                if (FeatureCtrl::IsAosCore()) {
                    kernelTrack_.rawStamp.tv_sec = static_cast<time_t>(*sec);
                } else {
                    kernelTrack_.rawStamp.tv_sec = static_cast<__time_t>(*sec);
                }
                kernelTrack_.rawStamp.tv_nsec = static_cast<int64_t>(*nsec);
                kernelTrack_.uniqueId = (*seqId & 0X000FFFFFU);
            }
        }

        void SetModelId(const uint32_t modelId)
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.modelId = modelId;
        }

        void SetStreamId(const uint32_t streamId)
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.streamId = streamId;
        }

        void SetTsStreamId(const uint32_t tsStreamId)
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.tsStreamId = tsStreamId;
        }

        void SetQueueId(const uint32_t queueId)
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.queueId = queueId;
        }

        uint64_t SchedGetCurCpuTick(void) const;

        uint64_t GetAicpuSysFreq() const;

        void SetDqStart()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.dqStart = SchedGetCurCpuTick();
        }

        void SetDqEnd()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.dqEnd = SchedGetCurCpuTick();
        }

        void SetModelStart()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.modelStart = SchedGetCurCpuTick();
        }

        void SetPrepareOutStart()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.prepareOutStart = SchedGetCurCpuTick();
        }

        void SetPrepareOutEnd()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.prepareOutEnd = SchedGetCurCpuTick();
        }

        void SetActiveStream()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.activeStream = SchedGetCurCpuTick();
        }

        void SetEndGraph()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.endGraph = SchedGetCurCpuTick();
        }

        void SetEqStart()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.eqStart = SchedGetCurCpuTick();
        }

        void SetEqEnd()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.eqEnd = SchedGetCurCpuTick();
        }

        void SetModelEnd()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.modelEnd = SchedGetCurCpuTick();
        }

        void SetRepeatStart()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.repeatStart = SchedGetCurCpuTick();
        }

        void SetRepeatEnd()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.repeatEnd = SchedGetCurCpuTick();
        }

        void SetProcEventStart()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.procEventStart = SchedGetCurCpuTick();
        }

        void SetProcEventEnd()
        {
            if (!hiperfExisted_) {
                return;
            }
            kernelTrack_.procEventEnd = SchedGetCurCpuTick();
        }

        inline bool GetHiperfSoStatus() const
        {
            return ((!accessHiperfSo_) || (hiperfExisted_));
        }

    private:

        AicpuProfiler(const AicpuProfiler &) = delete;

        AicpuProfiler &operator=(const AicpuProfiler &) = delete;

        uint64_t BuildKey();

        pid_t pid_;
        pid_t tid_;
        Hiva::KernelTrack kernelTrack_;
        float64_t frequence_;
        bool hiperfExisted_;
        bool accessHiperfSo_;
        uint64_t oneMsForTick_;
        uint64_t tenMsForTick_;
    };

    extern thread_local AicpuProfiler g_aicpuProfiler;
}

#endif // CORE_AICPUSD_PROFILER_H
