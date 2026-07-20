/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TSD_SHA256_H
#define TSD_SHA256_H

#include <cstddef>
#include <cstdint>
#include <string>

namespace tsd {
namespace sha256 {

constexpr uint32_t DIGEST_LENGTH = 32U;
constexpr uint32_t SHA256_BLOCK_SIZE = 64U;

struct Context {
    uint32_t state[8];
    uint64_t totalLen;
    uint32_t bufLen; // invariant: [0, SHA256_BLOCK_SIZE), maintained by UpdateCore
    uint8_t buffer[SHA256_BLOCK_SIZE];
};

void Init(Context& ctx);
void Update(Context& ctx, const uint8_t* data, size_t len);
void Final(Context& ctx, uint8_t* hash);

// 一次性计算
void Compute(const uint8_t* data, size_t len, uint8_t* hash);

// 一次性计算并返回十六进制字符串
std::string ComputeHexString(const uint8_t* data, size_t len);

// 强制使用纯软件实现（用于UT验证软件回退路径的正确性）
void ComputeSoft(const uint8_t* data, size_t len, uint8_t* hash);
std::string ComputeHexStringSoft(const uint8_t* data, size_t len);

} // namespace sha256
} // namespace tsd

#endif // TSD_SHA256_H
