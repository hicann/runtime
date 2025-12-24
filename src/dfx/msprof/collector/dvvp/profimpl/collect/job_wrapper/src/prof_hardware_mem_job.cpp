/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_hardware_mem_job.h"
#include "ai_drv_prof_api.h"
#include "utils/utils.h"
#include "config/config.h"
#include "config_manager.h"
#include "param_validation.h"
#include "uploader_mgr.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;

/*
 * @berif  : Collect DDR profiling data
 */
ProfDdrJob::ProfDdrJob()
{
    channelId_ = PROF_CHANNEL_DDR;
}

ProfDdrJob::~ProfDdrJob() {}

/*
 * @berif  : DDR Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfDdrJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->ddr_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("DDR Profiling not enabled");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

/*
 * @berif  : DDR Peripheral Set Config to Driver
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfDdrJob::SetPeripheralConfig()
{
    samplePeriod_ = PERIPHERAL_INTERVAL_MS_MIN;
    if (collectionJobCfg_->comParams->params->ddr_interval >= PERIPHERAL_INTERVAL_MS_MIN &&
        collectionJobCfg_->comParams->params->ddr_interval <= PERIPHERAL_INTERVAL_MS_MAX) {
        samplePeriod_ = collectionJobCfg_->comParams->params->ddr_interval;
    }

    eventsStr_ = GetEventsStr(*(collectionJobCfg_->jobParams.events));
    const uint32_t configSize =
        sizeof(TagDdrProfileConfig) + (sizeof(uint32_t) * GetEventSize(*(collectionJobCfg_->jobParams.events)));
    CHECK_JOB_CONFIG_UNSIGNED_SIZE_RET(configSize, return PROFILING_FAILED);

    TagDdrProfileConfig *configP =
        static_cast<TagDdrProfileConfig *>(Utils::ProfMalloc(static_cast<size_t>(configSize)));
    if (configP == nullptr) {
        MSPROF_LOGE("ProfDdrJob ProfMalloc TagDdrProfileConfig failed");
        return PROFILING_FAILED;
    }

    configP->period = samplePeriod_;
    configP->masterId = DEAFULT_MASTER_ID;

    for (uint32_t i = 0; i < static_cast<uint32_t>(collectionJobCfg_->jobParams.events->size()); i++) {
        if ((*collectionJobCfg_->jobParams.events)[i].compare("read") == 0) {
            configP->event[configP->eventNum++] = PERIPHERAL_EVENT_READ;
        } else if ((*collectionJobCfg_->jobParams.events)[i].compare("write") == 0) {
            configP->event[configP->eventNum++] = PERIPHERAL_EVENT_WRITE;
        } else if ((*collectionJobCfg_->jobParams.events)[i].compare("master_id") == 0) {  // master id
            configP->masterId = static_cast<uint32_t>(collectionJobCfg_->comParams->params->ddr_master_id);
        } else {
            MSPROF_LOGW("DDR event:%s not support", (*collectionJobCfg_->jobParams.events)[i].c_str());
        }
    }

    peripheralCfg_.configP = configP;
    peripheralCfg_.configSize = configSize;
    return PROFILING_SUCCESS;
}

/*
 * @berif  : Collect HBM profiling data
 */
ProfHbmJob::ProfHbmJob()
{
    channelId_ = PROF_CHANNEL_HBM;
}
ProfHbmJob::~ProfHbmJob() {}

