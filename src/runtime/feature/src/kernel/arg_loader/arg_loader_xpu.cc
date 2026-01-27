/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "xpu_device.hpp"
#include "arg_loader_xpu.hpp"
#include "stream_xpu.hpp"
#include "api.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
XpuArgLoader::XpuArgLoader(XpuDevice * const dev)
    : NoCopy(), device_(dev)
{
}

XpuArgLoader::~XpuArgLoader()
{
    DELETE_O(argAllocator_);
    DELETE_O(randomAllocator_);
    DELETE_O(handleAllocator_);
}

rtError_t XpuArgLoader::Init()
{
    uint32_t initCount = 1024U;
    itemSize_ = XPU_ARG_POOL_COPY_SIZE;
    uint32_t maxItemCount = device_->GetXpuMaxStream() * device_->GetXpuStreamDepth();

    const uint32_t argAllocatorSize = initCount;
    argAllocator_ = new (std::nothrow) H2HCopyMgr(itemSize_, argAllocatorSize,
        maxItemCount, BufferAllocator::LINEAR, H2HCopyPolicy::H2H_COPY_POLICY_SYNC);

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, argAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init xpu arg loader stage1 failed, new BufferAllocator failed.");

    randomAllocator_ = new (std::nothrow) H2HCopyMgr(H2HCopyPolicy::H2H_COPY_POLICY_SYNC);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, randomAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init xpu arg loader stage2 failed, new BufferAllocator failed.");

    const uint32_t handleAllocatorSize = 1024U;
    handleAllocator_ = new (std::nothrow) BufferAllocator(static_cast<uint32_t>(sizeof(XpuHandle)), handleAllocatorSize,
        maxItemCount);

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, handleAllocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init xpu arg loader stage3 failed, new BufferAllocator failed.");
    RT_LOG(RT_LOG_INFO, "new BufferAllocator handleAllocator_ ok, Runtime_alloc_size %zu", sizeof(BufferAllocator));

    return RT_ERROR_NONE;
}

rtError_t XpuArgLoader::AllocCopyPtr(const uint32_t size, ArgLoaderResult * const result)
{
    XpuHandle *argHandle = nullptr;
    result->handle = handleAllocator_->AllocItem();
    NULL_PTR_RETURN(result->handle, RT_ERROR_MEMORY_ALLOCATION);
    argHandle = static_cast<XpuHandle *>(result->handle);
    argHandle->isFreeArgs = false;
    bool isRandom = false;

    H2HCopyMgr *argAllocator = nullptr;
    if (size <= XPU_ARG_POOL_COPY_SIZE) {
        argAllocator = argAllocator_;
    } else {
        argAllocator = randomAllocator_;
        isRandom = true;
    }

    void *kerArgs = nullptr;
    if (isRandom) {
        kerArgs = argAllocator->AllocHostMem(size);
    } else {
        kerArgs = argAllocator->AllocHostMem();
    }
    if (kerArgs == nullptr) {
        handleAllocator_->FreeByItem(argHandle);
        result->handle = nullptr;
        RT_LOG(RT_LOG_ERROR, "Alloc args loader mem failed.");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    RT_LOG(RT_LOG_DEBUG, "Alloc args loader mem success.");
    argHandle->kerArgs = kerArgs;
    argHandle->isFreeArgs = true;
    argHandle->argsAlloc = argAllocator;
    result->kerArgs = kerArgs;
    return RT_ERROR_NONE;
}

rtError_t XpuArgLoader::Release(void * const argHandle) const
{
    if (argHandle == nullptr) {
        return RT_ERROR_NONE;
    }

    XpuHandle *hdl = static_cast<XpuHandle *>(argHandle);
    if (hdl->isFreeArgs) {
        hdl->argsAlloc->FreeHostMem(hdl->kerArgs);
        RT_LOG(RT_LOG_DEBUG, "Release arg memory!");
    }

    handleAllocator_->FreeByItem(argHandle);
    return RT_ERROR_NONE;
}
}
}
