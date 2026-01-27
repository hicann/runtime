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
#include <atomic>
#include <numeric>
#include <queue>
#include <algorithm>
#include "common/bqs_log.h"
#include "subscribe_manager.h"
#include "statistic_manager.h"
#include "entity_manager.h"
#include "schedule_config.h"
#include "hccl/comm_channel_manager.h"

namespace bqs {
namespace {
// RELATION_UPPER_BOUND: 64 * 1024
constexpr const uint32_t RELATION_UPPER_BOUND = 65536U;
} // namespace

BindRelation &BindRelation::GetInstance()
{
    static BindRelation instance;
    return instance;
}

BqsStatus BindRelation::CheckMultiLayerBind(const EntityInfo& srcEntity, const EntityInfo& dstEntity,
    const uint32_t index) const
{
    const MapEnitityInfoToInfoSet &srcToDstRelation = (index == 0) ? srcToDstRelation_ : srcToDstRelationExtra_;
    const MapEnitityInfoToInfoSet &dstToSrcRelation = (index == 0) ? dstToSrcRelation_ : dstToSrcRelationExtra_;

    const auto srcToDstIter = srcToDstRelation.find(dstEntity);
    if (srcToDstIter != srcToDstRelation.end()) {
        auto dstSets = srcToDstIter->second;
        for (auto itDst = dstSets.begin(); itDst != dstSets.end(); ++itDst) {
            if ((*itDst).GetType() == dgw::EntityType::ENTITY_TAG) {
                BQS_LOG_WARN("Bind relation[%s->%s] ignore check multi layer bind.",
                    (srcToDstIter->first).ToString().c_str(), (*itDst).ToString().c_str());
                return BQS_STATUS_OK;
            }
        }

        BQS_LOG_ERROR("Bind relation[%s->*] already exists, can't add relation [%s->%s], suggest to add "
            "relation[%s->*] directly.",
            (srcToDstIter->first).ToString().c_str(), srcEntity.ToString().c_str(),
            dstEntity.ToString().c_str(), srcEntity.ToString().c_str());
        return BQS_STATUS_PARAM_INVALID;
    }

    const auto dstToSrcIter = dstToSrcRelation.find(srcEntity);
    if (dstToSrcIter != dstToSrcRelation.end()) {
        BQS_LOG_ERROR("Bind relation[*->%s] already exists, can't add relation [%s->%s], suggest to add "
            "relation[*->%s] directly.",
            (dstToSrcIter->first).ToString().c_str(), srcEntity.ToString().c_str(),
            dstEntity.ToString().c_str(), dstEntity.ToString().c_str());
        return BQS_STATUS_PARAM_INVALID;
    }
    return BQS_STATUS_OK;
}


BqsStatus BindRelation::CheckEntityExistInGroup(const EntityInfo& src, const EntityInfo& dst,
    const uint32_t resIndex) const
{
    if (src.GetType() == dgw::EntityType::ENTITY_GROUP) {
        const auto &entitiesInGroup = GetEntitiesInGroup(src.GetId());
        for (auto iter = entitiesInGroup.begin(); iter != entitiesInGroup.end(); ++iter) {
            const auto &element = (*(*iter));
            if (dst == element) {
                BQS_LOG_ERROR("dst entity[%s] has exist in src group entity[%s].",
                    dst.ToString().c_str(), src.ToString().c_str());
                return BQS_STATUS_PARAM_INVALID;
            }
            const auto existSrcEntity = dgw::EntityManager::Instance(resIndex).GetEntityById(
                element.GetQueueType(), element.GetDeviceId(), element.GetType(),
                element.GetId(), dgw::EntityDirection::DIRECTION_SEND);
            if ((existSrcEntity != nullptr) &&
                (existSrcEntity->GetHostGroupId() != static_cast<int32_t>(src.GetId()))) {
                BQS_LOG_ERROR("Entity[%s] in group[%s] exists in other src side.",
                    element.ToString().c_str(), src.ToString().c_str());
                return BQS_STATUS_PARAM_INVALID;
            }
        }
    } else {
        const auto srcEntityPtr = dgw::EntityManager::Instance(resIndex).
            GetEntityById(src.GetQueueType(), src.GetDeviceId(), src.GetType(),
                          src.GetId(), dgw::EntityDirection::DIRECTION_SEND);
        if (srcEntityPtr != nullptr) {
            const int32_t groupId = srcEntityPtr->GetHostGroupId();
            if (groupId != dgw::INVALID_GROUP_ID) {
                BQS_LOG_ERROR("Entity[%s] has exist in group[%d].", src.ToString().c_str(), groupId);
                return BQS_STATUS_PARAM_INVALID;
            }
            BQS_LOG_INFO("Entity[%s] has been created.", src.ToString().c_str());
        }
    }

    if (dst.GetType() == dgw::EntityType::ENTITY_GROUP) {
        const auto &entitiesInGroup = GetEntitiesInGroup(dst.GetId());
        for (auto iter = entitiesInGroup.begin(); iter != entitiesInGroup.end(); ++iter) {
            const auto &element = (*(*iter));
            if (src == element) {
                BQS_LOG_ERROR("src entity[%s] has exist in dst group entity[%s].",
                    src.ToString().c_str(), dst.ToString().c_str());
                return BQS_STATUS_PARAM_INVALID;
            }
            const auto existDstEntity = dgw::EntityManager::Instance(resIndex).
                GetEntityById(element.GetQueueType(), element.GetDeviceId(), element.GetType(),
                              element.GetId(), dgw::EntityDirection::DIRECTION_RECV);
            if ((existDstEntity != nullptr) &&
                (existDstEntity->GetHostGroupId() != static_cast<int32_t>(dst.GetId()))) {
                BQS_LOG_ERROR("Entity[%s] in group[%s] exists in other dst side.",
                    element.ToString().c_str(), dst.ToString().c_str());
                return BQS_STATUS_PARAM_INVALID;
            }
        }
    } else {
        const auto dstEntityPtr = dgw::EntityManager::Instance(resIndex).
            GetEntityById(dst.GetQueueType(), dst.GetDeviceId(), dst.GetType(),
                          dst.GetId(), dgw::EntityDirection::DIRECTION_RECV);
        if (dstEntityPtr != nullptr) {
            const int32_t groupId = dstEntityPtr->GetHostGroupId();
            if (groupId != dgw::INVALID_GROUP_ID) {
                BQS_LOG_ERROR("Entity[%s] has exist in group[%d].", dst.ToString().c_str(), groupId);
                return BQS_STATUS_PARAM_INVALID;
            }
            BQS_LOG_INFO("Entity[%s] has been created.", dst.ToString().c_str());
        }
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::CheckBind(const EntityInfo& srcEntity, const EntityInfo& dstEntity,
    const uint32_t resIndex, uint32_t &index) const
{
    if (srcEntity == dstEntity) {
        BQS_LOG_ERROR("Bind relation[%s->%s] failed, as can't bind to self.", srcEntity.ToString().c_str(),
            dstEntity.ToString().c_str());
        return BQS_STATUS_PARAM_INVALID;
    }

    if (GetBindRelationIndex(srcEntity, dstEntity, index) != BQS_STATUS_OK) {
        BQS_LOG_ERROR("GetBindRelationIndex error");
        return BQS_STATUS_PARAM_INVALID;
    }

    if (resIndex != index) {
        BQS_LOG_INFO("relation[%s->%s] should be processed by threads[%u] while current threads[%u]",
            srcEntity.ToString().c_str(), dstEntity.ToString().c_str(), index, resIndex);
        return BQS_STATUS_OK;
    }

    const MapEnitityInfoToInfoSet &dstToSrcRelation = (index == 0) ? dstToSrcRelation_ : dstToSrcRelationExtra_;
    if (dstToSrcRelation.size() >= RELATION_UPPER_BOUND) {
        BQS_LOG_ERROR("Bind relation[%u->%u] failed, as the maximum number of relation supported is %u, "
            "current number is %zu.",
            srcEntity.GetId(), dstEntity.GetId(), RELATION_UPPER_BOUND, dstToSrcRelation.size());
        return BQS_STATUS_INNER_ERROR;
    }
    const auto dstToSrcIter = dstToSrcRelation.find(dstEntity);
    if ((dstToSrcIter != dstToSrcRelation.end()) && (dstToSrcIter->second.count(srcEntity) != 0U)) {
        BQS_LOG_WARN("Bind relation[%s->%s] already exists, no need bind.", srcEntity.ToString().c_str(),
            dstEntity.ToString().c_str());
        (void)UpdateSubscribeEvent(srcEntity, EventType::ENQUEUE, index);
        (void)UpdateSubscribeEvent(dstEntity, EventType::F2NF, index);
        return BQS_STATUS_OK;
    }

    const auto &abnormalDstToSrcIter = abnormalDstToSrc_.find(dstEntity);
    if ((abnormalDstToSrcIter != abnormalDstToSrc_.end()) && (abnormalDstToSrcIter->second.count(srcEntity) != 0U)) {
        BQS_LOG_WARN("Bind relation[%s->%s] already exists in abnormal bind relations, can not bind.",
                     srcEntity.ToString().c_str(), dstEntity.ToString().c_str());
        return BQS_STATUS_OK;
    }

    auto ret = CheckMultiLayerBind(srcEntity, dstEntity, index);
    if (ret != BQS_STATUS_OK) {
        return ret;
    }

    // check whether entity exist in group
    ret = CheckEntityExistInGroup(srcEntity, dstEntity, index);
    if (ret != BQS_STATUS_OK) {
        return ret;
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::SetEntityPtr(EntityInfo &entityInfo, const dgw::EntityDirection direction,
    const uint32_t index) const
{
    if (entityInfo.GetEntity() != nullptr) {
        return BQS_STATUS_OK;
    }

    const auto entity = dgw::EntityManager::Instance(index).GetEntityById(
        entityInfo.GetQueueType(), entityInfo.GetDeviceId(), entityInfo.GetType(), entityInfo.GetId(), direction);
    if (entity == nullptr) {
        BQS_LOG_ERROR("Missing entity [%s].", entityInfo.ToString().c_str());
        return BQS_STATUS_INNER_ERROR;
    }
    entityInfo.SetEntity(entity);
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::AddSrcToDst(EntityInfo &srcEntity, EntityInfo &dstEntity, const uint32_t index)
{
    BqsStatus ret = BQS_STATUS_OK;
    if ((SetEntityPtr(srcEntity, dgw::EntityDirection::DIRECTION_SEND, index) != BQS_STATUS_OK) ||
        (SetEntityPtr(dstEntity, dgw::EntityDirection::DIRECTION_RECV, index) != BQS_STATUS_OK)) {
        BQS_LOG_ERROR("Bind relation add [%s->%s] failed becuause of missing entity.",
                      srcEntity.ToString().c_str(), dstEntity.ToString().c_str());
        return BQS_STATUS_INNER_ERROR;
    }

    MapEnitityInfoToInfoSet &srcToDstRelation = (index == 0) ? srcToDstRelation_ : srcToDstRelationExtra_;
    const auto iter = srcToDstRelation.find(srcEntity);
    if (iter == srcToDstRelation.end()) {
        ret = SubscribeEvent(srcEntity, EventType::ENQUEUE, index);
        if (ret != BQS_STATUS_OK) {
            BQS_LOG_ERROR("Bind relation add [%s->%s] failed, as subscribe failed, ret=%d.",
                srcEntity.ToString().c_str(), dstEntity.ToString().c_str(), static_cast<int32_t>(ret));
            return ret;
        } else {
            (void)srcToDstRelation.emplace(
                std::make_pair(srcEntity, EntityInfoSet{ dstEntity }));
        }
    } else {
        (void)iter->second.emplace(dstEntity);
    }

    return ret;
}

BqsStatus BindRelation::AddDstToSrc(EntityInfo &srcEntity, EntityInfo &dstEntity, const uint32_t index)
{
    BqsStatus ret = BQS_STATUS_OK;

    if ((SetEntityPtr(srcEntity, dgw::EntityDirection::DIRECTION_SEND, index) != BQS_STATUS_OK) ||
        (SetEntityPtr(dstEntity, dgw::EntityDirection::DIRECTION_RECV, index) != BQS_STATUS_OK)) {
        BQS_LOG_ERROR("Bind relation add [%s->%s] failed becuause of missing entity.",
                      srcEntity.ToString().c_str(), dstEntity.ToString().c_str());
        return BQS_STATUS_INNER_ERROR;
    }

    MapEnitityInfoToInfoSet &dstToSrcRelation = (index == 0) ? dstToSrcRelation_ : dstToSrcRelationExtra_;
    const auto iter = dstToSrcRelation.find(dstEntity);
    if (iter == dstToSrcRelation.end()) {
        ret = SubscribeEvent(dstEntity, EventType::F2NF, index);
        if (ret != BQS_STATUS_OK) {
            BQS_LOG_ERROR("Bind relation add [%s->%s] failed, as subscribe f2nf failed, ret=%d.",
                srcEntity.ToString().c_str(), dstEntity.ToString().c_str(), static_cast<int32_t>(ret));
        } else {
            (void)dstToSrcRelation.emplace(
                std::make_pair(dstEntity, EntityInfoSet{ srcEntity }));
        }
    } else {
        (void)iter->second.emplace(srcEntity);
    }
    return ret;
}

BqsStatus BindRelation::DelSrcToDst(const EntityInfo& srcEntity, const EntityInfo& dstEntity, const uint32_t index)
{
    auto ret = BQS_STATUS_OK;
    MapEnitityInfoToInfoSet &srcToDstRelation = (index == 0) ? srcToDstRelation_ : srcToDstRelationExtra_;
    const auto iter = srcToDstRelation.find(srcEntity);
    if (iter == srcToDstRelation.end()) {
        BQS_LOG_WARN("Bind relation[%s->%s] dst doesn't exist, no need unbind.", srcEntity.ToString().c_str(),
            dstEntity.ToString().c_str());
        return BQS_STATUS_OK;
    }

    (void)iter->second.erase(dstEntity);
    if (iter->second.empty()) {
        (void)UnsubscribeEvent(srcEntity, EventType::ENQUEUE, index);
        BQS_LOG_INFO("delete route [%s->*]", srcEntity.ToString().c_str());
        (void)srcToDstRelation.erase(iter);
    }
    
    return ret;
}

BqsStatus BindRelation::DelDstToSrc(const EntityInfo& srcEntity, const EntityInfo& dstEntity, const uint32_t index)
{
    MapEnitityInfoToInfoSet &dstToSrcRelation = (index == 0) ? dstToSrcRelation_ : dstToSrcRelationExtra_;
    auto ret = BQS_STATUS_OK;
    const auto iter = dstToSrcRelation.find(dstEntity);
    if (iter == dstToSrcRelation.end()) {
        BQS_LOG_WARN("Bind relation[%s->%s] dst doesn't exist, no need unbind.", srcEntity.ToString().c_str(),
            dstEntity.ToString().c_str());
        return BQS_STATUS_OK;
    }

    (void)iter->second.erase(srcEntity);
    if (iter->second.empty()) {
        (void)UnsubscribeEvent(dstEntity, EventType::F2NF, index);
        (void)dstToSrcRelation.erase(iter);
    }

    return ret;
}

BqsStatus BindRelation::Bind(EntityInfo &srcEntity, EntityInfo &dstEntity, const uint32_t resIndex)
{
    uint32_t index = 0;
    auto ret = CheckBind(srcEntity, dstEntity, resIndex, index);
    if (ret != BQS_STATUS_OK) {
        return ret;
    }

    if (index != resIndex) {
        return BQS_STATUS_RETRY;
    }

    ret = CreateEntity(srcEntity, dstEntity, index);
    if (ret != BQS_STATUS_OK) {
        return ret;
    }

    ret = AddSrcToDst(srcEntity, dstEntity, index);
    if (ret != BQS_STATUS_OK) {
        (void) DeleteEntity(srcEntity, true, index);
        (void) DeleteEntity(dstEntity, false, index);
        return ret;
    }

    ret = AddDstToSrc(srcEntity, dstEntity, index);
    if (ret != BQS_STATUS_OK) {
        // roll back
        (void) DelSrcToDst(srcEntity, dstEntity, index);
        (void) DeleteEntity(srcEntity, true, index);
        (void) DeleteEntity(dstEntity, false, index);
        BQS_LOG_ERROR("Bind relation add [%s->%s] failed, as subscribe f2nf failed, ret=%d.",
            srcEntity.ToString().c_str(), dstEntity.ToString().c_str(), static_cast<int32_t>(ret));
        return ret;
    }

    BQS_LOG_RUN_INFO("Bind relation add {src[%s]->dst[%s]} success on resIndex[%u].",
        srcEntity.ToString().c_str(), dstEntity.ToString().c_str(), resIndex);
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::UnBind(EntityInfo &srcEntity, EntityInfo &dstEntity, const uint32_t resIndex)
{
    // check unbind for src and dst entity
    auto ret = CheckUnBind(srcEntity);
    if (ret != BQS_STATUS_OK) {
        return ret;
    }
    ret = CheckUnBind(dstEntity);
    if (ret != BQS_STATUS_OK) {
        return ret;
    }

    uint32_t index = 0U;
    if (GetBindIndexBySrc(srcEntity, index) != BQS_STATUS_OK) {
        BQS_LOG_WARN("GetBindIndexBySrc failed");
        return BQS_STATUS_OK;
    }
    if (index != resIndex) {
        return BQS_STATUS_RETRY;
    }

    ret = DelSrcToDst(srcEntity, dstEntity, resIndex);
    if (ret == BQS_STATUS_OK) {
        ret = DelDstToSrc(srcEntity, dstEntity, resIndex);
        if (ret != BQS_STATUS_OK) {
            // roll back
            (void)AddSrcToDst(srcEntity, dstEntity, resIndex);
        }
    }
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Bind relation del [%s->%s] failed, bqsStatus=%d.",
            srcEntity.ToString().c_str(), dstEntity.ToString().c_str(), static_cast<int32_t>(ret));
        return ret;
    }

    // no roll back if delete entity failed
    // check src entity whether exist multi bind
    auto &srcToDstRelation = (resIndex == 0U) ? srcToDstRelation_ : srcToDstRelationExtra_;
    auto &dstToSrcRelation = (resIndex == 0U) ? dstToSrcRelation_ : dstToSrcRelationExtra_;
    const auto srcIter = srcToDstRelation.find(srcEntity);
    if (srcIter == srcToDstRelation.end()) {
        (void)DeleteEntity(srcEntity, true, resIndex);
    }
    // check dst entity whether exist multi bind
    const auto dstIter = dstToSrcRelation.find(dstEntity);
    if (dstIter == dstToSrcRelation.end()) {
        (void)DeleteEntity(dstEntity, false, resIndex);
    }

    // delete abnormal bind relation
    DelAbnormalSrcToDst(srcEntity, dstEntity);
    DelAbnormalDstToSrc(srcEntity, dstEntity);

    return BQS_STATUS_OK;
}

BqsStatus BindRelation::UnBindBySrc(const EntityInfo& srcEntity)
{
    UnBindAbnormalRelationBySrc(srcEntity);
    return UnBindRelationBySrc(srcEntity);
}

BqsStatus BindRelation::UnBindRelationBySrc(const EntityInfo& srcEntity)
{
    uint32_t index = 0;
    if (GetBindIndexBySrc(srcEntity, index) != BQS_STATUS_OK) {
        BQS_LOG_WARN("GetBindIndexBySrc failed");
        return BQS_STATUS_OK;
    }

    MapEnitityInfoToInfoSet &srcToDstRelation = (index == 0) ? srcToDstRelation_ : srcToDstRelationExtra_;
    const auto srcToDstIter = srcToDstRelation.find(srcEntity);
    if (srcToDstIter == srcToDstRelation.end()) {
        BQS_LOG_WARN("No relation [%s->*] exists, no need unbind", srcEntity.ToString().c_str());
        return BQS_STATUS_OK;
    }

    const auto ret = UnsubscribeEvent(srcEntity, EventType::ENQUEUE, index);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("Unsubscribe queue[%s] failed, bqsStatus=%d.", srcEntity.ToString().c_str(),
            static_cast<int32_t>(ret));
        return BQS_STATUS_DRIVER_ERROR;
    }

    for (const auto &dstEntity : srcToDstIter->second) {
        (void)DelDstToSrc(srcEntity, dstEntity, index);
        // delete dst entity
        const auto dstIter = dstToSrcRelation_.find(dstEntity);
        if (dstIter == dstToSrcRelation_.end()) {
            (void)DeleteEntity(dstEntity, false, index);
        }
    }

    (void)srcToDstRelation.erase(srcToDstIter);
    // delete src entity
    (void)DeleteEntity(srcEntity, true, index);
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::UnBindByDst(const EntityInfo& dstEntity)
{
    UnBindAbnormalRelationByDst(dstEntity);
    return UnBindRelationByDst(dstEntity);
}

BqsStatus BindRelation::UnBindRelationByDst(const EntityInfo& dstEntity)
{
    uint32_t index = 0;
    if (GetBindIndexByDst(dstEntity, index) != BQS_STATUS_OK) {
        BQS_LOG_WARN("GetBindIndexByDst failed");
        return BQS_STATUS_OK;
    }

    MapEnitityInfoToInfoSet &dstToSrcRelation = (index == 0) ? dstToSrcRelation_ : dstToSrcRelationExtra_;
    const auto dstToSrcIter = dstToSrcRelation.find(dstEntity);
    if (dstToSrcIter == dstToSrcRelation.end()) {
        BQS_LOG_WARN("No bind relation[*->%s] exists, no need unbind.", dstEntity.ToString().c_str());
        return BQS_STATUS_OK;
    }

    auto ret = UnsubscribeEvent(dstEntity, EventType::F2NF, index);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("UnsubscribeFullToNotFull queue[%s] failed, bqsStatus=%d.", dstEntity.ToString().c_str(),
            static_cast<int32_t>(ret));
        return BQS_STATUS_DRIVER_ERROR;
    }

    for (const auto &srcEntity : dstToSrcIter->second) {
        ret = DelSrcToDst(srcEntity, dstEntity, index);
        if (ret != BQS_STATUS_OK) {
            break;
        }
        // delete src entity
        const auto srcIter = srcToDstRelation_.find(srcEntity);
        if (srcIter == srcToDstRelation_.end()) {
            (void)DeleteEntity(srcEntity, true, index);
        }
    }

    if (ret == BQS_STATUS_OK) {
        (void)dstToSrcRelation.erase(dstToSrcIter);
        // delete dst entity
        (void)DeleteEntity(dstEntity, false, index);
    } else {
        BQS_LOG_ERROR("Bind relation del [*->%s] failed, bqsStatus=%d.", dstEntity.ToString().c_str(),
            static_cast<int32_t>(ret));
    }

    return ret;
}

// topsort
void BindRelation::Order(const uint32_t index)
{
    StatisticManager::GetInstance().BindNum(CountBinds());
    StatisticManager::GetInstance().AbnormalBindNum(CountAbnormalBinds());
    StatisticManager::GetInstance().SubscribeNum(
        static_cast<uint32_t>(srcToDstRelation_.size() + srcToDstRelationExtra_.size()));
    if (index == 0U) {
        OrderOneTable(orderedSubscribeQueueId_, srcToDstRelation_, dstToSrcRelation_);
    } else {
        OrderOneTable(orderedSubscribeQueueIdExtra_, srcToDstRelationExtra_, dstToSrcRelationExtra_);
    }
}

void BindRelation::OrderOneTable(std::vector<EntityInfo> &orderedSubscribeQueueId,
    const MapEnitityInfoToInfoSet &srcToDstRelation, const MapEnitityInfoToInfoSet &dstToSrcRelation)
{
    isHasLoop_ = false;
    orderedSubscribeQueueId.clear();
    orderedSubscribeQueueId.reserve(srcToDstRelation.size());
    std::unordered_map<EntityInfo, uint32_t, EntityInfoHash> inDegrees;

    // as queue input edge is only one, so we can use order by traverse
    std::queue<EntityInfo> subscribeQueue;
    for (auto &iter : srcToDstRelation) {
        // No input queue is head queue
        if (dstToSrcRelation.count(iter.first) == 0U) {
            (void)subscribeQueue.emplace(iter.first);
        }
        for (const auto &dstQ : iter.second) {
            const auto degIter = inDegrees.find(dstQ);
            if (degIter != inDegrees.end()) {
                degIter->second++;
            } else {
                inDegrees[dstQ] = 1U;
            }
        }
    }

    // protect for loop
    while (!subscribeQueue.empty()) {
        auto queueId = subscribeQueue.front();
        subscribeQueue.pop();
        const auto &dstQueueIter = srcToDstRelation.find(queueId);
        if (dstQueueIter == srcToDstRelation.end()) {
            continue;
        }

        orderedSubscribeQueueId.emplace_back(dstQueueIter->first);
        for (auto dstQueueId : dstQueueIter->second) {
            --(inDegrees[dstQueueId]);
            if (inDegrees[dstQueueId] == 0U) {
                (void)subscribeQueue.emplace(dstQueueId);
            }
        }
    }

    if (orderedSubscribeQueueId.size() != srcToDstRelation.size()) {
        BQS_LOG_ERROR("orderedSubscribeQueueId.size is [%zu] is not equal to srcToDstRelation.size[%zu], "
            "may be with loop in bind relation, use unordered instead.",
            orderedSubscribeQueueId.size(), srcToDstRelation.size());
        isHasLoop_ = true;
        orderedSubscribeQueueId.clear();
        for (auto &srcToDstIter : srcToDstRelation) {
            (void)orderedSubscribeQueueId.emplace_back(srcToDstIter.first);
        }
    }
}

const MapEnitityInfoToInfoSet &BindRelation::GetSrcToDstRelation() const
{
    return srcToDstRelation_;
}

const MapEnitityInfoToInfoSet &BindRelation::GetDstToSrcRelation() const
{
    return dstToSrcRelation_;
}

const MapEnitityInfoToInfoSet &BindRelation::GetAbnormalSrcToDstRelation() const
{
    return abnormalSrcToDst_;
}

const MapEnitityInfoToInfoSet &BindRelation::GetAbnormalDstToSrcRelation() const
{
    return abnormalDstToSrc_;
}

const std::vector<EntityInfo> &BindRelation::GetOrderedSubscribeQueueId() const
{
    return orderedSubscribeQueueId_;
}

uint32_t BindRelation::CountBinds() const
{
    uint32_t bindCount = std::accumulate(std::begin(srcToDstRelation_), std::end(srcToDstRelation_), 0U,
        [](const uint32_t previous,
        const std::pair<EntityInfo, EntityInfoSet> &dstQueueId) {
            return previous + static_cast<uint32_t>(dstQueueId.second.size());
        });
    if (GlobalCfg::GetInstance().GetNumaFlag()) {
        bindCount += std::accumulate(std::begin(srcToDstRelationExtra_), std::end(srcToDstRelationExtra_), 0U,
            [](const uint32_t previous,
            const std::pair<EntityInfo, EntityInfoSet> &dstQueueId) {
                return previous + static_cast<uint32_t>(dstQueueId.second.size());
            });
    }
    return bindCount;
}

uint32_t BindRelation::CountAbnormalBinds() const
{
    const uint32_t bindCount = std::accumulate(std::begin(abnormalSrcToDst_), std::end(abnormalSrcToDst_), 0U,
        [](const uint32_t previous,
        const std::pair<EntityInfo, EntityInfoSet> &abnormalBinds) {
            return previous + static_cast<uint32_t>(abnormalBinds.second.size());
        });
    return bindCount;
}

BqsStatus BindRelation::CreateGroup(const std::vector<EntityInfoPtr> &entities, uint32_t &groupId)
{
    if (entities.empty()) {
        BQS_LOG_ERROR("entity is empty.");
        return BQS_STATUS_PARAM_INVALID;
    }

    // generate group id
    groupId = GenerateGroupId();
    // save to allGroupConfig
    const auto ret = allGroupConfig_.emplace(std::make_pair(groupId, entities));
    if (!ret.second) {
        BQS_LOG_ERROR("create group [%u] failed.", groupId);
        return BQS_STATUS_GROUP_HAS_EXIST;
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::DeleteGroup(const uint32_t groupId)
{
    const auto indexIter = group2ResIndex_.find(groupId);
    if (indexIter != group2ResIndex_.end()) {
        const MapEnitityInfoToInfoSet &srcToDstRelation =
            (indexIter->second.first == 0U) ? srcToDstRelation_ : srcToDstRelationExtra_;
        const MapEnitityInfoToInfoSet &dstToSrcRelation =
            (indexIter->second.first == 0U) ? dstToSrcRelation_ : dstToSrcRelationExtra_;
        OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        const EntityInfo group(groupId, indexIter->second.second, &args);
        if ((srcToDstRelation.find(group) != srcToDstRelation.end()) ||
            (dstToSrcRelation.find(group) != dstToSrcRelation.end())) {
            BQS_LOG_ERROR("group[%u] still exist in routes. Please delete route first.", groupId);
            return BQS_STATUS_GROUP_EXIST_IN_ROUTE;
        }
    }

    const auto iter = allGroupConfig_.find(groupId);
    if (iter == allGroupConfig_.end()) {
        BQS_LOG_RUN_INFO("group %u does not exist.", groupId);
        return BQS_STATUS_OK;
    }
    for (auto infoPtr : iter->second) {
        if (infoPtr->GetType() == dgw::EntityType::ENTITY_TAG) {
            (void)dgw::CommChannelManager::GetInstance().DeleteCommChannel(*(infoPtr->GetCommChannel()));
        }
    }
    (void)allGroupConfig_.erase(iter);
    if (indexIter != group2ResIndex_.end()) {
        (void) group2ResIndex_.erase(indexIter);
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::CreateEntity(const EntityInfo &src, const EntityInfo &dst, const uint32_t resIndex)
{
    // when one src entity bind with multi dst entities, src entity may has been created
    const auto srcRet = CreateEntity(src, true, resIndex);
    if ((srcRet != BQS_STATUS_OK) && (srcRet != BQS_STATUS_ENTITY_EXIST)) {
        // roolback
        (void) DeleteEntity(src, true, resIndex);
        return srcRet;
    }
    const auto dstRet = CreateEntity(dst, false, resIndex);
    if ((dstRet != BQS_STATUS_OK) && (dstRet != BQS_STATUS_ENTITY_EXIST)) {
        // roolback
        (void) DeleteEntity(dst, false, resIndex);
        if (srcRet == BQS_STATUS_ENTITY_EXIST) {
            (void) DeleteEntity(src, true, resIndex);
        }
        return dstRet;
    }

    // set needTransId for entity: no need check nullptr
    const auto srcEntity = dgw::EntityManager::Instance(resIndex).GetEntityById(
        src.GetQueueType(), src.GetDeviceId(), src.GetType(), src.GetId(), dgw::EntityDirection::DIRECTION_SEND);
    if (srcEntity == nullptr) {
        BQS_LOG_ERROR("Missing entity [%s].", src.ToString().c_str());
        return BQS_STATUS_INNER_ERROR;
    }
    if (srcEntity->IsNeedTransId()) {
        return BQS_STATUS_OK;
    }
    // if dst entity is group, src entity need get transId
    if (dst.GetType() == dgw::EntityType::ENTITY_GROUP) {
        srcEntity->SetNeedTransId(true);
        BQS_LOG_INFO("entity[%s] need get transId when scheduled because dst entity[%s].",
            src.ToString().c_str(), dst.ToString().c_str());
        return BQS_STATUS_OK;
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::CreateEntity(const EntityInfo &info, const bool isSrc, const uint32_t resIndex)
{
    // check entity exist
    const dgw::EntityDirection direction = isSrc ? dgw::EntityDirection::DIRECTION_SEND :
                                                   dgw::EntityDirection::DIRECTION_RECV;
    const auto entity = dgw::EntityManager::Instance(resIndex).GetEntityById(
        info.GetQueueType(), info.GetDeviceId(), info.GetType(), info.GetId(), direction);
    if (entity != nullptr) {
        BQS_LOG_INFO("Entity[%s] has been created, no need created again.", info.ToString().c_str());
        return BQS_STATUS_ENTITY_EXIST;
    }

    // create entity for [group]
    if (info.GetType() == dgw::EntityType::ENTITY_GROUP) {
        const auto ret = CreateEntityForGroup(info, isSrc, resIndex);
        return ret;
    }
    // create entify for [queue or channel]
    dgw::EntityMaterial material = {};
    material.eType = info.GetType();
    material.direction = direction;
    material.id = info.GetId();
    material.globalId = info.GetGlobalId();
    material.uuId = info.GetUuId();
    material.schedCfgKey = info.GetSchedCfgKey();
    material.resId = info.GetDeviceId();
    material.channel = info.GetCommChannel();
    material.queueType = info.GetQueueType();
    if (nullptr == dgw::EntityManager::Instance(resIndex).CreateEntity(material)) {
        BQS_LOG_ERROR("Create entityPtr for entity[%s] failed.", info.ToString().c_str());
        return BQS_STATUS_INNER_ERROR;
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::CreateEntityForGroup(const EntityInfo &groupEntity, const bool isSrc,
    const uint32_t resIndex)
{
    const uint32_t groupId = groupEntity.GetId();
    BQS_LOG_INFO("Begin to create entityPtr for group[%u].", groupId);
    const std::vector<EntityInfoPtr> &entities = GetEntitiesInGroup(groupId);
    if (entities.empty()) {
        BQS_LOG_ERROR("group %u does not exist.", groupId);
        return BQS_STATUS_INNER_ERROR;
    }

    const dgw::EntityDirection direction = isSrc ? dgw::EntityDirection::DIRECTION_SEND :
                                                   dgw::EntityDirection::DIRECTION_RECV;
    std::vector<dgw::EntityPtr> entityPtrVec;
    // create entity in group
    for (auto &info : entities) {
        dgw::EntityMaterial material = {};
        material.eType = info->GetType();
        material.direction = direction;
        material.id = info->GetId();
        material.globalId = info->GetGlobalId();
        material.uuId = info->GetUuId();
        material.schedCfgKey = info->GetSchedCfgKey();
        material.resId = info->GetDeviceId();
        material.channel = info->GetCommChannel();
        material.hostGroupId = static_cast<int32_t>(groupId);
        material.queueType = info->GetQueueType();
        auto entityPtr = dgw::EntityManager::Instance(resIndex).CreateEntity(material);
        if (entityPtr == nullptr) {
            BQS_LOG_ERROR("Create entityPtr for entity[%s] failed.", info->ToString().c_str());
            return BQS_STATUS_INNER_ERROR;
        }
        entityPtrVec.emplace_back(entityPtr);
        // src entity in group need transId
        entityPtr->SetNeedTransId(true);
        BQS_LOG_RUN_INFO("Entity group[%u] add element[%s] success.", groupId, info->ToString().c_str());
    }
    // save group
    const dgw::FsmStatus ret = dgw::EntityManager::Instance(resIndex).CreateGroup(groupId, entityPtrVec);
    if (ret != dgw::FsmStatus::FSM_SUCCESS) {
        BQS_LOG_ERROR("Save group[%u] failed.", groupId);
        return BQS_STATUS_INNER_ERROR;
    }
    group2ResIndex_[groupId] = std::make_pair(resIndex, groupEntity.GetDeviceId());

    // create group entity
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_GROUP;
    material.direction = direction;
    material.id = groupId;
    material.globalId = groupEntity.GetGlobalId();
    material.uuId = groupEntity.GetUuId();
    material.schedCfgKey = groupEntity.GetSchedCfgKey();
    material.resId = groupEntity.GetDeviceId();
    material.groupPolicy = groupEntity.GetGroupPolicy();
    material.peerInstanceNum = groupEntity.GetPeerInstanceNum();
    material.localInstanceIndex = groupEntity.GetLocalInstanceIndex();
    material.queueType = groupEntity.GetQueueType();
    const auto groupEntityPtr = dgw::EntityManager::Instance(resIndex).CreateEntity(material);
    if (groupEntityPtr == nullptr) {
        BQS_LOG_ERROR("Create entityPtr for group[%u] failed.", groupId);
        return BQS_STATUS_INNER_ERROR;
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::DeleteEntity(const EntityInfo &info, const bool isSrc, const uint32_t resIndex) const
{
    BQS_LOG_INFO("DeleteEntity: %s", info.ToString().c_str());
    const dgw::EntityDirection direction = isSrc ? dgw::EntityDirection::DIRECTION_SEND :
                                                   dgw::EntityDirection::DIRECTION_RECV;
    // group
    if (info.GetType() == dgw::EntityType::ENTITY_GROUP) {
        return DeleteEntityForGroup(info.GetQueueType(), info.GetDeviceId(), info.GetId(), direction, resIndex);
    }
    // queue or tag
    const auto ret = dgw::EntityManager::Instance(resIndex).DeleteEntity(
        info.GetQueueType(), info.GetDeviceId(), info.GetType(), info.GetId(), direction);
    if (ret != dgw::FsmStatus::FSM_SUCCESS) {
        BQS_LOG_ERROR("Delete entity[%s] failed.", info.ToString().c_str());
        return BQS_STATUS_INNER_ERROR;
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::DeleteEntityForGroup(
    const uint32_t queueType, const uint32_t deviceId, const uint32_t groupId, const dgw::EntityDirection direction,
    const uint32_t resIndex) const
{
    // delete group entity
    dgw::FsmStatus ret = dgw::EntityManager::Instance(resIndex).
        DeleteEntity(queueType, deviceId, dgw::EntityType::ENTITY_GROUP, groupId, direction);
    if (ret != dgw::FsmStatus::FSM_SUCCESS) {
        BQS_LOG_ERROR("Delete group entity[%u] failed.", groupId);
        return BQS_STATUS_INNER_ERROR;
    }
    // delete group
    ret = dgw::EntityManager::Instance(resIndex).DeleteGroup(groupId);
    if (ret != dgw::FsmStatus::FSM_SUCCESS) {
        BQS_LOG_ERROR("Delete group[%u] failed.", groupId);
        return BQS_STATUS_INNER_ERROR;
    }
    // delete entity in group
    const std::vector<EntityInfoPtr> &entities = GetEntitiesInGroup(groupId);
    for (auto &info : entities) {
        ret = dgw::EntityManager::Instance(resIndex).DeleteEntity(
            info->GetQueueType(), info->GetDeviceId(), info->GetType(), info->GetId(), direction);
        if (ret != dgw::FsmStatus::FSM_SUCCESS) {
            BQS_LOG_ERROR("delete entityPtr for entity[%s] failed.", info->ToString().c_str());
            return BQS_STATUS_INNER_ERROR;
        }
    }
    return BQS_STATUS_OK;
}

uint32_t BindRelation::GenerateGroupId()
{
    static uint32_t groupId = 0U;
    uint32_t currGroupId;
    lockForGroup_.Lock();
    ++groupId;
    currGroupId = groupId;
    lockForGroup_.Unlock();
    return currGroupId;
}

const std::vector<EntityInfoPtr> &BindRelation::GetEntitiesInGroup(const uint32_t groupId) const
{
    static const std::vector<EntityInfoPtr> emptyVec;
    const auto iter = allGroupConfig_.find(groupId);
    if (iter != allGroupConfig_.end()) {
        return iter->second;
    }
    return emptyVec;
}

BqsStatus BindRelation::SubscribeEvent(const EntityInfo &subscribeEntity, const EventType eventType,
    const uint32_t index) const
{
    if (subscribeEntity.GetType() == dgw::EntityType::ENTITY_QUEUE) {
        const uint32_t SubQueueType = subscribeEntity.GetQueueType();
        const auto subscribeManager =
            Subscribers::GetInstance().GetSubscribeManager(index, subscribeEntity.GetDeviceId());
        if (subscribeManager == nullptr) {
            DGW_LOG_ERROR("Failed to find subscribeManager for isHost:%d, resIndex: %u, device: %u",
                SubQueueType == bqs::LOCAL_Q, index, subscribeEntity.GetDeviceId());
            return BQS_STATUS_INNER_ERROR;
        }
        return (eventType == EventType::ENQUEUE) ?
            subscribeManager->Subscribe(subscribeEntity.GetId()) :
            subscribeManager->SubscribeFullToNotFull(subscribeEntity.GetId());
    }
    if (subscribeEntity.GetType() == dgw::EntityType::ENTITY_GROUP) {
        const auto entitiesInGroup = GetEntitiesInGroup(subscribeEntity.GetId());
        for (const auto &entity : entitiesInGroup) {
            if (entity->GetType() != dgw::EntityType::ENTITY_QUEUE) {
                continue;
            }
            const uint32_t queuType = entity->GetQueueType();
            const auto subscribeManager =
                Subscribers::GetInstance().GetSubscribeManager(index, entity->GetDeviceId());
            if (subscribeManager == nullptr) {
                DGW_LOG_ERROR("Failed to find subscribeManager for ishost: %d, resIndex: %u, device: %u",
                    queuType == bqs::LOCAL_Q, index, entity->GetDeviceId());
                return BQS_STATUS_INNER_ERROR;
            }
            const auto ret = (eventType == EventType::ENQUEUE) ?
                subscribeManager->Subscribe(entity->GetId()) :
                subscribeManager->SubscribeFullToNotFull(entity->GetId());
            if (ret != BQS_STATUS_OK) {
                BQS_LOG_ERROR("Subscribe queue[%u] in group[%u] failed.", entity->GetId(), subscribeEntity.GetId());
                return ret;
            }
        }
        return BQS_STATUS_OK;
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::UnsubscribeEvent(const EntityInfo &subscribeEntity, const EventType eventType,
    const uint32_t index) const
{
    if (subscribeEntity.GetType() == dgw::EntityType::ENTITY_QUEUE) {
        const uint32_t SubQueueType = subscribeEntity.GetQueueType();
        const auto subscribeManager =
        Subscribers::GetInstance().GetSubscribeManager(index, subscribeEntity.GetDeviceId());
        if (subscribeManager == nullptr) {
            DGW_LOG_ERROR("Failed to find subscribeManager for SubQueueType: %u resIndex: %u, device: %u",
                SubQueueType, index, subscribeEntity.GetDeviceId());
            return BQS_STATUS_INNER_ERROR;
        }
        return (eventType == EventType::ENQUEUE) ?
            subscribeManager->Unsubscribe(subscribeEntity.GetId()) :
            subscribeManager->UnsubscribeFullToNotFull(subscribeEntity.GetId());
    }
    auto result = BQS_STATUS_OK;
    if (subscribeEntity.GetType() == dgw::EntityType::ENTITY_GROUP) {
        const auto entitiesInGroup = GetEntitiesInGroup(subscribeEntity.GetId());
        for (const auto &entity : entitiesInGroup) {
            if (entity->GetType() != dgw::EntityType::ENTITY_QUEUE) {
                continue;
            }
            const auto subscribeManager =
                Subscribers::GetInstance().GetSubscribeManager(index, entity->GetDeviceId());
            if (subscribeManager == nullptr) {
                DGW_LOG_ERROR("Failed to find subscribeManager for resIndex: %u, device: %u",
                    index, entity->GetDeviceId());
                return BQS_STATUS_INNER_ERROR;
            }
            const auto ret = (eventType == EventType::ENQUEUE) ?
                subscribeManager->Unsubscribe(entity->GetId()) :
                subscribeManager->UnsubscribeFullToNotFull(entity->GetId());
            if (ret != BQS_STATUS_OK) {
                result = ret;
                BQS_LOG_ERROR("Unsubscribe queue[%u] in group[%u] failed.", entity->GetId(), subscribeEntity.GetId());
            }
        }
    }
    return result;
}

BqsStatus BindRelation::UpdateSubscribeEvent(const EntityInfo &subscribeEntity, const EventType eventType,
    const uint32_t index) const
{
    if (subscribeEntity.GetType() == dgw::EntityType::ENTITY_QUEUE) {
        const auto subscribeManager =
                Subscribers::GetInstance().GetSubscribeManager(index, subscribeEntity.GetDeviceId());
        if (subscribeManager == nullptr) {
            DGW_LOG_ERROR("Failed to find subscribeManager for resIndex: %u, device: %u",
                index, subscribeEntity.GetDeviceId());
            return BQS_STATUS_INNER_ERROR;
        }
        return (eventType == EventType::ENQUEUE) ?
            subscribeManager->UpdateSubscribe(subscribeEntity.GetId()) :
            subscribeManager->UpdateSubscribeFullToNotFull(subscribeEntity.GetId());
    }
    auto result = BQS_STATUS_OK;
    if (subscribeEntity.GetType() == dgw::EntityType::ENTITY_GROUP) {
        const auto entitiesInGroup = GetEntitiesInGroup(subscribeEntity.GetId());
        for (const auto &entity : entitiesInGroup) {
            if (entity->GetType() != dgw::EntityType::ENTITY_QUEUE) {
                continue;
            }
            const auto subscribeManager =
                Subscribers::GetInstance().GetSubscribeManager(index, entity->GetDeviceId());
            if (subscribeManager == nullptr) {
                DGW_LOG_ERROR("Failed to find subscribeManager for resIndex: %u, device: %u",
                    index, entity->GetDeviceId());
                return BQS_STATUS_INNER_ERROR;
            }
            const auto ret = (eventType == EventType::ENQUEUE) ?
                subscribeManager->UpdateSubscribe(entity->GetId()) :
                subscribeManager->UpdateSubscribeFullToNotFull(entity->GetId());
            if (ret != BQS_STATUS_OK) {
                result = ret;
                BQS_LOG_ERROR("Subscribe queue[%u] in group[%u] failed.",
                    entity->GetId(), subscribeEntity.GetId());
            }
        }
    }
    return result;
}

BqsStatus BindRelation::CheckUnBind(const EntityInfo &entity) const
{
    (void)entity;
    return BQS_STATUS_OK;
}

void BindRelation::MarkAbnormalSrc(const EntityInfo &srcEntity)
{
    const auto &iter = srcToDstRelation_.find(srcEntity);
    if (iter == srcToDstRelation_.end()) {
        BQS_LOG_WARN("No relation [%s->*] exists, no need mark", srcEntity.ToString().c_str());
        return;
    } else {
        auto abnormalSrc = iter->first;
        abnormalSrc.SetEntity(nullptr);

        auto &abnormalDstSet = iter->second;
        for (auto abnormalDst : abnormalDstSet) {
            abnormalDst.SetEntity(nullptr);
            abnormalSrcToDst_[abnormalSrc].emplace(abnormalDst);
            abnormalDstToSrc_[abnormalDst].emplace(abnormalSrc);
        }
        BQS_LOG_RUN_INFO("Mark abnormal relation [%s->*]", abnormalSrc.ToString().c_str());
    }
}

void BindRelation::MarkAbnormalDst(const EntityInfo &dstEntity)
{
    const auto &iter = dstToSrcRelation_.find(dstEntity);
    if (iter == dstToSrcRelation_.end()) {
        BQS_LOG_WARN("No relation [*->%s] exists, no need mark", dstEntity.ToString().c_str());
        return;
    } else {
        auto abnormalDst = iter->first;
        abnormalDst.SetEntity(nullptr);

        const auto &abnormalSrcSet = iter->second;
        for (auto abnormalSrc : abnormalSrcSet) {
            abnormalSrc.SetEntity(nullptr);
            abnormalDstToSrc_[abnormalDst].emplace(abnormalSrc);
            abnormalSrcToDst_[abnormalSrc].emplace(abnormalDst);
        }
        BQS_LOG_RUN_INFO("Mark abnormal relation [*->%s]", abnormalDst.ToString().c_str());
    }
}

void BindRelation::DelAbnormalSrcToDst(const EntityInfo &srcEntity, const EntityInfo &dstEntity)
{
    const auto iter = abnormalSrcToDst_.find(srcEntity);
    if (iter == abnormalSrcToDst_.end()) {
        BQS_LOG_WARN("Bind relation[%s->%s] dst doesn't exist in abnormal bind relations, no need unbind.",
                     srcEntity.ToString().c_str(), dstEntity.ToString().c_str());
        return;
    }

    (void)iter->second.erase(dstEntity);
    if (iter->second.empty()) {
        (void)abnormalSrcToDst_.erase(iter);
    }
}

void BindRelation::DelAbnormalDstToSrc(const EntityInfo &srcEntity, const EntityInfo &dstEntity)
{
    const auto iter = abnormalDstToSrc_.find(dstEntity);
    if (iter == abnormalDstToSrc_.end()) {
        BQS_LOG_WARN("Bind relation[%s->%s] dst doesn't exist in abnormal bind relations, no need unbind.",
                     srcEntity.ToString().c_str(), dstEntity.ToString().c_str());
        return;
    }

    (void)iter->second.erase(srcEntity);
    if (iter->second.empty()) {
        (void)abnormalDstToSrc_.erase(iter);
    }
}

void BindRelation::UnBindAbnormalRelationBySrc(const EntityInfo &srcEntity)
{
    const auto srcToDstIter = abnormalSrcToDst_.find(srcEntity);
    if (srcToDstIter == abnormalSrcToDst_.end()) {
        BQS_LOG_WARN("No relation [%s->*] exists in abnormal bind relation, no need unbind",
                     srcEntity.ToString().c_str());
        return;
    }

    for (const auto &dstEntity : srcToDstIter->second) {
        DelAbnormalDstToSrc(srcEntity, dstEntity);
    }

    (void)abnormalSrcToDst_.erase(srcToDstIter);
}

void BindRelation::UnBindAbnormalRelationByDst(const EntityInfo &dstEntity)
{
    const auto dstToSrcIter = abnormalDstToSrc_.find(dstEntity);
    if (dstToSrcIter == abnormalDstToSrc_.end()) {
        BQS_LOG_WARN("No bind relation[*->%s] exists in abnormal bind relations, no need unbind.",
                     dstEntity.ToString().c_str());
        return;
    }

    for (const auto &srcEntity : dstToSrcIter->second) {
        DelAbnormalSrcToDst(srcEntity, dstEntity);
    }

    (void)abnormalDstToSrc_.erase(dstToSrcIter);
}

BqsStatus BindRelation::ClearInputQueue(const uint32_t index, const std::unordered_set<uint32_t>& keySet)
{
    const auto &inputQueues = (index == 0U) ? orderedSubscribeQueueId_ : orderedSubscribeQueueIdExtra_;
    for (const auto &info: inputQueues) {
        if (keySet.count(info.GetSchedCfgKey()) == 0U) {
            continue;
        }
        const auto entity = info.GetEntity();
        if (entity == nullptr) {
            BQS_LOG_ERROR("[%s] has no entity, this should not happen.", info.ToString().c_str());
            return BQS_STATUS_INNER_ERROR;
        }
        const auto ret = entity->ClearQueue();
        if (ret != dgw::FsmStatus::FSM_SUCCESS) {
            return BQS_STATUS_INNER_ERROR;
        }
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::MakeSureOutputCompletion(const uint32_t index, const std::unordered_set<uint32_t>& keySet)
{
    const auto &dstToSrcRelation = (index == 0U) ? dstToSrcRelation_ : dstToSrcRelationExtra_;
    for (const auto &dstItem: dstToSrcRelation) {
        auto &dst = dstItem.first;
        if (keySet.count(dst.GetSchedCfgKey()) == 0U) {
            continue;
        }
        const auto entity = dst.GetEntity();
        if (entity == nullptr) {
            BQS_LOG_ERROR("[%s] has no entity, this should not happen.", dst.ToString().c_str());
            return BQS_STATUS_INNER_ERROR;
        }
        const auto ret = entity->MakeSureOutputCompletion();
        if (ret != dgw::FsmStatus::FSM_SUCCESS) {
            return BQS_STATUS_INNER_ERROR;
        }
    }
    return BQS_STATUS_OK;
}

BqsStatus BindRelation::GetBindRelationIndex(const EntityInfo &srcEntity, const EntityInfo &dstEntity,
    uint32_t &index) const
{
    if (!GlobalCfg::GetInstance().GetNumaFlag()) {
        index = 0U;
        return BQS_STATUS_OK;
    }
    const auto srcToDstIter = srcToDstRelation_.find(srcEntity);
    const auto dstToSrcIter = dstToSrcRelation_.find(dstEntity);
    const auto srcToDstIterExtra = srcToDstRelationExtra_.find(srcEntity);
    const auto dstToSrcIterExtra = dstToSrcRelationExtra_.find(dstEntity);
    if ((srcToDstIter != srcToDstRelation_.end() || dstToSrcIter != dstToSrcRelation_.end()) &&
        (srcToDstIterExtra == srcToDstRelationExtra_.end() && dstToSrcIterExtra == dstToSrcRelationExtra_.end())) {
        index = 0;
        return BQS_STATUS_OK;
    }

    if ((srcToDstIterExtra != srcToDstRelationExtra_.end() || dstToSrcIterExtra != dstToSrcRelationExtra_.end()) &&
        (srcToDstIter == srcToDstRelation_.end() && dstToSrcIter == dstToSrcRelation_.end())) {
        index = 1;
        return BQS_STATUS_OK;
    }

    if ((srcToDstIterExtra == srcToDstRelationExtra_.end() || dstToSrcIterExtra == dstToSrcRelationExtra_.end()) &&
        (srcToDstIter == srcToDstRelation_.end() && dstToSrcIter == dstToSrcRelation_.end())) {
        index = GlobalCfg::GetInstance().GetResIndexByDeviceId(srcEntity.GetDeviceId());
        return BQS_STATUS_OK;
    }

    return BQS_STATUS_PARAM_INVALID;
}

BqsStatus BindRelation::GetBindIndexBySrc(const EntityInfo &srcEntity, uint32_t &index) const
{
    if (!GlobalCfg::GetInstance().GetNumaFlag()) {
        index = 0U;
        return BQS_STATUS_OK;
    }
    const auto srcToDstIter = srcToDstRelation_.find(srcEntity);
    if (srcToDstIter != srcToDstRelation_.end()) {
        index = 0;
        return BQS_STATUS_OK;
    }

    const auto srcToDstIterExtra = srcToDstRelationExtra_.find(srcEntity);
    if (srcToDstIterExtra != srcToDstRelationExtra_.end()) {
        index = 1;
        return BQS_STATUS_OK;
    }

    return BQS_STATUS_PARAM_INVALID;
}

BqsStatus BindRelation::GetBindIndexByDst(const EntityInfo &srcEntity, uint32_t &index) const
{
    if (!GlobalCfg::GetInstance().GetNumaFlag()) {
        index = 0U;
        return BQS_STATUS_OK;
    }
    const auto dstToSrcIter = dstToSrcRelation_.find(srcEntity);
    if (dstToSrcIter != dstToSrcRelation_.end()) {
        index = 0;
        return BQS_STATUS_OK;
    }

    const auto dstToSrcIterExtra = dstToSrcRelationExtra_.find(srcEntity);
    if (dstToSrcIterExtra != dstToSrcRelationExtra_.end()) {
        index = 1;
        return BQS_STATUS_OK;
    }

    return BQS_STATUS_PARAM_INVALID;
}

const MapEnitityInfoToInfoSet &BindRelation::GetSrcToDstExtraRelation() const
{
    return srcToDstRelationExtra_;
}

const MapEnitityInfoToInfoSet &BindRelation::GetDstToSrcExtraRelation() const
{
    return dstToSrcRelationExtra_;
}

const std::vector<EntityInfo> &BindRelation::GetOrderedSubscribeQueueIdExtra() const
{
    return orderedSubscribeQueueIdExtra_;
}

void BindRelation::AppendAbnormalEntity(const EntityInfo &info, const dgw::EntityDirection direction,
    const uint32_t index) {
    if (index == 0) {
        if (direction == dgw::EntityDirection::DIRECTION_SEND) {
            abnormalSrc_.emplace_back(info);
        } else {
            abnormalDst_.emplace_back(info);
        }
    }
}

void BindRelation::ClearAbnormalEntityInfo(const uint32_t index) {
    if (index == 0) {
        abnormalSrc_.clear();
        abnormalDst_.clear();
    }
}

void BindRelation::UpdateRelation(const uint32_t index)
{
    if (index == 0) {
        if (abnormalSrc_.empty() && abnormalDst_.empty()) {
        return;
        }

        for (const auto &abnormalSrc : abnormalSrc_) {
            MarkAbnormalSrc(abnormalSrc);
            UnBindRelationBySrc(abnormalSrc);
        }

        for (const auto &abnormalDst : abnormalDst_) {
            MarkAbnormalDst(abnormalDst);
            UnBindRelationByDst(abnormalDst);
        }

        Order(index);

        abnormalSrc_.clear();
        abnormalDst_.clear();
    }
}
}  // namespace bqs
