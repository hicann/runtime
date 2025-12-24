/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "running_mode.h"
#include <chrono>
#include "errno/error_code.h"
#include "input_parser.h"
#include "cmd_log/cmd_log.h"
#include "msprof_dlog.h"
#include "ai_drv_dev_api.h"
#include "msprof_params_adapter.h"
#include "config_manager.h"
#include "application.h"
#include "transport/file_transport.h"
#include "transport/uploader_mgr.h"
#include "task_relationship_mgr.h"
#include "osal.h"
#include "platform/platform.h"
#include "env_manager.h"
#include "dyn_prof_client.h"

namespace Collector {
namespace Dvvp {
namespace Msprofbin {
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::driver;
using namespace Analysis::Dvvp::Msprof;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::utils;
using namespace Collector::Dvvp::DynProf;

AppMode::AppMode(std::string preCheckParams, SHARED_PTR_ALIA<ProfileParams> params)
    : RunningMode(preCheckParams, "app", params)
{
    whiteSet_ = {
        ARGS_OUTPUT, ARGS_STORAGE_LIMIT, ARGS_APPLICATION, ARGS_ENVIRONMENT, ARGS_DYNAMIC_PROF, ARGS_DYNAMIC_PROF_PID,
        ARGS_AIC_MODE, ARGS_AIC_METRICS, ARGS_AIV_MODE, ARGS_AIV_METRICS, ARGS_LLC_PROFILING,
        ARGS_ASCENDCL, ARGS_AI_CORE, ARGS_AIV, ARGS_MODEL_EXECUTION, ARGS_TASK_MEMORY,
        ARGS_RUNTIME_API, ARGS_TASK_TIME, ARGS_GE_API, ARGS_AICPU,
        ARGS_CPU_PROFILING, ARGS_SYS_PROFILING, ARGS_PID_PROFILING, ARGS_HARDWARE_MEM, ARGS_IO_PROFILING,
        ARGS_INTERCONNECTION_PROFILING, ARGS_DVPP_PROFILING, ARGS_L2_PROFILING, ARGS_AIC_FREQ,
        ARGS_AIV_FREQ, ARGS_INSTR_PROFILING_FREQ, ARGS_INSTR_PROFILING, ARGS_HCCL,
        ARGS_SYS_SAMPLING_FREQ, ARGS_PID_SAMPLING_FREQ, ARGS_HARDWARE_MEM_SAMPLING_FREQ,
        ARGS_IO_SAMPLING_FREQ, ARGS_DVPP_FREQ,  ARGS_CPU_SAMPLING_FREQ, ARGS_INTERCONNECTION_FREQ,
        ARGS_HOST_SYS, ARGS_PYTHON_PATH, ARGS_MSPROFTX, ARGS_DELAY_PROF, ARGS_DURATION_PROF, ARGS_SCALE,
        ARGS_EXPORT_TYPE, ARGS_MSTX_DOMAIN_INCLUDE, ARGS_MSTX_DOMAIN_EXCLUDE
    };
}

int32_t RunningMode::HandleProfilingParams() const
{
    if (params_ == nullptr) {
        MSPROF_LOGE("ProfileParams is not valid!");
        return PROFILING_FAILED;
    }
    if (params_->devices.compare("all") == 0) {
        params_->devices = DrvGetDevIdsStr();
    }
    std::string aiCoreMetrics;
    std::string aiVectMetrics;
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_V3_TYPE) {
        aiCoreMetrics = params_->ai_core_metrics.empty() ? PIPE_EXECUTION_UTILIZATION : params_->ai_core_metrics;
    } else {
        aiCoreMetrics = params_->ai_core_metrics.empty() ? PIPE_UTILIZATION : params_->ai_core_metrics;
    }
    aiVectMetrics = aiCoreMetrics;
    ConfigManager::instance()->GetVersionSpecificMetrics(aiCoreMetrics);
    int32_t ret = Platform::instance()->GetAicoreEvents(aiCoreMetrics, params_->ai_core_profiling_events);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("The intput of ai_core_metrics is invalid");
        return PROFILING_FAILED;
    }
    params_->ai_core_metrics = aiCoreMetrics;
    ret = Platform::instance()->GetAicoreEvents(aiVectMetrics, params_->aiv_profiling_events);
    params_->aiv_metrics = aiVectMetrics;
    Platform::instance()->L2CacheAdaptor(params_->npuEvents, params_->l2CacheTaskProfiling,
        params_->l2CacheTaskProfilingEvents);
    Analysis::Dvvp::Msprof::MsprofParamsAdapter::instance()->GenerateLlcEvents(params_);
    params_->msprofBinPid = Utils::GetPid();
    return MsprofParamsAdapter::instance()->UpdateParams(params_);
}

void AppMode::SetDefaultParamsByPlatformType() const
{
    if (params_->taskTrace == "off" || params_->taskTime == "off") {
        return;
    }
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_STARS_ACSQ)) {
        if (params_->stars_acsq_task.empty()) {
            params_->stars_acsq_task = MSVP_PROF_ON;
        }
    } else {
        if (params_->hwts_log.empty()) {
            params_->hwts_log = "on";
        }
        if (params_->hwts_log1.empty()) {
            params_->hwts_log1 = "on";
        }
    }
    if (params_->ts_memcpy.empty()) {
        params_->ts_memcpy = "on";
    }
}

