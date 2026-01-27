/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "collect_engine.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iostream>
#include <sstream>
#include "collection_entry.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "param_validation.h"
#include "securec.h"
#include "uploader_mgr.h"
#include "utils/utils.h"
#include "config_manager.h"
#include "prof_channel_manager.h"
#include "prof_hardware_mem_job.h"
#include "prof_perf_job.h"
#include "prof_sys_info_job.h"

namespace analysis {
namespace dvvp {
namespace device {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::JobWrapper;
using namespace analysis::dvvp::common::validation;


std::mutex CollectEngine::staticMtx_;

CollectEngine::CollectEngine()
    : _is_stop(false), isInited_(false), _is_started(false)
{
    collectionJobCommCfg_.reset();
}

CollectEngine::~CollectEngine()
{
    Uinit();
}

int32_t CollectEngine::Init(int32_t devId)
{
    isInited_ = true;
    MSVP_MAKE_SHARED0(collectionJobCommCfg_, CollectionJobCommonParams, return PROFILING_FAILED);
    collectionJobCommCfg_->devId = devId;
    CreateCollectionJobArray();
    return PROFILING_SUCCESS;
}

int32_t CollectEngine::Uinit()
{
    if (!isInited_) {
        return PROFILING_SUCCESS;
    }

    isInited_ = false;
    if (_is_started) {
        try {
            analysis::dvvp::message::StatusInfo status;
            int32_t ret = CollectStop(status);
            if (ret != PROFILING_SUCCESS) {
                MSPROF_LOGD("[CollectEngine]Collect stop failed.");
                return ret;
            }
        } catch (...) {
            MSPROF_LOGD("[CollectEngine]Uinit failed.");
            return PROFILING_FAILED;
        }
    }
    collectionJobCommCfg_.reset();
    return PROFILING_SUCCESS;
}

void CollectEngine::SetDevIdOnHost(int32_t devIdOnHost)
{
    if (collectionJobCommCfg_ != nullptr) {
        MSPROF_LOGI("SetDevIdOnHost devId :%d", collectionJobCommCfg_->devIdOnHost);
        collectionJobCommCfg_->devIdOnHost = devIdOnHost;
        collectionJobCommCfg_->devIdFlush = devIdOnHost;
    }
}

int32_t CollectEngine::CreateTmpDir(std::string &tmp)
{
    std::string tempDir = Analysis::Dvvp::Common::Config::ConfigManager::instance()->GetDefaultWorkDir();
    if (tempDir.empty()) {
        MSPROF_LOGE("GetInotifyDir failed");
        return PROFILING_FAILED;
    }
    tmp = tempDir + collectionJobCommCfg_->params->job_id;

    std::lock_guard<std::mutex> lock(staticMtx_);
    int32_t ret = analysis::dvvp::common::utils::Utils::CreateDir(tmp);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Creating dir failed: %s", Utils::BaseName(tmp).c_str());
        analysis::dvvp::common::utils::Utils::PrintSysErrorMsg();
        return ret;
    }
    MSPROF_LOGI("Creating dir: \"%s\", ret=%d", Utils::BaseName(tmp).c_str(), ret);
    std::string perfDataDir =
        Analysis::Dvvp::Common::Config::ConfigManager::instance()->GetPerfDataDir(collectionJobCommCfg_->devId);
    if (perfDataDir.empty()) {
        MSPROF_LOGE("GetPerfDataDir failed");
        return PROFILING_FAILED;
    }
    ret = analysis::dvvp::common::utils::Utils::CreateDir(perfDataDir);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Creating dir failed: %s", Utils::BaseName(perfDataDir).c_str());
        analysis::dvvp::common::utils::Utils::PrintSysErrorMsg();
        return ret;
    }
    MSPROF_LOGI("Creating dir: \"%s\", ret=%d", Utils::BaseName(perfDataDir).c_str(), ret);
    return PROFILING_SUCCESS;
}

int32_t CollectEngine::CleanupResults()
{
    std::string tempDir = Analysis::Dvvp::Common::Config::ConfigManager::instance()->GetDefaultWorkDir();
    if (tempDir.empty()) {
        MSPROF_LOGE("GetInotifyDir failed");
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lock(staticMtx_);
    std::string tmp = tempDir + collectionJobCommCfg_->params->job_id;
    MSPROF_LOGI("Removing collected data: \"%s\"", tmp.c_str());
    analysis::dvvp::common::utils::Utils::RemoveDir(tmp);
    std::string perfDataDir =
        Analysis::Dvvp::Common::Config::ConfigManager::instance()->GetPerfDataDir(collectionJobCommCfg_->devId);
    if (perfDataDir.empty()) {
        MSPROF_LOGE("GetPerfDataDir failed");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Removing collected data: \"%s\"", perfDataDir.c_str());
    analysis::dvvp::common::utils::Utils::RemoveDir(perfDataDir);
    tmpResultDir_.clear();
    return PROFILING_SUCCESS;
}

int32_t CollectEngine::CheckPmuEventIsValid(SHARED_PTR_ALIA<std::vector<std::string> > ctrlCpuEvent,
    SHARED_PTR_ALIA<std::vector<std::string> > llcEvent)
{
    if (ctrlCpuEvent != nullptr && !ParamValidation::instance()->CheckCtrlCpuEventIsValid(*ctrlCpuEvent)) {
        MSPROF_LOGE("[CheckPmuEventIsValid]ctrlCpuEvent is not valid!");
        return PROFILING_FAILED;
    }

    if (llcEvent != nullptr) {
        UtilsStringBuilder<std::string> builder;
        std::string eventStr = builder.Join(*llcEvent, ",");
        if (!ParamValidation::instance()->CheckLlcEventsIsValid(eventStr)) {
            MSPROF_LOGE("[CheckPmuEventIsValid]llcEvent is not valid!");
            return PROFILING_FAILED;
        }
    }

    return PROFILING_SUCCESS;
}

int32_t CollectEngine::CollectStartReplay(SHARED_PTR_ALIA<std::vector<std::string> > ctrlCpuEvent,
                                      analysis::dvvp::message::StatusInfo &status,
                                      SHARED_PTR_ALIA<std::vector<std::string> > llcEvent)
{
    status.status = analysis::dvvp::message::ERR;
    if (!_is_started || collectionJobCommCfg_ == nullptr) {
        status.info = "collection engine has not been started";
        return PROFILING_FAILED;
    }
    if (CheckPmuEventIsValid(ctrlCpuEvent, llcEvent) != PROFILING_SUCCESS) {
        status.info = "[CollectStart] pmu event is not valid.";
        MSPROF_LOGE("[CollectStart] pmu event is not valid.");
        return PROFILING_FAILED;
    }
    MSVP_MAKE_SHARED0(collectionJobCommCfg_->jobCtx, analysis::dvvp::message::JobContext, return PROFILING_FAILED);
    collectionJobCommCfg_->jobCtx->dev_id = std::to_string(collectionJobCommCfg_->devIdFlush);
    collectionJobCommCfg_->jobCtx->job_id = collectionJobCommCfg_->params->job_id;
    collectionJobV_[CTRLCPU_PERF_COLLECTION_JOB].jobCfg->jobParams.events = ctrlCpuEvent;
    collectionJobV_[LLC_DRV_COLLECTION_JOB].jobCfg->jobParams.events = llcEvent;
    return CollectRegister(status);
}

int32_t CollectEngine::CollectRegister(analysis::dvvp::message::StatusInfo &status)
{
    MSPROF_LOGI("Start to register collection job:%s", collectionJobCommCfg_->params->job_id.c_str());
    int32_t registerCnt = 0;
    std::vector<int32_t> registered;
    for (int32_t cnt = 0; cnt < NR_MAX_COLLECTION_JOB; cnt++) {
        // check job availability
        if (collectionJobV_[cnt].collectionJob != nullptr) {
            MSPROF_LOGI("CollectRegister Start jobId %d ", cnt);
            int32_t ret = collectionJobV_[cnt].collectionJob->Init(collectionJobV_[cnt].jobCfg);
            if (ret == PROFILING_SUCCESS) {
                MSPROF_LOGD("Collection Job %d Register", cnt);
                ret = CollectionRegisterMgr::instance()
                    ->CollectionJobRegisterAndRun(collectionJobCommCfg_->devId,
                                                  collectionJobV_[cnt].jobTag,
                                                  collectionJobV_[cnt].collectionJob);
            }

            if (ret != PROFILING_SUCCESS) {
                MSPROF_LOGD("Collection Job %d No Run; Total: %d", collectionJobV_[cnt].jobTag, registerCnt);
                registerCnt++;
            } else {
                registered.push_back(cnt);
            }
        }
    }
    UtilsStringBuilder<int32_t> intBuilder;
    MSPROF_LOGI("Total count of job registered: %s", intBuilder.Join(registered, ",").c_str());

    if (registered.empty()) {
        MSPROF_LOGE("CollectionJobRegisterAndRun failed, fail_cnt:%d", registerCnt);
        status.status = analysis::dvvp::message::ERR;
        return PROFILING_FAILED;
    }
    status.status = analysis::dvvp::message::SUCCESS;
    return PROFILING_SUCCESS;
}

int32_t CollectEngine::CollectStopJob(analysis::dvvp::message::StatusInfo &status)
{
    int32_t ret = PROFILING_FAILED;
    status.status = analysis::dvvp::message::ERR;

    do {
        MSPROF_LOGI("Stop Job");

        if (!_is_started || collectionJobCommCfg_ == nullptr) {
            status.info = "collection engine has not been started";
            break;
        }
        for (int32_t cnt = 0; cnt < NR_MAX_COLLECTION_JOB; cnt++) {
            if (collectionJobV_[cnt].collectionJob == nullptr) {
                continue;
            }
            int32_t retn = CollectionRegisterMgr::instance()->CollectionJobUnregisterAndStop(
                collectionJobCommCfg_->devId, collectionJobV_[cnt].jobTag);
            collectionJobV_[cnt].jobCfg->jobParams.events.reset();
            collectionJobV_[cnt].jobCfg->jobParams.cores.reset();
            if (retn != PROFILING_SUCCESS) {
                MSPROF_LOGD("Device %d Collection Job %d Unregister", collectionJobCommCfg_->devIdOnHost,
                            collectionJobV_[cnt].jobTag);
            }
        }
        ret = PROFILING_SUCCESS;
    } while (0);
    return ret;
}

int32_t CollectEngine::CollectStopReplay(analysis::dvvp::message::StatusInfo &status)
{
    int32_t ret = PROFILING_FAILED;
    status.status = analysis::dvvp::message::ERR;

    do {
        MSPROF_LOGI("Stop");

        if (CollectStopJob(status) != PROFILING_SUCCESS) {
            break;
        }
        collectionJobCommCfg_->jobCtx.reset();
        status.status = analysis::dvvp::message::SUCCESS;
        ret = PROFILING_SUCCESS;
    } while (0);

    return ret;
}

int32_t CollectEngine::CollectStop(analysis::dvvp::message::StatusInfo &status)
{
    int32_t ret = PROFILING_FAILED;
    status.status = analysis::dvvp::message::SUCCESS;
    if (!collectionJobCommCfg_) {
        status.status = analysis::dvvp::message::ERR;
        MSPROF_LOGE("[CollectStop]Config is null");
        return PROFILING_FAILED;
    }
    if (_is_started) {
        MSPROF_LOGI("stop collect ...");
        ret = CollectStopReplay(status);
        if (ret != PROFILING_SUCCESS) {
            status.status = analysis::dvvp::message::ERR;
            MSPROF_LOGE("[CollectStop]Collect stop failed");
        }
        MSPROF_LOGI("Data collection finished under agent mode.");
    }
    (void)CleanupResults();
    // finish data session
    ret = analysis::dvvp::device::CollectionEntry::instance()->FinishCollection(
        collectionJobCommCfg_->devIdFlush, collectionJobCommCfg_->params->job_id);
    if (ret != PROFILING_SUCCESS) {
        status.status = analysis::dvvp::message::ERR;
        MSPROF_LOGE("[CollectStop]FinishCollection failed");
    }
    ProfChannelManager::instance()->UnInit();
    _is_started = false;
    _is_stop = true;
    if (status.status == analysis::dvvp::message::ERR) {
        status.info = "Stop profiling failed, please check it or see log for more info";
        return PROFILING_FAILED;
    } else {
        return PROFILING_SUCCESS;
    }
}

int32_t CollectEngine::InitBeforeCollectStart(const std::string &sampleConfig,
    analysis::dvvp::message::StatusInfo &status)
{
    _is_started = false;
    _is_stop = false;
    _sample_config = sampleConfig;
    do {
        MSVP_MAKE_SHARED0_NODO(collectionJobCommCfg_->params, analysis::dvvp::message::ProfileParams, break);
        if (!collectionJobCommCfg_->params->FromString(sampleConfig)) {
            MSPROF_LOGE("Failed to parse sampleConfig: \"%s\".", sampleConfig.c_str());
            status.info = "invalid sample configuration";
            break;
        }

        MSPROF_LOGI("parse sampleConfig: \"%s\".", sampleConfig.c_str());
        int32_t ret = CreateTmpDir(tmpResultDir_);
        if (ret != PROFILING_SUCCESS) {
            status.info = "Failed to create tmp root result directory.";
            break;
        }
        return PROFILING_SUCCESS;
    } while (0);
    return PROFILING_FAILED;
}

int32_t CollectEngine::CollectStart(const std::string &sampleConfig,
                                analysis::dvvp::message::StatusInfo &status)
{
    int32_t ret = PROFILING_FAILED;
    status.status = analysis::dvvp::message::ERR;
    do {
        if (!isInited_ || collectionJobCommCfg_ == nullptr) {
            status.info = "Collection engine was not initialized.";
            break;
        }

        if (InitBeforeCollectStart(sampleConfig, status) == PROFILING_FAILED) {
            break;
        }
        MSPROF_LOGI("Collection started, sample config:%s", sampleConfig.c_str());
        if (ProfChannelManager::instance()->Init() != PROFILING_SUCCESS) {
            MSPROF_LOGE("[CollectEngine::CollectStart]Failed to init channel poll");
            ret = PROFILING_FAILED;
            break;
        }
        if (DrvChannelsMgr::instance()->GetAllChannels(collectionJobCommCfg_->devId) != PROFILING_SUCCESS) {
            MSPROF_LOGE("[CollectEngine::CollectStart]Failed to GetAllChannels");
            ret = PROFILING_FAILED;
            break;
        }
        _is_started = true;
        ret = PROFILING_SUCCESS;
    } while (0);
    if (ret != PROFILING_SUCCESS) {
        (void)CleanupResults();
    } else {
        status.status = analysis::dvvp::message::SUCCESS;
    }
    return ret;
}

std::string CollectEngine::BindFileWithChannel(const std::string &fileName, uint32_t channelId)
{
    std::stringstream ssProfDataFilePath;

    ssProfDataFilePath << fileName;
    ssProfDataFilePath << ".";
    ssProfDataFilePath << channelId;

    return ssProfDataFilePath.str();
}

void CollectEngine::CreateCollectionJobArray()
{
    // on device mapping scene, device just proc system profiling job
    MSVP_MAKE_SHARED0(collectionJobV_[CTRLCPU_PERF_COLLECTION_JOB].collectionJob, ProfCtrlcpuJob, return);
    MSVP_MAKE_SHARED0(collectionJobV_[SYSSTAT_PROC_COLLECTION_JOB].collectionJob, ProfSysStatJob, return);
    MSVP_MAKE_SHARED0(collectionJobV_[SYSMEM_PROC_COLLECTION_JOB].collectionJob, ProfSysMemJob, return);
    MSVP_MAKE_SHARED0(collectionJobV_[ALLPID_PROC_COLLECTION_JOB].collectionJob, ProfAllPidsJob, return);
    MSVP_MAKE_SHARED0(collectionJobV_[LLC_DRV_COLLECTION_JOB].collectionJob, ProfLlcJob, return);
    MSPROF_LOGI("CreateCollectionJobArray to set jobCfg");

    for (int32_t cnt = 0; cnt < NR_MAX_COLLECTION_JOB; cnt++) {
        // check job availability
        if (collectionJobV_[cnt].collectionJob != nullptr) {
            MSVP_MAKE_SHARED0(collectionJobV_[cnt].jobCfg, CollectionJobCfg, return);
            collectionJobV_[cnt].jobTag = (ProfCollectionJobE)cnt;
            collectionJobV_[cnt].jobCfg->jobParams.jobTag = (ProfCollectionJobE)cnt;
            collectionJobV_[cnt].jobCfg->comParams = collectionJobCommCfg_;
        }
    }
}
}  // namespace device
}  // namespace dvvp
}  // namespace analysis
