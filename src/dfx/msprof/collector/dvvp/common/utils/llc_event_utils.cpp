/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "llc_event_utils.h"
#include "config/config.h"
#include "config_manager.h"
#include "message/prof_params.h"
#include "msprof_dlog.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace utils {

using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;

std::string LlcEventUtils::GenerateCapacityEvents()
{
    const int32_t maxLlcEvents = 8;
    std::vector<std::string> llcProfilingEvents;
    for (int32_t i = 0; i < maxLlcEvents; i++) {
        std::string tempEvents;
        tempEvents.append("hisi_l3c0_1/dsid");
        tempEvents.append(std::to_string(i));
        tempEvents.append("/");
        llcProfilingEvents.push_back(tempEvents);
    }
    UtilsStringBuilder<std::string> builder;
    return builder.Join(llcProfilingEvents, ",");
}

std::string LlcEventUtils::GenerateBandwidthEvents()
{
    MSPROF_LOGI("Begin to GenerateBandwidthEvents");
    std::vector<std::string> llcProfilingEvents;
    llcProfilingEvents.push_back("hisi_l3c0_1/read_allocate/");
    llcProfilingEvents.push_back("hisi_l3c0_1/read_hit/");
    llcProfilingEvents.push_back("hisi_l3c0_1/read_noallocate/");
    llcProfilingEvents.push_back("hisi_l3c0_1/write_allocate/");
    llcProfilingEvents.push_back("hisi_l3c0_1/write_hit/");
    llcProfilingEvents.push_back("hisi_l3c0_1/write_noallocate/");

    UtilsStringBuilder<std::string> builder;
    return builder.Join(llcProfilingEvents, ",");
}

void LlcEventUtils::GenerateLlcEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    MSPROF_LOGI("Begin to GenerateLlcEvents");
    if (params == nullptr) {
        return;
    }
    if (params->llc_profiling.empty()) {
        GenerateLlcDefEvents(params);
        return;
    }
    #ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        if (params->llc_profiling.compare(LLC_PROFILING_CAPACITY) == 0) {
            params->llc_profiling_events = GenerateCapacityEvents();
        } else if (params->llc_profiling.compare(LLC_PROFILING_BANDWIDTH) == 0) {
            params->llc_profiling_events = GenerateBandwidthEvents();
        }
    } else
#endif // BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->IsDriverSupportLlc()) {
        if (params->llc_profiling.compare(LLC_PROFILING_READ) == 0) {
            params->llc_profiling_events = LLC_PROFILING_READ;
        } else if (params->llc_profiling.compare(LLC_PROFILING_WRITE) == 0) {
            params->llc_profiling_events = LLC_PROFILING_WRITE;
        }
    }
    if (params->llc_profiling_events.empty()) {
        MSPROF_LOGE("Does not support this llc profiling type : %s",
            params->llc_profiling.c_str());
    }
}

void LlcEventUtils::GenerateLlcDefEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        params->llc_profiling = LLC_PROFILING_CAPACITY;
        params->llc_profiling_events = GenerateCapacityEvents();
    } else
#endif // BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->IsDriverSupportLlc()) {
        params->llc_profiling = LLC_PROFILING_READ;
        params->llc_profiling_events = LLC_PROFILING_READ;
    } else {
        MSPROF_LOGW("The current platform does not support llc profiling.");
    }
}

}
}
}
}
