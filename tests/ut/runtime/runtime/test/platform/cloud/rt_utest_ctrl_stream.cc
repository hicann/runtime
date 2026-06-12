/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <cstdlib>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "engine.hpp"
#include "event.hpp"
#include "ctrl_stream.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "hwts.hpp"
#undef private
#undef protected
#include "context.hpp"
#include "securec.h"
#include "api.hpp"
#include "npu_driver.hpp"
#include "raw_device.hpp"
#include "ctrl_res_pool.hpp"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

static uint16_t ind = 0;

class CtrlStreamTest : public testing::Test {
public:

protected:
    static void SetUpTestCase()
    {
        std::cout<<"stream test start"<<std::endl;
        GlobalMockObject::verify();
    }

    static void TearDownTestCase()
    {
        std::cout<<"stream test end"<<std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        ind = 0;
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }
};

TEST_F(CtrlStreamTest, SynchronizePolymorphismTest)
{
    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, nullptr);
    
    CtrlStream *ctrlStream = new (std::nothrow) CtrlStream(dev);
    ASSERT_NE(ctrlStream, nullptr);
    
    rtError_t error = ctrlStream->Setup();
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    Stream *streamBase = static_cast<Stream*>(ctrlStream);
    error = streamBase->Synchronize();
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    error = streamBase->Synchronize(true, 1000);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    delete ctrlStream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CtrlStreamTest, SynchronizeWithDefaultParamsTest)
{
    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, nullptr);
    
    CtrlStream ctrlStream(dev);
    rtError_t error = ctrlStream.Setup();
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    error = ctrlStream.Synchronize();
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    error = ctrlStream.Synchronize(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    error = ctrlStream.Synchronize(false, -1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CtrlStreamTest, SynchronizeGetHeadPosFromCtrlSqFailTest)
{
    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, nullptr);
    
    CtrlStream ctrlStream(dev);
    rtError_t error = ctrlStream.Setup();
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetCtrlSqHead)
        .expects(once())
        .will(returnValue(3));
    
    error = ctrlStream.Synchronize();
    EXPECT_NE(error, RT_ERROR_NONE);
    
    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CtrlStreamTest, SynchronizeWithRecycledTaskTest)
{
    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, nullptr);
    
    CtrlStream ctrlStream(dev);
    rtError_t error = ctrlStream.Setup();
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    ctrlStream.sqTailPos_ = 10;
    
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetCtrlSqHead)
        .expects(atLeast(1))
        .will(returnValue(RT_ERROR_NONE));
    
    error = ctrlStream.Synchronize();
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}