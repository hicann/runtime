/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_sharder.h"
#include "aicpu_context.h"
#include "aicpu_sharder_log.h"
#include "aicpu_timer.h"

namespace aicpu {

AicpuTimer &AicpuTimer::GetInstance()
{
    static AicpuTimer instance;
    return instance;
}

void AicpuTimer::SetSupportTimer(const bool flag)
{
    isSupportTimer_ = flag;
}

void AicpuTimer::RegistMonitorFunc(const StartMonitorFunc &startFunc, const StopMonitorFunc &stopFunc)
{
    startTimerFunc_ = startFunc;
    stopTimerFunc_ = stopFunc;

    return;
}

TimerStatus AicpuTimer::StartTimer(TimerHandle &timerHandle, const TimeoutCallback &callback, const uint32_t timeInS)
{
    if (!isSupportTimer_) {
        AICPUE_LOGI("No need start timer");
        return TimerStatus::AICPU_TIMER_SUCCESS;
    }

    if (callback == nullptr) {
        AICPUE_LOGE("Async timer callback is null.");
        return TimerStatus::AICPU_TIMER_FAILED;
    }

    {
        const std::lock_guard<std::mutex> lk(timerHandleMutex_);
        ++timerHandleCnt_;
        timerHandle = timerHandleCnt_;
    }

    TimerStatus ret = RegistTimeoutCallback(timerHandle, callback);
    if (ret != TimerStatus::AICPU_TIMER_SUCCESS) {
        AICPUE_LOGE("Regist op timeout callback func failed, ret=%d, TimerHandle=%lu.", static_cast<int32_t>(ret),
                    timerHandle);
        return ret;
    }

    ret = StartTimerInMonitor(timerHandle, timeInS);
    if (ret != TimerStatus::AICPU_TIMER_SUCCESS) {
        AICPUE_LOGE("Start op timer failed, ret=%d, TimerHandle=%lu.", static_cast<int32_t>(ret), timerHandle);
        return ret;
    }

    AICPUE_LOGI("Start op timer success, TimerHandle=%lu.", timerHandle);

    return ret;
}

TimerStatus AicpuTimer::StopTimer(const TimerHandle timerHandle)
{
    if ((!isSupportTimer_) && (timeoutCbkMap_.empty())) {
        AICPUE_LOGI("No need stop timer");
        return TimerStatus::AICPU_TIMER_SUCCESS;
    }

    TimerStatus ret = StopTimerInMonitor(timerHandle);
    if (ret != TimerStatus::AICPU_TIMER_SUCCESS) {
        AICPUE_LOGE("Stop op timer failed, ret=%d, TimerHandle=%lu.", static_cast<int32_t>(ret), timerHandle);
        return ret;
    }

    ret = UnregistTimeoutCallback(timerHandle);
    if (ret != TimerStatus::AICPU_TIMER_SUCCESS) {
        AICPUE_LOGE("Unregist op timeout callback func failed, ret=%d, TimerHandle=%lu.", static_cast<int32_t>(ret),
                    timerHandle);
        return ret;
    }

    AICPUE_LOGI("Stop op timer success, TimerHandle=%lu.", timerHandle);

    return ret;
}

void AicpuTimer::CallTimeoutCallback(const TimerHandle timerHandle)
{
    {
        const std::lock_guard<std::mutex> lk(timeoutCbkMapMutex_);
        const auto iter = timeoutCbkMap_.find(timerHandle);
        if (iter == timeoutCbkMap_.end()) {
            AICPUE_LOGE("Call timeout callback func, TimerHandle=%lu.", timerHandle);
            return;
        }

        iter->second();
    }

    return;
}

TimerStatus AicpuTimer::RegistTimeoutCallback(const TimerHandle timerHandle, const TimeoutCallback &callback)
{
    {
        const std::lock_guard<std::mutex> lk(timeoutCbkMapMutex_);
        const auto ret = timeoutCbkMap_.emplace(timerHandle, callback);
        if (!ret.second) {
            AICPUE_LOGE("Register timeout callback func in map failed, TimerHandle=%u.", timerHandle);
            return TimerStatus::AICPU_TIMER_FAILED;
        }
    }

    return TimerStatus::AICPU_TIMER_SUCCESS;
}

TimerStatus AicpuTimer::UnregistTimeoutCallback(const TimerHandle timerHandle)
{
    {
        const std::lock_guard<std::mutex> lk(timeoutCbkMapMutex_);
        const auto eraseNum = timeoutCbkMap_.erase(timerHandle);
        if (eraseNum <= 0) {
            AICPUE_LOGE("Erase op callback in map failed, TimerHandle=%u.", timerHandle);
            return TimerStatus::AICPU_TIMER_FAILED;
        }
    }

    return TimerStatus::AICPU_TIMER_SUCCESS;
}

TimerStatus AicpuTimer::StartTimerInMonitor(const TimerHandle timerHandle, const uint32_t timeInS) const
{
    if (startTimerFunc_ == nullptr) {
        AICPUE_LOGE("Start op timer failed by nullptr.");
        return TimerStatus::AICPU_TIMER_FAILED;
    }

    startTimerFunc_(timerHandle, timeInS);

    return TimerStatus::AICPU_TIMER_SUCCESS;
}

TimerStatus AicpuTimer::StopTimerInMonitor(const TimerHandle timerHandle) const
{
    if (stopTimerFunc_ == nullptr) {
        AICPUE_LOGE("Stop op timer failed by nullptr");
        return TimerStatus::AICPU_TIMER_FAILED;
    }

    stopTimerFunc_(timerHandle);

    return TimerStatus::AICPU_TIMER_SUCCESS;
}

bool StartTimer(TimerHandle &timerHandle, const TimeoutCallback &callBack, const uint32_t timeInS)
{
    return AicpuTimer::GetInstance().StartTimer(timerHandle, callBack, timeInS) ==
           TimerStatus::AICPU_TIMER_SUCCESS ? true : false;
}

void StopTimer(const TimerHandle timerHandle)
{
    (void)AicpuTimer::GetInstance().StopTimer(timerHandle);
}
} // namespace aicpu
