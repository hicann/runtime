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

namespace cce {

namespace runtime {
constexpr uint64_t DEVICE_POOL_VADDR_SIZE = (64ULL << 30);  // 64 GB
constexpr uint64_t DEVICE_POOL_MIN_BLOCK_SIZE = (2UL << 20); // 2 MB
constexpr uint64_t DEVICE_POOL_ALIGN_SIZE = (2UL << 20); // 2 MB
constexpr int INVALID_STREAM_ID = -1;

struct Segment {
    Segment(uint64_t base, uint64_t size);
    Segment(uint64_t base, uint64_t size, Segment *prev, Segment *next);
    Segment* SplitLeft(uint64_t splitedSize, bool mustSplit = false);

    uint64_t basePtr;
    uint64_t size;
    Segment *prev;
    Segment *next;
    int32_t streamId;
    int32_t graphId;
    int32_t eventId;
    bool inUse;
    std::unordered_set<int32_t> freeEventsMap_;
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

enum class AicpuOpType : uint8_t {
    MALLOC = 0,
    FREE = 1,
    INVALID = 0xFF,
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
    uint32_t eventDependencies = 1;  // Reuse between streams with event
    uint32_t internalDependencies = 0; // Reuse between streams, alloc must wait until free
    uint32_t opportunistic = 0;      // Reuse between streams, failed when free not executed before alloc
    uint32_t waterMark = 0;
};

enum class ReuseFlag : uint16_t {
    REUSE_FLAG_SINGLE_STREAM = 0,
    REUSE_FLAG_EVENT = 1,
    REUSE_FLAG_OPPOR = 2,
    REUSE_FLAG_INTERNAL = 3,
    REUSE_FLAG_NONE = 4,
    REUSE_FLAG_INVALID = 0XFFFF,
};

class SegmentManager {
public:
    SegmentManager(Segment *seg, uint32_t deviceId, bool canDelete);
    ~SegmentManager();
    rtError_t SegmentAlloc(Segment* &ret, uint64_t size, int streamId = INVALID_STREAM_ID);
    rtError_t SegmentFree(uint64_t ptr);
    static inline Segment* CreateSegment(uint64_t base, uint64_t size);
    static inline Segment* CreateSegment(uint64_t base, uint64_t size, Segment *next, Segment *prev);

    uint64_t MemPoolId() const { return RtPtrToValue(this); }
    uint64_t PoolSegAddr() const { return base_; }
    uint64_t PoolSize() const { return static_cast<uint64_t>(size_); }
    uint32_t DeviceId() const { return deviceId_; }
    bool CanDelete() const { return canDelete_; }
    rtError_t GetAttribute(rtMemPoolAttr attr, void* value);
    rtError_t SetAttribute(rtMemPoolAttr attr, const void* value);
    Segment* StreamOpportReuse(uint64_t size, const int32_t streamId, ReuseFlag &flag);
    Segment* StreamEventReuse(uint64_t size, const int32_t streamId, ReuseFlag &flag);
    void AddEventIdToSegment(const int32_t streamId, const int32_t eventId);

private:
    void MaintainList(Segment *seg);
    bool CheckMergeRules(const Segment *segLeft, const Segment *segRight) const;
    void mergeSegToTail();
    std::mutex mutex_;
    std::unordered_map<uint64_t, Segment *> allocedMap_;
    std::set<Segment *, SegmentComparator> cachedSegs_;

    PoolDependencyFea state_;
    Segment *tail_;
    uint64_t base_;
    uint64_t size_;
    uint64_t busySize_;
    uint64_t reserveSize_;
    uint64_t maxBusySize_;
    uint64_t maxReservedSize_;
    uint32_t deviceId_;
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
        delete poolRegistry_;
    }

    rtError_t Init();
    ~PoolRegistry();
    rtError_t CreateMemPool(uint64_t size, uint64_t device, bool canDelete, SegmentManager* &memPool);
    rtError_t CheckRemoveMemPool(SegmentManager *memPool);
    rtError_t RemoveMemPool(SegmentManager* memPool);
    static inline SegmentManager* CreateManager(Segment *seg, uint32_t deviceId, bool canDeleteOutsideDestruction);
    void CleanupDevice(uint32_t deviceId);
    bool QueryMemPool(SegmentManager *p);
    std::unordered_map<int32_t, std::unordered_set<int32_t> > GetEventsMap() const { return eventsMap_; }
    SegmentManager* FindMemPoolByPtr(void *p);

private:
    PoolRegistry() = default;
    PoolRegistry(const PoolRegistry &) = delete;
    PoolRegistry &operator=(const PoolRegistry &) = delete;

    std::mutex mutex_;
    std::set<SegmentManager*, SegmentManagerComparator> entries_;
    Segment *globalSegment_ = nullptr;
    SegmentManager *poolAllocator_ = nullptr;
    std::unordered_map<int32_t, std::unordered_set<int32_t> > eventsMap_;
    static PoolRegistry *poolRegistry_;
    static std::once_flag initFlag_;
};

}  // namespace runtime
}  // namespace cce
#endif // STREAM_MEM_POOL_HPP