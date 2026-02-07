/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_impl_david.hpp"
#include "context.hpp"
#include "stream_c.hpp"
#include "aix_c.hpp"
#include "aicpu_c.hpp"
#include "fusion_c.hpp"
#include "dvpp_c.hpp"
#include "event_c.hpp"
#include "memcpy_c.hpp"
#include "notify_c.hpp"
#include "count_notify.hpp"
#include "event_david.hpp"
#include "model_c.hpp"
#include "cond_c.hpp"
#include "profiler_c.hpp"
#include "coredump_c.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "device_msg_handler.hpp"
#include "task_david.hpp"
#include "task_recycle.hpp"
#include "fast_recover.hpp"
#include "device/device_error_info.hpp"
#include "capture_model_utils.hpp"
#include "capture_adapt.hpp"
#include "base_david.hpp"
#include "stars_common_task.h"
#include "args_handle_allocator.hpp"
#include "para_convertor.hpp"
#include "runtime/kernel.h"
#include "starsv2_base.hpp"
namespace cce {
namespace runtime {

rtError_t ApiImplDavid::KernelLaunch(const void * const stubFunc, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    UNUSED(l2ctrl);
    COND_RETURN_WARN(isLaunchVec, RT_ERROR_FEATURE_NOT_SUPPORT, "chip type(%d) does not support.",
        static_cast<int32_t>(Runtime::Instance()->GetChipType()));
    RT_LOG(RT_LOG_DEBUG, "Launch kernel, stubFunc=%p, blockDim=%u.", stubFunc, coreDim);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    return StreamLaunchKernelV1(stubFunc, coreDim, argsInfo, curStm, flag, cfgInfo);
}

rtError_t ApiImplDavid::KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    UNUSED(l2ctrl);
    COND_RETURN_WARN(isLaunchVec, RT_ERROR_FEATURE_NOT_SUPPORT, "chip type(%d) does not support.",
        static_cast<int32_t>(Runtime::Instance()->GetChipType()));
    RT_LOG(RT_LOG_DEBUG, "Launch kernel with hdl, blockDim=%u, tilingKey=%" PRIu64, coreDim, tilingKey);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch with handle failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    uint32_t flag = RT_KERNEL_DEFAULT;
    if ((cfgInfo != nullptr) &&
        ((cfgInfo->dumpflag == RT_KERNEL_DUMPFLAG) || (cfgInfo->dumpflag == RT_FUSION_KERNEL_DUMPFLAG))) {
        flag = static_cast<uint32_t>(cfgInfo->dumpflag);
        RT_LOG(RT_LOG_WARNING, "dumpflag set %u.", flag);
    }

    return StreamLaunchKernelWithHandle(hdl, tilingKey, coreDim, argsInfo, curStm, flag, cfgInfo);
}

rtError_t ApiImplDavid::LaunchKernel(Kernel * const kernel, uint32_t blockDim, const rtArgsEx_t * const argsInfo,
    Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    RT_LOG(RT_LOG_DEBUG, "Launch kernel, blockDim=%u", blockDim);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch with handle failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    if (!kernel->Program_()->IsDeviceSoAndNameValid(curCtx->Device_()->Id_())) {
        RT_LOG(RT_LOG_WARNING, "kernel is invalid, device_id=%d", curCtx->Device_()->Id_());
        return RT_ERROR_KERNEL_INVALID;
    }
    rtStreamLaunchKernelV2ExtendArgs_t launchKernelExtendArgs = {};
    ConstructStreamLaunchKernelV2ExtendArgs(argsInfo, cfgInfo, nullptr, nullptr, &launchKernelExtendArgs);
    return StreamLaunchKernelV2(kernel, blockDim, curStm, &launchKernelExtendArgs);
}

rtError_t ApiImplDavid::CpuKernelLaunchExAll(const Kernel * const kernel, const uint32_t coreDim,
    rtCpuKernelArgs_t *argsInfo, Stream * const stm, const TaskCfg * const taskCfg)
{
    // 由于tv是可选配置，可以通过有没有timeout可选配置来弱化RT_KERNEL_USE_SPECIAL_TIMEOUT的kernel flag
    // 对外不提供kernel flag, 如果taskCfg.extend.timeout为0时，代表永不超时, 在等于0时，flag直接退化默认为RT_KERNEL_DEFAULT
    uint32_t flag = RT_KERNEL_DEFAULT;
    if (taskCfg->isBaseValid == 1U) {
        flag |= taskCfg->base.dumpflag;
    }

    const uint32_t kernelType = kernel->KernelType_();
    if ((kernelType != KERNEL_TYPE_FWK) &&
        (kernelType != KERNEL_TYPE_AICPU) &&
        (kernelType != KERNEL_TYPE_AICPU_CUSTOM) &&
        (kernelType != KERNEL_TYPE_AICPU_KFC)) {
        RT_LOG(RT_LOG_ERROR, "kernel type mismatch kernelType=%u.", kernelType);
        return RT_ERROR_KERNEL_TYPE;
    }

    const rtError_t error = StreamLaunchCpuKernelExWithArgs(coreDim,
        static_cast<const rtAicpuArgsEx_t* const>(&argsInfo->baseArgs), taskCfg, stm,
        flag, kernelType, kernel, argsInfo->cpuParamHeadOffset);

    ERROR_RETURN_MSG_INNER(error, "Cpu kernel launch ex with args failed, check and start tsd open aicpu sd error=%#x.", error);
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::LaunchKernelByHandle(Kernel * const kernel, uint32_t blockDim, const RtArgsHandle * const argHandle,
    Stream * const curStm, const TaskCfg &taskCfg)
{
    COND_RETURN_ERROR(argHandle == nullptr, RT_ERROR_INVALID_VALUE, "args handle is nullptr");

    rtError_t error = RT_ERROR_NONE;
    const KernelRegisterType regType = kernel->GetKernelRegisterType();
    const uint8_t phNum = argHandle->placeHolderNum;
    // Cpu kernel
    if (regType == RT_KERNEL_REG_TYPE_CPU) {
        rtCpuKernelArgs_t cpuKernelArgs = {};

        if (phNum <= SPECIAL_ARGS_MAX_CNT) {
            rtHostInputInfo_t hostArgsInfos[SPECIAL_ARGS_MAX_CNT] = {};
            error = ConvertCpuArgsByArgsHandle(cpuKernelArgs, argHandle, hostArgsInfos, SPECIAL_ARGS_MAX_CNT);
            ERROR_RETURN_MSG_INNER(error, "convert args failed, error=%#x", static_cast<uint32_t>(error));
            return CpuKernelLaunchExAll(kernel, blockDim, &cpuKernelArgs, curStm, &taskCfg);
        }
        rtHostInputInfo_t *hostArgsInfos = new (std::nothrow) rtHostInputInfo_t[phNum];
        COND_RETURN_ERROR(hostArgsInfos == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "new specialArgsInfos failed,phNum=%u", phNum);
        error = ConvertCpuArgsByArgsHandle(cpuKernelArgs, argHandle, hostArgsInfos, phNum);
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_A(hostArgsInfos), "covert args failed.");
        error = CpuKernelLaunchExAll(kernel, blockDim, &cpuKernelArgs, curStm, &taskCfg);
        DELETE_A(hostArgsInfos);
        ERROR_RETURN_MSG_INNER(error, "launch kernel failed, error=%#x", static_cast<uint32_t>(error));

        return RT_ERROR_NONE;
    }

    // Non Cpu Kernel
    rtArgsEx_t argsInfo = {};
    if (phNum <= SPECIAL_ARGS_MAX_CNT) {
        rtHostInputInfo_t specialArgsInfos[SPECIAL_ARGS_MAX_CNT];
        error = ConvertArgsByArgsHandle(argsInfo, argHandle, specialArgsInfos, SPECIAL_ARGS_MAX_CNT);
        ERROR_RETURN_MSG_INNER(error, "convert args failed, error=%#x", error);
        rtStreamLaunchKernelV2ExtendArgs_t launchKernelExtendArgs = {};
        ConstructStreamLaunchKernelV2ExtendArgs(&argsInfo, nullptr, nullptr, &taskCfg, &launchKernelExtendArgs);
        return StreamLaunchKernelV2(kernel, blockDim, curStm, &launchKernelExtendArgs);
    }

    rtHostInputInfo_t *hostArgsInfos = new (std::nothrow) rtHostInputInfo_t[phNum];
    COND_RETURN_ERROR(
        hostArgsInfos == nullptr, RT_ERROR_MEMORY_ALLOCATION, "new specialArgsInfos failed,phNum=%u", phNum);
    error = ConvertArgsByArgsHandle(argsInfo, argHandle, hostArgsInfos, phNum);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_A(hostArgsInfos), "covert args failed.");
    rtStreamLaunchKernelV2ExtendArgs_t launchKernelExtendArgs = {};
    ConstructStreamLaunchKernelV2ExtendArgs(&argsInfo, nullptr, nullptr, &taskCfg, &launchKernelExtendArgs);
    error = StreamLaunchKernelV2(kernel, blockDim, curStm, &launchKernelExtendArgs);
    DELETE_A(hostArgsInfos);
    ERROR_RETURN_MSG_INNER(error, "launch kernel failed, error=%#x", error);

    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
    Stream * const stm, const rtLaunchConfig_t * const launchConfig)
{
    rtError_t error = RT_ERROR_NONE;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Launch kernelV2 failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    if (!kernel->Program_()->IsDeviceSoAndNameValid(curCtx->Device_()->Id_())) {
        RT_LOG(RT_LOG_WARNING, "kernel is invalid, device_id=%d", curCtx->Device_()->Id_());
        return RT_ERROR_KERNEL_INVALID;
    }
    LaunchTaskCfgInfo_t launchTaskCfg;
    (void)memset_s(&launchTaskCfg, sizeof(LaunchTaskCfgInfo_t), 0, sizeof(LaunchTaskCfgInfo_t));
    error = GetLaunchConfigInfo(launchConfig, &launchTaskCfg);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Kernel launch GetLaunchConfigInfo failed, stream_id=%d.", curStm->Id_());
    rtStreamLaunchKernelV2ExtendArgs_t launchKernelExtendArgs = {};
    ConstructStreamLaunchKernelV2ExtendArgs(argsInfo, nullptr, &launchTaskCfg, nullptr, &launchKernelExtendArgs);
    return StreamLaunchKernelV2(kernel, launchTaskCfg.blockDim, curStm, &launchKernelExtendArgs);
}

