/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_MANAGER_H
#define QUEUE_MANAGER_H

#include <cstdint>
#include <atomic>
#include <condition_variable>
#include "bqs_status.h"
#include "bqs_log.h"
#include "bind_relation.h"
#include "bqs_util.h"

namespace bqs {
class QueueManager {
public:
    static QueueManager &GetInstance();

    ~QueueManager();

    QueueManager(const QueueManager &) = delete;

    QueueManager(QueueManager &&) = delete;

    QueueManager &operator=(const QueueManager &) = delete;

    QueueManager &operator=(QueueManager &&) = delete;

    /**
     * init/create/subscribe buff queue
     * @return BQS_STATUS_OK:success other:failed
     */
    BqsStatus InitQueueManager(const uint32_t deviceId, const uint32_t groupId, const bool hasAICPU,
                               const std::string& groupName);
    void InitExtra(const uint32_t deviceIdExtra, const uint32_t groupIdExtra);

    BqsStatus InitQueueExtra();

    /**
     * init/create/subscribe buff queue
     * @return BQS_STATUS_OK:success other:failed
     */
    BqsStatus InitQueue();

    /**
     * destroy buff queue
     * @return NA
     */
    void Destroy();

    /**
     * Enqueue a data to implies that the client sent a message
     * @return BQS_STATUS_OK:success other:failed
     */
    BqsStatus EnqueueRelationEvent();

    BqsStatus EnqueueRelationEventExtra();

    BqsStatus EnqueueRelationEventToQ(const uint32_t deviceId, const uint32_t relationEventQ) const;

    /**
     * handle the bind or unbind msg that the client sent
     * @return true:has handle relation msg, false:not handle
     */
    bool HandleRelationEvent(const uint32_t index = 0U) const;

    /**
     * enqueue the queue id of full to not full queue
     * @return BQS_STATUS_OK:success other:failed
     */
    BqsStatus EnqueueFullToNotFullEvent(const uint32_t index);

    /**
     * handle the event of full to not full
     * @return true:has handle f2nf msg, false:not handle
     */
    bool HandleFullToNotFullEvent(const uint32_t index);

    /**
     * enqueue the queue id of asyn mem buff queue
     * @return BQS_STATUS_OK:success other:failed
     */
    BqsStatus EnqueueAsynMemBuffEvent();

    /**
     * handle the event of asyn mem buff event
     * @return true:has handle asyn mem buff msg, false:not handle
     */
    bool HandleAsynMemBuffEvent(const uint32_t index);

    /**
     * enable async mem dequeu flag
     */
    void enableAsyncMemDequeueFlag()
    {
        isTriggeredByAsyncMemDequeue_ = true;
    }

    /**
     * enable async mem enqueue flag
     */
    void enableAsyncMemEnqueueFlag()
    {
        isTriggeredByAsyncMemEnqueue_ = true;
    }

    /**
     * work thread init success will notify queue manager
     * @return NA
     */
    void NotifyInitSuccess(const uint32_t index);

    /**
     * log queue status for error occur
     * @return NA
     */
    void LogErrorQueueStatus(const uint32_t queueId) const;

    /**
     * log relation queue status for error occur
     * @return NA
     */
    void LogErrorRelationQueueStatus() const;

    /**
     * create and subscribe buff queue
     * @param name queue name
     * @param depth queue depth
     * @param queueId queue id
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus CreateAndSubscribeQueue(const char_t * const name, const uint32_t depth, uint32_t &queueId) const;

    BqsStatus CreateAndSubscribeQueueExtra(const char_t * const name, const uint32_t depth, uint32_t &queueId) const;

    /**
     * destroy queue
     * @param queueId queue id
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus DestroyQueue(const uint32_t queueId) const;

    BqsStatus DestroyQueue(const uint32_t queueId, uint32_t deviceId) const;

    /**
     * @brief Create a Queue object
     * @param name queue name
     * @param depth queue depth
     * @param queueId queue id
     * @return BQS_STATUS_OK: success, other: failed
     */
    BqsStatus CreateQueue(const char_t * const name, const uint32_t depth, uint32_t &queueId) const;

    BqsStatus CreateQueue(const char_t * const name, const uint32_t depth, uint32_t &queueId, uint32_t deviceId) const;

    /**
     * @brief get device id
     * @return device id
     */
    inline const uint32_t GetDeviceId() const
    {
        return deviceId_;
    }

    inline const uint32_t GetExtraDeviceId() const
    {
        return deviceIdExtra_;
    }
private:
    /**
     * @brief Construct a new Queue Manager object
     */
    QueueManager();
    BqsStatus UnsubscribeQueue(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const;
    void Clear();
    void ClearQueue(const uint32_t queueId, const QUEUE_EVENT_TYPE eventType) const;
    void MakeUpF2NFMbuf(const uint32_t index);
    void MakeUpMbuf(Mbuf **mbufPtr) const;

private:
    uint32_t deviceId_;
    uint32_t groupId_;
    std::string grpName_;
    uint32_t relationEventQId_;
    uint32_t fullToNotFullEventQId_;
    uint32_t asyncMemDequeueBuffQId_;
    uint32_t asyncMemEnqueueBuffQId_;

    std::condition_variable cv_;  // condition var to wait queue_schedule init success
    std::mutex mutex_;
    bool initialized_;  // true means queue_schedule has init success
    bool stopped_;      // true means queue manager has been stopped
    std::atomic<bool> f2nfQueueEmptyFlag_;
    Mbuf *mbufForF2nf_;
    SpinLock f2nfLock_;
    bool relationEventQInitialized_;
    bool fullToNotFullEventQInitialized_;
    uint32_t deviceIdExtra_;
    uint32_t groupIdExtra_;
    uint32_t relationEventQIdExtra_;
    bool relationEventQInitializedExtra_;
    uint32_t fullToNotFullEventQIdExtra_;
    bool fullToNotFullEventQInitializedExtra_;
    Mbuf *mbufForF2nfExtra_;
    SpinLock f2nfLockExtra_;
    std::atomic<bool> f2nfQueueEmptyFlagExtra_;
    bool isTriggeredByAsyncMemDequeue_;
    bool isTriggeredByAsyncMemEnqueue_;
    bool ayncMemBuffEventQInitialized_;
    bool initiallizedExtra_;
};
}      // namespace bqs
#endif  // QUEUE_MANAGER_H
