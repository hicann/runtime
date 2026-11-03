/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "buffer_allocator.hpp"
#include "error_message_manage.hpp"

namespace {
constexpr int32_t TRY_ALLOC_ID_TIMES = 1000;
}

namespace cce {
namespace runtime {

bool BufferAllocator::openHugeBuff_ = false;

BufferAllocator::BufferAllocator(
    const uint32_t size, const uint32_t initCnt, const uint32_t maxCnt, const Strategy stg,
    AllocFuncPtr const allocFunctionPtr, FreeFuncPtr const freeFunctionPtr, void* const allocParam,
    const bool enablePoolRelease)
    : NoCopy(),
      allocStrategy_(stg),
      itemSize_(size),
      initCount_((initCnt < maxCnt) ? initCnt : maxCnt),
      maxCount_(maxCnt),
      poolSize_(0),
      bitmap_(maxCnt <= static_cast<uint32_t>(BUFF_SLIP_NUMBER) ? maxCnt : static_cast<uint32_t>(BUFF_SLIP_NUMBER)),
      para_(allocParam),
      pool_(nullptr),
      currentCount_((initCnt < maxCnt) ? initCnt : maxCnt),
      allocFunc_(allocFunctionPtr),
      freeFunc_(freeFunctionPtr),
      enablePoolRelease_(enablePoolRelease),
      allocFuncState_(true)
{
    if ((maxCount_ == 0U) || (itemSize_ == 0U) || (initCount_ == 0U)) {
        RT_LOG(RT_LOG_ERROR, "invalid maxCount=%u, itemSize=%u(bytes), initCount=%u", maxCount_, itemSize_, initCnt);
        return;
    }

    poolSize_ = GetPoolIndex(maxCount_ - 1U) + 1U;
    const uint32_t poolArraySize = static_cast<uint32_t>((GetPoolIndex(maxCount_ - 1U) + 1U) * sizeof(uint8_t*));
    pool_ = RtPtrToPtr<uint8_t**>(malloc(static_cast<size_t>(poolArraySize)));
    if (pool_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Failed to malloc pool array, size=%u(bytes).", poolArraySize);
        return;
    }

    const errno_t rc = memset_s(
        static_cast<void*>(const_cast<uint8_t**>(pool_)), static_cast<size_t>(poolArraySize), 0,
        static_cast<size_t>(poolArraySize));
    if (rc != EOK) {
        RT_LOG(RT_LOG_ERROR, "memset array failed, size=%u(bytes), retCode=%d.", poolArraySize, rc);
        free(static_cast<void*>(const_cast<uint8_t**>(pool_)));
        pool_ = nullptr;
        return;
    }

    if (enablePoolRelease_) {
        poolMeta_ = new (std::nothrow) PoolMeta[poolSize_];
        if (poolMeta_ == nullptr) {
            RT_LOG(RT_LOG_ERROR, "Failed to allocate pool metadata, poolSize=%u.", poolSize_);
            free(static_cast<void*>(const_cast<uint8_t**>(pool_)));
            pool_ = nullptr;
            return;
        }
        for (uint32_t i = 0U; i < poolSize_; ++i) {
            poolMeta_[i].availableItemCount.Set(GetPoolCount(i));
        }
    }

    const auto ptr = allocFunc_(initCount_ * itemSize_, para_);
    if (ptr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "allocFunc failed, init count=%u, item size=%u(bytes)", initCount_, itemSize_);
        allocFuncState_.Set(false); // allocFunc fail
        DELETE_A(poolMeta_);
        free(static_cast<void*>(const_cast<uint8_t**>(pool_)));
        pool_ = nullptr;
        return;
    }

