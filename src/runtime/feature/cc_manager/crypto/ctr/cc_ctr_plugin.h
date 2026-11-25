/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software: you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_CTR_PLUGIN_H
#define CCE_RUNTIME_CC_CTR_PLUGIN_H

#include <cstddef>

#include "cc_task_queue.h"
#include "crypto/cc_crypto.h"
#include "crypto/cc_crypto_plugin.h"

namespace cce {
namespace runtime {

// 每片预取密钥流做 XOR，设备消费完成后归还。
class CCCtrPlugin : public CCCryptoPlugin {
public:
    explicit CCCtrPlugin(CCrypto* crypto);
    ~CCCtrPlugin() override = default;

    rtError_t OnTaskBegin(
        const CCMemcpyTask& task, uint32_t deviceId, uint32_t totalSlices, void** pluginTaskCtx) override;
    rtError_t PrepareH2DSlice(CCCryptoSliceCtx& ctx, size_t& dmaLen) override;
    rtError_t OnH2DSliceDone(CCCryptoSliceCtx& ctx) override;
    rtError_t PrepareD2HSlice(CCCryptoSliceCtx& ctx) override;
    rtError_t FinishD2HSlice(CCCryptoSliceCtx& ctx) override;
    rtError_t LaunchTransfer(Stream* stm, uint64_t taskQueueAddr, const CCMemcpyTask& task) override;
    void OnTaskEnd(const CCMemcpyTask& task, uint32_t deviceId, uint32_t totalSlices, void* pluginTaskCtx) override;

private:
    CCrypto* crypto_{nullptr}; // 密钥流接口来源（GetKeyStreamPair/KeystreamEncrypt/FreeKeyStream）
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_CTR_PLUGIN_H
