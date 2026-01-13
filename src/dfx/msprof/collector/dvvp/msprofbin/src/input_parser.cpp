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
constexpr int32_t FILE_FIND_REPLAY          = 100;
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

    if (CheckMstxValid() != MSPROF_DAEMON_OK) {
        return nullptr;
    }

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
        if (!Utils::CheckPathWithInvalidChar(path)) {
            CmdLog::CmdErrorLog("Argument --output %s contains invalid character.", path.c_str());
            return MSPROF_DAEMON_ERROR;
        }
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

int32_t InputParser::CheckHostSysUsageValid(const struct MsprofCmdInfo &cmdInfo)
{
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
    CmdLog::CmdErrorLog("Currently, --host-sys-usage can be used only in the Linux environment.");
#endif
    if (Platform::instance()->RunSocSide()) {
        CmdLog::CmdErrorLog("Not in host side, --host-sys-usage is not supported.");
        return MSPROF_DAEMON_ERROR;
    }
    if (cmdInfo.args[ARGS_HOST_SYS_USAGE] == nullptr) {
        CmdLog::CmdErrorLog("Argument --host-sys-usage is empty. Please input in the range of "
            "'cpu|mem'.");
        return MSPROF_DAEMON_ERROR;
    }
    std::vector<std::string> hostSysUsageArray = Utils::Split(cmdInfo.args[ARGS_HOST_SYS_USAGE], false, "", ",");
    for (size_t i = 0; i < hostSysUsageArray.size(); ++i) {
        if (!ParamValidation::instance()->CheckHostSysUsageOptionsIsValid(hostSysUsageArray[i])) {
            MSPROF_LOGE("Argument --host-sys-usage: invalid value:%s. Please input in the range of "
                "'cpu|mem'.", hostSysUsageArray[i].c_str());
            CmdLog::CmdErrorLog("Argument --host-sys-usage=%s is invalid. Please input in the range of "
                "'cpu|mem'.", cmdInfo.args[ARGS_HOST_SYS_USAGE]);
            return MSPROF_DAEMON_ERROR;
        }
        SetHostSysUsageParam(hostSysUsageArray[i]);
    }
    params_->hostSysUsage = cmdInfo.args[ARGS_HOST_SYS_USAGE];
    return MSPROF_DAEMON_OK;
}

void InputParser::SetHostSysUsageParam(const std::string &hostSysUsageParam)
{
    if (hostSysUsageParam.compare(HOST_SYS_CPU) == 0) {
        params_->hostAllPidCpuProfiling = ON;
    } else if (hostSysUsageParam.compare(HOST_SYS_MEM) == 0) {
        params_->hostAllPidMemProfiling = ON;
    }
}

/**
 * @brief check host-sys parameter is valid or not
 * @param cmd_info: command info
 *
 * @return
 *        MSPROF_DAEMON_OK: succ
 *        MSPROF_DAEMON_ERROR: failed
 */
