/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_comm_job.h"
#include <fstream>
#include <iostream>
#include <sstream>

#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "json_parser.h"
#include "prof_channel_manager.h"
#include "securec.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;
using namespace Msprofiler::Parser;

ProfDrvJob::ProfDrvJob()
{
}
ProfDrvJob::~ProfDrvJob()
{
}

void ProfDrvJob::AddReader(const std::string &key, int32_t devId, AI_DRV_CHANNEL channelId, const std::string &filePath)
{
    std::string relativePath;
    (void)analysis::dvvp::common::utils::Utils::RelativePath(filePath,
        collectionJobCfg_->comParams->tmpResultDir,
        relativePath);

    SHARED_PTR_ALIA<ChannelReader> reader;
    MSVP_MAKE_SHARED4(reader, ChannelReader, devId, channelId,
        relativePath, collectionJobCfg_->comParams->jobCtx, return);
    int32_t ret = reader->Init();
    if (ret != PROFILING_SUCCESS) {
        return;
    }
    SHARED_PTR_ALIA<ChannelPoll> poll = ProfChannelManager::instance()->GetChannelPoller();
    if (poll != nullptr) {
        (void)poll->AddReader(devId, channelId, reader);
    } else {
        MSPROF_LOGI("ProfDrvJob AddReader failed, key:%s, devId:%d, channel:%d, filepath:%s",
                    key.c_str(), devId, channelId, Utils::BaseName(filePath).c_str());
    }
}

void ProfDrvJob::RemoveReader(const std::string &key, int32_t devId, AI_DRV_CHANNEL channelId) const
{
    MSPROF_LOGI("ProfDrvJob RemoveReader, key:%s, devId:%d, channel:%d", key.c_str(), devId, channelId);
    SHARED_PTR_ALIA<ChannelPoll> poll = ProfChannelManager::instance()->GetChannelPoller();
    if (poll != nullptr) {
        (void)poll->RemoveReader(devId, channelId);
    }
}

uint32_t ProfDrvJob::GetEventSize(const std::vector<std::string> &events) const
{
    uint32_t eventSize = 0;
    for (size_t i = 0; i < events.size(); i++) {
        if ((events[i].compare("read") == 0) || (events[i].compare("write") == 0)) {
            eventSize++;
        }
    }
    return eventSize;
}

std::string ProfDrvJob::GetEventsStr(const std::vector<std::string> &events,
    const std::string &separator /* = "," */) const
{
    analysis::dvvp::common::utils::UtilsStringBuilder<std::string> builder;

    return builder.Join(events, separator);
}

std::string ProfDrvJob::GenerateFileName(const std::string &fileName, int32_t devId) const
{
    std::stringstream ssProfDataFilePath;

    ssProfDataFilePath << fileName;
    ssProfDataFilePath << ".";
    ssProfDataFilePath << devId;

    return ssProfDataFilePath.str();
}

std::string ProfDrvJob::BindFileWithChannel(const std::string &fileName) const
{
    std::stringstream ssProfDataFilePath;

    ssProfDataFilePath << fileName;

    return ssProfDataFilePath.str();
}

/*
 * @berif  : Collect Peripheral profiling data
 */
ProfPeripheralJob::ProfPeripheralJob()
    : samplePeriod_(analysis::dvvp::common::config::DEFAULT_INTERVAL),
      channelId_(PROF_CHANNEL_UNKNOWN) {}

ProfPeripheralJob::~ProfPeripheralJob() {}

/*
 * @berif  : Collect Peripheral profiling data Default Init
 * @param  : cfg : Collect data config information
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfPeripheralJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);
    if (cfg->comParams->params->hostProfiling) {
        return PROFILING_FAILED;
    }
    collectionJobCfg_ = cfg;
    return PROFILING_SUCCESS;
}

/*
 * @berif  : Collect Peripheral profiling Set Default peripheral Config
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 */
int32_t ProfPeripheralJob::SetPeripheralConfig()
{
    peripheralCfg_.configP    = nullptr;
    peripheralCfg_.configSize = 0;
    return PROFILING_SUCCESS;
}

/*
 * @berif  : Collect Peripheral start profiling with default
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 *
 */
int32_t ProfPeripheralJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            static_cast<int32_t>(channelId_));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGI("Begin to start profiling Channel %d, events:%s",
        static_cast<int32_t>(channelId_), eventsStr_.c_str());
    peripheralCfg_.profDataFilePath = BindFileWithChannel(collectionJobCfg_->jobParams.dataPath);
    int32_t ret = SetPeripheralConfig();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("ProfPeripheralJob SetPeripheralConfig failed");
        return ret;
    }

    AddReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_,
        peripheralCfg_.profDataFilePath);

    MSPROF_LOGI("begin to start profiling Channel %d, devId :%d",
        static_cast<int32_t>(channelId_), collectionJobCfg_->comParams->devIdOnHost);

    peripheralCfg_.profDeviceId     = collectionJobCfg_->comParams->devId;
    peripheralCfg_.profChannel      = channelId_;
    peripheralCfg_.bufLen = JsonParser::instance()->GetJsonChannelDriverBufferLen(channelId_);
    int32_t peroid = JsonParser::instance()->GetJsonChannelPeroid(channelId_);
    if (peroid != 0) {
        peripheralCfg_.profSamplePeriod = peroid;
    } else {
        peripheralCfg_.profSamplePeriod = samplePeriod_;
    }
    peripheralCfg_.profDataFile = "";
    ret = DrvPeripheralStart(peripheralCfg_);
    MSPROF_LOGI("start profiling Channel %d, events:%s, ret=%d",
        static_cast<int32_t>(channelId_), eventsStr_.c_str(), ret);

    Utils::ProfFree(peripheralCfg_.configP);
    peripheralCfg_.configP = nullptr;

    FUNRET_CHECK_RET_VAL(ret != PROFILING_SUCCESS);
    return ret;
}

/*
 * @berif  : Collect Peripheral stop profiling with default
 * @param  : None
 * @return : PROFILING_FAILED(-1) : failed
 *         : PROFILING_SUCCESS(0) : success
 *
 */
int32_t ProfPeripheralJob::Uninit()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_SUCCESS);
    if (!DrvChannelsMgr::instance()->ChannelIsValid(collectionJobCfg_->comParams->devId, channelId_)) {
        MSPROF_LOGW("Channel is invalid, devId:%d, channelId:%d", collectionJobCfg_->comParams->devId,
            static_cast<int32_t>(channelId_));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGI("begin to stop profiling Channel %d data", static_cast<int32_t>(channelId_));
    if (!peripheralCfg_.startSuccess) {
        MSPROF_LOGI("stop profiling Channel %d data which isn't starting.", static_cast<int32_t>(channelId_));
        return PROFILING_SUCCESS;
    }

    const int32_t ret = DrvStop(collectionJobCfg_->comParams->devId, channelId_);
    MSPROF_LOGI("stop profiling Channel %d data, ret=%d", static_cast<int32_t>(channelId_), ret);

    RemoveReader(collectionJobCfg_->comParams->params->job_id, collectionJobCfg_->comParams->devId, channelId_);
    return PROFILING_SUCCESS;
}
}
}
}