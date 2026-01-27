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
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_gather_dequeue.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"


using namespace AicpuSchedule;


namespace {
std::vector<MbufHeadMsg> g_mbufHeads[3];
size_t g_dequeCursor[3] = {0};
void GenerateMbufHead(uint64_t transId, uint32_t routeLabel, std::vector<MbufHeadMsg> &heads) {
    MbufHeadMsg mbufhead = {};
    mbufhead.transId = transId;
    mbufhead.dataLabel = routeLabel;
    heads.emplace_back(mbufhead);
}
void ClearMbufHeads() {
    for (size_t i = 0; i < 3U; ++i) {
        g_mbufHeads[i].clear();
        g_dequeCursor[i] = 0U;
    }
}

drvError_t halQueueDeQueueHead(unsigned int devId, unsigned int qid, void **mbuf)
{
    std::cout << "try to dequed mbuf from queue: " << qid << std::endl;
    if (qid >= 3U) {
        return DRV_ERROR_NO_DEVICE;
    }

    if (g_dequeCursor[qid] >= g_mbufHeads[qid].size()) {
        return DRV_ERROR_QUEUE_EMPTY;
    }

    auto &head = g_mbufHeads[qid][g_dequeCursor[qid]];
    *mbuf = (Mbuf *)(&head);
    std::cout << "dequed mbuf: "<< *mbuf << " from queue: " << qid << std::endl;
    g_dequeCursor[qid]++;
    if ((head.transId == 0U) && (head.routeLabel == 0U)) {
        return DRV_ERROR_QUEUE_EMPTY;
    }
    return DRV_ERROR_NONE;
}

int halMbufGetPrivInfoFakeHead(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    *priv = (void *)mbuf;
    *size = sizeof(MbufHeadMsg);
    return DRV_ERROR_NONE;
}

int32_t halMbufGetBuffAddrFakeHead(Mbuf *mbuf, void **buf)
{
    std::cout << "aicpusd_interface_process_test halMbufGetBuffAddrFakeHead begin" << std::endl;
    *buf = (void*)((char*)mbuf+sizeof(MbufHeadMsg));
    return 0;
}
}

class OperatorKernelGatherDequeueTest : public OperatorKernelTest {
protected:
    OperatorKernelGatherDequeue kernel_;
};

