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
#include "operator_kernel_stream_repeat.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelStreamRepeatTest : public OperatorKernelTest {
protected:
    OperatorKernelStreamRepeat kernel_;
};

TEST_F(OperatorKernelStreamRepeatTest, ModelRepeatStream_Success)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    uint32_t stubId = 1U;
    StreamRepeatTaskParam param = {0};
    param.modelId = stubId;
    param.streamId = stubId;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    RunContext runContextLocal = {.modelId = stubId,
        .modelTsId = stubId,
        .streamId = stubId,
        .pending = false,
        .executeInline = true,
        .gotoTaskIndex = -1};

    EXPECT_EQ(kernel_.Compute(taskT, runContextLocal), AICPU_SCHEDULE_OK);
    EXPECT_EQ(runContextLocal.gotoTaskIndex, 0);
}

TEST_F(OperatorKernelStreamRepeatTest, ModelRepeatStream_fail_MissingParam)
{
    AicpuTaskInfo taskT = {};
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelStreamRepeatTest, ModelRepeatStream_fail_ModelDisMatch)
{
    uint32_t stubId = 1U;
    StreamRepeatTaskParam param = {0};
    param.modelId = stubId;
    param.streamId = stubId;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    RunContext runContextLocal = {.modelId = 2U,
        .modelTsId = stubId,
        .streamId = stubId,
        .pending = false,
        .executeInline = true,
        .gotoTaskIndex = -1};

    EXPECT_NE(kernel_.Compute(taskT, runContextLocal), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelStreamRepeatTest, ModelRepeatStream_fail_AbnormalBreak)
{
    uint32_t stubId = 1U;
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = stubId;
    aicpuModel.abnormalBreak_ = true;
    aicpuModel.retCode_ = 1;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    StreamRepeatTaskParam param = {0};
    param.modelId = stubId;
    param.streamId = stubId;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    RunContext runContextLocal = {.modelId = stubId,
        .modelTsId = stubId,
        .streamId = stubId,
        .pending = false,
        .executeInline = true,
        .gotoTaskIndex = -1};

    EXPECT_NE(kernel_.Compute(taskT, runContextLocal), AICPU_SCHEDULE_OK);
}