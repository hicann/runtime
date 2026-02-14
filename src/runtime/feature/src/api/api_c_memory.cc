/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_c.h"
#include "api.hpp"
#include "osal.hpp"
#include "thread_local_container.hpp"
#include "global_state_manager.hpp"
using namespace cce::runtime;

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtMalloc);
TIMESTAMP_EXTERN(rtMallocHost);
TIMESTAMP_EXTERN(rtsMallocHost);
TIMESTAMP_EXTERN(rtFreeHost);
TIMESTAMP_EXTERN(rtsFreeHost);
TIMESTAMP_EXTERN(rtFlushCache);
TIMESTAMP_EXTERN(rtInvalidCache);
TIMESTAMP_EXTERN(rtsMemFlushCache);
TIMESTAMP_EXTERN(rtsMemInvalidCache);
TIMESTAMP_EXTERN(rtsHostRegister);
TIMESTAMP_EXTERN(rtHostRegisterV2);
TIMESTAMP_EXTERN(rtsHostUnregister);
TIMESTAMP_EXTERN(rtHostGetDevicePointer);
TIMESTAMP_EXTERN(rtHostMemMapCapabilities);
TIMESTAMP_EXTERN(rtsPointerGetAttributes);
TIMESTAMP_EXTERN(rtsMemcpy);
TIMESTAMP_EXTERN(rtsMemcpyBatch);
TIMESTAMP_EXTERN(rtsMemcpyBatchAsync);
TIMESTAMP_EXTERN(rtsMemcpyAsync);
TIMESTAMP_EXTERN(rtsSetMemcpyDesc);
TIMESTAMP_EXTERN(rtsMemcpyAsyncWithDesc);
TIMESTAMP_EXTERN(rtMemAlloc);
TIMESTAMP_EXTERN(rtsFree);
TIMESTAMP_EXTERN(rtsMemReserveAddress);
TIMESTAMP_EXTERN(rtsMemMallocPhysical);
}  // namespace runtime
}  // namespace cce

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtMalloc);

    const rtError_t error = apiInstance->DevMalloc(devPtr, size, type, moduleId);
    TIMESTAMP_END(rtMalloc);
    if (unlikely(error != RT_ERROR_NONE)) {
        return GetRtExtErrCodeAndSetGlobalErr((error));
    }
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemcpy2D(rtMemcpy2DParams_t *params, rtMemcpyConfig_t *config)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(params, RT_ERROR_INVALID_VALUE);
    if (config != nullptr) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(config, "nullptr");
        REPORT_FUNC_ERROR_REASON(RT_ERROR_INVALID_VALUE);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemCopy2DSync(params->dst, params->dstPitch,
        params->src, params->srcPitch, params->width, params->height, RT_MEMCPY_RESERVED, params->kind);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMallocHost(void **hostPtr, uint64_t size, const rtMallocConfig_t *cfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsMallocHost);

    const rtError_t error = apiInstance->HostMallocWithCfg(hostPtr, size, cfg);
    TIMESTAMP_END(rtsMallocHost);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMallocHost(void **hostPtr, uint64_t size, const uint16_t moduleId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMallocHost);

    const rtError_t error = apiInstance->HostMalloc(hostPtr, size, moduleId);
    TIMESTAMP_END(rtMallocHost);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemcpy2DAsync(rtMemcpy2DParams_t *params, rtMemcpyConfig_t *config, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(params, RT_ERROR_INVALID_VALUE);
    if (config != nullptr) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(config, "nullptr");
        REPORT_FUNC_ERROR_REASON(RT_ERROR_INVALID_VALUE);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);

    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemCopy2DAsync(params->dst, params->dstPitch, params->src,
        params->srcPitch, params->width, params->height, exeStream, RT_MEMCPY_RESERVED, params->kind);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsFreeHost(void *hostPtr)
{
    return rtFreeHost(hostPtr);
}