SystemMode::SystemMode(std::string preCheckParams, SHARED_PTR_ALIA<ProfileParams> params)
    : RunningMode(preCheckParams, "system", params)
{
    whiteSet_ = {
        ARGS_OUTPUT, ARGS_STORAGE_LIMIT, ARGS_AIC_MODE, ARGS_SYS_DEVICES,
        ARGS_AIC_METRICS, ARGS_AIV_MODE, ARGS_AIV_METRICS, ARGS_LLC_PROFILING,
        ARGS_AI_CORE, ARGS_AIV, ARGS_CPU_PROFILING, ARGS_SYS_PROFILING,
        ARGS_PID_PROFILING, ARGS_HARDWARE_MEM, ARGS_IO_PROFILING, ARGS_INTERCONNECTION_PROFILING,
        ARGS_DVPP_PROFILING, ARGS_AIC_FREQ, ARGS_AIV_FREQ,
        ARGS_INSTR_PROFILING_FREQ, ARGS_INSTR_PROFILING, ARGS_SYS_SAMPLING_FREQ, ARGS_PID_SAMPLING_FREQ,
        ARGS_HARDWARE_MEM_SAMPLING_FREQ, ARGS_IO_SAMPLING_FREQ, ARGS_DVPP_FREQ,
        ARGS_CPU_SAMPLING_FREQ, ARGS_INTERCONNECTION_FREQ, ARGS_HOST_SYS, ARGS_SYS_PERIOD,
        ARGS_HOST_SYS_PID, ARGS_HOST_SYS_USAGE, ARGS_HOST_SYS_USAGE_FREQ, ARGS_PYTHON_PATH
    };
    neccessarySet_ = { ARGS_OUTPUT, ARGS_SYS_PERIOD };
}

bool SystemMode::IsDeviceJob() const
{
    if (params_ == nullptr) {
        return false;
    }
    if (params_->cpu_profiling.compare("on") == 0 || params_->sys_profiling.compare("on") == 0 ||
        params_->pid_profiling.compare("on") == 0) {
        return true;
    } else {
        return false;
    }
}

SHARED_PTR_ALIA<ProfileParams> SystemMode::GenerateDeviceParam(SHARED_PTR_ALIA<ProfileParams> params) const
{
    if (params == nullptr) {
        return nullptr;
    }
    SHARED_PTR_ALIA<ProfileParams> dstParams = nullptr;
    MSVP_MAKE_SHARED0(dstParams, ProfileParams, return nullptr);
    dstParams->result_dir = params->result_dir;
    dstParams->sys_profiling = params->sys_profiling;
    dstParams->sys_sampling_interval = params->sys_sampling_interval;
    dstParams->pid_profiling = params->pid_profiling;
    dstParams->pid_sampling_interval = params->pid_sampling_interval;
    dstParams->cpu_profiling = params->cpu_profiling;
    dstParams->cpu_sampling_interval = params->cpu_sampling_interval;
    dstParams->aiCtrlCpuProfiling = params->aiCtrlCpuProfiling;
    dstParams->ai_ctrl_cpu_profiling_events = params->ai_ctrl_cpu_profiling_events;
    dstParams->profiling_period = params->profiling_period;
    uintptr_t addr = reinterpret_cast<uintptr_t>(dstParams.get());
    dstParams->job_id = Utils::ProfCreateId(static_cast<uint64_t>(addr));
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_V4_1_0) {
        dstParams->instrProfiling = params->instrProfiling;
        dstParams->instrProfilingFreq = params->instrProfilingFreq;
    }
    return dstParams;
}
}
}
}
