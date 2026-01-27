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
#include "utils.h"
#include "xpu_context.hpp"
#define private public
#define protected public
#include "kernel.hpp"
#include "program.hpp"
#include "arg_loader_xpu.hpp"
#undef private
#undef protected
#include "raw_device.hpp"
#include "xpu_stub.h"
#include "runtime.hpp"
#include "api.hpp"
#include "tprt.hpp"
using namespace testing;
using namespace cce::runtime;
class XpuArgLoaderTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(XpuArgLoaderTest, xpu_arg_loader_test_01)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    XpuDevice *device;
    device = static_cast<XpuDevice*>(((Runtime *)Runtime::Instance())->XpuDeviceRetain(0));
    const uint32_t size = 100;
    ArgLoaderResult result = {nullptr, nullptr, nullptr};
    result.kerArgs = nullptr;
    result.handle = nullptr;
    rtError_t error = device->xpuArgLoader_->AllocCopyPtr(size, &result);
    EXPECT_EQ(error, RT_ERROR_NONE);
    void *argHandle1 = nullptr;
    error = device->xpuArgLoader_->Release(argHandle1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = device->xpuArgLoader_->Release(result.handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime::Instance()->XpuDeviceRelease(device);
}

TEST_F(XpuArgLoaderTest, xpu_arg_loader_test_fail_01)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    XpuDevice *device;
    device = static_cast<XpuDevice*>(((Runtime *)Runtime::Instance())->XpuDeviceRetain(0));
    const uint32_t size = 5000;
    ArgLoaderResult result = {nullptr, nullptr, nullptr};
    result.kerArgs = nullptr;
    result.handle = nullptr;
    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
    rtError_t error = device->xpuArgLoader_->AllocCopyPtr(size, &result);
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
    void *argHandle1 = nullptr;
    error = device->xpuArgLoader_->Release(argHandle1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = device->xpuArgLoader_->Release(result.handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime::Instance()->XpuDeviceRelease(device);
}
