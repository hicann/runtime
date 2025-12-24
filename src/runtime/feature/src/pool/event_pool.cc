/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "event_pool.hpp"
#include "device.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
EventPool::EventPool(Device *device, uint32_t tsId)
    : NoCopy(), device_(device), poolSize_(0U), tsId_(tsId), isAging_(false)
{
    poolSize_ = device->GetDevProperties().eventPoolSize;
    eventQueue_ = new (std::nothrow) int32_t[poolSize_]();
    if (eventQueue_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "alloc eventQueue memory failed");
    }
}

EventPool::~EventPool() noexcept
{
    FreeAllEvent();
    DELETE_A(eventQueue_);
}

uint32_t EventPool::GetQueueAvilableNum() const
{
     return (eventQueueTail_ + poolSize_ - eventQueueHead_) % poolSize_;
}

bool EventPool::IsNeedAllocIdForPool() {
    if (isAging_) {
        RT_LOG(RT_LOG_INFO, "already aging, pool_size=%d.", GetQueueAvilableNum());
        return false;
    }
    if (((eventQueueTail_ + 1U) % poolSize_) == eventQueueHead_) {
        RT_LOG(RT_LOG_DEBUG, "event queue is full, head=%u, tail=%u", eventQueueHead_, eventQueueTail_);
        return false;
    }
    return true;
}

rtError_t EventPool::AllocEventIdFromDrv(int32_t * const eventId)
{
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_NOTIFY_ONLY)) {
        return device_->Driver_()->NotifyIdAlloc(static_cast<int32_t>(device_->Id_()),
            RtPtrToPtr<uint32_t *>(eventId), tsId_, 0U, false, true);
    } else {
        return device_->Driver_()->EventIdAlloc(eventId, device_->Id_(), tsId_);
    }
}

void EventPool::TryAllocEventIdForPool()
{
    if (!IsNeedAllocIdForPool()) {
        return;
    }
    int32_t eventId;
    const rtError_t error = AllocEventIdFromDrv(&eventId);
    if (error == RT_ERROR_NONE) {
        std::lock_guard<std::mutex> lock(lk_);
        if (!IsNeedAllocIdForPool()) {
            FreeEventId(eventId);
            return;
        }
        eventQueue_[eventQueueTail_] = eventId;
        eventQueueTail_ = (eventQueueTail_ + 1U) % poolSize_;
        RT_LOG(RT_LOG_INFO, "alloc event_id=%d for pool.", eventId);
    }
}

rtError_t EventPool::FreeEventId(const int32_t eventId)
{
    // 1. first free id.
    const rtError_t error = device_->FreeEventIdFromDrv(eventId);
    COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE), error, "Event Id Free failed, retCode=%#x.",
                                static_cast<uint32_t>(error));
    // 2. if queue not empty need alloc; else return.
    (void)TryAllocEventIdForPool();
    RT_LOG(RT_LOG_INFO, "device_id=%u, free event_id=%d, pool event_num =%d", device_->Id_(), eventId,
           GetQueueAvilableNum());
    return RT_ERROR_NONE;
}

rtError_t EventPool::FreeAllEvent() noexcept
{
    isAging_ = true;
    std::vector<int32_t> tempEventBuffer;
    {
        std::lock_guard<std::mutex> lock(lk_);
        while (eventQueueHead_ != eventQueueTail_) {
            tempEventBuffer.push_back(eventQueue_[eventQueueHead_]);
            eventQueueHead_ = (eventQueueHead_ + 1) % poolSize_;
        }
    }
    for (auto &id: tempEventBuffer) {
        const rtError_t error = device_->FreeEventIdFromDrv(id);
        COND_LOG_ERROR((error != RT_ERROR_NONE), "Event Id Free failed, retCode=%#x.", error);
        RT_LOG(RT_LOG_INFO, "free pool event_id=%d", id);
    }
    return RT_ERROR_NONE;
}

bool EventPool::AllocEventIdFromPool(int32_t *eventId)
{
    const std::lock_guard<std::mutex> lock(lk_);
    device_->SetLastUsagePoolTimeStamp();
    isAging_ = false;
    if (eventQueueHead_ != eventQueueTail_) {
        *eventId = eventQueue_[eventQueueHead_];
        eventQueueHead_ = (eventQueueHead_ + 1) % poolSize_;
        return true;
    }
    return false;
}

rtError_t EventPool::EventIdReAlloc()
{
    const std::lock_guard<std::mutex> lock(lk_);
    Driver *devDrv = device_->Driver_();
    NULL_PTR_RETURN_MSG(devDrv, RT_ERROR_DRV_NULL);
    for (uint32_t i = eventQueueHead_; i < eventQueueTail_; i++) {
        const int32_t eventId = eventQueue_[i];
        const rtError_t error = devDrv->ReAllocResourceId(
            device_->Id_(), device_->DevGetTsId(), 0U, static_cast<uint32_t>(eventId), DRV_EVENT_ID);
        ERROR_RETURN(error,
            "Reallocate event id failed, eventId=%d, drv devId=%u, retCode=%#x.",
            eventId,
            device_->Id_(),
            error);
        RT_LOG(RT_LOG_INFO, "Reallocate event id successfully, drv devId=%u, eventId=%d", device_->Id_(), eventId);
    }
    return RT_ERROR_NONE;
}

rtError_t EventPool::AllocEventId(int32_t *eventId)
{
    if (AllocEventIdFromPool(eventId)) { // pool not empty，pop event queue;
        RT_LOG(RT_LOG_INFO, "alloc from pool, event_id=%d.", *eventId);
        return RT_ERROR_NONE;
    }
    return AllocEventIdFromDrv(eventId); // pool empty, alloc from drv
}

}  // namespace runtime
}  // namespace cce
