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
#include "runtime/dev.h"
#include "runtime/mem.h"
#include "npu_driver.hpp"
#include "runtime.hpp"
#include "config.hpp"
#include "cmodel_driver.h"
#include "raw_device.hpp"
#include "thread_local_container.hpp"
#undef private

using namespace testing;
using namespace cce::runtime;

class NpuDriverTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetDevice(0);
        std::cout<<"Driver test start -- cloud"<<std::endl;
    }

    static void TearDownTestCase()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout<<"Driver test end -- cloud"<<std::endl;
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

TEST_F(NpuDriverTest, host_register)
{
    rtError_t error;
    int ptr = 10;
    void **devPtr;
    NpuDriver *rawDrv = new NpuDriver();

    MOCKER(halHostRegister)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER(halHostUnregisterEx)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    error = rawDrv->HostRegister(&ptr, 100 ,RT_HOST_REGISTER_MAPPED, devPtr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->HostUnregister(&ptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDrv->HostUnregister(&ptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}