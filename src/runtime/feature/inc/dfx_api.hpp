/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_DFX_API_HPP
#define CCE_RUNTIME_DFX_API_HPP

#include "base.hpp"

namespace cce {
namespace runtime {

static inline uint64_t GetTimeInterval(const mmTimespec &beginTime)
{
    const mmTimespec endTime = mmGetTickCount();
    const uint64_t beginCnt = static_cast<uint64_t>(beginTime.tv_sec) * RT_MS_PER_S +
        static_cast<uint64_t>(beginTime.tv_nsec) / RT_MS_TO_NS;
    const uint64_t endCnt = static_cast<uint64_t>(endTime.tv_sec) * RT_MS_PER_S +
        static_cast<uint64_t>(endTime.tv_nsec) / RT_MS_TO_NS;

    return (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;
}

static inline uint64_t ClockGetTimeUs()
{
    // clock_gettime is *much* faster than std::chrono implementation on Linux
    struct timespec t{};
    (void)clock_gettime(CLOCK_MONOTONIC, &t);
    return static_cast<uint64_t>(t.tv_sec) * 1000000UL + static_cast<uint64_t>(t.tv_nsec) / 1000UL;
}

static inline uint64_t ClockGetTimeIntervalUs(const uint64_t beginTime)
{
    const uint64_t endTime = static_cast<uint64_t>(ClockGetTimeUs());
    return (endTime > beginTime) ? (endTime - beginTime) : 0ULL;
}

}
}

#endif // CCE_RUNTIME_DFX_API_HPP
