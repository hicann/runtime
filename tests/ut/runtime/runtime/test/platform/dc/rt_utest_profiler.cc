/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#define private public

#include "driver/ascend_hal.h"
#include "event.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver.hpp"
#include "api_impl.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "profiler_struct.hpp"
#include "runtime/dev.h"
#include "runtime/mem.h"
#include "runtime.hpp"
#include "config.hpp"
#include "cmodel_driver.h"
#include "raw_device.hpp"
#include "thread_local_container.hpp"
#undef private

using namespace testing;
using namespace cce::runtime;

class ProfilerTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetDevice(0);
        std::cout<<"Profiler test start -- dc"<<std::endl;
    }

    static void TearDownTestCase()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout<<"Profiler test start end -- dc"<<std::endl;
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

TEST_F(ProfilerTest, ReduceAsyncV2)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ReduceAsyncV2).stubs().will(returnValue(RT_ERROR_NONE));
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Profiler *profiler = rtInstance->profiler_;
    profiler->SetApiProfEnable(true);


    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_REDUCV2_SUPPORT_DC);

    auto error = profiler->apiProfileDecorator_->ReduceAsyncV2(NULL, NULL, 1, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, NULL, NULL);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    delete apiImpl_;
}