VISIBILITY_DEFAULT
rtError_t rtFreeHost(void *hostPtr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtFreeHost);
    const rtError_t error = apiInstance->HostFree(hostPtr);
    TIMESTAMP_END(rtFreeHost);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtFreeWithDevSync(void *devPtr)
{
    const rtError_t error = rtDeviceSynchronize();
    if (error != ACL_RT_SUCCESS) {
        RT_LOG(RT_LOG_ERROR, "rtFreeWithDevSync, device synchronize failed, result=%d",
            static_cast<int32_t>(error));
        return error;
    }
    return rtFree(devPtr);
}

VISIBILITY_DEFAULT
rtError_t rtFreeHostWithDevSync(void *hostPtr)
{
    const rtError_t error = rtDeviceSynchronize();
    if (error != ACL_RT_SUCCESS) {
        RT_LOG(RT_LOG_ERROR, "rtFreeHostWithDevSync, device synchronize failed, result=%d",
            static_cast<int32_t>(error));
        return error;
    }
    return rtFreeHost(hostPtr);
}

VISIBILITY_DEFAULT
rtError_t rtsMemFlushCache(void *base, size_t len)
{
    return rtFlushCache(base, len);
}

VISIBILITY_DEFAULT
rtError_t rtsMemInvalidCache(void *base, size_t len)
{
    return rtInvalidCache(base, len);
}

VISIBILITY_DEFAULT
rtError_t rtFlushCache(void *base, size_t len)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtFlushCache);
    const rtError_t error = apiInstance->FlushCache(RtPtrToValue(base), len);
    TIMESTAMP_END(rtFlushCache);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemGetInfo(rtMemInfoType memInfoType, size_t *freeSize, size_t *totalSize)
{
    return rtMemGetInfoEx(memInfoType, freeSize, totalSize);
}

VISIBILITY_DEFAULT
rtError_t rtInvalidCache(void *base, size_t len)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtInvalidCache);
    const rtError_t error = apiInstance->InvalidCache(RtPtrToValue(base), len);
    TIMESTAMP_END(rtInvalidCache);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsHostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsHostRegister);
    const rtError_t error = apiInstance->HostRegister(ptr, size, type, devPtr);
    TIMESTAMP_END(rtsHostRegister);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
