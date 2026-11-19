/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software: you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_CRYPTO_H
#define CCE_RUNTIME_CC_CRYPTO_H

#include <cstdint>
#include <cstddef>
#include <memory>
#include <mutex>

#include "runtime/rt_external_base.h"

namespace cce {
namespace runtime {

constexpr uint32_t AICC_KEY_SIZE = 16U;
constexpr uint32_t AICC_BLOCK_SIZE = 16U;

enum class CC_CRYPTO_DIRECTION : uint32_t {
    ENCRYPT = 0U,
    DECRYPT = 1U,
};

enum class CC_CRYPTO_ALG_TYPE : uint32_t {
    GCM = 0,
    CTR = 1,
    MAX = 2, // 哨兵：有效模式数上界（注册表大小）
};

enum class CC_CRYPTO_CIPHER : uint32_t {
    AES_128 = 0,
    SM4 = 1,
    MAX = 2, // 哨兵：有效算法数上界（注册表大小）
};

constexpr uint32_t AICC_ALG_AES128_GCM = 0U;
constexpr uint32_t AICC_ALG_AES128_CTR = 1U;
constexpr uint32_t AICC_ALG_AES128_KEYSTREAM = 2U;

enum class CRYPTO_KEY_DIRECTION : uint32_t {
    H2D = 0,
    D2H = 1,
};

// Ciphertext wire format header (Host encrypt output / AICPU decrypt input).
constexpr uint32_t AICC_CTR_IV_SIZE = 16U;
constexpr uint32_t AICC_GCM_IV_SIZE = 12U;
constexpr uint32_t AICC_GCM_TAG_SIZE = 16U;
constexpr uint32_t AICC_IV_COUNTER_SIZE = 4U;
constexpr uint32_t AICC_IV_COUNTER_MAX = 0xFFFFFFFFU;
constexpr uint32_t AICC_CIPHER_VERSION = 1U;
constexpr uint32_t AICC_CIPHER_IV_MAX_SIZE = 32U;
constexpr uint32_t AICC_CIPHER_TAG_MAX_SIZE = 32U;

struct AiccCiphertextHeader {
    uint32_t version;
    uint32_t totalLen;
    uint32_t ivLen;
    uint8_t iv[AICC_CIPHER_IV_MAX_SIZE];
    uint32_t tagLen;
    uint8_t tag[AICC_CIPHER_TAG_MAX_SIZE];
    uint32_t ciphertextLen;
};

struct CCLoadKeyKernelParam {
    uint16_t h2dSlotId;
    uint16_t d2hSlotId;
    uint32_t keyLen;
    uint64_t keyAddr;
};
static_assert(sizeof(CCLoadKeyKernelParam) == 16U, "CCLoadKeyKernelParam must match master ABI");

struct KeystreamPair {
    int keystreamId;
    size_t length;
    void* keystreamHost;
    void* keystreamDevice;
};

int32_t GetKeyFromKernel(int32_t deviceId, CRYPTO_KEY_DIRECTION direction, uint8_t key[AICC_KEY_SIZE]);

int32_t GetKeyFromSlot(int32_t deviceId, uint32_t slot, uint8_t key[AICC_KEY_SIZE]);

namespace cc_crypto_impl {
constexpr uint32_t IV_BASE_SIZE = 8U;
constexpr uint32_t KEY_SLOT_H2D = 1U;
constexpr uint32_t KEY_SLOT_D2H = 2U;
constexpr uint32_t SLOT_KEY_MAX_SIZE = 64U;
constexpr int32_t AUTH_TAG_VERIFY_FAILED = -8;

int32_t AeadEncrypt(
    const void* cipher, uint32_t ivSize, uint32_t tagSize, const uint8_t* key, const uint8_t* iv,
    const uint8_t* plaintext, size_t plaintext_len, const uint8_t* aad, size_t aad_len, uint8_t* ciphertext,
    size_t* ciphertext_len, uint8_t* tag);

// 认证成功后方可使用解密输出；失败时输出长度不变。
int32_t AeadDecrypt(
    const void* cipher, uint32_t ivSize, uint32_t tagSize, const uint8_t* key, const uint8_t* iv,
    const uint8_t* ciphertext, size_t ciphertext_len, const uint8_t* aad, size_t aad_len, uint8_t* plaintext,
    size_t* plaintext_len, const uint8_t* tag);
} // namespace cc_crypto_impl

using CCCryptoCipherFn = const void* (*)();

rtError_t RegisterCryptoAlg(CC_CRYPTO_CIPHER cipher, CCCryptoCipherFn cipherFn, uint32_t ivSize, uint32_t tagSize);

class KeystreamManager;

class CCrypto {
public:
    explicit CCrypto(CC_CRYPTO_ALG_TYPE mode = CC_CRYPTO_ALG_TYPE::GCM);
    ~CCrypto();

    rtError_t InitKey(uint32_t deviceId);

    rtError_t BuildLoadKeyParam(CCLoadKeyKernelParam* param) const;

    rtError_t ReleaseKey(uint32_t deviceId) const;

    rtError_t Encrypt(
        uint32_t deviceId, CC_CRYPTO_CIPHER cipher, const uint8_t* plaintext, size_t ptLen, const uint8_t* aad,
        size_t aadLen, uint8_t* ciphertext, size_t* ctLen) const;
    rtError_t Decrypt(
        uint32_t deviceId, CC_CRYPTO_CIPHER cipher, const uint8_t* ciphertext, size_t ctLen, const uint8_t* aad,
        size_t aadLen, uint8_t* plaintext, size_t* ptLen) const;

    rtError_t GetDeviceKeyAddr(CC_CRYPTO_DIRECTION direction, uint64_t* keyAddr) const;

    rtError_t GetKeyStreamPair(uint32_t deviceId, size_t length, int timeout, KeystreamPair& pair);

    rtError_t FreeKeyStream(uint32_t deviceId, KeystreamPair& pair);

    rtError_t KeystreamEncrypt(
        const KeystreamPair& pair, const void* plaintext, size_t ptLen, void* ciphertext, size_t ctLen) const;

    rtError_t KeystreamDecrypt(
        const KeystreamPair& pair, const void* ciphertext, size_t ctLen, void* plaintext, size_t ptLen) const;

private:
    rtError_t EnsureKeystreamPool() const;

    struct KeyCtx;
    KeyCtx* keyCtx_{nullptr};
    const CC_CRYPTO_ALG_TYPE mode_{CC_CRYPTO_ALG_TYPE::GCM};  // 加密模式（CTR 模式启用密钥流池）

    uint32_t deviceId_{UINT32_MAX};                           // 绑定的设备 ID（InitKey 时确定）
    mutable std::shared_ptr<KeystreamManager> keystreamPool_; // 本设备密钥流池（CCrypto 独占）
    mutable std::mutex keystreamPoolMutex_;                   // 保护惰性创建与释放
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_CRYPTO_H
