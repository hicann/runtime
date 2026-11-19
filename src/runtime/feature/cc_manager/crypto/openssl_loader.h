/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software; you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_OPENSSL_LOADER_H
#define CCE_RUNTIME_OPENSSL_LOADER_H

#include <mutex>

namespace cce {
namespace runtime {

struct evp_cipher_ctx_st;
struct evp_cipher_st;
struct engine_st;
using EVP_CIPHER_CTX = evp_cipher_ctx_st;
using EVP_CIPHER = evp_cipher_st;
using ENGINE = engine_st;

constexpr int EVP_CTRL_GCM_SET_IVLEN = 0x9;
constexpr int EVP_CTRL_GCM_GET_TAG = 0x10;
constexpr int EVP_CTRL_GCM_SET_TAG = 0x11;

// OpenSSL 动态加载 API 表（X-Macro，参照 error_code_meta.h 的 RUNTIME_ERROR_CODE_TABLE 惯例）
// 新增/删除 API 只需增删一行：X(成员名, 函数指针类型别名, dlsym 符号名)
#define OPENSSL_API_TABLE(X)                                        \
    X(CipherCtxNew, EVP_CIPHER_CTX_new_fn, "EVP_CIPHER_CTX_new")    \
    X(CipherCtxFree, EVP_CIPHER_CTX_free_fn, "EVP_CIPHER_CTX_free") \
    X(Aes128Gcm, EVP_aes_128_gcm_fn, "EVP_aes_128_gcm")             \
    X(Aes128Ctr, EVP_aes_128_ctr_fn, "EVP_aes_128_ctr")             \
    X(EncInit, EVP_EncryptInit_ex_fn, "EVP_EncryptInit_ex")         \
    X(DecInit, EVP_DecryptInit_ex_fn, "EVP_DecryptInit_ex")         \
    X(CtxCtrl, EVP_CIPHER_CTX_ctrl_fn, "EVP_CIPHER_CTX_ctrl")       \
    X(EncUpdate, EVP_EncryptUpdate_fn, "EVP_EncryptUpdate")         \
    X(DecUpdate, EVP_DecryptUpdate_fn, "EVP_DecryptUpdate")         \
    X(EncFinal, EVP_EncryptFinal_ex_fn, "EVP_EncryptFinal_ex")      \
    X(DecFinal, EVP_DecryptFinal_ex_fn, "EVP_DecryptFinal_ex")      \
    X(RandBytes, RAND_bytes_fn, "RAND_bytes")                       \
    X(VersionNum, OpenSSL_version_num_fn, "OpenSSL_version_num")

struct OpenSSLApi {
    using EVP_CIPHER_CTX_new_fn = EVP_CIPHER_CTX* (*)(void);
    using EVP_CIPHER_CTX_free_fn = void (*)(EVP_CIPHER_CTX*);
    using EVP_aes_128_gcm_fn = const EVP_CIPHER* (*)(void);
    using EVP_aes_128_ctr_fn = const EVP_CIPHER* (*)(void);
    using EVP_EncryptInit_ex_fn =
        int (*)(EVP_CIPHER_CTX*, const EVP_CIPHER*, ENGINE*, const unsigned char*, const unsigned char*);
    using EVP_DecryptInit_ex_fn =
        int (*)(EVP_CIPHER_CTX*, const EVP_CIPHER*, ENGINE*, const unsigned char*, const unsigned char*);
    using EVP_CIPHER_CTX_ctrl_fn = int (*)(EVP_CIPHER_CTX*, int, int, void*);
    using EVP_EncryptUpdate_fn = int (*)(EVP_CIPHER_CTX*, unsigned char*, int*, const unsigned char*, int);
    using EVP_DecryptUpdate_fn = int (*)(EVP_CIPHER_CTX*, unsigned char*, int*, const unsigned char*, int);
    using EVP_EncryptFinal_ex_fn = int (*)(EVP_CIPHER_CTX*, unsigned char*, int*);
    using EVP_DecryptFinal_ex_fn = int (*)(EVP_CIPHER_CTX*, unsigned char*, int*);
    using RAND_bytes_fn = int (*)(unsigned char*, int);
    using OpenSSL_version_num_fn = unsigned long (*)(void);

#define OPENSSL_API_DECL_MEMBER(member, type, sym) type member = nullptr;
    OPENSSL_API_TABLE(OPENSSL_API_DECL_MEMBER)
#undef OPENSSL_API_DECL_MEMBER

    bool Complete() const
    {
#define OPENSSL_API_CHECK_MEMBER(member, type, sym) (member != nullptr)&&
        return OPENSSL_API_TABLE(OPENSSL_API_CHECK_MEMBER) true;
#undef OPENSSL_API_CHECK_MEMBER
    }
};

class OpenSSLLoader {
public:
    static OpenSSLLoader& Instance();

    bool Init() noexcept;

    bool Ready() const noexcept;

    OpenSSLApi Api;

private:
    OpenSSLLoader() = default;
    ~OpenSSLLoader();
    OpenSSLLoader(const OpenSSLLoader&) = delete;
    OpenSSLLoader& operator=(const OpenSSLLoader&) = delete;

    void* handle_ = nullptr;
    std::once_flag once_;
    bool inited_ = false;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_OPENSSL_LOADER_H
