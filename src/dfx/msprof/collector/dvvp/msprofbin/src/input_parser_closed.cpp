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
#include <cstdio>
#include <cstdlib>
#include <map>
#include <memory>
#include <cstring>
#include <iostream>
#include <iomanip>
#include "cmd_log/cmd_log.h"
#include "errno/error_code.h"
#include "param_validation.h"
#include "utils/utils.h"
#include "config_manager.h"
#include "ai_drv_dev_api.h"
#include "platform/platform.h"
#include "config/config.h"
#include "msprof_dlog.h"
#include "osal.h"
#include "dyn_prof_client.h"

namespace Analysis {
namespace Dvvp {
namespace Msprof {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::validation;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::cmdlog;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::config;
using namespace Collector::Dvvp::Msprofbin;
using namespace Collector::Dvvp::DynProf;

constexpr int32_t MSPROF_DAEMON_ERROR       = -1;
constexpr int32_t MSPROF_DAEMON_OK          = 0;
const std::string TASK_BASED        = "task-based";
const std::string SAMPLE_BASED      = "sample-based";
const std::string ALL               = "all";
const std::string ON                = "on";
const std::string OFF               = "off";
const std::string L0                = "l0";
const std::string L1                = "l1";
const std::string L2                = "l2";
const std::string L3                = "l3";
const std::string LLC_CAPACITY      = "capacity";
const std::string LLC_BANDWIDTH     = "bandwidth";
const std::string LLC_READ          = "read";
const std::string LLC_WRITE         = "write";
const std::string TOOL_NAME_PERF    = "perf";
const std::string TOOL_NAME_LTRACE  = "ltrace";
const std::string TOOL_NAME_IOTOP   = "iotop";
const std::string CSV_FORMAT        = "csv";
const std::string JSON_FORMAT       = "json";


int32_t InputParser::PreCheckPlatform(int32_t opt, CONST_CHAR_PTR argv[])
{
    std::vector<MsprofArgsType> socBlackSwith = {ARGS_HOST_SYS, ARGS_HOST_SYS_PID, ARGS_HOST_SYS_USAGE,
        ARGS_HOST_SYS_USAGE_FREQ, ARGS_PARSE, ARGS_QUERY, ARGS_EXPORT, ARGS_EXPORT_ITERATION_ID, ARGS_EXPORT_MODEL_ID,
        ARGS_SUMMARY_FORMAT, ARGS_PYTHON_PATH, ARGS_ANALYZE, ARGS_RULE, ARGS_MEM_SERVICEFLOW, ARGS_SCALE};
    Analysis::Dvvp::Common::Config::PlatformType platformType = ConfigManager::instance()->GetPlatformType();
    if (platformType < PlatformType::MINI_TYPE || platformType >= PlatformType::END_TYPE) {
        return PROFILING_FAILED;
    }
    std::vector<MsprofArgsType> platSwithList = GeneratePlatSwithList();
    if (Platform::instance()->RunSocSide()) {
        platSwithList.insert(platSwithList.end(), socBlackSwith.begin(), socBlackSwith.end());
    }
    if (std::find(platSwithList.begin(), platSwithList.end(), opt) != platSwithList.end()) {
        std::cout << Utils::GetSelfPath() << ": unrecognized option '" << argv[OsalGetOptInd() - 1] << "'" << std::endl;
        std::cout << "PlatformType:" << static_cast<uint32_t>(platformType) << std::endl;
        MsprofCmdUsage("");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

std::vector<MsprofArgsType> InputParser::GeneratePlatSwithList() const
{
    Analysis::Dvvp::Common::Config::PlatformType platformType = ConfigManager::instance()->GetPlatformType();
    std::vector<MsprofArgsType> miniBlackSwith = {ARGS_INTERCONNECTION_PROFILING, ARGS_INTERCONNECTION_FREQ,
        ARGS_L2_PROFILING, ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS, ARGS_STORAGE_LIMIT,
        ARGS_TASK_BLOCK, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ, ARGS_DYNAMIC_PROF, ARGS_DYNAMIC_PROF_PID,
        ARGS_NPU_EVENTS, ARGS_DELAY_PROF, ARGS_DURATION_PROF, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ,
        ARGS_MEM_SERVICEFLOW, ARGS_SCALE};
    std::vector<MsprofArgsType> cloudBlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_TASK_BLOCK, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ,
        ARGS_MEM_SERVICEFLOW, ARGS_SCALE};
    std::vector<MsprofArgsType> mdcBlackSwith = {ARGS_IO_PROFILING, ARGS_IO_SAMPLING_FREQ, ARGS_INTERCONNECTION_FREQ,
        ARGS_INTERCONNECTION_PROFILING, ARGS_AICPU, ARGS_TASK_BLOCK, ARGS_PYTHON_PATH,
        ARGS_SUMMARY_FORMAT, ARGS_PARSE, ARGS_QUERY, ARGS_EXPORT, ARGS_EXPORT_ITERATION_ID, ARGS_EXPORT_MODEL_ID,
        ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ, ARGS_DYNAMIC_PROF, ARGS_DYNAMIC_PROF_PID, ARGS_ANALYZE,
        ARGS_RULE, ARGS_DELAY_PROF, ARGS_DURATION_PROF, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ,
        ARGS_MEM_SERVICEFLOW, ARGS_SCALE};
    std::vector<MsprofArgsType> dcBlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_IO_PROFILING, ARGS_IO_SAMPLING_FREQ, ARGS_TASK_BLOCK, ARGS_INSTR_PROFILING,
        ARGS_INSTR_PROFILING_FREQ, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_MEM_SERVICEFLOW, ARGS_SCALE};
    std::vector<MsprofArgsType> cloudBlackSwithV2 = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_SCALE};
    std::vector<MsprofArgsType> miniV3BlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_INTERCONNECTION_PROFILING, ARGS_INTERCONNECTION_FREQ, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ,
        ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_MEM_SERVICEFLOW, ARGS_SCALE};
    std::vector<MsprofArgsType> mdcMiniV3BlackSwith = {ARGS_AICPU, ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_QUERY,
        ARGS_AIV_METRICS, ARGS_INTERCONNECTION_PROFILING, ARGS_INTERCONNECTION_FREQ, ARGS_DYNAMIC_PROF, ARGS_EXPORT,
        ARGS_HOST_SYS, ARGS_HOST_SYS_PID, ARGS_EXPORT_ITERATION_ID, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ,
        ARGS_MODEL_EXECUTION, ARGS_EXPORT_MODEL_ID, ARGS_PYTHON_PATH, ARGS_PARSE, ARGS_DYNAMIC_PROF_PID,
        ARGS_SUMMARY_FORMAT, ARGS_IO_PROFILING, ARGS_IO_SAMPLING_FREQ, ARGS_TASK_BLOCK, ARGS_MEM_SERVICEFLOW,
        ARGS_ANALYZE, ARGS_RULE, ARGS_DELAY_PROF, ARGS_DURATION_PROF, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ,
        ARGS_SCALE};
    std::vector<MsprofArgsType> mdcLiteBlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_IO_PROFILING, ARGS_IO_SAMPLING_FREQ, ARGS_INTERCONNECTION_FREQ, ARGS_INTERCONNECTION_PROFILING,
        ARGS_AICPU, ARGS_TASK_BLOCK, ARGS_PYTHON_PATH, ARGS_SUMMARY_FORMAT, ARGS_PARSE, ARGS_QUERY,
        ARGS_EXPORT, ARGS_EXPORT_ITERATION_ID, ARGS_EXPORT_MODEL_ID, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ,
        ARGS_DYNAMIC_PROF, ARGS_DYNAMIC_PROF_PID, ARGS_ANALYZE, ARGS_RULE, ARGS_DELAY_PROF, ARGS_DURATION_PROF,
        ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_MEM_SERVICEFLOW, ARGS_SCALE};
    std::vector<MsprofArgsType> davidBlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS};
    std::vector<MsprofArgsType> david121BlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS};

    std::map<Analysis::Dvvp::Common::Config::PlatformType, std::vector<MsprofArgsType>> platformArgsType = {
        {PlatformType::MINI_TYPE, miniBlackSwith}, {PlatformType::CLOUD_TYPE, cloudBlackSwith}, {PlatformType::MDC_TYPE, mdcBlackSwith},
        {PlatformType::DC_TYPE, dcBlackSwith}, {PlatformType::CHIP_V4_1_0, cloudBlackSwithV2}, {PlatformType::MINI_V3_TYPE, miniV3BlackSwith},
        {PlatformType::CHIP_MDC_MINI_V3, mdcMiniV3BlackSwith}, {PlatformType::CHIP_TINY_V1, mdcMiniV3BlackSwith}, {PlatformType::CHIP_MDC_LITE, mdcLiteBlackSwith},
        {PlatformType::CHIP_CLOUD_V3, davidBlackSwith}, {PlatformType::CHIP_CLOUD_V4, david121BlackSwith},
    };

    return platformArgsType[platformType];
}

