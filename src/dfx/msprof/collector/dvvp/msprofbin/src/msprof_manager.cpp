/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprof_manager.h"
#include "errno/error_code.h"
#include "cmd_log/cmd_log.h"
#include "message/prof_params.h"
#include "platform/platform.h"
#include "dyn_prof_client.h"
#include "input_parser.h"

namespace Analysis {
namespace Dvvp {
namespace Msprof {
using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Collector::Dvvp::Msprofbin;
using namespace Collector::Dvvp::DynProf;
using namespace Analysis::Dvvp::Common::Platform;

MsprofManager::MsprofManager() {}

MsprofManager::~MsprofManager() {}

int32_t MsprofManager::Init(SHARED_PTR_ALIA<ProfileParams> params)
{
    MSPROF_LOGI("init MsprofManager begin.");
    if (params == nullptr) {
        MSPROF_LOGE("MsprofManager init failed because of params is null.");
        return PROFILING_FAILED;
    }
    params_ = params;
    if (GenerateRunningMode() != PROFILING_SUCCESS) {
        MSPROF_LOGE("MsprofManager init failed because of generating running mode error.");
        return PROFILING_FAILED;
    }
    if (ParamsCheck() != PROFILING_SUCCESS) {
        MSPROF_LOGE("MsprofManager init failed because of checking params failed.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("init MsprofManager end.");
    return PROFILING_SUCCESS;
}

int32_t MsprofManager::UnInit()
{
    params_.reset();
    rMode_.reset();
    return PROFILING_SUCCESS;
}

void MsprofManager::NotifyStop()
{
    if (rMode_ == nullptr) {
        return;
    }
    rMode_->isQuit_ = true;
}

int32_t MsprofManager::MsProcessCmd() const
{
    if (rMode_ == nullptr) {
        MSPROF_LOGE("[MsprocessCmd] No running mode found!");
        return PROFILING_FAILED;
    }
    return rMode_->RunModeTasks();
}

SHARED_PTR_ALIA<MsprofTask> MsprofManager::GetTask(const std::string &jobId)
{
    if (rMode_ == nullptr) {
        MSPROF_LOGE("[MsprocessCmd] Get running mode failed");
        return nullptr;
    }
    return rMode_->GetRunningTask(jobId);
}

int32_t MsprofManager::GenerateRunningMode()
{
    MSPROF_LOGI("[MsprofManager] GenerateRunningMode");
    if (params_ == nullptr) {
        MSPROF_LOGE("[MsprocessCmd] Invalid params!");
        return PROFILING_FAILED;
    }

    if (GenerateCollectRunningMode() == PROFILING_SUCCESS ||
        GenerateAnalyzeRunningMode() == PROFILING_SUCCESS) {
        return PROFILING_SUCCESS;
    }

    if (Platform::instance()->RunSocSide()) {
        CmdLog::CmdErrorLog("No valid argument found in --application --sys-devices");
    } else {
        CmdLog::CmdErrorLog("No valid argument found in --application "
            "--sys-devices --host-sys --host-sys-usage --parse --query --export --analyze");
    }

    ArgsManager::instance()->PrintHelp();
    return PROFILING_FAILED;
}

int32_t MsprofManager::GenerateCollectRunningMode()
{
    if (!params_->app.empty() || DynProfCliMgr::instance()->IsDynProfCliEnable()) {
        MSVP_MAKE_SHARED2(rMode_, AppMode, "application", params_, return PROFILING_FAILED);
        return PROFILING_SUCCESS;
    }

    if (!params_->devices.empty()) {
        if (Platform::instance()->PlatformIsHelperHostSide()) {
            CmdLog::CmdErrorLog("sys-device mode not support in helper");
            return PROFILING_FAILED;
        }
        MSVP_MAKE_SHARED2(rMode_, SystemMode, "sys-devices", params_, return PROFILING_FAILED);
        return PROFILING_SUCCESS;
    }

    if (!params_->host_sys.empty()) {
        if (Platform::instance()->PlatformIsHelperHostSide()) {
            CmdLog::CmdErrorLog("sys-host_sys mode not support in helper");
            return PROFILING_FAILED;
        }
        MSVP_MAKE_SHARED2(rMode_, SystemMode, "host-sys", params_, return PROFILING_FAILED);
        return PROFILING_SUCCESS;
    }

    if (!params_->hostSysUsage.empty()) {
        if (Platform::instance()->PlatformIsHelperHostSide()) {
            CmdLog::CmdErrorLog("sys-host_sys_usage mode not support in helper");
            return PROFILING_FAILED;
        }
        MSVP_MAKE_SHARED2(rMode_, SystemMode, "host-sys-usage", params_, return PROFILING_FAILED);
        return PROFILING_SUCCESS;
    }

    return PROFILING_FAILED;
}

int32_t MsprofManager::GenerateAnalyzeRunningMode()
{
    if (params_->parseSwitch == MSVP_PROF_ON) {
        MSVP_MAKE_SHARED2(rMode_, ParseMode, "parse", params_, return PROFILING_FAILED);
        return PROFILING_SUCCESS;
    }

    if (params_->querySwitch == MSVP_PROF_ON) {
        MSVP_MAKE_SHARED2(rMode_, QueryMode, "query", params_, return PROFILING_FAILED);
        return PROFILING_SUCCESS;
    }

    if (params_->exportSwitch == MSVP_PROF_ON) {
        MSVP_MAKE_SHARED2(rMode_, ExportMode, "export", params_, return PROFILING_FAILED);
        return PROFILING_SUCCESS;
    }

    if (params_->analyzeSwitch == MSVP_PROF_ON) {
        MSVP_MAKE_SHARED2(rMode_, AnalyzeMode, "analyze", params_, return PROFILING_FAILED);
        return PROFILING_SUCCESS;
    }

    return PROFILING_FAILED;
}

int32_t MsprofManager::ParamsCheck() const
{
    if (params_ == nullptr) {
        MSPROF_LOGE("[MsprocessCmd] Invalid params!");
        return PROFILING_FAILED;
    }
    if (rMode_ == nullptr) {
        MSPROF_LOGE("[MsprocessCmd] Invalid running mode!");
        return PROFILING_FAILED;
    }
    if (rMode_->ModeParamsCheck() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[MsprocessCmd] Invalid input arguments!");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}
}
}
}
