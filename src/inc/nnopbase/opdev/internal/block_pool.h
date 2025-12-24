/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __BLOCK_POOL_H__
#define __BLOCK_POOL_H__

#include <algorithm>
#include <array>
#include <cstdlib>
#include <cstring>
#include <functional>
#include <limits>
#include <mutex>
#include <numeric>
#include <type_traits>
#include <vector>
#include <unistd.h>
#include "block_store.h"
#include "opdev/op_log.h"

#include <atomic>

namespace op {
namespace internal {

#if defined(NNOPBASE_UT) || defined(NNOPBASE_ST)
constexpr int32_t kHugeBlockNum = 16;
#else
constexpr int32_t kHugeBlockNum = 4096;
#endif
constexpr int32_t kHugeBlockSize = 64 * 1024;
constexpr int32_t kHugeBlockDefaultOffset = 64;
constexpr int32_t kSleepWatingForBlockDuration = 10;

/**
 * @brief Singletone Memory Poll backed by BlockStore
 *
 */

class OpSpinlock {
private:
    std::atomic<unsigned int> atomic_flag;

public:
    OpSpinlock()
    {
        atomic_flag = 0;
    }
    void lock()
    {
        for (int i = 0; atomic_flag.load(std::memory_order_relaxed) != 0 ||
                        atomic_flag.exchange(1, std::memory_order_acquire) != 0;
             i++) {
        }
    }
    void unlock()
    {
        atomic_flag.store(0, std::memory_order_release);
    }
};

class BlockPool {
public:
    friend class BlockCache;

    BlockPool()
    {
        if (Init() == false) {
            OP_LOGE(ACLNN_ERR_INNER, "Failed to init memory pool.");
        }
    };

    ~BlockPool()
    {
        UnInit();
    }

    static void *Malloc(size_t size)
    {
        return get_instance().MallocImpl(size);
    }

    static size_t BatchMalloc(size_t size, void **addrList, size_t batch)
    {
        return get_instance().BatchMatchImpl(size, addrList, batch);
    }

    static void Free(void *block)
    {
        return get_instance().FreeImpl(block);
    }

    static void *GetOneHugeBlock()
    {
        return get_instance().GetOneHugeBlockImpl();
    }

    static void FreeOneHugeBlock(void *addr)
    {
        return get_instance().FreeOneHugeBlockImpl(addr);
    }

    static bool InHugeMemRange(void *p)
    {
        return get_instance().InHugeMemRangeImpl(p);
    }

private:
    static BlockPool &globalPool_;

    static BlockPool &get_instance()
    {
        /* Return a new instance for each thread, so no locking is needed when doing malloc/free  */
        return globalPool_;
    }

    inline void *MallocImpl(size_t size)
    {
        void *p = PoolMalloc(size);
        if (p != nullptr) {
            return p;
        }

        p = std::malloc(sizeof(BlockStore::BlockHeader) + size);
        if (p == nullptr) {
            return nullptr;
        }

        BlockStore::BlockHeader *head = static_cast<BlockStore::BlockHeader *>(p);
        head->userTag_ = SYS_TAG;
        head->cacheExt_ = BlockStore::NOT_IN_CACHE;
        return head + 1;
    }

    size_t BatchMatchImpl(size_t size, void **addrList, size_t batch)
    {
        size_t n = 0;
        BlockStore *store = GetStore(size);
        if (store == nullptr) {
            OP_LOGW("Get BlockStore nullptr.");
            return n;
        }

        {
            const std::lock_guard<OpSpinlock> guard(guard_);
            while (n < batch) {
                void *block = store->Alloc();
                if (block) {
                    addrList[n++] = block;
                } else {
                    break;
                }
            }
        }

        while (n < batch) {
            void *block = std::malloc(sizeof(BlockStore::BlockHeader) + store->GetBlockSize());
            if (block) {
                BlockStore::BlockHeader *head = static_cast<BlockStore::BlockHeader *>(block);
                head->userTag_ = SYS_TAG;
                addrList[n++] = head + 1;
            } else {
                break;
            }
        }
        return n;
    }

    inline void FreeImpl(void *block)
    {
        uint16_t tag = BlockStore::GetBlockTag(block);
        if (tag == SYS_TAG) {
            std::free(static_cast<BlockStore::BlockHeader *>(block) - 1);
            return;
        }

        size_t idx = tag - DEFAULT_TAG;
        if (idx > MAX_STORE) {
            // FATAL: try to free block not belong to this BlockPool
            return;
        }
        BlockStore &store = blockStoreArray_[idx];
        const std::lock_guard<OpSpinlock> guard(guard_);
        store.Free(block);
    }

