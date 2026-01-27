/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "subscribe_manager.h"
#include "common/bqs_log.h"
#include "driver/ascend_hal.h"
#include "statistic_manager.h"
#include "bqs_util.h"

namespace bqs {
SubscribeManager &SubscribeManager::GetInstance()
{
    static SubscribeManager instance;
    return instance;
}

void SubscribeManager::InitSubscribeManager(const uint32_t deviceId, const uint32_t enqueGroupId,
                                            const uint32_t f2nfGroupId, const uint32_t dstDeviceId)
{
    deviceId_ = deviceId;
    enqueGroupId_ = enqueGroupId;
    f2nfGroupId_ = f2nfGroupId;
    dstDeviceId_ = dstDeviceId;
    extendDriverInterface_ = (GetRunContext() == RunContext::HOST) || GlobalCfg::GetInstance().GetNumaFlag();
    subscribeQueuesMaps_.clear();
    fullToNotFullQueuesSets_.clear();
}

BqsStatus SubscribeManager::Subscribe(uint32_t queueId)
{
    const auto findRet = subscribeQueuesMaps_.find(queueId);
    if (findRet != subscribeQueuesMaps_.end()) {
        BQS_LOG_INFO("queue[%u] devId[%u] is subscribed, no need to subscribe.", queueId, deviceId_);
        return BQS_STATUS_OK;
    }

    const auto ret = EnhancedSubscribe(queueId, QUEUE_ENQUE_EVENT);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_QUEUE_RE_SUBSCRIBED)) {
        BQS_LOG_ERROR("halQueueSubscribe queue[%u] on device[%u] in group[%u] failed, ret=%d.",
                      queueId, deviceId_, enqueGroupId_, static_cast<int32_t>(ret));
        return BQS_STATUS_DRIVER_ERROR;
    }

    if ((ret == DRV_ERROR_QUEUE_RE_SUBSCRIBED) && (Resubscribe(queueId) != BQS_STATUS_OK)) {
        BQS_LOG_ERROR("ReSubscribeBuffQueue queue[%u] on device[%u] in group[%u] failed.",
            queueId, deviceId_, enqueGroupId_);
        return BQS_STATUS_DRIVER_ERROR;
    }

    (void)subscribeQueuesMaps_.insert(std::make_pair(queueId, true));
    BQS_LOG_INFO("halQueueSubscribe queue[%u], deviceId[%u] in group[%u] success.", queueId, deviceId_, enqueGroupId_);
    return BQS_STATUS_OK;
}

BqsStatus SubscribeManager::UpdateSubscribe(const uint32_t queueId)
{
    const auto findRet = subscribeQueuesMaps_.find(queueId);
    if (findRet == subscribeQueuesMaps_.end()) {
        BQS_LOG_INFO("queue[%u] devId[%u] is not subscribed, no need to update subscribe.", queueId, deviceId_);
        return BQS_STATUS_OK;
    }

    const auto status = EnhancedSubscribe(queueId, QUEUE_ENQUE_EVENT);
    if ((status != DRV_ERROR_NONE) && (status != DRV_ERROR_QUEUE_RE_SUBSCRIBED)) {
        BQS_LOG_ERROR("halQueueSubscribe queue[%u] on device[%u] in group[%u] failed, ret=%d.",
                      queueId, deviceId_, enqueGroupId_, static_cast<int32_t>(status));
        return BQS_STATUS_DRIVER_ERROR;
    }

    if ((status == DRV_ERROR_QUEUE_RE_SUBSCRIBED) && (Resubscribe(queueId) != BQS_STATUS_OK)) {
        BQS_LOG_ERROR("ReSubscribeBuffQueue queue[%u] on device[%u] failed.", queueId, deviceId_);
        return BQS_STATUS_DRIVER_ERROR;
    }

    if (!(findRet->second)) {
        findRet->second = true;
        StatisticManager::GetInstance().ResumeSubscribe();
    }

    BQS_LOG_INFO("UpdateSubscribe queue[%u] on device[%u] in group[%u] success.", queueId, deviceId_, enqueGroupId_);
    return BQS_STATUS_OK;
}

