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

BufferAllocator::BufferAllocator(const uint32_t size, const uint32_t initCnt, const uint32_t maxCnt,
    const Strategy stg, const AllocFuncPtr allocFunctionPtr, const FreeFuncPtr freeFunctionPtr, void * const allocParam)
    : NoCopy(),
      allocStrategy_(stg),
      itemSize_(size),
      initCount_((initCnt < maxCnt) ? initCnt : maxCnt),
      maxCount_(maxCnt),
      poolSize_(GetPoolIndex(maxCount_ - 1U) + 1U),
      bitmap_(maxCnt <= BUFF_SLIP_NUMBER ? maxCnt : BUFF_SLIP_NUMBER),
      para_(allocParam),
      pool_(nullptr),
      currentCount_((initCnt < maxCnt) ? initCnt : maxCnt),
      allocFunc_(allocFunctionPtr),
      freeFunc_(freeFunctionPtr),
      allocFuncState_(true)
{
    if ((maxCount_ == 0U) || (itemSize_ == 0U) || (initCount_ == 0U)) {
        RT_LOG(RT_LOG_ERROR, "invalid maxCount=%u, itemSize=%u(bytes), initCount=%u", maxCount_, itemSize_, initCnt);
        return;
    }

    const uint32_t poolArraySize = (GetPoolIndex(maxCount_ - 1U) + 1U) * sizeof(uint8_t *);
    pool_ = RtPtrToPtr<uint8_t **>(malloc(static_cast<size_t>(poolArraySize)));
    if (pool_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "malloc array failed, size=%u(bytes)", poolArraySize);
        return;
    }

    const errno_t rc = memset_s(static_cast<void *>(const_cast<uint8_t **>(pool_)), static_cast<size_t>(poolArraySize),
        0, static_cast<size_t>(poolArraySize));
    if (rc != EOK) {
        RT_LOG(RT_LOG_ERROR, "memset array failed, size=%u(bytes), retCode=%d.", poolArraySize, rc);
        free(static_cast<void *>(const_cast<uint8_t **>(pool_)));
        pool_ = nullptr;
        return;
    }

    const auto ptr = allocFunc_(initCount_ * itemSize_, para_);
    if (ptr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "allocFunc failed, init count=%u, item size=%u(bytes)", initCount_, itemSize_);
        allocFuncState_ = false;  // allocFunc fail
        free(static_cast<void *>(const_cast<uint8_t **>(pool_)));
        pool_ = nullptr;
        return;
    }

    pool_[0] = static_cast<uint8_t *>(ptr);
    RT_LOG(RT_LOG_INFO, "alloc success, Runtime_alloc_size %u(bytes)", poolArraySize);
}

BufferAllocator::~BufferAllocator()
{
    if (pool_ == nullptr) {
        DELETE_O(hugeBitmap_);
        return;
    }

    for (uint32_t i = 0U; i < poolSize_; i++) {
        if (pool_[i] != nullptr) {
            freeFunc_(pool_[i], para_);
            pool_[i] = nullptr;
        }
    }

    free(static_cast<void *>(const_cast<uint8_t **>(pool_)));
    pool_ = nullptr;
    DELETE_O(hugeBitmap_);
}

int32_t BufferAllocator::AllocId(const bool isLogError)
{
    if (pool_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "pool array is null");
        return -1;
    }

    uint32_t curCount = currentCount_;
    int32_t id = AllocBitMap(curCount);
    while (unlikely((id < 0) && (curCount < maxCount_))) {  // No enough ID
        uint32_t newCount = GetIncreasedCount(curCount);
        newCount = (newCount > maxCount_) ? maxCount_ : newCount;
        if (CompareAndExchange(&currentCount_, curCount, newCount)) {
            const size_t newPoolSize = (static_cast<size_t>(newCount) - static_cast<size_t>(curCount))
                * static_cast<size_t>(itemSize_);
            const uint32_t poolIdx = GetPoolIndex(newCount - 1U);
            const auto ptr = allocFunc_(newPoolSize, para_);
            if (ptr == nullptr) {
                allocFuncState_ = false;  // allocFunc fail
                RtLogErrorLevelControl(isLogError, "allocFunc failed, new size count=%u, pool index=%u",
                    newPoolSize, poolIdx);
                return -1;
            }
            pool_[poolIdx] = static_cast<uint8_t *>(ptr);
        }
        // Anyway, currentCount_ is increased
        id = AllocBitMap(currentCount_);
        curCount = currentCount_;
    }

    if (id < 0) {
        int32_t loopCount = 0;
        RT_LOG(RT_LOG_EVENT, "repeat alloc id, currentCount=%u.", currentCount_);
        do {
            id = AllocBitMap(currentCount_);
            loopCount++;
        } while ((id < 0) && (loopCount < TRY_ALLOC_ID_TIMES));
    }
    return id;
}

