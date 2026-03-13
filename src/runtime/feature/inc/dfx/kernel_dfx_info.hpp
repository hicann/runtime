/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_KERNEL_DFX_INFO_HPP
#define CCE_RUNTIME_KERNEL_DFX_INFO_HPP

#include "base.hpp"
#include "rt_inner_dfx.h"

namespace cce {
namespace runtime {

class KernelDfxInfo {
public:
    KernelDfxInfo(const KernelDfxInfo&) = delete;
    KernelDfxInfo& operator=(const KernelDfxInfo&) = delete;

    static KernelDfxInfo* Instance()
    {
        static KernelDfxInfo instance;
        return &instance;
    }

    bool isSupportAllKernelDfxInfo() 
    {
        const std::unique_lock<std::mutex> regMapLock(kernelDfxInfoCallbackMutex_);
        return kernelDfxInfoCallbackMap_.find(RT_KERNEL_DFX_INFO_DEFAULT) != kernelDfxInfoCallbackMap_.end();
    }

    rtKernelDfxInfoType GetValidBlockInfoType()
    {
        if (kernelDfxInfoCallbackMap_.find(RT_KERNEL_DFX_INFO_DEFAULT) != kernelDfxInfoCallbackMap_.end()) {
            return RT_KERNEL_DFX_INFO_DEFAULT;
        }
        if (kernelDfxInfoCallbackMap_.find(RT_KERNEL_DFX_INFO_BLOCK_INFO) != kernelDfxInfoCallbackMap_.end()) {
            return RT_KERNEL_DFX_INFO_BLOCK_INFO;
        }
        return RT_KERNEL_DFX_INFO_INVALID;
    }

    rtError_t SetKernelDfxInfoCallback(rtKernelDfxInfoType type, rtKernelDfxInfoProFunc func);
    rtError_t ExecuteKernelDfxInfoFunc(rtKernelDfxInfoType type, uint32_t coreType, uint32_t coreId, const uint8_t *buffer, uint64_t length);
private:
    std::map<rtKernelDfxInfoType, rtKernelDfxInfoProFunc> kernelDfxInfoCallbackMap_;
    std::mutex kernelDfxInfoCallbackMutex_;

    KernelDfxInfo() {}
};

} // runtime
} // cce

#endif // CCE_RUNTIME_KERNEL_DFX_INFO_HPP