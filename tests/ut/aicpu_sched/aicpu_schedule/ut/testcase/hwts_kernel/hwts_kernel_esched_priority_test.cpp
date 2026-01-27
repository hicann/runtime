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
#include "aicpusd_resource_manager.h"
#include "hwts_kernel_model_process.h"
#include "aicpusd_model_execute.h"
#undef private
#include "aicpusd_context.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;
using namespace aicpu;

class EschedPriorityKernelTest : public EventProcessKernelTest {
protected:
    EschedPriorityTsKernel kernel_;
};

TEST_F(EschedPriorityKernelTest, TsKernelSetPriority_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuPriInfo *cfg = reinterpret_cast<AicpuPriInfo *>(args + sizeof(aicpu::AicpuParamHead));
    cfg->checkHead = PRIORITY_MSG_CHECKCODE;
    cfg->pidPriority = 3;
    cfg->eventPriority = 1;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();
}

TEST_F(EschedPriorityKernelTest, TsKernelSetPriority_lenError) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = 0;
    AicpuPriInfo *cfg = reinterpret_cast<AicpuPriInfo *>(args + sizeof(aicpu::AicpuParamHead));
    cfg->checkHead = PRIORITY_MSG_CHECKCODE;
    cfg->pidPriority = 3;
    cfg->eventPriority = 1;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();
}

TEST_F(EschedPriorityKernelTest, TsKernelSetPriority_baseNull) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = 0;
    AicpuPriInfo *cfg = reinterpret_cast<AicpuPriInfo *>(args + sizeof(aicpu::AicpuParamHead));
    cfg->checkHead = PRIORITY_MSG_CHECKCODE;
    cfg->pidPriority = 3;
    cfg->eventPriority = 1;
    cceKernel.paramBase = 0;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();
}