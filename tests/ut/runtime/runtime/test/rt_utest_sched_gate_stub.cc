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
#include "api_decorator.hpp"
#include "api_impl.hpp"
#include "device_sched_gate.hpp"
#include "runtime/rt_inner_device.h"

namespace {
using namespace cce::runtime;

TEST(SchedGateStubTest, UnsupportedGateHasNoEventOrWaitSideEffects)
{
    DeviceSchedGate gate(nullptr, 8U);
    EXPECT_EQ(gate.Setup(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(gate.Suspend(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(gate.Resume(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(gate.TryInsertGateWait(nullptr, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_FALSE(gate.NeedWait(nullptr, TS_TASK_TYPE_KERNEL_AICORE));
    EXPECT_FALSE(DeviceSchedGate::Eligible(nullptr));
    gate.CountSubmittedOperator(nullptr);
    gate.Release();
    EXPECT_EQ(gate.GateEvent(), nullptr);
}

TEST(SchedGateStubTest, DecoratorPreservesUnsupportedResultAndOutput)
{
    ApiImpl impl;
    ApiDecorator decorator(&impl);
    rtDeviceSuspendConfig config{};
    config.taskInterval = 17U;
    EXPECT_EQ(decorator.DeviceSetSuspendConfig(0, &config), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(decorator.DeviceGetSuspendConfig(0, &config), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(config.taskInterval, 17U);
    EXPECT_EQ(decorator.DeviceSuspendExecution(0, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(decorator.DeviceResumeExecution(0, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
}
} // namespace
