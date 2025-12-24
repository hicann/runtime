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
#include "trace_attr.h"
#include "trace_driver_api.h"
#include "ascend_hal.h"
#include <pwd.h>

class TraceAttrUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

extern "C" {
    uint32_t TraceAttrGetPlatform(void);
}
TEST_F(TraceAttrUtest, TraceAttrInit)
{
    setenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT", "null", 1);
    auto ret = TraceAttrInit();
    EXPECT_EQ(TRACE_SUCCESS, ret);

    EXPECT_EQ(PLATFORM_HOST_SIDE, TraceAttrGetPlatform());
    TraceAttrExit();
    unsetenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT");
}

TEST_F(TraceAttrUtest, TraceAttrGetPlatform)
{
    MOCKER(TraceDriverInit).stubs().will(returnValue(TRACE_FAILURE));
    auto ret = TraceAttrInit();
    EXPECT_EQ(TRACE_SUCCESS, ret);

    EXPECT_EQ(PLATFORM_INVALID_VALUE, TraceAttrGetPlatform());
    TraceAttrExit();
}

drvError_t drvGetPlatformInfoStub(uint32_t *info)
{
    *info = 0; // DEVICE_SIDE
    return DRV_ERROR_NONE;
}

TEST_F(TraceAttrUtest, TraceAttrGetPlatformHelperHost)
{
    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    auto ret = TraceAttrInit();
    EXPECT_EQ(TRACE_SUCCESS, ret);

    EXPECT_EQ(PLATFORM_INVALID_VALUE, TraceAttrGetPlatform());
    TraceAttrExit();
}

TEST_F(TraceAttrUtest, TraceAttrHelperDevice)
{
    MOCKER(drvGetPlatformInfo)
        .stubs()
        .will(invoke(drvGetPlatformInfoStub));
    auto ret = TraceAttrInit();
    EXPECT_EQ(TRACE_SUCCESS, ret);

    EXPECT_EQ(PLATFORM_DEVICE_SIDE, TraceAttrGetPlatform());
    TraceAttrExit();
}

TEST_F(TraceAttrUtest, TraceAttrGetuidFailed)
{
    MOCKER(getuid).stubs().will(returnValue(INT32_MAX));
    auto ret = TraceAttrInit();
    EXPECT_EQ(TRACE_FAILURE, ret);

    TraceAttrExit();
}

TEST_F(TraceAttrUtest, TestEnvTimeout)
{
    setenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT", "180000", 1);
    auto ret = TraceAttrInit();
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(180000, TraceGetTimeout());

    setenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT", "0", 1);
    ret = TraceAttrInit();
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(0, TraceGetTimeout());

    unsetenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT");
}

TEST_F(TraceAttrUtest, TestEnvTimeout_InvalidValue)
{
    setenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT", "180001", 1);
    auto ret = TraceAttrInit();
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(0, TraceGetTimeout());

    setenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT", "-1", 1);
    ret = TraceAttrInit();
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(0, TraceGetTimeout());

    unsetenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT");
}

TEST_F(TraceAttrUtest, TestGlobalAttr)
{
    TraceGlobalAttr attr = { 1, 32, 100 };
    EXPECT_EQ(TRACE_SUCCESS, TraceSetGlobalAttr(&attr));
    EXPECT_EQ(1, TraceAttrGetSaveMode());
    EXPECT_EQ(32, TraceAttrGetGlobalDevId());
    EXPECT_EQ(100, TraceAttrGetGlobalPid());
}