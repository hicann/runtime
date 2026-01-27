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
#include "operator_kernel_model_enqueue.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

namespace {}  // namespace

class OperatorKernelModelEnqueueTest : public OperatorKernelTest {
protected:
    OperatorKernelModelEnqueue kernel_;
};

TEST_F(OperatorKernelModelEnqueueTest, ModelEnqueue) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER_CPP(&BufManager::UnGuardBuf).stubs().will(returnValue(0));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128]={0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    BufEnQueueInfo queue{0,(uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;

    uint32_t dataLen = 128U;
    void *headPtr = reinterpret_cast<void *>(&tmpBuf[0U]);
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .with(mockcpp::any(), outBoundP(&headPtr), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));;

    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER(memcpy_s).stubs().will(returnValue(1));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);

    MOCKER(CheckLogLevel).stubs().will(returnValue(0));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelEnqueueTest, ModelEnqueue_failed1) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    TsAicpuNotify *aicpuNotify = nullptr;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)aicpuNotify;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelEnqueueTest, ModelEnqueueTaskKernel_failed1) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    int *mbuf = nullptr;
    BufEnQueueInfo bufInfoT;
    bufInfoT.mBufPtr = (uint64_t)mbuf;

    int ret = kernel_.EnqueueTask(bufInfoT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelEnqueueTest, ModelEnqueueTaskKernel_failed2) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    char *mbuf = allocFakeMBuf[0];
    BufEnQueueInfo bufInfoT;
    bufInfoT.mBufPtr = (uint64_t)&mbuf;

    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));

    int ret = kernel_.EnqueueTask(bufInfoT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelEnqueueTest, ModelEnqueueTaskKernel_failed3) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    char *mbuf = allocFakeMBuf[0];
    BufEnQueueInfo bufInfoT;
    bufInfoT.mBufPtr = (uint64_t)&mbuf;

    MOCKER_CPP(&AicpuModel::GetModelRetCode).stubs().will(returnValue(1));
    MOCKER_CPP(&AicpuModel::AbnormalEnabled).stubs().will(returnValue(false));
    int ret = kernel_.EnqueueTask(bufInfoT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelEnqueueTest, ModelEnqueue_halQueueEnQueue_FAILED) {
    MOCKER(halQueueEnQueue).stubs().will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128]={0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    BufEnQueueInfo queue{0,(uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelEnqueueTest, ModelEnqueue_halQueueEnQueue_FULL) {
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueEnQueue).stubs().will(returnValue(DRV_ERROR_QUEUE_FULL));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128]={0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    uint32_t queueId = 123;
    BufEnQueueInfo queue{queueId,(uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    bool hasWait = false;
    uint32_t notifyStreamId;
    EventWaitManager::QueueNotFullWaitManager().Event(queueId, hasWait, notifyStreamId);
    EXPECT_TRUE(hasWait);
}

TEST_F(OperatorKernelModelEnqueueTest, ModelEnqueueForEOS) {
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFakeForEOS));
    MOCKER_CPP(&BufManager::UnGuardBuf).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuModel::IsEndOfSequence).stubs().will(returnValue(true));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER(halQueueEnQueue).stubs().will(returnValue(DRV_ERROR_NONE));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char mbufVal[MAX_SIZE_BUF_FOR_FAKE_EOS] = {0};
    Mbuf *mbuf = (Mbuf *)mbufVal;
    BufEnQueueInfo queue{0,(uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelEnqueueTest, SetMbufNullData_success)
{
    char head[256] = {};
    AicpuModel aicpuModel;
    aicpuModel.nullDataFlag_ = true;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    kernel_.SetMbufNullData(0U, &head[0U], 256U);
    MbufHeadMsg *const msg = PtrToPtr<uint8_t, MbufHeadMsg>(
        PtrAdd<uint8_t>(PtrToPtr<char, uint8_t>(&head[0U]), 256U, 256U - sizeof(MbufHeadMsg)));
    EXPECT_TRUE((msg->dataFlag & MBUF_HEAD_DATA_FLAG_MASK) == static_cast<uint8_t>(DataFlag::DFLOW_NULL_DATA_FLAG));
}