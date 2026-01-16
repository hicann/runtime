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
#include "notify.hpp"
#include "prof_map_ge_model_device.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "toolchain/prof_api.h"
#include "prof_acl_api.h"
#include "soc_info.h"
#include "task_abort.hpp"
#include "global_state_manager.hpp"
#include "platform_manager_v2.h"

using namespace cce::runtime;
namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtFftsPlusTaskLaunch);
TIMESTAMP_EXTERN(rtFftsPlusTaskLaunchWithFlag);
TIMESTAMP_EXTERN(CmoAddrTaskLaunch);
TIMESTAMP_EXTERN(CmoTaskLaunch);
}
}

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtWriteValue(rtWriteValueInfo_t * const info, rtStream_t const stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->WriteValue(info, static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}


VISIBILITY_DEFAULT
rtError_t rtWriteValuePtr(void * const writeValueInfo, rtStream_t const stm, void * const pointedAddr)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = 
        apiInstance->WriteValuePtr(writeValueInfo, static_cast<Stream *>(stm), pointedAddr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}


VISIBILITY_DEFAULT
rtError_t rtStreamTaskAbort(rtStream_t stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamTaskAbort(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamRecover(rtStream_t stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamRecover(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamTaskClean(rtStream_t stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamTaskClean(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetModelList(int32_t devId, rtModelList_t *mdlList)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->DeviceGetModelList(devId, mdlList);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceResourceClean(const int32_t devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtError_t error = apiInstance->DeviceResourceClean(devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetBinaryDeviceBaseAddr(void *handle, void **deviceBase)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t ret = apiInstance->GetBinaryDeviceBaseAddr(RtPtrToPtr<Program *>(handle), deviceBase);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

rtError_t rtFftsPlusTaskLaunch(rtFftsPlusTaskInfo_t *fftsPlusTaskInfo, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_FFTS_PLUS)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtFftsPlusTaskLaunch);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->FftsPlusTaskLaunch(fftsPlusTaskInfo, streamPtr, 0U);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtFftsPlusTaskLaunch);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtFftsPlusTaskLaunchWithFlag(rtFftsPlusTaskInfo_t *fftsPlusTaskInfo, rtStream_t stm, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_FFTS_PLUS)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtFftsPlusTaskLaunchWithFlag);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t ret = apiInstance->FftsPlusTaskLaunch(fftsPlusTaskInfo, streamPtr, flag);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtFftsPlusTaskLaunchWithFlag);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtRDMASend(uint32_t sqIndex, uint32_t wqeIndex, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_RDMA)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    const rtError_t error = apiInstance->RDMASend(sqIndex, wqeIndex, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtRDMADBSend(uint32_t dbIndex, uint64_t dbInfo, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const Runtime * const rt = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rt);
    const rtChipType_t chipType = rt->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_RDMA)) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    const rtError_t error = apiInstance->RdmaDbSend(dbIndex, dbInfo, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcSetMemoryName(const void *ptr, uint64_t byteCount, char_t *name, uint32_t len)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcSetMemoryName(ptr, byteCount, name, len, RT_IPC_MEM_FLAG_DEFAULT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcSetMemoryAttr(const char *name, uint32_t type, uint64_t attr)
{
     Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcSetMemoryAttr(name, type, attr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcDestroyMemoryName(const char_t *name)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcDestroyMemoryName(name);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenMemory(void **ptr, const char_t *name)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcOpenMemory(ptr, name, RT_IPC_MEM_FLAG_DEFAULT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcCloseMemory(const void *ptr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcCloseMemory(ptr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcSetNotifyName(rtNotify_t notify, char_t* name, uint32_t len)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    Notify * const notifyPtr = static_cast<Notify *>(notify);
    const rtError_t error = apiInstance->IpcSetNotifyName(notifyPtr, name, len, RT_NOTIFY_FLAG_DEFAULT);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenNotify(rtNotify_t *notify, const char_t *name)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);

    const rtChipType_t chipType = rtInstance->GetChipType();
    COND_RETURN_WARN(!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_IPC_NOTIFY),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcOpenNotify(RtPtrToPtr<Notify **>(notify), name);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenNotifyWithFlag(rtNotify_t *notify, const char_t *name, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);

    const rtChipType_t chipType = rtInstance->GetChipType();
    COND_RETURN_WARN(!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_IPC_NOTIFY),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcOpenNotify(RtPtrToPtr<Notify **>(notify), name, flag);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchSqeUpdateTask(uint32_t streamId, uint32_t taskId, void *src, uint64_t cnt,
                                rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    COND_RETURN_WARN(!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_UPDATE_SQE_TILING_KEY),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "only support in 910_B_93.");

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    Stream * const exeStream = static_cast<Stream *>(stm);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->LaunchSqeUpdateTask(streamId, taskId, src, cnt, exeStream);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtRegKernelLaunchFillFunc(const char* symbol, rtKernelLaunchFillFunc callback)
{
    Runtime *rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    COND_RETURN_WARN((!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_REGISTER_CALLBACK)), 
    ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));
    const rtError_t error = rtInstance->RegKernelLaunchFillFunc(symbol, callback);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtUnRegKernelLaunchFillFunc(const char* symbol)
{
    Runtime *rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    COND_RETURN_WARN((!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_REGISTER_CALLBACK)), 
    ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));
    const rtError_t error = rtInstance->UnRegKernelLaunchFillFunc(symbol);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchKernelExByFuncHandle(rtFuncHandle funcHandle, rtLaunchConfig_t* launchConfig,
    rtLaunchArgsHandle argsHandle, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);

    COND_RETURN_WARN(!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_EX_BY_FUNC_HANDLE),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "chip type(%d) does not support, return.",
        static_cast<int32_t>(rtInstance->GetChipType()));

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(argsHandle, RT_ERROR_INVALID_VALUE);
    rtLaunchArgs_t* args = RtPtrToPtr<rtLaunchArgs_t*>(argsHandle);
    rtArgsEx_t *argsInfo = &(args->argsInfo);
    const rtError_t ret = apiInstance->LaunchKernelV3(RtPtrToPtr<Kernel *>(funcHandle), argsInfo,
        static_cast<Stream *>(stm), launchConfig);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchReduceAsyncTask(const rtReduceInfo_t *reduceInfo, const rtStream_t stm, const void *reserve)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((reserve != nullptr), RT_ERROR_INVALID_VALUE, "reserve only support nullptr.");
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(reduceInfo, RT_ERROR_INVALID_VALUE);
    const auto rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    rtError_t ret = RT_ERROR_NONE;
    DevProperties properties;
    auto error = GET_DEV_PROPERTIES(rtInstance->GetChipType(), properties);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "GetDevProperties failed.");
    if (properties.reduceOverflow == ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCE_V2_ID ||
        properties.reduceOverflow == ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCV2_SUPPORT_DC) {
        void *overflowAddr = nullptr;
        ret = apiInstance->CtxGetOverflowAddr(&overflowAddr);
        ERROR_RETURN_WITH_EXT_ERRCODE(ret);
        ret = apiInstance->ReduceAsyncV2(reduceInfo->dst, reduceInfo->src, reduceInfo->count, reduceInfo->kind,
            reduceInfo->type, static_cast<Stream *>(stm), overflowAddr);
        ERROR_RETURN_WITH_EXT_ERRCODE(ret);

        return ACL_RT_SUCCESS;
    }

    ret = apiInstance->ReduceAsync(reduceInfo->dst, reduceInfo->src, reduceInfo->count,
        reduceInfo->kind, reduceInfo->type, static_cast<Stream *>(stm), nullptr);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchUpdateTask(rtStream_t destStm, uint32_t destTaskId, rtStream_t stm, rtTaskUpdateCfg_t *cfg)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(cfg, RT_ERROR_INVALID_VALUE);

    rtError_t error = RT_ERROR_NONE;
    const rtUpdateTaskAttrId updateType = cfg->id;
    switch (updateType) {
        case RT_UPDATE_DSA_TASK: {
            PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(destStm, RT_ERROR_INVALID_VALUE);
            Stream *const destStream = RtPtrToPtr<Stream *>(destStm);

            const Runtime * const rtInstance = Runtime::Instance();
            NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
            if (!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_DSA_UPDATE)) {
                RT_LOG(RT_LOG_WARNING, "only support in 910_B_93");
                return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
            }

            Api * const apiInstance = Api::Instance();
            NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

            Stream * const exeStream = RtPtrToPtr<Stream *>(stm);
            const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
            (void)AwdStartThreadWatchdog(watchDogHandle);
            error = apiInstance->LaunchSqeUpdateTask(static_cast<uint32_t>(destStream->Id_()), destTaskId, cfg->val.dsaTaskAttr.srcAddr, cfg->val.dsaTaskAttr.size, exeStream, true);
            (void)AwdStopThreadWatchdog(watchDogHandle);
            ERROR_RETURN_WITH_EXT_ERRCODE(error);
            break;
        }
        case RT_UPDATE_AIC_AIV_TASK: {
            rtMdlTaskUpdateInfo_t para = {};
            para.tilingKeyAddr = RtPtrToPtr<uint64_t *>(cfg->val.aicAivTaskAttr.funcEntryAddr);
            para.blockDimAddr = RtPtrToPtr<uint64_t *>(cfg->val.aicAivTaskAttr.blockDimAddr);
            para.hdl = cfg->val.aicAivTaskAttr.binHandle;
            para.fftsPlusTaskInfo = nullptr;
            error = rtModelTaskUpdate(destStm, destTaskId, stm, &para);
            break;
        }
        default:
            error = RT_ERROR_INVALID_VALUE;
            RT_LOG_OUTER_MSG_INVALID_PARAM(cfg->id, "[1, " + std::to_string(RT_UPDATE_MAX) + ")");
            break;
    }

    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetCmoDescSize(size_t *size)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_CMO)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetCmoDescSize(size);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_CMO)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetCmoDesc(cmoDesc, srcAddr, srcLen);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchCmoAddrTask(rtCmoDesc_t cmoDesc, rtStream_t stm, rtCmoOpCode cmoOpCode, const void *reserve)
{
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((reserve != nullptr), RT_ERROR_INVALID_VALUE, "reserve only support nullptr.");

    DevProperties properties;
    auto error = GET_DEV_PROPERTIES(Runtime::Instance()->GetChipType(), properties);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "GetDevProperties failed.");
    const uint64_t sizeMax = properties.cmoDDRStructInfoSize;

    return rtCmoAddrTaskLaunch(cmoDesc, sizeMax, cmoOpCode, stm, 0U);
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceGetInfo(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetDeviceInfoByAttr(deviceId, attr, val);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCmoAddrTaskLaunch(void *cmoAddrInfo, uint64_t destMax, rtCmoOpCode_t cmoOpCode,
    rtStream_t stm, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    // cmoAddrInfo must be 64-byte aligned. (Stars Software Constraints Manual)
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    DevProperties properties;
    (void)GET_DEV_PROPERTIES(rtInstance->GetChipType(), properties);
    if (properties.cmoDDRStructInfoSize == 0) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    TIMESTAMP_BEGIN(CmoAddrTaskLaunch);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->CmoAddrTaskLaunch(cmoAddrInfo, destMax, cmoOpCode, streamPtr, flag);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(CmoAddrTaskLaunch);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelTaskUpdate(rtStream_t desStm, uint32_t desTaskId, rtStream_t sinkStm,
                            rtMdlTaskUpdateInfo_t *para)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api *apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->ModelTaskUpdate(static_cast<Stream *>(desStm), desTaskId,
                                                         static_cast<Stream *>(sinkStm), para);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsyncV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
                          rtDataType_t type, rtStream_t stm, void *overflowAddr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    UNUSED(destMax);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    DevProperties properties;
    auto error = GET_DEV_PROPERTIES(rtInstance->GetChipType(), properties);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "GetDevProperties failed.");
    if (properties.reduceOverflow != ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCE_V2_ID &&
        properties.reduceOverflow != ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCV2_SUPPORT_DC) {
        REPORT_FUNC_ERROR_REASON(RT_ERROR_FEATURE_NOT_SUPPORT);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    error = apiInstance->ReduceAsyncV2(dst, src, cnt, kind, type, exeStream, overflowAddr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamCreateWithFlagsExternal(rtStream_t *stm, int32_t priority, uint32_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    COND_RETURN_OUT_ERROR_MSG_CALL((priority != RT_STREAM_GREATEST_PRIORITY) &&
        (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_STREAM_CREATE_PRIORITY_GREATEST)),
        GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE),
        "chipType=%d not support set priority, priority=%d.",
        chipType, priority);

    return rtStreamCreateWithFlags(stm, priority, flags);
}

VISIBILITY_DEFAULT
rtError_t rtModelGetNodes(rtModel_t mdl, uint32_t * const num)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelGetNodes(static_cast<Model *>(mdl), num);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelDebugDotPrint(rtModel_t mdl)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelDebugDotPrint(static_cast<Model *>(mdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtModelDebugJsonPrint(rtModel_t mdl, const char* path, uint32_t flags)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_JSON_PRINT)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ModelDebugJsonPrint(static_cast<Model *>(mdl), path, flags);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamAddToModel(rtStream_t stm, rtModel_t captureMdl)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamAddToModel(static_cast<Stream *>(stm), static_cast<Model *>(captureMdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamBeginCapture(rtStream_t stm, const rtStreamCaptureMode mode)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamBeginCapture(static_cast<Stream *>(stm), mode);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamEndCapture(rtStream_t stm, rtModel_t *captureMdl)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamEndCapture(static_cast<Stream *>(stm),
                                                          RtPtrToPtr<Model **>(captureMdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtStreamGetCaptureInfo(rtStream_t stm, rtStreamCaptureStatus * const status,
                                 rtModel_t *captureMdl)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    const static bool isSupportAclGraph = IS_SUPPORT_CHIP_FEATURE(chipType,
        RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH);
    if (!isSupportAclGraph) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support, return.",
            static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamGetCaptureInfo(static_cast<Stream *>(stm), status,
                                                              RtPtrToPtr<Model **>(captureMdl));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmoType, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime *const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    COND_RETURN_WARN((!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_CMO)),
                     ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "chip type(%d) does not support, return.",
                     static_cast<int32_t>(chipType));

    // support prefetch, write back, invalid, flush
    const bool isSupport = (cmoType == RT_CMO_PREFETCH) || (cmoType == RT_CMO_WRITEBACK) ||
                           (cmoType == RT_CMO_INVALID) || (cmoType == RT_CMO_FLUSH);
    COND_RETURN_WARN(!isSupport, ACL_ERROR_RT_FEATURE_NOT_SUPPORT,
        "cmoType(%d) does not support, support[PREFETCH, WRITEBACK, INVALID, FLUSH], return.",
        static_cast<int32_t>(cmoType));

    COND_RETURN_ERROR(srcAddrPtr == nullptr, ACL_ERROR_RT_PARAM_INVALID, "srcAddPtr is nullptr.");
    COND_RETURN_ERROR(srcLen == 0, ACL_ERROR_RT_PARAM_INVALID, "srcLen must be bigger than 0, but srcLen is zero.");

    rtCmoTaskInfo_t taskInfo = {};
    taskInfo.opCode = cmoType;
    taskInfo.lengthInner = static_cast<uint32_t>(srcLen);
    taskInfo.sourceAddr = RtPtrToValue(srcAddrPtr);

    return rtCmoTaskLaunch(&taskInfo, stm, 0);
}


VISIBILITY_DEFAULT
rtError_t rtCmoTaskLaunch(rtCmoTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_CMO) &&
        !IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_ASYNC_CMO)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) not support, return.", static_cast<int32_t>(chipType));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    Stream * const streamPtr = static_cast<Stream *>(stm);
    TIMESTAMP_BEGIN(CmoTaskLaunch);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->CmoTaskLaunch(taskInfo, streamPtr, flag);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(CmoTaskLaunch);
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_CMO_DOT_NO_LOG)) {
        COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    }
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsync(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
                        rtDataType_t type, rtStream_t stm)
{
    UNUSED(destMax);
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->ReduceAsync(dst, src, cnt, kind, type, exeStream, nullptr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsyncWithCfg(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
    rtDataType_t type, rtStream_t stm, uint32_t qosCfg)
{
    UNUSED(destMax);
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    rtTaskCfgInfo_t cfgInfo = {};
    cfgInfo.qos = static_cast<uint8_t>(qosCfg & 0xFU); // 0xf is value mask, and move right 8 bits
    cfgInfo.partId = static_cast<uint8_t>((qosCfg & 0xFF0U) >> 4U); // 0xff0 is value mask, and move right 4 bits

    const rtError_t error = apiInstance->ReduceAsync(dst, src, cnt, kind, type, exeStream, &cfgInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsyncWithCfgV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
    rtDataType_t type, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    UNUSED(destMax);
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Stream * const exeStream = static_cast<Stream *>(stm);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    const rtError_t error = apiInstance->ReduceAsync(dst, src, cnt, kind, type, exeStream, cfgInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyAsyncWithOffset(void **dst, uint64_t dstMax, uint64_t dstDataOffset, const void **src,
    uint64_t cnt, uint64_t srcDataOffset, rtMemcpyKind kind, rtStream_t stm)
{
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((kind != RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE), RT_ERROR_INVALID_VALUE,
        "Invalid kind, current kind must be %d.", RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE);
    return rtMemcpyD2DAddrAsync(RtPtrToPtr<void *>(dst), dstMax, dstDataOffset,
        RtPtrToPtr<void *>(src), cnt, srcDataOffset, stm);
}

VISIBILITY_DEFAULT
rtError_t rtIpcMemImportPidInterServer(const char *key, const rtServerPid *serverPids, size_t num)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(key, RT_ERROR_INVALID_VALUE);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(serverPids, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((num == 0UL), RT_ERROR_INVALID_VALUE,
        "Invalid userdata, the parameter num cannot be zero.");

    for (size_t i = 0; i < num; i++) {
        COND_RETURN_ERROR_WITH_EXT_ERRCODE((serverPids[i].pid == nullptr), RT_ERROR_INVALID_VALUE,
            "Invalid userdata, the parameter serverPids[%zu].pid cannot be a null pointer.", i);
        const rtError_t ret = rtSetIpcMemorySuperPodPid(key, serverPids[i].sdid, serverPids[i].pid,
            static_cast<int32_t>(serverPids[i].num & INT32_MAX));
        if (ret != ACL_RT_SUCCESS) {
            return ret;
        }
    }

    return ACL_RT_SUCCESS;
}


VISIBILITY_DEFAULT
rtError_t rtNotifySetImportPidInterServer(rtNotify_t notify, const rtServerPid *serverPids, size_t num)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(notify, RT_ERROR_INVALID_VALUE);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(serverPids, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((num == 0UL), RT_ERROR_INVALID_VALUE,
        "Invalid userdata, the parameter num cannot be zero.");
        
    Notify * const notifyPtr = static_cast<Notify *>(notify);
    for (size_t i = 0; i < num; i++) {
        COND_RETURN_ERROR_WITH_EXT_ERRCODE((serverPids[i].pid == nullptr), RT_ERROR_INVALID_VALUE,
            "Invalid userdata, the parameter serverPids[%zu].pid cannot be a null pointer.", i);
        COND_RETURN_ERROR_WITH_EXT_ERRCODE((serverPids[i].num != 1UL), RT_ERROR_INVALID_VALUE,
            "Invalid userdata, the parameter serverPids[%zu].num must be 1.", i);
        const rtError_t ret = rtSetIpcNotifySuperPodPid(notifyPtr->GetIpcName().c_str(), serverPids[i].sdid, serverPids[i].pid[0U]);
        if (ret != ACL_RT_SUCCESS) {
            return ret;
        }
    }

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsPersistentTaskClean(rtStream_t stm)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->StreamTaskClean(static_cast<Stream *>(stm));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetXpuDevice(rtXpuDevType devType, const uint32_t devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetXpuDevice(devType, devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtResetXpuDevice(rtXpuDevType devType, const uint32_t devId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ResetXpuDevice(devType, devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
   Api * const apiInstance = Api::Instance();
   NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
   const rtError_t ret = apiInstance->CacheLastTaskOpInfo(infoPtr, infoSize);
   ERROR_RETURN_WITH_EXT_ERRCODE(ret);
   return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventWorkModeSet(uint8_t mode)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_VALUE_WAIT)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support rtEventWorkModeSet api.", chipType);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EventWorkModeSet(mode);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtEventWorkModeGet(uint8_t *mode)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_VALUE_WAIT)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support rtEventWorkModeGet api.", chipType);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->EventWorkModeGet(mode);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcGetEventHandle(rtEvent_t event, rtIpcEventHandle_t *handle)
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_IPC_EVENT)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support rtIpcGetEventHandle api.", chipType);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    IpcEvent * const eventPtr = static_cast<IpcEvent *>(event);
    const rtError_t error = apiInstance->IpcGetEventHandle(eventPtr, handle);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenEventHandle(rtIpcEventHandle_t handle, rtEvent_t *event)
{
    RT_LOG(RT_LOG_INFO, "rtIpcOpenEventHandle start");
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_IPC_EVENT)) {
        RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support rtIpcOpenEventHandle api.", chipType);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    rtIpcEventHandle_t *eventHandle = &handle;
    const rtError_t error = apiInstance->IpcOpenEventHandle(eventHandle, RtPtrToPtr<IpcEvent **>(event));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    RT_LOG(RT_LOG_INFO, "rtIpcOpenEventHandle end");
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtFunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->FunctionGetAttribute(funcHandle, attrType, attrValue);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtGetSocSpec(const char* label, const char* key, char* val, const uint32_t maxLen)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(label, RT_ERROR_INVALID_VALUE);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(key, RT_ERROR_INVALID_VALUE);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(val, RT_ERROR_INVALID_VALUE);

    char_t socVersion[SOC_VERSION_LEN] = {};
    const auto error = rtGetSocVersion(socVersion, static_cast<uint32_t>(sizeof(socVersion)));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    std::string result = "";
    const uint32_t ret = PlatformManagerV2::Instance().GetSocSpec(std::string(socVersion), std::string(label),
        std::string(key), result);
    if (ret != RT_ERROR_NONE) {
        if (ret == 0xFFFFFFFFU) {
            RT_LOG(RT_LOG_WARNING, "No platform info found from GetSocSpec.");
            return ret;
        }
        RT_LOG(RT_LOG_ERROR, "Get soc spec failed, ret = %u, please check.", ret);
        ERROR_RETURN_WITH_EXT_ERRCODE(RT_ERROR_DEVICE_PLATFORM);
    }

    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((maxLen < (result.size() + 1U)), RT_ERROR_INVALID_VALUE, maxLen,
        "maxLen should be larger than size of query result");

    const errno_t rtn = memcpy_s(val, maxLen, result.c_str(), result.size() + 1U);
    COND_RETURN_ERROR_WITH_EXT_ERRCODE((ret != EOK), RT_ERROR_INVALID_VALUE,
        "Get soc spec, memcpy failed, retCode=%#x", static_cast<uint32_t>(rtn));
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
