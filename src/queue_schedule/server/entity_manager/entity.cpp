/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "entity.h"
#include "state_manager.h"

namespace dgw {

namespace {
    constexpr uint32_t SCHEDULE_THRESHOLD = 100U;
    constexpr uint32_t DYNAMIC_SCHEDULE_THRESHOLD = 100U;
}

Entity::Entity(const EntityMaterial &material, const uint32_t resIndex)
    : type_(material.eType),
      id_(material.id),
      deviceId_(material.resId),
      hostGroupId_(material.hostGroupId),
      globalId_(material.globalId),
      uuId_(material.uuId),
      schedCfgKey_(material.schedCfgKey),
      resIndex_(resIndex),
      queueType_(material.queueType),
      subscribeStatus_(SubscribeStatus::SUBSCRIBE_INVALID),
      scheduleCount_(0U),
      curState_(FsmState::FSM_IDLE_STATE),
      mbuf_(nullptr),
      transId_(0UL),
      refCount_(0U),
      direction_(EntityDirection::DIRECTION_SEND),
      needTransId_(false),
      msgType_(InnerMsgType::INNER_MSG_INVALID),
      routeLabel_(0U),
      waitingDecision_(false),
      dynamicReqTime_(0UL)
{
    (void)entityDesc_.append("qid:").append(std::to_string(id_))
            .append(", type:").append(std::to_string(static_cast<int32_t>(type_)))
            .append(", globalId:").append(std::to_string(globalId_))
            .append(", schedCfgKey:").append(std::to_string(schedCfgKey_))
            .append(", hostGrpId:").append(std::to_string(hostGroupId_))
            .append(", deviceId:").append(std::to_string(deviceId_))
            .append(", resIndex:").append(std::to_string(resIndex_))
            .append(", queue type:").append(std::to_string(queueType_));
}

FsmStatus Entity::Init(const FsmState state, const EntityDirection direction)
{
    curState_ = state;
    direction_ = direction;
    entityDesc_.append(", direction:").append(std::to_string(static_cast<int32_t>(direction_)));
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus Entity::Uninit()
{
    return FsmStatus::FSM_SUCCESS;
}

uint32_t Entity::GetQueueId() const
{
    return id_;
}

FsmStatus Entity::AllowDeque()
{
    if (scheduleCount_ >= SCHEDULE_THRESHOLD) {
        return FsmStatus::FSM_FAILED;
    }

    // The destination receiver has not finished scheduling, keep peek state
    // if waitingDecision, maybe some decision is comming, then return fail,
    //    so fsm can transfer to idle to process decision
    if ((!waitingDecision_ && !sendDataObjs_.empty()) ||
        (sendDataObjs_.size() > DYNAMIC_SCHEDULE_THRESHOLD)) {
        DGW_LOG_DEBUG("[FSM] Entity:[%s] state:[%s] not finish count:[%zu].",
            entityDesc_.c_str(), GetStateDesc(FsmState::FSM_PEEK_STATE).c_str(), sendDataObjs_.size());
        return waitingDecision_ ? FsmStatus::FSM_FAILED : FsmStatus::FSM_KEEP_STATE;
    };

    return FsmStatus::FSM_SUCCESS;
}

FsmStatus Entity::ResetSrcState()
{
    return FsmStatus::FSM_SUCCESS;
}

void Entity::ResetSrcSubState()
{
    return;
}

void Entity::ReprocessInTryPush(const Entity &srcEntity, DynamicRequestPtr &dynamicRequest, uint32_t &schedCfgKey)
{
    (void)srcEntity;
    (void)dynamicRequest;
    (void)schedCfgKey;
    return;
}

FsmStatus Entity::AbProcessInTryPush()
{
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus Entity::SendData(const DataObjPtr dataObj)
{
    (void)dataObj;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus Entity::ProcessMessage(const InnerMessage &msg)
{
    DGW_LOG_DEBUG("[FSM] Entity qid:[%u] type:[%s] state:[%s] ProcessMessage.",
        id_, GetTypeDesc().c_str(), GetStateDesc(curState_).c_str());
    // if cur_state is not full, then there's no need to process f2nf msg
    if ((msg.msgType == dgw::InnerMsgType::INNER_MSG_F2NF) && (curState_ != FsmState::FSM_FULL_STATE)) {
        return FsmStatus::FSM_SUCCESS;
    }

    auto const state = StateManager::Instance().GetState(curState_, type_);
    if (state != nullptr) {
        return state->ProcessMessage(*this, msg);
    }
    DGW_LOG_ERROR("[FSM] Entity qid:[%u] type:[%s] state:[%s] get state failed.",
        id_, GetTypeDesc().c_str(), GetStateDesc(curState_).c_str());
    return FsmStatus::FSM_FAILED;
}

FsmStatus Entity::ChangeState(const FsmState nextState)
{
    DGW_LOG_DEBUG("[FSM] Entity qid:[%u] type:[%s] change from state:[%s] to state:[%s].",
        id_, GetTypeDesc().c_str(), GetStateDesc(curState_).c_str(), GetStateDesc(nextState).c_str());
    curState_ = nextState;
    auto const state = StateManager::Instance().GetState(nextState, type_);
    if (state != nullptr) {
        return state->PreProcess(*this);
    }
    return FsmStatus::FSM_FAILED;
}

FsmStatus Entity::AddDataObjToSendList(const DataObjPtr &dataObj)
{
    sendDataObjs_.push_back(dataObj);
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus Entity::AddDataObjToRecvList(const DataObjPtr &dataObj)
{
    for (const auto &recvDataObj : recvDataObjs_) {
        if (recvDataObj == dataObj) {
            DGW_LOG_INFO("Skip AddDataObjToRecvList");
            return FsmStatus::FSM_SUCCESS;
        }
    }
    recvDataObjs_.push_back(dataObj);
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus Entity::RemoveDataObjFromSendList(const DataObjPtr &dataObj)
{
    if (!sendDataObjs_.empty()) {
        // what's intension?
        if ((dataObj != nullptr) && (dataObj->GetSendEntity() != nullptr)) {
            DGW_LOG_INFO("[FSM] id:[%u] type:[%s] state:[%s], remove id:[%u].",
                id_, GetTypeDesc().c_str(), GetStateDesc(curState_).c_str(), dataObj->GetSendEntity()->GetId());
        }
        sendDataObjs_.pop_front();
        DGW_LOG_INFO("Entity[%s] remove one sendDataObj", entityDesc_.c_str());
    }
    return FsmStatus::FSM_SUCCESS;
}

void Entity::RemoveRecvEntityFromSendList(const Entity* const recvEntityPtr)
{
    if (!sendDataObjs_.empty()) {
        const auto sendDataObj = sendDataObjs_.front();
        sendDataObj->RemoveRecvEntity(recvEntityPtr);
        if (sendDataObj->GetRecvEntitySize() == 0U) {
            sendDataObjs_.pop_front();
        }
    }

    if (sendDataObjs_.empty()) {
        waitingDecision_ = false;
    }
}

const std::string &Entity::GetTypeDesc() const
{
    return StateManager::Instance().GetTypeDesc(type_);
}

const std::string &Entity::GetStateDesc(const FsmState id) const
{
    return StateManager::Instance().GetStateDesc(id, type_);
}

bool Entity::Equal(const Entity * const recvEntityPtr) const
{
    return ((type_ == recvEntityPtr->GetType()) && (id_ == recvEntityPtr->GetId()) &&
            (deviceId_ == recvEntityPtr->GetDeviceId()) && (queueType_ == recvEntityPtr->GetQueueType()));
}

bool Entity::UpdateSendObject(const EntityPtr group, const EntityPtr elem)
{
    for (auto sendDataObj : sendDataObjs_) {
        DGW_LOG_INFO("Try to replace group[%s] with elem[%s] in Entity[%s].",
            group->ToString().c_str(), elem->ToString().c_str(), ToString().c_str());
        if (sendDataObj->UpdateRecvEntities(group, elem)) {
            DGW_LOG_INFO("replace group[%s] with elem[%s] in Entity[%s].",
                group->ToString().c_str(), elem->ToString().c_str(), ToString().c_str());
            return true;
        }
    }
    DGW_LOG_ERROR("Invalid UpdateSendObject for dst[%s] with elem[%s] in Entity[%s].",
        group->ToString().c_str(), elem->ToString().c_str(), entityDesc_.c_str());
    return false;
}

FsmStatus Entity::MakeSureOutputCompletion()
{
    return FsmStatus::FSM_SUCCESS;
}

bool Entity::IsDataPeeked() const
{
    return false;
}

uint32_t Entity::GetMbufDeviceId() const
{
    return deviceId_;
}

uint32_t Entity::GetMbufQueueType() const
{
    return queueType_;
}
}