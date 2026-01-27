/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_hardware_mem_job.h"
#include "ai_drv_prof_api.h"
#include "utils/utils.h"
#include "config/config.h"
#include "config_manager.h"
#include "param_validation.h"
#include "uploader_mgr.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;

/*
 * @berif  : LLC Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfLlcJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        MSPROF_LOGI("Mini LLC Profiling not transport by driver channel");
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;

    if (collectionJobCfg_->comParams->params->msprof_llc_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("LLC Profiling not enabled");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}
}
}
}