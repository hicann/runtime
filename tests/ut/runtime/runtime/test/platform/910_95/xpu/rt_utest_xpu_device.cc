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
#define protected public
#define private public
#include "utils.h"
#include "api_impl_david.hpp"
#include "runtime.hpp"
#include "xpu_context.hpp"
#include "tprt.hpp"
#include "api_decorator.hpp"
#undef protected
#undef private
#include "xpu_stub.h"

using namespace cce::runtime;
class XpuDeviceTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "XpuDeviceTest SetUP" << std::endl;

        std::cout << "XpuDeviceTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "XpuDeviceTest end" << std::endl;
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(XpuDeviceTest, GetConfigIniValueDouble_Success)
{
    const std::string dirName = "../tests/ut/runtime/runtime/test/data/";
    const std::string fileName = dirName + std::to_string(getpid()) + "TestRuntimeConfig.ini";

    std::ofstream myfile;
    myfile.open(fileName);
    myfile<<"[Global Config]\n";
    myfile<<"ver1=1.0\n";
    myfile<<"ver2=abc\n";
    myfile<<"ver3=1e309\n";
    myfile.close();

    double val = 0;
    EXPECT_TRUE(GetConfigIniValueDouble(fileName, "ver1=", val));
    EXPECT_NEAR(val, 1.0, 1e-6);

    EXPECT_FALSE(GetConfigIniValueDouble(fileName, "ver2=", val));
    EXPECT_FALSE(GetConfigIniValueDouble(fileName, "ver3=", val));
    const std::string rmFileCmd = "rm -f " + fileName;
    system(rmFileCmd.c_str());
}

TEST_F(XpuDeviceTest, GetConfigIniValueDouble_FilePathNull)
{
    const std::string fileName = "TestRuntimeConfig.ini";
    double val = 0;
    EXPECT_FALSE(GetConfigIniValueDouble(fileName, "ver1=", val));
}

TEST_F(XpuDeviceTest, GetConfigIniValueDouble_OpenFailed)
{
    MOCKER(RealPath).stubs().will(returnValue(string("stub")));
    const std::string fileName = "TestRuntimeConfig.ini";
    double val = 0;
    EXPECT_FALSE(GetConfigIniValueDouble(fileName, "ver1=", val));
}


TEST_F(XpuDeviceTest, ParseXpuConfigInfo_Success_01)
{
    char *envpath = "stub";
    MOCKER(mmSysGetEnv)
    .stubs()
    .will(returnValue(envpath));
    MOCKER(GetConfigIniValueDouble)
    .stubs()
    .will(returnValue(true));
    MOCKER(GetConfigIniValueInt32)
    .stubs()
    .will(returnValue(true));
    MOCKER(RealPath).stubs().will(returnValue(string("stub")));
    XpuDevice * xpuDev = new XpuDevice(0);
    rtError_t error = xpuDev->ParseXpuConfigInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete xpuDev;
    GlobalMockObject::verify();
}

TEST_F(XpuDeviceTest, ParseXpuConfigInfo_Success_02)
{   
    char *envpath = "stub";
    MOCKER(mmSysGetEnv)
    .stubs()
    .will(returnValue(envpath));
    int32_t outParam = 0;
    MOCKER(GetConfigIniValueDouble)
    .stubs()
    .will(returnValue(true));
    MOCKER(GetConfigIniValueInt32)
    .stubs()
    .with(mockcpp::any(), mockcpp::any(), outBound(outParam))
    .will(returnValue(true));
    MOCKER(RealPath).stubs().will(returnValue(string("stub")));
    XpuDevice * xpuDev = new XpuDevice(0);
    rtError_t error = xpuDev->ParseXpuConfigInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete xpuDev;
    GlobalMockObject::verify();
}

TEST_F(XpuDeviceTest, ParseXpuConfigInfo_Fail_01)
{
    char *envpath = "stub";
    MOCKER(mmSysGetEnv)
    .stubs()
    .will(returnValue(envpath));
    MOCKER(GetConfigIniValueDouble)
    .stubs()
    .will(returnValue(false)); // 第一步报错
    MOCKER(GetConfigIniValueInt32)
    .stubs()
    .will(returnValue(true));
    MOCKER(RealPath).stubs().will(returnValue(string("stub")));
    XpuDevice * xpuDev = new XpuDevice(0);
    rtError_t error = xpuDev->ParseXpuConfigInfo();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete xpuDev;
}

