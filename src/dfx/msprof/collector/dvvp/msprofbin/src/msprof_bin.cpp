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
#include <thread>
#include <condition_variable>
#include <mutex>
#include "message/prof_params.h"
#include "errno/error_code.h"
#include "msprof_manager.h"
#include "input_parser.h"
#include "env_manager.h"
#include "platform/platform.h"
#include "config/config.h"
#include "cmd_log/cmd_log.h"
#include "dyn_prof_client.h"
#include "msopprof_manager.h"

using namespace Analysis::Dvvp::App;
using namespace Analysis::Dvvp::Msprof;
using namespace Analysis::Dvvp::Msopprof;
using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Collector::Dvvp::Msprofbin;
using namespace Collector::Dvvp::DynProf;

#if defined(__PROF_LLT)
#define STATIC
#else
#define STATIC static
#endif

STATIC void PrintOutPutDir()
{
    if (MsprofManager::instance()->rMode_ == nullptr || MsprofManager::instance()->rMode_->jobResultDir_.empty()) {
        return;
    }
    auto& outputDirInfo = MsprofManager::instance()->rMode_->jobResultDir_;
    CmdLog::CmdInfoLog("Process profiling data complete. Data is saved in %s",
        outputDirInfo.c_str());
}

STATIC void SetEnvList(CONST_CHAR_PTR &envp, std::vector<std::string> &envpList)
{
    uint32_t envpLen = 0;
    constexpr uint32_t maxEnvpLen = 4096;
    CONST_CHAR_PTR_PTR env = &envp;
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
int LltMain(int argc, const char **argv, const char **envp)
#else
int main(int argc, const char **argv, const char **envp)
#endif
{
    std::vector<std::string> envpList;
    SetEnvList(*envp, envpList);
    EnvManager::instance()->SetGlobalEnv(envpList);
    if (Platform::instance()->PlatformInitByDriver() != PROFILING_SUCCESS) {
        CmdLog::CmdErrorLog("Init platform by driver faild!");
        return PROFILING_FAILED;
    }
    if (Platform::instance()->Init() != PROFILING_SUCCESS) {
        CmdLog::CmdErrorLog("MsprofManager init failed because of init platform mode error.");
        return PROFILING_FAILED;
    }
    InputParser parser = InputParser();
    if (argc <= 1) {
        parser.MsprofCmdUsage("");
        return PROFILING_FAILED;
    }
    if (MsopprofManager::instance()->MsopprofProcess(argc, argv) == PROFILING_SUCCESS) {
        return PROFILING_SUCCESS;
    }
    auto params = parser.MsprofGetOpts(argc, argv);
    if (params == nullptr) {
        return PROFILING_FAILED;
    }
    if (MsprofManager::instance()->Init(params) != PROFILING_SUCCESS) {
        CmdLog::CmdErrorLog("Start profiling failed");
        return PROFILING_FAILED;
    }
    signal(SIGINT, [](int signum) {
        usleep(OSAL_TIMES_MILLIONS);
        if (DynProfCliMgr::instance()->IsCliStarted()) {
            CmdLog::CmdLogNoLevel("Use 'quit' or 'q' to exit dynamic profiling.");
        }
        MsprofManager::instance()->NotifyStop();
    });
    CmdLog::CmdInfoLog("Start profiling....");
    auto ret = MsprofManager::instance()->MsProcessCmd();
    if (ret != PROFILING_SUCCESS) {
        if (ret == PROFILING_NOTSUPPORT) {
            CmdLog::CmdWarningLog("System profiling isn't supported in container of ascend virtual instance.");
        } else {
            CmdLog::CmdErrorLog("Running profiling failed. Please check log for more info.");
        }
        DlogFlush();
        return ret;
    }
    if (!DynProfCliMgr::instance()->IsDynProfCliEnable()) {
        CmdLog::CmdInfoLog("Profiling finished.");
        PrintOutPutDir();
    }
    return PROFILING_SUCCESS;
}