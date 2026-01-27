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
#include "operator_kernel_model_batch_dequeue.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

namespace {
int32_t CheckAndParseBatchDequeueParamsStub(OperatorKernelModelBatchDequeue *obj, const AicpuTaskInfo &kernelTaskInfo,
    const RunContext &taskContext, BatchDequeueInfo &batchDeqInfo)
{
    batchDeqInfo.inputNums = 1;
    batchDeqInfo.queueIds = &batchDequeueInfoQueueIds[0];
    batchDeqInfo.mbufAddrs = &batchDequeueInfoMbufAddrs[0];
    return AICPU_SCHEDULE_OK;
}

int halMbufGetPrivInfoStub2(Mbuf *mbuf, void **priv, unsigned int *size)
{
    g_curHead.aicpuBufhead.startTime = 10;
    g_curHead.aicpuBufhead.endTime = 10;
    *priv = reinterpret_cast<void *>(&g_curHead);
    *size = 256;
    return 0;
}

int halMbufGetPrivInfoStub3(Mbuf *mbuf, void **priv, unsigned int *size)
{
    g_curHead.aicpuBufhead.startTime = 10;
    g_curHead.aicpuBufhead.endTime = 10;
    *priv = reinterpret_cast<void *>(&g_curHead);
    *size = 32;
    return 0;
}

int halMbufGetPrivInfoStub4(Mbuf *mbuf, void **priv, unsigned int *size)
{
    g_curHead.aicpuBufhead.startTime = 10;
    g_curHead.aicpuBufhead.endTime = 10;
    *priv = reinterpret_cast<void *>(&g_curHead);
    *size = 32;
    return 0;
}

uint32_t batchDequeueInfoAlignOffsets[2] = {0, 0};

}  // namespace

class OperatorKernelModelBatchDequeueTest : public OperatorKernelTest {
protected:
    OperatorKernelModelBatchDequeue kernel_;
};

TEST_F(OperatorKernelModelBatchDequeueTest, ModelBatchDequeue_001)
{
    MOCKER_CPP(&OperatorKernelModelBatchDequeue::CheckAndParseBatchDequeueParams).stubs().will(returnValue(-1));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    const AicpuTaskInfo task = {};
    int ret = kernel_.Compute(task, runContextT);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(OperatorKernelModelBatchDequeueTest, ModelBatchDequeue_002)
{
    MOCKER_CPP(&OperatorKernelModelBatchDequeue::CheckAndParseBatchDequeueParams)
        .stubs().will(invoke(CheckAndParseBatchDequeueParamsStub));
    AicpuModel aicpuModel;
    auto &inputsIsDequeue = aicpuModel.MutableInputsIsDequeue();
    inputsIsDequeue.resize(1, false);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&OperatorKernelModelBatchDequeue::DequeueTask).stubs().will(returnValue((int32_t)0));
    MOCKER_CPP(&OperatorKernelModelBatchDequeue::AlignBatchDequeue).stubs().will(returnValue(0));
    const AicpuTaskInfo task = {};
    int32_t ret = kernel_.Compute(task, runContextT);
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueTest, CheckAndParseBatchDequeueParams_001)
{
    AicpuModel aicpuModel;
    auto &inputsIsDequeue = aicpuModel.MutableInputsIsDequeue();
    inputsIsDequeue.resize(1, false);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo task;
    BatchDequeueDesc batchDeqDesc = {};
    batchDeqDesc.inputNums = 1U;
    batchDeqDesc.alignInterval = 0U;
    batchDeqDesc.alignOffsetsAddr = 0x1U;
    batchDeqDesc.queueIdsAddr = (uint64_t)(&batchDequeueInfoQueueIds[0]);
    batchDeqDesc.mbufAddrsAddr = (uint64_t)(&batchDequeueInfoMbufAddrs[0]);
    task.paraBase = (uint64_t)(&batchDeqDesc);
    BatchDequeueInfo batchDeqInfo = {};
    int32_t ret = kernel_.CheckAndParseBatchDequeueParams(task, runContextT, batchDeqInfo);
    EXPECT_EQ(ret, 0);
    EXPECT_EQ(batchDeqInfo.inputNums, batchDeqDesc.inputNums);
    EXPECT_EQ(batchDeqInfo.alignInterval, batchDeqDesc.alignInterval);
    EXPECT_EQ((uint64_t)batchDeqInfo.alignOffsets, batchDeqDesc.alignOffsetsAddr);
    EXPECT_EQ((uint64_t)batchDeqInfo.queueIds, batchDeqDesc.queueIdsAddr);
    EXPECT_EQ((uint64_t)batchDeqInfo.mbufAddrs, batchDeqDesc.mbufAddrsAddr);
}

