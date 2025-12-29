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
#include "osal.hpp"
#include "api_impl.hpp"
#include "api_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "api_profile_decorator.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "stars_engine.hpp"
#include "raw_device.hpp"
#include "platform/platform_info.h"
#undef private


using namespace testing;
using namespace cce::runtime;

class CloudV2ApiDeviceTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"CloudV2ApiDeviceTest test start start. "<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"CloudV2ApiDeviceTest test start end. "<<std::endl;

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
private:
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

TEST_F(CloudV2ApiDeviceTest, TestRtsSetOpWaitTimeOut)
{
    rtError_t error;
    error = rtsSetOpWaitTimeOut(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiDeviceTest, TestWaitForParsePrint)
{
    rtError_t error;
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    RawDevice* rawdevice = dynamic_cast<RawDevice*>(device);
    void * const printf = ValueToPtr(THREAD_PRINTF);
    constexpr const char_t* threadName = "PRINTF";
    auto * stars_engine = dynamic_cast<StarsEngine*>(rawdevice->engine_);
    stars_engine->printfThread_.reset(OsalFactory::CreateThread(threadName, stars_engine, printf));
    rawdevice->WaitForParsePrintf();
    stars_engine->printfThread_.reset(nullptr);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2ApiDeviceTest, AddAddrKernelNameMapTableTest)
{
    RawDevice dev(0);
    dev.Init();
    dev.platformConfig_ = 0x500;
    rtAddrKernelName_t mapInfo;
    mapInfo.addr = 0;
    mapInfo.kernelName = "testKernel";
    dev.AddAddrKernelNameMapTable(mapInfo);
    string ret = dev.LookupKernelNameByAddr(1);
    EXPECT_EQ(ret, "not found kernel name");
    ret = dev.LookupKernelNameByAddr(0);
    EXPECT_EQ(ret, "testKernel");
}

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetInfo)
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

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_1)
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

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_2)
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

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_3)
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

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_4)
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

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_5)
{
    rtError_t error;
    int32_t devid = 129;
    int64_t val = 0;

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetCapabilityUpdate)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, static_cast<int32_t>(FEATURE_NOT_SUPPORT));
}

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetCapabilityCross)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, static_cast<int32_t>(FEATURE_SUPPORT));
}

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetCapabilityTaskIdBitWidth)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    rtError_t error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, 16);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetCapabilityInvalied)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, 20, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetCapabilityFailed)
{
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, -1, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetStreamPriorityRange)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    error = rtsDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceGetCapabilityTaskIdBitWidthOnStarsV2)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int32_t value = 0;
 
    rtError_t error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, 16);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsGetDeviceCount)
{
    rtError_t error;
    int32_t count;

    error = rtsGetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtsGetDeviceCount(&count);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsGetRunMode)
{
    rtError_t error;
    rtRunMode mode;

    error = rtsGetRunMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_RUN_MODE_ONLINE);

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

TEST_F(CloudV2ApiDeviceTest, TestRtsGetDeviceUtilizations)
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
    error = rtsGetDeviceUtilizations(0, RT_UTIL_TYPE_MAX, &utilValue);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsGetSocVersion)
{
    rtError_t error = rtsGetSocVersion(nullptr, 50);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsResetDevice)
{
    rtError_t error = rtsResetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsDeviceResetForce)
{
    rtError_t error = rtsDeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsGetPairDevicesInfo)
{
    ApiImpl apiImpl;
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetPairDevicesInfo).stubs().will(returnValue(RT_ERROR_NONE));
    uint64_t val;
    rtError_t error = rtsGetPairDevicesInfo(0, 1, 0, &val);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(val, 1);
}

TEST_F(CloudV2ApiDeviceTest, TestRtsNewDeviceId)
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

rtError_t ApiGetDeviceUuidStub(Api *api, int32_t devId, rtUuid_t *uuid)
{
    UNUSED(api);
    UNUSED(devId);
    memset_s(uuid->bytes, RT_NPU_UUID_LENGTH, 0xaa, RT_NPU_UUID_LENGTH);

    return RT_ERROR_NONE;
}

TEST_F(CloudV2ApiDeviceTest, get_device_uuid_success)
{ 
    int32_t devId = 0;
    rtUuid_t uuid;

    MOCKER_CPP_VIRTUAL(Runtime::Instance()->Api_(), &Api::GetDeviceUuid)
        .stubs()
        .will(invoke(ApiGetDeviceUuidStub));

    auto error = rtGetDeviceUuid(devId, &uuid);
    EXPECT_EQ(error, RT_ERROR_NONE);

    char exepectUuid[RT_NPU_UUID_LENGTH];
    memset_s(exepectUuid, RT_NPU_UUID_LENGTH, 0xaa, RT_NPU_UUID_LENGTH);
    EXPECT_EQ(memcmp(uuid.bytes, exepectUuid, RT_NPU_UUID_LENGTH), 0);
}

TEST_F(CloudV2ApiDeviceTest, get_device_uuid_fail)
{
    rtError_t error;
    int32_t devId = 0;
    rtUuid_t uuid;

    MOCKER_CPP_VIRTUAL(Runtime::Instance()->Api_(), &Api::GetDeviceUuid)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_NULL))
        .then(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT))
        .then(returnValue(RT_ERROR_DEVICE_ID));

    error = rtGetDeviceUuid(devId, &uuid);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtGetDeviceUuid(devId, &uuid);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtGetDeviceUuid(devId, &uuid);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
}