/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_SHARDER_TIMER_H
#define AICPU_SHARDER_TIMER_H

#include <mutex>
#include <atomic>
#include <functional>
#include <unordered_map>
#include "aicpu_timer_api.h"

namespace aicpu {
    using StartMonitorFunc = std::function<void(const TimerHandle, const uint32_t)>;
    using StopMonitorFunc = std::function<void(const TimerHandle)>;

    enum class TimerStatus : int32_t {
        AICPU_TIMER_SUCCESS,
        AICPU_TIMER_FAILED
    };

    class AicpuTimer {
    public:
        AicpuTimer() : startTimerFunc_{nullptr},
                       stopTimerFunc_{nullptr},
                       timerHandleCnt_(0U),
                       isSupportTimer_(false) {}
        ~AicpuTimer() {}

        static AicpuTimer &GetInstance();
        void SetSupportTimer(const bool flag);
        void RegistMonitorFunc(const StartMonitorFunc &startFunc, const StopMonitorFunc &stopFunc);
        TimerStatus StartTimer(TimerHandle &timerHandle, const TimeoutCallback &callback, const uint32_t timeInS);
        TimerStatus StopTimer(const TimerHandle timerHandle);
        void CallTimeoutCallback(const TimerHandle timerHandle);

    private:
        TimerStatus RegistTimeoutCallback(const TimerHandle timerHandle, const TimeoutCallback &callback);
        TimerStatus UnregistTimeoutCallback(const TimerHandle timerHandle);

        TimerStatus StartTimerInMonitor(const TimerHandle timerHandle, const uint32_t timeInS) const;
        TimerStatus StopTimerInMonitor(const TimerHandle timerHandle) const;

        AicpuTimer(const AicpuTimer &) = delete;
        AicpuTimer &operator=(const AicpuTimer &) = delete;
        AicpuTimer(AicpuTimer &&) = delete;
        AicpuTimer &operator=(AicpuTimer &&) = delete;

        std::mutex timeoutCbkMapMutex_;
        std::unordered_map<TimerHandle, TimeoutCallback> timeoutCbkMap_; // key is timerHandle
        StartMonitorFunc startTimerFunc_;
        StopMonitorFunc stopTimerFunc_;
        std::mutex timerHandleMutex_;
        TimerHandle timerHandleCnt_;
        std::atomic<bool> isSupportTimer_;
    };
}  // namespace aicpu
#endif // AICPU_SHARDER_TIMER_H
