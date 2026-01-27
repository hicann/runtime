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
#include "hwts_kernel_model_process.h"
#include "aicpusd_interface_process.h"
#undef private
#include "aicpusd_context.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class CheckSupportedKernelTest : public EventProcessKernelTest {
protected:
    CheckSupportedTsKernel kernel_;
};

TEST_F(CheckSupportedKernelTest, TsKernelCheckKernelSupported_success)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "TsKernelCheckKernelSupported";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    config->kernelNameLen = 8;
    char *OpraterkernelName = "markStep";
    config->kernelNameAddr = PtrToValue(&OpraterkernelName[0]);
    uint32_t retValue = 10;
    config->checkResultAddr = PtrToValue(&retValue);
    config->checkResultLen = 0;
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    uint32_t *resultAddr = PtrToPtr<void, uint32_t>(ValueToPtr(config->checkResultAddr));
    EXPECT_EQ(*resultAddr, AICPU_SCHEDULE_OK);
    delete config;
    config = nullptr;
}

TEST_F(CheckSupportedKernelTest, TsKernelCheckKernelSupported_failed00)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "TsKernelCheckKernelSupported";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    config->kernelNameLen = 14;
    char *OpraterkernelName = "markStepMytest";
    config->kernelNameAddr = PtrToValue(&OpraterkernelName[0]);
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
    delete config;
    config = nullptr;
}

TEST_F(CheckSupportedKernelTest, TsKernelCheckKernelSupported_failed01)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "TsKernelCheckKernelSupported";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;
    CheckKernelSupportedConfig *config = new CheckKernelSupportedConfig();
    config->kernelNameLen = 14;
    char *OpraterkernelName = "markStepMytest";
    config->kernelNameAddr = PtrToValue(&OpraterkernelName[0]);
    uint32_t retValue = 10;
    config->checkResultAddr = PtrToValue(&retValue);
    config->checkResultLen = 0;
    cceKernel.paramBase = (uint64_t)config;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    uint32_t *resultAddr = PtrToPtr<void, uint32_t>(ValueToPtr(config->checkResultAddr));
    EXPECT_EQ(*resultAddr, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    delete config;
    config = nullptr;
}