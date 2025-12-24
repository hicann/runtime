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
#include "wsecv2_callbacks.h"
#include "wsecv2_itf.h"
#include "sdpv2_itf.h"
#include <fcntl.h>
#include "ide_daemon_enc_dec.h"
#include "ide_common_util.h"
#include "utils.h"
#include <string>

using std::string;

class IDE_DAEMON_ENC_UTEST: public testing::Test {
protected:
    virtual void SetUp() {

    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }

};

extern void CbWriLog(int nLevel, const char* module, const char* filename, int numline, const char* pszLog);
extern void CbRecvNotify(unsigned int eNtfCode, const void* data, size_t nDataSize);
extern void CbDoEvents(void);
extern int  CbCreateThreadLock(void **phMutex);
extern void CbDestroyThreadLock(void *hMutex);
extern void CbThreadLock(void *hMutex);
extern void  CbThreadUnlock(void *  hMutex);
extern int CbCreateProcLock(void** CProcLock);
extern void CbDestroyProcLock(void* DProcLock);
extern void CbProcLock(void* ProcLock);
extern void CbProcUnlock(void* ProcUnlock);
extern int GetFileLen(int fd, unsigned int *len);

TEST_F(IDE_DAEMON_ENC_UTEST, call_back_test)
{
    CbWriLog(0, NULL, NULL, 0, NULL);
    CbRecvNotify(0, NULL, 0);
    CbDoEvents();
    CbCreateThreadLock(NULL);
    CbDestroyThreadLock(NULL);
    CbThreadLock(NULL);
    CbThreadUnlock(NULL);
    CbCreateProcLock(NULL);
    CbDestroyProcLock(NULL);
    CbProcLock(NULL);
    EXPECT_CALL(CbProcUnlock(nullptr));
}

extern bool KmcEncryptRandomSw(bool sw, bool value);
extern int WSECGetEntropy(unsigned char **ppEnt, size_t buffLen);
TEST_F(IDE_DAEMON_ENC_UTEST, WSECGetEntropy)
{
    unsigned char mall[10];
    unsigned char *pEnt;

    MOCKER(malloc)
        .stubs()
        .will(returnValue((void *)NULL))
        .then(returnValue((void *)mall));
    MOCKER(SslRandomNumbers)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(1));
    MOCKER(IdeXfree)
        .stubs();
    KmcEncryptRandomSw(true, true);
    EXPECT_EQ(WSEC_FALSE, WSECGetEntropy(NULL, 10));
    EXPECT_EQ(WSEC_FALSE, WSECGetEntropy(&pEnt, 10));
    EXPECT_EQ(WSEC_FALSE, WSECGetEntropy(&pEnt, 10));
    EXPECT_EQ(WSEC_TRUE, WSECGetEntropy(&pEnt, 10));
}

extern void WSECCleanupEntropy(unsigned char *pEnt, size_t buffLen);
TEST_F(IDE_DAEMON_ENC_UTEST, WSECCleanupEntropy)
{
    unsigned char *Ent;

    MOCKER(memset_s)
    .stubs()
    .will(returnValue(-1))
    .then(returnValue(0));

    WSECCleanupEntropy(NULL, 10);
    Ent = (unsigned char *)malloc(sizeof(unsigned char));
    EXPECT_CALL(WSECCleanupEntropy(Ent, 1));

    GlobalMockObject::reset();
}

extern void *Fopen(const char *filePathName, const KmcFileOpenMode mode);
TEST_F(IDE_DAEMON_ENC_UTEST, Fopen)
{
    unsigned char *pEnt;

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));
    EXPECT_EQ(NULL, Fopen(NULL, KMC_FILE_READ_BINARY));
    EXPECT_EQ(NULL, Fopen("test", (const KmcFileOpenMode)100));
    EXPECT_EQ(NULL, Fopen("", KMC_FILE_READ_BINARY));
    void *ret = Fopen("", KMC_FILE_WRITE_BINARY);
    IdeXfree(ret);
    ret = Fopen("test", KMC_FILE_READWRITE_BINARY);
    IdeXfree(ret);

    void *p = IdeXmalloc(PATH_MAX);
    MOCKER(IdeXmalloc)
        .stubs()
        .will(returnValue(p))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(NULL, Fopen("", KMC_FILE_WRITE_BINARY));
}

