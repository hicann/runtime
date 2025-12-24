/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_SPM_POOL_HPP
#define CCE_RUNTIME_SPM_POOL_HPP

#include "base.hpp"
#include "buffer_allocator.hpp"

namespace cce {
namespace runtime {
class Device;

class SpmPool : public NoCopy {
public:
    explicit SpmPool(Device * const devPtr);
    ~SpmPool() override;
    rtError_t Init();
    rtError_t AllocSPM(void **dptr, const uint64_t size);
    rtError_t FreeSPM(const void * const dptr);
    bool IsSPM(const void * const dptr) const;

private:
    static void *DrvAllocSPM(const size_t size, void * const para);
    static void DrvFreeSPM(void * const addr, void * const para);

    uint32_t spmItemSize_;
    uint32_t spmPageNum_;
    uint32_t spmPageSize_;
    uint32_t spmPagePad_;
    uint32_t spmInitCount_;
    uint64_t *spmBases_;
    Device *dev_;
    BufferAllocator *spmAllocator_;
};
}
}

#endif  // CCE_RUNTIME_SPM_POOL_HPP
