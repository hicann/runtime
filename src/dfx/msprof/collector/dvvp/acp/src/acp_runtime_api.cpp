/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <mutex>
#include "acl/acl_prof.h"
#include "runtime/kernel.h"
#include "runtime/dev.h"
#include "errno/error_code.h"
#include "error_codes/rt_error_codes.h"
#include "acp_api_plugin.h"
#include "acp_manager.h"

using namespace Collector::Dvvp::Acp;
using namespace analysis::dvvp::common::error;

static std::mutex g_setDeviceMtx;
constexpr uint32_t KERNEL_TASK_TIME = 5;

static void SaveBinaryBaseAddr()
{
    if (!AcpManager::instance()->PcSamplingIsEnable()) {
        MSPROF_LOGI("Pc-sampling isn't enabled");
        return;
    }
    VOID_PTR baseAddress = nullptr;
    auto hdl =  AcpManager::instance()->GetBinaryHandle();
    auto error = AcpApiPlugin::instance()->ApiRtGetBinaryDeviceBaseAddress(hdl, baseAddress);
    if (error == RT_ERROR_NONE) {
        AcpManager::instance()->AddBinaryBaseAddr(hdl, baseAddress);
    } else {
        MSPROF_LOGW("Unable to get base address, code info = %u", error);
    }
}

/**
 * @name  KernelWarmUp
 * @brief Template method. Start Warm up process in different KernelLaunch phases.
 * @param [in] stream: operator stream id
 * @param [in] func: pointer of different KernelLaunch method
 * @param [in] args: input params from different KernelLaunch
 * @return RT_ERROR_NONE:SUCCESS, !RT_ERROR_NONE:FAILED
 */
template <typename Func, typename... Args>
static rtError_t KernelWarmUp(rtStream_t &stream, Func &&func, Args&&... args)
{
    rtError_t ret = RT_ERROR_NONE;
    MSPROF_LOGI("Acp execute kernel warm up.");
    ret = std::forward<Func>(func)(std::forward<Args>(args)...);
    FUNRET_CHECK_EXPR_ACTION(ret != RT_ERROR_NONE, return ret, "Failed to warm up kernel, ret: %d.", ret);
    ret = AcpApiPlugin::instance()->ApiRtStreamSynchronize(stream);
    FUNRET_CHECK_EXPR_ACTION(ret != RT_ERROR_NONE, return ret, "Failed to execute rtStreamSynchronize, ret: %d.",
        ret);
    return ret;
}

/**
 * @name  KernelReplay
 * @brief Template method. Start profiling process in different KernelLaunch phases.
 * @param [in] stream: operator stream id
 * @param [in] func: pointer of different KernelLaunch method
 * @param [in] args: input params from different KernelLaunch
 * @return RT_ERROR_NONE:SUCCESS, !RT_ERROR_NONE:FAILED
 */
template <typename Func, typename... Args>
static rtError_t KernelReplay(rtStream_t &stream, Func &&func, Args&&... args)
{
    rtError_t ret = RT_ERROR_NONE;
    int32_t acpRet = PROFILING_SUCCESS;
    for (uint32_t time = 0; time < KERNEL_TASK_TIME; ++time) {
        MSPROF_LOGI("Acp execute kernel task, time: %u.", time);
        // reset malloc memory
        AcpManager::instance()->ResetMallocMemory(stream);
        // start profiling
        acpRet = AcpManager::instance()->TaskStart();
        FUNRET_CHECK_EXPR_PRINT(acpRet != PROFILING_SUCCESS, "Failed to start acp task.");
        // kernel execute
        ret = std::forward<Func>(func)(std::forward<Args>(args)...);
        FUNRET_CHECK_EXPR_PRINT(ret != RT_ERROR_NONE, "Failed to execute kernel, ret: %d.", ret);
        // stream synchronize
        if (ret == RT_ERROR_NONE) {
            SaveBinaryBaseAddr();
            ret = AcpApiPlugin::instance()->ApiRtStreamSynchronize(stream);
            FUNRET_CHECK_EXPR_PRINT(ret != RT_ERROR_NONE, "Failed to execute rtStreamSynchronize, ret: %d.", ret);
        }
        // stop profiling
        acpRet = AcpManager::instance()->TaskStop();
        FUNRET_CHECK_EXPR_PRINT(acpRet != PROFILING_SUCCESS, "Failed to stop acp task.");
        FUNRET_CHECK_EXPR_ACTION(ret != RT_ERROR_NONE || acpRet != PROFILING_SUCCESS, break,
            "Failed to execute kernel task, time: %u.", time);
    }

    return ret;
}