extern int Fclose(void *stream);
TEST_F(IDE_DAEMON_ENC_UTEST, Fclose)
{
    int fd = -1;

    MOCKER(free)
        .stubs()
        .will(ignoreReturnValue());

    EXPECT_EQ(-1, Fclose(NULL));
    EXPECT_EQ(0, Fclose((void *)&fd));
}

extern int Fread(void *buffer, size_t count, const void *stream);
TEST_F(IDE_DAEMON_ENC_UTEST, Fread)
{
    int fd = -1;
    char buff;

    EXPECT_EQ(WSEC_FALSE, Fread(NULL, 0, (const void *)NULL));
    EXPECT_EQ(WSEC_TRUE, Fread(&buff, 10, (const void *)&fd));
}

extern int Fwrite(const void *buffer, size_t count, const void *stream);
TEST_F(IDE_DAEMON_ENC_UTEST, Fwrite)
{
    int fd = -1;
    char buff;
     
    MOCKER(mmFsync)
    .stubs()
    .will(returnValue(EN_ERR))
    .then(returnValue(EN_OK));

    EXPECT_EQ(WSEC_FALSE, Fwrite(NULL, 0, (const void *)NULL));
    EXPECT_EQ(WSEC_FALSE, Fwrite(&buff, 10, (const void *)&fd));
    EXPECT_EQ(WSEC_TRUE, Fwrite(&buff, 10, (const void *)&fd));
}

extern int Fflush(const void *stream);
TEST_F(IDE_DAEMON_ENC_UTEST, Fflush)
{
    int fd = -1;
    char buff;

    MOCKER(mmFsync)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    EXPECT_EQ(-1, Fflush((const void *)NULL));
    EXPECT_EQ(-1, Fflush((const void *)&fd));
}

extern int Fremove(const char *path);
TEST_F(IDE_DAEMON_ENC_UTEST, Fremove)
{
    int fd = -1;
    char buff;

    MOCKER(remove)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    EXPECT_EQ(-1, Fremove(NULL));
    EXPECT_EQ(-1, Fremove("test"));
}

extern long Ftell(const void *stream);
TEST_F(IDE_DAEMON_ENC_UTEST, Ftell)
{
    int fd = -1;
    char buff;

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    EXPECT_EQ(-1, Ftell((const void *)NULL));
    EXPECT_EQ(-1, Ftell((const void *)&fd));
    EXPECT_EQ(0, Ftell((const void *)&fd));
}

extern long Fseek(const void *stream, long offset, KmcFileSeekPos origin);
TEST_F(IDE_DAEMON_ENC_UTEST, Fseek)
{
    int fd = -1;
    char buff;

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(-1, Fseek((const void *)NULL, 0, KMC_FILE_SEEK_SET));
    EXPECT_EQ(-1, Fseek((const void *)&fd, 0, (KmcFileSeekPos)100));
    EXPECT_EQ(-1, Fseek((const void *)&fd, 0, KMC_FILE_SEEK_SET));
    EXPECT_EQ(-1, Fseek((const void *)&fd, 0, KMC_FILE_SEEK_CUR));
    EXPECT_EQ(-1, Fseek((const void *)&fd, 0, KMC_FILE_SEEK_END));
}

extern int Feof(const void *stream, int *endOfFile);
TEST_F(IDE_DAEMON_ENC_UTEST, Feof)
{
    int fd = -1;
    int endOfFile;

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0))
        .then(returnValue(-1))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(-1))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(1))
        .then(returnValue(0));

    EXPECT_EQ(-1, Feof((const void *)NULL, NULL));
    EXPECT_EQ(-1, Feof((const void *)&fd, &endOfFile));
    EXPECT_EQ(-1, Feof((const void *)&fd, &endOfFile));
    EXPECT_EQ(-1, Feof((const void *)&fd, &endOfFile));
    EXPECT_EQ(0, Feof((const void *)&fd, &endOfFile));
    EXPECT_EQ(0, Feof((const void *)&fd, &endOfFile));
}

extern int Ferrno(void *stream);
TEST_F(IDE_DAEMON_ENC_UTEST, Ferrno)
{
    EXPECT_EQ(errno, Ferrno(NULL));
}

extern int Fexist(const char *filePathName);
TEST_F(IDE_DAEMON_ENC_UTEST, Fexist)
{
    EXPECT_EQ(WSEC_FALSE, Fexist(NULL));
    EXPECT_EQ(WSEC_TRUE, Fexist(" "));
}

