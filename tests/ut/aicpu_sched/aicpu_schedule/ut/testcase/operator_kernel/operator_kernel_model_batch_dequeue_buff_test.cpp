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
#include "operator_kernel_model_batch_dequeue_buff.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

namespace {
uint32_t batchDequeueInfoDeviceIds[] = {0U, 1U};
int32_t CheckAndParseBatchDeqBufParamsStub(OperatorKernelModelBatchDequeueBuff *obj,
    const BatchDequeueBuffDesc *const batchDeqBufDesc, const AicpuTaskInfo &kernelTaskInfo,
    const RunContext &taskContext, BatchDequeueBuffInfo &batchDeqBufInfo)
{
    batchDeqBufInfo.inputNums = 1;
    batchDeqBufInfo.queueIds = &batchDequeueInfoQueueIds[0];
    batchDeqBufInfo.mbufAddrs = &batchDequeueInfoMbufAddrs[0];
    batchDeqBufInfo.deviceIds = &batchDequeueInfoDeviceIds[0];
    return AICPU_SCHEDULE_OK;
}
}  // namespace

class OperatorKernelModelBatchDequeueBuffTest : public OperatorKernelTest {
protected:
    OperatorKernelModelBatchDequeueBuff kernel_;
};

TEST_F(OperatorKernelModelBatchDequeueBuffTest, ModelBatchDequeueBuff_001)
{
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::CheckAndParseBatchDeqBufParams).stubs().will(returnValue(-1));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCKER(halQueueDeQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128] = {0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, -1);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, ModelBatchDequeueBuff_002)
{
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCKER(halQueueDeQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    AicpuTaskInfo taskT;
    BatchDequeueBuffDesc *dequeBuff = nullptr;
    taskT.paraBase = (uint64_t)dequeBuff;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, ModelBatchDequeueBuff_003)
{
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::CheckAndParseBatchDeqBufParams)
        .stubs()
        .will(invoke(CheckAndParseBatchDeqBufParamsStub));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::ModelDequeueBuffTaskKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::AlignBatchDequeueBuff).stubs().will(returnValue(0));
    MOCKER(halQueueDeQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128] = {0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int32_t ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, ModelBatchDequeueBuff_004)
{
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::CheckAndParseBatchDeqBufParams)
        .stubs()
        .will(invoke(CheckAndParseBatchDeqBufParamsStub));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::ModelDequeueBuffTaskKernel)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_MODEL_UNLOAD));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::AlignBatchDequeueBuff).stubs().will(returnValue(0));
    MOCKER(halQueueDeQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128] = {0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)&mbuf};
    taskT.paraBase = (uint64_t)&queue;
    int32_t ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, DequeueBuffTask_001)
{
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::CheckAndParseBatchDeqBufParams)
        .stubs()
        .will(invoke(CheckAndParseBatchDeqBufParamsStub));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::AlignBatchDequeueBuff).stubs().will(returnValue(0));
    uint64_t respLen = sizeof(struct buff_iovec) + sizeof(struct iovec_info);
    MOCKER(halQueuePeek).stubs().with(mockcpp::any(), mockcpp::any(), outBoundP(&respLen), mockcpp::any()).will(returnValue(DRV_ERROR_NONE));
    MOCKER(halQueueDeQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128] = {0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)&mbuf};
    int32_t ret = kernel_.ModelDequeueBuffTaskKernel(queue, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, DequeueBuffTask_002)
{
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::CheckAndParseBatchDeqBufParams)
        .stubs()
        .will(invoke(CheckAndParseBatchDeqBufParamsStub));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::AlignBatchDequeueBuff).stubs().will(returnValue(0));
    uint64_t respLen = sizeof(struct buff_iovec) + sizeof(struct iovec_info);
    MOCKER(halQueuePeek).stubs().with(mockcpp::any(), mockcpp::any(), outBoundP(&respLen), mockcpp::any()).will(returnValue(DRV_ERROR_NONE));
    MOCKER(halQueueDeQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128] = {0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    MOCKER_CPP(&BufManager::MallocAndGuardBuf).stubs().will(returnValue(mbuf));
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)&mbuf};
    int32_t ret = kernel_.ModelDequeueBuffTaskKernel(queue, runContextT);
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, ModelDequeueBuffTaskKernel_003)
{
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::CheckAndParseBatchDeqBufParams)
        .stubs()
        .will(invoke(CheckAndParseBatchDeqBufParamsStub));
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::AlignBatchDequeueBuff).stubs().will(returnValue(0));
    uint64_t respLen = sizeof(struct buff_iovec) + sizeof(struct iovec_info);
    MOCKER(halQueuePeek).stubs().with(mockcpp::any(), mockcpp::any(), outBoundP(&respLen), mockcpp::any()).will(returnValue(DRV_ERROR_NONE));
    MOCKER(halQueueDeQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128] = {0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    MOCKER_CPP(&BufManager::MallocAndGuardBuf).stubs().will(returnValue(mbuf));
    MOCKER_CPP(&AicpuModel::GetModelDestroyStatus).stubs().will(returnValue(true));
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)&mbuf};
    int32_t ret = kernel_.ModelDequeueBuffTaskKernel(queue, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_UNLOAD);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, AlignBatchDequeueBuff_001)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    BatchDequeueBuffInfo batchDeqBuffInfo = {};
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::AlignTimestamp).stubs().will(invoke(AlignTimestampStub1));
    int32_t ret = kernel_.AlignBatchDequeueBuff(batchDeqBuffInfo, runContextT);
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, AlignBatchDequeueBuff_002)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    BatchDequeueBuffInfo batchDeqBuffInfo = {};
    batchDeqBuffInfo.mbufAddrs = &batchDequeueInfoMbufAddrs[0];
    batchDeqBuffInfo.queueIds = &batchDequeueInfoQueueIds[0];
    batchDeqBuffInfo.deviceIds = &batchDequeueInfoDeviceIds[0];

    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::AlignTimestamp).stubs().will(invoke(AlignTimestampStub2));
    MOCKER(halMbufFree).stubs().will(returnValue(0));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::ModelDequeueBuffTaskKernel).stubs().will(returnValue(-1));
    runContextT.pending = true;
    int32_t ret = kernel_.AlignBatchDequeueBuff(batchDeqBuffInfo, runContextT);
    runContextT.pending = false;
    EXPECT_EQ(ret, -1);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, AlignBatchDequeueBuff_003)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    BatchDequeueBuffInfo batchDeqBuffInfo = {};
    batchDeqBuffInfo.mbufAddrs = &batchDequeueInfoMbufAddrs[0];
    batchDeqBuffInfo.queueIds = &batchDequeueInfoQueueIds[0];
    batchDeqBuffInfo.deviceIds = &batchDequeueInfoDeviceIds[0];

    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::AlignTimestamp).stubs().will(invoke(AlignTimestampStub2));
    MOCKER(halMbufFree).stubs().will(returnValue(0));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::ModelDequeueBuffTaskKernel)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_MODEL_UNLOAD));
    runContextT.pending = true;
    int32_t ret = kernel_.AlignBatchDequeueBuff(batchDeqBuffInfo, runContextT);
    runContextT.pending = false;
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, CheckAndParseBatchDeqBuffParams_001)
{
    AicpuModel aicpuModel;
    auto &inputsIsDequeue = aicpuModel.MutableInputsIsDequeue();
    inputsIsDequeue.resize(1, false);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo task;
    BatchDequeueBuffDesc batchDeqBufDesc = {};
    batchDeqBufDesc.inputNums = 1U;
    batchDeqBufDesc.alignInterval = 0U;
    batchDeqBufDesc.alignOffsetsAddr = 0x1U;
    batchDeqBufDesc.queueIdsAddr = (uint64_t)(&batchDequeueInfoQueueIds[0]);
    batchDeqBufDesc.mbufAddrsAddr = (uint64_t)(&batchDequeueInfoMbufAddrs[0]);
    batchDeqBufDesc.deviceIdAddr = (uint64_t)(&batchDequeueInfoDeviceIds[0]);
    task.paraBase = (uint64_t)(&batchDeqBufDesc);
    BatchDequeueBuffInfo batchDeqBufInfo = {};
    int32_t ret = kernel_.CheckAndParseBatchDeqBufParams(&batchDeqBufDesc, task, runContextT, batchDeqBufInfo);
    EXPECT_EQ(ret, 0);
    EXPECT_EQ(batchDeqBufInfo.inputNums, batchDeqBufDesc.inputNums);
    EXPECT_EQ(batchDeqBufInfo.alignInterval, batchDeqBufDesc.alignInterval);
    EXPECT_EQ((uint64_t)batchDeqBufInfo.alignOffsets, batchDeqBufDesc.alignOffsetsAddr);
    EXPECT_EQ((uint64_t)batchDeqBufInfo.queueIds, batchDeqBufDesc.queueIdsAddr);
    EXPECT_EQ((uint64_t)batchDeqBufInfo.mbufAddrs, batchDeqBufDesc.mbufAddrsAddr);
    EXPECT_EQ((uint64_t)batchDeqBufInfo.deviceIds, batchDeqBufDesc.deviceIdAddr);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, CheckAndParseBatchDeqBufParams_003)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    AicpuTaskInfo task;
    BatchDequeueBuffDesc batchDeqBufDesc = {};
    batchDeqBufDesc.inputNums = 1U;
    batchDeqBufDesc.alignInterval = 0U;
    batchDeqBufDesc.alignOffsetsAddr = 0x1U;
    batchDeqBufDesc.queueIdsAddr = (uint64_t)(&batchDequeueInfoQueueIds[0]);
    batchDeqBufDesc.mbufAddrsAddr = (uint64_t)(&batchDequeueInfoMbufAddrs[0]);
    batchDeqBufDesc.deviceIdAddr = (uint64_t)(&batchDequeueInfoDeviceIds[0]);
    task.paraBase = (uint64_t)(&batchDeqBufDesc);
    BatchDequeueBuffInfo batchDeqBufInfo = {};
    int32_t ret = kernel_.CheckAndParseBatchDeqBufParams(&batchDeqBufDesc, task, runContextT, batchDeqBufInfo);
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, ModelDequeueBuffTaskKernel_FAILED1) {
    MOCKER(halQueueDeQueueBuff).stubs().will(returnValue(DRV_ERROR_NONE));

    Mbuf **mbuf = nullptr;
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)mbuf};
    int ret = kernel_.ModelDequeueBuffTaskKernel(queue, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelBatchDequeueBuffTest, ModelDequeueBuffTaskKernel_TryOnce_WhenPeekFail)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER(halQueuePeek).stubs().will(returnValue(DRV_ERROR_NO_EVENT));
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    char tmpBuf[128] = {0};
    Mbuf *mbuf = (Mbuf *)tmpBuf;
    BufEnQueueBuffInfo queue{0, 0, (uint64_t)&mbuf};
    int32_t ret = kernel_.ModelDequeueBuffTaskKernel(queue, runContextT, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}