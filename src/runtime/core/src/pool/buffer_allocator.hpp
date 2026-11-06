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

#include <algorithm>
#include <cmath>
#include <mutex>
#include <shared_mutex>
#include "bitmap.hpp"
#include "securec.h"

namespace cce {
namespace runtime {

class Device;
constexpr int32_t BUFF_SLIP_NUMBER = static_cast<int32_t>(4U * 1024U * 1024U);

class BufferAllocator : public NoCopy {
public:
    enum Strategy { LINEAR, EXPONENTIAL };
    typedef void* (*AllocFuncPtr)(size_t size, void* para);
    typedef void (*FreeFuncPtr)(void* addr, void* para);
    explicit BufferAllocator(
        const uint32_t size, const uint32_t initCnt = 256U, const uint32_t maxCnt = 0x10000U,
        const Strategy stg = EXPONENTIAL, AllocFuncPtr const allocFunctionPtr = &DefaultAlloc,
        FreeFuncPtr const freeFunctionPtr = &DefaultFree, void* const allocParam = nullptr,
        const bool enablePoolRelease = false);
    ~BufferAllocator() override;
    static bool openHugeBuff_;
    int32_t AllocId(const bool isLogError = true);
    void* AllocItem(const bool isLogError = true)
    {
        return static_cast<void*>(GetItemById(AllocId(isLogError), isLogError));
    }
    int32_t AllocIdWithoutRetry(const bool isLogError = true);

    void* GetItemById(const int32_t id, const bool isLogError = true) const;
    int32_t GetIdByItem(const void* const item) const;
    void FreeById(int32_t id);
    void FreeByItem(const void* item) { FreeById(GetIdByItem(item)); }

    static void OpenHugeBuff(void) { openHugeBuff_ = true; }

    rtError_t MemsetBuffers(Device* device, uint32_t value);

private:
    enum class PoolState : uint8_t { UNEXPANDED, INITIALIZING, INITIALIZED, RELEASED };

    struct PoolMeta {
        Atomic<uint32_t> availableItemCount{0U};
        Atomic<PoolState> state{PoolState::UNEXPANDED};
    };

    static void* DefaultAlloc(size_t size, void* para)
    {
        UNUSED(para);
        if (size > 0) {
            RT_LOG(RT_LOG_INFO, "Runtime_alloc_size %u(bytes)", size);
            void* ptr = malloc(size);
            if (ptr != nullptr) {
                (void)memset_s(ptr, static_cast<size_t>(size), 0, static_cast<size_t>(size));
            }

            return ptr;
        }
        return nullptr;
    }
    static void DefaultFree(void* addr, void* para)
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
        return (allocStrategy_ == LINEAR) ? (count + initCount_) :
                                            (count * 2); // 根据allocStrategy_选择增加initCount_或者扩大2倍
    }
    uint32_t AccumulatePoolCount(uint32_t idx) const
    {
        const uint32_t rate = (LINEAR == allocStrategy_) ? idx : ((idx > 0U) ? (1U << (idx - 1U)) : 0U);
        return rate * initCount_;
    }
    uint32_t GetPoolCount(uint32_t poolIdx) const
    {
        const uint32_t baseId = AccumulatePoolCount(poolIdx);
        const uint32_t endId = std::min(AccumulatePoolCount(poolIdx + 1U), maxCount_);
        return endId - baseId;
    }

    int32_t AllocBitMap(uint32_t curCount);
    void FreeBitmapId(int32_t id);
    bool PrepareAllocatedId(int32_t id, bool isLogError);
    bool InitializePool(const uint32_t poolIdx, const PoolState failureState, const bool isLogError) const;
    void RollbackAllocatedId(int32_t id, uint32_t poolIdx);
    int32_t FinishAllocatedId(int32_t id, bool isLogError, bool& canRetry);
    int32_t AllocIdWithoutRetryInner(bool isLogError, bool& canRetry);
    bool BitmapIsOccupied(const int32_t id) const
    {
        if (id < BUFF_SLIP_NUMBER) {
            return bitmap_.IsIdOccupied(id);
        }

        if (hugeBitmap_ != nullptr) {
            return hugeBitmap_->IsIdOccupied(id - BUFF_SLIP_NUMBER);
        } else {
            return false;
        }
    }

    const Strategy allocStrategy_;
    const uint32_t itemSize_;
    const uint32_t initCount_;
    const uint32_t maxCount_;
    uint32_t poolSize_;
    Bitmap bitmap_;
    void* const para_;
    uint8_t* volatile* pool_;
    uint32_t volatile currentCount_;
    AllocFuncPtr const allocFunc_;
    FreeFuncPtr const freeFunc_;
    const bool enablePoolRelease_;
    PoolMeta* poolMeta_{nullptr};
    mutable std::shared_mutex poolMutex_;
    Atomic<bool> allocFuncState_;
    std::mutex hugeBitmapMutex_;
    Bitmap* hugeBitmap_{nullptr};
};
} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_BUFFER_ALLOCATOR_HPP