rtError_t ApiImplDavid::KernelLaunchEx(const char_t * const opName, const void * const args, const uint32_t argsSize,
    const uint32_t flags, Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "Launch kernel ex, opName=%s, argsSize=%u, flags=%u.", opName, argsSize, flags);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch(extend) failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    return StreamLaunchKernelEx(args, argsSize, flags, curStm);
}

rtError_t ApiImplDavid::CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag)
{
    UNUSED(l2ctrl);
    RT_LOG(RT_LOG_DEBUG, "Launch cpu kernel, soName=%s, kernelName=%s, opName=%s, blockDim=%u, argsSize=%u, "
        "hostInputInfoNum=%hu, flag=%u.", launchNames->soName, launchNames->kernelName, launchNames->opName, coreDim,
        argsInfo->argsSize, argsInfo->hostInputInfoNum, flag);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Cpu kernel launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null.");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Cpu kernel launch failed, check and start tsd open aicpu sd error.");
    return StreamLaunchCpuKernel(launchNames, coreDim, argsInfo, curStm, flag);
}

rtError_t ApiImplDavid::CpuKernelLaunchExWithArgs(const char_t * const opName, const uint32_t coreDim,
    const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const uint32_t kernelType)
{
    UNUSED(l2ctrl);
    RT_LOG(RT_LOG_DEBUG, "Launch cpu kernel ex, opName=%s, blockDim=%u, argsSize=%u, hostInputInfoNum=%hu, "
        "flag=%u, kernelType=%u, isNoNeedH2DCopy=%u.", opName, coreDim, argsInfo->argsSize, argsInfo->hostInputInfoNum,
        flag, kernelType, argsInfo->isNoNeedH2DCopy);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Cpu kernel launch ex failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null.");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Cpu kernel launch failed, check and start tsd open aicpu sd error.");
    return StreamLaunchCpuKernelExWithArgs(coreDim, argsInfo, nullptr, curStm, flag, kernelType, nullptr);
}

rtError_t ApiImplDavid::FusionLaunch(void * const fusionInfo, Stream * const stm, rtFusionArgsEx_t *argsInfo)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Fusion launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    return LaunchFusionKernel(curStm, fusionInfo, argsInfo);
}

rtError_t ApiImplDavid::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "CCU launch failed, stream is not in current ctx.");
    return StreamCCULaunch(curStm, taskInfo);
}

rtError_t ApiImplDavid::UbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);

    return NpuDriver::QueryUbInfo(dev->Id_(), cmd, devInfo);
}

rtError_t ApiImplDavid::GetDevResAddress(const rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    uint64_t resAddr = 0U;
    uint32_t len = 0U;

    const rtError_t error = NpuDriver::GetDevResAddress(dev->Id_(), resInfo, &resAddr, &len);
    if (error == RT_ERROR_NONE) {
        *(addrInfo->resAddress) = resAddr;
        *(addrInfo->len) = len;
    }

    return error;
}

rtError_t ApiImplDavid::ReleaseDevResAddress(rtDevResInfo * const resInfo)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);

    return NpuDriver::ReleaseDevResAddress(dev->Id_(), resInfo);
}

rtError_t ApiImplDavid::CmoTaskLaunch(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm, const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "Cmo task launch, opCode=%hu, lengthInner=%u", taskInfo->opCode, taskInfo->lengthInner);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");
    
    COND_RETURN_WARN((curStm->Model_() != nullptr), RT_ERROR_FEATURE_NOT_SUPPORT,
        "CMO task stream does not support in model.");
    return CmoTaskLaunchForDavid(taskInfo, curStm, flag);
}

rtError_t ApiImplDavid::CmoAddrTaskLaunch(void *cmoAddrInfo, const uint64_t destMax,
    const rtCmoOpCode_t cmoOpCode, Stream * const stm, const uint32_t flag)
{
    UNUSED(destMax);
    UNUSED(flag);
    RT_LOG(RT_LOG_DEBUG, "Cmo addr task launch, opCode=%d.", cmoOpCode);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");

    return CmoAddrTaskLaunchForDavid(static_cast<rtDavidCmoAddrInfo *>(cmoAddrInfo), cmoOpCode, curStm);
 }

rtError_t ApiImplDavid::EventCreate(Event ** const evt, const uint64_t flag)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");

    *evt = new (std::nothrow) DavidEvent(dev, flag, curCtx);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *evt == nullptr, RT_ERROR_EVENT_NEW, "new event failed.");

    if (flag == RT_EVENT_DEFAULT) { // default flag not alloc id in create.
        return RT_ERROR_NONE;
    }

    const rtError_t error = (*evt)->GenEventId();
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_O(*evt);,
        "Gen event id failed, device_id=%u, tsId=%u, retCode=%#x",
        dev->Id_(), dev->DevGetTsId(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::EventCreateEx(Event ** const evt, const uint64_t flag)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");
    *evt = new (std::nothrow) DavidEvent(dev, flag, curCtx, true);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *evt == nullptr, RT_ERROR_EVENT_NEW, "new event failed.");
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::EventDestroy(Event *evt)
{
    RT_LOG(RT_LOG_INFO, "event destroy event_id=%d.", evt->EventId_());
    TryToFreeEventIdAndDestroyEvent(&evt, evt->EventId_(), true);
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::GetCaptureEvent(const Stream * const stm, Event * const evt, Event ** const captureEvt)
{
    std::lock_guard<std::mutex> lock(evt->GetCaptureMutex());
    Event *curEvent = evt->GetCaptureEvent();
    if (curEvent != nullptr) {
        RT_LOG(RT_LOG_INFO, "Capture event has been created, event_id=[%d->%d].",
            evt->EventId_(), curEvent->EventId_());
        *captureEvt = curEvent;
        return RT_ERROR_NONE;
    }

    Stream *captureStm = stm->GetCaptureStream();
    COND_RETURN_ERROR_MSG_INNER((captureStm == nullptr), RT_ERROR_STREAM_NULL,
        "Capture stream is invalid, stream_id=%d, event_id=%d.", stm->Id_(), evt->EventId_());

    Model* mdl = captureStm->Model_();
    COND_RETURN_ERROR_MSG_INNER((mdl == nullptr), RT_ERROR_MODEL_NULL,
        "Capture model is invalid, stream_id=[%d->%d], event_id=%d.", stm->Id_(), captureStm->Id_(), evt->EventId_());

    Event *newEvent = nullptr;
    rtError_t error;
    if (evt->IsNewMode()) {
        error = EventCreate(&newEvent, RT_EVENT_DEFAULT);
    } else {
        error = EventCreate(&newEvent, RT_EVENT_WITH_FLAG);
    }
    COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE || newEvent == nullptr), error,
        "Create capture event failed, stream_id=[%d->%d], event_id=%d, error=%d.",
        stm->Id_(), captureStm->Id_(), evt->EventId_(), error);

    evt->SetCaptureEvent(newEvent);
    CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(mdl);
    captureMdl->InsertSingleOperEvent(evt);
    newEvent->SetCaptureStream(captureStm);
    captureMdl->InsertCaptureEvent(newEvent);

    RT_LOG(RT_LOG_INFO, "Capture event_id=[%d->%d], model_id=%u, stream_id=[%d->%d].",
        evt->EventId_(), newEvent->EventId_(), captureMdl->Id_(), stm->Id_(), captureStm->Id_());
    *captureEvt = newEvent;
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::CaptureRecordEvent(Context * const ctx, Event * const evt, Stream * const stm)
{
    Stream *captureStm = nullptr;
    rtError_t error = GetCaptureStream(ctx, stm, evt, &captureStm);
    ERROR_RETURN_MSG_INNER(error, "Create capture stream failed, stream_id=%d, event_id=%d, error=%d.",
            stm->Id_(), evt->EventId_(), error);

    Event *captureEvt = nullptr;
    error = GetCaptureEvent(stm, evt, &captureEvt);
    ERROR_RETURN_MSG_INNER(error, "Create capture event failed, stream_id=%d, event_id=%d, error=%d.",
        stm->Id_(), evt->EventId_(), error);

    COND_RETURN_ERROR_MSG_INNER(IsCrossCaptureModel(captureEvt, captureStm),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture event and capture stream is cross-model.");

    error = EvtRecord(captureEvt, stm);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,
            "Stream record capture event failed, stream_id=[%d->%d], error=%d.",
            stm->Id_(), captureStm->Id_(), error);
    } else {
        const Stream * const newCaptureStm = stm->GetCaptureStream();
        RT_LOG(RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].",
            stm->Id_(), newCaptureStm->Id_(), evt->EventId_(), captureEvt->EventId_());
    }

    return error;
}

