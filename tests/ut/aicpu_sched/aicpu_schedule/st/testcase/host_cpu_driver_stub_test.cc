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
 
class HostCpuDriverStubUt : public ::testing::Test {
public:
    virtual void SetUp()
    {}
 
    virtual void TearDown()
    {}
};
 
TEST_F(HostCpuDriverStubUt, HostCpuDriverStubUtSuccess)
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
    EXPECT_EQ(ret, DRV_ERROR_NONE);
}
 
TEST_F(HostCpuDriverStubUt, drvQueryProcessHostPid)
{
    int pid = 2343;
    unsigned int *chip_id;
    unsigned int *vfid;
    unsigned int *host_pid;
    unsigned int *cp_type;
    auto ret = drvQueryProcessHostPid(pid, chip_id, vfid, host_pid, cp_type);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
}

extern int32_t SetSubProcScheduleMode(const uint32_t deviceId, const uint32_t waitType,
                                      const uint32_t hostPid, const uint32_t vfId,
                                      const struct SubProcScheduleModeInfo *scheInfo);
TEST_F(HostCpuDriverStubUt, SetSubProcScheduleMode)
{
  int ret = SetSubProcScheduleMode(0U, 0U, 0U, 0U, nullptr);
  EXPECT_EQ(ret, 0);
}