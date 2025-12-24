/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "job_device_soc.h"
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
#include "prof_hardware_mem_job.h"
#include "prof_dvpp_job.h"
#include "prof_lpm_job.h"
#include "prof_inter_connection_job.h"
#include "prof_io_job.h"
#include "prof_perf_job.h"
#include "prof_ts_job.h"
#include "prof_sys_info_job.h"
#include "prof_stars_job.h"
#include "prof_instr_perf_job.h"
#include "prof_soc_pmu_job.h"
#include "prof_l2cache_job.h"
#include "prof_hwts_log_job.h"
#include "prof_aicore_job.h"
#include "prof_aicpu_job.h"
#include "prof_adprof_job.h"
#include "prof_diagnostic_job.h"
#include "prof_ccu_job.h"
#include "prof_biu_perf_job.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::TaskHandle;
using namespace Analysis::Dvvp::Common::Platform;

JobDeviceSoc::JobDeviceSoc(int32_t devIndexId)
    : devIndexId_(devIndexId),
      isStarted_(false)
{
    collectionJobV_.fill(CollectionJobT());
}

JobDeviceSoc::~JobDeviceSoc()
{
    params_ = nullptr;
    collectionJobCommCfg_ = nullptr;
}

void JobDeviceSoc::GetAndStoreStartTime(const int32_t &hostProfiling)
{
    std::string fileName;
    std::stringstream timeData;
    if (hostProfiling != 0) {
        GetHostTime();
        timeData << "[Host]" << std::endl;
        fileName = "host_start.log";
    } else {
        GetHostAndDeviceTime(devIndexId_);
        MSPROF_LOGI("devId: %d, hostMonotonicStart=%" PRIu64 " ns, hostCntvctStart=%" PRIu64 " ns, hostCntvctDiff=%"
            PRIu64 ", deviceMonotonicStart=%" PRIu64 "ns, devCntvct=%" PRIu64 " cycle",
            devIndexId_, hostMonotonicStart_, hostCntvctStart_, hostCntvctDiff_, devMonotonic_, devCntvct_);
        fileName = "dev_start.log." +  std::to_string(devIndexId_);
        auto startTime = GenerateDevStartTime();
        auto ret = StoreTime(fileName, startTime);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("[JobDeviceSoc]Failed to upload data for %s", fileName.c_str());
            return;
        }

        timeData << "[" << std::string(DEVICE_TAG_KEY) << devIndexId_ << "]" << std::endl;
        fileName = "host_start.log." + std::to_string(devIndexId_);
    }

    timeData << GenerateHostStartTime();
    if (StoreTime(fileName, timeData.str()) != PROFILING_SUCCESS) {
        MSPROF_LOGE("[JobDeviceSoc]Failed to upload data for %s", fileName.c_str());
    }
}

int32_t JobDeviceSoc::StoreTime(const std::string &fileName, const std::string &startTime)
{
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, analysis::dvvp::message::JobContext, return PROFILING_FAILED);
    jobCtx->dev_id = std::to_string(devIndexId_);
    jobCtx->job_id = params_->job_id;
    analysis::dvvp::transport::FileDataParams fileDataParams(fileName, true,
        analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_CTRL_DATA);
    MSPROF_LOGI("[JobDeviceSoc]storeTime.id: %s,fileName: %s", params_->job_id.c_str(), fileName.c_str());
    int32_t ret = analysis::dvvp::transport::UploaderMgr::instance()->UploadCtrlFileData(params_->job_id,
        startTime, fileDataParams, jobCtx);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[JobDeviceSoc]Failed to upload data for %s", fileName.c_str());
    }
    return ret;
}

