/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "acp_compute_device_job.h"
#include "ai_drv_prof_api.h"
#include "ai_drv_dev_api.h"
#include "config/config.h"
#include "config_manager.h"
#include "param_validation.h"
#include "prof_channel_manager.h"
#include "prof_host_job.h"
#include "task_relationship_mgr.h"
#include "utils/utils.h"
#include "platform/platform.h"
#include "prof_stars_job.h"
#include "prof_biu_perf_job.h"

namespace Collector {
namespace Dvvp {
namespace Acp {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::TaskHandle;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::JobWrapper;

AcpComputeDeviceJob::AcpComputeDeviceJob(int32_t devIndexId)
    : devIndexId_(devIndexId),
      isStarted_(false)
{
    collectionJobV_.fill(CollectionJobT());
    jobUsed_ = {BIU_PERF_COLLECTION_JOB, STARS_SOC_LOG_COLLECTION_JOB, FFTS_PROFILE_COLLECTION_JOB};
}

AcpComputeDeviceJob::~AcpComputeDeviceJob()
{
}

int32_t AcpComputeDeviceJob::StartProfHandle(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    params_ = params;
    tmpResultDir_ = params_->result_dir;
    MSVP_MAKE_SHARED0(collectionJobCommCfg_, CollectionJobCommonParams, return PROFILING_FAILED);
    collectionJobCommCfg_->devId = devIndexId_;
    MSVP_MAKE_SHARED0(collectionJobCommCfg_->params, analysis::dvvp::message::ProfileParams, return PROFILING_FAILED);
    collectionJobCommCfg_->params = params;
    int32_t ret = CreateCollectionJobArray();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[AcpComputeDeviceJob]CreateCollectionJobArray failed");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t AcpComputeDeviceJob::StartProf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    status_.status = analysis::dvvp::message::ERR;
    status_.info = "Start prof failed";
    do {
        MSPROF_LOGI("AcpComputeDeviceJob StartProf checking params");
        if (isStarted_ || params == nullptr ||
            !(ParamValidation::instance()->CheckProfilingParams(params))) {
            MSPROF_LOGE("[AcpComputeDeviceJob::StartProf]Failed to check params");
            status_.info = "Start flag is true or parmas is invalid";
            break;
        }
        int32_t ret = StartProfHandle(params);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("[AcpComputeDeviceJob::StartProf]Failed to StartProfParmasAdapt, devIndexId: %d", devIndexId_);
            status_.info = "Start profiling, parmas handle failed";
            break;
        }
        if (ProfChannelManager::instance()->Init() != PROFILING_SUCCESS) {
            MSPROF_LOGE("[AcpComputeDeviceJob::StartProf]Failed to init channel poll");
            status_.info = "Init prof channel manager failed";
            break;
        }
        if (analysis::dvvp::driver::DrvChannelsMgr::instance()->GetAllChannels(devIndexId_) != PROFILING_SUCCESS) {
            MSPROF_LOGE("[AcpComputeDeviceJob::StartProf]Failed to GetAllChannels, devIndexId: %d", devIndexId_);
            status_.info = "Get all prof channels failed";
            break;
        }
        MSVP_MAKE_SHARED0_NODO(collectionJobCommCfg_->jobCtx, analysis::dvvp::message::JobContext, break);
        collectionJobCommCfg_->jobCtx->dev_id = std::to_string(collectionJobCommCfg_->devIdFlush);
        collectionJobCommCfg_->jobCtx->job_id = params_->job_id;
        collectionJobCommCfg_->tmpResultDir = params->result_dir;
        ret = ParsePmuConfig(CreatePmuEventConfig(params, devIndexId_));
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("[AcpComputeDeviceJob::StartProf]Failed to ParsePmuConfig, devIndexId: %d", devIndexId_);
            status_.info = "Parse pmu config failed";
            break;
        }
        ret = RegisterCollectionJobs();
        if (ret != PROFILING_SUCCESS) {
            status_.info = "Check hbm events failed";
            break;
        }
        status_.status = analysis::dvvp::message::SUCCESS;
        isStarted_ = true;
        return PROFILING_SUCCESS;
    } while (0);

