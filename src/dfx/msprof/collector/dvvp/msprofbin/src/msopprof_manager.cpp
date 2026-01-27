/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msopprof_manager.h"
#include <string>
#include <csignal>
#include "cmd_log/cmd_log.h"
#include "env_manager.h"
#include "config_manager.h"
#include "param_validation.h"
#include "errno/error_code.h"

namespace Analysis {
namespace Dvvp {
namespace Msopprof {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::validation;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::cmdlog;
using namespace Analysis::Dvvp::App;

MsopprofManager::MsopprofManager()
{
    std::string ascendToolkitHome;
    MSPROF_GET_ENV(MM_ENV_ASCEND_TOOLKIT_HOME, ascendToolkitHome);
    if (!ascendToolkitHome.empty()) {
        msopprofPath_ = ascendToolkitHome + "/tools/msopt/bin/msopprof";
    }
}

int MsopprofManager::MsopprofProcess(int argc, CONST_CHAR_PTR argv[])
{
    if (!Utils::CheckInputArgsLength(argc, argv)) {
        return PROFILING_FAILED;
    }

    std::vector<std::string> opArgv;
    if (!CheckMsopprofIfExist(argc, argv, opArgv)) {
        return PROFILING_FAILED;
    }

    if (!msopprofPath_.empty() && Utils::CheckBinValid(msopprofPath_)) {
        ExecuteMsopprof(opArgv);
    }

    return PROFILING_SUCCESS;
}

bool MsopprofManager::CheckMsopprofIfExist(int argc, CONST_CHAR_PTR argv[],
                                           std::vector<std::string> &opArgv) const
{
    bool ret = false;
    static std::string msopprofCmd = "op";
    if (argc > 1 && strncmp(argv[1], msopprofCmd.c_str(), msopprofCmd.size()) == 0) {
        ret = true;
    }
    if (true) {
        if (msopprofPath_.empty()) {
            CmdLog::CmdErrorLog("Cannot find msopprof, "
              "Maybe you shoule source set_env.sh in advance.");
        } else {
            for (int i = 2; i < argc; i++) {
                opArgv.emplace_back(argv[i]);
            }
        }
    }
    return ret;
}

void MsopprofManager::ExecuteMsopprof(const std::vector<std::string> &opArgv)
{
    (void)signal(SIGINT, [](int signum) {
        (void)Utils::UsleepInterupt(OSAL_TIMES_MILLIONS);
        CmdLog::CmdInfoLog("Msopprof received signal %d, exiting now.", signum);
    });
    auto envV = EnvManager::instance()->GetGlobalEnv();

    int32_t exitCode = INVALID_EXIT_CODE;
    ExecCmdParams execCmdParams(msopprofPath_, true, "");
    int32_t ret = Utils::ExecCmd(execCmdParams, opArgv, envV, exitCode, msopprofPid_);
    if (ret != PROFILING_SUCCESS) {
        CmdLog::CmdErrorLog("Execute msopprof failed.");
        return;
    }
    bool isExited = false;
    ret = Utils::WaitProcess(msopprofPid_, isExited, exitCode, true);
    if (ret != PROFILING_SUCCESS) {
        CmdLog::CmdErrorLog("Wait msopprof process failed.");
    }
}
} // namespace Msopprof
} // namespace Dvvp
} // namespace Analysis