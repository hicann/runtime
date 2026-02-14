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
#include "base.hpp"
#include "prof_ctrl_callback_manager.hpp"
#include "config.hpp"
#include "error_message_manage.hpp"
#include "errcode_manage.hpp"
#include "error_code.h"
#include "dvpp_grp.hpp"
#include "inner.hpp"
#include "osal.hpp"
#include "prof_map_ge_model_device.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "toolchain/prof_api.h"
#include "prof_acl_api.h"
#include "heterogenous.h"
#include "runtime_keeper.h"
#include "global_state_manager.hpp"

using namespace cce::runtime;

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtKernelLaunch);
TIMESTAMP_EXTERN(rtKernelLaunchWithFlagV2);
TIMESTAMP_EXTERN(rtKernelConfigTransArg);
TIMESTAMP_EXTERN(rtEventCreate);
TIMESTAMP_EXTERN(rtEventDestroy);
TIMESTAMP_EXTERN(rtEventDestroySync);
TIMESTAMP_EXTERN(rtEventRecord);
TIMESTAMP_EXTERN(rtEventReset);
TIMESTAMP_EXTERN(rtEventSynchronize);
TIMESTAMP_EXTERN(rtEventSynchronizeWithTimeout);
TIMESTAMP_EXTERN(rtFree_drvMemUnLock_drvMemFreeManaged);
TIMESTAMP_EXTERN(rtDvppMalloc);
TIMESTAMP_EXTERN(rtDvppFree);
TIMESTAMP_EXTERN(rtDvppMallocWithFlag);
TIMESTAMP_EXTERN(rtMallocHostSharedMemory);
TIMESTAMP_EXTERN(rtFreeHostSharedMemory);
TIMESTAMP_EXTERN(rtMemAllocManaged);
TIMESTAMP_EXTERN(rtMemFreeManaged);
TIMESTAMP_EXTERN(rtMemset);
TIMESTAMP_EXTERN(rtMemsetAsync);
TIMESTAMP_EXTERN(rtMemGetInfo);
TIMESTAMP_EXTERN(rtMemGetInfoByType);
TIMESTAMP_EXTERN(rtMemGetInfoEx);
TIMESTAMP_EXTERN(rtPointerGetAttributes);
TIMESTAMP_EXTERN(rtMemPrefetchToDevice);
TIMESTAMP_EXTERN(rtMallocCached);
TIMESTAMP_EXTERN(rtMemcpy);
TIMESTAMP_EXTERN(rtMemcpyEx);
TIMESTAMP_EXTERN(rtMemcpyAsync);
TIMESTAMP_EXTERN(rtMemcpyAsyncV2);
TIMESTAMP_EXTERN(rtMemcpyAsyncWithoutCheckKind);
TIMESTAMP_EXTERN(rtMemcpyAsyncEx);
TIMESTAMP_EXTERN(rtMemcpy2D);
TIMESTAMP_EXTERN(rtMemcpy2DAsync);
TIMESTAMP_EXTERN(rtStarsTaskLaunch);
TIMESTAMP_EXTERN(rtStarsTaskLaunchWithFlag);
TIMESTAMP_EXTERN(rtKernelLaunchWithHandle);
TIMESTAMP_EXTERN(rtKernelLaunchWithHandleV2);
TIMESTAMP_EXTERN(rtNpuGetFloatDebugStatus);
TIMESTAMP_EXTERN(rtNpuClearFloatDebugStatus);
TIMESTAMP_EXTERN(rtDvppGroupCreate);
TIMESTAMP_EXTERN(rtDvppGroupDestory);
TIMESTAMP_EXTERN(rtDvppWaitGroupReport);
TIMESTAMP_EXTERN(rtCalcLaunchArgsSize);
TIMESTAMP_EXTERN(rtAppendLaunchAddrInfo);
TIMESTAMP_EXTERN(rtAppendLaunchHostInfo);
TIMESTAMP_EXTERN(rtNotifyCreate);
TIMESTAMP_EXTERN(rtNotifyCreateWithFlag);
TIMESTAMP_EXTERN(rtNotifyDestroy);
TIMESTAMP_EXTERN(rtGetServerIDBySDID);
TIMESTAMP_EXTERN(rtMemcpyAsyncWithCfg);
}  // namespace runtime
}  // namespace cce

namespace {
    std::array<std::atomic<int64_t>, SYS_OPT_RESERVED> sysParamOpt_ = {};
}

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
VISIBILITY_DEFAULT
rtError_t rtGetNotifyAddress(rtNotify_t notify, uint64_t * const notifyAddres)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Notify * const notifyPtr = static_cast<Notify *>(notify);
    const rtError_t ret = apiInstance->GetNotifyAddress(notifyPtr, notifyAddres);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}
