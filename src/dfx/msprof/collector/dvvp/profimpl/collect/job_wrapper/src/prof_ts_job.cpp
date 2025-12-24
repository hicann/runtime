/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_ts_job.h"
#include "errno/error_code.h"
#include "json_parser.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Msprofiler::Parser;
using namespace Analysis::Dvvp::Common::Platform;

ProfTscpuJob::ProfTscpuJob()
{
}
ProfTscpuJob::~ProfTscpuJob()
{
}

int32_t ProfTscpuJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

int32_t ProfTscpuJob::Process()
{
    CHECK_JOB_EVENT_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, PROF_CHANNEL_TS_CPU)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            PROF_CHANNEL_TS_CPU);
        return PROFILING_SUCCESS;
    }

    std::string eventsStr = GetEventsStr(*collectionJobCfg_->jobParams.events);
    MSPROF_LOGI("Begin to start profiling ts cpu, events:%s", eventsStr.c_str());

    int32_t tsCpuPeriod = 10;
    if (collectionJobCfg_->comParams->params->cpu_sampling_interval > 0) {
        tsCpuPeriod = collectionJobCfg_->comParams->params->cpu_sampling_interval;
    }

    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);

    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId,
        PROF_CHANNEL_TS_CPU, filePath);

    DrvPeripheralProfileCfg drvPeripheralProfileCfg;
    drvPeripheralProfileCfg.profDeviceId = collectionJobCfg_->comParams->devId;
    drvPeripheralProfileCfg.profChannel = PROF_CHANNEL_TS_CPU;
    drvPeripheralProfileCfg.bufLen = JsonParser::instance()->GetJsonChannelDriverBufferLen(PROF_CHANNEL_TS_CPU);
    uint32_t peroid = JsonParser::instance()->GetJsonChannelPeroid(PROF_CHANNEL_TS_CPU);
    if (peroid != 0) {
        drvPeripheralProfileCfg.profSamplePeriod = peroid;
    } else {
        drvPeripheralProfileCfg.profSamplePeriod = tsCpuPeriod;  // int32_t prof_sample_period
    }
    drvPeripheralProfileCfg.profDataFilePath = "";

    int32_t ret = DrvTscpuStart(drvPeripheralProfileCfg,
                            *collectionJobCfg_->jobParams.events);

    MSPROF_LOGI("start profiling ts cpu, events:%s, ret=%d", eventsStr.c_str(), ret);
    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);
    return ret;
}

int32_t ProfTscpuJob::Uninit()
{
    CHECK_JOB_EVENT_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, PROF_CHANNEL_TS_CPU)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            PROF_CHANNEL_TS_CPU);
        return PROFILING_SUCCESS;
    }

    std::string eventsStr = GetEventsStr(*(collectionJobCfg_->jobParams.events));

    const int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, PROF_CHANNEL_TS_CPU);

    MSPROF_LOGI("stop profiling ts cpu, events:%s, ret=%d", eventsStr.c_str(), ret);

    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId,
        PROF_CHANNEL_TS_CPU);
    collectionJobCfg_->jobParams.events.reset();
    return PROFILING_SUCCESS;
}

ProfFmkJob::ProfFmkJob()
{
}
ProfFmkJob::~ProfFmkJob()
{
}

int32_t ProfFmkJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_CONTEXT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

int32_t ProfFmkJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    if (collectionJobCfg_->comParams->params->ts_fw_training.compare("on") != 0) {
        MSPROF_LOGI("ts_fw_training not enabled");
        return PROFILING_SUCCESS;
    }
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, PROF_CHANNEL_FMK)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            PROF_CHANNEL_FMK);
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("Begin to start profiling fmk log");

    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);
    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId,
        PROF_CHANNEL_FMK, filePath);
    int32_t ret = DrvFmkDataStart(collectionJobCfg_->comParams->devId, PROF_CHANNEL_FMK);

    MSPROF_LOGI("start profiling fmk log, ret=%d", ret);
    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);
    return ret;
}

