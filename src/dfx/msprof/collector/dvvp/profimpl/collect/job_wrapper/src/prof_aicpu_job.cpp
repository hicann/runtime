/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_aicpu_job.h"
#include "errno/error_code.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
const char * const AICPU_EVENT_GRP_NAME = "prof_aicpu_grp";
const char * const AI_CUSTOM_CPU_EVENT_GRP_NAME = "prof_cus_grp";

ProfAicpuJob::ProfAicpuJob() : channelId_(PROF_CHANNEL_AICPU), eventGrpName_(AICPU_EVENT_GRP_NAME),
    eventAttr_{0, channelId_, AICPU_COLLECTION_JOB, false, false, false, false, 0, false, false, nullptr},
    processCount_(0) {}

ProfAicpuJob::~ProfAicpuJob()
{
    eventAttr_.isExit = true;
    eventAttr_.isWaitDevPid = false;
    if (eventAttr_.isThreadStart) {
        (void)OsalJoinTask(&eventAttr_.handle);
    }
}

int32_t ProfAicpuJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->profMode.compare(MSVP_PROF_SUBSCRIBE_MODE) == 0) {
        MSPROF_LOGI("Aicpu not enable in subscribe mode.");
        return PROFILING_FAILED;
    }

    if (!CheckChannelSwitch()) {
        MSPROF_LOGI("Aicpu channel %d not start", static_cast<int32_t>(channelId_));
        return PROFILING_FAILED;
    }

    if (!Platform::instance()->CheckIfSupportAdprof(static_cast<uint32_t>(collectionJobCfg_->comParams->devId))) {
        MSPROF_LOGI("Collect Aicpu data by HDC");
        return PROFILING_FAILED;
    }

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            static_cast<int32_t>(channelId_));
        eventAttr_.deviceId = collectionJobCfg_->comParams->devId;
        eventAttr_.grpName = eventGrpName_.c_str();
        eventAttr_.isWaitDevPid =
            (collectionJobCfg_->comParams->params->profMode.compare(MSVP_PROF_ACLAPI_MODE) == 0) ? true : false;
        int32_t ret = profDrvEvent_.SubscribeEventThreadInit(&eventAttr_);
        if (ret != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
        return PROFILING_SUCCESS;
    } else {
        eventAttr_.isChannelValid = true;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfAicpuJob::Process()
{
    CHECK_JOB_CONTEXT_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    MSPROF_LOGI("Begin to start profiling aicpu");

    if (!eventAttr_.isChannelValid) {
        MSPROF_LOGI("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId, channelId_);
        return PROFILING_SUCCESS;
    }

    // ensure only done once
    uint8_t expected = 0;
    if (!processCount_.compare_exchange_strong(expected, 1)) {
        MSPROF_LOGI("Only process once");
        return PROFILING_SUCCESS;
    }

    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);
    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_, filePath);

    int32_t ret = DrvAicpuStart(collectionJobCfg_->comParams->devId, channelId_);
    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);

    eventAttr_.isProcessRun = true;
    MSPROF_LOGI("start profiling aicpu");
    return ret;
}

int32_t ProfAicpuJob::Uninit()
{
    CHECK_JOB_CONTEXT_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);

    eventAttr_.isExit = true;
    eventAttr_.isWaitDevPid = false;
    if (eventAttr_.isThreadStart) {
        if (OsalJoinTask(&eventAttr_.handle) != OSAL_EN_OK) {
            MSPROF_LOGW("thread not exist tid:%d", eventAttr_.handle);
        } else {
            MSPROF_LOGI("aicpu event thread exit, tid:%d", eventAttr_.handle);
        }
    }
    eventAttr_.isThreadStart = false;
    if (eventAttr_.isAttachDevice) {
        profDrvEvent_.SubscribeEventThreadUninit(static_cast<uint32_t>(collectionJobCfg_->comParams->devId));
    }

    if (!eventAttr_.isProcessRun) {
        MSPROF_LOGI("ProfAicpuJob Process is not run, return");
        return PROFILING_SUCCESS;
    }
    int32_t ret = 0;
    if (DrvChannelsMgr::instance()->GetAllChannels(collectionJobCfg_->comParams->devId) == PROFILING_SUCCESS &&
        DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);
        MSPROF_LOGI("stop profiling Channel %d data, ret=%d", static_cast<int32_t>(channelId_), ret);
    }

    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);
    return ret;
}

bool ProfAicpuJob::CheckAicpuSwitch(void)
{
    return collectionJobCfg_->comParams->params->aicpuTrace.compare(MSVP_PROF_ON) == 0;
}

bool ProfAicpuJob::CheckMC2Switch(void)
{
    // MC2 check prof_level >= L1 (L1 or L2)
    if (Platform::instance()->CheckIfSupport(PLATFORM_MC2) &&
        ((collectionJobCfg_->comParams->params->prof_level.compare(MSVP_LEVEL_L1) == 0) ||
        (collectionJobCfg_->comParams->params->prof_level.compare(MSVP_LEVEL_L2) == 0) ||
        (collectionJobCfg_->comParams->params->prof_level.compare(MSVP_LEVEL_L3) == 0))) {
        return true;
    }

    // aicpu hccl check prof_level >= L0 (!= off)
    if (Platform::instance()->CheckIfSupport(PLATFORM_AICPU_HCCL) &&
        (collectionJobCfg_->comParams->params->prof_level.compare(MSVP_PROF_OFF) != 0)) {
        return true;
    }

    return false;
}

bool ProfAicpuJob::CheckChannelSwitch(void)
{
    if (CheckAicpuSwitch() || CheckMC2Switch()) {
        return true;
    }

    return false;
}

ProfAiCustomCpuJob::ProfAiCustomCpuJob()
{
    channelId_ = PROF_CHANNEL_CUS_AICPU;
    eventGrpName_ = AI_CUSTOM_CPU_EVENT_GRP_NAME;
    eventAttr_.channelId = channelId_;
    eventAttr_.jobTag = AI_CUSTOM_CPU_COLLECTION_JOB;
}
}
}
}