/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel_dfx_info.hpp"
#include "driver_enum_desc.hpp"

namespace cce {
namespace runtime {
rtError_t KernelDfxInfo::SetKernelDfxInfoCallback(rtKernelDfxInfoType type, rtKernelDfxInfoProFunc func)
{
    const std::unique_lock<std::mutex> regMapLock(kernelDfxInfoCallbackMutex_);
    if (kernelDfxInfoCallbackMap_.find(type) != kernelDfxInfoCallbackMap_.end()) {
        RT_LOG(
            RT_LOG_ERROR, "Failed to register dump call function, duplicate callback registration, type=%s(%d)",
            KernelDfxInfoTypeName(type), type);
        return RT_ERROR_INVALID_VALUE;
    }
    kernelDfxInfoCallbackMap_[type] = func;
    RT_LOG(RT_LOG_INFO, "Register rtKernelDfxInfoProFunc callback finish, data dump type=%d.", type);
    return RT_ERROR_NONE;
}

rtError_t KernelDfxInfo::ExecuteKernelDfxInfoFunc(
    rtKernelDfxInfoType type, uint32_t coreType, uint32_t coreId, const uint8_t* buffer, uint64_t length)
{
    const std::unique_lock<std::mutex> regMapLock(kernelDfxInfoCallbackMutex_);
    auto iter = kernelDfxInfoCallbackMap_.find(type);
    if (iter != kernelDfxInfoCallbackMap_.end()) {
        RT_LOG(
            RT_LOG_INFO, "ExecuteKernelDfxInfoFunc start, type=%d, coreType=%u, coreId=%u, buffer=%p, length=%llu",
            type, coreType, coreId, buffer, length);
        iter->second(type, coreType, coreId, buffer, length);
        RT_LOG(RT_LOG_INFO, "ExecuteKernelDfxInfoFunc end");
    }
    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce