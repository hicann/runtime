/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_PROF_CHANNEL_MANAGER_H
#define ANALYSIS_DVVP_PROF_CHANNEL_MANAGER_H

#include <mutex>
#include "singleton/singleton.h"
#include "transport/prof_channel.h"


namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
class ProfChannelManager : public analysis::dvvp::common::singleton::Singleton<ProfChannelManager> {
    friend analysis::dvvp::common::singleton::Singleton<ProfChannelManager>;
public:
    ProfChannelManager();
    ~ProfChannelManager() override;
    int32_t Init();
    void UnInit(bool isReset = false);
    SHARED_PTR_ALIA<analysis::dvvp::transport::ChannelPoll> GetChannelPoller();
    void FlushChannel();

private:
    SHARED_PTR_ALIA<analysis::dvvp::transport::ChannelPoll> drvChannelPoll_;
    std::mutex channelPollMutex_;
    uint64_t index_;
};
}}}

#endif