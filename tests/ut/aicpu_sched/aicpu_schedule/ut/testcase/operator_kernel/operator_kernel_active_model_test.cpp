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
#include "aicpusd_status.h"
#include "operator_kernel_active_model.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;


class OperatorKernelActiveModelTest : public OperatorKernelTest {
protected:
    OperatorKernelActiveModel activeModelKernel_;
};

TEST_F(OperatorKernelActiveModelTest, ModelActiveModelExecute_success) {
    AicpuTaskInfo taskT;
    uint32_t modelID = 0;
    taskT.paraBase = (uint64_t)&modelID;
    int ret = activeModelKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelActiveModelTest, ModelActiveModelExecute_failed_for_nullPara) {
    AicpuTaskInfo taskT;
    uint32_t modelID = 0;
    taskT.paraBase = (uint64_t)nullptr;
    int ret = activeModelKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}