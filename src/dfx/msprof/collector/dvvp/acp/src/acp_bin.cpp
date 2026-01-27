/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <fstream>
#include <string>
#include "cmd_log/cmd_log.h"
#include "argparser.h"
#include "acp_command.h"
#include "env_manager.h"

using namespace analysis::dvvp::common::cmdlog;
using namespace Analysis::Dvvp::App;
using namespace analysis::dvvp::common::utils;
using namespace Collector::Dvvp::Acp;

static void SetEnvList(CONST_CHAR_PTR &envp, std::vector<std::string> &envpList)
{
    uint32_t envpLen = 0;
    constexpr uint32_t maxEnvpLen = 4096;
    const char **env = &envp;
    while (*env) {
        envpList.push_back(*env++);
        envpLen++;
        if (envpLen >= maxEnvpLen) {
            CmdLog::CmdErrorLog("Truncate env params due to exceeding limit!");
            break;
        }
    }
}

#ifdef __PROF_LLT
int32_t LltAcpMain(int32_t argc, const char *argv[], const char **envp)
#else
int32_t main(int32_t argc, const char *argv[], const char **envp)
#endif
{
    std::vector<std::string> envpList;
    SetEnvList(*envp, envpList);
    EnvManager::instance()->SetGlobalEnv(envpList);
    EnvManager::instance()->SetParamEnv("acp");
    auto acpCommand = AcpCommandBuild("acp");
    acpCommand.Parse(argc, argv);
    return acpCommand.Execute();
}