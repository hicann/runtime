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

#undef private

using namespace testing;
using namespace cce::runtime;
#define PROF_AICPU_MODEL_MASK            0x4000000000000000ULL
#define PROF_AICPU_TRACE_MASK            0x00000008ULL
#define PROF_TASK_TIME_MASK              0x00000002ULL
#define PROF_AICORE_METRICS              0x00000004ULL

class RuntimeTest910B : public testing::Test
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

TEST_F(RuntimeTest910B, ut_AllKernelRegister_mix_degenerate)
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

TEST_F(RuntimeTest910B, ut_KernelRegister_mix_degenerate)
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

TEST_F(RuntimeTest910B, ut_AllKernelRegister_2)
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

TEST_F(RuntimeTest910B, ut_AllKernelRegister_3)
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

TEST_F(RuntimeTest910B, ut_TsdClientInit)
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

TEST_F(RuntimeTest910B, ut_GetVisibleDevicesByChipCloudTest0)
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

TEST_F(RuntimeTest910B, ut_KernelRegister_mix_aic)
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


TEST_F(RuntimeTest910B, ut_KernelRegister_mix_aic2)
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

TEST_F(RuntimeTest910B, ut_AiCpuProfilerStart_01)
{
    rtError_t ret = 0;
    uint32_t deviceList[1]={1};

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    ret = rtInstance->AiCpuProfilerStart(1, 1, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(RuntimeTest910B, binanry_reg_mix_null_data)
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

TEST_F(RuntimeTest910B, ut_HwtsLogDynamicProfilerStartStopSTTest)
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

TEST_F(RuntimeTest910B, ut_GetVisibleDevicesByChipCloudTest1)
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

TEST_F(RuntimeTest910B, ut_GetVisibleDevicesByChipCloudTest2)
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

TEST_F(RuntimeTest910B, ut_AiCpuProfilerStart_00)
{
    rtError_t ret = 0;
    uint32_t deviceList[5]={1,2,3,4,5};

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    ret = rtInstance->AiCpuProfilerStart(1, 5, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(RuntimeTest910B, MacroInitCloudV2)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER(halSupportFeature).stubs().will(returnValue(false));

    EXPECT_EQ(Runtime::macroValue_.rtsqDepth, 2048U);

    rtInstance->MonitorNumAdd(1U);
    EXPECT_EQ(Runtime::macroValue_.rtsqDepth, 2048U);
    GlobalMockObject::reset();
}

TEST_F(RuntimeTest910B, MacroInitDefault)
{
    Runtime rt;
    RtMacroValue value{};
    rt.MacroInitDefault(value);
    EXPECT_EQ(value.maxModelNum, 1024U);
    EXPECT_EQ(value.maxPersistTaskNum, 15000U);
}

TEST_F(RuntimeTest910B, binanry_reg_null_data)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = NULL;
    bin.length = 0;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(RuntimeTest910B, binary_reg_max)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    uint32_t old = Runtime::maxProgramNum_;
    Runtime::maxProgramNum_ = 0U;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_PROGRAM_USEOUT);
    Runtime::maxProgramNum_ = old;
}

TEST_F(RuntimeTest910B, binanry_reg_cube_null_data)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    bin.magic = RT_DEV_BINARY_MAGIC_ELF_AICUBE;
    bin.version = 1;
    bin.data = NULL;
    bin.length = 0;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_NE(error, RT_ERROR_NONE);

    bin.magic = RT_DEV_BINARY_MAGIC_ELF_AIVEC;
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_NE(error, RT_ERROR_NONE);
}


void stubFunc(void)
{}

TEST_F(RuntimeTest910B, config_log_level)
{
    setenv("RT_LOG_LEVEL", "xxx", 1);
    Config *tmpConfig = new Config();
    delete tmpConfig;

    setenv("RT_LOG_LEVEL", "100", 1);
    tmpConfig = new Config();
    delete tmpConfig;

    setenv("RT_LOG_LEVEL", "2", 1);
    tmpConfig = new Config();
    delete tmpConfig;
    EXPECT_NE(tmpConfig, nullptr);
}

