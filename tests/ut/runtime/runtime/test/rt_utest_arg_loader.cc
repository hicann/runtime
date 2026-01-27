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

class ArgLoaderTest : public testing::Test
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

TEST_F(ArgLoaderTest, uma_arg_loader_test_310M)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    int64_t aiCpuCnt = 1;
     MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetDevInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&aiCpuCnt, sizeof(aiCpuCnt)))
        .will(returnValue(RT_ERROR_NONE));
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = rtInstance->GetSocType();
    rtInstance->SetSocType(SOC_AS31XM1X);
    UmaArgLoader *loader = new UmaArgLoader(device);
    error = loader->Init();
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);
    for (uint32_t i = 0; i < 10; i++) {
        error = loader->LoadCpuKernelArgs(&argsInfo, (Stream *)device->PrimaryStream_(), &results[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    for (uint32_t i = 0; i < 10; i++) {
        error = loader->Release(results[i].handle);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtInstance->SetSocType(socType);
}

TEST_F(ArgLoaderTest, uma_arg_loader)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);
    for (uint32_t i = 0; i < 10; i++)
    {
        error = loader->Load(NULL, &argsInfo, NULL, (Stream *)device->PrimaryStream_(), &results[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    for (uint32_t i = 0; i < 10; i++)
    {
        error = loader->Release(results[i].handle);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

rtError_t StubCheckSupportPcieBarCopy(Driver *that, const uint32_t deviceId, uint32_t &val, const bool need4KAsync)
{
    val = RT_CAPABILITY_SUPPORT;
    return RT_ERROR_NONE;
}

TEST_F(ArgLoaderTest, uma_arg_loader_mix_illegal_size)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;
    uint32_t supportPcieBar = 1;
    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .will(invoke(StubCheckSupportPcieBarCopy));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(RT_RUN_MODE_ONLINE)));

    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = 40900U;
    bool mixOpt = false;
    error = loader->LoadForMix(NULL, &argsInfo, NULL, (Stream *)device->PrimaryStream_(), &results, mixOpt);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    MOCKER_CPP(&H2DCopyMgr::AllocDevMem, void* (H2DCopyMgr::*)(const bool)).stubs().will(returnValue((void *)NULL));

    argsInfo.argsSize = 128U;
    error = loader->LoadForMix(NULL, &argsInfo, NULL, (Stream *)device->PrimaryStream_(), &results, mixOpt);
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);

    delete loader;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_init_of_chip_as31xm1x)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    UmaArgLoader argLdr(device);
    rtSocType_t preType = rtInstance->GetSocType();
    rtInstance->SetSocType(SOC_AS31XM1X);
    int32_t aicpuCnt = rtInstance->GetAicpuCnt();
    rtInstance->SetAicpuCnt(1);
    rtError_t err = argLdr.Init();
    EXPECT_EQ(RT_ERROR_NONE, err);
    void *soNameAddr = nullptr;
    argLdr.GetKernelInfoDevAddr("123", KernelInfoType::SO_NAME, &soNameAddr);
    argLdr.GetKernelInfoDevAddr("456", KernelInfoType::KERNEL_NAME, &soNameAddr);
    argLdr.RestoreAiCpuKernelInfo();
    rtInstance->SetSocType(preType);
    rtInstance->SetAicpuCnt(aicpuCnt);
    rtInstance->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_with_sm)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;
    void * args[] = {NULL, NULL, NULL, NULL};
    rtSmDesc_t smDesc;
    ArgLoaderResult result;
    ArgLoaderResult result2;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);
    error = loader->Load(NULL, &argsInfo, &smDesc, (Stream *)device->PrimaryStream_(), &result);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = loader->Load(NULL, &argsInfo, &smDesc, (Stream *)device->PrimaryStream_(), &result2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = loader->Release(result.handle);
	EXPECT_EQ(error, RT_ERROR_NONE);

    error = loader->Release(result2.handle);
	EXPECT_EQ(error, RT_ERROR_NONE);

    delete loader;
	((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_with_kernel_info)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);
    for (uint32_t i = 0; i < 10; i++)
    {
        error = loader->LoadCpuKernelArgs(&argsInfo, (Stream *)device->PrimaryStream_(), &results[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    for (uint32_t i = 0; i < 10; i++)
    {
        error = loader->Release(results[i].handle);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_with_kernel_info_Ex00)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);

    for (uint32_t i = 0; i < 10; i++)
    {
        error = loader->LoadCpuKernelArgsEx(&argsInfo, (Stream *)device->PrimaryStream_(), &results[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    for (uint32_t i = 0; i < 10; i++)
    {
        error = loader->Release(results[i].handle);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_with_kernel_info_Ex01)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = 6320;//sizeof(args);
    for (uint32_t i = 0; i < 1; i++)
    {
        error = loader->LoadCpuKernelArgsEx(&argsInfo, (Stream *)device->PrimaryStream_(), &results[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    for (uint32_t i = 0; i < 1; i++)
    {
        error = loader->Release(results[i].handle);
        //EXPECT_EQ(error, RT_ERROR_NONE);
    }

    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_with_kernel_info_Ex02)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = 45000;//sizeof(args);
    for (uint32_t i = 0; i < 1; i++)
    {
        error = loader->LoadCpuKernelArgsEx(&argsInfo, (Stream *)device->PrimaryStream_(), &results[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    for (uint32_t i = 0; i < 1; i++)
    {
        error = loader->Release(results[i].handle);
        //EXPECT_EQ(error, RT_ERROR_NONE);
    }

    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_with_kernel_info_Ex03)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtAicpuArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = 80000;//sizeof(args);
    for (uint32_t i = 0; i < 1; i++)
    {
        error = loader->LoadCpuKernelArgsEx(&argsInfo, (Stream *)device->PrimaryStream_(), &results[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    for (uint32_t i = 0; i < 1; i++)
    {
        error = loader->Release(results[i].handle);
        //EXPECT_EQ(error, RT_ERROR_NONE);
    }

    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

class ArgLoaderTest1 : public testing::Test
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

TEST_F(ArgLoaderTest, uma_arg_loader_with_kernel_info_super)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = 6320;//sizeof(args);
    for (uint32_t i = 0; i < 1; i++)
    {
        error = loader->LoadCpuKernelArgs(&argsInfo, (Stream *)device->PrimaryStream_(), &results[i]);        
    }

    for (uint32_t i = 0; i < 1; i++)
    {
        error = loader->Release(results[i].handle);
        //EXPECT_EQ(error, RT_ERROR_NONE);
    }

    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_with_kernel_info_super_fail)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult results[10];
    void *memBase = (void*)100;
    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
	
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));

    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = 6320;//sizeof(args);
    for (uint32_t i = 0; i < 1; i++)
    {
        memset(&results[i], 0, sizeof(results[i]));
        error = loader->LoadCpuKernelArgs(&argsInfo, (Stream *)device->PrimaryStream_(), &results[i]);
    }

    for (uint32_t i = 0; i < 1; i++)
    {
        error = loader->Release(results[i].handle);
        //EXPECT_EQ(error, RT_ERROR_NONE);
    }
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::PcieHostRegister)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::PcieHostUnRegister)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::PcieHostRegister)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));
    GlobalMockObject::verify();
    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_with_sm_fail)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;
    void * args[] = {NULL, NULL, NULL, NULL};
    rtSmDesc_t smDesc;
    ArgLoaderResult result;
    uint32_t info = RT_RUN_MODE_ONLINE;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    MOCKER(drvGetPlatformInfo).stubs().with(outBoundP(&info, sizeof(info))).will(returnValue(DRV_ERROR_NONE));
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);
    error = loader->Load(NULL, &argsInfo, &smDesc, (Stream *)device->PrimaryStream_(), &result);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();

    delete loader;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy)
{
    NpuDriver drv;

    RawDevice * device = new RawDevice(0);
    device->driver_ = &drv;
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::CheckSupportPcieBarCopy)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::DevMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostUnRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(device, 10U, 1U, 1U,
        BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemCopyAsyncWaitFinishEx)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));

    void *args = argAllocator->AllocDevMem();
    argAllocator->FreeDevMem(args);
    argAllocator->cpyInfoDmaMap_.cpyCount = 2;
    argAllocator->cpyInfoDmaMap_.cpyItemSize = 1;
    argAllocator->cpyInfoDmaMap_.device = argAllocator->device_;
    argAllocator->cpyInfoDmaMap_.mapLock = &argAllocator->mapLock_;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemConvertAddr)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));

    argAllocator->MallocBuffer(1, &(argAllocator->cpyInfoDmaMap_));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemDestroyAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    argAllocator->FreeBuffer((void *)1, &(argAllocator->cpyInfoDmaMap_));
    CpyHandle hdl;
    hdl.copyStatus = ASYNC_COPY_STATU_SUCC;
    int32_t ret = argAllocator->H2DMemCopyWaitFinish(&hdl);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete argAllocator;
    delete device;
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy_2)
{
    NpuDriver drv;

    RawDevice * device = new RawDevice(0);
    device->driver_ = &drv;
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::CheckSupportPcieBarCopy)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::DevMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostUnRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(device, 10U, 1U, 1U,
        BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemCopyAsyncWaitFinishEx)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));

    void *args = argAllocator->AllocDevMem();
    argAllocator->FreeDevMem(args);
    argAllocator->cpyInfoDmaMap_.cpyCount = 2;
    argAllocator->cpyInfoDmaMap_.cpyItemSize = 1;
    argAllocator->cpyInfoDmaMap_.device = argAllocator->device_;
    argAllocator->cpyInfoDmaMap_.mapLock = &argAllocator->mapLock_;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemConvertAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    argAllocator->MallocBuffer(1, &(argAllocator->cpyInfoDmaMap_));

    CpyAddrMgr cpyAddr;
    cpyAddr.isDma = false;
    int dst = 0;
    int src = 0;
    cpyAddr.hostAddr = (uint64_t)&src;
    argAllocator->cpyInfoDmaMap_.cpyDmaMap[(uint64_t)&dst] = cpyAddr;
    auto error = argAllocator->ArgsPoolConvertAddr();
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemDestroyAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    argAllocator->FreeBuffer((void *)1, &(argAllocator->cpyInfoDmaMap_));
    CpyHandle hdl;
    hdl.copyStatus = ASYNC_COPY_STATU_SUCC;
    int32_t ret = argAllocator->H2DMemCopyWaitFinish(&hdl);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete argAllocator;
    delete device;
}

