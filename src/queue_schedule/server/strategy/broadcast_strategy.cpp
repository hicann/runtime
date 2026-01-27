/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "strategy/broadcast_strategy.h"
#include "dgw_client.h"
#include "common/bqs_log.h"
#include "entity_manager.h"
#include "strategy/strategy_manager.h"

namespace dgw {
FsmStatus BroadcastStrategy::Search(const uint32_t groupId, const uint64_t transId, std::vector<EntityPtr> &selEntities,
    const uint32_t resIndex)
{
    const std::vector<EntityPtr> &entitiesInGroup = EntityManager::Instance(resIndex).GetEntitiesInGroup(groupId);
    if (entitiesInGroup.empty()) {
        DGW_LOG_ERROR("No entities in group, groupId:%u, transId:%lu", groupId, transId);
        return FsmStatus::FSM_FAILED;
    }
    selEntities.assign(entitiesInGroup.begin(), entitiesInGroup.end());
    return FsmStatus::FSM_SUCCESS;
}

REGISTER_STRATEGY(BROADCAST, BroadcastStrategy);
}