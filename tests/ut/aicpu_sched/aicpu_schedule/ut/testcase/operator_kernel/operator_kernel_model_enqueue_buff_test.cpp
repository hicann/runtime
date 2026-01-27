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
#include "operator_kernel_model_enqueue_buff.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

namespace {}  // namespace

class OperatorKernelModelEnqueueBuffTest : public OperatorKernelTest {
protected:
    OperatorKernelModelEnqueueBuff kernel_;
};

TEST_F(OperatorKernelModelEnqueueBuffTest, ModelEnqueueBuff)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&BufManager::UnGuardBuf).stubs().will(returnValue(0));
    MOCKER(halQueueEnQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128] = {0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(0, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelEnqueueBuffTest, ModelEnqueueBuff_failed1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueEnQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    TsAicpuNotify *aicpuNotify = nullptr;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)aicpuNotify;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelEnqueueBuffTest, ModelEnqueueBuff_failed2)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&BufManager::UnGuardBuf).stubs().will(returnValue(0));
    MOCKER(halQueueEnQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128] = {0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    MOCKER(halMbufGetDataLen).stubs().will(returnValue(2));
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(0, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelEnqueueBuffTest, ModelEnqueueBuffTaskKernel_failed1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueEnQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    int *mbuf = nullptr;
    BufEnQueueBuffInfo bufInfoT;
    bufInfoT.mBufPtr = (uint64_t)mbuf;

    int ret = kernel_.ModelEnqueueBuff(bufInfoT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelEnqueueBuffTest, ModelEnqueueBuffTaskKernel_failed2)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueEnQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    char *mbuf = allocFakeMBuf[0];
    BufEnQueueBuffInfo bufInfoT;
    bufInfoT.mBufPtr = (uint64_t)&mbuf;

    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));

    int ret = kernel_.ModelEnqueueBuff(bufInfoT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelEnqueueBuffTest, ModelEnqueueBuffTaskKernel_failed3)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueEnQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    char *mbuf = allocFakeMBuf[0];
    BufEnQueueBuffInfo bufInfoT;
    bufInfoT.mBufPtr = (uint64_t)&mbuf;

    MOCKER_CPP(&AicpuModel::GetModelRetCode).stubs().will(returnValue(1));
    int ret = kernel_.ModelEnqueueBuff(bufInfoT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}