TEST_F(XpuDeviceTest, ParseXpuConfigInfo_Fail_02)
{
    char *envpath = "stub";
    MOCKER(mmSysGetEnv)
    .stubs()
    .will(returnValue(envpath));
    MOCKER(GetConfigIniValueDouble)
    .stubs()
    .will(returnValue(true));
    MOCKER(GetConfigIniValueInt32)
    .defaults()
    .will(returnValue(false)); // 第二步报错
    MOCKER(RealPath).stubs().will(returnValue(string("stub")));
    XpuDevice * xpuDev = new XpuDevice(0);
    rtError_t error = xpuDev->ParseXpuConfigInfo();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete xpuDev;
    GlobalMockObject::verify();
}

TEST_F(XpuDeviceTest, ParseXpuConfigInfo_Fail_03)
{
    char *envpath = "stub";
    MOCKER(mmSysGetEnv)
    .stubs()
    .will(returnValue(envpath));
    MOCKER(GetConfigIniValueDouble)
    .stubs()
    .will(returnValue(true));
    MOCKER(GetConfigIniValueInt32)
    .stubs()
    .will(returnObjectList(true, false, true, true));
    MOCKER(RealPath).stubs().will(returnValue(string("stub")));
    XpuDevice * xpuDev = new XpuDevice(0);
    rtError_t error = xpuDev->ParseXpuConfigInfo();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete xpuDev;
    GlobalMockObject::verify();
}

TEST_F(XpuDeviceTest, ParseXpuConfigInfo_Fail_04)
{
    char *envpath = "stub";
    MOCKER(mmSysGetEnv)
    .stubs()
    .will(returnValue(envpath));
    MOCKER(GetConfigIniValueDouble)
    .stubs()
    .will(returnValue(true));
    MOCKER(GetConfigIniValueInt32)
    .stubs()
    .will(returnObjectList(true, true, false, true));
    MOCKER(RealPath).stubs().will(returnValue(string("stub")));
    XpuDevice * xpuDev = new XpuDevice(0);
    rtError_t error = xpuDev->ParseXpuConfigInfo();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete xpuDev;
    GlobalMockObject::verify();
}

TEST_F(XpuDeviceTest, ParseXpuConfigInfo_Fail_05)
{
    char *envpath = "stub";
    MOCKER(mmSysGetEnv)
    .stubs()
    .will(returnValue(envpath));
    MOCKER(GetConfigIniValueDouble)
    .stubs()
    .will(returnValue(true));
    MOCKER(GetConfigIniValueInt32)
    .stubs()
    .will(returnObjectList(true, true, true, false));
    MOCKER(RealPath).stubs().will(returnValue(string("stub")));
    XpuDevice * xpuDev = new XpuDevice(0);
    rtError_t error = xpuDev->ParseXpuConfigInfo();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete xpuDev;
    GlobalMockObject::verify();
}

TEST_F(XpuDeviceTest, ParseXpuConfigInfo_Fail_06)
{
    char *envpath = nullptr;
    MOCKER(mmSysGetEnv)
    .stubs()
    .will(returnValue(envpath));
    XpuDevice * xpuDev = new XpuDevice(0);
    rtError_t error = xpuDev->ParseXpuConfigInfo();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete xpuDev;
    GlobalMockObject::verify();
}

TEST_F(XpuDeviceTest, SetXpuDevice_success)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    Device *dev = rt->GetXpuDevice();
    EXPECT_EQ(dev->GetChipType(), CHIP_XPU);
    Context *ctxt = rt->GetXpuCtxt();
    EXPECT_NE(ctxt, nullptr);

    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuDeviceTest, SetXpuDevice_Offline)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_offline));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(XpuDeviceTest, SetXpuDevice_InvalidDevId)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(XpuDeviceTest, SetXpuDevice_InvalidType)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_REV, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(XpuDeviceTest, SetXpuDevice_PrimaryXpuContextRetain_error1)
{
    Runtime *rt = (Runtime *)Runtime::Instance();
    Context *context;
    XpuDevice *device = new XpuDevice(0);
    MOCKER_CPP_VIRTUAL(device, &XpuDevice::Init).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    context = rt->PrimaryXpuContextRetain(0);
    EXPECT_EQ(context, nullptr);
    delete device;
}

