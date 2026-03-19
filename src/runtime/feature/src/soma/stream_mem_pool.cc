/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "common/internal_error_define.hpp"
#include "stream_mem_pool.hpp"
#include "npu_driver.hpp"

namespace cce {
namespace runtime {

std::once_flag PoolRegistry::initFlag_;
PoolRegistry* PoolRegistry::poolRegistry_ = nullptr;

Segment::Segment(uint64_t base, uint64_t size) :
    basePtr(base), size(size), prev(nullptr), next(nullptr), streamId(INVALID_STREAM_ID),
    graphId(MODEL_ID_INVALID), eventId(INVALID_EVENT_ID), inUse(false)
{}

Segment::Segment(uint64_t base, uint64_t size, Segment *prev, Segment *next) :
    basePtr(base), size(size), prev(prev), next(next), streamId(INVALID_STREAM_ID),
    graphId(MODEL_ID_INVALID), eventId(INVALID_EVENT_ID), inUse(false)
{}

Segment* Segment::SplitLeft(uint64_t splitedSize, bool mustSplit)
{
    if (splitedSize > size) {
        return nullptr;
    } else if (splitedSize == size && !mustSplit) {
        return this;
    } else {
        auto splitedSeg = SegmentManager::CreateSegment(basePtr, splitedSize, prev, this);
        COND_RETURN_ERROR(splitedSeg == nullptr, nullptr, "Failed to allocate New Segment: Host out of memory.");
        splitedSeg->eventId = eventId;
        splitedSeg->streamId = streamId;
        if (prev != nullptr) {
            prev->next = splitedSeg;
        }
        prev = splitedSeg;
        size -= splitedSize;
        basePtr = basePtr + static_cast<uintptr_t>(splitedSize);
        return splitedSeg;
    }
}

SegmentManager::SegmentManager(Segment *seg, uint32_t deviceId, bool canDelete) :
    tail_(seg), base_(0U), size_(0U), busySize_(0U), reserveSize_(0U), maxBusySize_(0U),
    maxReservedSize_(0U), deviceId_(deviceId), canDelete_(canDelete), isIPCPool_(false)
{
    if (seg == nullptr) {
        RT_LOG(RT_LOG_WARNING,
        "The mempool is being initialized using an empty segment, memPoolID=%" PRIx64, MemPoolId());
    } else {
        base_ = seg->basePtr;
        size_ = seg->size;
    }
}

Segment* SegmentManager::CreateSegment(uint64_t base, uint64_t size)
{
    return new (std::nothrow) Segment(base, size);
}

Segment* SegmentManager::CreateSegment(uint64_t base, uint64_t size, Segment *next, Segment *prev)
{
    return new (std::nothrow) Segment(base, size, next, prev);
}

SegmentManager::~SegmentManager()
{
    RT_LOG(RT_LOG_DEBUG, "SegmentManager destroy.");
    std::lock_guard<std::mutex> lock(mutex_);

    if (tail_ == nullptr) {
        return ;
    }
    Segment *it = tail_->prev;
    while (tail_->basePtr != base_) {
        tail_->prev = it->prev;
        tail_->basePtr = it->basePtr;
        delete it;
        it = tail_->prev;
    }
    if (it != nullptr) {
        it->next = tail_;
    }
}

rtError_t SegmentManager::SegmentAlloc(Segment* &ret, uint64_t size, int streamId)
{
    COND_RETURN_ERROR(tail_ == nullptr, RT_ERROR_MEM_POOL_ALLOC,
        "Segment not properly initialized, memPoolID=%" PRIx64 ".", MemPoolId());

    COND_RETURN_ERROR(isIPCPool_, RT_ERROR_POOL_UNSUPPORTED,
        "Memory allocation from a IPC pool denied. The IPC pool is read-only.");
    
    std::lock_guard<std::mutex> lock(mutex_);
    ReuseFlag flag;
    Segment* reuseSegment = StreamOpportReuse(size, streamId, flag);
    if (reuseSegment == nullptr) {
        RT_LOG(RT_LOG_DEBUG, "Allocating new segment from tail, size=%" PRIx64 ".", size);
        ret = tail_->SplitLeft(size, true);
        if (ret == nullptr) {
            RT_LOG(RT_LOG_INFO,
                "Unable to alloc segments(size=" PRIx64 ") from tail(size=" PRIx64 "). Merging segments to tail.", 
                size, tail_->size);
            mergeSegToTail();
            ret = tail_->SplitLeft(size, true);
        }
        COND_RETURN_ERROR(ret == nullptr, RT_ERROR_MEM_POOL_ALLOC,
            "Unable to alloc segments(size=" PRIx64 ") from tail(size=" PRIx64 ")", size, tail_->size);
        ret->inUse = true;
        ret->streamId = streamId;
        (void)allocedMap_.insert(std::make_pair(ret->basePtr, ret));
        reserveSize_ += size;
        maxReservedSize_ = max(maxReservedSize_, reserveSize_);
    } else {
        RT_LOG(RT_LOG_DEBUG,
            "Allocating new segment from cached segments, size=" PRIx64 ", cached block size=" PRIx64 ".",
            size, reuseSegment->size);
        (void)cachedSegs_.erase(reuseSegment);
        ret = reuseSegment->SplitLeft(size);
        COND_RETURN_ERROR(ret == nullptr, RT_ERROR_MEM_POOL_ALLOC,
            "Unable to alloc segments(size=" PRIx64 ") from segment(size=" PRIx64 ").", size, reuseSegment->size);
        
        ret->inUse = true;
        (void)allocedMap_.insert(std::make_pair(ret->basePtr, ret));
        if (reuseSegment->basePtr != ret->basePtr) {
            (void)cachedSegs_.insert(reuseSegment);
        }
    }
    busySize_ += size;
    maxBusySize_ = max(maxBusySize_, busySize_);
    return RT_ERROR_NONE;
}

rtError_t SegmentManager::SegmentFree(uint64_t ptr)
{
    std::lock_guard<std::mutex> lock(mutex_);
    auto it = allocedMap_.find(ptr);
    COND_RETURN_ERROR(it == allocedMap_.end(), RT_ERROR_POOL_PTR_NOTFOUND,
        "Unable to free ptr=%" PRIx64 " from memPoolId=%" PRIx64, ptr, MemPoolId());
    
    Segment *seg = it->second;
    (void)allocedMap_.erase(it);
    seg->inUse = false;
    MaintainList(seg);
    (void)cachedSegs_.insert(seg);
    busySize_ -= seg->size;
    return RT_ERROR_NONE;
}

void SegmentManager::MaintainList(Segment *seg)
{
    while ((seg->basePtr != base_) && CheckMergeRules(seg->prev, seg)) {
        auto mergedSeg = seg->prev;
        RT_LOG(RT_LOG_DEBUG,
            "Merging segment and its previous segment,  base from " PRIx64 " to " PRIx64 "size from %" PRIx64 " to %" PRIx64,
            seg->basePtr, mergedSeg->basePtr, seg->size, seg->size + mergedSeg->size);
        seg->prev = mergedSeg->prev;
        if (mergedSeg->prev != nullptr) {
            mergedSeg->prev->next = seg;
        }
        seg->basePtr = mergedSeg->basePtr;
        seg->size += mergedSeg->size;
        (void)cachedSegs_.erase(mergedSeg);
        delete mergedSeg;
    }

    while (CheckMergeRules(seg, seg->next)) {
        auto mergedSeg = seg->next;
        RT_LOG(RT_LOG_DEBUG,
            "Merging segment and its next segment, base from " PRIx64 " to " PRIx64 "size from %" PRIx64 " to %" PRIx64,
            seg->basePtr, seg->basePtr, seg->size, seg->size + mergedSeg->size);
        seg->next = mergedSeg->next;
        if (mergedSeg->next != nullptr) {
            mergedSeg->next->prev = seg;
        }
        seg->size += mergedSeg->size;
        (void)cachedSegs_.erase(mergedSeg);
        delete mergedSeg;
    }
}

void SegmentManager::mergeSegToTail()
{
    while(tail_->basePtr != base_ && !tail_->prev->inUse) {
        auto mergedSeg = tail_->prev;
        RT_LOG(RT_LOG_DEBUG, "Merging tail and its previous block, tail base from %" PRIx64 " to %" PRIx64,
            tail_->basePtr, mergedSeg->basePtr);
        tail_->prev = mergedSeg->prev;
        if (mergedSeg->prev != nullptr) {
            mergedSeg->prev->next = tail_;
        }
        tail_->basePtr = mergedSeg->basePtr;
        tail_->size += mergedSeg->size;
        (void)cachedSegs_.erase(mergedSeg);
        delete mergedSeg;
    }
}

Segment* SegmentManager::StreamOpportReuse(uint64_t size, const int32_t streamId, ReuseFlag &flag)
{
    RT_LOG(RT_LOG_DEBUG, "Find block by stream opportunistic reuse, size=" PRIx64 ", streamId=%d.",
        size, streamId);

    Segment* curStmSeg = nullptr;
    Segment* otherStmSeg = nullptr;
    Segment* newSeg = nullptr;

    auto it = std::lower_bound(cachedSegs_.begin(), cachedSegs_.end(), size,
        [](const Segment* seg, size_t targetSize) {
            return seg->size < targetSize;
        });

    for (; it != cachedSegs_.end(); ++it) {
        Segment* segment = *it;
        if (segment->streamId == streamId) {
            curStmSeg = segment;
            break;
        } else if (otherStmSeg == nullptr && segment->streamId != INVALID_STREAM_ID) {
            otherStmSeg = segment;
        }
    }

    if (curStmSeg != nullptr) {
        flag = ReuseFlag::REUSE_FLAG_SINGLE_STREAM;
        return curStmSeg;
    } else if (otherStmSeg != nullptr) {
        flag = ReuseFlag::REUSE_FLAG_OPPOR;
        return otherStmSeg;
    }

    flag = ReuseFlag::REUSE_FLAG_NONE;
    return newSeg;
}

bool SegmentManager::CheckMergeRules(const Segment *segLeft, const Segment *segRight) const
{
    if (segLeft == tail_ || segRight == tail_) {
        return false;
    }
    return segLeft->inUse == segRight->inUse &&
    segLeft->streamId == segRight->streamId &&
    segLeft->graphId == segRight->graphId &&
    segLeft->eventId == segRight->eventId;
}

rtError_t SegmentManager::GetAttribute(rtMemPoolAttr attr, void* value)
{
    switch (attr) {
        case rtMemPoolReuseFollowEventDependencies:
            *static_cast<uint32_t*>(value) = state_.eventDependencies;
            break;
        case rtMemPoolReuseAllowOpportunistic:
            *static_cast<uint32_t*>(value) = state_.opportunistic;
            break;
        case rtMemPoolReuseAllowInternalDependencies:
            *static_cast<uint32_t*>(value) = state_.internalDependencies;
            break;
        case rtMemPoolAttrReleaseThreshold:
            *static_cast<uint64_t*>(value) = state_.waterMark;
            break;
        case rtMemPoolAttrReservedMemCurrent:
            *static_cast<uint64_t*>(value) = reserveSize_;
            break;
        case rtMemPoolAttrReservedMemHigh:
            *static_cast<uint64_t*>(value) = maxReservedSize_;
            break;
        case rtMemPoolAttrUsedMemCurrent:
            *static_cast<uint64_t*>(value) = busySize_;
            break;
        case rtMemPoolAttrUsedMemHigh:
            *static_cast<uint64_t*>(value) = maxBusySize_;
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "Invalid attribute.");
            return RT_ERROR_POOL_PROP_INVALID;
    }
    return RT_ERROR_NONE;
}

void SegmentManager::AddEventIdToSegment(const int32_t streamId, const int32_t eventId)
{
    std::lock_guard<std::mutex> lock(mutex_);
    for (auto &segment : cachedSegs_) {
        if (segment->streamId == streamId) {
            segment->freeEventsMap_.insert(eventId);
        }
    }
}

rtError_t SegmentManager::SetAttribute(rtMemPoolAttr attr, const void *value)
{
    uint64_t reset = 0U;

    COND_RETURN_ERROR(isIPCPool_, RT_ERROR_POOL_UNSUPPORTED,
        "Modification of IPC pool attributes denied. The IPC pool is read-only.");
    
    switch (attr) {
        case rtMemPoolReuseFollowEventDependencies:
            state_.eventDependencies = (*static_cast<const uint32_t*>(value) == 0 ? 0 : 1);
            RT_LOG(RT_LOG_DEBUG, "Set attribute eventDependencies, value=%u.", state_.eventDependencies);
            break;
        case rtMemPoolReuseAllowOpportunistic:
            state_.opportunistic = (*static_cast<const uint32_t*>(value) == 0 ? 0 : 1);
            RT_LOG(RT_LOG_DEBUG, "Set attribute opportunistic, value=%u.", state_.opportunistic);
            break;
        case rtMemPoolReuseAllowInternalDependencies:
            state_.internalDependencies = (*static_cast<const uint32_t*>(value) == 0 ? 0 : 1);
            RT_LOG(RT_LOG_DEBUG, "Set attribute internalDependencies, value=%u.", state_.internalDependencies);
            break;
        case rtMemPoolAttrReleaseThreshold:
            reset = *static_cast<const uint64_t*>(value);
            COND_RETURN_ERROR(reset > size_, RT_ERROR_POOL_PROP_INVALID,
                "Value is out of range, reset value=%" PRIx64", should less than maxsize=%" PRIx64 ".", reset, size_);
                state_.waterMark = reset;
            RT_LOG(RT_LOG_DEBUG, "Set attribute releaseThreshold, value=%" PRIx64 ".",
                *static_cast<const uint64_t*>(value));
            break;
        case rtMemPoolAttrReservedMemHigh:
            reset = *static_cast<const uint64_t*>(value);
            COND_RETURN_ERROR(reset != 0, RT_ERROR_POOL_PROP_INVALID,
                "Set attribute reservedMemHigh only accept zero, value=%ul", reset);
            maxReservedSize_ = 0U;
            RT_LOG(RT_LOG_DEBUG, "Reset reservedMemHigh to zero successfully.");
            break;
        case rtMemPoolAttrUsedMemHigh:
            reset = *static_cast<const uint64_t*>(value);
            COND_RETURN_ERROR(reset != 0, RT_ERROR_POOL_PROP_INVALID,
                "Set attribute usedMemHigh only accept zero, value=%ul", reset);
            maxBusySize_ = 0U;
            RT_LOG(RT_LOG_DEBUG, "Reset usedMemHigh to zero successfully.");
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "Invalid attribute.");
            return RT_ERROR_POOL_PROP_INVALID;
    }
    return RT_ERROR_NONE;
}