extern int UtcTime(const time_t *curTime, struct tm *curTm);
TEST_F(IDE_DAEMON_ENC_UTEST, UtcTime)
{
    EXPECT_EQ(WSEC_FALSE, UtcTime(NULL, NULL));
}

extern int InitKMC(IdeString storPath);
TEST_F(IDE_DAEMON_ENC_UTEST, InitKMC)
{
    IdeString store = "";

    MOCKER(WsecRegFuncEx)
    .stubs()
    .will(returnValue(WSEC_SUCCESS + 1))
    .then(returnValue(WSEC_SUCCESS));

    MOCKER(WsecInitializeEx)
    .stubs()
    .will(returnValue(WSEC_SUCCESS + 1))
    .then(returnValue(WSEC_SUCCESS));

    EXPECT_EQ(-1, InitKMC(nullptr));
    store = "ide_dameon.store";
    EXPECT_EQ(-1, InitKMC(store));
    EXPECT_EQ(-2, InitKMC(store));
    EXPECT_EQ(0, InitKMC(store));
}

extern int EncWithKMCWithoutHmac(unsigned int encalg, const unsigned char *pln, unsigned int plnlen, unsigned char *cpr, unsigned int *retlen);
TEST_F(IDE_DAEMON_ENC_UTEST, TestEncWithKMCWithoutHmac)
{
    unsigned int retlen;
    unsigned int needlen;
    needlen = 3;

    MOCKER(SdpGetCipherDataLenEx)
    .stubs()
    .with(any(), outBoundP(&needlen, sizeof(needlen)))
    .will(returnValue(WSEC_SUCCESS + 1))
    .then(returnValue(WSEC_SUCCESS));

    MOCKER(SdpEncryptEx)
    .stubs()
    .will(returnValue(WSEC_SUCCESS + 1))
    .then(returnValue(WSEC_SUCCESS));

    EXPECT_EQ(-1, EncWithKMCWithoutHmac(0, NULL, 0, NULL, NULL));
    EXPECT_EQ(-1, EncWithKMCWithoutHmac(0, NULL, 0, NULL, &retlen));
    retlen = 0;
    EXPECT_EQ(-1, EncWithKMCWithoutHmac(0, NULL, 0, NULL, &retlen));
    retlen = 4;
    EXPECT_EQ(-1, EncWithKMCWithoutHmac(0, NULL, 0, NULL, &retlen));
    EXPECT_EQ(0, EncWithKMCWithoutHmac(0, NULL, 0, NULL, &retlen));
}

extern int TestDecWithKMC(unsigned char *cpr, unsigned int cprlen, unsigned char *pln, unsigned int *plnlen);
TEST_F(IDE_DAEMON_ENC_UTEST, TestDecWithKMC)
{
    unsigned int plnlen;
    plnlen = 1;
    unsigned char ciphertext[128] = {0};
    unsigned char decrypedtext[128] = {0};

    MOCKER(SdpDecryptEx)
    .stubs()
    .will(returnValue(WSEC_SUCCESS + 1))
    .then(returnValue(WSEC_SUCCESS));


    EXPECT_EQ(-1, TestDecWithKMC(NULL, 0, NULL, NULL));
    EXPECT_EQ(-1, TestDecWithKMC(NULL, 0, NULL, &plnlen));
    EXPECT_EQ(-1, TestDecWithKMC(ciphertext, 0, decrypedtext, NULL));
    EXPECT_EQ(-2, TestDecWithKMC(ciphertext, 0, decrypedtext, &plnlen));
    EXPECT_EQ(0, TestDecWithKMC(ciphertext, 0, decrypedtext, &plnlen));
}

extern int UninitKMC(void);
TEST_F(IDE_DAEMON_ENC_UTEST, UninitKMC)
{
    MOCKER(WsecFinalizeEx)
    .stubs()
    .will(returnValue(WSEC_SUCCESS + 1))
    .then(returnValue(WSEC_SUCCESS));


    EXPECT_EQ(-1, UninitKMC());
    EXPECT_EQ(0, UninitKMC());
}

#define BUF_MAX (1024)

