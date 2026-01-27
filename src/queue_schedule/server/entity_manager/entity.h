/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_ENTITY_H
#define DGW_ENTITY_H

#include <list>
#include <vector>
#include "data_obj_manager.h"
#include "dynamic_sched_mgr.hpp"
#include "fsm/state_define.h"
#include "statistic_manager.h"

#include "dgw_client.h"
#include "hccl/comm_channel_manager.h"
#include "bqs_util.h"
namespace dgw {

// invalid group id
constexpr int32_t INVALID_GROUP_ID = -1;
struct EntityMaterial {
    EntityType eType;
    EntityDirection direction;
    uint32_t id;
    uint32_t globalId;
    uint32_t uuId;
    uint32_t schedCfgKey;
    uint32_t resId;  // deviceId
    int32_t hostGroupId = INVALID_GROUP_ID;
    const CommChannel* channel = nullptr;
    bqs::GroupPolicy groupPolicy = bqs::GroupPolicy::HASH;
    uint32_t peerInstanceNum = 1U;
    uint32_t localInstanceIndex = 0U;
    uint32_t queueType = bqs::LOCAL_Q;
};

using DynamicRequestPtr = std::shared_ptr<DynamicSchedMgr::RequestInfo>;

constexpr uint32_t MBUF_HEAD_MAX_SIZE = 256U;

class Entity {
public:
    explicit Entity(const EntityMaterial &material, const uint32_t resIndex);
    virtual ~Entity() = default;
    Entity(const Entity &) = delete;
    Entity(const Entity &&) = delete;
    Entity &operator = (const Entity &) = delete;
    Entity &operator = (Entity &&) = delete;

    virtual FsmStatus Dequeue() = 0;
    virtual void SelectDstEntities(const uint64_t key, std::vector<Entity*> &toPushDstEntities,
        std::vector<Entity*> &reprocessDstEntities, std::vector<Entity*> &abnormalDstEntities) = 0;
    virtual FsmStatus ClearQueue() = 0;
    virtual FsmStatus PauseSubscribe(const Entity &fullEntity) = 0;
    virtual FsmStatus ResumeSubscribe(const Entity &notFullEntity) = 0;

    virtual FsmStatus Init(const FsmState state, const EntityDirection direction);
    virtual FsmStatus Uninit();
    virtual uint32_t GetQueueId() const;
    virtual FsmStatus ResetSrcState();
    virtual void ResetSrcSubState();
    virtual void ReprocessInTryPush(const Entity &srcEntity, DynamicRequestPtr &dynamicRequest, uint32_t &schedCfgKey);
    virtual FsmStatus AbProcessInTryPush();
    virtual FsmStatus SendData(const DataObjPtr dataObj);
    virtual bool IsDataPeeked() const;
    virtual FsmStatus MakeSureOutputCompletion();
    virtual uint32_t GetMbufDeviceId() const;
    virtual uint32_t GetMbufQueueType() const;

    FsmStatus AllowDeque();
    FsmStatus ProcessMessage(const InnerMessage &msg);
    FsmStatus ChangeState(const FsmState nextState);
    FsmStatus RemoveDataObjFromSendList(const DataObjPtr &dataObj);
    void RemoveRecvEntityFromSendList(const Entity* const recvEntityPtr);
    FsmStatus AddDataObjToSendList(const DataObjPtr &dataObj);
    FsmStatus AddDataObjToRecvList(const DataObjPtr &dataObj);
    const std::string &GetTypeDesc() const;
    const std::string &GetStateDesc(const FsmState id) const;
    bool Equal(const Entity* const recvEntityPtr) const;
    bool UpdateSendObject(const EntityPtr group, const EntityPtr elem);