rtError_t PoolRegistry::Init()
{
    std::lock_guard<std::mutex> lock(mutex_);
    if (poolAllocator_ != nullptr) {
        RT_LOG(RT_LOG_WARNING, "PoolRegistry already init. PoolAllocator address: %p.", poolAllocator_);
        return RT_ERROR_NONE;
    }

    void *ptr = nullptr;
    rtError_t error = NpuDriver::ReserveMemAddress(&ptr, DEVICE_POOL_VADDR_SIZE, 0U, nullptr, 1U);
    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_NONE,
        "SOMA is not supported.");
    COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_MEMORY_ALLOCATION,
        "Reserve mem address failed, size=%zu, alignment=%zu, flags=%" PRIx64 ", reCode=%#x", DEVICE_POOL_VADDR_SIZE, 0U, 1U, error);
    
    globalSegment_ = SegmentManager::CreateSegment(RtPtrToValue(ptr), DEVICE_POOL_VADDR_SIZE);
    if (globalSegment_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Failed to allocate New Segment: Host out of memory.");
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    poolAllocator_ = CreateManager(globalSegment_, 0U, false);
    if (poolAllocator_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Failed to allocate New SegmentManager: Host out of memory.");
        delete globalSegment_;
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    RT_LOG(RT_LOG_DEBUG, "Init mem address success, devptr=%" PRIx64 ".", globalSegment_->basePtr);
    return RT_ERROR_NONE;
}

PoolRegistry::~PoolRegistry()
{
    RT_LOG(RT_LOG_EVENT, "SOMA PoolRegistry destructor.");
    std::lock_guard<std::mutex> lock(mutex_);
    if (poolAllocator_ != nullptr) {
        delete poolAllocator_;
    }
    if (globalSegment_ != nullptr) {
        rtError_t error = NpuDriver::ReleaseMemAddress(RtPtrToPtr<void*>(globalSegment_->basePtr));
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Release mem address failed, devptr=%" PRIx64 ", reCode=%#x", globalSegment_->basePtr, error);
        }
        delete globalSegment_;
    }
}

