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

static void ReleaseEventBuffer(Device* const dev, void* const addr, const bool isHostRegistered)
{
    if (isHostRegistered) {
        const rtError_t unregisterRet = dev->Driver_()->PcieHostUnRegister(addr, dev->Id_());
        COND_LOG_WARN(
            unregisterRet != RT_ERROR_NONE, "host unregister failed, retCode=%#x, device_id=%u.",
            static_cast<uint32_t>(unregisterRet), dev->Id_());
    }
    const rtError_t freeRet = dev->Driver_()->DevMemFree(addr, dev->Id_());
    COND_LOG_WARN(
        freeRet != RT_ERROR_NONE, "device mem free failed, retCode=%#x, device_id=%u.", static_cast<uint32_t>(freeRet),
        dev->Id_());
}

EventExpandingPool::EventExpandingPool(Device* const dev)
    : NoCopy(), device_(dev), eventAllocator_{}, eventIdCount_(EVENT_INIT_VALUE), lastEventId_(0U), poolIndex_(0U)
{
    uint32_t capability = RT_CAPABILITY_NOT_SUPPORT;
    const uint64_t size = static_cast<uint64_t>(EVENT_INIT_CNT) * sizeof(uint8_t);
    const bool need4KAsync = size <= HUGE_PAGE_MEM_CRITICAL_VALUE;
    (void)device_->Driver_()->CheckSupportPcieBarCopy(device_->Id_(), capability, need4KAsync);
    barSupported_ = (capability == RT_CAPABILITY_SUPPORT);
}

EventExpandingPool::~EventExpandingPool()
{
    for (int i = 0; i < MAX_POOL_CNT; ++i) {
        DELETE_O(eventAllocator_[i]);
    }
}

void* EventExpandingPool::MallocBufferForEvent(const size_t size, void* const para)
{
    void* addr = nullptr;
    const EventExpandingPool* const pool = static_cast<EventExpandingPool*>(para);
    Device* const dev = pool->device_;
    const bool barSupported = pool->barSupported_;
    /* 如果支持，申请device内存时PCIE场景必须传入P2P, UB场景传入普通MEMORY也可以，为了归一，都传入P2P */
    const rtMemType_t memType = barSupported ? RT_MEMORY_P2P_HBM : RT_MEMORY_DDR;
    rtError_t error = dev->Driver_()->DevMemAllocWithBackupFlag(
        &addr, static_cast<uint64_t>(size), memType, dev->Id_(), DevMemBackupType::SNAPSHOT_OPTIONAL_BACKUP);
    COND_RETURN_WARN(
        error != RT_ERROR_NONE, nullptr,
        "device mem alloc pool mem failed, "
        "size=%zu(bytes), kind=%d, device_id=%u, retCode=%#x",
        size, memType, dev->Id_(), static_cast<uint32_t>(error));

    if (barSupported) {
        void* outAddr = nullptr;
        error = dev->Driver_()->PcieHostRegister(addr, static_cast<uint64_t>(size), dev->Id_(), outAddr);
        if (error != RT_ERROR_NONE) {
            ReleaseEventBuffer(dev, addr, false);
            RT_LOG(
                RT_LOG_ERROR, "Pcie host register failed, retCode=%#x, size=%zu(bytes), device_id=%u.",
                static_cast<uint32_t>(error), size, dev->Id_());
            return nullptr;
        }
        if (outAddr != addr) {
            ReleaseEventBuffer(dev, addr, true);
            RT_LOG(
                RT_LOG_ERROR,
                "host register returned a different address, dev_addr=%p, host_addr=%p, "
                "size=%zu(bytes), device_id=%u.",
                addr, outAddr, size, dev->Id_());
            return nullptr;
        }
    }

    error = dev->Driver_()->MemSetSync(addr, static_cast<uint64_t>(size), 0U, static_cast<uint64_t>(size));
    if (error != RT_ERROR_NONE) {
        ReleaseEventBuffer(dev, addr, barSupported);
        RT_LOG(
            RT_LOG_WARNING, "device memset sync failed, size=%zu(bytes), kind=%d, device_id=%u, retCode=%#x", size,
            memType, dev->Id_(), static_cast<uint32_t>(error));
        return nullptr;
    }
    return addr;
}

void EventExpandingPool::FreeBufferForEvent(void* const addr, void* const para)
{
    const EventExpandingPool* const pool = static_cast<EventExpandingPool*>(para);
    ReleaseEventBuffer(pool->device_, addr, pool->barSupported_);
}

