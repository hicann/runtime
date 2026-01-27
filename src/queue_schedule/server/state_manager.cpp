/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "state_manager.h"
#include "common/bqs_log.h"
#include "fsm/state_define.h"

namespace dgw {
StateManager &StateManager::Instance()
{
    static StateManager instance;
    return instance;
}

void StateManager::RegisterState(const FsmState id, const EntityType eType, const StateBase *const state,
                                 const char_t * const idDesc, const char_t * const typeDesc)
{
    // Overwrite old when repeating
    state_[static_cast<size_t>(eType)][static_cast<size_t>(id)] = const_cast<StateBase *>(state);
    stateDesc_[static_cast<size_t>(eType)][static_cast<size_t>(id)] = idDesc;
    typeDesc_[static_cast<size_t>(eType)]= typeDesc;
}

StateBase *StateManager::GetState(const FsmState id, const EntityType eType) const
{
    auto state = state_[static_cast<size_t>(eType)][static_cast<size_t>(id)];
    if (state == nullptr) {
        DGW_LOG_ERROR("[FSM] Failed id:%d eType:%d.", id, eType);
    }
    return state;
}

const std::string &StateManager::GetStateDesc(const FsmState id, const EntityType eType)
{
    return stateDesc_[static_cast<size_t>(eType)][static_cast<size_t>(id)];
}

const std::string &StateManager::GetTypeDesc(const EntityType eType)
{
    return typeDesc_[static_cast<size_t>(eType)];
}
}  // namespace dgw