using ConstructFunc = Runtime *(*)();
using DesConstructFunc = void (*)(Runtime *);

TEST_F(RuntimeTest910B, BOOT_RUNTIME_TEST_ConstructRuntime)
{
    constexpr const int32_t flags = static_cast<int32_t>(static_cast<uint32_t>(MMPA_RTLD_NOW));
    void *const handlePtr = dlopen(NULL, flags);

    EXPECT_NE(handlePtr, nullptr);
    const ConstructFunc create = reinterpret_cast<ConstructFunc>(dlsym(handlePtr, "ConstructRuntimeImpl"));
    EXPECT_NE(create, nullptr);
    Runtime *rt = create();
    EXPECT_NE(rt, nullptr);

    const DesConstructFunc destruct = reinterpret_cast<DesConstructFunc>(dlsym(handlePtr, "DestructorRuntimeImpl"));
    EXPECT_NE(destruct, nullptr);
    destruct(rt);

    dlclose(handlePtr);
}

TEST_F(RuntimeTest910B, AicpuCntInitTest)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = rtInstance->GetSocType();

    rtError_t error = RT_ERROR_NONE;
    rtInstance->SetSocType(SOC_BEGIN);
    error  = rtInstance->InitAiCpuCnt();

    rtInstance->SetSocType(socType);
}

TEST_F(RuntimeTest910B, CheckHaveDevice)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool ret = rtInstance->CheckHaveDevice();
    EXPECT_EQ(ret, true);

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));
    ret = rtInstance->CheckHaveDevice();
    EXPECT_EQ(ret, false);
    rtInstance->InitChipAndSocType();

    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    ret = rtInstance->CheckHaveDevice();
}

