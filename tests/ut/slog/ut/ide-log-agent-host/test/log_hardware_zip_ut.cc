/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_config_mgr.h"
extern "C" {
#include "log_compress/log_hardware_zip.h"
#include "log_common.h"
#include "log_config_api.h"
#include "log_to_file.h"
#include "log_types.h"
#include "log_daemon_ut_stub.h"
#include "securec.h"
#include <assert.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <malloc.h>
#include <fcntl.h>

#define LLT_SLOG_DIR        "llt/abl/slog"
#define ZIP_RATIO           2
#define BLOCK_SIZE          (1024 * 1024) // 1MB

int HardwareSrcDataCopy(const char *source, int *sourceLen, struct zip_stream *zipStream);
int HardwareZipProcess(struct zip_stream *zipStream, int flush, char *dest, int *destAvailLen);
}

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

using namespace std;
using namespace testing;

class LOG_HARDWAREZIP_TEST : public testing::Test {
protected:
    static void SetupTestCase()
    {
        cout << "LOG_HARDWAREZIP_TEST SetUP" << endl;
    }
    static void TearDownTestCase()
    {
        cout << "LOG_HARDWAREZIP_TEST TearDown" << endl;
    }
    virtual void SetUP()
    {
        cout << "a test SetUP" << endl;
    }
    virtual void TearDown()
    {
        cout << "a test TearDown" << endl;
    }
};

TEST_F(LOG_HARDWAREZIP_TEST, HardwareSrcDataCopy01)
{
    char *source;
    struct zip_stream zipStream;
    int sourceLength = BLOCK_SIZE + 10;
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    EXPECT_EQ(BLOCK_SIZE, HardwareSrcDataCopy(source, &sourceLength, &zipStream));
    sourceLength = BLOCK_SIZE - 10;
    EXPECT_EQ(BLOCK_SIZE - 10, HardwareSrcDataCopy(source, &sourceLength, &zipStream));
    GlobalMockObject::reset();
}