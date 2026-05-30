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
#include <sys/stat.h>
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
const std::string CSV_FORMAT        = "csv";
const std::string JSON_FORMAT       = "json";
const std::string TEXT_EXPORT_TYPE  = "text";
const std::string DB_EXPORT_TYPE    = "db";


InputParser::InputParser()
{
    MSVP_MAKE_SHARED0(params_, analysis::dvvp::message::ProfileParams, return);
}

InputParser::~InputParser()
{}

void InputParser::MsprofCmdUsage(const std::string msg)
{
    if (!msg.empty()) {
        std::cout << "err: " << const_cast<CHAR_PTR>(msg.c_str()) << std::endl;
    }
    ArgsManager::instance()->PrintHelp();
}

SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> InputParser::MsprofGetOpts(int32_t argc, CONST_CHAR_PTR argv[])
{
    if (!Utils::CheckInputArgsLength(argc, argv)) {
        return nullptr;
    }

    int32_t argCount = 1;       // argv[0] is msprof
    SplitApplicationArgv(argc, argv, argCount);

    int32_t opt = 0;
    int32_t optionIndex = 0;
    MsprofString optString = "";
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    while ((opt = OsalGetOptLong(argCount, const_cast<MsprofStrBufAddrT>(argv),
        optString, LONG_OPTIONS, &optionIndex)) != MSPROF_DAEMON_ERROR) {
        if (PreCheckPlatform(opt, argv) == PROFILING_FAILED) {
            return nullptr;
        }
        if (ProcessOptions(opt, cmdInfo) != MSPROF_DAEMON_OK) {
            return nullptr;
        }
    }

    if (!params_->application.empty()) {
        HandleApp();
    }

    if (CheckDynProfValid(cmdInfo) != MSPROF_DAEMON_OK) {
        return nullptr;
    }

#ifndef BUILD_OPEN_PROJECT
    if (CheckMstxValid() != MSPROF_DAEMON_OK) {
        return nullptr;
    }
#endif // BUILD_OPEN_PROJECT

    return ParamsCheck() == MSPROF_DAEMON_OK ? params_ : nullptr;
}

/**
 * @brief find msprof command parameter and user parameter splits
 * @param [in] argc: argc
 * @param [in] argv: argv
 * @param [out] argCount: msprof parameter count
 */
void InputParser::SplitApplicationArgv(int32_t argc, CONST_CHAR_PTR argv[], int32_t &argCount)
{
    const int32_t argWithSpaceNum = 2;
    for (int32_t i = 1; i < argc; i++) {
        if (argv[i][0] == '-' && argv[i][1] == '-') {
            if (std::strchr(argv[i], '=') != nullptr) {
                argCount++;
            } else {
                argCount += argWithSpaceNum;
                i++;
            }
        } else {
            for (;i < argc; i++) {
                params_->application.emplace_back(argv[i]);
            }
            return;
        }
    }
}

/**
 * @brief handle new application cmd style
 */
void InputParser::HandleApp()
{
    if (!params_->app.empty()) {                             // --application has a higher priority.
        params_->application.clear();
        return;
    }
    params_->app = Utils::BaseName(params_->application[0]); // start with app mode by check param_->app if empty
    return;
}

int32_t InputParser::ProcessOptions(int32_t opt, struct MsprofCmdInfo &cmdInfo)
{
    int32_t ret = MSPROF_DAEMON_ERROR;
    // opt range validate
    if (opt < ARGS_HELP || opt >= NR_ARGS || opt == static_cast<int32_t>(ARGS_INVALID)) {
        MsprofCmdUsage("");
        return ret;
    }

    cmdInfo.args[opt] = OsalGetOptArg();
    params_->usedParams.insert(opt);

    if (opt >= ARGS_OUTPUT && opt <= ARGS_RULE) {
        ret = MsprofCmdCheckValid(cmdInfo, opt);
    } else if (opt >= ARGS_ASCENDCL && opt <= ARGS_ANALYZE) {
        ret = MsprofSwitchCheckValid(cmdInfo, opt);
    } else if (opt >= ARGS_AIC_FREQ && opt <= ARGS_EXPORT_MODEL_ID) {
        ret = MsprofFreqCheckValid(cmdInfo, opt);
    } else if (opt >= ARGS_HOST_SYS && opt <= ARGS_HOST_SYS_USAGE) {
        ret = MsprofHostCheckValid(cmdInfo, opt);
    } else {
        MsprofCmdUsage("");
    }
    return ret;
}

