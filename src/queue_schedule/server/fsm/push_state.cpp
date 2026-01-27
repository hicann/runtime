/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "fsm/push_state.h"
#include "common/bqs_log.h"
#include "entity_manager.h"
#include "data_obj_manager.h"
#include "driver/ascend_hal.h"
#include "profile_manager.h"
#include "state_manager.h"
#include "statistic_manager.h"

namespace dgw {

FsmStatus PushState::PreProcess(Entity &entity)
{
    DGW_LOG_INFO("[FSM] Entity id:[%u] type:[%s] state:[%s] desc:[%s].",
        entity.GetId(), entity.GetTypeDesc().c_str(),
        entity.GetStateDesc(FsmState::FSM_PUSH_STATE).c_str(), entity.ToString().c_str());
    auto &recvDataObjs = entity.GetRecvDataObjs();
    FsmStatus ret = FsmStatus::FSM_SUCCESS;
    while (!recvDataObjs.empty()) {
        const auto &dataObj = recvDataObjs.front();
        if ((dataObj == nullptr) || (dataObj->GetSendEntity() == nullptr)) {
            recvDataObjs.pop_front();
            continue;
        }

        Mbuf * const mbuf = const_cast<Mbuf *>(dataObj->GetMbuf());
        DGW_LOG_INFO("Begin to sendEntity:[%s] mbuf for entity:[%s].",
            dataObj->GetSendEntity()->ToString().c_str(), entity.ToString().c_str());
        bqs::ProfileManager::GetInstance(entity.GetResIndex()).AddEnqueueNum();
        ret = entity.SendData(dataObj);
        if (ret == FsmStatus::FSM_KEEP_STATE) {
            return PostProcess(entity);
        }
        if (ret != FsmStatus::FSM_SUCCESS) {
            DGW_LOG_WARN("Push to %s[%u] in device[%u] failed, error=[%d].",
                entity.GetTypeDesc().c_str(), entity.GetId(), entity.GetDeviceId(), static_cast<int32_t>(ret));
            bqs::StatisticManager::GetInstance().DataScheduleFailedStat();
            if (ret == FsmStatus::FSM_DEST_FULL) {
                return entity.ChangeState(FsmState::FSM_FULL_STATE);
            }
            if (ret == FsmStatus::FSM_ERROR_PENDING) {
                return entity.ChangeState(FsmState::FSM_ERROR_STATE);
            }
            return PostProcess(entity);
        }

        DGW_LOG_INFO("Push to %s[%u] in device[%u], owneredDevId[%u], ret is %d.",
            entity.GetTypeDesc().c_str(), entity.GetId(), entity.GetDeviceId(), entity.GetDeviceId(),
            static_cast<int32_t>(ret));

        if ((entity.GetMessageType() == InnerMsgType::INNER_MSG_F2NF) &&
            (dgw::EntityManager::Instance(entity.GetResIndex()).ShouldPauseSubscirpiton())) {
            (void)dataObj->GetSendEntity()->ResumeSubscribe(entity);
        }

        dataObj->GetSendEntity()->RemoveRecvEntityFromSendList(&entity);
        if ((dataObj->GetRecvEntitySize() == 0U) && !dataObj->ShouldMaintainMbuf()) {
            DGW_LOG_INFO("Entity[%s] free mbuf", entity.ToString().c_str());
            (void)halMbufFree(mbuf);
        }
        recvDataObjs.pop_front();
    }
    return PostProcess(entity);
}

FsmStatus PushState::PostProcess(Entity &entity)
{
    return entity.ChangeState(FsmState::FSM_WAIT_PUSH_STATE);
}

REGISTER_STATE(FSM_PUSH_STATE, ENTITY_QUEUE, PushState);
REGISTER_STATE(FSM_PUSH_STATE, ENTITY_TAG, PushState);
}  // namespace dgw