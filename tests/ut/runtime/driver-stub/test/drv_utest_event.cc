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

class DrvEventTest : public testing::Test {
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

extern "C" drvError_t drvEventIDListInit();

TEST_F(DrvEventTest, event_api_test)
{
	drvError_t error;
    struct halResourceIdInputInfo  resAllocInput;
    struct halResourceIdOutputInfo  resAllocOutput;
    resAllocInput.type = DRV_EVENT_ID;
    resAllocInput.tsId = 0;
    int32_t deviceId = 0;
    drvEventIDListInit();
    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    struct halResourceIdInputInfo resFreeInput;
    resFreeInput.type = DRV_EVENT_ID;
    resFreeInput.tsId = 0;
    resFreeInput.resourceId = resAllocOutput.resourceId;

    error = halResourceIdFree (deviceId, &resFreeInput);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvEventTest, event_api_test1)
{
	drvError_t error;
    struct halResourceIdInputInfo  resAllocInput;
    struct halResourceIdOutputInfo  resAllocOutput;
    resAllocInput.type = DRV_MODEL_ID;
    resAllocInput.tsId = 0;
    int32_t deviceId = 0;
    drvEventIDListInit();
    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    struct halResourceIdInputInfo resFreeInput;
    resFreeInput.type = DRV_MODEL_ID;
    resFreeInput.tsId = 0;
    resFreeInput.resourceId = resAllocOutput.resourceId;

    error = halResourceIdFree (deviceId, &resFreeInput);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}
TEST_F(DrvEventTest, event_api_test2)
{
	drvError_t error;
    struct halResourceIdInputInfo  resAllocInput;
    struct halResourceIdOutputInfo  resAllocOutput;
    resAllocInput.type = DRV_NOTIFY_ID;
    resAllocInput.tsId = 0;
    int32_t deviceId = 0;
    drvEventIDListInit();
    error = halResourceIdAlloc(deviceId, &resAllocInput, &resAllocOutput);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    struct halResourceIdInputInfo resFreeInput;
    resFreeInput.type = DRV_NOTIFY_ID;
    resFreeInput.tsId = 0;
    resFreeInput.resourceId = resAllocOutput.resourceId;

    error = halResourceIdFree (deviceId, &resFreeInput);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}
