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

#include "slogd_thread_mgr.h"
#include "ascend_hal.h"
#include "self_log_stub.h"

static ThreadManage g_threadManage;

class SLOGD_THREAD_MGR_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

};

static void *TestProcess(void *args)
{
    return (void *)NULL;
}

TEST_F(SLOGD_THREAD_MGR_UTEST, SlogdThreadMgrCreateDeviceThread)
{
    uint32_t devNum = 0;
    DevThread devThread[1] = {0};
    EXPECT_EQ(LOG_FAILURE, SlogdThreadMgrCreateDeviceThread(devThread, 1, &devNum, NULL));
    EXPECT_EQ(LOG_SUCCESS, SlogdThreadMgrCreateDeviceThread(devThread, 1, &devNum, TestProcess));
    MOCKER(halGetDevNumEx).stubs().will(returnValue(1));
    EXPECT_EQ(LOG_FAILURE, SlogdThreadMgrCreateDeviceThread(devThread, 1, &devNum, TestProcess));
}

TEST_F(SLOGD_THREAD_MGR_UTEST, SlogdThreadMgrCreateDeviceThreadGetDevIdFailed)
{
    uint32_t devNum = 0;
    DevThread devThread[1] = {0};
    EXPECT_EQ(LOG_FAILURE, SlogdThreadMgrCreateDeviceThread(devThread, 1, &devNum, NULL));
    EXPECT_EQ(LOG_SUCCESS, SlogdThreadMgrCreateDeviceThread(devThread, 1, &devNum, TestProcess));
    MOCKER(halGetDevIDsEx).stubs().will(returnValue(1));
    EXPECT_EQ(LOG_FAILURE, SlogdThreadMgrCreateDeviceThread(devThread, 1, &devNum, TestProcess));
}