/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_HOST_MEMORY_HPP
#define CCE_RUNTIME_API_HOST_MEMORY_HPP

#include <cstdint>

#include "internal_error_define.hpp"
#include "runtime/rt.h"
#include "runtime/rt_inner_mem.h"

namespace cce {
namespace runtime {

class ApiHostMemory {
public:
    ApiHostMemory() = default;
    virtual ~ApiHostMemory() = default;

    ApiHostMemory(const ApiHostMemory&) = delete;
    ApiHostMemory& operator=(const ApiHostMemory&) = delete;
    ApiHostMemory(ApiHostMemory&&) = delete;
    ApiHostMemory& operator=(ApiHostMemory&&) = delete;

    static ApiHostMemory* Instance();

    virtual rtError_t HostMalloc(
        void** const hostPtr, const uint64_t size, const uint16_t moduleId = MODULEID_RUNTIME) = 0;
    virtual rtError_t HostMallocWithCfg(
        void** const hostPtr, const uint64_t size, const rtMallocConfig_t* cfg = nullptr) = 0;
    virtual rtError_t HostFree(void* const hostPtr) = 0;
    virtual rtError_t MallocHostSharedMemory(
        rtMallocHostSharedMemoryIn* const in, rtMallocHostSharedMemoryOut* const out) = 0;
    virtual rtError_t FreeHostSharedMemory(rtFreeHostSharedMemoryIn* const in) = 0;
    virtual rtError_t HostRegister(void* ptr, uint64_t size, rtHostRegisterType type, void** devPtr) = 0;
    virtual rtError_t HostRegisterV2(void* ptr, uint64_t size, uint32_t flag) = 0;
    virtual rtError_t HostUnregister(void* ptr) = 0;
    virtual rtError_t HostGetDevicePointer(void* pHost, void** pDevice, uint32_t flag) = 0;
    virtual rtError_t HostGetDevicePointerAddrRange(rtAddrRange* addrRange, uint32_t* count) = 0;
    virtual rtError_t HostMemMapCapabilities(
        uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability* capabilities) = 0;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_HOST_MEMORY_HPP
