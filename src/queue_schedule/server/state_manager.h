/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_STATE_MANAGER_H
#define QUEUE_STATE_MANAGER_H

#include <list>
#include <map>
#include <string>
#include "fsm/state_define.h"
#include "fsm/state_base.h"

namespace dgw {
class StateManager {
public:
    explicit StateManager() = default;

    ~StateManager() = default;

    StateManager(const StateManager &) = delete;
    StateManager(const StateManager &&) = delete;
    StateManager &operator = (const StateManager &) = delete;
    StateManager &operator = (StateManager &&) = delete;

public:
    static StateManager &Instance();

    void RegisterState(const FsmState id, const EntityType eType, const StateBase *const state,
                       const char_t * const idDesc, const char_t * const typeDesc);
    StateBase *GetState(const FsmState id, const EntityType eType) const;
    const std::string &GetStateDesc(const FsmState id, const EntityType eType);
    const std::string &GetTypeDesc(const EntityType eType);

private:
    StateBase *state_[static_cast<size_t>(EntityType::ENTITY_INVALID)]
        [static_cast<size_t>(FsmState::FSM_INVALID_STATE)] = {{nullptr}};
    std::string stateDesc_[static_cast<size_t>(EntityType::ENTITY_INVALID)]
        [static_cast<size_t>(FsmState::FSM_INVALID_STATE)] = {{""}};
    std::string typeDesc_[static_cast<size_t>(EntityType::ENTITY_INVALID)] = {""};
};

// state registerar
class StateRegisterar {
public:
    StateRegisterar(const FsmState id, const EntityType eType, const StateBase *const state, const char_t *const idDesc,
                    const char_t *const typeDesc) noexcept
    {
        StateManager::Instance().RegisterState(id, eType, state, idDesc, typeDesc);
    }

    ~StateRegisterar() = default;
    StateRegisterar(const StateRegisterar &) = delete;
    StateRegisterar(const StateRegisterar &&) = delete;
    StateRegisterar &operator = (const StateRegisterar &) = delete;
    StateRegisterar &operator = (StateRegisterar &&) = delete;
};

#define REGISTER_STATE(id, type, state)                               \
    static const state g_##state##_##type;                                         \
    static const StateRegisterar g_##state##_##type##_Register(FsmState::id, EntityType::type, \
                                                               &g_##state##_##type, #id, #type)
}

#endif
