/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cc_aiv_launch.h"

#include <array>
#include <atomic>
#include <mutex>
#include <string>

#include <dlfcn.h>

#include "common/cc_defs.h"
#include "crypto/device/cc_kernel_abi.h"
#include "api.hpp"
#include "context.hpp"
#include "device.hpp"
#include "logger.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr const char_t* CC_AIV_FATBIN_NAME = "cc_aiv_ks_xor.o";
constexpr const char_t* CC_AIV_KERNEL_SUBDIR = "ops/";

std::atomic<Kernel*> g_aivKsXorKernel{nullptr};
std::atomic<Program*> g_aivKsXorProgram{nullptr};
std::array<std::atomic<Context*>, RT_MAX_DEV_NUM> g_aivKsXorCtx{};
std::mutex g_aivKsInitMutex;

std::string ResolveKernelDir()
{
    Dl_info info{};
    if ((dladdr(reinterpret_cast<void*>(&ResolveKernelDir), &info) != 0) && (info.dli_fname != nullptr)) {
        const std::string self(info.dli_fname);
        const size_t slash = self.rfind('/');
        if (slash != std::string::npos) {
            return self.substr(0U, slash + 1U) + CC_AIV_KERNEL_SUBDIR;
        }
    }
    return std::string();
}

bool IsAivKernelReady(const uint32_t devId, const Context* const ctx)
{
    return (devId < RT_MAX_DEV_NUM) && (ctx != nullptr) &&
           (g_aivKsXorKernel.load(std::memory_order_acquire) != nullptr) &&
           (g_aivKsXorCtx[devId].load(std::memory_order_acquire) == ctx);
}

bool IsAivKernelInited(const uint32_t devId)
{
    return (devId < RT_MAX_DEV_NUM) && (g_aivKsXorKernel.load(std::memory_order_acquire) != nullptr) &&
           (g_aivKsXorCtx[devId].load(std::memory_order_acquire) != nullptr);
}

rtError_t LoadAivKsProgram(Api* const api)
{
    if (g_aivKsXorProgram.load(std::memory_order_acquire) != nullptr) {
        return RT_ERROR_NONE;
    }
    const std::string dir = ResolveKernelDir();
    COND_RETURN_ERROR(dir.empty(), RT_ERROR_CC_INIT_FAILED, "CC AIV kernel init: kernel dir is not resolved.");
    const std::string fatbinPath = dir + CC_AIV_FATBIN_NAME;

    Program* program = nullptr;
    const rtError_t ret = api->BinaryLoadFromFile(fatbinPath.c_str(), nullptr, &program);
    COND_RETURN_ERROR(
        (ret != RT_ERROR_NONE) || (program == nullptr), RT_ERROR_CC_INIT_FAILED,
        "CC AIV kernel load failed, path=%s, ret=%#x.", fatbinPath.c_str(), ret);
    g_aivKsXorProgram.store(program, std::memory_order_release);
    return RT_ERROR_NONE;
}

} // namespace

rtError_t CcInitAivKsKernel(const uint32_t devId)
{
    COND_RETURN_ERROR(devId >= RT_MAX_DEV_NUM, RT_ERROR_DEVICE_ID, "CC AIV kernel init: invalid device id %u.", devId);
    Runtime* const rt = Runtime::Instance();
    COND_RETURN_ERROR(rt == nullptr, RT_ERROR_INSTANCE_NULL, "CC AIV kernel init: runtime instance is null.");
    Api* const api = rt->ApiImpl_();
    COND_RETURN_ERROR(api == nullptr, RT_ERROR_INSTANCE_NULL, "CC AIV kernel init: api instance is null.");

    Context* const curCtx = rt->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device* const curDev = curCtx->Device_();
    COND_RETURN_ERROR(curDev == nullptr, RT_ERROR_DEVICE_NULL, "CC AIV kernel init: current device is null.");
    COND_RETURN_ERROR(
        curDev->Id_() != devId, RT_ERROR_STREAM_CONTEXT, "CC AIV kernel init: device mismatch, devId=%u, curDevId=%u.",
        devId, curDev->Id_());

    if (IsAivKernelReady(devId, curCtx)) {
        return RT_ERROR_NONE;
    }

    const std::lock_guard<std::mutex> lock(g_aivKsInitMutex);
    if (IsAivKernelReady(devId, curCtx)) {
        return RT_ERROR_NONE;
    }

    const rtError_t loadRet = LoadAivKsProgram(api);
    COND_RETURN_WITH_NOLOG(loadRet != RT_ERROR_NONE, loadRet);

    Kernel* kernel = nullptr;
    const rtError_t ret = api->BinaryGetFunctionByName(
        g_aivKsXorProgram.load(std::memory_order_acquire), CC_KERNEL_KEYSTREAM_XOR, &kernel);
    COND_RETURN_ERROR(
        (ret != RT_ERROR_NONE) || (kernel == nullptr), RT_ERROR_CC_INIT_FAILED,
        "CC AIV kernel lookup failed, kernel=%s, devId=%u, ret=%#x.", CC_KERNEL_KEYSTREAM_XOR, devId, ret);

    g_aivKsXorKernel.store(kernel, std::memory_order_release);
    g_aivKsXorCtx[devId].store(curCtx, std::memory_order_release);
    RT_LOG(RT_LOG_INFO, "CC AIV kernel loaded, devId=%u, kernel=%s.", devId, CC_KERNEL_KEYSTREAM_XOR);
    return RT_ERROR_NONE;
}

void CcResetAivKsKernel(const uint32_t devId)
{
    if (devId >= RT_MAX_DEV_NUM) {
        return;
    }
    const std::lock_guard<std::mutex> lock(g_aivKsInitMutex);
    g_aivKsXorCtx[devId].store(nullptr, std::memory_order_release);
}

rtError_t CcLaunchAivKsXor(Stream* const stm, const AiccKeystreamXorParam& param)
{
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC AIV KeystreamXor launch stream is null.");
    const Device* const dev = stm->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_DEVICE_NULL, "CC AIV KeystreamXor launch: stream device is null.");
    COND_RETURN_ERROR(
        !IsAivKernelInited(dev->Id_()), RT_ERROR_CC_INIT_FAILED, "CC AIV kernel is not initialized, devId=%u.",
        dev->Id_());

    const uint32_t blockDim = CcSelectAivBlockDim(param.totalBytes, AICC_MAX_BLOCK_DIM);
    // 设备入口接收两个 8B 标量：环地址与 {mode, totalSlices}。
    const uint64_t ctlPacked = (static_cast<uint64_t>(param.mode) << 32U) | static_cast<uint64_t>(param.totalSlices);
    uint64_t args[2] = {param.taskQueueAddr, ctlPacked};

    rtArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = static_cast<uint32_t>(sizeof(args));
    argsInfo.isNoNeedH2DCopy = 0U; // 参数是 host 栈变量，让 Runtime 拷到 device

    Runtime* const rt = Runtime::Instance();
    COND_RETURN_ERROR(rt == nullptr, RT_ERROR_INSTANCE_NULL, "CC AIV KeystreamXor launch: runtime instance is null.");
    Api* const api = rt->ApiImpl_();
    COND_RETURN_ERROR(api == nullptr, RT_ERROR_INSTANCE_NULL, "CC AIV KeystreamXor launch: api instance is null.");
    const rtError_t ret = api->LaunchKernel(g_aivKsXorKernel, blockDim, &argsInfo, stm);
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret, "CC AIV KeystreamXor launch failed, blockDim=%u slices=%u mode=%u ret=%#x.",
        blockDim, param.totalSlices, param.mode, ret);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
