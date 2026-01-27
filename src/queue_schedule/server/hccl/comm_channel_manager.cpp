/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hccl/comm_channel_manager.h"

namespace dgw {
    CommChannelManager &CommChannelManager::GetInstance()
    {
        static CommChannelManager instance;
        return instance;
    }

    uint32_t CommChannelManager::GetCommChannelId(const CommChannel &channel, const CommChannel *&channelPtr)
    {
        const std::lock_guard<std::mutex> commChannelLock(commChannelMapMutex_);
        const auto iter = commChannelMap_.find(channel);
        if (iter != commChannelMap_.end()) {
            channelPtr = &(iter->first);
            return iter->second;
        }
        // generate channel id
        static uint32_t channelId = 0U;
        const auto result = commChannelMap_.emplace(std::make_pair(channel, channelId));
        channelPtr = &(result.first->first);
        return channelId++;
    }

    FsmStatus CommChannelManager::DeleteCommChannel(const CommChannel &channel)
    {
        const std::lock_guard<std::mutex> commChannelLock(commChannelMapMutex_);
        const auto iter = commChannelMap_.find(channel);
        if (iter == commChannelMap_.end()) {
            BQS_LOG_WARN("Not find channel[%s] in commChannelMap_.", channel.ToString().c_str());
            return FsmStatus::FSM_SUCCESS;
        }
        (void)commChannelMap_.erase(iter);
        return FsmStatus::FSM_SUCCESS;
    }
}