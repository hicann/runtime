/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "self_log_stub.h"
#include "ascend_hal_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "log_recv.h"
#include "log_common.h"
#include "slogd_firmware_log.h"
#include "log_path_mgr.h"
using namespace std;
using namespace testing;

extern "C" {
void ScanFirmwareDir(const char *path);
}

class EP_SLOGD_FIRMWARE_LOG_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        log_release_buffer();
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    int DlogCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/EP_SLOGD_FUNC_STEST_cmd_result.txt", path);

        char cmdToFile[400] = {0};
        sprintf(cmdToFile, "%s > %s", cmd, resultFile);
        system(cmdToFile);

        char buf[100] = {0};
        FILE *fp = fopen(resultFile, "r");
        if (fp == NULL) {
            return 0;
        }
        int size = fread(buf, 1, 100, fp);
        fclose(fp);
        if (size == 0) {
            return 0;
        }
        return atoi(buf);
    }

    int DlogCheckDir(const char *path, const char *str)
    {
        if (access(path, F_OK) != 0) {
            return 0;
        }

        char cmd[200] = {0};
        sprintf(cmd, "ls %s | grep %s | wc -l", path, str);
        int ret = DlogCmdGetIntRet(PATH_ROOT, cmd);
        return ret;
    }
};

// 迁移小核日志到debug目录下
TEST_F(EP_SLOGD_FIRMWARE_LOG_FUNC_UTEST, MoveFirmwareDirToDirDebug)
{
    // 初始化
    system("mkdir -p " LOG_FILE_PATH "/device-0");
    system("touch " LOG_FILE_PATH "/device-0/device-0_20231106235702082.log");
    system("mkdir -p " LOG_FILE_PATH "/debug/device-0");
    system("touch " LOG_FILE_PATH "/debug/device-0/device-0_20231106235702083.log");
    EXPECT_EQ(1, DlogCheckDir(LOG_FILE_PATH, "device-0"));
    EXPECT_EQ(1, DlogCheckDir(LOG_FILE_PATH "/debug", "device-0"));

    // 迁移小核日志
    ScanFirmwareDir(LOG_FILE_PATH);

    // 校验
    EXPECT_EQ(0, DlogCheckDir(LOG_FILE_PATH, "device-0"));
    EXPECT_EQ(1, DlogCheckDir(LOG_FILE_PATH "/debug", "device-0"));
    EXPECT_EQ(2, DlogCheckDir(LOG_FILE_PATH "/debug/device-0", "device-0"));
    EXPECT_EQ(0, GetErrLogNum());
}

static void *malloc_stub(size_t size)
{
    return malloc(size);
}

TEST_F(EP_SLOGD_FIRMWARE_LOG_FUNC_UTEST, SlogdFirmwareLogFlushFailed)
{
    EXPECT_EQ(LOG_FAILURE, SlogdFirmwareLogFlush(NULL, 0, false));
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("firmware log flush args is NULL"));
    ResetErrLog();

    MOCKER(LogMalloc).stubs()
        .will(invoke(malloc_stub))
        .then(invoke(malloc_stub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdFirmwareLogResInit());
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("malloc failed, device_id=0"));
    SlogdFirmwareLogResExit();
    ResetErrLog();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs()
        .will(invoke(malloc_stub))
        .then(invoke(malloc_stub))
        .then(invoke(malloc_stub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdFirmwareLogResInit());
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("malloc failed, device_id=0"));
    SlogdFirmwareLogResExit();
    ResetErrLog();
    GlobalMockObject::verify();

    MOCKER(log_type_alloc_mem).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdFirmwareLogResInit());
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("get log buffer"));
    SlogdFirmwareLogResExit();
    ResetErrLog();
    GlobalMockObject::verify();

    MOCKER(LogGetRootPath).stubs().will(returnValue((char *)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdFirmwareLogResInit());
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("Root path is null"));
    SlogdFirmwareLogResExit();
    ResetErrLog();
    GlobalMockObject::verify();

    EXPECT_EQ(LOG_SUCCESS, SlogdFirmwareLogResInit());
    int32_t devId = 0;
    SlogdFirmwareLogReceive((void *)&devId);
    SlogdFirmwareLogResExit();
}

TEST_F(EP_SLOGD_FIRMWARE_LOG_FUNC_UTEST, SlogdFirmwareLogFailed)
{
    MOCKER(LogMalloc).stubs()
        .will(invoke(malloc_stub))
        .then(invoke(malloc_stub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdFirmwareLogInit(-1, false));
}