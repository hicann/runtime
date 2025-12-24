/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_sys_info_job.h"
#include "prof_timer.h"
#include "uploader_mgr.h"
#include "prof_comm_job.h"
#include "param_validation.h"
#include "errno/error_code.h"
#include "platform/platform.h"
#include "adprof_collector_proxy.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Platform;

static unsigned long long ProfTimerJobCommonInit(const SHARED_PTR_ALIA<CollectionJobCfg> cfg,
    SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> &uploader,
    TimerHandlerTag timerTag)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    const uint32_t profStatMemIntervalHundredMs = 100;  // 100 MS
    const uint32_t profMsToNs = 1000000;  // 1000000 NS
    int32_t sampleIntervalMs = profStatMemIntervalHundredMs;
    int32_t profilingInterval = cfg->comParams->params->cpu_sampling_interval;

    if (timerTag == PROF_SYS_MEM) {
        profilingInterval = cfg->comParams->params->sys_sampling_interval;
    } else if (timerTag == PROF_ALL_PID) {
        profilingInterval = cfg->comParams->params->pid_sampling_interval;
    }

    if (profilingInterval > sampleIntervalMs) {
        sampleIntervalMs = profilingInterval;
    }

    if (AdprofCollectorProxy::instance()->AdprofStarted()) {
        return (static_cast<unsigned long long>(sampleIntervalMs) * profMsToNs);
    }

    analysis::dvvp::transport::UploaderMgr::instance()->GetUploader(cfg->comParams->params->job_id, uploader);
    if (uploader == nullptr) {
        MSPROF_LOGE("Failed to get devId:%d uploader, devIdOnHost:%d",
                    cfg->comParams->devId, cfg->comParams->devIdOnHost);
        MSPROF_INNER_ERROR("EK9999", "Failed to get devId:%d uploader, devIdOnHost:%d",
            cfg->comParams->devId, cfg->comParams->devIdOnHost);
        return 0;
    }
    MSPROF_LOGI("[ProfTimerJobCommonInit]devId:%d, devIdOnHost:%d, timerTag:%d, sampleIntervalMs:%d",
        cfg->comParams->devId, cfg->comParams->devIdOnHost, timerTag, sampleIntervalMs);

    return (static_cast<unsigned long long>(sampleIntervalMs) * profMsToNs);
}

ProfSysStatJob::ProfSysStatJob() : ProfSysInfoBase()
{
}

ProfSysStatJob::~ProfSysStatJob()
{
}

