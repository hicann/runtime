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
#include "dev_info_manage.h"
#include "thread_local_container.hpp"
#include "../../rt_utest_config_define.hpp"
#include "../../common/rt_utest_context_reset_helper.hpp"

#undef private

namespace cce {
namespace runtime {
void ParseIniFile(const std::string& socVersion, RtIniAttributes& iniAttrs);
}
}

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
        ut::ResetPrimaryDeviceIfActiveWithDeviceDown();
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

TEST_F(ChipRuntimeTest, UpdateDevProperties)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_NE(rtInstance, nullptr);

    rtInstance->UpdateDevProperties(CHIP_CLOUD, "Ascend910A");

    // Verify DevProperties values after UpdateDevProperties for CHIP_CLOUD
    DevProperties cloudProps;
    EXPECT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD, cloudProps), RT_ERROR_NONE);
    EXPECT_EQ(cloudProps.rtsqDepth, 4096U);
    EXPECT_EQ(Runtime::starsPendingMax_, cloudProps.rtsqDepth * 3U / 4U);

    rtInstance->UpdateDevProperties(CHIP_ADC, "Ascend610");

    rtInstance->UpdateDevProperties(CHIP_DC, "Ascend310P3");

    rtInstance->UpdateDevProperties(CHIP_END, "Ascend910A");

    rtInstance->UpdateDevProperties(CHIP_AS31XM1, "AS31XM1X");

    rtInstance->UpdateDevProperties(CHIP_610LITE, "Ascend610Lite");

    rtInstance->UpdateDevProperties(CHIP_END, "Ascend910A");

    rtInstance->UpdateDevProperties(CHIP_AS31XM1, "AS31XM1X");

    rtInstance->UpdateDevProperties(CHIP_610LITE, "Ascend610Lite");
}

TEST_F(ChipRuntimeTest, UpdateDevPropertiesFromIniAttrs_PartialOverride)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    DevProperties origProps;
    EXPECT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD, origProps), RT_ERROR_NONE);

    // Only set normalStreamDepth, leave others as 0 (should not override)
    RtIniAttributes iniAttrs = {};
    iniAttrs.normalStreamDepth = 8192U;

    rtInstance->UpdateDevPropertiesFromIniAttrs(CHIP_CLOUD, iniAttrs);

    DevProperties updatedProps;
    EXPECT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD, updatedProps), RT_ERROR_NONE);
    // normalStreamDepth overrides rtsqDepth
    EXPECT_EQ(updatedProps.rtsqDepth, 8192U);
    // normalStreamNum was 0, should keep original
    EXPECT_EQ(updatedProps.maxAllocStreamNum, origProps.maxAllocStreamNum);
    // hugeStreamNum was 0, should keep original
    EXPECT_EQ(updatedProps.maxAllocHugeStreamNum, origProps.maxAllocHugeStreamNum);

    // Restore original props
    SET_DEV_PROPERTIES(CHIP_CLOUD, origProps);
}

TEST_F(ChipRuntimeTest, ParseIniFile_Success)
{
    RtIniAttributes iniAttrs = {};
    ParseIniFile("LLT_ParseIniFile_Success", iniAttrs);

    EXPECT_EQ(iniAttrs.normalStreamNum, 64U);
    EXPECT_EQ(iniAttrs.normalStreamDepth, 8192U);
    EXPECT_EQ(iniAttrs.hugeStreamNum, 16U);
    EXPECT_EQ(iniAttrs.hugeStreamDepth, 4096U);
}

TEST_F(ChipRuntimeTest, ParseIniFile_MixedInvalidInput_KeepDefaultForBadFields)
{
    RtIniAttributes iniAttrs = {};
    ParseIniFile("LLT_ParseIniFile_Mixed", iniAttrs);

    EXPECT_EQ(iniAttrs.normalStreamNum, 0U);
    EXPECT_EQ(iniAttrs.normalStreamDepth, 0U);
    EXPECT_EQ(iniAttrs.hugeStreamNum, 0U);
    EXPECT_EQ(iniAttrs.hugeStreamDepth, 256U);
}

TEST_F(ChipRuntimeTest, ParseIniFile_QueryError_SkipRemainingFields)
{
    RtIniAttributes iniAttrs = {};
    ParseIniFile("LLT_ParseIniFile_QueryError", iniAttrs);

    EXPECT_EQ(iniAttrs.normalStreamNum, 0U);
    EXPECT_EQ(iniAttrs.normalStreamDepth, 0U);
    EXPECT_EQ(iniAttrs.hugeStreamNum, 0U);
    EXPECT_EQ(iniAttrs.hugeStreamDepth, 0U);
}

TEST_F(ChipRuntimeTest, AicpuCntInitTest_02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string socVersion = rtInstance->GetSocVersion();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    rtInstance->SetSocVersion("AS31XM1X");
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_DEVICE));
    rtError_t error  = rtInstance->InitAiCpuCnt();
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_DEVICE);
    rtInstance->SetSocVersion(socVersion);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ChipRuntimeTest, AicpuCntInitTest_03)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string socVersion = rtInstance->GetSocVersion();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    rtInstance->SetSocVersion("AS31XM1X");
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtError_t error  = rtInstance->InitAiCpuCnt();
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetSocVersion(socVersion);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ChipRuntimeTest, ut_GetSocVersionByHardwareVer)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    std::string oriSocVersion = rtInstance->GetSocVersion();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtError_t ret = rtInstance->GetSocVersionByHardwareVer(PLAT_COMBINE(ARCH_V200, CHIP_ADC, VER_LITE), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocVersion(oriSocVersion);
}

TEST_F(ChipRuntimeTest, ut_GetSocVersionByHardwareVer_as31xm1)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    std::string oriSocVersion = rtInstance->GetSocVersion();
    rtInstance->SetChipType(CHIP_AS31XM1);
    GlobalContainer::SetRtChipType(CHIP_AS31XM1);
    rtError_t ret = rtInstance->GetSocVersionByHardwareVer(PLAT_COMBINE(ARCH_M300, CHIP_AS31XM1, VER_NA), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocVersion(oriSocVersion);
}


TEST_F(ChipRuntimeTest, ut_GetSocVersionByHardwareVer_610lite)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    std::string oriSocVersion = rtInstance->GetSocVersion();
    rtInstance->SetChipType(CHIP_610LITE);
    GlobalContainer::SetRtChipType(CHIP_610LITE);
    rtError_t ret = rtInstance->GetSocVersionByHardwareVer(PLAT_COMBINE(ARCH_M310, CHIP_610LITE, VER_NA), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocVersion(oriSocVersion);
}

TEST_F(ChipRuntimeTest, ut_GetSocVersionByHardwareVer02)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    std::string oriSocVersion = rtInstance->GetSocVersion();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    rtError_t ret = rtInstance->GetSocVersionByHardwareVer(PLAT_COMBINE(ARCH_V300, CHIP_ADC, VER_310M1), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocVersion(oriSocVersion);
}

TEST_F(ChipRuntimeTest, ut_GetSocVersionByHardwareVerSelectiveChipFallback)
{
    Runtime* rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    std::string oriSocVersion = rtInstance->GetSocVersion();

    rtInstance->SetChipType(CHIP_910_B_93);
    GlobalContainer::SetRtChipType(CHIP_910_B_93);
    rtError_t ret = rtInstance->GetSocVersionByHardwareVer(PLAT_COMBINE(ARCH_V200, CHIP_910_B_93, VER_NA), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->GetRawSocVersion(), "Ascend910B4");

    rtInstance->SetChipType(CHIP_MINI);
    GlobalContainer::SetRtChipType(CHIP_MINI);
    ret = rtInstance->GetSocVersionByHardwareVer(PLAT_COMBINE(ARCH_V200, CHIP_MINI, VER_NA), 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->GetRawSocVersion(), "");

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocVersion(oriSocVersion);
}

TEST_F(ChipRuntimeTest, ut_InitSocTypeFromVersion)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtInstance->InitSocTypeFrom310BVersion((PLAT_COMBINE(ARCH_V300, CHIP_MINI_V3, RT_VER_BIN4)));
    rtInstance->InitSocTypeFrom310BVersion((PLAT_COMBINE(ARCH_END, CHIP_END, RT_VER_END)));
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
