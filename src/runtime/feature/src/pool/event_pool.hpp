/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_EVENT_POOL_HPP
#define CCE_RUNTIME_EVENT_POOL_HPP

#include <mutex>
#include "base.hpp"

namespace cce {
namespace runtime {
class Device;

class EventPool : public NoCopy {
public:
    explicit EventPool(Device *device, uint32_t tsId);
    ~EventPool() noexcept override;
    void TryAllocEventIdForPool();
    rtError_t FreeEventId(const int32_t eventId);
    bool AllocEventIdFromPool(int32_t *eventId);
    rtError_t AllocEventIdFromDrv(int32_t * const eventId);
    rtError_t AllocEventId(int32_t *eventId);
    rtError_t EventIdReAlloc();
    rtError_t FreeAllEvent() noexcept;
private:
    bool IsNeedAllocIdForPool();
    uint32_t GetQueueAvilableNum() const;
    std::mutex lk_;
    uint32_t eventQueueHead_{0U};
    uint32_t eventQueueTail_{0U};
    int32_t *eventQueue_{nullptr};
    Device *device_;
    uint8_t poolSize_;
    uint32_t tsId_;
    bool isAging_;
};
}
}

#endif  // CCE_RUNTIME_EVENT_POOL_HPP