    return PROFILING_FAILED;
}

int32_t AcpComputeDeviceJob::ParsePmuConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    int32_t ret = ParseAiCoreConfig(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    ret = ParseAivConfig(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    return PROFILING_SUCCESS;
}

int32_t AcpComputeDeviceJob::ParseAiCoreConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    MSPROF_LOGI("aiCoreEvents:%s", Utils::GetEventsStr(cfg->aiCoreEvents).c_str());
    MSPROF_LOGI("aiCoreIdSize:%d", cfg->aiCoreEventsCoreIds.size());
    if (cfg->aiCoreEvents.size() > 0 &&
        !ParamValidation::instance()->CheckAiCoreEventsIsValid(cfg->aiCoreEvents)) {
        MSPROF_LOGE("[AcpComputeDeviceJob::ParseAiCoreConfig]aiCoreEvent is not valid!");
        return PROFILING_FAILED;
    }
    if (cfg->aiCoreEventsCoreIds.size() > 0
        && !ParamValidation::instance()->CheckAiCoreEventCoresIsValid(cfg->aiCoreEventsCoreIds)) {
        MSPROF_LOGE("[AcpComputeDeviceJob::ParseAiCoreConfig]aiCoreEventCores is not valid!");
        return PROFILING_FAILED;
    }
    if (cfg->aiCoreEventsCoreIds.size() > 0) {
        SHARED_PTR_ALIA<std::vector<std::string>> events;
        MSVP_MAKE_SHARED0(events, std::vector<std::string>, return PROFILING_FAILED);
        *events = cfg->aiCoreEvents;
        SHARED_PTR_ALIA<std::vector<int32_t>> cores;
        MSVP_MAKE_SHARED0(cores, std::vector<int32_t>, return PROFILING_FAILED);
        *cores = cfg->aiCoreEventsCoreIds;
        collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.events = events;
        collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.cores = cores;
    }

    if (collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.cores == nullptr) {
        MSVP_MAKE_SHARED0(collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.cores,
            std::vector<int32_t>,
            return PROFILING_FAILED);
    }

    if (collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.events == nullptr) {
        MSVP_MAKE_SHARED0(collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.events,
            std::vector<std::string>,
            return PROFILING_FAILED);
    }
    return PROFILING_SUCCESS;
}

int32_t AcpComputeDeviceJob::ParseAivConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    if (cfg->aivEvents.size() > 0 &&
        !ParamValidation::instance()->CheckAivEventsIsValid(cfg->aivEvents)) {
        MSPROF_LOGE("[AcpComputeDeviceJob::ParseAivConfig]aivEvents is not valid!");
        return PROFILING_FAILED;
    }
    if (cfg->aivEventsCoreIds.size() > 0
        && !ParamValidation::instance()->CheckAivEventCoresIsValid(cfg->aivEventsCoreIds)) {
        MSPROF_LOGE("[AcpComputeDeviceJob::ParseAivConfig]aivEventsCoreIds is not valid!");
        return PROFILING_FAILED;
    }
    if (cfg->aivEventsCoreIds.size() > 0) {
        SHARED_PTR_ALIA<std::vector<std::string>> events;
        MSVP_MAKE_SHARED0(events, std::vector<std::string>, return PROFILING_FAILED);
        *events = cfg->aivEvents;
        SHARED_PTR_ALIA<std::vector<int32_t>> cores;
        MSVP_MAKE_SHARED0(cores, std::vector<int32_t>, return PROFILING_FAILED);
        *cores = cfg->aivEventsCoreIds;
        collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.aivEvents = events;
        collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.aivCores = cores;
    }

    if (collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.aivCores == nullptr) {
        MSVP_MAKE_SHARED0(collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.aivCores,
            std::vector<int32_t>,
            return PROFILING_FAILED);
    }

    if (collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.aivEvents == nullptr) {
        MSVP_MAKE_SHARED0(collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg->jobParams.aivEvents,
            std::vector<std::string>,
            return PROFILING_FAILED);
    }
    return PROFILING_SUCCESS;
}

int32_t AcpComputeDeviceJob::StopProf(void)
{
    MSPROF_LOGI("Stop profiling begin");
    if (!isStarted_ || collectionJobCommCfg_ == nullptr) {
        status_.status = analysis::dvvp::message::ERR;
        MSPROF_LOGE("Stop profiling failed");
        return PROFILING_FAILED;
    }
    UnRegisterCollectionJobs();
    collectionJobCommCfg_->jobCtx.reset();
    status_.status = analysis::dvvp::message::SUCCESS;
    MSPROF_LOGI("Stop profiling success");
    return PROFILING_SUCCESS;
}

