/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "program_common.hpp"
#include "base.hpp"
namespace cce {
namespace runtime {
// XPU 注册CPU算子
rtError_t Program::XpuRegisterCpuKernel(const std::vector<CpuKernelInfo> &kernelInfos)
{
    constexpr uint64_t defaultTilingKey = 0ULL; // cpu kernel不使用tiling key，所以默认填值0
    kernelMapLock_.Lock();

    for (auto kernelInfo : kernelInfos) {	
        const std::string key = kernelInfo.key;
        const auto it = kernelNameMap_.find(key); // 如果已经注册，不重复注册
        if (it != kernelNameMap_.end()) {
            RT_LOG(RT_LOG_WARNING, "[%s] has been registered, continue", key.c_str());
            continue;
        }

        Kernel *kernel = new (std::nothrow) Kernel(nullptr, key.c_str(), defaultTilingKey, this, 0U, 0U);
        if (unlikely(kernel == nullptr)) {
            RT_LOG(RT_LOG_ERROR, "kernel new failed, continue");
            continue;
        }

        SetCpuKernelAttr(kernel, kernelInfo, key);

        void *funcPc = mmDlsym(binHandle_, key.c_str());
        if (unlikely(funcPc == nullptr)) {
            RT_LOG(RT_LOG_ERROR, "The func symbol[%s] cannot be found", key.c_str());
            DELETE_O(kernel);
            kernelMapLock_.Unlock();
            return RT_ERROR_INVALID_VALUE;
        }
        kernel->SetKernelLiteralNameDevAddr(nullptr, funcPc, 0U);

        kernelNameMap_[key] = kernel;
        RT_LOG(RT_LOG_DEBUG, "cpu kernel info: functionName[%s], kernelSo[%s], opType[%s]",
            kernel->GetCpuFuncName().c_str(), kernel->GetCpuKernelSo().c_str(), key.c_str());
    }

    kernelMapLock_.Unlock();
    return RT_ERROR_NONE;
}

}
}