BqsStatus SubscribeManager::Unsubscribe(const uint32_t queueId)
{
    const auto findRet = subscribeQueuesMaps_.find(queueId);
    if (findRet == subscribeQueuesMaps_.end()) {
        BQS_LOG_INFO("queue[%u] devId[%u] is not subscribed, no need to unsubscribe.", queueId, deviceId_);
        return BQS_STATUS_OK;
    }

    if (findRet->second) {
        const auto status = EnhancedUnSubscribe(queueId, QUEUE_ENQUE_EVENT);
        if (status == DRV_ERROR_NONE) {
            BQS_LOG_INFO("halQueueUnsubscribe queue[%u] on device[%u] success.", queueId, deviceId_);
        } else if (status == DRV_ERROR_NOT_EXIST) {
            BQS_LOG_RUN_WARN("halQueueUnsubscribe return abnormal, queue[%u], device[%u], ret[%d].",
                             queueId, deviceId_, static_cast<int32_t>(status));
        } else {
            BQS_LOG_ERROR("halQueueUnsubscribe queue[%u] on device[%u] failed, ret=%d.",
                queueId, deviceId_, static_cast<int32_t>(status));
            return BQS_STATUS_DRIVER_ERROR;
        }
    } else {
        BQS_LOG_INFO("queue[%u] on device[%u] is pause subscribed, no need to unsubscribe.", queueId, deviceId_);
        StatisticManager::GetInstance().ResumeSubscribe();
    }
    subscribeQueuesMaps_.erase(findRet);
    return BQS_STATUS_OK;
}

BqsStatus SubscribeManager::Resubscribe(const uint32_t queueId) const
{
    auto status = EnhancedUnSubscribe(queueId, QUEUE_ENQUE_EVENT);
    if ((status != DRV_ERROR_NONE) &&
        (status != DRV_ERROR_NOT_EXIST)) {
        BQS_LOG_ERROR("halQueueUnsubscribe queue[%u] on device[%u] failed, ret=%d.", queueId, deviceId_,
            static_cast<int32_t>(status));
        return BQS_STATUS_DRIVER_ERROR;
    }

    status = EnhancedSubscribe(queueId, QUEUE_ENQUE_EVENT);
    if (status != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("halQueueSubscribe queue[%u] on device[%u] in group[%u] failed, ret=%d.",
                      queueId, deviceId_, enqueGroupId_, static_cast<int32_t>(status));
        return BQS_STATUS_DRIVER_ERROR;
    }
    return BQS_STATUS_OK;
}

BqsStatus SubscribeManager::PauseSubscribe(const uint32_t queueId, const uint32_t fullId, const bool idleLog)
{
    const auto findRet = subscribeQueuesMaps_.find(queueId);
    if (findRet == subscribeQueuesMaps_.end()) {
        BQS_LOG_INFO("queue[%u] devId[%u] is not subscribed, no need to pause subscribe.", queueId, deviceId_);
        return BQS_STATUS_OK;
    }

    if (findRet->second) {
        const auto status = EnhancedUnSubscribe(queueId, QUEUE_ENQUE_EVENT);
        if ((status != DRV_ERROR_NONE) && (status != DRV_ERROR_NOT_EXIST)) {
            if (idleLog) {
                BQS_LOG_ERROR("halQueueUnsubscribe queue[%u] on device[%u] failed, ret=%d.",
                    queueId, deviceId_, static_cast<int32_t>(status));
            }
            return BQS_STATUS_DRIVER_ERROR;
        }
        findRet->second = false;
        StatisticManager::GetInstance().PauseSubscribe();
        BQS_LOG_INFO("Pause subscribe queue[%u] on device[%u] as queue or tag[%u] full or get status not success.",
            queueId, deviceId_, fullId);
    } else {
        if (idleLog) {
            BQS_LOG_INFO("queue[%u] on device[%u] is pause subscribed, no need to pause subscribe.",
                queueId, deviceId_);
        }
    }
    return BQS_STATUS_OK;
}

BqsStatus SubscribeManager::ResumeSubscribe(const uint32_t queueId, const uint32_t notFullId)
{
    const auto findRet = subscribeQueuesMaps_.find(queueId);
    if (findRet == subscribeQueuesMaps_.end()) {
        BQS_LOG_ERROR("queue[%u] devId[%u] is not subscribed, can't resume subscribe.", queueId, deviceId_);
        return BQS_STATUS_PARAM_INVALID;
    }

    if (findRet->second) {
        BQS_LOG_INFO("queue[%u] on device[%u] is subscribed, no need to resume subscribe.", queueId, deviceId_);
    } else {
        const auto status = EnhancedSubscribe(queueId, QUEUE_ENQUE_EVENT);
        if (status != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halQueueSubscribe queue[%u] on device[%u] in group[%u] failed, ret=%d.",
                queueId, deviceId_, enqueGroupId_, static_cast<int32_t>(status));
            return BQS_STATUS_DRIVER_ERROR;
        }
        findRet->second = true;
        StatisticManager::GetInstance().ResumeSubscribe();
        BQS_LOG_INFO("Resume subscribe queue[%u] on device[%u] as queue or tag[%u] be not full success.",
            queueId, deviceId_, notFullId);
    }
    return BQS_STATUS_OK;
}

