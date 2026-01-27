/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_BIND_RELATION_H
#define QUEUE_SCHEDULE_BIND_RELATION_H

#include <memory>
#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include "hccl/hccl_types_in.h"
#include "queue_schedule/dgw_client.h"
#include "common/bqs_status.h"
#include "common/bqs_util.h"
#include "fsm/state_define.h"
#include "hccl/comm_channel_manager.h"
#include "data_obj_manager.h"
#include "common/bqs_log.h"

namespace bqs {
enum class EventType : uint32_t {
    ENQUEUE,
    F2NF,
};

struct OptionalArg {
    const dgw::CommChannel* channelPtr = nullptr;
    dgw::EntityType eType = dgw::EntityType::ENTITY_QUEUE;
    bqs::GroupPolicy policy = bqs::GroupPolicy::HASH;
    uint32_t peerInstanceNum = 1U;
    uint32_t localInstanceIndex = 0U;
    uint32_t globalId = 0U;
    uint32_t uuId = 0U;
    uint32_t schedCfgKey = 0U;
    uint32_t queueType = bqs::LOCAL_Q;
};

class EntityInfo {
public:
    EntityInfo() = delete;
    ~EntityInfo() = default;

    explicit EntityInfo(const uint32_t id, const uint32_t deviceId, const OptionalArg *const args = nullptr)
        : id_(id), deviceId_(deviceId)
    {
        if (args != nullptr) {
            optionalArgs_ = *args;
        }
        (void)entityDesc_.append("qid:").append(std::to_string(id_))
            .append(", type:").append(std::to_string(static_cast<int32_t>(optionalArgs_.eType)))
            .append(", globalId:").append(std::to_string(optionalArgs_.globalId))
            .append(", schedCfgKey:").append(std::to_string(optionalArgs_.schedCfgKey))
            .append(", queue type:").append(std::to_string(optionalArgs_.queueType))
            .append(", deviceId:").append(std::to_string(deviceId_));
        if (optionalArgs_.channelPtr != nullptr) {
            (void)entityDesc_.append(", ").append(optionalArgs_.channelPtr->ToString());
        }
    }

    bool operator==(const EntityInfo &entityInfo) const
    {
        if (id_ != entityInfo.id_) {
            return false;
        }
        if (optionalArgs_.eType != entityInfo.optionalArgs_.eType) {
            return false;
        }
        if (optionalArgs_.queueType != entityInfo.optionalArgs_.queueType) {
            return false;
        }
        if (deviceId_ != entityInfo.deviceId_) {
            return false;
        }
        return true;
    }

    inline const uint32_t GetId() const
    {
        return id_;
    }
    inline dgw::EntityType GetType() const
    {
        return optionalArgs_.eType;
    }
    inline const bqs::GroupPolicy GetGroupPolicy() const
    {
        return optionalArgs_.policy;
    }
    inline const dgw::CommChannel *GetCommChannel() const
    {
        return optionalArgs_.channelPtr;
    }

    inline const dgw::EntityPtr &GetEntity() const
    {
        return entity_;
    }

    inline void SetEntity(const dgw::EntityPtr &entity)
    {
        entity_ = entity;
    }

    inline const std::string &ToString() const
    {
        return entityDesc_;
    }

    inline const uint32_t GetPeerInstanceNum() const
    {
        return optionalArgs_.peerInstanceNum;
    }

    inline const uint32_t GetLocalInstanceIndex() const
    {
        return optionalArgs_.localInstanceIndex;
    }

    inline const uint32_t GetGlobalId() const
    {
        return optionalArgs_.globalId;
    }

    inline const uint32_t GetUuId() const
    {
        return optionalArgs_.uuId;
    }

    inline const uint32_t GetSchedCfgKey() const
    {
        return optionalArgs_.schedCfgKey;
    }

    inline const uint32_t GetDeviceId() const
    {
        return deviceId_;
    }

    inline const uint32_t GetQueueType() const
    {
        return optionalArgs_.queueType;
    }

private:
    uint32_t id_;
    uint32_t deviceId_;
    OptionalArg optionalArgs_ = {};
    std::string entityDesc_;
    dgw::EntityPtr entity_ = nullptr;
};

class EntityInfoHash {
public:
    size_t operator()(const EntityInfo &info) const
    {
        return std::hash<uint32_t>()(info.GetId()) ^ std::hash<uint16_t>()(static_cast<uint16_t>(info.GetType()));
    }
};

using EntityInfoPtr = std::shared_ptr<EntityInfo>;
using EntityInfoSet = std::unordered_set<EntityInfo, EntityInfoHash>;
using MapEnitityInfoToInfoSet = std::unordered_map<EntityInfo, EntityInfoSet, EntityInfoHash>;

class BindRelation {
public:
    static BindRelation &GetInstance();

    ~BindRelation() = default;

    BindRelation(const BindRelation &) = delete;

    BindRelation &operator=(const BindRelation &) = delete;