int32_t InputParser::ParamsCheck() const
{
    if (params_ == nullptr) {
        return MSPROF_DAEMON_ERROR;
    }

    if (!params_->result_dir.empty()) {
        return MSPROF_DAEMON_OK;
    }
    std::string ascendWorkPath;
    MSPROF_GET_ENV(MM_ENV_ASCEND_WORK_PATH, ascendWorkPath);
    if (!ascendWorkPath.empty()) {
        std::string path = Utils::RelativePathToAbsolutePath(ascendWorkPath) + MSVP_SLASH + PROFILING_RESULT_PATH;
        if (Utils::CreateDir(path) != PROFILING_SUCCESS) {
            char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
            CmdLog::CmdErrorLog("Create output dir failed.ErrorCode: %d, ErrorInfo: %s.",
                OsalGetErrorCode(),
                OsalGetErrorFormatMessage(OsalGetErrorCode(), errBuf, MAX_ERR_STRING_LEN));
            return MSPROF_DAEMON_ERROR;
        }
        if (!Utils::IsDirAccessible(path)) {
            CmdLog::CmdErrorLog("Profiling output path %s is not a dir or can not accessible.", path.c_str());
            return MSPROF_DAEMON_ERROR;
        }
        params_->result_dir = Utils::CanonicalizePath(path);
        if (params_->result_dir.empty()) {
            CmdLog::CmdErrorLog("Profiling output path is invalid because of"
                                " get the canonicalized absolute pathname failed");
            return MSPROF_DAEMON_ERROR;
        }
    } else {
        if (!params_->application.empty()) {
            // new cmd save result in current dir when output not set
            params_->result_dir = Utils::CanonicalizePath("./");
            return MSPROF_DAEMON_OK;
        }
        if (!params_->app_dir.empty()) {
            params_->result_dir = params_->app_dir;
        }
    }

    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckOutputValid(const struct MsprofCmdInfo &cmdInfo)
{
    if (cmdInfo.args[ARGS_OUTPUT] == nullptr) {
        CmdLog::CmdErrorLog("Argument --output: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    std::string path = Utils::RelativePathToAbsolutePath(cmdInfo.args[ARGS_OUTPUT]);
    if (!path.empty()) {
        if (path.size() > MAX_PATH_LENGTH) {
            CmdLog::CmdErrorLog("Argument --output is invalid because of exceeds"
                " the maximum length of %d", MAX_PATH_LENGTH);
            return MSPROF_DAEMON_ERROR;
        }
        if (!Utils::CheckPathWithInvalidChar(path)) {
            CmdLog::CmdErrorLog("Argument --output %s contains invalid character.", path.c_str());
            return MSPROF_DAEMON_ERROR;
        }
        if (Utils::CreateDir(path) != PROFILING_SUCCESS) {
            char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
            CmdLog::CmdErrorLog("Create output dir failed.ErrorCode: %d, ErrorInfo: %s.",
                OsalGetErrorCode(), OsalGetErrorFormatMessage(OsalGetErrorCode(), errBuf, MAX_ERR_STRING_LEN));
            return MSPROF_DAEMON_ERROR;
        }
        if (!Utils::IsDir(path)) {
            CmdLog::CmdErrorLog("Argument --output %s is not a dir.", params_->result_dir.c_str());
            return MSPROF_DAEMON_ERROR;
        }
        if (OsalAccess2(path.c_str(), OSAL_W_OK) != OSAL_EN_OK) {
            CmdLog::CmdErrorLog("Argument --output %s permission denied.", params_->result_dir.c_str());
            return MSPROF_DAEMON_ERROR;
        }
        params_->result_dir = Utils::CanonicalizePath(path);
        if (params_->result_dir.empty()) {
            CmdLog::CmdErrorLog("Argument --output is invalid because of"
                " get the canonicalized absolute pathname failed");
            return MSPROF_DAEMON_ERROR;
        }
    } else {
        CmdLog::CmdErrorLog("Argument --output: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckStorageLimitValid(const struct MsprofCmdInfo &cmdInfo) const
{
    if (cmdInfo.args[ARGS_STORAGE_LIMIT] == nullptr) {
        return MSPROF_DAEMON_OK;
    }
    params_->storageLimit = cmdInfo.args[ARGS_STORAGE_LIMIT];
    if (params_->storageLimit.empty()) {
        CmdLog::CmdErrorLog("Argument --storage-limit: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    const std::string storageLimit = params_->storageLimit;
    if (!ParamValidation::instance()->CheckStorageLimit(params_)) {
        CmdLog::CmdErrorLog("Argument --storage-limit %s is invalid, valid range is %dMB~%uMB",
            storageLimit.c_str(), STORAGE_LIMIT_DOWN_THD, UINT32_MAX);
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::GetAppParam(const std::string &appParams)
{
    if (appParams.empty()) {
        CmdLog::CmdErrorLog("Argument --application: expected one script");
        return MSPROF_DAEMON_ERROR;
    }
    size_t index = appParams.find_first_of(" ");
    if (index != std::string::npos) {
        params_->app_parameters = appParams.substr(index + 1);
    }
    std::string appPath = appParams.substr(0, index);
    appPath = Utils::CanonicalizePath(appPath);
    if (appPath.empty()) {
        CmdLog::CmdErrorLog("Script params are invalid");
        return MSPROF_DAEMON_ERROR;
    }
    if (Utils::IsSoftLink(appPath)) {
        MSPROF_LOGE("Script(%s) is soft link.", Utils::BaseName(appPath).c_str());
        return MSPROF_DAEMON_ERROR;
    }
    std::string appDir;
    std::string appName;
    int32_t ret = Utils::SplitPath(appPath, appDir, appName);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to get app dir");
        return MSPROF_DAEMON_ERROR;
    }
    params_->app_dir = appDir;
    params_->app = appName;
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckAppValid(const struct MsprofCmdInfo &cmdInfo)
{
    if (cmdInfo.args[ARGS_APPLICATION] == nullptr) {
        CmdLog::CmdErrorLog("Argument --application: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    std::string appParam = cmdInfo.args[ARGS_APPLICATION];
    if (appParam.empty()) {
        CmdLog::CmdErrorLog("Argument --application: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    if (appParam.length() > MAX_APP_LEN) {
        CmdLog::CmdErrorLog("Argument --application: expected param length less than %d", MAX_APP_LEN);
        return MSPROF_DAEMON_ERROR;
    }
    std::string tmpAppParamers;
    size_t index = appParam.find_first_of(" ");
    if (index != std::string::npos) {
        tmpAppParamers = appParam.substr(index + 1);
    }
    std::string cmdPath = appParam.substr(0, index);
    if (!Utils::IsAppName(cmdPath) && cmdPath.find("/") == std::string::npos) {
        params_->cmdPath = cmdPath;
        return GetAppParam(tmpAppParamers);
    }
    cmdPath = Utils::RelativePathToAbsolutePath(cmdPath);
    if (!Utils::IsAppName(cmdPath)) {
        if (Utils::CanonicalizePath(cmdPath).empty()) {
            CmdLog::CmdErrorLog("App path(%s) does not exist or permission denied.", cmdPath.c_str());
            return MSPROF_DAEMON_ERROR;
        }
        if (OsalAccess2(cmdPath.c_str(), OSAL_X_OK) != OSAL_EN_OK) {
            CmdLog::CmdErrorLog("This app(%s) has no executable permission.", cmdPath.c_str());
            return MSPROF_DAEMON_ERROR;
        }
        params_->cmdPath = cmdPath;
        return GetAppParam(tmpAppParamers);
    }
    params_->app_parameters = tmpAppParamers;
    std::string cmdDir;
    std::string cmdName;
    int32_t ret = Utils::SplitPath(cmdPath, cmdDir, cmdName);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to get cmd dir");
        return MSPROF_DAEMON_ERROR;
    }
    ret = PreCheckApp(cmdDir, cmdName);
    if (ret == MSPROF_DAEMON_OK) {
        params_->app_dir = cmdDir;
        params_->app = cmdName;
        params_->cmdPath = cmdPath;
        return MSPROF_DAEMON_OK;
    }
    return MSPROF_DAEMON_ERROR;
}

/**
 * Check validation of app name and app dir before launch.
 */
int32_t InputParser::PreCheckApp(const std::string &appDir, const std::string &appName) const
{
    if (appDir.empty() || appName.empty()) {
        return MSPROF_DAEMON_ERROR;
    }
    // check app name
    if (!ParamValidation::instance()->CheckAppNameIsValid(appName)) {
        CmdLog::CmdErrorLog("Argument --application(%s) is invalid, appName.", appName.c_str());
        return MSPROF_DAEMON_ERROR;
    }
    // check app path
    const std::string appPath = appDir + MSVP_SLASH + appName;
    if (Utils::CanonicalizePath(appPath).empty()) {
        CmdLog::CmdErrorLog("App path(%s) does not exist or permission denied!!!", appPath.c_str());
        return MSPROF_DAEMON_ERROR;
    }
    if (Utils::IsSoftLink(appPath)) {
        CmdLog::CmdErrorLog("App path(%s) is soft link, which is not support!", appPath.c_str());
        return MSPROF_DAEMON_ERROR;
    }
    // check app permisiion
    if (OsalAccess2(appPath.c_str(), OSAL_X_OK) != OSAL_EN_OK) {
        CmdLog::CmdErrorLog("This app(%s) has no executable permission!", appPath.c_str());
        return MSPROF_DAEMON_ERROR;
    }

    if (Utils::IsDir(appPath)) {
        CmdLog::CmdErrorLog("Argument --application:%s is a directory, "
            "please enter the executable file path.", appPath.c_str());
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}


int32_t InputParser::CheckEnvironmentValid(const struct MsprofCmdInfo &cmdInfo)
{
    if (cmdInfo.args[ARGS_ENVIRONMENT] == nullptr) {
        CmdLog::CmdErrorLog("Argument --environment: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    params_->app_env = cmdInfo.args[ARGS_ENVIRONMENT];
    if (params_->app_env.empty()) {
        CmdLog::CmdErrorLog("Argument --environment: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckDynProfValid(struct MsprofCmdInfo &cmdInfo) const
{
    const auto app = params_->app;
    const auto dynamic = params_->dynamic;
    const auto pid = params_->pid;
    MSPROF_LOGD("app:%s, dynamic:%s, pid:%s", app.c_str(), dynamic.c_str(), pid.c_str());
    // --dynamic empty
    if (dynamic.empty() || dynamic == OFF) {
        // --dynamic empty && --pid not empty
        if (!pid.empty()) {
            CmdLog::CmdErrorLog("Argument --dynamic=off, but --pid is set.");
            MSPROF_LOGE("Argument --dynamic=off, but --pid is set.");
            return MSPROF_DAEMON_ERROR;
        } else {
            return MSPROF_DAEMON_OK;
        }
    }
    // --pid and --application is both empty
    if (app.empty() && pid.empty()) {
        CmdLog::CmdErrorLog("Argument --dynamic=on, but --application/--pid is all empty.");
        MSPROF_LOGE("Argument --dynamic=on, but --application/--pid is all empty.");
        return MSPROF_DAEMON_ERROR;
    }
    // --pid and --application is both non-empty
    if (!app.empty() && !pid.empty()) {
        CmdLog::CmdErrorLog("Argument --dynamic=on, can not set --application/--pid at the same time.");
        MSPROF_LOGE("Argument --dynamic=on, can not set --application/--pid at the same time.");
        return MSPROF_DAEMON_ERROR;
    }
    // Check whether the switch parameter conflicts with the dynamic parameter.
    FUNRET_CHECK_EXPR_ACTION(CheckDynConflict(cmdInfo), return MSPROF_DAEMON_ERROR,
        "Failed to check the parameter conflict about dynamic mode.");

    // --pid is non-empty, save pid to DynProfCliMgr
    if (!pid.empty()) {
        int32_t pidInt = 0;
        FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(pidInt, pid), return MSPROF_DAEMON_ERROR, 
            "pid %s is invalid", pid.c_str());
        DynProfCliMgr::instance()->SetKeyPid(pidInt);
    } else { // app mode, set msprofbin pid
        DynProfCliMgr::instance()->SetAppMode();
        DynProfCliMgr::instance()->SetKeyPid(Utils::GetPid());
    }
    DynProfCliMgr::instance()->EnableDynProfCli();
    return MSPROF_DAEMON_OK;
}

bool InputParser::CheckDynConflict(struct MsprofCmdInfo &cmdInfo) const
{
    FUNRET_CHECK_EXPR_ACTION(ConflictChecking(cmdInfo, ARGS_SYS_DEVICES, "dynamic"), return true,
        "Failed to check availability of argument --%s", LONG_OPTIONS[ARGS_SYS_DEVICES].name);
    FUNRET_CHECK_EXPR_ACTION(ConflictChecking(cmdInfo, ARGS_SYS_PERIOD, "dynamic"), return true,
        "Failed to check availability of argument --%s", LONG_OPTIONS[ARGS_SYS_PERIOD].name);
    FUNRET_CHECK_EXPR_ACTION(ConflictChecking(cmdInfo, ARGS_CPU_PROFILING, "dynamic"), return true,
        "Failed to check availability of argument --%s", LONG_OPTIONS[ARGS_CPU_PROFILING].name);
    return false;
}

bool InputParser::ConflictChecking(struct MsprofCmdInfo &cmdInfo, int32_t opt, const std::string &conflictArgs) const
{
    if (cmdInfo.args[opt] != nullptr) {
        CmdLog::CmdErrorLog("Argument --%s and --%s cannot be configured at the same time.", conflictArgs.c_str(),
            LONG_OPTIONS[opt].name);
        MSPROF_LOGE("Argument --%s and --%s cannot be configured at the same time.", conflictArgs.c_str(),
            LONG_OPTIONS[opt].name);
        return true;
    }
    return false;
}

int32_t InputParser::CheckPythonPathValid(const struct MsprofCmdInfo &cmdInfo) const
{
    if (cmdInfo.args[ARGS_PYTHON_PATH] == nullptr) {
        CmdLog::CmdErrorLog("Argument --python-path: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    params_->pythonPath = cmdInfo.args[ARGS_PYTHON_PATH];
    if (params_->pythonPath.empty()) {
        CmdLog::CmdErrorLog("Argument --python-path: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }

    if (params_->pythonPath.size() > MAX_PATH_LENGTH) {
        CmdLog::CmdErrorLog("Argument --python-path is invalid because of exceeds"
            " the maximum length of %d", MAX_PATH_LENGTH);
        return MSPROF_DAEMON_ERROR;
    }

    std::string absolutePythonPath = Utils::CanonicalizePath(params_->pythonPath);
    if (absolutePythonPath.empty()) {
        CmdLog::CmdErrorLog("Argument --python-path %s does not exist or permission denied!!!",
            params_->pythonPath.c_str());
        return MSPROF_DAEMON_ERROR;
    }

    if (OsalAccess2(absolutePythonPath.c_str(), OSAL_X_OK) != OSAL_EN_OK) {
        CmdLog::CmdErrorLog("Argument --python-path %s permission denied.", params_->pythonPath.c_str());
        return MSPROF_DAEMON_ERROR;
    }

    if (Utils::IsDir(absolutePythonPath)) {
        CmdLog::CmdErrorLog("Argument --python-path %s is a directory, "
            "please enter the executable file path.", params_->pythonPath.c_str());
        return MSPROF_DAEMON_ERROR;
    }

    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckExportSummaryFormat(const struct MsprofCmdInfo &cmdInfo) const
{
    if (cmdInfo.args[ARGS_SUMMARY_FORMAT] == nullptr) {
        CmdLog::CmdErrorLog("Argument --summary-format: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    params_->exportSummaryFormat = cmdInfo.args[ARGS_SUMMARY_FORMAT];
    if (params_->exportSummaryFormat != JSON_FORMAT && params_->exportSummaryFormat != CSV_FORMAT) {
        CmdLog::CmdErrorLog("Argument --summary-format: invalid value: %s. "
            "Please input 'json' or 'csv'.", cmdInfo.args[ARGS_SUMMARY_FORMAT]);
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckExportType(const struct MsprofCmdInfo &cmdInfo) const
{
    if (cmdInfo.args[ARGS_EXPORT_TYPE] == nullptr) {
        CmdLog::CmdErrorLog("Argument --type: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    params_->exportType = cmdInfo.args[ARGS_EXPORT_TYPE];
    if (params_->exportType != TEXT_EXPORT_TYPE && params_->exportType != DB_EXPORT_TYPE) {
        CmdLog::CmdErrorLog("Argument --type: invalid value: %s. "
            "Please input 'text' or 'db'.", cmdInfo.args[ARGS_EXPORT_TYPE]);
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckReports(const struct MsprofCmdInfo &cmdInfo) const
{
    if (cmdInfo.args[ARGS_REPORTS] == nullptr) {
        CmdLog::CmdErrorLog("Argument --type: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    params_->reportsPath = cmdInfo.args[ARGS_REPORTS];
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckAnalyzeRuleSwitch(const struct MsprofCmdInfo &cmdInfo) const
{
    if (cmdInfo.args[ARGS_RULE] == nullptr) {
        CmdLog::CmdErrorLog("Argument --rule: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }

    std::vector<std::string> ruleVal = Utils::Split(cmdInfo.args[ARGS_RULE], false, "", ",");
    for (size_t i = 0; i < ruleVal.size(); ++i) {
        if (ruleVal[i].compare("communication") != 0 &&
            ruleVal[i].compare("communication_matrix") != 0) {
            CmdLog::CmdErrorLog("Argument --rule: invalid value: %s. "
                                "Please input 'communication' or 'communication_matrix'.", ruleVal[i].c_str());
            return MSPROF_DAEMON_ERROR;
        }
    }

    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckCmdScaleIsValid(const struct MsprofCmdInfo &cmdInfo) const
{
    std::string errInfo = "";
    if (!ParamValidation::instance()->CheckOpTypeIsValid(cmdInfo.args[ARGS_OPTYPE], params_->opType, errInfo)) {
        CmdLog::CmdErrorLog("%s", errInfo.c_str());
        return MSPROF_DAEMON_ERROR;
    }

    return MSPROF_DAEMON_OK;
}

std::string InputParser::GeneratePrompts() const
{
    // Generate the ERROR print. Consider changing to another file location.
    std::vector<std::string> metricsHint;
    std::stringstream result;
    metricsHint.push_back("[ArithmeticUtilization|PipeUtilization|Memory|MemoryL0|MemoryUB");
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_L2_CACHE_PMU)) {
        metricsHint.push_back("|L2Cache");
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_RCR_PMU)) {
        metricsHint.push_back("|ResourceConflictRatio");
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_PEU_PMU)) {
        metricsHint.push_back("|PipelineExecuteUtilization");
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_MEMORY_ACCESS_PMU)) {
        metricsHint.push_back("|MemoryAccess");
    }
    for (auto metrics : metricsHint) {
        result << metrics;
    }
    result << "]";
    return result.str();
}

int32_t InputParser::CheckLlcProfilingValid(const struct MsprofCmdInfo &cmdInfo)
{
    if (cmdInfo.args[ARGS_LLC_PROFILING] == nullptr) {
        CmdLog::CmdErrorLog("Argument --llc-profiling: expected one argument.");
        return MSPROF_DAEMON_ERROR;
    }

    std::string llcProfiling = std::string(cmdInfo.args[ARGS_LLC_PROFILING]);
    if (CheckLlcProfilingIsValid(llcProfiling) != MSPROF_DAEMON_OK) {
        return MSPROF_DAEMON_ERROR;
    }
    params_->llc_profiling = llcProfiling;
    return MSPROF_DAEMON_OK;
}

/**
 * @brief check sys-period parameter is valid or not
 * @param cmd_info: command info
 *
 * @return
 *        MSPROF_DAEMON_OK: succ
 *        MSPROF_DAEMON_ERROR: failed
 */
int32_t InputParser::CheckSysPeriodValid(const struct MsprofCmdInfo &cmdInfo) const
{
    if (cmdInfo.args[ARGS_SYS_PERIOD] == nullptr) {
        CmdLog::CmdErrorLog("Argument --sys-period is empty,"
            "Please enter a valid --sys-period value.");
        return MSPROF_DAEMON_ERROR;
    }

    if (Utils::CheckStringIsNonNegativeIntNum(cmdInfo.args[ARGS_SYS_PERIOD])) {
        int32_t syspeRet = 0;
        FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(syspeRet, cmdInfo.args[ARGS_SYS_PERIOD]), return MSPROF_DAEMON_ERROR, 
            "syspeRet %s is invalid", cmdInfo.args[ARGS_SYS_PERIOD]);
        if (!(ParamValidation::instance()->IsValidSleepPeriod(syspeRet))) {
            CmdLog::CmdErrorLog("Argument --sys-period: invalid int value: %d."
                "The range of period is 1~2592000 seconds.", syspeRet);
            return MSPROF_DAEMON_ERROR;
        } else {
            return MSPROF_DAEMON_OK;
        }
    } else {
        CmdLog::CmdErrorLog("Argument --sys-period: invalid value: %s."
            "Please input an integer value.The range of period is 1~2592000 seconds.", cmdInfo.args[ARGS_SYS_PERIOD]);
        return MSPROF_DAEMON_ERROR;
    }
}

/**
 * @brief check sys-devices parameter is valid or not
 * @param cmd_info: command info
 *
 * @return
 *        MSPROF_DAEMON_OK: succ
 *        MSPROF_DAEMON_ERROR: failed
 */
int32_t InputParser::CheckSysDevicesValid(const struct MsprofCmdInfo &cmdInfo)
{
    if (cmdInfo.args[ARGS_SYS_DEVICES] == nullptr) {
        CmdLog::CmdErrorLog("Argument --sys-devices is empty,"
            "Please enter a valid --sys-devices value.");
        return MSPROF_DAEMON_ERROR;
    }
    params_->devices = cmdInfo.args[ARGS_SYS_DEVICES];
    if (params_->devices.empty()) {
        CmdLog::CmdErrorLog("Argument --sys-devices is empty,"
            "Please enter a valid --sys-devices value.");
        return MSPROF_DAEMON_ERROR;
    }
    if (std::string(cmdInfo.args[ARGS_SYS_DEVICES]) == ALL) {
        return MSPROF_DAEMON_OK;
    }

    std::vector<std::string> devices = Utils::Split(cmdInfo.args[ARGS_SYS_DEVICES], false, "", ",");
    for (size_t i = 0; i < devices.size(); ++i) {
        if (!(ParamValidation::instance()->CheckDeviceIdIsValid(devices[i]))) {
            CmdLog::CmdErrorLog("Argument --sys-devices: invalid value: %s."
                "Please input a valid device id.", devices[i].c_str());
            return MSPROF_DAEMON_ERROR;
        }
    }

    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckArgRange(const struct MsprofCmdInfo &cmdInfo, int32_t opt, uint32_t min, uint32_t max) const
{
    if (cmdInfo.args[opt] == nullptr) {
        CmdLog::CmdErrorLog("Argument --%s is empty, please enter a valid value.", LONG_OPTIONS[opt].name);
        return MSPROF_DAEMON_ERROR;
    }
    if (Utils::CheckStringIsUnsignedIntNum(cmdInfo.args[opt])) {
        uint32_t optRet = std::stoul(cmdInfo.args[opt]);
        if ((optRet >= min) && (optRet <= max)) {
            return MSPROF_DAEMON_OK;
        } else {
            CmdLog::CmdErrorLog("Argument --%s: invalid int value: %d."
                "Please input data is in %u to %u.", LONG_OPTIONS[opt].name, optRet, min, max);
            return MSPROF_DAEMON_ERROR;
        }
    } else {
        CmdLog::CmdErrorLog("Argument --%s: invalid value: %s."
            "Please input an integer value in %u-%u.", LONG_OPTIONS[opt].name, cmdInfo.args[opt], min, max);
        return MSPROF_DAEMON_ERROR;
    }
}

int32_t InputParser::CheckArgsIsNumber(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
    if (cmdInfo.args[opt] == nullptr) {
        CmdLog::CmdErrorLog("Argument --%s is empty, please enter a valid value.", LONG_OPTIONS[opt].name);
        return MSPROF_DAEMON_ERROR;
    }
    if (!Utils::CheckStringIsUnsignedIntNum(cmdInfo.args[opt])) {
        CmdLog::CmdErrorLog("Argument --%s: invalid value: %s."
            "Please input an integer value.", LONG_OPTIONS[opt].name, cmdInfo.args[opt]);
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}

void InputParser::SetTaskTimeSwitch(const std::string timeSwitch)
{
    if (params_->taskTrace == OFF || params_->taskTime == OFF) {
        return;
    }
    params_->prof_level = (params_->prof_level.compare(OFF) == 0) ? timeSwitch : params_->prof_level;
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_STARS_ACSQ)) {
        params_->stars_acsq_task = ON;
    } else {
        params_->hwts_log = ON;
        params_->hwts_log1 = ON;
    }

    params_->ts_memcpy = ON;
}

void InputParser::ParamsSwitchValid3(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    switch (opt) {
        case ARGS_INSTR_PROFILING:
            params_->instrProfiling = cmdInfo.args[opt];
            break;
        case ARGS_HARDWARE_MEM:
            params_->hardware_mem = cmdInfo.args[opt];
            break;
        case ARGS_HCCL:
            CmdLog::CmdWarningLog("[Note] [hccl] This option will be discarded in later versions.");
            params_->hcclTrace = cmdInfo.args[opt];
            break;
        case ARGS_MODEL_EXECUTION:
            CmdLog::CmdWarningLog("[Note] [model-execution] This option will be discarded in later versions.");
            break;
        default:
            break;
    }
}

int32_t InputParser::MsprofSwitchCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    int32_t ret = CheckArgOnOff(cmdInfo, opt);
    if (ret == MSPROF_DAEMON_OK) {
        ParamsSwitchValid(cmdInfo, opt);
        if (opt == ARGS_CPU_PROFILING) {
            ret = CheckSysCpu();
        }
    }
    return ret;
}

int32_t InputParser::CheckSysCpu()
{
    if (!Platform::instance()->RunSocSide()) {
        MSPROF_LOGI("In host side, --sys-cpu-profiling don't check perf.");
        return MSPROF_DAEMON_OK;
    }
    if (params_->cpu_profiling.compare(ON) == 0) {
        MSPROF_LOGI("Start the detection tool.");
        if (CheckHostSysToolsIsExist(TOOL_NAME_PERF, PROF_SCRIPT_PROF) != MSPROF_DAEMON_OK) {
            CmdLog::CmdErrorLog("The tool perf is invalid, please check"
                " if the tool and sudo are available.");
            return MSPROF_DAEMON_ERROR;
        }
    }
    return MSPROF_DAEMON_OK;
}




int32_t InputParser::MsprofFreqCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    int32_t ret = MSPROF_DAEMON_OK;
    if (opt > NR_ARGS) {
        return MSPROF_DAEMON_ERROR;
    }
    switch (opt) {
        case ARGS_SYS_PERIOD:
            ret = CheckSysPeriodValid(cmdInfo);
            break;
        case ARGS_SYS_SAMPLING_FREQ:
        case ARGS_PID_SAMPLING_FREQ:
            // 1 - 10
            ret = CheckArgRange(cmdInfo, opt, 1, 10); // 10 : max length
            break;
        case ARGS_CPU_SAMPLING_FREQ:
        case ARGS_INTERCONNECTION_FREQ:
        case ARGS_HOST_SYS_USAGE_FREQ:
            // 1 - 50
            ret = CheckArgRange(cmdInfo, opt, 1, 50); // 50 : max length
            break;
        case ARGS_AIC_FREQ:
        case ARGS_AIV_FREQ:
        case ARGS_IO_SAMPLING_FREQ:
        case ARGS_DVPP_FREQ:
            // 1 - 100
            ret = CheckArgRange(cmdInfo, opt, 1, 100); // 100 : max length
            break;
        case ARGS_INSTR_PROFILING_FREQ:
            // 300 - 30000
            if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_INSTR_PROFILING)) {
                CmdLog::CmdWarningLog("The argument: instr-profiling-freq is useless on this platform.");
                return ret;
            }
            ret = CheckArgRange(cmdInfo, opt, INSTR_PROFILING_SAMPLE_FREQ_MIN, INSTR_PROFILING_SAMPLE_FREQ_MAX);
            break;
        default:
            ret = MsprofFreqCheckValidTwo(cmdInfo, opt);
            break;
    }

    if (ret == MSPROF_DAEMON_OK) {
        MsprofFreqUpdateParams(cmdInfo, opt);
    }
    return ret;
}

void InputParser::MsprofFreqUpdateParams(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    switch (opt) {
        case ARGS_INSTR_PROFILING_FREQ: {
                int32_t instrProfilingFreq = 0;
                FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(instrProfilingFreq, cmdInfo.args[opt]), return, 
                    "instrProfilingFreq %s is invalid", cmdInfo.args[opt]);
                params_->instrProfilingFreq = instrProfilingFreq;
            }
            break;
        case ARGS_SYS_PERIOD: {
                int32_t period = 0;
                FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(period, cmdInfo.args[opt]), return, 
                    "profiling_period %s is invalid", cmdInfo.args[opt]);
                params_->profiling_period = period;
            }
            break;
        case ARGS_EXPORT_ITERATION_ID:
            params_->exportIterationId = cmdInfo.args[opt];
            break;
        case ARGS_EXPORT_MODEL_ID:
            params_->exportModelId = cmdInfo.args[opt];
            break;
        default:
            MsprofFreqTransferParams(cmdInfo, opt);
            break;
    }
}

int32_t InputParser::MsprofDynamicCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    int32_t ret = MSPROF_DAEMON_OK;
    switch (opt) {
        case ARGS_DYNAMIC_PROF:
            ret = CheckArgOnOff(cmdInfo, opt);
            break;
        case ARGS_DYNAMIC_PROF_PID:
            ret = CheckArgRange(cmdInfo, opt, 1, PROF_MAX_DYNAMIC_PID);
            break;
        case ARGS_DELAY_PROF:
            ret = CheckArgRange(cmdInfo, opt, 1, PROF_MAX_DYNAMIC_TIME);
            break;
        case ARGS_DURATION_PROF:
            ret = CheckArgRange(cmdInfo, opt, 1, PROF_MAX_DYNAMIC_TIME);
            break;
        default:
            break;
    }
    if (ret == MSPROF_DAEMON_OK) {
        MsprofDynamicUpdateParams(cmdInfo, opt);
    }
    return ret;
}

void InputParser::MsprofDynamicUpdateParams(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    switch (opt) {
        case ARGS_DYNAMIC_PROF:
            params_->dynamic = cmdInfo.args[opt];
            break;
        case ARGS_DYNAMIC_PROF_PID:
            params_->pid = cmdInfo.args[opt];
            break;
        case ARGS_DELAY_PROF:
            params_->delayTime = cmdInfo.args[opt];
            break;
        case ARGS_DURATION_PROF:
            params_->durationTime = cmdInfo.args[opt];
            break;
        default:
            break;
    }
}

Args::Args(const std::string &name, const std::string &detail)
    : name_(name), detail_(detail), optional_(OSAL_OPTIONAL_ARG)
{
}

Args::Args(const std::string &name, const std::string &detail, const std::string &defaultValue)
    : name_(name), defaultValue_(defaultValue), detail_(detail), optional_(OSAL_OPTIONAL_ARG)
{
}

Args::Args(const std::string &name, const std::string &detail, const std::string &defaultValue, int32_t optional)
    : name_(name), defaultValue_(defaultValue), detail_(detail), optional_(optional)
{
}

Args::~Args()
{
}

void Args::PrintHelp()
{
    std::string ifOptional = (optional_ == OSAL_OPTIONAL_ARG) ? "<Optional>" : "<Mandatory>";
    std::cout << std::right << std::setw(8) << "--"; // 8 space
    std::cout << std::left << std::setw(32) << name_  << ifOptional; // 32 space for option
    std::cout << " " << detail_ << std::endl << std::flush;
}

void Args::SetDetail(const std::string &detail)
{
    detail_ = detail;
}

ArgsManager::~ArgsManager()
{
    argsList_.clear();
}

void ArgsManager::AddAicMetricsArgs()
{
    std::string option = "PipeUtilization";
    std::string pipExe = "";
    std::string l2Cache = "";
    std::string resource = "";
    std::string memoryAccess = "";
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_PEU_PMU)) {
        option = "PipelineExecuteUtilization";
        pipExe = ", PipelineExecuteUtilization";
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_L2_CACHE_PMU)) {
        l2Cache = ", L2Cache";
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_RCR_PMU)) {
        resource = ", ResourceConflictRatio";
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_MEMORY_ACCESS_PMU)) {
        memoryAccess = ", MemoryAccess";
    }
    Args aicMetricsArgs = {"aic-metrics",
        "The aic metrics groups, include ArithmeticUtilization, PipeUtilization" + pipExe +
        ", Memory, MemoryL0" + resource + ", MemoryUB" + l2Cache + memoryAccess + ".\n" +
        "\t\t\t\t\t\t   the default value is " + option + ".",
        option};
    argsList_.push_back(aicMetricsArgs);
}

void ArgsManager::AddAnalysisArgs()
{
    if (Platform::instance()->RunSocSide()) {
        return;
    }
    std::vector<Args> argsList;
    argsList = {
    {"python-path", "Specify the python interpreter path that is used for analysis, please ensure the python version"
                " is 3.7.5 or later."},
    {"parse", "Switch for using msprof to parse collecting data, the default value is off.", OFF},
    {"query", "Switch for using msprof to query collecting data, the default value is off.", OFF},
    {"export", "Switch for using msprof to export collecting data, the default value is off.", OFF},
    {"clear", "Switch for using msprof to analyze or export data in clear mode, the default value is off.", OFF},
    {"analyze", "Switch for using msprof to analyze collecting data, the default value is off.", OFF},
    {"rule", "Switch specified rule for using msprof to analyze collecting data, "
        "include communication, communication_matrix.\n"
        "\t\t\t\t\t\t   the default value is communication,communication_matrix."},
    {"iteration-id", "The export iteration id, only used when argument export is on, the default value is 1.", "1"},
    {"model-id", "The export model id, only used when argument export is on, "
        "msprof will export minium accessible model by default.",
        "-1"},
    {"summary-format", "The export summary file format, only used when argument export is on, "
        "include csv, json, the default value is csv.", "csv"},
    {"type", "The export type, only used when argument `export` is on \n"
        "\t\t\t\t\t\t   or when collecting data, include text, db.\n"
        "\t\t\t\t\t\t   the default value is text(which will alse export the database).", "text"},
    {"reports", "Specify the path that is used for controlling the export scope of collecting results"}
    };
    argsList_.insert(argsList_.end(), argsList.begin(), argsList.end());
}

void ArgsManager::AddInstrArgs()
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_INSTR_PROFILING) &&
        !Platform::instance()->CheckIfSupport(PLATFORM_TASK_INSTR_PROFILING)) {
        return;
    }
    Args instrProfiling = {"instr-profiling", "Show instr profiling data, the default value is off.", OFF};
    Args instrProfilingFreq = {"instr-profiling-freq", "The instr profiling sampling period in clock-cycle, "
        "the default value is 1000 cycle, the range is 300 to 30000 cycle.",
        "1000"};
    argsList_.push_back(instrProfiling);
    argsList_.push_back(instrProfilingFreq);
}

void ArgsManager::AddCpuArgs()
{
    Args cpu = Args("sys-cpu-profiling", "The CPU acquisition switch, optional on / off,"
        "the default value is off.",
        OFF);
    if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_AICPU_HSCB)) {
        cpu.SetDetail("CPU and HSCB acquisition switch, optional on / off, the default value is off.");
    }
    Args cpuFreq =  {"sys-cpu-freq", "The cpu sampling frequency in hertz. "
        "the default value is 50 Hz, the range is 1 to 50 Hz.",
        "50"};
    argsList_.push_back(cpu);
    argsList_.push_back(cpuFreq);
}

void ArgsManager::AddSysArgs()
{
    Args sysProfiling = {"sys-profiling", "The System CPU usage and system memory acquisition switch,"
        "the default value is off.",
        OFF};
    Args sysFreq = {"sys-sampling-freq", "The sys sampling frequency in hertz. "
        "the default value is 10 Hz, the range is 1 to 10 Hz.",
        "10"};
    Args pidProfiling = {"sys-pid-profiling",
        "The CPU usage of the process and the memory acquisition switch of the process,"
        "the default value is off.",
        OFF};
    Args pidFreq = {"sys-pid-sampling-freq", "The pid sampling frequency in hertz. "
        "the default value is 10 Hz, the range is 1 to 10 Hz.",
        "10"};
    argsList_.push_back(sysProfiling);
    argsList_.push_back(sysFreq);
    argsList_.push_back(pidProfiling);
    argsList_.push_back(pidFreq);
}

void ArgsManager::AddDvvpArgs()
{
    Args dvpp = {"dvpp-profiling",
        "DVPP acquisition switch, the default value is off.",
        OFF};
    Args dvppFreq = {"dvpp-freq", "DVPP acquisition frequency, range 1 ~ 100, "
        "the default value is 50, unit Hz.",
        "50"};
    argsList_.push_back(dvpp);
    argsList_.push_back(dvppFreq);
}




void ArgsManager::PrintHelp()
{
    std::cout << std::endl << "Usage:" << std::endl;
    std::cout << "      ./msprof [--options]" << std::endl << std::endl;
#ifndef BUILD_OPEN_PROJECT
    PrintMsopprofHelp();
#endif // BUILD_OPEN_PROJECT
    std::cout << "Options:" << std::endl;
    for (auto args : argsList_) {
        args.PrintHelp();
    }
}

void ArgsManager::AddHostArgs()
{
    if (Platform::instance()->RunSocSide()) {
        return;
    }
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
    return;
#endif
    Args hostSys = {"host-sys", "The host-sys data type, include cpu, mem, disk, network, osrt",
        HOST_SYS_CPU};
    Args hostSysPid = {"host-sys-pid", "Set the PID of the app process for "
        "which you want to collect performance data."};
    Args hostSysUsage = {"host-sys-usage", "The host-sys-usage data type, include cpu, mem.(full-platform)",
        HOST_SYS_CPU};
    Args hostSysUsageFreq = {
        "host-sys-usage-freq",
        "The sampling frequency in hertz. the default value is 50 Hz the range is 1 to 50 Hz.",
        "50"};
    argsList_.push_back(hostSys);
    argsList_.push_back(hostSysPid);
    argsList_.push_back(hostSysUsage);
    argsList_.push_back(hostSysUsageFreq);
}

void ArgsManager::AddDynProfArgs()
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_DYNAMIC)) {
        return;
    }
    Args dynamic = {"dynamic", "Dynamic profiling switch, the default value is off.", OFF};
    Args pid = {"pid", "Dynamic profiling pid of the target process", "0"};
    argsList_.push_back(dynamic);
    argsList_.push_back(pid);
}

void ArgsManager::AddDelayDurationArgs()
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_DELAY_DURATION)) {
        return;
    }
    Args delay = {"delay",
        "Collect start delay time in seconds, range 1 ~ 4294967295s."};
    Args duration = {"duration",
        "Collection duration in seconds, range 1 ~ 4294967295s."};
    argsList_.push_back(delay);
    argsList_.push_back(duration);
}

void ArgsManager::AddScaleArgs()
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_SCALE)) {
        return;
    }
    Args optype = {"optype", "Customized operator type with the following format: "
        "\"opType1,opType2,...\"."};
    argsList_.push_back(optype);
}

int32_t InputParser::PreCheckPlatform(int32_t opt, CONST_CHAR_PTR argv[])
{
    std::vector<MsprofArgsType> socBlackSwith = {ARGS_HOST_SYS, ARGS_HOST_SYS_PID, ARGS_HOST_SYS_USAGE,
        ARGS_HOST_SYS_USAGE_FREQ, ARGS_PARSE, ARGS_QUERY, ARGS_EXPORT, ARGS_EXPORT_ITERATION_ID, ARGS_EXPORT_MODEL_ID,
        ARGS_SUMMARY_FORMAT, ARGS_PYTHON_PATH, ARGS_ANALYZE, ARGS_RULE, ARGS_MEM_SERVICEFLOW, ARGS_OPTYPE};
    Analysis::Dvvp::Common::Config::PlatformType platformType = ConfigManager::instance()->GetPlatformType();
#ifndef BUILD_OPEN_PROJECT
    if (platformType < PlatformType::MINI_TYPE || platformType >= PlatformType::END_TYPE) {
#else
    if (platformType >= PlatformType::END_TYPE) {
#endif // BUILD_OPEN_PROJECT
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

void InputParser::InitOpenBlackLists(std::map<PlatformType, std::vector<MsprofArgsType>> &platformArgsType) const
{
#ifndef BUILD_OPEN_PROJECT
    std::vector<MsprofArgsType> miniBlackSwith = {ARGS_INTERCONNECTION_PROFILING, ARGS_INTERCONNECTION_FREQ,
        ARGS_L2_PROFILING, ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS, ARGS_STORAGE_LIMIT,
        ARGS_TASK_BLOCK, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ, ARGS_DYNAMIC_PROF, ARGS_DYNAMIC_PROF_PID,
        ARGS_NPU_EVENTS, ARGS_DELAY_PROF, ARGS_DURATION_PROF, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ,
        ARGS_MEM_SERVICEFLOW, ARGS_OPTYPE};
#endif // BUILD_OPEN_PROJECT
    std::vector<MsprofArgsType> cloudBlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_TASK_BLOCK, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ,
        ARGS_MEM_SERVICEFLOW, ARGS_OPTYPE};
    std::vector<MsprofArgsType> dcBlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_IO_PROFILING, ARGS_IO_SAMPLING_FREQ, ARGS_TASK_BLOCK, ARGS_INSTR_PROFILING,
        ARGS_INSTR_PROFILING_FREQ, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_MEM_SERVICEFLOW, ARGS_OPTYPE};
    std::vector<MsprofArgsType> cloudBlackSwithV2 = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_OPTYPE};
    std::vector<MsprofArgsType> miniV3BlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_INTERCONNECTION_PROFILING, ARGS_INTERCONNECTION_FREQ, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ,
        ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_MEM_SERVICEFLOW, ARGS_OPTYPE};
    #ifndef BUILD_OPEN_PROJECT
    platformArgsType[PlatformType::MINI_TYPE] = miniBlackSwith;
#endif // BUILD_OPEN_PROJECT
    platformArgsType[PlatformType::CLOUD_TYPE] = cloudBlackSwith;
    platformArgsType[PlatformType::DC_TYPE] = dcBlackSwith;
    platformArgsType[PlatformType::CHIP_V4_1_0] = cloudBlackSwithV2;
    platformArgsType[PlatformType::MINI_V3_TYPE] = miniV3BlackSwith;
}

#ifndef BUILD_OPEN_PROJECT
void InputParser::InitClosedBlackLists(std::map<PlatformType, std::vector<MsprofArgsType>> &platformArgsType) const
{
    std::vector<MsprofArgsType> mdcBlackSwith = {ARGS_IO_PROFILING, ARGS_IO_SAMPLING_FREQ, ARGS_INTERCONNECTION_FREQ,
        ARGS_INTERCONNECTION_PROFILING, ARGS_AICPU, ARGS_TASK_BLOCK, ARGS_PYTHON_PATH,
        ARGS_SUMMARY_FORMAT, ARGS_PARSE, ARGS_QUERY, ARGS_EXPORT, ARGS_EXPORT_ITERATION_ID, ARGS_EXPORT_MODEL_ID,
        ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ, ARGS_DYNAMIC_PROF, ARGS_DYNAMIC_PROF_PID, ARGS_ANALYZE,
        ARGS_RULE, ARGS_DELAY_PROF, ARGS_DURATION_PROF, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ,
        ARGS_MEM_SERVICEFLOW, ARGS_OPTYPE};
    std::vector<MsprofArgsType> mdcMiniV3BlackSwith = {ARGS_AICPU, ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_QUERY,
        ARGS_AIV_METRICS, ARGS_INTERCONNECTION_PROFILING, ARGS_INTERCONNECTION_FREQ, ARGS_DYNAMIC_PROF, ARGS_EXPORT,
        ARGS_HOST_SYS, ARGS_HOST_SYS_PID, ARGS_EXPORT_ITERATION_ID, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ,
        ARGS_MODEL_EXECUTION, ARGS_EXPORT_MODEL_ID, ARGS_PYTHON_PATH, ARGS_PARSE, ARGS_DYNAMIC_PROF_PID,
        ARGS_SUMMARY_FORMAT, ARGS_IO_PROFILING, ARGS_IO_SAMPLING_FREQ, ARGS_TASK_BLOCK, ARGS_MEM_SERVICEFLOW,
        ARGS_ANALYZE, ARGS_RULE, ARGS_DELAY_PROF, ARGS_DURATION_PROF, ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ,
        ARGS_OPTYPE};
    std::vector<MsprofArgsType> mdcLiteBlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS,
        ARGS_IO_PROFILING, ARGS_IO_SAMPLING_FREQ, ARGS_INTERCONNECTION_FREQ, ARGS_INTERCONNECTION_PROFILING,
        ARGS_AICPU, ARGS_TASK_BLOCK, ARGS_PYTHON_PATH, ARGS_SUMMARY_FORMAT, ARGS_PARSE, ARGS_QUERY,
        ARGS_EXPORT, ARGS_EXPORT_ITERATION_ID, ARGS_EXPORT_MODEL_ID, ARGS_INSTR_PROFILING, ARGS_INSTR_PROFILING_FREQ,
        ARGS_DYNAMIC_PROF, ARGS_DYNAMIC_PROF_PID, ARGS_ANALYZE, ARGS_RULE, ARGS_DELAY_PROF, ARGS_DURATION_PROF,
        ARGS_SYS_LOW_POWER, ARGS_SYS_LOW_POWER_FREQ, ARGS_MEM_SERVICEFLOW, ARGS_OPTYPE};
    std::vector<MsprofArgsType> davidBlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS};
    std::vector<MsprofArgsType> david121BlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS};
    std::vector<MsprofArgsType> mdcV2BlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS};
    std::vector<MsprofArgsType> mdcLiteV2BlackSwith = {ARGS_AIV, ARGS_AIV_FREQ, ARGS_AIV_MODE, ARGS_AIV_METRICS};
    platformArgsType[PlatformType::MDC_TYPE] = mdcBlackSwith;
    platformArgsType[PlatformType::CHIP_MDC_MINI_V3] = mdcMiniV3BlackSwith;
    platformArgsType[PlatformType::CHIP_TINY_V1] = mdcMiniV3BlackSwith;
    platformArgsType[PlatformType::CHIP_MDC_LITE] = mdcLiteBlackSwith;
    platformArgsType[PlatformType::CHIP_CLOUD_V3] = davidBlackSwith;
    platformArgsType[PlatformType::CHIP_CLOUD_V4] = david121BlackSwith;
    platformArgsType[PlatformType::CHIP_MDC_V2] = mdcV2BlackSwith;
    platformArgsType[PlatformType::CHIP_MDC_LITE_V2] = mdcLiteV2BlackSwith;
}
#endif // BUILD_OPEN_PROJECT

