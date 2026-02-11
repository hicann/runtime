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
#include "osal/osal_thread.h"
#include "errno/error_code.h"
#include "hal/hal_prof.h"
#include "hal/hal_dsmi.h"
#include "ascend_hal.h"

class HalProfUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(HalProfUtest, HalGetApiVersionBase)
{
    int32_t ver = 1;
    MOCKER(halGetAPIVersion)
        .stubs()
        .with(outBoundP(&ver, sizeof(int32_t)))
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));
    uint32_t ret = HalGetApiVersion();
    EXPECT_EQ(ret, 1);
    ret = HalGetApiVersion();
    EXPECT_EQ(ret, 0);
}

TEST_F(HalProfUtest, HalGetPlatformInfoBase)
{
    uint32_t* platformInfo;
    MOCKER(drvGetPlatformInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));
    EXPECT_EQ(PROFILING_SUCCESS, HalGetPlatformInfo(platformInfo));
    EXPECT_EQ(PROFILING_SUCCESS, HalGetPlatformInfo(platformInfo));
}

TEST_F(HalProfUtest, HalGetDeviceNumberBase)
{
    uint32_t devNum = 1;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(uint32_t)))
        .will(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(1, HalGetDeviceNumber());
    GlobalMockObject::verify();
    uint32_t devNums = 65;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNums, sizeof(uint32_t)))
        .will(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(0, HalGetDeviceNumber());
}

TEST_F(HalProfUtest, HalGetDeviceIdsBase)
{
    EXPECT_EQ(0, HalGetDeviceIds(1, NULL, 0));
    EXPECT_EQ(0, HalGetDeviceIds(65, NULL, 64));

    uint32_t devIds[64] = {0};
    MOCKER(drvGetDevIDs)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));
    EXPECT_EQ(1, HalGetDeviceIds(1, devIds, 64));
    EXPECT_EQ(0, HalGetDeviceIds(1, devIds, 64));
}

TEST_F(HalProfUtest, HalGetDeviceInfoBase)
{
    int64_t value[64] = {0};
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));
    EXPECT_EQ(PROFILING_SUCCESS, HalGetDeviceInfo(SYSTEM_SYS_COUNT, 0, value));
    EXPECT_EQ(PROFILING_SUCCESS, HalGetDeviceInfo(SYSTEM_HOST_OSC_FREQUE, 0, value));
}

TEST_F(HalProfUtest, HalGetHostFreqBase)
{
    int64_t hostFreq = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&hostFreq, sizeof(int64_t)))
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    EXPECT_EQ(1, HalGetHostFreq());
    EXPECT_EQ(0, HalGetHostFreq());
}

TEST_F(HalProfUtest, HalGetChipVersionBase)
{
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(0, HalGetChipVersion());
}

TEST_F(HalProfUtest, HalGetChipVersionBase2)
{
    int64_t info = -1;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .with(any(), any(), any(), outBoundP(&info, sizeof(info)))
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(0, HalGetChipVersion());
}

TEST_F(HalProfUtest, HalGetDeviceFreqBase)
{
    int64_t info = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&info, sizeof(info)))
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(1, HalGetDeviceFreq(0));
}

TEST_F(HalProfUtest, HalProfChannelStartBase)
{
    ChannelStartPara para[10] = {};
    MOCKER(prof_drv_start)
        .stubs()
        .will(returnValue(PROF_ERROR))
        .then(returnValue(PROF_OK));
    EXPECT_EQ(PROFILING_FAILED, HalProfChannelStart(0, 0, para));
    EXPECT_EQ(PROFILING_SUCCESS, HalProfChannelStart(0, 0, para));
}

TEST_F(HalProfUtest, HalProfChannelPollBase)
{
    ChannelPollInfo info[10] = {};
    MOCKER(prof_channel_poll)
        .stubs()
        .will(returnValue(2))
        .then(returnValue(1));
    EXPECT_EQ(2, HalProfChannelPoll(info, 1, 1));
    EXPECT_EQ(1, HalProfChannelPoll(info, 1, 1));
}