TEST_F(XpuDeviceTest, SetXpuDevice_PrimaryXpuContextRetain_error2)
{
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = new XpuContext(0, true);
    MOCKER_CPP_VIRTUAL(context, &XpuContext::Setup).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    EXPECT_EQ(rt->PrimaryXpuContextRetain(1), nullptr); 
    delete context;
}

TEST_F(XpuDeviceTest, SetXpuDevice_XpuDeviceRetain_error)
{
    Runtime *rt = (Runtime *)Runtime::Instance();
    Device *dev;
    XpuDevice *device = new XpuDevice(0);
    MOCKER_CPP_VIRTUAL(device, &XpuDevice::Init).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    dev = rt->XpuDeviceRetain(0);
    EXPECT_EQ(dev, nullptr);
    delete device;
}

TEST_F(XpuDeviceTest, SetXpuDevice_XpuDeviceRetain_error2)
{
    Runtime *rt = (Runtime *)Runtime::Instance();
    Device *dev;
    XpuDevice *device = new XpuDevice(0);
    MOCKER_CPP_VIRTUAL(device, &XpuDevice::Init).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device, &XpuDevice::Start).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    dev = rt->XpuDeviceRetain(0);
    EXPECT_EQ(dev, nullptr);
    delete device;
} 

TEST_F(XpuDeviceTest, XpuDevice_Init_error1)
{
    XpuDevice *device = new XpuDevice(0);
    rtError_t error = device->Init();
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete device;
}

TEST_F(XpuDeviceTest, CreateRecycleThread_mmSemInit_error)
{
    MOCKER(mmSemInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    XpuDevice *device = new XpuDevice(0);
    rtError_t error = device->CreateRecycleThread();
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
    delete device;
}

TEST_F(XpuDeviceTest, CreateRecycleThread_start_error)
{
    XpuDevice *device = new XpuDevice(0);
    void * const xpuRecycle = RtValueToPtr<void *>(static_cast<uint64_t>(XpuThreadType::XPU_THREAD_RECYCLE));
    Thread *thread = OsalFactory::CreateThread("DPU_RECYCLE", device, xpuRecycle);
    MOCKER_CPP_VIRTUAL(thread, &Thread::Start).stubs().will(returnValue(EN_ERROR));
    rtError_t error = device->CreateRecycleThread();
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
    delete thread;
    delete device;
}

TEST_F(XpuDeviceTest, CreateRecycleThread_CreateThread_error)
{
    MOCKER(OsalFactory::CreateThread).stubs().will(returnValue((Thread *)nullptr));
    XpuDevice *device = new XpuDevice(0);
    rtError_t error = device->CreateRecycleThread();
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
    delete device;
}

TEST_F(XpuDeviceTest, GetXpuDevCount_success)
{
    uint32_t devCount = 0U;
    rtError_t error = rtGetXpuDevCount(RT_DEV_TYPE_DPU, &devCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(devCount, 1U);
}

TEST_F(XpuDeviceTest, GetXpuDevCount_devType_error)
{
    uint32_t devCount = 0U;
    rtError_t error = rtGetXpuDevCount(RT_DEV_TYPE_REV, &devCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(devCount, 0U);
}

TEST_F(XpuDeviceTest, Impl_GetXpuDevCount_devType_error)
{
    ApiImplDavid impl;
    uint32_t devCount = 0U;
    rtError_t error = impl.GetXpuDevCount(RT_DEV_TYPE_REV, &devCount);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuDeviceTest, ApiDecorator_SetXpuDevice)
{
    ApiImplDavid impl;
    ApiDecorator api(&impl);

    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = api.SetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = api.ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(XpuDeviceTest, ApiDecorator_GetXpuDevCount)
{
    ApiImplDavid impl;
    ApiDecorator api(&impl);
    uint32_t devCount = 0U;

    rtError_t error = api.GetXpuDevCount(RT_DEV_TYPE_DPU, &devCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(devCount, 1U);
}

TEST_F(XpuDeviceTest, XpuDriver_GetDrvErrCode_error)
{
    XpuDriver *driver = new XpuDriver();
    uint32_t errCode = 0x4;
    rtError_t error = driver->GetDrvErrCode(errCode);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    DELETE_O (driver);
}
