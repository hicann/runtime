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
#include "aicpusd_event_process.h"
#include "aicpusd_msg_send.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class ActiveEntryStreamKernelTest : public EventProcessKernelTest {
protected:
    ActiveEntryStreamTsKernel kernel_;
};

TEST_F(ActiveEntryStreamKernelTest, TsKernelActiveEntryStream_failed1)
{
    void *aa = nullptr;
    aicpu::HwtsTsKernel tsKernelInfo = {};
    tsKernelInfo.kernelBase.cceKernel.paramBase = (uintptr_t)aa;

    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(ActiveEntryStreamKernelTest, TsKernelActiveEntryStream_succ)
{
    aicpu::HwtsTsKernel tsKernelInfo = {};
    aicpu::HwtsCceKernel cceKernel;
    int streamId = 1;
    cceKernel.paramBase = (uint64_t)&streamId;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    MOCKER_CPP(&ModelStreamManager::GetInstance().GetStreamModelId).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuMsgSend::SendAICPUSubEvent).stubs().will(returnValue(0));
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}