/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_hwts_log_job.h"
#include "errno/error_code.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;

ProfHwtsLogJob::ProfHwtsLogJob() : channelId_(PROF_CHANNEL_HWTS_LOG)
{
}

ProfHwtsLogJob::~ProfHwtsLogJob()
{
}

int32_t ProfHwtsLogJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    if (cfg->comParams->params->hwts_log.compare("on") != 0) {
        MSPROF_LOGI("hwts_log not enabled");
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

int32_t ProfHwtsLogJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    MSPROF_LOGI("[ProfHwtsLogJob]Process, hwts_log:%s, aiv_hwts_log:%s",
        collectionJobCfg_->comParams->params->hwts_log.c_str(),
        collectionJobCfg_->comParams->params->hwts_log1.c_str());

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("Begin to start profiling hwts log");
    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);

    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_, filePath);

    int32_t ret = DrvHwtsLogStart(collectionJobCfg_->comParams->devId, channelId_);

    MSPROF_LOGI("start profiling hwts log, ret=%d", ret);
    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);
    return ret;
}

int32_t ProfHwtsLogJob::Uninit()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);

    MSPROF_LOGI("[ProfHwtsLogJob]Uninit, hwts_log:%s, aiv_hwts_log:%s",
        collectionJobCfg_->comParams->params->hwts_log.c_str(),
        collectionJobCfg_->comParams->params->hwts_log1.c_str());

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("begin to stop profiling hwts_log data");

    int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);

    MSPROF_LOGI("stop profiling hwts_log data, ret=%d", ret);

    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);

    return PROFILING_SUCCESS;
}

ProfAivHwtsLogJob::ProfAivHwtsLogJob() {}

ProfAivHwtsLogJob::~ProfAivHwtsLogJob() {}

int32_t ProfAivHwtsLogJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    if (cfg->comParams->params->hwts_log1.compare("on") != 0) {
        MSPROF_LOGI("aiv_hwts_log not enabled");
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    channelId_ = PROF_CHANNEL_AIV_HWTS_LOG;
    return PROFILING_SUCCESS;
}

}
}
}