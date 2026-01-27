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
#include "aicpusd_resource_manager.h"
#include "hwts_kernel_model_control.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class EndGraphKernelKernelTest : public EventProcessKernelTest {
protected:
    EndGraphTsKernel kernel_;
};

TEST_F(EndGraphKernelKernelTest, TsKernelEndGraph_failed)
{
    aicpu::HwtsTsKernel tsKernelInfo = {};
    aicpu::HwtsCceKernel cceKernel;
    cceKernel.paramBase = (uint64_t)0U;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(EndGraphKernelKernelTest, TsKernelEndGraph_failed1)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    int modelId = 1;
    cceKernel.paramBase = (uint64_t)&modelId;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}

TEST_F(EndGraphKernelKernelTest, TsKernelEndGraph_success)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    aicpu::HwtsTsKernel tsKernelInfo = {};
    aicpu::HwtsCceKernel cceKernel;
    int modelId = 1;
    cceKernel.paramBase = (uint64_t)&modelId;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND);
}