std::vector<MsprofArgsType> InputParser::GeneratePlatSwithList() const
{
    PlatformType platformType = ConfigManager::instance()->GetPlatformType();
    std::map<PlatformType, std::vector<MsprofArgsType>> platformArgsType;
    InitOpenBlackLists(platformArgsType);
#ifndef BUILD_OPEN_PROJECT
    InitClosedBlackLists(platformArgsType);
#endif // BUILD_OPEN_PROJECT
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

#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE) {
        params_->aiv_profiling_mode = (opt == ARGS_AIV_MODE) ?
            cmdInfo.args[ARGS_AIV_MODE] : params_->aiv_profiling_mode;
    } else {
        params_->aiv_profiling_mode = (opt == ARGS_AIC_MODE) ?
            cmdInfo.args[ARGS_AIC_MODE] : params_->aiv_profiling_mode;
    }
#else
    params_->aiv_profiling_mode = (opt == ARGS_AIC_MODE) ?
        cmdInfo.args[ARGS_AIC_MODE] : params_->aiv_profiling_mode;
#endif // BUILD_OPEN_PROJECT
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
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE) {
        params_->aiv_metrics = (opt == ARGS_AIV_METRICS) ? cmdInfo.args[opt] : params_->aiv_metrics;
    } else {
        params_->aiv_metrics = (opt == ARGS_AIC_METRICS) ? cmdInfo.args[opt] : params_->aiv_metrics;
    }
