/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_c.h"
#include "api_vmm.hpp"
#include "global_state_manager.hpp"

using namespace cce::runtime;

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtsMemReserveAddress);
TIMESTAMP_EXTERN(rtsMemMallocPhysical);
} // namespace runtime
} // namespace cce

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtReserveMemAddress(void** devPtr, size_t size, size_t alignment, void* devAddr, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ReserveMemAddress(devPtr, size, alignment, devAddr, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtReleaseMemAddress(void* devPtr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ReleaseMemAddress(devPtr);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MallocPhysical(handle, size, prop, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    if (unlikely(error != RT_ERROR_NONE)) {
        return GetRtExtErrCodeAndSetGlobalErr(error);
    }
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtFreePhysical(rtDrvMemHandle handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->FreePhysical(handle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MapMem(devPtr, size, offset, handle, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtUnmapMem(void* devPtr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->UnmapMem(devPtr);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemMapNoAccess(void* virPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemMapNoAccess(virPtr, size, offset, handle, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemExportToShareableHandle(
    rtDrvMemHandle handle, rtDrvMemHandleType handleType, uint64_t flags, uint64_t* shareableHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ExportToShareableHandle(handle, handleType, flags, shareableHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemExportToShareableHandle(
    rtDrvMemHandle handle, rtDrvMemHandleType handleType, uint64_t flags, uint64_t* shareableHandle)
{
    return rtMemExportToShareableHandle(handle, handleType, flags, shareableHandle);
}

VISIBILITY_DEFAULT
rtError_t rtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ImportFromShareableHandle(shareableHandle, devId, handle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ImportFromShareableHandle(shareableHandle, devId, handle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetPidToShareableHandle(shareableHandle, pid, pidNum);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum)
{
    return rtMemSetPidToShareableHandle(shareableHandle, pid, pidNum);
}

VISIBILITY_DEFAULT
rtError_t rtMemGetAllocationGranularity(rtDrvMemProp_t* prop, rtDrvMemGranularityOptions option, size_t* granularity)
{
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetAllocationGranularity(prop, option, granularity);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemGetAllocationGranularity(rtDrvMemProp_t* prop, rtDrvMemGranularityOptions option, size_t* granularity)
{
    return rtMemGetAllocationGranularity(prop, option, granularity);
}

VISIBILITY_DEFAULT
rtError_t rtMemExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void* shareableHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ExportToShareableHandleV2(handle, handleType, flags, shareableHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemImportFromShareableHandleV2(
    const void* shareableHandle, rtMemSharedHandleType handleType, uint64_t flags, int32_t devId,
    rtDrvMemHandle* handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ImportFromShareableHandleV2(shareableHandle, handleType, flags, devId, handle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemSetPidToShareableHandleV2(
    const void* shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetPidToShareableHandleV2(shareableHandle, handleType, pid, pidNum);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemReserveAddress(
    void** virPtr, size_t size, rtMallocPolicy policy, void* expectAddr, rtMallocConfig_t* cfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsMemReserveAddress);
    const rtError_t error = apiInstance->MemReserveAddress(virPtr, size, policy, expectAddr, cfg);
    TIMESTAMP_END(rtsMemReserveAddress);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemFreeAddress(void** virPtr)
{
    if (virPtr == nullptr) {
        return rtReleaseMemAddress(nullptr);
    }
    return rtReleaseMemAddress(*virPtr);
}

VISIBILITY_DEFAULT
rtError_t rtsMemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t* cfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsMemMallocPhysical);
    const rtError_t error = apiInstance->MemMallocPhysical(handle, size, policy, cfg);
    TIMESTAMP_END(rtsMemMallocPhysical);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemFreePhysical(rtMemHandle* handle)
{
    if (handle == nullptr) {
        return rtFreePhysical(nullptr);
    }
    return rtFreePhysical(RtPtrToPtr<rtDrvMemHandle>(*handle));
}

VISIBILITY_DEFAULT
rtError_t rtsMemMap(void* virPtr, size_t size, size_t offset, rtMemHandle handle, uint64_t flags)
{
    return rtMapMem(virPtr, size, offset, RtPtrToPtr<rtDrvMemHandle>(handle), flags);
}

VISIBILITY_DEFAULT
rtError_t rtsMemUnmap(void* virPtr) { return rtUnmapMem(virPtr); }

VISIBILITY_DEFAULT
rtError_t rtMemSetAccess(void* virPtr, size_t size, rtMemAccessDesc* desc, size_t count)
{
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemSetAccess(virPtr, size, desc, count);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetAccess(void* virPtr, rtMemLocation* location, uint64_t* flags)
{
    ApiVmm* apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemGetAccess(virPtr, location, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemRetainAllocationHandle(void* virPtr, rtDrvMemHandle* handle)
{
    ApiVmm* const apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemRetainAllocationHandle(virPtr, handle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop)
{
    ApiVmm* const apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemGetAllocationPropertiesFromHandle(handle, prop);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetAddressRange(void* ptr, void** pbase, size_t* psize)
{
    ApiVmm* const apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemGetAddressRange(ptr, pbase, psize);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtMemMapSelectedLink(void* virPtrDst, size_t size, void* virPtrSrc, uint32_t linkIdx)
{
    ApiVmm* const apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemMapSelectedLink(virPtrDst, size, virPtrSrc, linkIdx);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtMemMapSetLink(rtDrvMemHandle handle, rtMemLinkType adviceLink)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiVmm* const apiInstance = ApiVmm::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemMapSetLink(handle, adviceLink);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_LINK_TYPE_NOT_SUPPORTED, ACL_ERROR_RT_LINK_TYPE_NOT_SUPPORTED);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
#ifdef __cplusplus
}
#endif // __cplusplus
