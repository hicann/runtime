/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_IMPL_SOMA_HPP
#define CCE_RUNTIME_API_IMPL_SOMA_HPP
 
#include "api_soma.hpp"
 
namespace cce {
namespace runtime {
 
// Runtime ApiSoma implement
class ApiImplSoma : public ApiSoma {
public:
    // Soma Impl API
    rtError_t StreamMemPoolCreate(rtMemPool_t* memPool, const rtMemPoolProps* poolProps) override;
    rtError_t StreamMemPoolDestroy(const rtMemPool_t memPool) override;
    rtError_t StreamMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void* value) override;
    rtError_t StreamMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void* value) override;
    rtError_t MemPoolMallocAsync(void** const devPtr, const uint64_t size, const rtMemPool_t memPoolId, Stream* const stm) override;
    rtError_t MemPoolFreeAsync(void* const ptr, Stream* const stm) override;
    rtError_t SomaAicpuKernelLaunch(const char *kernelName, const uint64_t size, const uint64_t va,
 	    const rtMemPool_t memPool, Stream * const stm, const int32_t opType, const int32_t subCmd);
 	rtError_t SomaAicpuLaunchValidation(const rtKernelLaunchNames_t * const launchNames, const uint32_t blockDim,
 	    const rtArgsEx_t * const argsInfo, const Stream * const stm, const uint32_t flags) const;
};
}  // namespace runtime
}  // namespace cce
 
 
#endif  // CCE_RUNTIME_API_IMPL_SOMA_HPP