/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime.hpp"
#include "sq_addr_memory_pool.hpp"
#include "error_message_manage.hpp"
namespace {
constexpr uint32_t SQ_ADDR_ITEM_SIZE_32K = 32U * 1024U;
constexpr uint32_t SQ_ADDR_ITEM_SIZE_64K = 64U * 1024U;
constexpr uint32_t SQ_ADDR_ITEM_SIZE_128K = 128U * 1024U;
constexpr uint32_t SQ_ADDR_ITEM_SIZE_256K = 256U * 1024U;
constexpr uint32_t SQ_ADDR_ITEM_SIZE_512K = 512U * 1024U;
constexpr uint32_t SQ_ADDR_ITEM_SIZE_1M = 1U * 1024U * 1024U;
constexpr uint32_t SQ_ADDR_ITEM_SIZE_2M = 2U * 1024U * 1024U;
constexpr uint32_t SQ_ADDR_ITEM_HUGE_PAGE_SIZE = 2U * 1024U * 1024U;

constexpr uint32_t SQ_ADDR_MAX_ITEM_32K = 262144U; // SQ_ADDR_TOTAL_MEM_SIZE / SQ_ADDR_ITEM_SIZE_32K
constexpr uint32_t SQ_ADDR_MAX_ITEM_64K = 131072U;
constexpr uint32_t SQ_ADDR_MAX_ITEM_128K = 65536U;
constexpr uint32_t SQ_ADDR_MAX_ITEM_256K = 32768U;
constexpr uint32_t SQ_ADDR_MAX_ITEM_512K = 16384U;
constexpr uint32_t SQ_ADDR_MAX_ITEM_1M = 8192U;
constexpr uint32_t SQ_ADDR_MAX_ITEM_2M = 4096U;
}

namespace cce {
namespace runtime {

static uint32_t g_orderMemSizes[SQ_ADDR_MEM_ORDER_TYPE_MAX] = {
    SQ_ADDR_ITEM_SIZE_32K,
    SQ_ADDR_ITEM_SIZE_64K,
    SQ_ADDR_ITEM_SIZE_128K,
    SQ_ADDR_ITEM_SIZE_256K,
    SQ_ADDR_ITEM_SIZE_512K,
    SQ_ADDR_ITEM_SIZE_1M,
    SQ_ADDR_ITEM_SIZE_2M,
};

SqAddrMemoryOrder::SqAddrMemoryOrder(Device * const dev)
    : NoCopy(),
      device_(dev)
{
}
SqAddrMemoryOrder::~SqAddrMemoryOrder()
{
    RT_LOG(RT_LOG_DEBUG, "free sq addr order");
    for (auto& pair : sqAddrAllocators_) {
        DELETE_O(pair.second);
    }

    sqAddrAllocators_.clear();
    device_ = nullptr;
}

rtError_t SqAddrMemoryOrder::Init() const
{
    return RT_ERROR_NONE;
}

uint32_t SqAddrMemoryOrder::GetMemOrderTypeByMemSize(const uint32_t memSize) const
{
    SQ_ADDR_MEM_ORDER_TYPE memOrderType = SQ_ADDR_MEM_ORDER_TYPE_MAX;
    const uint32_t arraySize = static_cast<uint32_t>(SQ_ADDR_MEM_ORDER_TYPE_MAX);

    for (uint32_t index = 0U; index < arraySize; index++) {
        if (memSize <= g_orderMemSizes[index]) {
            memOrderType = static_cast<SQ_ADDR_MEM_ORDER_TYPE>(index);
            break;
        }
    }

    if (memOrderType >= SQ_ADDR_MEM_ORDER_TYPE_MAX) {
        RT_LOG(RT_LOG_ERROR, "invalid memSize=%u", memSize);
    }

    return static_cast<uint32_t>(memOrderType);
}

uint32_t SqAddrMemoryOrder::GetMemOrderSizeByMemOrderType(const uint32_t memOrderType) const
{
    if (memOrderType >= SQ_ADDR_MEM_ORDER_TYPE_MAX) {
        RT_LOG(RT_LOG_ERROR, "invalid memOrderType=%u", memOrderType);
        return UINT32_MAX;
    }
 
    return g_orderMemSizes[memOrderType];
}

BufferAllocator* SqAddrMemoryOrder::FindSqMemPoolByMemOrderType(const uint32_t memOrderType)
{
    auto it = std::find_if(sqAddrAllocators_.begin(), sqAddrAllocators_.end(),
        [memOrderType](const auto& pair) { return pair.first == memOrderType; });
    if (it != sqAddrAllocators_.end()) {
        RT_LOG(RT_LOG_DEBUG, "Find memOrderType=%u, it=%p", memOrderType, it->second);
        return it->second;
    }

    BufferAllocator* bufferAllocator = nullptr;
    bufferAllocator = SetUp(memOrderType);
    return bufferAllocator;
}
BufferAllocator* SqAddrMemoryOrder::SetUp(const uint32_t memOrderType)
{
    static SqAddrMemoryOrder_t memOrderTypeList[SQ_ADDR_MEM_ORDER_TYPE_MAX] =
        {{SQ_ADDR_ITEM_SIZE_32K, SQ_ADDR_ITEM_HUGE_PAGE_SIZE / SQ_ADDR_ITEM_SIZE_32K, SQ_ADDR_MAX_ITEM_32K},
         {SQ_ADDR_ITEM_SIZE_64K, SQ_ADDR_ITEM_HUGE_PAGE_SIZE / SQ_ADDR_ITEM_SIZE_64K, SQ_ADDR_MAX_ITEM_64K},
         {SQ_ADDR_ITEM_SIZE_128K, SQ_ADDR_ITEM_HUGE_PAGE_SIZE / SQ_ADDR_ITEM_SIZE_128K, SQ_ADDR_MAX_ITEM_128K},
         {SQ_ADDR_ITEM_SIZE_256K, SQ_ADDR_ITEM_HUGE_PAGE_SIZE / SQ_ADDR_ITEM_SIZE_256K, SQ_ADDR_MAX_ITEM_256K},
         {SQ_ADDR_ITEM_SIZE_512K, SQ_ADDR_ITEM_HUGE_PAGE_SIZE / SQ_ADDR_ITEM_SIZE_512K, SQ_ADDR_MAX_ITEM_512K},
         {SQ_ADDR_ITEM_SIZE_1M, SQ_ADDR_ITEM_HUGE_PAGE_SIZE / SQ_ADDR_ITEM_SIZE_1M, SQ_ADDR_MAX_ITEM_1M},
         {SQ_ADDR_ITEM_SIZE_2M, SQ_ADDR_ITEM_HUGE_PAGE_SIZE / SQ_ADDR_ITEM_SIZE_2M, SQ_ADDR_MAX_ITEM_2M}};

    RT_LOG(RT_LOG_DEBUG, "SetUp sq addr memory order memOrderType=%u", memOrderType);
    if (memOrderType >= SQ_ADDR_MEM_ORDER_TYPE_MAX) {
        return nullptr;
    }

    BufferAllocator *sqAddrAllocator = new (std::nothrow) BufferAllocator(memOrderTypeList[memOrderType].sqAddrItemSize, 
        memOrderTypeList[memOrderType].sqAddrInitCount, memOrderTypeList[memOrderType].sqAddrMaxCount,
        BufferAllocator::LINEAR, &DrvAllocSqAddr, &DrvFreeSqAddr, device_);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, sqAddrAllocator == nullptr, nullptr,
        "SqAddr pool init failed, new BufferAllocator failed.");

