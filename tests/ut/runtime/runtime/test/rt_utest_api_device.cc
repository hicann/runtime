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
#include "config.h"
#include "runtime.hpp"
#include "dev.h"
#include "rt_error_codes.h"
#include "api_impl.hpp"
#include "api_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "api_profile_decorator.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "platform/platform_info.h"
#undef private


using namespace testing;
using namespace cce::runtime;

class ApiDeviceTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"ApiDeviceTest test start start. "<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"ApiDeviceTest test start end. "<<std::endl;

    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
};

drvError_t drvGetPlatformInfo_rts1(uint32_t *info)
{
    *info = RT_RUN_MODE_ONLINE;
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo_rts2(uint32_t *info)
{
    *info = RT_RUN_MODE_AICPU_SCHED;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode_rts1(unsigned int dev_id, unsigned int *split_mode)
{
    *split_mode = 0;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode_rts2(unsigned int dev_id, unsigned int *split_mode)
{
    *split_mode = 1;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode_rts3(unsigned int dev_id, unsigned int *split_mode)
{
    *split_mode = 2;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode_rts4(unsigned int dev_id, unsigned int *split_mode)
{
    *split_mode = 3;
    return DRV_ERROR_NONE;
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_AICPU_CORE_NUM, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_MAX, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsDeviceGetInfo(devid, static_cast<rtDevAttr>(111), &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_AICORE_CORE_NUM, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    std::string literalStr = "20";
    MOCKER_CPP(&fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string &, const std::string &, std::string &))
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(literalStr))
        .will(returnValue(true));

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_CUBE_CORE_NUM, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_VECTOR_CORE_NUM, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_WARP_SIZE, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_SMP_ID, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_PHY_CHIP_ID, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_SUPER_POD_DEVICE_ID, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_SUPER_POD_SERVER_ID, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_SUPER_POD_ID, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_CUST_OP_PRIVILEGE, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_MAINBOARD_ID, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halGetDeviceSplitMode).stubs().will(invoke(halGetDeviceSplitMode_rts1));
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_IS_VIRTUAL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, static_cast<int64_t>(0));
    GlobalMockObject::verify();

    MOCKER(halGetDeviceSplitMode).stubs().will(invoke(halGetDeviceSplitMode_rts2));
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_IS_VIRTUAL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, static_cast<int64_t>(1));
    GlobalMockObject::verify();

    MOCKER(halGetDeviceSplitMode).stubs().will(invoke(halGetDeviceSplitMode_rts3));
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_IS_VIRTUAL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, static_cast<int64_t>(1));
    GlobalMockObject::verify();

    MOCKER(halGetDeviceSplitMode).stubs().will(invoke(halGetDeviceSplitMode_rts4));
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_IS_VIRTUAL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_1)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;

    MOCKER_CPP(&fe::PlatformInfoManager::InitRuntimePlatformInfos)
        .stubs()
        .will(returnValue(0xFFFFFFFF));

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_2)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;

    std::string literalStr = "20";
    MOCKER_CPP(&fe::PlatformInfoManager::GetRuntimePlatformInfosByDevice)
        .stubs()
        .will(returnValue(0xFFFFFFFF));

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_3)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;

    std::string literalStr = "20";
    MOCKER_CPP(&fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string &, const std::string &, std::string &))
        .stubs()
        .will(returnValue(false));

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_4)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;
    
    std::string literalStr = "xyz";
    MOCKER_CPP(&fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string &, const std::string &, std::string &))
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(literalStr))
        .will(returnValue(true));

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_5)
{
    rtError_t error;
    int32_t devid = 129;
    int64_t val = 0;

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityUpdate)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, static_cast<int32_t>(FEATURE_NOT_SUPPORT));
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityCross)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, static_cast<int32_t>(FEATURE_SUPPORT));
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityTaskIdBitWidth)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    rtError_t error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, 16);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityInvalied)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, 20, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityFailed)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, -1, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetStreamPriorityRange)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    error = rtsDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityTaskIdBitWidthOnDavid)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;
 
    rtError_t error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, 16);
}

TEST_F(ApiDeviceTest, TestRtsGetDeviceCount)
{
    rtError_t error;
    int32_t count;

    error = rtsGetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtsGetDeviceCount(&count);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsGetRunMode)
{
    rtError_t error;
    rtRunMode mode;

    error = rtsGetRunMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_RUN_MODE_OFFLINE);

    error = rtsGetRunMode(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_rts1));
    error = rtsGetRunMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_RUN_MODE_ONLINE);

    GlobalMockObject::verify();

    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_rts2));
    error = rtsGetRunMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_RUN_MODE_OFFLINE);
}

TEST_F(ApiDeviceTest, TestRtsGetDeviceUtilizations)
{
    rtError_t error;
    uint8_t utilValue = 0;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    error = rtsGetDeviceUtilizations(0, RT_UTIL_TYPE_AICORE, &utilValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsGetDeviceUtilizations(0, RT_UTIL_TYPE_AIVECTOR, &utilValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsGetDeviceUtilizations(0, RT_UTIL_TYPE_AICPU, &utilValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t type = rtInstance->chipType_;
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtsGetDeviceUtilizations(0, RT_UTIL_TYPE_MAX, &utilValue);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtInstance->chipType_ = type;
    GlobalContainer::SetRtChipType(type);
}

TEST_F(ApiDeviceTest, TestRtsGetSocVersion)
{
    rtError_t error = rtsGetSocVersion(nullptr, 50);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsResetDevice)
{
    rtError_t error = rtsResetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsDeviceResetForce)
{
    rtError_t error = rtsDeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsGetPairDevicesInfo)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetPairDevicesInfo).stubs().will(returnValue(RT_ERROR_NONE));
    uint64_t val;
    rtError_t error = rtsGetPairDevicesInfo(0, 1, 0, &val);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(val, 1);
}

TEST_F(ApiDeviceTest, TestRtsNewDeviceId)
{
    rtError_t error;
    int32_t count;

    error = rtsGetLogicDevIdByPhyDevId(0, &count);
    EXPECT_EQ(error, RT_ERROR_NONE);
    int32_t count1;
    error = rtsGetPhyDevIdByLogicDevId(0, &count1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    int32_t count2;
    error = rtsGetLogicDevIdByUserDevId(0, &count2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    int32_t count3;
    error = rtsGetUserDevIdByLogicDevId(0, &count3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsGetLogicDevIdByPhyDevId(-1, &count);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsGetPhyDevIdByLogicDevId(-1, &count1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsGetLogicDevIdByUserDevId(-1, &count2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsGetUserDevIdByLogicDevId(-1, &count3);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}