TEST_F(RuntimeTest910B, ut_JudgeOffsetByMixType_mix)
{
    rtError_t error;
    Program *program = nullptr;
    rtDevBinary_t bin;
    uint8_t mixType = 0;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtKernelContent kernelInfo1;
    rtKernelContent kernelInfo2;

    error = rtInstance->JudgeOffsetByMixType(program, "abc", mixType, &kernelInfo1, &kernelInfo2);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(RuntimeTest910B, ut_JudgeOffsetByMixType)
{
    rtError_t error;
    Program *program = nullptr;
    rtDevBinary_t bin;
    uint8_t mixType = 0;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtKernelContent kernelInfo1;
    rtKernelContent kernelInfo2;

    MOCKER_CPP_VIRTUAL(program, &Program::HasMixKernel).stubs().will(returnValue(true));
    error = rtInstance->JudgeOffsetByMixType(program, "abc", mixType, &kernelInfo1, &kernelInfo2);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(RuntimeTest910B, ut_GetOffsetByCustomKernelType_mix)
{
    rtError_t error;
    Program *program = nullptr;
    rtDevBinary_t bin;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    bin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    bin.version = 1;
    bin.data = &bin;
    bin.length = sizeof(bin);
    error = rtInstance->ProgramRegister(&bin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtKernelContent kernelInfo1;
    rtKernelContent kernelInfo2;
    uint32_t mixType = 9U;

    error = rtInstance->GetOffsetByCustomKernelType(program, mixType, "abc", &kernelInfo1, &kernelInfo2);
    EXPECT_EQ(error, RT_ERROR_KERNEL_OFFSET);

}

TEST_F(RuntimeTest910B, CheckHaveDeviceNotSupport)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool ret = rtInstance->CheckHaveDevice();
    EXPECT_EQ(ret, true);

    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    ret = rtInstance->CheckHaveDevice();
    EXPECT_EQ(ret, false);

    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    ret = rtInstance->CheckHaveDevice();
}

TEST_F(RuntimeTest910B, ut_AllKernelRegister_GetKernelsCount_2)
{
    ElfProgram prog;
    char *name = new (std::nothrow) char[10];
    strcpy(name, "a_200");
    RtKernel kernel = {name, 10, 10, nullptr};
    prog.elfData_->kernel_num = 1;
    prog.kernels_ = &kernel;
    rtError_t error = Runtime::Instance()->AllKernelRegister(&prog, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}

TEST_F(RuntimeTest910B, ut_AllKernelRegister_GetKernelsCount_invalid01)
{
    ElfProgram prog;
    char *name = new (std::nothrow) char[10];
    strcpy(name, "a200");
    RtKernel kernel = {name, 10, 10, nullptr};
    prog.elfData_->kernel_num = 1;
    prog.kernels_ = &kernel;
    rtError_t error = Runtime::Instance()->AllKernelRegister(&prog, false);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}

TEST_F(RuntimeTest910B, ut_AllKernelRegister_GetKernelsCount_invalid02)
{
    ElfProgram prog;
    char *name = new (std::nothrow) char[100];
    strcpy(name, "a_4444444444444444444444444444444444444444444444444444444444");
    RtKernel kernel = {name, 10, 10, nullptr};
    prog.elfData_->kernel_num = 1;
    prog.kernels_ = &kernel;
    rtError_t error = Runtime::Instance()->AllKernelRegister(&prog, false);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}

TEST_F(RuntimeTest910B, ut_AllKernelRegister_GetKernelsCount_invalid03)
{
    ElfProgram prog;
    char *name = new (std::nothrow) char[3];
    strcpy(name, "a_");
    RtKernel kernel = {name, 10, 10, nullptr};
    prog.elfData_->kernel_num = 1;
    prog.kernels_ = &kernel;
    rtError_t error = Runtime::Instance()->AllKernelRegister(&prog, false);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    prog.kernels_ = nullptr;
    prog.elfData_->kernel_num = 0;
    delete[] name;
}

TEST_F(RuntimeTest910B, ut_AllKernelRegister)
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

TEST_F(RuntimeTest910B, ut_CheckKernelsName)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RtKernel kernels = {};
    bool staticKernel = false;
    kernels.name = new (std::nothrow) char[256];
    strcpy(kernels.name, "Diag_10f221e28fd08dee9977262d2fb6c36e_high_performance_mix_aic_mix_aiv__kernel0");
    rtError_t error = rtInstance->CheckKernelsName(&kernels, 1, true, staticKernel);
    EXPECT_EQ(error, RT_ERROR_NONE);

    strcpy(kernels.name, "Diag_10f221e28fd08dee9977262d2fb6c36e_high_performance_mix_aiv_mix_aic__kernel0");
    error = rtInstance->CheckKernelsName(&kernels, 1, true, staticKernel);
    EXPECT_EQ(error, RT_ERROR_NONE);

    strcpy(kernels.name, "Diag_10f221e28fd08dee9977262d2fb6c36e_high_performance__kernel0_mix_aic");
    error = rtInstance->CheckKernelsName(&kernels, 1, true, staticKernel);
    EXPECT_EQ(error, RT_ERROR_NONE);

    strcpy(kernels.name, "Diag_10f221e28fd08dee9977262d2fb6c36e_high_performance_0");
    error = rtInstance->CheckKernelsName(&kernels, 1, true, staticKernel);
    EXPECT_EQ(error, RT_ERROR_NONE);

    strcpy(kernels.name, "12345_9_mix_aic");
    error = rtInstance->CheckKernelsName(&kernels, 1, true, staticKernel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete [] kernels.name;
}

TEST_F(RuntimeTest910B, ut_GetTilingKeyFromKernel)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string kernelName = "abc_mix_aic";
    uint8_t mixType = 0U;
    std::string ret;
    ret = rtInstance->GetTilingKeyFromKernel(kernelName, mixType);
    EXPECT_EQ(ret, "abc");
    std::string kernelName2 = "abc_mix_aiv";
    ret = rtInstance->GetTilingKeyFromKernel(kernelName2, mixType);
    EXPECT_EQ(ret, "abc");
    std::string kernelName3 = "abc_mix_aic_mix_aiv";
    ret = rtInstance->GetTilingKeyFromKernel(kernelName3, mixType);
    EXPECT_EQ(ret, "abc");
}

TEST_F(RuntimeTest910B, ut_GetTilingValue)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string kernelName = "@111";
    uint64_t tilingValue = 0U;
    rtError_t error = rtInstance->GetTilingValue(kernelName, tilingValue);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    std::string kernelName2 = "11111111111111111111111111111111111111111111111111";
    error = rtInstance->GetTilingValue(kernelName2, tilingValue);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    std::string kernelName3 = "200";
    error = rtInstance->GetTilingValue(kernelName3, tilingValue);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RuntimeTest910B, ut_GetProfDeviceNum)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    int32_t ret = rtInstance->GetProfDeviceNum(0xFFFFFFFFFFFFFFFFULL);
    bool result = (ret >= 0);
    EXPECT_EQ(result, true);
}

