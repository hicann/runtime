/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_channel_manager.h"
#include "errno/error_code.h"
#include "transport/prof_channel.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;

ProfChannelManager::ProfChannelManager()
    : index_(0)
{
}

ProfChannelManager::~ProfChannelManager()
{
}

int32_t ProfChannelManager::Init()
{
    std::lock_guard<std::mutex> lock(channelPollMutex_);
    index_++;
    MSPROF_LOGI("ProfChannelManager Init index:%" PRIu64, index_);
    if (drvChannelPoll_ != nullptr) {
        MSPROF_LOGI("ProfChannelManager already inited");
        return PROFILING_SUCCESS;
    }
    MSVP_MAKE_SHARED0(drvChannelPoll_, ChannelPoll, return PROFILING_FAILED);
    int32_t ret = drvChannelPoll_->Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGI("drvChannelPoll start thread pool failed");
        return ret;
    }
    MSPROF_LOGI("Init Poll Succ");
    return PROFILING_SUCCESS;
}

SHARED_PTR_ALIA<ChannelPoll> ProfChannelManager::GetChannelPoller()
{
    std::lock_guard<std::mutex> lock(channelPollMutex_);
    return drvChannelPoll_;
}

void ProfChannelManager::UnInit(bool isReset)
{
    std::lock_guard<std::mutex> lock(channelPollMutex_);
    MSPROF_LOGI("ProfChannelManager UnInit index:%" PRIu64, index_);
    if (!isReset) {
        if (index_ == 0) {
            return;
        }
        index_--;
        if (index_ != 0) {
            return;
        }
    } else {
        index_ = 0;
    }
    if (drvChannelPoll_ != nullptr) {
        int32_t ret = drvChannelPoll_->Stop();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("drvChannelPoll_ stop failed");
        }
        drvChannelPoll_.reset();
        drvChannelPoll_ = nullptr;
    }

    MSPROF_LOGI("UnInit Poll Succ");
}

void ProfChannelManager::FlushChannel()
{
    if (drvChannelPoll_ != nullptr) {
        drvChannelPoll_->FlushDrvBuff();
    }
}
}}}