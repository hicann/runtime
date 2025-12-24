/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "profiler.hpp"
#include "rdma_task.h"
#include "thread_local_container.hpp"
#include "platform/platform_info.h"

#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CloudV2DeviceResLimitTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        isCfgOpWaitTaskTimeout = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;
        isCfgOpExcTaskTimeout = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = false;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = false;
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = isCfgOpWaitTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = isCfgOpExcTaskTimeout;
        GlobalMockObject::verify();
    }

private:
    rtChipType_t oldChipType;
    bool isCfgOpWaitTaskTimeout{false};
    bool isCfgOpExcTaskTimeout{false};
};

TEST_F(CloudV2DeviceResLimitTest, TestSetDeviceResLimit)
{
    rtError_t error = rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtsSetDeviceResLimit(0, RT_DEV_RES_VECTOR_CORE, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtsSetDeviceResLimit(0, RT_DEV_RES_VECTOR_CORE, 2048);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2DeviceResLimitTest, TestSetDeviceResLimitFailed)
{
    MOCKER_CPP(&fe::PlatformInfoManager::GetRuntimePlatformInfosByDevice).stubs().will(returnValue(1));
    rtError_t error = rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    // invalid resource type;
    error = rtsSetDeviceResLimit(0, RT_DEV_RES_TYPE_MAX, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2DeviceResLimitTest, TestSetDeviceResLimitFailed2)
{
    MOCKER_CPP(&fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string &label, std::map<std::string, std::string> &res))
        .stubs()
        .will(returnValue(false));
    rtError_t error = rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2DeviceResLimitTest, TestSetDeviceResLimitFailed3)
{
    MOCKER_CPP(&fe::PlatformInfoManager::UpdateRuntimePlatformInfosByDevice).stubs().will(returnValue(1));
    rtError_t error = rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2DeviceResLimitTest, TestSetDeviceResLimitFailed4)
{
    rtError_t error = rtsSetDeviceResLimit(-1, RT_DEV_RES_CUBE_CORE, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(CloudV2DeviceResLimitTest, TestSetDeviceResLimitFailed5)
{
    MOCKER_CPP(&fe::PlatformInfoManager::InitRuntimePlatformInfos).stubs().will(returnValue(1));
    rtDeviceReset(0);
    rtSetDevice(0);
    rtError_t error = rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2DeviceResLimitTest, TestSetDeviceResLimitFailed6)
{
    MOCKER_CPP(&fe::PlatformInfoManager::GetRuntimePlatformInfosByDevice).stubs().will(returnValue(1));
    rtDeviceReset(0);
    rtSetDevice(0);
    rtError_t error = rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2DeviceResLimitTest, TestSetDeviceResLimitFailed7)
{
    MOCKER_CPP(&fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string &label, std::map<std::string, std::string> &res))
        .stubs()
        .will(returnValue(false));
    rtDeviceReset(0);
    rtSetDevice(0);
    rtError_t error = rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2DeviceResLimitTest, TestResetDeviceResLimit)
{
    rtError_t error = rtsResetDeviceResLimit(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2DeviceResLimitTest, TestResetDeviceResLimitFailed)
{
    rtError_t error = rtsResetDeviceResLimit(-1);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(CloudV2DeviceResLimitTest, TestGetDeviceResLimit)
{
    rtError_t error = rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    uint32_t value = 0;
    error = rtsGetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, 2);
}

TEST_F(CloudV2DeviceResLimitTest, TestGetDeviceResLimitFailed)
{
    uint32_t value = 0;
    rtError_t error = rtsGetDeviceResLimit(-1, RT_DEV_RES_CUBE_CORE, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}

TEST_F(CloudV2DeviceResLimitTest, TestGetDeviceResLimit_InvalidResType)
{
    uint32_t value = 0;
    rtError_t error = rtsGetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}
