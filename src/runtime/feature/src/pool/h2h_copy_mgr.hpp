/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_H2H_COPY_MGR_HPP__
#define __CCE_RUNTIME_H2H_COPY_MGR_HPP__

#include <unordered_map>
#include "base.hpp"
#include "buffer_allocator.hpp"

namespace cce {
namespace runtime {

enum class H2HCopyPolicy : uint64_t {
    H2H_POLICY_DEFAULT,
    H2H_COPY_POLICY_SYNC
};
constexpr uint32_t DEFAULT_INIT_ITEM_SIZE = 4096U;
class H2HCopyMgr : public NoCopy {
public:
    H2HCopyMgr(const uint32_t size, const uint32_t initCnt,
        const uint32_t maxCnt, const BufferAllocator::Strategy stg, H2HCopyPolicy policy);
    H2HCopyMgr(H2HCopyPolicy policy);
    ~H2HCopyMgr() override;

    void *AllocHostMem(const bool isLogError = true) const;
    void *AllocHostMem(const uint32_t size) const;
    void FreeHostMem(void *item) const;
    rtError_t H2DMemCopy(void *dst, const void * const src, const uint32_t size) const;

private:
    static void *MallocBuffer(const size_t size, void * const para);
    static void FreeBuffer(void * const addr, void * const para);
    BufferAllocator *argAllocator_{nullptr};
    H2HCopyPolicy policy_;
};
}
}

#endif  // CCE_RUNTIME_H2H_COPY_MGR_HPP
