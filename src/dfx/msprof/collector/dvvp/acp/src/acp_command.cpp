/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "acp_command.h"
#include <unistd.h>
#include <algorithm>
#include "argparser.h"
#include "acp_pipe_transfer.h"
#include "app/application.h"
#include "app/env_manager.h"
#include "utils/utils.h"
#include "cmd_log/cmd_log.h"
#include "platform/platform.h"
#include "ascend_hal.h"
#include "config/config.h"
#include "param_validation.h"

namespace Collector {
namespace Dvvp {
namespace Acp {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::argparse;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::message;

const std::string LIBASCEND_PROFINJ_LIB = "libascend_profinj.so";
constexpr size_t MAX_GROUP_METRICS_LEN = 7;
constexpr size_t MAX_CUSTOM_METRICS_LEN = 30;

/**
 * @brief validation function to check value of option "--output"
 * @param [in] output: value of "--output" option
 * @return: ARGPARSE_OK
            ARGPARSE_ERROR
 */
int32_t CheckOutputValid(std::string &output)
{
    std::string path = Utils::RelativePathToAbsolutePath(output);
    if (path.empty()) {
        CmdLog::CmdErrorLog("Argument --output: expected one argument");
        return ARGPARSE_ERROR;
    }
    if (path.size() > MAX_PATH_LENGTH) {
        CmdLog::CmdErrorLog("Argument --output is invalid because of exceeds"
                            " the maximum length of %d",
                            MAX_PATH_LENGTH);
        return ARGPARSE_ERROR;
    }
    if (Utils::CreateDir(path) != PROFILING_SUCCESS) {
        char errBuf[MAX_ERR_STRING_LEN + 1] = { 0 };
        CmdLog::CmdErrorLog("Create output dir failed.ErrorCode: %d, ErrorInfo: %s.", OsalGetErrorCode(),
                            OsalGetErrorFormatMessage(OsalGetErrorCode(), errBuf, MAX_ERR_STRING_LEN));
        return ARGPARSE_ERROR;
    }
    if (!Utils::IsDir(path)) {
        CmdLog::CmdErrorLog("Argument --output %s is not a dir.", output.c_str());
        return ARGPARSE_ERROR;
    }
    if (OsalAccess2(path.c_str(), OSAL_W_OK) != OSAL_EN_OK) {
        CmdLog::CmdErrorLog("Argument --output %s permission denied.", output.c_str());
        return ARGPARSE_ERROR;
    }
    output = Utils::CanonicalizePath(path);
    if (output.empty()) {
        CmdLog::CmdErrorLog("Argument --output is invalid because of"
                            " get the canonicalized absolute pathname failed");
        return ARGPARSE_ERROR;
    }
    return ARGPARSE_OK;
}

/**
 * @brief validation function to check value of option "--aic-metrics"
 * @param [in] metrics: value of "--aic-metrics" option
 * @return: ARGPARSE_OK
            ARGPARSE_ERROR
 */
int32_t CheckAcpMetricsIsValid(std::string &metrics)
{
    if (metrics.empty()) {
        CmdLog::CmdErrorLog("Argument --aic-metrics input is empty.");
        return ARGPARSE_ERROR;
    }

    std::vector<std::string> metricsVec = {};
    std::string::size_type pos = metrics.find(CUSTOM_METRICS, 0);
    if (pos != std::string::npos) { // custom events
        if (CheckCustomEventIsValid(pos, metrics, metricsVec) != ARGPARSE_OK) {
            return ARGPARSE_ERROR;
        };
    } else { // metrics group
        if (CheckGroupMetricsIsValid(metrics, metricsVec) != ARGPARSE_OK) {
            return ARGPARSE_ERROR;
        };
    }

    DeduplicateAcpMetrics(pos, metrics, metricsVec); // deduplicate metrics
    return ARGPARSE_OK;
}

/**
 * @brief validation function to check custom event
 * @param [in] metrics: value of "--aic-metrics" option
 * @param [in] metricsVec: vector of "--aic-metrics" option
 * @return: ARGPARSE_OK
            ARGPARSE_ERROR
 */
int32_t CheckCustomEventIsValid(std::string::size_type pos, std::string &metrics, std::vector<std::string> &metricsVec)
{
    if (pos > 0) {
        CmdLog::CmdErrorLog("Argument --aic-metrics %s is invalid because of invalid value before custom events. "
            "Please noted that custom function can not be used with metrics groups.", metrics.c_str());
        return ARGPARSE_ERROR;
    }

    std::string eventStr = metrics.substr(CUSTOM_METRICS.length());
    std::transform(eventStr.begin(), eventStr.end(), eventStr.begin(), ::tolower);
    metricsVec = Utils::Split(eventStr, false, "", ",");
    if (metricsVec.empty() || metricsVec.size() > MAX_CUSTOM_METRICS_LEN) {
        CmdLog::CmdErrorLog("Argument --aic-metrics %s is invalid, which input %zu custom events, and the number "
            "of custom events should be in range of [1,%zu].", metrics.c_str(), metricsVec.size(),
            MAX_CUSTOM_METRICS_LEN);
        return ARGPARSE_ERROR;
    }

    for (size_t i = 0; i < metricsVec.size(); ++i) {
        std::string event = metricsVec[i];
        if (!ParamValidation::instance()->CheckHexOrDec(event, HEX_MODE) &&
            !ParamValidation::instance()->CheckHexOrDec(event, DEC_MODE)) {
            CmdLog::CmdErrorLog("Argument --aic-metrics %s (lower) is invalid, hexadecimal or decimal "
                "parameters are allowed in custom mode.", event.c_str());
            return ARGPARSE_ERROR;
        }
    }

    return ARGPARSE_OK;
}

/**
 * @brief validation function to check group metrics
 * @param [in] metrics: value of "--aic-metrics" option
 * @param [in] metricsVec: vector of "--aic-metrics" option
 * @return: ARGPARSE_OK
            ARGPARSE_ERROR
 */
int32_t CheckGroupMetricsIsValid(std::string &metrics, std::vector<std::string> &metricsVec)
{
    metricsVec = Utils::Split(metrics, false, "", ",");
    if (metricsVec.size() > MAX_GROUP_METRICS_LEN) {
        CmdLog::CmdErrorLog("Argument --aic-metrics %s is invalid, which inputs %zu group metrics, and the maximum "
            "number of group metrics is %zu.", metrics.c_str(), metricsVec.size(), MAX_GROUP_METRICS_LEN);
        return ARGPARSE_ERROR;
    }

    for (size_t i = 0; i < metricsVec.size(); ++i) {
        std::string metricsVal = metricsVec[i];
        auto featureMetrics = Platform::instance()->PmuToFeature(metricsVal);
        if (!Platform::instance()->CheckIfSupport(featureMetrics)) {
            CmdLog::CmdErrorLog("Argument --aic-metrics %s is invalid in this platform, please check input range "
                "in help message.", metricsVal.c_str());
            return ARGPARSE_ERROR;
        }
    }

    return ARGPARSE_OK;
}

/**
 * @brief deduplicate value of "--aic-metrics" option
 * @param [in] metrics: value of "--aic-metrics" option
 * @param [in] metricsVec: vector of "--aic-metrics" option
 * @return: ARGPARSE_OK
            ARGPARSE_ERROR
 */
void DeduplicateAcpMetrics(std::string::size_type pos, std::string &metrics, std::vector<std::string> &metricsVec)
{
    if (metricsVec.size() == 1) {
        return;
    }

    for (uint32_t i = 0; i < metricsVec.size(); i++) {
        for (uint32_t j = i + 1; j < metricsVec.size(); j++) {
            if (metricsVec[i] == metricsVec[j]) {
                metricsVec.erase(metricsVec.begin() + j);
                j--;
            }
        }
    }

    metrics = "";
    if (pos != std::string::npos) {
        metrics += CUSTOM_METRICS;
    }

    for (auto &iter : metricsVec) {
        metrics += iter + ",";
    }

    metrics.pop_back();
    MSPROF_LOGI("Acp deduplicate metrics: %s.", metrics.c_str());
}

/**
 * @brief pre-check function to check platform if support acp
 * @return: ARGPARSE_OK
            ARGPARSE_ERROR
 */
int32_t PreCheckPlatform()
{
    if (Platform::instance()->CheckIfPlatformExist()) {
        return ARGPARSE_OK;
    }
    CmdLog::CmdErrorLog("Acp is not supported on the current platform type.");
    return ARGPARSE_ERROR;
}

int32_t WaitRunningProcess(std::string processUsage, int32_t &taskPid)
{
    if (taskPid == MSVP_PROCESS) {
        MSPROF_LOGE("[WaitRunningProcess] Invalid task pid.");
        return PROFILING_FAILED;
    }
    bool isExited = false;
    int32_t exitCode = 0;
    int32_t ret = PROFILING_SUCCESS;
    static const int32_t SLEEP_INTERVAL_US = 100000;  // 0.1s
    static const int32_t APP_FAIL_EXIT_CODE = 256;

    for (;;) {
        ret = analysis::dvvp::common::utils::Utils::WaitProcess(taskPid, isExited, exitCode, false);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to wait %s process %d to exit, ret=%d", processUsage.c_str(), taskPid, ret);
            return ret;
        }
        if (isExited) {
            MSPROF_EVENT("%s process %d exited, exit code:%d", processUsage.c_str(), taskPid, exitCode);
            if (exitCode != 0) {
                MSPROF_LOGW("An exception has occurred in process %s, code info: %s.", processUsage.c_str(),
                            strerror(exitCode));
                CmdLog::CmdWarningLog("An exception has occurred in process %s, code info: %s.", 
                                      processUsage.c_str(), strerror(exitCode));
            }
            if (exitCode == APP_FAIL_EXIT_CODE) {
                return PROFILING_FAILED;
            }
            return PROFILING_SUCCESS;
        }
        analysis::dvvp::common::utils::Utils::UsleepInterupt(SLEEP_INTERVAL_US);
    }
}

/**
 * @brief subcommand "profile" execution funtion
 * @param [in] profCommand: instance of Argparser
 * @return: PROFILING_SUCCESS
            PROFILING_FAILED
 */
int32_t ProfileCommandRun(Argparser &profCommand)
{
    std::string path = profCommand.GetOption("output");
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params;
    MSVP_MAKE_SHARED0(params, analysis::dvvp::message::ProfileParams, return PROFILING_FAILED);
    params->ai_core_metrics = profCommand.GetOption("aic-metrics");
    params->aicScale = profCommand.GetOption("aic-scale");
    params->instrProfiling = profCommand.GetOption("instr-profiling");
    params->pcSampling = profCommand.GetOption("pc-sampling");
    params->result_dir = path;
    if (params->result_dir.empty()) {
        params->result_dir = Utils::CanonicalizePath("./");
    }
    params->application = profCommand.appArgs;
    if (params->instrProfiling.compare("on") == 0 && params->pcSampling.compare("on") == 0) {
        CmdLog::CmdErrorLog("Start profiling failed because instr-profiling and pc-sampling switch"
            "have been enabled together.");
        return PROFILING_FAILED;
    }
    int32_t taskPid = MSVP_PROCESS;
    int32_t fdPipe = -1;
    int32_t ret = AcpPipeWrite(params, fdPipe);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to write pipe");
        return PROFILING_FAILED;
    }
    params->app_env += ";LD_PRELOAD=" + LIBASCEND_PROFINJ_LIB;
    params->app_env += ";ACP_PIPE_FD=" + std::to_string(fdPipe);
    MM_SYS_SET_ENV(MM_ENV_ACP_PIPE_FD, std::to_string(fdPipe).c_str(), 1, ret);
    FUNRET_CHECK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "Failed to set environment variable ACP_PIPE_FD.");
    CmdLog::CmdInfoLog("Start profiling....");
    ret = analysis::dvvp::app::Application::LaunchApp(params, taskPid);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to launch app");
        return PROFILING_FAILED;
    }
    ret = WaitRunningProcess("App", taskPid);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to wait process %d to exit, ret=%d", taskPid, ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief building the acp command-line app with argparse
 * @param [in] commandName: acp name
 * @return: Argparser
 */