int32_t ProfSysStatJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    if (!Platform::instance()->RunSocSide()) {
        MSPROF_LOGI("Not in device Side, SysStat Profiling not enabled");
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->sys_profiling.compare(
        analysis::dvvp::common::config::MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("sys_profiling not enabled");
        return PROFILING_FAILED;
    }
    sampleIntervalNs_ = ProfTimerJobCommonInit(collectionJobCfg_, uploader_, PROF_SYS_STAT);
    if (sampleIntervalNs_ == 0) {
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t ProfSysStatJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    const uint32_t procSysStatBufSize = (1 << 13); // 1 << 13  means 8k

    std::string retFileName(PROF_SYS_CPU_USAGE_FILE);
    SHARED_PTR_ALIA<ProcStatFileHandler> statHandler;
    SHARED_PTR_ALIA<TimerAttr> attr = nullptr;
    MSVP_MAKE_SHARED4(attr, TimerAttr, PROF_SYS_STAT, collectionJobCfg_->comParams->devId,
        procSysStatBufSize, sampleIntervalNs_, return PROFILING_FAILED);
    attr->srcFileName = PROF_PROC_STAT;
    attr->retFileName = retFileName;
    MSVP_MAKE_SHARED4(statHandler, ProcStatFileHandler, attr, collectionJobCfg_->comParams->params,
        collectionJobCfg_->comParams->jobCtx, uploader_, return PROFILING_FAILED);

    if (statHandler->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("statHandler Init Failed");
        MSPROF_INNER_ERROR("EK9999", "statHandler Init Failed");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("statHandler Init succ, sampleIntervalNs_:%" PRIu64, sampleIntervalNs_);
    TimerManager::instance()->StartProfTimer();
    TimerManager::instance()->RegisterProfTimerHandler(PROF_SYS_STAT, statHandler);
    return PROFILING_SUCCESS;
}

int32_t ProfSysStatJob::Uninit()
{
    TimerManager::instance()->RemoveProfTimerHandler(PROF_SYS_STAT);
    TimerManager::instance()->StopProfTimer();
    uploader_.reset();
    return PROFILING_SUCCESS;
}

ProfAllPidsJob::ProfAllPidsJob() : ProfSysInfoBase()
{
}

ProfAllPidsJob::~ProfAllPidsJob()
{
}

int32_t ProfAllPidsJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    if (cfg == nullptr ||
        cfg->comParams == nullptr ||
        cfg->comParams->jobCtx == nullptr ||
        cfg->comParams->params == nullptr) {
        return PROFILING_FAILED;
    }
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    if (!Platform::instance()->RunSocSide()) {
        MSPROF_LOGI("Not in device Side, AllPids Profiling not enabled");
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->pid_profiling.compare(
        analysis::dvvp::common::config::MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("pid_profiling not enabled");
        return PROFILING_FAILED;
    }
    sampleIntervalNs_ = ProfTimerJobCommonInit(collectionJobCfg_, uploader_, PROF_ALL_PID);
    if (sampleIntervalNs_ == 0) {
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t ProfAllPidsJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    SHARED_PTR_ALIA<ProcAllPidsFileHandler> pidsHandler;
    SHARED_PTR_ALIA<TimerAttr> attr = nullptr;
    MSVP_MAKE_SHARED4(attr, TimerAttr, PROF_ALL_PID, collectionJobCfg_->comParams->devId,
        0, sampleIntervalNs_, return PROFILING_FAILED);
    MSVP_MAKE_SHARED4(pidsHandler, ProcAllPidsFileHandler,
        attr, collectionJobCfg_->comParams->params,
        collectionJobCfg_->comParams->jobCtx, uploader_, return PROFILING_FAILED);
    if (pidsHandler->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("pidsHandler Init Failed");
        MSPROF_INNER_ERROR("EK9999", "pidsHandler Init Failed");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("pidsHandler Init succ, sampleIntervalNs_:%" PRIu64, sampleIntervalNs_);
    TimerManager::instance()->StartProfTimer();
    TimerManager::instance()->RegisterProfTimerHandler(PROF_ALL_PID, pidsHandler);
    return PROFILING_SUCCESS;
}

int32_t ProfAllPidsJob::Uninit()
{
    TimerManager::instance()->RemoveProfTimerHandler(PROF_ALL_PID);
    TimerManager::instance()->StopProfTimer();
    uploader_.reset();
    return PROFILING_SUCCESS;
}

ProfSysMemJob::ProfSysMemJob() : ProfSysInfoBase()
{
}

ProfSysMemJob::~ProfSysMemJob()
{
}

int32_t ProfSysMemJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    if (!Platform::instance()->RunSocSide()) {
        MSPROF_LOGI("Not in device Side, SysMem Profiling not enabled");
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->sys_profiling.compare(
        analysis::dvvp::common::config::MSVP_PROF_ON) != 0 ||
        collectionJobCfg_->comParams->params->msprof.compare(
            analysis::dvvp::common::config::MSVP_PROF_ON) == 0) { // msprof does not collect mem
        MSPROF_LOGI("sys mem profiling not enabled");
        return PROFILING_FAILED;
    }
    sampleIntervalNs_ = ProfTimerJobCommonInit(collectionJobCfg_, uploader_, PROF_SYS_MEM);
    if (sampleIntervalNs_ == 0) {
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t ProfSysMemJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    const uint32_t procSysMemBufSize = (1 << 15);  // 1 << 15  means 32k
    std::string retFileName(PROF_SYS_MEM_FILE);

    SHARED_PTR_ALIA<ProcMemFileHandler> memHandler;
    SHARED_PTR_ALIA<TimerAttr> attr = nullptr;
    MSVP_MAKE_SHARED4(attr, TimerAttr, PROF_SYS_MEM, collectionJobCfg_->comParams->devId,
        procSysMemBufSize, sampleIntervalNs_, return PROFILING_FAILED);
    attr->srcFileName = PROF_PROC_MEM;
    attr->retFileName = retFileName;
    MSVP_MAKE_SHARED4(memHandler, ProcMemFileHandler, attr, collectionJobCfg_->comParams->params,
        collectionJobCfg_->comParams->jobCtx, uploader_, return PROFILING_FAILED);
    if (memHandler->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("memHandler Init Failed");
        MSPROF_INNER_ERROR("EK9999", "memHandler Init Failed");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("memHandler Init succ, sampleIntervalNs_:%" PRIu64, sampleIntervalNs_);
    TimerManager::instance()->StartProfTimer();
    TimerManager::instance()->RegisterProfTimerHandler(PROF_SYS_MEM, memHandler);
    return PROFILING_SUCCESS;
}

int32_t ProfSysMemJob::Uninit()
{
    TimerManager::instance()->RemoveProfTimerHandler(PROF_SYS_MEM);
    TimerManager::instance()->StopProfTimer();
    uploader_.reset();
    return PROFILING_SUCCESS;
}

}
}
}