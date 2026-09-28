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
#include "ai_drv_prof_api.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "json_parser.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Msprofiler::Parser;
using namespace Analysis::Dvvp::Common::Platform;

ProfHwtsLogJob::ProfHwtsLogJob() : channelId_(PROF_CHANNEL_HWTS_LOG) {}

ProfHwtsLogJob::~ProfHwtsLogJob() {}

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
    // The f die job owns channel 45: the acl api entry can set hwts_log
    // without the stars gate, so yield here to avoid double registration.
    if (Platform::instance()->CheckIfSupport(PLATFORM_STARS_F_DIE)) {
        MSPROF_LOGI("[ProfHwtsLogJob]channel 45 is owned by the f die job on this platform");
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

int32_t ProfHwtsLogJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    MSPROF_LOGI(
        "[ProfHwtsLogJob]Process, hwts_log:%s, aiv_hwts_log:%s", collectionJobCfg_->comParams->params->hwts_log.c_str(),
        collectionJobCfg_->comParams->params->hwts_log1.c_str());

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId, channelId_);
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

    MSPROF_LOGI(
        "[ProfHwtsLogJob]Uninit, hwts_log:%s, aiv_hwts_log:%s", collectionJobCfg_->comParams->params->hwts_log.c_str(),
        collectionJobCfg_->comParams->params->hwts_log1.c_str());

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId, channelId_);
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

ProfHwtsLogFDieJob::ProfHwtsLogFDieJob() : channelId_(PROF_CHANNEL_HWTS_LOG) {}

ProfHwtsLogFDieJob::~ProfHwtsLogFDieJob() {}

int32_t ProfHwtsLogFDieJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    if (!Platform::instance()->CheckIfSupport(PLATFORM_STARS_F_DIE)) {
        MSPROF_LOGI("[ProfHwtsLogFDieJob]F die task data not support on this platform");
        return PROFILING_FAILED;
    }
    if (cfg->comParams->params->stars_acsq_task.compare(MSVP_PROF_ON) != 0 &&
        cfg->comParams->params->taskBlock.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("[ProfHwtsLogFDieJob]task-time and task-block not enabled");
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

int32_t ProfHwtsLogFDieJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW(
            "[ProfHwtsLogFDieJob]Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGI(
        "Begin to start profiling f die task data, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
        channelId_);
    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);
    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_, filePath);
    DrvPeripheralProfileCfg drvPeripheralProfileCfg;
    drvPeripheralProfileCfg.profDeviceId = collectionJobCfg_->comParams->devId;
    drvPeripheralProfileCfg.profChannel = channelId_;
    // F die channel must reuse the P die channel 50 param set and values.
    drvPeripheralProfileCfg.profSamplePeriod = JsonParser::instance()->GetJsonChannelPeroid(PROF_CHANNEL_STARS_SOC_LOG);
    drvPeripheralProfileCfg.bufLen = JsonParser::instance()->GetJsonChannelDriverBufferLen(PROF_CHANNEL_STARS_SOC_LOG);
    int32_t ret = DrvStarsSocLogStart(drvPeripheralProfileCfg, collectionJobCfg_->comParams->params);
    MSPROF_LOGI("start profiling f die task data, ret=%d", ret);
    if (ret != PROFILING_SUCCESS) {
        RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);
        MSPROF_LOGE(
            "[ProfHwtsLogFDieJob]Process, DrvStarsSocLogStart failed, devId:%d, channelId:%d",
            collectionJobCfg_->comParams->devId, channelId_);
    }
    return ret;
}

int32_t ProfHwtsLogFDieJob::Uninit()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW(
            "[ProfHwtsLogFDieJob]Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("begin to stop profiling f die task data");

    int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE(
            "[ProfHwtsLogFDieJob]Uninit, DrvStop failed, devId:%d, channelId:%d, ret:%d",
            collectionJobCfg_->comParams->devId, channelId_, ret);
    }
    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);

    return PROFILING_SUCCESS;
}

} // namespace JobWrapper
} // namespace Dvvp
} // namespace Analysis