Argparser AcpCommandBuild(const std::string commandName)
{
    if (Platform::instance()->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init platform.");
    }
    const std::string profileName = "profile";
    const std::string subcmdName = commandName + " " + profileName;
    const std::string profUsageMsg = "./" + subcmdName + " [--options] [app]";
    std::vector<std::string> aicMetricsRange = { "ArithmeticUtilization", "PipeUtilization", "Memory", "MemoryL0",
                                                 "ResourceConflictRatio", "MemoryUB",        "L2Cache" };
    UtilsStringBuilder<std::string> builder;
    std::string aicMetricsHelpMsg = "The aic metrics groups, include " + builder.Join(aicMetricsRange, ", ") + ".\n" +
                                    "\t\t\t\t\t\t   the default value is PipeUtilization. " +
                                    "Additionally, if need customize metrics events, input format of Custom:"
                                    "<event id>,<event id>.";
    std::string aicScaleHelpMsg = "Control if need collect partial op, input all or partial, "
                                  "the default value is all.";
    std::vector<std::string> aicScaleRange = { "all", "partial" };
    std::vector<std::string> onOffRange = { "on", "off" };
    auto profileCommand = Argparser("Profile single operator.")
                              .SetProgramName(subcmdName)
                              .SetUsage(profUsageMsg)
                              .AddOption("help", "Show this help message.", "")
                              .AddOption("aic-metrics", aicMetricsHelpMsg, "PipeUtilization",
                                  CheckAcpMetricsIsValid);

    if (Platform::instance()->CheckIfSupport(PLATFORM_AICSCALE_ACP)) {
        profileCommand.AddOption("aic-scale", aicScaleHelpMsg, "all", aicScaleRange);
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_INSTR_PROFILING)) {
        profileCommand.AddOption("instr-profiling", "Show instr profiling data, the default value is off.",
            "off", onOffRange);
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_PC_SAMPLING)) {
        profileCommand.AddOption("pc-sampling", "Show pc sampling data, the default value is off.",
            "off", onOffRange);
    }
    profileCommand
        .AddOption("output", "Specify the directory that is used for storing data results.", "", CheckOutputValid)
        .AddRearAppSupport()
        .BindExecute(ProfileCommandRun);

    const std::string usageMsg = "./" + commandName + " [subcommand] [--options]";
    auto acpCommand = Argparser("acp cmd.")
                          .SetProgramName(commandName)
                          .SetUsage(usageMsg)
                          .AddOption("help", "Show this help message.", "")
                          .BindPreCheck(PreCheckPlatform)
                          .AddSubCommand(profileName, profileCommand);
    return acpCommand;
}
}
}
}