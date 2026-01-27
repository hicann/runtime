/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "fsm/wait_push_state.h"
#include "common/bqs_log.h"
#include "entity.h"
#include "state_manager.h"

namespace dgw {
FsmStatus WaitPushState::PreProcess(Entity &entity)
{
    DGW_LOG_INFO("[FSM] Entity id:[%u] type:[%s] state:[%s] desc:[%s].",
        entity.GetId(), entity.GetTypeDesc().c_str(),
        entity.GetStateDesc(FsmState::FSM_WAIT_PUSH_STATE).c_str(), entity.ToString().c_str());
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus WaitPushState::ProcessMessage(Entity &entity, const InnerMessage &msg)
{
    if (msg.msgType == InnerMsgType::INNER_MSG_PUSH) {
        return PostProcess(entity);
    }

    DGW_LOG_INFO("[FSM] Entity id:[%u] type:[%s] state:[%s] desc:[%s] ignore msg:[%s].", entity.GetId(),
        entity.GetTypeDesc().c_str(), entity.GetStateDesc(FsmState::FSM_WAIT_PUSH_STATE).c_str(),
        entity.ToString().c_str(), GetMsgDesc(msg));
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus WaitPushState::PostProcess(Entity &entity)
{
    return entity.ChangeState(FsmState::FSM_PUSH_STATE);
}

REGISTER_STATE(FSM_WAIT_PUSH_STATE, ENTITY_QUEUE, WaitPushState);
REGISTER_STATE(FSM_WAIT_PUSH_STATE, ENTITY_TAG, WaitPushState);
REGISTER_STATE(FSM_WAIT_PUSH_STATE, ENTITY_GROUP, WaitPushState);
}  // namespace dgw
