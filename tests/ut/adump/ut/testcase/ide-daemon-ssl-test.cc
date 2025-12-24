/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"

#include "ide-daemon-ssl-test.h"
#include "../stub/ide_ssl_stub.h"
#include "ide_common_util.h"
#include <string>
#include "utils.h"
#include "common/config.h"
#include "ide_daemon_stub.h"
using std::string;

extern int PemPasswdCb(char *buf, int size, int rwflag, void *userdata);
extern string GetCfgResolvedPath(const string &path);
extern int SslVerifySelectTimeout(SslPt ssl, int sock, int stat, int timeout);
using namespace IdeDaemon::Common::Utils;
using namespace IdeDaemon::Common::Config;

class IDE_DAEMON_SSL_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(IDE_DAEMON_SSL_UTEST, SslInit)
{
    sock_type_t type1 = TLS_CLIENT;
    sock_type_t type2 = TLS_SERVER;
    ssl_ctx_t *g_ssl_ctx = (ssl_ctx_t *)0x123456;
    ssl_ctx_t *null_ssl_ctx = NULL;
    ssl_method_t *valid_method = (ssl_method_t *)0x123455;
    ssl_method_t *invalid_method = NULL;

    MOCKER(SslCtxNew).stubs().will(returnValue(null_ssl_ctx)).then(returnValue(g_ssl_ctx));

    MOCKER(SslLoadVerifyInfo)
        .stubs()
        .will(returnValue(SSL_ERROR))
        .then(returnValue(SSL_ERROR))
        .then(returnValue(SSL_OK));

    MOCKER(OPENSSL_init_ssl).stubs().then(returnValue(1));

    MOCKER(SslCreateMethod).stubs().will(returnValue(invalid_method)).then(returnValue(valid_method));

    //SslCreateMethod == NULLn
    EXPECT_EQ(SSL_ERROR, SslInit(type1));

    //ssl_ctx == NULL
    EXPECT_EQ(SSL_ERROR, SslInit(type1));

    //type == TLS_CLIENT && ret == SSL_ERROR
    EXPECT_EQ(SSL_ERROR, SslInit(type1));

    //type == TLS_SERVER && ret == SSL_ERROR
    EXPECT_EQ(SSL_ERROR, SslInit(type2));

