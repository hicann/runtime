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
#include "aicpusd_drv_manager.h"
#define private public
#include "aicpu_sharder.h"
#include "aicpusd_threads_process.h"
#undef private


using namespace AicpuSchedule;

class ComputeProcessTest : public testing::Test {
protected:
    static void SetUpTestCase() {
    }

    static void TearDownTestCase() {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

namespace {
drvError_t halEschedSubmitEventBatchSuccess1(unsigned int devId, SUBMIT_FLAG flag,
    struct event_summary *events, unsigned int event_num, unsigned int *succ_event_num)
{
    *succ_event_num = 1;
    return DRV_ERROR_NONE;
}
};

TEST_F(ComputeProcessTest, RegisterScheduleTaskSuccess)
{
    ComputeProcess inst;
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(ComputeProcessTest, SubmitRandomKernelTaskSuccess)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    const aicpu::Closure task = []() {};
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().randomKernelScheduler_(task);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_OK);
}

TEST_F(ComputeProcessTest, SubmitRandomKernelTaskEnqueueFail)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    const aicpu::Closure task = []() {};
    MOCKER_CPP(&TaskQueue::Enqueue).stubs().will(returnValue(false));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().randomKernelScheduler_(task);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(ComputeProcessTest, SubmitRandomKernelTaskDrvFail)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const aicpu::Closure task = []() {};
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(1));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().randomKernelScheduler_(task);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(ComputeProcessTest, SubmitSplitKernelTaskMdcSuccess)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 1;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    MOCKER_CPP(&FeatureCtrl::ShouldSubmitTaskOneByOne).stubs().will(returnValue(true));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_OK);
}

TEST_F(ComputeProcessTest, SubmitSplitKernelTaskDcSuccess)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 1;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    MOCKER_CPP(&FeatureCtrl::ShouldSubmitTaskOneByOne).stubs().will(returnValue(false));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_OK);
}

TEST_F(ComputeProcessTest, SubmitSplitKernelTaskAddTaskFail)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 1;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    MOCKER_CPP(&TaskMap::BatchAddTask).stubs().will(returnValue(false));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(ComputeProcessTest, SubmitSplitKernelTaskMdcFail)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 1;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(1));
    MOCKER_CPP(&FeatureCtrl::ShouldSubmitTaskOneByOne).stubs().will(returnValue(true));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(ComputeProcessTest, SubmitSplitKernelTaskDcFail)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 1;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    MOCKER(halEschedSubmitEventBatch).stubs().will(returnValue(1));
    MOCKER_CPP(&FeatureCtrl::ShouldSubmitTaskOneByOne).stubs().will(returnValue(false));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_OK);
}

TEST_F(ComputeProcessTest, SubmitSplitKernelTaskDcPartSubmitSuccess)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 2;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    taskQueue.push(task);
    MOCKER(halEschedSubmitEventBatch).stubs().will(invoke(halEschedSubmitEventBatchSuccess1));
    MOCKER_CPP(&FeatureCtrl::ShouldSubmitTaskOneByOne).stubs().will(returnValue(false));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_OK);
}

TEST_F(ComputeProcessTest, SubmitSplitKernelTaskDcPartSubmitFail)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 2;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    taskQueue.push(task);
    MOCKER(halEschedSubmitEventBatch).stubs().will(invoke(halEschedSubmitEventBatchSuccess1));
    MOCKER_CPP(&FeatureCtrl::ShouldSubmitTaskOneByOne).stubs().will(returnValue(false));
    MOCKER_CPP(&ComputeProcess::DoSplitKernelTask).stubs().will(returnValue(false));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

drvError_t halEschedGetEventHasEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
                                     EVENT_ID eventId, struct event_info *event)
{
    AICPUSubEventInfo aicpuEventInfo = {};
    aicpuEventInfo.para.sharderTaskInfo = {1U, 1};
    memcpy(event->priv.msg, (void *)(&aicpuEventInfo), sizeof(AICPUSubEventInfo));
    return DRV_ERROR_NONE;
}

TEST_F(ComputeProcessTest, GetAndDoSplitKernelTaskSuccess)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 1;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    MOCKER_CPP(&FeatureCtrl::ShouldSubmitTaskOneByOne).stubs().will(returnValue(false));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_OK);

    MOCKER(halEschedGetEvent).stubs().will(invoke(halEschedGetEventHasEvent));
    const bool getRet = aicpu::SharderNonBlock::GetInstance().splitKernelGetProcesser_();
    EXPECT_EQ(getRet, true);
}

TEST_F(ComputeProcessTest, GetAndDoSplitKernelTaskNoEventSuccess)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 1;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    MOCKER_CPP(&FeatureCtrl::ShouldSubmitTaskOneByOne).stubs().will(returnValue(false));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_OK);

    MOCKER(halEschedGetEvent).stubs().will(returnValue(DRV_ERROR_NO_EVENT));
    const bool getRet = aicpu::SharderNonBlock::GetInstance().splitKernelGetProcesser_();
    EXPECT_EQ(getRet, true);
}

TEST_F(ComputeProcessTest, GetAndDoSplitKernelTaskNoEventFail)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 1;
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {};
    taskQueue.push(task);
    MOCKER_CPP(&FeatureCtrl::ShouldSubmitTaskOneByOne).stubs().will(returnValue(false));
    const uint32_t schRet = aicpu::SharderNonBlock::GetInstance().splitKernelScheduler_(parallelId, shardNum, taskQueue);
    EXPECT_EQ(schRet, AICPU_SCHEDULE_OK);

    MOCKER(halEschedGetEvent).stubs().will(returnValue(DRV_ERROR_GROUP_EXIST));
    const bool getRet = aicpu::SharderNonBlock::GetInstance().splitKernelGetProcesser_();
    EXPECT_EQ(getRet, false);
}

TEST_F(ComputeProcessTest, DoSplitKernelTaskException)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    const uint32_t parallelId = 1U;
    const int64_t shardNum = 1;
    const AICPUSharderTaskInfo taskInfo = {parallelId, shardNum};
    std::queue<aicpu::Closure> taskQueue;
    const aicpu::Closure task = []() {throw std::runtime_error("runtime error");};
    taskQueue.push(task);
    inst.splitKernelTask_.BatchAddTask(taskInfo, taskQueue);

    const bool taskRet = inst.DoSplitKernelTask(taskInfo);
    EXPECT_EQ(taskRet, false);
}

TEST_F(ComputeProcessTest, DoRandomKernelTaskSuccess)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);


    const aicpu::Closure task = []() {};
    inst.randomKernelTask_.Enqueue(task);

    const bool taskRet = inst.DoRandomKernelTask();
    EXPECT_EQ(taskRet, true);
}

TEST_F(ComputeProcessTest, DoRandomKernelTaskException)
{
    ComputeProcess inst;
    inst.deviceVec_.push_back(0U);
    const int32_t ret = inst.RegisterScheduleTask();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);


    const aicpu::Closure task = []() {throw std::runtime_error("runtime error");};
    inst.randomKernelTask_.Enqueue(task);

    const bool taskRet = inst.DoRandomKernelTask();
    EXPECT_EQ(taskRet, false);
}