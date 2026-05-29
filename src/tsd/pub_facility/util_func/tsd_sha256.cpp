/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "tsd_sha256.h"
#include <mutex>
#include <securec.h>
#include "common/type_def.h"
#include "tsd_log.h"

#if defined(__aarch64__)
#include <arm_neon.h>
#include <sys/auxv.h>
#include <asm/hwcap.h>
#define TSD_SHA256_PLATFORM_ARM 1
#define TSD_SHA256_PLATFORM_X86 0
#elif defined(__x86_64__) || defined(_M_X64) || defined(__i386__) || defined(_M_IX86)
#include <immintrin.h>
#define TSD_SHA256_PLATFORM_ARM 0
#define TSD_SHA256_PLATFORM_X86 1
#else
#define TSD_SHA256_PLATFORM_ARM 0
#define TSD_SHA256_PLATFORM_X86 0
#endif

namespace tsd {
namespace sha256 {

namespace {

constexpr uint32_t INITIAL_HASH[8] = {
    0x6a09e667U, 0xbb67ae85U, 0x3c6ef372U, 0xa54ff53aU,
    0x510e527fU, 0x9b05688cU, 0x1f83d9abU, 0x5be0cd19U
};

constexpr uint32_t K[64] = {
    0x428a2f98U, 0x71374491U, 0xb5c0fbcfU, 0xe9b5dba5U,
    0x3956c25bU, 0x59f111f1U, 0x923f82a4U, 0xab1c5ed5U,
    0xd807aa98U, 0x12835b01U, 0x243185beU, 0x550c7dc3U,
    0x72be5d74U, 0x80deb1feU, 0x9bdc06a7U, 0xc19bf174U,
    0xe49b69c1U, 0xefbe4786U, 0x0fc19dc6U, 0x240ca1ccU,
    0x2de92c6fU, 0x4a7484aaU, 0x5cb0a9dcU, 0x76f988daU,
    0x983e5152U, 0xa831c66dU, 0xb00327c8U, 0xbf597fc7U,
    0xc6e00bf3U, 0xd5a79147U, 0x06ca6351U, 0x14292967U,
    0x27b70a85U, 0x2e1b2138U, 0x4d2c6dfcU, 0x53380d13U,
    0x650a7354U, 0x766a0abbU, 0x81c2c92eU, 0x92722c85U,
    0xa2bfe8a1U, 0xa81a664bU, 0xc24b8b70U, 0xc76c51a3U,
    0xd192e819U, 0xd6990624U, 0xf40e3585U, 0x106aa070U,
    0x19a4c116U, 0x1e376c08U, 0x2748774cU, 0x34b0bcb5U,
    0x391c0cb3U, 0x4ed8aa4aU, 0x5b9cca4fU, 0x682e6ff3U,
    0x748f82eeU, 0x78a5636fU, 0x84c87814U, 0x8cc70208U,
    0x90befffaU, 0xa4506cebU, 0xbef9a3f7U, 0xc67178f2U
};

// ============================================================
// Software fallback (all platforms)
// ============================================================

inline uint32_t RotateRight(uint32_t x, uint32_t n)
{
    return (x >> n) | (x << (32U - n));
}

inline uint32_t BigSigma0(uint32_t x) { return RotateRight(x, 2) ^ RotateRight(x, 13) ^ RotateRight(x, 22); }
inline uint32_t BigSigma1(uint32_t x) { return RotateRight(x, 6) ^ RotateRight(x, 11) ^ RotateRight(x, 25); }
inline uint32_t SmallSigma0(uint32_t x) { return RotateRight(x, 7) ^ RotateRight(x, 18) ^ (x >> 3); }
inline uint32_t SmallSigma1(uint32_t x) { return RotateRight(x, 17) ^ RotateRight(x, 19) ^ (x >> 10); }
inline uint32_t Choose(uint32_t e, uint32_t f, uint32_t g) { return (e & f) ^ (~e & g); }
inline uint32_t Majority(uint32_t a, uint32_t b, uint32_t c) { return (a & b) ^ (a & c) ^ (b & c); }

inline uint32_t LoadBigEndian32(const uint8_t *p)
{
    return (static_cast<uint32_t>(p[0]) << 24U) |
           (static_cast<uint32_t>(p[1]) << 16U) |
           (static_cast<uint32_t>(p[2]) << 8U)  |
           static_cast<uint32_t>(p[3]);
}

void CompressBlockSoft(uint32_t state[8], const uint8_t *block)
{
    uint32_t w[64];
    for (int i = 0; i < 16; ++i) {
        w[i] = LoadBigEndian32(block + i * 4);
    }
    for (int i = 16; i < 64; ++i) {
        w[i] = SmallSigma1(w[i - 2]) + w[i - 7] + SmallSigma0(w[i - 15]) + w[i - 16];
    }

    uint32_t a = state[0], b = state[1], c = state[2], d = state[3];
    uint32_t e = state[4], f = state[5], g = state[6], h = state[7];

    for (int i = 0; i < 64; ++i) {
        uint32_t t1 = h + BigSigma1(e) + Choose(e, f, g) + K[i] + w[i];
        uint32_t t2 = BigSigma0(a) + Majority(a, b, c);
        h = g; g = f; f = e; e = d + t1;
        d = c; c = b; b = a; a = t1 + t2;
    }

    state[0] += a; state[1] += b; state[2] += c; state[3] += d;
    state[4] += e; state[5] += f; state[6] += g; state[7] += h;
}

// ============================================================
// ARM SHA2 Crypto Extensions (runtime detection via getauxval)
// ============================================================
#if TSD_SHA256_PLATFORM_ARM

static bool DetectArmCE()
{
    const unsigned long hwcap = getauxval(AT_HWCAP);
    return (hwcap & HWCAP_SHA2) != 0;
}

static const bool g_hasArmCE = DetectArmCE();

void CompressBlockArmCE(uint32_t state[8], const uint8_t *block)
{
    uint32x4_t abcd = vld1q_u32(&state[0]);
    uint32x4_t efgh = vld1q_u32(&state[4]);
    const uint32x4_t abcd_orig = abcd;
    const uint32x4_t efgh_orig = efgh;

    uint32x4_t msg0 = vreinterpretq_u32_u8(vrev32q_u8(vld1q_u8(block)));
    uint32x4_t msg1 = vreinterpretq_u32_u8(vrev32q_u8(vld1q_u8(block + 16)));
    uint32x4_t msg2 = vreinterpretq_u32_u8(vrev32q_u8(vld1q_u8(block + 32)));
    uint32x4_t msg3 = vreinterpretq_u32_u8(vrev32q_u8(vld1q_u8(block + 48)));

    uint32x4_t wk, abcd_prev;

#define SHA256_ROUND4_SCHED(i, m0, m1, m2, m3) \
    wk = vaddq_u32(m0, vld1q_u32(&K[(i)]));    \
    abcd_prev = abcd;                            \
    abcd = vsha256hq_u32(abcd, efgh, wk);        \
    efgh = vsha256h2q_u32(efgh, abcd_prev, wk);  \
    m0 = vsha256su1q_u32(vsha256su0q_u32(m0, m1), m2, m3)

#define SHA256_ROUND4_FINAL(i, m0) \
    wk = vaddq_u32(m0, vld1q_u32(&K[(i)]));  \
    abcd_prev = abcd;                          \
    abcd = vsha256hq_u32(abcd, efgh, wk);      \
    efgh = vsha256h2q_u32(efgh, abcd_prev, wk)

    SHA256_ROUND4_SCHED(0,  msg0, msg1, msg2, msg3);
    SHA256_ROUND4_SCHED(4,  msg1, msg2, msg3, msg0);
    SHA256_ROUND4_SCHED(8,  msg2, msg3, msg0, msg1);
    SHA256_ROUND4_SCHED(12, msg3, msg0, msg1, msg2);
    SHA256_ROUND4_SCHED(16, msg0, msg1, msg2, msg3);
    SHA256_ROUND4_SCHED(20, msg1, msg2, msg3, msg0);
    SHA256_ROUND4_SCHED(24, msg2, msg3, msg0, msg1);
    SHA256_ROUND4_SCHED(28, msg3, msg0, msg1, msg2);
    SHA256_ROUND4_SCHED(32, msg0, msg1, msg2, msg3);
    SHA256_ROUND4_SCHED(36, msg1, msg2, msg3, msg0);
    SHA256_ROUND4_SCHED(40, msg2, msg3, msg0, msg1);
    SHA256_ROUND4_SCHED(44, msg3, msg0, msg1, msg2);
    SHA256_ROUND4_FINAL(48, msg0);
    SHA256_ROUND4_FINAL(52, msg1);
    SHA256_ROUND4_FINAL(56, msg2);
    SHA256_ROUND4_FINAL(60, msg3);

#undef SHA256_ROUND4_SCHED
#undef SHA256_ROUND4_FINAL

    vst1q_u32(&state[0], vaddq_u32(abcd, abcd_orig));
    vst1q_u32(&state[4], vaddq_u32(efgh, efgh_orig));
}

#endif  // TSD_SHA256_PLATFORM_ARM

// ============================================================
// x86 SSSE3 + BMI2 accelerated path (runtime detection)
// SSSE3: Intel Core 2 2007+ / AMD Bulldozer 2011+
// BMI2:  Intel Haswell 2013+ / AMD Zen 2017+
//
// Uses 128-bit XMM (not 256-bit YMM) intentionally:
//   - 256-bit store → 32-bit scalar load triggers partial-width
//     store-to-load forwarding stalls (~15 cycles each on Intel).
//   - 128-bit store → 32-bit scalar load forwards cleanly.
//   - No AVX-SSE state transition overhead.
// BMI2 RORX: no FLAGS write, breaks false dependency chain in
// schedule expansion and compression, improving OOO scheduling.
// ============================================================
#if TSD_SHA256_PLATFORM_X86

static bool DetectX86Ssse3Bmi2()
{
    return __builtin_cpu_supports("ssse3") && __builtin_cpu_supports("bmi2");
}

static const bool g_hasSsse3Bmi2 = DetectX86Ssse3Bmi2();

// _rorx_u32 requires __BMI2__ defined at parse time (header guard), but
// __attribute__((target("bmi2"))) only affects code-gen, not header parsing.
// Use a portable rotation helper; with target("bmi2") + -O2 the compiler
// recognizes the rotate idiom and emits the RORX instruction.
static inline uint32_t Ror32(uint32_t x, unsigned imm) noexcept
{
    return (x >> imm) | (x << (32U - imm));
}

__attribute__((target("ssse3,bmi2")))
void CompressBlockSsse3Bmi2(uint32_t state[8], const uint8_t *block)
{
    // Load 16 message words with SSSE3 byte-swap, 4 words (128-bit) at a time.
    // 128-bit stores allow clean 32-bit scalar forwarding in the schedule loop.
    const __m128i BSWAP = _mm_set_epi8(12, 13, 14, 15,  8,  9, 10, 11,
                                        4,  5,  6,  7,  0,  1,  2,  3);
    uint32_t w[64];
    for (int i = 0; i < 16; i += 4) {
        _mm_storeu_si128(PtrToPtr<uint32_t, __m128i>(&w[i]),
            _mm_shuffle_epi8(
                _mm_loadu_si128(PtrToPtr<const uint8_t, const __m128i>(block + i * 4)), BSWAP));
    }

    for (int i = 16; i < 64; ++i) {
        const uint32_t s0 = Ror32(w[i - 15], 7) ^ Ror32(w[i - 15], 18) ^ (w[i - 15] >> 3);
        const uint32_t s1 = Ror32(w[i - 2], 17) ^ Ror32(w[i - 2], 19) ^ (w[i - 2] >> 10);
        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
    }

    uint32_t a = state[0], b = state[1], c = state[2], d = state[3];
    uint32_t e = state[4], f = state[5], g = state[6], h = state[7];

    for (int i = 0; i < 64; ++i) {
        const uint32_t S1 = Ror32(e, 6) ^ Ror32(e, 11) ^ Ror32(e, 25);
        const uint32_t ch = (e & f) ^ (~e & g);
        const uint32_t t1 = h + S1 + ch + K[i] + w[i];
        const uint32_t S0 = Ror32(a, 2) ^ Ror32(a, 13) ^ Ror32(a, 22);
        const uint32_t maj = (a & b) ^ (a & c) ^ (b & c);
        const uint32_t t2 = S0 + maj;
        h = g; g = f; f = e; e = d + t1;
        d = c; c = b; b = a; a = t1 + t2;
    }

    state[0] += a; state[1] += b; state[2] += c; state[3] += d;
    state[4] += e; state[5] += f; state[6] += g; state[7] += h;
}

#endif  // TSD_SHA256_PLATFORM_X86

// ============================================================
// Dispatch
// ============================================================

inline void StoreBigEndian64(uint8_t *p, uint64_t v)
{
    p[0] = static_cast<uint8_t>(v >> 56U);
    p[1] = static_cast<uint8_t>(v >> 48U);
    p[2] = static_cast<uint8_t>(v >> 40U);
    p[3] = static_cast<uint8_t>(v >> 32U);
    p[4] = static_cast<uint8_t>(v >> 24U);
    p[5] = static_cast<uint8_t>(v >> 16U);
    p[6] = static_cast<uint8_t>(v >> 8U);
    p[7] = static_cast<uint8_t>(v);
}

inline void StoreBigEndian32(uint8_t *p, uint32_t v)
{
    p[0] = static_cast<uint8_t>(v >> 24U);
    p[1] = static_cast<uint8_t>(v >> 16U);
    p[2] = static_cast<uint8_t>(v >> 8U);
    p[3] = static_cast<uint8_t>(v);
}

void LogSha256Backend()
{
    static std::once_flag logOnce;
    std::call_once(logOnce, []() {
#if TSD_SHA256_PLATFORM_ARM
        if (g_hasArmCE) {
            TSD_INFO("[TsdSha256] Using ARM SHA2 Crypto Extensions accelerated path.");
        } else {
            TSD_INFO("[TsdSha256] ARM SHA2 CE not available, using software fallback path.");
        }
#elif TSD_SHA256_PLATFORM_X86
        if (g_hasSsse3Bmi2) {
            TSD_INFO("[TsdSha256] Using x86 SSSE3+BMI2 accelerated path.");
        } else {
            TSD_INFO("[TsdSha256] x86 SSSE3+BMI2 not available, using software fallback path.");
        }
#else
        TSD_INFO("[TsdSha256] Unknown platform, using software fallback path.");
#endif
    });
}

inline void CompressBlock(uint32_t state[8], const uint8_t *block)
{
#if TSD_SHA256_PLATFORM_ARM
    if (g_hasArmCE) {
        CompressBlockArmCE(state, block);
    } else {
        CompressBlockSoft(state, block);
    }
#elif TSD_SHA256_PLATFORM_X86
    if (g_hasSsse3Bmi2) {
        CompressBlockSsse3Bmi2(state, block);
    } else {
        CompressBlockSoft(state, block);
    }
#else
    CompressBlockSoft(state, block);
#endif
}

using CompressFn = void (*)(uint32_t *, const uint8_t *);

void UpdateCore(Context &ctx, const uint8_t *data, size_t len, CompressFn compress)
{
    const size_t origLen = len;

    if (ctx.bufLen > 0) {
        const uint32_t fill = SHA256_BLOCK_SIZE - ctx.bufLen;
        if (len < fill) {
            const errno_t err = memcpy_s(ctx.buffer + ctx.bufLen,
                                         SHA256_BLOCK_SIZE - ctx.bufLen, data, len);
            if (err != EOK) {
                return;
            }
            ctx.bufLen += static_cast<uint32_t>(len % SHA256_BLOCK_SIZE);
            ctx.totalLen += origLen;
            return;
        }
        const errno_t err = memcpy_s(ctx.buffer + ctx.bufLen,
                                     SHA256_BLOCK_SIZE - ctx.bufLen, data, fill);
        if (err != EOK) {
            return;
        }
        compress(ctx.state, ctx.buffer);
        data += fill;
        len -= fill;
        ctx.bufLen = 0;
    }

    while (len >= SHA256_BLOCK_SIZE) {
        compress(ctx.state, data);
        data += SHA256_BLOCK_SIZE;
        len -= SHA256_BLOCK_SIZE;
    }

    if (len > 0) {
        const errno_t err = memcpy_s(ctx.buffer, SHA256_BLOCK_SIZE, data, len);
        if (err != EOK) {
            return;
        }
        ctx.bufLen = static_cast<uint32_t>(len % SHA256_BLOCK_SIZE);
    }

    ctx.totalLen += origLen;
}

void FinalCore(Context &ctx, uint8_t *hash, CompressFn compress)
{
    const uint64_t totalBits = ctx.totalLen * 8U;

    ctx.buffer[ctx.bufLen++] = 0x80U;

    if (ctx.bufLen > 56U) {
        const errno_t err = memset_s(ctx.buffer + ctx.bufLen,
                                     SHA256_BLOCK_SIZE - ctx.bufLen, 0,
                                     SHA256_BLOCK_SIZE - ctx.bufLen);
        if (err != EOK) {
            return;
        }
        compress(ctx.state, ctx.buffer);
        ctx.bufLen = 0;
    }

    const errno_t err = memset_s(ctx.buffer + ctx.bufLen,
                                 SHA256_BLOCK_SIZE - ctx.bufLen, 0,
                                 56U - ctx.bufLen);
    if (err != EOK) {
        return;
    }

    StoreBigEndian64(ctx.buffer + 56U, totalBits);
    compress(ctx.state, ctx.buffer);

    for (int i = 0; i < 8; ++i) {
        StoreBigEndian32(hash + i * 4, ctx.state[i]);
    }
}

}  // anonymous namespace

void Init(Context &ctx)
{
    for (int i = 0; i < 8; ++i) {
        ctx.state[i] = INITIAL_HASH[i];
    }
    ctx.totalLen = 0;
    ctx.bufLen = 0;
}

void Update(Context &ctx, const uint8_t *data, size_t len)
{
    if (data == nullptr && len > 0) {
        TSD_ERROR("[TsdSha256] Update called with nullptr data and non-zero len.");
        return;
    }
    LogSha256Backend();
    UpdateCore(ctx, data, len, CompressBlock);
}

void Final(Context &ctx, uint8_t *hash)
{
    if (hash == nullptr) {
        TSD_ERROR("[TsdSha256] Final called with nullptr hash.");
        return;
    }
    FinalCore(ctx, hash, CompressBlock);
}

void Compute(const uint8_t *data, size_t len, uint8_t *hash)
{
    Context ctx;
    Init(ctx);
    Update(ctx, data, len);
    Final(ctx, hash);
}

std::string ComputeHexString(const uint8_t *data, size_t len)
{
    if (data == nullptr && len > 0) {
        TSD_ERROR("[TsdSha256] ComputeHexString called with nullptr data and non-zero len.");
        return "";
    }
    uint8_t hash[DIGEST_LENGTH];
    Compute(data, len, hash);
    constexpr char hexDigits[] = "0123456789abcdef";
    std::string result;
    result.reserve(DIGEST_LENGTH * 2);
    for (uint32_t i = 0; i < DIGEST_LENGTH; ++i) {
        result.push_back(hexDigits[hash[i] >> 4U]);
        result.push_back(hexDigits[hash[i] & 0x0FU]);
    }
    return result;
}

// ============================================================
// Software-only path (for UT verification)
// ============================================================
static void UpdateSoft(Context &ctx, const uint8_t *data, size_t len)
{
    UpdateCore(ctx, data, len, CompressBlockSoft);
}

static void FinalSoft(Context &ctx, uint8_t *hash)
{
    FinalCore(ctx, hash, CompressBlockSoft);
}

void ComputeSoft(const uint8_t *data, size_t len, uint8_t *hash)
{
    Context ctx;
    Init(ctx);
    UpdateSoft(ctx, data, len);
    FinalSoft(ctx, hash);
}

std::string ComputeHexStringSoft(const uint8_t *data, size_t len)
{
    if (data == nullptr && len > 0) {
        TSD_ERROR("[TsdSha256] ComputeHexStringSoft called with nullptr data and non-zero len.");
        return "";
    }
    uint8_t hash[DIGEST_LENGTH];
    ComputeSoft(data, len, hash);
    constexpr char hexDigits[] = "0123456789abcdef";
    std::string result;
    result.reserve(DIGEST_LENGTH * 2);
    for (uint32_t i = 0; i < DIGEST_LENGTH; ++i) {
        result.push_back(hexDigits[hash[i] >> 4U]);
        result.push_back(hexDigits[hash[i] & 0x0FU]);
    }
    return result;
}

}  // namespace sha256
}  // namespace tsd
