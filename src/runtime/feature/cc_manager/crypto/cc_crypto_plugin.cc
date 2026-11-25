/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software: you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cc_crypto_plugin.h"

#include "common/cc_defs.h"

#include <algorithm>
#include <cstdlib>
#include <cstring>
#include <mutex>
#include <string>
#include <vector>

#include "aicpu_c.hpp"
#include "common/cc_utils.h"
#include "crypto/aiv/cc_aiv_launch.h"
#include "stream.hpp"

namespace cce {
namespace runtime {

namespace {
CCCryptoPluginFactory g_cryptoPluginFactories[static_cast<uint32_t>(CC_CRYPTO_ALG_TYPE::MAX)] = {nullptr};

std::mutex g_activeAlgMutex;                                    // 保护模式缓存
CC_CRYPTO_ALG_TYPE g_activeCryptoAlg = CC_CRYPTO_ALG_TYPE::GCM; // 静态初值；节点不可读时 GetActiveCryptoAlg 回落 GCM
bool g_activeCryptoAlgResolved = false;                         // 模式是否已解析（true 后不再读节点）

std::atomic<CC_CRYPTO_CIPHER> g_activeCryptoCipher{CC_CRYPTO_CIPHER::AES_128}; // 生效加密算法（缺省 AES_128）

} // namespace

CCCryptoPlugin::CCCryptoPlugin(
    CC_CRYPTO_ALG_TYPE algType, std::atomic<CC_CRYPTO_CIPHER>& cipher, const char_t* kernelName, uint32_t sliceDescSize)
    : algType_(algType), cipher_(cipher), kernelName_(kernelName), sliceDescSize_(sliceDescSize)
{}

CCCryptoPlugin::~CCCryptoPlugin() = default;

CC_CRYPTO_ALG_TYPE CCCryptoPlugin::AlgType() const { return algType_; }

CC_CRYPTO_CIPHER CCCryptoPlugin::Cipher() const { return cipher_.load(std::memory_order_relaxed); }

const char_t* CCCryptoPlugin::KernelName() const { return kernelName_; }

uint32_t CCCryptoPlugin::SliceDescSize() const { return sliceDescSize_; }

rtError_t CCCryptoPlugin::OnTaskBegin(
    const CCMemcpyTask& task, uint32_t deviceId, uint32_t totalSlices, void** pluginTaskCtx)
{
    UNUSED(task);
    UNUSED(deviceId);
    UNUSED(totalSlices);
    if (pluginTaskCtx != nullptr) {
        *pluginTaskCtx = nullptr; // 原语轨默认无 per-task 状态
    }
    return RT_ERROR_NONE;
}

rtError_t CCCryptoPlugin::PrepareH2DSlice(CCCryptoSliceCtx& ctx, size_t& dmaLen)
{
    UNUSED(ctx);
    UNUSED(dmaLen);
    return RT_ERROR_NONE;
}

rtError_t CCCryptoPlugin::OnH2DSliceDone(CCCryptoSliceCtx& ctx)
{
    UNUSED(ctx);
    return RT_ERROR_NONE;
}

rtError_t CCCryptoPlugin::PrepareD2HSlice(CCCryptoSliceCtx& ctx)
{
    UNUSED(ctx);
    return RT_ERROR_NONE;
}

rtError_t CCCryptoPlugin::FinishD2HSlice(CCCryptoSliceCtx& ctx)
{
    UNUSED(ctx);
    return RT_ERROR_NONE;
}

void CCCryptoPlugin::OnTaskEnd(const CCMemcpyTask& task, uint32_t deviceId, uint32_t totalSlices, void* pluginTaskCtx)
{
    UNUSED(task);
    UNUSED(deviceId);
    UNUSED(totalSlices);
    UNUSED(pluginTaskCtx);
}

namespace {
rtError_t LaunchBuiltinAicpuKernel(
    Stream* const stm, const char_t* const kernelName, void* const args, const uint32_t argsSize)
{
    rtKernelLaunchNames_t launchNames{};
    launchNames.soName = nullptr;
    launchNames.kernelName = kernelName;
    launchNames.opName = kernelName;

    rtArgsEx_t argsInfo{};
    argsInfo.args = args;
    argsInfo.argsSize = argsSize;
    argsInfo.isNoNeedH2DCopy = 0U; // 参数多是 host 栈变量，让 Runtime 拷到 device

    return StreamLaunchCpuKernel(&launchNames, 1U, &argsInfo, stm, RT_KERNEL_DEFAULT);
}
} // namespace

rtError_t CCCryptoPlugin::LaunchDeviceKernel(
    Stream* const stm, const char_t* const kernelName, void* const args, const uint32_t argsSize)
{
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC device kernel launch stream is null.");
    COND_RETURN_ERROR(kernelName == nullptr, RT_ERROR_CC_INIT_FAILED, "CC device kernel name is null.");
    COND_RETURN_ERROR(args == nullptr, RT_ERROR_INVALID_VALUE, "CC device kernel args are null.");

    if (std::strcmp(kernelName, CC_KERNEL_KEYSTREAM_XOR) == 0) {
        COND_RETURN_ERROR(
            argsSize != sizeof(AiccKeystreamXorParam), RT_ERROR_INVALID_VALUE,
            "CC KeystreamXor args size %u is invalid.", argsSize);
        return CcLaunchAivKsXor(stm, *reinterpret_cast<const AiccKeystreamXorParam*>(args));
    }
    return LaunchBuiltinAicpuKernel(stm, kernelName, args, argsSize);
}

rtError_t RegisterCryptoPlugin(CC_CRYPTO_ALG_TYPE algType, CCCryptoPluginFactory factory)
{
    const auto idx = static_cast<uint32_t>(algType);
    if ((idx >= static_cast<uint32_t>(CC_CRYPTO_ALG_TYPE::MAX)) || (factory == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    g_cryptoPluginFactories[idx] = factory;
    return RT_ERROR_NONE;
}

rtError_t CreateCryptoPlugin(CC_CRYPTO_ALG_TYPE algType, CCrypto* crypto, CCCryptoPlugin** plugin)
{
    if (plugin == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    *plugin = nullptr;
    const auto idx = static_cast<uint32_t>(algType);
    if (idx >= static_cast<uint32_t>(CC_CRYPTO_ALG_TYPE::MAX)) {
        return RT_ERROR_INVALID_VALUE;
    }
    CCCryptoPluginFactory factory = g_cryptoPluginFactories[idx];
    if (factory == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    *plugin = factory(crypto);
    return (*plugin != nullptr) ? RT_ERROR_NONE : RT_ERROR_INVALID_VALUE;
}

CC_CRYPTO_ALG_TYPE GetActiveCryptoAlg()
{
    std::lock_guard<std::mutex> lock(g_activeAlgMutex);
    if (g_activeCryptoAlgResolved) {
        return g_activeCryptoAlg;
    }
    std::string encryptMode;
    g_activeCryptoAlg = (ReadCcEncryptMode(encryptMode) && (encryptMode == CC_SYSFS_MEM_ENCRYPT_MODE_CTR)) ?
                            CC_CRYPTO_ALG_TYPE::CTR :
                            CC_CRYPTO_ALG_TYPE::GCM;
    g_activeCryptoAlgResolved = true;
    return g_activeCryptoAlg;
}

std::atomic<CC_CRYPTO_CIPHER>& ActiveCryptoCipherRef() { return g_activeCryptoCipher; }

CC_CRYPTO_CIPHER GetActiveCryptoCipher() { return g_activeCryptoCipher.load(std::memory_order_relaxed); }

rtError_t SetActiveCryptoCipher(CC_CRYPTO_CIPHER cipher)
{
    const auto idx = static_cast<uint32_t>(cipher);
    if (idx >= static_cast<uint32_t>(CC_CRYPTO_CIPHER::MAX)) {
        return RT_ERROR_INVALID_VALUE;
    }
    g_activeCryptoCipher.store(cipher, std::memory_order_relaxed);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