    //SslInit ok
    EXPECT_EQ(SSL_OK, SslInit(type2));
    EXPECT_EQ(SSL_OK, SslInit(type1));
    EXPECT_TRUE(IsSslClientInited());
}
extern int KmcGetPassword(IdeStringBuffer pwd, int pwd_len);
TEST_F(IDE_DAEMON_SSL_UTEST, SslLoadVerifyInfo)
{
    ssl_ctx_t *invalid_ctx = NULL;
    ssl_ctx_t *valid_ctx = (ssl_ctx_t *)0x123456;

    const char *invalid_ca_file = NULL;
    const char *valid_ca_file = "1";

    const char *invalid_cert_file = NULL;
    const char *valid_cert_file = "2";

    const char *invalid_key_file = NULL;
    const char *valid_key_file = "3";

    MOCKER(SSL_CTX_load_verify_locations).stubs().will(returnValue(-1)).then(returnValue(1));

    MOCKER(SSL_CTX_set_default_verify_paths).stubs().will(returnValue(-1)).then(returnValue(1));

    MOCKER(SSL_CTX_use_certificate_file).stubs().will(returnValue(-1)).then(returnValue(1));

    MOCKER(SSL_CTX_use_PrivateKey_file).stubs().will(returnValue(-1)).then(returnValue(1));

    MOCKER(SSL_CTX_check_private_key).stubs().will(returnValue(-1)).then(returnValue(1));

    MOCKER(KmcGetPassword).stubs().will(returnValue(-1)).then(returnValue(0));

    MOCKER(GenrateCfgFile).stubs().will(returnValue(-1)).then(returnValue(0));

    // one of ctx, ca_file, cert_file, key_file is NULLL
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(invalid_ctx, valid_ca_file, valid_cert_file, valid_key_file));
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, invalid_ca_file, valid_cert_file, valid_key_file));
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, valid_ca_file, invalid_cert_file, valid_key_file));
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, valid_ca_file, valid_cert_file, invalid_key_file));

    // SSL_CTX_load_verify_locations <= 0
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, valid_ca_file, valid_cert_file, valid_key_file));

    // SSL_CTX_set_default_verify_paths <=0
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, valid_ca_file, valid_cert_file, valid_key_file));

    // SSL_CTX_use_certificate_file <=0
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, valid_ca_file, valid_cert_file, valid_key_file));

    // GenrateCfgFile <=0
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, valid_ca_file, valid_cert_file, valid_key_file));

    // KmcGetPassword <=0
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, valid_ca_file, valid_cert_file, valid_key_file));

    // SSL_CTX_use_PrivateKey_file <= 0
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, valid_ca_file, valid_cert_file, valid_key_file));

    // SSL_CTX_check_private_key <= 0
    EXPECT_EQ(SSL_ERROR, SslLoadVerifyInfo(valid_ctx, valid_ca_file, valid_cert_file, valid_key_file));

    // SslLoadVerifyInfo ok
    EXPECT_EQ(SSL_OK, SslLoadVerifyInfo(valid_ctx, valid_ca_file, valid_cert_file, valid_key_file));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslCreateMethod)
{
    sock_type_t type1 = TLS_CLIENT;
    sock_type_t type2 = TLS_SERVER;

    ssl_method_t *invalid_type = NULL;
    EXPECT_EQ(invalid_type, SslCreateMethod(type1));
    EXPECT_EQ(invalid_type, SslCreateMethod(type2));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslCtxNew)
{
    ssl_method_t *valid_method = (ssl_method_t *)0x123456;
    ssl_method_t *invalid_method = NULL;

    ssl_ctx_t *invalid_ctx = NULL;

    // method ==NULL
    EXPECT_EQ(invalid_ctx, SslCtxNew(invalid_method));

    // method != NULL
    EXPECT_EQ(invalid_ctx, SslCtxNew(valid_method));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslNew)
{
    ssl_ctx_t *valid_ctx = (ssl_ctx_t *)0x123456;
    ssl_ctx_t *invalid_ctx = NULL;

    ssl_t *invalid_ssl = NULL;
    // ctx ==NULL
    EXPECT_EQ(invalid_ssl, SslNew(invalid_ctx));

    // ctx !=NULL
    EXPECT_EQ(invalid_ssl, SslNew(valid_ctx));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslSetSock)
{
    ssl_t *valid_ssl = (ssl_t *)0x123456;
    ssl_t *invalid_ssl = NULL;

    ssl_handle_t invalid_sock = -1;
    ssl_handle_t valid_sock = 1;

    MOCKER(SSL_set_fd).stubs().will(returnValue(0)).then(returnValue(1));

    // ssl == NULL || sock < 0
    EXPECT_EQ(SSL_ERROR, SslSetSock(invalid_ssl, valid_sock));
    EXPECT_EQ(SSL_ERROR, SslSetSock(valid_ssl, invalid_sock));

    EXPECT_EQ(SSL_ERROR, SslSetSock(valid_ssl, valid_sock));
    // ok
    EXPECT_EQ(SSL_OK, SslSetSock(valid_ssl, valid_sock));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslAccept)
{
    ssl_t *valid_ssl = (ssl_t *)0x123456;
    ssl_t *invalid_ssl = NULL;

    MOCKER(SSL_set_cipher_list).stubs().will(returnValue(0)).then(returnValue(1));

    // ssl == NULL
    EXPECT_EQ(SSL_ERROR, SslAccept(invalid_ssl));
    // SSL_set_cipher_list error
    EXPECT_EQ(SSL_ERROR, SslAccept(valid_ssl));
    // ok
    EXPECT_EQ(SSL_OK, SslAccept(valid_ssl));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslAcceptVerify)
{
    ssl_handle_t invalid_sock = -1;
    ssl_handle_t valid_sock = 1;

    ssl_t *valid_ssl = (ssl_t *)0x123456;
    ssl_t *invalid_ssl = NULL;

    MOCKER(SslNew).stubs().will(returnValue(invalid_ssl)).then(returnValue(valid_ssl));

    MOCKER(SslSetSock).stubs().will(returnValue(SSL_ERROR)).then(returnValue(SSL_OK));

    MOCKER(SslAccept).stubs().will(returnValue(SSL_ERROR)).then(returnValue(SSL_OK));

    MOCKER(IdeSetFdFlag).stubs().will(returnValue(1)).then(returnValue(0));

    MOCKER(SSL_get_error)
        .stubs()
        .will(returnValue(SSL_ERROR_WANT_WRITE))
        .then(returnValue(SSL_ERROR_WANT_READ))
        .then(returnValue(SSL_ERROR_SYSCALL))
        .then(returnValue(-1))
        .then(returnValue(SSL_ERROR_NONE));

    MOCKER(select).stubs().will(returnValue(0)).then(returnValue(2));

    MOCKER(IdeClearFdFlag).stubs().will(returnValue(1)).then(returnValue(0));

    // sock < 0
    EXPECT_EQ(invalid_ssl, SslAcceptVerify(invalid_sock));

    // ssl == NULL
    EXPECT_EQ(invalid_ssl, SslAcceptVerify(valid_sock));

    // SslSetSock == SSL_ERROR
    EXPECT_EQ(invalid_ssl, SslAcceptVerify(valid_sock));

    // IdeSetFdFlag return ERROR
    EXPECT_EQ(invalid_ssl, SslAcceptVerify(valid_sock));

    // SSL_get_error return SSL_ERROR_WANT_WRITE
    EXPECT_EQ(invalid_ssl, SslAcceptVerify(valid_sock));
    // SSL_get_error return SSL_ERROR_WANT_READ
    EXPECT_EQ(valid_ssl, SslAcceptVerify(valid_sock));
    // SSL_get_error return SSL_ERROR_SYSCALL
    EXPECT_EQ(invalid_ssl, SslAcceptVerify(valid_sock));
    // SSL_get_error return SSL_ERROR_SYSCALL + 1
    EXPECT_EQ(invalid_ssl, SslAcceptVerify(valid_sock));
    // ok
    EXPECT_EQ(valid_ssl, SslAcceptVerify(valid_sock));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslConnect)
{
    ssl_t *ssl = (ssl_t *)0x123456;
    ssl_t *invalid_ssl = NULL;

    MOCKER(SSL_connect).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(SSL_set_cipher_list).stubs().will(returnValue(0)).then(returnValue(1));

    // ssl == NULL
    EXPECT_EQ(SSL_ERROR, SslConnect(invalid_ssl));
    // SSL_set_cipher_list error
    EXPECT_EQ(SSL_ERROR, SslConnect(ssl));
    // SSL_connect == -1
    EXPECT_EQ(SSL_ERROR, SslConnect(ssl));
    // ok
    EXPECT_EQ(SSL_OK, SslConnect(ssl));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslConnectVerify)
{
    ssl_handle_t invalid_sock = -1;
    ssl_handle_t valid_sock = 1;

    ssl_t *valid_ssl = (ssl_t *)0x123456;
    ssl_t *invalid_ssl = NULL;

    MOCKER(SslNew).stubs().will(returnValue(invalid_ssl)).then(returnValue(valid_ssl));

    MOCKER(SslSetSock).stubs().will(returnValue(SSL_ERROR)).then(returnValue(SSL_OK));

    MOCKER(SslConnect).stubs().will(returnValue(SSL_ERROR)).then(returnValue(SSL_OK));

    MOCKER(SslVerifySelectTimeout)
        .stubs()
        .will(returnValue(SSL_VERIFY_STATUS_ERROR))
        .then(returnValue(SSL_VERIFY_STATUS_OK));

    // sock < 0
    EXPECT_EQ(invalid_ssl, SslConnectVerify(invalid_sock));
    // ssl == NULL
    EXPECT_EQ(invalid_ssl, SslConnectVerify(valid_sock));
    // SslSetSock == SSL_ERROR
    EXPECT_EQ(invalid_ssl, SslConnectVerify(valid_sock));
    // SslConnect == SSL_ERROR
    EXPECT_EQ(invalid_ssl, SslConnectVerify(valid_sock));
    // ok
    EXPECT_EQ(valid_ssl, SslConnectVerify(valid_sock));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslRecv)
{
    ssl_t *valid_ssl = (ssl_t *)0x123456;
    ssl_t *invalid_ssl = NULL;

    void *invalid_buf = NULL;
    void *valid_buf = (ssl_ctx_t *)0x123456;

    int invalid_num = -1;
    int valid_num = 1;

    // ssl == NULL || buf == NULL || num <= 0
    EXPECT_EQ(SSL_ERROR, SslRecv(invalid_ssl, valid_buf, valid_num));
    EXPECT_EQ(SSL_ERROR, SslRecv(valid_ssl, invalid_buf, valid_num));
    EXPECT_EQ(SSL_ERROR, SslRecv(valid_ssl, valid_buf, invalid_num));

    // ok
    EXPECT_EQ(0, SslRecv(valid_ssl, valid_buf, valid_num));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslSend)
{
    ssl_t *valid_ssl = (ssl_t *)0x123456;
    ssl_t *invalid_ssl = NULL;

    void *invalid_buf = NULL;
    void *valid_buf = (ssl_ctx_t *)0x123456;

    int invalid_num = -1;
    int valid_num = 1;

    // ssl == NULL || buf == NULL || num <= 0
    EXPECT_EQ(SSL_ERROR, SslSend(invalid_ssl, valid_buf, valid_num));
    EXPECT_EQ(SSL_ERROR, SslSend(valid_ssl, invalid_buf, valid_num));
    EXPECT_EQ(SSL_ERROR, SslSend(valid_ssl, valid_buf, invalid_num));

    // ok
    EXPECT_EQ(0, SslSend(valid_ssl, valid_buf, valid_num));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslCtxFreeByType)
{
    sock_type_t type1 = TLS_CLIENT;
    sock_type_t type2 = TLS_SERVER;

    // ssl == NULL || buf == NULL || num <= 0
    EXPECT_EQ(SSL_OK, SslCtxFreeByType(type1));
    EXPECT_EQ(SSL_OK, SslCtxFreeByType(type2));
}

