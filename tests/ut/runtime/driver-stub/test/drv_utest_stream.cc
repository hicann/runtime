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
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"

using namespace testing;

class DrvStreamTest : public testing::Test {
 protected:
  static void SetUpTestCase() {
    std::cout << "DrvApiTest SetUP" << std::endl;
  }
  static void TearDownTestCase() {
    std::cout << "DrvApiTest SetUP" << std::endl;
  }
  // Some expensive resource shared by all tests.
  virtual void SetUp()
  {
    std::cout << "a test SetUP" << std::endl;
  }
  virtual void TearDown()
  {
    std::cout << "a test SetUP" << std::endl;
  }
};

extern "C" drvError_t drvStreamIDListInit();

TEST_F(DrvStreamTest, stream_api_test)
{
	drvError_t error;
    int32_t deviceId = 0;
    struct halResourceIdInputInfo  resAllocInput;
    struct halResourceIdOutputInfo  resAllocOutput;
    resAllocInput.type = DRV_STREAM_ID;
    resAllocInput.tsId = 0;
    drvStreamIDListInit();
    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    struct halResourceIdInputInfo resFreeInput;
    resFreeInput.type = DRV_STREAM_ID;
    resFreeInput.tsId = 0;
    resFreeInput.resourceId = resAllocOutput.resourceId;

    error = halResourceIdFree (deviceId, &resFreeInput);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halResourceIdFree (deviceId, NULL);
    EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
}

TEST_F(DrvStreamTest, stream_allocAPI_test)
{
	drvError_t error;
    int32_t deviceId = 0;

    struct halResourceIdInputInfo  resAllocInput;
    struct halResourceIdOutputInfo  resAllocOutput;
    resAllocInput.type = DRV_STREAM_ID;
    resAllocInput.tsId = 0;
    drvStreamIDListInit();

    error = halResourceIdAlloc(deviceId, NULL, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
    error = halResourceIdAlloc(deviceId, &resAllocInput, NULL);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
    deviceId = 1;
    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_INVALID_DEVICE);
    deviceId=-1;
    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_INVALID_DEVICE);
    resAllocInput.tsId = 2;
    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_INVALID_DEVICE);

    resAllocInput.type = DRV_INVALID_ID;
    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = halResourceIdFree(deviceId, &resAllocInput);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

}

TEST_F(DrvStreamTest, stream_alloc_test)
{
    drvError_t error;
    int32_t deviceId = 0;
    int32_t maxStreamNum = 1024;

    struct halResourceIdInputInfo  resAllocInput;
    struct halResourceIdOutputInfo  resAllocOutput;
    resAllocInput.type = DRV_STREAM_ID;
    resAllocInput.tsId = 0;
    drvStreamIDListInit();



    drvStreamIDListInit();
    for (int32_t i = 0; i<maxStreamNum; i++)
    {
        error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	    EXPECT_EQ(error, DRV_ERROR_NONE);
    }

    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
    EXPECT_NE(error, DRV_ERROR_NONE);
}

TEST_F(DrvStreamTest, stream_free_test)
{
	drvError_t error;
    int32_t deviceId = 0;

    struct halResourceIdInputInfo  resAllocInput;
    struct halResourceIdOutputInfo  resAllocOutput;
    resAllocInput.type = DRV_STREAM_ID;
    resAllocInput.tsId = 0;
    drvStreamIDListInit();
    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    struct halResourceIdInputInfo resFreeInput;
    resFreeInput.type = DRV_STREAM_ID;
    resFreeInput.tsId = 0;
    resFreeInput.resourceId = resAllocOutput.resourceId;

    error = halResourceIdFree (deviceId, &resFreeInput);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = halResourceIdFree (-1, &resFreeInput);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = halResourceIdFree (1, &resFreeInput);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

    resFreeInput.resourceId = -1;
    error = halResourceIdFree (deviceId, &resFreeInput);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

    resFreeInput.resourceId = 1024;
    error = halResourceIdFree (deviceId, &resFreeInput);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

}

TEST_F(DrvStreamTest, stream_sqcq_allocAPI_test)
{
    drvError_t error;
    int32_t deviceId = 0;
    uint64_t cqidBit[16] = {0};

    struct halSqCqInputInfo normalSqCqAllocInputInfo;
    struct halSqCqOutputInfo normalSqCqAllocOutputInfo;
    normalSqCqAllocInputInfo.type = DRV_NORMAL_TYPE;
    normalSqCqAllocInputInfo.tsId = 0;
    normalSqCqAllocInputInfo.sqeSize = 64;
    normalSqCqAllocInputInfo.cqeSize = 12;
	normalSqCqAllocInputInfo.sqeDepth = 1024;
    normalSqCqAllocInputInfo.cqeDepth = 1024;
    normalSqCqAllocInputInfo.flag = (1 & 0x1) | ((1 & 0x1) << 0x1);
    normalSqCqAllocInputInfo.grpId = 0;
    normalSqCqAllocInputInfo.cqId = 0;
    normalSqCqAllocInputInfo.sqId = 0;

    error = halSqCqAllocate(deviceId, &normalSqCqAllocInputInfo, &normalSqCqAllocOutputInfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    struct halSqCqFreeInfo normalSqCqFreeInputInfo;
    normalSqCqFreeInputInfo.type = DRV_NORMAL_TYPE;
    normalSqCqFreeInputInfo.tsId = 0;
    normalSqCqFreeInputInfo.sqId = normalSqCqAllocOutputInfo.sqId;
    normalSqCqFreeInputInfo.cqId = normalSqCqAllocOutputInfo.cqId;
    normalSqCqFreeInputInfo.flag = 1;
    error = halSqCqFree(deviceId, &normalSqCqFreeInputInfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    normalSqCqAllocInputInfo.type = DRV_NORMAL_TYPE;
    normalSqCqFreeInputInfo.type = DRV_NORMAL_TYPE;
    error = halSqCqAllocate(deviceId, &normalSqCqAllocInputInfo, &normalSqCqAllocOutputInfo);
    error = halSqCqFree(deviceId, &normalSqCqFreeInputInfo);
    normalSqCqAllocInputInfo.type = DRV_INVALID_TYPE;
    normalSqCqFreeInputInfo.type = DRV_INVALID_TYPE;
    error = halSqCqAllocate(deviceId, &normalSqCqAllocInputInfo, &normalSqCqAllocOutputInfo);
    error = halSqCqFree(deviceId, &normalSqCqFreeInputInfo);

}

TEST_F(DrvStreamTest, stream_sqcq_shm_test)
{
    drvError_t error;
    int32_t deviceId = 0;

    struct halSqCqInputInfo sqCqAllocInputInfo;
    struct halSqCqOutputInfo sqCqAllocOutputInfo;
    sqCqAllocInputInfo.type = DRV_SHM_TYPE;
    sqCqAllocInputInfo.tsId = 0;

    error = halSqCqAllocate(deviceId, &sqCqAllocInputInfo, &sqCqAllocOutputInfo);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

    sqCqAllocInputInfo.type = DRV_CALLBACK_TYPE;
    error = halSqCqAllocate(deviceId, &sqCqAllocInputInfo, &sqCqAllocOutputInfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    struct halSqCqFreeInfo normalSqCqFreeInputInfo;
    normalSqCqFreeInputInfo.type = DRV_CALLBACK_TYPE;
    error = halSqCqFree(deviceId, &normalSqCqFreeInputInfo);
    EXPECT_NE(error, DRV_ERROR_NONE);

}

