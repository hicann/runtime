/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_DEFS_H
#define CCE_RUNTIME_CC_DEFS_H

#include <cstdint>

namespace cce {
namespace runtime {

constexpr uint64_t CC_DEV_MEM_ALIGN_BYTES = 32U;

constexpr uint64_t CcAlignUp(const uint64_t size)
{
    return (size + CC_DEV_MEM_ALIGN_BYTES - 1U) & ~(CC_DEV_MEM_ALIGN_BYTES - 1U);
}

constexpr const char* CC_KERNEL_KEYSTREAM_XOR = "AiccKeystreamXor";   // CTR 的 AIV XOR 核
constexpr const char* CC_KERNEL_KEYSTREAM_FILL = "AiccKeystreamFill"; // 密钥流并行填充
constexpr const char* CC_KERNEL_AICC_CRYPTO = "AiccCrypto";           // GCM 整体 AEAD
constexpr const char* CC_KERNEL_AICC_LOAD_KEY = "AiccLoadKey";        // 装载方向密钥

constexpr uint32_t CC_AIV_DIM_UNIT_BYTES = 256U * 1024U;

constexpr uint32_t CcNextPow2(const uint32_t n)
{
    uint32_t p = 1U;
    while (p < n) {
        p <<= 1U;
    }
    return p;
}

constexpr uint32_t CcSelectAivBlockDim(const uint32_t totalSize, const uint32_t maxDim)
{
    // 每核 256 KiB，向上取 2 的幂；0 字节沿用上限，先减后除避免溢出。
    const uint32_t cap = (maxDim == 0U) ? 1U : maxDim;
    if (totalSize == 0U) {
        return cap;
    }
    const uint32_t needed = ((totalSize - 1U) / CC_AIV_DIM_UNIT_BYTES) + 1U;
    const uint32_t dim = CcNextPow2(needed);
    return (dim < cap) ? dim : cap;
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_DEFS_H
