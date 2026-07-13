/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memset_common.h"
#include <cstring>

// ==================== Platform detection macros ====================
#if defined(__x86_64__)
    #define RT_ARCH_X86 1
    #include <immintrin.h>
    #include <cpuid.h>
#elif defined(__arm__) || defined(__aarch64__)
    #define RT_ARCH_ARM 1
    #include <arm_neon.h>
#endif

namespace cce {
namespace runtime {

// LCOV_EXCL_START
// -------------------- Naive implementation --------------------
// Dynamic selection
static inline __attribute__((unused)) void Memset32_Naive(uint32_t* dst, uint32_t value, size_t count)
{
    for (size_t i = 0UL; i < count; ++i) {
        dst[i] = value;
    }
}

// -------------------- x86 SIMD ---------------------------------
#ifdef RT_ARCH_X86
__attribute__((target("avx2"))) 
static inline void Memset32_AVX2(uint32_t* dst, uint32_t value, size_t count)
{
    __m256i val = _mm256_set1_epi32(static_cast<int>(value));
    size_t i = 0UL;
    for (; i + 8ULL <= count; i += 8ULL) {
        _mm256_storeu_si256(reinterpret_cast<__m256i*>(dst + i), val);
    }
    for (; i < count; ++i) {
        dst[i] = value;
    }
}

// LCOV_EXCL_STOP

__attribute__((target("avx512f")))
static inline void Memset32_AVX512(uint32_t* dst, uint32_t value, size_t count)
{
    __m512i val = _mm512_set1_epi32(static_cast<int>(value));
    size_t i = 0UL;
    for (; i + 16ULL <= count; i += 16ULL) {
        _mm512_storeu_si512(reinterpret_cast<__m512i*>(dst + i), val);
    }
    for (; i < count; ++i) {
        dst[i] = value;
    }
}

// LCOV_EXCL_START
static inline bool CpuSupportsAVX2(void)
{
    unsigned int eax = 0U;
    unsigned int ebx = 0U;
    unsigned int ecx = 0U;
    unsigned int edx = 0U;
    __cpuid_count(7U, 0U, eax, ebx, ecx, edx);
    return (ebx & (1U << 5U)) != 0U;
}
// LCOV_EXCL_STOP

static inline bool CpuSupportsAVX512F(void)
{
    unsigned int eax = 0U;
    unsigned int ebx = 0U;
    unsigned int ecx = 0U;
    unsigned int edx = 0U;
    __cpuid_count(7U, 0U, eax, ebx, ecx, edx);
    return (ebx & (1U << 16U)) != 0U;
}
#endif

// -------------------- ARM NEON ---------------------------------
#ifdef RT_ARCH_ARM
static inline void Memset32_NEON(uint32_t* dst, uint32_t value, size_t count)
{
    uint32x4_t val = vdupq_n_u32(value);
    size_t i = 0UL;
    for (; i + 4ULL <= count; i += 4ULL) {
        vst1q_u32(dst + i, val);
    }
    for (; i < count; ++i) {
        dst[i] = value;
    }
}
#endif

// -------------------- Function pointer type --------------------
using Memset32Func = void (*)(uint32_t*, uint32_t, size_t);

// -------------------- Runtime selector -------------------------
static inline Memset32Func GetOptimalMemset32Func(void)
{
#ifdef RT_ARCH_X86
    if (CpuSupportsAVX512F()) {
        return Memset32_AVX512;
    } else if (CpuSupportsAVX2()) {
        return Memset32_AVX2;
    } else {
        return Memset32_Naive;
    }
#elif defined(RT_ARCH_ARM)
    return Memset32_NEON;
#else
    return Memset32_Naive;
#endif
}

// -------------------- Public entry (with alignment optimization) --------------------
void MemsetD32Optimized(uint32_t* dst, uint32_t value, size_t count)
{
    if (count == 0UL) {
        return;
    }
    
    static Memset32Func optimal_func = GetOptimalMemset32Func();
    const size_t kAlignBytes = 32ULL;
    uintptr_t addr = reinterpret_cast<uintptr_t>(dst);
    size_t offset = 0UL;
    
    // Handle misaligned prefix
    while ((offset < count) && ((addr & (kAlignBytes - 1ULL)) != 0ULL)) {
        dst[offset] = value;
        ++offset;
        addr += sizeof(uint32_t);
    }
    
    // Handle aligned main body
    size_t remaining = count - offset;
    if (remaining > 0UL) {
        optimal_func(dst + offset, value, remaining);
    }
}

}  // namespace runtime 
}  // namespace cce