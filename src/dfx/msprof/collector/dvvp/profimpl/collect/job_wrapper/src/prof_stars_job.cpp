/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_stars_job.h"
#include "ai_drv_prof_api.h"
#include "errno/error_code.h"
#include "config/config.h"
#include "json_parser.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace Msprofiler::Parser;
using namespace Analysis::Dvvp::Common::Platform;

ProfStarsSocLogJob::ProfStarsSocLogJob() : channelId_(PROF_CHANNEL_STARS_SOC_LOG)
{
}
ProfStarsSocLogJob::~ProfStarsSocLogJob()
{
}

int32_t ProfStarsSocLogJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    if (cfg->comParams->params->profMode.compare(MSVP_PROF_SYSTEM_MODE) == 0) {
        MSPROF_LOGI("[ProfStarsSocLogJob]Stars log job not enable in system mode.");
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

int32_t ProfStarsSocLogJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId, channelId_);
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGI("Begin to start profiling stars soc log, devId: %d", collectionJobCfg_->comParams->devId);
    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);
    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId,
        channelId_, filePath);
    DrvPeripheralProfileCfg drvPeripheralProfileCfg;
    drvPeripheralProfileCfg.profDeviceId = collectionJobCfg_->comParams->devId;
    drvPeripheralProfileCfg.profChannel = channelId_;
    drvPeripheralProfileCfg.profSamplePeriod = JsonParser::instance()->GetJsonChannelPeroid(channelId_);
    drvPeripheralProfileCfg.bufLen = JsonParser::instance()->GetJsonChannelDriverBufferLen(channelId_);
    int32_t ret = DrvStarsSocLogStart(drvPeripheralProfileCfg, collectionJobCfg_->comParams->params);
    MSPROF_LOGI("start profiling stars soc log, ret=%d", ret);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfStarsSocLogJob]Process, DrvStarsSocLogStart failed");
        MSPROF_INNER_ERROR("EK9999", "Process, DrvStarsSocLogStart failed");
    }
    return ret;
}

int32_t ProfStarsSocLogJob::Uninit()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);

    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }

    int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);
    MSPROF_LOGI("stop profiling stars soc log, ret=%d", ret);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfStarsSocLogJob]Uninit, DrvStop failed");
        MSPROF_INNER_ERROR("EK9999", "Uninit, DrvStop failed");
    }
    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);

    return ret;
}

ProfStarsBlockLogJob::ProfStarsBlockLogJob() : channelId_(PROF_CHANNEL_STARS_BLOCK_LOG)
{
}
ProfStarsBlockLogJob::~ProfStarsBlockLogJob()
{
}

int32_t ProfStarsBlockLogJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

int32_t ProfStarsBlockLogJob::Process()
{
    /* reserved for 630 */
    return PROFILING_SUCCESS;
}

int32_t ProfStarsBlockLogJob::Uninit()
{
    /* reserved for 630 */
    return PROFILING_SUCCESS;
}

ProfFftsProfileJob::ProfFftsProfileJob()
    : channelId_(PROF_CHANNEL_UNKNOWN), cfgMode_(0), aicMode_(0), aivMode_(0),
      aicPeriod_(DEFAULT_PERIOD_TIME), aivPeriod_(DEFAULT_PERIOD_TIME)
{
}
ProfFftsProfileJob::~ProfFftsProfileJob()
{
}

int32_t ProfFftsProfileJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    cfgMode_ = 0;
    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->ai_core_profiling.compare("on") != 0 &&
        collectionJobCfg_->comParams->params->aiv_profiling.compare("on") != 0 &&
        collectionJobCfg_->comParams->params->prof_level.compare(MSVP_LEVEL_L3) == 0) {
        MSPROF_LOGI("Aicore not enable, devId:%d", collectionJobCfg_->comParams->devId);
        return PROFILING_FAILED;
    }

    if (collectionJobCfg_->comParams->params->ai_core_profiling.compare("on") == 0) {
        cfgMode_ |= 1 << static_cast<uint32_t>(FFTS_PROF_MODE_AIC);
    }
    if (collectionJobCfg_->comParams->params->aiv_profiling.compare("on") == 0) {
        cfgMode_ |= 1 << static_cast<uint32_t>(FFTS_PROF_MODE_AIV);
    }

    if (collectionJobCfg_->comParams->params->aicore_sampling_interval > 0) {
        aicPeriod_ = collectionJobCfg_->comParams->params->aicore_sampling_interval;
    }
    if (collectionJobCfg_->comParams->params->aiv_sampling_interval > 0) {
        aivPeriod_ = collectionJobCfg_->comParams->params->aiv_sampling_interval;
    }

    if (collectionJobCfg_->comParams->params->ai_core_profiling_mode.compare("sample-based") == 0 &&
        collectionJobCfg_->comParams->params->aiv_profiling_mode.compare("sample-based") == 0) {
        aicMode_ = 1 << static_cast<uint32_t>(FFTS_PROF_TYPE_SAMPLE_BASE);
        aivMode_ = 1 << static_cast<uint32_t>(FFTS_PROF_TYPE_SAMPLE_BASE);
        channelId_ = PROF_CHANNEL_FFTS_PROFILE_SAMPLE;
    } else {
        /* default mode - task based */
        aicMode_ = 1 << static_cast<uint32_t>(FFTS_PROF_TYPE_TASK_BASE);
        aivMode_ = 1 << static_cast<uint32_t>(FFTS_PROF_TYPE_TASK_BASE);
        channelId_ = PROF_CHANNEL_FFTS_PROFILE_TASK;
        aicPeriod_ = 0;
        aivPeriod_ = 0;
    }
    if (collectionJobCfg_->comParams->params->taskBlock.compare("on") == 0 &&
        channelId_ == PROF_CHANNEL_FFTS_PROFILE_TASK) {
        aicMode_ = aicMode_ | (1 << static_cast<uint32_t>(FFTS_PROF_TYPE_BLOCK));
        aivMode_ = aivMode_ | (1 << static_cast<uint32_t>(FFTS_PROF_TYPE_BLOCK));
    }
    // set sub task on
    aicMode_ = aicMode_ | (1 << static_cast<uint32_t>(FFTS_PROF_TYPE_SUBTASK));
    aivMode_ = aivMode_ | (1 << static_cast<uint32_t>(FFTS_PROF_TYPE_SUBTASK));

    MSPROF_LOGI("ffts profile init success, channelId_(0x%x), cfgMode(0x%x), aicMode(0x%x), aicPeriod(%u),"
        "aivMode(0x%x), aivPeriod(%u)", channelId_, cfgMode_, aicMode_, aicPeriod_, aivMode_, aivPeriod_);
    return PROFILING_SUCCESS;
}

