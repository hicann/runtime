/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "channel_job.h"
#include "prof_channel_manager.h"

namespace Dvvp {
namespace Collect {
namespace JobWrapper {
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::JobWrapper;
ChannelJob::ChannelJob()
{
}
ChannelJob::ChannelJob(int32_t collectionId, const std::string &name)
    : ICollectionJob(collectionId, name)
{
}

ChannelJob::~ChannelJob()
{
}

int32_t ChannelJob::ChannelStart(int32_t devId, int32_t channelId, const ProfChannelParam &param) const
{
    MSPROF_EVENT("Begin to start channel profiling, profDeviceId=%d, profChannel=%d",
        devId, channelId);
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = param.period;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = param.userData;
    profStartPara.user_data_size = param.dataSize;
    auto ret = prof_drv_start(devId, channelId, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start channel profiling, profDeviceId=%d, profChannel=%d, ret=%d",
            devId, channelId, ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling channel profiling, profDeviceId=%d, profChannel=%d",
        devId, channelId);
    return PROFILING_SUCCESS;
}

void ChannelJob::AddReader(int32_t devId, int32_t channelId, const std::string &filePath)
{
    SHARED_PTR_ALIA<ChannelReader> reader;
    MSVP_MAKE_SHARED4(reader, ChannelReader, devId, static_cast<AI_DRV_CHANNEL>(channelId),
        filePath, cfg_->comParams->jobCtx, return);
    auto ret = reader->Init();
    if (ret != PROFILING_SUCCESS) {
        return;
    }
    SHARED_PTR_ALIA<ChannelPoll> poll = ProfChannelManager::instance()->GetChannelPoller();
    if (poll != nullptr) {
        (void)poll->AddReader(devId, channelId, reader);
    } else {
        MSPROF_LOGI("Channel job add reader failed, devId:%d, channel:%d, filepath:%s",
                    devId, channelId, Utils::BaseName(filePath).c_str());
    }
}

void ChannelJob::RemoveReader(int32_t devId, int32_t channelId) const
{
    MSPROF_LOGI("Channel job remove reader, devId:%d, channel:%d", devId, channelId);
    SHARED_PTR_ALIA<ChannelPoll> poll = ProfChannelManager::instance()->GetChannelPoller();
    if (poll != nullptr) {
        (void)poll->RemoveReader(devId, channelId);
    }
}
}
}
}