#else
    params_->aiv_metrics = (opt == ARGS_AIC_METRICS) ? cmdInfo.args[opt] : params_->aiv_metrics;
#endif // BUILD_OPEN_PROJECT
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckLlcProfilingIsValid(const std::string &llcProfiling) const
{
    std::vector<std::string> llcProfilingWhiteList = {
        LLC_READ,
        LLC_WRITE
    };
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        llcProfilingWhiteList = {LLC_CAPACITY, LLC_BANDWIDTH};
    }
#endif // BUILD_OPEN_PROJECT
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
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE) {
        params_->aicore_sampling_interval = intervalTransfer;
    } else {
        params_->aicore_sampling_interval = intervalTransfer;
        params_->aiv_sampling_interval = intervalTransfer;
    }
#else
    params_->aicore_sampling_interval = intervalTransfer;
    params_->aiv_sampling_interval = intervalTransfer;
#endif // BUILD_OPEN_PROJECT
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
        return CheckGeApiArgValid(switchStr, cmdInfo, opt);
    }
    if (opt == ARGS_TASK_BLOCK) {
        return CheckTaskBlockArgValid(switchStr, cmdInfo, opt);
    }
    if (opt == ARGS_TASK_TIME || opt == ARGS_TASK_TRACE) {
        return CheckTaskTimeArgValid(switchStr, cmdInfo, opt);
    }
    return CheckOnOffArgValid(switchStr, cmdInfo, opt);
}

