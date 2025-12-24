/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
extern "C"
{
    #include "log_recv.h"
    #include "log_recv_interface.h"
    #include "log_common.h"
    #include "ascend_hal.h"
    #include "log_queue.h"
    #include <unistd.h>
    #include <sys/time.h>
    #include "log_daemon_ut_stub.h"
    #include "log_config_api.h"
    #include "log_daemon.h"
    #include "bbox_dev_register.h"
    #include "slogd_buffer.h"

    enum SystemState {
        OFF = 0,
        WORKING,
        SLEEP,
        UPGRADE,
        CALIBRATION
    };
    bool IsHostDrvReady(void);
    enum SystemState GetSystemState(void);
};

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "log_pm_sig.h"

using namespace std;
using namespace testing;

class HDC_LOG_RECV_UTEST : public testing::Test
{
    protected:
        static void SetupTestCase()
        {
            cout << "HDC_LOG_RECV_UTEST SetUP" <<endl;
        }
        static void TearDownTestCase()
        {
            cout << "HDCLOG_HOST_TEST TearDown" << endl;
        }
        virtual void SetUp()
        {
            cout << "a test SetUP" << endl;
        }
        virtual void TearDown()
        {
            cout << "a test TearDown" << endl;
        }
};

TEST_F(HDC_LOG_RECV_UTEST, LogQueueEnqueue_ARGV_NULL)
{
    EXPECT_EQ(ARGV_NULL, LogQueueEnqueue(NULL, NULL));
    GlobalMockObject::reset();
}

TEST_F(HDC_LOG_RECV_UTEST, LogQueueEnqueue_Failed)
{
    LogQueue queue;
    LogNode node;

    MOCKER(LogQueueEnqueue)
        .stubs()
        .will(returnValue(1));

    EXPECT_EQ(1, LogQueueEnqueue(&queue, &node));
    GlobalMockObject::reset();
}

TEST_F(HDC_LOG_RECV_UTEST, LogQueueEnqueue_SUCCESS)
{
    LogQueue queue;
    LogNode node;

    MOCKER(LogQueueEnqueue)
        .stubs()
        .will(returnValue(SUCCESS));

    EXPECT_EQ(SUCCESS, LogQueueEnqueue(&queue, &node));
    GlobalMockObject::reset();
}

TEST_F(HDC_LOG_RECV_UTEST, TimerEnoughSuccess)
{
    struct timespec lastTv = { 0, 0 };
    EXPECT_EQ(true, TimerEnough(&lastTv));
    sleep(2);
    EXPECT_EQ(true, TimerEnough(&lastTv));
    EXPECT_EQ(false, TimerEnough(&lastTv));
    GlobalMockObject::reset();
}