/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CORE_AICPUSD_MPI_MGR_H
#define CORE_AICPUSD_MPI_MGR_H

#include <chrono>
#include <vector>
#include <mutex>
#include <atomic>

namespace AicpuSchedule {
namespace mpi {
// for future more another MpiDvpp event
class MpiDvppPulseListener {
public:
    using MpiDvppTimePoint = std::chrono::high_resolution_clock::time_point;

    MpiDvppPulseListener() = default;

    virtual ~MpiDvppPulseListener() = default;

    virtual void OnPulse(const MpiDvppTimePoint &nowTimePoint) = 0;

private:
    MpiDvppPulseListener(const MpiDvppPulseListener &) = delete;
    MpiDvppPulseListener &operator = (const MpiDvppPulseListener &) = delete;
    MpiDvppPulseListener(MpiDvppPulseListener &&) = delete;
    MpiDvppPulseListener &operator = (MpiDvppPulseListener &&) = delete;
};

class MpiDvppStatisticManager : public MpiDvppPulseListener {
public:
    using MpiDvppTimePoint = std::chrono::high_resolution_clock::time_point;
    static MpiDvppStatisticManager &Instance();

    ~MpiDvppStatisticManager() override;

    /**
     * @ingroup mpi
     * @brief it is used to print statistics at regular intervals
     * @param [in] MpiDvppTimePoint: current time
     */
    void OnPulse(const MpiDvppTimePoint &nowTimePoint) override;

    /**
     * @ingroup mpi
     * @brief register notify function
     */
    void InitMpiDvpp();

    /**
     * @ingroup mpi
     * @brief record mpi dvpp event
     */
    void Record();

    /**
     * @ingroup mpi
     * @brief print statistic data of mpi dvpp event
     */
    int32_t PrintStatisticInfo() const;

private:
    MpiDvppStatisticManager()
        : MpiDvppPulseListener(),
          lastTimePoint_(std::chrono::high_resolution_clock::now()),
          mpiEventStatistic_(0UL),
          registerFlag_(false)
    {}

    // last time of print statistic
    MpiDvppTimePoint lastTimePoint_;
    // statistic of receive mpi dvpp event
    std::atomic<uint64_t> mpiEventStatistic_;
    // mutex for register notify function
    std::mutex registerFlagMutex_;
    // flag of first register notify function
    std::atomic<bool> registerFlag_;
};

class MpiDvppPulse {
public:
    /**
     * @ingroup mpi
     * @brief it is used to print statistics at regular intervals
     */
    static void MpiDvppPulseNotify();

private:
    static MpiDvppPulseListener *pulseListener_;
};
} // namespace mpi
}

#endif // CORE_AICPUSD_MPI_MGR_H