rtError_t EventExpandingPool::AllocAndInsertEvent(void** const eventAddr, int32_t* eventId)
{
    const std::unique_lock<std::mutex> taskLock(EventMapLock_);
    COND_PROC_RETURN_AND_MSG_OUTER(
        eventIdCount_ == INT32_MAX, RT_ERROR_DRV_NO_EVENT_RESOURCES, ErrorCode::EE1023,
        RT_LOG(RT_LOG_ERROR, "Event count is reaching the maximum."), "Alloc Event resource",
        "Too many events are created");
    int32_t currentEventId = -1;
    const uint16_t oriPoolIndex = poolIndex_;
    do {
        if (eventAllocator_[poolIndex_] == nullptr) {
            eventAllocator_[poolIndex_] = new (std::nothrow) BufferAllocator(
                sizeof(uint8_t), EVENT_INIT_CNT, PER_POOL_CNT, BufferAllocator::LINEAR, &MallocBufferForEvent,
                &FreeBufferForEvent, this);
            COND_RETURN_AND_MSG_OUTER(
                eventAllocator_[poolIndex_] == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
                std::to_string(sizeof(BufferAllocator)).c_str(), "new");
            if (!eventAllocator_[poolIndex_]->IsInitializedSuccess()) {
                DELETE_O(eventAllocator_[poolIndex_]);
                RT_LOG(RT_LOG_ERROR, "Failed to initialize expanded event buffer, poolIndex=%hu.", poolIndex_);
                return RT_ERROR_MEMORY_ALLOCATION;
            }
            RT_LOG(
                RT_LOG_INFO, "Init EventExpandingPool success, poolIndex=%hu, barSupported=%d.", poolIndex_,
                IsBarSupported());
        }

        currentEventId = eventAllocator_[poolIndex_]->AllocIdWithoutRetry(false);
        if (currentEventId >= 0) {
            break;
        }
        poolIndex_ = (poolIndex_ + 1U) % MAX_POOL_CNT;
    } while (oriPoolIndex != poolIndex_); // only one loop
    COND_PROC_RETURN_AND_MSG_OUTER(
        currentEventId < 0, RT_ERROR_DRV_NO_EVENT_RESOURCES, ErrorCode::EE1023,
        RT_LOG(RT_LOG_ERROR, "Failed to allocate event ID from event pool."), "Alloc Event resource",
        "Too many events are created");
    lastEventId_ =
        EVENT_INIT_VALUE + (PER_POOL_CNT * poolIndex_) + currentEventId; // (init:65536) + (PER_POOL_CNT * index)  + cur
    *eventAddr = eventAllocator_[poolIndex_]->GetItemById(currentEventId, false);
    *eventId = lastEventId_;
    eventIdCount_++;
    RT_LOG(
        RT_LOG_INFO, "get event id, event_id=%d, lastEventId=%d, poolIndex=%d, currentEventId=%d.", *eventId,
        lastEventId_, poolIndex_, currentEventId);
    return RT_ERROR_NONE;
}

void EventExpandingPool::FreeEventId(int32_t eventId)
{
    const std::unique_lock<std::mutex> taskLock(EventMapLock_);
    COND_RETURN_VOID(eventId < EVENT_INIT_VALUE, "Free event id failed, event_id=%d.", eventId);
    const uint16_t poolIndex = (eventId - EVENT_INIT_VALUE) / PER_POOL_CNT;
    const int32_t id = (eventId - EVENT_INIT_VALUE) % PER_POOL_CNT;
    COND_RETURN_VOID(poolIndex >= MAX_POOL_CNT, "Free event id failed, event_id=%d, poolIndex=%u.", eventId, poolIndex);
    BufferAllocator* const allocator = eventAllocator_[poolIndex];
    COND_RETURN_VOID(allocator == nullptr, "Free event id failed, event_id=%d, allocator is null.", eventId);
    void* const eventAddr = allocator->GetItemById(id, false);
    COND_RETURN_VOID(eventAddr == nullptr, "Free event id failed, event_id=%d, event address is null.", eventId);
    if (barSupported_) {
        *RtPtrToPtr<volatile uint8_t*>(eventAddr) = 0U;
    } else {
        const rtError_t error = device_->Driver_()->MemSetSync(eventAddr, sizeof(uint8_t), 0U, sizeof(uint8_t));
        COND_RETURN_VOID(
            error != RT_ERROR_NONE, "Failed to clear event value, event_id=%d, retCode=%#x.", eventId,
            static_cast<uint32_t>(error));
    }
    allocator->FreeById(id);
    eventIdCount_--;
}

rtError_t EventExpandingPool::ResetBufferForEvent()
{
    const size_t poolIndex = GetPoolIndex();
    for (size_t poolIdx = 0U; poolIdx <= poolIndex; ++poolIdx) {
        BufferAllocator* allocator = eventAllocator_[poolIdx];
        if (allocator == nullptr) {
            continue;
        }

        const rtError_t error = allocator->MemsetBuffers(device_, 0U);
        ERROR_RETURN(error, "Failed to reset event buffer, poolIdx=%zu", poolIdx);
    }
    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce
