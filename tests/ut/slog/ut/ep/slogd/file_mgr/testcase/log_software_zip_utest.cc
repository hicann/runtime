/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_software_zip.h"

#include <cstdio>
#include <cstring>
#include <string>
#include <unistd.h>
#include <zlib.h>

#include "gtest/gtest.h"
#include "log_compress.h"
#include "log_error_code.h"
#include "securec.h"
#include "self_log_stub.h"

class EP_SLOGD_SOFTWARE_ZIP_UTEST : public testing::Test {
protected:
    void SetUp() override
    {
        ResetErrLog();
        system("mkdir -p " PATH_ROOT "/software_zip");
    }

    void TearDown() override
    {
        system("rm -rf " PATH_ROOT "/software_zip");
        EXPECT_EQ(0, GetErrLogNum());
    }
};

TEST_F(EP_SLOGD_SOFTWARE_ZIP_UTEST, SoftwareCompressFileCreatesGzipAndRemovesSource)
{
    const char *srcFile = PATH_ROOT "/software_zip/source.log";
    const char *gzPath = PATH_ROOT "/software_zip/source.log.gz";
    const char *content = "software zip coverage\nsecond line\n";

    FILE *src = fopen(srcFile, "wb");
    ASSERT_NE(nullptr, src);
    ASSERT_EQ(strlen(content), fwrite(content, 1, strlen(content), src));
    ASSERT_EQ(0, fclose(src));

    EXPECT_EQ(LOG_SUCCESS, SoftwareCompressFile(srcFile));
    EXPECT_NE(0, access(srcFile, F_OK));
    EXPECT_EQ(0, access(gzPath, F_OK));

    gzFile gz = gzopen(gzPath, "rb");
    ASSERT_NE(nullptr, gz);
    char buf[128] = {0};
    int readLen = gzread(gz, buf, sizeof(buf) - 1U);
    EXPECT_GT(readLen, 0);
    EXPECT_EQ(Z_OK, gzclose(gz));
    EXPECT_STREQ(content, buf);
}

TEST_F(EP_SLOGD_SOFTWARE_ZIP_UTEST, SoftwareCompressFileRejectsInvalidInput)
{
    EXPECT_EQ(LOG_FAILURE, SoftwareCompressFile(nullptr));
    ResetErrLog();
    EXPECT_EQ(LOG_FAILURE, SoftwareCompressFile(""));
    ResetErrLog();
}
