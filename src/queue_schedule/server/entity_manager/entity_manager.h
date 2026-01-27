/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_ENTITY_MANAGER_H
#define DGW_ENTITY_MANAGER_H

#include <functional>
#include <map>
#include <pthread.h>
#include <vector>

#include "entity.h"
#include "channel_entity.h"

namespace dgw {
// buf pool register/unregister msg
constexpr uint32_t EVENT_BUF_POOL_MSG = static_cast<uint32_t>(EVENT_ID::EVENT_DRV_MSG);
// request recv msg
constexpr uint32_t EVENT_RECV_REQUEST_MSG = static_cast<uint32_t>(EVENT_ID::EVENT_USR_START);
// request send completion msg
constexpr uint32_t EVENT_SEND_COMPLETION_MSG = static_cast<uint32_t>(EVENT_ID::EVENT_USR_START) + 1U;
// request recv completion msg
constexpr uint32_t EVENT_RECV_COMPLETION_MSG = static_cast<uint32_t>(EVENT_ID::EVENT_USR_START) + 2U;
// hccl full2NotFull msg
constexpr uint32_t EVENT_CONGESTION_RELIEF_MSG = static_cast<uint32_t>(EVENT_ID::EVENT_USR_START) + 3U;

struct CommChannels {
    std::vector<ChannelEntityPtr> entities;     // comm channel vector
    std::vector<HcclRequest> requests;   // requests
    std::vector<int32_t> compIndices;    // comp indices: when testsome, completed request index in requests
    std::vector<HcclStatus> compStatus;  // comp status: when testsome, status of completed request
    pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;  // lock for comm channel vector
};

using MapIdToEntityVector = std::map<uint32_t, std::vector<EntityPtr>>;
using IdToEntityMap = std::map<uint32_t, std::map<uint32_t, std::map<EntityType, MapIdToEntityVector>>>;
using GroupEntityMap = std::map<uint32_t, std::vector<EntityPtr>>;

class EntityManager {
public:
    explicit EntityManager(const uint32_t resIndex)
    {
        resIndex_ = resIndex;
    }
    ~EntityManager();

    EntityManager(const EntityManager &) = delete;
    EntityManager(const EntityManager &&) = delete;
    EntityManager &operator = (const EntityManager &) = delete;
    EntityManager &operator = (EntityManager &&) = delete;

    static EntityManager &Instance(const uint32_t resIndex = 0U);

    /**
     * get entity by id
     * @param eType: entity type
     * @param id: entity id
     * @return entity pointer
     */
    EntityPtr GetEntityById(const uint32_t queueType, const uint32_t deviceId, const EntityType eType,
                            const uint32_t id, const EntityDirection direction);

    EntityPtr DoGetEntity(const uint32_t queueType, const uint32_t deviceId, const EntityType eType,
                          const uint32_t id, const EntityDirection direction);

    EntityPtr GetSrcEntityByGlobalId(const uint32_t key, const uint32_t globalId) const;

    EntityPtr GetDstEntityByGlobalId(const uint32_t key, const uint32_t globalId) const;
    /**
     * get entities from group
     * @param groupId: group id
     * @return const std::vector<EntityPtr> &
     */
    const std::vector<EntityPtr> &GetEntitiesInGroup(const uint32_t groupId);

    /**
     * create group
     * @param groupId group id
     * @param entities entities in group
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus CreateGroup(const uint32_t groupId, std::vector<EntityPtr>& entities);

    /**
     * delete group
     * @param groupId group id
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus DeleteGroup(const uint32_t groupId);

    /**
     * create entity
     * @param etype entity for queue:EntityType::ENTITY_QUEUE, entity for tag:EntityType::ENTITY_TAG
     * @param state send entity:FsmState::FSM_IDLE_STATE, recv entity:FsmState::FSM_WAIT_PUSH_STATE
     * @param id queue id or group id or channel id (not tag id)
     * @param channel comm channel info, only for comm channel
     * @param hostGroupId host group id
     * @param groupPolicy group policy, only for group
     * @return return EntityPtr
     */
    EntityPtr CreateEntity(const EntityMaterial &material);

    /**
     * delete entity
     * @param type entity for queue:EntityType::ENTITY_QUEUE, entity for tag:EntityType::ENTITY_TAG
     * @param id queue id or tag id or group id
     * @return FsmStatus FSM_SUCCESS: success, other: failed
     */
    FsmStatus DeleteEntity(const uint32_t queueType, const uint32_t deviceId,
                           const EntityType eType, const uint32_t id,  const EntityDirection direction);

