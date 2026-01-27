/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "fsm/full_state.h"
#include "entity_manager.h"
#include "data_obj_manager.h"
#include "common/bqs_log.h"
#include "state_manager.h"

namespace dgw {
FsmStatus FullState::PreProcess(Entity &entity)
{
    DGW_LOG_INFO("[FSM] Entity id:[%u] type:[%s] state:[%s] desc:[%s].",
        entity.GetId(), entity.GetTypeDesc().c_str(),
        entity.GetStateDesc(FsmState::FSM_FULL_STATE).c_str(), entity.ToString().c_str());
    dgw::EntityManager::Instance(entity.GetResIndex()).SetExistFullEntity();
    auto &recvDataObjs = entity.GetRecvDataObjs();
    if (dgw::EntityManager::Instance(entity.GetResIndex()).ShouldPauseSubscirpiton()) {
        for (const auto &dataObj : recvDataObjs) {
            auto const sendEntity = dataObj->GetSendEntity();
            if (sendEntity != nullptr) {
                (void)sendEntity->PauseSubscribe(entity);
            }
        }
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus FullState::ProcessMessage(Entity &entity, const InnerMessage &msg)
{
    if (msg.msgType == InnerMsgType::INNER_MSG_PUSH) {
        return FsmStatus::FSM_SUCCESS;
    } else if (msg.msgType == InnerMsgType::INNER_MSG_F2NF) {
        entity.SetMessageType(msg.msgType);
        return PostProcess(entity);
    } else {
        return FsmStatus::FSM_SUCCESS;
    }
}

FsmStatus FullState::PostProcess(Entity &entity)
{
    return entity.ChangeState(FsmState::FSM_PUSH_STATE);
}

REGISTER_STATE(FSM_FULL_STATE, ENTITY_QUEUE, FullState);
REGISTER_STATE(FSM_FULL_STATE, ENTITY_TAG, FullState);
}  // namespace dgw