int32_t InputParser::CheckSampleModeValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
    std::map<int32_t, std::string> sampleMap = {
        {ARGS_AIC_MODE, "--aic-mode"},
        {ARGS_AIV_MODE, "--aiv-mode"},
    };

    if (cmdInfo.args[opt] == nullptr) {
        CmdLog::CmdErrorLog("Argument %s: expected one argument", sampleMap[opt].c_str());
        return MSPROF_DAEMON_ERROR;
    }

    if (std::string(cmdInfo.args[opt]) != TASK_BASED &&
        std::string(cmdInfo.args[opt]) != SAMPLE_BASED) {
        CmdLog::CmdErrorLog("Argument %s: invalid value: %s."
            "Please input 'task-based' or 'sample-based'.", sampleMap[opt].c_str(), cmdInfo.args[opt]);
        return MSPROF_DAEMON_ERROR;
    }

    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE) {
        params_->aiv_profiling_mode = (opt == ARGS_AIV_MODE) ?
            cmdInfo.args[ARGS_AIV_MODE] : params_->aiv_profiling_mode;
    } else {
        params_->aiv_profiling_mode = (opt == ARGS_AIC_MODE) ?
            cmdInfo.args[ARGS_AIC_MODE] : params_->aiv_profiling_mode;
    }
    params_->ai_core_profiling_mode = (opt == ARGS_AIC_MODE) ?
        cmdInfo.args[ARGS_AIC_MODE] : params_->ai_core_profiling_mode;
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckAiCoreMetricsValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
    std::map<int32_t, std::string> metricsMap = {
        {ARGS_AIC_METRICS, "--aic-metrics"},
        {ARGS_AIV_METRICS, "--aiv-metrics"},
    };

    if (cmdInfo.args[opt] == nullptr) {
        CmdLog::CmdErrorLog("Argument %s: expected one argument", metricsMap[opt].c_str());
        return MSPROF_DAEMON_ERROR;
    }
    std::string metricsRange = GeneratePrompts();
    std::string aicoreMetrics = std::string(cmdInfo.args[opt]);
    if (aicoreMetrics.empty()) {
        CmdLog::CmdErrorLog("Argument %s is empty. Please input in the range of %s", metricsMap[opt].c_str(),
            metricsRange.c_str());
        return MSPROF_DAEMON_ERROR;
    }
    if (!ParamValidation::instance()->CheckAicoreMetricsIsValid(aicoreMetrics)) {
        CmdLog::CmdErrorLog("Argument %s: invalid value:%s. Please input in the range of %s",
            metricsMap[opt].c_str(), aicoreMetrics.c_str(), metricsRange.c_str());
        return MSPROF_DAEMON_ERROR;
    }
    params_->ai_core_metrics = (opt == ARGS_AIC_METRICS) ? cmdInfo.args[opt] : params_->ai_core_metrics;
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE) {
        params_->aiv_metrics = (opt == ARGS_AIV_METRICS) ? cmdInfo.args[opt] : params_->aiv_metrics;
    } else {
        params_->aiv_metrics = (opt == ARGS_AIC_METRICS) ? cmdInfo.args[opt] : params_->aiv_metrics;
    }
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckLlcProfilingIsValid(const std::string &llcProfiling) const
{
    std::vector<std::string> llcProfilingWhiteList = {
        LLC_READ,
        LLC_WRITE
    };
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        llcProfilingWhiteList = {LLC_CAPACITY, LLC_BANDWIDTH};
    }
    if (llcProfiling.empty()) {
        CmdLog::CmdErrorLog("Argument --llc-profiling is empty."
            "Please input in the range of '%s|%s'",
            llcProfilingWhiteList[0].c_str(), llcProfilingWhiteList[1].c_str());
        return MSPROF_DAEMON_ERROR;
    }

    for (size_t j = 0; j < llcProfilingWhiteList.size(); j++) {
        if (llcProfiling.compare(llcProfilingWhiteList[j]) == 0) {
            return MSPROF_DAEMON_OK;
        }
    }

    CmdLog::CmdErrorLog("Argument --llc-profiling: invalid value: %s. "
        "Please input in the range of '%s|%s'", llcProfiling.c_str(),
        llcProfilingWhiteList[0].c_str(), llcProfilingWhiteList[1].c_str());
    return MSPROF_DAEMON_ERROR;
}

