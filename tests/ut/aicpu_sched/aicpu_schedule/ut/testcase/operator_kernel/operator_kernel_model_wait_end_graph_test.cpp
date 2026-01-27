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
#include "aicpusd_common.h"
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_model_wait_end_graph.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelModelWaitEndGraphTest : public OperatorKernelTest {
protected:
    OperatorKernelModelWaitEndGraph kernel_;
};

TEST_F(OperatorKernelModelWaitEndGraphTest, ModelWaitEndGraph) {
    AicpuTaskInfo taskT;
    uint32_t modelID = 0;
    taskT.paraBase = (uint64_t)&modelID;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelWaitEndGraphTest, ModelWaitEndGraph_failed1) {
    AicpuTaskInfo taskT;
    uint32_t *modelID = nullptr;
    taskT.paraBase = (uint64_t)modelID;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}