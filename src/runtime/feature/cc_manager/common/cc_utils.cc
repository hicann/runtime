/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cc_utils.h"

#include <algorithm>
#include <chrono>
#include <thread>

#include "securec.h"

#if defined(__aarch64__)
#include <arm_neon.h>
#elif defined(__x86_64__) || defined(_M_X64)
#include <immintrin.h> // AVX2（若编译期开启）与 SSE2（x86-64 基线，无需 -msse 编译开关）
#endif

namespace cce {
namespace runtime {

void CCSpinWait(const std::chrono::steady_clock::time_point start)
{
    const uint64_t waitedUs = static_cast<uint64_t>(
        std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::steady_clock::now() - start).count());
    if (waitedUs < CC_SPIN_WAIT_YIELD_US) {
        std::this_thread::yield();
        return;
    }

    uint64_t sleepUs = 1U;
    const uint64_t backoffUs = waitedUs - CC_SPIN_WAIT_YIELD_US;
    while ((sleepUs < backoffUs) && (sleepUs < CC_SPIN_WAIT_MAX_SLEEP_US)) {
        sleepUs <<= 1U;
    }
    std::this_thread::sleep_for(std::chrono::microseconds(std::min(sleepUs, CC_SPIN_WAIT_MAX_SLEEP_US)));
}

namespace {
inline void XorWord64(const uint8_t* inputA, const uint8_t* inputB, uint8_t* output)
{
    // 输入不保证 8B 对齐，使用拷贝避免非对齐解引用。
    uint64_t wordA = 0UL;
    uint64_t wordB = 0UL;
    (void)memcpy_s(&wordA, sizeof(uint64_t), inputA, sizeof(uint64_t));
    (void)memcpy_s(&wordB, sizeof(uint64_t), inputB, sizeof(uint64_t));
    wordA ^= wordB;
    (void)memcpy_s(output, sizeof(uint64_t), &wordA, sizeof(uint64_t));
}
} // namespace

void XorBytesOptimized(const uint8_t* inputA, const uint8_t* inputB, uint8_t* output, size_t length)
{
    if ((length == 0UL) || (inputA == nullptr) || (inputB == nullptr) || (output == nullptr)) {
        return;
    }

    size_t i = 0UL;
#if defined(__aarch64__)
    for (; i + sizeof(uint8x16_t) <= length; i += sizeof(uint8x16_t)) {
        const uint8x16_t va = vld1q_u8(inputA + i);
        const uint8x16_t vb = vld1q_u8(inputB + i);
        vst1q_u8(output + i, veorq_u8(va, vb));
    }
#elif defined(__x86_64__) || defined(_M_X64)
#if defined(__AVX2__)
    for (; i + sizeof(__m256i) <= length; i += sizeof(__m256i)) {
        const __m256i va = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(inputA + i));
        const __m256i vb = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(inputB + i));
        _mm256_storeu_si256(reinterpret_cast<__m256i*>(output + i), _mm256_xor_si256(va, vb));
    }
#endif
    for (; i + sizeof(__m128i) <= length; i += sizeof(__m128i)) {
        const __m128i va = _mm_loadu_si128(reinterpret_cast<const __m128i*>(inputA + i));
        const __m128i vb = _mm_loadu_si128(reinterpret_cast<const __m128i*>(inputB + i));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(output + i), _mm_xor_si128(va, vb));
    }
#endif
    for (; i + sizeof(uint64_t) <= length; i += sizeof(uint64_t)) {
        XorWord64(inputA + i, inputB + i, output + i);
    }
    for (; i < length; ++i) {
        output[i] = static_cast<uint8_t>(inputA[i] ^ inputB[i]);
    }
}

} // namespace runtime
} // namespace cce