    pool_[0] = static_cast<uint8_t*>(ptr);
    if (enablePoolRelease_) {
        poolMeta_[0].state.Set(PoolState::INITIALIZED);
    }
    RT_LOG(RT_LOG_INFO, "alloc success, Runtime_alloc_size %u(bytes)", poolArraySize);
}

BufferAllocator::~BufferAllocator()
{
    if (pool_ == nullptr) {
        DELETE_A(poolMeta_);
        DELETE_O(hugeBitmap_);
        return;
    }

    for (uint32_t i = 0U; i < poolSize_; i++) {
        if (pool_[i] != nullptr) {
            freeFunc_(pool_[i], para_);
            pool_[i] = nullptr;
        }
    }

    free(static_cast<void*>(const_cast<uint8_t**>(pool_)));
    pool_ = nullptr;
    DELETE_A(poolMeta_);
    DELETE_O(hugeBitmap_);
}

int32_t BufferAllocator::AllocId(const bool isLogError)
{
    bool canRetry = true;
    int32_t id = AllocIdWithoutRetryInner(isLogError, canRetry);
    if ((id < 0) && canRetry) {
        int32_t loopCount = 0;
        RT_LOG(RT_LOG_EVENT, "repeat alloc id, currentCount=%u.", currentCount_);
        do {
            id = AllocBitMap(currentCount_);
            loopCount++;
        } while ((id < 0) && canRetry && (loopCount < TRY_ALLOC_ID_TIMES));
        if (id >= 0) {
            id = FinishAllocatedId(id, isLogError, canRetry);
        }
    }
    return id;
}

int32_t BufferAllocator::AllocBitMap(uint32_t curCount)
{
    int32_t id = -1;
    if (openHugeBuff_ == true && hugeBitmap_ == nullptr) {
        const std::lock_guard<std::mutex> lock(hugeBitmapMutex_);
        if (hugeBitmap_ == nullptr) {
            hugeBitmap_ = new (std::nothrow) Bitmap(maxCount_ - static_cast<uint32_t>(BUFF_SLIP_NUMBER));
        }
    }

    id = bitmap_.AllocId(curCount);
    if ((id < 0) && (curCount > static_cast<uint32_t>(BUFF_SLIP_NUMBER)) && openHugeBuff_ && (hugeBitmap_ != nullptr)) {
        id = hugeBitmap_->AllocId(curCount - BUFF_SLIP_NUMBER);
        id = (id >= 0) ? (id + BUFF_SLIP_NUMBER) : id;
    }

    return id;
}

int32_t BufferAllocator::AllocIdWithoutRetry(const bool isLogError)
{
    bool canRetry = true;
    return AllocIdWithoutRetryInner(isLogError, canRetry);
}

int32_t BufferAllocator::AllocIdWithoutRetryInner(const bool isLogError, bool& canRetry)
{
    if (pool_ == nullptr) {
        if (enablePoolRelease_) {
            canRetry = false;
        }
        RT_LOG(RT_LOG_ERROR, "Failed to allocate ID because pool array is null.");
        return -1;
    }
    uint32_t curCount = currentCount_;
    int32_t id = AllocBitMap(curCount);
    id = FinishAllocatedId(id, isLogError, canRetry);
    while (unlikely((id < 0) && canRetry && (curCount < maxCount_))) { // No enough ID
        uint32_t newCount = GetIncreasedCount(curCount);
        newCount = (newCount > maxCount_) ? maxCount_ : newCount;
        if (CompareAndExchange(&currentCount_, curCount, newCount)) {
            const uint32_t poolIdx = GetPoolIndex(newCount - 1U);
            if (enablePoolRelease_) {
                std::shared_lock<std::shared_mutex> lock(poolMutex_);
                const bool changed =
                    poolMeta_[poolIdx].state.CompareExchange(PoolState::UNEXPANDED, PoolState::INITIALIZING);
                if (!changed || !InitializePool(poolIdx, PoolState::UNEXPANDED, isLogError)) {
                    allocFuncState_.Set(false);
                    canRetry = false;
                    return -1;
                }
            } else {
                const size_t newPoolSize =
                    (static_cast<size_t>(newCount) - static_cast<size_t>(curCount)) * static_cast<size_t>(itemSize_);
                const auto ptr = allocFunc_(newPoolSize, para_);
                if (ptr == nullptr) {
                    allocFuncState_.Set(false); // allocFunc fail
                    RtLogErrorLevelControl(
                        isLogError, "Failed to call allocFunc, newPoolSize=%zu, poolIdx=%u", newPoolSize, poolIdx);
                    return -1;
                }
                pool_[poolIdx] = RtPtrToPtr<uint8_t*>(ptr);
            }
        }
        // Anyway, currentCount_ is increased
        id = AllocBitMap(currentCount_);
        id = FinishAllocatedId(id, isLogError, canRetry);
        curCount = currentCount_;
    }
    return id;
}

int32_t BufferAllocator::FinishAllocatedId(const int32_t id, const bool isLogError, bool& canRetry)
{
    if ((id < 0) || !enablePoolRelease_) {
        return id;
    }
    if (PrepareAllocatedId(id, isLogError)) {
        return id;
    }
    canRetry = false;
    return -1;
}

bool BufferAllocator::PrepareAllocatedId(const int32_t id, const bool isLogError)
{
    const uint32_t poolIdx = GetPoolIndex(static_cast<uint32_t>(id));
    std::shared_lock<std::shared_mutex> lock(poolMutex_);
    poolMeta_[poolIdx].availableItemCount.Sub(1U);

    while (true) {
        const PoolState state = poolMeta_[poolIdx].state.Value();
        if (state == PoolState::INITIALIZED) {
            return true;
        }
        if (state == PoolState::RELEASED) {
            if (poolMeta_[poolIdx].state.CompareExchange(PoolState::RELEASED, PoolState::INITIALIZING)) {
                if (InitializePool(poolIdx, PoolState::RELEASED, isLogError)) {
                    return true;
                }
                RollbackAllocatedId(id, poolIdx);
                return false;
            }
            continue;
        }
        if ((state == PoolState::UNEXPANDED) && !allocFuncState_.Value()) {
            RollbackAllocatedId(id, poolIdx);
            return false;
        }
        (void)sched_yield();
    }
}

bool BufferAllocator::InitializePool(const uint32_t poolIdx, const PoolState failureState, const bool isLogError) const
{
    const size_t size = static_cast<size_t>(GetPoolCount(poolIdx)) * itemSize_;
    void* const ptr = allocFunc_(size, para_);
    if (ptr == nullptr) {
        RtLogErrorLevelControl(isLogError, "Failed to call allocFunc, newPoolSize=%zu, poolIdx=%u", size, poolIdx);
        poolMeta_[poolIdx].state.Set(failureState);
        return false;
    }
    pool_[poolIdx] = RtPtrToPtr<uint8_t*>(ptr);
    poolMeta_[poolIdx].state.Set(PoolState::INITIALIZED);
    if (failureState == PoolState::RELEASED) {
        RT_LOG(RT_LOG_DEBUG, "Rebuild buffer pool memory, poolIdx=%u, size=%zu(bytes).", poolIdx, size);
    }
    return true;
}

void BufferAllocator::RollbackAllocatedId(const int32_t id, const uint32_t poolIdx)
{
    poolMeta_[poolIdx].availableItemCount.Add(1U);
    FreeBitmapId(id);
}

void BufferAllocator::FreeBitmapId(const int32_t id)
{
    if (id < BUFF_SLIP_NUMBER) {
        bitmap_.FreeId(id);
        return;
    }

    if (hugeBitmap_ != nullptr) {
        hugeBitmap_->FreeId(id - BUFF_SLIP_NUMBER);
    }
}

void BufferAllocator::FreeById(const int32_t id)
{
    if (!enablePoolRelease_) {
        FreeBitmapId(id);
        return;
    }
    if ((id < 0) || (static_cast<uint32_t>(id) >= currentCount_)) {
        return;
    }

    const uint32_t poolIdx = GetPoolIndex(static_cast<uint32_t>(id));
    FreeBitmapId(id);
    const uint32_t availableItemCount = poolMeta_[poolIdx].availableItemCount.AddAndFetch(1U);
    if ((poolIdx == 0U) || (availableItemCount != GetPoolCount(poolIdx))) {
        return;
    }

    std::unique_lock<std::shared_mutex> lock(poolMutex_);
    if ((poolMeta_[poolIdx].availableItemCount.Value() != GetPoolCount(poolIdx)) ||
        (poolMeta_[poolIdx].state.Value() != PoolState::INITIALIZED)) {
        return;
    }

    uint8_t* const ptr = pool_[poolIdx];
    pool_[poolIdx] = nullptr;
    freeFunc_(ptr, para_);
    poolMeta_[poolIdx].state.Set(PoolState::RELEASED);
    RT_LOG(
        RT_LOG_DEBUG, "Release buffer pool memory, poolIdx=%u, size=%zu(bytes).", poolIdx,
        static_cast<size_t>(GetPoolCount(poolIdx)) * itemSize_);
}

void* BufferAllocator::GetItemById(const int32_t id, const bool isLogError) const
{
    if ((pool_ == nullptr) || (id < 0)) {
        RtLogErrorLevelControl(isLogError, "pool is nullptr or id less than 0, now id=%d, pool=%p.", id, pool_);
        return nullptr;
    }

    if (likely(BitmapIsOccupied(id))) {
        const uint32_t poolIdx = GetPoolIndex(static_cast<uint32_t>(id));
        if (enablePoolRelease_ && (poolMeta_[poolIdx].state.Value() != PoolState::INITIALIZED)) {
            return nullptr;
        }
        const uint32_t baseId = AccumulatePoolCount(poolIdx);
        while (allocFuncState_.Value() && (pool_[poolIdx] == nullptr)) {
            // Not wait now, hold yield.
            (void)sched_yield();
        }
        if (pool_[poolIdx] == nullptr) {
            RtLogErrorLevelControl(isLogError, "pool failed, poolIdx=%u, id=%d", poolIdx, id);
            return nullptr;
        }
        return static_cast<void*>(
            pool_[poolIdx] + (static_cast<uint64_t>(static_cast<uint32_t>(id) - baseId) * itemSize_));
    }
    return nullptr;
}

int32_t BufferAllocator::GetIdByItem(const void* const item) const
{
    if (pool_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "pool array is null");
        return -1;
    }

