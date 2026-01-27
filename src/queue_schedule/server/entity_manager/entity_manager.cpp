/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "entity_manager.h"
#include <algorithm>
#include "bqs_util.h"
#include "client_entity.h"
#include "common/bqs_log.h"
#include "driver/ascend_hal_external.h"
#include "group_entity.h"
#include "queue_manager.h"
#include "schedule_config.h"
#include "simple_entity.h"
#include "state_manager.h"

namespace dgw {
namespace {
    const uint32_t SHIFT32 = 32U;
    // default channel request capacity
    constexpr size_t DEFAULT_CHANNEL_CAPACITY = 32UL;
}

EntityManager::~EntityManager()
{
    (void)pthread_rwlock_destroy(&srcCommChannels_.lock);
    (void)pthread_rwlock_destroy(&dstCommChannels_.lock);
}

EntityManager &EntityManager::Instance(const uint32_t resIndex)
{
    if (resIndex != 0U) {
        static EntityManager instanceExtra(resIndex);
        return instanceExtra;
    }

    static EntityManager instance(resIndex);
    return instance;
}

EntityPtr EntityManager::DoGetEntity(const uint32_t queueType, const uint32_t deviceId, const EntityType eType,
    const uint32_t id, const EntityDirection direction)
{
    const auto iterDevId = idToEntity_.find(deviceId);
    if (iterDevId == idToEntity_.end()) {
        return nullptr;
    }

    const auto qTypeIter = iterDevId->second.find(queueType);
    if (qTypeIter == iterDevId->second.end()) {
        return nullptr;
    }

    const auto iterType = qTypeIter->second.find(eType);
    if (iterType == qTypeIter->second.end()) {
        return nullptr;
    }

    const auto itEntityIter = iterType->second.find(id);
    if (itEntityIter == iterType->second.end()) {
        return nullptr;
    }

    EntityPtr entity = nullptr;
    for (const auto &elem: itEntityIter->second) {
        if (elem->GetDirection() == direction) {
            entity = elem;
        }
    }
    return entity;
}

EntityPtr EntityManager::GetEntityById(const uint32_t queueType, const uint32_t deviceId, const EntityType eType,
    const uint32_t id, const EntityDirection direction)
{
    EntityPtr entity = DoGetEntity(queueType, deviceId, eType, id, direction);
    if (entity != nullptr) {
        DGW_LOG_DEBUG("Direction:[%s] type:[%s] id:[%u] state:[%s] queue id:[%u] "
                      "device id:[%u] owner deviceid:[%u] is found",
                      GetDirectionDesc(entity->GetDirection()), entity->GetTypeDesc().c_str(), id,
                      entity->GetStateDesc(entity->GetCurState()).c_str(),
                      entity->GetQueueId(), deviceId, entity->GetDeviceId());
    } else {
        DGW_LOG_WARN("Type:[%s] id:[%u], device id:[%u], queueType:[%u], direction[%d] does not exist",
            StateManager::Instance().GetTypeDesc(eType).c_str(), id, deviceId,
            queueType, static_cast<int32_t>(direction));
    }
    return entity;
}

EntityPtr EntityManager::GetSrcEntityByGlobalId(const uint32_t key, const uint32_t globalId) const
{
    EntityPtr entity = nullptr;
    uint64_t uniqKey = key;
    uniqKey = (uniqKey << SHIFT32) | static_cast<uint64_t>(globalId);
    const auto iter = globalIdToSrcEntity_.find(uniqKey);
    if (iter != globalIdToSrcEntity_.end()) {
        entity = iter->second;
    }
    return entity;
}

EntityPtr EntityManager::GetDstEntityByGlobalId(const uint32_t key, const uint32_t globalId) const
{
    EntityPtr entity = nullptr;
    uint64_t uniqKey = key;
    uniqKey = (uniqKey << SHIFT32) | static_cast<uint64_t>(globalId);
    const auto iter = globalIdToDstEntity_.find(uniqKey);
    if (iter != globalIdToDstEntity_.end()) {
        entity = iter->second;
    }
    return entity;
}

const std::vector<EntityPtr> &EntityManager::GetEntitiesInGroup(const uint32_t groupId)
{
    static const std::vector<EntityPtr> emptyVec;
    const auto iter = groupEntityMap_.find(groupId);
    if (iter != groupEntityMap_.end()) {
        return iter->second;
    }
    return emptyVec;
}

FsmStatus EntityManager::CreateGroup(const uint32_t groupId, std::vector<EntityPtr>& entities)
{
    const auto iter = groupEntityMap_.find(groupId);
    // when group src bind to multi dst
    if (iter != groupEntityMap_.end()) {
        DGW_LOG_WARN("groupId[%u] has exist.", groupId);
        return FsmStatus::FSM_SUCCESS;
    }
    (void) groupEntityMap_.insert(std::make_pair(groupId, entities));
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus EntityManager::DeleteGroup(const uint32_t groupId)
{
    const auto iter = groupEntityMap_.find(groupId);
    if (iter == groupEntityMap_.end()) {
        DGW_LOG_WARN("groupId[%u] does not exist.", groupId);
        return FsmStatus::FSM_SUCCESS;
    }
    (void) groupEntityMap_.erase(iter);
    return FsmStatus::FSM_SUCCESS;
}

EntityPtr EntityManager::CreateEntity(const EntityMaterial &material)
{
    auto entity = GetEntityById(material.queueType, material.resId, material.eType, material.id, material.direction);
    if (entity != nullptr) {
        DGW_LOG_INFO("Type:[%s] id:[%u], direction:[%d] is existed", entity->GetTypeDesc().c_str(), material.id,
            static_cast<int32_t>(material.direction));
        entity->IncreaseRefCount();
        return entity;
    }

    // alloc entity
    entity = AllocEntity(material);
    if (entity == nullptr) {
        DGW_LOG_ERROR("Create [%s] entity failed type:[%s] id:[%u].", GetDirectionDesc(material.direction),
            StateManager::Instance().GetTypeDesc(material.eType).c_str(), material.id);
        return nullptr;
    }

    // init and save entity
    FsmState state = FsmState::FSM_IDLE_STATE;
    if (material.direction == EntityDirection::DIRECTION_RECV) {
        state = FsmState::FSM_WAIT_PUSH_STATE;
    }
    const auto ret = entity->Init(state, material.direction);
    if (ret != FsmStatus::FSM_SUCCESS) {
        DGW_LOG_ERROR("Init entity failed, direction:[%s].", entity->ToString().c_str());
        return nullptr;
    }
    entity->IncreaseRefCount();
    idToEntity_[material.resId][material.queueType][material.eType][material.id].emplace_back(entity);

    uint64_t uniqKey = material.schedCfgKey;
    uniqKey = (uniqKey << SHIFT32) | static_cast<uint64_t>(material.globalId);
    if (material.direction == EntityDirection::DIRECTION_RECV) {
        DGW_LOG_INFO("add globalIdToDstEntity_ for %u:%u", material.schedCfgKey, material.globalId);
        globalIdToDstEntity_[uniqKey] = entity;
    } else {
        DGW_LOG_INFO("add globalIdToSrcEntity_ for %u:%u", material.schedCfgKey, material.globalId);
        globalIdToSrcEntity_[uniqKey] = entity;
    }
    DGW_LOG_INFO("Create entity[%s] success, state:[%s]",
        entity->ToString().c_str(), entity->GetStateDesc(entity->GetCurState()).c_str());
    bqs::StatisticManager::GetInstance().SetExistEntityFlag(true);

    if (material.eType == dgw::EntityType::ENTITY_TAG) {
        const ChannelEntityPtr channelEntity = std::dynamic_pointer_cast<ChannelEntity>(entity);
        (void)InsertCommChannel(channelEntity, material.direction == EntityDirection::DIRECTION_SEND);
    }
    return entity;
}

FsmStatus EntityManager::DeleteEntity(const uint32_t queueType, const uint32_t deviceId, const EntityType eType,
    const uint32_t id, const EntityDirection direction) {
    EntityPtr entity = DoGetEntity(queueType, deviceId, eType, id, direction);
    if (entity == nullptr) {
        DGW_LOG_WARN("Failed to find entity for queueType[%u], deviceId[%u], type[%s], id:[%u], direction:[%d]",
            queueType, deviceId, StateManager::Instance().GetTypeDesc(eType).c_str(), id,
            static_cast<int32_t>(direction));
        return FsmStatus::FSM_SUCCESS;
    }

    // delete entity
    entity->DecreaseRefCount();
    if (entity->GetRefCount() != 0U) {
        return FsmStatus::FSM_SUCCESS;
    }
    auto &entityVec = idToEntity_[deviceId][queueType][eType][id];
    auto entityVectorIter = entityVec.begin();
    while (entityVectorIter != entityVec.end()) {
        if ((*entityVectorIter)->GetDirection() == direction) {
            DGW_LOG_INFO("Delete entity[%s] from entityMap", entity->ToString().c_str());
            entityVec.erase(entityVectorIter);
            break;
        }
        ++entityVectorIter;
    }
    CleanEntityMap(queueType, deviceId, eType, id);

    uint64_t uniqKey = entity->GetSchedCfgKey();
    uniqKey = (uniqKey << SHIFT32) | static_cast<uint64_t>(entity->GetGlobalId());
    if (direction == EntityDirection::DIRECTION_RECV) {
        globalIdToDstEntity_.erase(uniqKey);
    } else {
        globalIdToSrcEntity_.erase(uniqKey);
    }

    DGW_LOG_INFO("Success to delete entity[%s], direction:[%s].",
        entity->ToString().c_str(), GetDirectionDesc(direction));
    if (!dgw::ScheduleConfig::GetInstance().GetSchedKeys().empty() &&
        (eType == dgw::EntityType::ENTITY_QUEUE)) {
            dgw::DynamicSchedMgr::GetInstance(resIndex_).DeleteQueue(entity->GetGlobalId(), entity->GetSchedCfgKey());
    }

    if (eType == dgw::EntityType::ENTITY_TAG) {
        (void)EraseCommChannel(entity, direction == EntityDirection::DIRECTION_SEND);
    }
    DGW_LOG_INFO("Finish to delete entity[%s], direction:[%s].",
        entity->ToString().c_str(), GetDirectionDesc(direction));
    (void)entity->Uninit();
    return FsmStatus::FSM_SUCCESS;
}

void EntityManager::CleanEntityMap(const uint32_t queueType, const uint32_t deviceId, const EntityType eType,
    const uint32_t id)
{
    if (!idToEntity_[deviceId][queueType][eType][id].empty()) {
        return;
    }

    DGW_LOG_INFO("Erase id[%u] in entityMap[%u:%u:%d].", id, deviceId, queueType, static_cast<int32_t>(eType));
    idToEntity_[deviceId][queueType][eType].erase(id);
    if (!idToEntity_[deviceId][queueType][eType].empty()) {
        return;
    }

    DGW_LOG_INFO("Erase eType[%u] in entityMap[%u:%u].", static_cast<int32_t>(eType), deviceId, queueType);
    idToEntity_[deviceId][queueType].erase(eType);
    if (!idToEntity_[deviceId][queueType].empty()) {
        return;
    }

    DGW_LOG_INFO("Erase queueType[%u] in entityMap[%u].", queueType, deviceId);
    idToEntity_[deviceId].erase(queueType);
    if (!idToEntity_[deviceId].empty()) {
        return;
    }

    DGW_LOG_INFO("Erase deviceId[%u] in entityMap.", deviceId);
    idToEntity_.erase(deviceId);
    if (idToEntity_.empty()) {
        bqs::StatisticManager::GetInstance().SetExistEntityFlag(false);
    }
}

FsmStatus EntityManager::ProbeSrcCommChannel(
    const std::function<FsmStatus(const ChannelEntityPtr &, uint32_t &)> procFunc)
{
    bool emptySched = true;
    (void)pthread_rwlock_rdlock(&srcCommChannels_.lock);
    auto &entities = srcCommChannels_.entities;
    DGW_LOG_INFO("EntityManager[%u] srcCommChannels_'s size is %u", resIndex_, entities.size());
    for (auto iter = entities.begin(); iter != entities.end(); ++iter) {
        uint32_t probeCount = 0U;
        (void)procFunc(*iter, probeCount);
        emptySched = (probeCount != 0U) ? false : emptySched;
    }
    (void)pthread_rwlock_unlock(&srcCommChannels_.lock);
    if (emptySched) {
        bqs::StatisticManager::GetInstance().HcclMpiRecvReqEmptySchedStat();
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus EntityManager::SupplyRecvRequestEvent()
{
    return SupplyEventForRecvRequest(EVENT_RECV_REQUEST_MSG);
}

FsmStatus EntityManager::SupplyOneTrackEvent()
{
    return SupplyEventForRecvRequest(EVENT_RECV_COMPLETION_MSG);
}

FsmStatus EntityManager::SupplyEventForRecvRequest(uint32_t msgType)
{
    const auto checkFunc = [](const ChannelEntityPtr entity)->bool {
        return entity->CheckRecvReqEventContinue();
    };

    bool supplyEventFlag = false;
    (void)pthread_rwlock_rdlock(&srcCommChannels_.lock);
    const auto &entities = srcCommChannels_.entities;
    supplyEventFlag = std::any_of(entities.begin(), entities.end(), checkFunc);
    (void)pthread_rwlock_unlock(&srcCommChannels_.lock);

    if (supplyEventFlag) {
        (void)SupplyEvent(msgType);
        bqs::StatisticManager::GetInstance().RecvReqEventSupplyStat();
        DGW_LOG_DEBUG("Supply receive request event[%u].", msgType);
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus EntityManager::TestSomeCommChannels(
    const std::function<FsmStatus(CommChannels &, uint32_t &, uint32_t &)> procFunc, const bool isSrc)
{
    uint32_t totalCompCount = 0U;
    CommChannels &channels = isSrc ? srcCommChannels_ : dstCommChannels_;
    auto ret = FsmStatus::FSM_SUCCESS;
    (void)pthread_rwlock_rdlock(&channels.lock);
    ret = procFunc(channels, totalCompCount, resIndex_);
    (void)pthread_rwlock_unlock(&channels.lock);
    if (totalCompCount == 0U) {
        isSrc ? bqs::StatisticManager::GetInstance().HcclMpiRecvCompEmptySchedStat() :
            bqs::StatisticManager::GetInstance().HcclMpiSendCompEmptySchedStat();
    }
    return ret;
}

FsmStatus EntityManager::EraseCommChannel(const EntityPtr &entity, const bool isSrc)
{
    CommChannels &channels = isSrc ? srcCommChannels_ : dstCommChannels_;
    (void)pthread_rwlock_wrlock(&channels.lock);
    auto &entities = channels.entities;

    const auto iter = std::find(entities.begin(), entities.end(), entity);
    if (iter != entities.end()) {
        (void)entities.erase(iter);
        DGW_LOG_INFO("Success to erase entity:[%s]", entity->ToString().c_str());
    }
    (void)pthread_rwlock_unlock(&channels.lock);

    DGW_LOG_INFO("Success to erase comm channel entity, entity:[%s], isSrc:[%d] comm channels size:[%zu].",
        entity->ToString().c_str(), static_cast<int32_t>(isSrc), channels.entities.size());
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus EntityManager::InsertCommChannel(const ChannelEntityPtr &entity, const bool isSrc)
{
    CommChannels &channels = isSrc ? srcCommChannels_ : dstCommChannels_;
    (void)pthread_rwlock_wrlock(&channels.lock);
    (void)channels.entities.push_back(entity);
    const size_t curCapacity = channels.requests.capacity();
    if (curCapacity < channels.entities.size()) {
        const size_t newCapacity = curCapacity + DEFAULT_CHANNEL_CAPACITY;
        channels.requests.reserve(newCapacity);
        channels.compIndices.reserve(newCapacity);
        channels.compStatus.reserve(newCapacity);
        DGW_LOG_INFO("Success to reserve requests capacity, primary:[%zu], current:[%zu]", curCapacity, newCapacity);
    }
    (void)pthread_rwlock_unlock(&channels.lock);

    DGW_LOG_INFO("Success to save comm channel entity:[%s], isSrc:[%d] comm channels size:[%zu].",
        entity->ToString().c_str(), static_cast<int32_t>(isSrc), channels.entities.size());
    return FsmStatus::FSM_SUCCESS;
}

EntityPtr EntityManager::AllocEntity(const EntityMaterial &material) const
{
    EntityPtr entity = nullptr;
    try {
        DoAllocEntity(material, entity);
    } catch (std::exception &e) {
        DGW_LOG_ERROR("catch %s", e.what());
    }
    return entity;
}

void EntityManager::DoAllocEntity(const EntityMaterial &material, EntityPtr &entity) const
{
    if (material.eType == dgw::EntityType::ENTITY_TAG) {
        entity = std::make_shared<ChannelEntity>(material, resIndex_);
    } else if (material.eType == dgw::EntityType::ENTITY_GROUP) {
        entity = std::make_shared<GroupEntity>(material, resIndex_);
    } else {
        if (material.queueType == bqs::CLIENT_Q) {
            entity = std::make_shared<ClientEntity>(material, resIndex_);
        } else {
            entity = std::make_shared<SimpleEntity>(material, resIndex_);
        }
    }
}

CommChannels &EntityManager::GetCommChannels(const bool isSrc)
{
    return isSrc ? srcCommChannels_ : dstCommChannels_;
}

FsmStatus EntityManager::SupplyEvent(const uint32_t eventId) const
{
    if (resIndex_ != 0U) {
        return SupplyEvent(eventId, bqs::QueueManager::GetInstance().GetExtraDeviceId(),
            static_cast<uint32_t>(bqs::EventGroupId::ENQUEUE_GROUP_ID_EXTRA));
    }
    return SupplyEvent(eventId, bqs::QueueManager::GetInstance().GetDeviceId(),
        static_cast<uint32_t>(bqs::EventGroupId::ENQUEUE_GROUP_ID));
}

FsmStatus EntityManager::SupplyEvent(const uint32_t eventId, const uint32_t deviceId, const uint32_t groupId) const
{
    uint32_t submitDeviceId = deviceId;
    uint32_t submitGroupId = groupId;
    if (!bqs::GlobalCfg::GetInstance().GetNumaFlag() &&
        ((eventId == static_cast<uint32_t>(EVENT_RECV_REQUEST_MSG)) ||
        (eventId == static_cast<uint32_t>(EVENT_SEND_COMPLETION_MSG)) ||
        (eventId == static_cast<uint32_t>(EVENT_RECV_COMPLETION_MSG)))) {
        submitGroupId = static_cast<uint32_t>(bqs::EventGroupId::F2NF_GROUP_ID);
        submitDeviceId = bqs::QueueManager::GetInstance().GetDeviceId();
    }
    event_summary sched = { };
    sched.pid = getpid();
    sched.grp_id = submitGroupId;
    sched.event_id = static_cast<EVENT_ID>(eventId);
    sched.dst_engine = ACPU_LOCAL;
    const auto ret = halEschedSubmitEvent(submitDeviceId, &sched);
    if (ret != DRV_ERROR_NONE) {
        DGW_LOG_ERROR("Call halEschedSumbmitEvent failed, event:[%u], deviceId[%u], groupId[%u], ret:[%d].",
            eventId, submitDeviceId, submitGroupId, static_cast<int32_t>(ret));
        return FsmStatus::FSM_FAILED;
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus EntityManager::CheckLinkStatus()
{
    (void)pthread_rwlock_rdlock(&srcCommChannels_.lock);
    auto &srcEntities = srcCommChannels_.entities;
    for (auto iter = srcEntities.begin(); iter != srcEntities.end(); ++iter) {
        if ((*iter)->linkStatus_ == dgw::ChannelLinkStatus::UNCONNECTED) {
            DGW_LOG_INFO("CheckLinkStatus srcCommChannels queueId[%u] unconnected", (*iter)->GetQueueId());
            (void)pthread_rwlock_unlock(&srcCommChannels_.lock);
            return FsmStatus::FSM_FAILED;
        }
    }
    (void)pthread_rwlock_unlock(&srcCommChannels_.lock);

    (void)pthread_rwlock_rdlock(&dstCommChannels_.lock);
    auto &dstEntities = dstCommChannels_.entities;
    for (auto iter = dstEntities.begin(); iter != dstEntities.end(); ++iter) {
        if ((*iter)->linkStatus_ == dgw::ChannelLinkStatus::UNCONNECTED) {
            DGW_LOG_INFO("CheckLinkStatus dstCommChannels_ queueId[%u] unconnected", (*iter)->GetQueueId());
            (void)pthread_rwlock_unlock(&dstCommChannels_.lock);
            return FsmStatus::FSM_FAILED;
        }
    }
    (void)pthread_rwlock_unlock(&dstCommChannels_.lock);
    DGW_LOG_INFO("CheckLinkStatus connect success");
    return FsmStatus::FSM_SUCCESS;
}
}  // namespace dgw
