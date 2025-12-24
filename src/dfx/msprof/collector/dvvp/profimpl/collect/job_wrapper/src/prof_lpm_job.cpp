/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_lpm_job.h"
#include "ai_drv_prof_api.h"
#include "utils/utils.h"
#include "config/config.h"
#include "platform/platform.h"
#include "uploader_mgr.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;        

/*
 * @berif  : Collect milan frequency conversion data
 */
ProfLpmFreqConvJob::ProfLpmFreqConvJob()
{
    channelId_ = PROF_CHANNEL_LP;
}

ProfLpmFreqConvJob::~ProfLpmFreqConvJob() {}

/*
 * @berif  : Frequency Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfLpmFreqConvJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->ai_core_lpm.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Frequency conversion is not enabled");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfLpmFreqConvJob::Process()
{
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_AICORE_LPM_INFO)) {
        std::string filePath =
            collectionJobCfg_->comParams->tmpResultDir + MSVP_SLASH + "lpmInfoConv.data";
        collectionJobCfg_->jobParams.dataPath = filePath;
    }
    return ProfPeripheralJob::Process();
}

/*
 * @berif  : Frequency Peripheral Set Config
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfLpmFreqConvJob::SetPeripheralConfig()
{
    uint32_t configSize = sizeof(LpmConvProfileConfig);
    LpmConvProfileConfig *configP = static_cast<LpmConvProfileConfig *>(Utils::ProfMalloc(configSize));
    if (configP == nullptr) {
        MSPROF_LOGE("ProfLpmFreqConvJob ProfMalloc LpmConvProfileConfig failed");
        return PROFILING_FAILED;
    }
    configP->period = DEFAULT_INTERVAL;
    configP->version = 1;
    peripheralCfg_.configP = configP;
    peripheralCfg_.configSize = configSize;
    return PROFILING_SUCCESS;
}
}
}
}