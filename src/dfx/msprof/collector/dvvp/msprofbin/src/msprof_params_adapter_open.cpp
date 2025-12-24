/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msprof_params_adapter.h"
#include <google/protobuf/util/json_util.h>
#include "errno/error_code.h"
#include "message/codec.h"
#include "message/prof_params.h"
#include "config/config.h"
#include "validation/param_validation.h"
#include "config_manager.h"
#include "platform/platform.h"
namespace Analysis {
namespace Dvvp {
namespace Msprof {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;

void MsprofParamsAdapter::GenerateLlcEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    if (params == nullptr || (params->hardware_mem.compare("on") != 0)) {
        return;
    }
    if (params->llc_profiling.empty()) {
        GenerateLlcDefEvents(params);
        return;
    }
    if (Analysis::Dvvp::Common::Config::ConfigManager::instance()->IsDriverSupportLlc()) {
        if (params->llc_profiling.compare(LLC_PROFILING_READ) == 0) {
            params->llc_profiling_events = LLC_PROFILING_READ;
        } else if (params->llc_profiling.compare(LLC_PROFILING_WRITE) == 0) {
            params->llc_profiling_events = LLC_PROFILING_WRITE;
        }
    }
    if (params->llc_profiling_events.empty()) {
        MSPROF_LOGE("Does not support this llc profiling type : %s", Utils::BaseName(params->llc_profiling).c_str());
    }
}

void MsprofParamsAdapter::GenerateLlcDefEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    if (Analysis::Dvvp::Common::Config::ConfigManager::instance()->IsDriverSupportLlc()) {
        params->llc_profiling = LLC_PROFILING_READ;
        params->llc_profiling_events = LLC_PROFILING_READ;
    } else {
        MSPROF_LOGW("The current platform does not support llc profiling.");
    }
}
}
}
}