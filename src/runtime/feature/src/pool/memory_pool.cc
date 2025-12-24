/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "memory_pool.hpp"

namespace cce {
namespace runtime {

MemoryPool::MemoryPool(Device *dev, const bool isReadOnly) : NoCopy(), device_(dev),
    driver_(dev->Driver_()), usedSize_(0), isReadOnly_(isReadOnly)
{
}

MemoryPool::~MemoryPool() noexcept
{
    // 释放内存池内存
    if (addr_ != nullptr && driver_ != nullptr) {
        driver_->DevMemFree(addr_, device_->Id_());
    }
    // 释放链表
    if (memoryList_ != nullptr) {
        delete memoryList_;
    }
    device_ = nullptr;
    driver_ = nullptr;
}

size_t MemoryPool::GetUsedSize() const
{
    return usedSize_;
}

const void* MemoryPool::GetAddr() const
{
    return addr_;
}
 
bool MemoryPool::GetReadOnlyFlag() const
{
    return isReadOnly_;
}

rtError_t MemoryPool::Init()
{
    addr_ = AllocDevMem(POOL_SIZE_2M);
    NULL_PTR_RETURN(addr_ , RT_ERROR_MEMORY_ALLOCATION);

    memoryList_ = new (std::nothrow) MemoryList();
    NULL_PTR_RETURN(memoryList_ , RT_ERROR_MEMORY_ALLOCATION);
    return memoryList_->AddBlock(addr_, POOL_SIZE_2M); 
}

// 分配内存
void* MemoryPool::Allocate(size_t size)
{
    // 从链表中获取一个符合要求的内存块
    void* addr = memoryList_->GetBlock(size);
    if (addr != nullptr) {
        usedSize_ += size;
    }
    return addr;
}

// 释放内存
void MemoryPool::Release(void* address, size_t size)
{
    // 将释放的内存块重新添加到链表中
    memoryList_->AddBlock(address, size);
    if (usedSize_ >= size) {
        usedSize_ -= size;
    } else {
        RT_LOG(RT_LOG_EVENT, "release memory size[%lu]  beyond the used memory size[%lu]!", size, usedSize_);
        usedSize_ = 0;
    }
}

// 检查指针是否在内存池范围内
bool MemoryPool::Contains(void* ptr) const
{
    if (usedSize_ == 0) {
        return false;
    }

    if (memoryList_->ContainsAddress(ptr)) {
        return false;
    }

    return (static_cast<int8_t*>(ptr) >= static_cast<int8_t*>(addr_)) &&
           (static_cast<int8_t*>(ptr) < (static_cast<int8_t*>(addr_) + POOL_SIZE_2M));
}

void *MemoryPool::AllocDevMem(const uint32_t size) const
{
    rtError_t error = RT_ERROR_NONE;
    void *addr = nullptr;
    const bool readOnly = (!device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_DATA_READ_ONLY)) ? 
        isReadOnly_ : false;
  
    error = driver_->DevMemAlloc(
        &addr, static_cast<uint64_t>(size), RT_MEMORY_HBM, device_->Id_(),
        MODULEID_RUNTIME, true, readOnly);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "DevMemAlloc failed, device_id=%u, retCode=%#x", device_->Id_(), error);
        return nullptr;
    }
    return addr;
}
}  // namespace runtime
}  // namespace cce
