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
#define protected public
#include "kernel.hpp"
#include "program.hpp"
#include "arg_loader_xpu.hpp"
#include "stream_xpu.hpp"
#include "xpu_context.hpp"
#include "tprt_worker.hpp"
#include "stream.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "tprt.hpp"
#include "inner_thread_local.hpp"
#include "task_res_da.hpp"
#include "task_xpu.hpp"
#include "base.h"
#include "task_info.hpp"
#include "task_info_base.hpp"
#include "tprt_error_code.h"
#include "xpu_aicpu_c.hpp"
#include "arg_manage_david.hpp"
#include "utils.h"
#include "npu_driver.hpp"
#include "para_convertor.hpp"
#include "xpu_kernel_task.h"
#include "arg_manage_xpu.hpp"
#include "api_impl_david.hpp"
#undef protected
#undef private
#include "xpu_stub.h"

using namespace cce::runtime;

class XpuApiImplTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
        cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    }

    virtual void TearDown()
    {
        DELETE_O(cce::tprt::TprtManage::tprt_);
        GlobalMockObject::verify();
    }
};

TEST_F(XpuApiImplTest, GetXpuDevCount_Success_DPU)
{
    uint32_t devCount = 0;
    rtError_t error = ApiImpl().GetXpuDevCount(RT_DEV_TYPE_DPU, &devCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(devCount, 1U);
}

TEST_F(XpuApiImplTest, GetXpuDevCount_Failed_InvalidType)
{
    uint32_t devCount = 0;
    rtError_t error = ApiImpl().GetXpuDevCount(static_cast<rtXpuDevType>(99), &devCount);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuApiImplTest, SetXpuDevice_Success)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    rtError_t error = ApiImpl().SetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // Cleanup
    (void)ApiImpl().ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Success_Start)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    (void)ApiImpl().SetXpuDevice(RT_DEV_TYPE_DPU, 0);

    rtProfCommandHandle_t profilerConfig = {};
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    rtError_t error = ApiImpl().XpuProfilingCommandHandle(PROF_CTRL_SWITCH, &profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    // Cleanup
    (void)ApiImpl().ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Success_Stop)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    (void)ApiImpl().SetXpuDevice(RT_DEV_TYPE_DPU, 0);

    rtProfCommandHandle_t profilerConfig = {};
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    rtError_t error = ApiImpl().XpuProfilingCommandHandle(PROF_CTRL_SWITCH, &profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    // Cleanup
    (void)ApiImpl().ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Failed_InvalidType)
{
    rtProfCommandHandle_t profilerConfig = {};
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    rtError_t error = ApiImpl().XpuProfilingCommandHandle(99, &profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Failed_NullData)
{
    rtError_t error = ApiImpl().XpuProfilingCommandHandle(PROF_CTRL_SWITCH, nullptr, sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuApiImplTest, XpuProfilingCommandHandle_Failed_InvalidLen)
{
    rtProfCommandHandle_t profilerConfig = {};
    rtError_t error = ApiImpl().XpuProfilingCommandHandle(PROF_CTRL_SWITCH, &profilerConfig, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuApiImplTest, ResetXpuDevice_Success)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    (void)ApiImpl().SetXpuDevice(RT_DEV_TYPE_DPU, 0);

    rtError_t error = ApiImpl().ResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
