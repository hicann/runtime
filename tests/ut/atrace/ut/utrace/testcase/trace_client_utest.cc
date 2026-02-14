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
#include "atrace_api.h"
#include "atrace_client_core.h"
#include "atrace_client_communication.h"
#include "trace_msg.h"
#include "trace_attr.h"
#include "securec.h"
#include "adcore_api.h"
#include "trace_recorder.h"
#include "mmpa_api.h"

class TraceClientUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(TraceRecorderGetFd).stubs().will(returnValue(TRACE_SUCCESS));
        MOCKER(TraceRecorderGetDirPath).stubs().will(returnValue((const TraceDirNode *)1));
        MOCKER(TraceRecorderWrite).stubs().will(returnValue(TRACE_SUCCESS));
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        EXPECT_EQ(TRACE_SUCCESS, AtraceClientInit());
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        AtraceClientExit();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

TEST_F(TraceClientUtest, TraceClient)
{
    int32_t devId = 0;
    auto ret = AtraceClientStart(devId);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    sleep(2);
    AtraceClientStop(devId);
}

TEST_F(TraceClientUtest, TraceClient_NotSupport)
{
    MOCKER(AtraceCheckSupported).stubs().will(returnValue(false));
    int32_t devId = 0;
    auto ret = AtraceReportStart(devId);
    EXPECT_EQ(TRACE_UNSUPPORTED, ret);

    sleep(2);
    AtraceReportStop(devId);
}

TEST_F(TraceClientUtest, TraceApiVersion_Support)
{
    MOCKER(AtraceCheckSupported).stubs().will(returnValue(true));
    int32_t devId = 0;
    auto ret = AtraceReportStart(devId);
    EXPECT_EQ(0, ret);

    sleep(2);
    AtraceReportStop(devId);
}

TEST_F(TraceClientUtest, TraceClient_InvalidDevice)
{
    int32_t devId = -1;
    auto ret = AtraceClientStart(devId);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    sleep(2);
    AtraceClientStop(devId);
}

TEST_F(TraceClientUtest, TraceClient_SetThreadNameFailed)
{
    MOCKER(mmSetCurrentThreadName).stubs().will(returnValue(TRACE_FAILURE));
    int32_t devId = 0;
    auto ret = AtraceClientStart(devId);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    sleep(2);
    AtraceClientStop(devId);
}

TEST_F(TraceClientUtest, TraceClient_RecvEeventMsg)
{
    int32_t devId = 0;
    auto ret = AtraceClientStart(devId);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    sleep(2);
    AtraceClientStop(devId);
}

TEST_F(TraceClientUtest, TraceClient_GetDirFailed)
{
    GlobalMockObject::verify();
    MOCKER(TraceRecorderGetDirPath).stubs().will(returnValue((const TraceDirNode *)0));
    int32_t devId = 0;
    auto ret = AtraceClientStart(devId);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    AtraceClientStop(devId);
}

TEST_F(TraceClientUtest, TraceClient_SendMsgFailed)
{
    GlobalMockObject::verify();
    MOCKER(AdxSendMsg).stubs().will(returnValue(TRACE_FAILURE));
    int32_t devId = 0;
    auto ret = AtraceClientStart(devId);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    AtraceClientStop(devId);
}

TEST_F(TraceClientUtest, TraceClient_GetFdFailed)
{
    GlobalMockObject::verify();
    MOCKER(TraceRecorderGetDirPath).stubs().will(returnValue((const TraceDirNode *)1));
    MOCKER(TraceRecorderGetFd).stubs().will(returnValue(TRACE_FAILURE));
    int32_t devId = 0;
    auto ret = AtraceClientStart(devId);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    AtraceClientStop(devId);
}

TEST_F(TraceClientUtest, TraceClient_WriteFailed)
{
    GlobalMockObject::verify();
    MOCKER(TraceRecorderGetDirPath).stubs().will(returnValue((const TraceDirNode *)0));
    MOCKER(TraceRecorderGetFd).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(TraceRecorderWrite).stubs().will(returnValue(TRACE_FAILURE));
    int32_t devId = 0;
    auto ret = AtraceClientStart(devId);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    AtraceClientStop(devId);
}

TEST_F(TraceClientUtest, TraceClient_SendEndFailed)
{
    GlobalMockObject::verify();
    MOCKER(AdxSendMsgAndNoResultByType).stubs().will(returnValue(-1));
    int32_t devId = 0;
    auto ret = AtraceClientSendEnd(devId);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceClientUtest, TraceClient_SendHelloFailed)
{
    GlobalMockObject::verify();
    MOCKER(AdxSendMsgAndGetResultByType).stubs().will(returnValue(-1));
    int32_t devId = 0;
    auto ret = AtraceClientStart(devId);
    EXPECT_EQ(TRACE_UNSUPPORTED, ret);
}

