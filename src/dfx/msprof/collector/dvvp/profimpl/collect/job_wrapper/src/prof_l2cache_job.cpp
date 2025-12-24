/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_l2cache_job.h"
#include "errno/error_code.h"
#include "param_validation.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Platform;

ProfL2CacheTaskJob::ProfL2CacheTaskJob() {}

ProfL2CacheTaskJob::~ProfL2CacheTaskJob() {}

int32_t ProfL2CacheTaskJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->l2CacheTaskProfiling.compare(
        analysis::dvvp::common::config::MSVP_PROF_ON) != 0 ||
        (DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, PROF_CHANNEL_SOC_PMU) &&
        Platform::instance()->CheckIfSupport(PLATFORM_TASK_SOC_PMU))) {
        MSPROF_LOGI("ProfL2CacheTaskJob Not Enabled");
        return PROFILING_FAILED;
    }

    static const int32_t L2_CACHE_TASK_EVENT_MAX_SIZE = 8;
    SHARED_PTR_ALIA<std::vector<std::string>> l2CacheTaskProfilingEvents;
    MSVP_MAKE_SHARED0(l2CacheTaskProfilingEvents, std::vector<std::string>, return PROFILING_FAILED);
    *l2CacheTaskProfilingEvents = analysis::dvvp::common::utils::Utils::Split(
        collectionJobCfg_->comParams->params->l2CacheTaskProfilingEvents, false, "", ",");
    bool ret = ParamValidation::instance()->CheckSocPmuEventsValid(ProfSocPmuType::PMU_TYPE_MATA,
        *l2CacheTaskProfilingEvents);
    if (!ret || l2CacheTaskProfilingEvents->size() > L2_CACHE_TASK_EVENT_MAX_SIZE) {
        MSPROF_LOGE("ProfL2CacheTaskJob Exits Error Events Size %zu bytes", l2CacheTaskProfilingEvents->size());
        MSPROF_INNER_ERROR("EK9999", "ProfL2CacheTaskJob Exits Error Events Size %zu",
            l2CacheTaskProfilingEvents->size());
        return PROFILING_FAILED;
    }

    collectionJobCfg_->jobParams.events = l2CacheTaskProfilingEvents;
    return PROFILING_SUCCESS;
}

int32_t ProfL2CacheTaskJob::Process()
{
    CHECK_JOB_EVENT_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, PROF_CHANNEL_L2_CACHE)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            PROF_CHANNEL_L2_CACHE);
        return PROFILING_SUCCESS;
    }

    std::string eventsStr = GetEventsStr(*collectionJobCfg_->jobParams.events);
    MSPROF_LOGI("Begin to start profiling L2 Cache, events:%s", eventsStr.c_str());
    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);

    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId,
        PROF_CHANNEL_L2_CACHE, filePath);
    const int32_t ret = DrvL2CacheTaskStart(
        collectionJobCfg_->comParams->devId,
        PROF_CHANNEL_L2_CACHE,
        *collectionJobCfg_->jobParams.events);
    MSPROF_LOGI("start profiling L2 Cache task, events:%s, ret=%d", eventsStr.c_str(), ret);

    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);
    return ret;
}

int32_t ProfL2CacheTaskJob::Uninit()
{
    CHECK_JOB_EVENT_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, PROF_CHANNEL_L2_CACHE)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            PROF_CHANNEL_L2_CACHE);
        return PROFILING_SUCCESS;
    }
    std::string eventsStr = GetEventsStr(*collectionJobCfg_->jobParams.events);

    const int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, PROF_CHANNEL_L2_CACHE);

    MSPROF_LOGI("stop Profiling L2 Cache Task, events:%s, ret=%d", eventsStr.c_str(), ret);

    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId,
        PROF_CHANNEL_L2_CACHE);
    collectionJobCfg_->jobParams.events.reset();
    return PROFILING_SUCCESS;
}

}
}
}
