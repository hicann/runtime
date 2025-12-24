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
#include <zlib.h>
#include "log_compress.h"
#include "log_file_info.h"
#include "slogd_compress.h"
#include "log_pm_sr.h"
#include "log_pm_sig.h"
#include "self_log_stub.h"

using namespace std;
using namespace testing;

#define LOG_NUM 10
#define BLOCK_SIZE          (1024 * 1024) // 1MB

class MDC_LOG_SOFTWARE_COMPRESS_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
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
            snprintf_s(msg, MSG_LENGTH, MSG_LENGTH - 1, "[MDC_LOG_SOFTWARE_COMPRESS_FUNC_UTEST][Log] test for compress log file, index = %d", i);
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
        sprintf(resultFile, "%s/MDC_LOG_SOFTWARE_COMPRESS_FUNC_UTEST_cmd_result.txt", PATH_ROOT);

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

// 软件压缩
TEST_F(MDC_LOG_SOFTWARE_COMPRESS_EXCP_UTEST, LogCompressFileInvalidInput)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();

    // 压缩文件
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(NULL));
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("file is invalid."));

    // 释放
    DlogDestructor();
}

TEST_F(MDC_LOG_SOFTWARE_COMPRESS_EXCP_UTEST, LogCompressFileOpenFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();

    // 压缩文件
    char path[PATH_MAX] = { 0 };
    snprintf_s(path, PATH_MAX, PATH_MAX - 1, "%s/test.log", PATH_ROOT);
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(path));
    EXPECT_EQ(0, GetErrLogNum());

    // 释放
    DlogDestructor();
}

TEST_F(MDC_LOG_SOFTWARE_COMPRESS_EXCP_UTEST, LogCompressFileGzopenFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();

    // 压缩文件
    MOCKER(gzopen).stubs().will(returnValue((gzFile)NULL));
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(FILE_PATH));
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("can't open"));

    // 释放
    DlogDestructor();
}

TEST_F(MDC_LOG_SOFTWARE_COMPRESS_EXCP_UTEST, LogCompressFileReadFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    system("> " FILE_PATH);
    MOCKER(ferror).stubs().will(returnValue(1));

    // 压缩文件
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(FILE_PATH));
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("fread failed"));

    // 释放
    system("rm " FILE_PATH);
}

TEST_F(MDC_LOG_SOFTWARE_COMPRESS_EXCP_UTEST, LogCompressFileGzcompressFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();

    // 压缩文件
    system("echo test1 > " PATH_ROOT);
    MOCKER(gzwrite).stubs().will(returnValue(NULL));
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(FILE_PATH));
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("gzwrite failed"));

    // 释放
    DlogDestructor();
}

TEST_F(MDC_LOG_SOFTWARE_COMPRESS_EXCP_UTEST, LogCompressFileMallocFailed)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();

    // 压缩文件
    MOCKER(LogMalloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, LogCompressFile(FILE_PATH));
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("malloc failed, strerr"));

    // 释放
    DlogDestructor();
}