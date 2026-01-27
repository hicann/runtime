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
#include "aicpu_task_struct.h"
#include "hwts_kernel_dfx.h"
#undef private
#include "aicpusd_context.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class CfgLogAddrKernelTest : public EventProcessKernelTest {
protected:
    CfgLogAddrTsKernel kernel_;
};

TEST_F(CfgLogAddrKernelTest, TsKernelCfgLogAddr_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(aicpu::AicpuConfigMsg) + sizeof(uint32_t);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    char *p = args + sizeof(aicpu::AicpuParamHead);
    p += sizeof(aicpu::AicpuConfigMsg);
    aicpu::AicpuConfigMsg *cfgMsg = (aicpu::AicpuConfigMsg *)p;
    cfgMsg->msgType = 0;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}