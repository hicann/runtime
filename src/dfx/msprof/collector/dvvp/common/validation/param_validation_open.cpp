/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "param_validation.h"
#include <sstream>
#include <cctype>
#include <algorithm>
#include <map>
#include "platform/platform.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "message/prof_params.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace validation {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;

constexpr int32_t MIN_INTERVAL = 1;
constexpr int32_t MAX_INTERVAL = 15 * 24 * 3600 * 1000; // 15 * 24 * 3600 * 1000 = 15day's micro seconds
constexpr int32_t MAX_PERIOD = 30 * 24 * 3600; // 30 * 24 * 3600 = 30day's seconds
constexpr int32_t MAX_CORE_ID_SIZE = 80;  // ai core or aiv core id size
constexpr int32_t BASE_HEX = 16;  // hex to int
const std::string SOC_PMU_HA = "HA:";
const std::string SOC_PMU_MATA = "MATA:";
const std::string SOC_PMU_SMMU = "SMMU:";
const std::string SOC_PMU_NOC = "NOC:";
const std::string SCALE_OP_TYPE = "opType:";
const std::string SCALE_OP_NAME = "opName:";
const std::map<std::string, ProfSocPmuType> SOC_PMU_MAP = {
    {SOC_PMU_HA, ProfSocPmuType::PMU_TYPE_HA},
    {SOC_PMU_MATA, ProfSocPmuType::PMU_TYPE_MATA},
    {SOC_PMU_SMMU, ProfSocPmuType::PMU_TYPE_SMMU},
    {SOC_PMU_NOC, ProfSocPmuType::PMU_TYPE_NOC}
};

const std::map<std::string, ProfScaleType> SCALE_MAP = {
    {SCALE_OP_TYPE, ProfScaleType::SCALE_OP_TYPE},
    {SCALE_OP_NAME, ProfScaleType::SCALE_OP_NAME}
};

bool ParamValidation::CheckAiCoreEventsIsValid(const std::vector<std::string> &events) const
{
    if (events.size() > Platform::instance()->GetMaxMonitorNumber()) {
        MSPROF_LOGE("ai core events size(%u) is bigger than %hu", events.size(),
            Platform::instance()->GetMaxMonitorNumber());
        return false;
    }
    int32_t minEvent = 1;
    int32_t maxEvent = MAX_PMU_EVENT;
    for (uint32_t i = 0; i < events.size(); ++i) {
        const int32_t eventVal = strtol(events[i].c_str(), nullptr, BASE_HEX);
        if (eventVal < minEvent || eventVal > maxEvent) {
            MSPROF_LOGE("ai core event[0x%x] out of range1-%d(0x1-0x%x). please check ai core pmu event.",
                eventVal, maxEvent, maxEvent);
            return false;
        }
    }
    return true;
}

/**
 * @brief  : Check LLC config is valid
 * @param  : [in] config : LLC config
 */
bool ParamValidation::CheckLlcConfigValid(const std::string &config) const
{
    std::vector<std::string> llcProfilingWhiteList = {LLC_PROFILING_READ, LLC_PROFILING_WRITE};
    for (size_t i = 0; i < llcProfilingWhiteList.size(); i++) {
        if (config.compare(llcProfilingWhiteList[i]) == 0) {
            return true;
        }
    }
    MSPROF_LOGE("Argument llc config: invalid value: %s. Please input in the range of 'read|write'", config.c_str());
    return false;
}
}
}
}
}