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

class AiCPUInterfaceStubUt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(AiCPUInterfaceStubUt, AiCPUInterfaceStubUtSuccess)
{
    AicpuLoadModelWithQ((void*)nullptr);
    AICPUModelLoad((void*)nullptr);
    AICPUModelDestroy(0);
    AICPUModelExecute(0);
    event_info eventInfo;
    event_ack eventAck;
    AICPUExecuteTask(&eventInfo, &eventAck);
    AICPUPreOpenKernels("test");
    ProfilingMode profilingMode;
    InitAICPUScheduler(0, 0, profilingMode);
    CpuSchedInitParam cpuSchedInitParam;
    InitCpuScheduler(&cpuSchedInitParam);
    UpdateProfilingMode(0, 0, 0);
    StopAICPUScheduler(0, 0);
    LoadOpMappingInfo(nullptr, 0);
    MsprofReporterCallback msprofReporterCallback;
    AicpuSetMsprofReporterCallback(msprofReporterCallback);
    AicpuGetTaskDefaultTimeout();
    aicpu::AsyncNotifyInfo notifyInfo = {0};
    AicpuReportNotifyInfo(notifyInfo);
    auto ret = AicpuIsStoped();
    EXPECT_EQ(ret, false);
}

TEST_F(AiCPUInterfaceStubUt, RegLastwordCallbackTest) {
    uint64_t times = 0;
    auto TestLastword = [&times]() {
        times++;
    };
    std::function<void()> cancelReg = nullptr;
    RegLastwordCallback("test", TestLastword, cancelReg);
    if (cancelReg != nullptr) {
        cancelReg();
    }
    EXPECT_EQ(cancelReg, nullptr);
}