/*
 * @berif  : HBM Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfHbmJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_EVENT_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;

    if (collectionJobCfg_->comParams->params->hbmProfiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("HBM Profiling not enabled");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

/*
 * @berif  : HBM Peripheral Set Config to Driver
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfHbmJob::SetPeripheralConfig()
{
    samplePeriod_ = PERIPHERAL_INTERVAL_MS_MIN;
    if (collectionJobCfg_->comParams->params->hbmInterval >= PERIPHERAL_INTERVAL_MS_MIN &&
        collectionJobCfg_->comParams->params->hbmInterval <= PERIPHERAL_INTERVAL_MS_MAX) {
        samplePeriod_ = collectionJobCfg_->comParams->params->hbmInterval;
    }

    eventsStr_ = GetEventsStr(*(collectionJobCfg_->jobParams.events));
    const uint32_t configSize =
        sizeof(TagTsHbmProfileConfig) + (sizeof(uint32_t) * GetEventSize(*(collectionJobCfg_->jobParams.events)));
    CHECK_JOB_CONFIG_UNSIGNED_SIZE_RET(configSize, return PROFILING_FAILED);

    TagTsHbmProfileConfig *configP = static_cast<TagTsHbmProfileConfig *>(Utils::ProfMalloc(configSize));
    if (configP == nullptr) {
        MSPROF_LOGE("ProfHbmJob ProfMalloc TagTsHbmProfileConfig failed");
        return PROFILING_FAILED;
    }

    configP->period = samplePeriod_;
    configP->masterId = DEAFULT_MASTER_ID;

    for (uint32_t i = 0; i < static_cast<uint32_t>(collectionJobCfg_->jobParams.events->size()); i++) {
        if ((*collectionJobCfg_->jobParams.events)[i].compare("read") == 0) {
            configP->event[configP->eventNum++] = PERIPHERAL_EVENT_READ;
        } else if ((*collectionJobCfg_->jobParams.events)[i].compare("write") == 0) {
            configP->event[configP->eventNum++] = PERIPHERAL_EVENT_WRITE;
        } else {
            MSPROF_LOGW("HBM event:%s not support", (*collectionJobCfg_->jobParams.events)[i].c_str());
        }
    }

    peripheralCfg_.configP = configP;
    peripheralCfg_.configSize = configSize;
    return PROFILING_SUCCESS;
}

/*
 * @berif  : Collect Application Memory profiling data
 */
ProfAppMemJob::ProfAppMemJob()
{
    channelId_ = PROF_CHANNEL_NPU_APP_MEM;
}

ProfAppMemJob::~ProfAppMemJob() {}

/*
 * @berif  : Application Memory Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfAppMemJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->app.empty() ||
        collectionJobCfg_->comParams->params->memProfiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Application Memory not enabled.");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

/*
 * @berif  : Application Memory Peripheral Set Config to Driver
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfAppMemJob::SetPeripheralConfig()
{
    samplePeriod_ = collectionJobCfg_->comParams->params->memInterval;
    const uint32_t configSize = sizeof(TagMemProfileConfig);
    TagMemProfileConfig *configP = static_cast<TagMemProfileConfig *>(Utils::ProfMalloc(configSize));
    if (configP == nullptr) {
        MSPROF_LOGE("ProfAppMemJob ProfMalloc TagMemProfileConfig failed");
        return PROFILING_FAILED;
    }

    configP->period = samplePeriod_;
    configP->res1 = 0;
    configP->res2 = 0;
    configP->event = PERIPHERAL_EVENT_APP_MEM;

    peripheralCfg_.configP = configP;
    peripheralCfg_.configSize = configSize;
    return PROFILING_SUCCESS;
}

/*
 * @berif  : Collect Device Memory profiling data
 */
ProfDevMemJob::ProfDevMemJob()
{
    channelId_ = PROF_CHANNEL_NPU_MEM;
}

ProfDevMemJob::~ProfDevMemJob() {}

/*
 * @berif  : Device Memory Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfDevMemJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->memProfiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Device Memory not enabled");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

/*
 * @berif  : Device Memory Peripheral Set Config to Driver
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfDevMemJob::SetPeripheralConfig()
{
    samplePeriod_ = collectionJobCfg_->comParams->params->memInterval;
    uint32_t configSize = sizeof(TagMemProfileConfig);
    TagMemProfileConfig *configP = static_cast<TagMemProfileConfig *>(Utils::ProfMalloc(configSize));
    if (configP == nullptr) {
        MSPROF_LOGE("ProfDevMemJob ProfMalloc TagMemProfileConfig failed");
        return PROFILING_FAILED;
    }

    configP->period = samplePeriod_;
    configP->res1 = 0;
    configP->res2 = 0;
    configP->event = PERIPHERAL_EVENT_DEV_MEM;

    peripheralCfg_.configP = configP;
    peripheralCfg_.configSize = configSize;
    return PROFILING_SUCCESS;
}

/*
 * @berif  : Collect ai stack memory profiling data
 */
ProfAiStackMemJob::ProfAiStackMemJob()
{
    channelId_ = PROF_CHANNEL_AISTACK_MEM;
}

ProfAiStackMemJob::~ProfAiStackMemJob() {}

