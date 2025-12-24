/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_MEMORY_POOL_MANAGER_HPP
#define CCE_RUNTIME_MEMORY_POOL_MANAGER_HPP

#include <mutex>
#include <vector>
#include "base.hpp"

namespace cce {
namespace runtime {
class Device;
class Driver;
class MemoryPool;
class MemoryPoolManager : public NoCopy {
public:
    explicit MemoryPoolManager(Device *dev, int32_t initialPoolsNum = 1);
    
    ~MemoryPoolManager() noexcept override;

    rtError_t Init();

    // 从内存池中分配内存，如果没有空闲池则创建一个新池 
    // 调用前确定是否需要加锁保护
    void* Allocate(const size_t size, const bool readOnly);

    // 释放内存回到相应的内存池
    // 调用前确定是否需要加锁保护
    void Release(void* ptr, size_t size);

    void CheckAndReleasePools();

    bool Contains(void* ptr);
private:
    // 创建一个新的内存池并增加池的数量
    rtError_t AddMemoryPool(const bool readOnly);

    std::vector<MemoryPool*> pools_; // 内存池的向量
    std::mutex mutex_;
    Device *device_ = nullptr;
    Driver *driver_ = nullptr;
    int32_t numPools_ = 0; // 当前内存池的数量
    int32_t maxFreePools_ = 5; // 空闲池数量
};
}
}
#endif // CCE_RUNTIME_MEMORY_POOL_MANAGER_HPP
