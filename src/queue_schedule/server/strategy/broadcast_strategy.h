/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_BROADCAST_STRATEGY_H
#define DGW_BROADCAST_STRATEGY_H

#include "strategy/strategy.h"

namespace dgw {
class BroadcastStrategy : public Strategy {
public:
    explicit BroadcastStrategy() = default;
    ~BroadcastStrategy() override = default;
public:
    /**
     * broadcast search strategy
     * @param groupId group id
     * @param transId transaction id
     * @param selEntities selected entities from group
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus Search(const uint32_t groupId, const uint64_t transId, std::vector<EntityPtr> &selEntities,
        const uint32_t resIndex) override;
};
}
#endif