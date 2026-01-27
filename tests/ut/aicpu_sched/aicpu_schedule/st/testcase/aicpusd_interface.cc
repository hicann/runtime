/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_interface.h"
#include "aicpusd_event_manager.h"
#include "ascend_hal.h"
#include "gtest/gtest.h"
#define private public
#include "aicpusd_lastword.h"
#undef private

class AiCPUInterfaceStubSt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(AiCPUInterfaceStubSt, AiCPUInterfaceStubStSuccess)
{
    int32_t ret = AicpuLoadModelWithQ((void*)nullptr);
    EXPECT_EQ(ret, 0);
    ret = AICPUModelLoad((void*)nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_SUCCESS);
    ret = AICPUModelDestroy(0);
    EXPECT_EQ(ret, 0);
    ret = AICPUModelExecute(0);
    EXPECT_EQ(ret, 0);
    event_info eventInfo;
    event_ack eventAck;
    ret = AICPUExecuteTask(&eventInfo, &eventAck);
    EXPECT_EQ(ret, 0);
    ret = AICPUPreOpenKernels("test");
    EXPECT_EQ(ret, 0);
    ProfilingMode profilingMode;
    ret = setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
    EXPECT_EQ(ret, 0);
    ret = setenv("ASCEND_GLOBAL_EVENT_ENABLE", "1", 1);
    EXPECT_EQ(ret, 0);
    ret = InitAICPUScheduler(0, 0, profilingMode);
    EXPECT_EQ(ret, 0);
    CpuSchedInitParam cpuSchedInitParam;
    ret = InitCpuScheduler(&cpuSchedInitParam);
    EXPECT_EQ(ret, 0);
    ret = UpdateProfilingMode(0, 0, 0);
    EXPECT_EQ(ret, 0);
    ret = StopAICPUScheduler(0, 0);
    EXPECT_EQ(ret, 0);
    ret = LoadOpMappingInfo(nullptr, 0);
    EXPECT_EQ(ret, 0);
    MsprofReporterCallback msprofReporterCallback;
    ret = AicpuSetMsprofReporterCallback(msprofReporterCallback);
    EXPECT_EQ(ret, 0);
    bool result = AicpuIsStoped();
    EXPECT_EQ(ret, false);
}

TEST_F(AiCPUInterfaceStubSt, RegLastwordCallbackTest) {
    uint64_t times = 0;
    auto TestLastword = [&times]() {
        times++;
    };
    std::function<void()> cancelReg = nullptr;
    RegLastwordCallback("test", TestLastword, cancelReg);
    if (cancelReg != nullptr) {
        cancelReg();
    }

    EXPECT_EQ(AicpuSchedule::AicpusdLastword::GetInstance().lastwords_.size(), 0);
}