/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef STREAM_MEM_POOL_HPP
#define STREAM_MEM_POOL_HPP

#include <cstdint>
#include <set>
#include <vector>
#include <mutex>
#include <map>
#include <unordered_map>
#include <bitset>
#include <list>

#include "base.hpp"
#include "device.hpp"
#include "runtime/rt_inner_mem.h"
#include "model.hpp"
#include "stream.hpp"
#include "event.hpp"
#include "stream_state_callback_manager.hpp"
#include "event_state_callback_manager.hpp"

namespace cce {

namespace runtime {
// SOMA virtual memory address range: 12TB-14TB
constexpr uint64_t DEVICE_POOL_VADDR_START = (12ULL << 40);  // 12 TB
constexpr uint64_t DEVICE_POOL_VADDR_SIZE = (2ULL << 40);  // 2 TB
constexpr uint64_t DEVICE_POOL_MIN_BLOCK_SIZE = (2UL << 20); // 2 MB
constexpr uint64_t DEVICE_POOL_ALIGN_SIZE = (2UL << 20); // 2 MB
constexpr size_t HASH_GOLDEN_RATIO = 0x9e3779b9U;
constexpr int INVALID_STREAM_ID = -1;
constexpr int INVALID_SEQ_ID = -1;

enum class SegmentState : uint8_t {
    FREE = 0,
    CACHED = 1,
    BUSY = 2,
};

struct Segment {
    Segment(uint64_t base, uint64_t size);
    Segment(uint64_t base, uint64_t size, Segment *prev, Segment *next);
    Segment* SplitLeft(uint64_t splitedSize, bool mustSplit = false);
    void MergeLeft();

    uint64_t basePtr;
    uint64_t size;
    Segment *prev;
    Segment *next;
    int32_t streamId;
    int32_t graphId;
    int32_t eventId;
    uint64_t seqId;
    SegmentState state;
};

struct SegmentComparator {
    bool operator()(const Segment *a, const Segment *b) const
    {
        if (a->size != b->size) {
            return a->size < b->size;
        }
        return a->basePtr < b->basePtr;
    }
};

struct PairHash {
    size_t operator()(const pair<int, int>& p) const {
        size_t h1 = hash<int>()(p.first);
        size_t h2 = hash<int>()(p.second);
        return h1 ^ (h2 + HASH_GOLDEN_RATIO + (h1 << 6) + (h1 >> 2));
    }
};

enum class AicpuOpType : uint8_t {
    MALLOC = 0,
    FREE = 1,
    INVALID = 0xFF,
};

enum class SomaAicpuSubCmd : uint8_t {
    MALLOC = 2,
    FREE = 4,
};

struct AicpuPoolCtxArgs {
    uint64_t size;
    uint64_t va;
    uint64_t mempoolId;
    uint32_t deviceId;
    int32_t memAsyncOpType;  // Malloc(0) Free(1)
    int32_t memAsyncSubCMD;  // Distinguish between Malloc reuse strategies and Free explicit/implicit reuse methods
};

struct PoolDependencyFea {
    uint32_t singleDependencies = 1; // Reuse in a single Stream
    uint32_t eventDependencies = 0;  // Reuse between streams with event
    uint32_t internalDependencies = 0; // Reuse between streams, alloc must wait until free
    uint32_t opportunistic = 0;      // Reuse between streams, failed when free not executed before alloc
    uint64_t waterMark = 0;
};

enum class ReuseFlag : int32_t {
    REUSE_FLAG_STANDARD = 0,
    REUSE_FLAG_INTERNAL = 1,
    REUSE_FLAG_NONE = 2,
    REUSE_FLAG_INVALID = 0XFFFF,
};

class SegmentManager {
public:
    SegmentManager(Segment *seg, uint32_t deviceId, bool canDelete);
    ~SegmentManager();
    rtError_t SegmentAlloc(Segment* &ret, uint64_t size, int streamId, ReuseFlag &flag);
    rtError_t SegmentFree(uint64_t ptr, bool forceFree = false);
    static inline Segment* CreateSegment(uint64_t base, uint64_t size);
    static inline Segment* CreateSegment(uint64_t base, uint64_t size, Segment *next, Segment *prev);
    static inline void DeleteSegment(Segment*& segment);
    uint64_t MemPoolId() const { return RtPtrToValue(this); }
    uint64_t PoolSegAddr() const { return base_; }
    uint64_t PoolSize() const { return static_cast<uint64_t>(size_); }
    uint32_t DeviceId() const { return deviceId_; }
    int32_t GraphId() const { return graphId_; }
    bool CanDelete() const { return canDelete_; }
    rtError_t GetAttribute(rtMemPoolAttr attr, void* value);
    rtError_t SetAttribute(rtMemPoolAttr attr, const void* value);
    Segment* SingleStreamReuse(size_t size, const int32_t streamId, ReuseFlag &flag);
    Segment* StreamInternalReuse(size_t size, const int32_t streamId, bool reuseType, ReuseFlag &flag);
    Segment* StreamEventReuse(size_t size, const int32_t streamId, ReuseFlag &flag);
    Segment* TryToReuse(size_t size, const int32_t streamId, PoolDependencyFea state, ReuseFlag &flag);
    rtError_t TrimTo(const uint64_t minBytesToKeep);

private:
    void MergeIntoCachedSegs(Segment* &seg);
    bool CheckMergeRules(const Segment *segLeft, const Segment *segRight) const;
    Segment* AllocFromFreeSegs(uint64_t size);
    void MergeIntoFreeSegs(Segment* &seg);
    void TrimCachedSegs(const uint64_t minBytesToKeep);