VISIBILITY_DEFAULT
rtError_t rtHostMemMapCapabilities(uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability *capabilities)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtHostMemMapCapabilities);
    const rtError_t error = apiInstance->HostMemMapCapabilities(deviceId, hacType, capabilities);
    TIMESTAMP_END(rtHostMemMapCapabilities);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtHostRegisterV2);
    const rtError_t error = apiInstance->HostRegisterV2(ptr, size, flag);
    TIMESTAMP_END(rtHostRegisterV2);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtHostGetDevicePointer);
    const rtError_t error = apiInstance->HostGetDevicePointer(pHost, pDevice, flag);
    TIMESTAMP_END(rtHostGetDevicePointer);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsHostUnregister(void *ptr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsHostUnregister);
    const rtError_t error = apiInstance->HostUnregister(ptr);
    TIMESTAMP_END(rtsHostUnregister);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsPointerGetAttributes(const void *ptr, rtPtrAttributes_t *attributes)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsPointerGetAttributes);
    const rtError_t error = apiInstance->PtrGetAttributes(ptr, attributes);
    TIMESTAMP_END(rtsPointerGetAttributes);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t cnt,
                    rtMemcpyKind kind, rtMemcpyConfig_t *config)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsMemcpy);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->RtsMemcpy(dst, destMax, src, cnt, kind, config);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtsMemcpy);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemcpyAsync(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind kind,
                        rtMemcpyConfig_t *config, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    TIMESTAMP_BEGIN(rtsMemcpyAsync);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->RtsMemcpyAsync(dst, destMax, src, cnt, kind, config, exeStream);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtsMemcpyAsync);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetMemcpyDescSize(rtMemcpyKind kind, size_t *descSize)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!rtInstance->ChipIsHaveStars()) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) not support rtsGetMemcpyDescSize, return.",
            static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    if (kind != RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE) {
        RT_LOG(RT_LOG_WARNING, "Kind should be %u, but now is %u.", RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, kind);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(descSize, RT_ERROR_INVALID_VALUE);
    DevProperties properties;
    (void)GET_DEV_PROPERTIES(rtInstance->GetChipType(), properties);
    *descSize = properties.memcpyDescriptorSize;
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetMemcpyDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, void *srcAddr, void *dstAddr,
    size_t count, rtMemcpyConfig_t *config)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!rtInstance->ChipIsHaveStars()) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) not support rtsSetMemcpyDesc, return.",
            static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const api = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(api);
    TIMESTAMP_BEGIN(rtsSetMemcpyDesc);
    rtError_t error = api->SetMemcpyDesc(desc, srcAddr, dstAddr, count, kind, config);
    TIMESTAMP_END(rtsSetMemcpyDesc);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemcpyAsyncWithDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, rtMemcpyConfig_t *config, rtStream_t stream)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!rtInstance->ChipIsHaveStars()) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) not support rtsMemcpyAsyncWithDesc, return.",
            static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const api = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(api);
    Stream * const exeStream = static_cast<Stream *>(stream);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    TIMESTAMP_BEGIN(rtsMemcpyAsyncWithDesc);
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = api->MemcpyAsyncWithDesc(desc, exeStream, kind, config);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_BEGIN(rtsMemcpyAsyncWithDesc);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemAlloc(void **devPtr, uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, rtMallocConfig_t *cfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemAlloc);
    const rtError_t error = apiInstance->DevMalloc(devPtr, size, policy, advise, cfg);
    TIMESTAMP_END(rtMemAlloc);
    if (unlikely(error != RT_ERROR_NONE)) {
        return GetRtExtErrCodeAndSetGlobalErr((error));
    }
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMalloc(void **devPtr, uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, rtMallocConfig_t *cfg)
{
    return rtMemAlloc(devPtr, size, policy, advise, cfg);
}

VISIBILITY_DEFAULT
rtError_t rtsFree(void *devPtr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsFree);
    const rtError_t error = apiInstance->DevFree(devPtr);
    TIMESTAMP_END(rtsFree);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flags, uint64_t *shareableHandle)
{
    return rtMemExportToShareableHandle(handle, handleType, flags, shareableHandle);
}

VISIBILITY_DEFAULT
rtError_t rtsMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum)
{
    return rtMemSetPidToShareableHandle(shareableHandle, pid, pidNum);
}

