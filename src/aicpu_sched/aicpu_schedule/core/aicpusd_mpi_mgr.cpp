/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_mpi_mgr.h"
#include <chrono>
#include <cmath>
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpu_pulse.h"

namespace AicpuSchedule {
namespace mpi {
namespace {
// time interval of print mpi dvpp event
constexpr uint32_t PRINT_MPI_DVPP_RECORD_IN_SECOND = 5U;
}

MpiDvppStatisticManager &MpiDvppStatisticManager::Instance()
{
    static MpiDvppStatisticManager statisticManagerInstance;
    return statisticManagerInstance;
}

MpiDvppStatisticManager::~MpiDvppStatisticManager()
{
    (void)PrintStatisticInfo();
}

void MpiDvppStatisticManager::OnPulse(const MpiDvppTimePoint &nowTimePoint)
{
    const float64_t duration = std::chrono::duration<float64_t>(nowTimePoint - lastTimePoint_).count();
    if (round(duration) < static_cast<float64_t>(PRINT_MPI_DVPP_RECORD_IN_SECOND)) {
        return;
    }
    (void)PrintStatisticInfo();
    lastTimePoint_ = nowTimePoint;
}

int32_t MpiDvppStatisticManager::PrintStatisticInfo() const
{
    aicpusd_run_info("Mpi Dvpp event statistics: [%lld]", mpiEventStatistic_.load());
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}

void MpiDvppStatisticManager::Record()
{
    mpiEventStatistic_++;
}

void MpiDvppStatisticManager::InitMpiDvpp()
{
    if (!registerFlag_.load()) {
        const std::lock_guard<std::mutex> lk(registerFlagMutex_);
        if (!registerFlag_.load()) {
            (void)RegisterPulseNotifyFunc("MpiDvppKernel", &AicpuSchedule::mpi::MpiDvppPulse::MpiDvppPulseNotify);
            registerFlag_.store(true);
        }
    }
}
MpiDvppPulseListener *MpiDvppPulse::pulseListener_ = &MpiDvppStatisticManager::Instance();

void MpiDvppPulse::MpiDvppPulseNotify()
{
    const auto nowTime = std::chrono::high_resolution_clock::now();
    pulseListener_->OnPulse(nowTime);
}
} // namespace mpi
}
