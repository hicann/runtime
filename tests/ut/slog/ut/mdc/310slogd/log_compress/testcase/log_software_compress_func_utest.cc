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

class MDC_LOG_SOFTWARE_COMPRESS_FUNC_UTEST : public testing::Test
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
TEST_F(MDC_LOG_SOFTWARE_COMPRESS_FUNC_UTEST, SoftwareCompressFile)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();

    // 压缩文件
    EXPECT_EQ(LOG_SUCCESS, LogCompressFile(FILE_PATH));

    // 释放
    DlogDestructor();
}

static int32_t CheckCompressResult(const char *file, const char *msg)
{
    char cmd[1024] = { 0 };
    char resultFile[1024] = { 0 };
    snprintf_s(resultFile, 1024, 1023, "%s/collectResult.txt", PATH_ROOT);
    snprintf_s(cmd, 1024, 1023, "zcat %s | grep -a \"%s\" | wc -l > %s", file, msg, resultFile);
    SELF_LOG_INFO("%s", cmd);
    system(cmd);

    char buf[MSG_LENGTH] = {0};
    FILE *fp = fopen(resultFile, "r");
    if (fp == NULL) {
        return 0;
    }
    int size = fread(buf, 1, MSG_LENGTH, fp);
    fclose(fp);
    if (size == 0) {
        return 0;
    } else {
        return atoi(buf);
    }
}

// 软件压缩
TEST_F(MDC_LOG_SOFTWARE_COMPRESS_FUNC_UTEST, SoftwareCompressFileWithGZIP_BUFLEN)
{
    // 初始化
    // 构造日志文件（非压缩）
    DlogConstructor();

    // 压缩文件
    system("mkdir -p " FILE_DIR);
    char file[256] = { 0 };
    snprintf_s(file, 256, 255, "cp %s/compress_log_test.log %s", FILE_STUB_DIR, FILE_DIR);
    system(file);
    memset_s(file, 256, 0, 256);
    snprintf_s(file, 256, 255, "%s/compress_log_test.log", FILE_DIR);
    EXPECT_EQ(LOG_SUCCESS, LogCompressFile(file));
    strncat_s(file, 256, ".gz", strlen(".gz"));
    EXPECT_EQ(SYS_OK, ToolAccess(file));

    // 校验压缩结果
    memset_s(file, 256, 0, 256);
    snprintf_s(file, 256, 255, "gzip -d %s/compress_log_test.log.gz", FILE_DIR);
    system(file);
    memset_s(file, 256, 0, 256);
    snprintf_s(file, 256, 255, "diff %s/compress_log_test.log %s/compress_log_test.log > %s/diff.txt",
        FILE_STUB_DIR, FILE_DIR, FILE_DIR);
    system(file);
    memset_s(file, 256, 0, 256);
    snprintf_s(file, 256, 255, "%s/diff.txt", FILE_DIR);
    FILE *fp = fopen(file, "r");
    ASSERT_NE((FILE *)NULL, fp);
    int32_t len = fread(fp, 1, 1024, fp);
    fclose(fp);
    EXPECT_EQ(0, len);

    // 释放
    DlogDestructor();
}

TEST_F(MDC_LOG_SOFTWARE_COMPRESS_FUNC_UTEST, SoftwareCompress)
{
    // 初始化
    DlogConstructor();
    SlogdCompressInit();
    EXPECT_EQ(true, SlogdCompressIsValid());
    EXPECT_EQ(LOG_SUCCESS, LogCompressFile(FILE_PATH));
    EXPECT_EQ(LOG_SUCCESS, SlogdCompress(nullptr, 0, nullptr, nullptr));
    SlogdCompressExit();
    // 释放
    DlogDestructor();
}