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
#include "aicpusd_common.h"

namespace AicpuSchedule {
    /**
     * @ingroup AicpuProfiler
     * @brief it is used to construct a object of AicpuScheduleCore.
     */
    AicpuProfiler::AicpuProfiler() noexcept
        : pid_(0),
          tid_(0),
          kernelTrack_({}),
          frequence_(0.0),
          hiperfExisted_(false),
          accessHiperfSo_(false),
          oneMsForTick_(0UL),
          tenMsForTick_(0UL) {}

    void AicpuProfiler::Uninit() {}

    void AicpuProfiler::InitProfiler(pid_t pid, pid_t tid)
    {
        pid_ = pid;
        tid_ = tid;
    }

    void AicpuProfiler::ProfilerAgentInit() {}

    void AicpuProfiler::Profiler() {}

    uint64_t AicpuProfiler::SchedGetCurCpuTick(void) const
    {
        return 0UL;
    }

    uint64_t AicpuProfiler::GetAicpuSysFreq() const
    {
        return 1UL;
    }

    thread_local AicpuProfiler g_aicpuProfiler;
}