int32_t InputParser::CheckHostSysValid(const struct MsprofCmdInfo &cmdInfo)
{
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
    CmdLog::CmdErrorLog("Currently, --host-sys can be used only in the Linux environment.");
#endif
    if (Platform::instance()->RunSocSide()) {
        CmdLog::CmdErrorLog("Not in host side, --host-sys is not supported");
    }
    if (cmdInfo.args[ARGS_HOST_SYS] == nullptr) {
        CmdLog::CmdErrorLog("Argument --host-sys: expected one argument");
        return MSPROF_DAEMON_ERROR;
    }
    std::string hostSys = std::string(cmdInfo.args[ARGS_HOST_SYS]);
    if (hostSys.empty()) {
        CmdLog::CmdErrorLog("Argument --host-sys is empty. Please input in the range of "
            "'cpu|mem|disk|network|osrt'");
        return MSPROF_DAEMON_ERROR;
    }
    std::vector<std::string> hostSysArray = Utils::Split(cmdInfo.args[ARGS_HOST_SYS], false, "", ",");
    for (size_t i = 0; i < hostSysArray.size(); ++i) {
        if (!(ParamValidation::instance()->CheckHostSysOptionsIsValid(hostSysArray[i]))) {
            CmdLog::CmdErrorLog("Argument --host-sys: invalid value:%s. Please input in the range of "
                "'cpu|mem|disk|network|osrt'", hostSysArray[i].c_str());
            return MSPROF_DAEMON_ERROR;
        }
        SetHostSysParam(hostSysArray[i]);
    }
    if (params_->host_osrt_profiling.compare(ON) == 0) {
        if (params_->result_dir.empty() && params_->app_dir.empty()) {
            CmdLog::CmdErrorLog("If you want to use this parameter:--host-sys,"
                " please put it behind the --output or --application.");
            return MSPROF_DAEMON_ERROR;
        }
        MSPROF_LOGI("Start the detection tool.");
        if (CheckHostSysToolsIsExist(TOOL_NAME_PERF, PROF_SCRIPT_FILE_PATH) != MSPROF_DAEMON_OK) {
            CmdLog::CmdErrorLog("The tool perf is invalid, please check"
                " if the tool and sudo are available.");
            return MSPROF_DAEMON_ERROR;
        }
        if (CheckHostSysToolsIsExist(TOOL_NAME_LTRACE, PROF_SCRIPT_FILE_PATH) != MSPROF_DAEMON_OK) {
            CmdLog::CmdErrorLog("The tool ltrace is invalid, please check"
                " if the tool and sudo are available.");
            return MSPROF_DAEMON_ERROR;
        }
    }
    if (params_->host_disk_profiling.compare(ON) == 0) {
        if (CheckHostSysToolsIsExist(TOOL_NAME_IOTOP, PROF_SCRIPT_FILE_PATH) != MSPROF_DAEMON_OK) {
            CmdLog::CmdErrorLog("The tool iotop is invalid, please check if"
                " the tool and sudo are available.");
            return MSPROF_DAEMON_ERROR;
        }
    }
    params_->host_sys = cmdInfo.args[ARGS_HOST_SYS];
    params_->host_disk_freq = 50; // host_disk_freq the default value is 50 Hz.
    return MSPROF_DAEMON_OK;
}

void InputParser::SetHostSysParam(const std::string hostSysParam)
{
    if (hostSysParam.compare(HOST_SYS_CPU) == 0) {
        params_->host_cpu_profiling = ON;
    } else if (hostSysParam.compare(HOST_SYS_MEM) == 0) {
        params_->host_mem_profiling = ON;
    } else if (hostSysParam.compare(HOST_SYS_NETWORK) == 0) {
        params_->host_network_profiling = ON;
    } else if (hostSysParam.compare(HOST_SYS_DISK) == 0) {
        params_->host_disk_profiling = ON;
    } else if (hostSysParam.compare(HOST_SYS_OSRT) == 0) {
        params_->host_osrt_profiling = ON;
    }
}

int32_t InputParser::CheckHostSysToolsIsExist(const std::string toolName, const std::string exeCmd)
{
    std::string tmpDir;
    if (!params_->result_dir.empty()) {
        tmpDir = params_->result_dir;
    } else if (!params_->app_dir.empty()) {
        tmpDir = params_->app_dir;
    } else {
        tmpDir = analysis::dvvp::common::utils::Utils::IdeGetHomedir();
    }
    static const std::string ENV_PATH = "PATH=/usr/bin/:/usr/sbin:/var";
    std::vector<std::string> envV;
    envV.push_back(ENV_PATH);
    std::vector<std::string> argsV;
    if (exeCmd.compare(PROF_SCRIPT_PROF) == 0) {
        argsV.push_back(PROF_SCRIPT_PROF);
        argsV.push_back("--version");
    } else {
        argsV.push_back(exeCmd);
        argsV.push_back("get-version");
        argsV.push_back(toolName);
    }
    unsigned long long startRealtime = analysis::dvvp::common::utils::Utils::GetClockRealtime();
    tmpDir += "/tmpPrint" + std::to_string(startRealtime);
    int32_t exitCode = analysis::dvvp::common::utils::INVALID_EXIT_CODE;
    static const std::string CMD = "sudo";
    OsalProcess tmpProcess = MSVP_PROCESS;
    ExecCmdParams execCmdParams(CMD, true, tmpDir);
    int32_t ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams,
                                                            argsV,
                                                            envV,
                                                            exitCode,
                                                            tmpProcess);
    FUNRET_CHECK_FAIL_PRINT(ret != PROFILING_SUCCESS);
    ret = CheckHostSysCmdOutIsExist(tmpDir, toolName, tmpProcess);
    return ret;
}

