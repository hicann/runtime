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

class ChipRuntimeTest : public testing::Test
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
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
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

TEST_F(ChipRuntimeTest, binanry_reg_mix_null_data)
{
    rtError_t error;
    Program *program;
    rtDevBinary_t bin;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    bin.magic = RT_DEV_BINARY_MAGIC_ELF;
    bin.version = 1;
    bin.data = NULL;
    bin.length = 0;
    error = rtInstance->ProgramRegister(&bin, &program);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ChipRuntimeTest, SocTypeInit)
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
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    rtInstance->CheckVirtualMachineMode(aicoreNum, virAicoreNum);
}


TEST_F(ChipRuntimeTest, MacroInit)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_NE(rtInstance, nullptr);

    rtInstance->MacroInit(CHIP_CLOUD);

    rtInstance->MacroInit(CHIP_ADC);

    rtInstance->MacroInit(CHIP_DC);

    rtInstance->MacroInit(CHIP_END);

    rtInstance->MacroInit(CHIP_AS31XM1);

    rtInstance->MacroInit(CHIP_610LITE);

    rtInstance->MacroInit(CHIP_END);

    rtInstance->MacroInit(CHIP_AS31XM1);

    rtInstance->MacroInit(CHIP_610LITE);
}

TEST_F(ChipRuntimeTest, AicpuCntInitTest_02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = rtInstance->GetSocType();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    rtInstance->SetSocType(SOC_AS31XM1X);
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_DEVICE));
    rtError_t error  = rtInstance->InitAiCpuCnt();
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_DEVICE);
    rtInstance->SetSocType(socType);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ChipRuntimeTest, AicpuCntInitTest_03)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = rtInstance->GetSocType();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    rtInstance->SetSocType(SOC_AS31XM1X);
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtError_t error  = rtInstance->InitAiCpuCnt();
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetSocType(socType);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ChipRuntimeTest, ut_SetSocTypeByChipType)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtSocType_t oriSocType = rtInstance->GetSocType();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtError_t ret = rtInstance->SetSocTypeByChipType(PLAT_COMBINE(ARCH_V200, CHIP_ADC, VER_LITE), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(oriSocType);
}

TEST_F(ChipRuntimeTest, ut_SetSocTypeByChipType_as31xm1)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtSocType_t oriSocType = rtInstance->GetSocType();
    rtInstance->SetChipType(CHIP_AS31XM1);
    GlobalContainer::SetRtChipType(CHIP_AS31XM1);
    rtError_t ret = rtInstance->SetSocTypeByChipType(PLAT_COMBINE(ARCH_M300, CHIP_AS31XM1, VER_NA), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(oriSocType);
}


TEST_F(ChipRuntimeTest, ut_SetSocTypeByChipType_610lite)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtSocType_t oriSocType = rtInstance->GetSocType();
    rtInstance->SetChipType(CHIP_610LITE);
    GlobalContainer::SetRtChipType(CHIP_610LITE);
    rtError_t ret = rtInstance->SetSocTypeByChipType(PLAT_COMBINE(ARCH_M310, CHIP_610LITE, VER_NA), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(oriSocType);
}

TEST_F(ChipRuntimeTest, ut_SetSocTypeByChipType02)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtSocType_t oriSocType = rtInstance->GetSocType();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtError_t ret = rtInstance->SetSocTypeByChipType(PLAT_COMBINE(ARCH_V300, CHIP_ADC, VER_310M1), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(oriSocType);
}


TEST_F(ChipRuntimeTest, ut_InitSocTypeFromVersion)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtInstance->InitSocTypeFrom310BVersion((PLAT_COMBINE(ARCH_V300, CHIP_MINI_V3, RT_VER_BIN4)));
    rtInstance->InitSocTypeFrom310BVersion((PLAT_COMBINE(ARCH_END, CHIP_END, RT_VER_END)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN0)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN1)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN2)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN3)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN4)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN5)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN6)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN7)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN11)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN12)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN13)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN14)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN15)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN16)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN17)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN18)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN19)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN20)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN21)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN22)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN23)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN24)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN34)));
    rtInstance->InitSocTypeFrom910Version((PLAT_COMBINE(ARCH_V100, CHIP_DAVID, PG_VER_BIN35)));
}


TEST_F(ChipRuntimeTest, ut_HwtsLogDynamicProfilerStartStopSTTest)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
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

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
}

TEST_F(ChipRuntimeTest, ut_GetVisibleDevicesByChipCloudTest0)
{
    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
    rtError_t ret = 0;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    bool haveDevice = rtInstance->isHaveDevice_;
    uint32_t devNum = 3;

    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtInstance->isHaveDevice_ = true;
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, false);

    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    rtInstance->isHaveDevice_ = false;
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, false);

    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    rtInstance->isHaveDevice_ = true;
    InitVisibleDevices();
    ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->userDeviceCnt, 0);
    EXPECT_EQ(rtInstance->isSetVisibleDev, false);

    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    rtInstance->isHaveDevice_ = true;
    InitVisibleDevices();
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
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
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


TEST_F(ChipRuntimeTest, ut_GetVisibleDevicesByChipCloudTest1)
{
    rtError_t ret = 0;
    uint32_t userDeviceid = 5;
    uint32_t deviceid = 0;
    uint32_t devNum = 3;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
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
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(deviceid, 1);
    rtInstance->isSetVisibleDev = false;
    rtInstance->isHaveDevice_ = haveDevice;
    delete profiler;
}

TEST_F(ChipRuntimeTest, ut_GetVisibleDevicesByChipCloudTest2)
{
    rtError_t ret = 0;
    uint32_t userDeviceid = 5;
    uint32_t deviceid = 0;
    uint32_t devNum = 3;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
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
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(deviceid, 0);
    rtInstance->isSetVisibleDev = false;
    rtInstance->isHaveDevice_ = haveDevice;
}

TEST_F(ChipRuntimeTest, ut_AiCpuProfilerStart_00)
{
    rtError_t ret = 0;
    uint32_t deviceList[5]={1,2,3,4,5};

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_ASCEND_031);
    GlobalContainer::SetRtChipType(CHIP_ASCEND_031);
    ret = rtInstance->AiCpuProfilerStart(1, 5, deviceList);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}