/**
 * @name  KernelExec
 * @brief Template method. Start kernel execution in different KernelLaunch phases.
 * @param [in] stream: operator stream id
 * @param [in] func: pointer of different KernelLaunch method
 * @param [in] args: input params from different KernelLaunch
 * @return RT_ERROR_NONE:SUCCESS, !RT_ERROR_NONE:FAILED
 */
template <typename Func, typename... Args>
static rtError_t KernelExec(rtStream_t stream, Func &&func, Args&&... args)
{
    rtError_t ret = RT_ERROR_NONE;
    // save rtMalloc memory
    AcpManager::instance()->SaveMallocMemory(stream);
    // warm up first time
    ret = KernelWarmUp(stream, func, args...);
    FUNRET_CHECK_EXPR_ACTION(ret != RT_ERROR_NONE, return ret, "Failed to warm up kernel replay, ret: %d.", ret);
    // reset rtMalloc memory
    AcpManager::instance()->ResetMallocMemory(stream);
    // warm up second time
    ret = KernelWarmUp(stream, func, args...);
    FUNRET_CHECK_EXPR_ACTION(ret != RT_ERROR_NONE, return ret, "Failed to warm up kernel replay, ret: %d.", ret);
    // get replay time
    uint32_t replayTime = AcpManager::instance()->GetKernelReplayTime();
    MSPROF_LOGI("Acp get kernel replay time: %u.", replayTime);
    for (uint32_t time = 0; time < replayTime; time++) {
        // set metrics and memory
        AcpManager::instance()->SetKernelReplayMetrics(time);
        // replay
        MSPROF_LOGI("Acp execute kernel replay, time: %u.", time);
        ret = KernelReplay(stream, func, args...);
        FUNRET_CHECK_EXPR_ACTION(ret != RT_ERROR_NONE, break, "Failed to execute kernel replay, ret: %d.", ret);
    }
    // clear back up memory
    AcpManager::instance()->ClearMallocMemory();
    return ret;
}

/**
 * @ingroup libascend_profinj
 * @name  rtSetDevice
 * @brief Intercept the rtSetDevice function and obtain the input parameter deviceId.
 * @param [in] devId: configure the target device id of the task
 * @return ACL_RT_SUCCESS:SUCCESS, !ACL_RT_SUCCESS:FAILED
 */
extern "C" MSVP_PROF_API rtError_t rtSetDevice(int32_t devId)
{
    MSPROF_LOGI("Acp %s reloaded start.", __FUNCTION__);
    std::lock_guard<std::mutex> lock(g_setDeviceMtx);
    int32_t ret = Platform::instance()->Init();
    FUNRET_CHECK_EXPR_PRINT(ret != PROFILING_SUCCESS, "Failed to init platform.");

    ret = AcpManager::instance()->Init(devId);
    FUNRET_CHECK_EXPR_PRINT(ret != PROFILING_SUCCESS, "Failed to init manager.");

    MSPROF_LOGI("Acp rtSetDevice reloading finished.");
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    return reinterpret_cast<RtSetDeviceFunc>(func)(devId);
}

 // static operator register
