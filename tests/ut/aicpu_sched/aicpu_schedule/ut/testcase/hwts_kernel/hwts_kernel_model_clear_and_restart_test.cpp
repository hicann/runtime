/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "aicpusd_model.h"
#include "hwts_kernel_model_control.h"
#include "aicpusd_interface_process.h"
#undef private
#include "aicpusd_context.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class ModelClearAndRestartKernelTest : public EventProcessKernelTest {
protected:
    ModelClearAndRestartTsKernel kernel_;
};

TEST_F(ModelClearAndRestartKernelTest, TsKernelModelClearInputAndRestart_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    MOCKER_CPP(&AicpuScheduleInterface::ClearInput)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&AicpuScheduleInterface::Restart)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    delete config;
    config = nullptr;
}

TEST_F(ModelClearAndRestartKernelTest, TsKernelModelClearInputAndRestart_fail1) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(ModelClearAndRestartKernelTest, TsKernelModelClearInputAndRestart_fail2) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    MOCKER_CPP(&AicpuScheduleInterface::ClearInput)
        .stubs()
        .will(returnValue(-1));
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(ModelClearAndRestartKernelTest, TsKernelModelClearInputAndRestart_fail3) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    ReDeployConfig *config = new ReDeployConfig();
    config->modelIdNum = 1;
    uint32_t modelIds[1] = {0};
    config->modelIdsAddr = PtrToValue(&modelIds[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    MOCKER_CPP(&AicpuScheduleInterface::ClearInput)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&AicpuScheduleInterface::Restart)
        .stubs()
        .will(returnValue(-1));
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}