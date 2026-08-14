/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "base.hpp"
#include "memory_pool_manager.hpp"

namespace cce {
namespace runtime {

#if F_DESC("MemoryPoolManagerStub")
MemoryPoolManager::MemoryPoolManager(Device* dev, int32_t initialPoolsNum)
    : NoCopy(), device_(dev), numPools_(initialPoolsNum)
{}

MemoryPoolManager::~MemoryPoolManager() noexcept {}

rtError_t MemoryPoolManager::Init() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

void* MemoryPoolManager::Allocate(const size_t size, const bool readOnly)
{
    UNUSED(size);
    UNUSED(readOnly);
    return nullptr;
}

bool MemoryPoolManager::TryRelease(void* ptr, size_t size)
{
    UNUSED(ptr);
    UNUSED(size);
    return false;
}

PoolMemInfo MemoryPoolManager::GetPoolMemInfo(void* ptr)
{
    UNUSED(ptr);
    return {};
}
#endif

} // namespace runtime
} // namespace cce