rtError_t ApiImplDavid::EventRecord(Event * const evt, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream * const curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    const bool supportFlag = (evt->IsNewMode() || (evt->GetEventFlag() == RT_EVENT_DEFAULT)) &&
        (curStm->GetModelNum() != 0);
    COND_RETURN_WARN(supportFlag, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support current mode bind stm, mode=%d, flag=%" PRIu64 ", isModel=%d.",
        evt->IsNewMode(), evt->GetEventFlag(), (curStm->GetModelNum() != 0));
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Event record failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    if (evt->ToBeCaptured(curStm)) {
        COND_RETURN_WARN(!evt->IsNewMode(), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support call rtEventCreate or rtEventCreateWithFlag without external flag, mode=%d",
        evt->IsNewMode());
        COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(curStm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", curStm->Flags());
        COND_RETURN_ERROR_MSG_INNER(curStm == curCtx->DefaultStream_(),
            RT_ERROR_STREAM_CAPTURE_IMPLICIT,
            "A disallowed implicit dependency from default stream.");
        COND_RETURN_WARN(evt->IsEventWithoutWaitTask(), RT_ERROR_NONE,
            "The event flag %" PRIu64 " is not supported in capture mode.", evt->GetEventFlag());
        const std::lock_guard<std::mutex> lk(curCtx->GetCaptureLock());
        if (evt->ToBeCaptured(curStm)) {
            const rtError_t retCode = CaptureRecordEvent(curCtx, evt, curStm);
            ERROR_PROC_RETURN_MSG_INNER(retCode, TerminateCapture(evt, curStm), "Capture event record failed.");
            return RT_ERROR_NONE;
        }
    }
    return EvtRecord(evt, curStm);
}

rtError_t ApiImplDavid::CaptureResetEvent(const Event * const evt, Stream * const stm)
{
    Event * const captureEvt = evt->GetCaptureEvent();
    NULL_PTR_RETURN_MSG(captureEvt, RT_ERROR_EVENT_NULL);

    const Stream * const captureStm = stm->GetCaptureStream();
    NULL_STREAM_PTR_RETURN_MSG(captureStm);

    COND_RETURN_ERROR_MSG_INNER(IsCrossCaptureModel(captureEvt, captureStm),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture event and capture stream is cross-model.");

    const rtError_t error = EvtReset(captureEvt, stm);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,
            "Stream reset capture event failed, stream_id=[%d->%d], error=%d.",
            stm->Id_(), captureStm->Id_(), error);
    } else {
        const Stream * const newCaptureStm = stm->GetCaptureStream();
        RT_LOG(RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].",
            stm->Id_(), newCaptureStm->Id_(), evt->EventId_(), captureEvt->EventId_());
    }
    return error;
}

rtError_t ApiImplDavid::EventReset(Event * const evt, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream * const curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    const bool supportFlag = (evt->IsNewMode()) ||
        ((evt->GetEventFlag() == RT_EVENT_DEFAULT) && (curStm->GetModelNum() != 0));
    COND_RETURN_WARN(supportFlag, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support current mode bind stm, mode=%d, flag=%" PRIu64 ", isModel=%d.",
        evt->IsNewMode(), evt->GetEventFlag(), (curStm->GetModelNum() != 0));
    if ((evt->GetEventFlag() == RT_EVENT_DEFAULT) && (curStm->GetModelNum() == 0U)) {
        return RT_ERROR_NONE;
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Event reset failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    if (evt->IsCapturing()) {
        COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(curStm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", curStm->Flags());
        COND_RETURN_ERROR_MSG_INNER(curStm == curCtx->DefaultStream_(),
            RT_ERROR_STREAM_CAPTURE_IMPLICIT,
            "A disallowed implicit dependency from default stream.");
        COND_RETURN_ERROR_MSG_INNER(evt->IsEventWithoutWaitTask(),
            RT_ERROR_INVALID_VALUE,
            "The event flag %" PRIu64 " is not supported in capture mode.", evt->GetEventFlag());
        const std::lock_guard<std::mutex> lk(curCtx->GetCaptureLock());
        if (evt->IsCapturing()) {
            const rtError_t retCode = CaptureResetEvent(evt, curStm);
            ERROR_PROC_RETURN_MSG_INNER(retCode, TerminateCapture(evt, curStm), "Capture event record failed.");
            return RT_ERROR_NONE;
        }
    } else {
        if ((curStm != curCtx->DefaultStream_()) && (evt->ToBeCaptured(curStm))) {
            RT_LOG(RT_LOG_WARNING,  "Not support call rtEventCreate or rtEventCreateWithFlag without external flag");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    return EvtReset(evt, curStm);
}

rtError_t ApiImplDavid::CaptureWaitEvent(Context * const ctx, Stream * const stm, Event * const evt,
    const uint32_t timeout)
{
    if (IsCaptureEventWaitNonOp(stm, evt)) {
        return RT_ERROR_NONE;
    }

    Stream *captureStm = nullptr;
    rtError_t error = GetCaptureStream(ctx, stm, evt, &captureStm);
    ERROR_RETURN_MSG_INNER(error, "Create capture stream failed, stream_id=%d, event_id=%d, error=%d.",
        stm->Id_(), evt->EventId_(), error);

    Event *captureEvt = nullptr;
    error = GetCaptureEvent(stm, evt, &captureEvt);
    ERROR_RETURN_MSG_INNER(error, "Create capture event failed, stream_id=%d, event_id=%d, error=%d.",
        stm->Id_(), evt->EventId_(), error);

    COND_RETURN_ERROR_MSG_INNER(IsCrossCaptureModel(captureEvt, captureStm),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture event and capture stream is cross-model.");

    error = EvtWait(captureEvt, stm, timeout);
    ERROR_RETURN_MSG_INNER(error, "Capture stream wait event failed, stream_id=[%d->%d], error=%d.",
        stm->Id_(), captureStm->Id_(), error);

    Stream * const newCaptureStm = stm->GetCaptureStream();
    RT_LOG(RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].",
        stm->Id_(), newCaptureStm->Id_(), evt->EventId_(), captureEvt->EventId_());
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::LaunchKernelByArgsWithType(Kernel * const kernel, const uint32_t coreDim, Stream *stm,
    const RtArgsWithType * const argsWithType, const TaskCfg &taskCfg)
{
    rtError_t error = RT_ERROR_NONE;
    RT_LOG(RT_LOG_DEBUG, "LaunchKernelByArgsWithType, device_id=%u, add stream_id=%d, blockDim=%u, argsType=%u.",
        stm->Device_()->Id_(), stm->Id_(), coreDim, static_cast<uint32_t>(argsWithType->type));
    switch (argsWithType->type) {
        case RT_ARGS_NON_CPU_EX: {
            rtStreamLaunchKernelV2ExtendArgs_t launchKernelExtendArgs = {};
            ConstructStreamLaunchKernelV2ExtendArgs(argsWithType->args.nonCpuArgsInfo, nullptr, nullptr, &taskCfg,
                &launchKernelExtendArgs);
            error = StreamLaunchKernelV2(kernel, coreDim, stm, &launchKernelExtendArgs);
            break;
        }
        case RT_ARGS_CPU_EX: {
            error = CpuKernelLaunchExAll(kernel, coreDim, argsWithType->args.cpuArgsInfo, stm, &taskCfg);
            break;
        }
        case RT_ARGS_HANDLE: {
            error = LaunchKernelByHandle(kernel, coreDim, argsWithType->args.argHandle, stm, taskCfg);
            break;
        }
        default:
            error = RT_ERROR_INVALID_VALUE;
            RT_LOG_OUTER_MSG_INVALID_PARAM(argsWithType->type,
                "[" + std::to_string(RT_ARGS_NON_CPU_EX) + ", " + std::to_string(RT_ARGS_MAX) + ")");
            break;
    }

    return error;
}

rtError_t ApiImplDavid::StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout)
{
    RT_LOG(RT_LOG_DEBUG, "Stream wait event, timeout=%us.", timeout);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream * const curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    const bool supFlag = ((evt->IsNewMode()) || (evt->GetEventFlag() == RT_EVENT_DEFAULT)) &&
            (curStm->GetModelNum() != 0);
    COND_RETURN_WARN(supFlag, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support current mode bind stream, mode=%d, flag=%" PRIu64 ", isModel=%d.",
        evt->IsNewMode(), evt->GetEventFlag(), (curStm->GetModelNum() != 0));
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Stream wait event failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    if (evt->IsCapturing()) {
        COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(curStm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u, stream_id=%d.", curStm->Flags(), curStm->Id_());
        COND_RETURN_ERROR_MSG_INNER(curStm == curCtx->DefaultStream_(),
            RT_ERROR_STREAM_CAPTURE_IMPLICIT,
            "A disallowed implicit dependency from default stream.");
        COND_RETURN_ERROR_MSG_INNER(evt->IsEventWithoutWaitTask(),
            RT_ERROR_INVALID_VALUE,
            "The event flag %" PRIu64 " is not supported in capture mode.", evt->GetEventFlag());
        const std::lock_guard<std::mutex> lk(curCtx->GetCaptureLock());
        if (evt->IsCapturing()) {
            const rtError_t retCode = CaptureWaitEvent(curCtx, curStm, evt, timeout);
            ERROR_PROC_RETURN_MSG_INNER(retCode, TerminateCapture(evt, curStm), "Capture wait event failed, stream_id=%d.", curStm->Id_());
            return RT_ERROR_NONE;
        }
    } else {
        if (curStm->IsCapturing()) { 
            if ((!(evt->IsNewMode())) && (evt->GetEventFlag() != RT_EVENT_EXTERNAL)) { 
                RT_LOG(RT_LOG_WARNING,  "Event created via the API rtEventCreate and rtEventCreateWithFlag are not"
                " supported, except for the RT_EVENT_EXTERNAL type, mode=%d, flag=%" PRIu64 "", evt->IsNewMode(),
                 evt->GetEventFlag());
                return RT_ERROR_FEATURE_NOT_SUPPORT;
            }
            if ((evt->IsNewMode()) && (evt->HasRecord())) { 
                // 1.Not capture event
                // 2.Be a capture stream
                // 3.Event was created using the rtCreateEventExWithFlag interface
                // 4. A record was added the single-operator stream
                RT_LOG(RT_LOG_ERROR,  "The record corresponding to the event not be captured, mode=%d",
                    evt->IsNewMode());
                return RT_ERROR_STREAM_CAPTURE_ISOLATION;
            }
        }
    }
    const rtError_t error = EvtWait(evt, curStm, timeout);
    COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE), error, "Stream wait event failed.");
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::MemcpyAsyncPtr(void * const memcpyAddrInfo, const uint64_t destMax,
    const uint64_t count, Stream *stm, const rtTaskCfgInfo_t * const cfgInfo, const bool isMemcpyDesc)
{
    UNUSED(destMax);
    UNUSED(isMemcpyDesc);
    RT_LOG(RT_LOG_DEBUG, "async memcpy, using ptr_mode=1, stream=%p, count=%" PRIu64 ".", stm, count);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (stm == nullptr) {
        stm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Memcpy async failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    return MemcpyAsyncPtrForDavid(static_cast<rtDavidMemcpyAddrInfo *>(memcpyAddrInfo), count, stm, cfgInfo);
}

rtError_t ApiImplDavid::SetMemcpyDesc(rtMemcpyDesc_t desc, const void * const srcAddr, const void * const dstAddr,
    const size_t count, const rtMemcpyKind kind, rtMemcpyConfig_t * const config)
{
    RT_LOG(RT_LOG_INFO, "SetMemcpyDesc called, desc=%p, srcAddr=%p, dstAddr=%p, count=%zu, kind=%d, config=%p",
        desc, srcAddr, dstAddr, count, kind, config);
    UNUSED(kind);
    UNUSED(config);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device * const dev = curCtx->Device_();

    rtDavidMemcpyAddrInfo memcpyData;
    (void)memset_s(&memcpyData, sizeof(rtDavidMemcpyAddrInfo), 0, sizeof(rtDavidMemcpyAddrInfo));
    
    memcpyData.len = static_cast<uint32_t>(count);
    memcpyData.src = RtPtrToValue<const void *>(srcAddr);
    memcpyData.dst = RtPtrToValue<const void *>(dstAddr);
    
    constexpr uint64_t dstMax = MEMCPY_DESC_SIZE_V2; //64U 
    rtError_t error = RT_ERROR_NONE;

    error = dev->Driver_()->MemCopySync(static_cast<rtDavidMemcpyAddrInfo *>(desc), dstMax, &memcpyData,
            dstMax, RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN(error, "Failed to memory copy stream info, device_id=%u, dstMax=%u, retCode=%#x.", 
            dev->Id_(), dstMax, static_cast<uint32_t>(error));

    if (dev->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE) {
        error = dev->Driver_()->DevMemFlushCache(RtPtrToPtr<uintptr_t>(desc), static_cast<size_t>(dstMax));
        ERROR_RETURN(error, "Failed to flush stream info, device_id=%u, retCode=%#x", 
            dev->Id_(), static_cast<uint32_t>(error));
    }
    
    RT_LOG(RT_LOG_INFO, "Set memcpyDesc info success, srcAddr=%p, dstAddr=%p, count=%llu", srcAddr, dstAddr, count);
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, Stream * const stm,
    const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    UNUSED(newKind);
    RT_LOG(RT_LOG_DEBUG, "Sync memcpy2d, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64 ", width=%" PRIu64
           ", height=%" PRIu64 ", kind=%d.", dstPitch, srcPitch, width, height, kind);

    rtError_t error = RT_ERROR_NONE;
    uint64_t remainSize = width * height;
    uint64_t realSize = 0UL;
    uint64_t fixedSize = 0UL;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Memcpy2D async failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    while (remainSize > 0UL) {
        error = Memcpy2DAsync(dst, dstPitch, src, srcPitch, width, height, kind, &realSize, curStm, fixedSize);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        fixedSize += realSize;
        remainSize -= realSize;
    }
    return error;
}

rtError_t ApiImplDavid::MemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    const rtMemcpyKind_t kind, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo,
    const rtD2DAddrCfgInfo_t * const addrCfg, bool checkKind, const rtMemcpyConfig_t * const memcpyConfig)
{
    UNUSED(checkKind);
    UNUSED(memcpyConfig);
    RT_LOG(RT_LOG_DEBUG, "Async memcpy, count=%" PRIu64 ", kind=%d", cnt, kind);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Memcpy async failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    uint32_t transType = UINT32_MAX;
    rtError_t error = RT_ERROR_NONE;
    if (kind == RT_MEMCPY_DEVICE_TO_DEVICE) {
        error = ConvertD2DCpyType(curStm, transType, src, dst);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "ConvertD2DCpyType failed, retCode=%#x.", static_cast<uint32_t>(error));
            return error;
        }
    }
    const uint64_t sqSize = CalculateMemcpyAsyncSingleMaxSize(kind, transType);

    uint64_t realSize = cnt;
    uint64_t remainSize = cnt;
    uint64_t doneSize = 0U;
    while (remainSize > 0U) {
        const uint64_t doingSize = (remainSize >= sqSize) ? sqSize : remainSize;
        realSize = doingSize;
        error = MemcopyAsync((static_cast<char_t *>(dst)) + doneSize,
            destMax - doneSize, (static_cast<const char_t *>(src)) + doneSize, doingSize,
            kind, curStm, &realSize, nullptr, cfgInfo, addrCfg);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "cnt=%lld, doingSize=%lld, realSize=%lld.", cnt, doingSize, realSize);
            return error;
        }
        doneSize += realSize;
        remainSize -= realSize;
    }
    return error;
}

rtError_t ApiImplDavid::ReduceAsync(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    RT_LOG(RT_LOG_INFO, "ReduceAsync, count=%" PRIu64 ", kind=%d.", cnt, kind);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Reduce async failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    return MemcpyReduceAsync(dst, src, cnt, kind, type, curStm, cfgInfo);
}

rtError_t ApiImplDavid::ModelExit(Model * const mdl, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Model exit run failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model exit run failed, stream is not in current ctx.");
    const uint32_t modelExitNum = mdl->ModelExitNum_();
    COND_RETURN_OUT_ERROR_MSG_CALL(modelExitNum >= 1U, RT_ERROR_MODEL_EXIT,
        "Model exit failed, current modelExitNum=%u, model must only exit one time.", modelExitNum);
    stm->SetLatestModlId(static_cast<int32_t>(mdl->Id_()));
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->Model_() == nullptr, RT_ERROR_MODEL_EXIT_STREAM_UNBIND,
        "Model exit failed, stream not bind, modelExitNum=%u!", modelExitNum);
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->Model_()->Id_() != mdl->Id_(), RT_ERROR_MODEL_EXIT_ID,
        "Model exit failed, stream is not belong the model, modelExitNum=%u!", modelExitNum);
    mdl->IncModelExitNum();
    return RT_ERROR_NONE;  
}

