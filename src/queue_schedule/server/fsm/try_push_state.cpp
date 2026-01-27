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
#include "common/bqs_log.h"
#include "fsm/try_push_state.h"
#include "profile_manager.h"
#include "state_manager.h"

namespace dgw {
FsmStatus TryPushState::PreProcess(Entity &entity)
{
    DGW_LOG_INFO("[FSM] Entity id:[%u] type:[%s] state:[%s] desc:[%s].",
        entity.GetId(), entity.GetTypeDesc().c_str(),
        entity.GetStateDesc(FsmState::FSM_TRY_PUSH_STATE).c_str(), entity.ToString().c_str());

    // use entity to find routes
    bqs::OptionalArg args = {};
    args.eType = entity.GetType();
    args.queueType = entity.GetQueueType();
    bqs::EntityInfo entityInfo(entity.GetId(), entity.GetDeviceId(), &args);
    // get ordered subscribe queue
    auto &srcToDstRelation = (entity.GetResIndex() == 0U) ? bqs::BindRelation::GetInstance().GetSrcToDstRelation() :
        bqs::BindRelation::GetInstance().GetSrcToDstExtraRelation();
    bqs::ProfileManager::GetInstance(entity.GetResIndex()).
        SetSrcQueueNum(static_cast<uint32_t>(srcToDstRelation.size()));
    const auto iter = srcToDstRelation.find(entityInfo);
    if (iter == srcToDstRelation.end()) {
        DGW_LOG_WARN("Can't find dst entities for entity:%u", entity.GetId());
        return PostProcess(entity);
    }

    std::vector<Entity*> dstEntitiesCanPush;
    std::vector<Entity*> reprocessDstEntities;
    std::vector<Entity*> abnormalDstEntities;
    for (auto &dst : iter->second) {
        const auto dstEntity = dst.GetEntity();
        if (dstEntity == nullptr) {
            DGW_LOG_WARN("[FSM] Recv entity is nullptr, id:[%u].", dst.GetId());
            continue;
        }
        DGW_LOG_INFO("Find dst entity, id:[%u] type:[%s].", dstEntity->GetId(), dstEntity->GetTypeDesc().c_str());
        dstEntity->SelectDstEntities(entity.GetTransId() + entity.GetRouteLabel(), dstEntitiesCanPush,
            reprocessDstEntities, abnormalDstEntities);
    }

    Mbuf *const mbuf = entity.GetMbuf();
    // check if current data is the first one to process{entity.sendObject size == 0}
    const bool firstData = (entity.GetSendDataObjs().size() == 0U);
    auto dataObj = DataObjManager::Instance().CreateDataObj(&entity, mbuf);
    std::vector<Entity*> dstEntitiesToPush;
    for (auto canPushDstEntity: dstEntitiesCanPush) {
        dataObj->AddRecvEntity(canPushDstEntity);
        if (!firstData) {
            // 前序数据未完成发送，当前数据不能发送
            continue;
        }
        (void)dstEntitiesToPush.emplace_back(canPushDstEntity);
    }

    std::shared_ptr<DynamicSchedMgr::RequestInfo> dynamicRequest = nullptr;
    uint32_t schedCfgKey = 0U;
    for (auto reprocessEntity : reprocessDstEntities) {
        dataObj->AddRecvEntity(reprocessEntity);
        reprocessEntity->ReprocessInTryPush(entity, dynamicRequest, schedCfgKey);
    }
    const auto sendRet = SendRequestForDynamicGroup(dynamicRequest, schedCfgKey, entity);
    if (sendRet != FsmStatus::FSM_SUCCESS) {
        return sendRet;
    }
    if (dataObj->GetRecvEntitySize() > 0U) {
        entity.AddDataObjToSendList(dataObj);
    }

    // if current data is not the first one to process, dstEntitiesToPush will be empty
    InnerMessage msg;
    msg.msgType = InnerMsgType::INNER_MSG_PUSH;
    FsmStatus processRet = FsmStatus::FSM_SUCCESS;
    for (auto entityToPush: dstEntitiesToPush) {
        // schedule each receiving entity
        (void)entityToPush->AddDataObjToRecvList(dataObj);
        if (entityToPush->ProcessMessage(msg) == FsmStatus::FSM_ERROR) {
            processRet = FsmStatus::FSM_ERROR;
            entity.RemoveRecvEntityFromSendList(entityToPush);
        };
    }

    for (auto abnormalEntity: abnormalDstEntities) {
        if (abnormalEntity->AbProcessInTryPush() == FsmStatus::FSM_ERROR) {
            processRet = FsmStatus::FSM_ERROR;
        }
    }

    if (processRet == FsmStatus::FSM_ERROR) {
        (void)entity.ChangeState(FsmState::FSM_IDLE_STATE);
        return processRet;
    }

    return PostProcess(entity);
}

FsmStatus TryPushState::SendRequestForDynamicGroup(const DynamicRequestPtr dynamicRequest, const uint32_t schedCfgKey,
    Entity &entity) const
{
    if (dynamicRequest == nullptr) {
        return FsmStatus::FSM_SUCCESS;
    }
    std::vector<DynamicSchedMgr::RequestInfo> dynamicRequests;
    dynamicRequests.emplace_back(*dynamicRequest);
    const auto requestRet = DynamicSchedMgr::GetInstance(entity.GetResIndex()).
        SendRequest(schedCfgKey, dynamicRequests);
    if (requestRet != FsmStatus::FSM_SUCCESS) {
        DGW_LOG_WARN("Entity:[%s] sendRequest fail, ret is %d.",
            entity.ToString().c_str(), static_cast<int32_t>(requestRet));
        return requestRet;
    }
    DGW_LOG_INFO("Entity[%s] SetWaitDecisionState to true", entity.ToString().c_str());
    entity.SetDynamicReqTime(DynamicSchedMgr::GetInstance(entity.GetResIndex()).DynamicSchedNow());
    entity.SetWaitDecisionState(true);
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus TryPushState::ProcessMessage(Entity &entity, const InnerMessage &msg)
{
    (void)msg;
    return PreProcess(entity);
}

FsmStatus TryPushState::PostProcess(Entity &entity)
{
    return entity.ChangeState(FsmState::FSM_PEEK_STATE);
}

REGISTER_STATE(FSM_TRY_PUSH_STATE, ENTITY_QUEUE, TryPushState);
REGISTER_STATE(FSM_TRY_PUSH_STATE, ENTITY_TAG, TryPushState);
REGISTER_STATE(FSM_TRY_PUSH_STATE, ENTITY_GROUP, TryPushState);
}  // namespace dgw
