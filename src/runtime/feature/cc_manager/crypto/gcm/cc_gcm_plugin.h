/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_GCM_PLUGIN_H
#define CCE_RUNTIME_CC_GCM_PLUGIN_H

#include "cc_task_queue.h"
#include "crypto/cc_crypto.h"
#include "crypto/cc_crypto_plugin.h"

namespace cce {
namespace runtime {

// 描述符整体（含 padding）作为 AAD，布局必须与设备侧一致。
struct AiccCryptoSliceDesc {
    volatile uint64_t ciphertextAddr; // 设备侧密文地址
    volatile uint64_t plaintextAddr;  // 设备侧明文地址
    volatile uint32_t ciphertextLen;  // 密文长度：密文布局 [header || payload]
    volatile uint32_t plaintextLen;   // 明文长度
    volatile uint32_t sliceIdx;       // 分片序号
    volatile uint32_t reserved;       // 对齐填充
};
static_assert(sizeof(AiccCryptoSliceDesc) == 32U, "AiccCryptoSliceDesc must be 32 bytes");
static_assert(sizeof(AiccCryptoSliceDesc) % 8U == 0U, "desc size must preserve taskDescList 8B alignment");
static_assert(
    offsetof(AiccCryptoSliceDesc, reserved) == 28U, "AiccCryptoSliceDesc common prefix must match AiccSliceDescBase");

// 原样传给设备算子，以下断言约束跨端 ABI。
struct AiccCryptoParam {
    uint64_t taskQueueAddr; // 任务队列地址
    uint64_t keyAddr;       // 设备侧方向密钥，Host 已按 mode 偏移: DECRYPT(H2D): +0, ENCRYPT(D2H): +keyLen
    uint32_t keyLen;        // 密钥长度
    uint32_t mode;          // ENCRYPT(D2H, 设备加密) / DECRYPT(H2D, 设备解密)
    uint32_t algType;       // 加密算法：AICC_ALG_AES128_GCM(0)
    uint32_t totalSlices;   // 本条 memcpy 的总分片数
};
static_assert(sizeof(AiccCryptoParam) == 32U, "AiccCryptoParam must be 32 bytes");
static_assert(offsetof(AiccCryptoParam, taskQueueAddr) == 0U, "AiccCryptoParam taskQueueAddr offset");
static_assert(offsetof(AiccCryptoParam, keyAddr) == 8U, "AiccCryptoParam keyAddr offset");
static_assert(offsetof(AiccCryptoParam, keyLen) == 16U, "AiccCryptoParam keyLen offset");
static_assert(offsetof(AiccCryptoParam, mode) == 20U, "AiccCryptoParam mode offset");
static_assert(offsetof(AiccCryptoParam, algType) == 24U, "AiccCryptoParam algType offset");
static_assert(offsetof(AiccCryptoParam, totalSlices) == 28U, "AiccCryptoParam totalSlices offset");

class CCGcmPlugin : public CCCryptoPlugin {
public:
    explicit CCGcmPlugin(CCrypto* crypto);
    ~CCGcmPlugin() override = default;

    rtError_t PrepareH2DSlice(CCCryptoSliceCtx& ctx, size_t& dmaLen) override;
    rtError_t PrepareD2HSlice(CCCryptoSliceCtx& ctx) override;
    rtError_t FinishD2HSlice(CCCryptoSliceCtx& ctx) override;
    rtError_t LaunchTransfer(Stream* const stm, const uint64_t taskQueueAddr, const CCMemcpyTask& task) override;

private:
    CCrypto* crypto_{nullptr}; // 加解密原语来源（Encrypt/Decrypt）
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_GCM_PLUGIN_H
