/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_io_job.h"
#include "utils/utils.h"
#include "config/config.h"
#include "uploader_mgr.h"
#include "ai_drv_prof_api.h"
#include "prof_timer.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

/*
 * @berif  : Collect NIC profiling data
 */
ProfNicJob::ProfNicJob()
{
    channelId_ = PROF_CHANNEL_NIC;
}

ProfNicJob::~ProfNicJob() {}

/*
 * @berif  : NIC Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfNicJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->nicProfiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("NIC Profiling not enabled");
        return PROFILING_FAILED;
    }

    std::vector<std::string> profDataFilePathV;
    profDataFilePathV.push_back(collectionJobCfg_->comParams->tmpResultDir);
    profDataFilePathV.push_back("data");
    profDataFilePathV.push_back("nic.data");
    collectionJobCfg_->jobParams.dataPath = Utils::JoinPath(profDataFilePathV);
    samplePeriod_ = PERIPHERAL_INTERVAL_MS_SMIN;
    if (collectionJobCfg_->comParams->params->nicInterval > 0) {
        samplePeriod_ = collectionJobCfg_->comParams->params->nicInterval;
    }
    MSPROF_LOGI("NIC Profiling samplePeriod_:%d", samplePeriod_);

    peripheralCfg_.configP = nullptr;
    peripheralCfg_.configSize = 0;
    return PROFILING_SUCCESS;
}

ProfRoceJob::ProfRoceJob()
{
    channelId_ = PROF_CHANNEL_ROCE;
}
ProfRoceJob::~ProfRoceJob() {}

/*
 * @berif  : ROCE Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfRoceJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->roceProfiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("ROCE Profiling not enabled");
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("ROCE Profiling enabled");
    std::vector<std::string> profDataFilePathV;
    profDataFilePathV.push_back(collectionJobCfg_->comParams->tmpResultDir);
    profDataFilePathV.push_back("data");
    profDataFilePathV.push_back("roce.data");
    collectionJobCfg_->jobParams.dataPath = Utils::JoinPath(profDataFilePathV);
    samplePeriod_ = PERIPHERAL_INTERVAL_MS_SMIN;
    if (collectionJobCfg_->comParams->params->roceInterval > 0) {
        samplePeriod_ = collectionJobCfg_->comParams->params->roceInterval;
    }

    peripheralCfg_.configP = nullptr;
    peripheralCfg_.configSize = 0;
    return PROFILING_SUCCESS;
}

std::mutex ProfNetDevStatJob::jobMtx_;

int32_t ProfNetDevStatJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->io_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("NetDevStat Profiling not enabled");
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("NetDevStat Profiling enabled");
    sampleIntervalNs_ =
        static_cast<uint64_t>(collectionJobCfg_->comParams->params->io_sampling_interval) * MS_TO_NS;

    std::vector<std::string> profDataFilePathV{collectionJobCfg_->comParams->tmpResultDir,
                                               "data", PROF_NETDEV_STATS_FILE};
    collectionJobCfg_->jobParams.dataPath = analysis::dvvp::common::utils::Utils::JoinPath(profDataFilePathV);

    MSPROF_LOGI("Netdev stats profiling enabled, sample interval: %llu ns", sampleIntervalNs_);
    return PROFILING_SUCCESS;
}

int32_t ProfNetDevStatJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    if (collectionJobCfg_->comParams->devId == DEFAULT_HOST_ID) {
        MSPROF_LOGW("Netdev stats profiling not enabled on host");
        return PROFILING_SUCCESS;
    }

    std::lock_guard<std::mutex> lock(jobMtx_); // 保证同时只有一个NetDevStatsJob实例向TimerManager注册
    static constexpr size_t netDevStatsBufSize = (1 << 14); // 1 << 14 = 16KB
    auto curHandler = TimerManager::instance()->GetProfTimerHandler(PROF_NETDEV_STATS);
    if (curHandler == nullptr) {
        SHARED_PTR_ALIA<NetDevStatsHandler> statHandler;
        MSVP_MAKE_SHARED4(statHandler, NetDevStatsHandler, netDevStatsBufSize, sampleIntervalNs_,
            collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->jobCtx,
            return PROFILING_FAILED);
        auto ret = statHandler->Init();
        if (ret == PROFILING_FAILED) {
            MSPROF_LOGE("NetDevStatsHandler Init Failed");
            return PROFILING_FAILED;
        } else if (ret == PROFILING_NOTSUPPORT) {
            MSPROF_LOGW("NetDevStatsHandler Not Support");
            return PROFILING_FAILED;
        }
        MSPROF_LOGI("NetDevStatsHandler Init succ, sampleIntervalNs_:%llu", sampleIntervalNs_);
        if (statHandler->RegisterDevTask(collectionJobCfg_->comParams->devId) != PROFILING_SUCCESS) {
            MSPROF_LOGE("NetDevStatsHandler RegisterDevTask Failed");
            return PROFILING_FAILED;
        }
        TimerManager::instance()->StartProfTimer();
        TimerManager::instance()->RegisterProfTimerHandler(PROF_NETDEV_STATS, statHandler);
    } else {
        SHARED_PTR_ALIA<NetDevStatsHandler> statHandler = std::dynamic_pointer_cast<NetDevStatsHandler>(curHandler);
        if (statHandler->RegisterDevTask(collectionJobCfg_->comParams->devId) != PROFILING_SUCCESS) {
            MSPROF_LOGE("NetDevStatsHandler RegisterDevTask Failed");
            return PROFILING_FAILED;
        }
    }
    isStarted_ = true;
    return PROFILING_SUCCESS;
}

int32_t ProfNetDevStatJob::Uninit()
{
    std::lock_guard<std::mutex> lock(jobMtx_); // 保证同时只有一个NetDevStatsJob实例从TimerManager注销
    if (!isStarted_) {
        return PROFILING_SUCCESS;
    }
    auto curHandler = TimerManager::instance()->GetProfTimerHandler(PROF_NETDEV_STATS);
    if (curHandler == nullptr) {
        if (collectionJobCfg_->comParams->devId != DEFAULT_HOST_ID) {
            MSPROF_LOGE("NetDevStatsHandler is not exist");
        }
        return PROFILING_SUCCESS;
    }
    SHARED_PTR_ALIA<NetDevStatsHandler> statHandler = std::dynamic_pointer_cast<NetDevStatsHandler>(curHandler);
    if (statHandler->RemoveDevTask(collectionJobCfg_->comParams->devId) != PROFILING_SUCCESS) {
        MSPROF_LOGE("NetDevStatsHandler RemoveDevTask Failed");
        return PROFILING_FAILED;
    }
    if (statHandler->GetCurDevTaskCount() == 0) {
        TimerManager::instance()->RemoveProfTimerHandler(PROF_NETDEV_STATS);
        TimerManager::instance()->StopProfTimer();
    }
    return PROFILING_SUCCESS;
}
}
}
}