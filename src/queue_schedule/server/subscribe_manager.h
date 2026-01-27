/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_SUBSCRIBE_MANAGER_H
#define QUEUE_SCHEDULE_SUBSCRIBE_MANAGER_H

#include <cstdint>
#include <unordered_map>
#include <map>
#include <set>
#include <unordered_set>
#include "common/bqs_log.h"
#include "common/bqs_status.h"
#include "driver/ascend_hal_external.h"
#include "driver/ascend_hal.h"

namespace bqs {
/**
 * attention:not thread safe. can't call concurrently.
 */

class SubscribeManager {
public:
    static SubscribeManager &GetInstance();

    ~SubscribeManager() = default;

    SubscribeManager(const SubscribeManager &) = delete;

    SubscribeManager &operator=(const SubscribeManager &) = delete;

    SubscribeManager(SubscribeManager &&) = delete;

    SubscribeManager &operator=(SubscribeManager &&) = delete;

    void InitSubscribeManager(const uint32_t deviceId, const uint32_t enqueGroupId,
        const uint32_t f2nfGroupId, const uint32_t dstDeviceId);

    /**
     * Subscribe queue group event.
     * @param queueId queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus Subscribe(uint32_t queueId);

    /**
     * update subscribe queue group event.
     * @param queueId queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus UpdateSubscribe(const uint32_t queueId);

    /**
     * Unsubscribe queue group event.
     * @param queueId queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus Unsubscribe(const uint32_t queueId);

    /**
     * pause subscribe queue group event.
     * attention: must ensure dst queue will trigger full to not full event.
     * @param queueId  queue id.
     * @param fullId full queue id or full tag id
     * @param idleLog idle status is true : log
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus PauseSubscribe(const uint32_t queueId, const uint32_t fullId, const bool idleLog);

    /**
     * resume subscribe queue group event.
     * attention: must ensure dst queue will trigger full to not full event.
     * @param queueId queue id.
     * @param notFullId not full queue id or tag id.
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus ResumeSubscribe(const uint32_t queueId, const uint32_t notFullId);

    /**
     * subscribe queue Full to not full event.
     * @param queueId queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus SubscribeFullToNotFull(uint32_t queueId);

    /**
     * update subscribe queue Full to not full event.
     * @param queueId queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus UpdateSubscribeFullToNotFull(const uint32_t queueId) const;

    /**
     * Unsubscribe queue Full to not full event.
     * @param queueId queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus UnsubscribeFullToNotFull(const uint32_t queueId);

    SubscribeManager() = default;

private:

    /**
     * Resubscribe queue group event.
     * @param queueId queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus Resubscribe(const uint32_t queueId) const;

    /**
     * Resubscribe queue Full to not full event.
     * @param queueId queue id
     * @return BQS_STATUS_OK:success, other:failed
     */
    BqsStatus ResubscribeF2NF(const uint32_t queueId) const;

    drvError_t DefalutSubscribe(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const;
    drvError_t EnhancedSubscribe(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const;
    drvError_t DefalutUnSubscribe(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const;
    drvError_t EnhancedUnSubscribe(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const;

private:
    // device chip id.
    uint32_t deviceId_ = 0U;

    // enqueue event group id.
    uint32_t enqueGroupId_ = 0U;

    // full to not full event group id.
    uint32_t f2nfGroupId_ = 1U;

    // queue subscribe(group event) status, true:subscribed, false:pause subscribed
    std::map<uint32_t, bool> subscribeQueuesMaps_;

    // full to not full event subscribe queues.
    std::set<uint32_t> fullToNotFullQueuesSets_;
    uint32_t dstDeviceId_{0U};
    bool extendDriverInterface_{false};
};

class Subscribers {
public:
    static Subscribers &GetInstance();
    SubscribeManager *GetSubscribeManager(const uint32_t resId, const uint32_t deviceId);
    // init subscribers which subscribe queue on deviceId to dstDeviceId for each deviceId
    void InitSubscribeManagers(const std::set<uint32_t> &deviceIds, const uint32_t dstDeviceId);

private:
    // resId - deviceId
    std::unordered_map<uint32_t, std::unordered_map<uint32_t, SubscribeManager>> subscribeManagers_;
};
}  // namespace bqs

#endif  // QUEUE_SCHEDULE_SUBSCRIBE_MANAGER_H
