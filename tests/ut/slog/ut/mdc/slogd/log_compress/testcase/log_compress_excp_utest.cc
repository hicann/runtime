/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "log_compress/log_compress.h"
#include "log_file_info.h"
#include "slogd_compress.h"
#include "ascend_hal_stub.h"
#include "self_log_stub.h"
#include "log_pm_sr.h"
#include "log_pm_sig.h"
#include "slogd_stub.h"
#include "log_iam_pub.h"
#include "iam.h"
using namespace std;
using namespace testing;

typedef struct FileList {
    char fileName[MAX_FULLPATH_LEN];
    uint32_t len;
    struct FileList *next;
} FileList;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
extern void SlogSysStateHandler(int32_t state);
#ifdef __cplusplus
}
#endif // __cplusplus

#define LOG_NUM 10

class MDC_LOG_COMPRESS_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    static void DlogConstructor()
    {
        FILE *fp = fopen(FILE_PATH, "w");
        char msg[MSG_LENGTH];
        for (int32_t i = 0; i < LOG_NUM; ++i) {
            snprintf_s(msg, MSG_LENGTH, MSG_LENGTH - 1, "[MDC_LOG_COMPRESS_FUNC_UTEST][Log] test for compress log file, index = %d", i);
            fwrite(msg, MSG_LENGTH, 1, fp);
        }
        fclose(fp);
        char cmdToFile[200] = { 0 };
        sprintf(cmdToFile, "cp %s %s", FILE_PATH, FILE_PATH_BAK);
        system(cmdToFile);
    }

    static void DlogDestructor()
    {
    }

    bool DlogCheckFile()
    {
        char resultFile[200] = { 0 };
        sprintf(resultFile, "%s/MDC_LOG_COMPRESS_FUNC_UTEST_cmd_result.txt", PATH_ROOT);

        char cmdToFile[200] = { 0 };
        sprintf(cmdToFile, "gzip -d %s.gz > %s", FILE_PATH, resultFile);
        system(cmdToFile);
        memset_s(cmdToFile, 200, 0, 200);
        sprintf(cmdToFile, "diff %s %s > %s", FILE_PATH, FILE_PATH_BAK, resultFile);
        system(cmdToFile);

        char buf[100] = {0};
        FILE *fp = fopen(resultFile, "r");
        int size = fread(buf, 1, 100, fp);
        fclose(fp);
        if (size == 0) {
            return true;
        }
        memset_s(cmdToFile, 200, 0, 200);
        sprintf(cmdToFile, "cat %s", resultFile);
        system(cmdToFile);
        return false;
    }
};

// 硬件压缩初始化失败
TEST_F(MDC_LOG_COMPRESS_EXCP_UTEST, HardwareCompressInitFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();
    MOCKER(hw_deflateInit2_).stubs().will(returnValue((int32_t)HZIP_OK + 1));

    // 压缩文件
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(FILE_PATH));
    // 压缩缓存
    const char* msgIn = "compress in";
    char *msgOut;
    uint32_t outLen;
    EXPECT_EQ(LOG_FAILURE, LogCompressBuffer(msgIn, strlen(msgIn), &msgOut, &outLen));

    // 释放
    DlogDestructor();
    EXPECT_EQ(3, GetErrLogNum());
}

// 硬件压缩内存申请失败
TEST_F(MDC_LOG_COMPRESS_EXCP_UTEST, HardwareCompressMallocFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();
    MOCKER(hw_deflateInit2_).stubs().will(returnValue(0));
    MOCKER(LogMalloc).stubs().will(returnValue((void *)NULL));

    // 压缩文件
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(FILE_PATH));
    // 压缩缓存
    const char* msgIn = "compress in";
    char *msgOut;
    uint32_t outLen;
    EXPECT_EQ(LOG_FAILURE, LogCompressBuffer(msgIn, strlen(msgIn), &msgOut, &outLen));

    // 释放
    DlogDestructor();
    EXPECT_EQ(2, GetErrLogNum());
}