drvError_t halMemCpyTest(struct DMA_ADDR *dmaAddr)
{
    return DRV_ERROR_NONE;
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy_err1)
{
    NpuDriver drv;

    RawDevice * device = new RawDevice(0);
    device->driver_ = &drv;
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    char memBase[2000];
    char memBase1[2000];
    void *mem = memBase;
    void *mem1 = memBase1;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&mem, sizeof(mem)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemAlloc)
        .stubs()
        .with(outBoundP(&mem1, sizeof(mem1)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemConvertAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemDestroyAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostUnRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    drv.runMode_ = RT_RUN_MODE_ONLINE;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    const bool flag = ((Runtime *)Runtime::Instance())->GetDisableThread();
    ((Runtime *)Runtime::Instance())->SetDisableThread(true);
    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(device, 2000U, 1U, 1U,
        BufferAllocator::LINEAR, COPY_POLICY_ASYNC_PCIE_DMA);

    void *args = argAllocator->AllocDevMem();
    argAllocator->FreeDevMem(args);

    struct DMA_ADDR dmaHandle;

    MOCKER(drvMemConvertAddr)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    dmaHandle.fixed_size = 0;
    int32_t ret = drv.MemConvertAddr(0, 1, 0, &dmaHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->SetDisableThread(flag);
    delete argAllocator;
    delete device;
}

#if 0
TEST_F(ArgLoaderTest, stub_arg_loader2)
{
    rtError_t error;
    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult result;
    uint32_t value = 0;
    StreamSwitchNLoadResult switchNResult;
    ArgLoaderResult results;
    rtStream_t trueStream[1];

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    g_launchArg.argCount = 1;

    ArgLoader *loader = new ArgLoader(device);
    loader->Init();
    rtArgsWithTiling_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);
    argsInfo.argsSizeWithoutTiling = sizeof(args);

    error = loader->LoadCpuKernelArgs(args, sizeof(args), (Stream *)device->PrimaryStream_(), &results);
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);


    delete loader;

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}
#endif

