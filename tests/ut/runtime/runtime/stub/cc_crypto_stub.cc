/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "crypto/openssl_loader.h"
#include "type_def.h"

#include <cstring>
#include <new>

namespace cce {
namespace runtime {

namespace {
bool g_readyFlag = true;

constexpr uint32_t STUB_AAD_MAX = 64U;
constexpr uint32_t STUB_TAG_SIZE = 16U;

struct StubCipherCtx {
    bool encrypt = false;
    const uint8_t* key = nullptr;
    const uint8_t* iv = nullptr;
    int ivLen = 0;
    const uint8_t* aad = nullptr;
    int aadLen = 0;
    uint8_t tag[STUB_TAG_SIZE] = {0};
    bool tagSet = false;
    bool tagGetDone = false;
};

EVP_CIPHER_CTX* StubCtxNew()
{
    auto* ctx = new (std::nothrow) StubCipherCtx();
    return PtrToPtr<StubCipherCtx, EVP_CIPHER_CTX>(ctx);
}

void StubCtxFree(EVP_CIPHER_CTX* ctx) { delete PtrToPtr<EVP_CIPHER_CTX, StubCipherCtx>(ctx); }

const EVP_CIPHER* StubAes128Gcm()
{
    static int dummy = 0;
    return PtrToPtr<int, const EVP_CIPHER>(&dummy);
}

const EVP_CIPHER* StubAes128Ctr()
{
    static int dummyCtr = 0;
    return PtrToPtr<int, const EVP_CIPHER>(&dummyCtr);
}

int StubEncInit(
    EVP_CIPHER_CTX* ctx, const EVP_CIPHER* cipher, ENGINE* engine, const unsigned char* key, const unsigned char* iv)
{
    (void)cipher;
    (void)engine;
    auto* s = PtrToPtr<EVP_CIPHER_CTX, StubCipherCtx>(ctx);
    if (s == nullptr) {
        return 0;
    }
    s->encrypt = true;
    if (key != nullptr) {
        s->key = key;
    }
    if (iv != nullptr) {
        s->iv = iv;
    }
    return 1;
}

int StubDecInit(
    EVP_CIPHER_CTX* ctx, const EVP_CIPHER* cipher, ENGINE* engine, const unsigned char* key, const unsigned char* iv)
{
    (void)cipher;
    (void)engine;
    auto* s = PtrToPtr<EVP_CIPHER_CTX, StubCipherCtx>(ctx);
    if (s == nullptr) {
        return 0;
    }
    s->encrypt = false;
    if (key != nullptr) {
        s->key = key;
    }
    if (iv != nullptr) {
        s->iv = iv;
    }
    return 1;
}

int StubCtxCtrl(EVP_CIPHER_CTX* ctx, int type, int arg, void* ptr)
{
    auto* s = PtrToPtr<EVP_CIPHER_CTX, StubCipherCtx>(ctx);
    if (s == nullptr) {
        return 0;
    }
    if (type == EVP_CTRL_GCM_SET_IVLEN) {
        s->ivLen = arg;
        return 1;
    }
    if (type == EVP_CTRL_GCM_GET_TAG) {
        if (ptr == nullptr || arg <= 0 || static_cast<uint32_t>(arg) > STUB_TAG_SIZE) {
            return 0;
        }
        static constexpr uint8_t STUB_FIXED_TAG[STUB_TAG_SIZE] = {'A', 'E', 'S', '1', '2', '8', 'G', 'C',
                                                                  'M', '_', 'T', 'A', 'G', 'F', 'I', 'X'};
        (void)memcpy(ptr, STUB_FIXED_TAG, static_cast<size_t>(arg));
        s->tagGetDone = true;
        return 1;
    }
    if (type == EVP_CTRL_GCM_SET_TAG) {
        if (ptr == nullptr || arg <= 0 || static_cast<uint32_t>(arg) > STUB_TAG_SIZE) {
            return 0;
        }
        (void)memcpy(s->tag, ptr, static_cast<size_t>(arg));
        s->tagSet = true;
        return 1;
    }
    return 0;
}

int StubEncUpdate(EVP_CIPHER_CTX* ctx, unsigned char* out, int* outLen, const unsigned char* in, int inLen)
{
    auto* s = PtrToPtr<EVP_CIPHER_CTX, StubCipherCtx>(ctx);
    if (s == nullptr || outLen == nullptr) {
        return 0;
    }
    // EVP 契约：out 为空且 in 非空表示追加 AAD 认证数据
    if (out == nullptr) {
        s->aad = in;
        s->aadLen = inLen;
        *outLen = inLen;
        return 1;
    }
    if (in == nullptr) {
        return 0;
    }
    (void)memcpy(out, in, static_cast<size_t>(inLen));
    *outLen = inLen;
    return 1;
}

int StubDecUpdate(EVP_CIPHER_CTX* ctx, unsigned char* out, int* outLen, const unsigned char* in, int inLen)
{
    auto* s = PtrToPtr<EVP_CIPHER_CTX, StubCipherCtx>(ctx);
    if (s == nullptr || outLen == nullptr) {
        return 0;
    }
    // EVP 契约：out 为空且 in 非空表示追加 AAD 认证数据
    if (out == nullptr) {
        s->aad = in;
        s->aadLen = inLen;
        *outLen = inLen;
        return 1;
    }
    if (in == nullptr) {
        return 0;
    }
    (void)memcpy(out, in, static_cast<size_t>(inLen));
    *outLen = inLen;
    return 1;
}

int StubEncFinal(EVP_CIPHER_CTX* ctx, unsigned char* out, int* outLen)
{
    (void)ctx;
    (void)out;
    if (outLen == nullptr) {
        return 0;
    }
    *outLen = 0;
    return 1;
}

int StubDecFinal(EVP_CIPHER_CTX* ctx, unsigned char* out, int* outLen)
{
    (void)out;
    if (outLen == nullptr) {
        return 0;
    }
    *outLen = 0;
    auto* s = PtrToPtr<EVP_CIPHER_CTX, StubCipherCtx>(ctx);
    if (s == nullptr || !s->tagSet) {
        return 0;
    }
    static constexpr uint8_t STUB_FIXED_TAG[STUB_TAG_SIZE] = {'A', 'E', 'S', '1', '2', '8', 'G', 'C',
                                                              'M', '_', 'T', 'A', 'G', 'F', 'I', 'X'};
    if (memcmp(s->tag, STUB_FIXED_TAG, STUB_TAG_SIZE) != 0) {
        return 0;
    }
    return 1;
}

int StubRandBytes(unsigned char* buf, int num)
{
    if (buf == nullptr || num <= 0) {
        return 0;
    }
    for (int i = 0; i < num; ++i) {
        buf[i] = static_cast<unsigned char>(i & 0xFF);
    }
    return 1;
}
} // namespace

OpenSSLLoader& OpenSSLLoader::Instance()
{
    static OpenSSLLoader inst;
    return inst;
}

OpenSSLLoader::~OpenSSLLoader()
{
    handle_ = nullptr;
    inited_ = false;
}

bool OpenSSLLoader::Init() noexcept
{
    Api.CipherCtxNew = &StubCtxNew;
    Api.CipherCtxFree = &StubCtxFree;
    Api.Aes128Gcm = &StubAes128Gcm;
    Api.Aes128Ctr = &StubAes128Ctr;
    Api.EncInit = &StubEncInit;
    Api.DecInit = &StubDecInit;
    Api.CtxCtrl = &StubCtxCtrl;
    Api.EncUpdate = &StubEncUpdate;
    Api.DecUpdate = &StubDecUpdate;
    Api.EncFinal = &StubEncFinal;
    Api.DecFinal = &StubDecFinal;
    Api.RandBytes = &StubRandBytes;
    inited_ = g_readyFlag;
    return inited_;
}

bool OpenSSLLoader::Ready() const noexcept { return g_readyFlag && Api.CipherCtxNew != nullptr; }

void SetOpenSSLLoaderReady(bool ready) { g_readyFlag = ready; }

} // namespace runtime
} // namespace cce