void InputParser::AiCoreFreqCheckValid(const int32_t intervalTransfer)
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE) {
        params_->aicore_sampling_interval = intervalTransfer;
    } else {
        params_->aicore_sampling_interval = intervalTransfer;
        params_->aiv_sampling_interval = intervalTransfer;
    }
}

int32_t InputParser::CheckArgOnOff(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
    if (cmdInfo.args[opt] == nullptr) {
        CmdLog::CmdErrorLog("Argument --%s: expected one argument,please enter a valid value.",
            LONG_OPTIONS[opt].name);
        return MSPROF_DAEMON_ERROR;
    }
    if (opt == ARGS_MSTX_DOMAIN_INCLUDE || opt == ARGS_MSTX_DOMAIN_EXCLUDE) {
        return MSPROF_DAEMON_OK;
    }
    std::string switchStr = std::string(cmdInfo.args[opt]);
    if (opt == ARGS_GE_API) {
        if (switchStr.compare(OFF) != 0 && switchStr.compare(L0) != 0 &&
            switchStr.compare(L1) != 0) {
                CmdLog::CmdErrorLog("Argument --%s: invalid value: %s. "
                    "Please input 'off', 'l0' or 'l1'.", LONG_OPTIONS[opt].name, cmdInfo.args[opt]);
                return MSPROF_DAEMON_ERROR;
            }
        return MSPROF_DAEMON_OK;
    }
    if (opt == ARGS_TASK_BLOCK) {
        if (!ParamValidation::instance()->CheckTaskBlockValid("--task-block", switchStr)) {
            CmdLog::CmdErrorLog("Argument --%s: invalid value: %s. ", LONG_OPTIONS[opt].name, cmdInfo.args[opt]);
            return MSPROF_DAEMON_ERROR;
        }
        return MSPROF_DAEMON_OK;
    }
    if (opt == ARGS_TASK_TIME || opt == ARGS_TASK_TRACE) {
        if (switchStr.compare(OFF) != 0 && switchStr.compare(L0) != 0 && switchStr.compare(L2) != 0 &&
            switchStr.compare(L3) != 0 && switchStr.compare(L1) != 0 && switchStr.compare(ON) != 0) {
            std::string task_trace_ranges = Platform::instance()->CheckIfSupport(PLATFORM_TASK_TRACE_L3)
                        ? "'on', 'off', 'l0', 'l1', 'l2' or 'l3'." 
                        : "'on', 'off', 'l0', 'l1' or 'l2'.";
            CmdLog::CmdErrorLog(("Argument --%s: invalid value: %s. "
                "Please input " + task_trace_ranges).c_str(), LONG_OPTIONS[opt].name, cmdInfo.args[opt]);
            return MSPROF_DAEMON_ERROR;
        }
        if (switchStr.compare(L3) == 0 && !Platform::instance()->CheckIfSupport(PLATFORM_TASK_TRACE_L3)) {
            CmdLog::CmdErrorLog("l3 is not supported on this platform.");
            return MSPROF_DAEMON_ERROR;
        }
        return MSPROF_DAEMON_OK;
    }
    if (switchStr.compare(OFF) != 0 && switchStr.compare(ON) != 0) {
        CmdLog::CmdErrorLog("Argument --%s: invalid value: %s. "
            "Please input 'on' or 'off'.", LONG_OPTIONS[opt].name, cmdInfo.args[opt]);
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}

void InputParser::ParamsSwitchValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    if (opt >= NR_ARGS) {
        return;
    }
    switch (opt) {
        case ARGS_ASCENDCL:
            params_->acl = cmdInfo.args[opt];
            break;
        case ARGS_RUNTIME_API:
            params_->runtimeApi = cmdInfo.args[opt];
            break;
        case ARGS_TASK_TSFW:
            params_->taskTsfw = cmdInfo.args[opt];
            break;
        case ARGS_TASK_TIME:
            params_->taskTime = cmdInfo.args[opt];
            SetTaskTimeSwitch(cmdInfo.args[opt]);
            break;
        case ARGS_TASK_TRACE:
            params_->taskTrace = cmdInfo.args[opt];
            SetTaskTimeSwitch(cmdInfo.args[opt]);
            break;
        case ARGS_TASK_MEMORY:
            params_->taskMemory = cmdInfo.args[opt];
            break;
        case ARGS_GE_API:
            params_->geApi = cmdInfo.args[opt];
            break;
        case ARGS_AI_CORE:
            params_->ai_core_profiling = cmdInfo.args[opt];
            break;
        case ARGS_AIV:
            params_->aiv_profiling = cmdInfo.args[opt];
            break;
        case ARGS_CPU_PROFILING:
            params_->cpu_profiling = cmdInfo.args[opt];
            break;
        case ARGS_SYS_PROFILING:
            params_->sys_profiling = cmdInfo.args[opt];
            break;
        case ARGS_PID_PROFILING:
            params_->pid_profiling = cmdInfo.args[opt];
            break;
        default:
            ParamsSwitchValid2(cmdInfo, opt);
            break;
    }
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

int32_t InputParser::MsprofCmdCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    int32_t ret = MSPROF_DAEMON_OK;
    if (opt > NR_ARGS) {
        return MSPROF_DAEMON_ERROR;
    }
    switch (opt) {
        case ARGS_OUTPUT:
            ret = CheckOutputValid(cmdInfo);
            break;
        case ARGS_STORAGE_LIMIT:
            ret = CheckStorageLimitValid(cmdInfo);
            break;
        case ARGS_APPLICATION:
            ret = CheckAppValid(cmdInfo);
            break;
        case ARGS_ENVIRONMENT:
            ret = CheckEnvironmentValid(cmdInfo);
            break;
        case ARGS_AIC_MODE:
        case ARGS_AIV_MODE:
            ret = CheckSampleModeValid(cmdInfo, opt);
            break;
        case ARGS_AIC_METRICS:
        case ARGS_AIV_METRICS:
            ret = CheckAiCoreMetricsValid(cmdInfo, opt);
            break;
        case ARGS_NPU_EVENTS:
            ret = CheckNpuEventsValid(cmdInfo, opt);
            break;
        case ARGS_SYS_DEVICES:
            ret = CheckSysDevicesValid(cmdInfo);
            break;
        default:
            ret = MsprofCmdCheckValid2(cmdInfo, opt);
            break;
    }

    if (ret == MSPROF_DAEMON_OK) {
        return MsprofDynamicCheckValid(cmdInfo, opt);
    }

    return ret;
}

