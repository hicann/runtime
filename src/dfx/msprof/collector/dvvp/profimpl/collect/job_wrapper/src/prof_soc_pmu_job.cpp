/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_soc_pmu_job.h"
#include "errno/error_code.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;

ProfSocPmuTaskJob::ProfSocPmuTaskJob() {}

ProfSocPmuTaskJob::~ProfSocPmuTaskJob() {}

int32_t ProfSocPmuTaskJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->l2CacheTaskProfiling.compare(
        analysis::dvvp::common::config::MSVP_PROF_ON) != 0 ||
        collectionJobCfg_->comParams->params->npuEvents.empty() ||
        !Platform::instance()->CheckIfSupport(PLATFORM_TASK_SOC_PMU)) {
        MSPROF_LOGI("ProfSocPmuTaskJob not enabled");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t ProfSocPmuTaskJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, PROF_CHANNEL_SOC_PMU)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            PROF_CHANNEL_SOC_PMU);
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGI("Begin to start profiling soc pmu task, events:%s",
        collectionJobCfg_->comParams->params->npuEvents.c_str());
    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);
    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId,
        PROF_CHANNEL_SOC_PMU, filePath);

    int32_t ret = DrvSocPmuTaskStart(
        collectionJobCfg_->comParams->devId,
        PROF_CHANNEL_SOC_PMU,
        collectionJobCfg_->comParams->params->npuEvents);
    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);
    MSPROF_LOGI("Success to start profiling soc pmu task, events:%s, ret:%d",
        collectionJobCfg_->comParams->params->npuEvents.c_str(), ret);
    return ret;
}

int32_t ProfSocPmuTaskJob::Uninit()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, PROF_CHANNEL_SOC_PMU)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            PROF_CHANNEL_SOC_PMU);
        return PROFILING_SUCCESS;
    }

    const int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, PROF_CHANNEL_SOC_PMU);
    MSPROF_LOGI("stop profiling soc pmu task, events:%s, ret:%d",
        collectionJobCfg_->comParams->params->npuEvents.c_str(), ret);

    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId,
        PROF_CHANNEL_SOC_PMU);
    collectionJobCfg_->jobParams.events.reset();
    return PROFILING_SUCCESS;
}

}
}
}
