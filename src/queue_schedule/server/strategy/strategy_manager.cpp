/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "strategy_manager.h"
#include "common/bqs_log.h"

namespace dgw {
namespace {
    const std::string UNKNOWN_POLICY = "";
}
StrategyManager &StrategyManager::GetInstance()
{
    static StrategyManager instance;
    return instance;
}

void StrategyManager::RegisterStrategy(const bqs::GroupPolicy policy,
                                       Strategy * strategy,
                                       const char_t * const strategyDesc)
{
    // Overwrite old when repeating
    strategy_[policy] = strategy;
    strategyDesc_[policy] = strategyDesc;
}

Strategy *StrategyManager::GetStrategy(const bqs::GroupPolicy policy) const
{
    const auto iter = strategy_.find(policy);
    if (iter != strategy_.end()) {
        return iter->second;
    }
    DGW_LOG_ERROR("[FSM] Failed policy:%d.", static_cast<int32_t>(policy));
    return nullptr;
}

const std::string &StrategyManager::GetStrategyDesc(const bqs::GroupPolicy policy) const
{
    const auto iter = strategyDesc_.find(policy);
    if (iter != strategyDesc_.end()) {
        return iter->second;
    }
    DGW_LOG_ERROR("[FSM] Failed policy:%d.", static_cast<int32_t>(policy));
    return UNKNOWN_POLICY;
}
}  // namespace dgw