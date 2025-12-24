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
#include "rts/rts.h"
#include "global_state_manager.hpp"

using namespace cce::runtime;

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtLaunchDvppTask);
}  // namespace runtime
}  // namespace cce

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtDevBinaryRegister(const rtDevBinary_t *bin, void **hdl)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->DevBinaryRegister(bin, RtPtrToPtr<Program **>(hdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchKernelWithHostArgs(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm, rtKernelLaunchCfg_t *cfg,
    void *hostArgs, uint32_t argsSize, rtPlaceHolderInfo_t *placeHolderArray, uint32_t placeHolderNum)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(funcHandle, RT_ERROR_INVALID_VALUE);

    Kernel * const kernel = RtPtrToPtr<Kernel *>(funcHandle);
    const KernelRegisterType regType = kernel->GetKernelRegisterType();
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    RtArgsWithType argsWithType = {};
    rtArgsEx_t argsInfo = {};
    rtCpuKernelArgs_t cpuArgsInfo = {};
    if (regType == RT_KERNEL_REG_TYPE_NON_CPU) {
        argsInfo.args = hostArgs;
        argsInfo.argsSize = argsSize;
        argsInfo.hostInputInfoPtr = RtPtrToPtr<rtHostInputInfo_t *>(placeHolderArray);
        argsInfo.hostInputInfoNum = placeHolderNum;
        argsInfo.isNoNeedH2DCopy = 0U;

        argsWithType.type = RT_ARGS_NON_CPU_EX;
        argsWithType.args.nonCpuArgsInfo = &argsInfo;
    } else {
        cpuArgsInfo.baseArgs.args = hostArgs;
        cpuArgsInfo.baseArgs.argsSize = argsSize;
        cpuArgsInfo.baseArgs.hostInputInfoPtr = RtPtrToPtr<rtHostInputInfo_t *>(placeHolderArray);
        cpuArgsInfo.baseArgs.hostInputInfoNum = placeHolderNum;
        cpuArgsInfo.baseArgs.isNoNeedH2DCopy = 0;

        argsWithType.type = RT_ARGS_CPU_EX;
        argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    }

    const rtError_t ret = apiInstance->LaunchKernelV2(kernel, blockDim, &argsWithType,
        RtPtrToPtr<Stream *>(stm), cfg);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchCpuKernel(const rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
    const rtKernelLaunchCfg_t *cfg, rtCpuKernelArgs_t *argsInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(funcHandle, RT_ERROR_INVALID_VALUE);

    Kernel * const kernel = RtPtrToPtr<Kernel *>(funcHandle);
    const KernelRegisterType regType = kernel->GetKernelRegisterType();
    COND_RETURN_ERROR_WITH_EXT_ERRCODE(regType != RT_KERNEL_REG_TYPE_CPU, RT_ERROR_INVALID_VALUE,
        "current api only support cpu kernel");

    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    RtArgsWithType argsWithType = {};
    argsWithType.type = RT_ARGS_CPU_EX;
    argsWithType.args.cpuArgsInfo = argsInfo;
    const rtError_t ret = apiInstance->LaunchKernelV2(kernel, blockDim, &argsWithType,
        RtPtrToPtr<Stream *>(stm), cfg);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchKernelWithConfig(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm, rtKernelLaunchCfg_t *cfg,
    rtArgsHandle argsHandle, void* reserve)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((reserve != nullptr), RT_ERROR_INVALID_VALUE, "reserve only support nullptr.");
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    RtArgsWithType argsWithType = {};
    argsWithType.type = RT_ARGS_HANDLE;
    argsWithType.args.argHandle = RtPtrToPtr<RtArgsHandle *>(argsHandle);
    const rtError_t ret = apiInstance->LaunchKernelV2(RtPtrToPtr<Kernel *>(funcHandle), blockDim, &argsWithType,
        static_cast<Stream *>(stm), cfg);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchKernelWithDevArgs(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm, rtKernelLaunchCfg_t *cfg,
                                     const void *args, uint32_t argsSize, void *reserve)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((reserve != nullptr), RT_ERROR_INVALID_VALUE, "reserve only support nullptr.");
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(funcHandle, RT_ERROR_INVALID_VALUE);

    Kernel * const kernel = RtPtrToPtr<Kernel *>(funcHandle);
    const KernelRegisterType regType = kernel->GetKernelRegisterType();
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);

    RtArgsWithType argsWithType = {};
    rtArgsEx_t argsInfo = {};
    rtCpuKernelArgs_t cpuArgsInfo = {};
    if (regType == RT_KERNEL_REG_TYPE_NON_CPU) {
        argsInfo.args = RtPtrToUnConstPtr<void *>(args);
        argsInfo.argsSize = argsSize;
        argsInfo.isNoNeedH2DCopy = 1;
        argsWithType.type = RT_ARGS_NON_CPU_EX;
        argsWithType.args.nonCpuArgsInfo = &argsInfo;
    } else {
        cpuArgsInfo.baseArgs.args = RtPtrToUnConstPtr<void *>(args);
        cpuArgsInfo.baseArgs.argsSize = argsSize;
        cpuArgsInfo.baseArgs.isNoNeedH2DCopy = 1;
        argsWithType.type = RT_ARGS_CPU_EX;
        argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    }

    const rtError_t ret = apiInstance->LaunchKernelV2(RtPtrToPtr<Kernel *>(funcHandle), blockDim, &argsWithType,
        static_cast<Stream *>(stm), cfg);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchDvppTask(const void *sqe, uint32_t sqeLen, rtStream_t stm, rtDvppCfg_t *cfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);

    const rtChipType_t chipType = rtInstance->GetChipType();
    const bool isNotSupport = !IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_DVPP);
    COND_RETURN_WARN(isNotSupport, ACL_ERROR_RT_FEATURE_NOT_SUPPORT,
        "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtLaunchDvppTask);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);

    const rtError_t error = apiInstance->LaunchDvppTask(sqe, sqeLen, RtPtrToPtr<Stream *>(stm), cfg);

    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtLaunchDvppTask);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, const rtStream_t stm, void *reserve)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    COND_RETURN_WARN(!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_RAND_GENERATOR),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->LaunchRandomNumTask(taskInfo, static_cast<Stream *>(stm), reserve);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsNpuClearFloatOverFlowStatus(uint32_t checkMode, rtStream_t stm)
{
    return rtNpuClearFloatStatus(checkMode, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsNpuGetFloatOverFlowStatus(void *outputAddrPtr, uint64_t outputSize, uint32_t checkMode, rtStream_t stm)
{
    return rtNpuGetFloatStatus(outputAddrPtr, outputSize, checkMode, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsNpuGetFloatOverFlowDebugStatus(void *outputAddrPtr, uint64_t outputSize, uint32_t checkMode, rtStream_t stm)
{
    return rtNpuGetFloatDebugStatus(outputAddrPtr, outputSize, checkMode, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsNpuClearFloatOverFlowDebugStatus(uint32_t checkMode, rtStream_t stm)
{
    return rtNpuClearFloatDebugStatus(checkMode, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsKernelArgsInit(rtFuncHandle funcHandle, rtArgsHandle *argsHandle)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->KernelArgsInit(RtPtrToPtr<Kernel *>(funcHandle),
        RtPtrToPtr<RtArgsHandle **>(argsHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsKernelArgsAppend(rtArgsHandle argsHandle, void *para, size_t paraSize, rtParaHandle *paraHandle)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->KernelArgsAppend(RtPtrToPtr<RtArgsHandle *>(argsHandle), para, paraSize,
        RtPtrToPtr<ParaDetail **>(paraHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsKernelArgsAppendPlaceHolder(rtArgsHandle argsHandle, rtParaHandle *paraHandle)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->KernelArgsAppendPlaceHolder(RtPtrToPtr<RtArgsHandle *>(argsHandle),
        RtPtrToPtr<ParaDetail **>(paraHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsKernelArgsGetPlaceHolderBuffer(rtArgsHandle argsHandle, rtParaHandle paraHandle, size_t dataSize, void **bufferAddr)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->KernelArgsGetPlaceHolderBuffer(RtPtrToPtr<RtArgsHandle *>(argsHandle),
        RtPtrToPtr<ParaDetail *>(paraHandle), dataSize, bufferAddr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsKernelArgsGetHandleMemSize(rtFuncHandle funcHandle, size_t *memSize)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->KernelArgsGetHandleMemSize(RtPtrToPtr<Kernel *>(funcHandle),
        memSize);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsKernelArgsGetMemSize(rtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->KernelArgsGetMemSize(RtPtrToPtr<Kernel *>(funcHandle),
        userArgsSize, actualArgsSize);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsKernelArgsInitByUserMem(rtFuncHandle funcHandle, rtArgsHandle argsHandle, void *userHostMem, size_t actualArgsSize)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->KernelArgsInitByUserMem(RtPtrToPtr<Kernel *>(funcHandle),
        RtPtrToPtr<RtArgsHandle *>(argsHandle), userHostMem, actualArgsSize);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsKernelArgsParaUpdate(rtArgsHandle argsHandle, rtParaHandle paraHandle, void *para, size_t paraSize)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(argsHandle, RT_ERROR_INVALID_VALUE);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(paraHandle, RT_ERROR_INVALID_VALUE);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(para, RT_ERROR_INVALID_VALUE);

    RtArgsHandle *handle = RtPtrToPtr<RtArgsHandle *>(argsHandle);
    ParaDetail *pHandle = RtPtrToPtr<ParaDetail *>(paraHandle);
    // 0 is Common param, 1 is place holder param
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((pHandle->type != 0U) || (pHandle->paraSize != paraSize),
        RT_ERROR_INVALID_VALUE, "invalid param, paraHandle type is %u, dest paraSize is %zu, input paraSize is %zu",
        pHandle->type, pHandle->paraSize, paraSize);

    const uint64_t offset = RtPtrToValue(handle->buffer) + pHandle->paraOffset;
    const errno_t ret = memcpy_s(RtValueToPtr<void *>(offset), paraSize, para, paraSize);
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((ret != EOK),
        RT_ERROR_INVALID_VALUE, "args para update, memcpy failed, retCode=%#x", static_cast<uint32_t>(ret));
    handle->isParamUpdating = 1U;

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsKernelArgsFinalize(rtArgsHandle argsHandle)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->KernelArgsFinalize(RtPtrToPtr<RtArgsHandle *>(argsHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsBinaryLoadFromFile(const char_t * const binPath, const rtLoadBinaryConfig_t * const optionalCfg,
                                rtBinHandle *handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryLoadFromFile(binPath, optionalCfg, RtPtrToPtr<Program **>(handle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsBinaryLoadFromData(const void * const data, const uint64_t length,
                                const rtLoadBinaryConfig_t * const optionalCfg, rtBinHandle *handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryLoadFromData(data, length, optionalCfg,
        RtPtrToPtr<Program **>(handle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsBinaryUnload(const rtBinHandle binHandle)
{
    return rtBinaryUnLoad(binHandle);
}

VISIBILITY_DEFAULT
rtError_t rtsFuncGetByName(const rtBinHandle binHandle, const char_t *kernelName, rtFuncHandle *funcHandle)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryGetFunctionByName(RtPtrToPtr<Program *>(binHandle),
                                                               kernelName,
                                                               RtPtrToPtr<Kernel **>(funcHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsFuncGetByEntry(const rtBinHandle binHandle, const uint64_t funcEntry, rtFuncHandle *funcHandle)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryGetFunctionByEntry(RtPtrToPtr<Program *>(binHandle),
                                                                funcEntry,
                                                                RtPtrToPtr<Kernel **>(funcHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsFuncGetAddr(const rtFuncHandle funcHandle, void **aicAddr, void **aivAddr)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->FuncGetAddr(RtPtrToPtr<Kernel *>(funcHandle), aicAddr, aivAddr);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsRegisterCpuFunc(
    rtBinHandle binHandle, const char_t *const funcName, const char_t *const kernelName, rtFuncHandle *funcHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->RegisterCpuFunc(binHandle, funcName, kernelName, funcHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsRegKernelLaunchFillFunc(const char_t *symbol, rtKernelLaunchFillFunc callback)
{
    return rtRegKernelLaunchFillFunc(symbol, callback);
}

VISIBILITY_DEFAULT
rtError_t rtsUnRegKernelLaunchFillFunc(const char_t *symbol)
{
    return rtUnRegKernelLaunchFillFunc(symbol);
}

VISIBILITY_DEFAULT
rtError_t rtsGetNonCacheAddrOffset(uint32_t deviceId, uint64_t *offset)
{
    return rtGetL2CacheOffset(deviceId, offset);
}

VISIBILITY_DEFAULT
rtError_t rtsFuncGetName(const rtFuncHandle funcHandle, const uint32_t maxLen, char_t * const name)
{
    Api * const apiInstance = Api::Instance();
    NULL_PTR_RETURN_NOLOG(apiInstance, ACL_ERROR_RT_INTERNAL_ERROR);
    const rtError_t ret = apiInstance->FuncGetName(RtPtrToPtr<Kernel *>(funcHandle), maxLen, name);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetHardwareSyncAddr(void **addr)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(addr, RT_ERROR_INVALID_VALUE);
    uint32_t len;
    uint64_t c2cAddr;
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_KERNEL_INTER_CORE_SYNC_ADDR)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    const rtError_t ret = apiInstance->GetC2cCtrlAddr(&c2cAddr, &len);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    *addr = RtValueToPtr<void*>(c2cAddr);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus