/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "nano_stars_profile.h"
#include "ai_drv_prof_api.h"
#include "utils/utils.h"

namespace Dvvp {
namespace Collect {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::driver;
using namespace Analysis::Dvvp::JobWrapper;
COLLECTION_JOB_REGISTER(PROF_CHANNEL_STARS_NANO_PROFILE, NanoStarsProfile);
int32_t NanoStarsProfile::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    if (cfg == nullptr || cfg->comParams == nullptr) {
        MSPROF_LOGE("Invalid parameter of collection job config.");
        return PROFILING_FAILED;
    }

    if (cfg->comParams->params->hostProfiling ||
        cfg->comParams->params->taskTrace.compare(MSVP_PROF_OFF) == 0) {
        return PROFILING_FAILED;
    }

    cfg_ = cfg;
    return PROFILING_SUCCESS;
}

void NanoStarsProfile::PackPmuParam(TagNanoStarsProfileConfig &config) const
{
    auto aiEvents = Utils::Split(cfg_->comParams->params->ai_core_profiling_events, false, "", ",");
    config.eventNum = static_cast<uint32_t>(aiEvents.size());
    for (size_t i = 0; i < aiEvents.size(); i++) {
        config.event[i] =
            static_cast<uint16_t>(strtol(aiEvents[i].c_str(), nullptr, STRING_TO_LONG_WEIGHT));
    }
    MSPROF_EVENT("PackPmuParam, event_num=%u, events=%s",
        config.eventNum, cfg_->comParams->params->ai_core_profiling_events.c_str());
}

int32_t NanoStarsProfile::Process()
{
    if (cfg_ == nullptr || cfg_->comParams == nullptr) {
        MSPROF_LOGE("Invalid parameter of collection job config.");
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Begin to start profiling stars soc log, devId: %d", cfg_->comParams->devId);
    std::string filePath = cfg_->comParams->params->result_dir + MSVP_SLASH + JobFileName();
    AddReader(cfg_->comParams->devId, GetCollectionId(), filePath);
    TagNanoStarsProfileConfig config;
    config.tag = 0;
    PackPmuParam(config);
    ProfChannelParam param;
    param.userData = &config;
    param.dataSize = sizeof(TagNanoStarsProfileConfig);
    return ChannelStart(cfg_->comParams->devId, GetCollectionId(), param);
}

int32_t NanoStarsProfile::Uninit()
{
    if (cfg_ == nullptr || cfg_->comParams == nullptr) {
        MSPROF_LOGE("Invalid parameter of collection job config.");
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("stop profiling begin, collection id: %d", GetCollectionId());
    auto ret = DrvStop(cfg_->comParams->devId, static_cast<AI_DRV_CHANNEL>(GetCollectionId()));
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("StarsNanoProfile uninit, DrvStop failed");
        MSPROF_INNER_ERROR("EK9999", "Uninit, DrvStop failed");
    }
    RemoveReader(cfg_->comParams->devId, GetCollectionId());
    MSPROF_LOGI("stop profiling success, collection id: %d", GetCollectionId());
    return ret;
}
}
}
}