#define PASSWORD_MAX_LNE (32)
TEST_F(IDE_DAEMON_SSL_UTEST, PemPasswdCb)
{
    char buf[20] = {0};
    int size = 20;
    int rwflag = 0;
    char userdata[PASSWORD_MAX_LNE] = "test123";

    MOCKER(strcpy_s).stubs().will(returnValue(-1)).then(returnValue(EOK));

    EXPECT_EQ(-1, PemPasswdCb(buf, size, rwflag, (void *)userdata));
    GlobalMockObject::verify();

    char userdata2[PASSWORD_MAX_LNE] = "test123";
    EXPECT_EQ(strlen("test123"), PemPasswdCb(buf, size, rwflag, (void *)userdata2));
}

TEST_F(IDE_DAEMON_SSL_UTEST, KmcGetPassword)
{
    MOCKER(DecryptExWithKMC).stubs().will(returnValue(SSL_ERROR)).then(returnValue(SSL_OK));

    MOCKER(strcpy_s).stubs().will(returnValue(-1)).then(returnValue(0));

    char pwd[PASSWORD_MAX_LNE] = {0};

    EXPECT_EQ(SSL_ERROR, KmcGetPassword(pwd, PASSWORD_MAX_LNE));
    EXPECT_EQ(SSL_ERROR, KmcGetPassword(pwd, PASSWORD_MAX_LNE));
    EXPECT_EQ(SSL_OK, KmcGetPassword(pwd, PASSWORD_MAX_LNE));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslDecodeBase64Test)
{
    unsigned char pwd[20] = {0};

    EXPECT_EQ(SSL_ERROR, SslDecodeBase64("123456", 6, pwd, 513));
    EXPECT_EQ(11, SslDecodeBase64("123456", 6, pwd, 11));
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslDecodeBase64_error)
{
    unsigned char pwd[20] = {0};
    MOCKER(BIO_new).stubs().will(returnValue((BIO *)NULL)).then(returnValue((BIO *)1234));
    MOCKER(BIO_new_mem_buf).stubs().will(returnValue((BIO *)NULL));
    EXPECT_EQ(SSL_ERROR, SslDecodeBase64(NULL, 0, pwd, 9));
    EXPECT_EQ(SSL_ERROR, SslDecodeBase64("123456", 6, pwd, 11));
}

