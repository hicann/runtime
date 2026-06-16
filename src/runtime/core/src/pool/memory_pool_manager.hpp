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

#include <deque>
#include <mutex>
#include <shared_mutex>
#include "base.hpp"

namespace cce {
namespace runtime {
class Device;
class Driver;
class MemoryPool;

// 原子查询结果：baseAddr + adviseMutex 在同一把锁下一起获取，避免 TOCTOU
struct PoolMemInfo {
    const void *baseAddr = nullptr;
    std::mutex *adviseMutex = nullptr;
    bool found = false;
};

class MemoryPoolManager : public NoCopy {
public:
    explicit MemoryPoolManager(Device *dev, int32_t initialPoolsNum = 1);

    ~MemoryPoolManager() noexcept override;

    rtError_t Init();

    // 从内存池中分配内存，如果没有空闲池则创建一个新池
    void* Allocate(const size_t size, const bool readOnly);

    // 释放内存回到相应的内存池（内部持写锁，原子操作）
    void Release(void* ptr, size_t size);

    // 原子化的 Contains + Release：找到则释放并返回 true，否则返回 false
    // 替代外部 Contains() + Release() 的两步调用，消除 TOCTOU 风险
    bool TryRelease(void* ptr, size_t size);

    // 原子化查询：在同一个 shared_lock 下获取 baseAddr 和 adviseMutex
    // 替代外部 GetMemoryPoolBaseAddr() + GetMemoryPoolAdviseMutex() 的两步调用
    PoolMemInfo GetPoolMemInfo(void* ptr);

    bool Contains(void* ptr);

    std::mutex *GetMemoryPoolAdviseMutex(void* ptr);
    const void *GetMemoryPoolBaseAddr(void *ptr);
private:
    // 创建一个新的内存池并增加池的数量（调用者必须持有 mutex_ 写锁）
    rtError_t AddMemoryPool(const bool readOnly);

    // 检查并释放空闲池（调用者必须持有 mutex_ 写锁）
    void CheckAndReleasePools();

    // 使用 deque 而非 vector：push_back 不会使已有元素的指针/引用失效
    // 即使 vector realloc 导致迭代器失效的并发遍历场景，deque 的指针稳定性也能避免悬空
    std::deque<MemoryPool*> pools_;
    mutable std::shared_mutex mutex_;  // 读写锁：读操作 shared_lock，写操作 unique_lock
    Device *device_ = nullptr;
    Driver *driver_ = nullptr;
    int32_t numPools_ = 0; // 当前内存池的数量
    int32_t maxFreePools_ = 5; // 空闲池数量
};
}
}
#endif // CCE_RUNTIME_MEMORY_POOL_MANAGER_HPP
