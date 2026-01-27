/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_ccu_job.h"
#include "errno/error_code.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::driver;

constexpr char CCU0_INSTRUCTION_NAME[] = "0.instr";
constexpr char CCU1_INSTRUCTION_NAME[] = "1.instr";
constexpr char CCU0_STATISTIC_NAME[] = "0.stat";
constexpr char CCU1_STATISTIC_NAME[] = "1.stat";

ProfCcuBaseJob::ProfCcuBaseJob(AI_DRV_CHANNEL channelIdCcu0, AI_DRV_CHANNEL channelIdCcu1)
    : channelIdCcu0_(channelIdCcu0), channelIdCcu1_(channelIdCcu1) {}

ProfCcuBaseJob::~ProfCcuBaseJob() {}

int32_t ProfCcuBaseJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    UNUSED(cfg);
    return PROFILING_SUCCESS;
}

int32_t ProfCcuBaseJob::Process()
{
    return PROFILING_SUCCESS;
}

int32_t ProfCcuBaseJob::Uninit()
{
    return PROFILING_SUCCESS;
}

int32_t ProfCcuBaseJob::StartCcuChannel(const std::string &jobId, int32_t deviceId,
    analysis::dvvp::driver::AI_DRV_CHANNEL channelId, const std::string &filePath)
{
    if (!DrvChannelsMgr::instance()->ChannelIsValid(deviceId, channelId)) {
        MSPROF_LOGW("Ccu channel is invalid, devId: %d, channelId: %d", deviceId,
            static_cast<int32_t>(channelId));
        return PROFILING_FAILED;
    }

    AddReader(jobId, deviceId, channelId, filePath);
    if (DrvCcuStart(deviceId, channelId) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start ccu channel: %d.", static_cast<int32_t>(channelId));
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Start profiling ccu channel: %d.", static_cast<int32_t>(channelId));
    return PROFILING_SUCCESS;
}

int32_t ProfCcuBaseJob::StopCcuChannel(const std::string &jobId, int32_t deviceId,
    analysis::dvvp::driver::AI_DRV_CHANNEL channelId) const
{
    if (!DrvChannelsMgr::instance()->ChannelIsValid(deviceId, channelId)) {
        MSPROF_LOGW("Ccu channel is invalid, devId: %d, channelId: %d", deviceId,
            static_cast<int32_t>(channelId));
        return PROFILING_FAILED;
    }

    if (DrvStop(deviceId, channelId) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to stop ccu channel: %d.", static_cast<int32_t>(channelId));
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Stop profiling ccu channel: %d.", static_cast<int32_t>(channelId));
    RemoveReader(jobId, deviceId, channelId);
    return PROFILING_SUCCESS;
}

ProfCcuInstrJob::ProfCcuInstrJob() : ProfCcuBaseJob(PROF_CHANNEL_CCU_INSTR_CCU0, PROF_CHANNEL_CCU_INSTR_CCU1) {}

ProfCcuInstrJob::~ProfCcuInstrJob() {}

int32_t ProfCcuInstrJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        MSPROF_LOGI("Ccu instruction not enabled in host profiling.");
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->ccuInstr.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Ccu instruction not enabled with ccuInstr switch off.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfCcuInstrJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    MSPROF_LOGI("Begin to start profiling ccu instruction, devId: %d", collectionJobCfg_->comParams->devId);

    std::string filePathCcu0 = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath + CCU0_INSTRUCTION_NAME);
    int32_t ret = StartCcuChannel(collectionJobCfg_->comParams->params->job_id,
        collectionJobCfg_->comParams->devId, channelIdCcu0_, filePathCcu0);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_INNER_ERROR("EK9999", "ProfCcuInstrJob Process failed");
        return ret;
    }

    std::string filePathCcu1 = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath + CCU1_INSTRUCTION_NAME);
    ret = StartCcuChannel(collectionJobCfg_->comParams->params->job_id,
        collectionJobCfg_->comParams->devId, channelIdCcu1_, filePathCcu1);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_INNER_ERROR("EK9999", "ProfCcuInstrJob Process failed");
        return ret;
    }
    return ret;
}

int32_t ProfCcuInstrJob::Uninit()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);
    int32_t ret = StopCcuChannel(collectionJobCfg_->comParams->params->job_id,
        collectionJobCfg_->comParams->devId, channelIdCcu0_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_INNER_ERROR("EK9999", "ProfCcuInstrJob Uninit failed");
        return ret;
    }

    ret = StopCcuChannel(collectionJobCfg_->comParams->params->job_id,
        collectionJobCfg_->comParams->devId, channelIdCcu1_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_INNER_ERROR("EK9999", "ProfCcuInstrJob Uninit failed");
        return ret;
    }
    return ret;
}

ProfCcuStatJob::ProfCcuStatJob() : ProfCcuBaseJob(PROF_CHANNEL_CCU_STAT_CCU0, PROF_CHANNEL_CCU_STAT_CCU1) {}

ProfCcuStatJob::~ProfCcuStatJob() {}

int32_t ProfCcuStatJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        MSPROF_LOGI("Ccu statistic not enabled in host profiling.");
        return PROFILING_FAILED;
    }
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_CCU_STATISTIC)) {
        MSPROF_LOGI("The platform not support ccu statistic feature.");
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->ccuInstr.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Ccu statistic not enabled with ccuInstr switch off.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfCcuStatJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    MSPROF_LOGI("Begin to start profiling ccu statistic, devId: %d", collectionJobCfg_->comParams->devId);

    std::string filePathCcu0 = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath + CCU0_STATISTIC_NAME);
    int32_t ret = StartCcuChannel(collectionJobCfg_->comParams->params->job_id,
        collectionJobCfg_->comParams->devId, channelIdCcu0_, filePathCcu0);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_INNER_ERROR("EK9999", "ProfCcuStatJob Process failed");
        return ret;
    }

    std::string filePathCcu1 = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath + CCU1_STATISTIC_NAME);
    ret = StartCcuChannel(collectionJobCfg_->comParams->params->job_id,
        collectionJobCfg_->comParams->devId, channelIdCcu1_, filePathCcu1);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_INNER_ERROR("EK9999", "ProfCcuStatJob Process failed");
        return ret;
    }
    return ret;
}

int32_t ProfCcuStatJob::Uninit()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);
    int32_t ret = StopCcuChannel(collectionJobCfg_->comParams->params->job_id,
        collectionJobCfg_->comParams->devId, channelIdCcu0_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_INNER_ERROR("EK9999", "ProfCcuStatJob Uninit failed");
        return ret;
    }

    ret = StopCcuChannel(collectionJobCfg_->comParams->params->job_id,
        collectionJobCfg_->comParams->devId, channelIdCcu1_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_INNER_ERROR("EK9999", "ProfCcuStatJob Uninit failed");
        return ret;
    }
    return ret;
}
}
}
}