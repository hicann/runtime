/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "sq_addr_memory_pool.hpp"

namespace cce {
namespace runtime {

SqAddrMemoryOrder::SqAddrMemoryOrder(Device* const dev) : NoCopy(), device_(dev) {}

SqAddrMemoryOrder::~SqAddrMemoryOrder() = default;

rtError_t SqAddrMemoryOrder::Init() const { return RT_ERROR_NONE; }

uint32_t SqAddrMemoryOrder::GetMemOrderTypeByMemSize(const uint32_t memSize) const
{
    UNUSED(memSize);
    return static_cast<uint32_t>(SQ_ADDR_MEM_ORDER_TYPE_MAX);
}

uint32_t SqAddrMemoryOrder::GetMemOrderSizeByMemOrderType(const uint32_t memOrderType) const
{
    UNUSED(memOrderType);
    return 0U;
}

BufferAllocator* SqAddrMemoryOrder::FindSqMemPoolByMemOrderType(const uint32_t memOrderType)
{
    UNUSED(memOrderType);
    return nullptr;
}

BufferAllocator* SqAddrMemoryOrder::SetUp(const uint32_t memOrderType)
{
    UNUSED(memOrderType);
    return nullptr;
}

void* SqAddrMemoryOrder::DrvAllocSqAddr(const size_t size, void* const para)
{
    UNUSED(size);
    UNUSED(para);
    return nullptr;
}

void SqAddrMemoryOrder::DrvFreeSqAddr(void* const addr, void* const para)
{
    UNUSED(addr);
    UNUSED(para);
}

rtError_t SqAddrMemoryOrder::AllocSqAddr(const uint32_t memOrderType, uint64_t** sqAddr)
{
    UNUSED(memOrderType);
    UNUSED(sqAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SqAddrMemoryOrder::FreeSqAddr(const uint64_t* sqAddr, const uint32_t memOrderType)
{
    UNUSED(sqAddr);
    UNUSED(memOrderType);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
