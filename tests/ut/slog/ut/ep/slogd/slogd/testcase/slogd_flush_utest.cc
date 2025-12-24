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

#include "slogd_flush.h"
#include "log_pm_sig.h"
#include "self_log_stub.h"
#include "slogd_stub.h"
#include "slogd_eventlog.h"
#include "slogd_syslog.h"

extern "C" {
extern ToolMutex g_confMutex;
extern SlogdStatus g_slogdStatus;
extern FlushMgr g_flushMgr;
extern LogStatus SlogdFlushCreateThread(void);
extern void SlogdFlushThreadExit(void);
extern void SlogdFlushFreeNode(void);
}

static int32_t g_flushProcess = 0;

class SLOGD_FLUSH_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        LogRecordSigNo(0);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        LogRecordSigNo(0);
        g_flushProcess = 0;
        g_confMutex = TOOL_MUTEX_INITIALIZER;
        g_slogdStatus = SLOGD_RUNNING;
        g_flushMgr = {0};
        GlobalMockObject::verify();
    }
};

static int32_t TestFlush(void *buffer, uint32_t bufferLen, bool flushFlag)
{
    g_flushProcess++;
    return LOG_SUCCESS;
}


TEST_F(SLOGD_FLUSH_UTEST, FlushDevice)
{
    LogFlushNode flushNode = {DEVICE_THREAD_TYPE, FIRMWARE_LOG_PRIORITY, TestFlush, NULL};
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushRegister(&flushNode));

    MOCKER(SlogdSyslogMgrInit).stubs().will(returnValue(LOG_SUCCESS));
    MOCKER(SlogdEventMgrInit).stubs().will(returnValue(LOG_SUCCESS));
    SlogdFlushInit();
    usleep(10 * 1000);
    LogRecordSigNo(15);
    SlogdFlushExit();
    EXPECT_NE(0, g_flushProcess);
}

TEST_F(SLOGD_FLUSH_UTEST, SlogdFlushRegisterError)
{
    EXPECT_EQ(LOG_FAILURE, SlogdFlushRegister(nullptr));
    LogFlushNode flushNode = {THREAD_TYPE_NUM, FIRMWARE_LOG_PRIORITY, NULL, NULL};
    EXPECT_EQ(LOG_FAILURE, SlogdFlushRegister(&flushNode));
    flushNode.flush = TestFlush;
    EXPECT_EQ(LOG_FAILURE, SlogdFlushRegister(&flushNode));
    flushNode.type = COMMON_THREAD_TYPE;
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushRegister(&flushNode));
    flushNode.type = DEVICE_THREAD_TYPE;
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushRegister(&flushNode));
}