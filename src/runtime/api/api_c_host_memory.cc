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
#include "api_host_memory.hpp"
#include "base.hpp"
#include "global_state_manager.hpp"

using namespace cce::runtime;

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtMallocHost);
TIMESTAMP_EXTERN(rtsMallocHost);
TIMESTAMP_EXTERN(rtFreeHost);
TIMESTAMP_EXTERN(rtsFreeHost);
TIMESTAMP_EXTERN(rtsHostRegister);
TIMESTAMP_EXTERN(rtHostRegisterV2);
TIMESTAMP_EXTERN(rtsHostUnregister);
TIMESTAMP_EXTERN(rtHostGetDevicePointer);
TIMESTAMP_EXTERN(rtHostMemMapCapabilities);
TIMESTAMP_EXTERN(rtMallocHostSharedMemory);
TIMESTAMP_EXTERN(rtFreeHostSharedMemory);
} // namespace runtime
} // namespace cce

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtsMallocHost(void** hostPtr, uint64_t size, const rtMallocConfig_t* cfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsMallocHost);

    const rtError_t error = apiInstance->HostMallocWithCfg(hostPtr, size, cfg);
    TIMESTAMP_END(rtsMallocHost);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMallocHost(void** hostPtr, uint64_t size, const uint16_t moduleId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMallocHost);

    const rtError_t error = apiInstance->HostMalloc(hostPtr, size, moduleId);
    TIMESTAMP_END(rtMallocHost);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsFreeHost(void* hostPtr) { return rtFreeHost(hostPtr); }

VISIBILITY_DEFAULT
rtError_t rtFreeHost(void* hostPtr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtFreeHost);
    const rtError_t error = apiInstance->HostFree(hostPtr);
    TIMESTAMP_END(rtFreeHost);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtFreeHostWithDevSync(void* hostPtr)
{
    const rtError_t error = rtDeviceSynchronize();
    if (error != ACL_RT_SUCCESS) {
        RT_LOG(RT_LOG_ERROR, "Device synchronize failed, result=%d", static_cast<int32_t>(error));
        return error;
    }
    return rtFreeHost(hostPtr);
}

VISIBILITY_DEFAULT
rtError_t rtsHostRegister(void* ptr, uint64_t size, rtHostRegisterType type, void** devPtr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsHostRegister);
    const rtError_t error = apiInstance->HostRegister(ptr, size, type, devPtr);
    TIMESTAMP_END(rtsHostRegister);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHostMemMapCapabilities(uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability* capabilities)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtHostMemMapCapabilities);
    const rtError_t error = apiInstance->HostMemMapCapabilities(deviceId, hacType, capabilities);
    TIMESTAMP_END(rtHostMemMapCapabilities);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHostRegisterV2(void* ptr, uint64_t size, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtHostRegisterV2);
    const rtError_t error = apiInstance->HostRegisterV2(ptr, size, flag);
    TIMESTAMP_END(rtHostRegisterV2);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHostGetDevicePointer(void* pHost, void** pDevice, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtHostGetDevicePointer);
    const rtError_t error = apiInstance->HostGetDevicePointer(pHost, pDevice, flag);
    TIMESTAMP_END(rtHostGetDevicePointer);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsHostUnregister(void* ptr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsHostUnregister);
    const rtError_t error = apiInstance->HostUnregister(ptr);
    TIMESTAMP_END(rtsHostUnregister);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMallocHostSharedMemory(rtMallocHostSharedMemoryIn* in, rtMallocHostSharedMemoryOut* out)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMallocHostSharedMemory);
    const rtError_t error = apiInstance->MallocHostSharedMemory(in, out);
    TIMESTAMP_END(rtMallocHostSharedMemory);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtFreeHostSharedMemory(rtFreeHostSharedMemoryIn* in)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtFreeHostSharedMemory);
    const rtError_t error = apiInstance->FreeHostSharedMemory(in);
    TIMESTAMP_END(rtFreeHostSharedMemory);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHostGetDevicePointerAddrRange(rtAddrRange* addrRange, uint32_t* count)
{
    ApiHostMemory* const apiInstance = ApiHostMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->HostGetDevicePointerAddrRange(addrRange, count);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
