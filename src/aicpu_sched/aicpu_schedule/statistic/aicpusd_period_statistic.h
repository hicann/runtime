/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef STATISTIC_AICPUSD_PERIOD_STATISTIC_H
#define STATISTIC_AICPUSD_PERIOD_STATISTIC_H

#include <atomic>
#include <mutex>
#include <semaphore.h>
#include <thread>
#include "aicpusd_proc_mem_statistic.h"
#include "aicpusd_model_statistic.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpu_context.h"

namespace AicpuSchedule {
    class AicpuSdPeriodStatistic {
    public:
        static AicpuSdPeriodStatistic &GetInstance();
        void InitStatistic(const uint32_t deviceId, const uint32_t hostPid, const aicpu::AicpuRunMode runMode);
        void StopStatistic();
        void PrintOutStatisticInfo(const aicpu::AicpuRunMode runMode);
        int32_t SetThreadAffinity() const;
    private:
        AicpuSdPeriodStatistic();
        void DoStatistic() noexcept;
        virtual ~AicpuSdPeriodStatistic();
        std::atomic<bool> initFlag_;
        bool runningFlag_;
        uint32_t deviceId_;
        uint32_t hostPid_;
        std::thread statThread_;
        std::mutex initMutex_;
        AicpuSdProcMemStatistic procMemInfo_;
    };
}
#endif