void InputParser::ParamsSwitchValid2(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    switch (opt) {
        case ARGS_IO_PROFILING:
            params_->io_profiling = cmdInfo.args[opt];
            break;
        case ARGS_INTERCONNECTION_PROFILING:
            params_->interconnection_profiling = cmdInfo.args[opt];
            break;
        case ARGS_DVPP_PROFILING:
            params_->dvpp_profiling = cmdInfo.args[opt];
            break;
        case ARGS_TASK_BLOCK:
            if (strcmp(cmdInfo.args[opt], MSVP_PROF_ALL) == 0) {
                params_->taskBlock = MSVP_PROF_ON;
                params_->taskBlockShink = MSVP_PROF_OFF;
            } else {
                params_->taskBlock = cmdInfo.args[opt];
                params_->taskBlockShink = params_->taskBlock.compare(MSVP_PROF_ON) ? MSVP_PROF_ON : MSVP_PROF_OFF;
            }
            break;
        case ARGS_SYS_LOW_POWER:
            params_->sysLp = cmdInfo.args[opt];
            break;
        case ARGS_L2_PROFILING:
            params_->l2CacheTaskProfiling = cmdInfo.args[opt];
            break;
        case ARGS_AICPU:
            params_->aicpuTrace = cmdInfo.args[opt];
            break;
        case ARGS_ANALYZE:
            params_->analyzeSwitch = cmdInfo.args[opt];
            break;
        case ARGS_PARSE:
            params_->parseSwitch = cmdInfo.args[opt];
            break;
        case ARGS_QUERY:
            params_->querySwitch = cmdInfo.args[opt];
            break;
        case ARGS_EXPORT:
            params_->exportSwitch = cmdInfo.args[opt];
            break;
        case ARGS_CLEAR:
            params_->clearSwitch = cmdInfo.args[opt];
            break;
        case ARGS_MSPROFTX:
            params_->msproftx = cmdInfo.args[opt];
            break;
        case ARGS_MSTX_DOMAIN_INCLUDE:
            params_->mstxDomainInclude = cmdInfo.args[opt];
            break;
        case ARGS_MSTX_DOMAIN_EXCLUDE:
            params_->mstxDomainExclude = cmdInfo.args[opt];
            break;
        default:
            ParamsSwitchValid3(cmdInfo, opt);
            break;
    }
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

int32_t InputParser::MsprofCmdCheckValid2(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    int32_t ret = MSPROF_DAEMON_OK;
    switch (opt) {
        case ARGS_LLC_PROFILING:
            ret = CheckLlcProfilingValid(cmdInfo);
            break;
        case ARGS_PYTHON_PATH:
            ret = CheckPythonPathValid(cmdInfo);
            break;
        case ARGS_SUMMARY_FORMAT:
            ret = CheckExportSummaryFormat(cmdInfo);
            break;
        case ARGS_EXPORT_TYPE:
            ret = CheckExportType(cmdInfo);
            break;
        case ARGS_REPORTS:
            ret = CheckReports(cmdInfo);
            break;
        case ARGS_MEM_SERVICEFLOW:
            ret = CheckMemServiceflow(cmdInfo);
            break;
        case ARGS_RULE:
            ret = CheckAnalyzeRuleSwitch(cmdInfo);
            break;
        case ARGS_SCALE:
            ret = CheckCmdScaleIsValid(cmdInfo);
            break;
        default:
            break;
    }

    return ret;
}

int32_t InputParser::MsprofFreqCheckValidTwo(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
    int32_t ret = MSPROF_DAEMON_OK;
    switch (opt) {
        case ARGS_HARDWARE_MEM_SAMPLING_FREQ:
            if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_US)) {
                ret = CheckArgRange(cmdInfo, opt, 1, HZ_TEN_THOUSAND);
            } else {
                ret = CheckArgRange(cmdInfo, opt, 1, HZ_HUNDRED);
            }
            break;
        case ARGS_EXPORT_ITERATION_ID:
        case ARGS_EXPORT_MODEL_ID:
            ret = CheckArgsIsNumber(cmdInfo, opt);
            break;
        case ARGS_SYS_LOW_POWER_FREQ:
            ret = CheckArgRange(cmdInfo, opt, 1, HZ_HUNDRED);
            break;
        default:
            ret = MSPROF_DAEMON_ERROR;
            break;
    }

    return ret;
}

