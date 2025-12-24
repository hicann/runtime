/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __BLOCK_STORE_H__
#define __BLOCK_STORE_H__

#include <algorithm>
#include <array>
#include <cstdio>
#include <cstring>
#include <functional>
#include <limits>
#include <numeric>
#include <type_traits>
#include <vector>
#include <cstdint>

namespace op {
namespace internal {

/**
 * @brief Simple memory block management class.
 */
class BlockStore {
public:
    BlockStore() = default;
    ~BlockStore();
    BlockStore(const BlockStore &) = delete;
    BlockStore &operator=(const BlockStore &) = delete;
    BlockStore(BlockStore &&src);
    BlockStore &operator=(BlockStore &&src);

    int Init(uint16_t tag, size_t block_size, size_t block_count);
    void UnInit();

    /**
     * @brief MAGIC HEADER for each managed memory block
     *
     */
    static constexpr uint32_t MAGIC = 0x12345678;

    /**
     * @brief User can set a TAG for this BlockStore
     *
     */
    static constexpr uint16_t DEFAULT_TAG = 0;
    static constexpr uintptr_t NOT_IN_CACHE = 0xabcd;
    using BlockIdx = int32_t;

    enum class BlockState : uint16_t { UNINIT = 0,
                                       FREE = 1,
                                       ALLOCATED = 2 };

    /**
     * @brief Each block has a header
     */
    struct BlockHeader {
        uint32_t magic_{MAGIC};  // magic header
        BlockIdx blockIdx_{-1}; // block index
        BlockIdx next_{-1};      // next free block index
        BlockState blockState_{BlockState::UNINIT};
        uint16_t userTag_{DEFAULT_TAG};
        uintptr_t cacheExt_{NOT_IN_CACHE};
    };

    inline void *Alloc()
    {
        if (freeHead_ == -1) {
            return nullptr;
        }
        BlockHeader *head = GetHeader(freeHead_);
        if (!head) {
            return nullptr;
        }
        freeHead_ = head->next_;
        head->blockState_ = BlockState::ALLOCATED;
        return head + 1;
    }

    inline void Free(void *block)
    {
        if (block == nullptr) {
            return;
        }
        BlockHeader *head = static_cast<BlockHeader *>(block) - 1;
        if (head->magic_ != BlockStore::MAGIC || head->userTag_ != tag_) {
            // FATAL, try to free memory no belong to this BlockStore
            return;
        }
        head->cacheExt_ = NOT_IN_CACHE;
        BlockIdx tmp = freeHead_;
        freeHead_ = head->blockIdx_;
        head->next_ = tmp;
        head->blockState_ = BlockState::FREE;
    }

    inline size_t GetBlockSize() const
    {
        return blockSize_;
    }

    inline uint16_t GetTag() const
    {
        return tag_;
    }

    inline static BlockHeader *GetBlockHeader(void *block)
    {
        BlockHeader *head = static_cast<BlockHeader *>(block) - 1;
        return head;
    }

    inline static uint16_t GetBlockTag(void *block)
    {
        BlockHeader *head = static_cast<BlockHeader *>(block) - 1;
        return head->userTag_;
    }

private:
    static const size_t MIN_BLOCK_SIZE = 64;
    static size_t AlignedBlockSize(size_t req_size)
    {
        return (req_size + MIN_BLOCK_SIZE - 1) / MIN_BLOCK_SIZE * MIN_BLOCK_SIZE;
    };

    inline BlockHeader *GetHeader(int idx) const
    {
        if (idx < 0 || static_cast<size_t>(idx) >= blockCount_) {
            return nullptr;
        }
        uint8_t *p = static_cast<uint8_t *>(mem_);
        p += idx * (blockSize_ + sizeof(BlockHeader));
        return static_cast<BlockHeader *>(static_cast<void *>(p));
    }

    uint16_t tag_{DEFAULT_TAG};
    size_t blockSize_{0};
    size_t blockCount_{0};
    void *mem_{nullptr};
    BlockIdx freeHead_{-1}; // index of free list head.
};

} // namespace internal
} // namespace op

#endif
