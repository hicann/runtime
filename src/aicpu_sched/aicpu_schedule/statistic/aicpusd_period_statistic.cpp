/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_period_statistic.h"

#include <errno.h>
#include <cstdio>
#include "aicpusd_util.h"
#include "aicpusd_drv_manager.h"
namespace AicpuSchedule {
    namespace {
        // 循环一次100ms
        constexpr const uint64_t STATISTIC_LOOP_PERIOD = 100UL;
        constexpr const uint64_t SECOND_TO_MS = 1000UL;
        constexpr const uint64_t MS_TO_US = 1000UL;
        constexpr const uint64_t PROC_MEM_PERIOD = 10U;
    }

    AicpuSdPeriodStatistic::AicpuSdPeriodStatistic()
        : initFlag_(false), runningFlag_(false), deviceId_(0U), hostPid_(0U)
    {
    }

    AicpuSdPeriodStatistic &AicpuSdPeriodStatistic::GetInstance()
    {
        static AicpuSdPeriodStatistic instance;
        return instance;
    }

    AicpuSdPeriodStatistic::~AicpuSdPeriodStatistic()
    {
        StopStatistic();
    }

    void AicpuSdPeriodStatistic::StopStatistic()
    {
        aicpusd_info("StopStatistic start");
        const std::lock_guard<std::mutex> lk(initMutex_);
        if (!initFlag_) {
            aicpusd_info("already uninit no need uninit");
            return;
        }
        runningFlag_ = false;
        initFlag_ = false;
        if (statThread_.joinable()) {
            statThread_.join();
        }
        aicpusd_info("StopStatistic finish");
    }

    void AicpuSdPeriodStatistic::DoStatistic() noexcept
    {
        if (SetThreadAffinity() != AICPU_SCHEDULE_OK) {
            aicpusd_run_warn("stat thread bind core nok.");
            return;
        }
        constexpr uint64_t procMemPeriod = PROC_MEM_PERIOD * SECOND_TO_MS / STATISTIC_LOOP_PERIOD;
        uint64_t loopCnt = 0UL;
        while (runningFlag_) {
            if (loopCnt % procMemPeriod == 0) {
                procMemInfo_.StatisticProcMemInfo();
            }
            loopCnt++;
            (void)usleep(STATISTIC_LOOP_PERIOD * MS_TO_US);
        }
        aicpusd_run_info("DoStatistic running over");
    }

    void AicpuSdPeriodStatistic::PrintOutStatisticInfo(const aicpu::AicpuRunMode runMode)
    {
        if (runMode == aicpu::AicpuRunMode::PROCESS_SOCKET_MODE || (AicpuUtil::IsFpga())) {
            aicpusd_info("socket mode no need this statistic");
            return;
        }
        procMemInfo_.PrintOutProcMemInfo(hostPid_);
    }

    void AicpuSdPeriodStatistic::InitStatistic(const uint32_t deviceId, const uint32_t hostPid,
                                               const aicpu::AicpuRunMode runMode)
    {
        if ((runMode == aicpu::AicpuRunMode::PROCESS_SOCKET_MODE) || (AicpuUtil::IsFpga())) {
            aicpusd_info("socket or fpga mode no need this statistic");
            return;
        }
        const std::lock_guard<std::mutex> lk(initMutex_);
        if (initFlag_) {
            aicpusd_info("already init before");
            return;
        }
        deviceId_ = deviceId;
        runningFlag_ = true;
        hostPid_ = hostPid;
        aicpusd_info("start init static devid:%u, hostpid:%u", deviceId_, hostPid_);
        if (!procMemInfo_.InitProcMemStatistic()) {
            aicpusd_err("InitProcMemStatistic failed");
            return;
        }

        try {
            statThread_ = std::thread(&AicpuSdPeriodStatistic::DoStatistic, this);
        } catch (std::exception &e) {
            aicpusd_err("create thread file:%s", e.what());
            return;
        }
        initFlag_ = true;
    }

    int32_t AicpuSdPeriodStatistic::SetThreadAffinity() const
    {
        std::vector<uint32_t> ccpuIds = AicpuDrvManager::GetInstance().GetCcpuList();
        if (ccpuIds.empty()) {
            aicpusd_run_info("ccpu list is empty no need bind core");
            return AICPU_SCHEDULE_OK;
        }
        const pthread_t threadId = pthread_self();
        cpu_set_t cpuset;
        for (const auto cpuId: ccpuIds) {
            CPU_SET(cpuId, &cpuset);
            aicpusd_info("prepare bind threadId=%lu to cpuId=%u", threadId, static_cast<uint32_t>(cpuId));
        }
        const int32_t ret = pthread_setaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
        if (ret != 0) {
            aicpusd_run_warn("aicpu bind tid by self, res[%d], reason[%s].", ret, strerror(errno));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        } else {
            aicpusd_run_info("aicpu bind by self success");
            return AICPU_SCHEDULE_OK;
        }
    }
}