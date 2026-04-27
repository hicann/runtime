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
#include "runtime/rt.h"
#include "device.hpp"
#include "raw_device.hpp"
#include "stream.hpp"
#include "runtime.hpp"
#include "npu_driver.hpp"
#include "context.hpp"
#include "api_error.hpp"
#include "api_impl.hpp"
#include "rt_unwrap.h"

using namespace cce::runtime;
class ApiTest : public testing::Test {
public:
protected:
    static void SetUpTestCase()
    {
        (void)rtSetDevice(0);
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(ApiTest, SetOpWaitTimeOut_test)
{
    Device *device = ((Runtime *)Runtime::Instance())->GetDevice(0, 0);
    rtError_t ret = rtSetOpWaitTimeOut(10);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTest, notify_wait_timeout)
{
    rtError_t error;
    rtStream_t streamA;
    uint64_t buff_size = 100;
 
    error = rtStreamCreate(&streamA, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtNotify_t notify;
    
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    
    device->SetTschVersion(TS_VERSION_WAIT_TIMEOUT_DC);
    error = rtSetOpWaitTimeOut(3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtNotifyCreate(0, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtNotifyWait(notify, streamA);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamSynchronize(streamA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->SetTschVersion(version);
    error = rtStreamDestroy(streamA);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiTest, GROUP_INFO_1)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    Device* dev = rtInstance->GetDevice(0, 0);
    dev->GroupInfoSetup();

    error = rtSetGroup(0);
    EXPECT_EQ(error, ACL_ERROR_RT_GROUP_NOT_CREATE);
                
    error = rtSetGroup(2);
    EXPECT_EQ(error, ACL_ERROR_RT_GROUP_NOT_CREATE);

    error = rtSetGroup(1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t count = 0;
    error = rtGetGroupCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);
                                                     
    rtGroupInfo_t groupInfo[count];
    error = rtGetGroupInfo(-1, groupInfo, count);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetGroupInfo(3, groupInfo, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetGroupInfo(-10, groupInfo, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_GROUP_NOT_CREATE);
}

TEST_F(ApiTest, GROUP_INF)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device* dev = rtInstance->GetDevice(0, 0);

    error = rtSetGroup(1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t count = 0;
    error = rtGetGroupCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtGroupInfo_t groupInfo[count];
    error = rtGetGroupInfo(-1, groupInfo, count);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest, StreamRecoverNotSupport)
{
    ApiImpl api;
    ApiErrorDecorator apiErrorDec(&api);
    rtStream_t stream;
    Stream * stream_ = nullptr;
    rtError_t error = RT_ERROR_NONE;
    
    error = rtStreamCreate(&stream, 0);
    stream_ = rt_ut::UnwrapOrNull<Stream>(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiErrorDec.StreamRecover(stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtStreamDestroy(stream);
}
