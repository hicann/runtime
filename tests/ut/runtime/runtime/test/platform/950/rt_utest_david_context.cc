/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "api_impl.hpp"
#include "aicpu_err_msg.hpp"
#include "thread_local_container.hpp"
#undef private
#undef protected
#include "rdma_task.h"
#include "device_sq_cq_pool.hpp"
#include "sq_addr_memory_pool.hpp"
#include "../../common/rt_utest_context_reset_helper.hpp"
#include "../../common/rt_utest_memory_transfer_driver.hpp"
using namespace testing;
using namespace cce::runtime;

class ContextTestDavid : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp() { rtSetDevice(0); }

    virtual void TearDown()
    {
        ut::ResetPrimaryDeviceIfActiveWithDeviceDown();
        GlobalMockObject::verify();
    }

public:
    Device* device_ = nullptr;
    Stream* stream_ = nullptr;
    Engine* engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
    static void* binHandle_;
    static char function_;
    static uint32_t binary_[32];
};

TEST_F(ContextTestDavid, CopyTilingTabToDevForDavid_ForNewBinaryLoadFlow_Test)
{
    GlobalMockObject::verify();
    int32_t devId;
    rtError_t error;
    Context* ctx;

    error = rtGetDevice(&devId);
    RawDevice* device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    device->Init();
    Stream* stream = new Stream(device, 0);
    RefObject<Context*>* refObject = NULL;
    refObject = (RefObject<Context*>*)((Runtime*)Runtime::Instance())->PrimaryContextRetain(devId);
    EXPECT_NE(refObject, nullptr);
    ctx = refObject->GetVal();
    EXPECT_NE(ctx, nullptr);

    PlainProgram prog;
    prog.SetIsNewBinaryLoadFlow(true);
    MOCKER_CPP(&Context::GetModule).expects(never());
    TilingTabl* memoryPtr = new TilingTabl[10];
    uint32_t tilingTabLen = 0U;
    void* devMem = nullptr;

    MOCKER_CPP(&Program::DavidBuildTilingTblForNewFlow).stubs().will(returnValue(1)).then(returnValue(RT_ERROR_NONE));
    error = prog.CopyTilingTabToDev(ctx, device, &devMem, &tilingTabLen);
    EXPECT_EQ(error, 1);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void**)&memoryPtr))
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = prog.CopyTilingTabToDev(ctx, device, &devMem, &tilingTabLen);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void**)&memoryPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().then(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = prog.CopyTilingTabToDev(ctx, device, &devMem, &tilingTabLen);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void**)&memoryPtr))
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = prog.CopyTilingTabToDev(ctx, device, &devMem, &tilingTabLen);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void**)memoryPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().then(returnValue(RT_ERROR_NONE));
    error = prog.CopyTilingTabToDev(ctx, device, &devMem, &tilingTabLen);
    EXPECT_NE(error, RT_ERROR_NONE);
    (void)((Runtime*)Runtime::Instance())->PrimaryContextRelease(devId);
    delete stream;
    delete device;
    delete[] memoryPtr;
    GlobalMockObject::verify();
}

TEST_F(ContextTestDavid, CopyTilingTabToDevForDavid_test)
{
    GlobalMockObject::verify();
    int32_t devId;
    rtError_t error;
    Context* ctx;

    error = rtGetDevice(&devId);
    RawDevice* device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    device->Init();
    Stream* stream = new Stream(device, 0);
    RefObject<Context*>* refObject = NULL;
    refObject = (RefObject<Context*>*)((Runtime*)Runtime::Instance())->PrimaryContextRetain(devId);
    EXPECT_NE(refObject, nullptr);
    ctx = refObject->GetVal();
    EXPECT_NE(ctx, nullptr);

    PlainProgram prog;
    TilingTabl* memoryPtr = new TilingTabl[10];
    Module module(device);
    MOCKER_CPP(&Context::GetModule).stubs().will(returnValue(static_cast<Module*>(nullptr))).then(returnValue(&module));
    error = prog.CopyTilingTabToDev(ctx, device, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_MODULE_NULL);

    MOCKER_CPP(&Program::BuildTilingTblForDavid).stubs().will(returnValue(1)).then(returnValue(RT_ERROR_NONE));
    error = prog.CopyTilingTabToDev(ctx, device, nullptr, nullptr);
    EXPECT_EQ(error, 1);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void**)&memoryPtr))
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = prog.CopyTilingTabToDev(ctx, device, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void**)&memoryPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().then(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = prog.CopyTilingTabToDev(ctx, device, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void**)&memoryPtr))
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = prog.CopyTilingTabToDev(ctx, device, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void**)memoryPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().then(returnValue(RT_ERROR_NONE));
    error = prog.CopyTilingTabToDev(ctx, device, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    (void)((Runtime*)Runtime::Instance())->PrimaryContextRelease(devId);
    delete stream;
    delete device;
    delete[] memoryPtr;
    GlobalMockObject::verify();
}