int32_t JobDeviceSoc::StartProfHandle(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    params_ = params;
    tmpResultDir_ = params_->result_dir;
    MSVP_MAKE_SHARED0(collectionJobCommCfg_, CollectionJobCommonParams, return PROFILING_FAILED);
    collectionJobCommCfg_->devId = devIndexId_;
    collectionJobCommCfg_->devIdOnHost = TaskRelationshipMgr::instance()->GetHostIdByDevId(devIndexId_);
    collectionJobCommCfg_->devIdFlush =
        TaskRelationshipMgr::instance()->GetFlushSuffixDevId(params_->job_id, devIndexId_);
    MSVP_MAKE_SHARED0(collectionJobCommCfg_->params, analysis::dvvp::message::ProfileParams, return PROFILING_FAILED);
    collectionJobCommCfg_->params = params;
    int32_t ret = CreateCollectionJobArray();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[JobDeviceSoc]CreateCollectionJobArray failed");
        return PROFILING_FAILED;
    }
    GetAndStoreStartTime(params_->hostProfiling);
    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::StartProf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    status_.status = analysis::dvvp::message::ERR;
    status_.info = "Start prof failed";
    do {
        MSPROF_LOGI("JobDeviceSoc StartProf checking params");
        if (isStarted_ || params == nullptr ||
            !(ParamValidation::instance()->CheckProfilingParams(params))) {
            MSPROF_LOGE("[JobDeviceSoc::StartProf]Failed to check params");
            status_.info = "Start flag is true or parmas is invalid";
            break;
        }
        int32_t ret = StartProfHandle(params);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("[JobDeviceSoc::StartProf]Failed to StartProfParmasAdapt, devIndexId: %d", devIndexId_);
            status_.info = "Start profiling, parmas handle failed";
            break;
        }
        if (ProfChannelManager::instance()->Init() != PROFILING_SUCCESS) {
            MSPROF_LOGE("[JobDeviceSoc::StartProf]Failed to init channel poll");
            status_.info = "Init prof channel manager failed";
            break;
        }
        if (!(params_->hostProfiling)
            && analysis::dvvp::driver::DrvChannelsMgr::instance()->GetAllChannels(devIndexId_) != PROFILING_SUCCESS) {
            MSPROF_LOGE("[JobDeviceSoc::StartProf]Failed to GetAllChannels, devIndexId: %d", devIndexId_);
            status_.info = "Get all prof channels failed";
            break;
        }
        MSVP_MAKE_SHARED0_NODO(collectionJobCommCfg_->jobCtx, analysis::dvvp::message::JobContext, break);
        collectionJobCommCfg_->jobCtx->dev_id = std::to_string(collectionJobCommCfg_->devIdFlush);
        collectionJobCommCfg_->jobCtx->job_id = params_->job_id;
        collectionJobCommCfg_->tmpResultDir = params->result_dir;
        ret = ParsePmuConfig(CreatePmuEventConfig(params, devIndexId_));
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("[JobDeviceSoc::StartProf]Failed to ParsePmuConfig, devIndexId: %d", devIndexId_);
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