BqsStatus SubscribeManager::SubscribeFullToNotFull(uint32_t queueId)
{
    const auto findRet = fullToNotFullQueuesSets_.find(queueId);
    if (findRet != fullToNotFullQueuesSets_.end()) {
        BQS_LOG_INFO("queue[%u] on device[%u] full to not full event is subscribed, no need to unsubscribe.",
            queueId, deviceId_);
        return BQS_STATUS_OK;
    }

    const auto status = EnhancedSubscribe(queueId, QUEUE_F2NF_EVENT);
    if ((status != DRV_ERROR_NONE) && (status != DRV_ERROR_QUEUE_RE_SUBSCRIBED)) {
        BQS_LOG_ERROR("halQueueSubF2NFEvent for queue[%u] in group[%u], deviceId[%u] failed, ret=%d.",
            queueId, f2nfGroupId_, deviceId_, static_cast<int32_t>(status));
        return BQS_STATUS_DRIVER_ERROR;
    }

    if ((status == DRV_ERROR_QUEUE_RE_SUBSCRIBED) && (ResubscribeF2NF(queueId) != BQS_STATUS_OK)) {
        BQS_LOG_ERROR("ReHalQueueSubEvent queue[%u] on device[%u] failed.", queueId, deviceId_);
        return BQS_STATUS_DRIVER_ERROR;
    }
    (void)fullToNotFullQueuesSets_.emplace(queueId);
    BQS_LOG_INFO("halQueueSubF2NFEvent for queue[%u] in group[%u], deviceId[%u] success.",
        queueId, f2nfGroupId_, deviceId_);
    return BQS_STATUS_OK;
}

BqsStatus SubscribeManager::UpdateSubscribeFullToNotFull(const uint32_t queueId) const
{
    const auto findRet = fullToNotFullQueuesSets_.find(queueId);
    if (findRet == fullToNotFullQueuesSets_.end()) {
        BQS_LOG_INFO("queue[%u] on device[%u] full to not full event is not subscribed, no need to update subscribe.",
            queueId, deviceId_);
        return BQS_STATUS_OK;
    }

    const auto ret = EnhancedSubscribe(queueId, QUEUE_F2NF_EVENT);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_QUEUE_RE_SUBSCRIBED)) {
        BQS_LOG_ERROR("halQueueSubF2NFEvent for queue[%u] on device[%u] in group[%u] failed, ret=%d.",
            queueId, deviceId_, f2nfGroupId_, static_cast<int32_t>(ret));
        return BQS_STATUS_DRIVER_ERROR;
    }

    if ((ret == DRV_ERROR_QUEUE_RE_SUBSCRIBED) && (ResubscribeF2NF(queueId) != BQS_STATUS_OK)) {
        BQS_LOG_ERROR("ReHalQueueSubEvent queue[%u] on device[%u] failed.", queueId, deviceId_);
        return BQS_STATUS_DRIVER_ERROR;
    }
    BQS_LOG_INFO("UpdateSubscribeFullToNotFull for queue[%u] on device[%u] in group[%u] success.",
        queueId, deviceId_, f2nfGroupId_);
    return BQS_STATUS_OK;
}

BqsStatus SubscribeManager::UnsubscribeFullToNotFull(const uint32_t queueId)
{
    const auto findRet = fullToNotFullQueuesSets_.find(queueId);
    if (findRet == fullToNotFullQueuesSets_.end()) {
        BQS_LOG_INFO("queue[%u] on device[%u] full to not full event is not subscribed, no need to unsubscribe.",
            queueId, deviceId_);
        return BQS_STATUS_OK;
    }

    const auto status = EnhancedUnSubscribe(queueId, QUEUE_F2NF_EVENT);
    if (status == DRV_ERROR_NONE) {
        BQS_LOG_INFO("halQueueUnsubEvent for queue[%u] on device[%u] success.", queueId, deviceId_);
    } else if ((status == DRV_ERROR_NOT_EXIST) || (status == DRV_ERROR_PERMISSION)) {
        BQS_LOG_WARN("halQueueUnsubF2NFEvent return abnormal, queue[%u] on device[%u], ret=%d.",
                         queueId, deviceId_, static_cast<int32_t>(status));
    } else {
        BQS_LOG_ERROR("halQueueUnsubEvent for queue[%u] on device[%u] failed, ret=%d.",
            queueId, deviceId_, static_cast<int32_t>(status));
        return BQS_STATUS_DRIVER_ERROR;
    }
    (void)fullToNotFullQueuesSets_.erase(findRet);
    return BQS_STATUS_OK;
}

