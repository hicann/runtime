/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cc_gcm_plugin.h"

#include "common/cc_defs.h"

#include "device.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {

CCGcmPlugin::CCGcmPlugin(CCrypto* crypto)
    : CCCryptoPlugin(
          CC_CRYPTO_ALG_TYPE::GCM, ActiveCryptoCipherRef(), CC_KERNEL_AICC_CRYPTO, sizeof(AiccCryptoSliceDesc)),
      crypto_(crypto)
{}

rtError_t CCGcmPlugin::PrepareH2DSlice(CCCryptoSliceCtx& ctx, size_t& dmaLen)
{
    auto* const desc = RtPtrToPtr<AiccCryptoSliceDesc*>(ctx.desc);
    if ((desc == nullptr) || (crypto_ == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    desc->ciphertextLen = CC_CIPHER_HEADER_SIZE + static_cast<uint32_t>(ctx.sliceSize);
    size_t ctLen = 0U;
    const rtError_t ret = crypto_->Encrypt(
        ctx.deviceId, Cipher(), static_cast<const uint8_t*>(ctx.src), ctx.sliceSize, RtPtrToPtr<const uint8_t*>(desc),
        sizeof(*desc), static_cast<uint8_t*>(ctx.hostBuf), &ctLen);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CC GCM encrypt failed, slice=%u, ret=%#x", ctx.sliceIdx, ret);
        return ret;
    }
    dmaLen = ctLen;
    return RT_ERROR_NONE;
}

rtError_t CCGcmPlugin::PrepareD2HSlice(CCCryptoSliceCtx& ctx)
{
    auto* const desc = RtPtrToPtr<AiccCryptoSliceDesc*>(ctx.desc);
    if (desc == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    desc->ciphertextLen = CC_CIPHER_HEADER_SIZE + static_cast<uint32_t>(ctx.sliceSize);
    return RT_ERROR_NONE;
}

rtError_t CCGcmPlugin::FinishD2HSlice(CCCryptoSliceCtx& ctx)
{
    const auto* const desc = RtPtrToPtr<const AiccCryptoSliceDesc*>(ctx.desc);
    if ((desc == nullptr) || (crypto_ == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    size_t ptLen = 0U;
    const rtError_t ret = crypto_->Decrypt(
        ctx.deviceId, Cipher(), static_cast<const uint8_t*>(ctx.hostBuf), desc->ciphertextLen,
        RtPtrToPtr<const uint8_t*>(desc), sizeof(*desc), static_cast<uint8_t*>(ctx.dst), &ptLen);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CC GCM decrypt failed, slice=%u, ret=%#x", ctx.sliceIdx, ret);
    }
    return ret;
}

rtError_t CCGcmPlugin::LaunchTransfer(Stream* const stm, const uint64_t taskQueueAddr, const CCMemcpyTask& task)
{
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC GCM transfer stream is null.");
    COND_RETURN_ERROR(crypto_ == nullptr, RT_ERROR_CC_INIT_FAILED, "CC GCM crypto primitive source is null.");
    COND_RETURN_ERROR(stm->Device_() == nullptr, RT_ERROR_DEVICE_NULL, "CC GCM transfer device is null.");

    const CC_CRYPTO_DIRECTION direction =
        (task.kind == RT_MEMCPY_DEVICE_TO_HOST) ? CC_CRYPTO_DIRECTION::ENCRYPT : CC_CRYPTO_DIRECTION::DECRYPT;
    uint64_t keyAddr = 0U;
    const rtError_t ret = crypto_->GetDeviceKeyAddr(direction, &keyAddr);
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, RT_ERROR_CC_CRYPTO_FAILED, "Get GCM device key addr failed, ret=%#x.",
        static_cast<uint32_t>(ret));

    AiccCryptoParam param{};
    param.taskQueueAddr = taskQueueAddr;
    param.keyAddr = keyAddr;
    param.keyLen = AICC_KEY_SIZE;
    param.mode = static_cast<uint32_t>(direction);
    param.algType = AICC_ALG_AES128_GCM;
    param.totalSlices =
        static_cast<uint32_t>((task.totalSize + CC_PLAINTEXT_SLICE_SIZE - 1U) / CC_PLAINTEXT_SLICE_SIZE);
    return LaunchDeviceKernel(stm, CC_KERNEL_AICC_CRYPTO, &param, static_cast<uint32_t>(sizeof(param)));
}

CC_REGISTER_CRYPTO_PLUGIN(CC_CRYPTO_ALG_TYPE::GCM, CCGcmPlugin);

} // namespace runtime
} // namespace cce