TEST_F(ContextTestDavid, CopyTilingTabToDev_WritesOutputsWithDavidLayout)
{
    Context* const ctx = Runtime::Instance()->CurrentContext();
    Device* const device = ctx->Device_();
    PlainProgram program;
    program.SetIsNewBinaryLoadFlow(true);
    MOCKER_CPP(&Context::GetModule).expects(never());
    TilingTablForDavid* hostTable = static_cast<TilingTablForDavid*>(malloc(sizeof(TilingTablForDavid)));
    ASSERT_NE(hostTable, nullptr);
    uint32_t kernelCount = 1U;
    ut::MemoryTransferTestDriver driver;
    void* output = nullptr;
    uint32_t outputCount = 0U;

    MOCKER_CPP(&Program::DavidBuildTilingTblForNewFlow)
        .expects(once())
        .with(outBoundP(&hostTable), outBoundP(&kernelCount))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device, &Device::Driver_).stubs().will(returnValue(static_cast<Driver*>(&driver)));

    EXPECT_EQ(program.CopyTilingTabToDev(ctx, device, &output, &outputCount), RT_ERROR_NONE);
    EXPECT_EQ(output, driver.storage);
    EXPECT_EQ(outputCount, kernelCount);
    EXPECT_FALSE(driver.phyContinuous);
    EXPECT_EQ(driver.allocationCalls, 1U);
    EXPECT_EQ(driver.allocationDeviceId, device->Id_());
    EXPECT_EQ(driver.allocationSize, sizeof(TilingTablForDavid));
    EXPECT_EQ(driver.copyCalls, 1U);
    EXPECT_EQ(driver.copySize, sizeof(TilingTablForDavid));
    EXPECT_EQ(driver.copyDestMax, sizeof(TilingTablForDavid));
    EXPECT_EQ(driver.copyKind, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(driver.freeCalls, 0U);
    GlobalMockObject::verify();
}

TEST_F(ContextTestDavid, CopyTilingTabToDev_FailuresPreserveOutputsAndReleaseAllocation)
{
    Context* const ctx = Runtime::Instance()->CurrentContext();
    Device* const device = ctx->Device_();
    for (uint32_t scenario = 0U; scenario < 3U; ++scenario) {
        PlainProgram program;
        program.SetIsNewBinaryLoadFlow(true);
        MOCKER_CPP(&Context::GetModule).expects(never());
        ut::MemoryTransferTestDriver driver;
        driver.allocationResult = scenario < 2U ? RT_ERROR_MEMORY_ALLOCATION : RT_ERROR_NONE;
        driver.allocateOnFailure = scenario == 1U;
        driver.copyResult = RT_ERROR_INVALID_VALUE;
        TilingTablForDavid* hostTable = static_cast<TilingTablForDavid*>(malloc(sizeof(TilingTablForDavid)));
        ASSERT_NE(hostTable, nullptr);
        uint32_t kernelCount = 1U;
        void* output = driver.storage + 64U;
        void* const original = output;
        uint32_t outputCount = 7U;
        MOCKER_CPP_VIRTUAL(device, &Device::Driver_).stubs().will(returnValue(static_cast<Driver*>(&driver)));
        MOCKER_CPP(&Program::DavidBuildTilingTblForNewFlow)
            .expects(once())
            .with(outBoundP(&hostTable), outBoundP(&kernelCount))
            .will(returnValue(RT_ERROR_NONE));
        EXPECT_EQ(
            program.CopyTilingTabToDev(ctx, device, &output, &outputCount),
            scenario < 2U ? RT_ERROR_MEMORY_ALLOCATION : RT_ERROR_INVALID_VALUE);
        EXPECT_EQ(output, original);
        EXPECT_EQ(outputCount, 7U);
        EXPECT_EQ(driver.allocationCalls, 1U);
        EXPECT_EQ(driver.copyCalls, scenario == 2U ? 1U : 0U);
        EXPECT_EQ(driver.freeCalls, scenario == 0U ? 0U : 1U);
        if (scenario != 0U) {
            EXPECT_EQ(driver.freedPointer, driver.storage);
            EXPECT_EQ(driver.freeDeviceId, device->Id_());
        }
        GlobalMockObject::verify();
    }
}
