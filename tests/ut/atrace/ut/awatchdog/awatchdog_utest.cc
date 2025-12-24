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
#include <thread>
#include <future>
#include <unistd.h>
#include <sys/syscall.h>
#include "awatchdog.h"
#include "adiag_list.h"
#include "adiag_utils.h"
#include "slog.h"
#include "../stub/slog_stub.h"
#include "ascend_hal.h"

extern "C" {
    void AwatchdogInit(void);
    void AwatchdogExit(void);
    void AwdMonitorInit(void);
    void AwdProcessUnInit(void);
    void AwdProcessInit(void);
    void AwdSubProcessInit(void);
}
class AwatchdogUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        Clear();
        system("mkdir -p " LLT_TEST_DIR );
        MOCKER(pthread_atfork).stubs().will(returnValue(0));
        AwatchdogInit();
    }
    void Clear()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
    }
    virtual void TearDown()
    {
        AwatchdogExit();
        GlobalMockObject::verify();
        Clear();
    }

    static void SetUpTestCase()
    {
        pthread_atfork(AwdProcessUnInit, AwdProcessInit, AwdSubProcessInit);
    }

    static void TearDownTestCase()
    {
    }
};

DEFINE_THREAD_WATCHDOG(threadHandle);

TEST_F(AwatchdogUtest, TestWatchDogCreate)
{
    MOCKER(AdiagListInsert).expects(once()).will(returnValue(ADIAG_SUCCESS));
    auto handle = AwdCreateThreadWatchdog(0, 0, NULL);
    EXPECT_NE(handle, AWD_INVALID_HANDLE);
    AwdDestroyThreadWatchdog(handle);
    free((void*)handle);
}

TEST_F(AwatchdogUtest, TestWatchDogCreateFailed)
{
    MOCKER(AdiagListInsert).expects(never()).will(returnValue(ADIAG_SUCCESS));
    MOCKER(AdiagMalloc).stubs().will(returnValue((void*)NULL));
    auto handle = AwdCreateThreadWatchdog(0, 0, NULL);
    EXPECT_EQ(handle, AWD_INVALID_HANDLE);
}

TEST_F(AwatchdogUtest, TestWatchDogCreateAddtoListFailed)
{
    MOCKER(AdiagListInsert).stubs().will(returnValue(ADIAG_FAILURE));
    auto handle = AwdCreateThreadWatchdog(0, 0, NULL);
    EXPECT_EQ(handle, AWD_INVALID_HANDLE);
}

TEST_F(AwatchdogUtest, TestWatchDogCreateBeforeFork)
{
    int status = fork();
    if (status == -1) {
        return;
    }
    if(status == 0) {
        MOCKER(AdiagListInsert).expects(once()).will(returnValue(ADIAG_SUCCESS));
        auto handle = AwdCreateThreadWatchdog(0, 0, NULL);
        EXPECT_NE(handle, AWD_INVALID_HANDLE);
        AwdDestroyThreadWatchdog(handle);
        free((void*)handle);
        exit(0);
    }
}

TEST_F(AwatchdogUtest, TestWatchDogCreateAfterFork)
{
    MOCKER(AdiagListInsert).expects(once()).will(returnValue(ADIAG_SUCCESS));
    auto handle = AwdCreateThreadWatchdog(0, 0, NULL);
    EXPECT_NE(handle, AWD_INVALID_HANDLE);
    AwdDestroyThreadWatchdog(handle);
    int status = fork();
    if (status == -1) {
        return;
    }
    if(status == 0) {
        exit(0);
    }
    AwdDestroyThreadWatchdog(handle);
    free((void*)handle);
}

TEST_F(AwatchdogUtest, TestDlopenFailed)
{
    EXPECT_CheckNoErrorLog();
    MOCKER(mmDlopen).stubs().will(returnValue((void*)NULL));
    MOCKER(AwdMonitorInit).expects(exactly(1)).will(ignoreReturnValue());
    AwatchdogExit();
    AwatchdogInit();
}

drvError_t drvGetPlatformInfoStub(uint32_t *info)
{
    *info = 0; // DEVICE_SIDE
    return DRV_ERROR_NONE;
}
TEST_F(AwatchdogUtest, TestDisable)
{
    EXPECT_CheckNoErrorLog();
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfoStub));
    MOCKER(AwdMonitorInit).expects(never()).will(ignoreReturnValue());
    AwatchdogExit();
    AwatchdogInit();
}

TEST_F(AwatchdogUtest, TestDlsymFailed)
{
    EXPECT_CheckNoErrorLog();
    MOCKER(mmDlsym).stubs().will(returnValue((void*)NULL));
    MOCKER(AwdMonitorInit).expects(exactly(1)).will(ignoreReturnValue());
    AwatchdogExit();
    AwatchdogInit();
}