int32_t InputParser::CheckHostSysCmdOutIsExist(const std::string tmpDir, const std::string toolName,
                                           const OsalProcess tmpProcess) const
{
    MSPROF_LOGI("Start to check whether the file exists.");
    for (int32_t i = 0; i < FILE_FIND_REPLAY; i++) {
        if (!(Utils::IsFileExist(tmpDir))) {
            OsalSleep(20); // If the file is not found, the delay is 20 ms.
            continue;
        } else {
            break;
        }
    }
    for (int32_t i = 0; i < FILE_FIND_REPLAY; i++) {
        int64_t len = analysis::dvvp::common::utils::Utils::GetFileSize(tmpDir);
        if (len < static_cast<int64_t>(toolName.length())) {
            OsalSleep(5); // If the file has no content, the delay is 5 ms.
            continue;
        } else {
            break;
        }
    }
    std::string tmpDirPath = Utils::CanonicalizePath(tmpDir);
    FUNRET_CHECK_EXPR_ACTION(tmpDirPath.empty(), return MSPROF_DAEMON_ERROR,
        "The tmpDir path: %s does not exist or permission denied.", tmpDirPath.c_str());
    std::ifstream in(tmpDirPath);
    std::ostringstream tmp;
    tmp << in.rdbuf();
    std::string tmpStr = tmp.str();
    OsalUnlink(tmpDirPath.c_str());
    int32_t ret = CheckHostOutString(tmpStr, toolName);
    if (ret != MSPROF_DAEMON_OK) {
        ret = UninitCheckHostSysCmd(tmpProcess); // stop check process.
        if (ret != MSPROF_DAEMON_OK) {
            MSPROF_LOGE("Failed to kill the process.");
        }
        MSPROF_LOGE("The tool %s useless", toolName.c_str());
        return MSPROF_DAEMON_ERROR;
    }
    return ret;
}

/**
 * Check the first word in the string is tool name.
 */
int32_t InputParser::CheckHostOutString(const std::string tmpStr, const std::string toolName) const
{
    std::vector<std::string> checkToolArray = Utils::Split(tmpStr.c_str());
    if (checkToolArray.size() > 0) {
        if (checkToolArray[0].compare(toolName) == 0) {
            MSPROF_LOGI("The returned value is correct.%s", checkToolArray[0].c_str());
            return MSPROF_DAEMON_OK;
        } else {
            MSPROF_LOGE("The return value is incorrect.%s", checkToolArray[0].c_str());
            return MSPROF_DAEMON_ERROR;
        }
    }
    MSPROF_LOGE("The file has no content.");
    return MSPROF_DAEMON_ERROR;
}

int32_t InputParser::UninitCheckHostSysCmd(const OsalProcess checkProcess) const
{
    if (!(ParamValidation::instance()->CheckHostSysPidIsValid(static_cast<int32_t>(checkProcess)))) {
        return MSPROF_DAEMON_ERROR;
    }
    if (!analysis::dvvp::common::utils::Utils::ProcessIsRuning(checkProcess)) {
        MSPROF_LOGI("Process:%d is not exist", static_cast<int32_t>(checkProcess));
        return MSPROF_DAEMON_OK;
    }
    static const std::string ENV_PATH = "PATH=/usr/bin/:/usr/sbin:/var:/bin";
    std::vector<std::string> envV;
    envV.push_back(ENV_PATH);
    std::vector<std::string> argsV;
    std::string killCmd = "kill -2 " + std::to_string(static_cast<int32_t>(checkProcess));
    argsV.push_back("-c");
    argsV.push_back(killCmd);
    int32_t exitCode = analysis::dvvp::common::utils::VALID_EXIT_CODE;
    static const std::string CMD = "sh";
    OsalProcess tmpProcess = MSVP_PROCESS;
    ExecCmdParams execCmdParams(CMD, true, "");
    int32_t ret = MSPROF_DAEMON_OK;
    for (int32_t i = 0; i < FILE_FIND_REPLAY; i++) {
        if (ParamValidation::instance()->CheckHostSysPidIsValid(static_cast<int32_t>(checkProcess))) {
            ret = analysis::dvvp::common::utils::Utils::ExecCmd(execCmdParams, argsV, envV, exitCode, tmpProcess);
            OsalSleep(20); // If failed stop check process, the delay is 20 ms.
            continue;
        } else {
            break;
        }
    }
    if (checkProcess > 0) {
        bool isExited = false;
        ret = analysis::dvvp::common::utils::Utils::WaitProcess(checkProcess,
                                                                isExited,
                                                                exitCode,
                                                                true);
        if (ret != PROFILING_SUCCESS) {
            ret = MSPROF_DAEMON_ERROR;
            MSPROF_LOGE("Failed to wait process %d, ret=%d",
                        static_cast<int32_t>(checkProcess), ret);
        } else {
            ret = MSPROF_DAEMON_OK;
            MSPROF_LOGI("Process %d exited, exit code=%d",
                        static_cast<int32_t>(checkProcess), exitCode);
        }
    }
    return ret;
}

