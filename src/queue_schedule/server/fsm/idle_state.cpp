/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "fsm/idle_state.h"
#include "state_manager.h"
#include "entity_manager.h"
#include "common/bqs_log.h"
#include "driver/ascend_hal.h"

namespace dgw {
namespace {
uint32_t g_dequeueFailtimes = 0U;
constexpr uint32_t FAIL_PRINT_THRESHOLD = 10U;
constexpr uint32_t DYNAMIC_SCHEDULE_THRESHOLD = 100U;
}  // namespace

FsmStatus IdleState::ProcessMessage(Entity &entity, const InnerMessage &msg)
{
    DGW_LOG_INFO("[FSM] Entity qid:[%u] type:[%s] state:[%s] desc:[%s].",
        entity.GetId(), entity.GetTypeDesc().c_str(),
        entity.GetStateDesc(FsmState::FSM_IDLE_STATE).c_str(), entity.ToString().c_str());
    (void)msg;
    entity.ResetScheduleCount();
    if (entity.GetWaitDecisionState()) {
        DGW_LOG_INFO("Enitity[%s] ProcessWaitingData", entity.ToString().c_str());
        const auto processRet = ProcessWaitingData(entity);
        if ((processRet != FsmStatus::FSM_SUCCESS) || (entity.GetSendDataObjs().size() > DYNAMIC_SCHEDULE_THRESHOLD)) {
            DGW_LOG_WARN("processRet is %d, cached data size is %zu",
                static_cast<int32_t>(processRet), entity.GetSendDataObjs().size());
            return processRet;
        }
    }

    int32_t srcStatus = static_cast<int32_t>(QUEUE_NORMAL);
    const auto ret = halQueueGetStatus(entity.GetDeviceId(), entity.GetQueueId(),
        QUERY_QUEUE_STATUS, static_cast<uint32_t>(sizeof(uint32_t)), &srcStatus);
    if (ret != DRV_ERROR_NONE) {
        g_dequeueFailtimes++;
        if ((ret == DRV_ERROR_NOT_EXIST) ||
            ((entity.GetQueueType() == bqs::CLIENT_Q) && (ret == DRV_ERROR_INNER_ERR))) {
            return entity.ChangeState(FsmState::FSM_ERROR_STATE);
        } else {
            if (g_dequeueFailtimes < FAIL_PRINT_THRESHOLD) {
                DGW_LOG_ERROR("halQueueGetStatus failed, queueId=[%u], ret=[%d].", entity.GetQueueId(),
                    static_cast<int32_t>(ret));
            }

            return FsmStatus::FSM_FAILED;
        }
    } else {
        g_dequeueFailtimes = 0U;
    }

    if (srcStatus != static_cast<int32_t>(QUEUE_EMPTY)) {
        return PostProcess(entity);
    }
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus IdleState::PostProcess(Entity &entity)
{
    return entity.ChangeState(FsmState::FSM_PEEK_STATE);
}

FsmStatus IdleState::PreProcess(Entity &entity)
{
    (void)entity;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus IdleState::ProcessWaitingData(Entity &entity) const
{
    auto &sendDataObjs = entity.GetSendDataObjs();
    auto sendDataCount = sendDataObjs.size();
    DGW_LOG_INFO("Entity[%s] current send objects is %zu", entity.ToString().c_str(), sendDataCount);
    do {
        sendDataCount = sendDataObjs.size();
        if (sendDataCount == 0U) {
            break;
        }
        auto &sendDataObj = sendDataObjs.front();
        // process sendDataObj, when data bonding to this obj was sent completely,
        // the sendDataObj will be removed from sendDataObjs, then sendDataObjs's size will decrease
        // and we should process the sendDataObjs following
        std::vector<Entity*> processableRecvEntities;
        for (auto elem : sendDataObj->GetRecvEntities()) {
            if (elem->GetType() != EntityType::ENTITY_GROUP) {
                processableRecvEntities.emplace_back(elem);
            }
        }
        DGW_LOG_INFO("Entity[%s] has %zu recvEntity to process", entity.ToString().c_str(),
            processableRecvEntities.size());
        InnerMessage msg;
        msg.msgType = InnerMsgType::INNER_MSG_PUSH;
        for (auto recvEntityPtr : processableRecvEntities) {
            (void)recvEntityPtr->AddDataObjToRecvList(sendDataObj);
            if (recvEntityPtr->ProcessMessage(msg) == FsmStatus::FSM_ERROR) {
                return FsmStatus::FSM_ERROR;
            }
        }
    } while (sendDataObjs.size() != sendDataCount);
    DGW_LOG_INFO("Entity[%s] send objects is %zu after process", entity.ToString().c_str(), sendDataObjs.size());

    return FsmStatus::FSM_SUCCESS;
}

FsmStatus GroupIdleState::ProcessMessage(Entity &entity, const InnerMessage &msg)
{
    (void)msg;
    entity.ResetScheduleCount();
    if (entity.GetWaitDecisionState()) {
        DGW_LOG_INFO("Enitity[%s] ProcessWaitingData", entity.ToString().c_str());
        const auto processRet = ProcessWaitingData(entity);
        if ((processRet != FsmStatus::FSM_SUCCESS) || (entity.GetSendDataObjs().size() > DYNAMIC_SCHEDULE_THRESHOLD)) {
            DGW_LOG_WARN("processRet is %d, cached data size is %zu",
                static_cast<int32_t>(processRet), entity.GetSendDataObjs().size());
            return processRet;
        }
    }
    return PostProcess(entity);
}

REGISTER_STATE(FSM_IDLE_STATE, ENTITY_QUEUE, IdleState);
REGISTER_STATE(FSM_IDLE_STATE, ENTITY_TAG, IdleState);
REGISTER_STATE(FSM_IDLE_STATE, ENTITY_GROUP, GroupIdleState);
}  // namespace dgw
