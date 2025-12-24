/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_JOB_ADAPTER_H
#define ANALYSIS_DVVP_JOB_ADAPTER_H

#include <vector>
#include "message/prof_params.h"
#include "platform/platform.h"
#include "utils/utils.h"
#include "errno/error_code.h"
#include "ai_drv_dev_api.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Platform;
struct PMUEventsConfig {
    std::vector<std::string> ctrlCPUEvents;
    std::vector<std::string> tsCPUEvents;
    std::vector<std::string> aiCoreEvents;
    std::vector<int32_t> aiCoreEventsCoreIds;
    std::vector<std::string> llcEvents;
    std::vector<std::string> ddrEvents;
    std::vector<std::string> aivEvents;
    std::vector<std::string> hbmEvents;
    std::vector<int32_t> aivEventsCoreIds;
};

class JobAdapter {
public:
    JobAdapter()
        : hostCntvctStart_(0),
          hostMonotonicStart_(0),
          hostCntvctDiff_(0),
          devMonotonic_(0),
          devCntvct_(0) {}
    virtual ~JobAdapter() {}

public:
    virtual int32_t StartProf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) = 0;
    virtual int32_t StopProf(void) = 0;

public:
    virtual const analysis::dvvp::message::StatusInfo& GetLastStatus()
    {
        return status_;
    }
    SHARED_PTR_ALIA<PMUEventsConfig> CreatePmuEventConfig(
        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params, int32_t devId) const
    {
        SHARED_PTR_ALIA<PMUEventsConfig> pmuEventsConfig = nullptr;
        MSVP_MAKE_SHARED0(pmuEventsConfig, PMUEventsConfig, return nullptr);
        pmuEventsConfig->ctrlCPUEvents = Utils::Split(params->ai_ctrl_cpu_profiling_events, false, "", ",");
        pmuEventsConfig->tsCPUEvents   = Utils::Split(params->ts_cpu_profiling_events, false, "", ",");
        pmuEventsConfig->hbmEvents     = Utils::Split(params->hbm_profiling_events, false, "", ",");
        pmuEventsConfig->aiCoreEvents  = Utils::Split(params->ai_core_profiling_events, false, "", ",");
        if (!params->hostProfiling) {
            if (RepackAicore(pmuEventsConfig->aiCoreEventsCoreIds, devId) != PROFILING_SUCCESS) {
                MSPROF_LOGE("RepackAicore failed , jobId:%s, devId:%d", params->job_id.c_str(), devId);
            }
        }
        pmuEventsConfig->llcEvents = Utils::Split(params->llc_profiling_events, false, "", ",");
        pmuEventsConfig->ddrEvents = Utils::Split(params->ddr_profiling_events, false, "", ",");
        pmuEventsConfig->aivEvents = Utils::Split(params->aiv_profiling_events, false, "", ",");
        if (!params->hostProfiling) {
            if (RepackAiv(pmuEventsConfig->aivEventsCoreIds, devId) != PROFILING_SUCCESS) {
                MSPROF_LOGE("RepackAiv failed , jobId:%s, devId:%d", params->job_id.c_str(), devId);
            }
        }
        MSPROF_LOGI("CreatePmuEventConfig, aiCoreEventSize:%zu, devId:%d", pmuEventsConfig->aiCoreEvents.size(), devId);
        return pmuEventsConfig;
    }

    void GetHostTime()
    {
        uint64_t devicemonotonic = 0;
        uint64_t t1 = Utils::GetCPUCycleCounter();
        if (t1 == 0 && Platform::instance()->PlatformIsSocSide()) {
            analysis::dvvp::driver::DrvGetDeviceTime(0, devicemonotonic, t1);
        }
        hostMonotonicStart_ = Utils::GetClockMonotonicRaw();
        uint64_t t2 = Utils::GetCPUCycleCounter();
        if (t2 == 0 && Platform::instance()->PlatformIsSocSide()) {
            analysis::dvvp::driver::DrvGetDeviceTime(0, devicemonotonic, t2);
        }
        // Taking the average time of pre and post,
        // It is assumed that the timeline obtained by the api is at the same time
        hostCntvctStart_ = (t2 + t1) >> 1;
    }

    void GetHostAndDeviceTime(uint32_t devIndexId)
    {
        static const int32_t GET_TIME_COUNT = 5;
        uint64_t deviceCntvct = 0;
        uint64_t devicemonotonic = 0;
        hostMonotonicStart_ = 0;
        hostCntvctStart_ = 0;
        devMonotonic_ = 0;
        devCntvct_ = 0;
        // Warn up 5 times to reduce the impact of HDC interaction time
        for (int32_t i = 0; i < GET_TIME_COUNT; i++) {
            analysis::dvvp::driver::DrvGetDeviceTime(devIndexId, devicemonotonic, deviceCntvct);
        }

        uint64_t minDelta = 0;
        for (int32_t i = 0; i < GET_TIME_COUNT; i++) {
            const uint64_t t1 = GenClockTimer(devIndexId, devicemonotonic);
            auto mT1 = Utils::GetClockMonotonicRaw();
            const uint64_t t2 = GenClockTimer(devIndexId, devicemonotonic);
            analysis::dvvp::driver::DrvGetDeviceTime(devIndexId, devicemonotonic, deviceCntvct);
            const uint64_t t3 = GenClockTimer(devIndexId, devicemonotonic);
            auto mT2 = Utils::GetClockMonotonicRaw();
            const uint64_t t4 = GenClockTimer(devIndexId, devicemonotonic);

            // Filter out the minimum time difference for obtaining device time from 5 times,
            // indicating that the interaction time between host and device has the least impact
            if ((t3 - t2)  < minDelta || minDelta == 0) {
                minDelta = t3 - t2;
                hostMonotonicStart_ = (mT2 + mT1) >> 1;
                hostCntvctStart_ = (((t1 + t2) >> 1) + ((t3 + t4) >> 1)) >> 1;
                devMonotonic_ = devicemonotonic;
                devCntvct_ = deviceCntvct;
                // Taking the average time of pre and post,
                // It is assumed that the timeline obtained by the api is at the same time, the error is 0
                hostCntvctDiff_ = 0;
            }
        }
    }

    uint64_t GenClockTimer(uint32_t devIndexId, uint64_t &startMono) const
    {
        uint64_t timer = Utils::GetCPUCycleCounter();
        if (timer == 0 && Platform::instance()->PlatformIsSocSide()) {
            analysis::dvvp::driver::DrvGetDeviceTime(devIndexId, startMono, timer);
        }
        return timer;
    }

    std::string GenerateDevStartTime() const
    {
        std::stringstream devStartData;
        devStartData << CLOCK_MONOTONIC_RAW_KEY << ": " << devMonotonic_ << std::endl;
        devStartData << CLOCK_CNTVCT_KEY << ": " << devCntvct_ << std::endl;
        return devStartData.str();
    }

    std::string GenerateHostStartTime() const
    {
        std::stringstream devStartData;
        devStartData << CLOCK_MONOTONIC_RAW_KEY << ": " << hostMonotonicStart_ << std::endl;
        devStartData << CLOCK_CNTVCT_KEY << ": " << hostCntvctStart_ << std::endl;
        devStartData << CLOCK_CNTVCT_KEY_DIFF << ": " << hostCntvctDiff_ << std::endl;
        return devStartData.str();
    }
