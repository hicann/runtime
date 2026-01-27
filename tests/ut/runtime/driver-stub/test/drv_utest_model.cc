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

class DrvModelTest : public testing::Test {
 protected:
  static void SetUpTestCase() {
    std::cout << "DrvModelTest SetUP" << std::endl;
  }
  static void TearDownTestCase() {
    std::cout << "DrvModelTest SetUP" << std::endl;
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


TEST_F(DrvModelTest, notify_test)
{
}

TEST_F(DrvModelTest, device_get_addr_test)
{
	drvError_t error;
	uint8_t type;

       error = drvDeviceGetTransWay(NULL, NULL, &type);
	EXPECT_EQ(error, DRV_ERROR_NONE);

}

TEST_F(DrvModelTest, sqcqConfig)
{
    drvError_t error;
    struct halSqCqConfigInfo info;
    error = halSqCqConfig(0, &info);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvModelTest, new_api_test)
{
    (void)halGetChipFromDevice(0, 0);
    (void)halGetDeviceFromChip(0, 0, 0);
    (void)halGetDeviceCountFromChip(0, 0);
    (void)halGetChipList(0, 0);
    drvError_t error = halGetChipCount(0);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvModelTest, GetDeviceSplitMode)
{
    drvError_t error;
    unsigned int split_mode;
    error = halGetDeviceSplitMode(0, &split_mode);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