TEST_F(OperatorKernelModelBatchDequeueTest, CheckAndParseBatchDequeueParams_002)
{
    AicpuTaskInfo task;
    task.paraBase = 0;
    BatchDequeueInfo batchDeqInfo = {};
    int32_t ret = kernel_.CheckAndParseBatchDequeueParams(task, runContextT, batchDeqInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelBatchDequeueTest, CheckAndParseBatchDequeueParams_003)
{
    AicpuModel *aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    AicpuTaskInfo task;
    BatchDequeueDesc batchDeqDesc = {};
    batchDeqDesc.inputNums = 1U;
    batchDeqDesc.alignInterval = 0U;
    batchDeqDesc.alignOffsetsAddr = 0x1U;
    batchDeqDesc.queueIdsAddr = (uint64_t)(&batchDequeueInfoQueueIds[0]);
    batchDeqDesc.mbufAddrsAddr = (uint64_t)(&batchDequeueInfoMbufAddrs[0]);
    task.paraBase = (uint64_t)(&batchDeqDesc);
    BatchDequeueInfo batchDeqInfo = {};
    int32_t ret = kernel_.CheckAndParseBatchDequeueParams(task, runContextT, batchDeqInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelBatchDequeueTest, AlignBatchDequeue_001)
{
    AicpuModel aicpuModel;
    auto &inputsIsDequeue = aicpuModel.MutableInputsIsDequeue();
    inputsIsDequeue.resize(1, false);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    BatchDequeueInfo batchDeqInfo = {};
    MOCKER_CPP(&OperatorKernelDequeueBase::AlignTimestamp).stubs().will(invoke(AlignTimestampStub1));
    int32_t ret = kernel_.AlignBatchDequeue(batchDeqInfo, runContextT);
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueTest, AlignBatchDequeue_002)
{
    AicpuModel aicpuModel;
    auto &inputsIsDequeue = aicpuModel.MutableInputsIsDequeue();
    inputsIsDequeue.resize(1, false);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    BatchDequeueInfo batchDeqInfo = {};
    batchDeqInfo.mbufAddrs = &batchDequeueInfoMbufAddrs[0];
    batchDeqInfo.queueIds = &batchDequeueInfoQueueIds[0];

    MOCKER_CPP(&OperatorKernelModelBatchDequeue::AlignTimestamp).stubs().will(invoke(AlignTimestampStub2));
    MOCKER(halMbufFree).stubs().will(returnValue(0));
    MOCKER_CPP(&OperatorKernelModelBatchDequeue::DequeueTask).stubs().will(returnValue(0));
    runContextT.pending = true;
    int32_t ret = kernel_.AlignBatchDequeue(batchDeqInfo, runContextT);
    runContextT.pending = false;
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueTest, AlignTimestamp_001)
{
    AicpuModel aicpuModel;
    auto &inputsIsDequeue = aicpuModel.MutableInputsIsDequeue();
    inputsIsDequeue.resize(1, false);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    BatchDequeueInfo batchDeqInfo = {};
    batchDeqInfo.inputNums = 1U;
    batchDeqInfo.mbufAddrs = &batchDequeueInfoMbufAddrs[0];
    batchDeqInfo.queueIds = &batchDequeueInfoQueueIds[0];
    batchDeqInfo.alignOffsets = &batchDequeueInfoAlignOffsets[0];
    uint32_t maxAlignTimestamp = 0U;
    uint32_t minAlignTimestamp = UINT32_MAX;
    uint32_t minTimestampIndex = 0U;

    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoStub2));
    int32_t ret =
        kernel_.AlignTimestamp(batchDeqInfo, runContextT, maxAlignTimestamp, minAlignTimestamp, minTimestampIndex);
    EXPECT_EQ(ret, 0);
}

TEST_F(OperatorKernelModelBatchDequeueTest, AlignTimestamp_002)
{
    AicpuModel aicpuModel;
    auto &inputsIsDequeue = aicpuModel.MutableInputsIsDequeue();
    inputsIsDequeue.resize(1, false);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    BatchDequeueInfo batchDeqInfo = {};
    batchDeqInfo.inputNums = 1U;
    batchDeqInfo.mbufAddrs = &batchDequeueInfoMbufAddrs[0];
    batchDeqInfo.queueIds = &batchDequeueInfoQueueIds[0];
    batchDeqInfo.alignOffsets = &batchDequeueInfoAlignOffsets[0];
    uint32_t maxAlignTimestamp = 0U;
    uint32_t minAlignTimestamp = UINT32_MAX;
    uint32_t minTimestampIndex = 0U;

    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoStub3));
    int32_t ret =
        kernel_.AlignTimestamp(batchDeqInfo, runContextT, maxAlignTimestamp, minAlignTimestamp, minTimestampIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelBatchDequeueTest, AlignTimestamp_003)
{
    AicpuModel aicpuModel;
    auto &inputsIsDequeue = aicpuModel.MutableInputsIsDequeue();
    inputsIsDequeue.resize(1, false);
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    BatchDequeueInfo batchDeqInfo = {};
    batchDeqInfo.inputNums = 1U;
    batchDeqInfo.mbufAddrs = &batchDequeueInfoMbufAddrs[0];
    batchDeqInfo.queueIds = &batchDequeueInfoQueueIds[0];
    batchDeqInfo.alignOffsets = &batchDequeueInfoAlignOffsets[0];
    uint32_t maxAlignTimestamp = 0U;
    uint32_t minAlignTimestamp = UINT32_MAX;
    uint32_t minTimestampIndex = 0U;

    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoStub4));
    int32_t ret =
        kernel_.AlignTimestamp(batchDeqInfo, runContextT, maxAlignTimestamp, minAlignTimestamp, minTimestampIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}