void InputParser::MsprofFreqTransferParams(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    int32_t interval = 0;
    FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(interval, cmdInfo.args[opt]), return, 
        "interval %s is invalid", cmdInfo.args[opt]);
    if (interval < 1) {
        return;
    }

    int32_t intervalTransfer = HZ_CONVERT_MS / interval;
    switch (opt) {
        case ARGS_AIC_FREQ:
            AiCoreFreqCheckValid(intervalTransfer);
            break;
        case ARGS_AIV_FREQ:
            params_->aiv_sampling_interval = intervalTransfer;
            break;
        case ARGS_SYS_SAMPLING_FREQ:
            params_->sys_sampling_interval = intervalTransfer;
            break;
        case ARGS_PID_SAMPLING_FREQ:
            params_->pid_sampling_interval = intervalTransfer;
            break;
        case ARGS_IO_SAMPLING_FREQ:
            params_->io_sampling_interval = intervalTransfer;
            break;
        case ARGS_DVPP_FREQ:
            params_->dvpp_sampling_interval = intervalTransfer;
            break;
        case ARGS_CPU_SAMPLING_FREQ:
            params_->cpu_sampling_interval = intervalTransfer;
            break;
        case ARGS_HARDWARE_MEM_SAMPLING_FREQ:
            params_->hardware_mem_sampling_interval = HZ_CONVERT_US / interval;
            break;
        case ARGS_INTERCONNECTION_FREQ:
            params_->interconnection_sampling_interval = intervalTransfer;
            break;
        case ARGS_HOST_SYS_USAGE_FREQ:
            params_->hostProfilingSamplingInterval = intervalTransfer;
            break;
        case ARGS_SYS_LOW_POWER_FREQ:
            params_->sysLpFreq = HZ_CONVERT_US / interval;
            break;
        default:
            break;
    }
}

