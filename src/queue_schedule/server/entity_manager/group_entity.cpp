/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "group_entity.h"
#include "bqs_util.h"
#include "common/bqs_log.h"
#include "entity_manager.h"
#include "strategy/strategy_manager.h"

namespace dgw {

namespace {
    constexpr int64_t GROUP_WAIT_TRANSID_TIMEOUT = -1L;
}

GroupEntity::GroupEntity(const EntityMaterial &material, const uint32_t resIndex)
    : Entity(material, resIndex), mbufDeviceId_(material.resId), mbufQueueType_(material.queueType)
{
    groupInfo_.groupId = static_cast<int32_t>(material.id);
    groupInfo_.groupPolicy = material.groupPolicy;
    groupInfo_.timeout = GROUP_WAIT_TRANSID_TIMEOUT;
    groupInfo_.lastTransId = 0UL;
    groupInfo_.peerInstanceNum = material.peerInstanceNum;
    groupInfo_.localInstanceIndex = material.localInstanceIndex;
    groupInfo_.lastTimestamp = 0UL;
}

FsmStatus GroupEntity::Dequeue()
{
    const auto dequeAllow = AllowDeque();
    if (dequeAllow != FsmStatus::FSM_SUCCESS) {
        return dequeAllow;
    }

    // select src entity in group
    FsmStatus selectStatus = FsmStatus::FSM_SUCCESS;
    const EntityPtr srcEntityPtr = SelectSrcEntity(selectStatus);
    if (selectStatus == FsmStatus::FSM_ERROR) {
        return FsmStatus::FSM_ERROR_PENDING;
    }
    // if select failed, group entity change to idle state
    if (srcEntityPtr == nullptr) {
        return FsmStatus::FSM_FAILED;
    }

    // select success
    DGW_LOG_INFO("Set srcEntity[%u] entity[%u] transId to %lu, routelabel to %u",
        srcEntityPtr->GetId(), id_, srcEntityPtr->GetTransId(), srcEntityPtr->GetRouteLabel());
    transId_ = srcEntityPtr->GetTransId();
    routeLabel_ = srcEntityPtr->GetRouteLabel();
    mbufDeviceId_ = srcEntityPtr->GetMbufDeviceId();
    mbufQueueType_ = srcEntityPtr->GetMbufQueueType();
    mbuf_ = srcEntityPtr->GetMbuf();
    srcEntityPtr->ResetSrcState();
    // set last trans id and last timestamp
    SetGroupInfo(GetTransId(), bqs::GetNowTime());
    AddScheduleCount();
    return FsmStatus::FSM_SUCCESS;
}

EntityPtr GroupEntity::SelectSrcEntity(FsmStatus &status)
{
    const std::vector<EntityPtr> &entitiesInGroup = EntityManager::Instance(resIndex_).GetEntitiesInGroup(id_);
    if (entitiesInGroup.empty()) {
        DGW_LOG_ERROR("No entities in group, group id:%u", id_);
        return nullptr;
    }

    uint64_t waitTransId;
    // first schedule, set lastTimestamp
    if (groupInfo_.lastTransId == 0UL) {
        SetGroupInfo(0UL, bqs::GetNowTime());
        waitTransId = (groupInfo_.localInstanceIndex == 0U) ?
            groupInfo_.peerInstanceNum : groupInfo_.localInstanceIndex;
    } else {
        waitTransId = groupInfo_.lastTransId + groupInfo_.peerInstanceNum;
    }

    // mark whether all entity in group is peeked state
    bool allFinishPeekFlag = true;
    // mark whether no entity in group is peeked state
    bool noOneFinishPeekFlag = true;
    // peek every entity in group
    for (auto &entity : entitiesInGroup) {
        if (entity == nullptr) {
            DGW_LOG_ERROR("Entity is nullptr.");
            return nullptr;
        }
        DGW_LOG_INFO("[FSM] Begin to peek mbuf from entity[%s] in group:%u, waitTransId:%lu.",
            entity->ToString().c_str(), id_, waitTransId);
        
        // peek data from entity in group
        status = PeekFromEntityInGroup(*entity, waitTransId);
        if (status != FsmStatus::FSM_SUCCESS) {
            if (status == FsmStatus::FSM_ERROR) {
                DGW_LOG_ERROR("[FSM] Peek mbuf from entity[%s] failed.", entity->ToString().c_str());
                return nullptr;
            }
            allFinishPeekFlag = false;
            continue;
        }
        noOneFinishPeekFlag = false;
        if (Match(*entity, waitTransId, true)) {
            DGW_LOG_DEBUG("[FSM] Entity:[%s] state:[%s] transId:[%lu] has been selected from group entity:[%s].",
                entity->ToString().c_str(), entity->GetStateDesc(FsmState::FSM_PEEK_STATE).c_str(),
                waitTransId, ToString().c_str());
            return entity;
        }
    }

    // only when part of entities in group are peeked state, check timeout
    bool timeoutFlag = false;
    if ((!allFinishPeekFlag) && (!noOneFinishPeekFlag)) {
        timeoutFlag = CheckTimeout(waitTransId);
    }
    // if timeout or all entity in group finished peek, try to find min transId
    if (allFinishPeekFlag || timeoutFlag) {
        return SelectEntityWithMinTransId(entitiesInGroup);
    }
    // if not timeout && not all entity in group is peeked state && not exist waitTransId, wait next schedule
    return nullptr;
}

bool GroupEntity::Match(const Entity &entity, const uint64_t waitTransId, bool exactlyMatch) const {
    if ((entity.GetRouteLabel() != 0U) || (groupInfo_.groupPolicy == bqs::GroupPolicy::DYNAMIC)) {
        return true;
    }
    DGW_LOG_INFO("entity transid[%lu] vs waitTransId[%lu]", entity.GetTransId(), waitTransId);
    return exactlyMatch ? (entity.GetTransId() == waitTransId) : (entity.GetTransId() >= waitTransId);
}

FsmStatus GroupEntity::PeekFromEntityInGroup(Entity &entity, const uint64_t waitTransId) const
{
    InnerMessage msg;
    msg.msgType = InnerMsgType::INNER_MSG_PUSH;
    do {
        if (entity.IsDataPeeked()) {
            // if match, return
            if (Match(entity, waitTransId, false)) {
                return FsmStatus::FSM_SUCCESS;
            };
            // not match, free mbuf
            Mbuf * const mbuf = entity.GetMbuf();
            if (mbuf != nullptr) {
                (void)halMbufFree(mbuf);
                entity.SetMbuf(nullptr);
                DGW_LOG_RUN_INFO("[FSM] Peek mbuf with transId[%lu] from entity[%s], "
                    "but wait transId is [%lu], free mbuf!",
                    entity.GetTransId(), entity.ToString().c_str(), waitTransId);
            }
        }

        DGW_LOG_DEBUG("[FSM] Entity[%s]  try to peek data.", entity.ToString().c_str());
        if (entity.ProcessMessage(msg) == FsmStatus::FSM_ERROR) {
            return FsmStatus::FSM_ERROR;
        }
    } while (entity.IsDataPeeked());

    return FsmStatus::FSM_FAILED;
}

bool GroupEntity::CheckTimeout(const uint64_t waitTransId) const
{
    (void)waitTransId;
    if (groupInfo_.timeout <= 0L) {
        DGW_LOG_INFO("[FSM] no need check timeout, timeoutInterval:%ld, waitTransId:%lu.",
            groupInfo_.timeout, waitTransId);
        return false;
    }
    const uint64_t currTimestamp = bqs::GetNowTime();
    if ((currTimestamp - groupInfo_.lastTimestamp) > static_cast<uint64_t>(groupInfo_.timeout)) {
        DGW_LOG_INFO("[FSM] timeout, currTimestamp:%lu, lasttimestamp:%lu, timeoutInterval:%ld, waitTransId:%lu.",
            currTimestamp, groupInfo_.lastTimestamp, groupInfo_.timeout, waitTransId);
        return true;
    }
    return false;
}

EntityPtr GroupEntity::SelectEntityWithMinTransId(const std::vector<EntityPtr> &entities) const
{
    EntityPtr selectedEntity = nullptr;
    uint64_t minTransId = UINT64_MAX;
    for (auto &entity : entities) {
        if ((entity == nullptr) || !entity->IsDataPeeked()) {
            continue;
        }
        if (minTransId >= entity->GetTransId()) {
            minTransId = entity->GetTransId();
            selectedEntity = entity;
        }
    }
    if (selectedEntity != nullptr) {
        DGW_LOG_RUN_INFO("[FSM] Group entity[%s] get minTransId[%lu].", selectedEntity->ToString().c_str(), minTransId);
    }
    return selectedEntity;
}

void GroupEntity::SelectDstEntities(const uint64_t key, std::vector<Entity*> &toPushDstEntities,
    std::vector<Entity*> &reprocessDstEntities, std::vector<Entity*> &abnormalDstEntities)
{
    if (groupInfo_.groupPolicy == bqs::GroupPolicy::DYNAMIC) {
        reprocessDstEntities.emplace_back(this);
        return;
    }
    // Group entity, use strategy to select dst entities
    Strategy *const strategy = StrategyManager::GetInstance().GetStrategy(groupInfo_.groupPolicy);
    if (strategy == nullptr) {
        DGW_LOG_ERROR("Strategy in group:%u with policy:%d is null. Please check!", id_,
            static_cast<int32_t>(groupInfo_.groupPolicy));
        return;
    }
    DGW_LOG_INFO("Get strategy:%s success.",
        StrategyManager::GetInstance().GetStrategyDesc(groupInfo_.groupPolicy).c_str());
    std::vector<EntityPtr> selEntities;
    (void) strategy->Search(id_, key, selEntities, resIndex_);
    for (auto selEntity : selEntities) {
        if (selEntity->GetCurState() == FsmState::FSM_ERROR_STATE) {
            abnormalDstEntities.emplace_back(this);
            break;
        }
        toPushDstEntities.emplace_back(selEntity.get());
    }
}

void GroupEntity::ReprocessInTryPush(const Entity &srcEntity, DynamicRequestPtr &dynamicRequest, uint32_t &schedCfgKey)
{
    if (groupInfo_.groupPolicy != bqs::GroupPolicy::DYNAMIC) {
        return;
    }

    if (dynamicRequest == nullptr) {
        dynamicRequest = std::make_shared<DynamicSchedMgr::RequestInfo>();
        DGW_CHECK_RET_VOID((dynamicRequest != nullptr), "Fail to alloc dynamicRequest in group:%u.", id_);
        dynamicRequest->src.queueLogicId = srcEntity.GetGlobalId();
        dynamicRequest->src.modelUuid = srcEntity.GetUuId();
        dynamicRequest->src.queueId = srcEntity.GetId();
        DynamicSchedMgr::DecisionInfo decision = {};
        decision.transId = srcEntity.GetTransId();
        decision.routeLabel = srcEntity.GetRouteLabel();
        dynamicRequest->decisions.emplace_back(decision);
    }
    DynamicSchedMgr::DstGroupInfo dstGrp = {};
    dstGrp.logicGroupId = GetGlobalId();
    dynamicRequest->dsts.emplace_back(dstGrp);
    schedCfgKey = GetSchedCfgKey();
}

FsmStatus GroupEntity::AbProcessInTryPush()
{
    return ChangeState(FsmState::FSM_ERROR_STATE);
}

FsmStatus GroupEntity::PauseSubscribe(const Entity &fullEntity)
{
    const auto entities = EntityManager::Instance(resIndex_).GetEntitiesInGroup(id_);
    for (auto &entity : entities) {
        entity->PauseSubscribe(fullEntity);
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus GroupEntity::ResumeSubscribe(const Entity &notFullEntity)
{
    const auto entities = EntityManager::Instance(resIndex_).GetEntitiesInGroup(id_);
    for (auto &entity : entities) {
        (void) entity->ResumeSubscribe(notFullEntity);
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus GroupEntity::ClearQueue()
{
    DGW_LOG_INFO("Entity[%s] clear queue", entityDesc_.c_str());
    const auto entities = EntityManager::Instance(resIndex_).GetEntitiesInGroup(id_);
    for (auto &entity : entities) {
        const auto ret = entity->ClearQueue();
        if (ret != FsmStatus::FSM_SUCCESS) {
            return ret;
        }
    }
    groupInfo_.lastTransId = 0U;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus GroupEntity::MakeSureOutputCompletion()
{
    DGW_LOG_INFO("Entity[%s] MakeSureOutputCompletion", entityDesc_.c_str());
    FsmStatus ret = FsmStatus::FSM_SUCCESS;
    const auto entities = EntityManager::Instance(resIndex_).GetEntitiesInGroup(id_);
    for (auto &entity : entities) {
        ret = entity->MakeSureOutputCompletion();
        if (ret != FsmStatus::FSM_SUCCESS) {
            break;
        }
    }
    DGW_LOG_INFO("Entity[%s] Finish MakeSureOutputCompletion, ret is %d", entityDesc_.c_str(),
        static_cast<int32_t>(ret));
    return ret;
}

void GroupEntity::SetGroupInfo(const uint64_t lastTransId, const uint64_t lastTimestamp)
{
    groupInfo_.lastTransId = lastTransId;
    groupInfo_.lastTimestamp = lastTimestamp;
}

uint32_t GroupEntity::GetMbufDeviceId() const
{
    return mbufDeviceId_;
}

uint32_t GroupEntity::GetMbufQueueType() const
{
    return mbufQueueType_;
}

}