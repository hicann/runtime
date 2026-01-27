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

class CloudV2ArgLoaderTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"CloudV2ArgLoaderTest start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"CloudV2ArgLoaderTest end"<<std::endl;
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

rtError_t StubCheckSupportPcieBarCopy(Driver *that, const uint32_t deviceId, uint32_t &val, const bool need4KAsync)
{
    val = RT_CAPABILITY_SUPPORT;
    return RT_ERROR_NONE;
}

TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_mix_illegal_size)
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

TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_init_of_chip_as31xm1x)
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

TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_with_sm)
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

TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_with_sm_fail)
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

#if 0
TEST_F(CloudV2ArgLoaderTest, stub_arg_loader2)
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

TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_with_memcpy_fail)
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

TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_copy_long_string_cut)
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
TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_pure_load)
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

TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_pure_load_AllocDevMemStub)
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

TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_find_kernel_info_name)
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

TEST_F(CloudV2ArgLoaderTest, load_stream_switch_n_args_with_drv_error)
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

TEST_F(CloudV2ArgLoaderTest, find_or_insert_dev_addr)
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

TEST_F(CloudV2ArgLoaderTest, uma_arg_loader_rollback)
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

    delete loader;
    delete rawDrv;
    rtInstance->DeviceRelease(device);
}