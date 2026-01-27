/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "schedule_config.h"

namespace dgw {

ScheduleConfig &ScheduleConfig::GetInstance()
{
    static ScheduleConfig schedCfg;
    return schedCfg;
}

void ScheduleConfig::RecordConfig(
    const uint32_t key, const bqs::DynamicSchedQueueAttr &requestQ, const bqs::DynamicSchedQueueAttr &responseQ)
{
    schedKeys_.insert(key);
    configMap_[key] = std::make_pair(requestQ, responseQ);
}

const std::unordered_set<uint32_t> &ScheduleConfig::GetSchedKeys() const
{
    return schedKeys_;
}

void ScheduleConfig::StopSched(const uint32_t key)
{
    stoppedSchedKeys_.insert(key);
}

void ScheduleConfig::RestartSched(const uint32_t key)
{
    stoppedSchedKeys_.erase(key);
}

const bool ScheduleConfig::IsStopped(const uint32_t key) const
{
    return stoppedSchedKeys_.count(key) > 0U;
}
}