TEST_F(RuntimeTest910B, ut_OtherProfilerApiStartStopTest)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    uint64_t profConfig = 0xFFFFFFFFFFFFFFFFULL;
    uint32_t deviceList[2] = {0U, 1U};
    int32_t numsDev = 1;
    rtError_t ret = rtInstance->RuntimeApiProfilerStart(profConfig, numsDev, deviceList);
    ret = rtInstance->RuntimeApiProfilerStop(profConfig, numsDev, deviceList);

    // open all device
    uint32_t devNum = 2;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    ret = rtInstance->RuntimeApiProfilerStart(profConfig, -1, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtInstance->RuntimeApiProfilerStop(profConfig, -1, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtInstance->RuntimeProfileLogStart(profConfig, numsDev, deviceList);
    ret = rtInstance->RuntimeProfileLogStop(profConfig, numsDev, deviceList);

    uint64_t type = 0ULL;
    RawDevice *dev = new RawDevice(0);

    rtInstance->TsTimelineStart(profConfig, type, dev);
    rtInstance->TsTimelineStop(profConfig, type, dev);

    bool needOpenTimeline = true;
    rtInstance->TsTimelineStart(profConfig, needOpenTimeline, dev);
    rtInstance->TsTimelineStop(profConfig, needOpenTimeline, dev);

    rtInstance->AicMetricStart(profConfig, type, dev);
    rtInstance->AicMetricStop(profConfig, type, dev);

    rtInstance->AiCpuTraceStart(profConfig, type, dev);
    rtInstance->AiCpuTraceStop(profConfig, type, dev);

    rtInstance->HwtsLogStart(profConfig, type, dev);
    rtInstance->HwtsLogStop(profConfig, type, dev);

    type |= PROF_AICPU_MODEL_MASK | PROF_AICPU_TRACE_MASK;
    dev->SetDevProfStatus(type, true);
    rtInstance->AiCpuModelTraceStart(profConfig, type, dev);
    rtInstance->AiCpuModelTraceStop(profConfig, type, dev);
    Runtime::Instance()->isHaveDevice_ = false;
    ret = Runtime::Instance()->HandleAiCpuProfiling(profConfig, 0U, true);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Runtime::Instance()->isHaveDevice_ = true;
    ret = Runtime::Instance()->HandleAiCpuProfiling(profConfig, 0U, true);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    int32_t streamId = 1;
    uint32_t devId = 0U;
    uint32_t sqId = 0U;
    rtInstance->GetSqIdByStreamId(devId, streamId, &sqId);

    delete dev;
}

extern "C" {
int TsdOpenExStub(uint32_t a, uint32_t b, uint32_t c)
{
    return 0;
}
int TsdOpenStub(uint32_t a, uint32_t b)
{
    return 0;
}
int TsdCloseStub(uint32_t a)
{
    return 0;
}
int UpdateProfilingModeStub(uint32_t a, uint32_t b)
{
    return 0;
}
int TsdSetMsprofReporterCallbackStub(void *ptr)
{
    return 0;
}
int TsdInitQsStub(uint32_t a, char* s)
{
    return 0;
}
int TsdSetAttrStub(char* s1, char* s2)
{
    return 0;
}
int TsdInitFlowGwStub(uint32_t a, void *info)
{
    return 0;
}
}

TEST_F(RuntimeTest910B, ut_GetHdcConctStatus01)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->tsdGetHdcConctStatus_ = [](const uint32_t logicDeviceId, int32_t *hdcSessStat) -> TDT_StatusType {
        return 0;
    };
    int32_t hdcSessStat;
    rtError_t ret = rtInstance->GetHdcConctStatus(0, hdcSessStat);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(RuntimeTest910B, ut_GetHdcConctStatus02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->tsdGetHdcConctStatus_ = [](const uint32_t logicDeviceId, int32_t *hdcSessStat) -> TDT_StatusType {
        return 10;
    };
    int32_t hdcSessStat;
    rtError_t ret = rtInstance->GetHdcConctStatus(0, hdcSessStat);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

void InitVisibleDevices()
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


TEST_F(RuntimeTest910B, ut_SetAndGetWatchDogDevStatus_01)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t devId = 65U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    RawDevice *dev = new RawDevice(devId);
    ret = rtInstance->SetWatchDogDevStatus(dev, deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_ID);
    ret = rtInstance->GetWatchDogDevStatus(devId, &deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_ID);
    delete dev;
}

TEST_F(RuntimeTest910B, ut_SetAndGetWatchDogDevStatus_02)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t devId = 0U;
    uint32_t tsId = 3U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    RawDevice *dev = new RawDevice(devId);
    dev->DevSetTsId(tsId);
    ret = rtInstance->SetWatchDogDevStatus(dev, deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_ID);
    ret = rtInstance->GetWatchDogDevStatus(devId, &deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(RuntimeTest910B, ut_SetAndGetWatchDogDevStatus_03)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t devId = 0U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_ABNORMAL;
    RawDevice *dev = new RawDevice(devId);
    ret = rtInstance->SetWatchDogDevStatus(dev, deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtInstance->GetWatchDogDevStatus(devId, &deviceStatus);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(deviceStatus, RT_DEVICE_STATUS_ABNORMAL);
    delete dev;
}

TEST_F(RuntimeTest910B, ut_SetAndGetWatchDogDevStatus_04)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    uint32_t devId = 0U;
    uint32_t tsId = 1U;
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_ABNORMAL;
    RawDevice *dev = new RawDevice(devId);
    dev->DevSetTsId(tsId);
    for (uint32_t i = 0; i < 2; i++) {
        ret = rtInstance->SetWatchDogDevStatus(dev, deviceStatus);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        usleep(100000);
    }
    delete dev;
}

TEST_F(RuntimeTest910B, SetTimeoutConfig_test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t oldSocType = rtInstance->GetSocType();
    bool oldflag1 = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
    bool oldflag2 = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;

    rtInstance->SetSocType(oldSocType);
    rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = oldflag1;
    rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = oldflag2;
}

TEST_F(RuntimeTest910B, RuntimeGetEnvPath_test1)
{
    std::string binaryPath;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    char_t * const getPath = "/usr/local/Ascend/CANN-7.0/fwkacllib/lib64/";
    MOCKER(getenv).stubs().will(returnValue(getPath));
    rtError_t ret = rtInstance->GetEnvPath(binaryPath);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
}

TEST_F(RuntimeTest910B, RuntimeGetEnvPath_test2)
{
    std::string binaryPath;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    char_t * const getPath1 = "/usr/local/HiAI/latest/runtime/lib64:/usr/local/Ascend/CANN-7.0/fwkacllib/lib64:";
    MOCKER(getenv).stubs().will(returnValue(getPath1));
    rtError_t ret = rtInstance->GetEnvPath(binaryPath);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(RuntimeTest910B, RuntimeGetKernelBinTest)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    char_t *envValue = ":fwkacllib/lib64:";
    MOCKER(getenv).stubs().will(returnValue(envValue));
    char_t *buffer = nullptr;
    uint32_t length;
    char_t *soName = "name";
    rtError_t ret = rtInstance->GetKernelBin(soName, &buffer, &length);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
}

TEST_F(RuntimeTest910B, GetKernelBinByFileName_test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    char_t *binFileName = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o";
    char_t *buffer = nullptr;
    uint32_t length;
    rtError_t ret = rtInstance->GetKernelBinByFileName(binFileName, &buffer, &length);
    ret = rtInstance->FreeKernelBin(buffer);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(RuntimeTest910B, MIX_KERNEL_test_1)
{
    const int NAME_MAX_LENGTH = 256U;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RtKernel kernel = {};
    kernel.name =  new (std::nothrow) char[NAME_MAX_LENGTH];

    uint8_t mixType;
    uint32_t kernelType;


    /* aicore */
    memset_s(kernel.name, NAME_MAX_LENGTH, 0, NAME_MAX_LENGTH);
    memcpy_s(kernel.name, NAME_MAX_LENGTH, "add", strlen("add"));
    kernel.funcType = KERNEL_FUNCTION_TYPE_AICORE;
    kernel.crossCoreSync = FUNC_NO_USE_SYNC;

    rtError_t ret = rtInstance->GetMixTypeAndKernelType(&kernel, mixType, kernelType);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(mixType, NO_MIX);
    EXPECT_EQ(kernelType, 0);

    /* aic */
    kernel.funcType = KERNEL_FUNCTION_TYPE_AIC;
    kernel.crossCoreSync = FUNC_USE_SYNC;

    ret = rtInstance->GetMixTypeAndKernelType(&kernel, mixType, kernelType);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(mixType, MIX_AIC);
    EXPECT_EQ(kernelType, 0);

    /* aiv */
    kernel.funcType = KERNEL_FUNCTION_TYPE_AIV;
    kernel.crossCoreSync = FUNC_USE_SYNC;

    ret = rtInstance->GetMixTypeAndKernelType(&kernel, mixType, kernelType);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(mixType, MIX_AIV);
    EXPECT_EQ(kernelType, 2);

    /* aic_main/aiv_main */
    kernel.funcType = KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN;

    ret = rtInstance->GetMixTypeAndKernelType(&kernel, mixType, kernelType);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    memset_s(kernel.name, NAME_MAX_LENGTH, 0, NAME_MAX_LENGTH);
    memcpy_s(kernel.name, NAME_MAX_LENGTH, "add_mix_aic", strlen("add_mix_aic"));
    ret = rtInstance->GetMixTypeAndKernelType(&kernel, mixType, kernelType);
    EXPECT_EQ(mixType, MIX_AIC);
    memset_s(kernel.name, NAME_MAX_LENGTH, 0, NAME_MAX_LENGTH);
    memcpy_s(kernel.name, NAME_MAX_LENGTH, "add_mix_aiv", strlen("add_mix_aiv"));
    ret = rtInstance->GetMixTypeAndKernelType(&kernel, mixType, kernelType);
    EXPECT_EQ(mixType, MIX_AIV);
    delete [] kernel.name;
}

TEST_F(RuntimeTest910B, MIX_KERNEL_test_2)
{
    const int NAME_MAX_LENGTH = 256U;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RtKernel kernel = {};
    kernel.name =  new (std::nothrow) char[NAME_MAX_LENGTH];
    uint8_t mixType;
    uint32_t kernelType;

    /* aicore */
    memset_s(kernel.name, NAME_MAX_LENGTH, 0, NAME_MAX_LENGTH);
    memcpy_s(kernel.name, NAME_MAX_LENGTH, "add", strlen("add"));
    kernel.funcType = KERNEL_FUNCTION_TYPE_AICORE;
    kernel.crossCoreSync = FUNC_NO_USE_SYNC;

    std::string kernelName = rtInstance->AdjustKernelName(&kernel, NO_MIX);
    bool isSame = kernelName.compare("add") == 0;
    EXPECT_EQ(isSame, true);

    kernel.funcType = KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN;
    kernelName = rtInstance->AdjustKernelName(&kernel, MIX_AIC);
    isSame = kernelName.compare("add") == 0;
    EXPECT_EQ(isSame, false);

    /* mix aic */
    memset_s(kernel.name, NAME_MAX_LENGTH, 0, NAME_MAX_LENGTH);
    memcpy_s(kernel.name, NAME_MAX_LENGTH, "add_mix_aic", strlen("add_mix_aic"));
    kernel.funcType = KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN;
    kernel.crossCoreSync = FUNC_USE_SYNC;

    kernelName = rtInstance->AdjustKernelName(&kernel, MIX_AIC);
    isSame = kernelName.compare("add") == 0;
    EXPECT_EQ(isSame, true);

    /* mix aiv */
    memset_s(kernel.name, NAME_MAX_LENGTH, 0, NAME_MAX_LENGTH);
    memcpy_s(kernel.name, NAME_MAX_LENGTH, "add_mix_aiv", strlen("add_mix_aiv"));
    kernel.funcType = KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN;
    kernel.crossCoreSync = FUNC_USE_SYNC;

    kernelName = rtInstance->AdjustKernelName(&kernel, MIX_AIV);
    isSame = kernelName.compare("add") == 0;
    EXPECT_EQ(isSame, true);

    /* mix aic rollback */
    memset_s(kernel.name, NAME_MAX_LENGTH, 0, NAME_MAX_LENGTH);
    memcpy_s(kernel.name, NAME_MAX_LENGTH, "add_mix_aic", strlen("add_mix_aic"));
    kernel.funcType = KERNEL_FUNCTION_TYPE_AIC_ROLLBACK;
    kernel.crossCoreSync = FUNC_USE_SYNC;

    kernelName = rtInstance->AdjustKernelName(&kernel, MIX_AIC);
    isSame = kernelName.compare("add") == 0;
    EXPECT_EQ(isSame, true);

    /* mix aiv rollback */
    memset_s(kernel.name, NAME_MAX_LENGTH, 0, NAME_MAX_LENGTH);
    memcpy_s(kernel.name, NAME_MAX_LENGTH, "add_mix_aiv", strlen("add_mix_aiv"));
    kernel.funcType = KERNEL_FUNCTION_TYPE_AIV_ROLLBACK;
    kernel.crossCoreSync = FUNC_USE_SYNC;

    kernelName = rtInstance->AdjustKernelName(&kernel, MIX_AIV);
    isSame = kernelName.compare("add") == 0;
    EXPECT_EQ(isSame, true);
    delete [] kernel.name;
}

TEST_F(RuntimeTest910B, feature_version_1)
{
    FeatureToTsVersionInit();
    bool result = CheckFeatureIsSupportOld(16, static_cast<rtFeature>(10));
    EXPECT_EQ(result, false);

    uint32_t tschVersion = ((uint32_t)TS_BRANCH_V1R1C13 << 16) | 18;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, true);

    tschVersion = ((uint32_t)TS_BRANCH_V1R1C30 << 16) | 17;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, true);

    tschVersion = ((uint32_t)TS_BRANCH_V1R1C15 << 16) | 22;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, true);

    tschVersion = ((uint32_t)TS_BRANCH_TRUNK << 16) | 22;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, true);

    tschVersion = ((uint32_t)TS_BRANCH_TRUNK << 16) | 18;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX));
    EXPECT_EQ(result, false);

    tschVersion = ((uint32_t)TS_BRANCH_V1R1C17 << 16) | 26;
    result = CheckFeatureIsSupportOld(tschVersion,
        static_cast<rtFeature>(RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC));
    EXPECT_EQ(result, true);
}

class RuntimeTest2 : public testing::Test
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
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
    }
};

TEST_F(RuntimeTest910B, reset_device_forece_01)
{
    uint32_t devNum = 8;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    // 设置可用device
    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,2,3", 20);
    InitVisibleDevices();
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    auto ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 3);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    EXPECT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    EXPECT_EQ(rtDeviceResetForce(0), RT_ERROR_NONE);
    InitVisibleDevices();
}

TEST_F(RuntimeTest910B, set_default_device_id)
{
    uint32_t devNum = 8;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(0));
    // 设置可用device
    setenv("ASCEND_RT_VISIBLE_DEVICES", "1,2,3", 20);
    InitVisibleDevices();
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    auto ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 3);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    EXPECT_EQ(rtSetDefaultDeviceId(0), RT_ERROR_NONE);
    rtStream_t desStm;
    auto error = rtStreamCreate(&desStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    InitVisibleDevices();
    error = rtSetDefaultDeviceId(0xFFFFFFFF);
    EXPECT_EQ(error, RT_ERROR_NONE);
}