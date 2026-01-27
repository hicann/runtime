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
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"
#define private public
#include "operator_kernel_active_entry_stream.h"
#undef private
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;


class OperatorKernelActiveEntryStreamTest : public OperatorKernelTest {
protected:
    OperatorKernelActiveEntryStream kernel_;
};


TEST_F(OperatorKernelActiveEntryStreamTest, ModelActiveEntryStream_failed1)
{
    TsAicpuNotify *aicpuNotify = nullptr;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)aicpuNotify;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelActiveEntryStreamTest, ModelActiveEntryStreamTaskKernel_failed1)
{
    uint32_t streamId = 3073;
    int ret = kernel_.DoCompute(streamId, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelActiveEntryStreamTest, ModelActiveEntryStreamTaskKernel_model_nullptr)
{
    uint32_t streamId = 1;
    StreamInfo stream = {};
    stream.streamID = streamId;
    std::vector<StreamInfo> streams;
    streams.push_back(stream);
    ModelStreamManager::GetInstance().Reg(1, streams);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel *)nullptr));
    int ret = kernel_.DoCompute(streamId, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    ModelStreamManager::GetInstance().UnReg(1, streams);
}

TEST_F(OperatorKernelActiveEntryStreamTest, ModelActiveEntryStreamTaskKernel_submit_endgraph)
{
    StreamInfo stream = {};
    stream.streamID = 1;
    std::vector<StreamInfo> streams;
    streams.push_back(stream);
    ModelStreamManager::GetInstance().Reg(1, streams);
    MOCKER_CPP(&AicpuModel::GetModelRetCode).stubs().will(returnValue(1));
    MOCKER_CPP(&AicpuModel::AbnormalEnabled).stubs().will(returnValue(true));
    uint32_t streamId = 1;
    AicpuModel model;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));
    int ret = kernel_.DoCompute(streamId, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ModelStreamManager::GetInstance().UnReg(1, streams);
}

TEST_F(OperatorKernelActiveEntryStreamTest, ModelActiveEntryStreamTaskKernel_nulldata)
{
    StreamInfo stream = {};
    stream.streamID = 1;
    std::vector<StreamInfo> streams;
    streams.push_back(stream);
    ModelStreamManager::GetInstance().Reg(1, streams);
    MOCKER_CPP(&AicpuModel::GetModelRetCode).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::AbnormalEnabled).stubs().will(returnValue(true));
    MOCKER_CPP(&AicpuModel::GetNullDataFlag).stubs().will(returnValue(true));
    uint32_t streamId = 1;
    AicpuModel model;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));

    int ret = kernel_.DoCompute(streamId, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ModelStreamManager::GetInstance().UnReg(1, streams);
}

TEST_F(OperatorKernelActiveEntryStreamTest, ModelActiveEntryStreamTaskKernel_executeInline)
{
    StreamInfo stream = {};
    stream.streamID = 96;
    stream.streamFlag = AICPU_STREAM_INDEX;
    std::vector<StreamInfo> streams;
    streams.push_back(stream);
    ModelStreamManager::GetInstance().Reg(7, streams);
    MOCKER_CPP(&AicpuModel::GetModelRetCode).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::AbnormalEnabled).stubs().will(returnValue(false));
    MOCKER_CPP(&AicpuModel::GetNullDataFlag).stubs().will(returnValue(false));
    uint32_t streamId = 96;
    AicpuModel model;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));
    MOCKER_CPP(&OperatorKernelCommon::SendAICPUSubEvent).stubs().will(returnValue(0));
    RunContext runContextTLocal = {
        .modelId = 7,
        .modelTsId = 1,
        .streamId = 96,
        .pending = false,
        .executeInline = true
    };
    int ret = kernel_.DoCompute(streamId, runContextTLocal);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ModelStreamManager::GetInstance().UnReg(1, streams);
}