rtError_t ApiImplDavid::StreamSwitchN(void * const ptr, const uint32_t size, void * const valuePtr,
    Stream ** const trueStreamPtr, const uint32_t elementSize, Stream * const stm, const rtSwitchDataType_t dataType)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(valuePtr);
    UNUSED(dataType);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    for (uint32_t i = 0U; i < elementSize; i++) {
        NULL_PTR_RETURN_MSG_OUTER(trueStreamPtr[i], RT_ERROR_STREAM_NULL);
        COND_RETURN_AND_MSG_OUTER(trueStreamPtr[i]->GetModelNum() == 0, RT_ERROR_STREAM_MODEL, ErrorCode::EE1011, 
            __func__, 0, "trueStreamPtr[" + std::to_string(i) + "]->modelNum", "The stream is not bound to a model");
    }

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Stream switchN failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_AND_MSG_OUTER(stm->GetModelNum() == 0, RT_ERROR_STREAM_MODEL, ErrorCode::EE1011, __func__,
            0, "stm->modelNum", "The stream is not bound to a model");
    return RT_ERROR_NONE;  
}

rtError_t ApiImplDavid::MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t val, const uint64_t cnt,
    Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Memset async failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    RT_LOG(RT_LOG_DEBUG, "fillVal=%u, fillCount=%" PRIu64 ", destMax=%" PRIu64 ", stream_id=%d.",
           val, cnt, destMax, curStm->Id_());
    return MemSetAsync(curStm, ptr, destMax, val, cnt);
}

