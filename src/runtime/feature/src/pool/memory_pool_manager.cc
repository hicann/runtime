/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memory_pool_manager.hpp"

#include "device.hpp"
#include "driver.hpp"
#include "memory_pool.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

MemoryPoolManager::MemoryPoolManager(Device *dev, int32_t initialPoolsNum) : NoCopy(), device_(dev),
    driver_(dev->Driver_()), numPools_(initialPoolsNum)
{
}

TIMESTAMP_EXTERN(ReleaseMemoryPoolManager);
MemoryPoolManager::~MemoryPoolManager() noexcept
{
    driver_ = nullptr;
    device_ = nullptr;
    RT_LOG(RT_LOG_DEBUG, "~MemoryPoolManager release device memory, size=%u.",  pools_.size());
    TIMESTAMP_BEGIN(ReleaseMemoryPoolManager);
    for (auto pool : pools_) {
        if (pool != nullptr) {
            delete pool;
        }
    }
    TIMESTAMP_END(ReleaseMemoryPoolManager);
}

rtError_t MemoryPoolManager::Init()
{
    rtError_t error = RT_ERROR_NONE;
    MemoryPool *mPool;
    for (int32_t i = 0; i < numPools_; ++i) {
        mPool = new (std::nothrow) MemoryPool(device_, true);
        NULL_PTR_RETURN(mPool , RT_ERROR_MEMORY_ALLOCATION);
        error = mPool->Init();
        COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, MEMORY_POOL_FREE,
            error, RT_ERROR_MEMORY_ALLOCATION, "allocate device memory failed.");
        pools_.push_back(mPool);
    }
    return error;
MEMORY_POOL_FREE:
    DELETE_O(mPool);
    for(auto pool : pools_) {
        DELETE_O(pool);
    }
    return error;
}

void* MemoryPoolManager::Allocate(const size_t size, const bool readOnly)
{
    // 超出2M
    if (size == 0 || (size > POOL_SIZE_2M)) {
        return nullptr;
    }
    std::lock_guard<std::mutex> lock(mutex_);
    for (auto pool : pools_) {
        if (readOnly == pool->GetReadOnlyFlag()) {
            void* block = pool->Allocate(size);
            if (block != nullptr) {
                RT_LOG(RT_LOG_DEBUG,
                    "drv devId=%u, alloc size=%u, pool=%#" PRIx64 ", addr=%#" PRIx64 ", readOnly=%d.",
                    device_->Id_(), size, pool, pool->GetAddr(), readOnly);
                return block;
            }
        }
    }
 
    // 没有可用的内存池，创建一个新的内存池
    const rtError_t error = AddMemoryPool(readOnly);
    if (error != RT_ERROR_NONE) {
        return nullptr;
    }
    return pools_.back()->Allocate(size);  // 使用刚刚添加的池
}

TIMESTAMP_EXTERN(MemoryPoolManagerRelease);
void MemoryPoolManager::Release(void* ptr, size_t size)
{
    TIMESTAMP_BEGIN(MemoryPoolManagerRelease);
    std::lock_guard<std::mutex> lock(mutex_);
    for (auto pool : pools_) {
        if (pool->Contains(ptr)) {
            pool->Release(ptr, size);
            RT_LOG(RT_LOG_DEBUG, "release device memory, ptr=%#" PRIx64 ", size=%u.", ptr, size);
            CheckAndReleasePools();
            TIMESTAMP_END(MemoryPoolManagerRelease);
            return;
        }
    }
}

rtError_t MemoryPoolManager::AddMemoryPool(const bool readOnly)
{
    rtError_t error = RT_ERROR_NONE;
    MemoryPool *pool = new (std::nothrow) MemoryPool(device_, readOnly);
    NULL_PTR_RETURN(pool , RT_ERROR_MEMORY_ALLOCATION);
    error = pool->Init();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, MEMORY_POOL_FREE,
            error, RT_ERROR_MEMORY_ALLOCATION, "allocate device memory failed.");
    pools_.push_back(pool);
    ++numPools_;
    return RT_ERROR_NONE;
MEMORY_POOL_FREE:
    DELETE_O(pool);
    return error;
}

bool MemoryPoolManager::Contains(void* ptr)
{
    for (auto pool : pools_) {
        if (pool->Contains(ptr)) {
            return true;
        }
    }
    return false;
}

void MemoryPoolManager::CheckAndReleasePools()
{
    int32_t freePoolCount = 0;

    // 计算空闲池的数量
    for (auto& pool : pools_) {
        if (pool->GetUsedSize() == 0) {
            ++freePoolCount;
        }
    }
    // 如果空闲池数量超过阈值，则释放多余的池
    if (freePoolCount > maxFreePools_) {
        // 释放空闲池
        auto it = pools_.cbegin();
        while ((it != pools_.cend()) && (freePoolCount > maxFreePools_)) {
            if ((*it)->GetUsedSize() == 0) {
                delete *it;
                it = pools_.erase(it);  // 从向量中移除并释放内存池
                --freePoolCount;
                --numPools_;
            } else {
                ++it;
            }
        }
    }
}

std::mutex *MemoryPoolManager::GetMemoryPoolAdviseMutex(void *ptr)
{
    for (MemoryPool *pool : pools_) {
        if (pool->Contains(ptr)) {
            RT_LOG(RT_LOG_DEBUG, "drv device_id=%u, pool=%#" PRIx64 ", addr=%#" PRIx64 ", ptr=%#" PRIx64 "",
                device_->Id_(), pool, pool->GetAddr(), ptr);
            return pool->GetMemoryPoolAdviseMutex();
        }
    }
    
    RT_LOG(RT_LOG_DEBUG, "drv device_id=%u, ptr=%#" PRIx64 "", device_->Id_(), ptr);
    return nullptr;
}

const void *MemoryPoolManager::GetMemoryPoolBaseAddr(void *ptr)
{
    for (MemoryPool *pool : pools_) {
        if (pool->Contains(ptr)) {
            RT_LOG(RT_LOG_DEBUG, "drv device_id=%u, pool=%#" PRIx64 ", addr=%#" PRIx64 ", ptr=%#" PRIx64 "",
                device_->Id_(), pool, pool->GetAddr(), ptr);
            return pool->GetAddr();
        }
    }

    RT_LOG(RT_LOG_DEBUG, "drv device_id=%u, ptr=%#" PRIx64 "", device_->Id_(), ptr);
    return nullptr;
}

}  // namespace runtime
}  // namespace cce
