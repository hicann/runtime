/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "common/enum_log.hpp"
#include "runtime/base.h"
#include <string>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "stream.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "tprt.hpp"
#include "base.h"
#include "utils.h"
#include "npu_driver.hpp"
#include "xpu_device.hpp"
#include "api_impl_xpu.hpp"
#undef protected
#undef private
#include "xpu_stub.h"

namespace cce {
namespace runtime {
rtError_t XpuProfilingHandle(uint32_t type, void* data, uint32_t len);
}
} // namespace cce

void ClearLastDlogRecordLine();
bool DlogRecordContains(const std::string& keyword);

using namespace cce::runtime;

class XpuApiImplTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp() { cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage(); }

    virtual void TearDown()
    {
        DELETE_O(cce::tprt::TprtManage::tprt_);
        GlobalMockObject::verify();
    }
};

TEST_F(XpuApiImplTest, GetXpuDevCount_Success_DPU)
{
    uint32_t devCount = 0;
    rtError_t error = ApiImplXpu().GetXpuDevCount(RT_DEV_TYPE_DPU, &devCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(devCount, 1U);
}

TEST_F(XpuApiImplTest, GetXpuDevCount_Failed_InvalidType)
{
    uint32_t devCount = 0;
    rtError_t error = ApiImplXpu().GetXpuDevCount(static_cast<rtXpuDevType>(99), &devCount);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuApiImplTest, GetXpuDevCount_Failed_NullPtr)
{
    rtError_t error = ApiImplXpu().GetXpuDevCount(RT_DEV_TYPE_DPU, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuApiImplTest, SetXpuDevice_Failed_InvalidType)
{
    rtError_t error = ApiImplXpu().SetXpuDevice(RT_DEV_TYPE_REV, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuApiImplTest, SetXpuDevice_Failed_InvalidDevId)
{
    rtError_t error = ApiImplXpu().SetXpuDevice(RT_DEV_TYPE_DPU, 1);
    EXPECT_EQ(error, RT_ERROR_DEVICE_ID);
}

TEST_F(XpuApiImplTest, SetXpuDevice_Success)
{
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    ClearLastDlogRecordLine();
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    rtError_t error = ApiImplXpu().SetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_TRUE(DlogRecordContains("drv devId=0, devType=DEV_TYPE_DPU(0)."));
#else
    EXPECT_TRUE(DlogRecordContains("drv devId=0, devType=0."));
#endif
    // Cleanup
    (void)ApiImplXpu().ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Success_Start)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    (void)ApiImplXpu().SetXpuDevice(RT_DEV_TYPE_DPU, 0);

    rtProfCommandHandle_t profilerConfig = {};
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    rtError_t error = XpuProfilingHandle(PROF_CTRL_SWITCH, &profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    // Cleanup
    (void)ApiImplXpu().ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Success_Stop)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    (void)ApiImplXpu().SetXpuDevice(RT_DEV_TYPE_DPU, 0);

    rtProfCommandHandle_t profilerConfig = {};
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    rtError_t error = XpuProfilingHandle(PROF_CTRL_SWITCH, &profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    // Cleanup
    (void)ApiImplXpu().ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Failed_InvalidType)
{
    rtProfCommandHandle_t profilerConfig = {};
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    rtError_t error = XpuProfilingHandle(99, &profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Failed_NullData)
{
    rtError_t error = XpuProfilingHandle(PROF_CTRL_SWITCH, nullptr, sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Failed_InvalidLen)
{
    rtProfCommandHandle_t profilerConfig = {};
    rtError_t error = XpuProfilingHandle(PROF_CTRL_SWITCH, &profilerConfig, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuApiImplTest, ResetXpuDevice_Success)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    (void)ApiImplXpu().SetXpuDevice(RT_DEV_TYPE_DPU, 0);

    rtError_t error = ApiImplXpu().ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
