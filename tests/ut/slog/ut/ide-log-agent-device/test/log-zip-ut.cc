/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
extern "C" {
#include "log_common.h"
#include "log_config_api.h"
#include "securec.h"
#include "ide_log_device_stub.h"
#include "log_to_file.h"
#include <assert.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <malloc.h>
#include <fcntl.h>
#include <zlib.h>

extern int32_t GetFileOfSize(StSubLogFileList *pstSubInfo, const StLogDataBlock *pstLogData,
                             const char *pFileName, off_t *filesize);
extern bool IsPathValidbyLog(const char *ppath, size_t pathLen);
}

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "log_file_util.h"

#define LLT_SLOG_DIR "llt/abl/slog"

using namespace std;
using namespace testing;

class LOG_ZIP_TEST : public testing::Test {
    protected:
        static void SetupTestCase()
        {
            cout << "LOG_ZIP_TEST SetUP" <<endl;
        }
        static void TearDownTestCase()
        {
            cout << "LOG_ZIP_TEST TearDown" << endl;
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

TEST_F(LOG_ZIP_TEST, IsPathValidbyLog)
{
    const char path1[256] = "device-app-1023.log";
    const char path2[256] = "device-app-1023.log.gz";
    const char path3[256] = "device-app.log-1023.log.gz";
    const char path4[256] = "device-app.log.gz-1023.log.gz";
    const char path5[256] = "device-app.log.gz-1023";
    EXPECT_EQ(true, IsPathValidbyLog(path1, strlen(path1)));
    EXPECT_EQ(true, IsPathValidbyLog(path2, strlen(path2)));
    EXPECT_EQ(true, IsPathValidbyLog(path3, strlen(path3)));
    EXPECT_EQ(true, IsPathValidbyLog(path4, strlen(path4)));
    EXPECT_EQ(false, IsPathValidbyLog(path5, strlen(path5)));
}