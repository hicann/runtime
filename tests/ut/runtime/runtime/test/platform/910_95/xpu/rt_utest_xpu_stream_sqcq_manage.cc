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
#define private public
#define protected public 
#include "stream_sqcq_manage_xpu.hpp"
#include "stream_xpu.hpp"
#include "xpu_driver.hpp"
#undef private
#undef protected
#include "xpu_device.hpp"

using namespace cce::runtime;
class XpuStreamSqCqManageTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "XpuStreamSqCqManageTest SetUP" << std::endl;

        std::cout << "XpuStreamSqCqManageTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "XpuStreamSqCqManageTest end" << std::endl;
    }

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(XpuStreamSqCqManageTest, should_be_success_when_allocXpuStreamSqCq)
{
    // 正常调用流程
    XpuDriver *driver = new XpuDriver();
    XpuDevice *device = new XpuDevice(1);
    device->driver_ = driver;
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;
    stream->sqId_ = 1;
    stream->cqId_ = 1;
    stream->device_ = device;
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;
    MOCKER_CPP(&XpuDriver::XpuDriverDeviceSqCqAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    
    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq).stubs().with(eq((uint32_t)1),eq((uint32_t)1)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStream::ReleaseStreamTaskRes).stubs();
    MOCKER(TprtDeviceClose).stubs().with(mockcpp::any()).will(returnValue((uint32_t)RT_ERROR_NONE));


    EXPECT_EQ(stmSqCqManage->AllocXpuStreamSqCq(stream), RT_ERROR_NONE);
    DELETE_O (stream);
    DELETE_O (driver);
    DELETE_O (device);
}

TEST_F(XpuStreamSqCqManageTest, allocXpuStreamSqCq_should_be_duplicate_when_streamIdToSqIdMap_found_streamId)
{
    // 正常调用流程
    XpuDriver *driver = new XpuDriver();
    XpuDevice *device = new XpuDevice(1);
    device->driver_ = driver;
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;
    stream->sqId_ = 1;
    stream->cqId_ = 1;
    stream->device_ = device;
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    stmSqCqManage->streamIdToSqIdMap_[1]=1;
    device->streamSqCqManage_ = stmSqCqManage;
    MOCKER_CPP(&XpuDriver::XpuDriverDeviceSqCqAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    
    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq).stubs().with(eq((uint32_t)1),eq((uint32_t)1)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStream::ReleaseStreamTaskRes).stubs();
    MOCKER(TprtDeviceClose).stubs().with(mockcpp::any()).will(returnValue((uint32_t)RT_ERROR_NONE));


    EXPECT_EQ(stmSqCqManage->AllocXpuStreamSqCq(stream), RT_ERROR_STREAM_DUPLICATE);
    DELETE_O (stream);
    DELETE_O (driver);
    DELETE_O (device);
}

TEST_F(XpuStreamSqCqManageTest, allocXpuStreamSqCq_should_be_duplicate_when_streamIdToCqIdMap_found_streamId)
{
    // 正常调用流程
    XpuDriver *driver = new XpuDriver();
    XpuDevice *device = new XpuDevice(1);
    device->driver_ = driver;
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;
    stream->sqId_ = 1;
    stream->cqId_ = 1;
    stream->device_ = device;
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    stmSqCqManage->streamIdToCqIdMap_[1]=1;
    device->streamSqCqManage_ = stmSqCqManage;
    MOCKER_CPP(&XpuDriver::XpuDriverDeviceSqCqAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    
    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq).stubs().with(eq((uint32_t)1),eq((uint32_t)1)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStream::ReleaseStreamTaskRes).stubs();
    MOCKER(TprtDeviceClose).stubs().with(mockcpp::any()).will(returnValue((uint32_t)RT_ERROR_NONE));


    EXPECT_EQ(stmSqCqManage->AllocXpuStreamSqCq(stream), RT_ERROR_STREAM_DUPLICATE);
    DELETE_O (stream);
    DELETE_O (driver);
    DELETE_O (device);
}