rtError_t ApiImplDavid::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify, const uint32_t flag)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");

    *retCntNotify = new (std::nothrow) CountNotify(static_cast<uint32_t>(deviceId), dev->DevGetTsId());
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *retCntNotify == nullptr, RT_ERROR_NOTIFY_NEW,
                               "Count Notify create failed, new notify failed.");

    (*retCntNotify)->SetNotifyFlag(flag);
    rtError_t error = (*retCntNotify)->Setup();
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(*retCntNotify);,
                                "Count Notify create failed, setup failed, user device_id=%d, retCode=%#x",
                                deviceId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    delete inCntNotify;
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                   const rtCntNtyRecordInfo_t * const info)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");

    Stream *targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR_MSG_INNER(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Count notify record failed, stream is not in current ctx.");

    const uint32_t countNotifyId = inCntNotify->GetCntNotifyId();
    const rtError_t error = inCntNotify->Record(targetStm, info);
    ERROR_RETURN_MSG_INNER(error, "Count Notify record failed, device_id=%u, stream_id=%d, count notify_id=%u,"
        " retCode=%#x", dev->Id_(), targetStm->Id_(), countNotifyId, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");

    Stream *targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR_MSG_INNER(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Count notify reset failed, stream is not in current ctx.");

    rtCntNtyRecordInfo_t info = {RECORD_STORE_MODE, 0U};
    const uint32_t countNotifyId = inCntNotify->GetCntNotifyId();
    const rtError_t error = inCntNotify->Record(targetStm, &info);
    ERROR_RETURN_MSG_INNER(error, "Count Notify record failed, device_id=%u, stream_id=%d, count notify_id=%u,"
        " retCode=%#x", dev->Id_(), targetStm->Id_(), countNotifyId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                            const rtCntNtyWaitInfo_t * const info)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");

    Stream *targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR_MSG_INNER(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Count notify reset failed, stream is not in current ctx.");

    const rtError_t error = inCntNotify->Wait(targetStm, info);
    const uint32_t notifyId = inCntNotify->GetCntNotifyId();
    ERROR_RETURN_MSG_INNER(error, "count notify wait failed, device_id=%u, stream_id=%d, count notify_id=%u,"
        " time_out = %u, retCode=%#x", dev->Id_(), targetStm->Id_(), notifyId, info->timeout,
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::GetCntNotifyId(CountNotify * const inCntNotify, uint32_t * const notifyId)
{
    *notifyId = inCntNotify->GetCntNotifyId();
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::GetCntNotifyAddress(CountNotify *const inCntNotify, uint64_t * const cntNotifyAddress,
                                            rtNotifyType_t const regType)
{
    uint64_t addr;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");
    const rtError_t error = inCntNotify->GetCntNotifyAddress(addr, regType);
    ERROR_RETURN_MSG_INNER(error, "GetCntNotifyAddress failed, device_id=%d, retCode=%#x", dev->Id_(),
        static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "GetCntNotifyAddress ok, device_id=%d, addr=%#" PRIx64, dev->Id_(), addr);
    *cntNotifyAddress = addr;
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Notify wait failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    const uint32_t timeOutTmp = timeOut;
    const rtError_t error = NtyWait(inNotify, curStm, timeOutTmp);
    const uint32_t notifyId = inNotify->GetNotifyId();
    ERROR_RETURN_MSG_INNER(error, "notify wait failed, notify_id=%u, time_out = %u, retCode=%#x",
        notifyId, timeOutTmp, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::NotifyRecord(Notify * const inNotify, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Notify record failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    const uint32_t notifyId = inNotify->GetNotifyId();
    const rtError_t error = NtyRecord(inNotify, curStm);
    ERROR_RETURN_MSG_INNER(error, "Notify record failed, notify_id=%u, retCode=%#x",
        notifyId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::NotifyReset(Notify * const inNotify)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream *curStm = curCtx->DefaultStream_();
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Notify reset failed, stream is not in current ctx, device_id=%u, stream_id=%d.",
                                curStm->Device_()->Id_(), curStm->Id_());

    const uint32_t notifyId = inNotify->GetNotifyId();
    const rtError_t error = NtyReset(inNotify, curStm);
    ERROR_RETURN_MSG_INNER(error, "Notify reset failed, device_id=%u, notify_id=%u, is_ipc_notify=%d, retCode=%#x",
        curStm->Device_()->Id_(), notifyId, inNotify->IsIpcNotify(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag)
{
    UNUSED(flag);
    RT_LOG(RT_LOG_DEBUG, "length=%u, flag=%u.", length, flag);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null.");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Data dump info load failed, check and start tsd open aicpu sd error.");
    return StreamDatadumpInfoLoad(dumpInfo, length, curCtx->DefaultStream_());
}

rtError_t ApiImplDavid::DebugRegister(Model * const mdl, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Debug register failed, stream is not in current ctx.");
    return ModelDebugRegister(mdl, flag, addr, streamId, taskId, curCtx->DefaultStream_());
}

rtError_t ApiImplDavid::DebugUnRegister(Model * const mdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Debug unregister failed, stream is not in current ctx.");
    return ModelDebugUnRegister(mdl, curCtx->DefaultStream_());
}

rtError_t ApiImplDavid::DebugRegisterForStream(Stream * const stm, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx");
    return StreamDebugRegister(stm, flag, addr, streamId, taskId);
}

rtError_t ApiImplDavid::DebugUnRegisterForStream(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Stream is not in current ctx");
    return StreamDebugUnRegister(stm);
}

rtError_t ApiImplDavid::GetDevRunningStreamSnapshotMsg(const rtGetMsgCallback callback)
{
    const std::function<rtError_t(Device * const dev)> getDevHangMsgForDev =
        [callback, this](Device * const dev) -> rtError_t {    
        DeviceStreamSnapshotHandler devStreamSnapshotHandler(dev, callback);
        rtError_t error = devStreamSnapshotHandler.Init();
        ERROR_RETURN(error, "Init device stream snapshot msg handler failed, retCode=%#x.", static_cast<uint32_t>(error));

        error = SyncGetDeviceMsg(dev, devStreamSnapshotHandler.GetDevMemAddr(),
            devStreamSnapshotHandler.GetDevMemSize(), RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG);

        ERROR_RETURN(error, "Sync get device msg failed, retCode=%#x.", static_cast<uint32_t>(error));

        error = devStreamSnapshotHandler.HandleMsg();
        ERROR_RETURN_MSG_INNER(error, "Failed to handle get stream snapshot msg, retCode=%#x.",
            static_cast<uint32_t>(error));
        return RT_ERROR_NONE;
    };
    return Runtime::Instance()->ProcessForAllOpenDevice(getDevHangMsgForDev, false);
}

rtError_t ApiImplDavid::NpuClearFloatStatus(const uint32_t checkMode, Stream * const stm)
{
    NULL_STREAM_PTR_RETURN_MSG(stm);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");
    return StreamNpuClearFloatStatus(checkMode, stm, false);
}

rtError_t ApiImplDavid::NpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode,
    Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream * const targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", targetStm->Id_());
    return StreamNpuGetFloatStatus(outputAddrPtr, outputSize, checkMode, targetStm, false);
}

rtError_t ApiImplDavid::NpuClearFloatDebugStatus(const uint32_t checkMode, Stream * const stm)
{
    NULL_STREAM_PTR_RETURN_MSG(stm);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");
    return StreamNpuClearFloatStatus(checkMode, stm, true);
}

rtError_t ApiImplDavid::NpuGetFloatDebugStatus(void * const outputAddrPtr, const uint64_t outputSize,
    const uint32_t checkMode, Stream * const stm)
{
    NULL_STREAM_PTR_RETURN_MSG(stm);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");
    return StreamNpuGetFloatStatus(outputAddrPtr, outputSize, checkMode, stm, true);
}

rtError_t ApiImplDavid::GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "Start to get sat status.");
    uint64_t realSize = 0U;
    rtError_t error = RT_ERROR_NONE;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", curStm->Id_());

    error = StreamGetSatStatus(outputSize, curStm);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = MemcopyAsync(outputAddrPtr, outputSize, curCtx->CtxGetOverflowAddr(),
        outputSize, RT_MEMCPY_DEVICE_TO_DEVICE, curStm, &realSize, nullptr, nullptr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemcpyAsync failed destMax=%llu.", outputSize);
    }

    return error;
}

rtError_t ApiImplDavid::SetStreamOverflowSwitch(Stream * const stm, const uint32_t flags)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    rtFloatOverflowMode_t overflowModel = RT_OVERFLOW_MODE_UNDEF;
    (void)GetDeviceSatMode(&overflowModel);
    COND_RETURN_ERROR_MSG_INNER((overflowModel != RT_OVERFLOW_MODE_SATURATION), RT_ERROR_FEATURE_NOT_SUPPORT,
        "overflow switch only support satuation mode(%d), current mode is %d.",
        RT_OVERFLOW_MODE_SATURATION, overflowModel);
    Stream * const targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", targetStm->Id_());
    return SetOverflowSwitchOnStream(targetStm, flags);
}

rtError_t ApiImplDavid::SetStreamTag(Stream * const stm, const uint32_t geOpTag)
{
    RT_LOG(RT_LOG_DEBUG, "geOpTag=%#x.", geOpTag);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream * const targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", targetStm->Id_());
    return SetTagOnStream(targetStm, geOpTag);
}

rtError_t ApiImplDavid::UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Ub send failed, stream is not in current ctx.");
    return StreamUbDbSend(dbInfo, curStm);
}

rtError_t ApiImplDavid::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Direct send failed, stream is not in current ctx.");
    COND_RETURN_ERROR_MSG_INNER(curStm->GetBindFlag(), RT_ERROR_STREAM_INVALID,
        "UbDirectSend not support model stream, stream_id=%d.", curStm->Id_());
    COND_RETURN_WARN(curStm->IsCapturing(), RT_ERROR_FEATURE_NOT_SUPPORT,
 	    "Ub direct tasks cannot be delivered in capture mode.");

    return StreamUbDirectSend(wqeInfo, curStm);
}

rtError_t ApiImplDavid::StreamClear(Stream * const stm, rtClearStep_t step)
{
    UNUSED(stm);
    UNUSED(step);
    RT_LOG(RT_LOG_WARNING, "Chip type(%d) does not support.", Runtime::Instance()->GetChipType());
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplDavid::NopTask(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    NULL_STREAM_PTR_RETURN_MSG(stm);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "add nop task failed, stream is not in current ctx, stream_id=%d.", stm->Id_());

    return StreamNopTask(stm);
}

rtError_t ApiImplDavid::AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length)
{
    RT_LOG(RT_LOG_DEBUG, "length=%u.", length);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null.");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "aicpu info load failed, check and start tsd open aicpu sd error.");
    return StreamAicpuInfoLoad(curCtx->DefaultStream_(), aicpuInfo, length);    
}

rtError_t ApiImplDavid::SubscribeReport(const uint64_t threadId, Stream * const stm)
{
    rtError_t ret = RT_ERROR_NONE;
    Stream *curStm = stm;
    if (curStm == nullptr) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    Notify *curNotify = nullptr;
    ret = NotifyCreate(static_cast<int32_t>(curStm->Device_()->Id_()), &curNotify, RT_NOTIFY_DEFAULT);
    ERROR_RETURN(ret, "Call NotifyCreate failed, ret=%#x.", ret);
    ret = Runtime::Instance()->SubscribeReport(threadId, curStm, static_cast<void *>(curNotify));
    if (ret != RT_ERROR_NONE) {
        (void)NotifyDestroy(curNotify);
    }
    return ret;
}

static rtError_t ProcessReportForBlockCqe(Device * const dev, rtHostFuncCqReport_t * const report,
    const uint32_t deviceId, uint32_t tsId)
{
    if (report->isBlock != 0) {
        Runtime * const rt = Runtime::Instance();
        Driver * const curDrv = dev->Driver_();
        Notify *curNotify = nullptr;
        rtError_t ret = rt->GetNotifyByStreamId(deviceId, static_cast<int32_t>(report->streamId), &curNotify);
        ERROR_RETURN_MSG_INNER(ret, "Call GetNotifyByStreamId failed for block callback, ret=%#x.",ret);
        ret = curDrv->WriteNotifyRecord(deviceId, tsId, curNotify->GetNotifyId());
        ERROR_RETURN_MSG_INNER(ret, "Call WriteNotifyRecord failed for block callback, ret=%#x.", ret);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::ProcessReport(const int32_t timeout, const bool noLog)
{
    UNUSED(noLog);
    uint64_t cqidBit[HOST_CALLBACK_SQCQ_BIT / 64U] = {0ULL};
    uint32_t deviceId = 0U;
    uint32_t tsId = 0U;
    uint32_t groupId = 0U;
    uint64_t bit = 0U;

    Runtime * const rt = Runtime::Instance();

    const uint64_t threadId = PidTidFetcher::GetCurrentUserTid();
    rtError_t ret = rt->GetGroupIdByThreadId(threadId, &deviceId, &tsId, &groupId);
    COND_RETURN_WARN(ret != RT_ERROR_NONE, ret, "get groupId fail, threadIdentifier=%" PRIu64 ", retCode=%#x",
                     threadId, ret);
    rt->LockGroupId(groupId);
    std::function<void()> const func = [=]() { rt->UnlockGroupId(groupId); };
    const ScopeGuard groupIdGuarder(func);

    Context *priCtx = rt->GetPriCtxByDeviceId(deviceId, tsId);
    if (priCtx == nullptr) {
        priCtx = CurrentContext();
    }
    CHECK_CONTEXT_VALID_WITH_RETURN(priCtx, RT_ERROR_CONTEXT_NULL);

    Device * const dev = priCtx->Device_();
    Driver * const curDrv = dev->Driver_();

    ret = curDrv->CqReportIrqWait(deviceId, tsId, groupId, timeout, &cqidBit[0], HOST_CALLBACK_SQCQ_BIT / 64U);
    COND_RETURN_WARN(ret != RT_ERROR_NONE, ret, "CqReportIrqWait, retCode=%#x", ret);

    RT_LOG(RT_LOG_DEBUG, "IrqWait groupId=%u, threadIdentifier=%" PRIu64, groupId, threadId);

    // per uint64_t num has 64 bit
    for (uint32_t index = 0U; index < (HOST_CALLBACK_SQCQ_BIT / 64U); index++) {
        for (; ; RT_BITMAP_CLR(cqidBit[index], bit)) {
            bit = BitScan(cqidBit[index]);
            if (bit >= 64U) { // 64 bit for uint64_t
                break;
            }
            // left move 6 is multiply 64
            const uint32_t cqidValue = (index << 6U) + static_cast<uint32_t>(bit);
            uint32_t cnt = 0U;
            rtHostFuncCqReport_t *report = nullptr;
            ret = curDrv->CqReportGet(deviceId, tsId, cqidValue, &report, &cnt);
            if (unlikely((report == nullptr) || (cnt == 0U))) {
                continue;
            }
            RT_LOG(RT_LOG_DEBUG, "get report info num=%u from cqid = %u.", cnt, cqidValue);
            COND_RETURN_WARN(ret != RT_ERROR_NONE, ret, "CqReportGet failed, retCode=%#x", ret);
            for (uint32_t idx = 0U; idx < cnt; idx++) {
                const rtCallback_t hostFunc =
                    RtValueToPtr<rtCallback_t>(report[idx].hostFuncCbPtr);
                NULL_PTR_RETURN_MSG(hostFunc, RT_ERROR_DRV_REPORT);

                RT_LOG(RT_LOG_INFO, "report[%u], streamId=%hu, taskId=%hu, eventNotifyId=%hu, isBlock=%hhu",
                    idx, report[idx].streamId, report[idx].taskId, report[idx].eventId, report[idx].isBlock);

                (hostFunc)(RtValueToPtr<void *>(report[idx].fnDataPtr));
                ret = ProcessReportForBlockCqe(dev, &report[idx], deviceId, tsId);
                ERROR_RETURN(ret, "process block cqe fail, ret=%#x.", ret);
                ret = curDrv->CqReportRelease(&report[idx], deviceId, cqidValue, tsId);
            }
        }
    }

    return ret;
}

rtError_t ApiImplDavid::ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
    rtMdlTaskUpdateInfo_t *para)
{
    RT_LOG(RT_LOG_INFO, "ModelTaskUpdate, desStm=%d, desTaskId=%u, sinkStm=%d", desStm->Id_(), desTaskId, sinkStm->Id_());
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return MdlTaskUpdate(desStm, desTaskId, sinkStm, para);
}

rtError_t ApiImplDavid::LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
    Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Label switch by index failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_AND_MSG_OUTER(stm->GetModelNum() == 0, RT_ERROR_STREAM_MODEL, ErrorCode::EE1011, __func__,
            0, "stm->modelNum", "The stream is not bound to a model");
    return CondLabelSwitchByIndex(ptr, maxVal, labelInfoPtr, stm);
}

rtError_t ApiImplDavid::StreamActive(Stream * const activeStream, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_OUTER(stm->GetModelNum() == 0, RT_ERROR_STREAM_MODEL, ErrorCode::EE1011, __func__,
        0, "stm->modelNum", "The stream is not bound to a model");
    COND_RETURN_AND_MSG_OUTER(activeStream->GetModelNum() == 0, RT_ERROR_STREAM_MODEL, ErrorCode::EE1011, __func__,
        0, "activeStream->modelNum", "The stream is not bound to a model");
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Stream active failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    return CondStreamActive(activeStream, stm);
}

rtError_t ApiImplDavid::CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
    const bool isBlock)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Callback launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    COND_RETURN_ERROR_MSG_INNER(!curStm->IsHostFuncCbReg(), RT_ERROR_STREAM_NO_CB_REG,
        "The stream used by this user's callback function is not registered to any thread, retCode=%#x",
        static_cast<uint32_t>(RT_ERROR_STREAM_NO_CB_REG));
    if (isBlock) {
        const rtError_t ret = CallbackLaunchForDavidWithBlock(callBackFunc, fnData, curStm);
        ERROR_RETURN(ret, "Call CallbackLaunch failed for block callback, ret=%#x.", ret);
        return ret;
    }
    return CallbackLaunchForDavidNoBlock(callBackFunc, fnData, curStm);
}