VISIBILITY_DEFAULT
rtError_t rtRegisterAllKernel(const rtDevBinary_t *bin, void **hdl)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->RegisterAllKernel(bin, RtPtrToPtr<Program **>(hdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBinaryRegisterToFastMemory(void *hdl)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Program * const prog = static_cast<Program *>(hdl);
    const rtError_t ret = apiInstance->BinaryRegisterToFastMemory(prog);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDevBinaryUnRegister(void *hdl)
{
    Program * const prog = static_cast<Program *>(hdl);
    if (IsRuntimeKeeperExiting()) {
        RT_LOG(RT_LOG_WARNING, "runtime is exited");
        return ACL_RT_SUCCESS;
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->DevBinaryUnRegister(prog);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMetadataRegister(void *hdl, const char_t *metadata)
{
    Program * const prog = static_cast<Program *>(hdl);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->MetadataRegister(prog, metadata);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDependencyRegister(void *mHandle, void *sHandle)
{
    Program * const mProgram = static_cast<Program *>(mHandle);
    Program * const sProgram = static_cast<Program *>(sHandle);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t ret = apiInstance->DependencyRegister(mProgram, sProgram);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtFunctionRegister(void *binHandle, const void *stubFunc, const char_t *stubName, const void *kernelInfoExt,
                             uint32_t funcMode)
{
    Program * const prog = static_cast<Program *>(binHandle);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->FunctionRegister(prog, stubFunc, stubName, kernelInfoExt, funcMode);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_KERNEL_DUPLICATE, ACL_ERROR_RT_KERNEL_DUPLICATE);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetFunctionByName(const char_t *stubName, void **stubFunc)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->GetFunctionByName(stubName, stubFunc);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetAddrByFun(const void *stubFunc, void **addr)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->GetAddrByFun(stubFunc, addr);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetAddrAndPrefCntWithHandle(void *hdl, const void *kernelInfoExt, void **addr, uint32_t *prefetchCnt)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_ADDR_PREFETCH_CNT)) {
        RT_LOG(RT_LOG_INFO, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return ACL_RT_SUCCESS;
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->GetAddrAndPrefCntWithHandle(hdl, kernelInfoExt, addr, prefetchCnt);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelGetAddrAndPrefCnt(void *hdl, const uint64_t tilingKey,
                                    const void * const stubFunc, const uint32_t flag,
                                    void **addr, uint32_t *prefetchCnt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->KernelGetAddrAndPrefCnt(hdl, tilingKey, stubFunc, flag, addr, prefetchCnt);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelGetAddrAndPrefCntV2(void *hdl, const uint64_t tilingKey,
                                      const void * const stubFunc, const uint32_t flag,
                                      rtKernelDetailInfo_t * kernelInfo)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_ADDR_PREFETCH_CNT)) {
        RT_LOG(RT_LOG_DEBUG, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return ACL_RT_SUCCESS;
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->KernelGetAddrAndPrefCntV2(hdl, tilingKey, stubFunc, flag, kernelInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtQueryFunctionRegistered(const char_t *stubName)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->QueryFunctionRegistered(stubName);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_KERNEL_LOOKUP, ACL_ERROR_RT_KERNEL_LOOKUP); // special state
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_KERNEL_UNREGISTERING, ACL_ERROR_RT_KERNEL_UNREGISTERING); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelConfigDump(uint32_t kind, uint32_t dumpSizePerBlock, uint32_t blockDim, void **dumpBaseAddr,
                             rtStream_t stm)
{
    UNUSED(kind);
    UNUSED(dumpSizePerBlock);
    UNUSED(blockDim);
    UNUSED(dumpBaseAddr);
    UNUSED(stm);
    REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
    return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
}

VISIBILITY_DEFAULT
rtError_t rtKernelLaunch(const void *stubFunc, uint32_t numBlocks, void *args, uint32_t argsSize, rtSmDesc_t *smDesc,
                         rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((launchArg.argCount >= (ARG_ENTRY_SIZE / MIN_ARG_SIZE)), RT_ERROR_INVALID_VALUE, 
        launchArg.argCount, "[0, " + std::to_string(ARG_ENTRY_SIZE / MIN_ARG_SIZE) + ")");
    launchArg.stubFunc = stubFunc;
    if (launchArg.argCount == 0U) {
        launchArg.argCount = 1U;
        launchArg.argsOffset[0U] = 0U;
    }

    TIMESTAMP_BEGIN(rtKernelLaunch);
    Stream * const exeStream = static_cast<Stream *>(stm);
    rtArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = argsSize;

    Stream *curStm = nullptr;
    if (exeStream != nullptr) {
        curStm = exeStream;
    } else {
        const Runtime * const rtInstance = Runtime::Instance();
        NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
        Context * const curCtx = rtInstance->CurrentContext();
        COND_RETURN_EXT_ERRCODE_AND_MSG_INNER(curCtx == nullptr, RT_ERROR_CONTEXT_NULL, "current context is nullptr");
        curStm = curCtx->DefaultStream_();
    }

    NULL_STREAM_PTR_RETURN_MSG(curStm);

    // 0 : need h2d copy  1: no need h2d copy
    argsInfo.isNoNeedH2DCopy = (curStm->NonSupportModelCompile()) || (curStm->GetModelNum() == 0U) ? 0U : 1U;
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->KernelLaunch(stubFunc, numBlocks, &argsInfo, smDesc, exeStream, 0U, nullptr);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtKernelLaunch);
    launchArg.argCount = 0U;
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelLaunchWithHandle(void *hdl, const uint64_t tilingKey, uint32_t numBlocks, rtArgsEx_t *argsInfo,
    rtSmDesc_t *smDesc, rtStream_t stm, const void* kernelInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    UNUSED(kernelInfo);
    Api * const apiInstance = Api::Instance();
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();

    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((launchArg.argCount >= (ARG_ENTRY_SIZE / MIN_ARG_SIZE)), RT_ERROR_INVALID_VALUE, 
        launchArg.argCount, "[0, " + std::to_string(ARG_ENTRY_SIZE / MIN_ARG_SIZE) + ")");
    launchArg.stubFunc = nullptr;
    if (launchArg.argCount == 0U) {
        launchArg.argCount = 1U;
        launchArg.argsOffset[0U] = 0U;
    }
    TIMESTAMP_BEGIN(rtKernelLaunchWithHandle);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->KernelLaunchWithHandle(
        hdl, tilingKey, numBlocks, argsInfo, smDesc, static_cast<Stream *>(stm), nullptr);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtKernelLaunchWithHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelLaunchWithHandleV2(void *hdl, const uint64_t tilingKey, uint32_t numBlocks, rtArgsEx_t *argsInfo,
    rtSmDesc_t *smDesc, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();

    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((launchArg.argCount >= (ARG_ENTRY_SIZE / MIN_ARG_SIZE)), RT_ERROR_INVALID_VALUE, 
        launchArg.argCount, "[0, " + std::to_string(ARG_ENTRY_SIZE / MIN_ARG_SIZE) + ")");
    launchArg.stubFunc = nullptr;
    if (launchArg.argCount == 0U) {
        launchArg.argCount = 1U;
        launchArg.argsOffset[0U] = 0U;
    }
    TIMESTAMP_BEGIN(rtKernelLaunchWithHandleV2);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->KernelLaunchWithHandle(
        hdl, tilingKey, numBlocks, argsInfo, smDesc, static_cast<Stream *>(stm), cfgInfo);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtKernelLaunchWithHandleV2);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelLaunchWithFlag(const void *stubFunc, uint32_t numBlocks, rtArgsEx_t *argsInfo,
                                 rtSmDesc_t *smDesc, rtStream_t stm, uint32_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    launchArg.stubFunc = stubFunc;
    if (launchArg.argCount == 0U) {
        launchArg.argCount = 1U;
        launchArg.argsOffset[0U] = 0U;
    }

    TIMESTAMP_BEGIN(rtKernelLaunch);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t err = apiInstance->KernelLaunch(stubFunc, numBlocks, argsInfo, smDesc, exeStream, flags, nullptr);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtKernelLaunch);
    launchArg.argCount = 0U;
    ERROR_RETURN_WITH_EXT_ERRCODE(err);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelLaunchWithFlagV2(const void *stubFunc, uint32_t numBlocks, rtArgsEx_t *argsInfo,
                                   rtSmDesc_t *smDesc, rtStream_t stm, uint32_t flags, const rtTaskCfgInfo_t *cfgInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    launchArg.stubFunc = stubFunc;
    if (launchArg.argCount == 0U) {
        launchArg.argCount = 1U;
        launchArg.argsOffset[0U] = 0U;
    }

    TIMESTAMP_BEGIN(rtKernelLaunchWithFlagV2);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t err = apiInstance->KernelLaunch(stubFunc, numBlocks, argsInfo, smDesc, exeStream, flags, cfgInfo);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtKernelLaunchWithFlagV2);
    launchArg.argCount = 0U;
    ERROR_RETURN_WITH_EXT_ERRCODE(err);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelLaunchEx(void *args, uint32_t argsSize, uint32_t flags, rtStream_t stm)
{
    return rtKernelLaunchFwk("", args, argsSize, flags, stm);
}

VISIBILITY_DEFAULT
rtError_t rtKernelLaunchFwk(const char_t *opName, void *args, uint32_t argsSize, uint32_t flags, rtStream_t rtStream)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const stm = static_cast<Stream *>(rtStream);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->KernelLaunchEx(opName, args, argsSize, flags, stm);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCpuKernelLaunchWithFlag(const void *soName, const void *kernelName, uint32_t numBlocks,
                                    const rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc,
                                    rtStream_t stm, uint32_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtKernelLaunchNames_t launchName = {static_cast<const char_t *>(soName),
        static_cast<const char_t *>(kernelName), ""};
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->CpuKernelLaunch(&launchName, numBlocks, argsInfo, smDesc, exeStream, flags);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtAicpuKernelLaunchWithFlag(const rtKernelLaunchNames_t *launchNames, uint32_t numBlocks,
    const rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm, uint32_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->CpuKernelLaunch(launchNames, numBlocks, argsInfo, smDesc, exeStream, flags);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtAicpuKernelLaunchExWithArgs(const uint32_t kernelType, const char_t * const opName,
    const uint32_t numBlocks, const rtAicpuArgsEx_t *argsInfo, rtSmDesc_t * const smDesc,
    const rtStream_t stm, const uint32_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    RT_LOG(RT_LOG_INFO, "kernel_type=%u, flags=%u", kernelType, flags);
    if ((kernelType != KERNEL_TYPE_FWK) &&
        (kernelType != KERNEL_TYPE_AICPU) &&
        (kernelType != KERNEL_TYPE_AICPU_CUSTOM) &&
        (kernelType != KERNEL_TYPE_AICPU_KFC)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_INVALID_VALUE);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }

    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->CpuKernelLaunchExWithArgs(opName, numBlocks, argsInfo, smDesc,
                                                                 exeStream, flags, kernelType);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDumpAddrSet(rtModel_t mdl, void *addr, uint32_t dumpSize, uint32_t flag)
{
    UNUSED(mdl);
    UNUSED(addr);
    UNUSED(dumpSize);
    UNUSED(flag);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDatadumpInfoLoad(const void *dumpInfo, uint32_t length)
{
    return rtDatadumpInfoLoadWithFlag(dumpInfo, length, RT_KERNEL_DEFAULT);
}

VISIBILITY_DEFAULT
rtError_t rtDatadumpInfoLoadWithFlag(const void *dumpInfo, const uint32_t length, const uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->DatadumpInfoLoad(dumpInfo, length, flag);

    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtConfigureCall(uint32_t numBlocks, rtSmDesc_t *smDesc, rtStream_t stm)
{
    TIMESTAMP_NAME(__func__);
    errno_t ret;
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();

    launchArg.stm = stm;
    launchArg.numBlocks = numBlocks;
    if (smDesc != nullptr) {
        launchArg.smUsed = true;
        ret = memcpy_s(&launchArg.smDesc, sizeof(launchArg.smDesc), smDesc,
                       sizeof(launchArg.smDesc));
        COND_RETURN_EXT_ERRCODE_AND_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE,
            "Call memcpy_s failed, copy size is %zu.", sizeof(launchArg.smDesc));
    } else {
        launchArg.smUsed = false;
        ret = memset_s(&launchArg.smDesc, sizeof(launchArg.smDesc), 0, sizeof(launchArg.smDesc));
        COND_RETURN_EXT_ERRCODE_AND_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE, "Call memset_s failed, set size is %zu.",
                                           sizeof(launchArg.smDesc));
    }
    launchArg.isConfig = true;
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetupArgument(const void *args, uint32_t size, uint32_t offset)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->SetupArgument(args, size, offset);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLaunch(const void *stubFunc)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();
    TIMESTAMP_NAME(__func__);

    const rtError_t error = rtKernelLaunch(stubFunc, launchArg.numBlocks, launchArg.args, launchArg.argSize,
                                           launchArg.smUsed ? &launchArg.smDesc : nullptr, launchArg.stm);
    launchArg.isConfig = false;
    launchArg.argSize = 0U;
    launchArg.numBlocks = 0U;
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelConfigTransArg(const void *ptr, uint64_t size, uint32_t flag, void** args)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtKernelConfigTransArg);
    const rtError_t error = apiInstance->KernelTransArgSet(ptr, size, flag, args);
    TIMESTAMP_END(rtKernelConfigTransArg);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelFusionStart(rtStream_t stm)
{
    UNUSED(stm);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtKernelFusionEnd(rtStream_t stm)
{
    UNUSED(stm);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetAvailEventNum(uint32_t * const eventCount)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->GetAvailEventNum(eventCount);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetMaxModelNum(uint32_t *maxModelCount)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->GetMaxModelNum(maxModelCount);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventCreateWithFlag(rtEvent_t *evt, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtEventCreate);
    const rtError_t error = apiInstance->EventCreate(RtPtrToPtr<Event **>(evt), static_cast<uint64_t>(flag));
    TIMESTAMP_END(rtEventCreate);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventCreateExWithFlag(rtEvent_t *evt, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EventCreateEx(RtPtrToPtr<Event **>(evt), static_cast<uint64_t>(flag));
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventDestroy(rtEvent_t evt)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtEventDestroy);
    Event *eventPtr = static_cast<Event *>(evt);
    const rtError_t error = apiInstance->EventDestroy(eventPtr);
    TIMESTAMP_END(rtEventDestroy);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventDestroySync(rtEvent_t evt)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtEventDestroySync);
    Event *eventPtr = static_cast<Event *>(evt);
    const rtError_t error = apiInstance->EventDestroySync(eventPtr);
    TIMESTAMP_END(rtEventDestroySync);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetEventID(rtEvent_t evt, uint32_t *evtId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    Event * const eventPtr = static_cast<Event *>(evt);
    const rtError_t error = apiInstance->GetEventID(eventPtr, evtId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventRecord(rtEvent_t evt, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtEventRecord);
    Event * const eventPtr = static_cast<Event *>(evt);
    Stream * const streamPtr = static_cast<Stream *>(stm);

    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->EventRecord(eventPtr, streamPtr);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtEventRecord);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventReset(rtEvent_t evt, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtEventReset);
    Event * const eventPtr = static_cast<Event *>(evt);
    Stream * const streamPtr = static_cast<Stream *>(stm);

    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->EventReset(eventPtr, streamPtr);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtEventReset);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventSynchronize(rtEvent_t evt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtEventSynchronize);
    Event * const eventPtr = static_cast<Event *>(evt);
    const rtError_t error = apiInstance->EventSynchronize(eventPtr);
    TIMESTAMP_END(rtEventSynchronize);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventSynchronizeWithTimeout(rtEvent_t evt, const int32_t timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtEventSynchronizeWithTimeout);
    Event * const eventPtr = static_cast<Event *>(evt);
    const rtError_t error = apiInstance->EventSynchronize(eventPtr, timeout);
    TIMESTAMP_END(rtEventSynchronizeWithTimeout);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventQuery(rtEvent_t evt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Event * const eventPtr = static_cast<Event *>(evt);
    const rtError_t error = apiInstance->EventQuery(eventPtr);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_EVENT_NOT_COMPLETE, ACL_ERROR_RT_EVENT_NOT_COMPLETE); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventQueryStatus(rtEvent_t evt, rtEventStatus_t *status)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Event * const eventPtr = static_cast<Event *>(evt);
    const rtError_t error = apiInstance->EventQueryStatus(eventPtr, status);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventQueryWaitStatus(rtEvent_t evt, rtEventWaitStatus_t *status)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Event * const eventPtr = static_cast<Event *>(evt);
    const rtError_t error = apiInstance->EventQueryWaitStatus(eventPtr, status);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventElapsedTime(float32_t *timeInterval, rtEvent_t startEvent, rtEvent_t endEvent)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->EventElapsedTime(timeInterval, static_cast<Event *>(startEvent),
        static_cast<Event *>(endEvent));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventGetTimeStamp(uint64_t *timeStamp, rtEvent_t evt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Event * const eventPtr = static_cast<Event *>(evt);
    const rtError_t error = apiInstance->EventGetTimeStamp(timeStamp, eventPtr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtFree(void *devPtr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtFree_drvMemUnLock_drvMemFreeManaged);
    const rtError_t error = apiInstance->DevFree(devPtr);
    TIMESTAMP_END(rtFree_drvMemUnLock_drvMemFreeManaged);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDvppMallocWithFlag(void **devPtr, uint64_t size, uint32_t flag, const uint16_t moduleId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtDvppMallocWithFlag);
    const rtError_t error = apiInstance->DevDvppMalloc(devPtr, size, flag, moduleId);
    TIMESTAMP_END(rtDvppMallocWithFlag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDvppMalloc(void **devPtr, uint64_t size, const uint16_t moduleId)
{
    return rtDvppMallocWithFlag(devPtr, size, 0U, moduleId);
}

VISIBILITY_DEFAULT
rtError_t rtDvppFree(void *devPtr)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtDvppFree);
    const rtError_t error = apiInstance->DevDvppFree(devPtr);
    TIMESTAMP_END(rtDvppFree);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMallocHostSharedMemory(rtMallocHostSharedMemoryIn *in,
    rtMallocHostSharedMemoryOut *out)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMallocHostSharedMemory);
    const rtError_t error = apiInstance->MallocHostSharedMemory(in, out);
    TIMESTAMP_END(rtMallocHostSharedMemory);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtFreeHostSharedMemory(rtFreeHostSharedMemoryIn *in)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtFreeHostSharedMemory);
    const rtError_t error = apiInstance->FreeHostSharedMemory(in);
    TIMESTAMP_END(rtFreeHostSharedMemory);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemAllocManaged(void **ptr, uint64_t size, uint32_t flag, const uint16_t moduleId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemAllocManaged);
    const rtError_t error = apiInstance->ManagedMemAlloc(ptr, size, flag, moduleId);
    TIMESTAMP_END(rtMemAllocManaged);
    if (unlikely(error != RT_ERROR_NONE)) {
        return GetRtExtErrCodeAndSetGlobalErr(error);
    }
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemFreeManaged(void *ptr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemFreeManaged);
    const rtError_t error = apiInstance->ManagedMemFree(ptr);
    TIMESTAMP_END(rtMemFreeManaged);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemset(void *devPtr, uint64_t destMax, uint32_t val, uint64_t cnt)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemset);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemSetSync(devPtr, destMax, val, cnt);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtMemset);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemsetAsync(void *ptr, uint64_t destMax, uint32_t val, uint64_t cnt, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemsetAsync);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemsetAsync(ptr, destMax, val, cnt, exeStream);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtMemsetAsync);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetInfo(size_t *freeSize, size_t *totalSize)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemGetInfo);
    const rtError_t error = apiInstance->MemGetInfo(freeSize, totalSize);   /* 获取当前设备的大页内存信息 */
    TIMESTAMP_END(rtMemGetInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetInfoByType(const int32_t devId, const rtMemType_t type, rtMemInfo_t * const info)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemGetInfoByType);
    const rtError_t error = apiInstance->MemGetInfoByType(devId, type, info);
    TIMESTAMP_END(rtMemGetInfoByType);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetInfoEx(rtMemInfoType_t memInfoType, size_t *freeSize, size_t *totalSize)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemGetInfoEx);
    const rtError_t error = apiInstance->MemGetInfoEx(memInfoType, freeSize, totalSize);
    TIMESTAMP_END(rtMemGetInfoEx);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtPointerGetAttributes(rtPointerAttributes_t *attributes, const void *ptr)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtPointerGetAttributes);
    const rtError_t error = apiInstance->PointerGetAttributes(attributes, ptr);
    TIMESTAMP_END(rtPointerGetAttributes);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemPrefetchToDevice(void *devPtr, uint64_t len, int32_t devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemPrefetchToDevice);
    const rtError_t error = apiInstance->MemPrefetchToDevice(devPtr, len, devId);
    TIMESTAMP_END(rtMemPrefetchToDevice);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMallocCached(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtMallocCached);
    const rtError_t error = apiInstance->DevMalloc(devPtr, size, type, moduleId);
    TIMESTAMP_END(rtMallocCached);
    if (unlikely(error != RT_ERROR_NONE)) {
        return GetRtExtErrCodeAndSetGlobalErr(error);
    }
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyEx(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemcpyEx);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemCopySyncEx(dst, destMax, src, cnt, kind);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtMemcpyEx);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemcpy);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemCopySync(dst, destMax, src, cnt, kind);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtMemcpy);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyAsync(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind,
                        rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    TIMESTAMP_BEGIN(rtMemcpyAsync);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    TIMESTAMP_NAME(__func__);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemcpyAsync(dst, destMax, src, cnt, kind, exeStream, nullptr);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    TIMESTAMP_END(rtMemcpyAsync);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyAsyncWithoutCheckKind(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind,
                                        rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    TIMESTAMP_BEGIN(rtMemcpyAsyncWithoutCheckKind);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    TIMESTAMP_NAME(__func__);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemcpyAsync(dst, destMax, src, cnt, kind, exeStream,
                                                     nullptr, nullptr, false);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtMemcpyAsyncWithoutCheckKind);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyAsyncEx(void *dst, uint64_t destMax, const void *src, uint64_t cnt,
                          rtMemcpyKind_t kind, rtStream_t stm, rtMemcpyConfig_t *memcpyConfig)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    TIMESTAMP_BEGIN(rtMemcpyAsyncEx);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    TIMESTAMP_NAME(__func__);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemcpyAsync(dst, destMax, src, cnt, kind, exeStream, nullptr, nullptr, true, memcpyConfig);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    TIMESTAMP_END(rtMemcpyAsyncEx);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyAsyncWithCfg(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind,
    rtStream_t stm, uint32_t qosCfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    rtTaskCfgInfo_t cfgInfo = {};
    cfgInfo.qos = static_cast<uint8_t>(qosCfg & 0xFU); // 0xf is value mask, and move right 8 bits
    cfgInfo.partId = static_cast<uint8_t>((qosCfg & 0xFF0U) >> 4U); // 0xff0 is value mask, and move right 4 bits

    TIMESTAMP_BEGIN(rtMemcpyAsyncWithCfg);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);

    TIMESTAMP_NAME(__func__);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemcpyAsync(dst, destMax, src, cnt, kind, exeStream, &cfgInfo);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtMemcpyAsyncWithCfg);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyAsyncWithCfgV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind,
    rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    TIMESTAMP_BEGIN(rtMemcpyAsyncV2);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);

    TIMESTAMP_NAME(__func__);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemcpyAsync(dst, destMax, src, cnt, kind, exeStream, cfgInfo);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtMemcpyAsyncV2);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyAsyncPtr(void *memcpyAddrInfo, uint64_t destMax, uint64_t count,
                           rtMemcpyKind_t kind, rtStream_t stream, uint32_t qosCfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    if (kind != RT_MEMCPY_ADDR_DEVICE_TO_DEVICE) {
        RT_LOG(RT_LOG_WARNING, "rtMemcpyAsyncPtr failed, kind should be %u, but now is %u.",
            RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, kind);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    rtTaskCfgInfo_t cfgInfo = {};
    (void)memset_s(&cfgInfo, sizeof(rtTaskCfgInfo_t), 0, sizeof(rtTaskCfgInfo_t));
    cfgInfo.qos = static_cast<uint8_t>(qosCfg & 0xFU); // 0xf is value mask, and move right 8 bits
    cfgInfo.partId = static_cast<uint8_t>((qosCfg & 0xFF0U) >> 4U); // 0xff0 is value mask, and move right 4 bits

    Api * const api = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(api);
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(Runtime::Instance());
    Stream * const exeStream = static_cast<Stream *>(stream);
    rtError_t error;
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    if (likely(Runtime::Instance()->ChipIsHaveStars())) {
        error = api->MemcpyAsyncPtr(memcpyAddrInfo, destMax, count, exeStream,
            &cfgInfo);
    } else {
        constexpr const uint32_t srcPtrOffset = 16U;
        constexpr const uint32_t dstPtrOffset = 24U;
        error = api->MemcpyAsync((static_cast<char_t *>(memcpyAddrInfo) + dstPtrOffset), destMax,
            (static_cast<const char_t *>(memcpyAddrInfo) + srcPtrOffset), count, kind, exeStream, &cfgInfo);
    }
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyAsyncPtrV2(void *memcpyAddrInfo, uint64_t destMax, uint64_t count,
                           rtMemcpyKind_t kind, rtStream_t stream, const rtTaskCfgInfo_t *cfgInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    if (kind != RT_MEMCPY_ADDR_DEVICE_TO_DEVICE) {
        RT_LOG(RT_LOG_WARNING, "rtMemcpyAsyncPtrV2 failed, kind should be %u, but now is %u.",
            RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, kind);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    if (cfgInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "rtMemcpyAsyncPtrV2 failed, qos cfgInfo should not be null.");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    Api * const api = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(api);
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(Runtime::Instance());
    Stream * const exeStream = static_cast<Stream *>(stream);
    rtError_t error;
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    if (likely(Runtime::Instance()->ChipIsHaveStars())) {
        error = api->MemcpyAsyncPtr(memcpyAddrInfo, destMax, count, exeStream,
            cfgInfo);
    } else {
        constexpr const uint32_t srcPtrOffset = 16U;
        constexpr const uint32_t dstPtrOffset = 24U;
        error = api->MemcpyAsync((static_cast<char_t *>(memcpyAddrInfo) + dstPtrOffset), destMax,
            (static_cast<const char_t *>(memcpyAddrInfo) + srcPtrOffset), count, kind, exeStream, cfgInfo);
    }
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpy2d(void *dst, uint64_t dstPitch, const void *src, uint64_t srcPitch, uint64_t width, uint64_t height,
                     rtMemcpyKind_t kind)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemCopy2DSync(dst, dstPitch, src, srcPitch, width, height, kind);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpy2dAsync(void *dst, uint64_t dstPitch, const void *src, uint64_t srcPitch, uint64_t width,
                          uint64_t height, rtMemcpyKind_t kind, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);

    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemCopy2DAsync(dst, dstPitch, src, srcPitch, width, height, exeStream, kind);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCtxCreate(rtContext_t *createCtx, uint32_t flags, int32_t devId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    if (flags == RT_CTX_GEN_MODE) {
        RT_LOG(RT_LOG_WARNING, "RT_CTX_GEN_MODE is not supported.");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    TIMESTAMP_NAME(__func__);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ContextCreate(RtPtrToPtr<Context **>(createCtx), devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCtxDestroy(rtContext_t destroyCtx)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Context * const ctx = static_cast<Context *>(destroyCtx);
    const rtError_t error = apiInstance->ContextDestroy(ctx);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCtxSetCurrent(rtContext_t currentCtx)
{
    Context * const ctx = static_cast<Context *>(currentCtx);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ContextSetCurrent(ctx);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCtxGetCurrent(rtContext_t *currentCtx)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->ContextGetCurrent(RtPtrToPtr<Context **>(currentCtx));
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_CONTEXT_NULL, ACL_ERROR_RT_CONTEXT_NULL); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetPriCtxByDeviceId(int32_t devId, rtContext_t *primaryCtx)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(primaryCtx, RT_ERROR_INVALID_VALUE);
    Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    uint32_t realDeviceId;
    const rtError_t error = rtInstance->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId), &realDeviceId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    if (static_cast<uint32_t>(devId) >= RT_MAX_DEV_NUM) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Invalid device_id=%d, valid range is [0,%u)", devId,
            RT_MAX_DEV_NUM);
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    *primaryCtx = rtInstance->GetPriCtxByDeviceId(realDeviceId, MAX_UINT32_NUM);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCtxGetDevice(int32_t *devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->ContextGetDevice(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNameStream(rtStream_t stm, const char_t *name)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->NameStream(exeStream, name);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNameEvent(rtEvent_t evt, const char_t *name)
{
    Event * const namedEvent = static_cast<Event *>(evt);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->NameEvent(namedEvent, name);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetProfDirEx(const char_t *profDir, const char_t *address, const char_t *jobCtx)
{
    UNUSED(profDir);
    UNUSED(address);
    UNUSED(jobCtx);
    REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
    return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
}

VISIBILITY_DEFAULT
rtError_t rtProfilerInit(const char_t *profDir, const char_t *address, const char_t *jobCtx)
{
    UNUSED(profDir);
    UNUSED(address);
    UNUSED(jobCtx);
    REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
    return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
}

VISIBILITY_DEFAULT
rtError_t rtProfilerConfig(uint16_t profConfig)
{
    UNUSED(profConfig);
    REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
    return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
}

VISIBILITY_DEFAULT
rtError_t rtProfilerTrace(uint64_t id, bool notify, uint32_t flags, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ProfilerTrace(id, notify, flags, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtProfilerTraceEx(uint64_t id, uint64_t modelId, uint16_t tagId, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ProfilerTraceEx(id, modelId, tagId, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStartOnlineProf(rtStream_t stm, uint32_t sampleNum)
{
    Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", rtInstance->GetChipType());
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    const rtError_t error = apiInstance->StartOnlineProf(static_cast<Stream *>(stm), sampleNum);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStopOnlineProf(rtStream_t stm)
{
    Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", rtInstance->GetChipType());
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    const rtError_t error = apiInstance->StopOnlineProf(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetOnlineProfData(rtStream_t stm, rtProfDataInfo_t *pProfData, uint32_t profDataNum)
{
    Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", rtInstance->GetChipType());
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    const rtError_t error = apiInstance->GetOnlineProfData(static_cast<Stream *>(stm), pProfData, profDataNum);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetDeviceIdByGeModelIdx(uint32_t geModelIdx, uint32_t deviceId)
{
    RT_LOG(RT_LOG_DEBUG, "geModelIdx:%u, deviceId:%u.", geModelIdx, deviceId);
    if (RtIsHeterogenous()) {
        RT_LOG(RT_LOG_INFO, "Heterogenous does not support set device id by model id, geModelIdx:%u, deviceId:%u.",
               geModelIdx, deviceId);
        return RT_ERROR_NONE;
    }

    uint32_t realDeviceId;
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(Runtime::Instance());
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    error = RtCheckDeviceIdValid(realDeviceId);
    if (error != RT_ERROR_NONE) {
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    ProfMapGeModelDevice::Instance().SetDeviceIdByGeModelIdx(geModelIdx, realDeviceId);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtUnsetDeviceIdByGeModelIdx(uint32_t geModelIdx, uint32_t deviceId)
{
    RT_LOG(RT_LOG_DEBUG, "geModelIdx:%u, deviceId:%u.", geModelIdx, deviceId);
    uint32_t realDeviceId;
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(Runtime::Instance());
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    error = RtCheckDeviceIdValid(realDeviceId);
    if (error != RT_ERROR_NONE) {
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    ProfMapGeModelDevice::Instance().UnsetDeviceIdByGeModelIdx(geModelIdx, realDeviceId);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetMsprofReporterCallback(MsprofReporterCallback callback)
{
    ProfCtrlCallbackManager::Instance().Notify(static_cast<uint32_t>(RT_PROF_CTRL_REPORTER),
        RtPtrToPtr<void*, decltype(callback)>(callback),
        sizeof(MsprofReporterCallback));
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetMsprofReporterCallback(callback);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtProfSetProSwitch(void *data, uint32_t len)
{
    RT_LOG(RT_LOG_DEBUG, "len:%u.", len);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(data, RT_ERROR_INVALID_VALUE);
 
    if (len != sizeof(rtProfCommandHandle_t)) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(len, sizeof(rtProfCommandHandle_t));
        REPORT_FUNC_ERROR_REASON(RT_ERROR_INVALID_VALUE);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    ProfCtrlCallbackManager::Instance().SaveProfSwitchData(static_cast<rtProfCommandHandle_t *>(data), len);
    ProfCtrlCallbackManager::Instance().Notify(static_cast<uint32_t>(RT_PROF_CTRL_SWITCH), data, len);
    rtProfCommandHandle_t * const profilerConfig = static_cast<rtProfCommandHandle_t *>(data);
    RT_LOG(RT_LOG_INFO,
        "profSwitch:%#" PRIx64 ", profSwitchHi:%#" PRIx64 ", type:%u",
        profilerConfig->profSwitch,
        profilerConfig->profSwitchHi,
        profilerConfig->type);
    if (!RtIsHeterogenous()) {
        const rtError_t ret = RtCheckDeviceIdListValid(profilerConfig->devIdList, profilerConfig->devNums);
        if (ret != RT_ERROR_NONE) {
            return ACL_ERROR_RT_PARAM_INVALID;
        }
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    if (profilerConfig->type == PROF_COMMANDHANDLE_TYPE_START) {
        const rtError_t error = apiInstance->ProfilerStart(profilerConfig->profSwitch,
            static_cast<int32_t>(profilerConfig->devNums), profilerConfig->devIdList,
            profilerConfig->cacheFlag, profilerConfig->profSwitchHi);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
        if (((profilerConfig->profSwitch) & (PROF_INSTR)) != 0U) {
            Runtime::Instance()->SetBiuperfProfFlag(true);
        }
        if (((profilerConfig->profSwitch) & (PROF_L2CACHE)) != 0U) {
            Runtime::Instance()->SetL2CacheProfFlag(true);
        }
    } else if (profilerConfig->type == PROF_COMMANDHANDLE_TYPE_STOP) {
        const rtError_t error = apiInstance->ProfilerStop(profilerConfig->profSwitch,
            static_cast<int32_t>(profilerConfig->devNums), profilerConfig->devIdList, profilerConfig->profSwitchHi);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
        if (((profilerConfig->profSwitch) & (PROF_INSTR)) != 0U) {
            Runtime::Instance()->SetBiuperfProfFlag(false);
        }
        if (((profilerConfig->profSwitch) & (PROF_L2CACHE)) != 0U) {
            Runtime::Instance()->SetL2CacheProfFlag(false);
        }
    } else {
        RT_LOG(RT_LOG_INFO, "runtime does not support type:%u", profilerConfig->type);
    }

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtProfRegisterCtrlCallback(uint32_t moduleId, rtProfCtrlHandle callback)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->RegProfCtrlCallback(moduleId, callback);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    ProfCtrlCallbackManager::Instance().NotifyProfInfo(moduleId);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetL2CacheOffset(uint32_t deviceId, uint64_t *offset)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->GetL2CacheOffset(deviceId, offset);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetKernelReportCallback(rtKernelReportCallback callBack)
{
    UNUSED(callBack);
    REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
    return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
}

VISIBILITY_DEFAULT
rtError_t rtModelSetExtId(rtModel_t mdl, uint32_t extId)
{
    Runtime *rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_MODEL_ID_FOR_AICPU)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", rtInstance->GetChipType());
        return RT_GET_EXT_ERRCODE(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelSetExtId(RtPtrToPtr<Model *>(mdl), extId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelDestroy(rtModel_t mdl)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelDestroy(static_cast<Model *>(mdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelBindStream(rtModel_t mdl, rtStream_t stm, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelBindStream(static_cast<Model *>(mdl), static_cast<Stream *>(stm), flag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelUnbindStream(rtModel_t mdl, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelUnbindStream(static_cast<Model *>(mdl), static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelLoadComplete(rtModel_t mdl)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelLoadComplete(static_cast<Model *>(mdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelExecute(rtModel_t mdl, rtStream_t stm, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelExecute(static_cast<Model *>(mdl), static_cast<Stream *>(stm), flag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelGetTaskId(rtModel_t mdl, uint32_t *taskId, uint32_t *streamId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelGetTaskId(static_cast<Model *>(mdl), taskId, streamId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEndGraph(rtModel_t mdl, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelEndGraph(static_cast<Model *>(mdl), static_cast<Stream *>(stm), 0U);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEndGraphEx(rtModel_t mdl, rtStream_t stm, uint32_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelEndGraph(static_cast<Model *>(mdl), static_cast<Stream *>(stm), flags);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelExecutorSet(rtModel_t mdl, uint8_t flags)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelExecutorSet(static_cast<Model *>(mdl), flags);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelAbort(rtModel_t mdl)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelAbort(static_cast<Model *>(mdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelExit(rtModel_t mdl, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelExit(static_cast<Model *>(mdl), static_cast<Stream *>(stm));
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_MODEL_ABORT_NORMAL, ACL_ERROR_RT_MODEL_ABORT_NORMAL); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelBindQueue(rtModel_t mdl, uint32_t queueId, rtModelQueueFlag_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelBindQueue(static_cast<Model *>(mdl), queueId, flag);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelGetId(rtModel_t mdl, uint32_t *modelId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Model * const modelPtr = static_cast<Model *>(mdl);
    const rtError_t error = apiInstance->ModelGetId(modelPtr, modelId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelSetSchGroupId(rtModel_t mdl, const int16_t schGrpId)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->ModelSetSchGroupId(static_cast<Model *>(mdl), schGrpId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}


VISIBILITY_DEFAULT
rtError_t rtSetExceptCallback(rtErrorCallback callback)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetExceptCallback(callback);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtSetTaskAbortCallBack(const char *moduleName, rtTaskAbortCallBack callback, void *args)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetTaskAbortCallBack(moduleName, RtPtrToPtr<void *>(callback),
        args, TaskAbortCallbackType::RT_SET_TASK_ABORT_CALLBACK);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetTaskFailCallback(rtTaskFailCallback callback)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetTaskFailCallback(RtPtrToPtr<void *>(callback), nullptr,
        TaskFailCallbackType::RT_SET_TASK_FAIL_CALLBACK);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
VISIBILITY_DEFAULT
rtError_t rtRegTaskFailCallbackByModule(const char_t *moduleName, rtTaskFailCallback callback)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->RegTaskFailCallbackByModule(moduleName, RtPtrToPtr<void *>(callback),
        nullptr, TaskFailCallbackType::RT_REG_TASK_FAIL_CALLBACK_BY_MODULE);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetExceptionRegInfo(const rtExceptionInfo_t * const exceptionInfo,
    rtExceptionErrRegInfo_t **exceptionErrRegInfo, uint32_t *num)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetExceptionRegInfo(exceptionInfo, exceptionErrRegInfo, num);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtRegDeviceStateCallbackEx(const char_t *regName, rtDeviceStateCallback callback,
    const rtDevCallBackDir_t notifyPos)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->RegDeviceStateCallback(regName, RtPtrToPtr<void *>(callback),
        nullptr, DeviceStateCallback::RT_DEVICE_STATE_CALLBACK, notifyPos);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetAiCoreCount(uint32_t *aiCoreCnt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetAiCoreCount(aiCoreCnt);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetAiCpuCount(uint32_t *aiCpuCnt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetAiCpuCount(aiCpuCnt);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyCreate(int32_t deviceId, rtNotify_t *notify)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->NotifyCreate(deviceId, RtPtrToPtr<Notify **>(notify));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyCreateWithFlag(int32_t deviceId, rtNotify_t *notify, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->NotifyCreate(deviceId, RtPtrToPtr<Notify **>(notify), static_cast<uint64_t>(flag));
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyDestroy(rtNotify_t notify)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtNotifyDestroy);
    Notify * const notifyPtr = static_cast<Notify *>(notify);
    const rtError_t error = apiInstance->NotifyDestroy(notifyPtr);
    TIMESTAMP_END(rtNotifyDestroy);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyReset(rtNotify_t notify)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);

    if (IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_NOTIFY_RESET)) {
        Notify * const notifyPtr = static_cast<Notify *>(notify);
        const rtError_t error = apiInstance->NotifyReset(notifyPtr);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
    } else {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
    }
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtResourceClean(int32_t devId, rtIdType_t type)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ResourceClean(devId, type);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyRecord(rtNotify_t notify, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);

    Notify * const notifyPtr = static_cast<Notify *>(notify);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->NotifyRecord(notifyPtr, exeStream);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyWait(rtNotify_t notify, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    rtError_t error = RT_ERROR_NONE;
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);

    Notify * const notifyPtr = static_cast<Notify *>(notify);
    Stream * const exeStream = static_cast<Stream *>(stm);
    if (IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT)) {
        error = apiInstance->NotifyWait(notifyPtr, exeStream, 0U);
    } else {
        error = apiInstance->NotifyWait(notifyPtr, exeStream, Runtime::Instance()->GetWaitTimeout());
        RT_LOG(RT_LOG_INFO, "start NotifyWait timeout value.timeout=%us", Runtime::Instance()->GetWaitTimeout());
    }
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyWaitWithTimeOut(rtNotify_t notify, rtStream_t stm, uint32_t timeOut)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);

    const rtChipType_t chipType = rtInstance->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT_TIMEOUT)) {
        RT_LOG(RT_LOG_INFO, "start notify wait support timeout value.timeout=%us", timeOut);
        Notify * const notifyPtr = static_cast<Notify *>(notify);
        Stream * const exeStream = static_cast<Stream *>(stm);
        const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
        (void)AwdStartThreadWatchdog(watchDogHandle);
        const rtError_t error = apiInstance->NotifyWait(notifyPtr, exeStream, timeOut);
        (void)AwdStopThreadWatchdog(watchDogHandle);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
        return ACL_RT_SUCCESS;
    } else {
        RT_LOG(RT_LOG_WARNING, "current chipType[%d] does not support timeout config.", rtInstance->GetChipType());
        return rtNotifyWait(notify, stm);
    }
}

VISIBILITY_DEFAULT
rtError_t rtGetNotifyID(rtNotify_t notify, uint32_t *notifyId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    Notify * const notifyPtr = static_cast<Notify *>(notify);
    const rtError_t error = apiInstance->GetNotifyID(notifyPtr, notifyId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyGetPhyInfoExt(rtNotify_t notify, rtNotifyPhyInfo *notifyInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    Notify * const notifyPtr = static_cast<Notify *>(notify);
    const rtError_t error = apiInstance->GetNotifyPhyInfo(notifyPtr, notifyInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyGetAddrOffset(rtNotify_t notify, uint64_t* devAddrOffset)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_NOTIFY_USER_VA_MAPPING)) {
        Api * const apiInstance = Api::Instance();
        NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
        Notify * const notifyPtr = static_cast<Notify *>(notify);
        const rtError_t error = apiInstance->NotifyGetAddrOffset(notifyPtr, devAddrOffset);
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
    }

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLabelCreate(rtLabel_t *lbl)
{
    UNUSED(lbl);
    RT_LOG(RT_LOG_WARNING, "feature not support");
    return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
}

VISIBILITY_DEFAULT
rtError_t rtLabelCreateV2(rtLabel_t *lbl, rtModel_t mdl)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(mdl, RT_ERROR_INVALID_VALUE);
    const rtError_t error = apiInstance->LabelCreate(RtPtrToPtr<Label **>(lbl), static_cast<Model *>(mdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLabelDestroy(rtLabel_t lbl)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->LabelDestroy(static_cast<Label *>(lbl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLabelSet(rtLabel_t lbl, rtStream_t stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->LabelSet(static_cast<Label *>(lbl), static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLabelGoto(rtLabel_t lbl, rtStream_t stm)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_LABEL_GOTO)) {
        Api * const apiInstance = Api::Instance();
        NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
        const rtError_t error = apiInstance->LabelGoto(static_cast<Label *>(lbl), static_cast<Stream *>(stm));
        ERROR_RETURN_WITH_EXT_ERRCODE(error);
        return ACL_RT_SUCCESS;
    }
    REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
    return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
}

VISIBILITY_DEFAULT
rtError_t rtCtxCreateEx(rtContext_t *createCtx, uint32_t flags, int32_t devId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    if (flags == RT_CTX_GEN_MODE) {
        RT_LOG(RT_LOG_WARNING, "RT_CTX_GEN_MODE is not supported.");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();

    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);

    const rtError_t error = apiInstance->ContextCreate(RtPtrToPtr<Context **>(createCtx), devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCtxDestroyEx(rtContext_t destroyCtx)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Context * const context = static_cast<Context *>(destroyCtx);
    const rtError_t error = apiInstance->ContextDestroy(context);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSubscribeReport(uint64_t threadId, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SubscribeReport(threadId, static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCallbackLaunch(rtCallback_t callBackFunc, void *fnData, rtStream_t stm, bool isBlock)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->CallbackLaunch(callBackFunc, fnData, static_cast<Stream *>(stm), isBlock);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtProcessReport(int32_t timeout)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ProcessReport(timeout);
    return GetRtExtErrCodeAndSetGlobalErr(error); // execute in user thread,exit with no error log
}

VISIBILITY_DEFAULT
rtError_t rtUnSubscribeReport(uint64_t threadId, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->UnSubscribeReport(threadId, static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetRunMode(rtRunMode *runMode)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetRunMode(runMode);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetIsHeterogenous(int32_t *heterogenous)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(heterogenous, RT_ERROR_INVALID_VALUE);
    *heterogenous = RtGetHeterogenous();
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLabelSwitchByIndex(void *ptr, uint32_t maxValue, void *labelInfoPtr, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->LabelSwitchByIndex(ptr, maxValue, labelInfoPtr, static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLabelGotoEx(rtLabel_t lbl, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->LabelGotoEx(static_cast<Label *>(lbl), static_cast<Stream *>(stm));
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLabelListCpy(rtLabel_t *lbl, uint32_t labelNumber, void *dst, uint32_t dstMax)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->LabelListCpy(RtPtrToPtr<Label **>(lbl), labelNumber, dst, dstMax);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLabelCreateEx(rtLabel_t *lbl, rtStream_t stm)
{
    UNUSED(lbl);
    UNUSED(stm);
    RT_LOG(RT_LOG_WARNING, "feature is not supported");
    return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
}

VISIBILITY_DEFAULT
rtError_t rtLabelCreateExV2(rtLabel_t *lbl, rtModel_t mdl, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(mdl, RT_ERROR_INVALID_VALUE);
    const rtError_t error = apiInstance->LabelCreateEx(RtPtrToPtr<Label **>(lbl), static_cast<Model *>(mdl),
        static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDebugRegister(rtModel_t mdl, uint32_t flag, const void *addr, uint32_t *streamId, uint32_t *taskId)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_DFX_FLOAT_OVERFLOW_DEBUG)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DebugRegister(static_cast<Model *>(mdl), flag, addr, streamId, taskId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDebugUnRegister(rtModel_t mdl)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_DFX_FLOAT_OVERFLOW_DEBUG)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->DebugUnRegister(static_cast<Model *>(mdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDebugRegisterForStream(rtStream_t stm, uint32_t flag, const void *addr,
                                   uint32_t *streamId, uint32_t *taskId)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_DFX_FLOAT_OVERFLOW_DEBUG)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->DebugRegisterForStream(exeStream, flag, addr, streamId, taskId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDebugUnRegisterForStream(rtStream_t stm)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_DFX_FLOAT_OVERFLOW_DEBUG)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->DebugUnRegisterForStream(exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetAicpuDeploy(rtAicpuDeployType_t *deployType)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetAicpuDeploy(deployType);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtGetRtCapability(rtFeatureType_t featureType, int32_t featureInfo, int64_t *val)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetRtCapability(featureType, featureInfo, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetGroup(int32_t groupId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetGroup(groupId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetGroupCount(uint32_t *cnt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetGroupCount(cnt);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetGroupInfo(int32_t groupId, rtGroupInfo_t *groupInfo, uint32_t cnt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetGroupInfo(groupId, groupInfo, cnt);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetCtxINFMode(bool infMode)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ContextSetINFMode(infMode);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetDeviceWithoutTsd(int32_t devId)
{
    Api * const apiInstance = Api::Instance(API_ENV_FLAGS_NO_TSD);
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->SetDevice(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetRuntimeVersion(uint32_t *runtimeVersion)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(runtimeVersion, RT_ERROR_INVALID_VALUE);
    *runtimeVersion = RUNTIME_PUBLIC_VERSION;
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetFaultEvent(const int32_t deviceId, rtDmsEventFilter *filter, rtDmsFaultEvent *dmsEvent,
    uint32_t len, uint32_t *eventCount)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetFaultEvent(deviceId, filter, dmsEvent, len, eventCount);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetMemUceInfo(deviceId, memUceInfo);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemUceRepair(deviceId, memUceInfo);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

rtError_t rtNpuGetFloatDebugStatus(void * outputAddrPtr, uint64_t outputSize, uint32_t checkMode, rtStream_t stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtNpuGetFloatDebugStatus);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->NpuGetFloatDebugStatus(outputAddrPtr, outputSize, checkMode, streamPtr);
    TIMESTAMP_END(rtNpuGetFloatDebugStatus);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

rtError_t rtNpuClearFloatDebugStatus(uint32_t checkMode, rtStream_t stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtNpuClearFloatDebugStatus);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    const rtError_t ret = apiInstance->NpuClearFloatDebugStatus(checkMode, streamPtr);
    TIMESTAMP_END(rtNpuClearFloatDebugStatus);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetOpWaitTimeOut(uint32_t timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->SetOpWaitTimeOut(timeout);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetOpExecuteTimeOut(uint32_t timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_TIMEOUT_CONFIG)) {
        COND_RETURN_WARN(rtInstance->GetAicpuCnt() == 0,
            ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "not support rtSetOpExecuteTimeOut!");
    }
    const rtError_t error = apiInstance->SetOpExecuteTimeOut(timeout, RT_TIME_UNIT_TYPE_S);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetOpExecuteTimeOutWithMs(uint32_t timeout)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetOpExecuteTimeOut(timeout, RT_TIME_UNIT_TYPE_MS);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetOpExecuteTimeOut(uint32_t * const timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetOpExecuteTimeOut(timeout);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetOpExecuteTimeoutV2(uint32_t *const timeout)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetOpExecuteTimeoutV2(timeout);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetOpTimeOutInterval(uint64_t *interval)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetOpTimeOutInterval(interval);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetOpExecuteTimeOutV2(timeout, actualTimeout);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetC2cCtrlAddr(uint64_t *addr, uint32_t *len)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_C2C_SYNC)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->GetC2cCtrlAddr(addr, len);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

rtError_t rtStarsTaskLaunch(const void *taskSqe, uint32_t sqeLen, rtStream_t stm)
{
    return rtStarsTaskLaunchWithFlag(taskSqe, sqeLen, stm, RT_KERNEL_DEFAULT);
}

rtError_t rtStarsTaskLaunchWithFlag(const void *taskSqe, uint32_t sqeLen, rtStream_t stm, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtStarsTaskLaunchWithFlag);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->StarsTaskLaunch(taskSqe, sqeLen, streamPtr, flag);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtStarsTaskLaunchWithFlag);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetTaskTag(const char_t *taskTag)
{
    Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtError_t ret = ThreadLocalContainer::SetTaskTag(taskTag);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetAicpuAttr(const char_t *key, const char_t *val)
{
    Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtError_t ret = rtInstance->SetAicpuAttr(key, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueInitFlowGw(int32_t devId, const rtInitFlowGwInfo_t * const initInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemQueueInitFlowGw(devId, initInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueCreate(int32_t devId, const rtMemQueueAttr_t *queAttr, uint32_t *qid)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueCreate(devId, queAttr, qid);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueExport(int32_t devId, uint32_t qid, int32_t peerDevId, const char * const shareName)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueExport(devId, qid, peerDevId, shareName);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueUnExport(int32_t devId, uint32_t qid, int32_t peerDevId, const char * const shareName)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueUnExport(devId, qid, peerDevId, shareName);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueImport(int32_t devId, int32_t peerDevId, const char * const shareName, uint32_t * const qid)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueImport(devId, peerDevId, shareName, qid);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueUnImport(int32_t devId, uint32_t qid, int32_t peerDevId, const char * const shareName)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueUnImport(devId, qid, peerDevId, shareName);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueSet(int32_t devId, rtMemQueueSetCmdType cmd, const rtMemQueueSetInputPara *input)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueSet(devId, cmd, input);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueDestroy(int32_t devId, uint32_t qid)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueDestroy(devId, qid);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueInit(int32_t devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueInit(devId);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_REPEATED_INIT, ACL_ERROR_RT_REPEATED_INIT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueReset(int32_t devId, uint32_t qid)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueReset(devId, qid);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueEnQueue(int32_t devId, uint32_t qid, void *memBuf)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueEnQueue(devId, qid, memBuf);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_QUEUE_FULL, ACL_ERROR_RT_QUEUE_FULL); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueDeQueue(int32_t devId, uint32_t qid, void **memBuf)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueDeQueue(devId, qid, memBuf);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_QUEUE_EMPTY, ACL_ERROR_RT_QUEUE_EMPTY); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueuePeek(int32_t devId, uint32_t qid, size_t *bufLen, int32_t timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueuePeek(devId, qid, bufLen, timeout);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_QUEUE_EMPTY, ACL_ERROR_RT_QUEUE_EMPTY); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueEnQueueBuff(int32_t devId, uint32_t qid, rtMemQueueBuff_t *inBuf, int32_t timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueEnQueueBuff(devId, qid, inBuf, timeout);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_QUEUE_FULL, ACL_ERROR_RT_QUEUE_FULL); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueDeQueueBuff(int32_t devId, uint32_t qid, rtMemQueueBuff_t *outBuf, int32_t timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueDeQueueBuff(devId, qid, outBuf, timeout);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_QUEUE_EMPTY, ACL_ERROR_RT_QUEUE_EMPTY); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueQueryInfo(int32_t devId, uint32_t qid, rtMemQueueInfo_t *queInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueQueryInfo(devId, qid, queInfo);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueQuery(int32_t devId, rtMemQueueQueryCmd_t cmd, const void *inBuff, uint32_t inLen,
    void *outBuff, uint32_t *outLen)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueQuery(devId, cmd, inBuff, inLen, outBuff, outLen);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueGrant(int32_t devId, uint32_t qid, int32_t pid, rtMemQueueShareAttr_t *attr)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueGrant(devId, qid, pid, attr);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueAttach(int32_t devId, uint32_t qid, int32_t timeOut)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueAttach(devId, qid, timeOut);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueGetQidByName(int32_t devId, const char_t *name, uint32_t *qId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemQueueGetQidByName(devId, name, qId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtQueueSubF2NFEvent(int32_t devId, uint32_t qId, uint32_t groupId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->QueueSubF2NFEvent(devId, qId, groupId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtQueueSubscribe(int32_t devId, uint32_t qId, uint32_t groupId, int32_t type)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->QueueSubscribe(devId, qId, groupId, type);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBufEventTrigger(const char_t * const name)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->BufEventTrigger(name);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedSubmitEventSync(int32_t devId, rtEschedEventSummary_t *evt,
    rtEschedEventReply_t *ack)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->EschedSubmitEventSync(devId, evt, ack);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtQueryDevPid(rtBindHostpidInfo_t *info, int32_t *devPid)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->QueryDevPid(info, devPid);
    return GetRtExtErrCodeAndSetGlobalErr(error);
}

VISIBILITY_DEFAULT
rtError_t rtEschedAttachDevice(int32_t devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EschedAttachDevice(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedDettachDevice(int32_t devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EschedDettachDevice(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedWaitEvent(int32_t devId, uint32_t grpId, uint32_t threadId,
    int32_t timeout, rtEschedEventSummary_t *evt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EschedWaitEvent(devId, grpId, threadId, timeout, evt);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_REPORT_TIMEOUT, ACL_ERROR_RT_REPORT_TIMEOUT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedCreateGrp(int32_t devId, uint32_t grpId, rtGroupType_t type)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EschedCreateGrp(devId, grpId, type);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedSubmitEvent(int32_t devId, rtEschedEventSummary_t *evt)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EschedSubmitEvent(devId, evt);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedSubscribeEvent(int32_t devId, uint32_t grpId, uint32_t threadId, uint64_t eventBitmap)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EschedSubscribeEvent(devId, grpId, threadId, eventBitmap);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEschedAckEvent(int32_t devId, rtEventIdType_t evtId, uint32_t subEvtId, char_t *msg, uint32_t len)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EschedAckEvent(devId, evtId, subEvtId, msg, len);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBuffAlloc(const uint64_t size, void **buff)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->BuffAlloc(size, buff);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBuffConfirm(void *buff, const uint64_t size)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->BuffConfirm(buff, size);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    return GetRtExtErrCodeAndSetGlobalErr(error);
}

VISIBILITY_DEFAULT
rtError_t rtBuffFree(void *buff)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->BuffFree(buff);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemQueueInitQS(int32_t devId, const char_t* grpName)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueInitQS(devId, grpName);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGrpCreate(const char_t *name, const rtMemGrpConfig_t *cfg)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemGrpCreate(name, cfg);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBuffGetInfo(rtBuffGetCmdType type, const void * const inBuff, uint32_t inLen,
    void * const outBuff, uint32_t * const outLen)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->BuffGetInfo(type, inBuff, inLen, outBuff, outLen);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGrpCacheAlloc(const char_t *name, int32_t devId, const rtMemGrpCacheAllocPara *para)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemGrpCacheAlloc(name, devId, para);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGrpAddProc(const char_t *name, int32_t pid, const rtMemGrpShareAttr_t *attr)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemGrpAddProc(name, pid, attr);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_REPEATED_INIT, ACL_ERROR_RT_REPEATED_INIT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGrpAttach(const char_t *name, int32_t timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemGrpAttach(name, timeout);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGrpQuery(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t *output)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemGrpQuery(input, output);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

rtError_t rtBarrierTaskLaunch(rtBarrierTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_ASYNC_CMO)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->BarrierTaskLaunch(taskInfo, streamPtr, flag);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    rtMemcpyKind_t kind, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_TASK_MEMORY_COPY_DOT_HOST)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemcpyHostTask(dst, destMax, src, cnt, kind, exeStream);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API uint32_t rtGetTsMemType(rtMemRequestFeature_t featureType, uint32_t memSize)
{
    Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    return rtInstance->GetTsMemType(featureType, static_cast<uint64_t>(memSize));
}

VISIBILITY_DEFAULT
rtError_t rtProfilingCommandHandle(uint32_t type, void *data, uint32_t len)
{
    if (type == PROF_CTRL_SWITCH) {
        RT_LOG(RT_LOG_INFO, "Profiling type: %u", type);
        return rtProfSetProSwitch(data, len);
    } else {
        RT_LOG(RT_LOG_WARNING, "Not support the type: %u", type);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtSetDeviceSatMode(rtFloatOverflowMode_t floatOverflowMode)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    DevProperties prop;
    rtError_t error = GET_DEV_PROPERTIES(rtInstance->GetChipType(), prop);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    if (!prop.isSupportSetDeviceSatMode) {
        if (floatOverflowMode == RT_OVERFLOW_MODE_SATURATION) {
            RT_LOG(RT_LOG_INFO, "Set mode saturation, chip type(%d) does not support, return success.",
                   static_cast<int32_t>(rtInstance->GetChipType()));
            return ACL_RT_SUCCESS;
        } else {
            RT_LOG(RT_LOG_WARNING, "Set mode inf/nan, chip type(%d) does not support, return error.",
                   static_cast<int32_t>(rtInstance->GetChipType()));
            return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
        }
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->SetDeviceSatMode(floatOverflowMode);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtDvppGroupCreate(rtDvppGrp_t *grp, uint32_t flags)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtDvppGroupCreate);
    const rtError_t ret = apiInstance->DvppGroupCreate(RtPtrToPtr<DvppGrp **>(grp), flags);
    TIMESTAMP_END(rtDvppGroupCreate);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtDvppGroupDestory(rtDvppGrp_t grp)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtDvppGroupDestory);
    const rtError_t ret = apiInstance->DvppGroupDestory(RtPtrToPtr<DvppGrp *>(grp));
    TIMESTAMP_END(rtDvppGroupDestory);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtDvppWaitGroupReport(rtDvppGrp_t grp, rtDvppGrpCallback callBackFunc, int32_t timeout)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtDvppWaitGroupReport);
    const rtError_t ret = apiInstance->DvppWaitGroupReport(RtPtrToPtr<DvppGrp *>(grp), callBackFunc, timeout);
    TIMESTAMP_END(rtDvppWaitGroupReport);
    return GetRtExtErrCodeAndSetGlobalErr(ret);
}

VISIBILITY_DEFAULT
rtError_t rtMultipleTaskInfoLaunch(const void * taskInfo, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->MultipleTaskInfoLaunch(
        RtPtrToPtr<const rtMultipleTaskInfo_t *>(taskInfo), exeStream, RT_DEFAULT_FLAG);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMultipleTaskInfoLaunchWithFlag(const void * taskInfo, rtStream_t stm, const uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->MultipleTaskInfoLaunch(
        RtPtrToPtr<const rtMultipleTaskInfo_t *>(taskInfo), exeStream, flag);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtCreateLaunchArgs(size_t argsSize, size_t hostInfoTotalSize, size_t hostInfoNum,
                                     void* argsData, rtLaunchArgsHandle* argsHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->CreateLaunchArgs(argsSize, hostInfoTotalSize, hostInfoNum, argsData,
                                                        RtPtrToPtr<rtLaunchArgs_t**>(argsHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}


VISIBILITY_DEFAULT
RTS_API rtError_t rtCalcLaunchArgsSize(size_t argsSize, size_t hostInfoTotalSize, size_t hostInfoNum,
                                       size_t *launchArgsSize)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtCalcLaunchArgsSize);
    const rtError_t ret = apiInstance->CalcLaunchArgsSize(argsSize, hostInfoTotalSize, hostInfoNum, launchArgsSize);
    TIMESTAMP_END(rtCalcLaunchArgsSize);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtResetLaunchArgs(rtLaunchArgsHandle argsHandle)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->ResetLaunchArgs(RtPtrToPtr<rtLaunchArgs_t*>(argsHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtDestroyLaunchArgs(rtLaunchArgsHandle argsHandle)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->DestroyLaunchArgs(RtPtrToPtr<rtLaunchArgs_t*>(argsHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtAppendLaunchAddrInfo(rtLaunchArgsHandle argsHandle, void *addrInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtAppendLaunchAddrInfo);
    const rtError_t ret = apiInstance->AppendLaunchAddrInfo(RtPtrToPtr<rtLaunchArgs_t*>(argsHandle), addrInfo);
    TIMESTAMP_END(rtAppendLaunchAddrInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtAppendLaunchHostInfo(rtLaunchArgsHandle argsHandle, size_t hostInfoSize, void **hostInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtAppendLaunchHostInfo);
    const rtError_t ret = apiInstance->AppendLaunchHostInfo(RtPtrToPtr<rtLaunchArgs_t*>(argsHandle),
                                                            hostInfoSize, hostInfo);
    TIMESTAMP_END(rtAppendLaunchHostInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBinaryGetFunction(rtBinHandle binHandle, uint64_t tilingKey, rtFuncHandle *funcHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryGetFunction(RtPtrToPtr<Program *>(binHandle), tilingKey,
                                                         RtPtrToPtr<Kernel **>(funcHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBinaryLoad(const rtDevBinary_t *bin, rtBinHandle *binHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryLoad(bin, RtPtrToPtr<Program **>(binHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBinaryUnLoad(rtBinHandle binHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryUnLoad(RtPtrToPtr<Program *>(binHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchKernelByFuncHandle(rtFuncHandle funcHandle, uint32_t numBlocks, rtLaunchArgsHandle argsHandle,
                                     rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(argsHandle, RT_ERROR_INVALID_VALUE);
    rtLaunchArgs_t* args = RtPtrToPtr<rtLaunchArgs_t*>(argsHandle);
    rtArgsEx_t *argsInfo = &(args->argsInfo);
    const rtError_t ret = apiInstance->LaunchKernel(RtPtrToPtr<Kernel *>(funcHandle), numBlocks, argsInfo,
                                                    static_cast<Stream *>(stm), nullptr);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_KERNEL_INVALID, ACL_ERROR_RT_INVALID_HANDLE);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchKernelByFuncHandleV2(rtFuncHandle funcHandle, uint32_t numBlocks, rtLaunchArgsHandle argsHandle,
                                       rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(argsHandle, RT_ERROR_INVALID_VALUE);
    rtLaunchArgs_t* args = RtPtrToPtr<rtLaunchArgs_t*>(argsHandle);
    rtArgsEx_t *argsInfo = &(args->argsInfo);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->LaunchKernel(RtPtrToPtr<Kernel *>(funcHandle), numBlocks, argsInfo,
                                                    static_cast<Stream *>(stm), cfgInfo);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_KERNEL_INVALID, ACL_ERROR_RT_INVALID_HANDLE);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchKernelByFuncHandleV3(rtFuncHandle funcHandle, uint32_t numBlocks, const rtArgsEx_t * const argsInfo,
                                       rtStream_t stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->LaunchKernel(RtPtrToPtr<Kernel *>(funcHandle), numBlocks, argsInfo,
                                                    static_cast<Stream *>(stm), cfgInfo);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(ret == RT_ERROR_KERNEL_INVALID, ACL_ERROR_RT_INVALID_HANDLE);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBinaryLoadWithoutTilingKey(const void *data, const uint64_t length, rtBinHandle *binHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_LOAD_DOT_WITHOUT_TILING)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryLoadWithoutTilingKey(data, length,
                                                                  RtPtrToPtr<Program **>(binHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBinaryGetFunctionByName(rtBinHandle binHandle, const char *kernelName, rtFuncHandle *funcHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_LOAD_DOT_WITHOUT_TILING)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryGetFunctionByName(RtPtrToPtr<Program *>(binHandle),
                                                               kernelName,
                                                               RtPtrToPtr<Kernel **>(funcHandle));
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBinaryGetMetaInfo(const rtBinHandle binHandle, const rtBinaryMetaType type, void *data, const uint32_t length)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->BinaryGetMetaInfo(RtPtrToPtr<Program *>(binHandle), type, data, length);

    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtFunctionGetMetaInfo(const rtFuncHandle funcHandle, const rtFunctionMetaType type, void *data, const uint32_t length)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->FunctionGetMetaInfo(RtPtrToPtr<const Kernel *>(funcHandle), type, data, length);

    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtGeneralCtrl(uintptr_t *ctrl, uint32_t num, uint32_t type)
{
    return rtGeneralCtrlInner(ctrl, num, type);
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtCtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->CtxSetSysParamOpt(configOpt, configVal);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    if (configOpt < SYS_OPT_RESERVED) {
        sysParamOpt_[configOpt].store(configVal);
    }
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtCtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->CtxGetSysParamOpt(configOpt, configVal);
    if (ret == RT_ERROR_NOT_SET_SYSPARAMOPT) {
        return ACL_ERROR_RT_SYSPARAMOPT_NOT_SET;
    }
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    COND_RETURN_WITH_EXT_ERRCODE((configOpt >= SYS_OPT_RESERVED) || (configOpt < 0), RT_ERROR_INVALID_VALUE, 
        "Invalid system configOpt, current configOpt=%d, valid range is [0, %d).",
        configOpt, SYS_OPT_RESERVED);
    COND_RETURN_WITH_EXT_ERRCODE((configVal >= SYS_OPT_MAX) || (configVal < 0), RT_ERROR_INVALID_VALUE,
        "Invalid configVal, current configVal=%" PRId64 ", valid range is [0, %d).",
        configVal, SYS_OPT_MAX);
    sysParamOpt_[configOpt].store(configVal);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    COND_RETURN_WITH_EXT_ERRCODE((configOpt >= SYS_OPT_RESERVED) || (configOpt < 0), RT_ERROR_INVALID_VALUE,
        "Invalid system configOpt, current configOpt=%d, valid range is [0, %d).",
        configOpt, SYS_OPT_RESERVED);
    COND_RETURN_WITH_EXT_ERRCODE(configVal == nullptr, RT_ERROR_INVALID_VALUE,
        "Check param failed, configVal can not be null.");
    *configVal = sysParamOpt_[configOpt].load();
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtCtxGetOverflowAddr(void **overflowAddr)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->CtxGetOverflowAddr(overflowAddr);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtGetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, rtStream_t stm)
{
    rtError_t ret;
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    Stream * const streamPtr = static_cast<Stream *>(stm);
    const rtChipType_t chipType = rtInstance->GetChipType();
    DevProperties props;
    GET_DEV_PROPERTIES(chipType, props);
    if (props.deviceSatStatusImpl > 0) {
        ret = apiInstance->GetDeviceSatStatus(outputAddrPtr, outputSize, streamPtr);
    } else {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtCleanDeviceSatStatus(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    rtError_t ret;
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    Stream * const streamPtr = static_cast<Stream *>(stm);
    const rtChipType_t chipType = rtInstance->GetChipType();
    DevProperties props;
    GET_DEV_PROPERTIES(chipType, props);
    if (props.deviceSatStatusImpl == 1) {
        ret = apiInstance->CleanDeviceSatStatus(streamPtr);
    } else if (props.deviceSatStatusImpl == 2 || props.deviceSatStatusImpl == 3) {
        ret = apiInstance->NpuClearFloatStatus(0U, streamPtr);
    } else {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtGetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->GetAllUtilizations(devId, kind, util);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtEschedQueryInfo(const uint32_t devId, const rtEschedQueryType type,
    rtEschedInputInfo *inPut, rtEschedOutputInfo *outPut)
{
    rtError_t ret;
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    if (IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_DRIVER_ESCHED_QUERY_INFO)) {
        ret = apiInstance->EschedQueryInfo(devId, type, inPut, outPut);
    } else {
        RT_LOG(RT_LOG_ERROR, "Chip type(%d) does not support.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtModelCheckCompatibility(const char_t *omSocVersion, const char_t *omArchVersion)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(omSocVersion, RT_ERROR_INVALID_VALUE);
    if (omSocVersion[0U] == '\0') {
        RT_LOG(RT_LOG_WARNING, "Input omSocVersion is null, please check.");
    }

    const rtArchType_t archType = rtInstance->GetArchType();
    const rtError_t error = apiInstance->ModelCheckArchVersion(omArchVersion, archType);
    if (error != RT_ERROR_NONE) {
        char_t socType[SOC_VERSION_LEN] = {0};
        const rtError_t rtRet = rtGetSocVersion(socType, SOC_VERSION_LEN);
        if (rtRet != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "rtGetSocVersion failed, retCode=%#x", rtRet);
            return ACL_ERROR_RT_INTERNAL_ERROR;
        } else {
            RT_LOG_OUTER_MSG_INVALID_PARAM(omSocVersion, socType);
        }
    }

    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtCheckArchCompatibility(const char_t *omSocVersion, int32_t *canCompatible)
{
    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->CheckArchCompatibility(omSocVersion, canCompatible);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtSetExceptionExtInfo(const rtArgsSizeInfo_t * const sizeInfo)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(sizeInfo, RT_ERROR_INVALID_VALUE);

    rtArgsSizeInfo_t &launchArg = ThreadLocalContainer::GetArgsSizeInfo();
    launchArg.infoAddr = sizeInfo->infoAddr;
    launchArg.atomicIndex = sizeInfo->atomicIndex;
    RT_LOG(RT_LOG_DEBUG, "rtSetExceptionExtInfo success.");
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api *apiInstance = Api::Instance();
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
    Api *apiInstance = Api::Instance();
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
    Api *apiInstance = Api::Instance();
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
    Api *apiInstance = Api::Instance();
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
    Api *apiInstance = Api::Instance();
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
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->UnmapMem(devPtr);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flags, uint64_t *shareableHandle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ExportToShareableHandle(handle, handleType, flags, shareableHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api *apiInstance = Api::Instance();
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
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetPidToShareableHandle(shareableHandle, pid, pidNum);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemGetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option, size_t *granularity)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetAllocationGranularity(prop, option, granularity);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBindHostPid(rtBindHostpidInfo info)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->BindHostPid(info);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtUnbindHostPid(rtBindHostpidInfo info)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->UnbindHostPid(info);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtQueryProcessHostPid(int32_t pid, uint32_t *chipId, uint32_t *vfId, uint32_t *hostPid,
    uint32_t *cpType)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->QueryProcessHostPid(pid, chipId, vfId, hostPid, cpType);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetIpcMemorySuperPodPid(const char *name, uint32_t sdid, int32_t pid[], int32_t num)
{
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ShmemSetPodPid(name, sdid, pid, num);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNeedDevVA2PA(bool *need)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(need, RT_ERROR_INVALID_VALUE);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    *need = false;
    rtChipType_t chipType = rtInstance->GetChipType();
    DevProperties devProperty {};
    rtError_t error = GET_DEV_PROPERTIES(chipType, devProperty);
    COND_RETURN_EXT_ERRCODE_AND_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DRV_INVALID_DEVICE,
        "Failed to get dev properties, chipType = %u", chipType);
    if (devProperty.isSupportDevVA2PA) {
        *need = true;
    }

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDevVA2PA(uint64_t devAddr, uint64_t len, rtStream_t stm, bool isAsync)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    rtChipType_t chipType = rtInstance->GetChipType();
    DevProperties devProperty {};
    rtError_t error = GET_DEV_PROPERTIES(chipType, devProperty);
    COND_RETURN_EXT_ERRCODE_AND_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DRV_INVALID_DEVICE,
        "Failed to get dev properties, chipType = %u", chipType);
    if (!(devProperty.isSupportDevVA2PA)) {
        RT_LOG(RT_LOG_ERROR, "Chip type(%d) does not support.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    error = apiInstance->DevVA2PA(devAddr, len, static_cast<Stream *>(stm), isAsync);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtVectorCoreKernelLaunchWithHandle(void *hdl, const uint64_t tilingKey, uint32_t numBlocks,
    rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();

    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((launchArg.argCount >= (ARG_ENTRY_SIZE / MIN_ARG_SIZE)), RT_ERROR_INVALID_VALUE, 
        launchArg.argCount, "[0, " + std::to_string(ARG_ENTRY_SIZE / MIN_ARG_SIZE) + ")");
    launchArg.stubFunc = nullptr;
    if (launchArg.argCount == 0U) {
        launchArg.argCount = 1U;
        launchArg.argsOffset[0U] = 0U;
    }

    TIMESTAMP_BEGIN(rtKernelLaunchWithHandle);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->KernelLaunchWithHandle(
        hdl, tilingKey, numBlocks, argsInfo, smDesc, static_cast<Stream *>(stm), cfgInfo, true);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtKernelLaunchWithHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtVectorCoreKernelLaunch(const void *stubFunc, uint32_t numBlocks, rtArgsEx_t *argsInfo,
    rtSmDesc_t *smDesc, rtStream_t stm, uint32_t flags, const rtTaskCfgInfo_t *cfgInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();
    launchArg.stubFunc = stubFunc;
    if (launchArg.argCount == 0U) {
        launchArg.argCount = 1U;
        launchArg.argsOffset[0U] = 0U;
    }

    TIMESTAMP_BEGIN(rtKernelLaunch);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t err = apiInstance->KernelLaunch(stubFunc, numBlocks,
        argsInfo, smDesc, exeStream, flags, cfgInfo, true);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtKernelLaunch);
    launchArg.argCount = 0U;
    ERROR_RETURN_WITH_EXT_ERRCODE(err);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtAicpuInfoLoad(const void *aicpuInfo, uint32_t length)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_NAME(__func__);
    const rtError_t ret = apiInstance->AicpuInfoLoad(aicpuInfo, length);

    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtNopTask(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->NopTask(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamClear(rtStream_t stm, rtClearStep_t step)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->StreamClear(exeStream, step);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetServerIDBySDID(uint32_t sdid, uint32_t *srvId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtGetServerIDBySDID);
    const rtError_t error = apiInstance->GetServerIDBySDID(sdid, srvId);
    TIMESTAMP_END(rtGetServerIDBySDID);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCtxGetCurrentDefaultStream(rtStream_t *stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->CtxGetCurrentDefaultStream(RtPtrToPtr<Stream **>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtRegStreamStateCallback(const char_t *regName, rtStreamStateCallback callback)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->RegStreamStateCallback(regName, RtPtrToPtr<void *>(callback),
        nullptr, StreamStateCallback::RT_STREAM_STATE_CALLBACK);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceResetForce(int32_t devId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->DeviceResetForce(devId);
    if (unlikely((error) != RT_ERROR_NONE)) {
        REPORT_FUNC_ERROR_REASON(error);
        return RT_TRANS_EXT_ERRCODE((error));
    }
    return ACL_RT_SUCCESS;
}

// rtGetLastError/rtPeekAtLastError
VISIBILITY_DEFAULT
rtError_t rtGetLastError(rtLastErrLevel_t level)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    COND_RETURN_ERROR((level > RT_CONTEXT_LEVEL) || (level < RT_THREAD_LEVEL), ACL_ERROR_RT_PARAM_INVALID,
        "Invalid level, current level=%d, valid range is [%d, %d].", level,
        RT_CONTEXT_LEVEL, RT_THREAD_LEVEL);
    const rtError_t error = apiInstance->GetLastErr(level);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtPeekAtLastError(rtLastErrLevel_t level)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    COND_RETURN_ERROR((level > RT_CONTEXT_LEVEL) || (level < RT_THREAD_LEVEL), ACL_ERROR_RT_PARAM_INVALID,
        "Invalid level, current level=%d, valid range is [%d, %d].", level,
        RT_CONTEXT_LEVEL, RT_THREAD_LEVEL);
    const rtError_t error = apiInstance->PeekLastErr(level);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtsGetThreadLastTaskId(uint32_t *taskId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->GetThreadLastTaskId(taskId);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsCallbackLaunch(rtCallback_t callBackFunc, void *fnData, rtStream_t stm, bool isBlock)
{
    return rtCallbackLaunch(callBackFunc, fnData, stm, isBlock);
}

VISIBILITY_DEFAULT
rtError_t rtsSubscribeReport(uint64_t threadId, rtStream_t stm)
{
    return rtSubscribeReport(threadId, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsProcessReport(int32_t timeout)
{
    return rtProcessReport(timeout);
}

VISIBILITY_DEFAULT
rtError_t rtsUnSubscribeReport(uint64_t threadId, rtStream_t stm)
{
    return rtUnSubscribeReport(threadId, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsGetInterCoreSyncAddr(uint64_t *addr, uint32_t *len)
{
    return rtGetC2cCtrlAddr(addr, len);
}

VISIBILITY_DEFAULT
rtError_t rtsProfTrace(void *userdata, int32_t length, rtStream_t stream)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(userdata, RT_ERROR_INVALID_VALUE);
    const int32_t dataSize = static_cast<int32_t>(sizeof(rtProfTraceUserData));
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM(((length > dataSize) || (length <= 0)), RT_ERROR_INVALID_VALUE, 
        length, "(0, " + std::to_string(dataSize) + "]");

    rtProfTraceUserData data = {0, 0, 0};
    errno_t ret = memcpy_s(&data, dataSize, userdata, length);
    COND_RETURN_EXT_ERRCODE_AND_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE,
        "Call memcpy_s failed in rtsProfTrace, copy size is %d", dataSize);

    Stream * const exeStream = static_cast<Stream *>(stream);
    const rtError_t error = apiInstance->ProfilerTraceEx(data.id, data.modelId, data.tagId, exeStream);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsCtxGetFloatOverflowAddr(void **overflowAddr)
{
    return rtCtxGetOverflowAddr(overflowAddr);
}

VISIBILITY_DEFAULT
rtError_t rtsGetFloatOverflowStatus(void * const outputAddrPtr, const uint64_t outputSize, rtStream_t stm)
{
    return rtGetDeviceSatStatus(outputAddrPtr, outputSize, stm);
}

VISIBILITY_DEFAULT
rtError_t rtsResetFloatOverflowStatus(rtStream_t stm)
{
    return rtCleanDeviceSatStatus(stm);
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchHostFunc(rtStream_t stm, const rtCallback_t callBackFunc, void * const fnData)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->LaunchHostFunc(static_cast<Stream *>(stm), callBackFunc, fnData);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsRegDeviceStateCallback(const char_t *regName, rtsDeviceStateCallback callback, void *args)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->RegDeviceStateCallback(regName, RtPtrToPtr<void *>(callback),
        args, DeviceStateCallback::RTS_DEVICE_STATE_CALLBACK, DEV_CB_POS_END);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsRegStreamStateCallback(const char_t *regName, rtsStreamStateCallback callback, void *args)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->RegStreamStateCallback(regName, RtPtrToPtr<void *>(callback),
        args, StreamStateCallback::RTS_STREAM_STATE_CALLBACK);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetTaskFailCallback(const char_t *regName, rtsTaskFailCallback callback, void *args)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->RegTaskFailCallbackByModule(regName, RtPtrToPtr<void *>(callback),
        args, TaskFailCallbackType::RTS_SET_TASK_FAIL_CALLBACK);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetDeviceTaskAbortCallback(const char_t *regName, rtsDeviceTaskAbortCallback callback, void *args)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetTaskAbortCallBack(regName, RtPtrToPtr<void *>(callback),
        args, TaskAbortCallbackType::RTS_SET_DEVICE_TASK_ABORT_CALLBACK);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamStop(rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Stream * const exeStream = static_cast<Stream *>(stm);
    const rtError_t error = apiInstance->StreamStop(exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
