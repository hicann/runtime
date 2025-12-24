/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "bitmap.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t maxAllocIdCountTh = 10U * 1024U;
constexpr uint32_t minAvailableIdCountTh = 1024U;

Bitmap::Bitmap(const uint32_t maxIdCnt) : NoCopy(), freeBitmap_(nullptr), maxIdCount_(maxIdCnt), allocedCnt_(0U), lastAllocIdx_(0U)
{
    COND_LOG((maxIdCnt == 0U), "Bitmap maxId Count should be larger than 0, current maxIdCount is 0");
}

rtError_t Bitmap::AllocBitmap()
{
    // freeBitmap_ just alloc once, modify for KernelLaunch performance optimization
    if (freeBitmap_ != nullptr) {
        return RT_ERROR_NONE;
    }

    mutex_.lock();
    if (freeBitmap_ != nullptr) {
        mutex_.unlock();
        return RT_ERROR_NONE;
    }
    uint64_t *tmpBitmap = nullptr;
    COND_PROC_RETURN_ERROR_MSG_INNER((maxIdCount_ == 0U), RT_ERROR_POOL_RESOURCE, mutex_.unlock(),
        "Alloc bitmap failed, Bitmap maxId Count should be larger than 0, "
        "current maxIdCount is 0");
    const uint32_t maxBitmapIdx = (maxIdCount_ - 1U) / 64U; // 64:bit of uint64_t
    tmpBitmap = new (std::nothrow) uint64_t[maxBitmapIdx + 1U];
    COND_PROC_RETURN_ERROR_MSG_INNER((tmpBitmap == nullptr), RT_ERROR_MEMORY_ALLOCATION, mutex_.unlock(),
        "Alloc new Bitmap failed, size=%zu(bytes)", static_cast<size_t>(maxBitmapIdx + 1U) * sizeof(uint64_t));

    for (uint32_t i = 0U; i <= maxBitmapIdx; i++) {
        tmpBitmap[i] = static_cast<uint64_t>(-1);  // 1-Free; 0-Occupied
    }
    if ((maxIdCount_ % 64U) != 0U) { // 64 bit
        // Invalid highest bits
        tmpBitmap[maxBitmapIdx] = (1ULL << (static_cast<uint64_t>(maxIdCount_) % 64ULL)) - 1ULL;
    }
    freeBitmap_ = tmpBitmap;
    mutex_.unlock();

    return RT_ERROR_NONE;
}

