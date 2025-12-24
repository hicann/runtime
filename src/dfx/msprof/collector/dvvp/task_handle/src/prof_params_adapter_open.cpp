/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_params_adapter.h"
#include <algorithm>
#include "json/json.h"
#include "acl/acl_prof.h"
#include "errno/error_code.h"
#include "message/prof_params.h"
#include "config/config.h"
#include "config_manager.h"
#include "validation/param_validation.h"
#include "prof_acl_api.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace Host {
namespace Adapter {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::validation;

void ProfParamsAdapter::UpdateHardwareMemParams(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> dstParams,
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> srcParams) const
{
    if (dstParams->hardware_mem.compare("on") == 0) {
        const int32_t periodUs = dstParams->hardware_mem_sampling_interval;
        const int32_t periodMs = (periodUs > DEFAULT_PROFILING_INTERVAL_10000US) ?
            (periodUs / US_CONVERT_MS) : DEFAULT_PROFILING_INTERVAL_10MS;
        dstParams->llc_profiling = "on";
        dstParams->msprof_llc_profiling = "on";
        dstParams->llc_profiling_events = srcParams->llc_profiling_events;
        dstParams->llc_interval = periodMs;
        dstParams->ddr_profiling = "on";
        dstParams->ddr_profiling_events = srcParams->ddr_profiling_events;
        dstParams->ddr_interval = periodMs;
        dstParams->ddr_master_id = srcParams->ddr_master_id;
        dstParams->memProfiling = "on";
        dstParams->memInterval = periodMs;

        dstParams->hbmProfiling = "on";
        dstParams->hbm_profiling_events = srcParams->hbm_profiling_events;
        dstParams->hbmInterval = periodMs;
    }
}

void ProfParamsAdapter::GenerateLlcEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    MSPROF_LOGI("Begin to GenerateLlcEvents");
    if (params == nullptr || params->msprof.compare("on") == 0) {
        return;
    }
    if (params->llc_profiling.empty()) {
        GenerateLlcDefEvents(params);
        return;
    }
    if (ConfigManager::instance()->IsDriverSupportLlc()) {
        if (params->llc_profiling.compare(LLC_PROFILING_READ) == 0) {
            params->llc_profiling_events = LLC_PROFILING_READ;
        } else if (params->llc_profiling.compare(LLC_PROFILING_WRITE) == 0) {
            params->llc_profiling_events = LLC_PROFILING_WRITE;
        }
    }
    if (params->llc_profiling_events.empty()) {
        MSPROF_LOGE("[GenerateLlcEvents]Does not support this llc profiling type : %s", params->llc_profiling.c_str());
    }
}

void ProfParamsAdapter::GenerateLlcDefEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (ConfigManager::instance()->IsDriverSupportLlc()) {
        params->llc_profiling = LLC_PROFILING_READ;
        params->llc_profiling_events = LLC_PROFILING_READ;
    } else {
        MSPROF_LOGW("[GenerateLlcDefEvents]The current platform does not support llc profiling.");
    }
}
}   // Adaptor
}   // Host
}   // Dvvp
}   // Analysis
