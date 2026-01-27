/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "h2h_copy_mgr.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"
#include "securec.h"

namespace cce {
namespace runtime {
H2HCopyMgr::H2HCopyMgr(const uint32_t size, const uint32_t initCnt,
    const uint32_t maxCnt, const BufferAllocator::Strategy stg, H2HCopyPolicy policy)
    : NoCopy(),
      policy_(policy)
{
    if (policy_ == H2HCopyPolicy::H2H_COPY_POLICY_SYNC) {
        argAllocator_ = new (std::nothrow) BufferAllocator(size, initCnt, maxCnt,
            stg,  &MallocBuffer, &FreeBuffer, nullptr);
    }
    RT_LOG(RT_LOG_INFO, "alloc h2h copy buff success, policy %d", policy_);
}

H2HCopyMgr::H2HCopyMgr(H2HCopyPolicy policy)
    : NoCopy(),
      policy_(policy)
{
}

H2HCopyMgr::~H2HCopyMgr()
{
    DELETE_O(argAllocator_);
}


void *H2HCopyMgr::AllocHostMem(const bool isLogError) const
{
    if (unlikely(argAllocator_ == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "alloc argAllocator_ failed!");
        return nullptr;
    }
    if (policy_ == H2HCopyPolicy::H2H_COPY_POLICY_SYNC) {
        return argAllocator_->AllocItem(isLogError);
    }
    return nullptr;
}

void *H2HCopyMgr::AllocHostMem(const uint32_t size) const
{
    void *addr = nullptr;
    addr = malloc(size);
    if (addr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "malloc host addr failed.");
        return nullptr;
    }
    return addr;
}

void H2HCopyMgr::FreeHostMem(void *item) const
{
    if (item == nullptr) {
        RT_LOG(RT_LOG_ERROR, "free item is null!");
        return;
    }
    // devAllocator being null  means this is a random allocator;
    if (unlikely(argAllocator_ == nullptr)) {
        RT_LOG(RT_LOG_INFO, "random allocator freeing host memory");
        free(item);
        return;
    }
    argAllocator_->FreeByItem(item);
}

rtError_t H2HCopyMgr::H2DMemCopy(void *dst, const void * const src, const uint32_t size) const
{
    if (dst == nullptr || src == nullptr) {
        RT_LOG(RT_LOG_ERROR, "destination address, source address parameters are illegal");
        return RT_ERROR_INVALID_VALUE;
    }
    uint32_t offset = 0U;
    uint32_t remaining = 0U;
    uint32_t curSize = 0U;
    void *dest = dst;
    const void *srcAddr = src;
    void* nonConstSrc = RtPtrToUnConstPtr<void *>(srcAddr);
    if (policy_ == H2HCopyPolicy::H2H_COPY_POLICY_SYNC) {
        while (offset < size) {
            remaining = size - offset;
            curSize = (remaining < SECUREC_MEM_MAX_LEN) ? remaining : SECUREC_MEM_MAX_LEN;
            const errno_t ret = memcpy_s(RtValueToPtr<void *>(RtPtrToValue<void *>(dest) + offset), static_cast<size_t>(curSize),
                RtValueToPtr<void *>(RtPtrToValue<void *>(nonConstSrc) + offset), static_cast<size_t>(curSize));
            if (ret != EOK) {
                RT_LOG(RT_LOG_ERROR, "Args host memcpy failed, size=%u, offset=%u, kind=%d, ret=%#x.", size, offset, RT_MEMCPY_HOST_TO_HOST, ret);
                return RT_ERROR_INVALID_VALUE;
            }
            offset += curSize;
        }
    }
    return RT_ERROR_NONE;
}

void *H2HCopyMgr::MallocBuffer(const size_t size, void * const para)
{
    UNUSED(para);
    void *addr = nullptr;
    addr = malloc(size);
    if (addr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "malloc Host addr failed, retCode=%#x, size=%u(bytes)", size);
        return nullptr;
    }
    return addr;
}

void H2HCopyMgr::FreeBuffer(void * const addr, void * const para)
{
    UNUSED(para);
    if (addr != nullptr) {
        free(addr);
    }
}

}  // namespace runtime
}  // namespace cce