/*
 * @berif  : Ai stack Memory Peripheral Init profiling
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfAiStackMemJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->memProfiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("Ai stack Memory not enabled");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

/*
 * @berif  : Ai stack Memory Peripheral Set Config to Driver
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfAiStackMemJob::SetPeripheralConfig()
{
    samplePeriod_ = collectionJobCfg_->comParams->params->memInterval;
    const uint32_t configSize = sizeof(TagMemProfileConfig);
    TagMemProfileConfig *configP = static_cast<TagMemProfileConfig *>(Utils::ProfMalloc(configSize));
    if (configP == nullptr) {
        MSPROF_LOGE("ProfAiStackMemJob ProfMalloc TagMemProfileConfig failed");
        return PROFILING_FAILED;
    }

    configP->period = samplePeriod_;
    configP->res1 = 0;
    configP->res2 = 0;
    configP->event = 0;

    peripheralCfg_.configP = configP;
    peripheralCfg_.configSize = configSize;
    return PROFILING_SUCCESS;
}

/*
 * @berif  : Collect LLC profiling data
 */
ProfLlcJob::ProfLlcJob()
{
    channelId_ = PROF_CHANNEL_LLC;
}

ProfLlcJob::~ProfLlcJob() {}

/*
 * @berif  : LLC Peripheral Set Config to Driver
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfLlcJob::SetPeripheralConfig()
{
    samplePeriod_ = PERIPHERAL_INTERVAL_MS_MIN;
    if (collectionJobCfg_->comParams->params->llc_interval >= PERIPHERAL_INTERVAL_MS_MIN &&
        collectionJobCfg_->comParams->params->llc_interval <= PERIPHERAL_INTERVAL_MS_MAX) {
        samplePeriod_ = collectionJobCfg_->comParams->params->llc_interval;
    }

    eventsStr_ = GetEventsStr(*(collectionJobCfg_->jobParams.events));
    const uint32_t configSize = sizeof(TagLlcProfileConfig);
    TagLlcProfileConfig *configP = static_cast<TagLlcProfileConfig *>(Utils::ProfMalloc(configSize));
    if (configP == nullptr) {
        MSPROF_LOGE("ProfLlcJob ProfMalloc TagLlcProfileConfig failed");
        return PROFILING_FAILED;
    }

    configP->period = samplePeriod_;

    const uint32_t llcRead = 1;
    const uint32_t llcWrite = 2;
    for (uint32_t i = 0; i < static_cast<uint32_t>(collectionJobCfg_->jobParams.events->size()); i++) {
        if ((*collectionJobCfg_->jobParams.events)[i].compare("read") == 0) {
            configP->sampleType = llcRead;
        } else if ((*collectionJobCfg_->jobParams.events)[i].compare("write") == 0) {
            configP->sampleType = llcWrite;
        } else {
            MSPROF_LOGW("LLC event:%s not support", (*collectionJobCfg_->jobParams.events)[i].c_str());
        }
    }

    peripheralCfg_.configP = configP;
    peripheralCfg_.configSize = configSize;
    return PROFILING_SUCCESS;
}

bool ProfLlcJob::IsGlobalJobLevel()
{
    return false;
}

/*
 * @berif  : Collect qos data
 */
ProfQosJob::ProfQosJob()
{
    channelId_ = PROF_CHANNEL_QOS;
}

ProfQosJob::~ProfQosJob() {}

/*
 * @berif  : Qos profiling init
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfQosJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }

    collectionJobCfg_ = cfg;
    if (collectionJobCfg_->comParams->params->qosProfiling.compare(MSVP_PROF_ON) != 0 ||
        collectionJobCfg_->comParams->params->qosEventId.size() == 0) {
        MSPROF_LOGI("Qos profiling is not enabled.");
        return PROFILING_FAILED;
    }

    MSPROF_EVENT("Qos profiling is enabled.");
    return PROFILING_SUCCESS;
}

/*
 * @berif  : Qos set config
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfQosJob::SetPeripheralConfig()
{
    const uint32_t configSize = sizeof(QosProfileConfig);
    QosProfileConfig *configP = static_cast<QosProfileConfig *>(Utils::ProfMalloc(configSize));
    if (configP == nullptr) {
        MSPROF_LOGE("ProfQosJob ProfMalloc QosProfileConfig failed");
        return PROFILING_FAILED;
    }

    configP->period = collectionJobCfg_->comParams->params->hardware_mem_sampling_interval / US_CONVERT_MS;
    configP->streamNum = static_cast<uint16_t>(collectionJobCfg_->comParams->params->qosEventId.size());
    for (size_t i = 0; i < collectionJobCfg_->comParams->params->qosEventId.size(); i++) {
        configP->mpamId[i] = collectionJobCfg_->comParams->params->qosEventId[i];
    }
    peripheralCfg_.configP = configP;
    peripheralCfg_.configSize = configSize;
    return PROFILING_SUCCESS;
}
}
}
}