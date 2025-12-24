/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_EVENT_EXPANDING_HPP
#define CCE_RUNTIME_EVENT_EXPANDING_HPP

#include <mutex>
#include "base.hpp"
#include "buffer_allocator.hpp"
namespace cce {
namespace runtime {
constexpr uint32_t EVENT_INIT_CNT    (2 * 1024 * 1024 / sizeof(uint64_t));
constexpr uint32_t PER_POOL_CNT      (256 * 1024);
constexpr uint16_t MAX_POOL_CNT      (8 * 1024);
constexpr int32_t  EVENT_INIT_VALUE  (UINT16_MAX + 1);
class Device;
class EventExpandingPool : public NoCopy {
public:
    explicit EventExpandingPool(Device * const dev);
    ~EventExpandingPool() override;
    rtError_t AllocAndInsertEvent(void ** const eventAddr, int32_t *eventId);
    rtError_t FindEventAddrById(void ** const eventAddr, int32_t eventId);
    void FreeEventAddr(void * const eventAddr, int32_t eventId);
protected:
    Device* device_;

private:
    BufferAllocator* eventAllocator_[MAX_POOL_CNT];
    std::unordered_map<int32_t, void *> eventIdMap_;
    std::mutex EventMapLock_;
    int32_t eventIdCount_;
    int32_t lastEventId_;
    uint16_t poolIndex_;
    static void *MallocBufferForEvent(const size_t size, void * const para);
    static void FreeBufferForEvent(void * const addr, void * const para);
};
}
}

#endif  // CCE_RUNTIME_EVENT_EXPANDING_HPP
