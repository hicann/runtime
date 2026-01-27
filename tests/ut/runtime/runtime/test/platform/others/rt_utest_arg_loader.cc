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
#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "kernel.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "raw_device.hpp"
#undef private
#undef protected
#include "runtime.hpp"
#include "event.hpp"
#include "npu_driver.hpp"
#include "api.hpp"
#include "cmodel_driver.h"
#include "thread_local_container.hpp"
using namespace testing;
using namespace cce::runtime;

class ChipArgLoaderTest : public testing::Test
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
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(ChipArgLoaderTest, uma_arg_loader_init_of_chip_lhisi)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    UmaArgLoader argLdr(device);
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_LHISI);
    GlobalContainer::SetRtChipType(CHIP_LHISI);
    rtError_t err = argLdr.Init();
    EXPECT_EQ(RT_ERROR_NONE, err);

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->DeviceRelease(device);
}

TEST_F(ChipArgLoaderTest, uma_arg_loader_with_kernel_info_rollback)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();
    uint32_t supportPcieBar = 1;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(supportPcieBar))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    device = rtInstance->DeviceRetain(devId, 0);
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);

    MOCKER_CPP(&H2DCopyMgr::AllocDevMem, void* (H2DCopyMgr::*)(const bool)).stubs().will(returnValue((void *)NULL));

    for (uint32_t i = 0; i < 10; i++)
    {
        error = loader->LoadCpuKernelArgsEx(&argsInfo, (Stream *)device->PrimaryStream_(), &results[i]);
        EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
    }

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);

    delete loader;
    delete rawDrv;
    rtInstance->DeviceRelease(device);
}

TEST_F(ChipArgLoaderTest, uma_arg_loader_rollback)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;
    void * args[] = {NULL, NULL, NULL, NULL};
    rtSmDesc_t smDesc;
    ArgLoaderResult result;
    uint32_t info = RT_RUN_MODE_ONLINE;
    NpuDriver * rawDrv = new NpuDriver();

    uint32_t supportPcieBar = 1;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(supportPcieBar))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    device = rtInstance->DeviceRetain(devId, 0);
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    Stream *stream;
    stream = (Stream *)device->PrimaryStream_();
    stream->models_.clear();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);

    MOCKER_CPP(&H2DCopyMgr::AllocDevMem, void* (H2DCopyMgr::*)(const bool)).stubs().will(returnValue((void *)NULL));

    error = loader->Load(Program::MACH_AI_CORE, &argsInfo, &smDesc, stream, &result);
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    delete loader;
    delete rawDrv;
    rtInstance->DeviceRelease(device);
}