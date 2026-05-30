/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "input_parser.h"
#include <iostream>
#include <iomanip>
#include "cmd_log/cmd_log.h"
#include "param_validation.h"
#include "utils/utils.h"
#include "config_manager.h"
#include "platform/platform.h"
#include "msprof_dlog.h"

namespace Analysis {
namespace Dvvp {
namespace Msprof {
using namespace analysis::dvvp::common::validation;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::cmdlog;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::config;

const std::string ON = "on";
constexpr int32_t MSPROF_DAEMON_OK = 0;
constexpr int32_t MSPROF_DAEMON_ERROR = -1;

int32_t InputParser::CheckMstxValid()
{
    if (params_->msproftx.compare(ON) != 0) {
        if (params_->mstxDomainInclude.empty() && params_->mstxDomainExclude.empty()) {
            return MSPROF_DAEMON_OK;
        } else {
            CmdLog::CmdErrorLog("Argument --mstx-domain-include/--mstx-domain-exclude "
                "must be used with --msproftx=on.");
            return MSPROF_DAEMON_ERROR;
        }
    } else {
        if (!params_->mstxDomainInclude.empty() && !params_->mstxDomainExclude.empty()) {
            CmdLog::CmdErrorLog("Argument --mstx-domain-include and --mstx-domain-exclude "
                "cannot be used at the same time.");
            return MSPROF_DAEMON_ERROR;
        }
        return MSPROF_DAEMON_OK;
    }
}

void ArgsManager::PrintMsopprofHelp()
{
    std::cout << "This is subcommand for operator optimization situation:" << std::endl;
    const int optionWidth = 34;
    std::cout << "      ";
    std::cout << std::left << std::setw(optionWidth) << "op";
    std::cout << "Use binary msopprof to operator optimization (msprof op ...)" << std::endl << std::endl;
}

int32_t InputParser::CheckNpuEventsValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
    params_->npuEvents = cmdInfo.args[opt];
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_L2_CACHE_REG) &&
        !Platform::instance()->CheckIfSupport(PLATFORM_TASK_SOC_PMU)) {
        MSPROF_LOGE("Soc pmu not support on this platform.");
        return MSPROF_DAEMON_ERROR;
    }
    static std::string singleEventsHead = "0x";
    if (params_->npuEvents.compare(0, singleEventsHead.length(), singleEventsHead) == 0 &&
        params_->npuEvents.find(";") != std::string::npos) {
        MSPROF_LOGE("Failed to check soc pmu events, if you want to collect multiple soc pmu type, "
            "please input prefix like [HA:] before events.");
        CmdLog::CmdErrorLog("Failed to check soc pmu events, if you want to collect multiple soc pmu type, "
            "please input prefix like [HA:] before events.");
        return MSPROF_DAEMON_ERROR;
    }
    if (!ParamValidation::instance()->CheckDuplicateSocPmu(params_->npuEvents)) {
        MSPROF_LOGE("Failed to check soc pmu events, please check if input duplicate soc pmu type.");
        CmdLog::CmdErrorLog("Failed to check soc pmu events, please check if input duplicate soc pmu type.");
        return MSPROF_DAEMON_ERROR;
    }
    std::vector<std::string> registerList = Utils::Split(params_->npuEvents, false, "", ";");
    for (size_t i = 0; i < registerList.size(); ++i) {
        std::string eventStr = "";
        ProfSocPmuType eventType = ParamValidation::instance()->GetSocPmuInfo(registerList[i], eventStr);
        if (eventStr.empty()) {
            MSPROF_LOGE("Failed to check empty soc pmu events, type: %u.", static_cast<uint32_t>(eventType));
            CmdLog::CmdErrorLog("Empty npu-events detected, please input valid npu-events.");
            return MSPROF_DAEMON_ERROR;
        }
        std::vector<std::string> eventsList = Utils::Split(eventStr, false, "", ",");
        if (!ParamValidation::instance()->CheckSocPmuEventsValid(eventType, eventsList)) {
            MSPROF_LOGE("Failed to check soc pmu events, type: %u, event: %s", static_cast<uint32_t>(eventType),
                registerList[i].c_str());
            CmdLog::CmdErrorLog("The npu-events[%s] is invalid or exceeds the specified length, "
                "please check ERROR infomation in host plog.", params_->npuEvents.c_str());
            return MSPROF_DAEMON_ERROR;
        }
    }

    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckMemServiceflow(const struct MsprofCmdInfo &cmdInfo) const
{
    if (cmdInfo.args[ARGS_MEM_SERVICEFLOW] == nullptr) {
        CmdLog::CmdErrorLog("Argument --sys-mem-serviceflow: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    std::string memServiceflow = std::string(cmdInfo.args[ARGS_MEM_SERVICEFLOW]);
    if (memServiceflow.empty()) {
        CmdLog::CmdErrorLog("Argument --sys-mem-serviceflow: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    params_->memServiceflow = memServiceflow;
    return MSPROF_DAEMON_OK;
}

void ArgsManager::AddLowPowerArgs()
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_LOW_POWER)) {
        return;
    }
    Args sysLpArgs = {"sys-lp", "Open low power profiling data config, the default value is on.", ON};
    Args sysLpFreqArgs = {"sys-lp-freq", "Config low power frequency, the default value is 100Hz, "
        "the range is 1 to 100Hz."};
    argsList_.push_back(sysLpArgs);
    argsList_.push_back(sysLpFreqArgs);
}

void ArgsManager::AddStarsArgs()
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_BLOCK)) {
        return;
    }
    std::string task_block_ranges;
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_CLOUD_V3 ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_CLOUD_V4 ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_V2 ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_LITE_V2) {
        task_block_ranges = "'all', 'on', 'off'.";
    } else {
        task_block_ranges = "'all', 'off'.";
    }
    Args fftsBlockArgs = {"task-block", "Show task block profiling data, the default value is off."
        "The possible parameters are " + task_block_ranges};
    argsList_.push_back(fftsBlockArgs);
}

}
}
}