int32_t ProfFftsProfileJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId, channelId_);
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGI("Begin to start ffts profile buffer, devId: %d", collectionJobCfg_->comParams->devId);
    std::string filePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);
    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_, filePath);
    DrvPeripheralProfileCfg drvPeripheralProfileCfg;
    drvPeripheralProfileCfg.profDeviceId = collectionJobCfg_->comParams->devId;
    drvPeripheralProfileCfg.profChannel = channelId_;
    drvPeripheralProfileCfg.profSamplePeriod = aicPeriod_;
    drvPeripheralProfileCfg.profSamplePeriodHi = aivPeriod_;
    drvPeripheralProfileCfg.cfgMode = cfgMode_;
    drvPeripheralProfileCfg.aicMode = aicMode_;
    drvPeripheralProfileCfg.aivMode = aivMode_;
    int32_t ret = PROFILING_SUCCESS;

    StarsAccProfileConfigT *configP = static_cast<StarsAccProfileConfigT*>(
        Utils::ProfMalloc(sizeof(StarsAccProfileConfigT)));
    FUNRET_CHECK_EXPR_ACTION(configP == nullptr, return PROFILING_FAILED,
        "StarsAccProfileConfigT ProfMalloc failed.");
    configP->aicScale = (collectionJobCfg_->comParams->params->aicScale.compare("partial") == 0) ? 1 : 0;
    drvPeripheralProfileCfg.configP = configP;
    if (Platform::instance()->GetMaxMonitorNumber() == ACC_PMU_EVENT_MAX_NUM) {
        ret = DrvAccProfileStart(drvPeripheralProfileCfg, *collectionJobCfg_->jobParams.cores,
            *collectionJobCfg_->jobParams.events, *collectionJobCfg_->jobParams.aivCores,
            *collectionJobCfg_->jobParams.aivEvents);
    } else {
        ret = DrvFftsProfileStart(drvPeripheralProfileCfg, *collectionJobCfg_->jobParams.cores,
            *collectionJobCfg_->jobParams.events, *collectionJobCfg_->jobParams.aivCores,
            *collectionJobCfg_->jobParams.aivEvents);
    }
    void *configVoid = static_cast<void *>(configP);
    Utils::ProfFree(configVoid);
    MSPROF_LOGI("start ffts profile buffer, ret=%d", ret);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfFftsProfileJob]Process, DrvFftsProfileStart failed");
        MSPROF_INNER_ERROR("EK9999", "Process, DrvFftsProfileStart failed");
    }
    return ret;
}

int32_t ProfFftsProfileJob::Uninit()
{
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            channelId_);
        return PROFILING_SUCCESS;
    }

    const int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfFftsProfileJob]Uninit failed, ret:%d", ret);
        MSPROF_INNER_ERROR("EK9999", "Uninit failed, ret:%d", ret);
    }
    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);
    collectionJobCfg_->jobParams.events.reset();

    return PROFILING_SUCCESS;
}

ProfStarsSocProfileJob::ProfStarsSocProfileJob()
{
    channelId_ = PROF_CHANNEL_STARS_SOC_PROFILE;
}

ProfStarsSocProfileJob::~ProfStarsSocProfileJob() {}