void ArgsManager::AddLowPowerArgs()
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_LOW_POWER)) {
        return;
    }
    Args sysLpArgs = {"sys-lp", "Open low power profiling data config, the default value is off."};
    Args sysLpFreqArgs = {"sys-lp-freq", "Config low power frequency, the default value is 100Hz, "
        "the range is 1 to 100Hz."};
    argsList_.push_back(sysLpArgs);
    argsList_.push_back(sysLpFreqArgs);
}

void ArgsManager::AddArgs()
{
    AddStorageLimitArgs();
    AddModelExecutionArgs();
    AddAicMetricsArgs();
    AddAnalysisArgs();
    AddAicpuArgs();
    AddAivArgs();
    AddHardWareMemArgs();
    AddCpuArgs();
    AddSysArgs();
    AddIoArgs();
    AddInstrArgs();
    AddInterArgs();
    AddDvvpArgs();
    AddL2Args();
    AddHostArgs();
    AddStarsArgs();
    AddLowPowerArgs();
    AddDynProfArgs();
    AddDelayDurationArgs();
    AddScaleArgs();
}

void ArgsManager::AddHardWareMemArgs()
{
    auto hardwareMem = Args("sys-hardware-mem", "", OFF);
    auto hardwareMemFreq = Args("sys-hardware-mem-freq", "", "50");
    if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_US)) {
        hardwareMem.SetDetail("QOS, HBM, LLC, SOC and mem acquisition switch, optional on / off, "
            "the default value is off.");
        hardwareMemFreq.SetDetail("QOS, HBM, LLC, SOC and mem acquisition frequency, "
            "range 1 ~ 10000 for QOS and SOC, 1 ~ 100 for HBM, LLC and mem, the default value is 50, unit Hz.");
    } else {
        hardwareMem.SetDetail("LLC, DDR, HBM acquisition switch, optional on / off, the default value is off.");
        hardwareMemFreq.SetDetail("LLC, DDR, HBM acquisition frequency, range 1 ~ 100, "
                                "the default value is 50, unit Hz.");
    }
    auto llcProfiling = Args("llc-profiling", "", "capacity");
    llcProfiling.SetDetail("The llc profiling groups, include read, write. the default value is read.");
    argsList_.push_back(hardwareMem);
    argsList_.push_back(hardwareMemFreq);
    if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_MEM_SERVICEFLOW)) {
        argsList_.push_back({"sys-mem-serviceflow", "The qos serviceflow group, based on user customized.", ""});
    }
    argsList_.push_back(llcProfiling);
}

