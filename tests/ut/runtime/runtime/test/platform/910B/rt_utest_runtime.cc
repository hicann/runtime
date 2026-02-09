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
#define private public
#include "runtime.hpp"
#include "runtime_keeper.h"
#include "npu_driver.hpp"
#include "api_impl.hpp"
#include "program.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "raw_device.hpp"
#include "platform/platform_info.h"
#include "soc_info.h"
#include "thread_local_container.hpp"
#include <dlfcn.h>

#undef private

using namespace testing;
using namespace cce::runtime;
#define PROF_AICPU_MODEL_MASK            0x4000000000000000ULL
#define PROF_AICPU_TRACE_MASK            0x00000008ULL
#define PROF_TASK_TIME_MASK              0x00000002ULL
#define PROF_AICORE_METRICS              0x00000004ULL

class CloudV2RuntimeTest : public testing::Test
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
        GlobalMockObject::verify();
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        rtSetDevice(0);
        rtError_t error;
        Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);
        GlobalContainer::SetHardwareChipType(CHIP_END);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
        Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);
    }

    static void InitVisibleDevices()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->userDeviceCnt = 0U;
        rtInstance->isSetVisibleDev = false;
        if (rtInstance->deviceInfo == nullptr) {
            rtInstance->deviceInfo = new (std::nothrow) uint32_t[RT_SET_DEVICE_STR_MAX_LEN];
        }
        (void)memset_s(rtInstance->deviceInfo, size_t(sizeof(uint32_t) * RT_SET_DEVICE_STR_MAX_LEN), MAX_UINT32_NUM,
            size_t(sizeof(uint32_t) * RT_SET_DEVICE_STR_MAX_LEN));
        (void)memset_s(rtInstance->inputDeviceStr, size_t(RT_SET_DEVICE_STR_MAX_LEN + 1U), 0U,
            size_t(RT_SET_DEVICE_STR_MAX_LEN + 1U));
        return;
    }

    static int TsdOpenExStub(uint32_t a, uint32_t b, uint32_t c)
    {
        return 0;
    }

    static int TsdOpenStub(uint32_t a, uint32_t b)
    {
        return 0;
    }

    static int TsdCloseStub(uint32_t a)
    {
        return 0;
    }

    static int UpdateProfilingModeStub(uint32_t a, uint32_t b)
    {
        return 0;
    }

    static int TsdSetMsprofReporterCallbackStub(void *ptr)
    {
        return 0;
    }

    static int TsdInitQsStub(uint32_t a, char* s)
    {
        return 0;
    }

    static int TsdSetAttrStub(char* s1, char* s2)
    {
        return 0;
    }

    static int TsdInitFlowGwStub(uint32_t a, void *info)
    {
        return 0;
    }

    static void stubFunc(void)
    {}
private:
    rtChipType_t originType;
};

TEST_F(CloudV2RuntimeTest, ut_AllKernelRegister_mix_degenerate)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    ElfProgram prog;
    char *name = new (std::nothrow) char[20];
    strcpy(name, "abc_123_mix_aic");
    RtKernel kernel = {name, 10, 10, nullptr};
    prog.elfData_->kernel_num = 1;
    prog.elfData_->degenerateFlag = true;
    prog.kernels_ = &kernel;
    rtError_t ret = rtInstance->AllKernelRegister(&prog, false);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}

TEST_F(CloudV2RuntimeTest, ut_KernelRegister_mix_degenerate)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint8_t mixType = MIX_AIV;

    ElfProgram prog;
    prog.elfData_->kernel_num = 1;
    prog.elfData_->degenerateFlag = true;
    MOCKER_CPP(&Runtime::JudgeOffsetByMixType)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(mixType), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    rtError_t ret = error = rtInstance->KernelRegister(&prog, (const void *)stubFunc, "repeat_mix_aic", "repeat_mix_aic", 196608);
}

TEST_F(CloudV2RuntimeTest, ut_AllKernelRegister_2)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    void *code[] = {NULL, NULL, NULL, NULL};
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.version = 1;
    bin.data = code;
    bin.length = sizeof(code);

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtInstance->AllKernelRegister(program, false);

    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2RuntimeTest, ut_AllKernelRegister_3)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    void *code[] = {NULL, NULL, NULL, NULL};
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.version = 1;
    bin.data = code;
    bin.length = sizeof(code);

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtInstance->AllKernelRegister(program, true);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2RuntimeTest, ut_TsdClientInit)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    uint64_t stub = 123;
    void *handle = &stub;
    MOCKER(mmDlopen).stubs().will(returnValue(handle));
    const char *funcName = "TsdOpenEx";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)TsdOpenExStub));
    funcName = "TsdOpen";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)TsdOpenStub));
    funcName = "TsdClose";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)TsdCloseStub));
    funcName = "UpdateProfilingMode";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)UpdateProfilingModeStub));
    funcName = "TsdSetMsprofReporterCallback";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)TsdSetMsprofReporterCallbackStub));
    funcName = "TsdInitQs";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)TsdInitQsStub));
    funcName = "TsdSetAttr";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)TsdSetAttrStub));
    funcName = "TsdInitFlowGw";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)TsdInitFlowGwStub));
    rtInstance->TsdClientInit();
}

