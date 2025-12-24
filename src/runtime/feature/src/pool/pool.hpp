/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_POOL_HPP
#define CCE_RUNTIME_POOL_HPP

#include <mutex>
#include <map>
#include <cstdlib>
#include <atomic>
#include <unordered_map>
#include <vector>
#include "base.hpp"
#include "osal.hpp"
#include "task_info.hpp"
#include "buffer_allocator.hpp"

#define TASK_ID_LT(lsh, rsh)    (static_cast<int16_t>(static_cast<uint16_t>(lsh) - static_cast<uint16_t>(rsh)) < 0)
#define TASK_ID_GT(lsh, rsh)    TASK_ID_LT((rsh), (lsh))
#define TASK_ID_LEQ(lsh, rsh)   (static_cast<int16_t>(static_cast<uint16_t>(lsh) - static_cast<uint16_t>(rsh)) <= 0)
#define TASK_ID_GEQ(lsh, rsh)   TASK_ID_LEQ((rsh), (lsh))

#define TASK_ID_ADD(lsh, rsh)   (static_cast<uint16_t>(static_cast<uint16_t>(lsh) + static_cast<uint16_t>(rsh)))
#define TASK_ID_SUB(lsh, rsh)   (static_cast<uint16_t>(static_cast<uint16_t>(lsh) - static_cast<uint16_t>(rsh)))

namespace cce {
namespace runtime {
class Device;
class Driver;
class Stream;
class Model;
class Task;

constexpr int32_t RT_INVALID_ID = -1;
constexpr uint64_t ASYNC_COPY_STATU_INIT = 0ULL;
constexpr uint64_t ASYNC_COPY_STATU_SUCC = 1ULL;
#ifdef __x86_64__
constexpr uint32_t PCIE_BAR_COPY_SIZE = 1024U;
#else
constexpr uint32_t PCIE_BAR_COPY_SIZE = 4096U;
#endif
constexpr uint32_t DMA_COPY_MAX_SIZE = 32U * 1024U * 1024U;

template <class T>
class ObjAllocator : public NoCopy {
public:
    // initCount and maxCount can't be 0.
    explicit ObjAllocator(uint32_t initCount = 256, uint32_t maxCount = 0x10000, bool clearFlag = false)
        : NoCopy(),
          initCount_((initCount < maxCount) ? initCount : maxCount),
          maxCount_(maxCount),
          clearFlag_(clearFlag),
          pool_(nullptr),
          mtx_(nullptr)
    {
    }

    ~ObjAllocator() override
    {
        for (uint32_t i = 0U; i <= GetPoolIndex(maxCount_ - 1); i++) {
            if (pool_ == nullptr) {
                break;
            }
            if (pool_[i] != nullptr) {
                ObjFree(pool_[i]);
                pool_[i] = nullptr;
            }
        }
        if (pool_ != nullptr) {
            free((void *)pool_);
            pool_ = nullptr;
        }
        if (mtx_ != nullptr) {
            delete []mtx_;
            mtx_ = nullptr;
        }
    }

    rtError_t Init(void)
    {
        uint32_t poolNum = GetPoolIndex(maxCount_ - 1) + 1;
        size_t poolArraySize = static_cast<size_t>(poolNum) * sizeof(T *);
        if (poolArraySize < sizeof(T *)) {
            return RT_ERROR_POOL_RESOURCE;
        }

        pool_ = (T **)malloc(poolArraySize);
        if (pool_ == nullptr) {
            RT_LOG(RT_LOG_ERROR, "ObjAllocator alloc failed, pool array size %zu(bytes)", poolArraySize);
            return RT_ERROR_MEMORY_ALLOCATION;
        }
        errno_t rc = memset_s((void *)pool_, poolArraySize, 0, poolArraySize);
        if (rc != EOK) {
            RT_LOG(RT_LOG_ERROR, "memset_s failed, size=%zu(bytes), retCode=%d.", poolArraySize, rc);
            free((void *)pool_);
            pool_ = nullptr;
            return RT_ERROR_SEC_HANDLE;
        }

        pool_[0] = ObjAlloc();
        if (pool_[0] == nullptr) {
            RT_LOG(RT_LOG_ERROR, "ObjAlloc pool 0 failed.");
            free((void *)pool_);
            pool_ = nullptr;
            return RT_ERROR_MEMORY_ALLOCATION;
        }
        RT_LOG(RT_LOG_INFO, "ObjAllocator alloc success, Runtime_alloc_size %zu(bytes)", poolArraySize);

        mtx_ = new (std::nothrow) std::mutex[poolNum];
        if (mtx_ == nullptr) {
            RT_LOG(RT_LOG_ERROR, "new mutex resource failed, poolNum=%u.", poolNum);
            ObjFree(pool_[0]);
            pool_[0] = nullptr;
            free((void *)pool_);
            pool_ = nullptr;
            return RT_ERROR_MEMORY_ALLOCATION;
        }

        RT_LOG(RT_LOG_INFO, "ObjAllocator alloc success, Runtime_alloc_size %zu(bytes)", poolNum * sizeof(std::mutex));
        return RT_ERROR_NONE;
    }

