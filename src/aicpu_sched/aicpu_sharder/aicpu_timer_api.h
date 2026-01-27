/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_TIMER_API_H
#define AICPU_TIMER_API_H

#include <functional>

namespace aicpu {
    using TimeoutCallback = std::function<void()>;
    using TimerHandle = uint64_t;

    /**
     * Start the timer
     * @param [out]timerHandle: The timer handle
     * @param [in]TimeoutCallback: The struct for timer config
     * @param [in]timeInS: Timeout in seconds
     * @return bool success of failed
     */
    bool __attribute__((weak)) StartTimer(TimerHandle &timerHandle, const TimeoutCallback &callBack,
                                          const uint32_t timeInS);

    /**
     * Stop the timer
     * @param [in]timerHandle: The struct for timer config
     * @return void
     */
    void __attribute__((weak)) StopTimer(const TimerHandle timerHandle);
} // namespace aicpu
#endif // AICPU_SHARDER_TIMER_API_H
