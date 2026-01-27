/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_biu_perf_job.h"
#include "errno/error_code.h"
#include "ai_drv_dev_api.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;

ProfBiuPerfJob::ProfBiuPerfJob(): groupNum_(BIU_PERF_LOWER_GROUP_NUM), biuPcSamplingMode_(0)
{
}

ProfBiuPerfJob::~ProfBiuPerfJob()
{
}

int32_t ProfBiuPerfJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    collectionJobCfg_ = cfg;
    if (cfg->comParams->params->hostProfiling || (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_INSTR_PROFILING) &&
        !Platform::instance()->CheckIfSupport(PLATFORM_TASK_PC_SAMPLING))) {
        MSPROF_LOGI("Biu perf job does not support.");
        return PROFILING_FAILED;
    }

    if ((cfg->comParams->params->instrProfiling.compare(MSVP_PROF_ON) != 0) &&
        (cfg->comParams->params->pcSampling.compare(MSVP_PROF_ON) != 0)) {
        MSPROF_LOGI("Biu perf job is not enabled.");
        return PROFILING_FAILED;
    }

    if (cfg->comParams->params->pcSampling.compare(MSVP_PROF_ON) == 0) {
        biuPcSamplingMode_ = 1;
        profBiuPerfJobName_ = "pc_sampling_";
        MSPROF_LOGI("Biu perf job is pc sampling.");
    } else {
        biuPcSamplingMode_ = 0;
        profBiuPerfJobName_ = "biu_perf_";
        MSPROF_LOGI("Biu perf job is perf monitor.");
    }
    int64_t aiCoreNum = 0;
    int32_t ret = DrvGetAiCoreNum(collectionJobCfg_->comParams->devId, aiCoreNum);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfBiuPerfJob]Failed to DrvGetAiCoreNum, deviceId=%d", collectionJobCfg_->comParams->devId);
        return PROFILING_FAILED;
    }
    if (aiCoreNum > DAVID_DIE0_AICORE_NUM) {
        groupNum_ = BIU_PERF_HIGHER_GROUP_NUM;
    }
    uint32_t groupVectorNum = GenGroupVector(aiCoreNum);
    if (groupVectorNum != groupNum_) {
        MSPROF_LOGE("[ProfBiuPerfJob]Create group vector number %u is different from %u.", groupVectorNum, groupNum_);
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Biu perf init success with aicore num %" PRId64 " and %u groups.", aiCoreNum, groupNum_);
    return PROFILING_SUCCESS;
}

uint32_t ProfBiuPerfJob::GenGroupVector(int64_t aiCoreNum)
{
    FUNRET_CHECK_EXPR_ACTION(aiCoreNum < 0 || aiCoreNum > std::numeric_limits<uint32_t>::max(), return 0,
        "Aicore number %" PRId64 " is abnormal.", aiCoreNum);
    uint32_t lowerCore = aiCoreNum;
    if (aiCoreNum > DAVID_DIE0_AICORE_NUM) {
        lowerCore = static_cast<uint32_t>(aiCoreNum) >> 1;
    }
    // die 0
    groupVector_.push_back(0);
    groupVector_.push_back(lowerCore >> 1);
    groupVector_.push_back(lowerCore - 1);
    if (aiCoreNum > DAVID_DIE0_AICORE_NUM) {
        // die 1
        groupVector_.push_back(lowerCore);
        groupVector_.push_back(aiCoreNum - (lowerCore >> 1));
        groupVector_.push_back(aiCoreNum - 1);
    }
    return groupVector_.size();
}

int32_t ProfBiuPerfJob::Process()
{
    CHECK_JOB_CONTEXT_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    int32_t ret = PROFILING_SUCCESS;
    int32_t devId = collectionJobCfg_->comParams->devId;
    std::vector<std::string> coreName = {"aic", "aiv0", "aiv1"};

    for (uint32_t groupId = 0; groupId < groupNum_; groupId++) {
        for (uint32_t groupType = 0; groupType < INSTR_PROFILING_GROUP_CHANNEL_NUM; groupType++) {
            if (biuPcSamplingMode_ == 1 && groupType == 0) {
                continue;
            }
            auto channelId = groupChannelIdMap_[groupId][groupType];
            if (!DrvChannelsMgr::instance()->ChannelIsValid(devId, channelId)) {
                MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", devId, channelId);
                continue;
            }
            MSPROF_LOGI("Begin to start biu perf job, devId:%d, channelId:%d, biu mode: %u", devId, channelId,
                biuPcSamplingMode_);
            std::string filePath = collectionJobCfg_->jobParams.dataPath + "." +
                profBiuPerfJobName_ + "group" + std::to_string(groupId) + "_" + coreName[groupType];
            AddReader(std::to_string(collectionJobCfg_->comParams->devId), devId, channelId, filePath);
            BiuProfileConfigT config;
            config.period = DEFAULT_BIU_PERF_CYCLE;
            config.biuPcSamplingMode = biuPcSamplingMode_;
            config.groupType = groupType;
            config.groupNo = groupVector_[groupId];
            ret = DrvInstrProfileStart(devId, channelId, static_cast<void *>(&config), sizeof(config));
            if (ret != PROFILING_SUCCESS) {
                RemoveReader(std::to_string(collectionJobCfg_->comParams->devId), devId, channelId);
                MSPROF_LOGE("[ProfBiuPerfJob]DrvInstrProfileStart failed. devId:%d, channelId:%d", devId, channelId);
                continue;
            }
            MSPROF_LOGI("Start biu perf job end, devId:%d, channelId:%d", devId, channelId);
        }
    }
    return ret;
}

int32_t ProfBiuPerfJob::Uninit()
{
    CHECK_JOB_CONTEXT_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    int32_t ret = PROFILING_SUCCESS;
    int32_t devId = collectionJobCfg_->comParams->devId;

    for (uint32_t groupId = 0; groupId < groupNum_; groupId++) {
        for (size_t i = 0; i < INSTR_PROFILING_GROUP_CHANNEL_NUM; ++i) {
            if (biuPcSamplingMode_ == 1 && i == 0) {
                continue;
            }
            auto channelId = groupChannelIdMap_[groupId][i];
            if (!DrvChannelsMgr::instance()->ChannelIsValid(devId, channelId)) {
                MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", devId, channelId);
                continue;
            }
            ret = DrvStop(devId, channelId);
            if (ret != PROFILING_SUCCESS) {
                MSPROF_LOGE("[ProfBiuPerfJob]DrvStop failed, ret:%d, devId:%d, channelId:%d", ret, devId, channelId);
            }
            RemoveReader(std::to_string(collectionJobCfg_->comParams->devId), devId, channelId);
            MSPROF_LOGI("Stop biu perf job end, devId:%d, channelId:%d", devId, channelId);
        }
    }
    return ret;
}

}
}
}