/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_IMPL_HOST_MEMORY_HPP
#define CCE_RUNTIME_API_IMPL_HOST_MEMORY_HPP

#include "api_host_memory.hpp"

namespace cce {
namespace runtime {

class ApiImplHostMemory : public ApiHostMemory {
public:
    rtError_t HostMalloc(
        void** const hostPtr, const uint64_t size, const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t HostMallocWithCfg(
        void** const hostPtr, const uint64_t size, const rtMallocConfig_t* cfg = nullptr) override;
    rtError_t HostFree(void* const hostPtr) override;
    rtError_t MallocHostSharedMemory(
        rtMallocHostSharedMemoryIn* const in, rtMallocHostSharedMemoryOut* const out) override;
    rtError_t FreeHostSharedMemory(rtFreeHostSharedMemoryIn* const in) override;
    rtError_t HostRegister(void* ptr, uint64_t size, rtHostRegisterType type, void** devPtr) override;
    rtError_t HostRegisterV2(void* ptr, uint64_t size, uint32_t flag) override;
    rtError_t HostUnregister(void* ptr) override;
    rtError_t HostGetDevicePointer(void* pHost, void** pDevice, uint32_t flag) override;
    rtError_t HostGetDevicePointerAddrRange(rtAddrRange* addrRange, uint32_t* count) override;
    rtError_t HostMemMapCapabilities(
        uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability* capabilities) override;

private:
    void CheckMallocHostCfg(uint16_t* moduleId) const;
    rtError_t GetMallocHostConfigAttr(rtMallocAttribute_t* attr, uint16_t* moduleId, uint32_t* vaFlag) const;
    rtError_t GetMallocHostConfigInfo(const rtMallocConfig_t* cfg, uint16_t* moduleId, uint32_t* vaFlag) const;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_IMPL_HOST_MEMORY_HPP