TEST_F(ArgLoaderTest, uma_arg_loader_with_memcpy_fail)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;
    void * args[] = {NULL, NULL, NULL, NULL};
    rtSmDesc_t smDesc;
    ArgLoaderResult result;
    uint32_t info = RT_RUN_MODE_ONLINE;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    Stream *stream;
    stream = (Stream *)device->PrimaryStream_();
    stream->models_.clear();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &args;
    argsInfo.argsSize = sizeof(args);
    error = loader->Load(Program::MACH_AI_CORE, &argsInfo, &smDesc, stream, &result);
    EXPECT_NE(error, RT_ERROR_SEC_HANDLE);

    delete loader;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_with_switchN)
{
    int32_t devId = -1;
    rtError_t error;
    Device *device;

    StreamSwitchNLoadResult result;
    int64_t value[2] = {1 , 2};
    rtStream_t streamA;
    rtStream_t streamB;
    void *memBase = (void*)100;

    error = rtStreamCreate(&streamA, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&streamB, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t trueStream[2];
    trueStream[0] = streamA;
    trueStream[1] = streamB;

    NpuDriver * rawDrv = new NpuDriver();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

   MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(RT_ERROR_NONE));

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device = ((Runtime *)Runtime::Instance())->DeviceRetain(devId, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();

    loader->LoadStreamSwitchNArgs((Stream *)device->PrimaryStream_(), &value, 2,
        (Stream **)&trueStream, 2, RT_SWITCH_INT32, &result);
    loader->LoadStreamSwitchNArgs((Stream *)device->PrimaryStream_(), &value, 2,
        (Stream **)&trueStream, 2, RT_SWITCH_INT64, &result);

    error = rtStreamDestroy(streamA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(streamB);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete loader;
    delete rawDrv;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy_err2)
{
    NpuDriver drv;

    RawDevice * device = new RawDevice(0);
    device->driver_ = &drv;
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    char memBase[2000];
    char memBase1[2000];
    void *mem = memBase;
    void *mem1 = memBase1;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&mem, sizeof(mem)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemAlloc)
        .stubs()
        .with(outBoundP(&mem1, sizeof(mem1)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemConvertAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemDestroyAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostUnRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemCopyAsyncWaitFinishEx)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    drv.runMode_ = RT_RUN_MODE_ONLINE;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    const bool flag = ((Runtime *)Runtime::Instance())->GetDisableThread();
    ((Runtime *)Runtime::Instance())->SetDisableThread(true);
    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(device, 2000U, 5U, 5U,
        BufferAllocator::LINEAR, COPY_POLICY_ASYNC_PCIE_DMA);

    argAllocator->cpyInfoDmaMap_.cpyCount = 1;
    argAllocator->cpyInfoDmaMap_.cpyItemSize = 2000U;
    argAllocator->cpyInfoDmaMap_.device = device;
    argAllocator->cpyInfoDmaMap_.mapLock = &argAllocator->mapLock_;
    argAllocator->policy_ = COPY_POLICY_ASYNC_PCIE_DMA;
    argAllocator->handleAllocator_ = new (std::nothrow) BufferAllocator(sizeof(CpyHandle), 5, 5);
    void *args = argAllocator->AllocDevMem();
    CpyHandle *hdl = (CpyHandle *)args;
    hdl->copyStatus = ASYNC_COPY_STATU_SUCC;
    hdl->isDmaPool = true;
    argAllocator->H2DMemCopyWaitFinish(args);
    argAllocator->FreeDevMem(args);

    argAllocator->MallocPcieBarBuffer(1, device);
    argAllocator->FreePcieBarBuffer((void *)1, device);

    struct DMA_ADDR dmaHandle;
    MOCKER(drvMemConvertAddr)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    dmaHandle.fixed_size = 0;
    int32_t ret = drv.MemConvertAddr(0, 1, 0, &dmaHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->SetDisableThread(flag);
    delete argAllocator;
    delete device;
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy_err6)
{
    NpuDriver drv;

    RawDevice * device = new RawDevice(0);
    device->driver_ = &drv;
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    char memBase[2000];
    char memBase1[2000];
    void *mem = memBase;
    void *mem1 = memBase1;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&mem, sizeof(mem)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemAlloc)
        .stubs()
        .with(outBoundP(&mem1, sizeof(mem1)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemConvertAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemDestroyAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(device, 2, 5U, 5U,
        BufferAllocator::LINEAR, COPY_POLICY_MAX);

    argAllocator->cpyInfoDmaMap_.cpyCount = 1;
    argAllocator->cpyInfoDmaMap_.cpyItemSize = 2;
    argAllocator->cpyInfoDmaMap_.device = device;
    argAllocator->cpyInfoDmaMap_.mapLock = nullptr;

    void *args = argAllocator->MallocBuffer(1, &argAllocator->cpyInfoDmaMap_);
    EXPECT_NE(args, nullptr);
    argAllocator->FreeBuffer(args, &argAllocator->cpyInfoDmaMap_);

    delete argAllocator;
    delete device;
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy_err8)
{
    NpuDriver drv;

    RawDevice * device = new RawDevice(0);
    device->driver_ = &drv;
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemCopyAsyncEx)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemDestroyAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    MOCKER(mmRWLockRDLock).stubs().will(returnValue(0));
    MOCKER(mmRDLockUnLock).stubs().will(returnValue(0));

    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(device, 2, 5U, 5U,
        BufferAllocator::LINEAR, COPY_POLICY_MAX);

    int dst = 0;
    int src = 0;
    argAllocator->policy_ = COPY_POLICY_PCIE_BAR;
    argAllocator->H2DMemCopy(&dst, &src, sizeof(int));
    argAllocator->policy_ = COPY_POLICY_ASYNC_PCIE_DMA;
    argAllocator->cpyInfoDmaMap_.cpyCount = 1;
    argAllocator->cpyInfoDmaMap_.cpyItemSize = 2;
    argAllocator->cpyInfoDmaMap_.device = device;
    CpyAddrMgr cpyAddr;
    cpyAddr.isDma = false;
    cpyAddr.hostAddr = (uint64_t)&src;
    argAllocator->cpyInfoDmaMap_.cpyDmaMap[(uint64_t)&dst] = cpyAddr;
    CpyHandle hdl;
    hdl.copyStatus = ASYNC_COPY_STATU_SUCC;
    hdl.devAddr = &dst;
    int32_t ret = argAllocator->H2DMemCopy(&hdl, &src, sizeof(int));
    EXPECT_EQ(ret, RT_ERROR_NONE);
    DELETE_O(argAllocator->devAllocator_);
    argAllocator->AllocDevMem();
    argAllocator->FreeDevMem((void *)1);
    delete argAllocator;
    delete device;
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy_long_string_cut)
{
    int32_t devId = -1;
    rtError_t error;
    void * args[] = {NULL, NULL, NULL, NULL};
    rtSmDesc_t smDesc;
    NpuDriver drv;
    Device * device = new RawDevice(0);
    device->Init();

    Stream * stream = new Stream(device, 0);
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();
    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::MemCopySync)
       .stubs()
       .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::ManagedMemAlloc)
       .stubs()
       .will(returnValue(RT_ERROR_NONE));

    void *addr;
    std::string kernelName = "RunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernel"
    "RunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernel"
    "RunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernel"
    "RunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernelRunCpuKernel";
    error = loader->GetKernelInfoDevAddr(kernelName.c_str(), KERNEL_NAME, &addr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete loader;
    delete stream;
    delete device;
}
TEST_F(ArgLoaderTest, uma_arg_loader_pure_load)
{
    rtError_t error;
    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult result;

    Device * device = new RawDevice(0);
    device->Init();
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();

    error = loader->PureLoad(81920, args, &result);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = loader->PureLoad(1024, args, &result);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete loader;
    delete device;
}

TEST_F(ArgLoaderTest, uma_arg_loader_pure_load_AllocDevMemStub)
{
    rtError_t error;
    void * args[] = {NULL, NULL, NULL, NULL};
    ArgLoaderResult result;
    
    Device * device = new RawDevice(0);
    device->Init();
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();

    MOCKER_CPP(&H2DCopyMgr::AllocDevMem, void* (H2DCopyMgr::*)(const bool)).stubs().will(returnValue((void *)NULL));
    error = loader->PureLoad(1024, args, &result);
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);

    delete loader;
    delete device;
}

TEST_F(ArgLoaderTest, uma_arg_loader_find_kernel_info_name)
{
    Device * device = new RawDevice(0);
    device->Init();
    UmaArgLoader *loader = new UmaArgLoader(device);
    loader->Init();

    std::unordered_map<std::string, void *> nameMap;
    void *addr1, *addr2;
    nameMap.emplace("TEST_KERNEL_01", addr1);
    nameMap.emplace("TEST_KERNEL_02", addr2);

    string name;
    loader->GetKernelInfoFromAddr(name, MAX_NAME, NULL);
    loader->FindKernelInfoName(name, nameMap, addr1);
    EXPECT_EQ(name, "TEST_KERNEL_01");

    delete loader;
    delete device;
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy_err)
{
    NpuDriver drv;

    RawDevice * device = new RawDevice(0);
    device->driver_ = &drv;
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    char memBase[2000];
    char memBase1[2000];
    void *mem = memBase;
    void *mem1 = memBase1;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&mem, sizeof(mem)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_DRV_ERR));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemAlloc)
        .stubs()
        .with(outBoundP(&mem1, sizeof(mem1)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemConvertAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemDestroyAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    const bool flag = ((Runtime *)Runtime::Instance())->GetDisableThread();
    ((Runtime *)Runtime::Instance())->SetDisableThread(true);
    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(device, 5000U, 1U, 1U,
        BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);

    void *args = argAllocator->AllocDevMem((uint32_t)10);
    EXPECT_EQ(args, nullptr);
    argAllocator->FreeDevMem(args);

    struct DMA_ADDR dmaHandle;

    MOCKER(drvMemConvertAddr)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    dmaHandle.fixed_size = 0;
    drv.MemConvertAddr(0, 1, 0, &dmaHandle);
    ((Runtime *)Runtime::Instance())->SetDisableThread(flag);
    delete argAllocator;
    delete device;
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy_err3)
{
    NpuDriver drv;

    RawDevice * device = new RawDevice(0);
    device->driver_ = &drv;
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    char memBase[2000];
    char memBase1[2000];
    void *mem = memBase;
    void *mem1 = memBase1;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&mem, sizeof(mem)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_DRV_ERR));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemAlloc)
        .stubs()
        .with(outBoundP(&mem1, sizeof(mem1)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemConvertAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemDestroyAddr)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::HostMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostUnRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::MemCopyAsyncWaitFinishEx)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    drv.runMode_ = RT_RUN_MODE_ONLINE;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    const bool flag = ((Runtime *)Runtime::Instance())->GetDisableThread();
    ((Runtime *)Runtime::Instance())->SetDisableThread(true);
    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(device, 2000U, 5U, 5U,
        BufferAllocator::LINEAR, COPY_POLICY_ASYNC_PCIE_DMA);

    argAllocator->cpyInfoDmaMap_.cpyCount = 1;
    argAllocator->cpyInfoDmaMap_.cpyItemSize = 2000U;
    argAllocator->cpyInfoDmaMap_.device = device;
    argAllocator->cpyInfoDmaMap_.mapLock = &argAllocator->mapLock_;
    argAllocator->policy_ = COPY_POLICY_ASYNC_PCIE_DMA;
    argAllocator->handleAllocator_ = nullptr;
    void *args = argAllocator->AllocDevMem();
    EXPECT_EQ(argAllocator->GetDevAddr(args), nullptr);
    argAllocator->FreeDevMem(args);

    argAllocator->handleAllocator_ = new (std::nothrow) BufferAllocator(sizeof(CpyHandle), 5, 5);
    args = argAllocator->AllocDevMem();
    EXPECT_NE(argAllocator->GetDevAddr(args), nullptr);
    CpyHandle *hdl = (CpyHandle *)args;
    hdl->copyStatus = ASYNC_COPY_STATU_SUCC;
    argAllocator->FreeDevMem(args);
    EXPECT_EQ(argAllocator->MallocPcieBarBuffer(1, device), nullptr);
    argAllocator->FreePcieBarBuffer((void *)1, device);
    ((Runtime *)Runtime::Instance())->SetDisableThread(flag);
    delete argAllocator;
    delete device;
}