    BindRelation(BindRelation &&) = delete;

    BindRelation &operator=(BindRelation &&) = delete;

    /**
     * create relation srcEntity->dstEntity.
     * @param srcEntity src queue
     * @param dstEntity destination queue
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus Bind(EntityInfo &srcEntity, EntityInfo &dstEntity, const uint32_t resIndex = 0U);

    /**
     * delete relation srcEntity->dstEntity.
     * @param srcEntity src queue id
     * @param dstEntity destination queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus UnBind(EntityInfo &srcEntity, EntityInfo &dstEntity, const uint32_t resIndex = 0U);

    /**
     * delete relation srcEntity->*.
     * @param srcEntity src queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus UnBindBySrc(const EntityInfo& srcEntity);

    /**
     * delete relation *->dstEntity.
     * @param dstEntity destination queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus UnBindByDst(const EntityInfo& dstEntity);

    /**
     * order subscribe queue id by topology.
     */
    void Order(const uint32_t index = 0U);

    /**
     * create group.
     * @param entities entity in group
     * @param groupId group id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus CreateGroup(const std::vector<EntityInfoPtr> &entities, uint32_t &groupId);

    /**
     * delete group.
     * @param groupId group id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus DeleteGroup(const uint32_t groupId);

    /**
     * get src to destination relation.
     * @return src to destination relation
     */
    const MapEnitityInfoToInfoSet &GetSrcToDstRelation() const;

    /* *
     * get destination to src relation.
     * @return destination to src relation
     */
    const MapEnitityInfoToInfoSet &GetDstToSrcRelation() const;

    /* *
     * Get ordered subscribe queue.
     * @return ordered subscribe queue id
     */
    const std::vector<EntityInfo> &GetOrderedSubscribeQueueId() const;

    /**
     * Get bind size.
     * @return size of all binds
     */
    uint32_t CountBinds() const;

    /**
     * Get abnormal bind size.
     * @return size of all binds
     */
    uint32_t CountAbnormalBinds() const;

    /**
     * Get group config.
     * @return endpoint entity info in current group
     */
    const std::vector<EntityInfoPtr> &GetEntitiesInGroup(const uint32_t groupId) const;

    BqsStatus UnBindRelationBySrc(const EntityInfo &srcEntity);

    BqsStatus UnBindRelationByDst(const EntityInfo &dstEntity);

    void MarkAbnormalSrc(const EntityInfo &srcEntity);

    void MarkAbnormalDst(const EntityInfo &dstEntity);

    const MapEnitityInfoToInfoSet &GetAbnormalSrcToDstRelation() const;

    const MapEnitityInfoToInfoSet &GetAbnormalDstToSrcRelation() const;

    BqsStatus GetBindRelationIndex(const EntityInfo &srcEntity, const EntityInfo &dstEntity, uint32_t &index) const;

    const MapEnitityInfoToInfoSet &GetSrcToDstExtraRelation() const;

    const MapEnitityInfoToInfoSet &GetDstToSrcExtraRelation() const;

    const std::vector<EntityInfo> &GetOrderedSubscribeQueueIdExtra() const;

    BqsStatus GetBindIndexBySrc(const EntityInfo &srcEntity, uint32_t &index) const;

    BqsStatus ClearInputQueue(const uint32_t index, const std::unordered_set<uint32_t>& keySet);

    BqsStatus MakeSureOutputCompletion(const uint32_t index, const std::unordered_set<uint32_t>& keySet);

    void ClearAbnormalEntityInfo(const uint32_t index);

    void AppendAbnormalEntity(const EntityInfo &info, const dgw::EntityDirection direction, const uint32_t index);

    void UpdateRelation(const uint32_t index);

private:
    BindRelation() = default;

    /**
     * check whether can add relation srcEntity->dstEntity.
     * @param srcEntity src queue id
     * @param dstEntity destination queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus CheckBind(const EntityInfo& srcEntity, const EntityInfo& dstEntity,
        const uint32_t resIndex, uint32_t &index) const;

    /**
     * check whether exist multi-layer bind relation.
     * @param srcEntity src entity
     * @param dstEntity dst entity
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus CheckMultiLayerBind(const EntityInfo& srcEntity, const EntityInfo& dstEntity, const uint32_t index) const;

    /**
     * check whether entity exist in group.
     * @param src src entity
     * @param dst dst entity
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus CheckEntityExistInGroup(const EntityInfo& src, const EntityInfo& dst, const uint32_t resIndex = 0U) const;

    /**
     * del relation from srcToDstRelation_
     * @param srcEntity src queue id
     * @param dstEntity destination queue id
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus DelSrcToDst(const EntityInfo& srcEntity, const EntityInfo& dstEntity, const uint32_t index = 0U);

    /**
     * add relation to srcToDstRelation_
     * @param srcEntity src queue id
     * @param dstEntity destination queue id
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus AddSrcToDst(EntityInfo &srcEntity, EntityInfo &dstEntity, const uint32_t index = 0U);

    /**
     * del relation from dstToSrcRelation_
     * @param srcEntity src queue id
     * @param dstEntity destination queue id
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus DelDstToSrc(const EntityInfo& srcEntity, const EntityInfo& dstEntity, const uint32_t index);

    /**
     * del relation to dstToSrcRelation_
     * @param srcEntity src queue id
     * @param dstEntity destination queue id
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus AddDstToSrc(EntityInfo &srcEntity, EntityInfo &dstEntity, const uint32_t index = 0U);

    /**
     * generate group id
     * @return group id
     */
    uint32_t GenerateGroupId();

