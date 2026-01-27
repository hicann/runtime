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
#include "operator_kernel_model_dequeue.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_drv_manager.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelModelDequeueTest : public OperatorKernelTest {
protected:
    OperatorKernelModelDequeue kernel_;
};

TEST_F(OperatorKernelModelDequeueTest, ModelDequeue)
{
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int mbufVal = 1;
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    BufEnQueueInfo queue{0, (uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelDequeueTest, ModelDequeue_failed1)
{
    TsAicpuNotify *aicpuNotify = nullptr;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)aicpuNotify;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelDequeueTest, ModelDequeue_Empty)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue(DRV_ERROR_QUEUE_EMPTY));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int mbufVal = 10;
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    uint32_t queueId = 123;
    BufEnQueueInfo queue{queueId, (uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    bool hasWait = false;
    uint32_t notifyStreamId;
    EventWaitManager::QueueNotEmptyWaitManager().Event(queueId, hasWait, notifyStreamId);
    EXPECT_TRUE(hasWait);
}

TEST_F(OperatorKernelModelDequeueTest, ModelDequeue_halQueueDeQueue_FAILED)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int mbufVal = 10;
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    BufEnQueueInfo queue{0, (uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelDequeueTest, ModelDequeueForEOS)
{
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFakeForEOS));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFakeForEOS));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char mbufVal[256] = {0};
    Mbuf *mbuf = (Mbuf *)&mbufVal;
    BufEnQueueInfo queue{0, (uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    bufForFakeEOS[128] = 0x5A;
    int ret = kernel_.Compute(taskT, runContextT);
    bufForFakeEOS[128] = 0;
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelDequeueTest, SetModelRetCode_OnlyFirstAffect)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    MbufHeadMsg headMsg = {};
    headMsg.retCode = 2;
    aicpuModel.abnormalEnabled_ = true;
    aicpuModel.retCode_ = 0;

    kernel_.SetModelRetCode(0, &headMsg);
    EXPECT_EQ(aicpuModel.GetModelRetCode(), 2);

    headMsg.retCode = 3;
    kernel_.SetModelRetCode(0, &headMsg);
    EXPECT_EQ(aicpuModel.GetModelRetCode(), 2);
}

TEST_F(OperatorKernelModelDequeueTest, SetMbufStepId_HeadNode)
{
    const uint32_t stepId = 100U;
    uint64_t geStepIdAddr = 0U;
    AicpuModel aicpuModel;
    aicpuModel.SetHeadNodeFlag(true);
    aicpuModel.SetStepIdInfo(std::move(StepIdInfo(&geStepIdAddr, stepId)));
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    MbufHeadMsg headMsg = {};

    kernel_.SetMbufStepId(0, &headMsg);
    EXPECT_EQ(headMsg.stepId, stepId);
}

TEST_F(OperatorKernelModelDequeueTest, SetMbufStepId_NullHeadNode)
{
    const uint32_t stepId = 100U;
    uint64_t geStepIdAddr = 0U;
    AicpuModel aicpuModel;
    aicpuModel.SetHeadNodeFlag(false);
    aicpuModel.SetStepIdInfo(std::move(StepIdInfo(&geStepIdAddr, geStepIdAddr)));
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    MbufHeadMsg headMsg = {};
    headMsg.stepId = stepId;

    kernel_.SetMbufStepId(0, &headMsg);
    EXPECT_EQ(geStepIdAddr, stepId);
}

TEST_F(OperatorKernelModelDequeueTest, SetMbufStepId_ModelNull)
{
    const uint32_t stepId = 100U;
    uint64_t geStepIdAddr = 0U;
    AicpuModel aicpuModel;
    aicpuModel.SetHeadNodeFlag(false);
    aicpuModel.SetStepIdInfo(std::move(StepIdInfo(&geStepIdAddr, geStepIdAddr)));
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel *)nullptr));

    MbufHeadMsg headMsg = {};
    headMsg.stepId = stepId;

    kernel_.SetMbufStepId(0, &headMsg);
    EXPECT_EQ(geStepIdAddr, 0);
}

TEST_F(OperatorKernelModelDequeueTest, SetModelNullData_FlagTrue)
{
    const uint32_t stepId = 100U;
    uint64_t geStepIdAddr = 0U;
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&FeatureCtrl::ShouldSetModuleNullData).stubs().will(returnValue(true));

    MbufHeadMsg headMsg = {};
    headMsg.dataFlag = 1;

    kernel_.SetModelNullData(0, &headMsg);
    EXPECT_EQ(aicpuModel.GetNullDataFlag(), true);
}

TEST_F(OperatorKernelModelDequeueTest, SetModelNullData_ModelNull)
{
    AicpuModel aicpuModel;
    MbufHeadMsg headMsg = {};
    headMsg.dataFlag = 1;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel *)nullptr));

    kernel_.SetModelNullData(0, &headMsg);
    EXPECT_EQ(aicpuModel.GetNullDataFlag(), false);
}

TEST_F(OperatorKernelModelDequeueTest, SetModelRetCode_ModelNull)
{
    AicpuModel aicpuModel;
    MbufHeadMsg headMsg = {};
    headMsg.dataFlag = 1;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel *)nullptr));

    kernel_.SetModelRetCode(0, &headMsg);
    EXPECT_EQ(aicpuModel.GetModelRetCode(), 0);
}

TEST_F(OperatorKernelModelDequeueTest, DequeueTask_InvalidInput)
{
    BufEnQueueInfo info = {};
    RunContext task = {};
    const int32_t ret = kernel_.DequeueTask(info, task, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}
