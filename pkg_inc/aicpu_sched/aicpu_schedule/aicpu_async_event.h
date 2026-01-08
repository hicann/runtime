/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_ASYNC_EVENT_H
#define AICPU_ASYNC_EVENT_H

#include <functional>
#include "aicpu_context.h"

namespace aicpu {
using NotifyFunc = std::function<void(void *param, const uint32_t paramLen)>;
using EventProcessCallBack = std::function<void(void *param)>;

struct AsyncNotifyInfo {
    uint8_t waitType;
    uint32_t waitId;
    uint64_t taskId;
    uint32_t streamId;
    uint32_t retCode;
    aicpu::aicpuContext_t ctx;
};

struct OpEventParam {
    uint64_t aivErrorBitMap;
    uint32_t aicErrorBitMap;
    uint32_t resultCode;
    uint8_t rsv[48];
};

class AsyncEventManager {
public:
    /**
     * Get the unique object of this class
     */
    static AsyncEventManager &GetInstance();

    /**
     * Register notify callback function
     * @param notify wait notify callback function
     */
    void Register(const NotifyFunc &notify);

    /**
     * Notify wait task
     * @param notifyParam notify param info
     * @param paramLen notifyParam len
     */
    void NotifyWait(void * const notifyParam, const uint32_t paramLen);

    /**
     * Register Event callback function, async op call
     * @param eventId EventId
     * @param subEventId queue id
     * @param cb Event callback function
     * @param times Callback execute times
     * @return whether register success
     */
    bool RegEventCb(const uint32_t eventId, const uint32_t subEventId,
                    const EventProcessCallBack &cb, const int32_t times = 1);

    /**
     * Unregister Event callback function, async op call
     * @param eventID EventId
     * @param subEventId queue id
     */
    void UnregEventCb(const uint32_t eventId, const uint32_t subEventId);

    /**
     * Process event
     * @param eventId EventId
     * @param subEventId queue id
     * @param param event param
     */
    void ProcessEvent(const uint32_t eventId, const uint32_t subEventId, void * const param = nullptr);

    bool RegOpEventCb(const uint32_t eventId, const uint32_t subEventId, const EventProcessCallBack &cb) const;

    void UnregOpEventCb(const uint32_t eventId, const uint32_t subEventId) const;

    void ProcessOpEvent(const uint32_t eventId, const uint32_t subEventId, void * const param) const;

private:
    AsyncEventManager();
    ~AsyncEventManager();

    AsyncEventManager(const AsyncEventManager &) = delete;
    AsyncEventManager &operator = (const AsyncEventManager &) = delete;
    AsyncEventManager(AsyncEventManager &&) = delete;
    AsyncEventManager &operator = (AsyncEventManager &&) = delete;

    // wait notify funciton
    NotifyFunc notifyFunc_;
};
}  // namespace aicpu

#ifdef __cplusplus
extern "C" {
#endif
/**
 * Notify wait task
 * @param notifyParam notify info
 * @param paramLen
 */
__attribute__((weak)) void AicpuNotifyWait(void *notifyParam, const uint32_t paramLen);

/**
 * Register Event callback function, async op call
 * @param eventId EventId
 * @param subEventId queue id
 * @param cb Event callback function
 * @return whether register success
 */
__attribute__((weak)) bool AicpuRegEventCb(const uint32_t eventId,
    const uint32_t subEventId, const aicpu::EventProcessCallBack &cb);

/**
 * Register Event callback function, async op call
 * @param eventId EventId
 * @param subEventId queue id
 * @param cb Event callback function
 * @param times Callback execute times
 * @return whether register success
 */
__attribute__((weak)) bool AicpuRegEventCbWithTimes(const uint32_t eventId, const uint32_t subEventId,
    const aicpu::EventProcessCallBack &cb, const int32_t times);

/**
 * Unregister Event callback function, async op call
 * @param eventId EventId
 * @param subEventId queue id
 */
__attribute__((weak)) void AicpuUnregEventCb(const uint32_t eventId, const uint32_t subEventId);

__attribute__((weak)) __attribute__((visibility("default"))) bool AicpuRegOpEventCb(
    const uint32_t eventId, const uint32_t subEventId, const aicpu::EventProcessCallBack &cb);

__attribute__((weak)) __attribute__((visibility("default"))) void AicpuUnregOpEventCb(
    const uint32_t eventId, const uint32_t subEventId);
#ifdef __cplusplus
}
#endif
#endif  // AICPU_ASYNC_EVENT_H_
