/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_NTS_METRICS_VALIDATION_H
#define ANALYSIS_DVVP_COMMON_NTS_METRICS_VALIDATION_H

#include <cerrno>
#include <cstdint>
#include <cstdlib>
#include <limits>
#include <string>
#include <vector>
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace validation {

constexpr uint16_t NTS_PMU_EVENT_MAX_NUM = 10;
constexpr int32_t NTS_PMU_EVENT_BASE_AUTO = 0;

inline const std::string& NtsMetricsConfigName()
{
    static const std::string ntsMetrics = "nts_metrics";
    return ntsMetrics;
}

inline const std::string& NtsPipeUtilization()
{
    static const std::string ntsPipeUtilization = "PipeUtilization";
    return ntsPipeUtilization;
}

inline const std::string& NtsCustomPrefix()
{
    static const std::string ntsCustomPrefix = "Custom:";
    return ntsCustomPrefix;
}

inline bool ParseNtsPmuEvent(const std::string& event, uint16_t& eventCode)
{
    const std::string trimEvent = analysis::dvvp::common::utils::Utils::Trim(event);
    if (trimEvent.empty()) {
        return false;
    }
    char* end = nullptr;
    errno = 0;
    const unsigned long value = std::strtoul(trimEvent.c_str(), &end, NTS_PMU_EVENT_BASE_AUTO);
    if (errno != 0 || end == trimEvent.c_str() || *end != '\0' || value > std::numeric_limits<uint16_t>::max()) {
        return false;
    }

    eventCode = static_cast<uint16_t>(value);
    return true;
}

inline bool CheckNtsPmuEventsValid(const std::vector<std::string>& events)
{
    if (events.empty() || events.size() > NTS_PMU_EVENT_MAX_NUM) {
        return false;
    }

    for (const auto& event : events) {
        uint16_t eventCode = 0;
        if (!ParseNtsPmuEvent(event, eventCode)) {
            return false;
        }
    }
    return true;
}

inline bool GetNtsCustomEvents(const std::string& metrics, std::string& events)
{
    const std::string& prefix = NtsCustomPrefix();
    if (metrics.compare(0, prefix.size(), prefix) != 0) {
        return false;
    }
    events = metrics.substr(prefix.size());
    return !events.empty();
}

inline bool CheckNtsMetricsConfigValid(const std::string& metrics, std::string& events)
{
    events.clear();
    if (metrics == NtsPipeUtilization()) {
        return true;
    }

    if (!GetNtsCustomEvents(metrics, events)) {
        return false;
    }

    const std::vector<std::string> eventList = analysis::dvvp::common::utils::Utils::Split(events, false, "", ",");
    return CheckNtsPmuEventsValid(eventList);
}

} // namespace validation
} // namespace common
} // namespace dvvp
} // namespace analysis
#endif // ANALYSIS_DVVP_COMMON_NTS_METRICS_VALIDATION_H
