/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_MEMORY_POOL_HPP
#define CCE_RUNTIME_MEMORY_POOL_HPP

#include <mutex>
#include <vector>
#include "base.hpp"
#include "memory_list.hpp"
#include "device.hpp"
#include "driver.hpp"

namespace cce {
namespace runtime {
constexpr size_t POOL_SIZE_2M = 2097152U;
class MemoryPool : public NoCopy {
public:
    explicit MemoryPool(Device *dev, const bool isReadOnly);
    ~MemoryPool() noexcept override;

    rtError_t Init();
    
    // 申请device内存
    void *AllocDevMem(const uint32_t size) const;
    
    // 分配内存
    void *Allocate(size_t size);

    // 释放内存
    void Release(void* address, size_t size);

    // 检查指针是否在内存池范围内
    bool Contains(void* ptr) const;

    size_t GetUsedSize() const;

    bool GetReadOnlyFlag() const;
 
    const void *GetAddr() const;

    std::mutex *GetMemoryPoolAdviseMutex();
private:
    // 内存块链表
    MemoryList* memoryList_ = nullptr;

    // 内存池起始地址
    void *addr_ = nullptr;

    Device *device_ = nullptr;
    Driver *driver_ = nullptr;
    // 已使用的内存大小
    size_t usedSize_ = 0U;
    bool isReadOnly_ = false;

    std::mutex mutexAdviseMem_;
};
}
}
#endif // CCE_RUNTIME_MEMORY_POOL_HPP
