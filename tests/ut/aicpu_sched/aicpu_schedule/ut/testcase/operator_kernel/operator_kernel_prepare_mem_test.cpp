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
#include "operator_kernel_prepare_mem.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;


class OperatorKernelPrepareMemTest : public OperatorKernelTest {
protected:
    OperatorKernelPrepareMem kernel_;
};

TEST_F(OperatorKernelPrepareMemTest, ModelPrepareMemory_Success)
{
    Mbuf *mbufP = reinterpret_cast<Mbuf*>(1);
    std::vector<uintptr_t> vec;
    vec.emplace_back(&mbufP);
    MOCKER_CPP(&MBufferPool::Allocate).stubs().with(outBoundP(&mbufP, sizeof(Mbuf**))).will(returnValue(0));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    PrepareMemTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    param.inBuffNum = 1U;
    param.outBuffNum = 1U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelPrepareMemTest, ModelPrepareMemory_fail_MissingModel)
{
    AicpuTaskInfo taskT = {};
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelPrepareMemTest, ModelPrepareMemory_fail_MissingParam)
{
    AicpuTaskInfo taskT = {};
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    EXPECT_NE(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelPrepareMemTest, ModelPrepareMemory_fail_AllocateSomeOutput)
{
    Mbuf *mbufP = nullptr;
    std::vector<uintptr_t> vec = {reinterpret_cast<uintptr_t>(&mbufP), reinterpret_cast<uintptr_t>(&mbufP)};
    Mbuf *placeHolder = reinterpret_cast<Mbuf*>(1);
    MOCKER_CPP(&MBufferPool::Allocate)
        .stubs()
        .with(outBoundP(&placeHolder))
        .will(repeat(0, 2))
        .then(returnValue(-1));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    PrepareMemTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    param.inBuffNum = 2U;
    param.outBuffNum = 2U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}


TEST_F(OperatorKernelPrepareMemTest, ModelPrepareMemory_fail_AllocateSomeInput)
{
    Mbuf *mbufP = nullptr;
    std::vector<uintptr_t> vec = {reinterpret_cast<uintptr_t>(&mbufP), reinterpret_cast<uintptr_t>(&mbufP)};
    Mbuf *placeHolder = reinterpret_cast<Mbuf*>(1);
    MOCKER_CPP(&MBufferPool::Allocate)
        .stubs()
        .with(outBoundP(&placeHolder))
        .will(returnValue(0))
        .then(returnValue(-1));

    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    PrepareMemTaskParam param = {0};
    param.inBuffPtr = vec.data();
    param.outBuffPtr = vec.data();
    param.inBuffNum = 2U;
    param.outBuffNum = 2U;
    AicpuTaskInfo taskT;
    taskT.paraBase = (uint64_t)&param;

    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelPrepareMemTest, PendPrepareMemoryTask_Success)
{
    bool needWait = false;
    kernel_.PendPrepareMemoryTask(runContextT, needWait);
    EXPECT_EQ(*(const_cast<bool *>(&runContextT.pending)), true);
}