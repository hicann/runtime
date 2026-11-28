/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cc_crypto.h"

#include <atomic>
#include <climits>
#include <cstring>
#include <memory>
#include <mutex>

#include "base.hpp"
#include "common/cc_defs.h"
#include "common/cc_utils.h"
#include "common/internal_error_define.hpp"
#include "npu_driver.hpp"
#include "driver.hpp"
#include "openssl_loader.h"
#include "keystream/keystream_manager.h"
#include "runtime.hpp"
#include "type_def.h"

namespace cce {
namespace runtime {

struct CryptoCipherBundle {
    CCCryptoCipherFn cipherFn; // 从 OpenSSL 加载表取本算法 cipher（加载完成后调用）；nullptr = 未实现
    uint32_t ivSize;           // IV 长度（末 4B 为递增序号，前段为随机基址）
    uint32_t tagSize;          // 认证标签长度
};

static CryptoCipherBundle g_cryptoCiphers[static_cast<uint32_t>(CC_CRYPTO_CIPHER::MAX)];

rtError_t RegisterCryptoAlg(CC_CRYPTO_CIPHER cipher, CCCryptoCipherFn cipherFn, uint32_t ivSize, uint32_t tagSize)
{
    const auto idx = static_cast<uint32_t>(cipher);
    if ((idx >= static_cast<uint32_t>(CC_CRYPTO_CIPHER::MAX)) || (cipherFn == nullptr) ||
        (ivSize <= AICC_IV_COUNTER_SIZE) || (tagSize == 0U)) {
        return RT_ERROR_INVALID_VALUE;
    }
    g_cryptoCiphers[idx] = CryptoCipherBundle{cipherFn, ivSize, tagSize};
    return RT_ERROR_NONE;
}

static const CryptoCipherBundle* FindCryptoAlg(CC_CRYPTO_CIPHER cipher)
{
    const auto idx = static_cast<uint32_t>(cipher);
    return (idx < static_cast<uint32_t>(CC_CRYPTO_CIPHER::MAX)) ? &g_cryptoCiphers[idx] : nullptr;
}

namespace {

const void* AesCipherFn() { return OpenSSLLoader::Instance().Api.Aes128Gcm(); }

[[maybe_unused]] const rtError_t g_builtinCryptoAlgInit =
    RegisterCryptoAlg(CC_CRYPTO_CIPHER::AES_128, &AesCipherFn, AICC_GCM_IV_SIZE, AICC_GCM_TAG_SIZE);

// device 侧密钥区（dev_key_addr）布局：[0,16)=H2D 密钥，[16,32)=D2H 密钥；
constexpr uint32_t AICC_DEV_KEY_REGION_SIZE = 2U * AICC_KEY_SIZE;

struct IvCtx {
    uint8_t base[cc_crypto_impl::IV_BASE_SIZE] = {0};
    uint32_t counter = 0U;
    std::mutex mtx;
    std::atomic<uint64_t> totalBytes{0};
};

int32_t GenIv(IvCtx& ivCtx, uint32_t ivSize, uint8_t* iv, size_t ivCap)
{
    if ((ivSize < AICC_IV_COUNTER_SIZE) || (ivSize > ivCap) || ((ivSize - AICC_IV_COUNTER_SIZE) > sizeof(ivCtx.base))) {
        return -1;
    }
    const uint32_t baseSize = ivSize - AICC_IV_COUNTER_SIZE;
    if (iv == nullptr) {
        return -1;
    }
    std::lock_guard<std::mutex> lk(ivCtx.mtx);
    if (ivCtx.counter >= AICC_IV_COUNTER_MAX) {
        auto& ssl = OpenSSLLoader::Instance();
        if (!ssl.Ready() || ssl.Api.RandBytes == nullptr) {
            return -1;
        }
        if (ssl.Api.RandBytes(ivCtx.base, static_cast<int>(baseSize)) != 1) {
            return -1;
        }
        ivCtx.counter = 0U;
    }
    (void)memcpy_s(iv, ivCap, ivCtx.base, baseSize);
    const uint32_t seq = ivCtx.counter;
    ivCtx.counter = seq + 1U;
    for (uint32_t byteIdx = 0U; byteIdx < AICC_IV_COUNTER_SIZE; ++byteIdx) {
        const uint32_t shift = (AICC_IV_COUNTER_SIZE - 1U - byteIdx) * CHAR_BIT;
        iv[baseSize + byteIdx] = static_cast<uint8_t>(seq >> shift);
    }
    return 0;
}

int32_t InitIvBase(IvCtx* ivCtx)
{
    if (ivCtx == nullptr) {
        return -1;
    }
    auto& ssl = OpenSSLLoader::Instance();
    if (!ssl.Ready() || ssl.Api.RandBytes == nullptr) {
        return -1;
    }
    std::lock_guard<std::mutex> lk(ivCtx->mtx);
    if (ssl.Api.RandBytes(ivCtx->base, static_cast<int>(cc_crypto_impl::IV_BASE_SIZE)) != 1) {
        return -1;
    }
    ivCtx->counter = 0U;
    ivCtx->totalBytes.store(0U);
    return 0;
}

} // namespace

namespace cc_crypto_impl {

constexpr int32_t AICC_CRYPTO_NULLPTR = -1;
constexpr int32_t AICC_CRYPTO_CTX_FAILURE = -2;
constexpr int32_t AICC_CRYPTO_INIT_FAILURE = -3;
constexpr int32_t AICC_CRYPTO_ENC_FAILURE = -4;
constexpr int32_t AICC_CRYPTO_DEC_FAILURE = -5;
constexpr int32_t AICC_CRYPTO_AUTH_FAILURE = -6;
constexpr int32_t AICC_CRYPTO_FAILURE = -7;

int32_t AeadEncrypt(
    const void* cipher, uint32_t ivSize, uint32_t tagSize, const uint8_t* key, const uint8_t* iv,
    const uint8_t* plaintext, size_t plaintext_len, const uint8_t* aad, size_t aad_len, uint8_t* ciphertext,
    size_t* ciphertext_len, uint8_t* tag)
{
    if (key == nullptr || iv == nullptr || plaintext == nullptr || ciphertext == nullptr || ciphertext_len == nullptr ||
        tag == nullptr) {
        return AICC_CRYPTO_NULLPTR;
    }
    if (aad == nullptr && aad_len > 0) {
        return AICC_CRYPTO_NULLPTR;
    }

    auto& ssl = OpenSSLLoader::Instance();
    if (!ssl.Ready()) {
        return AICC_CRYPTO_CTX_FAILURE;
    }
    EVP_CIPHER_CTX* ctx = ssl.Api.CipherCtxNew();
    if (ctx == nullptr) {
        return AICC_CRYPTO_CTX_FAILURE;
    }

    int32_t ret = AICC_CRYPTO_FAILURE;
    int len = 0;
    size_t total = 0;

    do {
        auto* const evpCipher = PtrToPtr<const void, const EVP_CIPHER>(cipher);
        if (ssl.Api.EncInit(ctx, evpCipher, nullptr, nullptr, nullptr) != 1) {
            ret = AICC_CRYPTO_INIT_FAILURE;
            break;
        }
        if (ssl.Api.CtxCtrl(ctx, EVP_CTRL_GCM_SET_IVLEN, static_cast<int>(ivSize), nullptr) != 1) {
            ret = AICC_CRYPTO_AUTH_FAILURE;
            break;
        }
        if (ssl.Api.EncInit(ctx, nullptr, nullptr, key, iv) != 1) {
            ret = AICC_CRYPTO_INIT_FAILURE;
            break;
        }
        if (aad_len > 0) {
            int aad_out = 0;
            if (ssl.Api.EncUpdate(ctx, nullptr, &aad_out, aad, static_cast<int>(aad_len)) != 1) {
                ret = AICC_CRYPTO_ENC_FAILURE;
                break;
            }
        }
        if (ssl.Api.EncUpdate(ctx, ciphertext, &len, plaintext, static_cast<int>(plaintext_len)) != 1) {
            ret = AICC_CRYPTO_ENC_FAILURE;
            break;
        }
        total = static_cast<size_t>(len);
        if (ssl.Api.EncFinal(ctx, ciphertext + total, &len) != 1) {
            ret = AICC_CRYPTO_ENC_FAILURE;
            break;
        }
        total += static_cast<size_t>(len);

        if (ssl.Api.CtxCtrl(ctx, EVP_CTRL_GCM_GET_TAG, static_cast<int>(tagSize), tag) != 1) {
            ret = AICC_CRYPTO_AUTH_FAILURE;
            break;
        }

        *ciphertext_len = total;
        ret = 0;
    } while (false);

    ssl.Api.CipherCtxFree(ctx);
    return ret;
}

int32_t AeadDecrypt(
    const void* cipher, uint32_t ivSize, uint32_t tagSize, const uint8_t* key, const uint8_t* iv,
    const uint8_t* ciphertext, size_t ciphertext_len, const uint8_t* aad, size_t aad_len, uint8_t* plaintext,
    size_t* plaintext_len, const uint8_t* tag)
{
    if (key == nullptr || iv == nullptr || ciphertext == nullptr || plaintext == nullptr || plaintext_len == nullptr ||
        tag == nullptr) {
        return AICC_CRYPTO_NULLPTR;
    }
    if (aad == nullptr && aad_len > 0) {
        return AICC_CRYPTO_NULLPTR;
    }

    auto& ssl = OpenSSLLoader::Instance();
    if (!ssl.Ready()) {
        return AICC_CRYPTO_CTX_FAILURE;
    }
    EVP_CIPHER_CTX* ctx = ssl.Api.CipherCtxNew();
    if (ctx == nullptr) {
        return AICC_CRYPTO_CTX_FAILURE;
    }

    int32_t ret = AICC_CRYPTO_FAILURE;
    int len = 0;
    size_t total = 0;

    do {
        auto* const evpCipher = PtrToPtr<const void, const EVP_CIPHER>(cipher);
        if (ssl.Api.DecInit(ctx, evpCipher, nullptr, nullptr, nullptr) != 1) {
            ret = AICC_CRYPTO_INIT_FAILURE;
            break;
        }
        if (ssl.Api.CtxCtrl(ctx, EVP_CTRL_GCM_SET_IVLEN, static_cast<int>(ivSize), nullptr) != 1) {
            ret = AICC_CRYPTO_AUTH_FAILURE;
            break;
        }
        if (ssl.Api.DecInit(ctx, nullptr, nullptr, key, iv) != 1) {
            ret = AICC_CRYPTO_INIT_FAILURE;
            break;
        }
        if (aad_len > 0) {
            int aad_out = 0;
            if (ssl.Api.DecUpdate(ctx, nullptr, &aad_out, aad, static_cast<int>(aad_len)) != 1) {
                ret = AICC_CRYPTO_DEC_FAILURE;
                break;
            }
        }
        if (ssl.Api.DecUpdate(ctx, plaintext, &len, ciphertext, static_cast<int>(ciphertext_len)) != 1) {
            ret = AICC_CRYPTO_DEC_FAILURE;
            break;
        }
        total = static_cast<size_t>(len);

        if (ssl.Api.CtxCtrl(ctx, EVP_CTRL_GCM_SET_TAG, static_cast<int>(tagSize), RtPtrToUnConstPtr<uint8_t*>(tag)) !=
            1) {
            ret = AICC_CRYPTO_AUTH_FAILURE;
            break;
        }
        if (ssl.Api.DecFinal(ctx, plaintext + total, &len) != 1) {
            ret = AUTH_TAG_VERIFY_FAILED;
            break;
        }
        total += static_cast<size_t>(len);

        *plaintext_len = total;
        ret = 0;
    } while (false);

    ssl.Api.CipherCtxFree(ctx);
    return ret;
}

} // namespace cc_crypto_impl

int32_t GetKeyFromSlot(int32_t deviceId, uint32_t slot, uint8_t key[AICC_KEY_SIZE])
{
    if ((deviceId < 0) || (key == nullptr)) {
        return -1;
    }
    uint32_t keyLen = 0U;
    uint8_t rawKey[cc_crypto_impl::SLOT_KEY_MAX_SIZE] = {0}; // 驱动侧槽位密钥最长 64 字节，先读全量
    Driver* const driver = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    if (driver == nullptr) {
        return -1;
    }
    const rtError_t slotRet = driver->GetSlotKey(static_cast<uint32_t>(deviceId), slot, rawKey, &keyLen);
    if (slotRet != RT_ERROR_NONE) {
        (void)memset_s(rawKey, sizeof(rawKey), 0, sizeof(rawKey));
        return -1;
    }
    if (keyLen < AICC_KEY_SIZE) {
        (void)memset_s(rawKey, sizeof(rawKey), 0, sizeof(rawKey));
        return -1;
    }
    (void)memcpy_s(key, AICC_KEY_SIZE, rawKey, AICC_KEY_SIZE);
    (void)memset_s(rawKey, sizeof(rawKey), 0, sizeof(rawKey));
    return 0;
}

int32_t GetKeyFromKernel(int32_t deviceId, CRYPTO_KEY_DIRECTION direction, uint8_t key[AICC_KEY_SIZE])
{
    uint32_t slot = 0U;
    if (direction == CRYPTO_KEY_DIRECTION::H2D) {
        slot = cc_crypto_impl::KEY_SLOT_H2D;
    } else if (direction == CRYPTO_KEY_DIRECTION::D2H) {
        slot = cc_crypto_impl::KEY_SLOT_D2H;
    } else {
        return -1;
    }
    return GetKeyFromSlot(deviceId, slot, key);
}

struct CCrypto::KeyCtx {
    std::atomic<bool> is_init{false};
    uint8_t host_key_H2D[AICC_KEY_SIZE] = {0};
    uint8_t host_key_D2H[AICC_KEY_SIZE] = {0};
    IvCtx ivH2D;
    std::atomic<uint64_t> totalBytesD2H{0};
    uint64_t dev_key_addr = 0; // device 侧密钥区地址（32B：H2D|D2H，AICPU 填充算子写入）
};

CCrypto::CCrypto(CC_CRYPTO_ALG_TYPE mode) : mode_(mode) {}

CCrypto::~CCrypto()
{
    {
        std::lock_guard<std::mutex> lock(keystreamPoolMutex_);
        keystreamPool_.reset();
    }
    if (keyCtx_ != nullptr) {
        (void)memset_s(keyCtx_->host_key_H2D, AICC_KEY_SIZE, 0, AICC_KEY_SIZE);
        (void)memset_s(keyCtx_->host_key_D2H, AICC_KEY_SIZE, 0, AICC_KEY_SIZE);
        if (keyCtx_->is_init) {
            if (keyCtx_->dev_key_addr != 0U) {
                (void)Runtime::Instance()
                    ->driverFactory_.GetDriver(NPU_DRIVER)
                    ->DevMemFree(ValueToPtr(keyCtx_->dev_key_addr), deviceId_);
                keyCtx_->dev_key_addr = 0U;
            }
            keyCtx_->is_init = false;
        }
        delete keyCtx_;
        keyCtx_ = nullptr;
    }
}

rtError_t CCrypto::InitKey(uint32_t deviceId)
{
    if (!OpenSSLLoader::Instance().Init()) {
        RT_LOG(RT_LOG_ERROR, "CCrypto InitKey openssl loader not ready, deviceId=%u", deviceId);
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    if (keyCtx_ == nullptr) {
        keyCtx_ = new (std::nothrow) KeyCtx();
        if (keyCtx_ == nullptr) {
            RT_LOG(RT_LOG_ERROR, "CCrypto InitKey alloc KeyCtx failed, deviceId=%u", deviceId);
            return RT_ERROR_CC_CRYPTO_FAILED;
        }
    }
    int32_t ret = GetKeyFromKernel(static_cast<int32_t>(deviceId), CRYPTO_KEY_DIRECTION::H2D, keyCtx_->host_key_H2D);
    if (ret != 0) {
        RT_LOG(RT_LOG_ERROR, "CCrypto InitKey get H2D key failed, deviceId=%u, ret=%d", deviceId, ret);
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    // CTR 两方向共用 H2D 密钥；GCM 额外读取 D2H 密钥。
    if (mode_ != CC_CRYPTO_ALG_TYPE::CTR) {
        ret = GetKeyFromKernel(static_cast<int32_t>(deviceId), CRYPTO_KEY_DIRECTION::D2H, keyCtx_->host_key_D2H);
        if (ret != 0) {
            RT_LOG(RT_LOG_ERROR, "CCrypto InitKey get D2H key failed, deviceId=%u, ret=%d", deviceId, ret);
            return RT_ERROR_CC_CRYPTO_FAILED;
        }
    }
    if (InitIvBase(&keyCtx_->ivH2D) != 0) {
        RT_LOG(RT_LOG_ERROR, "CCrypto InitKey gen IV base failed, deviceId=%u", deviceId);
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    keyCtx_->totalBytesD2H.store(0U);
    if (keyCtx_->dev_key_addr != 0U) {
        (void)Runtime::Instance()
            ->driverFactory_.GetDriver(NPU_DRIVER)
            ->DevMemFree(ValueToPtr(keyCtx_->dev_key_addr), deviceId);
        keyCtx_->dev_key_addr = 0U;
    }
    void* devKeyBuf = nullptr;
    Driver* const driver = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    const uint64_t alignSize = CcAlignUp(AICC_DEV_KEY_REGION_SIZE);
    DevMemAllocConfig allocConfig = {};
    allocConfig.privateFlag = true;
    const uint64_t drvFlag = NpuDriver::BuildDevMemAllocFlag(deviceId, &allocConfig);
    const rtError_t merr =
        driver->DevMemAllocWithFlag(&devKeyBuf, alignSize, RT_MEMORY_HBM, deviceId, &allocConfig, drvFlag);
    if (merr != RT_ERROR_NONE || devKeyBuf == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CC Crypto InitKey alloc device key mem failed, deviceId=%u, ret=%#x", deviceId, merr);
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1023, "Alloc device memory for the encryption and decryption keys",
            "Device memory is insufficient");
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    keyCtx_->dev_key_addr = PtrToValue(devKeyBuf);
    keyCtx_->is_init = true;
    deviceId_ = deviceId;
    RT_LOG(RT_LOG_INFO, "CCrypto InitKey ok, deviceId=%u", deviceId);
    return RT_ERROR_NONE;
}

rtError_t CCrypto::ReleaseKey(uint32_t deviceId) const
{
    (void)deviceId;
    if (keyCtx_ == nullptr) {
        return RT_ERROR_NONE;
    }
    if (!keyCtx_->is_init) {
        return RT_ERROR_NONE;
    }

    {
        std::lock_guard<std::mutex> lock(keystreamPoolMutex_);
        keystreamPool_.reset();
    }

    (void)memset_s(keyCtx_->host_key_H2D, AICC_KEY_SIZE, 0, AICC_KEY_SIZE);
    (void)memset_s(keyCtx_->host_key_D2H, AICC_KEY_SIZE, 0, AICC_KEY_SIZE);
    if (keyCtx_->dev_key_addr != 0U) {
        (void)Runtime::Instance()
            ->driverFactory_.GetDriver(NPU_DRIVER)
            ->DevMemFree(ValueToPtr(keyCtx_->dev_key_addr), deviceId);
    }
    keyCtx_->dev_key_addr = 0U;
    keyCtx_->is_init = false;
    RT_LOG(RT_LOG_INFO, "CCrypto ReleaseKey ok, deviceId=%u", deviceId);
    return RT_ERROR_NONE;
}

rtError_t CCrypto::Encrypt(
    uint32_t deviceId, CC_CRYPTO_CIPHER cipher, const uint8_t* plaintext, size_t ptLen, const uint8_t* aad,
    size_t aadLen, uint8_t* ciphertext, size_t* ctLen) const
{
    (void)deviceId;
    if (plaintext == nullptr || ciphertext == nullptr || ctLen == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (aad == nullptr && aadLen > 0) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (keyCtx_ == nullptr) {
        return RT_ERROR_CC_KEY_NOT_INITIALIZED;
    }
    if (!keyCtx_->is_init) {
        return RT_ERROR_CC_KEY_NOT_INITIALIZED;
    }
    if (mode_ == CC_CRYPTO_ALG_TYPE::CTR) {
        if (cipher != CC_CRYPTO_CIPHER::AES_128) {
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
        AiccCiphertextHeader header{};
        auto& ssl = OpenSSLLoader::Instance();
        if (!ssl.Ready() || (ssl.Api.RandBytes(header.iv, AICC_CTR_IV_SIZE - AICC_IV_COUNTER_SIZE) != 1)) {
            return RT_ERROR_CC_CRYPTO_FAILED;
        }
        const rtError_t ret = TransformCtr(plaintext, ptLen, header.iv, ciphertext + sizeof(header));
        if (ret != RT_ERROR_NONE) {
            return ret;
        }
        header.version = AICC_CIPHER_VERSION;
        header.totalLen = static_cast<uint32_t>(sizeof(header) + ptLen);
        header.ivLen = AICC_CTR_IV_SIZE;
        header.ciphertextLen = static_cast<uint32_t>(ptLen);
        (void)memcpy_s(ciphertext, sizeof(header), &header, sizeof(header));
        *ctLen = header.totalLen;
        keyCtx_->ivH2D.totalBytes.fetch_add(static_cast<uint64_t>(ptLen));
        return RT_ERROR_NONE;
    }
    const CryptoCipherBundle* bundle = FindCryptoAlg(cipher);
    if ((bundle == nullptr) || (bundle->cipherFn == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "CCrypto cipher not implemented, cipher=%u", static_cast<uint32_t>(cipher));
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    const void* cipherObj = bundle->cipherFn();
    if (cipherObj == nullptr) {
        return RT_ERROR_CC_CRYPTO_FAILED;
    }

    uint8_t iv[AICC_CIPHER_IV_MAX_SIZE]; // 密文头 iv 域上限内按算法包尺寸生成
    if (GenIv(keyCtx_->ivH2D, bundle->ivSize, iv, sizeof(iv)) != 0) {
        RT_LOG(RT_LOG_ERROR, "CCrypto Encrypt gen IV failed, deviceId=%u", deviceId);
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    uint8_t* enc_body = ciphertext + sizeof(AiccCiphertextHeader);
    uint8_t tag_buf[AICC_CIPHER_TAG_MAX_SIZE]; // 密文头 tag 域上限
    size_t enc_len = 0;
    int32_t ret = cc_crypto_impl::AeadEncrypt(
        cipherObj, bundle->ivSize, bundle->tagSize, keyCtx_->host_key_H2D, iv, plaintext, ptLen, aad, aadLen, enc_body,
        &enc_len, tag_buf);
    if (ret != 0) {
        RT_LOG(RT_LOG_ERROR, "CCrypto Encrypt AeadEncrypt failed, deviceId=%u, ret=%d", deviceId, ret);
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    keyCtx_->ivH2D.totalBytes.fetch_add(static_cast<uint64_t>(ptLen));

    AiccCiphertextHeader* hdr = PtrToPtr<uint8_t, AiccCiphertextHeader>(ciphertext);
    hdr->version = AICC_CIPHER_VERSION;
    hdr->totalLen = static_cast<uint32_t>(sizeof(AiccCiphertextHeader)) + static_cast<uint32_t>(enc_len);
    hdr->ivLen = bundle->ivSize;
    (void)memcpy_s(hdr->iv, sizeof(hdr->iv), iv, bundle->ivSize);
    hdr->tagLen = bundle->tagSize;
    (void)memcpy_s(hdr->tag, sizeof(hdr->tag), tag_buf, bundle->tagSize);
    hdr->ciphertextLen = static_cast<uint32_t>(enc_len);

    *ctLen = sizeof(AiccCiphertextHeader) + enc_len;
    return RT_ERROR_NONE;
}

rtError_t CCrypto::Decrypt(
    uint32_t deviceId, CC_CRYPTO_CIPHER cipher, const uint8_t* ciphertext, size_t ctLen, const uint8_t* aad,
    size_t aadLen, uint8_t* plaintext, size_t* ptLen) const
{
    (void)deviceId;
    if (ciphertext == nullptr || plaintext == nullptr || ptLen == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (aad == nullptr && aadLen > 0) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (ctLen < sizeof(AiccCiphertextHeader)) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (keyCtx_ == nullptr) {
        return RT_ERROR_CC_KEY_NOT_INITIALIZED;
    }
    if (!keyCtx_->is_init) {
        return RT_ERROR_CC_KEY_NOT_INITIALIZED;
    }

    const AiccCiphertextHeader* hdr = PtrToPtr<uint8_t, const AiccCiphertextHeader>(ciphertext);
    if (hdr->totalLen != ctLen) {
        return RT_ERROR_INVALID_VALUE;
    }
    size_t enc_len = ctLen - sizeof(AiccCiphertextHeader);
    if (enc_len != hdr->ciphertextLen) {
        return RT_ERROR_INVALID_VALUE;
    }

    if (mode_ == CC_CRYPTO_ALG_TYPE::CTR) {
        if (cipher != CC_CRYPTO_CIPHER::AES_128) {
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
        if ((hdr->version != AICC_CIPHER_VERSION) || (hdr->ivLen != AICC_CTR_IV_SIZE) || (hdr->tagLen != 0U)) {
            return RT_ERROR_CC_CRYPTO_FAILED;
        }
        const rtError_t ret = TransformCtr(ciphertext + sizeof(AiccCiphertextHeader), enc_len, hdr->iv, plaintext);
        if (ret == RT_ERROR_NONE) {
            *ptLen = enc_len;
            keyCtx_->totalBytesD2H.fetch_add(static_cast<uint64_t>(enc_len));
        }
        return ret;
    }

    const CryptoCipherBundle* bundle = FindCryptoAlg(cipher);
    if ((bundle == nullptr) || (bundle->cipherFn == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "CCrypto cipher not implemented, cipher=%u", static_cast<uint32_t>(cipher));
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    const void* cipherObj = bundle->cipherFn();
    if (cipherObj == nullptr) {
        return RT_ERROR_CC_CRYPTO_FAILED;
    }

    const uint8_t* iv = hdr->iv;
    const uint8_t* tag = hdr->tag;
    const uint8_t* enc_body = ciphertext + sizeof(AiccCiphertextHeader);
    size_t dec_len = 0;
    int32_t ret = cc_crypto_impl::AeadDecrypt(
        cipherObj, bundle->ivSize, bundle->tagSize, keyCtx_->host_key_D2H, iv, enc_body, enc_len, aad, aadLen,
        plaintext, &dec_len, tag);
    if (ret != 0) {
        RT_LOG(RT_LOG_ERROR, "CCrypto Decrypt AeadDecrypt failed, deviceId=%u, ret=%d", deviceId, ret);
        if (ret == cc_crypto_impl::AUTH_TAG_VERIFY_FAILED) {
            return RT_ERROR_CC_TAG_VERIFY_FAILED;
        }
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    *ptLen = dec_len;
    keyCtx_->totalBytesD2H.fetch_add(static_cast<uint64_t>(dec_len));
    return RT_ERROR_NONE;
}

rtError_t CCrypto::TransformCtr(const uint8_t* input, size_t length, const uint8_t* iv, uint8_t* output) const
{
    auto& ssl = OpenSSLLoader::Instance();
    if (!ssl.Ready()) {
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    EVP_CIPHER_CTX* ctx = ssl.Api.CipherCtxNew();
    if (ctx == nullptr) {
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    const std::unique_ptr<EVP_CIPHER_CTX, OpenSSLApi::EVP_CIPHER_CTX_free_fn> guard(ctx, ssl.Api.CipherCtxFree);
    const EVP_CIPHER* cipher = ssl.Api.Aes128Ctr();
    if ((cipher == nullptr) || (ssl.Api.EncInit(ctx, cipher, nullptr, keyCtx_->host_key_H2D, iv) != 1)) {
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    int outputLen = 0;
    if ((ssl.Api.EncUpdate(ctx, output, &outputLen, input, static_cast<int>(length)) != 1) ||
        (outputLen != static_cast<int>(length))) {
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    uint8_t finalBytes[AICC_BLOCK_SIZE]{};
    int finalLen = 0;
    const int finalRet = ssl.Api.EncFinal(ctx, finalBytes, &finalLen);
    (void)memset_s(finalBytes, sizeof(finalBytes), 0, sizeof(finalBytes));
    return ((finalRet == 1) && (finalLen == 0)) ? RT_ERROR_NONE : RT_ERROR_CC_CRYPTO_FAILED;
}

rtError_t CCrypto::GetDeviceKeyAddr(CC_CRYPTO_DIRECTION direction, uint64_t* keyAddr) const
{
    if (keyAddr == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    if ((keyCtx_ == nullptr) || (!keyCtx_->is_init)) {
        return RT_ERROR_CC_KEY_NOT_INITIALIZED;
    }
    *keyAddr = keyCtx_->dev_key_addr + ((direction == CC_CRYPTO_DIRECTION::ENCRYPT) ? AICC_KEY_SIZE : 0U);
    return RT_ERROR_NONE;
}

rtError_t CCrypto::BuildLoadKeyParam(CCLoadKeyKernelParam* param) const
{
    if (param == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (keyCtx_ == nullptr) {
        return RT_ERROR_CC_KEY_NOT_INITIALIZED;
    }

    if (!keyCtx_->is_init || keyCtx_->dev_key_addr == 0U) {
        return RT_ERROR_CC_KEY_NOT_INITIALIZED;
    }

    param->h2dSlotId = static_cast<uint16_t>(cc_crypto_impl::KEY_SLOT_H2D);
    param->d2hSlotId = static_cast<uint16_t>(
        (mode_ == CC_CRYPTO_ALG_TYPE::CTR) ? cc_crypto_impl::KEY_SLOT_H2D : cc_crypto_impl::KEY_SLOT_D2H);
    param->keyAddr = keyCtx_->dev_key_addr;
    param->keyLen = AICC_KEY_SIZE;
    return RT_ERROR_NONE;
}

rtError_t CCrypto::EnsureKeystreamPool() const
{
    if (mode_ != CC_CRYPTO_ALG_TYPE::CTR) {
        return RT_ERROR_CC_INIT_FAILED;
    }
    std::lock_guard<std::mutex> lock(keystreamPoolMutex_);
    if (keystreamPool_ != nullptr) {
        return RT_ERROR_NONE;
    }
    std::shared_ptr<KeystreamManager> pool = std::make_shared<KeystreamManager>(static_cast<int>(deviceId_));

    KeystreamKey key{};
    if ((keyCtx_ == nullptr) || (!keyCtx_->is_init) || (keyCtx_->dev_key_addr == 0U)) {
        return RT_ERROR_CC_KEY_NOT_INITIALIZED;
    }
    (void)memcpy_s(key.key, sizeof(key.key), keyCtx_->host_key_H2D, AICC_KEY_SIZE);
    key.keyAddr = keyCtx_->dev_key_addr;
    key.keyLen = AICC_KEY_SIZE;

    const rtError_t ret = pool->Init(GetDefaultKeystreamConfigs(), key);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CCrypto create keystream pool failed, deviceId=%u, ret=%#x", deviceId_, ret);
        return ret;
    }
    keystreamPool_ = std::move(pool);
    return RT_ERROR_NONE;
}

rtError_t CCrypto::GetKeyStreamPair(uint32_t deviceId, size_t length, int timeout, KeystreamPair& pair)
{
    if (mode_ != CC_CRYPTO_ALG_TYPE::CTR) {
        RT_LOG(
            RT_LOG_ERROR, "CCrypto keystream pool not initialized, mode=%u, deviceId=%u", static_cast<uint32_t>(mode_),
            deviceId);
        return RT_ERROR_CC_INIT_FAILED;
    }
    if ((length == 0U) || (length > static_cast<size_t>(INT32_MAX))) {
        return RT_ERROR_INVALID_VALUE;
    }
    if ((deviceId_ != UINT32_MAX) && (deviceId != deviceId_)) {
        return RT_ERROR_INVALID_VALUE;
    }
    const rtError_t ret = EnsureKeystreamPool();
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    std::shared_ptr<KeystreamManager> pool;
    {
        std::lock_guard<std::mutex> lock(keystreamPoolMutex_);
        pool = keystreamPool_;
    }
    return (pool == nullptr) ? RT_ERROR_CC_INIT_FAILED :
                               pool->GetKeystreamPair(pair, static_cast<int>(length), timeout);
}

rtError_t CCrypto::FreeKeyStream(uint32_t deviceId, KeystreamPair& pair)
{
    if (pair.keystreamId < 0) {
        return RT_ERROR_NONE;
    }
    if (mode_ != CC_CRYPTO_ALG_TYPE::CTR) {
        return RT_ERROR_CC_INIT_FAILED;
    }
    if ((deviceId_ != UINT32_MAX) && (deviceId != deviceId_)) {
        return RT_ERROR_INVALID_VALUE;
    }
    std::shared_ptr<KeystreamManager> pool;
    {
        std::lock_guard<std::mutex> lock(keystreamPoolMutex_);
        pool = keystreamPool_;
    }
    return (pool == nullptr) ? RT_ERROR_CC_INIT_FAILED : pool->FreeKeystreamPair(pair);
}

rtError_t CCrypto::KeystreamEncrypt(
    const KeystreamPair& pair, const void* plaintext, size_t ptLen, void* ciphertext, size_t ctLen) const
{
    if ((pair.keystreamHost == nullptr) || (plaintext == nullptr) || (ciphertext == nullptr) || (ptLen > pair.length) ||
        (ctLen < ptLen)) {
        return RT_ERROR_INVALID_VALUE;
    }
    XorBytesOptimized(
        static_cast<const uint8_t*>(plaintext), static_cast<const uint8_t*>(pair.keystreamHost),
        static_cast<uint8_t*>(ciphertext), ptLen);
    return RT_ERROR_NONE;
}

rtError_t CCrypto::KeystreamDecrypt(
    const KeystreamPair& pair, const void* ciphertext, size_t ctLen, void* plaintext, size_t ptLen) const
{
    return KeystreamEncrypt(pair, ciphertext, ctLen, plaintext, ptLen);
}

} // namespace runtime
} // namespace cce
