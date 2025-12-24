/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DVVP_COLLECT_JOB_WRAPPER_STARS_NANO_PROFILE_H
#define DVVP_COLLECT_JOB_WRAPPER_STARS_NANO_PROFILE_H
#include "channel_job.h"
namespace Dvvp {
namespace Collect {
namespace JobWrapper {
constexpr uint8_t NANO_PMU_EVENT_MAX_NUM = 10;
struct TagNanoStarsProfileConfig {
    uint32_t tag = 0;                                  // 0-enable immediately, 1-enable delay
    uint32_t eventNum = 0;                             // PMU count
    uint16_t event[NANO_PMU_EVENT_MAX_NUM] = {0};      // PMU value
};
class NanoStarsProfile : public ChannelJob {
public:
    NanoStarsProfile()
        : ChannelJob(static_cast<uint32_t>(
        analysis::dvvp::driver::AI_DRV_CHANNEL::PROF_CHANNEL_STARS_NANO_PROFILE),
        "nano_stars_profile.data") {}
    ~NanoStarsProfile() override {}
    int32_t Init(const SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;
    void PackPmuParam(TagNanoStarsProfileConfig &config) const;
};
}
}
}
#endif
