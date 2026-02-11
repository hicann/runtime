/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mmpa_api.h"
#include "osal/osal.h"
#include "osal/osal_mem.h"
#include "errno/error_code.h"
#include "hal/hal_prof.h"
#include "hal/hal_dsmi.h"
#include "platform.h"
#include "platform_define.h"
#include "platform_table.h"
#include "platform_interface.h"
#include "platform_feature.h"
#include "chip/chip_nano_v1.h"

class PlatformUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(PlatformUtest, PlatformBaseFeature)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_DC)))
        .then(returnValue(uint32_t(CHIP_NANO_V1)));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_FAILED);

    ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // support
    bool retVal = IsSupportFeature(PLATFORM_TASK_SCALAR_RATIO_PMU);
    EXPECT_EQ(retVal, true);
    retVal = IsSupportFeature(PLATFORM_TASK_PU_PMU);
    EXPECT_EQ(retVal, true);
    retVal = IsSupportFeature(PLATFORM_TASK_PSC_PMU);
    EXPECT_EQ(retVal, true);
    retVal = IsSupportFeature(PLATFORM_TASK_MEMORY_PMU);
    EXPECT_EQ(retVal, true);
    retVal = IsSupportFeature(PLATFORM_TASK_MEMORYUB_PMU);
    EXPECT_EQ(retVal, true);
    retVal = IsSupportFeature(PLATFORM_TASK_TRACE);
    EXPECT_EQ(retVal, true);
    retVal = IsSupportFeature(PLATFORM_TASK_AIC_METRICS);
    EXPECT_EQ(retVal, true);
    retVal = IsSupportFeature(PLATFORM_TASK_SWITCH);
    EXPECT_EQ(retVal, true);

    retVal = IsSupportSwitch("ScalarRatio");
    EXPECT_EQ(retVal, true);
    retVal = IsSupportSwitch("PipeUtilization");
    EXPECT_EQ(retVal, true);
    retVal = IsSupportSwitch("PipeStallCycle");
    EXPECT_EQ(retVal, true);
    retVal = IsSupportSwitch("Memory");
    EXPECT_EQ(retVal, true);
    retVal = IsSupportSwitch("MemoryUB");
    EXPECT_EQ(retVal, true);
    retVal = IsSupportSwitch("task_trace");
    EXPECT_EQ(retVal, true);
    retVal = IsSupportSwitch("aic_metrics");
    EXPECT_EQ(retVal, true);
    retVal = IsSupportSwitch("switch");
    EXPECT_EQ(retVal, true);
    // not support
    retVal = IsSupportFeature(PLATFORM_TASK_BLOCK);
    EXPECT_EQ(retVal, false);
    retVal = IsSupportFeature(PLATFORM_TASK_MEMORY);
    EXPECT_EQ(retVal, false);

    retVal = IsSupportSwitch("Switch");
    EXPECT_EQ(retVal, false);
    retVal = IsSupportSwitch("aiv_metrics");
    EXPECT_EQ(retVal, false);
    PlatformFinalize(&count);
    // not init
    retVal = IsSupportSwitch("switch");
    EXPECT_EQ(retVal, false);
    retVal = IsSupportFeature(PLATFORM_TASK_SWITCH);
    EXPECT_EQ(retVal, false);
}

TEST_F(PlatformUtest, PlatformBaseMetrics)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_NANO_V1)));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // support
    char events[PMU_EVENT_LENGTH] = { 0 };
    bool retVal = PlatformGetMetricsEvents("ScalarRatio", events, PMU_EVENT_LENGTH);
    EXPECT_EQ(retVal, true);
    EXPECT_EQ(0, strcmp(events, "0x103,0x104,0x105"));
    (void)memset_s(events, PMU_EVENT_LENGTH, 0, PMU_EVENT_LENGTH);
    retVal = PlatformGetMetricsEvents("PipeUtilization", events, PMU_EVENT_LENGTH);
    EXPECT_EQ(retVal, true);
    EXPECT_EQ(0, strcmp(events, "0x300,0x400,0x100,0x200,0x201,0x202,0x302,0x203,0x101,0x102"));
    (void)memset_s(events, PMU_EVENT_LENGTH, 0, PMU_EVENT_LENGTH);
    retVal = PlatformGetMetricsEvents("PipeStallCycle", events, PMU_EVENT_LENGTH);
    EXPECT_EQ(retVal, true);
    EXPECT_EQ(0, strcmp(events, "0x406,0x305,0x600,0x601,0x602,0x603,0x604,0x605,0x606,0x607"));
    (void)memset_s(events, PMU_EVENT_LENGTH, 0, PMU_EVENT_LENGTH);
    retVal = PlatformGetMetricsEvents("Memory", events, PMU_EVENT_LENGTH);
    EXPECT_EQ(retVal, true);
    EXPECT_EQ(0, strcmp(events, "0x201,0x202,0x204,0x205"));
    (void)memset_s(events, PMU_EVENT_LENGTH, 0, PMU_EVENT_LENGTH);
    retVal = PlatformGetMetricsEvents("MemoryUB", events, PMU_EVENT_LENGTH);
    EXPECT_EQ(retVal, true);
    EXPECT_EQ(0, strcmp(events, "0x206,0x207,0x208,0x209,0x303,0x304,0x106,0x107"));
    (void)memset_s(events, PMU_EVENT_LENGTH, 0, PMU_EVENT_LENGTH);
    // not support
    retVal = PlatformGetMetricsEvents("ArithmeticUtilization", events, PMU_EVENT_LENGTH);
    EXPECT_EQ(retVal, false);
    PlatformFinalize(&count);
    // not init
    retVal = PlatformGetMetricsEvents("MemoryUB", events, PMU_EVENT_LENGTH);
    EXPECT_EQ(retVal, false);

}