rtError_t ApiImplDavid::ModelAbort(Model * const mdl)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_MODEL_NULL);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model abort run failed, stream is not in current ctx.");
    return MdlAbort(mdl);
}

rtError_t ApiImplDavid::ModelEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags)
{
    RT_LOG(RT_LOG_DEBUG, "model add end graph task model_id=%u, stream_id=%d, flags=%u",
        mdl->Id_(), stm->Id_(), flags);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Model end graph run failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model end graph run failed, model is not in current ctx.");

    if ((flags & RT_KERNEL_DUMPFLAG) != 0U) {
        ERROR_RETURN_MSG_INNER(Runtime::Instance()->StartAicpuSd(curCtx->Device_()),
            "Model end graph with kernel dump flag failed, check and start tsd open aicpu sd error.");
    }
    return MdlAddEndGraph(mdl, stm, flags);
}

rtError_t ApiImplDavid::StreamSwitchEx(void * const ptr, const rtCondition_t condition, void * const valuePtr,
    Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType)
{
    RT_LOG(RT_LOG_DEBUG, "Stream switch, condition=%d, dataType=%d.", condition, dataType);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx,
        RT_ERROR_STREAM_CONTEXT,
        "Stream switch(extend) failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_AND_MSG_OUTER(stm->GetModelNum() == 0, RT_ERROR_STREAM_MODEL, ErrorCode::EE1011, __func__,
        0, "stm->modelNum", "The stream is not bound to a model");
    COND_RETURN_AND_MSG_OUTER(trueStream->GetModelNum() == 0, RT_ERROR_STREAM_MODEL, ErrorCode::EE1011, __func__,
        0, "trueStream->modelNum", "The stream is not bound to a model");
    return CondStreamSwitchEx(ptr, condition, valuePtr, trueStream, stm, dataType);
}