int32_t ProfStarsSocProfileJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    if (Platform::instance()->GetMaxMonitorNumber() == ACC_PMU_EVENT_MAX_NUM &&
        cfg->comParams->params->interconnection_profiling != MSVP_PROF_ON &&
        cfg->comParams->params->hardware_mem != MSVP_PROF_ON &&
        cfg->comParams->params->sysLp != MSVP_PROF_ON) {
        MSPROF_LOGI("[ProfStarsSocProfileJob]Soc_profile not enable");
        return PROFILING_FAILED;
    }
 
    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

void ProfStarsSocProfileJob::SetConfigP(int32_t &period, StarsSocProfileConfigT *configP) const
{
    if (collectionJobCfg_->comParams->params->interconnection_profiling == MSVP_PROF_ON) {
        period = collectionJobCfg_->comParams->params->interconnection_sampling_interval;
        configP->interChip.innerSwitch = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
        configP->interChip.period = (!Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_US)) ?
            period : (period * US_CONVERT_MS);
        configP->interDie.innerSwitch = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
        configP->interDie.period = (!Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_US)) ?
            period : (period * US_CONVERT_MS);
    }

    if (collectionJobCfg_->comParams->params->hardware_mem == MSVP_PROF_ON) {
        period = collectionJobCfg_->comParams->params->hardware_mem_sampling_interval;
        configP->onChip.innerSwitch = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
        configP->onChip.period = (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_US)) ?
            period : (period / US_CONVERT_MS);
        // Compatible with old driver packages in rc mode, whose hardware_mem interval unit is ms
        if (Platform::instance()->RunSocSide() && (configP->onChip.period <= 1)) {
            configP->onChip.period = period;
        }
        configP->accPmu.innerSwitch = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
        configP->accPmu.period = DEFAULT_PROFILING_INTERVAL_20MS;
    }

    if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_LOW_POWER) &&
        collectionJobCfg_->comParams->params->sysLp == MSVP_PROF_ON) {
        configP->power.innerSwitch = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
        configP->power.period = collectionJobCfg_->comParams->params->sysLpFreq;
    }

    MSPROF_LOGI("SocProfileParam: accPmu:[%d, %d], onChip:[%d, %d], interChip:[%d, %d], power:[%d, %d]",
        configP->accPmu.innerSwitch, configP->accPmu.period,
        configP->onChip.innerSwitch, configP->onChip.period,
        configP->interChip.innerSwitch, configP->interChip.period,
        configP->power.innerSwitch, configP->power.period);
}

int32_t ProfStarsSocProfileJob::SetPeripheralConfig()
{
    int32_t period = 0;
    StarsSocProfileConfigT *configP = nullptr;
    uint32_t configSize = sizeof(StarsSocProfileConfigT);
    configP = static_cast<StarsSocProfileConfigT *>(
        Utils::ProfMalloc(static_cast<size_t>(configSize)));
    if (configP == nullptr) {
        MSPROF_LOGE("ProfStarsSocProfileJob ProfMalloc failed");
        return PROFILING_FAILED;
    }
    SetConfigP(period, configP);
    if (Platform::instance()->CheckIfSupport(PLATFORM_STARS_QOS)) {
        MSPROF_EVENT("Config StarsSocQosProfileConfigT");
        uint32_t withQosConfigSize = sizeof(StarsSocQosProfileConfigT);
        StarsSocQosProfileConfigT *withQosConfigP = static_cast<StarsSocQosProfileConfigT *>(
            Utils::ProfMalloc(static_cast<size_t>(withQosConfigSize)));
        if (withQosConfigP == nullptr) {
            void *freeConfigP = static_cast<void *>(configP);
            Utils::ProfFree(freeConfigP);
            MSPROF_LOGE("StarsSocQosProfileConfigT ProfMalloc failed");
            return PROFILING_FAILED;
        }
        int32_t ret = memcpy_s(withQosConfigP, withQosConfigSize, configP, configSize);
        void *freeConfigP = static_cast<void *>(configP);
        Utils::ProfFree(freeConfigP);
        if (ret != EOK) {
            void *freeWithQosConfigP = static_cast<void *>(withQosConfigP);
            Utils::ProfFree(freeWithQosConfigP);
            MSPROF_LOGE("memcpy_s from StarsSocProfileConfigT failed");
            return PROFILING_FAILED;
        }
        if (collectionJobCfg_->comParams->params->hardware_mem == MSVP_PROF_ON) {
            withQosConfigP->qosConfig.period = period > 0 ? period : DEFAULT_PROFILING_INTERVAL_20000US;
            size_t qosEventIdSize = collectionJobCfg_->comParams->params->qosEventId.size();
            withQosConfigP->qosConfig.streamNum = static_cast<uint16_t>(qosEventIdSize);
            for (size_t i = 0; i < qosEventIdSize; i++) {
                withQosConfigP->qosConfig.mpamId[i] = collectionJobCfg_->comParams->params->qosEventId[i];
            }
        }
        peripheralCfg_.configP = withQosConfigP;
        peripheralCfg_.configSize = withQosConfigSize;
    } else {
        peripheralCfg_.configP = configP;
        peripheralCfg_.configSize = configSize;
    }
    samplePeriod_ = 0;
    return PROFILING_SUCCESS;
}
}
}
}