extern "C" MSVP_PROF_API rtError_t rtDevBinaryRegister(const rtDevBinary_t *bin, void **hdl)
{
    MSPROF_LOGI("rtDevBinaryRegister called");
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    rtError_t error = reinterpret_cast<RtDevBinaryRegisterFunc>(func)(bin, hdl);
    if (error == RT_ERROR_NONE) {
        AcpManager::instance()->AddBinary(*hdl, *bin);
        AcpManager::instance()->SaveBinaryHandle(*hdl);
    }

    return error;
}

extern "C" MSVP_PROF_API rtError_t rtDevBinaryUnRegister(void *hdl)
{
    MSPROF_LOGI("rtDevBinaryUnRegister called");
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    rtError_t error = reinterpret_cast<RtDevBinaryUnRegisterFunc>(func)(hdl);
    if (error == RT_ERROR_NONE) {
        AcpManager::instance()->RemoveBinary(hdl);
    }

    return error;
}

// function register after static operator binary register
extern "C" MSVP_PROF_API rtError_t rtFunctionRegister(void *binHandle, const void *stubFunc,
                             const char_t *stubName, const void *kernelInfoExt,
                             uint32_t funcMode)
{
    MSPROF_LOGI("rtFunctionRegister called");
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    rtError_t error = reinterpret_cast<RtFunctionRegisterFunc>(func)(binHandle, stubFunc, stubName,
        kernelInfoExt, funcMode);
    if (error == RT_ERROR_NONE) {
        AcpManager::instance()->SaveBinaryHandle(binHandle);
    } else {
        MSPROF_LOGW("rtFunctionRegister returned code %d", error);
    }

    return error;
}

// dynamic operator register
extern "C" MSVP_PROF_API rtError_t rtRegisterAllKernel(const rtDevBinary_t *bin, void **hdl)
{
    MSPROF_LOGI("rtRegisterAllKernel called");
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    rtError_t error = reinterpret_cast<RtRegisterAllKernelFunc>(func)(bin, hdl);
    if (error == RT_ERROR_NONE) {
        AcpManager::instance()->AddBinary(*hdl, *bin);
        AcpManager::instance()->SaveBinaryHandle(*hdl);
    }

    return error;
}

extern "C" MSVP_PROF_API rtError_t rtKernelLaunch(const void *stubFunc, uint32_t blockDim, void *args,
    uint32_t argsSize, rtSmDesc_t *smDesc, rtStream_t stm)
{
    MSPROF_LOGI("Acp %s reloaded start.", __FUNCTION__);
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    AcpManager::instance()->SetTaskBlockDim(blockDim);
    return KernelExec(stm, reinterpret_cast<RtKernelLaunchFunc>(func),
        stubFunc, blockDim, args, argsSize, smDesc, stm);
}

extern "C" MSVP_PROF_API rtError_t rtKernelLaunchWithHandle(void *hdl, const uint64_t tilingKey, uint32_t blockDim,
    rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm, const void *kernelInfo)
{
    MSPROF_LOGI("Acp %s reloaded start.", __FUNCTION__);
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    AcpManager::instance()->SetTaskBlockDim(blockDim);
    AcpManager::instance()->SaveBinaryHandle(hdl);
    return KernelExec(stm, reinterpret_cast<RtKernelLaunchWithHandleFunc>(func),
        hdl, tilingKey, blockDim, argsInfo, smDesc, stm, kernelInfo);
}

extern "C" MSVP_PROF_API rtError_t rtKernelLaunchWithHandleV2(void *hdl, const uint64_t tilingKey, uint32_t blockDim,
    rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    MSPROF_LOGI("Acp %s reloaded start.", __FUNCTION__);
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    AcpManager::instance()->SetTaskBlockDim(blockDim);
    AcpManager::instance()->SaveBinaryHandle(hdl);
    return KernelExec(stm, reinterpret_cast<RtKernelLaunchWithHandleV2Func>(func),
        hdl, tilingKey, blockDim, argsInfo, smDesc, stm, cfgInfo);
}