protected:
    uint64_t hostCntvctStart_;
    uint64_t hostMonotonicStart_;
    uint64_t hostCntvctDiff_;
    uint64_t devMonotonic_;
    uint64_t devCntvct_;
    analysis::dvvp::message::StatusInfo status_;

private:
    int32_t RepackAicore(std::vector<int32_t> &aiCores, int32_t devId) const
    {
        int64_t aiCoreNum = 0;
        if (analysis::dvvp::driver::DrvGetAiCoreNum(devId, aiCoreNum) != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
        RepackCoreId(aiCoreNum, aiCores);
        return PROFILING_SUCCESS;
    }

    int32_t RepackAiv(std::vector<int32_t> &aivCores, int32_t devId) const
    {
        int64_t aivNum = 0;
        if (analysis::dvvp::driver::DrvGetAivNum(devId, aivNum) != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
        RepackCoreId(aivNum, aivCores);
        return PROFILING_SUCCESS;
    }

    void RepackCoreId(const int32_t coreNum, std::vector<int32_t> &aiCores) const
    {
        int32_t startCoreIndex = 0;
        for (int32_t kk = 0; kk < coreNum; ++kk) {
            if (startCoreIndex >= coreNum) {
                break;
            }
            aiCores.push_back(startCoreIndex);
            startCoreIndex++;
        }
    }
};
}}}

#endif
