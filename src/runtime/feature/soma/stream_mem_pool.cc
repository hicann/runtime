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
    graphId(MODEL_ID_INVALID), eventId(INVALID_EVENT_ID), seqId(INVALID_SEQ_ID), state(SegmentState::FREE)
{}

Segment::Segment(uint64_t base, uint64_t size, Segment *prev, Segment *next) :
    basePtr(base), size(size), prev(prev), next(next), streamId(INVALID_STREAM_ID),
    graphId(MODEL_ID_INVALID), eventId(INVALID_EVENT_ID), seqId(INVALID_SEQ_ID), state(SegmentState::FREE)
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
        splitedSeg->seqId = seqId;
        if (prev != nullptr) {
            prev->next = splitedSeg;
        }
        prev = splitedSeg;
        size -= splitedSize;
        basePtr = basePtr + static_cast<uintptr_t>(splitedSize);
        return splitedSeg;
    }
}

void Segment::MergeLeft() {
    Segment* old_prev = prev;
    basePtr = prev->basePtr;
    size += prev->size;
    prev = prev->prev;
    if (prev != nullptr) {
        prev->next = this;
    }
    delete old_prev;
}

SegmentManager::SegmentManager(Segment *seg, uint32_t deviceId, bool canDelete) :
    tail_(seg), base_(0U), size_(0U), busySize_(0U), reserveSize_(0U), maxBusySize_(0U),
    maxReservedSize_(0U), deviceId_(deviceId), graphId_(MODEL_ID_INVALID),
    canDelete_(canDelete), isIPCPool_(false)
{
    if (seg == nullptr) {
        RT_LOG(RT_LOG_WARNING,
            "The mempool is being initialized using an empty segment, memPoolID=%#" PRIx64, MemPoolId());
    } else {
        base_ = seg->basePtr;
        size_ = seg->size;
        seg->state = SegmentState::FREE;
        freeSegs_.insert(seg);
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

void SegmentManager::DeleteSegment(Segment*& segment)
{
    delete segment;
    segment = nullptr;
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
        RT_LOG(RT_LOG_DEBUG, "tail=%#" PRIx64 ".", tail_->basePtr);
        tail_->prev = it->prev;
        tail_->basePtr = it->basePtr;
        delete it;
        it = tail_->prev;
    }
    if (it != nullptr) {
        it->next = tail_;
    }
    delete tail_;
}

Segment* SegmentManager::TryToReuse(size_t size, const int32_t streamId, PoolDependencyFea state, ReuseFlag &flag)
{
    Segment* reuseSeg = nullptr;
    if (state.singleDependencies != 0) {
        reuseSeg = SingleStreamReuse(size, streamId, flag);
        if (reuseSeg != nullptr) return reuseSeg;
    }
    if (state.eventDependencies != 0) {
        reuseSeg = StreamEventReuse(size, streamId, flag);
        if (reuseSeg != nullptr) return reuseSeg;
    }
    if (state.opportunistic != 0) {
        reuseSeg = StreamInternalReuse(size, streamId, true, flag);
        if (reuseSeg != nullptr) return reuseSeg;
    }
    if (state.internalDependencies != 0) {
        reuseSeg = StreamInternalReuse(size, streamId, false, flag);
        if (reuseSeg != nullptr) return reuseSeg;
    }
    return reuseSeg;
}

rtError_t SegmentManager::SegmentAlloc(Segment* &ret, uint64_t size, int streamId, ReuseFlag &flag)
{
    RT_LOG(RT_LOG_DEBUG, "Allocating segment, size=%#" PRIx64 " streamId=%d.", size, streamId);
    COND_RETURN_ERROR(tail_ == nullptr, RT_ERROR_MEM_POOL_ALLOC,
        "Segment not properly initialized, memPoolID=%#" PRIx64 ".", MemPoolId());

    COND_RETURN_ERROR(isIPCPool_, RT_ERROR_POOL_UNSUPPORTED,
        "Memory allocation from a IPC pool denied. The IPC pool is read-only.");

    std::lock_guard<std::mutex> lock(mutex_);
    Segment* reuseSegment = TryToReuse(size, streamId, state_, flag);
    if (reuseSegment == nullptr) {
        ret = AllocFromFreeSegs(size);
        COND_RETURN_ERROR(ret == nullptr, RT_ERROR_MEM_POOL_ALLOC,
            "Unable to alloc segments(size=%#" PRIx64 ") from free segments.", size);

        ret->state = SegmentState::BUSY;
        ret->streamId = streamId;
        (void)allocedMap_.insert(std::make_pair(ret->basePtr, ret));
        reserveSize_ += size;
        maxReservedSize_ = max(maxReservedSize_, reserveSize_);
    } else {
        RT_LOG(RT_LOG_DEBUG,
            "Allocating new segment from cached segments, size=%#" PRIx64 ", cached block size=%#" PRIx64 ".",
            size, reuseSegment->size);
        reuseSegment->streamId = streamId;
        RT_LOG(RT_LOG_DEBUG, "Update reuseSegment streamId to %d.", streamId);
        (void)cachedSegs_.erase(reuseSegment);
        ret = reuseSegment->SplitLeft(size);
        COND_RETURN_ERROR(ret == nullptr, RT_ERROR_MEM_POOL_ALLOC,
            "Unable to alloc segments(size=%#" PRIx64 ") from segment(size=%#" PRIx64 ").", size, reuseSegment->size);

        ret->state = SegmentState::BUSY;
        (void)allocedMap_.insert(std::make_pair(ret->basePtr, ret));
        if (reuseSegment->basePtr != ret->basePtr) {
            (void)cachedSegs_.insert(reuseSegment);
        }
    }
    busySize_ += size;
    maxBusySize_ = max(maxBusySize_, busySize_);
    return RT_ERROR_NONE;
}

rtError_t SegmentManager::SegmentFree(uint64_t ptr, bool forceFree)
{
    std::lock_guard<std::mutex> lock(mutex_);
    auto it = allocedMap_.find(ptr);
    COND_RETURN_ERROR(it == allocedMap_.end(), RT_ERROR_POOL_PTR_NOTFOUND,
        "Unable to free ptr=%#" PRIx64 " from memPoolId=%#" PRIx64, ptr, MemPoolId());
    
    Segment *seg = it->second;
    RT_LOG(RT_LOG_DEBUG, "Free segment ptr=%#" PRIx64 " size=%#" PRIx64 ".", seg->basePtr, seg->size);
    (void)allocedMap_.erase(it);
    busySize_ -= seg->size;
    if (forceFree) {
        seg->state = SegmentState::FREE;
        MergeIntoFreeSegs(seg);
    } else {
        seg->seqId = PoolRegistry::Instance().GetStreamSeqId()[seg->streamId];
        seg->state = SegmentState::CACHED;
        MergeIntoCachedSegs(seg);
    }
    return RT_ERROR_NONE;
}

void SegmentManager::MergeIntoCachedSegs(Segment* &seg)
{
    RT_LOG(RT_LOG_DEBUG, "Merging segment into cachedSegs ptr=%#" PRIx64 " size=%#" PRIx64 ".", seg->basePtr, seg->size);
    while ((seg->basePtr != base_) && (seg->prev != nullptr) && (seg->prev->state == SegmentState::CACHED) && CheckMergeRules(seg->prev, seg)) {
        (void)cachedSegs_.erase(seg->prev);
        seg->MergeLeft();
    }

    while ((seg->next != nullptr) && (seg->next->state == SegmentState::CACHED) && CheckMergeRules(seg, seg->next)) {
        (void)cachedSegs_.erase(seg->next);
        seg = seg->next;
        seg->MergeLeft();
    }
    RT_LOG(RT_LOG_DEBUG, "After merging segment seg, ptr=%#" PRIx64 " size=%lu.", seg->basePtr, seg->size);
    (void)cachedSegs_.insert(seg);
}

Segment* SegmentManager::SingleStreamReuse(size_t size, const int32_t streamId, ReuseFlag &flag)
{
    RT_LOG(RT_LOG_DEBUG, "Find segment by single stream reuse, size=%zu, streamId=%d.", size, streamId);
    Segment* curStmSeg = nullptr;

    auto it = std::lower_bound(cachedSegs_.begin(), cachedSegs_.end(), size,
        [](const Segment* seg, size_t targetSize) {
            return seg->size < targetSize;
        });

    for (; it != cachedSegs_.end(); ++it) {
        Segment* segment = *it;
        if (segment->streamId == streamId) {
            curStmSeg = segment;
            break;
        }
    }

    if (curStmSeg != nullptr) {
        flag = ReuseFlag::REUSE_FLAG_STANDARD;
        RT_LOG(RT_LOG_DEBUG, "Single stream reuse successfully, flag=%d, segPtr=%#" PRIx64 ".",
        static_cast<int32_t>(flag), curStmSeg->basePtr);
        return curStmSeg;
    }

    flag = ReuseFlag::REUSE_FLAG_NONE;
    RT_LOG(RT_LOG_DEBUG, "Single stream do not reuse any segment, flag=%d.", static_cast<int32_t>(flag));
    return curStmSeg;
}

Segment* SegmentManager::StreamEventReuse(size_t size, const int32_t streamId, ReuseFlag &flag)
{
    RT_LOG(RT_LOG_DEBUG, "Find segment by multiple stream event reuse, size=%zu, streamId=%d.", size, streamId);

    std::unordered_map<std::pair<int32_t, int32_t>, uint64_t, PairHash> sequenceMap = PoolRegistry::Instance().GetSequenceMap();
    Segment* eventStmSeg = nullptr;

    auto it = std::lower_bound(cachedSegs_.begin(), cachedSegs_.end(), size,
        [](const Segment* seg, size_t targetSize) {
            return seg->size < targetSize;
        });

    for (; it != cachedSegs_.end(); ++it) {
        Segment* segment = *it;
        auto mapIt = sequenceMap.find({streamId, segment->streamId});
        if (mapIt != sequenceMap.end() && mapIt->second >= segment->seqId) {
            eventStmSeg = segment;
            break;
        }
    }

    if (eventStmSeg != nullptr) {
        flag = ReuseFlag::REUSE_FLAG_STANDARD;
        RT_LOG(RT_LOG_DEBUG, "Stream event reuse successfully, flag=%d, segPtr=%#" PRIx64 ".",
            static_cast<int32_t>(flag), eventStmSeg->basePtr);
        return eventStmSeg;
    }

    flag = ReuseFlag::REUSE_FLAG_NONE;
    RT_LOG(RT_LOG_DEBUG, "Stream event do not reuse any segment, flag=%d.", static_cast<int32_t>(flag));
    return eventStmSeg;
}

Segment* SegmentManager::StreamInternalReuse(size_t size, const int32_t streamId, bool reuseType, ReuseFlag &flag)
{
    RT_LOG(RT_LOG_DEBUG, "Find segment by stream internal reuse, size=%zu, streamId=%d.", size, streamId);

    Segment* otherStmSeg = nullptr;

    auto it = std::lower_bound(cachedSegs_.begin(), cachedSegs_.end(), size,
        [](const Segment* seg, size_t targetSize) {
            return seg->size < targetSize;
        });
    if (it != cachedSegs_.end()) {
        otherStmSeg = *it;
    }

    if (otherStmSeg != nullptr) {
        flag = reuseType ? ReuseFlag::REUSE_FLAG_STANDARD : ReuseFlag::REUSE_FLAG_INTERNAL;
        RT_LOG(RT_LOG_DEBUG, "Stream internal reuse successfully, flag=%d, segPtr=%#" PRIx64 ".",
            static_cast<int32_t>(flag), otherStmSeg->basePtr);
        return otherStmSeg;
    }

    flag = ReuseFlag::REUSE_FLAG_NONE;
    RT_LOG(RT_LOG_DEBUG, "Stream do not reuse any segment internally, flag=%d.", static_cast<int32_t>(flag));
    return otherStmSeg;
}

bool SegmentManager::CheckMergeRules(const Segment *segLeft, const Segment *segRight) const
{
    if (segLeft == tail_ || segRight == tail_) {
        return false;
    }
    return (segLeft->state == segRight->state) &&
        (segLeft->streamId == segRight->streamId) &&
        (segLeft->graphId == segRight->graphId) &&
        (segLeft->eventId == segRight->eventId) &&
        (segLeft->seqId == segRight->seqId);
}

Segment *SegmentManager::AllocFromFreeSegs(uint64_t size)
{
    RT_LOG(RT_LOG_DEBUG, "Allocating new segment from free segments, size=%#" PRIx64 ".", size);
    Segment reqSegs = Segment(0, size);
    auto fit = freeSegs_.lower_bound(&reqSegs);
    if(fit == freeSegs_.end()) {
        RT_LOG(RT_LOG_DEBUG, "Unable to alloc segments(size=%#" PRIx64 ") from free segments.", size);
        return nullptr;
    }

    Segment* seg = *fit;
    freeSegs_.erase(fit);
    Segment* ret = seg->SplitLeft(size);
    if (seg->basePtr != ret->basePtr) {
        freeSegs_.insert(seg);
    }
    return ret;
}

void SegmentManager::MergeIntoFreeSegs(Segment* &seg)
{
    RT_LOG(RT_LOG_DEBUG, "Merging free segment basePtr=%#" PRIx64 " size=%lu.", seg->basePtr, seg->size);

    while ((seg->basePtr != base_) && (seg->prev != nullptr) && (seg->prev->state == SegmentState::FREE)) {
        (void)freeSegs_.erase(seg->prev);
        seg->MergeLeft();
    }
    while ((seg != tail_) && (seg->next != nullptr) && (seg->next->state == SegmentState::FREE)) {
        (void)freeSegs_.erase(seg->next);
        seg = seg->next;
        seg->MergeLeft();
    }
    RT_LOG(RT_LOG_DEBUG, "After merging segment seg, ptr=%#" PRIx64 " size=%lu.", seg->basePtr, seg->size);
    seg->state = SegmentState::FREE;
    freeSegs_.insert(seg);
}

void SegmentManager::TrimCachedSegs(const uint64_t minBytesToKeep)
{
    RT_LOG(RT_LOG_DEBUG, "Trim reserved size from %lu to %lu.", reserveSize_, minBytesToKeep);
    auto it = cachedSegs_.begin();
    while ((it != cachedSegs_.end()) && (reserveSize_ > minBytesToKeep)) {
        Segment* seg = *it;
        RT_LOG(RT_LOG_DEBUG, "Trim cached segment basePtr=%#" PRIx64 " size=%lu.",
                seg->basePtr, seg->size);
        if (seg->size > reserveSize_ - minBytesToKeep) {
            RT_LOG(RT_LOG_DEBUG, "Split last segment with size=%lu for exact trimming, reserved size=%lu, size=%lu.",
                seg->size, reserveSize_, minBytesToKeep);
            (void)cachedSegs_.erase(seg);
            uint64_t leftSize = reserveSize_ - minBytesToKeep;
            Segment* left = seg->SplitLeft(leftSize);
            cachedSegs_.insert(seg);
            reserveSize_ -= leftSize;
            MergeIntoFreeSegs(left);
            break;
        } else {
            it = cachedSegs_.erase(it);
            reserveSize_ -= seg->size;
            MergeIntoFreeSegs(seg);
        }
    }
}

rtError_t SegmentManager::TrimTo(const uint64_t minBytesToKeep)
{
    std::lock_guard<std::mutex> lock(mutex_);
    RT_LOG(RT_LOG_DEBUG, "Trim reserved size from %lu to %lu.", reserveSize_, minBytesToKeep);
    COND_RETURN_ERROR(minBytesToKeep > size_, RT_ERROR_POOL_OP_INVALID,
        "Trim size should smaller than mempool total size, total size=%lu, trim to size=%lu.",
        size_, minBytesToKeep);
    COND_RETURN_DEBUG(minBytesToKeep >= reserveSize_, RT_ERROR_NONE,
        "No need to trim, reserved size=%lu, trim to size=%lu.", reserveSize_, minBytesToKeep);
    COND_RETURN_ERROR(minBytesToKeep < busySize_, RT_ERROR_POOL_OP_INVALID,
        "Trim size is smaller than busy size, busy size=%lu, trim to size=%lu.",
        busySize_, minBytesToKeep);

    TrimCachedSegs(minBytesToKeep);
    return RT_ERROR_NONE;    
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
                "Value is out of range, reset value=%#" PRIx64", should less than maxsize=%#" PRIx64 ".", reset, size_);
                state_.waterMark = reset;
            RT_LOG(RT_LOG_DEBUG, "Set attribute releaseThreshold, value=%#" PRIx64 ".",
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
    if (poolAllocator_ != nullptr) {
        return RT_ERROR_NONE;
    }

    std::lock_guard<std::mutex> lock(mutex_);    
    globalSegment_ = SegmentManager::CreateSegment(DEVICE_POOL_VADDR_START, DEVICE_POOL_VADDR_SIZE, nullptr, nullptr);
    if (globalSegment_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Failed to allocate New Segment: Host out of memory.");
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    poolAllocator_ = CreateManager(globalSegment_, 0U, false);
    if (poolAllocator_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Failed to allocate New SegmentManager: Host out of memory.");
        SegmentManager::DeleteSegment(globalSegment_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    RT_LOG(RT_LOG_DEBUG, "Init mem address success, devptr=%#" PRIx64 ".", globalSegment_->basePtr);
    rtError_t error = RegisterSomaCallBack();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Soma Callback register failed, reCode=%#x.", error);
        DeleteManager(poolAllocator_);
        return error;
    }
    return RT_ERROR_NONE;
}

PoolRegistry::~PoolRegistry()
{
    RT_LOG(RT_LOG_EVENT, "SOMA PoolRegistry destructor.");
    std::lock_guard<std::mutex> lock(mutex_);
    if (poolAllocator_ != nullptr && globalSegment_ != nullptr) {
        DeleteManager(poolAllocator_);
    }
}

SegmentManager* PoolRegistry::CreateManager(Segment *seg, uint32_t deviceId, bool canDeleteOutsideDestruction)
{
    return new (std::nothrow) SegmentManager(seg, deviceId, canDeleteOutsideDestruction);
}

void PoolRegistry::DeleteManager(SegmentManager*& manager)
{
    delete manager;
    manager = nullptr;
}

rtError_t PoolRegistry::CreateMemPool(uint64_t size, uint64_t device, bool canDelete, SegmentManager* &memPool)
{
    (void)PoolRegistry::Instance().Init();
    COND_RETURN_ERROR(poolAllocator_ == nullptr, RT_ERROR_MEM_POOL_NULL,
        "PoolRegistry used before init, or poolAllocator init failed.");

    Segment *seg = nullptr;
    ReuseFlag flag = ReuseFlag::REUSE_FLAG_NONE;
    rtError_t error = poolAllocator_->SegmentAlloc(seg, static_cast<uint64_t>(size), INVALID_STREAM_ID, flag);
    ERROR_RETURN(error, "CreateMemPool failed, no more virtual address for new mempool, size=" PRIx64 ".", size);

    Segment *memPoolSeg = SegmentManager::CreateSegment(seg->basePtr, seg->size, nullptr, nullptr);
    memPool = CreateManager(memPoolSeg, device, canDelete);
    COND_RETURN_ERROR(memPool == nullptr, RT_ERROR_MEM_POOL_ALLOC,
        "Failed to allocate New SegmentManager: Host out of memory.");
    std::lock_guard<std::mutex> lock(mutex_);
    (void)entries_.insert(memPool);
    return RT_ERROR_NONE;
}

rtError_t PoolRegistry::CheckRemoveMemPool(SegmentManager *memPool)
{
    COND_RETURN_ERROR(memPool == nullptr, RT_ERROR_MEM_POOL_NULL, "Memory pool is nullptr.");
    COND_RETURN_ERROR(poolAllocator_ == nullptr, RT_ERROR_MEM_POOL_NULL,
        "PoolRegistry used before init, or poolAllocator init failed.");
    std::lock_guard<std::mutex> lock(mutex_);

    auto it = entries_.find(memPool);
    COND_RETURN_ERROR(it == entries_.end(), RT_ERROR_POOL_PTR_NOTFOUND,
        "Failed to remove memPool, memPoolId=%#" PRIx64 ".", memPool->MemPoolId());
    COND_RETURN_ERROR(!(*it)->CanDelete(), RT_ERROR_POOL_OP_INVALID,
        "Failed to destroy not deletable memPool(Id=%#" PRIx64 ").", memPool->MemPoolId());
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
    poolAllocator_->SegmentFree(base, true);
    return RT_ERROR_NONE;
}

bool PoolRegistry::QueryMemPool(SegmentManager *p)
{
    std::lock_guard<std::mutex> lock(mutex_);
    return entries_.find(p) != entries_.end();
}

bool PoolRegistry::InMemPoolRegion(uint64_t ptr)
{
    if (poolAllocator_ == nullptr) {
        return false;
    }
    std::lock_guard<std::mutex> lock(mutex_);
    return ptr >= poolAllocator_->PoolSegAddr() && ptr < poolAllocator_->PoolSegAddr() + poolAllocator_->PoolSize();
}

SegmentManager *PoolRegistry::FindMemPoolByPtr(uint64_t ptr)
{
    std::lock_guard<std::mutex> lock(mutex_);
    COND_RETURN_DEBUG(entries_.empty(), nullptr, "No memory pools created.");
 
    auto it = std::lower_bound(entries_.begin(), entries_.end(), ptr,
        [](const SegmentManager *memPool, const uint64_t p) {
            return memPool->PoolSegAddr() + memPool->PoolSize() <= p;
        });
    COND_RETURN_DEBUG((it == entries_.end() || ptr < (*it)->PoolSegAddr()), nullptr,
        "Pointer %#" PRIx64 " not found in any memory pool range.", ptr);
 
    return *it;
}

std::unordered_set<SegmentManager *> PoolRegistry::EnumerateMemPools(bool includeGraphPool)
{
    std::lock_guard<std::mutex> lock(mutex_);
    if (includeGraphPool) {
        return std::unordered_set<SegmentManager *>(entries_.begin(), entries_.end());
    } else {
        std::unordered_set<SegmentManager *> ret;
        for (auto memPool : entries_) {
            if (memPool->GraphId() == MODEL_ID_INVALID) {
                ret.insert(memPool);
            }
        }
        return ret;
    }
}

std::unordered_map<std::pair<int32_t, int32_t>, uint64_t, PairHash> PoolRegistry::GetSequenceMap() const {
    std::lock_guard<std::mutex> lock(mutex_);
    return sequenceMap_;
}

std::unordered_map<int32_t, uint64_t> PoolRegistry::GetStreamSeqId() const {
    std::lock_guard<std::mutex> lock(mutex_);
    return streamSeqId_;
}

void PoolRegistry::UpdateSeqMap(const int32_t streamId, const int32_t eventId)
{
    std::lock_guard<std::mutex> lock(mutex_);
    auto it = eventsMap_.find(eventId);
    if (it == eventsMap_.end()) {
        RT_LOG(RT_LOG_WARNING, "EventId=%d not found in eventsMap.", eventId);
        return;
    }
    std::pair<int32_t, uint64_t>& record = it->second;
    int32_t recordStreamId = record.first;   // the stream that recorded this event
    uint64_t recordSeqId = record.second;  // the index of the event record in stream
    sequenceMap_[{streamId, recordStreamId}] = max(sequenceMap_[{streamId, recordStreamId}], recordSeqId);
}

void PoolRegistry::UpdateEventMap(const int32_t streamId, const int32_t eventId)
{
    std::lock_guard<std::mutex> lock(mutex_);
    uint64_t seqId = streamSeqId_[streamId];
    eventsMap_[eventId] = {streamId, seqId};
    streamSeqId_[streamId] += 1; // update the number of event records on the stream
}

void PoolRegistry::RemoveFromEventMap(const int32_t eventId)
{
    std::lock_guard<std::mutex> lock(mutex_);
    eventsMap_.erase(eventId);
}

void PoolRegistry::RemoveSeqMap(rtStream_t stm)
{
    std::lock_guard<std::mutex> lock(mutex_);

    Stream *stream = nullptr;
    if (GetValidatedObject<Stream>(stm, stream) != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "RemoveSeqMap skip invalid stream handle.");
        return;
    }
    int32_t streamId = stream->Id_();
    streamSeqId_.erase(streamId);
    for (auto it = sequenceMap_.begin(); it != sequenceMap_.end();) {
        const auto& [streamId1, streamId2] = it->first;
        if (streamId1 == streamId || streamId2 == streamId) {
            it = sequenceMap_.erase(it);
        } else {
            ++it;
        }
    }
}

void PoolRegistry::StreamStateCallback(rtStream_t stm, rtStreamState type, void *args)
{
    UNUSED(args);
    if (type == RT_STREAM_STATE_DESTROY_PRE) {
        PoolRegistry::Instance().RemoveSeqMap(stm);
    }
}

void PoolRegistry::EventStateCallbackWrapper(Stream* stream, Event* event, EventStatePeriod period, void *args)
{
    RT_LOG(RT_LOG_DEBUG, "PoolRegistry event callback start, period %u.", static_cast<uint32_t>(period));
    UNUSED(args);

    COND_RETURN_VOID(event == nullptr, "PoolRegistry event callback event nullptr.");
    if (period == EventStatePeriod::EVENT_STATE_PERIOD_DESTROY) {
        PoolRegistry::Instance().RemoveFromEventMap(event->EventId_());
    }

    COND_RETURN_VOID(stream == nullptr, "PoolRegistry event callback stream nullptr.");
    if (period == EventStatePeriod::EVENT_STATE_PERIOD_RECORD) {
        PoolRegistry::Instance().UpdateEventMap(stream->Id_(), event->EventId_());
    } else if (period == EventStatePeriod::EVENT_STATE_PERIOD_WAIT) {
        PoolRegistry::Instance().UpdateSeqMap(stream->Id_(), event->EventId_());
    } else {
        RT_LOG(RT_LOG_ERROR, "EventStatePeriod period err, period=%u.", period);
    }
}

rtError_t PoolRegistry::RegisterSomaCallBack()
{
    rtError_t error = StreamStateCallbackManager::Instance().RegStreamStateCallback("Inner#SomaStreamCallback",
        RtPtrToPtr<void *>(StreamStateCallback), nullptr, StreamStateCallback::RTS_STREAM_STATE_CALLBACK);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_POOL_OP_INVALID,
        "Soma stream state callback register failed, reCode=%#x.", error);
    error = EventStateCallbackManager::Instance().RegEventStateCallback("Inner#SomaEventCallback",
        RtPtrToPtr<void *>(PoolRegistry::EventStateCallbackWrapper), nullptr,
        EventStateCallbackType::RT_EVENT_STATE_CALLBACK);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_POOL_OP_INVALID,
        "Soma event state callback register failed, reCode=%#x.", error);
    return RT_ERROR_NONE;
}


}  // namespace runtime
}  // namespace cce