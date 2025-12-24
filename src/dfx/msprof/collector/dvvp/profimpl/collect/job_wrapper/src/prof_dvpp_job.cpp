/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_dvpp_job.h"
#include "ai_drv_prof_api.h"
#include "utils/utils.h"
#include "config/config.h"
#include "config_manager.h"
#include "param_validation.h"
#include "uploader_mgr.h"
#include "platform/platform.h"
#include "json_parser.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;
using namespace Msprofiler::Parser;

/*
 * @berif  : Collect DVPP profiling data
 */
ProfDvppJob::ProfDvppJob()
{
    channelId_ = PROF_CHANNEL_DVPP;
    channelList_ = {PROF_CHANNEL_DVPP_VENC,
               PROF_CHANNEL_DVPP_JPEGE,
               PROF_CHANNEL_DVPP_VDEC,
               PROF_CHANNEL_DVPP_JPEGD,
               PROF_CHANNEL_DVPP_VPC,
               PROF_CHANNEL_DVPP_PNG,
               PROF_CHANNEL_DVPP_SCD};
    fileNameList_ = {{PROF_CHANNEL_DVPP_JPEGD, "data/dvpp.jpegd"},
                {PROF_CHANNEL_DVPP_JPEGE, "data/dvpp.jpege"},
                {PROF_CHANNEL_DVPP_PNG, "data/dvpp.png"},
                {PROF_CHANNEL_DVPP_SCD, "data/dvpp.scd"},
                {PROF_CHANNEL_DVPP_VENC, "data/dvpp.venc"},
                {PROF_CHANNEL_DVPP_VPC, "data/dvpp.vpc"},
                {PROF_CHANNEL_DVPP_VDEC, "data/dvpp.vdec"}};
}
ProfDvppJob::~ProfDvppJob()
{
    channelList_.clear();
    fileNameList_.clear();
}

/*
 * @berif  : DVPP Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfDvppJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->dvpp_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("DVPP Profiling not enabled");
        return PROFILING_FAILED;
    }

    std::vector<std::string> profDataFilePathV;
    profDataFilePathV.push_back(collectionJobCfg_->comParams->tmpResultDir);
    profDataFilePathV.push_back("data");
    profDataFilePathV.push_back("dvpp.data");
    collectionJobCfg_->jobParams.dataPath = Utils::JoinPath(profDataFilePathV);
    samplePeriod_ = PERIPHERAL_INTERVAL_MS_SMIN;
    if (collectionJobCfg_->comParams->params->dvpp_sampling_interval > 0) {
        samplePeriod_ = collectionJobCfg_->comParams->params->dvpp_sampling_interval;
    }

    peripheralCfg_.configP = nullptr;
    peripheralCfg_.configSize = 0;
    return PROFILING_SUCCESS;
}

int32_t ProfDvppJob::Process()
{
    if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_DVPP_EX)) {
        CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
        (void)SetPeripheralConfig();
        for (const auto channelId : channelList_) {
            if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId)) {
                MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
                    static_cast<int32_t>(channelId));
                continue;
            }
            std::string filePath =
                collectionJobCfg_->comParams->tmpResultDir + MSVP_SLASH + fileNameList_[channelId];
            AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId,
                filePath);
            MSPROF_LOGI("begin to start profiling Channel %d, devId :%d",
                static_cast<int32_t>(channelId), collectionJobCfg_->comParams->devIdOnHost);
            peripheralCfg_.profDeviceId     = collectionJobCfg_->comParams->devId;
            peripheralCfg_.profChannel      = channelId;
            peripheralCfg_.profSamplePeriod = samplePeriod_;
            peripheralCfg_.bufLen = JsonParser::instance()->GetJsonChannelDriverBufferLen(channelId);
            int32_t peroid = JsonParser::instance()->GetJsonChannelPeroid(channelId);
            if (peroid != 0) {
                peripheralCfg_.profSamplePeriod = peroid;
            } else {
                peripheralCfg_.profSamplePeriod = samplePeriod_;
            }
            peripheralCfg_.profDataFile = "";
            const int32_t ret = DrvPeripheralStart(peripheralCfg_);
            MSPROF_LOGI("start profiling Channel %d, events:%s, ret=%d",
                static_cast<int32_t>(channelId), eventsStr_.c_str(), ret);

            Utils::ProfFree(peripheralCfg_.configP);
            peripheralCfg_.configP = nullptr;
            if (ret != PROFILING_SUCCESS) {
                MSPROF_LOGE("ProfDvppJob DrvPeripheralStart failed, channelId:%d", static_cast<int32_t>(channelId));
                continue;
            }
        }
    }

    if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_DVPP)) {
        return ProfPeripheralJob::Process();
    }
    return PROFILING_SUCCESS;
}

int32_t ProfDvppJob::Uninit()
{
    if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_DVPP_EX)) {
        CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);
        for (const auto channelId : channelList_) {
            if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId)) {
                MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
                    static_cast<int32_t>(channelId));
                continue;
            }

            MSPROF_LOGI("begin to stop profiling Channel %d data", static_cast<int32_t>(channelId));

            int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId);
            MSPROF_LOGI("stop profiling Channel %d data, ret=%d", static_cast<int32_t>(channelId), ret);
            RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId);
        }
    }

    if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_DVPP)) {
        return ProfPeripheralJob::Uninit();
    }
    return PROFILING_SUCCESS;
}
}
}
}