int32_t BufferAllocator::AllocBitMap(uint32_t curCount)
{
    int32_t id = -1;
    if (openHugeBuff_ == true && hugeBitmap_ == nullptr) {
        hugeBitmap_ = new (std::nothrow) Bitmap(maxCount_ - BUFF_SLIP_NUMBER);
    }

    id = bitmap_.AllocId(curCount);
    if ((id < 0) && (curCount > BUFF_SLIP_NUMBER) && openHugeBuff_ && (hugeBitmap_ != nullptr)) {
        id = hugeBitmap_->AllocId(curCount - BUFF_SLIP_NUMBER);
        id = (id >= 0) ? (id + BUFF_SLIP_NUMBER) : id;
    }

    return id;
}

int32_t BufferAllocator::AllocIdForEventPool(int32_t *currentId, const bool isLogError)
{
    COND_RETURN_ERROR(pool_ == nullptr, -1, "pool array is null");
    uint32_t curCount = currentCount_;
    int32_t id = AllocBitMap(curCount);
    while (unlikely((id < 0) && (curCount < maxCount_))) {  // No enough ID
        uint32_t newCount = GetIncreasedCount(curCount);
        newCount = (newCount > maxCount_) ? maxCount_ : newCount;
        if (CompareAndExchange(&currentCount_, curCount, newCount)) {
            const uint32_t newPoolSize = (newCount - curCount) * itemSize_;
            const uint32_t poolIdx = GetPoolIndex(newCount - 1U);
            const auto ptr = allocFunc_(newPoolSize, para_);
            if (ptr == nullptr) {
                allocFuncState_ = false;  // allocFunc fail
                RtLogErrorLevelControl(isLogError, "allocFunc failed, new size count=%u, pool index=%u",
                    newPoolSize, poolIdx);
                return -1;
            }
            pool_[poolIdx] = static_cast<uint8_t *>(ptr);
        }
        // Anyway, currentCount_ is increased
        id = AllocBitMap(currentCount_);
        curCount = currentCount_;
    }
    *currentId = (id < 0) ? -1 : id;
    return id;
}

void *BufferAllocator::GetItemById(const int32_t id, const bool isLogError) const
{
    if ((pool_ == nullptr) || (id < 0)) {
        RtLogErrorLevelControl(isLogError, "pool is nullptr or id less than zero, now id=%d, pool=%p.",
            id, pool_);
        return nullptr;
    }

    if (likely(BitmapIsOccupied(id))) {
        const uint32_t poolIdx = GetPoolIndex(static_cast<uint32_t>(id));
        const uint32_t baseId = AccumulatePoolCount(poolIdx);
        while (allocFuncState_ && (pool_[poolIdx] == nullptr)) {
            // Not wait now, hold yield.
            (void)sched_yield();
        }
        if (pool_[poolIdx] == nullptr) {
            RtLogErrorLevelControl(isLogError, "pool failed, poolIdx=%u, id=%d", poolIdx, id);
            return nullptr;
        }
        return static_cast<void *>(pool_[poolIdx] +
            (static_cast<uint64_t>(static_cast<uint32_t>(id) - baseId) * itemSize_));
    }
    return nullptr;
}

int32_t BufferAllocator::GetIdByItem(const void * const item) const
{
    if (pool_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "pool array is null");
        return -1;
    }

    for (uint32_t i = 0U; i <= GetPoolIndex(currentCount_ - 1U); i++) {
        const uint32_t baseId = AccumulatePoolCount(i);
        const uint32_t poolCount = AccumulatePoolCount(i + 1U) - baseId;
        if ((pool_[i] <= item) && (item < (pool_[i] + (static_cast<uint64_t>(poolCount) * itemSize_)))) {
            const uint64_t offset = RtPtrToValue(item) - RtPtrToValue(pool_[i]);
            const int32_t id = (static_cast<int32_t>(offset) / static_cast<int32_t>(itemSize_)) +
                static_cast<int32_t>(baseId);
            if (((offset % itemSize_) == 0ULL) && (BitmapIsOccupied(id))) {
                return id;
            }
        }
    }
    return -1;
}

}  // namespace runtime
}  // namespace cce