TEST_F(OperatorKernelGatherDequeueTest, ModelGatherDeque_success) {
    GenerateMbufHead(1U, 1U, g_mbufHeads[0]);
    GenerateMbufHead(2U, 2U, g_mbufHeads[0]);
    GenerateMbufHead(0U, 0U, g_mbufHeads[0]); // use (0,0) to mock data-break
    GenerateMbufHead(3U, 2U, g_mbufHeads[0]);
    GenerateMbufHead(2U, 2U, g_mbufHeads[1]);
    GenerateMbufHead(3U, 2U, g_mbufHeads[1]);
    GenerateMbufHead(3U, 3U, g_mbufHeads[1]);
    GenerateMbufHead(1U, 1U, g_mbufHeads[2]);
    GenerateMbufHead(3U, 3U, g_mbufHeads[2]);
    GenerateMbufHead(2U, 2U, g_mbufHeads[2]);

    uint32_t stubId = 1U;
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = stubId;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueHead));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFakeHead));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    GatherDequeParam batchDeqInfo = {};
    batchDeqInfo.inputNums = 3U;
    uint32_t queueIds[3] = {0U, 1U, 2U};
    batchDeqInfo.queueIdsAddr = (uint64_t)(&queueIds[0U]);
    MbufHeadMsg *placeHolder[3] = {nullptr};
    MbufHeadMsg **mbufAddrsAddr[3] = {&placeHolder[0], &placeHolder[1], &placeHolder[2]};
    batchDeqInfo.mbufAddrsAddr = (uint64_t)(&mbufAddrsAddr[0U]);
    uint32_t deviceTypes[3] = {0U};
    batchDeqInfo.deviceTypeAddr = (uint64_t)(&deviceTypes[0U]);
    batchDeqInfo.deviceIdAddr = (uint64_t)(&deviceTypes[0U]);
    taskT.paraBase = (uint64_t)&batchDeqInfo;

    RunContext runContextLocal = {.modelId = stubId,
                                  .modelTsId = stubId,
                                  .streamId = stubId,
                                  .pending = false,
                                  .executeInline = true,
                                  .gotoTaskIndex = -1};
    int ret = kernel_.Compute(taskT, runContextLocal);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(runContextLocal.pending, true);

    runContextLocal.pending = false;
    EXPECT_EQ(kernel_.Compute(taskT, runContextLocal), AICPU_SCHEDULE_OK);
    EXPECT_EQ(placeHolder[0]->transId, 2U);
    EXPECT_EQ(placeHolder[0]->dataLabel, 2U);
    EXPECT_EQ(placeHolder[1]->transId, 2U);
    EXPECT_EQ(placeHolder[1]->dataLabel, 2U);
    EXPECT_EQ(placeHolder[2]->transId, 2U);
    EXPECT_EQ(placeHolder[2]->dataLabel, 2U);

    std::cout << "fake selected and not allow to drop out" << std::endl;
    uint64_t dataLen = sizeof(RuntimeTensorDesc);
    char mbufStub[dataLen + sizeof(MbufHeadMsg)] = {};
    MOCKER_CPP(&BufManager::MallocAndGuardBufU64)
        .stubs()
        .will(returnValue(reinterpret_cast<Mbuf*>(&mbufStub[0U])));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFakeHead));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    batchDeqInfo.inputsAlignMaxCacheNum = 1U;
    EXPECT_EQ(kernel_.Compute(taskT, runContextLocal), AICPU_SCHEDULE_ERROR_DISCARD_DATA);
    EXPECT_EQ(placeHolder[0]->transId, 1U);
    EXPECT_EQ(placeHolder[0]->dataLabel, 1U);

    std::cout << "fake selected and allow to drop out, pending is " << runContextLocal.pending << std::endl;
    batchDeqInfo.inputsAlignDropout = 1U;
    EXPECT_EQ(kernel_.Compute(taskT, runContextLocal), AICPU_SCHEDULE_OK);
    EXPECT_TRUE(runContextLocal.pending);

    aicpuModel.ReleaseModelResource();
    ClearMbufHeads();
}

TEST_F(OperatorKernelGatherDequeueTest, ModelGatherDeque_fail) {
    AicpuTaskInfo taskT = {};
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    GatherDequeParam batchDeqInfo = {};
    batchDeqInfo.inputNums = 3U;
    taskT.paraBase = (uint64_t)&batchDeqInfo;
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    uint32_t queueIds[3] = {0U, 1U, 2U};
    batchDeqInfo.queueIdsAddr = (uint64_t)(&queueIds[0U]);
    MbufHeadMsg *placeHolder[3] = {nullptr};
    MbufHeadMsg **mbufAddrsAddr[3] = {&placeHolder[0], &placeHolder[1], &placeHolder[2]};
    batchDeqInfo.mbufAddrsAddr = (uint64_t)(&mbufAddrsAddr[0U]);
    uint32_t deviceTypes[3] = {0U};
    batchDeqInfo.deviceTypeAddr = (uint64_t)(&deviceTypes[0U]);
    batchDeqInfo.deviceIdAddr = (uint64_t)(&deviceTypes[0U]);
    AicpuModel *aicpuModelPtr = nullptr;
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(aicpuModelPtr))
        .then(returnValue(&aicpuModel));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_INNER_ERROR);
    MOCKER_CPP(&AicpuModel::SelectGatheredMbuf)
        .stubs()
        .will(returnValue(GatherResult::SELECTED))
        .then(returnValue(GatherResult::FAKE_SELECTED));

    uint64_t dataLen = sizeof(RuntimeTensorDesc);
    char mbufStub[dataLen + sizeof(MbufHeadMsg)] = {};
    MOCKER_CPP(&BufManager::MallocAndGuardBufU64)
        .stubs()
        .will(returnValue(reinterpret_cast<Mbuf*>(&mbufStub[0U])));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFakeHead));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFakeHead));
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    MOCKER_CPP(&BufManager::GuardBuf).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_DISCARD_DATA);
    MbufHeadMsg *headMsg = PtrToPtr<char_t, MbufHeadMsg>(&mbufStub[0U]);
    EXPECT_EQ(headMsg->retCode, INNER_ERROR_BASE + AICPU_SCHEDULE_ERROR_DISCARD_DATA);
}

