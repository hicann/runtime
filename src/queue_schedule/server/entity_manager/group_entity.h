/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_GROUP_ENTITY_H
#define DGW_GROUP_ENTITY_H

#include "entity.h"
#include "dgw_client.h"

namespace dgw {

struct GroupEntityInfo {
    int32_t groupId;               // group id
    bqs::GroupPolicy groupPolicy;  // group policy
    int64_t timeout;               // timeout interval, us
    uint64_t lastTransId;          // last route label
    uint64_t lastTimestamp;        // timestamp of last data migration, us
    uint32_t peerInstanceNum;
    uint32_t localInstanceIndex;
};

class GroupEntity : public Entity {
public:
    explicit GroupEntity(const EntityMaterial &material, const uint32_t resIndex);
    virtual ~GroupEntity() = default;
    GroupEntity(const GroupEntity &) = delete;
    GroupEntity(const GroupEntity &&) = delete;
    GroupEntity &operator = (const GroupEntity &) = delete;
    GroupEntity &operator = (GroupEntity &&) = delete;

    FsmStatus Dequeue() override;
    void SelectDstEntities(const uint64_t key, std::vector<Entity*> &toPushDstEntities,
        std::vector<Entity*> &reprocessDstEntities, std::vector<Entity*> &abnormalDstEntities) override;
    void ReprocessInTryPush(const Entity &srcEntity, DynamicRequestPtr &dynamicRequest, uint32_t &schedCfgKey) override;
    FsmStatus AbProcessInTryPush() override;
    FsmStatus PauseSubscribe(const Entity &fullEntity) override;
    FsmStatus ResumeSubscribe(const Entity &notFullEntity) override;
    FsmStatus ClearQueue() override;
    FsmStatus MakeSureOutputCompletion() override;
    uint32_t GetMbufDeviceId() const override;
    uint32_t GetMbufQueueType() const override;

private:
    void SetGroupInfo(const uint64_t lastTransId, const uint64_t lastTimestamp);
    EntityPtr SelectSrcEntity(FsmStatus &status);
    bool Match(const Entity &entity, const uint64_t waitTransId, bool exactlyMatch) const;
    FsmStatus PeekFromEntityInGroup(Entity &entity, const uint64_t waitTransId) const;
    bool CheckTimeout(const uint64_t waitTransId) const;
    EntityPtr SelectEntityWithMinTransId(const std::vector<EntityPtr> &entities) const;

    GroupEntityInfo groupInfo_;
    uint32_t mbufDeviceId_;
    uint32_t mbufQueueType_;
};
}
#endif