ArgsManager::ArgsManager()
{
    std::string task_trace_ranges = Platform::instance()->CheckIfSupport(PLATFORM_TASK_TRACE_L3)
                ? "'l0', 'l1', 'l2', 'l3', 'on' or 'off'." 
                : "'l0', 'l1', 'l2', 'on' or 'off'.";
    argsList_ = {
    {"output", "Specify the directory that is used for storing data results."},
    {"application", "Specify application path, considering the risk of privilege escalation, please pay attention to\n"
        "\t\t\t\t\t\t   the group of the application and confirm whether it is the same as the user currently.\n"
        "\t\t\t\t\t\t   [Note] This option will be discarded in later versions.\n"
        "\t\t\t\t\t\t   you can try to use: msprof [msprof arguments] <app> [app arguments]"},
    {"ascendcl", "Show acl profiling data, the default value is on.", ON},
    {"ge-api", "Specify if report GE event, the default value is off. "
        "The possible parameters are 'l0', 'l1' or 'off'.", OFF},
    {"runtime-api", "Show runtime api profiling data, the default value is off.", OFF},
    {"task-time", "Show task profiling data, the default value is on. "
        "The possible parameters are " + task_trace_ranges, ON},
    {"task-trace", "Show task profiling data, the default value is on."
        "The possible parameters are " + task_trace_ranges, ON},
    {"task-tsfw", "Specify the start of collection of ts management data, the default value is off.", OFF},
    {"task-memory", "Show the memory usage of the operator, the default value is off. "
        "The possible parameters are 'on' or 'off'.", ON},
    {"ai-core", "Turn on / off the ai core profiling, the default value is on when collecting app Profiling.", ON},
    {"aic-mode", "Set the aic profiling mode to task-based or sample-based.\n"
                  "\t\t\t\t\t\t   In task-based mode, profiling data will be collected by tasks.\n"
                  "\t\t\t\t\t\t   In sample-based mode, profiling data will be collected in a specific interval.\n"
                  "\t\t\t\t\t\t   The default value is task-based in AI task mode, sample-based in system mode.",
                  TASK_BASED},
    {"aic-freq", "The aic sampling frequency in hertz, "
                "the default value is 100 Hz, the range is 1 to 100 Hz.", "100"},
    {"environment", "User app custom environment variable configuration."},
    {"sys-period", "Set total sampling period of system profiling in seconds."},
    {"sys-devices", "Specify the profiling scope by device ID when collect sys profiling."
                     "The value is all or ID list (split with ',')."},
    {"hccl", "Show hccl profiling data, the default value is off. "
                "[Note] This option will be discarded in later versions.", OFF},
    {"msproftx", "Show msproftx and mstx data, the default value is off.", OFF},
    {"mstx-domain-include", "Choose to only include mstx events from a comma separated list of domains;\n"
        "\t\t\t\t\t\t   `default` filters the mstx default domain;\n"
        "\t\t\t\t\t\t   The switch is only applicable when parameter msproftx is set to on;\n"
        "\t\t\t\t\t\t   The switch cannot be set with mstx-domain-exclude at the same time."},
    {"mstx-domain-exclude", "Choose to exclude mstx events from a comma separated list of domains;\n"
        "\t\t\t\t\t\t   `default` excludes the mstx default domain;\n"
        "\t\t\t\t\t\t   The switch is only applicable when parameter msproftx is set to on;\n"
        "\t\t\t\t\t\t   The switch cannot be set with mstx-domain-include at the same time."}
    };
    AddArgs();
    Args help = {"help", "help message."};
    argsList_.push_back(help);
}

void ArgsManager::AddStarsArgs()
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_BLOCK)) {
        return;
    }
    std::string task_block_ranges;
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_CLOUD_V3 ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_CLOUD_V4) {
        task_block_ranges = "'all', 'on', 'off'.";
    } else {
        task_block_ranges = "'all', 'off'.";
    }
    Args fftsBlockArgs = {"task-block", "Show task block profiling data, the default value is off."
        "The possible parameters are " + task_block_ranges};
    argsList_.push_back(fftsBlockArgs);
}

void ArgsManager::AddStorageLimitArgs()
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        return;
    }
    Args storageLimitArgs = {"storage-limit", "Specify the output directory volume. range 200MB ~ 4294967295MB."};
    argsList_.push_back(storageLimitArgs);
}

void ArgsManager::AddModelExecutionArgs()
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_MINI_V3 ||
    ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_TINY_V1) {
        return;
    }
    Args modelExecutionArgs = {"model-execution", "Show ge model execution profiling data, the default value is off. "
        "[Note] This option will be discarded in later versions.", OFF};
    argsList_.push_back(modelExecutionArgs);
}

