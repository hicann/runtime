/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "device_sched_gate.hpp"
#include "runtime.hpp"
#include "runtime/rt.h"
#include "runtime/rt_inner_device.h"
#include "thread_local_container.hpp"

namespace {
using namespace cce::runtime;
class rtUtestSuspendV201 : public testing::TestWithParam<rtChipType_t> {
protected:
    void SetUp() override
    {
        runtime_ = Runtime::Instance();
        savedGlobalChip_ = GlobalContainer::GetRtChipType();
        // Exercise each V201 capability table without initializing a device.
        GlobalContainer::SetRtChipType(GetParam());
    }
    void TearDown() override
    {
        GlobalContainer::SetRtChipType(savedGlobalChip_);
        GlobalMockObject::verify();
    }
    Runtime* runtime_ = nullptr;
    rtChipType_t savedGlobalChip_{};
};
TEST_P(rtUtestSuspendV201, PublicApisRejectMissingControlQueueCapability)
{
    rtDeviceSuspendConfig config{};
    config.mode = RT_DEVICE_SUSPEND_MODE_DEVICE;
    config.taskInterval = 17U;
    EXPECT_EQ(rtDeviceSetSuspendConfig(1, &config), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceGetSuspendConfig(1, &config), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(config.mode, RT_DEVICE_SUSPEND_MODE_DEVICE);
    EXPECT_EQ(config.taskInterval, 17U);
    EXPECT_EQ(rtDeviceSuspendExecution(1, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceResumeExecution(1, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
TEST_P(rtUtestSuspendV201, SetupRejectsMissingCapabilityBeforeAllocatingEvent)
{
    DeviceSchedGate gate(nullptr, 8U);
    EXPECT_EQ(gate.Setup(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(gate.GateEvent(), nullptr);
}
INSTANTIATE_TEST_SUITE_P(Platforms, rtUtestSuspendV201, testing::Values(CHIP_MC32DM11A, CHIP_MC62CM12A));
} // namespace
