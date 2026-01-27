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
}

EventPool::~EventPool() noexcept
{
}

rtError_t EventPool::AllocEventIdFromDrv(int32_t * const eventId)
{
    UNUSED(eventId);
    return RT_ERROR_NONE;
}

rtError_t EventPool::FreeEventId(const int32_t eventId)
{
    UNUSED(eventId);
    return RT_ERROR_NONE;
}

rtError_t EventPool::FreeAllEvent() noexcept
{
    return RT_ERROR_NONE;
}

bool EventPool::AllocEventIdFromPool(int32_t *eventId)
{
    UNUSED(eventId);
    return false;
}

rtError_t EventPool::EventIdReAlloc()
{
    return RT_ERROR_NONE;
}

rtError_t EventPool::AllocEventId(int32_t *eventId)
{
    UNUSED(eventId);
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