SegmentManager* PoolRegistry::CreateManager(Segment *seg, uint32_t deviceId, bool canDeleteOutsideDestruction)
{
    return new (std::nothrow) SegmentManager(seg, deviceId, canDeleteOutsideDestruction);
}

rtError_t PoolRegistry::CreateMemPool(uint64_t size, uint64_t device, bool canDelete, SegmentManager* &memPool)
{
    COND_RETURN_ERROR(poolAllocator_ == nullptr, RT_ERROR_MEM_POOL_NULL,
        "PoolRegistry used before init, or poolAllocator init failed.");
    
    Segment *seg = nullptr;
    rtError_t error = poolAllocator_->SegmentAlloc(seg, static_cast<uint64_t>(size));
    ERROR_RETURN(error, "CreateMemPool failed, no more virtual address for new mempool, size=" PRIx64 ".", size);

    memPool = CreateManager(seg, device, canDelete);
    COND_RETURN_ERROR(memPool == nullptr, RT_ERROR_MEM_POOL_ALLOC,
        "Failed to allocate New SegmentManager: Host out of memory.");
    
    std::lock_guard<std::mutex> lock(mutex_);
    (void)entries_.insert(memPool);
    return RT_ERROR_NONE;
}

rtError_t PoolRegistry::CheckRemoveMemPool(SegmentManager *memPool)
{
    COND_RETURN_ERROR(poolAllocator_ == nullptr, RT_ERROR_MEM_POOL_NULL,
        "PoolRegistry used before init, or poolAllocator init failed.");
    std::lock_guard<std::mutex> lock(mutex_);

    auto it = entries_.find(memPool);
    COND_RETURN_ERROR(it == entries_.end(), RT_ERROR_POOL_PTR_NOTFOUND,
        "Failed to remove memPool, memPoolId=%" PRIx64 ".", memPool->MemPoolId());
    COND_RETURN_ERROR(!(*it)->CanDelete(), RT_ERROR_POOL_OP_INVALID,
        "Failed to destroy not deletable memPool(Id=%" PRIx64 ").", memPool->MemPoolId());
    return RT_ERROR_NONE;
}

