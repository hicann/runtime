/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "fsm/peek_state.h"
#include "common/bqs_log.h"
#include "entity.h"
#include "state_manager.h"
namespace dgw {

FsmStatus PeekState::PreProcess(Entity &entity)
{
    DGW_LOG_INFO("[FSM] Entity id:[%u] type:[%s] state:[%s] desc:[%s].",
        entity.GetId(), entity.GetTypeDesc().c_str(),
        entity.GetStateDesc(FsmState::FSM_PEEK_STATE).c_str(), entity.ToString().c_str());
    FsmStatus status = entity.Dequeue();
    if (status == FsmStatus::FSM_FAILED) {
        return entity.ChangeState(FsmState::FSM_IDLE_STATE);
    } else if (status == FsmStatus::FSM_KEEP_STATE) {
        return FsmStatus::FSM_SUCCESS;
    } else if (status == FsmStatus::FSM_ERROR_PENDING) {
        return entity.ChangeState(FsmState::FSM_ERROR_STATE);
    } else {
        return PostProcess(entity);
    }
}

FsmStatus PeekState::ProcessMessage(Entity &entity, const InnerMessage &msg)
{
    (void)msg;
    // deque and schedule next data
    return PreProcess(entity);
}

FsmStatus PeekState::PostProcess(Entity &entity)
{
    // entity in group not need change to TRY_PUSH state, group need change to TRY_PUSH state
    if (entity.GetHostGroupId() != -1) {
        // keep current PEEK state
        return FsmStatus::FSM_SUCCESS;
    }

    entity.ResetSrcSubState();
    // change to TRY_PUSH state
    return entity.ChangeState(FsmState::FSM_TRY_PUSH_STATE);
}

FsmStatus GroupPeekState::PostProcess(Entity &entity)
{
    // change to TRY_PUSH state
    return entity.ChangeState(FsmState::FSM_TRY_PUSH_STATE);
}

REGISTER_STATE(FSM_PEEK_STATE, ENTITY_QUEUE, PeekState);
REGISTER_STATE(FSM_PEEK_STATE, ENTITY_TAG, PeekState);
REGISTER_STATE(FSM_PEEK_STATE, ENTITY_GROUP, GroupPeekState);
}  // namespace dgw