/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_SQ_ADDR_MEMORY_POOL_HPP
#define CCE_RUNTIME_SQ_ADDR_MEMORY_POOL_HPP

#include "base.hpp"
#include "buffer_allocator.hpp"

namespace cce {
namespace runtime {
class Device;

enum SQ_ADDR_MEM_ORDER_TYPE : std::uint32_t {
    SQ_ADDR_MEM_ORDER_TYPE_32K = 0,
    SQ_ADDR_MEM_ORDER_TYPE_64K,
    SQ_ADDR_MEM_ORDER_TYPE_128K,
    SQ_ADDR_MEM_ORDER_TYPE_256K,
    SQ_ADDR_MEM_ORDER_TYPE_512K,
    SQ_ADDR_MEM_ORDER_TYPE_1M,
    SQ_ADDR_MEM_ORDER_TYPE_2M,

    SQ_ADDR_MEM_ORDER_TYPE_MAX,
};

typedef struct {
    uint32_t sqAddrItemSize;  // Size of memory units in each pool
    uint32_t sqAddrInitCount; // Indicates how many sqAddrItemSize there are in each pool.
    uint32_t sqAddrMaxCount;  // The entire pool can apply for up to how many sqAddrItemSize allocations.
                              // When memory is insufficient, a new pool of size sqAddrInitCount * sqAddrItemSize will be allocated.
} SqAddrMemoryOrder_t;

class SqAddrMemoryOrder : public NoCopy {
public:
    explicit SqAddrMemoryOrder(Device * const dev);
    ~SqAddrMemoryOrder() override;
    rtError_t Init() const;
    uint32_t GetMemOrderSizeByMemOrderType(const uint32_t memOrderType) const;
    uint32_t GetMemOrderTypeByMemSize(const uint32_t memSize) const;
    BufferAllocator* FindSqMemPoolByMemOrderType(const uint32_t memOrderType);
    BufferAllocator* SetUp(const uint32_t memOrderType);

    /**
     * @param [in]  memOrderType To indicate the size of the SQ address that needs to be applied for,
     * users can call GetMemOrderTypeByMemSize and pass the required memory size to convert it into memOrderType.
     * Currently supported memOrderSize values are: 32k, 64k, 128k, 256k, 512k, 1M, 2M
     * @param [out] **sqAddr     Second-level pointer, *sqAddr is the address of the allocated pointer.
     */
    rtError_t AllocSqAddr(const uint32_t memOrderType, uint64_t **sqAddr);

    /**
     * @param [in]  memOrderType Used to indicate which pool the sqAddr was allocated from.
     * @param [in-] *sqAddr      Memory to be released, returned only to the pool.
     */
    rtError_t FreeSqAddr(const uint64_t *sqAddr, const uint32_t memOrderType);

    static void *DrvAllocSqAddr(const size_t size, void * const para);
    static void DrvFreeSqAddr(void * const addr, void * const para);

private:
    Device *device_;
    std::vector<std::pair<SQ_ADDR_MEM_ORDER_TYPE, BufferAllocator*>> sqAddrAllocators_;
};
}
}

#endif  // CCE_RUNTIME_SQ_ADDR_MEMORY_POOL_HPP