rtError_t ApiImplDavid::LabelSet(Label * const lbl, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(lbl->Context_() != curCtx, RT_ERROR_LABEL_CONTEXT,
                                "Label is not in current ctx");
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Label set failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    return CondLabelSet(lbl, stm);
}

rtError_t ApiImplDavid::ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags, Stream * const stm)
{
    UNUSED(id);
    UNUSED(notifyFlag);
    UNUSED(flags);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Profiler trace failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::ProfilerTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId, Stream *stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (stm == nullptr) {
        stm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Profiler trace[extend] failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    return ProfTraceEx(id, modelId, tagId, stm, curCtx);
}

rtError_t ApiImplDavid::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Write value failed, stream is not in current ctx.");

    return StreamWriteValue(info, curStm);
}

rtError_t ApiImplDavid::WriteValuePtr(void * const writeValueInfo, Stream * const stm,
    void * const pointedAddr)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Write value ptr task failed, stream is not in current ctx.");
    return StreamWriteValuePtr(static_cast<rtWriteValueInfo_t *>(writeValueInfo), curStm, pointedAddr);
}

rtError_t ApiImplDavid::StarsTaskLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm,
    const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "Stars launch, sqeLen=%u, flag=%u.", sqeLen, flag);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Stars task launch failed, stream is not in current ctx");
    COND_RETURN_WARN(curStm->IsCapturing(), RT_ERROR_FEATURE_NOT_SUPPORT,
 	         "DVPP tasks cannot be delivered in capture mode.");
    return StarsLaunch(sqe, sqeLen, curStm, flag);
}

rtError_t ApiImplDavid::LaunchDvppTask(const void *sqe, uint32_t sqeLen, Stream *stm, rtDvppCfg_t *cfg)
{
    RT_LOG(RT_LOG_INFO, "Start to launch dvpp task.");

    // Retrieve the current context and validate its validity
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    //Determine the stream to use; if the provided stream is null, use the default stream
    Stream *curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);

    // Verify that the stream belongs to the current context
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
    "Launch dvpp task failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
 
    bool isCmdListNotFree = false;
    rtError_t error = GetIsCmdListNotFreeValByDvppCfg(cfg, isCmdListNotFree);
    ERROR_RETURN_MSG_INNER(error, "Failed to get dvpp cmdlist not free flag, streamId=%u, retCode=%#x",
                curStm->Id_(), error);

    const uint32_t flag = isCmdListNotFree ? RT_KERNEL_CMDLIST_NOT_FREE : RT_KERNEL_DEFAULT;
    COND_RETURN_WARN(curStm->IsCapturing(), RT_ERROR_FEATURE_NOT_SUPPORT,
 	        "DVPP tasks cannot be delivered in capture mode.");
    error = StarsTaskLaunch(sqe, sqeLen, curStm, flag);
    ERROR_RETURN(error, "Failed to launch Dvpp task");
    return error;
}

rtError_t ApiImplDavid::MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    for (size_t idx = 0U; idx < taskInfo->taskNum; idx++) {
        if (taskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_DVPP) {
            RT_LOG(RT_LOG_DEBUG,
                "Launch dvpp task, dvppSqeType=%hhu, pos=%hu",
                taskInfo->taskDesc[idx].u.dvppTaskDesc.sqe.sqeHeader.type,
                taskInfo->taskDesc[idx].u.dvppTaskDesc.aicpuTaskPos);
        } else if (taskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_AICPU) {
            RT_LOG(RT_LOG_DEBUG,
                "Launch aicpu task, soName=%s, kernelName=%s, opName=%s, blockDim=%hu, isUnderstudyOp=%hu,"
                " argsSize=%u, hostInputInfoNum=%hu",
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.kernelLaunchNames.soName,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.kernelLaunchNames.kernelName,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.kernelLaunchNames.opName,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.blockDim,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.isUnderstudyOp,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.argsInfo.argsSize,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.argsInfo.hostInputInfoNum);
        } else {
            Kernel *hdl = RtPtrToPtr<Kernel *>(taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.funcHdl);
            RT_LOG(RT_LOG_DEBUG,
                "launch aicpu task by handle, soName=%s, funcName=%s, opName=%s, blockDim=%hu, isUnderstudyOp=%hu,"
                " argsSize=%u, hostInputInfoNum=%hu,",
                hdl->GetCpuKernelSo().c_str(), hdl->GetCpuFuncName().c_str(), hdl->GetCpuOpType().c_str(),
                taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.blockDim,
                taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.isUnderstudyOp,
                taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.argsInfo.argsSize,
                taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.argsInfo.hostInputInfoNum);
        }
    }

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "task info launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    COND_RETURN_WARN(curStm->IsCapturing(), RT_ERROR_FEATURE_NOT_SUPPORT,
 	        "DVPP tasks cannot be delivered in capture mode.");
    return LaunchMultipleTaskInfo(taskInfo, curStm, flag);
}

rtError_t ApiImplDavid::DvppWaitGroupReport(DvppGrp * const grp, rtDvppGrpCallback const callBackFunc,
    const int32_t timeout)
{
    Context * const curCtx = grp->getContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return DvppWaitGroup(curCtx->Device_(), grp, callBackFunc, timeout);
}

static rtError_t SetLimitSizeByType(const rtLimitType_t type, const uint32_t val)
{
    Runtime *rt = Runtime::Instance();
    uint32_t alignVal = (val + STACK_PHY_BASE_ALIGN_LEN - 1U) / STACK_PHY_BASE_ALIGN_LEN * STACK_PHY_BASE_ALIGN_LEN;
    switch (type) {
        case RT_LIMIT_TYPE_SIMT_WARP_STACK_SIZE:
            rt->SetSimtWarpStkSize(alignVal);
            break;
        case RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE:
            rt->SetSimtDvgWarpStkSize(alignVal);
            break;
        default:
            RT_LOG_OUTER_MSG_INVALID_PARAM(type,
               std::to_string(RT_LIMIT_TYPE_SIMT_WARP_STACK_SIZE) + " or " + std::to_string(RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE));
            return RT_ERROR_DEVICE_LIMIT;
    }
    COND_RETURN_OUT_ERROR_MSG_CALL(((rt->GetSimtWarpStkSize() == 0) && (rt->GetSimtDvgWarpStkSize() == 0)),
        RT_ERROR_INVALID_VALUE, "simtWarpStkSize and simtDvgWarpStkSize cannot both be zero.");  
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::DeviceSetLimit(const int32_t devId, const rtLimitType_t type, const uint32_t val)
{
    RT_LOG(RT_LOG_DEBUG, "drv devId=%u, type=%u, value=%u.", static_cast<uint32_t>(devId),
        static_cast<uint32_t>(type), val);
    rtError_t error = RT_ERROR_NONE;
    Runtime *rt = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rt == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null.");
    Context * const curCtx = CurrentContext();
    if (type == RT_LIMIT_TYPE_LOW_POWER_TIMEOUT) {
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        RT_LOG(RT_LOG_WARNING, "DeviceSetLimit, drv devId=%u, type=%u, value=%u.", static_cast<uint32_t>(devId),
            static_cast<uint32_t>(type), val);
        return error;
    } else if (type == RT_LIMIT_TYPE_STACK_SIZE) {
        std::unique_lock<std::mutex> lock(rt->GetSimtStackMutex());
        rt->SetDeviceCustomerStackSize(val);
        return RT_ERROR_NONE;
    } else if (type == RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE) {
        std::unique_lock<std::mutex> lock(rt->GetSimdFifoMutex());
        return rt->SetSimdPrintFifoSize(val);
    } else if (type == RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE) {
        std::unique_lock<std::mutex> lock(rt->GetSimtFifoMutex());
        return rt->SetSimtPrintFifoSize(val);
    } else {
        // no op
    }

    error = SetLimitSizeByType(type, val);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Set simt stack size failed, drv devId=%u, retCode=%#x.",
        static_cast<uint32_t>(devId), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::StreamTaskAbort(Stream * const stm)
{
    Stream *curStm = stm;
    if (curStm == nullptr) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    } else {
        const bool isValid = ContextManage::CheckStreamPtrIsValid(curStm);
        COND_RETURN_ERROR((isValid == false), RT_ERROR_INVALID_VALUE, "Input stm ptr is invalid.");
    }

    return curStm->StreamAbort();
}

rtError_t ApiImplDavid::StreamAbort(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream *curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "StreamAbort failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    COND_RETURN_ERROR_MSG_INNER(curStm->GetBindFlag(), RT_ERROR_STREAM_INVALID,
        "StreamAbort not support model stream, stream_id=%d.", curStm->Id_());
    COND_RETURN_ERROR_MSG_INNER((curStm->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U, RT_ERROR_STREAM_INVALID,
        "StreamAbort not support mc2 stream, stream flag=%u.", curStm->Flags());
    return curStm->StreamAbort();
}

rtError_t ApiImplDavid::StreamStop(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "StreamStop failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(stm->GetBindFlag(), RT_ERROR_STREAM_INVALID,
        "StreamStop not support model stream, stream_id=%d.", stm->Id_());
    return stm->StreamStop();
}
rtError_t ApiImplDavid::StreamRecover(Stream * const stm)
{
    const bool isValid = ContextManage::CheckStreamPtrIsValid(stm);
    COND_RETURN_ERROR((isValid == false), RT_ERROR_INVALID_VALUE, "Input stm ptr is invalid.");
    return stm->StreamRecoverAbort();
}

rtError_t ApiImplDavid::StreamTaskClean(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "task clean failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    return stm->StreamTaskClean();
}

rtError_t ApiImplDavid::DeviceResourceClean(int32_t devId)
{
    return ContextManage::DeviceResourceClean(devId);
}

