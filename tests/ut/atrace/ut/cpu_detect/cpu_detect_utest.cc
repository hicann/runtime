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
#include "cpu_detect.h"
#include "cpu_detect_types.h"
#include "cpu_detect_core.h"
#include "mmpa_api.h"
#include "ascend_hal.h"
#include "slog.h"

extern "C" {
    extern pid_t g_pid;
    extern pid_t CpuDetectCreateProcess(uint32_t timeout);
}

class CpuDetectUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        system("mkdir -p " LLT_TEST_DIR );
        system("echo [DBG][CpuDetect][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        system("echo [DBG][CpuDetect][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("echo [DBG][CpuDetect][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("echo [DBG][CpuDetect][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

TEST_F(CpuDetectUtest, UtestCpuDetectStart)
{
    // CPUD_SUCCESS
    g_pid = 0;
    MOCKER(CpuDetectProcess).stubs().will(returnValue(0));
    CpudStatus ret = CpuDetectStart(1);
    EXPECT_EQ(ret, CPUD_SUCCESS);
    EXPECT_EQ(g_pid, 0);

    // CPUD_ERROR_BUSY
    g_pid = 10000;
    ret = CpuDetectStart(1);
    EXPECT_EQ(ret, CPUD_ERROR_BUSY);
    EXPECT_EQ(g_pid, 10000);

    // CPUD_ERROR_CREATE_PROCESS
    g_pid = 0;
    MOCKER(fork).stubs().will(returnValue(-1));
    ret = CpuDetectStart(1);
    EXPECT_EQ(ret, CPUD_ERROR_CREATE_PROCESS);
    EXPECT_EQ(g_pid, 0);
}

TEST_F(CpuDetectUtest, UtestCpuDetectStop)
{
    g_pid = 0;
    CpuDetectStop();

    MOCKER(kill).stubs().will(returnValue(0));

    g_pid = 10000;
    CpuDetectStop();
    EXPECT_EQ(g_pid, 10000);

    GlobalMockObject::verify();
    MOCKER(kill).stubs().will(returnValue(10));

    g_pid = 10000;
    CpuDetectStop();
    EXPECT_EQ(g_pid, 10000);
}

TEST_F(CpuDetectUtest, UtestCpuDetectStart_WaitPidFail)
{
    // CPUD_SUCCESS
    g_pid = 0;
    MOCKER(CpuDetectCreateProcess).stubs().will(returnValue(10));
    MOCKER(waitpid).stubs().will(returnValue(-1)).then(returnValue(0));
    CpudStatus ret = CpuDetectStart(1);
    EXPECT_EQ(ret, CPUD_FAILURE);
    EXPECT_EQ(g_pid, 0);
    ret = CpuDetectStart(1);
    EXPECT_EQ(ret, CPUD_SUCCESS);
    EXPECT_EQ(g_pid, 0);
}