int32_t JobDeviceSoc::ParsePmuConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    int32_t ret = ParseTsCpuConfig(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    ret = ParseAiCoreConfig(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    ret = ParseControlCpuConfig(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    ret = ParseLlcConfig(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    ret = ParseDdrCpuConfig(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    ret = ParseAivConfig(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    ret = ParseHbmConfig(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::ParseTsCpuConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    if (cfg->tsCPUEvents.size() > 0) {
        if (!ParamValidation::instance()->CheckTsCpuEventIsValid(cfg->tsCPUEvents)) {
            MSPROF_LOGE("[JobDeviceSoc::ParseTsCpuConfig]tsCpuEvent is not valid!");
            return PROFILING_FAILED;
        }
        SHARED_PTR_ALIA<std::vector<std::string>> events;
        MSVP_MAKE_SHARED0(events, std::vector<std::string>, return PROFILING_FAILED);
        *events = cfg->tsCPUEvents;
        collectionJobV_[TS_CPU_DRV_COLLECTION_JOB].jobCfg->jobParams.events = events;
        MSPROF_LOGI("tsCpuEvent:%s", Utils::GetEventsStr(cfg->tsCPUEvents).c_str());
    }
    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::ParseHbmConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    if (cfg->hbmEvents.size() > 0) {
        if (!ParamValidation::instance()->CheckHbmEventsIsValid(cfg->hbmEvents)) {
            MSPROF_LOGE("[JobDeviceSoc::ParseHbmConfig]hbmEvents is not valid!");
            return PROFILING_FAILED;
        }
        SHARED_PTR_ALIA<std::vector<std::string>> events;
        MSVP_MAKE_SHARED0(events, std::vector<std::string>, return PROFILING_FAILED);
        *events = cfg->hbmEvents;
        collectionJobV_[HBM_DRV_COLLECTION_JOB].jobCfg->jobParams.events = events;
        MSPROF_LOGI("hbmEvents:%s", Utils::GetEventsStr(cfg->hbmEvents).c_str());
    }
    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::ParseAiCoreConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    MSPROF_LOGI("aiCoreEvents:%s", Utils::GetEventsStr(cfg->aiCoreEvents).c_str());
    MSPROF_LOGI("aiCoreIdSize:%d", cfg->aiCoreEventsCoreIds.size());
    if (cfg->aiCoreEvents.size() > 0 &&
        !ParamValidation::instance()->CheckAiCoreEventsIsValid(cfg->aiCoreEvents)) {
        MSPROF_LOGE("[JobDeviceSoc::ParseAiCoreConfig]aiCoreEvent is not valid!");
        return PROFILING_FAILED;
    }
    if (cfg->aiCoreEventsCoreIds.size() > 0
        && !ParamValidation::instance()->CheckAiCoreEventCoresIsValid(cfg->aiCoreEventsCoreIds)) {
        MSPROF_LOGE("[JobDeviceSoc::ParseAiCoreConfig]aiCoreEventCores is not valid!");
        return PROFILING_FAILED;
    }
    if (cfg->aiCoreEventsCoreIds.size() > 0) {
        SHARED_PTR_ALIA<std::vector<std::string>> events;
        MSVP_MAKE_SHARED0(events, std::vector<std::string>, return PROFILING_FAILED);
        *events = cfg->aiCoreEvents;
        SHARED_PTR_ALIA<std::vector<int32_t>> cores;
        MSVP_MAKE_SHARED0(cores, std::vector<int32_t>, return PROFILING_FAILED);
        *cores = cfg->aiCoreEventsCoreIds;
        collectionJobV_[AI_CORE_SAMPLE_DRV_COLLECTION_JOB].jobCfg->jobParams.events = events;
        collectionJobV_[AI_CORE_SAMPLE_DRV_COLLECTION_JOB].jobCfg->jobParams.cores = cores;
        collectionJobV_[AI_CORE_TASK_DRV_COLLECTION_JOB].jobCfg->jobParams.events = events;
        collectionJobV_[AI_CORE_TASK_DRV_COLLECTION_JOB].jobCfg->jobParams.cores = cores;
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

int32_t JobDeviceSoc::ParseAivConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    if (cfg->aivEvents.size() > 0 &&
        !ParamValidation::instance()->CheckAivEventsIsValid(cfg->aivEvents)) {
        MSPROF_LOGE("[JobDeviceSoc::ParseAivConfig]aivEvents is not valid!");
        return PROFILING_FAILED;
    }
    if (cfg->aivEventsCoreIds.size() > 0
        && !ParamValidation::instance()->CheckAivEventCoresIsValid(cfg->aivEventsCoreIds)) {
        MSPROF_LOGE("[JobDeviceSoc::ParseAivConfig]aivEventsCoreIds is not valid!");
        return PROFILING_FAILED;
    }
    if (cfg->aivEventsCoreIds.size() > 0) {
        SHARED_PTR_ALIA<std::vector<std::string>> events;
        MSVP_MAKE_SHARED0(events, std::vector<std::string>, return PROFILING_FAILED);
        *events = cfg->aivEvents;
        SHARED_PTR_ALIA<std::vector<int32_t>> cores;
        MSVP_MAKE_SHARED0(cores, std::vector<int32_t>, return PROFILING_FAILED);
        *cores = cfg->aivEventsCoreIds;
        collectionJobV_[AIV_SAMPLE_DRV_COLLECTION_JOB].jobCfg->jobParams.events = events;
        collectionJobV_[AIV_SAMPLE_DRV_COLLECTION_JOB].jobCfg->jobParams.cores = cores;
        collectionJobV_[AIV_TASK_DRV_COLLECTION_JOB].jobCfg->jobParams.events = events;
        collectionJobV_[AIV_TASK_DRV_COLLECTION_JOB].jobCfg->jobParams.cores = cores;
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

int32_t JobDeviceSoc::ParseControlCpuConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    if (cfg->ctrlCPUEvents.size() > 0) {
        if (!ParamValidation::instance()->CheckCtrlCpuEventIsValid(cfg->ctrlCPUEvents)) {
            MSPROF_LOGE("[JobDeviceSoc::ParseControlCpuConfig]ctrlCpuEvent is not valid!");
            return PROFILING_FAILED;
        }
        SHARED_PTR_ALIA<std::vector<std::string>> events;
        MSVP_MAKE_SHARED0(events, std::vector<std::string>, return PROFILING_FAILED);
        *events = cfg->ctrlCPUEvents;
        collectionJobV_[CTRLCPU_PERF_COLLECTION_JOB].jobCfg->jobParams.events = events;
    }
    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::ParseDdrCpuConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    if (cfg->ddrEvents.size() > 0) {
        if (!ParamValidation::instance()->CheckDdrEventsIsValid(cfg->ddrEvents)) {
            MSPROF_LOGE("[JobDeviceSoc::ParseDdrCpuConfig]ddrEvent is not valid!");
            return PROFILING_FAILED;
        }
        SHARED_PTR_ALIA<std::vector<std::string>> events;
        MSVP_MAKE_SHARED0(events, std::vector<std::string>, return PROFILING_FAILED);
        *events = cfg->ddrEvents;
        collectionJobV_[DDR_DRV_COLLECTION_JOB].jobCfg->jobParams.events = events;
    }
    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::ParseLlcConfig(SHARED_PTR_ALIA<PMUEventsConfig> cfg)
{
    if (cfg->llcEvents.size() > 0) {
        UtilsStringBuilder<std::string> builder;
        std::string eventStr = builder.Join(cfg->llcEvents, ",");
        if (!ParamValidation::instance()->CheckLlcEventsIsValid(eventStr)) {
            MSPROF_LOGE("[JobDeviceSoc::ParseLlcConfig]llcEvent is not valid!");
            return PROFILING_FAILED;
        }
        SHARED_PTR_ALIA<std::vector<std::string>> events;
        MSVP_MAKE_SHARED0(events, std::vector<std::string>, return PROFILING_FAILED);
        *events = cfg->llcEvents;
        collectionJobV_[LLC_DRV_COLLECTION_JOB].jobCfg->jobParams.events = events;
    }
    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::StopProf(void)
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

int32_t JobDeviceSoc::RegisterCollectionJobs() const
{
    MSPROF_LOGI("Start to register collection job:%s", collectionJobCommCfg_->params->job_id.c_str());
    int32_t registerCnt = 0;
    std::vector<int32_t> registered;
    for (int32_t cnt = 0; cnt < NR_MAX_COLLECTION_JOB; cnt++) {
        MSPROF_LOGD("Collect Start jobId %d ", cnt);
        int32_t ret = collectionJobV_[cnt].collectionJob->Init(collectionJobV_[cnt].jobCfg);
        if (ret == PROFILING_SUCCESS) {
            MSPROF_LOGD("[JobDeviceSoc]Collection Job %d Register", cnt);
            ret = CollectionRegisterMgr::instance()->CollectionJobRegisterAndRun(
                collectionJobCommCfg_->devId, collectionJobV_[cnt].jobTag, collectionJobV_[cnt].collectionJob);
        }
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGD("[JobDeviceSoc]Collection Job %d No Run; Total: %d", collectionJobV_[cnt].jobTag, registerCnt);
            registerCnt++;
        } else {
            registered.push_back(cnt);
        }
    }
    UtilsStringBuilder<int32_t> intBuilder;
    MSPROF_LOGI("Total count of job registered: %s", intBuilder.Join(registered, ",").c_str());
    return PROFILING_SUCCESS;
}

void JobDeviceSoc::UnRegisterCollectionJobs()
{
    do {
        for (int32_t cnt = 0; cnt < NR_MAX_COLLECTION_JOB; cnt++) {
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
        std::string perfDataDir =
            Analysis::Dvvp::Common::Config::ConfigManager::instance()->GetPerfDataDir(collectionJobCommCfg_->devId);
        MSPROF_LOGI("Removing collected perf data: \"%s\"", Utils::BaseName(perfDataDir).c_str());
        analysis::dvvp::common::utils::Utils::RemoveDir(perfDataDir);
    } while (0);
}

int32_t JobDeviceSoc::CreateCollectionJobArray()
{
    MSVP_MAKE_SHARED0(collectionJobV_[DDR_DRV_COLLECTION_JOB].collectionJob, ProfDdrJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[HBM_DRV_COLLECTION_JOB].collectionJob, ProfHbmJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[DVPP_COLLECTION_JOB].collectionJob, ProfDvppJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[PCIE_DRV_COLLECTION_JOB].collectionJob, ProfPcieJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[NIC_COLLECTION_JOB].collectionJob, ProfNicJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[HCCS_DRV_COLLECTION_JOB].collectionJob, ProfHccsJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[UB_DRV_COLLECTION_JOB].collectionJob, ProfUbJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[LLC_DRV_COLLECTION_JOB].collectionJob, ProfLlcJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[ROCE_DRV_COLLECTION_JOB].collectionJob, ProfRoceJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[APP_MEM_COLLECTION_JOB].collectionJob, ProfAppMemJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[DEV_MEM_COLLECTION_JOB].collectionJob, ProfDevMemJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[AISTACK_MEM_COLLECTION_JOB].collectionJob, ProfAiStackMemJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[LPM_FREQ_COLLECTION_JOB].collectionJob, ProfLpmFreqConvJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[QOS_COLLECTION_JOB].collectionJob, ProfQosJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[AICPU_COLLECTION_JOB].collectionJob, ProfAicpuJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[AI_CUSTOM_CPU_COLLECTION_JOB].collectionJob, ProfAiCustomCpuJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[CCU_INSTR_COLLECTION_JOB].collectionJob, ProfCcuInstrJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[CCU_STAT_COLLECTION_JOB].collectionJob, ProfCcuStatJob, return PROFILING_FAILED);
    int32_t ret = CreateTsCollectionJobArray();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[JobDeviceSoc]CreateTsCollectionJobArray failed");
        return PROFILING_FAILED;
    }

    ret = CreateSysCollectionJobArray();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[JobDeviceSoc]CreateSysCollectionJobArray failed");
        return PROFILING_FAILED;
    }

    ret = DoCreateCollectionJobArray();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[JobDeviceSoc]DoCreateCollectionJobArray failed");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::CreateTsCollectionJobArray()
{
    // for ts
    MSVP_MAKE_SHARED0(collectionJobV_[TS_CPU_DRV_COLLECTION_JOB].collectionJob, ProfTscpuJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[AIV_TS_TRACK_DRV_COLLECTION_JOB].collectionJob, ProfAivTsTrackJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[AI_CORE_SAMPLE_DRV_COLLECTION_JOB].collectionJob, ProfAicoreJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[AI_CORE_TASK_DRV_COLLECTION_JOB].collectionJob,
        ProfAicoreTaskBasedJob,
        return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[AIV_SAMPLE_DRV_COLLECTION_JOB].collectionJob, ProfAivJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[TS_TRACK_DRV_COLLECTION_JOB].collectionJob, ProfTsTrackJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[AIV_TASK_DRV_COLLECTION_JOB].collectionJob, ProfAivTaskBasedJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[AIV_HWTS_LOG_COLLECTION_JOB].collectionJob, ProfAivHwtsLogJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[FMK_COLLECTION_JOB].collectionJob, ProfFmkJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[SOC_PMU_TASK_COLLECTION_JOB].collectionJob, ProfSocPmuTaskJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[L2_CACHE_TASK_COLLECTION_JOB].collectionJob, ProfL2CacheTaskJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[STARS_SOC_LOG_COLLECTION_JOB].collectionJob, ProfStarsSocLogJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[STARS_BLOCK_LOG_COLLECTION_JOB].collectionJob, ProfStarsBlockLogJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[HWTS_LOG_COLLECTION_JOB].collectionJob, ProfHwtsLogJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[STARS_SOC_PROFILE_COLLECTION_JOB].collectionJob,
        ProfStarsSocProfileJob,
        return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].collectionJob, ProfFftsProfileJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[INSTR_PROFILING_COLLECTION_JOB].collectionJob, ProfInstrPerfJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[BIU_PERF_COLLECTION_JOB].collectionJob, ProfBiuPerfJob, return PROFILING_FAILED);

    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::CreateSysCollectionJobArray()
{
    // for system
    MSVP_MAKE_SHARED0(collectionJobV_[ADPROF_COLLECTION_JOB].collectionJob, ProfAdprofJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[CTRLCPU_PERF_COLLECTION_JOB].collectionJob, ProfCtrlcpuJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[SYSSTAT_PROC_COLLECTION_JOB].collectionJob, ProfSysStatJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[SYSMEM_PROC_COLLECTION_JOB].collectionJob, ProfSysMemJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[ALLPID_PROC_COLLECTION_JOB].collectionJob, ProfAllPidsJob, return PROFILING_FAILED);
    // for host system
    MSVP_MAKE_SHARED0(
        collectionJobV_[HOST_SYSCALLS_COLLECTION_JOB].collectionJob, ProfHostSysCallsJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[HOST_PTHREAD_COLLECTION_JOB].collectionJob, ProfHostPthreadJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[HOST_DISKIO_COLLECTION_JOB].collectionJob, ProfHostDiskJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[HOST_CPU_COLLECTION_JOB].collectionJob, ProfHostCpuJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(collectionJobV_[HOST_MEM_COLLECTION_JOB].collectionJob, ProfHostMemJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[HOST_NETWORK_COLLECTION_JOB].collectionJob, ProfHostNetworkJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[HOST_ALL_PID_COLLECTION_JOB].collectionJob, ProfHostAllPidJob, return PROFILING_FAILED);
    MSVP_MAKE_SHARED0(
        collectionJobV_[DIAGNOSTIC_COLLECTION_JOB].collectionJob, ProfDiagnostic, return PROFILING_FAILED);

    return PROFILING_SUCCESS;
}

int32_t JobDeviceSoc::DoCreateCollectionJobArray()
{
    std::string dataDir = tmpResultDir_ + MSVP_SLASH + "data";
    if (!Platform::instance()->CheckIfRpcHelper() &&
        !Platform::instance()->CheckIfSupport(PLATFORM_AOE_SUPPORT_FUNC)) {
        const int32_t ret = analysis::dvvp::common::utils::Utils::CreateDir(dataDir);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Creating dir: %s err!", analysis::dvvp::common::utils::Utils::BaseName(dataDir).c_str());
            analysis::dvvp::common::utils::Utils::PrintSysErrorMsg();
        }
    }
    for (int32_t cnt = 0; cnt < NR_MAX_COLLECTION_JOB; cnt++) {
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

int32_t JobDeviceSoc::SendData(const std::string &fileName, const std::string &data)
{
    if (params_->hostProfiling) {
        return PROFILING_SUCCESS;
    }
    if (data.empty()) {
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, analysis::dvvp::message::JobContext, return PROFILING_FAILED);
    jobCtx->dev_id = std::to_string(
        TaskRelationshipMgr::instance()->GetFlushSuffixDevId(params_->job_id, devIndexId_));
    jobCtx->job_id = params_->job_id;

    analysis::dvvp::transport::FileDataParams fileDataParams(fileName, true,
            analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_CTRL_DATA);
    int32_t ret = analysis::dvvp::transport::UploaderMgr::instance()->UploadCtrlFileData(params_->job_id, data,
        fileDataParams, jobCtx);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to upload data for %s", fileName.c_str());
    }
    return ret;
}

std::string JobDeviceSoc::GenerateFileName(const std::string &fileName)
{
    std::string ret = fileName + "." + std::to_string(collectionJobCommCfg_->devIdFlush);
    return ret;
}
}}}