    inline void *PoolMalloc(size_t size)
    {
        const std::lock_guard<OpSpinlock> guard(guard_);
        BlockStore *store = GetStore(size);
        if (store == nullptr) {
            return nullptr;
        }
        return store->Alloc();
    }

    void *GetOneHugeBlockImpl()
    {
        guard_.lock();
        if (hugeMemArray_.empty()) {
            guard_.unlock();
            OP_LOGW("Hugemem trace: huge memory array is empty!!!");
            return nullptr;
        } else {
            void *res = hugeMemArray_.back();
            hugeMemArray_.pop_back();
            guard_.unlock();
            return res;
        }
    }

    inline void FreeOneHugeBlockImpl(void *addr)
    {
        if (addr == nullptr) {
            return;
        }
        const std::lock_guard<OpSpinlock> guard(guard_);
        hugeMemArray_.push_back(addr);
    }

    inline bool InHugeMemRangeImpl(const void *addr)
    {
        return (addr >= hugeMemStart_) && (addr < hugeMemEnd_);
    }

    bool Init();
    void UnInit();

    /**
   * @brief Block size and count of BlockStore
   */
    struct BlockDesc {
        BlockDesc(size_t s, size_t c) : size(s), count(c) {};
        size_t size{0};
        size_t count{0};
    };

    static const int INVALID_STORE = -1;
    static const int MAX_STORE = 6;
    static const int BLOCK_BASE_SIZE = 64;
    static const uint32_t BLOCK_MAX_SIZE = BLOCK_BASE_SIZE * 1024;
    static const uint16_t DEFAULT_TAG = 0x1337;
    static const uint16_t SYS_TAG = 0xfeed;
    OpSpinlock guard_;

    const std::array<BlockDesc, MAX_STORE> StoreIndex = {
        BlockDesc(BLOCK_BASE_SIZE, 32768),      // 64B 2MB
        BlockDesc(BLOCK_BASE_SIZE * 4, 16384),  // 256B 4MB
        BlockDesc(BLOCK_BASE_SIZE * 16, 32768), // 1KB 32MB
        BlockDesc(BLOCK_BASE_SIZE * 64, 8192),  // 4KB 32MB
        BlockDesc(BLOCK_BASE_SIZE * 256, 2048),  // 16KB 32MB
        BlockDesc(BLOCK_MAX_SIZE, 512)};       // 64KB 32MB

    using StoreArray = std::array<BlockStore, MAX_STORE>;
    StoreArray blockStoreArray_;
    using HugeMemArray = std::vector<void *>;
    HugeMemArray hugeMemArray_;
    void *hugeMemStart_;
    void *hugeMemEnd_;
    static int GetStoreIndex(size_t req_size)
    {
        if (req_size == 0 || req_size > BLOCK_MAX_SIZE) {
            return INVALID_STORE;
        }

        if (req_size <= BLOCK_BASE_SIZE) {
            return 0;
        }

        int idx = 1;
        req_size -= 1;
        req_size = req_size >> 6;
        do {
            if (req_size < 4) {
                break;
            }
            idx++;
            req_size = req_size >> 2;
        } while (req_size);
        return idx;
    }
    inline BlockStore *GetStore(size_t req_size)
    {
        int idx = GetStoreIndex(req_size);
        if (idx == INVALID_STORE) {
            return nullptr;
        }
        return &blockStoreArray_[idx];
    }
};

class BlockCache {
public:
    BlockCache() = default;

    ~BlockCache() = default;

    static void *CacheAlloc(size_t size)
    {
        return get_instance().CacheAllocImpl(size);
    }

    static void CacheFree(void *block)
    {
        return get_instance().CacheFreeImpl(block);
    }

    OpSpinlock guard_;
private:
    static BlockCache &get_instance()
    {
        thread_local BlockCache blockCache_;
        return blockCache_;
    }

    inline bool CacheEmpty(int index)
    {
        return cacheHead_[index] == nullptr;
    }