BqsStatus SubscribeManager::ResubscribeF2NF(const uint32_t queueId) const
{
    auto status = EnhancedUnSubscribe(queueId, QUEUE_F2NF_EVENT);
    if ((status != DRV_ERROR_NONE) && (status != DRV_ERROR_NOT_EXIST)) {
        BQS_LOG_ERROR("halQueueUnsubF2NFEvent for queue[%u], deviceId[%u] failed, ret=%d.",
            queueId, deviceId_, static_cast<int32_t>(status));
        return BQS_STATUS_DRIVER_ERROR;
    }

    status = EnhancedSubscribe(queueId, QUEUE_F2NF_EVENT);
    if (status != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("halQueueSubF2NFEvent for queue[%u] in group[%u], deviceId[%u] failed, ret=%d.",
            queueId, f2nfGroupId_, deviceId_, static_cast<int32_t>(status));
        return BQS_STATUS_DRIVER_ERROR;
    }
    return BQS_STATUS_OK;
}

drvError_t SubscribeManager::DefalutSubscribe(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const
{
    if (deviceId_ != dstDeviceId_) {
        BQS_LOG_ERROR("Subscribe queue[%u] on device[%u] to device[%u] fail for not support.",
            queueId, deviceId_, dstDeviceId_);
        return DRV_ERROR_NOT_SUPPORT;
    }

    if (eventType == QUEUE_ENQUE_EVENT) {
        return halQueueSubscribe(deviceId_, queueId, enqueGroupId_, static_cast<int32_t>(QUEUE_TYPE_GROUP));
    }

    if (eventType == QUEUE_F2NF_EVENT) {
        return halQueueSubF2NFEvent(deviceId_, queueId, enqueGroupId_);
    }

    BQS_LOG_ERROR("Invalid event type %d", static_cast<int32_t>(eventType));
    return DRV_ERROR_INVALID_VALUE;
}

drvError_t SubscribeManager::EnhancedSubscribe(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const
{
    if (extendDriverInterface_) {
        QueueSubPara queSubParm = {};
        queSubParm.eventType = eventType;
        queSubParm.qid = queueId;
        queSubParm.groupId = enqueGroupId_;
        queSubParm.devId = deviceId_;
        queSubParm.dstDevId = dstDeviceId_;
        queSubParm.flag = QUEUE_SUB_FLAG_SPEC_DST_DEVID;

        if (eventType == QUEUE_ENQUE_EVENT) {
            queSubParm.queType = QUEUE_TYPE_GROUP;
        }
        BQS_LOG_RUN_INFO("Subscribe event[%d] of queue[%u] on device[%u] to group[%u] on resDevice[%u]",
            static_cast<int32_t>(eventType), queueId, deviceId_, enqueGroupId_, dstDeviceId_);
        return halQueueSubEvent(&queSubParm);
    }

    return DefalutSubscribe(queueId, eventType);
}

drvError_t SubscribeManager::DefalutUnSubscribe(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const
{
    if (eventType == QUEUE_ENQUE_EVENT) {
        return halQueueUnsubscribe(deviceId_, queueId);
    }
    if (eventType == QUEUE_F2NF_EVENT) {
        return halQueueUnsubF2NFEvent(deviceId_, queueId);
    }

    BQS_LOG_ERROR("Invalid event type %d", static_cast<int32_t>(eventType));
    return DRV_ERROR_INVALID_VALUE;
}

drvError_t SubscribeManager::EnhancedUnSubscribe(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const
{
    if (extendDriverInterface_) {
        QueueUnsubPara queUnSubParm = {};
        queUnSubParm.eventType = eventType;
        queUnSubParm.qid = queueId;
        queUnSubParm.devId = deviceId_;

        return halQueueUnsubEvent(&queUnSubParm);
    }

    return DefalutUnSubscribe(queueId, eventType);
}

Subscribers &Subscribers::GetInstance()
{
    static Subscribers instance;
    return instance;
}

void Subscribers::InitSubscribeManagers(const std::set<uint32_t> &deviceIds, const uint32_t dstDeviceId)
{
    const uint32_t resId = GlobalCfg::GetInstance().GetResIndexByDeviceId(dstDeviceId);
    const uint32_t groupId = GlobalCfg::GetInstance().GetGroupIdByDeviceId(dstDeviceId);
    for (uint32_t resDevId : deviceIds) {
        subscribeManagers_[resId][resDevId].InitSubscribeManager(resDevId, groupId, groupId, dstDeviceId);
    }
}

SubscribeManager *Subscribers::GetSubscribeManager(const uint32_t resId, const uint32_t deviceId)
{
    const auto resIdIter = subscribeManagers_.find(resId);
    if (resIdIter == subscribeManagers_.end()) {
        return nullptr;
    }
    const auto deviceIdIter = resIdIter->second.find(deviceId);
    if (deviceIdIter == resIdIter->second.end()) {
        return nullptr;
    }

    return &(deviceIdIter->second);
}

} // namespace bqs
