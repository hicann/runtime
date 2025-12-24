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
#include "log_compress.h"
#include "log_compress/log_hardware_zip.h"
#include "log_file_info.h"
#include "slogd_compress.h"
#include "log_pm_sr.h"
#include "log_pm_sig.h"
#include "ascend_hal_stub.h"
#include "self_log_stub.h"
#include "log_iam_pub.h"
#include "iam.h"
#include "slogd_stub.h"

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
#define BLOCK_SIZE          (1024 * 1024) // 1MB

class MDC_LOG_COMPRESS_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        EXPECT_EQ(0, GetErrLogNum());
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

// 硬件压缩
TEST_F(MDC_LOG_COMPRESS_FUNC_UTEST, HardwareCompressFile)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();

    // 压缩文件
    EXPECT_EQ(LOG_SUCCESS, HardwareCompressFile(FILE_PATH));

    // 释放
    DlogDestructor();
}

// test null input filename
TEST_F(MDC_LOG_COMPRESS_FUNC_UTEST, LogCompressCheckUnzipSuffixNull)
{
    EXPECT_EQ(false, LogCompressCheckUnzipSuffix((char *)NULL));
}

// test file which is not log file
TEST_F(MDC_LOG_COMPRESS_FUNC_UTEST, LogCompressCheckUnzipSuffixInvalid)
{
    char fileName[MAX_FULLPATH_LEN];
    strcpy(fileName, PATH_ROOT "/test");
    EXPECT_EQ(false, LogCompressCheckUnzipSuffix(fileName));
    memset(fileName, 0, MAX_FULLPATH_LEN);
    strcpy(fileName, PATH_ROOT "/test.logx");
    EXPECT_EQ(false, LogCompressCheckUnzipSuffix(fileName));
    memset(fileName, 0, MAX_FULLPATH_LEN);
    strcpy(fileName, PATH_ROOT "/test.log.gzx");
    EXPECT_EQ(false, LogCompressCheckUnzipSuffix(fileName));
}

// test file is zip log
TEST_F(MDC_LOG_COMPRESS_FUNC_UTEST, LogCompressCheckUnzipSuffixZip)
{
    char fileName[MAX_FULLPATH_LEN];
    strcpy(fileName, PATH_ROOT "/test.log.gz");
    EXPECT_EQ(false, LogCompressCheckUnzipSuffix(fileName));
}

// test file is unzip log
TEST_F(MDC_LOG_COMPRESS_FUNC_UTEST, LogCompressCheckUnzipSuffixUnzip)
{
    char fileName[MAX_FULLPATH_LEN];
    strcpy(fileName, PATH_ROOT "/test.log");
    EXPECT_EQ(true, LogCompressCheckUnzipSuffix(fileName));
}

TEST_F(MDC_LOG_COMPRESS_FUNC_UTEST, HardwareCompressOverBlockSize)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();
    // 压缩缓存
    size_t msgInLen = 2 * BLOCK_SIZE;
    char *msgIn = (char *)malloc(msgInLen);
    memset_s(msgIn, msgInLen, 0, msgInLen);
    memset_s(msgIn, msgInLen - 1U, 1, msgInLen - 1U);
    char *msgOut;
    uint32_t outLen;
    EXPECT_EQ(LOG_SUCCESS, LogCompressBuffer(msgIn, strlen(msgIn), &msgOut, &outLen));
    free(msgIn);
    free(msgOut);

    // 释放
    DlogDestructor();
}

TEST_F(MDC_LOG_COMPRESS_FUNC_UTEST, HardwareCompressNotReady)
{
    ResChangeStatus(KMS_IAM_SERVICE_PATH, IAM_RESOURCE_WAITING);
    EXPECT_EQ(LOG_SERVICE_NOT_READY, SlogdCompress(nullptr, 0, nullptr, nullptr));
}