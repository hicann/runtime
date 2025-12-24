/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_acl_mgr.h"
#include <iomanip>
#include <algorithm>
#include "config/config.h"
#include "config_manager.h"
#include "errno/error_code.h"
#include "logger/msprof_dlog.h"
#include "message/prof_params.h"
#include "msprofiler_impl.h"
#include "msprof_reporter.h"
#include "op_desc_parser.h"
#include "platform/platform.h"
#include "prof_manager.h"
#include "transport/file_transport.h"
#include "transport/uploader.h"
#include "transport/uploader_mgr.h"
#include "transport/hash_data.h"
#include "transport/hdc/helper_transport.h"
#include "adx_prof_api.h"
#include "param_validation.h"
#include "command_handle.h"
#include "prof_channel_manager.h"
#include "prof_ge_core.h"
#include "msproftx_adaptor.h"
#include "utils/utils.h"
#include "prof_reporter_mgr.h"
#include "prof_hal_plugin.h"
#include "prof_acl_intf.h"

using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::host;
using namespace Analysis::Dvvp::Host::Adapter;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::transport;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::JobWrapper;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace Analysis::Dvvp::ProfilerCommon;

namespace Msprofiler {
namespace Api {
/**
 * @brief  : TaskBased transfer dataTypeConfig to ProfApiStartReq
 * @param  : [in] msprofStartCfg : msprof cfg
 * @param  : [out] ProfApiStartReq : acl api struct cfg
 */
void ProfAclMgr::TaskBasedCfgTrfToReq(const uint64_t dataTypeConfig, ProfAicoreMetrics aicMetrics,
    SHARED_PTR_ALIA<ProfApiStartReq> feature) const
{
    // task-based StartCfg Transfer
    MSPROF_LOGI("Begin to transfer task=based msprof StartCfg to api StartReq");
    feature->featureName = PROF_FEATURE_TASK;
    // ts_timeline & hwts
    if ((dataTypeConfig & PROF_TASK_TIME_MASK) != 0) {
        feature->hwtsLog = "on";
    }
    // ts_track
    if ((dataTypeConfig & PROF_SCHEDULE_TRACE_MASK) != 0) {
        feature->tsTaskTrack = "on";
    }
    // training trace
    if ((dataTypeConfig & PROF_TRAINING_TRACE_MASK) != 0) {
        feature->tsFwTraining = "on";
    }
    SHARED_PTR_ALIA<ProfApiSysConf> conf = nullptr;
    MSVP_MAKE_SHARED0(conf, ProfApiSysConf, return);
    std::string metrics;
    AicoreMetricsEnumToName(aicMetrics, metrics);
    // ai_core and aiv
    if ((dataTypeConfig & PROF_AICORE_METRICS_MASK) != 0 && !metrics.empty()) {
        conf->aicoreMetrics = metrics;
        conf->aivMetrics = metrics;
    }
    // l2cache
    if ((dataTypeConfig & PROF_L2CACHE_MASK) != 0) {
        conf->l2 = MSVP_PROF_ON;
    }
    if (!conf->aicoreMetrics.empty() || !conf->aivMetrics.empty() || !conf->l2.empty()) {
        feature->taskTraceConf = ProfParamsAdapter::instance()->EncodeSysConfJson(conf);
    }
}

void ProfAclMgr::AicoreMetricsEnumToName(ProfAicoreMetrics aicMetrics, std::string &name) const
{
    switch (aicMetrics) {
        case PROF_AICORE_ARITHMETIC_UTILIZATION:
            name = ARITHMETIC_UTILIZATION;
            break;
        case PROF_AICORE_PIPE_UTILIZATION:
            name = PIPE_UTILIZATION;
            break;
        case PROF_AICORE_PIPE_EXECUTE_UTILIZATION:
            name = PIPE_EXECUTION_UTILIZATION;
            break;
        case PROF_AICORE_MEMORY_BANDWIDTH:
            name = MEMORY_BANDWIDTH;
            break;
        case PROF_AICORE_L0B_AND_WIDTH:
            name = L0B_AND_WIDTH;
            break;
        case PROF_AICORE_RESOURCE_CONFLICT_RATIO:
            name = RESOURCE_CONFLICT_RATIO;
            break;
        case PROF_AICORE_MEMORY_UB:
            name = MEMORY_UB;
            break;
        case PROF_AICORE_L2_CACHE:
            if (ConfigManager::instance()->GetPlatformType() == PlatformType::CLOUD_TYPE ||
                ConfigManager::instance()->GetPlatformType() == PlatformType::DC_TYPE) {
                MSPROF_LOGE("Invalid aicore metrics enum: %u", static_cast<uint32_t>(aicMetrics));
                MSPROF_INNER_ERROR("EK9999", "Invalid aicore metrics enum: %u", static_cast<uint32_t>(aicMetrics));
                break;
            }
            name = L2_CACHE;
            break;
        case PROF_AICORE_MEMORY_ACCESS:
            if (ConfigManager::instance()->GetPlatformType() != PlatformType::CHIP_V4_1_0) {
                MSPROF_LOGE("Invalid aicore metrics enum: %u", static_cast<uint32_t>(aicMetrics));
                MSPROF_INNER_ERROR("EK9999", "Invalid aicore metrics enum: %u", static_cast<uint32_t>(aicMetrics));
                break;
            }
            name = MEMORY_ACCESS;
            break;
        case PROF_AICORE_NONE:
            break;
        default:
            MSPROF_LOGE("Invalid aicore metrics enum: %u", static_cast<uint32_t>(aicMetrics));
            MSPROF_INNER_ERROR("EK9999", "Invalid aicore metrics enum: %u", static_cast<uint32_t>(aicMetrics));
    }
}

int32_t ProfAclMgr::MsprofAclJsonMetricsConstruct(NanoJson::Json &acljsonCfg)
{
    std::string aiCoreMetrics;
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_V3_TYPE) {
        aiCoreMetrics = GetJsonMetricsParam(acljsonCfg, "aic_metrics", PIPE_EXECUTION_UTILIZATION,
            PIPE_EXECUTION_UTILIZATION);
    } else {
        aiCoreMetrics = GetJsonMetricsParam(acljsonCfg, "aic_metrics", PIPE_UTILIZATION, PIPE_UTILIZATION);
    }
    std::string aiVectMetrics = aiCoreMetrics;
    ConfigManager::instance()->GetVersionSpecificMetrics(aiCoreMetrics);
    auto ret = Platform::instance()->GetAicoreEvents(aiCoreMetrics, params_->ai_core_profiling_events);
    ret = Platform::instance()->GetAicoreEvents(aiVectMetrics, params_->aiv_profiling_events);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("The parameter of aic_metrics in aclJsonConfig is invalid");
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({
                "aic_metrics", aiCoreMetrics, "The parameter of aic_metrics in aclJsonConfig is invalid"
            }));
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    params_->ai_core_metrics = aiCoreMetrics;
    params_->aiv_metrics = aiVectMetrics;
    MSPROF_LOGI("MsprofInitAclJson, aicoreMetricsType:%s, aicoreEvents:%s, hcclTrace: %s",
        params_->ai_core_metrics.c_str(), params_->ai_core_profiling_events.c_str(), params_->hcclTrace.c_str());
    return MSPROF_ERROR_NONE;
}
}   // namespace Api
}   // namespace Msprofiler