TEST_F(PlatformUtest, PlatformBaseOther)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_NANO_V1)));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = PlatformGetAicFreq();
    EXPECT_EQ(ret, 333);
    ret = PlatformGetAivFreq();
    EXPECT_EQ(ret, 333);
    ret = PlatformGetDevNum();
    EXPECT_EQ(ret, 1);
    PlatformFinalize(&count);
    // not init
    ret = PlatformGetAicFreq();
    EXPECT_EQ(ret, 0);
    ret = PlatformGetAivFreq();
    EXPECT_EQ(ret, 0);
    ret = PlatformGetDevNum();
    EXPECT_EQ(ret, 0);
}

TEST_F(PlatformUtest, PlatformGetDefaultMetricsBase)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_NANO_V1)));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    char* metrics = PlatformGetDefaultMetrics();
    EXPECT_EQ(strcmp(metrics, "PipeUtilization"), 0);
    PlatformFinalize(&count);
    // not init
    char* metrics2 = PlatformGetDefaultMetrics();
    EXPECT_EQ((metrics2 == NULL), true);
}

TEST_F(PlatformUtest, PlatformGetDefaultDevFreqBase)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_NANO_V1)));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    uint64_t devFreq = PlatformGetDefaultDevFreq();
    EXPECT_EQ(devFreq, (uint64_t)NANO_HWTS_DEFAULT_FREQ);
    PlatformFinalize(&count);
    // not init
    devFreq = PlatformGetDefaultDevFreq();
    EXPECT_EQ(devFreq, 0);
}

TEST_F(PlatformUtest, PlatformGetDevFreqBase)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_NANO_V1)));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    MOCKER(HalGetDeviceFreq)
        .stubs()
        .will(returnValue((uint64_t)50000))
        .then(returnValue((uint64_t)0));
    uint64_t devFreq = PlatformGetDevFreq(0);
    EXPECT_EQ(devFreq, 50);
    devFreq = PlatformGetDevFreq(0);
    EXPECT_EQ(devFreq, 50);
    PlatformFinalize(&count);
    // not init
    devFreq = PlatformGetDevFreq(0);
    EXPECT_EQ(devFreq, 0);
}

TEST_F(PlatformUtest, PlatformGetHostFreqBase)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_NANO_V1)));
    MOCKER(HalGetHostFreq)
        .stubs()
        .will(returnValue((uint64_t)10000));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    uint64_t hostFreq = PlatformGetHostFreq();
    EXPECT_EQ(hostFreq, 10);
    PlatformFinalize(&count);
    // not init
    hostFreq = PlatformGetHostFreq();
    EXPECT_EQ(hostFreq, 0);
}

TEST_F(PlatformUtest, PlatformGetVersionInfoBase)
{
    const char *versionInfo = PlatformGetVersionInfo();
    EXPECT_EQ(strcmp(versionInfo, "1.0"), 0);
}

TEST_F(PlatformUtest, IsSupportBitBase)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_NANO_V1)));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    EXPECT_EQ(IsSupportBit(PROF_AICORE_METRICS), true);
    EXPECT_EQ(IsSupportBit(PROF_AICPU_TRACE), false);
    PlatformFinalize(&count);
    // not init
    EXPECT_EQ(IsSupportBit(PROF_AICORE_METRICS), false);
}