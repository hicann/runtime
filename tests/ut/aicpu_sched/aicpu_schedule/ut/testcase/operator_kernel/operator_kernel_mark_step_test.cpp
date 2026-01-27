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
#include "operator_kernel_mark_step.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"


using namespace AicpuSchedule;


class OperatorKernelMarkStepTest : public OperatorKernelTest {
protected:
    OperatorKernelMarkStep kernel_;
};

TEST_F(OperatorKernelMarkStepTest, MarkStep) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int mbufVal = 1;
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    MarkStepInfo stepInfo{2, 0, 0, (uint64_t)&mbuf};
    memset_s(stepInfo.reserved, MAX_MARK_STEP_RESERVE, 0, MAX_MARK_STEP_RESERVE);
    taskT.paraBase = (uint64_t)&stepInfo;
    int ret = kernel_.Compute(taskT, runContextT);
    uint64_t *stepId = reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(stepInfo.stepIdAddr));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(*stepId, 3);
    taskT.paraBase = 0;
    ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelMarkStepTest, MarkStepNoModel) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel*)nullptr));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int mbufVal = 1;
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    MarkStepInfo stepInfo{2, 0, 0, (uint64_t)&mbuf};
    memset_s(stepInfo.reserved, MAX_MARK_STEP_RESERVE, 0, MAX_MARK_STEP_RESERVE);
    taskT.paraBase = (uint64_t)&stepInfo;
    int ret = kernel_.Compute(taskT, runContextT);
    uint64_t *stepId = reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(stepInfo.stepIdAddr));
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelMarkStepTest, MarkStep_Overflow) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int mbufVal = 1;
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    MarkStepInfo stepInfo{500, 2, 0, (uint64_t)&mbuf};
    memset_s(stepInfo.reserved, MAX_MARK_STEP_RESERVE, 0, MAX_MARK_STEP_RESERVE);
    taskT.paraBase = (uint64_t)&stepInfo;
    aicpuModel->iteratorCount_ = std::numeric_limits<uint64_t>::max() - 1;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_OVERFLOW);
}

TEST_F(OperatorKernelMarkStepTest, MarkStep_Overflow1) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int mbufVal = 1;
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    MarkStepInfo stepInfo{1, std::numeric_limits<uint32_t>::max(), 0, (uint64_t)&mbuf};
    memset_s(stepInfo.reserved, MAX_MARK_STEP_RESERVE, 0, MAX_MARK_STEP_RESERVE);
    taskT.paraBase = (uint64_t)&stepInfo;
    aicpuModel->iteratorCount_ = std::numeric_limits<uint64_t>::max();
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_OVERFLOW);
}

TEST_F(OperatorKernelMarkStepTest, MarkStep_NullHeadFlag) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int mbufVal = 1;
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    MarkStepInfo stepInfo{2, 0, 0, (uint64_t)&mbuf, 0UL, 1};
    memset_s(stepInfo.reserved, MAX_MARK_STEP_RESERVE, 0, MAX_MARK_STEP_RESERVE);
    taskT.paraBase = (uint64_t)&stepInfo;
    aicpuModel->iteratorCount_ = 10;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(aicpuModel->GetHeadNodeFlag(), false);
}