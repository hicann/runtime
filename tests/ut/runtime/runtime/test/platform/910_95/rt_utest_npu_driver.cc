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
#include "npu_driver.hpp"
#include "runtime/mem.h"
#include "runtime/dev.h"
#include "runtime.hpp"
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
        std::cout<<"Driver test start -- david"<<std::endl;
    }

    static void TearDownTestCase()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout<<"Driver test end -- david"<<std::endl;
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

    delete rawDrv;
}

TEST_F(NpuDriverTest, CreateAsyncDmaWqe2D_Test)
{
    NpuDriver* rawDrv = new NpuDriver();
    uint32_t devId = 0;
    AsyncDmaWqeInputInfo2D input = {};
    AsyncDmaWqeOutputInfo output = {};

    input.tsId = 0;
    input.sqId = 0;
    input.dst = (void*)0x1000;
    input.src = (void*)0x2000;
    input.dpitch = 1024;
    input.spitch = 1024;
    input.width = 64;
    input.height = 64;
    input.fixedSize = 4096;

    struct halAsyncDmaOutputPara wqeOutput = {};
    wqeOutput.dieId = 0;
    wqeOutput.functionId = 1;
    wqeOutput.jettyId = 2;
    wqeOutput.wqe = (uint8_t*)0x3000;
    wqeOutput.size = 128;
    wqeOutput.pi = 10;
    wqeOutput.fixedSize = 4096;

    MOCKER(halAsyncDmaCreate2D).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    rtError_t error = rawDrv->CreateAsyncDmaWqe2D(devId, input, &output);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(halAsyncDmaCreate2D)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBoundP(&wqeOutput, sizeof(struct halAsyncDmaOutputPara)))
        .will(returnValue(DRV_ERROR_NONE));

    error = rawDrv->CreateAsyncDmaWqe2D(devId, input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(output.dieId, 0U);
    EXPECT_EQ(output.functionId, 1U);
    EXPECT_EQ(output.jettyId, 2U);

    delete rawDrv;
}

TEST_F(NpuDriverTest, DestroyAsyncDmaWqe2D_Success)
{
    NpuDriver* rawDrv = new NpuDriver();
    uint32_t devId = 0;
    AsyncDmaWqeDestroyInfo2D destroyPara = {};

    destroyPara.tsId = 0;
    destroyPara.sqId = 0;
    destroyPara.ci = 5;

    MOCKER(halAsyncDmaDestroy2D).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT)).then(returnValue(DRV_ERROR_NONE));
    rtError_t error = rawDrv->DestroyAsyncDmaWqe2D(devId, &destroyPara);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv->DestroyAsyncDmaWqe2D(devId, &destroyPara);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(NpuDriverTest, CreateAsyncDmaWqeBatch_Success)
{
    NpuDriver* rawDrv = new NpuDriver();
    uint32_t devId = 0;
    AsyncDmaWqeInputInfoBatch input = {};
    AsyncDmaWqeOutputInfo output = {};

    input.tsId = 0;
    input.sqId = 0;
    void* dsts[2] = {(void*)0x1000, (void*)0x2000};
    void* srcs[2] = {(void*)0x3000, (void*)0x4000};
    uint64_t lens[2] = {64, 64};
    input.dst = dsts;
    input.src = srcs;
    input.len = lens;
    input.count = 2;
    input.fixedSize = 128;

    struct halAsyncDmaOutputPara wqeOutput = {};
    wqeOutput.dieId = 0;
    wqeOutput.functionId = 1;
    wqeOutput.jettyId = 2;
    wqeOutput.wqe = (uint8_t*)0x5000;
    wqeOutput.size = 256;
    wqeOutput.pi = 20;
    wqeOutput.fixedSize = 128;

    MOCKER(halAsyncDmaCreateBatch).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    rtError_t error = rawDrv->CreateAsyncDmaWqeBatch(devId, input, &output);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    MOCKER(halAsyncDmaCreateBatch)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBoundP(&wqeOutput, sizeof(struct halAsyncDmaOutputPara)))
        .will(returnValue(DRV_ERROR_NONE));

    rtError_t error = rawDrv->CreateAsyncDmaWqeBatch(devId, input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(output.dieId, 0U);
    EXPECT_EQ(output.functionId, 1U);
    EXPECT_EQ(output.jettyId, 2U);

    delete rawDrv;
}

TEST_F(NpuDriverTest, DestroyAsyncDmaWqeBatch_Success)
{
    NpuDriver* rawDrv = new NpuDriver();
    uint32_t devId = 0;
    AsyncDmaWqeDestroyInfoBatch destroyPara = {};

    destroyPara.tsId = 0;
    destroyPara.sqId = 0;
    destroyPara.ci = 10;

    MOCKER(halAsyncDmaDestroyBatch).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT)).then(returnValue(DRV_ERROR_NONE));
    rtError_t error = rawDrv->DestroyAsyncDmaWqeBatch(devId, &destroyPara);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rawDrv->DestroyAsyncDmaWqeBatch(devId, &destroyPara);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}