    sqAddrAllocators_.emplace_back(static_cast<SQ_ADDR_MEM_ORDER_TYPE>(memOrderType), sqAddrAllocator);
    RT_LOG(RT_LOG_DEBUG, "new BufferAllocator ok.");

    return sqAddrAllocator;
}

void *SqAddrMemoryOrder::DrvAllocSqAddr(const size_t size, void * const para)
{
    COND_RETURN_WARN(para == nullptr, nullptr, "para is null");
    COND_RETURN_WARN(size == 0U, nullptr, "size is 0");

    Device * const device = RtPtrToPtr<Device *, void *>(para);
    void *addr = nullptr;
    const rtError_t error = device->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(size),
        RT_MEMORY_P2P_HBM, device->Id_(), MODULEID_RUNTIME, false, false, false, false, true);
    COND_RETURN_WARN(error != RT_ERROR_NONE, nullptr, "device mem alloc sqAddr order failed, "
             "size=%u(bytes), kind=%d, id=%u, retCode=0x%#x", size, RT_MEMORY_P2P_HBM, device->Id_(), static_cast<uint32_t>(error));

    return addr;
}

void SqAddrMemoryOrder::DrvFreeSqAddr(void * const addr, void * const para)
{
    COND_RETURN_WARN(addr == nullptr, , "addr is null");
    COND_RETURN_WARN(para == nullptr, , "para is null");
    Device * const device = RtPtrToPtr<Device *, void *>(para);
    const rtError_t error = device->Driver_()->DevMemFree(addr, device->Id_());
    COND_LOG(error != RT_ERROR_NONE, "device mem free sqAddr failed, retCode=0x%#x", static_cast<uint32_t>(error));
}

rtError_t SqAddrMemoryOrder::AllocSqAddr(const uint32_t memOrderType, uint64_t **sqAddr)
{
    RT_LOG(RT_LOG_DEBUG, "memOrderType=%d", memOrderType);
    if ((sqAddr == nullptr) || (memOrderType >= SQ_ADDR_MEM_ORDER_TYPE_MAX)) {
        return RT_ERROR_INVALID_VALUE;
    }

    BufferAllocator *sqAddrAllocator = FindSqMemPoolByMemOrderType(memOrderType);
    COND_RETURN_WARN(sqAddrAllocator == nullptr, RT_ERROR_INVALID_VALUE, "invalid memOrderType=%u.", memOrderType);

    *sqAddr = RtPtrToPtr<uint64_t *, void *>(sqAddrAllocator->AllocItem());
    if (*sqAddr == nullptr) {
        RT_LOG(RT_LOG_DEBUG, "alloc SqAddr fail, memOrderType=%u", memOrderType);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    RT_LOG(RT_LOG_DEBUG, "alloc SqAddr success, sqAddr=0x%x", *sqAddr);

    return RT_ERROR_NONE;
}

rtError_t SqAddrMemoryOrder::FreeSqAddr(const uint64_t *sqAddr, const uint32_t memOrderType)
{
    RT_LOG(RT_LOG_DEBUG, "memOrderType=%d", memOrderType);
    if ((sqAddr == nullptr) || (memOrderType >= SQ_ADDR_MEM_ORDER_TYPE_MAX)) {
        return RT_ERROR_INVALID_VALUE;
    }

    BufferAllocator *sqAddrAllocator = FindSqMemPoolByMemOrderType(memOrderType);
    COND_RETURN_WARN(sqAddrAllocator == nullptr, RT_ERROR_INVALID_VALUE, "invalid memOrderType=%u.", memOrderType);

    const int32_t id = sqAddrAllocator->GetIdByItem(RtPtrToPtr<const void *const, const uint64_t *>(sqAddr));
    if (id < 0) {
        RT_LOG(RT_LOG_EVENT, "Free SqAddr fail, sqAddr=%p, id=%d", sqAddr, id);
        return RT_ERROR_INVALID_VALUE;
    }

    sqAddrAllocator->FreeById(id);
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