TEST_F(CloudV2RuntimeTest, ut_GetVisibleDevicesByChipCloudTest0)
{
    rtError_t ret = 0;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool haveDevice = rtInstance->isHaveDevice_;
    uint32_t devNum = 3;

    rtInstance->isHaveDevice_ = true;
    InitVisibleDevices();
    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, false);

    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    setenv("ASCEND_RT_VISIBLE_DEVICES", "", 1);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", ",0", 3);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "0,1,5,7", 8);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 2);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "1", 2);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 1);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,,", 4);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 1);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "1*", 3);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 1);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,", 3);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 1);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "0,1", 4);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 2);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "0,1$0,", 7);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 2);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "0#1,", 5);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 1);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "-1,3", 5);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "0,1,2", 6);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 3);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "0,1,2,0", 6);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 3);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "10,", 4);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "10", 3);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "10#", 4);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,-1", 5);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 1);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "0,1,1", 6);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,0,1", 6);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,1,0", 6);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    setenv("ASCEND_RT_VISIBLE_DEVICES", "0,1,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4", 134);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 2);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);
    rtInstance->isSetVisibleDev = false;
    rtInstance->isHaveDevice_ = haveDevice;

    setenv("ASCEND_RT_VISIBLE_DEVICES", "1234567891012345678910123456789", 1);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->deviceInfo[0], MAX_UINT32_NUM);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);
    rtInstance->isSetVisibleDev = false;
    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
}

TEST_F(CloudV2RuntimeTest, ut_KernelRegister_mix_aic)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint8_t mixType = MIX_AIC;

    ElfProgram prog;
    prog.elfData_->kernel_num = 1;
    prog.elfData_->degenerateFlag = true;
    MOCKER_CPP(&Runtime::JudgeOffsetByMixType)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(mixType), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    error = rtInstance->KernelRegister(&prog, (const void *)stubFunc, "repeat_mix_aic", "repeat_mix_aic", 196608);
}


TEST_F(CloudV2RuntimeTest, ut_KernelRegister_mix_aic2)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint8_t mixType = MIX_AIC_AIV_MAIN_AIC;

    ElfProgram prog;
    prog.elfData_->kernel_num = 1;
    prog.elfData_->degenerateFlag = true;
    MOCKER_CPP(&Runtime::JudgeOffsetByMixType)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(mixType), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    error = rtInstance->KernelRegister(&prog, (const void *)stubFunc, "repeat_mix_aic", "repeat_mix_aic", 196608);
    ContextManage::TryToRecycleCtxMdlPool();
}

TEST_F(CloudV2RuntimeTest, ut_AiCpuProfilerStart_01)
{
    rtError_t ret = 0;
    uint32_t deviceList[1]={1};

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    ret = rtInstance->AiCpuProfilerStart(1, 1, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2RuntimeTest, binanry_reg_mix_null_data)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    bin.version = 1;
    bin.data = NULL;
    bin.length = 0;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2RuntimeTest, SocTypeInit)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_NE(rtInstance, nullptr);
    uint32_t aicoreNum = 0;
    int64_t virAicoreNum = 1;

    rtInstance->SocTypeInit(0, 1);
    rtInstance->SocTypeInit(1, 1);
    rtInstance->SocTypeInit(1, 2);
    rtInstance->SocTypeInit(1, 3);
    rtInstance->SocTypeInit(1, 4);
    rtInstance->SocTypeInit(2, 1);
    rtInstance->SocTypeInit(2, 2);
    rtInstance->SocTypeInit(2, 3);
    rtInstance->CheckVirtualMachineMode(aicoreNum, virAicoreNum);
}

TEST_F(CloudV2RuntimeTest, AicpuCntInitTest_03)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = rtInstance->GetSocType();
    rtInstance->SetSocType(SOC_AS31XM1X);
    rtError_t error  = rtInstance->InitAiCpuCnt();
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetSocType(socType);
}

