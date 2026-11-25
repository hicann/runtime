/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software: you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cc_ctr_plugin.h"

#include <cstdint>
#include <limits>
#include <new>
#include <vector>

#include "common/cc_defs.h"
#include "task_queue/task_queue_abi.h"

namespace cce {
namespace runtime {

namespace {
constexpr int KS_GET_TIMEOUT_MS = 60000;

using CtrTaskState = std::vector<KeystreamPair>;
} // namespace

CCCtrPlugin::CCCtrPlugin(CCrypto* crypto)
    : CCCryptoPlugin(
          CC_CRYPTO_ALG_TYPE::CTR, ActiveCryptoCipherRef(), CC_KERNEL_KEYSTREAM_XOR, sizeof(AiccKeystreamXorSliceDesc)),
      crypto_(crypto)
{}

rtError_t CCCtrPlugin::OnTaskBegin(
    const CCMemcpyTask& task, uint32_t deviceId, uint32_t totalSlices, void** pluginTaskCtx)
{
    (void)task;
    (void)deviceId;
    if (pluginTaskCtx == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    auto* state = new (std::nothrow) CtrTaskState(totalSlices);
    if (state == nullptr) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    *pluginTaskCtx = state;
    return RT_ERROR_NONE;
}

static rtError_t ReserveKsSlice(
    CCrypto* crypto, const CCCryptoSliceCtx& ctx, KeystreamPair& pair, AiccKeystreamXorSliceDesc* desc)
{
    rtError_t ret = crypto->GetKeyStreamPair(ctx.deviceId, ctx.sliceSize, KS_GET_TIMEOUT_MS, pair);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    COND_RETURN_ERROR(
        pair.keystreamDevice == nullptr, RT_ERROR_CC_INIT_FAILED,
        "CC CTR keystream device address is null, slice=%u, deviceId=%u.", ctx.sliceIdx, ctx.deviceId);
    desc->keystreamAddr = RtPtrToValue(pair.keystreamDevice);
    desc->ciphertextLen = static_cast<uint32_t>(ctx.sliceSize);
    return RT_ERROR_NONE;
}

rtError_t CCCtrPlugin::PrepareH2DSlice(CCCryptoSliceCtx& ctx, size_t& dmaLen)
{
    rtError_t ret = PrepareD2HSlice(ctx);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    KeystreamPair& pair = (*static_cast<CtrTaskState*>(ctx.pluginTaskCtx))[ctx.sliceIdx];
    ret = crypto_->KeystreamEncrypt(pair, ctx.src, ctx.sliceSize, ctx.hostBuf, ctx.sliceSize);
    if (ret != RT_ERROR_NONE) {
        (void)crypto_->FreeKeyStream(ctx.deviceId, pair);
        return ret;
    }
    dmaLen = ctx.sliceSize;
    return RT_ERROR_NONE;
}

rtError_t CCCtrPlugin::OnH2DSliceDone(CCCryptoSliceCtx& ctx)
{
    auto* state = static_cast<CtrTaskState*>(ctx.pluginTaskCtx);
    if ((state == nullptr) || (ctx.sliceIdx >= state->size())) {
        return RT_ERROR_INVALID_VALUE;
    }
    return crypto_->FreeKeyStream(ctx.deviceId, (*state)[ctx.sliceIdx]);
}

rtError_t CCCtrPlugin::PrepareD2HSlice(CCCryptoSliceCtx& ctx)
{
    auto* state = static_cast<CtrTaskState*>(ctx.pluginTaskCtx);
    auto* desc = reinterpret_cast<AiccKeystreamXorSliceDesc*>(ctx.desc); // 公共前缀布局兼容（offsetof 断言保证）
    if ((state == nullptr) || (desc == nullptr) || (ctx.sliceIdx >= state->size())) {
        return RT_ERROR_INVALID_VALUE;
    }
    return ReserveKsSlice(crypto_, ctx, (*state)[ctx.sliceIdx], desc);
}

rtError_t CCCtrPlugin::FinishD2HSlice(CCCryptoSliceCtx& ctx)
{
    auto* state = static_cast<CtrTaskState*>(ctx.pluginTaskCtx);
    if ((state == nullptr) || (ctx.sliceIdx >= state->size())) {
        return RT_ERROR_INVALID_VALUE;
    }
    KeystreamPair& pair = (*state)[ctx.sliceIdx];
    rtError_t ret = crypto_->KeystreamDecrypt(pair, ctx.hostBuf, ctx.sliceSize, ctx.dst, ctx.sliceSize);
    const rtError_t freeRet = crypto_->FreeKeyStream(ctx.deviceId, pair);
    return (ret != RT_ERROR_NONE) ? ret : freeRet;
}

rtError_t CCCtrPlugin::LaunchTransfer(Stream* const stm, const uint64_t taskQueueAddr, const CCMemcpyTask& task)
{
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC CTR transfer stream is null.");

    AiccKeystreamXorParam param{};
    param.taskQueueAddr = taskQueueAddr;
    const CC_CRYPTO_DIRECTION direction =
        (task.kind == RT_MEMCPY_DEVICE_TO_HOST) ? CC_CRYPTO_DIRECTION::ENCRYPT : CC_CRYPTO_DIRECTION::DECRYPT;
    param.mode = static_cast<uint32_t>(direction);
    param.totalSlices =
        static_cast<uint32_t>((task.totalSize + CC_PLAINTEXT_SLICE_SIZE - 1U) / CC_PLAINTEXT_SLICE_SIZE);
    param.reserved = (task.totalSize > static_cast<size_t>(std::numeric_limits<uint32_t>::max())) ?
                         std::numeric_limits<uint32_t>::max() :
                         static_cast<uint32_t>(task.totalSize);
    return LaunchDeviceKernel(stm, CC_KERNEL_KEYSTREAM_XOR, &param, static_cast<uint32_t>(sizeof(param)));
}

void CCCtrPlugin::OnTaskEnd(const CCMemcpyTask& task, uint32_t deviceId, uint32_t totalSlices, void* pluginTaskCtx)
{
    (void)task;
    auto* state = static_cast<CtrTaskState*>(pluginTaskCtx);
    if (state == nullptr) {
        return;
    }
    // 失败任务可能仍持有密钥流，逐片兜底归还。
    for (uint32_t i = 0U; i < totalSlices && i < state->size(); ++i) {
        (void)crypto_->FreeKeyStream(deviceId, (*state)[i]);
    }
    delete state;
}

CC_REGISTER_CRYPTO_PLUGIN(CC_CRYPTO_ALG_TYPE::CTR, CCCtrPlugin);

} // namespace runtime
} // namespace cce