// 硬件压缩拷贝失败
TEST_F(MDC_LOG_COMPRESS_EXCP_UTEST, HardwareCompressCopyFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();
    MOCKER(memcpy_s).stubs().will(returnValue(-1));

    // 压缩文件
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(FILE_PATH));
    // 压缩缓存
    const char* msgIn = "compress in";
    char *msgOut;
    uint32_t outLen;
    EXPECT_EQ(LOG_FAILURE, LogCompressBuffer(msgIn, strlen(msgIn), &msgOut, &outLen));

    // 释放
    DlogDestructor();
    EXPECT_EQ(3, GetErrLogNum());
}

TEST_F(MDC_LOG_COMPRESS_EXCP_UTEST, HardwareCompressMemcpyFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();
    MOCKER(memcpy_s).stubs().will(returnValue(0)).then(returnValue(-1));

    // 压缩缓存
    const char* msgIn = "compress in";
    char *msgOut;
    uint32_t outLen;
    EXPECT_EQ(LOG_FAILURE, LogCompressBuffer(msgIn, strlen(msgIn), &msgOut, &outLen));

    // 释放
    DlogDestructor();
    EXPECT_EQ(2, GetErrLogNum());
}

TEST_F(MDC_LOG_COMPRESS_EXCP_UTEST, HardwareCompressMemcpyFailedOverBlock)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();
    MOCKER(memcpy_s).stubs().will(returnValue(0)).then(returnValue(-1));

    // 压缩缓存
    size_t msgInLen = 2 * 1024 * 1024;
    char *msgIn = (char *)malloc(msgInLen);
    memset_s(msgIn, msgInLen, 0, msgInLen);
    memset_s(msgIn, msgInLen - 1U, 1, msgInLen - 1U);
    char *msgOut;
    uint32_t outLen;
    EXPECT_EQ(LOG_FAILURE, LogCompressBuffer(msgIn, strlen(msgIn), &msgOut, &outLen));
    free(msgIn);

    // 释放
    DlogDestructor();
    EXPECT_EQ(2, GetErrLogNum());
}

TEST_F(MDC_LOG_COMPRESS_EXCP_UTEST, HardwareCompressCpFailedOverBlock)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();
    MOCKER(memcpy_s).stubs().will(returnValue(0)).then(returnValue(0)).then(returnValue(-1));

    // 压缩缓存
    size_t msgInLen = 2 * 1024 * 1024;
    char *msgIn = (char *)malloc(msgInLen);
    memset_s(msgIn, msgInLen, 0, msgInLen);
    memset_s(msgIn, msgInLen - 1U, 1, msgInLen - 1U);
    char *msgOut;
    uint32_t outLen;
    EXPECT_EQ(LOG_FAILURE, LogCompressBuffer(msgIn, strlen(msgIn), &msgOut, &outLen));
    free(msgIn);

    // 释放
    DlogDestructor();
    EXPECT_EQ(2, GetErrLogNum());
}

// 硬件压缩失败
TEST_F(MDC_LOG_COMPRESS_EXCP_UTEST, HardwareCompressHwEndFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();
    MOCKER(hw_deflateInit2_).stubs().will(returnValue(0));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    MOCKER(hw_deflate).stubs().will(returnValue(0));
    MOCKER(hw_deflateEnd).stubs().will(returnValue((int32_t)HZIP_OK + 1));

    // 压缩文件
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(FILE_PATH));

    // 释放
    DlogDestructor();
    EXPECT_EQ(1, GetErrLogNum());
}

TEST_F(MDC_LOG_COMPRESS_EXCP_UTEST, LogCompressFileRotateFailed)
{
    MOCKER(strcpy_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(LOG_FAILURE, LogCompressFileRotate(FILE_PATH));
    char file[4096] = { 0 };
    memset_s(file, 4095, 1, 4095);
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(file));
}

TEST_F(MDC_LOG_COMPRESS_EXCP_UTEST, HardwareCompressDeflateFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();
    MOCKER(hw_deflate).stubs().will(returnValue(0)).then(returnValue(HZIP_OK + 1));

    // 压缩缓存
    const char* msgIn = "compress in";
    char *msgOut;
    uint32_t outLen;
    EXPECT_EQ(LOG_FAILURE, LogCompressBuffer(msgIn, strlen(msgIn), &msgOut, &outLen));

    // 释放
    DlogDestructor();
    EXPECT_EQ(1, GetErrLogNum());
}