TEST_F(IDE_DAEMON_SSL_UTEST, GetCfgResolvedPath)
{
    string test = "11";

    MOCKER(CreateDirByFileName)
        .stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR));
    string pid = std::to_string(mmGetPid());
    string result = test + "." + pid;
    EXPECT_EQ("", GetCfgResolvedPath(test));
    EXPECT_EQ(result, GetCfgResolvedPath(test));
}

extern SslCtxT *g_sslServerCtx;
TEST_F(IDE_DAEMON_SSL_UTEST, CheckServerVerifyInfoValidity)
{
    g_sslServerCtx = nullptr;
    MOCKER(SSL_CTX_get0_certificate).stubs().will(returnValue((X509 *)nullptr)).then(returnValue((X509 *)0x123456));
    MOCKER(ASN1_TIME_cmp_time_t).stubs().will(returnValue(1)).then(returnValue(0));

    EXPECT_EQ(SSL_ERROR, CheckServerVerifyInfoValidity());
    g_sslServerCtx = (SslCtxT *)0x123456;
    EXPECT_EQ(SSL_ERROR, CheckServerVerifyInfoValidity());
    EXPECT_EQ(SSL_ERROR, CheckServerVerifyInfoValidity());
    EXPECT_EQ(SSL_OK, CheckServerVerifyInfoValidity());
    g_sslServerCtx = nullptr;
}

