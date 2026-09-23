/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_VMM_HPP
#define CCE_RUNTIME_API_VMM_HPP

#include <cstddef>
#include <cstdint>

#include "runtime/rt.h"
#include "runtime/rt_inner_mem.h"

namespace cce {
namespace runtime {

// Runtime VMM interface
class ApiVmm {
public:
    ApiVmm() = default;
    virtual ~ApiVmm() = default;

    ApiVmm(const ApiVmm&) = delete;
    ApiVmm& operator=(const ApiVmm&) = delete;
    ApiVmm(ApiVmm&&) = delete;
    ApiVmm& operator=(ApiVmm&&) = delete;

    // Get ApiVmm instance.
    static ApiVmm* Instance();

    virtual rtError_t ReserveMemAddress(
        void** devPtr, size_t size, size_t alignment, void* devAddr, uint64_t flags) = 0;
    virtual rtError_t ReleaseMemAddress(void* devPtr) = 0;
    virtual rtError_t MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags) = 0;
    virtual rtError_t FreePhysical(rtDrvMemHandle handle) = 0;
    virtual rtError_t MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags) = 0;
    virtual rtError_t UnmapMem(void* devPtr) = 0;
    virtual rtError_t MemMapNoAccess(
        void* virPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags) = 0;
    virtual rtError_t MemSetAccess(void* virPtr, size_t size, rtMemAccessDesc* desc, size_t count) = 0;
    virtual rtError_t MemGetAccess(void* virPtr, rtMemLocation* location, uint64_t* flags) = 0;
    virtual rtError_t ExportToShareableHandle(
        rtDrvMemHandle handle, rtDrvMemHandleType handleType, uint64_t flags, uint64_t* shareableHandle) = 0;
    virtual rtError_t ExportToShareableHandleV2(
        rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void* shareableHandle) = 0;
    virtual rtError_t ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle) = 0;
    virtual rtError_t ImportFromShareableHandleV2(
        const void* shareableHandle, rtMemSharedHandleType handleType, uint64_t flags, int32_t devId,
        rtDrvMemHandle* handle) = 0;
    virtual rtError_t SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum) = 0;
    virtual rtError_t SetPidToShareableHandleV2(
        const void* shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum) = 0;
    virtual rtError_t GetAllocationGranularity(
        rtDrvMemProp_t* prop, rtDrvMemGranularityOptions option, size_t* granularity) = 0;
    virtual rtError_t MemReserveAddress(
        void** virPtr, size_t size, rtMallocPolicy policy, void* expectAddr, rtMallocConfig_t* cfg) = 0;
    virtual rtError_t MemMallocPhysical(
        rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t* cfg) = 0;
    virtual rtError_t MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle* handle) = 0;
    virtual rtError_t MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop) = 0;
    virtual rtError_t MemGetAddressRange(void* ptr, void** pbase, size_t* psize) = 0;
    virtual rtError_t MemMapSelectedLink(void* virPtrDst, size_t size, void* virPtrSrc, uint32_t linkIdx) = 0;
    virtual rtError_t MemMapSetLink(rtDrvMemHandle handle, rtMemLinkType adviceLink) = 0;
};
} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_VMM_HPP
