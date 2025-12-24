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
#include "npu_driver.hpp"
#undef private
#include "driver/ascend_hal.h"
#include "event.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver.hpp"
#include "cmodel_driver.h"
using namespace testing;
using namespace cce::runtime;


class DriverTest : public testing::Test
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

TEST_F(DriverTest, bitmap)
{
    Bitmap map(70);
    int id = -1;
    for (int i = 0; i < 70; i++)
    {
        id = map.AllocId();
        EXPECT_NE(id, -1);
    }
    id = map.AllocId();
    EXPECT_EQ(id, -1);

    uint32_t numOfRes = 15*1024;
    uint32_t curMaxNumOfRes = 11*1024;
    Bitmap map2(numOfRes);
    for (int i = 0; i < curMaxNumOfRes; i++) {
        id = map2.AllocId(curMaxNumOfRes);
        EXPECT_NE(id, -1);
    }

    for (int i =0; i < 1025; i++) {     // utilization: 11*1024 - 1025, available: 1025
        map2.FreeId(i);
    }

    id = map2.AllocId(curMaxNumOfRes);  // available: 1024
    EXPECT_NE(id, -1);

    id = map2.AllocId(curMaxNumOfRes);  // available: 1023
    EXPECT_NE(id, -1);

    id = map2.AllocId(curMaxNumOfRes);
    EXPECT_EQ(id, -1);
}

TEST_F(DriverTest, get_plat_info_succ)
{
    uint32_t info = 0;

    MOCKER(drvGetPlatformInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    NpuDriver * rawDrv = new NpuDriver();

    info = rawDrv->RtGetRunMode();
    EXPECT_EQ(info, RT_RUN_MODE_RESERVED);
    GlobalMockObject::verify();

    delete rawDrv;
}

TEST_F(DriverTest, get_plat_info_fail)
{
    uint32_t info = 0;

    MOCKER(drvGetPlatformInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    NpuDriver * rawDrv = new NpuDriver();

    info = rawDrv->RtGetRunMode();
    EXPECT_EQ(info, RT_RUN_MODE_RESERVED);
    delete rawDrv;
}


TEST_F(DriverTest, register_driver_fail)
{
    DriverFactory * rawDrv = new DriverFactory();
    bool ret = rawDrv->RegDriver(NPU_DRIVER, nullptr);
    EXPECT_EQ(ret, false);
    delete rawDrv;
}

TEST_F(DriverTest, get_sq_head)
{
    rtError_t error;
    NpuDriver drv;
    struct halSqCqQueryInfo queryInfoIn = {};
    uint16_t head;

    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = 0U;
    queryInfoIn.sqId = 1U;
    queryInfoIn.cqId = 1U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_HEAD;
    queryInfoIn.value[0] = 0xffff;

    MOCKER(halSqCqQuery)
        .stubs()
        .with(mockcpp::any(), outBoundP(&queryInfoIn, sizeof(queryInfoIn)))
        .will(returnValue(DRV_ERROR_NONE));

    error = drv.GetSqHead(0U, 0U, 1U, head);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(head, 0xffff);
}

TEST_F(DriverTest, get_sq_tail)
{
    rtError_t error;
    NpuDriver drv;
    struct halSqCqQueryInfo queryInfoIn = {};
    uint16_t tail;

    queryInfoIn.type = DRV_NORMAL_TYPE;
    queryInfoIn.tsId = 0U;
    queryInfoIn.sqId = 1U;
    queryInfoIn.cqId = 1U;
    queryInfoIn.prop = DRV_SQCQ_PROP_SQ_TAIL;
    queryInfoIn.value[0] = 0xffff;

    MOCKER(halSqCqQuery)
        .stubs()
        .with(mockcpp::any(), outBoundP(&queryInfoIn, sizeof(queryInfoIn)))
        .will(returnValue(DRV_ERROR_NONE));

    error = drv.GetSqTail(0U, 0U, 1U, tail);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(tail, 0xffff);

    drv.addrMode_ = 1;
    drv.sysMode_ = 1;
    drv.HostAddrRegister(nullptr, 0, 0);
    drv.HostAddrUnRegister(nullptr, 0);
}