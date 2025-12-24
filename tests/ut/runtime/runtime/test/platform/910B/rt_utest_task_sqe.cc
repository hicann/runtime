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
#include "global_state_manager.hpp"
#include "rt_preload_task.h"
#include "task_to_sqe.hpp"

using namespace testing;
using namespace cce::runtime;

class TaskToSqeTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TaskToSqeTest, ConstructAicore)
{
    rtTaskInput_t task_input{};
    task_input.argOffset = 0;
    int a = 0;
    task_input.dataBuffer = &a;
    task_input.bufferLen = sizeof(int);
    uint32_t task_len = 0U;
    task_input.compilerInfo.bufType = PARAM_TASK_INFO_DESC;
    task_input.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_NANO_AICORE;
    task_input.compilerInfo.streamId = 0;
    task_input.compilerInfo.u.aicoreTask.argsOffset = 0U;
    task_input.compilerInfo.u.aicoreTask.blockDim = 1;

    EXPECT_EQ(ConstructSqeByTaskInput(&task_input, &task_len), RT_ERROR_NONE);
}

TEST_F(TaskToSqeTest, ConstructHostFuncStaticSqe)
{
    rtTaskInput_t task_input{};
    task_input.argOffset = 0;
    int a = 0;
    task_input.dataBuffer = &a;
    task_input.bufferLen = sizeof(int);
    uint32_t task_len = 0U;
    task_input.compilerInfo.bufType = HWTS_STATIC_TASK_DESC;
    task_input.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC;
    task_input.compilerInfo.streamId = 0;
    task_input.compilerInfo.u.aicoreTask.argsOffset = 0U;
    task_input.compilerInfo.u.aicoreTask.blockDim = 1;

    EXPECT_EQ(ConstructSqeByTaskInput(&task_input, &task_len), RT_ERROR_NONE);
}

TEST_F(TaskToSqeTest, ConstructHostFuncDynamicSqe)
{
    rtTaskInput_t task_input{};
    task_input.argOffset = 0;
    int a = 0;
    task_input.dataBuffer = &a;
    task_input.bufferLen = sizeof(int);
    uint32_t task_len = 0U;
    task_input.compilerInfo.u.nanoHostFuncTask.u.paramBufDesc.bufSize = sizeof(int);
    task_input.compilerInfo.bufType = HWTS_STATIC_TASK_DESC;
    task_input.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC;
    task_input.compilerInfo.streamId = 0;
    task_input.compilerInfo.u.aicoreTask.argsOffset = 0U;
    task_input.compilerInfo.u.aicoreTask.blockDim = 1;

    EXPECT_EQ(ConstructSqeByTaskInput(&task_input, &task_len), RT_ERROR_NONE);
}

TEST_F(TaskToSqeTest, ConstructErrorTaskType)
{
    rtTaskInput_t task_input{};
    task_input.compilerInfo.taskType = RT_TASK_TYPE_MAX;
    uint32_t task_len = 0U;
    EXPECT_NE(ConstructSqeByTaskInput(&task_input, &task_len), RT_ERROR_NONE);
}

TEST_F(TaskToSqeTest, ConstructErrortaskBufferType)
{
    rtTaskInput_t task_input{};
    task_input.compilerInfo.bufType = MAX_TASK;
    uint32_t task_len = 0U;
    EXPECT_NE(ConstructSqeByTaskInput(&task_input, &task_len), RT_ERROR_NONE);
}