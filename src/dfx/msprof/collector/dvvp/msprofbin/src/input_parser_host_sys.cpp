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
#include <fstream>
#include <sstream>
#include "cmd_log/cmd_log.h"
#include "errno/error_code.h"
#include "param_validation.h"
#include "utils/utils.h"
#include "config_manager.h"
#include "platform/platform.h"
#include "config/config.h"
#include "msprof_dlog.h"
#include "osal.h"

namespace Analysis {
namespace Dvvp {
namespace Msprof {
using namespace analysis::dvvp::common::validation;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::cmdlog;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::config;

const std::string ON = "on";
constexpr int32_t MSPROF_DAEMON_ERROR       = -1;
constexpr int32_t MSPROF_DAEMON_OK          = 0;
constexpr int32_t FILE_FIND_REPLAY          = 100;
const std::string TOOL_NAME_PERF    = "perf";
const std::string TOOL_NAME_LTRACE  = "ltrace";
const std::string TOOL_NAME_IOTOP   = "iotop";

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

int32_t InputParser::CheckOsrtTools() const
{
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
    return MSPROF_DAEMON_OK;
}

int32_t InputParser::CheckDiskTool() const
{
    if (CheckHostSysToolsIsExist(TOOL_NAME_IOTOP, PROF_SCRIPT_FILE_PATH) != MSPROF_DAEMON_OK) {
        CmdLog::CmdErrorLog("The tool iotop is invalid, please check if"
            " the tool and sudo are available.");
        return MSPROF_DAEMON_ERROR;
    }
    return MSPROF_DAEMON_OK;
}

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
        int32_t ret = CheckOsrtTools();
        if (ret != MSPROF_DAEMON_OK) {
            return ret;
        }
    }
    if (params_->host_disk_profiling.compare(ON) == 0) {
        int32_t ret = CheckDiskTool();
        if (ret != MSPROF_DAEMON_OK) {
            return ret;
        }
    }
    params_->host_sys = cmdInfo.args[ARGS_HOST_SYS];
    params_->host_disk_freq = 50;
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

int32_t InputParser::CheckHostSysToolsIsExist(const std::string toolName, const std::string exeCmd) const
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
            OsalSleep(20);
            continue;
        } else {
            break;
        }
    }
    for (int32_t i = 0; i < FILE_FIND_REPLAY; i++) {
        int64_t len = analysis::dvvp::common::utils::Utils::GetFileSize(tmpDir);
        if (len < static_cast<int64_t>(toolName.length())) {
            OsalSleep(5);
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
        ret = UninitCheckHostSysCmd(tmpProcess);
        if (ret != MSPROF_DAEMON_ERROR) {
            MSPROF_LOGE("Failed to kill the process.");
        }
        MSPROF_LOGE("The tool %s useless", toolName.c_str());
        return MSPROF_DAEMON_ERROR;
    }
    return ret;
}

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
            OsalSleep(20);
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
}
}
}
