/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SCHEDULE_CONFIG_H
#define SCHEDULE_CONFIG_H

#include <unordered_map>
#include <unordered_set>
#include "dgw_client.h"

namespace dgw {

class ScheduleConfig {
public:
    explicit ScheduleConfig() = default;
    virtual ~ScheduleConfig() = default;
    static ScheduleConfig &GetInstance();

    void RecordConfig(const uint32_t key, const bqs::DynamicSchedQueueAttr &requestQ,
        const bqs::DynamicSchedQueueAttr &responseQ);

    const std::unordered_set<uint32_t> &GetSchedKeys() const;

    void StopSched(const uint32_t key);

    void RestartSched(const uint32_t key);

    const bool IsStopped(const uint32_t key) const;
    
private:
    std::unordered_set<uint32_t> schedKeys_;
    std::unordered_set<uint32_t> stoppedSchedKeys_;
    std::unordered_map<uint32_t, std::pair<bqs::DynamicSchedQueueAttr, bqs::DynamicSchedQueueAttr>> configMap_;
};
}

#endif