    inline void AddScheduleCount()
    {
        scheduleCount_++;
    }
    inline void ResetScheduleCount()
    {
        scheduleCount_ = 0U;
    }
    inline uint32_t GetScheduleCount() const
    {
        return scheduleCount_;
    }
    inline EntityType GetType() const
    {
        return type_;
    }
    inline uint32_t GetId() const
    {
        return id_;
    }
    inline Mbuf *GetMbuf() const
    {
        return mbuf_;
    }
    inline void SetMbuf(Mbuf * const mbuf)
    {
        mbuf_ = mbuf;
    }
    inline uint32_t GetDeviceId() const
    {
        return deviceId_;
    }
    inline DataObjList &GetRecvDataObjs()
    {
        return recvDataObjs_;
    }
    inline const DataObjList &GetSendDataObjs() const
    {
        return sendDataObjs_;
    }
    inline uint32_t GetRefCount() const
    {
        return refCount_;
    }
    inline void DecreaseRefCount()
    {
        refCount_--;
    }
    inline void IncreaseRefCount()
    {
        refCount_++;
    }
    inline EntityDirection GetDirection() const
    {
        return direction_;
    }
    inline FsmState GetCurState() const
    {
        return curState_;
    }
    inline uint64_t GetTransId() const
    {
        return transId_;
    }
    inline void SetTransId(const uint64_t transId)
    {
        transId_ = transId;
    }
    inline uint32_t GetRouteLabel() const
    {
        return routeLabel_;
    }
    inline void SetRouteLabel(const uint32_t routeLabel)
    {
        routeLabel_ = routeLabel;
    }

    inline uint32_t GetQueueType() const
    {
        return queueType_;
    }

    inline int32_t GetHostGroupId() const
    {
        return hostGroupId_;
    }
    inline void SetNeedTransId(const bool needTransId)
    {
        needTransId_ = needTransId;
    }
    inline bool IsNeedTransId() const
    {
        return needTransId_;
    }
    inline void SetMessageType(const InnerMsgType msgType)
    {
        msgType_ = msgType;
    }
    inline InnerMsgType GetMessageType() const
    {
        return msgType_;
    }

    inline const std::string &ToString() const
    {
        return entityDesc_;
    }
    inline bqs::EntityStatisticInfo &GetStatisticInfo()
    {
        return statInfo_;
    }
    inline void SetWaitDecisionState(const bool waitState)
    {
        waitingDecision_ = waitState;
    }
    inline bool GetWaitDecisionState() const
    {
        return waitingDecision_;
    }
    inline uint32_t GetGlobalId() const
    {
        return globalId_;
    }

    inline uint32_t GetUuId() const
    {
        return uuId_;
    }

    inline uint32_t GetSchedCfgKey() const
    {
        return schedCfgKey_;
    }

    inline uint32_t GetResIndex() const
    {
        return resIndex_;
    }

    inline void SetDynamicReqTime(const uint64_t dynamicReqTime)
    {
        dynamicReqTime_ = dynamicReqTime;
    }

    inline uint64_t GetDynamicReqTime() const
    {
        return dynamicReqTime_;
    }

protected:
    EntityType type_;
    uint32_t id_;
    uint32_t deviceId_;
    // the group which this entity belong to
    int32_t hostGroupId_;
    uint32_t globalId_;
    uint32_t uuId_;
    uint32_t schedCfgKey_;
    uint32_t resIndex_;
    uint32_t queueType_;
    SubscribeStatus subscribeStatus_;
    uint32_t scheduleCount_;
    FsmState curState_;
    Mbuf *mbuf_;
    uint64_t transId_;
    uint32_t refCount_;
    EntityDirection direction_;
    // whether src entity need get transId from mbuf head
    bool needTransId_;
    InnerMsgType msgType_;
    uint32_t routeLabel_;
    bool waitingDecision_;
    uint64_t dynamicReqTime_;
    // entity desc
    std::string entityDesc_;
    // statistic info
    bqs::EntityStatisticInfo statInfo_;
    DataObjList recvDataObjs_;
    DataObjList sendDataObjs_;
};
}
#endif