rtError_t ApiImplDavid::LabelGotoEx(Label * const lbl, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Label goto(extend) failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(lbl->Context_() != curCtx, RT_ERROR_LABEL_CONTEXT,
                                "Label is not in current ctx");
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplDavid::GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    rtError_t error;
    rtErrorInfo errorInfo = {};
    error = GetMemUceInfoProc(deviceId, &errorInfo);
    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support get mem uce info.");
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get mem uce info failed, drv devId=%u, error=%d.", deviceId, error);
        return error;
    }

    rtMemUceArray *memUceArray = &(errorInfo.detail.uceInfo);
    memUceInfo->devid = deviceId;
    memUceInfo->count = memUceArray->arraySize;
    errno_t ret = memcpy_s(memUceInfo->repairAddr, sizeof(memUceInfo->repairAddr),
                            memUceArray->repairAddrArray, sizeof(memUceArray->repairAddrArray));
    COND_RETURN_ERROR(ret != 0, RT_ERROR_INVALID_VALUE, "memcpy_s failed, err=%d.", ret);

    return RT_ERROR_NONE;
}

rtError_t ApiImplDavid::DeviceTaskAbort(const int32_t devId, const uint32_t timeout)
{
    return DavidDeviceTaskAbort(devId, timeout);
}

static rtError_t L2BufferErrProc(const uint32_t deviceId, rtErrorInfo * const errorInfo)
{
    errorInfo->errorType = RT_ERROR_L2;

    uint32_t resume_cnt = MAX_UINT32_NUM;
    int32_t buf_size = sizeof(resume_cnt);
    const rtError_t error = NpuDriver::GetDeviceInfoByBuff(deviceId, MODULE_TYPE_L2BUFF, INFO_TYPE_L2BUFF_RESUME_CNT,
        static_cast<void *>(&resume_cnt), &buf_size);
    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support get fault event info.");
    if ((error != RT_ERROR_NONE) || (resume_cnt == MAX_UINT32_NUM) || (buf_size != sizeof(resume_cnt))) {
        RT_LOG(RT_LOG_ERROR, "Calling drv api halGetDeviceInfoByBuff failed, resume_cnt=%u, buf_size=%d, error=%#x.",
            resume_cnt, buf_size, static_cast<uint32_t>(error));
        return RT_ERROR_DRV_ERR;
    }

    if (resume_cnt == 0U) {
        errorInfo->tryRepair = 1U;
    } else {
        errorInfo->tryRepair = 0U;
        RT_LOG(RT_LOG_INFO, "Resume cnt is not zero, recovery may have been triggered.");
    }
    return error;
}

static void AicoreErrorProc(const Device * const dev, rtErrorInfo * const errorInfo)
{
    errorInfo->hasDetail = 1U;
    errorInfo->errorType = RT_ERROR_AICORE;

    const uint32_t recoverCnt = dev->GetAixErrRecoverCnt();
    if (recoverCnt == 0U) {
        errorInfo->tryRepair = 1U;
    } else {
        errorInfo->tryRepair = 0U;
        RT_LOG(RT_LOG_INFO, "Aicore recover cnt is not zero or other fault event exist, recoverCnt=%u.", recoverCnt);
    }

    return;
}

static void AicoreUnknownErrorProc(rtErrorInfo * const errorInfo)
{
    errorInfo->errorType = RT_ERROR_AICORE;
    errorInfo->hasDetail = 1U;
    errorInfo->detail.aicoreErrType = RT_AICORE_ERROR_UNKNOWN;
}

static void UnknowErrorProc(const Context * const curCtx, rtErrorInfo * const errorInfo)
{
    if (curCtx->GetFailureError() == RT_ERROR_NONE) {
        errorInfo->errorType = RT_NO_ERROR;
    } else {
        errorInfo->errorType = RT_ERROR_OTHERS;
    }
}

rtError_t ApiImplDavid::GetErrorVerbose(const uint32_t deviceId, rtErrorInfo * const errorInfo)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);

    rtError_t error = RT_ERROR_NONE;
    const DeviceFaultType faultType = dev->GetDeviceFaultType();
    RT_LOG(RT_LOG_DEBUG, "start GetErrorVerbose, device_id=%u, type=%u", deviceId, faultType);
    errorInfo->hasDetail = 0U;
    errorInfo->tryRepair = 0U;
    switch (faultType) {
        case DeviceFaultType::L2_BUFFER_ERROR:
            error = L2BufferErrProc(deviceId, errorInfo);
            break;
        case DeviceFaultType::HBM_UCE_ERROR:
            error = GetMemUceInfoProc(deviceId, errorInfo);
            errorInfo->errorType = RT_ERROR_MEMORY;
            break;
        case DeviceFaultType::AICORE_SW_ERROR:
            errorInfo->detail.aicoreErrType = RT_AICORE_ERROR_SW;
            AicoreErrorProc(dev, errorInfo);
            break;
        case DeviceFaultType::AICORE_HW_L_ERROR:
            errorInfo->detail.aicoreErrType = RT_AICORE_ERROR_HW_LOCAL;
            AicoreErrorProc(dev, errorInfo);
            break;
        case DeviceFaultType::AICORE_UNKNOWN_ERROR:
            AicoreUnknownErrorProc(errorInfo);
            break;
        case DeviceFaultType::LINK_ERROR:
            errorInfo->errorType = RT_ERROR_LINK;
            errorInfo->tryRepair = 1U;
            break;
        default:
            UnknowErrorProc(curCtx, errorInfo);
            break;

    }
    return error;
}

static rtError_t L2BufferErrorResume(Device * const dev, const uint32_t deviceId)
{
    uint32_t buf_context = DRV_L2BUFF_CLEAN;
    const rtError_t error = NpuDriver::SetDeviceInfoByBuff(deviceId, MODULE_TYPE_L2BUFF, INFO_TYPE_L2BUFF_RESUME,
        static_cast<void *>(&buf_context), sizeof(buf_context));
    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT, 
        "Not support l2 buffer resume.");
    COND_PROC((error != RT_ERROR_NONE),
        RT_LOG(RT_LOG_ERROR, "L2 buffer err repair failed, deviceId=%u, retCode=%#x.",
            deviceId, static_cast<uint32_t>(error)));
    dev->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
    return error;
}

rtError_t ApiImplDavid::RepairError(const uint32_t deviceId, const rtErrorInfo * const errorInfo)
{
    rtError_t error = RT_ERROR_NONE;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    switch (errorInfo->errorType) {
        case RT_ERROR_L2:
            error = L2BufferErrorResume(dev, deviceId);
            break;
        case RT_ERROR_AICORE:
            dev->SetAixErrRecoverCnt();
            dev->SetDeviceFaultType(DeviceFaultType::NO_ERROR);
            break;
        case RT_ERROR_MEMORY:
            error = MemUceErrorResume(dev, deviceId, errorInfo);
            break;
        default:
            error = RT_ERROR_INVALID_VALUE;
            RT_LOG(RT_LOG_ERROR, "Not support current error type [%d]", errorInfo->errorType);
            break;
    }
    return error;
}

rtError_t ApiImplDavid::GetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
        const void **stack, uint32_t *stackSize)
{
    RT_LOG(RT_LOG_DEBUG, "Get stack buffer, bin handle %p, coreType %u, coreId %u", binHandle, coreType, coreId);
    return GetStackBufferInfo(binHandle, coreType, coreId, stack, stackSize);
}

rtError_t ApiImplDavid::DebugReadAICore(rtDebugMemoryParam_t *const param)
{
    return ReadAICoreDebugInfo(param);
}

rtError_t ApiImplDavid::GetExceptionRegInfo(const rtExceptionInfo_t * const exceptionInfo,
    rtExceptionErrRegInfo_t **exceptionErrRegInfo, uint32_t *num)
{
    UNUSED(exceptionInfo);
    UNUSED(exceptionErrRegInfo);
    UNUSED(num);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplDavid::LaunchHostFunc(Stream * const stm, const rtCallback_t callBackFunc, void * const fnData)
{
    UNUSED(stm);
    UNUSED(callBackFunc);
    UNUSED(fnData);;
    RT_LOG(RT_LOG_WARNING, "ascend950 does not support rtsLaunchHostFunc.");
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImplDavid::GetDeviceSimtInfo(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    RT_LOG(RT_LOG_INFO, "get device simt info, deviceId=%u attr=%d", deviceId, attr);
    
    UNUSED(deviceId);
    rtError_t error = RT_ERROR_NONE;

    switch(attr) {
        case RT_DEV_ATTR_WARP_SIZE:
            *val = RT_MAX_THREAD_NUM_PER_WARP;
            break;
        case RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE:
            *val = RT_MAX_THREAD_PER_VECTOR_CORE;
            break;
        case RT_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE:
            *val = RT_SIMT_AVAILBALE_UB_SIZE;
            break;
        default:
            RT_LOG_OUTER_MSG_INVALID_PARAM(attr,
               std::to_string(RT_DEV_ATTR_WARP_SIZE) + " or " +
               std::to_string(RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE) +
               " or " + std::to_string(RT_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE));
            error = RT_ERROR_INVALID_VALUE;
            break;
    }

    return error;
}

rtError_t ApiImplDavid::MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    UNUSED(flag);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "mem write value failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    rtWriteValueInfo_t info;
    info.addr = RtPtrToValue(devAddr);
    uint64_t writeValue = value;
    info.value = RtPtrToPtr<uint8_t*>(&writeValue);
    info.size = WRITE_VALUE_SIZE_TYPE_64BIT;
    return StreamWriteValue(&info, curStm);
}

rtError_t ApiImplDavid::MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "mem wait value failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return CondMemWaitValue(devAddr, value, flag, curStm);
}

}  // namespace runtime
}  // namespace cce