    std::mutex mutex_;
    std::unordered_map<uint64_t, Segment *> allocedMap_;
    std::set<Segment *, SegmentComparator> cachedSegs_;
    std::set<Segment *, SegmentComparator> freeSegs_;

    PoolDependencyFea state_;
    Segment *tail_;
    uint64_t base_;
    uint64_t size_;
    uint64_t busySize_; // allocated
    uint64_t reserveSize_; // allocated + cached
    uint64_t maxBusySize_;
    uint64_t maxReservedSize_;
    uint32_t deviceId_;
    int32_t graphId_;
    bool canDelete_;
    bool isIPCPool_;
};

struct SegmentManagerComparator {
    bool operator()(const SegmentManager *a, const SegmentManager *b) const
    {
        return a->PoolSegAddr() < b->PoolSegAddr();
    }
};

class PoolRegistry {
public:
    static PoolRegistry &Instance() {
        std::call_once(initFlag_, []() {
            poolRegistry_ = new PoolRegistry();
        });
        return *poolRegistry_;
    }

    static void DestroyPoolRegistry() {
        if (poolRegistry_ != nullptr) {
            delete poolRegistry_;
            poolRegistry_ = nullptr;
        }
    }
    rtError_t Init();
    ~PoolRegistry();
    rtError_t CreateMemPool(uint64_t size, uint64_t device, bool canDelete, SegmentManager* &memPool);
    rtError_t CheckRemoveMemPool(SegmentManager *memPool);
    rtError_t RemoveMemPool(SegmentManager* memPool);
    static inline SegmentManager* CreateManager(Segment *seg, uint32_t deviceId, bool canDeleteOutsideDestruction);
    static inline void DeleteManager(SegmentManager*& manager);
    bool QueryMemPool(SegmentManager *p);
    std::unordered_map<std::pair<int32_t, int32_t>, uint64_t, PairHash> GetSequenceMap() const;
    std::unordered_map<int32_t, uint64_t> GetStreamSeqId() const;
    void UpdateSeqMap(const int32_t streamId, const int32_t eventId);
    void UpdateEventMap(const int32_t streamId, const int32_t eventId);
    void RemoveFromEventMap(const int32_t eventId);
    void RemoveSeqMap(rtStream_t stream);
    static void StreamStateCallback(rtStream_t stm, rtStreamState type, void *args);
    static void EventStateCallbackWrapper(Stream* stream, Event* event, EventStatePeriod period, void *args);
    rtError_t RegisterSomaCallBack();
    bool InMemPoolRegion(uint64_t ptr);
    SegmentManager* FindMemPoolByPtr(uint64_t ptr);
    std::unordered_set<SegmentManager *> EnumerateMemPools(bool includeGraphPool);

private:
    PoolRegistry() = default;
    PoolRegistry(const PoolRegistry &) = delete;
    PoolRegistry &operator=(const PoolRegistry &) = delete;

    mutable std::mutex mutex_;
    std::set<SegmentManager*, SegmentManagerComparator> entries_;
    Segment *globalSegment_ = nullptr;
    SegmentManager *poolAllocator_ = nullptr;
    std::unordered_map<int32_t, std::pair<int32_t, uint64_t>> eventsMap_;
    std::unordered_map<std::pair<int32_t, int32_t>, uint64_t, PairHash> sequenceMap_;
    std::unordered_map<int32_t, uint64_t> streamSeqId_;
    static PoolRegistry *poolRegistry_;
    static std::once_flag initFlag_;
};

}  // namespace runtime
}  // namespace cce
#endif // STREAM_MEM_POOL_HPP