int32_t InputParser::CheckGeApiArgValid(const std::string &switchStr,
    const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
    if (switchStr.compare(OFF) != 0 && switchStr.compare(L0) != 0 &&
        switchStr.compare(L1) != 0) {
        CmdLog::CmdErrorLog("Argument --%s: invalid value: %s. "
            "Please input 'off', 'l0' or 'l1'.", LONG_OPTIONS[opt].name, cmdInfo.args[opt]);
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckTaskBlockArgValid(const std::string &switchStr,
    const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
#ifndef BUILD_OPEN_PROJECT
    if (!ParamValidation::instance()->CheckTaskBlockValid("--task-block", switchStr)) {
        CmdLog::CmdErrorLog("Argument --%s: invalid value: %s. ", LONG_OPTIONS[opt].name, cmdInfo.args[opt]);
        return MSPROF_DAEMON_ERROR;
    }
#else
    (void)switchStr;
    (void)cmdInfo;
    (void)opt;
#endif // BUILD_OPEN_PROJECT
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckTaskTimeArgValid(const std::string &switchStr,
    const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
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

int32_t InputParser::CheckOnOffArgValid(const std::string &switchStr,
    const struct MsprofCmdInfo &cmdInfo, int32_t opt) const
{
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
#ifndef BUILD_OPEN_PROJECT
            ret = CheckNpuEventsValid(cmdInfo, opt);
#else
            params_->npuEvents = cmdInfo.args[opt];
            ret = MSPROF_DAEMON_OK;
#endif // BUILD_OPEN_PROJECT
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

void InputParser::SetSwitchParam(int32_t opt, const char *value)
{
    switch (opt) {
        case ARGS_IO_PROFILING:
            params_->io_profiling = value;
            break;
        case ARGS_INTERCONNECTION_PROFILING:
            params_->interconnection_profiling = value;
            break;
        case ARGS_DVPP_PROFILING:
            params_->dvpp_profiling = value;
            break;
        case ARGS_SYS_LOW_POWER:
            params_->sysLp = value;
            break;
        case ARGS_L2_PROFILING:
            params_->l2CacheTaskProfiling = value;
            break;
        case ARGS_AICPU:
            params_->aicpuTrace = value;
            break;
        case ARGS_ANALYZE:
            params_->analyzeSwitch = value;
            break;
        case ARGS_PARSE:
            params_->parseSwitch = value;
            break;
        case ARGS_QUERY:
            params_->querySwitch = value;
            break;
        case ARGS_EXPORT:
            params_->exportSwitch = value;
            break;
        case ARGS_CLEAR:
            params_->clearSwitch = value;
            break;
        case ARGS_MSPROFTX:
            params_->msproftx = value;
            break;
        case ARGS_MSTX_DOMAIN_INCLUDE:
            params_->mstxDomainInclude = value;
            break;
        case ARGS_MSTX_DOMAIN_EXCLUDE:
            params_->mstxDomainExclude = value;
            break;
        default:
            break;
    }
}

bool InputParser::IsSwitchValid2Handled(int32_t opt) const
{
    return opt == ARGS_IO_PROFILING || opt == ARGS_INTERCONNECTION_PROFILING ||
        opt == ARGS_DVPP_PROFILING || opt == ARGS_SYS_LOW_POWER ||
        opt == ARGS_L2_PROFILING || opt == ARGS_AICPU ||
        opt == ARGS_ANALYZE || opt == ARGS_PARSE ||
        opt == ARGS_QUERY || opt == ARGS_EXPORT ||
        opt == ARGS_CLEAR || opt == ARGS_MSPROFTX ||
        opt == ARGS_MSTX_DOMAIN_INCLUDE || opt == ARGS_MSTX_DOMAIN_EXCLUDE;
}

void InputParser::ParamsSwitchValid2(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    if (opt == ARGS_TASK_BLOCK) {
        SetTaskBlockParam(cmdInfo.args[opt]);
    } else if (IsSwitchValid2Handled(opt)) {
        SetSwitchParam(opt, cmdInfo.args[opt]);
    } else {
        ParamsSwitchValid3(cmdInfo, opt);
    }
}

void InputParser::SetTaskBlockParam(const char *argValue)
{
    if (strcmp(argValue, MSVP_PROF_ALL) == 0) {
        params_->taskBlock = MSVP_PROF_ON;
        params_->taskBlockShink = MSVP_PROF_OFF;
    } else {
        params_->taskBlock = argValue;
        params_->taskBlockShink = params_->taskBlock.compare(MSVP_PROF_ON) ? MSVP_PROF_ON : MSVP_PROF_OFF;
    }
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
#ifndef BUILD_OPEN_PROJECT
            ret = CheckMemServiceflow(cmdInfo);
#else
            if (cmdInfo.args[ARGS_MEM_SERVICEFLOW] != nullptr) {
                params_->memServiceflow = cmdInfo.args[ARGS_MEM_SERVICEFLOW];
            }
            ret = MSPROF_DAEMON_OK;
#endif // BUILD_OPEN_PROJECT
            break;
        case ARGS_RULE:
            ret = CheckAnalyzeRuleSwitch(cmdInfo);
            break;
        case ARGS_OPTYPE:
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
    #ifndef BUILD_OPEN_PROJECT
    AddStarsArgs();
    AddLowPowerArgs();
    #endif // BUILD_OPEN_PROJECT
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




void ArgsManager::AddStorageLimitArgs()
{
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        return;
    }
#endif // BUILD_OPEN_PROJECT
    Args storageLimitArgs = {"storage-limit", "Specify the output directory volume. range 200MB ~ 4294967295MB."};
    argsList_.push_back(storageLimitArgs);
}

void ArgsManager::AddModelExecutionArgs()
{
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_MINI_V3 ||
    ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_TINY_V1) {
        return;
    }
#endif // BUILD_OPEN_PROJECT
    Args modelExecutionArgs = {"model-execution", "Show ge model execution profiling data, the default value is off. "
        "[Note] This option will be discarded in later versions.", OFF};
    argsList_.push_back(modelExecutionArgs);
}

void ArgsManager::AddAicpuArgs()
{
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_LITE ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_MINI_V3 ||
        ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_TINY_V1) {
        return;
    }
#endif // BUILD_OPEN_PROJECT
    Args aicpu = {"aicpu", "Show aicpu profiling data, the default value is off.", OFF};
    argsList_.push_back(aicpu);
}

void ArgsManager::AddAivArgs()
{
#ifndef BUILD_OPEN_PROJECT
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
#endif // BUILD_OPEN_PROJECT
}

void ArgsManager::AddIoArgs()
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::DC_TYPE
#ifndef BUILD_OPEN_PROJECT
        || ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE
        || ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_MINI_V3
        || ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_LITE
        || ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_TINY_V1
#endif // BUILD_OPEN_PROJECT
        ) {
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
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_CLOUD_V3) {
        ioArgs.SetDetail("UB acquisition switch, the default value is off.");
        ioFreqArgs.SetDetail("UB acquisition frequency, range 1 ~ 100, "
                               "the default value is 100, unit Hz.");
    }
#endif // BUILD_OPEN_PROJECT
    argsList_.push_back(ioArgs);
    argsList_.push_back(ioFreqArgs);
}

void ArgsManager::AddInterArgs()
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_V3_TYPE
#ifndef BUILD_OPEN_PROJECT
        || ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE
        || ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE
        || ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_MINI_V3
        || ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_TINY_V1
#endif // BUILD_OPEN_PROJECT
        ) {
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
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_CLOUD_V3) {
        interArgs.SetDetail("PCIE, CCU, SIO and UB acquisition switch, the default value is off.");
        interFreq.SetDetail("PCIE, CCU, SIO and UB acquisition frequency, range 1 ~ 50, "
            "the default value is 50, unit Hz.");
    }
#endif // BUILD_OPEN_PROJECT
    argsList_.push_back(interArgs);
    argsList_.push_back(interFreq);
}

void ArgsManager::AddL2Args()
{
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        return;
    }
#endif // BUILD_OPEN_PROJECT
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