TEST_F(OperatorKernelGatherDequeueTest, DequeAndCheckIfReady_ForClientQ_OnDestroy) {
    GatherDequeParam batchDeqInfo = {};
    batchDeqInfo.inputNums = 3U;
    uint32_t queueIds[3] = {0U, 1U, 2U};
    batchDeqInfo.queueIdsAddr = (uint64_t)(&queueIds[0U]);
    MbufHeadMsg *placeHolder[3] = {nullptr};
    MbufHeadMsg **mbufAddrsAddr[3] = {&placeHolder[0], &placeHolder[1], &placeHolder[2]};
    batchDeqInfo.mbufAddrsAddr = (uint64_t)(&mbufAddrsAddr[0U]);
    uint32_t deviceTypes[3] = {0U};
    batchDeqInfo.deviceTypeAddr = (uint64_t)(&deviceTypes[0U]);
    batchDeqInfo.deviceIdAddr = (uint64_t)(&deviceTypes[0U]);

    AicpuModel aicpuModel;
    aicpuModel.isDestroyModel_ = true;
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(&aicpuModel));

    MOCKER(GetAicpuDeployContext).stubs().with(outBound(DeployContext::HOST)).will(returnValue(AICPU_SCHEDULE_OK));
    int32_t ret = AICPU_SCHEDULE_OK;
    bool blockOnClientQ = false;
    EXPECT_FALSE(kernel_.DequeAndCheckIfReady(&batchDeqInfo, ret, &aicpuModel, runContextT, blockOnClientQ));
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MODEL_UNLOAD);
}

TEST_F(OperatorKernelGatherDequeueTest, MakeUpPassedMbuf_Fail) {
    // fail for malloc
    EXPECT_EQ(kernel_.MakeUpPassedMbuf(0U), nullptr);

    // fail for head
    uint64_t dataLen = sizeof(RuntimeTensorDesc);
    char mbufStub[dataLen + sizeof(MbufHeadMsg)] = {};
    MOCKER_CPP(&BufManager::MallocAndGuardBufU64)
        .stubs()
        .will(returnValue(reinterpret_cast<Mbuf*>(&mbufStub[0U])));
    EXPECT_EQ(kernel_.MakeUpPassedMbuf(0U), nullptr);
    // fail for body
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFakeHead));
    EXPECT_EQ(kernel_.MakeUpPassedMbuf(0U), nullptr);
    // success
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFakeHead));
    EXPECT_EQ(PtrToValue(kernel_.MakeUpPassedMbuf(0U)), PtrToValue(&mbufStub));
}

TEST_F(OperatorKernelGatherDequeueTest, ModelGatherDeque_EmptyOnClientQ) {
    AicpuTaskInfo taskT = {};
    GatherDequeParam batchDeqInfo = {};
    batchDeqInfo.inputNums = 3U;

    uint32_t queueIds[3] = {0U, 1U, 2U};
    batchDeqInfo.queueIdsAddr = (uint64_t)(&queueIds[0U]);
    MbufHeadMsg *placeHolder[3] = {nullptr};
    MbufHeadMsg **mbufAddrsAddr[3] = {&placeHolder[0], &placeHolder[1], &placeHolder[2]};
    batchDeqInfo.mbufAddrsAddr = (uint64_t)(&mbufAddrsAddr[0U]);
    uint32_t deviceTypes[3] = {0U};
    batchDeqInfo.deviceTypeAddr = (uint64_t)(&deviceTypes[0U]);
    batchDeqInfo.deviceIdAddr = (uint64_t)(&deviceTypes[0U]);
    taskT.paraBase = (uint64_t)&batchDeqInfo;
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel)
        .stubs()
        .will(returnValue(&aicpuModel));
    MOCKER_CPP(&AicpuModel::SelectGatheredMbuf)
        .stubs()
        .will(returnValue(GatherResult::UN_SELECTED));
    MOCKER(GetAicpuDeployContext).stubs().with(outBound(DeployContext::HOST)).will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelModelBatchDequeueBuff::ModelAttachAndDequeueBuff)
        .stubs().will(returnValue(AICPU_SCHEDULE_OK));

    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}