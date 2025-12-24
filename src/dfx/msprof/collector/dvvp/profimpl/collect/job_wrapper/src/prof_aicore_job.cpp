/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_aicore_job.h"
#include "errno/error_code.h"
#include "json_parser.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace Msprofiler::Parser;

ProfAicoreJob::ProfAicoreJob()
    : period_(DEFAULT_PERIOD_TIME), channelId_(PROF_CHANNEL_AI_CORE) // 10 is the default period
{
}
ProfAicoreJob::~ProfAicoreJob()
{
}


int32_t ProfAicoreJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->ai_core_profiling.compare("on") != 0 ||
        collectionJobCfg_->comParams->params->ai_core_profiling_mode.compare("sample-based") != 0) {
        MSPROF_LOGI("Aicore sample-based not enable, devId:%d", collectionJobCfg_->comParams->devId);
        return PROFILING_FAILED;
    }
    taskType_ = PROF_AICORE_SAMPLE;
    if (collectionJobCfg_->comParams->params->aicore_sampling_interval > 0) {
        period_ = collectionJobCfg_->comParams->params->aicore_sampling_interval;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfAicoreJob::Process()
{
    CHECK_JOB_EVENT_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId_:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }
    std::string eventsStr = GetEventsStr(*collectionJobCfg_->jobParams.events);
    std::string coresStr = analysis::dvvp::common::utils::Utils::GetCoresStr(*collectionJobCfg_->jobParams.cores);
    MSPROF_LOGI("Begin to start profiling ai core, taskType:%s, events:%s, cores:%s",
        taskType_.c_str(), eventsStr.c_str(), coresStr.c_str());

    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);

    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_, filePath);

    DrvPeripheralProfileCfg drvPeripheralProfileCfg;
    drvPeripheralProfileCfg.profDeviceId = collectionJobCfg_->comParams->devId;
    drvPeripheralProfileCfg.profChannel = channelId_;
    drvPeripheralProfileCfg.profSamplePeriod = period_;  // int32_t prof_sample_period,
    const uint32_t peroid = JsonParser::instance()->GetJsonChannelPeroid(channelId_);
    const uint32_t bufferLen = JsonParser::instance()->GetJsonChannelDriverBufferLen(channelId_);
    if (peroid != 0) {
        drvPeripheralProfileCfg.profSamplePeriod = peroid;
    }
    if (bufferLen != 0) {
        drvPeripheralProfileCfg.bufLen = bufferLen;
    }
    std::string fileName = GenerateFileName(filePath,
        collectionJobCfg_->comParams->devIdOnHost);
    drvPeripheralProfileCfg.profDataFilePath = "";

    int32_t ret = DrvAicoreStart(drvPeripheralProfileCfg,
                             *collectionJobCfg_->jobParams.cores,  // const std::vector<int32_t>& prof_cores,
                             *collectionJobCfg_->jobParams.events);  // std::vector<std::string> &prof_events,

    MSPROF_LOGI("start profiling ai core, taskType:%s, events:%s, cores:%s, ret=%d", taskType_.c_str(),
        eventsStr.c_str(), coresStr.c_str(), ret);

    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);
    return ret;
}

int32_t ProfAicoreJob::Uninit()
{
    CHECK_JOB_EVENT_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);

    std::string eventsStr = GetEventsStr(*collectionJobCfg_->jobParams.events);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("begin to stop profiling %s, events:%s", taskType_.c_str(), eventsStr.c_str());

    int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);

    MSPROF_LOGI("stop profiling %s, events:%s, ret=%d", taskType_.c_str(), eventsStr.c_str(), ret);

    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);
    collectionJobCfg_->jobParams.cores.reset();
    collectionJobCfg_->jobParams.events.reset();
    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);
    return ret;
}

ProfAivJob::ProfAivJob()
{
}
ProfAivJob::~ProfAivJob()
{
}


int32_t ProfAivJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->aiv_profiling.compare("on") != 0 ||
        collectionJobCfg_->comParams->params->aiv_profiling_mode.compare("sample-based") != 0) {
        MSPROF_LOGI("Aivector core sample-based not enable, devId:%d", collectionJobCfg_->comParams->devId);
        return PROFILING_FAILED;
    }
    taskType_ = PROF_AIV_SAMPLE;
    period_ = DEFAULT_PERIOD_TIME; // 10 is the default period
    channelId_ = PROF_CHANNEL_AIV_CORE;
    if (collectionJobCfg_->comParams->params->aiv_sampling_interval > 0) {
        period_ = collectionJobCfg_->comParams->params->aiv_sampling_interval;
    }
    return PROFILING_SUCCESS;
}


ProfAicoreTaskBasedJob::ProfAicoreTaskBasedJob()
    : channelId_(PROF_CHANNEL_AI_CORE)
{
}
ProfAicoreTaskBasedJob::~ProfAicoreTaskBasedJob()
{
}

int32_t ProfAicoreTaskBasedJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    MSPROF_LOGI("ProfAicoreTaskBasedJob init");
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    if (cfg->comParams->params->ai_core_profiling.compare("on") != 0 ||
        cfg->comParams->params->ai_core_profiling_mode.compare("task-based") != 0) {
        MSPROF_LOGI("Aicore task-based not enable, devId:%d", cfg->comParams->devId);
        return PROFILING_FAILED;
    }
    taskType_ = PROF_AICORE_TASK;
    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

int32_t ProfAicoreTaskBasedJob::Process()
{
    CHECK_JOB_EVENT_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }
    std::string eventsStr = GetEventsStr(*collectionJobCfg_->jobParams.events);
    MSPROF_LOGI("Begin to start profiling AicoreTaskBase, taskType:%s, events:%s",
        taskType_.c_str(), eventsStr.c_str());

    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);

    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_, filePath);
    int32_t ret = DrvAicoreTaskBasedStart(collectionJobCfg_->comParams->devId, channelId_,
        *collectionJobCfg_->jobParams.events);

    MSPROF_LOGI("start profiling AicoreTaskBase, taskType:%s, events:%s, ret=%d",
        taskType_.c_str(), eventsStr.c_str(), ret);

    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);
    return ret;
}

int32_t ProfAicoreTaskBasedJob::Uninit()
{
    CHECK_JOB_EVENT_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }
    std::string eventsStr = GetEventsStr(*collectionJobCfg_->jobParams.events);
    int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);
    MSPROF_LOGI("stop profiling AicoreTaskBase, taskType:%s, events:%s, ret=%d",
                taskType_.c_str(), eventsStr.c_str(), ret);
    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);
    collectionJobCfg_->jobParams.events.reset();

    return PROFILING_SUCCESS;
}

ProfAivTaskBasedJob::ProfAivTaskBasedJob()
{
}
ProfAivTaskBasedJob::~ProfAivTaskBasedJob()
{
}

int32_t ProfAivTaskBasedJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    MSPROF_LOGI("ProfAivTaskBasedJob init");
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    if (cfg->comParams->params->aiv_profiling.compare("on") != 0 ||
        cfg->comParams->params->aiv_profiling_mode.compare("task-based") != 0) {
        MSPROF_LOGI("Aivector core task-based not enable, devId:%d", cfg->comParams->devId);
        return PROFILING_FAILED;
    }
    taskType_ = PROF_AIV_TASK;
    channelId_ = PROF_CHANNEL_AIV_CORE;
    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

}
}
}