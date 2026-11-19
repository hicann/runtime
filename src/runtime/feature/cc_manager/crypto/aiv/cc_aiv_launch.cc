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

#include <string>

#include <dlfcn.h>

#include "common/cc_defs.h"
#include "crypto/device/cc_kernel_abi.h"
#include "api.hpp"
#include "logger.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr const char_t* CC_AIV_FATBIN_NAME = "cc_aiv_ks_xor.o";
constexpr const char_t* CC_AIV_KERNEL_SUBDIR = "ops/";

Kernel* g_aivKsXorKernel = nullptr;

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

} // namespace

rtError_t CcInitAivKsKernel()
{
    if (g_aivKsXorKernel != nullptr) {
        return RT_ERROR_NONE;
    }
    Runtime* const rt = Runtime::Instance();
    COND_RETURN_ERROR(rt == nullptr, RT_ERROR_INSTANCE_NULL, "CC AIV kernel init: runtime instance is null.");
    Api* const api = rt->ApiImpl_();
    COND_RETURN_ERROR(api == nullptr, RT_ERROR_INSTANCE_NULL, "CC AIV kernel init: api instance is null.");

    const std::string dir = ResolveKernelDir();
    COND_RETURN_ERROR(dir.empty(), RT_ERROR_CC_INIT_FAILED, "CC AIV kernel init: kernel dir is not resolved.");
    const std::string fatbinPath = dir + CC_AIV_FATBIN_NAME;

    Program* program = nullptr;
    rtError_t ret = api->BinaryLoadFromFile(fatbinPath.c_str(), nullptr, &program);
    COND_RETURN_ERROR(
        (ret != RT_ERROR_NONE) || (program == nullptr), RT_ERROR_CC_INIT_FAILED,
        "CC AIV kernel load failed, path=%s, ret=%#x.", fatbinPath.c_str(), ret);

    Kernel* kernel = nullptr;
    ret = api->BinaryGetFunctionByName(program, CC_KERNEL_KEYSTREAM_XOR, &kernel);
    COND_RETURN_ERROR(
        (ret != RT_ERROR_NONE) || (kernel == nullptr), RT_ERROR_CC_INIT_FAILED,
        "CC AIV kernel lookup failed, kernel=%s, path=%s, ret=%#x.", CC_KERNEL_KEYSTREAM_XOR, fatbinPath.c_str(), ret);

    g_aivKsXorKernel = kernel;
    RT_LOG(RT_LOG_INFO, "CC AIV kernel loaded, path=%s.", fatbinPath.c_str());
    return RT_ERROR_NONE;
}

rtError_t CcLaunchAivKsXor(Stream* const stm, const AiccKeystreamXorParam& param)
{
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC AIV KeystreamXor launch stream is null.");
    COND_RETURN_ERROR(g_aivKsXorKernel == nullptr, RT_ERROR_CC_INIT_FAILED, "CC AIV kernel is not initialized.");

    const uint32_t blockDim = CcSelectAivBlockDim(param.reserved, AICC_MAX_BLOCK_DIM);
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
