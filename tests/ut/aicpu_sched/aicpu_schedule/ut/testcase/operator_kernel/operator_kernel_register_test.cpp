/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <memory>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "operator_kernel_register.h"
#undef private
#include "aicpusd_status.h"

using namespace AicpuSchedule;

class OperatorKernelRegisterTest : public testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(OperatorKernelRegisterTest, RunKernelNameNullFail)
{
    OperatorKernelRegister inst;
    const AicpuTaskInfo kernelTaskInfo = {};
    const RunContext taskContext = {};
    const int32_t ret = inst.RunOperatorKernel(kernelTaskInfo, taskContext);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelRegisterTest, RunKernelNameNotExistFail)
{
    OperatorKernelRegister inst;

    const std::string kernelName = "test";
    AicpuTaskInfo kernelTaskInfo = {};
    kernelTaskInfo.kernelName = reinterpret_cast<uint64_t>(kernelName.data());
    const RunContext taskContext = {};
    const int32_t ret = inst.RunOperatorKernel(kernelTaskInfo, taskContext);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_LOGICAL_TASK);
}

TEST_F(OperatorKernelRegisterTest, RepeatRegisterKernelFail)
{
    OperatorKernelRegister inst;
    const std::string kernelName = "test";
    const KernelCreatorFunc func = []() -> std::shared_ptr<OperatorKernel> { return nullptr; };
    inst.Register(kernelName, func);
    EXPECT_EQ(inst.kernelInstMap_.size(), 1);
    inst.Register(kernelName, func);
    EXPECT_EQ(inst.kernelInstMap_.size(), 1);
}

TEST_F(OperatorKernelRegisterTest, RegistAndRunKernel)
{
    class MockOperatorKernel : public OperatorKernel {
    public:
        int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
        {
            return AICPU_SCHEDULE_OK;
        }
    };
    std::shared_ptr<OperatorKernel> kernel = std::make_shared<MockOperatorKernel>();
    const KernelCreatorFunc func = [&kernel]() -> std::shared_ptr<OperatorKernel> { return kernel; };
    const std::string kernelName = "test";

    OperatorKernelRegister inst;
    inst.Register(kernelName, func);
    EXPECT_EQ(inst.kernelInstMap_.size(), 1);

    AicpuTaskInfo kernelTaskInfo = {};
    kernelTaskInfo.kernelName = reinterpret_cast<uint64_t>(kernelName.data());
    const RunContext taskContext = {};
    int32_t ret = inst.RunOperatorKernel(kernelTaskInfo, taskContext);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    ret = inst.CheckOperatorKernelSupported(kernelName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelRegisterTest, CheckOperatorKernelSupportedFailed)
{
    OperatorKernelRegister inst;
    int32_t ret = inst.CheckOperatorKernelSupported("test");
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}