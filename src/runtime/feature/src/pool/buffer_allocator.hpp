/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_BUFFER_ALLOCATOR_HPP
#define CCE_RUNTIME_BUFFER_ALLOCATOR_HPP

#include <cmath>
#include "bitmap.hpp"

namespace cce {
namespace runtime {

constexpr int32_t BUFF_SLIP_NUMBER = 4U * 1024U * 1024U;

class BufferAllocator : public NoCopy {
public:
    enum Strategy {
        LINEAR,
        EXPONENTIAL
    };
    typedef void *(*AllocFuncPtr)(size_t size, void *para);
    typedef void (*FreeFuncPtr)(void *addr, void *para);
    explicit BufferAllocator(const uint32_t size, const uint32_t initCnt = 256, const uint32_t maxCnt = 0x10000,
        const Strategy stg = EXPONENTIAL, const AllocFuncPtr allocFunctionPtr = DefaultAlloc,
        const FreeFuncPtr freeFunctionPtr = DefaultFree, void * const allocParam = nullptr);
    ~BufferAllocator() override;
    static bool openHugeBuff_;
    int32_t AllocId(const bool isLogError = true);
    void *AllocItem(const bool isLogError = true)
    {
        return static_cast<void *>(GetItemById(AllocId(isLogError), isLogError));
    }
    int32_t AllocIdWithoutRetry(const bool isLogError = true);
    
    void *GetItemById(const int32_t id, const bool isLogError = true) const;
    int32_t GetIdByItem(const void * const item) const;
    void FreeById(int32_t id)
    {
        if (id < BUFF_SLIP_NUMBER) {
            bitmap_.FreeId(id);
            return;
        }

        hugeBitmap_->FreeId(id - BUFF_SLIP_NUMBER);
    }
    void FreeByItem(const void *item) 
    {
        FreeById(GetIdByItem(item));
    }

    static void OpenHugeBuff(void) {
        openHugeBuff_ = true;
    }

private:
    static void *DefaultAlloc(size_t size, void *para)
    {
        UNUSED(para);
        if (size > 0) {
            RT_LOG(RT_LOG_INFO, "Runtime_alloc_size %u(bytes)", size);
            void *ptr = malloc(size);
            if (ptr != nullptr) {
                (void)memset_s(ptr, static_cast<size_t>(size), 0, static_cast<size_t>(size));
            }

            return ptr;
        }
        return nullptr;
    }
    static void DefaultFree(void *addr, void *para)
    {
        UNUSED(para);
        free(addr);
    }

    uint32_t GetPoolIndex(uint32_t id) const
    {
        const uint32_t rate = static_cast<uint32_t>(id / initCount_);
        return (allocStrategy_ == LINEAR) ? rate : ((rate > 0U) ? (static_cast<uint32_t>(std::log2(rate)) + 1U) : 0U);
    }
    uint32_t GetIncreasedCount(uint32_t count) const
    {
        return (allocStrategy_ == LINEAR) ? (count + initCount_) : (count * 2); // 根据allocStrategy_选择增加initCount_或者扩大2倍
    }
    uint32_t AccumulatePoolCount(uint32_t idx) const
    {
        const uint32_t rate = (LINEAR == allocStrategy_) ? idx : ((idx > 0U) ? (1U << (idx - 1U)) : 0U);
        return rate * initCount_;
    }

    int32_t AllocBitMap(uint32_t curCount);
    bool BitmapIsOccupied(const int32_t id) const
    {
        if (id < BUFF_SLIP_NUMBER) {
            return bitmap_.IsIdOccupied(id);
        }

        return hugeBitmap_->IsIdOccupied(id - BUFF_SLIP_NUMBER);
    }

    const Strategy allocStrategy_;
    const uint32_t itemSize_;
    const uint32_t initCount_;
    const uint32_t maxCount_;
    const uint32_t poolSize_;
    Bitmap bitmap_;
    void *const para_;
    uint8_t *volatile *pool_;
    uint32_t volatile currentCount_;
    const AllocFuncPtr allocFunc_;
    const FreeFuncPtr freeFunc_;
    std::atomic<bool> allocFuncState_;
    Bitmap *hugeBitmap_{nullptr};
};
}
}

#endif  // CCE_RUNTIME_BUFFER_ALLOCATOR_HPP