extern SslCtxT *g_sslClientCtx;
TEST_F(IDE_DAEMON_SSL_UTEST, CheckClientVerifyInfoValidity)
{
    g_sslClientCtx = nullptr;
    MOCKER(SSL_CTX_get0_certificate).stubs().will(returnValue((X509 *)nullptr)).then(returnValue((X509 *)0x123456));
    MOCKER(ASN1_TIME_cmp_time_t).stubs().will(returnValue(1)).then(returnValue(0));
    EXPECT_EQ(SSL_ERROR, CheckClientVerifyInfoValidity());
    g_sslClientCtx = (SslCtxT *)0x123456;
    EXPECT_EQ(SSL_ERROR, CheckClientVerifyInfoValidity());
    EXPECT_EQ(SSL_ERROR, CheckClientVerifyInfoValidity());
    EXPECT_EQ(SSL_OK, CheckClientVerifyInfoValidity());
    g_sslClientCtx = nullptr;
}

TEST_F(IDE_DAEMON_SSL_UTEST, SslRandomNumbers)
{
    unsigned char buff[10];
    EXPECT_EQ(0, SslRandomNumbers(buff, 0));
    EXPECT_EQ(0, SslRandomNumbers(nullptr, 10));
    EXPECT_EQ(1, SslRandomNumbers(buff, 10));
}
