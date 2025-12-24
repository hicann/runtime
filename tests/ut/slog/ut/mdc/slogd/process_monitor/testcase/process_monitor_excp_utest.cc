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

#include "log_pm_sr.h"
#include "self_log_stub.h"

using namespace std;
using namespace testing;

extern "C"
{
extern int32_t ioctl(int32_t fd, uint32_t cmd, int32_t f);
extern void SlogSysStateHandler(int32_t state);
}

class MDC_PROCESS_MONITOR_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("> " AOS_PM_STATUS_FILE);
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
    }

    static void DlogDestructor()
    {
    }
};

static int32_t DlogAosWakeUp(void)
{
    SlogSysStateHandler(WORKING);
    return EAGAIN;
}
// aos唤醒，订阅失败
TEST_F(MDC_PROCESS_MONITOR_EXCP_UTEST, RegisterAosWakeUpFailed)
{
    // 初始化
    DlogConstructor();
    SlogSysStateHandler(SLEEP);

    MOCKER(ioctl).stubs().will(returnValue(-1));
    SlogdSubscribeToWakeUpState();
    EXPECT_EQ(SLEEP, GetSystemState());
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_LE(1, CheckErrLog("pass the efd failed"));
    // 释放
    DlogDestructor();
}

// aos唤醒
TEST_F(MDC_PROCESS_MONITOR_EXCP_UTEST, ReadAosWakeUpFailed)
{
    // 初始化
    DlogConstructor();
    SlogSysStateHandler(SLEEP);

    MOCKER(ioctl).stubs().will(returnValue(0));
    MOCKER(ToolGetErrorCode).stubs().will(returnValue(EINTR)).then(returnValue(EBUSY));
    SlogdSubscribeToWakeUpState();
    EXPECT_EQ(SLEEP, GetSystemState());
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_LE(1, CheckErrLog("cannot read from eventfd"));
    // 释放
    DlogDestructor();
}