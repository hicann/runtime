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
#include "gmock/gmock.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "aicpusd_task_queue.h"
#undef private


using namespace AicpuSchedule;

class TaskMapTest : public testing::Test {
protected:
    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TaskMapTest, BatchAddTaskSuccess)
{
    const aicpu::Closure task = []() {};
    std::queue<aicpu::Closure> taskQueue = {};
    taskQueue.push(task);
    TaskMap taskMap;
    const AICPUSharderTaskInfo taskInfo = {.parallelId=1, .shardNum=1};
    bool ret = taskMap.BatchAddTask(taskInfo, taskQueue);
    EXPECT_EQ(ret, true);
    aicpu::Closure outTask;
    ret = taskMap.PopTask(taskInfo, outTask);
    EXPECT_EQ(ret, true);
    outTask();
    EXPECT_STREQ(taskMap.DebugString().c_str(), "Split kernel TaskMapSize=0. ");
}

TEST_F(TaskMapTest, BatchAddTaskAddNotEmpty)
{
    const aicpu::Closure task = []() {};
    std::queue<aicpu::Closure> taskQueue = {};
    taskQueue.push(task);
    TaskMap taskMap;
    const AICPUSharderTaskInfo taskInfo = {.parallelId=1, .shardNum=1};
    bool ret = taskMap.BatchAddTask(taskInfo, taskQueue);
    EXPECT_EQ(ret, true);
    ret = taskMap.BatchAddTask(taskInfo, taskQueue);
    EXPECT_EQ(ret, false);
    EXPECT_STREQ(taskMap.DebugString().c_str(), "Split kernel TaskMapSize=1. task=0, parallelId=1, size=1, shardNum=1");
    aicpu::Closure outTask;
    ret = taskMap.PopTask(taskInfo, outTask);
    EXPECT_EQ(ret, true);
    outTask();
}

TEST_F(TaskMapTest, BatchAddTaskReaddSuccess)
{
    const aicpu::Closure task = []() {};
    std::queue<aicpu::Closure> taskQueue = {};
    taskQueue.push(task);
    TaskMap taskMap;
    const AICPUSharderTaskInfo taskInfo = {.parallelId=1, .shardNum=1};
    bool ret = taskMap.BatchAddTask(taskInfo, taskQueue);
    EXPECT_EQ(ret, true);
    auto iter = taskMap.taskMap_.find(taskInfo);
    iter->second.pop();
    EXPECT_STREQ(taskMap.DebugString().c_str(), "Split kernel TaskMapSize=1. task=0, parallelId=1, size=0, shardNum=1");
    ret = taskMap.BatchAddTask(taskInfo, taskQueue);
    EXPECT_EQ(ret, true);
    EXPECT_STREQ(taskMap.DebugString().c_str(), "Split kernel TaskMapSize=1. task=0, parallelId=1, size=1, shardNum=1");
}

TEST_F(TaskMapTest, PopTaskFromEmpty)
{
    std::queue<aicpu::Closure> taskQueue = {};
    TaskMap taskMap;
    const AICPUSharderTaskInfo taskInfo = {.parallelId=1, .shardNum=1};
    bool ret = taskMap.BatchAddTask(taskInfo, taskQueue);
    EXPECT_EQ(ret, true);
    aicpu::Closure task;
    ret = taskMap.PopTask(taskInfo, task);
    EXPECT_EQ(ret, false);
}

TEST_F(TaskMapTest, ClearSuccess)
{
    const aicpu::Closure task = []() {};
    std::queue<aicpu::Closure> taskQueue = {};
    taskQueue.push(task);
    TaskMap taskMap;
    const AICPUSharderTaskInfo taskInfo = {.parallelId=1, .shardNum=1};
    bool ret = taskMap.BatchAddTask(taskInfo, taskQueue);
    EXPECT_EQ(ret, true);
    taskMap.Clear();
    EXPECT_STREQ(taskMap.DebugString().c_str(), "Split kernel TaskMapSize=0. ");
}

class TaskQueueTest : public testing::Test {
protected:
    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TaskQueueTest, EnqueueSuccess)
{
    TaskQueue taskQ;
    const aicpu::Closure task = []() {};
    bool ret = true;
    for (uint32_t i = 0; i < 1024; ++i) {
        ret = taskQ.Enqueue(task);
    }
    EXPECT_EQ(ret, true);
    EXPECT_STREQ(taskQ.DebugString().c_str(), "queueSize=1024");
}

TEST_F(TaskQueueTest, EnqueueFail)
{
    TaskQueue taskQ;
    const aicpu::Closure task = []() {};
    bool ret = true;
    for (uint32_t i = 0; i < 1025; ++i) {
        ret = taskQ.Enqueue(task);
    }
    EXPECT_EQ(ret, false);
}

TEST_F(TaskQueueTest, ClearSuccess)
{
    TaskQueue taskQ;
    const aicpu::Closure task = []() {};
    bool ret = true;
    for (uint32_t i = 0; i < 1024; ++i) {
        ret = taskQ.Enqueue(task);
    }
    EXPECT_EQ(ret, true);
    EXPECT_STREQ(taskQ.DebugString().c_str(), "queueSize=1024");
    taskQ.Clear();
    EXPECT_STREQ(taskQ.DebugString().c_str(), "queueSize=0");
}