/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ascend_hal.h"
#include "ascend_inpackage_hal.h"
#include "tsd.h"
#include "gtest/gtest.h"

class HostCpuDriverStubSt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(HostCpuDriverStubSt, HostCpuDriverStubStSuccess)
{
    drvBindHostpidInfo info;
    drvBindHostPid(info);
    halMemInitSvmDevice(0, 0, 0);
    int64_t temp_value = 0;
    halGetDeviceInfo(0, 1, 3, &temp_value);
    halGetDeviceInfo(0, 1, 8, &temp_value);
    uint32_t vfMaXNum;
    halGetDeviceVfMax(0, &vfMaXNum);
    uint32_t vfList;
    uint32_t vfNum;
    auto ret = halGetDeviceVfList(0, &vfList, 1, &vfNum);
    EXPECT_EQ(ret, 0);
}