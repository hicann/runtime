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

#include "log_time.h"
#include "self_log_stub.h"
#include "log_time_stub.h"

using namespace std;
using namespace testing;

class MDC_LOG_TIME_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("> " BOOTARGS_FILE_PATH);
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
    }

    static void DlogDestructor()
    {
    }

    void DlogCreateCmdFile(int32_t clockId)
    {
        FILE *fp = fopen(BOOTARGS_FILE_PATH, "w");
        uint32_t length = 1024;
        char msg[length];
        snprintf_s(msg, length, length - 1, "[MDC_LOG_TIME_FUNC_UTEST][Log] test for dpclk=%d", clockId);
        fwrite(msg, length, 1, fp);
        fclose(fp);
    }
};

// dpclk=100
TEST_F(MDC_LOG_TIME_FUNC_UTEST, LogTimeDpclk100)
{
    // 初始化
    DlogConstructor();
    // 构造bootargs为100
    DlogCreateCmdFile(100);
    struct timespec currentTimeval = { 0, 0 };
    bool isTimeInit = false;
    clockid_t clockId = 1;
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_stub));
    // 获取时间
    EXPECT_EQ(LOG_SUCCESS, LogGetTime(&currentTimeval, &isTimeInit, &clockId));
    EXPECT_EQ(true, isTimeInit);
    EXPECT_EQ(0, currentTimeval.tv_sec);
    EXPECT_EQ(0, currentTimeval.tv_nsec);

    // 释放
    DlogDestructor();
}

// dpclk=0
TEST_F(MDC_LOG_TIME_FUNC_UTEST, LogTimeDpclk0)
{
    // 初始化
    DlogConstructor();
    // 构造bootargs为0
    DlogCreateCmdFile(0);
    struct timespec currentTimeval = { 0, 0 };
    bool isTimeInit = false;
    clockid_t clockId = 1;
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_stub));
    // 获取时间
    EXPECT_EQ(LOG_SUCCESS, LogGetTime(&currentTimeval, &isTimeInit, &clockId));
    EXPECT_EQ(true, isTimeInit);
    EXPECT_EQ(100, currentTimeval.tv_sec);
    EXPECT_EQ(100, currentTimeval.tv_nsec);

    // 释放
    DlogDestructor();
}

// dpclk=1
TEST_F(MDC_LOG_TIME_FUNC_UTEST, LogTimeDpclkNull)
{
    // 初始化
    DlogConstructor();
    // 构造bootargs为1
    DlogCreateCmdFile(1);
    struct timespec currentTimeval = { 0, 0 };
    bool isTimeInit = false;
    clockid_t clockId = 1;
    MOCKER(clock_gettime).stubs().will(invoke(clock_gettime_stub));
    // 获取时间
    EXPECT_EQ(LOG_SUCCESS, LogGetTime(&currentTimeval, &isTimeInit, &clockId));
    EXPECT_EQ(true, isTimeInit);
    EXPECT_EQ(100, currentTimeval.tv_sec);
    EXPECT_EQ(100, currentTimeval.tv_nsec);
    // 释放
    DlogDestructor();
}