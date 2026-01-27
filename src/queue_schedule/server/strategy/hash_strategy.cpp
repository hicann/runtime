/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "strategy/hash_strategy.h"
#include "dgw_client.h"
#include "common/bqs_log.h"
#include "entity_manager.h"
#include "strategy/strategy_manager.h"

namespace dgw {
FsmStatus HashStrategy::Search(const uint32_t groupId, const uint64_t transId, std::vector<EntityPtr> &selEntities,
    const uint32_t resIndex)
{
    const std::vector<EntityPtr> &entitiesInGroup = EntityManager::Instance(resIndex).GetEntitiesInGroup(groupId);
    if (entitiesInGroup.empty()) {
        DGW_LOG_ERROR("No entities in group, groupId:%u, transId:%lu", groupId, transId);
        return FsmStatus::FSM_FAILED;
    }
    if (transId == 0UL) {
        DGW_LOG_ERROR("transId is invalid, transId:%lu", transId);
        return FsmStatus::FSM_FAILED;
    }

    const uint64_t idx = transId % entitiesInGroup.size();
    auto &selEntity = entitiesInGroup[idx];
    selEntities.push_back(selEntity);
    DGW_LOG_DEBUG("Select entity id:%u type:%s from group:%u success, index:%lu.",
        selEntity->GetId(), selEntity->GetTypeDesc().c_str(), groupId, idx);
    return FsmStatus::FSM_SUCCESS;
}

REGISTER_STRATEGY(HASH, HashStrategy);
}