TEST_F(HalProfUtest, HalProfChannelReadBase)
{
    MOCKER(prof_channel_read)
        .stubs()
        .will(returnValue(PROF_STOPPED_ALREADY))
        .then(returnValue(PROF_ERROR))
        .then(returnValue(10));
    EXPECT_EQ(0, HalProfChannelRead(0, 0, NULL, 0));
    EXPECT_EQ(PROFILING_FAILED, HalProfChannelRead(0, 0, NULL, 0));
    EXPECT_EQ(10, HalProfChannelRead(0, 0, NULL, 0));
}

TEST_F(HalProfUtest, HalProfGetChannelListBase)
{
    ChannelList chanList[100] = {};
    MOCKER(prof_drv_get_channels)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalProfGetChannelList(0, chanList));
    EXPECT_EQ(PROFILING_SUCCESS,  HalProfGetChannelList(0, chanList));
}

TEST_F(HalProfUtest, HalGetEnvTypeBase)
{
    int64_t envType = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&envType, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetEnvType(0));
    EXPECT_EQ(1,  HalGetEnvType(0));
}

TEST_F(HalProfUtest, HalGetCtrlCpuIdBase)
{
    int64_t ctrlCpuId = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&ctrlCpuId, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetCtrlCpuId(0));
    EXPECT_EQ(1,  HalGetCtrlCpuId(0));
}

TEST_F(HalProfUtest, HalGetCtrlCpuCoreNumBase)
{
    int64_t ctrlCpuCoreNum = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&ctrlCpuCoreNum, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetCtrlCpuCoreNum(0));
    EXPECT_EQ(1,  HalGetCtrlCpuCoreNum(0));
}

TEST_F(HalProfUtest, HalGetCtrlCpuEndianLittleBase)
{
    int64_t ctrlCpuEndianLittle = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&ctrlCpuEndianLittle, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetCtrlCpuEndianLittle(0));
    EXPECT_EQ(1,  HalGetCtrlCpuEndianLittle(0));
}

TEST_F(HalProfUtest, HalGetAiCpuCoreNumBase)
{
    int64_t aiCpuCoreNum = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&aiCpuCoreNum, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetAiCpuCoreNum(0));
    EXPECT_EQ(1,  HalGetAiCpuCoreNum(0));
}

TEST_F(HalProfUtest, HalGetAiCpuCoreIdBase)
{
    int64_t aiCpuCoreId = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&aiCpuCoreId, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetAiCpuCoreId(0));
    EXPECT_EQ(1,  HalGetAiCpuCoreId(0));
}

TEST_F(HalProfUtest, HalGetAiCpuOccupyBitmapBase)
{
    int64_t aiCpuOccupyBitmap = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&aiCpuOccupyBitmap, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetAiCpuOccupyBitmap(0));
    EXPECT_EQ(1,  HalGetAiCpuOccupyBitmap(0));
}

TEST_F(HalProfUtest, HalGetTsCpuCoreNumBase)
{
    int64_t tsCpuCoreNum = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&tsCpuCoreNum, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetTsCpuCoreNum(0));
    EXPECT_EQ(1,  HalGetTsCpuCoreNum(0));
}

TEST_F(HalProfUtest, HalGetAiCoreIdBase)
{
    int64_t aiCoreId = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&aiCoreId, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetAiCoreId(0));
    EXPECT_EQ(1,  HalGetAiCoreId(0));
}

TEST_F(HalProfUtest, HalGetAiCoreNumBase)
{
    int64_t aiCoreNum = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&aiCoreNum, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetAiCoreNum(0));
    EXPECT_EQ(1,  HalGetAiCoreNum(0));
}

TEST_F(HalProfUtest, HalGetAicFrqBase)
{
    int64_t aiCoreFreq = 1000;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&aiCoreFreq, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetAicFrq(0));
    EXPECT_EQ(1000,  HalGetAicFrq(0));
}

TEST_F(HalProfUtest, HalGetAiVectorCoreNumBase)
{
    int64_t aiVecCoreNum = 1;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&aiVecCoreNum, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetAiVectorCoreNum(0));
    EXPECT_EQ(1,  HalGetAiVectorCoreNum(0));
}

TEST_F(HalProfUtest, HalGetAivFeqBase)
{
    int64_t aiVecCoreFreq = 1000;
    MOCKER(HalGetDeviceInfo)
        .stubs()
        .with(any(), any(), outBoundP(&aiVecCoreFreq, sizeof(int64_t)))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED,  HalGetAivFeq(0));
    EXPECT_EQ(1000,  HalGetAivFeq(0));
}