rtError_t PoolRegistry::RemoveMemPool(SegmentManager* memPool)
{
    COND_RETURN_ERROR(poolAllocator_ == nullptr, RT_ERROR_MEM_POOL_NULL,
        "PoolRegistry used before init, or poolAllocator init failed.");
    
    {
        std::lock_guard<std::mutex> lock(mutex_);
        (void)entries_.erase(memPool);
    }
    auto base = memPool->PoolSegAddr();
    delete memPool;
    poolAllocator_->SegmentFree(base);
    return RT_ERROR_NONE;
}

void PoolRegistry::CleanupDevice(uint32_t deviceId)
{
    std::lock_guard<std::mutex> lock(mutex_);
    for (auto it = entries_.begin(); it != entries_.end();) {
        if ((*it)->DeviceId() == deviceId) {
            auto base = (*it)->PoolSegAddr();
            delete (*it);
            poolAllocator_->SegmentFree(base);
            it = entries_.erase(it);
        } else {
            ++it;
        }
    }
}

bool PoolRegistry::QueryMemPool(SegmentManager *p)
{
    std::lock_guard<std::mutex> lock(mutex_);
    return entries_.find(p) != entries_.end();
}

SegmentManager *PoolRegistry::FindMemPoolByPtr(void *p)
{
    uint64_t ptr = RtPtrToValue(p);
    std::lock_guard<std::mutex> lock(mutex_);
    COND_RETURN_DEBUG(entries_.empty(), nullptr, "No memory pools created.");
 
    auto it = std::lower_bound(entries_.begin(), entries_.end(), ptr,
        [](const SegmentManager *memPool, const uint64_t p) {
            return memPool->PoolSegAddr() + memPool->PoolSize() <= p;
        });
    COND_RETURN_DEBUG((it == entries_.end() || ptr < (*it)->PoolSegAddr()), nullptr,
        "Pointer %" PRIx64 " not found in any memory pool range.", ptr);
 
    return *it;
}

}  // namespace runtime
}  // namespace cce