    void *PoolAlloc(size_t size, int index)
    {
        if (index == BlockPool::INVALID_STORE) {
            return BlockPool::Malloc(size);
        }

        size_t batch = CacheBatchSize[index];
        void *addrList[batch];
        size_t n = BlockPool::BatchMalloc(size, addrList, batch);
        if (n) {
            const std::lock_guard<OpSpinlock> guard(guard_);
            for (size_t i = 0; i < n; i++) {
                BlockStore::BlockHeader *head = BlockStore::GetBlockHeader(addrList[i]);
                head->cacheExt_ = reinterpret_cast<uintptr_t>(this);
                // use blockIdx_ to store cache index if SYS_TAG
                if (head->userTag_ == BlockPool::SYS_TAG) {
                    head->blockIdx_ = static_cast<BlockStore::BlockIdx>(index);
                }
                if (i > 0) {
                    head->cacheExt_ = reinterpret_cast<uintptr_t>(cacheHead_[index]);
                    cacheHead_[index] = head;
                    cacheCount_[index]++;
                }
            }
            return addrList[0];
        }
        return nullptr;
    }

    inline void *CacheAllocImpl(size_t size)
    {
        int index = BlockPool::GetStoreIndex(size);
        if (index == BlockPool::INVALID_STORE) {
            return PoolAlloc(size, index);
        }

        if (index < 0 || index > BlockPool::MAX_STORE) {
            OP_LOGE(ACLNN_ERR_INNER, "invalid cache to alloc, idx %d size %lu", index, size);
            return nullptr;
        }

        {
            const std::lock_guard<OpSpinlock> guard(guard_);
            if (!CacheEmpty(index)) {
                BlockStore::BlockHeader *head = cacheHead_[index];
                cacheHead_[index] = reinterpret_cast<BlockStore::BlockHeader *>(head->cacheExt_);
                cacheCount_[index]--;
                head->cacheExt_ = reinterpret_cast<uintptr_t>(this);
                return head + 1;
            }
        }
        return PoolAlloc(size, index);
    }

    inline int GetBlockCacheIndex(BlockStore::BlockHeader *head)
    {
        if (head->userTag_ != BlockPool::SYS_TAG) {
            return head->userTag_ - BlockPool::DEFAULT_TAG;
        }
        return static_cast<int>(head->blockIdx_);
    }

    void CacheFreeImpl(void *block)
    {
        BlockStore::BlockHeader *head = BlockStore::GetBlockHeader(block);
        if (head->cacheExt_ == BlockStore::NOT_IN_CACHE) {
            BlockPool::Free(block);
            return;
        }

        int idx = GetBlockCacheIndex(head);
        if (idx < 0 || idx > BlockPool::MAX_STORE) {
            OP_LOGW("invalid block to free, idx %d tag %u blockIdx %d cacheExt %lu",
                idx, head->userTag_, head->blockIdx_, head->cacheExt_);
            return;
        }

        if (head->cacheExt_ != reinterpret_cast<uintptr_t>(this) && cacheCount_[idx] > cacheMaxCount_[idx]) {
            OP_LOGD("free cache pool block to block pool");
            BlockPool::Free(block);
            return;
        }

        const std::lock_guard<OpSpinlock> guard(guard_);
        head->cacheExt_ = reinterpret_cast<uintptr_t>(cacheHead_[idx]);
        cacheHead_[idx] = head;
        cacheCount_[idx]++;
    }

    // cache size limit and cache block recycle in future
    const std::array<BlockPool::BlockDesc, BlockPool::MAX_STORE> CacheIndex = {
        BlockPool::BlockDesc(BlockPool::BLOCK_BASE_SIZE, 4096),      // 64B 256KB
        BlockPool::BlockDesc(BlockPool::BLOCK_BASE_SIZE * 4, 2048),  // 256B 512KB
        BlockPool::BlockDesc(BlockPool::BLOCK_BASE_SIZE * 16, 4096), // 1KB 4MB
        BlockPool::BlockDesc(BlockPool::BLOCK_BASE_SIZE * 64, 1024), // 4KB 4MB
        BlockPool::BlockDesc(BlockPool::BLOCK_BASE_SIZE * 256, 256), // 16KB 4MB
        BlockPool::BlockDesc(BlockPool::BLOCK_MAX_SIZE, 64)          // 64KB 4MB
    };

    const std::array<size_t, BlockPool::MAX_STORE> CacheBatchSize = {
        16,
        8,
        16,
        4,
        1,
        1
    };

    BlockStore::BlockHeader *cacheHead_[BlockPool::MAX_STORE] = {nullptr};
    std::array<size_t, BlockPool::MAX_STORE> cacheCount_ = {0, 0, 0, 0, 0, 0};
    const std::array<size_t, BlockPool::MAX_STORE> cacheMaxCount_ = {
        4096,  // 64B 256KB
        2048,  // 256B 512KB
        4096,  // 1KB 4MB
        1024,  // 4KB 4MB
        256,   // 16KB 4MB
        64     // 64KB 4MB
    };
};

} // namespace internal
} // namespace op
#endif
