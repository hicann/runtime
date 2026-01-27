/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "bind_relation.h"
#include "fsm/error_state.h"
#include "entity.h"
#include "common/bqs_log.h"
#include "state_manager.h"

namespace dgw {
FsmStatus ErrorState::PreProcess(Entity &entity)
{
    DGW_LOG_RUN_INFO("[FSM] Entity id:[%u] type:[%s] state:[%s] desc:[%s].",
        entity.GetId(), entity.GetTypeDesc().c_str(),
        entity.GetStateDesc(FsmState::FSM_ERROR_STATE).c_str(), entity.ToString().c_str());
    ProcessAbnormalEntity(entity);
    return FsmStatus::FSM_ERROR;
}

FsmStatus ErrorState::ProcessMessage(Entity &entity, const InnerMessage &msg)
{
    DGW_LOG_INFO("[FSM] Entity id:[%u] type:[%s] state:[%s] msg:[%s] desc:[%s].",
        entity.GetId(), entity.GetTypeDesc().c_str(), entity.GetStateDesc(FsmState::FSM_ERROR_STATE).c_str(),
        GetMsgDesc(msg), entity.ToString().c_str());
    if (msg.msgType == InnerMsgType::INNER_MSG_RECOVER) {
        return PostProcess(entity);
    }
    // discard the data
    auto &recvDataObjs = entity.GetRecvDataObjs();
    while (!recvDataObjs.empty()) {
        const auto dataObj = recvDataObjs.front();
        if ((dataObj != nullptr) && (dataObj->GetSendEntity() != nullptr)) {
            Mbuf * const mbuf = const_cast<Mbuf *>(dataObj->GetMbuf());
            if (!dataObj->CopRef()) {
                // fail discard
                (void)halMbufFree(mbuf);
                DGW_LOG_INFO("Success to free mbuf for entity[%s] with state[%s].",
                    entity.ToString().c_str(), entity.GetStateDesc(FsmState::FSM_ERROR_STATE).c_str());
            }
            (void) dataObj->GetSendEntity()->RemoveDataObjFromSendList(dataObj);
        }
        recvDataObjs.pop_front();
    }
    ProcessAbnormalEntity(entity);
    return FsmStatus::FSM_ERROR;
}

FsmStatus ErrorState::PostProcess(Entity &entity)
{
    DGW_LOG_INFO("[FSM] Entity id:[%u] type:[%s] state:[%s] desc:[%s].",
        entity.GetId(), entity.GetTypeDesc().c_str(),
        entity.GetStateDesc(FsmState::FSM_ERROR_STATE).c_str(), entity.ToString().c_str());
    return entity.ChangeState(FsmState::FSM_PUSH_STATE);
}

void ErrorState::ProcessAbnormalEntity(Entity &entity) const
{
    auto &bindRelationObj = bqs::BindRelation::GetInstance();
    bqs::OptionalArg args = {};
    args.eType = entity.GetType();
    args.queueType = entity.GetQueueType();
    bqs::EntityInfo entityInfo(entity.GetId(), entity.GetDeviceId(), &args);
    bindRelationObj.AppendAbnormalEntity(entityInfo, entity.GetDirection(), entity.GetResIndex());
}

REGISTER_STATE(FSM_ERROR_STATE, ENTITY_QUEUE, ErrorState);
REGISTER_STATE(FSM_ERROR_STATE, ENTITY_TAG, ErrorState);
REGISTER_STATE(FSM_ERROR_STATE, ENTITY_GROUP, ErrorState);
}  // namespace dgw