    std::shared_lock<std::shared_mutex> lock(poolMutex_, std::defer_lock);
    if (enablePoolRelease_) {
        lock.lock();
    }
    for (uint32_t i = 0U; i <= GetPoolIndex(currentCount_ - 1U); i++) {
        if (enablePoolRelease_ && ((poolMeta_[i].state.Value() != PoolState::INITIALIZED) || (pool_[i] == nullptr))) {
            continue;
        }
        const uint32_t baseId = AccumulatePoolCount(i);
        const uint32_t poolCount = AccumulatePoolCount(i + 1U) - baseId;
        if ((pool_[i] <= item) && (item < (pool_[i] + (static_cast<uint64_t>(poolCount) * itemSize_)))) {
            const uint64_t offset = RtPtrToValue(item) - RtPtrToValue(pool_[i]);
            const int32_t id =
                (static_cast<int32_t>(offset) / static_cast<int32_t>(itemSize_)) + static_cast<int32_t>(baseId);
            if (((offset % itemSize_) == 0ULL) && (BitmapIsOccupied(id))) {
                return id;
            }
        }
    }
    return -1;
}

rtError_t BufferAllocator::MemsetBuffers(Device* device, uint32_t value)
{
    NULL_PTR_RETURN(device, RT_ERROR_INVALID_VALUE);
    const uint64_t memSize = initCount_ * itemSize_;

    std::unique_lock<std::shared_mutex> lock(poolMutex_, std::defer_lock);
    if (enablePoolRelease_) {
        lock.lock();
    }
    for (uint32_t bufIdx = 0U; bufIdx < poolSize_; ++bufIdx) {
        if (enablePoolRelease_ &&
            ((poolMeta_[bufIdx].state.Value() != PoolState::INITIALIZED) || (pool_[bufIdx] == nullptr))) {
            continue;
        }
        if (pool_[bufIdx] != nullptr) {
            const rtError_t error = device->Driver_()->MemSetSync(pool_[bufIdx], memSize, value, memSize);
            ERROR_RETURN(
                error, "Failed to call MemSetSync, destMax=%" PRIu64 ", value=%u, count=%" PRIu64, memSize, value,
                memSize);
        }
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