extern "C" MSVP_PROF_API rtError_t rtKernelLaunchWithFlag(const void *stubFunc, uint32_t blockDim, rtArgsEx_t *argsInfo,
    rtSmDesc_t *smDesc, rtStream_t stm, uint32_t flags)
{
    MSPROF_LOGI("Acp %s reloaded start.", __FUNCTION__);
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    AcpManager::instance()->SetTaskBlockDim(blockDim);
    return KernelExec(stm, reinterpret_cast<RtKernelLaunchWithFlagFunc>(func),
        stubFunc, blockDim, argsInfo, smDesc, stm, flags);
}

extern "C" MSVP_PROF_API rtError_t rtKernelLaunchWithFlagV2(const void *stubFunc, uint32_t blockDim,
    rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm, uint32_t flags, const rtTaskCfgInfo_t *cfgInfo)
{
    MSPROF_LOGI("Acp %s reloaded start.", __FUNCTION__);
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    AcpManager::instance()->SetTaskBlockDim(blockDim);
    return KernelExec(stm, reinterpret_cast<RtKernelLaunchWithFlagV2Func>(func),
       stubFunc, blockDim, argsInfo, smDesc, stm, flags, cfgInfo);
}

/**
 * @name  rtMalloc
 * @brief Register rtMalloc, rtFree and rtMemcpyAsync function and save rtMalloc attribute applied by user
 * @param [in] devPtr: malloc ptr
 * @param [in] size: malloc size
 * @param [in] type: malloc type
 * @param [in] moduleId: model id
 * @return RT_ERROR_NONE:SUCCESS, !RT_ERROR_NONE:FAILED
 */
extern "C" MSVP_PROF_API rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId)
{
    MSPROF_LOGI("Acp %s reloaded start.", __FUNCTION__);
    // register rtMalloc、rtFree and rtMemcpyAsync
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__);
    auto func2 = AcpApiPlugin::instance()->GetPluginApiStubFunc("rtFree");
    FUNRET_CHECK_EXPR_ACTION(func2 == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[rtFree] func.")
    AcpManager::instance()->RegisterRtMallocFunc(reinterpret_cast<RtMallocFunc>(func),
        reinterpret_cast<RtFreeFunc>(func2));
    auto func3 = AcpApiPlugin::instance()->GetPluginApiStubFunc("rtMemcpyAsync");
    FUNRET_CHECK_EXPR_ACTION(func3 == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[rtMemcpyAsync] func.")
    AcpManager::instance()->RegisterRtMemcpyFunc(reinterpret_cast<RtMemcpyAsyncFunc>(func3));
    // execute rtMalloc
    rtError_t ret = reinterpret_cast<RtMallocFunc>(func)(devPtr, size, type, moduleId);
    FUNRET_CHECK_EXPR_ACTION(ret != ACL_RT_SUCCESS, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to %s, size: %llu, type: %u, moduleId: %u.", __FUNCTION__, size,
        static_cast<uint32_t>(type), moduleId);
    // save rtMalloc attr
    AcpBackupAttr attr = {*devPtr, size, type, moduleId};
    AcpManager::instance()->SaveRtMallocAttr(attr);
    return ret;
}

/**
 * @name  rtFree
 * @brief Release rtMalloc ptr
 * @param [in] devPtr: malloc ptr which need to be free
 * @return RT_ERROR_NONE:SUCCESS, !RT_ERROR_NONE:FAILED
 */
extern "C" MSVP_PROF_API rtError_t rtFree(void *devPtr)
{
    MSPROF_LOGI("Acp %s reloaded start.", __FUNCTION__);
    auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc(__FUNCTION__);
    FUNRET_CHECK_EXPR_ACTION(func == nullptr, return ACL_ERROR_RT_PROFILING_ERROR,
        "Failed to get api stub[%s] func.", __FUNCTION__)
    // release rtMalloc addr
    AcpManager::instance()->ReleaseRtMallocAddr(devPtr);
    return reinterpret_cast<RtFreeFunc>(func)(devPtr);
}