int32_t ProfFmkJob::Uninit()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);

    if (collectionJobCfg_->comParams->params->ts_fw_training.compare("on") != 0) {
        return PROFILING_SUCCESS;
    }
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, PROF_CHANNEL_FMK)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            PROF_CHANNEL_FMK);
        return PROFILING_SUCCESS;
    }

    int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, PROF_CHANNEL_FMK);

    MSPROF_LOGI("stop profiling fmk data, ret=%d", ret);

    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, PROF_CHANNEL_FMK);

    return PROFILING_SUCCESS;
}

ProfTsTrackJob::ProfTsTrackJob() : channelId_(PROF_CHANNEL_TS_FW)
{
}
ProfTsTrackJob::~ProfTsTrackJob()
{
}

int32_t ProfTsTrackJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    if (cfg->comParams->params->ts_task_track.compare("on") != 0 &&
        cfg->comParams->params->ts_cpu_usage.compare("on") != 0 &&
        cfg->comParams->params->ai_core_status.compare("on") != 0 &&
        cfg->comParams->params->ts_timeline.compare("on") != 0 &&
        cfg->comParams->params->ts_keypoint.compare("on") != 0 &&
        cfg->comParams->params->ts_memcpy.compare("on") != 0) {
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

int32_t ProfTsTrackJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    int32_t cpuProfilingInterval = 10;
    if (collectionJobCfg_->comParams->params->cpu_sampling_interval > 0) {
        cpuProfilingInterval = collectionJobCfg_->comParams->params->cpu_sampling_interval;
    }
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId, channelId_);
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("Begin to start profiling ts track, devId: %d", collectionJobCfg_->comParams->devId);
    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);
    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId,
        channelId_, filePath);
    DrvPeripheralProfileCfg drvPeripheralProfileCfg;
    drvPeripheralProfileCfg.profDeviceId = collectionJobCfg_->comParams->devId;
    drvPeripheralProfileCfg.profChannel = channelId_;
    drvPeripheralProfileCfg.bufLen = JsonParser::instance()->GetJsonChannelDriverBufferLen(channelId_);
    if (Platform::instance()->GetMaxMonitorNumber() == ACC_PMU_EVENT_MAX_NUM) {
        drvPeripheralProfileCfg.profSamplePeriod = 0;
    } else {
        uint32_t peroid = JsonParser::instance()->GetJsonChannelPeroid(channelId_);
        drvPeripheralProfileCfg.profSamplePeriod = (peroid != 0) ? peroid : cpuProfilingInterval;
    }
    drvPeripheralProfileCfg.profDataFilePath = "";
    const int32_t ret = DrvTsFwStart(drvPeripheralProfileCfg, collectionJobCfg_->comParams->params);
    MSPROF_LOGI("start profiling ts track, ret=%d", ret);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfTsTrackJob]Process, DrvTsFwStart failed");
        MSPROF_INNER_ERROR("EK9999", "Process, DrvTsFwStart failed");
    }
    return ret;
}

int32_t ProfTsTrackJob::Uninit()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }

    int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);
    MSPROF_LOGI("stop profiling ts track data, ret=%d", ret);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfTsTrackJob]Uninit, DrvStop failed");
        MSPROF_INNER_ERROR("EK9999", "Uninit, DrvStop failed");
    }
    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);

    return ret;
}

ProfAivTsTrackJob::ProfAivTsTrackJob() {}

ProfAivTsTrackJob::~ProfAivTsTrackJob() {}

int32_t ProfAivTsTrackJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    if (cfg->comParams->params->ts_task_track.compare("on") != 0 &&
        cfg->comParams->params->ts_cpu_usage.compare("on") != 0 &&
        cfg->comParams->params->ai_core_status.compare("on") != 0 &&
        cfg->comParams->params->ts_timeline.compare("on") != 0) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    channelId_ = PROF_CHANNEL_AIV_TS_FW;
    collectionJobCfg_->comParams->params->ts_keypoint = "off";
    return PROFILING_SUCCESS;
}

}
}
}
