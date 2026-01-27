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
#include "model/model_api.h"
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#include "runtime/dev.h"

using namespace testing;

class DrvDevTest : public testing::Test {
 protected:
  static void SetUpTestCase() {
    std::cout << "DrvApiTest SetUP" << std::endl;
  }
  static void TearDownTestCase() {
    std::cout << "DrvApiTest Tear Down" << std::endl;
  }
  // Some expensive resource shared by all tests.
  virtual void SetUp()
  {
    std::cout << "a test SetUP" << std::endl;
  }
  virtual void TearDown()
  {
        GlobalMockObject::verify();
    std::cout << "a test SetUP" << std::endl;
  }
};

TEST_F(DrvDevTest, device_api_test)
{
    drvError_t error;
    struct devdrv_device_info* deviceInfo=NULL;
    uint32_t count;
    int32_t deviceId=0;
    int64_t value = 0;

    error=drvDeviceOpen((void **)&deviceInfo,deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error=drvGetDevNum(&count);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvGetDevNum(NULL);
    EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);

    error = halGetDeviceInfo((uint32_t)deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &value);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halGetDeviceInfo((uint32_t)deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_CORE_NUM, &value);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halGetDeviceInfo((uint32_t)deviceId, MODULE_TYPE_AICPU, INFO_TYPE_CORE_NUM, &value);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error=drvDeviceClose(deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);

}

TEST_F(DrvDevTest, device_close_test)
{
    drvError_t error;
    int32_t deviceId=0;

    uint32_t info=0;
    error = drvGetPlatformInfo(&info);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = drvDeviceClose(deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvDevTest, device_GetDeviceIds)
{
    drvError_t error;
    int32_t count;
    uint32_t device_arr[2];
    error = drvGetDevIDs(device_arr, 2);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    drvDfxShowReport(0);
}

TEST_F(DrvDevTest, device_GetGroupInfo)
{
    drvError_t error;
    halCapabilityInfo capabilityInfo;

    error = halGetChipCapability(0, &capabilityInfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    uint32_t groupCount = capabilityInfo.ts_group_number;

    capability_group_info* groupInfos = new (std::nothrow) capability_group_info[groupCount];
    EXPECT_NE(groupInfos, nullptr);

    error = halGetCapabilityGroupInfo(0, 0,  -1,  groupInfos, groupCount);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halGetCapabilityGroupInfo(0, 0,  1,  groupInfos, 1);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halGetCapabilityGroupInfo(0, 0,  -10,  groupInfos, 1);
    EXPECT_NE(error, DRV_ERROR_NONE);

    delete []groupInfos;
}
TEST_F(DrvDevTest, device_EnableP2P)
{
    drvError_t error;
    uint32_t devId = 0;
    uint32_t peerDevId = 1;
    uint32_t flag = 0;
	  int32_t canAccessPeer = 0;
	
    error = halDeviceEnableP2P(devId, peerDevId, flag);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	  error = halDeviceCanAccessPeer(&canAccessPeer, devId, peerDevId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	  error = halDeviceDisableP2P(devId, peerDevId, flag);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

extern "C" int AICPUModelLoad(void *arg);
extern "C" int AICPUModelDestroy(uint32_t modelId);
extern "C" int AICPUModelExecute(uint32_t modelId);

TEST_F(DrvDevTest, device_unused_test)
{
    drvError_t err;
    int ret;

    err = halHostRegister(NULL, 0, 0, 0, NULL);
    EXPECT_EQ(err, DRV_ERROR_NONE);

    err = halHostUnregister(NULL, 0);
    EXPECT_EQ(err, DRV_ERROR_NONE);

    err = drvMemPrefetchToDevice(NULL, 0, 0);
    EXPECT_EQ(err, DRV_ERROR_NONE);

    struct DMA_ADDR ptr;
    err = drvMemDestroyAddr(&ptr);
    EXPECT_EQ(err, DRV_ERROR_NONE);


    ret = drvMemDeviceOpen(0, 0);
    EXPECT_EQ(ret, DRV_ERROR_NONE);

    ret = drvMemDeviceClose(0);
    EXPECT_EQ(ret, DRV_ERROR_NONE);

    err = drvMemSmmuQuery(0, NULL);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    
    err = halMemGetInfo(0, 0, NULL);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    
    err = halMemCtl(0, NULL, 0, NULL, NULL);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    
    err = drvGetP2PStatus(0, 0, NULL);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    
    ret = AICPUModelLoad(NULL);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    
    ret = AICPUModelDestroy(0);
    EXPECT_EQ(ret, DRV_ERROR_NONE);

    ret = AICPUModelExecute(0);
    EXPECT_EQ(ret, DRV_ERROR_NONE);

    drvDeviceGetBareTgid();

    err = halGetPairDevicesInfo(0, 0, 0, NULL);
    EXPECT_EQ(err, DRV_ERROR_NONE);
}

