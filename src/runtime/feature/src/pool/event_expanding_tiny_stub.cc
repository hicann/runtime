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
#include "device.hpp"

namespace cce {
namespace runtime {
EventExpandingPool::EventExpandingPool(Device * const dev)
    : NoCopy(), device_(dev), eventIdCount_(EVENT_INIT_VALUE), lastEventId_(0U), poolIndex_(0U)
{
}

EventExpandingPool::~EventExpandingPool()
{
}

rtError_t EventExpandingPool::AllocAndInsertEvent(void ** const eventAddr, int32_t *eventId)
{
    UNUSED(eventAddr);
    UNUSED(eventId);
    return RT_ERROR_NONE;
}

rtError_t EventExpandingPool::FindEventAddrById(void ** const eventAddr, int32_t eventId)
{
    UNUSED(eventAddr);
    UNUSED(eventId);
    return RT_ERROR_NONE;
}

void EventExpandingPool::FreeEventAddr(void * const eventAddr, int32_t eventId)
{
    UNUSED(eventAddr);
    UNUSED(eventId);
}
}
}