    void SetDataToItem(uint32_t id, T val)
    {
        uint32_t poolIdx;
        uint32_t subId;
        GetOrAllocItemById(id, poolIdx, subId);
        if (pool_[poolIdx] != nullptr) {
            pool_[poolIdx][subId] = val;
        }
    }

    T *GetDataToItem(uint32_t id)
    {
        uint32_t poolIdx;
        uint32_t subId;
        GetOrAllocItemById(id, poolIdx, subId);
        if (pool_[poolIdx] == nullptr) {
            return nullptr;
        }
        return &(pool_[poolIdx][subId]);
    }

    T *GetDataToItemApplied(uint32_t id) const
    {
        const uint32_t poolIdx = GetPoolIndex(id);
        if (pool_[poolIdx] == nullptr) {
            return nullptr;
        }
        const uint32_t baseId = AccumulatePoolCount(poolIdx);
        const uint32_t subId = id - baseId;
        return &(pool_[poolIdx][subId]);
    }

    bool CheckIdValid(uint32_t id) const
    {
        uint32_t poolIdx = GetPoolIndex(id);
        return pool_[poolIdx] != nullptr;
    }

    constexpr uint32_t NextPoolFirstId(uint32_t id) const
    {
        return (GetPoolIndex(id) + 1) * initCount_;
    }

    constexpr uint32_t AccumulatePoolCount(uint32_t idx) const
    {
        return idx * initCount_;
    }

    // 只有回收线程调用，外面加锁
    void RecyclePool(uint32_t idx) const
    {
        ObjFree(pool_[idx]);
        pool_[idx] = nullptr;
        return;
    }

    std::mutex *GetObjAllocatorMutex() const
    {
        return mtx_;
    }

    T **GetObjAllocatorPool() const
    {
        return pool_;
    }

private:
    void GetOrAllocItemById(uint32_t id, uint32_t &poolIdx, uint32_t &subId) const
    {
        poolIdx = GetPoolIndex(id);
        const uint32_t baseId = AccumulatePoolCount(poolIdx);
        if ((pool_[poolIdx] == nullptr) && (mtx_ != nullptr)) {
            mtx_[poolIdx].lock();
            // it prevent the Multiple malloc memroy.
            uint32_t counter = 0;
            while ((pool_[poolIdx] == nullptr) && (counter < 15)) { // try alloc max 15 times
                pool_[poolIdx] = ObjAlloc();
                ++counter;
                if ((counter % 10) == 0) { // if try 10 times alloc failed, print warning log
                    RT_LOG(RT_LOG_WARNING, "pool index:%u obj alloc failed.", poolIdx);
                    (void)mmSleep(10); // sleep 10ms
                }
            }
            mtx_[poolIdx].unlock();
        }
        subId = id - baseId;
    }

    constexpr uint32_t GetPoolIndex(uint32_t id) const
    {
        return id / initCount_;
    }

    T *ObjAlloc(void) const
    {
        T *t = new (std::nothrow) T[initCount_];
        if (t == nullptr) {
            RT_LOG(RT_LOG_ERROR, "ObjAlloc failed, size %u", initCount_);
            return nullptr;
        }

        if (clearFlag_) {
            (void)memset_s(t, initCount_ * sizeof(T), 0, initCount_ * sizeof(T));
        }
        return t;
    }

    void ObjFree(T *pool) const
    {
        delete []pool;
    }

    const uint32_t initCount_;
    const uint32_t maxCount_;
    const bool clearFlag_;
    T **pool_;
    std::mutex *mtx_;
};
}
}

#endif  // CCE_RUNTIME_POOL_HPP