VISIBILITY_DEFAULT
rtError_t rtsMemImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle *handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error =
        apiInstance->ImportFromShareableHandle(shareableHandle, devId, handle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ExportToShareableHandleV2(handle, handleType, flags, shareableHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemImportFromShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType,
    uint64_t flags, int32_t devId, rtDrvMemHandle *handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ImportFromShareableHandleV2(shareableHandle, handleType, flags, devId, handle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemSetPidToShareableHandleV2(
    const void *shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetPidToShareableHandleV2(shareableHandle, handleType, pid, pidNum);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemGetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option, size_t *granularity)
{
    return rtMemGetAllocationGranularity(prop, option, granularity);
}

VISIBILITY_DEFAULT
rtError_t rtsMemset(void *devPtr, uint64_t destMax, uint32_t val, uint64_t cnt)
{
    return rtMemset(devPtr, destMax, val, cnt);
}

VISIBILITY_DEFAULT
rtError_t rtsMemsetAsync(void *ptr, uint64_t destMax, uint32_t val, uint64_t cnt, rtStream_t stm)
{
    return rtMemsetAsync(ptr, destMax, val, cnt, static_cast<Stream *>(stm));
}

VISIBILITY_DEFAULT
rtError_t rtsEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    return rtEnableP2P(devIdDes, phyIdSrc, flag);
}

VISIBILITY_DEFAULT
rtError_t rtsDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc)
{
    return rtDisableP2P(devIdDes, phyIdSrc);
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceCanAccessPeer(uint32_t devId, uint32_t peerDevice, int32_t *canAccessPeer)
{
    return rtDeviceCanAccessPeer(canAccessPeer, devId, peerDevice);
}

VISIBILITY_DEFAULT
rtError_t rtsMemReserveAddress(void** virPtr, size_t size, rtMallocPolicy policy, void *expectAddr, rtMallocConfig_t *cfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsMemReserveAddress);
    const rtError_t error = apiInstance->MemReserveAddress(virPtr, size, policy, expectAddr, cfg);
    TIMESTAMP_END(rtsMemReserveAddress);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsValueWrite(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_VALUE_WAIT)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.",
               static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemWriteValue(devAddr, value, flag, static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsValueWait(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_VALUE_WAIT)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.",
               static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemWaitValue(devAddr, value, flag, static_cast<Stream *>(stm));
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
rtError_t rtsMemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t *cfg)
{
    Api *apiInstance = Api::Instance();
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
rtError_t rtsMemUnmap(void* virPtr)
{
    return rtUnmapMem(virPtr);
}

VISIBILITY_DEFAULT
rtError_t rtMemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemSetAccess(virPtr, size, desc, count);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemGetAccess(virPtr, location, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode cmoType, rtStream_t stm)
{
    return rtCmoAsync(srcAddrPtr, srcLen, cmoType, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsCmoAsyncWithBarrier(void *srcAddrPtr, size_t srcLen, rtCmoOpCode cmoType, uint32_t logicId, rtStream_t stm)
{    
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_ASYNC_CMO)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) don't support this function.",
               static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(srcAddrPtr, RT_ERROR_INVALID_VALUE);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM(srcLen == 0, RT_ERROR_INVALID_VALUE, srcLen, "greater than 0");
    
    // support prefetch, write back, invalid, flush
    // when invalid op, logicId must set >0, other ops logicId must set 0.
    switch (cmoType){
        case RT_CMO_INVALID:
            COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER(logicId == 0, RT_ERROR_INVALID_VALUE, ErrorCode::EE1001,
                "Parameter logicId is invalid. If parameter cmoType is equal to " + std::to_string(cmoType) + ", parameter logicId cannot be 0.");
            break;
        case RT_CMO_PREFETCH:
        case RT_CMO_WRITEBACK:
        case RT_CMO_FLUSH:
            COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER(logicId != 0, RT_ERROR_INVALID_VALUE, ErrorCode::EE1001,
                "Parameter logicId is invalid. If parameter cmoType is equal to " + std::to_string(cmoType) + ", the value of parameter logicId should be 0.");
            break;
        default:
            RT_LOG(RT_LOG_WARNING, "cmoType(%d) does not support, support[PREFETCH, WRITEBACK, INVALID, FLUSH]",
                static_cast<int32_t>(cmoType));
            return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    rtCmoTaskInfo_t taskInfo = {};
    taskInfo.opCode = cmoType;
    taskInfo.lengthInner = static_cast<int32_t>(srcLen);
    taskInfo.sourceAddr = RtPtrToValue(srcAddrPtr);
    taskInfo.logicId = logicId;

    return rtCmoTaskLaunch(&taskInfo, stm, 0);
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchBarrierTask(rtBarrierTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag)
{
    // only CHIP_MINI_V3, CHIP_AS31XM1 and cmoType=invalid support this function
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(taskInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((taskInfo->logicIdNum > RT_CMO_MAX_BARRIER_NUM || taskInfo->logicIdNum == 0), 
        RT_ERROR_INVALID_VALUE, taskInfo->logicIdNum, "[1, " + std::to_string(RT_CMO_MAX_BARRIER_NUM) + "]");
    // loop cmoInfo array to validate whether cmoType is 1(invalid) or not
    for (uint8_t i = 0; i < taskInfo->logicIdNum; i++) {
        auto cmoInfo = taskInfo->cmoInfo[i];
        // if cmoType!=invalid return error
        COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER(cmoInfo.cmoType != RT_CMO_INVALID, RT_ERROR_INVALID_VALUE,
            ErrorCode::EE1006, __func__, "taskInfo->cmoInfo[" + std::to_string(i) + "].cmoType=" + std::to_string(RT_CMO_INVALID));
        COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM(cmoInfo.logicId == 0, RT_ERROR_INVALID_VALUE, cmoInfo.logicId, "not equal to 0");
    }
    
    return rtBarrierTaskLaunch(taskInfo, stm, flag);
}

VISIBILITY_DEFAULT
rtError_t rtsMemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_MEMORY_BATCH_COPY)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support MemcpyBatch.",
            chipType);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtsMemcpyBatch);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemcpyBatch(dsts, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtsMemcpyBatch);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx, rtStream_t stream)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_MEMORY_BATCH_COPY)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support MemcpyBatchAsync.",
            chipType);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const streamPtr = static_cast<Stream *>(stream);
    TIMESTAMP_BEGIN(rtsMemcpyBatchAsync);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = 
        apiInstance->MemcpyBatchAsync(dsts, destMaxs, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, streamPtr);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtsMemcpyBatchAsync);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchCmoTask(rtCmoTaskCfg_t *taskCfg, rtStream_t stm, const void *reserve)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(taskCfg, RT_ERROR_INVALID_VALUE);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((reserve != nullptr), RT_ERROR_INVALID_VALUE, reserve, "nullptr");

    rtCmoTaskInfo_t taskInfo = {};
    taskInfo.qos = 6U; // to avoid the cross-chip D2D problem, set QoS to 6.
    taskInfo.partId = 0U;
    taskInfo.pmg = 0U;
    taskInfo.reserved = 0U;
    taskInfo.logicId = 0U;
    taskInfo.opCode = taskCfg->cmoType;
    taskInfo.numInner = taskCfg->numInner;
    taskInfo.numOuter = taskCfg->numOuter;
    taskInfo.lengthInner = taskCfg->lengthInner;
    taskInfo.sourceAddr = taskCfg->sourceAddr;
    taskInfo.striderOuter = taskCfg->striderOuter;
    taskInfo.striderInner = taskCfg->striderInner;
    switch (taskCfg->cmoType) {
        case RT_CMO_INVALID:
            taskInfo.cmoType = 1U; // Cmo Type: invalid is 1
            break;
        case RT_CMO_PREFETCH:
            taskInfo.cmoType = 2U; // Cmo Type: Prefetch is 2
            break;
        case RT_CMO_WRITEBACK:
            taskInfo.cmoType = 3U; // Cmo Type: Write_back is 3
            break;
        default:
            taskInfo.cmoType = 0U;
            break;
    }

    return rtCmoTaskLaunch(&taskInfo, stm, 0U);
}

VISIBILITY_DEFAULT
rtError_t rtsIpcMemGetExportKey(const void *ptr, size_t size, char_t *key, uint32_t len, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcSetMemoryName(ptr, static_cast<uint64_t>(size), key, len, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsIpcMemClose(const char_t *key)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);

    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) not support IpcMemClose.", chipType);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcCloseMemoryByName(key);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsIpcMemImportByKey(void **ptr, const char_t *key, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcOpenMemory(ptr, key, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsIpcMemSetImportPid(const char_t *key, int32_t pid[], int num)
{
    return rtSetIpcMemPid(key, pid, num);
}

VISIBILITY_DEFAULT
rtError_t rtsCheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->CheckMemType(addrs, size, memType, checkResult, reserve);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemRetainAllocationHandle(virPtr, handle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemGetAllocationPropertiesFromHandle(handle, prop);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetMemUsageInfo(uint32_t deviceId, rtMemUsageInfo_t *memUsageInfo, size_t inputNum, size_t *outputNum)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetMemUsageInfo(deviceId, memUsageInfo, inputNum, outputNum);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetAddressRange(void *ptr, void **pbase, size_t *psize)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemGetAddressRange(ptr, pbase, psize);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus