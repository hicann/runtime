/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "event.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver.hpp"
#include "cmodel_driver.h"
using namespace testing;
using namespace cce::runtime;


class ChipDriverTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"Driver test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"Driver test start end"<<std::endl;

    }

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(ChipDriverTest, managed_mem_alloc)
{
    rtError_t error;
    NpuDriver drv;
    drv.runMode_ =  RT_RUN_MODE_OFFLINE;
    drv.chipType_ = CHIP_CLOUD;
    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(drvMbindHbm).stubs().will(returnValue(DRV_ERROR_NONE));

    void *dptr = nullptr;

    error = drv.ManagedMemAlloc(&dptr, 128, Driver::MANAGED_MEM_RW, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ChipDriverTest, Test_GetAvailEventNum)
{
    rtError_t error;
    NpuDriver npu;
    uint32_t count;
    error = npu.GetAvailEventNum(0, 0, &count);
    EXPECT_EQ(error, RT_ERROR_NONE);
    npu.chipType_ = CHIP_DAVID;
    error = npu.GetAvailEventNum(0, 0, &count);
    EXPECT_EQ(error, RT_ERROR_NONE);
}