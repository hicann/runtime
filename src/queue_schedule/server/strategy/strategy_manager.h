/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_STRATEGY_MANAGER_H
#define DGW_STRATEGY_MANAGER_H

#include <map>
#include "common/type_def.h"
#include "dgw_client.h"
#include "strategy.h"

namespace dgw {

class StrategyManager {
public:
    explicit StrategyManager() = default;
    ~StrategyManager() = default;

    StrategyManager(const StrategyManager &) = delete;
    StrategyManager(const StrategyManager &&) = delete;
    StrategyManager &operator = (const StrategyManager &) = delete;
    StrategyManager &operator = (StrategyManager &&) = delete;

public:
    static StrategyManager &GetInstance();
    void RegisterStrategy(const bqs::GroupPolicy policy,
                          Strategy*  strategy,
                          const char_t * const strategyDesc);
    Strategy *GetStrategy(const bqs::GroupPolicy policy) const;
    const std::string &GetStrategyDesc(const bqs::GroupPolicy policy) const;

private:
    std::map<bqs::GroupPolicy, Strategy*> strategy_;
    std::map<bqs::GroupPolicy, std::string> strategyDesc_;
};

// strategy register
class StrategyRegister {
public:
    StrategyRegister(const bqs::GroupPolicy policy, Strategy * strategy, const char_t * const strategyDesc)
    {
        StrategyManager::GetInstance().RegisterStrategy(policy, strategy, strategyDesc);
    }

    ~StrategyRegister() = default;
    StrategyRegister(const StrategyRegister &) = delete;
    StrategyRegister(const StrategyRegister &&) = delete;
    StrategyRegister &operator = (const StrategyRegister &) = delete;
    StrategyRegister &operator = (StrategyRegister &&) = delete;
};

#define REGISTER_STRATEGY(policy, strategy)       \
    strategy g_##strategy;                        \
    StrategyRegister g_##strategy##_register(bqs::GroupPolicy::policy, &g_##strategy, #policy)
}
#endif