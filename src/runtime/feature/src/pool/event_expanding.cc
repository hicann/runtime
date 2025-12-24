/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "event_expanding.hpp"
#include <vector>
#include "securec.h"
#include "runtime.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "api.hpp"
#include "npu_driver.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
EventExpandingPool::EventExpandingPool(Device * const dev)
    : NoCopy(), device_(dev), eventIdCount_(EVENT_INIT_VALUE), lastEventId_(0U), poolIndex_(0U)
{
    for (int i = 0; i < MAX_POOL_CNT; ++i) {
        eventAllocator_[i] = nullptr;
    }
}

EventExpandingPool::~EventExpandingPool()
{
    for (int i = 0; i < MAX_POOL_CNT; ++i) {
        DELETE_O(eventAllocator_[i]);
    }

    eventIdMap_.clear();
}

void *EventExpandingPool::MallocBufferForEvent(const size_t size, void * const para)
{
    void *addr = nullptr;
    Device * const dev = static_cast<Device *>(para);
    rtError_t error = dev->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(size), RT_MEMORY_DDR, dev->Id_());
    COND_RETURN_WARN(error != RT_ERROR_NONE, nullptr, "device mem alloc pool mem failed, "
        "size=%u(bytes), kind=%d, device_id=%u, retCode=0x%#x",
        size, RT_MEMORY_DDR, dev->Id_(), static_cast<uint32_t>(error));
    return addr;
}

void EventExpandingPool::FreeBufferForEvent(void * const addr, void * const para)
{
    Device * const dev = static_cast<Device *>(para);
    rtError_t error = dev->Driver_()->DevMemFree(addr, dev->Id_());
    COND_LOG(error != RT_ERROR_NONE, "device mem free failed, device_id=%u, retCode=0x%#x!",
        dev->Id_(), static_cast<uint32_t>(error));
}

rtError_t EventExpandingPool::AllocAndInsertEvent(void ** const eventAddr, int32_t *eventId)
{
    const std::unique_lock<std::mutex> taskLock(EventMapLock_);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, eventIdCount_ == INT32_MAX, RT_ERROR_DRV_NO_EVENT_RESOURCES,
        "event count is reaching the maximum.");
    if (eventAllocator_[poolIndex_] == nullptr) {
        eventAllocator_[poolIndex_] = new (std::nothrow) BufferAllocator(sizeof(uint64_t), EVENT_INIT_CNT, PER_POOL_CNT, BufferAllocator::LINEAR, 
                                                            &MallocBufferForEvent, &FreeBufferForEvent, device_);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, eventAllocator_[poolIndex_] == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "Init EventExpandingPool failed.");
        RT_LOG(RT_LOG_INFO, "Init EventExpandingPool success.");
    }
    // Alloc 
    int32_t currentEventId;
    void *devAddr = eventAllocator_[poolIndex_]->AllocItemForEventPool(&currentEventId, false);
    if (devAddr == nullptr) {
        ++poolIndex_;
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, poolIndex_ > (MAX_POOL_CNT - 1), RT_ERROR_DRV_NO_EVENT_RESOURCES,
            "event count is reaching the maximum.");
        eventAllocator_[poolIndex_] = new (std::nothrow) BufferAllocator(sizeof(uint64_t), EVENT_INIT_CNT, PER_POOL_CNT, BufferAllocator::LINEAR, 
                                                            &MallocBufferForEvent, &FreeBufferForEvent, device_);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, eventAllocator_[poolIndex_] == nullptr, RT_ERROR_MEMORY_ALLOCATION,
                    "Init EventExpandingPool failed.");
        RT_LOG(RT_LOG_INFO, "Init EventExpandingPool success.");
        devAddr = eventAllocator_[poolIndex_]->AllocItemForEventPool(&currentEventId, false);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, devAddr == nullptr, RT_ERROR_DRV_NO_EVENT_RESOURCES,
                     "devAddr is nullptr! Alloc addr for event failed.");
    }
    lastEventId_ = EVENT_INIT_VALUE + currentEventId + PER_POOL_CNT * (poolIndex_); // init 65536 + cur + PER_POOL_CNT * index
    *eventAddr = devAddr;
    *eventId = lastEventId_;
    (void)eventIdMap_.insert(std::make_pair(lastEventId_, *eventAddr));
    eventIdCount_++;
    RT_LOG(RT_LOG_INFO, "get event id, eventid=%d, lastEventId=%d, poolIndex=%d,currentEventId=%d.",
        *eventId, lastEventId_, poolIndex_, currentEventId);
    return RT_ERROR_NONE;
}

rtError_t EventExpandingPool::FindEventAddrById(void ** const eventAddr, int32_t eventId)
{
    const std::unique_lock<std::mutex> taskLock(EventMapLock_);
    const auto iter = eventIdMap_.find(eventId);
    if (iter != eventIdMap_.end()) {
        *eventAddr = iter->second;
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_ERROR, "can not get addr by id, event_id=%d.", eventId);
    return RT_ERROR_EVENT_NULL;
}

void EventExpandingPool::FreeEventAddr(void * const eventAddr, int32_t eventId)
{
    const std::unique_lock<std::mutex> taskLock(EventMapLock_);
    uint16_t index = (eventId - (EVENT_INIT_VALUE)) / (256 * 1024);
    COND_RETURN_VOID(index > (MAX_POOL_CNT - 1), "can not get addr by id, event_id=%d, index=%u.", eventId, index);
    eventAllocator_[index]->FreeByItem(eventAddr);
    eventIdMap_.erase(eventId);
    eventIdCount_--;
}
}
}