    /**
     * probe source comm channel
     * @param procFunc process function
     * @return FsmStatus FSM_SUCCESS: success, other: failed
     */
    FsmStatus ProbeSrcCommChannel(const std::function<FsmStatus(const ChannelEntityPtr &, uint32_t &)> procFunc);

    /**
     * check and supply recv request event
     * @return FsmStatus FSM_SUCCESS: success, other: failed
     */
    FsmStatus SupplyRecvRequestEvent();

    FsmStatus SupplyOneTrackEvent();

    /**
     * test some comm channel
     * @param procFunc process function
     * @param isSrc is src
     * @return FsmStatus FSM_SUCCESS: success, other: failed
     */
    FsmStatus TestSomeCommChannels(const std::function<FsmStatus(CommChannels &, uint32_t &, uint32_t &)> procFunc,
                                   const bool isSrc);

    /**
     * erase comm channel from src/dst comm channels
     * @param isSrc is source entity
     */
    FsmStatus EraseCommChannel(const EntityPtr &entity, const bool isSrc);

    /**
     * insert comm channel to src/dst comm channels
     * @param entity entity
     * @param isSrc is source entity
     * @return FsmStatus FSM_SUCCESS: success, other: failed
     */
    FsmStatus InsertCommChannel(const ChannelEntityPtr &entity, const bool isSrc);

    /**
     * @brief Get comm channels
     * @param isSrc is source entity
     * @return const CommChannels& src or dst comm channels
     */
    CommChannels &GetCommChannels(const bool isSrc);

    /**
     * @brief supply event
     * @param eventId event id
     * @return FsmStatus FSM_SUCCESS: success, other: failed
     */
    FsmStatus SupplyEvent(const uint32_t eventId) const;

    FsmStatus SupplyEvent(const uint32_t eventId, const uint32_t deviceId, const uint32_t groupId) const;

    /**
     * @brief check link status
     * @return FsmStatus FSM_SUCCESS: success, other: failed
     */
    FsmStatus CheckLinkStatus();

    /**
     * @brief show whether some entity has been full
     * @return true: yes, false: no
     */
    inline bool IsExistFullEntity() const
    {
        return existFull_;
    }

    /**
     * @brief mark some entity has been full
     */
    inline void SetExistFullEntity()
    {
        existFull_ = true;
    }

    /**
     * @brief show whether some entity has been Async Mem Buff
     * @return true: yes, false: no
     */
    inline bool IsExistAsyncMemEntity() const
    {
        return existDstAsyncMem_;
    }

    /**
     * @brief mark some entity has been Async Mem Buff
     */
    inline void SetExistAsyncMemEntity()
    {
        existDstAsyncMem_ = true;
    }

    /**
     * @brief set subscription_pause_policy for full queue
     */
    inline void SetSubscriptionPausePolicy(const bool pauseSubscriptionWhenFull)
    {
        pauseSubscriptionWhenFull_ = pauseSubscriptionWhenFull;
    }

    /**
     * @brief whether pause subscription
     * @return true: yes, false: no
     */
    inline bool ShouldPauseSubscirpiton() const
    {
        return pauseSubscriptionWhenFull_;
    }

    void CleanEntityMap(const uint32_t queueType, const uint32_t deviceId, const EntityType eType,
        const uint32_t id);

private:
    /**
     * @brief create new entity by type
     * @param etype entity type
     * @param id entity id
     * @param channel channel info, only for channel
     * @param hostGroupId host group id, for queue or channel in group
     * @param groupPolicy group policy, only for group
     * @return EntityPtr
     */
    EntityPtr AllocEntity(const EntityMaterial &material) const;

    void DoAllocEntity(const EntityMaterial &material, EntityPtr &entity) const;

    FsmStatus SupplyEventForRecvRequest(uint32_t msgType);

    // entity map
    IdToEntityMap idToEntity_;
    // group entity map
    GroupEntityMap groupEntityMap_;
    // src comm channels info
    CommChannels srcCommChannels_;
    // dst comm channels info
    CommChannels dstCommChannels_;
    bool existFull_{false};
    bool pauseSubscriptionWhenFull_{true};
    uint32_t resIndex_{0U};
    std::map<uint64_t, EntityPtr> globalIdToSrcEntity_;
    std::map<uint64_t, EntityPtr> globalIdToDstEntity_;
    bool existDstAsyncMem_{false};
};
}
#endif