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
    if (Platform::instance()->GetPlatformType() == CHIP_MDC_LITE) {
        maxEvent = LITE_MAX_PMU_EVENT;
    }
    if (Platform::instance()->GetPlatformType() == CHIP_CLOUD_V3 ||
        Platform::instance()->GetPlatformType() == CHIP_CLOUD_V4) {
        minEvent = 0;
        maxEvent = ACC_MAX_PMU_EVENT;
    }
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
    if (Platform::instance()->GetPlatformType() == PlatformTypeEnum::CHIP_MINI) {
        MSPROF_LOGE("1910 llc is supported only in the msprof command line tool");
        return false;
    }
    for (size_t i = 0; i < llcProfilingWhiteList.size(); i++) {
        if (config.compare(llcProfilingWhiteList[i]) == 0) {
            return true;
        }
    }
    MSPROF_LOGE("Argument llc config: invalid value: %s. Please input in the range of 'read|write'", config.c_str());
    return false;
}

/**
 * @brief  : Check task block is valid
 * @param  : [in] switchName : the switch name
 * @param  : [in] config : task block config
 * @return : true
 *           false
 */
bool ParamValidation::CheckTaskBlockValid(const std::string &switchName, const std::string &config) const
{
    FUNRET_CHECK_EXPR_ACTION(!Platform::instance()->CheckIfSupport(PLATFORM_TASK_BLOCK), return false,
        "Argument %s is not supported", switchName.c_str());
    FUNRET_CHECK_EXPR_ACTION(config.empty(), return false, "Argument %s is empty.", switchName.c_str());
    if (config.compare(MSVP_PROF_OFF) != 0 && config.compare(MSVP_PROF_ALL) != 0 && 
        config.compare(MSVP_PROF_ON) != 0) {
        std::string task_block_ranges;
        if (Platform::instance()->GetPlatformType() == CHIP_CLOUD_V3 ||
            Platform::instance()->GetPlatformType() == CHIP_CLOUD_V4) {
            task_block_ranges = "'all', 'on', 'off'.";
        } else {
            task_block_ranges = "'all', 'off'.";
        }
        MSPROF_LOGE("Argument %s: invalid value: %s. Please input %s", 
            switchName.c_str(), config.c_str(), task_block_ranges.c_str());
        return false;
    }
    if (config.compare(MSVP_PROF_ON) == 0 && 
        Platform::instance()->GetPlatformType() != CHIP_CLOUD_V3 &&
        Platform::instance()->GetPlatformType() != CHIP_CLOUD_V4) {
        MSPROF_LOGE("The on option is not supported on this platform, please use all to collect block data.");
        return false;
    }  
    return true;
}
}
}
}
}