int32_t InputParser::CheckHostSysPidValid(const struct MsprofCmdInfo &cmdInfo)
{
    if (cmdInfo.args[ARGS_HOST_SYS_PID] == nullptr) {
        CmdLog::CmdErrorLog("Argument --host-sys-pid is empty,"
            "Please enter a valid --host-sys-pid value.");
        return MSPROF_DAEMON_ERROR;
    }

    if (Utils::CheckStringIsNonNegativeIntNum(cmdInfo.args[ARGS_HOST_SYS_PID])) {
        int32_t hostSysRet = 0;
        FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(hostSysRet, cmdInfo.args[ARGS_HOST_SYS_PID]),
            return MSPROF_DAEMON_ERROR, "ARGS_HOST_SYS_PID %s is invalid", cmdInfo.args[ARGS_HOST_SYS_PID]);
        if (!(ParamValidation::instance()->CheckHostSysPidIsValid(hostSysRet))) {
            CmdLog::CmdErrorLog("Argument --host-sys-pid: invalid int value: %d."
                "The process cannot be found, please enter a correct host-sys-pid.", hostSysRet);
            return MSPROF_DAEMON_ERROR;
        } else {
            params_->host_sys_pid = hostSysRet;
            return MSPROF_DAEMON_OK;
        }
    } else {
        CmdLog::CmdErrorLog("Argument --host-sys-pid: invalid value: %s."
            "Please input an integer value.The min value is 0.", cmdInfo.args[ARGS_HOST_SYS_PID]);
        return MSPROF_DAEMON_ERROR;
    }
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
    if (!ParamValidation::instance()->CheckScaleIsValid(cmdInfo.args[ARGS_SCALE], params_->scaleType,
        params_->scaleName, errInfo)) {
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

int32_t InputParser::MsprofHostCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt)
{
    int32_t ret = MSPROF_DAEMON_ERROR;
    if (opt > NR_ARGS) {
        return MSPROF_DAEMON_ERROR;
    }
    switch (opt) {
        case ARGS_HOST_SYS:
            ret = CheckHostSysValid(cmdInfo);
            break;
        case ARGS_HOST_SYS_PID:
            ret = CheckHostSysPidValid(cmdInfo);
            break;
        case ARGS_HOST_SYS_USAGE:
            ret = CheckHostSysUsageValid(cmdInfo);
            break;
        default:
            break;
    }
    return ret;
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
    {"clear", "Swith for using msprof to analyze or export data in clear mode, the default value is off.", OFF},
    {"analyze", "Switch for using msprof to analyze collecting data, the default value is off.", OFF},
    {"rule", "Switch specified rule for using msprof to analyze collecting data, "
        "include communication, communication_matrix.\n"
        "\t\t\t\t\t\t   the default value is communication,communication_matrix."},
    {"iteration-id", "The export iteration id, only uesd when argument export is on, the default value is 1.", "1"},
    {"model-id", "The export model id, only uesd when argument export is on, "
        "msprof will export minium accessible model by default.",
        "-1"},
    {"summary-format", "The export summary file format, only uesd when argument export is on, "
        "include csv, json, the default value is csv.", "csv"},
    {"type", "The export type, only uesd when argument `export` is on \n"
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

void ArgsManager::PrintMsopprofHelp()
{
    std::cout << "This is subcommand for operator optimization situation:" << std::endl;
    const int optionWidth = 34;
    std::cout << "      ";
    std::cout << std::left << std::setw(optionWidth) << "op";
    std::cout << "Use binary msopprof to operator optimization (msprof op ...)" << std::endl << std::endl;
}

void ArgsManager::PrintHelp()
{
    std::cout << std::endl << "Usage:" << std::endl;
    std::cout << "      ./msprof [--options]" << std::endl << std::endl;
    PrintMsopprofHelp();
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
    Args scale = {"scale", "Customized operator name and operator type with the following format: "
        "\"opName:*,*;opType:*,*\"."};
    argsList_.push_back(scale);
}
}
}
}