TEST_F(ArgLoaderTest, uma_arg_loader_copy_err4)
{
    NpuDriver drv;

    RawDevice * device = new RawDevice(0);
    device->driver_ = &drv;
    drv.runMode_ = RT_RUN_MODE_ONLINE;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::CheckSupportPcieBarCopy)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::DevMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostRegister)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_ERR));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::PcieHostUnRegister)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(device, 10U, 1U, 1U,
        BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);
    EXPECT_EQ(argAllocator->MallocPcieBarBuffer(1, device), nullptr);
    argAllocator->FreePcieBarBuffer((void *)1, device);
    delete argAllocator;
    delete device;
}

TEST_F(ArgLoaderTest, load_stream_switch_n_args_with_drv_error)
{
    NpuDriver drv;
    RawDevice device(0);
    device.Init();
    device.driver_ = &drv;
    Stream stream(&device, 0);
    UmaArgLoader argLdr(&device);

    uint32_t elementSize = 1;
    uint32_t valueSize = 1;
    uint32_t value = 0;
    uint32_t* valuePtr = &value;
    Stream* trueStreamPtr[] = {&stream};
    StreamSwitchNLoadResult result = {};

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::DevMemAlloc).stubs()
        .will(returnValue(RT_ERROR_NONE)).then(returnValue(RT_ERROR_DRV_ERR));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t err = argLdr.LoadStreamSwitchNArgs(&stream, (void*)valuePtr, valueSize, trueStreamPtr, elementSize,
        RT_SWITCH_INT32, &result);
    EXPECT_EQ(RT_ERROR_DRV_ERR, err);

    GlobalMockObject::verify();
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs()
        .will(returnValue(RT_ERROR_NONE)).then(returnValue(RT_ERROR_DRV_ERR));
    err = argLdr.LoadStreamSwitchNArgs(&stream, (void*)valuePtr, valueSize, trueStreamPtr, elementSize,
        RT_SWITCH_INT32, &result);
    EXPECT_EQ(RT_ERROR_DRV_ERR, err);
}

TEST_F(ArgLoaderTest, find_or_insert_dev_addr)
{
    NpuDriver drv;
    RawDevice device(0);
    device.Init();
    device.driver_ = &drv;
    Stream stream(&device, 0);
    UmaArgLoader argLdr(&device);

    char_t *kernelName = "tf_test_so_name";
    std::unordered_map<std::string, void *> nameMap;
    void *devAddr = nullptr;

    rtError_t err = argLdr.Init();
    EXPECT_EQ(RT_ERROR_NONE, err);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    err = argLdr.FindOrInsertDevAddr(kernelName, nameMap, &devAddr);
    EXPECT_EQ(RT_ERROR_DRV_ERR, err);
}