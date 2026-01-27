/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_ARG_LOADER_XPU_HPP__
#define __CCE_RUNTIME_ARG_LOADER_XPU_HPP__

#include "h2h_copy_mgr.hpp"
#include "arg_loader.hpp"
namespace cce {
namespace runtime {

class XpuDevice;

constexpr uint32_t XPU_ARG_ADDR_ALIGN_LEN = 8U;

struct XpuHandle {
    void *kerArgs;              // 记录申请到host地址
    bool isFreeArgs;              // 是否需要释放资源
    H2HCopyMgr *argsAlloc;      // 记录分配器
};

class XpuArgLoader : public NoCopy {
public:
    explicit XpuArgLoader(XpuDevice * const dev);
    ~XpuArgLoader() final;
    rtError_t Init();
    rtError_t Release(void * const argHandle) const;
    rtError_t AllocCopyPtr(const uint32_t size, ArgLoaderResult * const result);
protected:
    XpuDevice *device_;

private:
    H2HCopyMgr *argAllocator_{nullptr};
    BufferAllocator* handleAllocator_{nullptr};
    H2HCopyMgr *randomAllocator_{nullptr};
    void ReleaseDevArgPool(XpuHandle * const argHandle);
    rtError_t AllocDevArgPool(const uint32_t size, XpuHandle * const argHandle);
    uint32_t itemSize_;
};

}
}

#endif