void ArgsManager::AddAicpuArgs()
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_LITE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_MINI_V3 ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_TINY_V1) {
        return;
    }
    Args aicpu = {"aicpu", "Show aicpu profiling data, the default value is off.", OFF};
    argsList_.push_back(aicpu);
}

void ArgsManager::AddAivArgs()
{
    PlatformType type = ConfigManager::instance()->GetPlatformType();
    if (type != PlatformType::MDC_TYPE) {
        return;
    }
    Args aiv = {"ai-vector-core", "Turn on / off the ai vector core profiling, the default value is on.", ON};
    Args aivMode = {"aiv-mode", "Set the aiv profiling mode to task-based or sample-based.\n"
        "\t\t\t\t\t\t   In task-based mode, profiling data will be collected by tasks.\n"
        "\t\t\t\t\t\t   In sample-based mode, profiling data will be collected in a specific interval.\n"
        "\t\t\t\t\t\t   The default value is task-based in AI task mode, sample-based in system mode.",
        TASK_BASED};
    Args aivFreq = {"aiv-freq", "The aiv sampling frequency in hertz, "
        "the default value is 100 Hz, the range is 1 to 100 Hz.",
        "100"};
    Args aivMetrics = {"aiv-metrics", "The aiv metrics groups, "
        "include ArithmeticUtilization, PipeUtilization, "
        "Memory, MemoryL0, ResourceConflictRatio, MemoryUB.\n"
        "\t\t\t\t\t\t   the default value is PipeUtilization.",
        "PipeUtilization"};
    argsList_.push_back(aiv);
    argsList_.push_back(aivMode);
    argsList_.push_back(aivFreq);
    argsList_.push_back(aivMetrics);
}

void ArgsManager::AddIoArgs()
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::DC_TYPE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_MINI_V3 ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_LITE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_TINY_V1) {
        return;
    }
    Args ioArgs = {"sys-io-profiling", "NIC acquisition switch, the default value is off.", OFF};
    Args ioFreqArgs = {"sys-io-sampling-freq", "NIC acquisition frequency, range 1 ~ 100, "
        "the default value is 100, unit Hz.",
        "100"};

    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CLOUD_TYPE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_V4_1_0 ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_V3_TYPE) {
        ioArgs.SetDetail("NIC, ROCE acquisition switch, the default value is off.");
        ioFreqArgs.SetDetail("NIC, ROCE acquisition frequency, range 1 ~ 100, "
                               "the default value is 100, unit Hz.");
    }
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_CLOUD_V3) {
        ioArgs.SetDetail("UB acquisition switch, the default value is off.");
        ioFreqArgs.SetDetail("UB acquisition frequency, range 1 ~ 100, "
                               "the default value is 100, unit Hz.");
    }
    argsList_.push_back(ioArgs);
    argsList_.push_back(ioFreqArgs);
}

void ArgsManager::AddInterArgs()
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_V3_TYPE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_MINI_V3 ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_TINY_V1) {
        return;
    }
    Args interArgs = {"sys-interconnection-profiling",
        "PCIE, HCCS acquisition switch, the default value is off.",
        OFF};
    Args interFreq = {"sys-interconnection-freq", "PCIE, HCCS acquisition frequency, range 1 ~ 50, "
        "the default value is 50, unit Hz.",
        "50"};
    if (ConfigManager::instance()->GetPlatformType() != PlatformType::CLOUD_TYPE &&
        ConfigManager::instance()->GetPlatformType() != PlatformType::CHIP_V4_1_0) {
        interArgs = {"sys-interconnection-profiling",
            "PCIE acquisition switch, the default value is off.",
            OFF};
        interFreq = {"sys-interconnection-freq", "PCIE acquisition frequency, range 1 ~ 50, "
            "the default value is 50, unit Hz.", "50"};
    }
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_CLOUD_V3) {
        interArgs.SetDetail("PCIE, CCU, SIO and UB acquisition switch, the default value is off.");
        interFreq.SetDetail("PCIE, CCU, SIO and UB acquisition frequency, range 1 ~ 50, "
            "the default value is 50, unit Hz.");
    }
    argsList_.push_back(interArgs);
    argsList_.push_back(interFreq);
}

void ArgsManager::AddL2Args()
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        return;
    }
    std::string noc = "";
    std::string smmu = "";
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_SOC_PMU_NOC)) {
        noc = " 4 parameters for NOC.";
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_SOC_PMU)) {
        smmu = " and SMMU";
    }
    Args l2 = {"l2", "L2 Cache" + smmu + " acquisition switch. The default value is off.", OFF};
    Args npuEvents = {"npu-events", "Customize soc pmu parameters for collection. "
        "The input is hexadecimal number starting with 0x. Maximum of 8 parameters can be received for MATA and SMMU."
        + noc};
    argsList_.push_back(l2);
    argsList_.push_back(npuEvents);
}
}
}
}