    /**
     * Create entity
     * @param src src entity info
     * @param dst dst entity info
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus CreateEntity(const EntityInfo &src, const EntityInfo &dst, const uint32_t resIndex = 0U);

    /**
     * Create entity
     * @param info entity info
     * @param isSrc is src
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus CreateEntity(const EntityInfo &info, const bool isSrc, const uint32_t resIndex);

    /**
     * create entity for group
     * @param groupEntity group entity
     * @param isSrc is src
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus CreateEntityForGroup(const EntityInfo &groupEntity, const bool isSrc, const uint32_t resIndex);

    /**
     * Delete entity
     * @param info entity info
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus DeleteEntity(const EntityInfo &info, const bool isSrc, const uint32_t resIndex = 0U) const;

    /**
     * delete entity for group
     * @param groupId group id
     * @return BQS_STATUS_OK:success, other:exist
     */
    BqsStatus DeleteEntityForGroup(const uint32_t queueType, const uint32_t deviceId,
        const uint32_t groupId, const dgw::EntityDirection direction, const uint32_t resIndex) const;

    /**
     * subscribe event
     * @param subscribeEntity entity info
     * @param eventType event type
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus SubscribeEvent(const EntityInfo &subscribeEntity, const EventType eventType,
        const uint32_t index) const;

    /**
     * unsubscribe event
     * @param subscribeEntity entity info
     * @param eventType event type
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus UnsubscribeEvent(const EntityInfo &subscribeEntity, const EventType eventType,
        const uint32_t index) const;

    /**
     * update subscribe event
     * @param subscribeEntity entity info
     * @param eventType event type
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus UpdateSubscribeEvent(const EntityInfo &subscribeEntity, const EventType eventType,
        const uint32_t index = 0U) const;

    /**
     * check whether can execute unbind for entity
     * @param entity entity info
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus CheckUnBind(const EntityInfo &entity) const;

    /**
     * set entityptr for entityInfo
     * @param entitiInfo to expand
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus SetEntityPtr(EntityInfo &entityInfo, const dgw::EntityDirection direction, const uint32_t index) const;

    void UnBindAbnormalRelationBySrc(const EntityInfo &srcEntity);

    void UnBindAbnormalRelationByDst(const EntityInfo &dstEntity);

    void DelAbnormalSrcToDst(const EntityInfo &srcEntity, const EntityInfo &dstEntity);

    void DelAbnormalDstToSrc(const EntityInfo &srcEntity, const EntityInfo &dstEntity);

    BqsStatus GetBindIndexByDst(const EntityInfo &srcEntity, uint32_t &index) const;

    void OrderOneTable(std::vector<EntityInfo> &orderedSubscribeQueueId,
        const MapEnitityInfoToInfoSet &srcToDstRelation,
        const MapEnitityInfoToInfoSet &dstToSrcRelation);

    // a queue can be bound to multi queue.
    MapEnitityInfoToInfoSet srcToDstRelation_;

    // a queue can bind to only one queue
    MapEnitityInfoToInfoSet dstToSrcRelation_;

    // abnormal route src->dst.
    MapEnitityInfoToInfoSet abnormalSrcToDst_;

    // abnormal route dst->src
    MapEnitityInfoToInfoSet abnormalDstToSrc_;

    // subscribed queue ordered by topology
    std::vector<EntityInfo> orderedSubscribeQueueId_;

    // group config   key: group id; value: endpoint entify in group
    std::unordered_map<uint32_t, std::vector<EntityInfoPtr>> allGroupConfig_;
    std::unordered_map<uint32_t, std::pair<uint32_t, uint32_t>> group2ResIndex_;

    // whether has loop in relation
    bool isHasLoop_ = false;

    // spin lock for generate group id
    SpinLock lockForGroup_;

     // a queue can be bound to multi queue.
    MapEnitityInfoToInfoSet srcToDstRelationExtra_;

    // a queue can bind to only one queue
    MapEnitityInfoToInfoSet dstToSrcRelationExtra_;

    std::vector<EntityInfo> orderedSubscribeQueueIdExtra_;

    std::vector<EntityInfo> abnormalSrc_;
    std::vector<EntityInfo> abnormalDst_;
};
}  // namespace bqs
#endif  // QUEUE_SCHEDULE_BIND_RELATION_H