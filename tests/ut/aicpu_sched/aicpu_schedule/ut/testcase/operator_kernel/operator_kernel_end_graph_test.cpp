/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#undef private
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"
#include "operator_kernel_end_graph.h"
#include "operator_kernel_common.h"

using namespace AicpuSchedule;


class OperatorKernelEndGraphTest : public OperatorKernelTest {
protected:
    OperatorKernelEndGraph kernel_;
};

TEST_F(OperatorKernelEndGraphTest, ModelEndGraph)
{
    AicpuTaskInfo taskT;
    uint32_t modelID = 0;
    taskT.paraBase = (uint64_t)&modelID;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelEndGraphTest, ModelEndGraph_failed1)
{
    TsAicpuNotify *aicpuNotify = nullptr;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)aicpuNotify;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelEndGraphTest, ModelEndGraph_haswait)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = reinterpret_cast<uint64_t>(&modelId);

    MOCKER_CPP(&OperatorKernelCommon::SendAICPUSubEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    EventWaitManager::EndGraphWaitManager().waitStream_[1] = 1;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}