TEST_F(IDE_DAEMON_ENC_UTEST, EncWithoutHmacWithKMC)
{

    unsigned char password[10];

    MOCKER(InitKMC)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(EncWithKMCWithoutHmac)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(UninitKMC)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(0));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(mmWrite)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(BUF_MAX));

    //invalid param
    EXPECT_EQ(-1, EncWithoutHmacWithKMC(NULL, 0));
    //InitKMC failed
    EXPECT_EQ(-1, EncWithoutHmacWithKMC(password, 10));
    //TestEncWithKMCWithouHmac
    EXPECT_EQ(-1, EncWithoutHmacWithKMC(password, 10));
    //mmOpen2 failed
    EXPECT_EQ(-1, EncWithoutHmacWithKMC(password, 10));
    //mmWrite failed
    EXPECT_EQ(-1, EncWithoutHmacWithKMC(password, 10));
    //UinitKMC failed
    EXPECT_EQ(-1, EncWithoutHmacWithKMC(password, 10));
    //SUCC
    EXPECT_EQ(0, EncWithoutHmacWithKMC(password, 10));
}

TEST_F(IDE_DAEMON_ENC_UTEST, GetFileLen)
{

    unsigned int len = 0;

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(BUF_MAX + 1))
        .then(returnValue(1))
        .then(returnValue(-1))
        .then(returnValue(1));

    //Invalid parameter
    EXPECT_EQ(-1, GetFileLen(-1, &len));
    //mmLseek for SEEK_END failed
    EXPECT_EQ(-1, GetFileLen(1, &len));
    //mmLseek for SEEK_SET failed
    EXPECT_EQ(-1, GetFileLen(1, &len));
    //SUCC
    EXPECT_EQ(0, GetFileLen(1, &len));
    EXPECT_EQ(1, len);
}

TEST_F(IDE_DAEMON_ENC_UTEST, DecryptExWithKMC)
{
    char secu_path[10];
    char stor_path[10];
    unsigned char password[10];
    unsigned int decrypedlen = 20;

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(GetFileLen)
        .stubs()
        .with(any(), outBoundP(&decrypedlen, sizeof(decrypedlen)))
        .will(returnValue(-1))
        .then(returnValue(1));

    //invalid param
    EXPECT_EQ(-1, DecryptExWithKMC(NULL, NULL, NULL, 0));
    //mmRealPath failed
    EXPECT_EQ(-1, DecryptExWithKMC(secu_path, stor_path, password, 10));
    //mmOpen2 failed
    EXPECT_EQ(-1, DecryptExWithKMC(secu_path, stor_path, password, 10));
    //GetFileLen failed
    EXPECT_EQ(-1, DecryptExWithKMC(secu_path, stor_path, password, 10));
}

TEST_F(IDE_DAEMON_ENC_UTEST, DecryptExWithKMC_mmLseek)
{
    char secu_path[10];
    char stor_path[10];
    unsigned char password[10];
    unsigned int decrypedlen = 20;

    MOCKER(mmRead)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(InitKMC)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(TestDecWithKMC)
        .stubs()
        .with(any(), any(), any(), outBoundP(&decrypedlen, sizeof(decrypedlen)))
        .will(returnValue(0));

    //mmRead
    EXPECT_EQ(-1, DecryptExWithKMC(secu_path, stor_path, password, 10));
    //InitKMC failed
    EXPECT_EQ(-1, DecryptExWithKMC(secu_path, stor_path, password, 10));
    //TestDecWithKMC failed
    EXPECT_EQ(-1, DecryptExWithKMC(secu_path, stor_path, password, 10));
}

TEST_F(IDE_DAEMON_ENC_UTEST, DecryptExWithKMC_TestDecWithKMC)
{
    char secu_path[10];
    char stor_path[10];
    unsigned char password[10];
    unsigned int decrypedlen = 5;

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(InitKMC)
        .stubs()
        .will(returnValue(0));

    MOCKER(TestDecWithKMC)
        .stubs()
        .with(any(), any(), any(), outBoundP(&decrypedlen, sizeof(decrypedlen)))
        .will(returnValue(0));

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(UninitKMC)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(0));

    //memcpy_s failed
    EXPECT_EQ(-1, DecryptExWithKMC(secu_path, stor_path, password, 10));
    //UnitKMC failed
    EXPECT_EQ(-1, DecryptExWithKMC(secu_path, stor_path, password, 10));
    //SUCC
    EXPECT_EQ(0, DecryptExWithKMC(secu_path, stor_path, password, 10));
}

