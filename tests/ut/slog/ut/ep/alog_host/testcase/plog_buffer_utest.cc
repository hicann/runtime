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

#include "self_log_stub.h"
#include "plog_buffer_mgr.h"

using namespace std;
using namespace testing;
class EP_PLOG_BUFFER_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("rm -rf " PATH_ROOT "/*");
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start exception test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End exception test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start exception test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End exception test suite");
    }

public:
};

static void *MallocStub(size_t len)
{
    void *buf = malloc(len);
    (void)memset_s(buf, len, 0, len);
    return buf;
}

TEST_F(EP_PLOG_BUFFER_UTEST, PlogBuffInit_failed)
{
    MOCKER(LogMalloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, PlogBuffInit());
    PlogBuffExit();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs().will(invoke(MallocStub)).then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, PlogBuffInit());
    PlogBuffExit();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, PlogBuffInit());
    PlogBuffExit();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, PlogBuffInit());
    PlogBuffExit();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, PlogBuffInit());
    PlogBuffExit();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, PlogBuffInit());
    PlogBuffExit();
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, PlogBuffInit());
    PlogBuffExit();
    GlobalMockObject::verify();
}