TEST_F(CloudV2RuntimeTest, ut_HwtsLogDynamicProfilerStartStopSTTest)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint64_t profConfig = 0ULL;

    profConfig |= PROF_TASK_TIME_MASK;
    uint32_t deviceList[1] = {0U};
    int32_t numsDev = 1;
    rtError_t ret = 0;
    ret = rtInstance->TsProfilerStart(profConfig, numsDev, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtInstance->TsProfilerStop(profConfig, numsDev, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // open all device
    uint32_t devNum = 1;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    ret = rtInstance->TsProfilerStart(profConfig, -1, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtInstance->TsProfilerStop(profConfig, -1, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2RuntimeTest, ut_GetVisibleDevicesByChipCloudTest1)
{
    rtError_t ret = 0;
    uint32_t userDeviceid = 5;
    uint32_t deviceid = 0;
    uint32_t devNum = 3;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = true;

    rtInstance->isSetVisibleDev = false;
    ret = rtInstance->ChgUserDevIdToDeviceId(userDeviceid, &deviceid);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(deviceid, 5);

    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,-1", 5);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 1);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    ret = rtInstance->ChgUserDevIdToDeviceId(userDeviceid, &deviceid);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_ID);

    userDeviceid = 0;
    int32_t deviceid0 = 0;
    Api* oldApi_ = Runtime::runtime_->api_;
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();
    ret = rtInstance->ChgUserDevIdToDeviceId(userDeviceid, &deviceid);
    ret |= rtGetVisibleDeviceIdByLogicDeviceId(userDeviceid, &deviceid0);
    ret |= profiler->apiProfileDecorator_->GetVisibleDeviceIdByLogicDeviceId(userDeviceid, &deviceid0);
    ret |= profiler->apiProfileLogDecorator_->GetVisibleDeviceIdByLogicDeviceId(userDeviceid, &deviceid0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(deviceid, 1);
    rtInstance->isSetVisibleDev = false;
    rtInstance->isHaveDevice_ = haveDevice;
    delete profiler;
}

TEST_F(CloudV2RuntimeTest, ut_GetVisibleDevicesByChipCloudTest2)
{
    rtError_t ret = 0;
    uint32_t userDeviceid = 5;
    uint32_t deviceid = 0;
    uint32_t devNum = 3;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = true;

    rtInstance->isSetVisibleDev = false;
    ret = rtInstance->GetUserDevIdByDeviceId(userDeviceid, &deviceid);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(deviceid, 5);

    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,-1", 5);
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 1);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    ret = rtInstance->GetUserDevIdByDeviceId(userDeviceid, &deviceid);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_ID);

    userDeviceid = 1;
    ret = rtInstance->GetUserDevIdByDeviceId(userDeviceid, &deviceid);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(deviceid, 0);
    rtInstance->isSetVisibleDev = false;
    rtInstance->isHaveDevice_ = haveDevice;
}

TEST_F(CloudV2RuntimeTest, ut_AiCpuProfilerStart_00)
{
    rtError_t ret = 0;
    uint32_t deviceList[5]={1,2,3,4,5};

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    ret = rtInstance->AiCpuProfilerStart(1, 5, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2RuntimeTest, MacroInitCloudV2)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->MacroInit(CHIP_910_B_93);
    EXPECT_EQ(Runtime::macroValue_.rtsqDepth, 2048U);

    MOCKER(halSupportFeature).stubs().will(returnValue(false));

    rtInstance->MacroInit(CHIP_910_B_93);
    EXPECT_EQ(Runtime::macroValue_.rtsqDepth, 4096U);

    rtInstance->MonitorNumAdd(1U);

    rtInstance->MacroInit(CHIP_910_B_93);
    EXPECT_EQ(Runtime::macroValue_.rtsqDepth, 4096U);
    GlobalMockObject::reset();
    // Restore to the initial system value
    rtInstance->MacroInit(CHIP_910_B_93);
}

TEST_F(CloudV2RuntimeTest, ut_GetDcacheLockMixPath_CloudV2_FileExistsInSoDir) {
    std::string currentExePath;
    Dl_info info;
    if (dladdr(reinterpret_cast<void*>(this), &info) && info.dli_fname != nullptr) {
        currentExePath = info.dli_fname;
    } else {
        currentExePath = "/proc/self/exe"; // fallback on Linux
        char buf[1024];
        ssize_t len = readlink(currentExePath.c_str(), buf, sizeof(buf)-1);
        if (len != -1) {
            buf[len] = '\0';
            currentExePath = buf;
        }
    }

    size_t lastSlash = currentExePath.find_last_of('/');
    std::string dir = (lastSlash != std::string::npos) ? currentExePath.substr(0, lastSlash + 1) : "./";
    std::string targetFile = dir + "dcache_lock_mix.o";
    // 创建文件
    std::ofstream file(targetFile);
    file.close();

    // 执行测试
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    std::string binaryPath;
    rtError_t ret = rtInstance->GetDcacheLockMixOpPath(binaryPath);

    size_t pos;
    while ((pos = binaryPath.find("//")) != std::string::npos) {
        binaryPath.replace(pos, 2, "/");
    }

    // 清理
    std::remove(targetFile.c_str());

    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(binaryPath, targetFile);
}

TEST_F(CloudV2RuntimeTest, ut_GetDcacheLockMixPath_CloudV2_FileNotExists_UseFallback) {
    std::string fallbackPath = "/usr/local/Ascend/driver/lib64/common/dcache_lock_mix.o";

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    std::string binaryPath;
    rtError_t ret = rtInstance->GetDcacheLockMixOpPath(binaryPath);

    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(binaryPath, fallbackPath);
}