int32_t Bitmap::AllocId(uint32_t maxAllocCount)
{
    const rtError_t error = AllocBitmap();
    COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE), -1,
                                "Alloc bitmap failed, retCode=%#x", static_cast<uint32_t>(error));

    int32_t maxAllocBitmapIdx;
    // calculate the correct max count and max bitmap index for allocation
    if ((maxAllocCount == 0U) || (maxAllocCount > maxIdCount_)) {
        maxAllocCount = maxIdCount_;
    }
    maxAllocBitmapIdx = (static_cast<int32_t>(maxAllocCount) - 1) / 64; // 64:bit of uint64_t
    const uint32_t allocRemainder = maxAllocCount % 64U; // 64:bit of uint64_t
    if (allocRemainder != 0U) {
        maxAllocBitmapIdx = maxAllocBitmapIdx - 1; // exclude the incomplete bitmap
    }

    if ((maxAllocCount > maxAllocIdCountTh) && (freeBitmap_[maxAllocBitmapIdx] == 0)) {
        RT_LOG(RT_LOG_WARNING, "alloced=%u max=%u", allocedCnt_, maxAllocCount);
        if (((std::max(maxAllocCount, allocedCnt_) - std::min(maxAllocCount, allocedCnt_) < minAvailableIdCountTh) &&
            (maxAllocCount != maxIdCount_)) || (allocedCnt_ == maxIdCount_)) {
            /* utilization is larger than 90% */
            return -1;
        }
    }

    uint64_t currentBitmap;
    uint32_t mapIdx = lastAllocIdx_;
    for (int32_t i = 0; i <= maxAllocBitmapIdx; i++) {
        // non-zero means there are free id
        while (true) {
            currentBitmap = freeBitmap_[mapIdx];
            if (currentBitmap == 0ULL) {
                break;
            }
            // index of leftmost 1
            const uint64_t bitIdx = BitScan(currentBitmap);
            const uint64_t newBitmap = currentBitmap & ~(1UL << bitIdx);
            // only one thread could occupy the id
            // other threads loop again to find other free id
            if (CompareAndExchange(&freeBitmap_[mapIdx], currentBitmap, newBitmap)) {
                allocedCnt_++;
                lastAllocIdx_ = mapIdx;
                return (static_cast<int32_t>(mapIdx) * 64) + static_cast<int32_t>(bitIdx); // 64 bit
            }
        }

        // normalize the index to 0~maxAllocBitmapIdx
        mapIdx = (mapIdx + 1U) % (static_cast<uint32_t>(maxAllocBitmapIdx) + 1U);
    }
    if (allocRemainder != 0U) { // process the incomplete bitmap
        mapIdx = static_cast<uint32_t>(maxAllocBitmapIdx) + 1U;
        while (true) {
            currentBitmap = freeBitmap_[mapIdx];
            if ((currentBitmap & ((1UL << allocRemainder) - 1UL)) == 0UL) {
                break;
            }
            // index of leftmost 1
            const uint64_t bitIdx = BitScan(currentBitmap);
            const uint64_t newBitmap = currentBitmap & ~(1ULL << bitIdx);
            // only one thread could occupy the id
            // other threads loop again to find other free id
            if (CompareAndExchange(&freeBitmap_[mapIdx], currentBitmap, newBitmap)) {
                allocedCnt_++;
                lastAllocIdx_ = (mapIdx > 0U ? mapIdx - 1 : 0U);
                return (static_cast<int32_t>(mapIdx) * 64) + static_cast<int32_t>(bitIdx); // 64 bit
            }
        }
    }

    return -1;
}

void Bitmap::FreeId(const int32_t id)
{
    if (likely((id >= 0) && (static_cast<uint32_t>(id) < maxIdCount_) && (freeBitmap_ != nullptr))) {
        const uint32_t mapIdx = static_cast<uint32_t>(id) / 64U; // 64:bit of uint64_t
        const uint32_t bitIdx = static_cast<uint32_t>(id) % 64U; // 64:bit of uint64_t
        FetchAndOr(&freeBitmap_[mapIdx], 1ULL << bitIdx);
        allocedCnt_ = (allocedCnt_ > 0U) ? (allocedCnt_ - 1U) : 0U;
    }
}
bool Bitmap::IsIdOccupied(const int32_t id) const
{
    if (likely((id >= 0) && (static_cast<uint32_t>(id) < maxIdCount_) && (freeBitmap_ != nullptr))) {
        const uint32_t mapIdx = static_cast<uint32_t>(id) / 64U; // 64:bit of uint64_t
        const uint32_t bitIdx = static_cast<uint32_t>(id) % 64U; // 64:bit of uint64_t
        if ((freeBitmap_[mapIdx] & (1UL << bitIdx)) == 0UL) {
            return true;
        }
    }

    return false;
}

void Bitmap::OccupyId(const int32_t id) const
{
    if (likely((id >= 0) && (static_cast<uint32_t>(id) < maxIdCount_) && (freeBitmap_ != nullptr))) {
        const uint32_t mapIdx = static_cast<uint32_t>(id) / 64U; // 64:bit of uint64_t
        const uint32_t bitIdx = static_cast<uint32_t>(id) % 64U; // 64:bit of uint64_t
        FetchAndAnd(&freeBitmap_[mapIdx], ~(1ULL << bitIdx));
    }
}

}  // namespace runtime
}  // namespace cce
