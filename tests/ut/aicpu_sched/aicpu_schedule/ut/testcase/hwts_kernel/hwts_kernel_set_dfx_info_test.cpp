/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "aicpu_task_struct.h"
#include "hwts_kernel_dfx.h"
#undef private
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class SetAicpuDfxKernelTest : public EventProcessKernelTest {
protected:
    SetAicpuDfxTsKernel kernel_;
};

TEST_F(SetAicpuDfxKernelTest, ParamBaseNull)
{
    aicpu::HwtsTsKernel tsKernelInfo = {};
    tsKernelInfo.kernelBase.cceKernel.paramBase = 0U;
    EXPECT_EQ(kernel_.Compute(tsKernelInfo), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(SetAicpuDfxKernelTest, CpTypeAicpusd)
{
    aicpu::AicpuDfxInfo dfxInfo = {};
    dfxInfo.infoAddr = 0x1234ULL;
    dfxInfo.cpType = 0U;
    aicpu::HwtsTsKernel tsKernelInfo = {};
    tsKernelInfo.kernelBase.cceKernel.paramBase = reinterpret_cast<uint64_t>(&dfxInfo);
    EXPECT_EQ(kernel_.Compute(tsKernelInfo), AICPU_SCHEDULE_OK);
}

TEST_F(SetAicpuDfxKernelTest, CpTypeCustomAicpusd)
{
    aicpu::AicpuDfxInfo dfxInfo = {};
    dfxInfo.infoAddr = 0x5678ULL;
    dfxInfo.cpType = 1U;
    aicpu::HwtsTsKernel tsKernelInfo = {};
    tsKernelInfo.kernelBase.cceKernel.paramBase = reinterpret_cast<uint64_t>(&dfxInfo);
    MOCKER(halEschedSubmitEventSync).stubs().will(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(kernel_.Compute(tsKernelInfo), AICPU_SCHEDULE_OK);
}

TEST_F(SetAicpuDfxKernelTest, CpTypeInvalid)
{
    aicpu::AicpuDfxInfo dfxInfo = {};
    dfxInfo.cpType = 2U;
    aicpu::HwtsTsKernel tsKernelInfo = {};
    tsKernelInfo.kernelBase.cceKernel.paramBase = reinterpret_cast<uint64_t>(&dfxInfo);
    EXPECT_EQ(kernel_.Compute(tsKernelInfo), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}