int32_t AcpComputeDeviceJob::RegisterCollectionJobs()
{
    if (params_->instrProfiling.compare(MSVP_PROF_ON) == 0 || params_->pcSampling.compare(MSVP_PROF_ON) == 0) {
        jobUsed_.erase(STARS_SOC_LOG_COLLECTION_JOB);
        jobUsed_.erase(FFTS_PROFILE_COLLECTION_JOB);
    }
    MSPROF_LOGI("Start to register collection job:%s", collectionJobCommCfg_->params->job_id.c_str());
    int32_t registerCnt = 0;
    std::vector<int32_t> registered;
    for (int32_t cnt = 0; cnt < NR_MAX_COLLECTION_JOB; cnt++) {
        if (jobUsed_.count(cnt) != 1) {
            continue;
        }
        MSPROF_LOGD("Collect Start jobId %d", cnt);
        int32_t ret = collectionJobV_[cnt].collectionJob->Init(collectionJobV_[cnt].jobCfg);
        if (ret == PROFILING_SUCCESS) {
            MSPROF_LOGD("[AcpComputeDeviceJob]Collection Job %d Register", cnt);
            ret = CollectionRegisterMgr::instance()->CollectionJobRegisterAndRun(
                collectionJobCommCfg_->devId, collectionJobV_[cnt].jobTag, collectionJobV_[cnt].collectionJob);
        }
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGD("[AcpComputeDeviceJob]Collection Job %d No Run", collectionJobV_[cnt].jobTag);
            registerCnt++;
        } else {
            registered.push_back(cnt);
        }
    }
    UtilsStringBuilder<int32_t> intBuilder;
    MSPROF_LOGI("Total %d of job registered: %s", registerCnt, intBuilder.Join(registered, ",").c_str());
    return PROFILING_SUCCESS;
}

void AcpComputeDeviceJob::UnRegisterCollectionJobs()
{
    do {
        for (int32_t cnt = 0; cnt < NR_MAX_COLLECTION_JOB; cnt++) {
            if (jobUsed_.count(cnt) != 1) {
                continue;
            }
            int32_t retn = CollectionRegisterMgr::instance()->CollectionJobUnregisterAndStop(
                collectionJobCommCfg_->devId, collectionJobV_[cnt].jobTag);
            if (collectionJobV_[cnt].jobCfg != nullptr) {
                collectionJobV_[cnt].jobCfg->jobParams.events.reset();
                collectionJobV_[cnt].jobCfg->jobParams.cores.reset();
            }
            if (retn != PROFILING_SUCCESS) {
                MSPROF_LOGD("Device %d Collection Job %d Unregister", collectionJobCommCfg_->devIdOnHost,
                            collectionJobV_[cnt].jobTag);
            }
        }
        ProfChannelManager::instance()->UnInit();
    } while (0);
}

int32_t AcpComputeDeviceJob::CreateCollectionJobArray()
{
    int32_t ret = CreateAcpCollectionJobArray();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[AcpComputeDeviceJob]CreateTsCollectionJobArray failed");
        return PROFILING_FAILED;
    }

    ret = DoCreateCollectionJobArray();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[AcpComputeDeviceJob]DoCreateCollectionJobArray failed");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t AcpComputeDeviceJob::CreateAcpCollectionJobArray()
{
    MSVP_MAKE_SHARED0(
        collectionJobV_[STARS_SOC_LOG_COLLECTION_JOB].collectionJob, ProfStarsSocLogJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].collectionJob, ProfFftsProfileJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[BIU_PERF_COLLECTION_JOB].collectionJob, ProfBiuPerfJob, return PROFILING_FAILED);
    return PROFILING_SUCCESS;
}

int32_t AcpComputeDeviceJob::DoCreateCollectionJobArray()
{
    for (int32_t cnt = 0; cnt < NR_MAX_COLLECTION_JOB; cnt++) {
        if (jobUsed_.count(cnt) != 1) {
            continue;
        }
        MSVP_MAKE_SHARED0(collectionJobV_[cnt].jobCfg, CollectionJobCfg, return PROFILING_FAILED);
        collectionJobV_[cnt].jobTag = static_cast<ProfCollectionJobE>(cnt);
        collectionJobV_[cnt].jobCfg->jobParams.jobTag = static_cast<ProfCollectionJobE>(cnt);
        if (COLLECTION_JOB_FILENAME[cnt].size() > 0) {
            collectionJobV_[cnt].jobCfg->jobParams.dataPath = tmpResultDir_ + MSVP_SLASH + COLLECTION_JOB_FILENAME[cnt];
        }
        collectionJobV_[cnt].jobCfg->comParams = collectionJobCommCfg_;
    }

    return PROFILING_SUCCESS;
}

std::string AcpComputeDeviceJob::GenerateFileName(const std::string &fileName)
{
    std::string ret = fileName + "." + std::to_string(collectionJobCommCfg_->devIdFlush);
    return ret;
}
}}}
