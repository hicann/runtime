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
#include "operator_kernel_model_prepare.h"
#include "operator_kernel_model_postpare.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"
#include "operator_kernel_common.h"

using namespace AicpuSchedule;

namespace {}  // namespace

class OperatorKernelModelPreAndPostpareTest : public OperatorKernelTest {
protected:
    OperatorKernelModelPostpare postKernel_;
    OperatorKernelModelPrepare preKernel_;
};

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_And_Postpare_Success)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halQueueEnQueue).stubs().will(invoke(halQueueEnQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);

    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    for (uint32_t i = 0; i < info.inputAddrNum; i++) {
        void *dataPtr = *(reinterpret_cast<void **>(inputAddrList[i]));
        void *checkDataPtr =
            calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(dequeueFakeMBuf[inQueueIdList[inputIndexList[i]]]), 0);
        EXPECT_EQ(dataPtr, checkDataPtr);
    }

    for (uint32_t i = 0; i < info.outputAddrNum; i++) {
        void *dataPtr = *(reinterpret_cast<void **>(outputAddrList[i]));
        void *checkDataPtr = calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(allocFakeMBuf[outputIndexList[i]]), 0);
        EXPECT_EQ(dataPtr, checkDataPtr);
    }

    for (uint32_t i = 0; i < info.outQueueNum; i++) {
        void *mbufPtr = reinterpret_cast<void *>(mbufPtrlist[i]);
        EXPECT_EQ(mbufPtr, allocFakeMBuf[i]);
    }

    ret = postKernel_.Compute(taskT, runContextT);

    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    for (uint32_t i = 0; i < info.outQueueNum; i++) {
        void *mbufPtr = reinterpret_cast<void *>(mbufPtrlist[i]);
        void *enqueueMbufPtr = enqueueFakeStore[outQueueIdList[i]].front();
        EXPECT_EQ(mbufPtr, enqueueMbufPtr);
    }
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Error_Size)
{
    BUILD_SUCC_PREPARE_INFO();
    // error size
    info.aicpuPareInfoSize = sizeof(AicpuPrepareInfo) + 1;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_And_Postpare_Pending_Succ)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    MOCKER(halQueueDeQueue)
        .stubs()
        .will(invoke(halQueueDeQueueFake))
        .then(invoke(halQueueDeQueueFake))
        .then(returnValue(DRV_ERROR_QUEUE_EMPTY))
        .then(invoke(halQueueDeQueueFake))
        .then(invoke(halQueueDeQueueFake));
    MOCKER(halQueueEnQueue)
        .stubs()
        .will(invoke(halQueueEnQueueFake))
        .then(returnValue(DRV_ERROR_QUEUE_FULL))
        .then(invoke(halQueueEnQueueFake))
        .then(invoke(halQueueEnQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(runContextT.pending, true);
    // 中断再次执行
    runContextT.pending = false;
    ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    for (uint32_t i = 0; i < info.inputAddrNum; i++) {
        void *dataPtr = *(reinterpret_cast<void **>(inputAddrList[i]));
        void *checkDataPtr =
            calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(dequeueFakeMBuf[inQueueIdList[inputIndexList[i]]]), 0);
        EXPECT_EQ(dataPtr, checkDataPtr);
    }

    for (uint32_t i = 0; i < info.outputAddrNum; i++) {
        void *dataPtr = *(reinterpret_cast<void **>(outputAddrList[i]));
        void *checkDataPtr = calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(allocFakeMBuf[outputIndexList[i]]), 0);
        EXPECT_EQ(dataPtr, checkDataPtr);
    }

    for (uint32_t i = 0; i < info.outQueueNum; i++) {
        void *mbufPtr = reinterpret_cast<void *>(mbufPtrlist[i]);
        EXPECT_EQ(mbufPtr, allocFakeMBuf[i]);
    }

    ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(runContextT.pending, true);
    // 中断再次执行
    runContextT.pending = false;
    ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    for (uint32_t i = 0; i < info.outQueueNum; i++) {
        void *mbufPtr = reinterpret_cast<void *>(mbufPtrlist[i]);
        void *enqueueMbufPtr = enqueueFakeStore[outQueueIdList[i]].front();
        EXPECT_EQ(mbufPtr, enqueueMbufPtr);
    }
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPostpare_Nullptr_Dataptr)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = 0;

    int ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error9)
{
    BUILD_SUCC_PREPARE_INFO();
    info.mbufPtrlist = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPostpare_Param_Nullptr_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    info.outQueueNum = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPostpare_Param_Nullptr_Error2)
{
    BUILD_SUCC_PREPARE_INFO();
    info.outQueueIdList = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPostpare_QueueEnQueue_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    MOCKER(halQueueEnQueue).stubs().will(returnValue(1));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // enqueue的mbuf*集合
    uint64_t mbufPtrlistSp[] = {(uint64_t)&allocFakeMBuf[0], (uint64_t)&allocFakeMBuf[1], (uint64_t)&allocFakeMBuf[2]};
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlistSp);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    auto ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_And_PostPare_GetModel_Error)
{
    BUILD_SUCC_PREPARE_INFO();
    delete aicpuModel;
    aicpuModel = nullptr;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halQueueEnQueue).stubs().will(invoke(halQueueEnQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // enqueue的mbuf*集合
    uint64_t mbufPtrlistSp[] = {(uint64_t)&allocFakeMBuf[0], (uint64_t)&allocFakeMBuf[1], (uint64_t)&allocFakeMBuf[2]};
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlistSp);

    ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_MAX_SIZE_Error6)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    info.outQueueNum = MAX_SIZE_NUM + 1;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPostpare_Param_Nullptr_List_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    auto addrList = (uint64_t *)info.mbufPtrlist;
    addrList[1] = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = postKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Dequeue_mbufList_Success)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // dequeue队列id
    uint32_t inQueueIdListSp[] = {1, 2, 3};
    // 每个mbuflist返回的mbuf长度
    // 测试用例只支持最后一个是N，其余是1,因为获取后面的mbuf实际上是+1操作，总计返回4个mbuf
    chainNumReturnValues = {1, 1, 2};
    mbufChainGetNumReturnValues = chainNumReturnValues;

    // 需要copy到用户数据指针的mbuf对应dataPtr的序号，对应4个mbuf
    uint32_t inputIndexListSp[] = {0, 1, 2, 3, 3};

    info.inputIndexList = reinterpret_cast<uint64_t>(inputIndexListSp);
    info.inQueueNum = sizeof(inQueueIdListSp) / sizeof(inQueueIdListSp[0]);
    info.inQueueIdList = reinterpret_cast<uint64_t>(inQueueIdListSp);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);

    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    void *dataPtr = nullptr;
    void *checkDataPtr = nullptr;

    uint32_t addrIndex = 0;
    dataPtr = *(reinterpret_cast<void **>(inputAddrList[addrIndex]));
    checkDataPtr =
        calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(dequeueFakeMBuf[inQueueIdListSp[inputIndexListSp[addrIndex]]]), 0);
    EXPECT_EQ(dataPtr, checkDataPtr);

    addrIndex = 1;
    dataPtr = *(reinterpret_cast<void **>(inputAddrList[addrIndex]));
    checkDataPtr =
        calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(dequeueFakeMBuf[inQueueIdListSp[inputIndexListSp[addrIndex]]]), 0);
    EXPECT_EQ(dataPtr, checkDataPtr);

    addrIndex = 2;
    dataPtr = *(reinterpret_cast<void **>(inputAddrList[addrIndex]));
    checkDataPtr =
        calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(dequeueFakeMBuf[inQueueIdListSp[inputIndexListSp[addrIndex]]]), 0);
    EXPECT_EQ(dataPtr, checkDataPtr);

    addrIndex = 3;
    dataPtr = *(reinterpret_cast<void **>(inputAddrList[addrIndex]));
    // 使用3号队列dequeue的mbuf的第二个mbuf（index为1）
    checkDataPtr = calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(dequeueFakeMBuf[3]), 1);
    EXPECT_EQ(dataPtr, checkDataPtr);

    addrIndex = 4;
    dataPtr = *(reinterpret_cast<void **>(inputAddrList[addrIndex]));
    checkDataPtr = calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(dequeueFakeMBuf[3]), 1);
    EXPECT_EQ(dataPtr, checkDataPtr);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Error_inQueueNum)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // error inQueueNum
    info.inQueueNum = sizeof(inputAddrList) / sizeof(inputAddrList[0]) + 1;
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Error_outQueueNum)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));
    // error outQueueNum
    info.outQueueNum = sizeof(outQueueIdList) / sizeof(outQueueIdList[0]) - 1;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Success_OneOutputQueue)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(invoke(halMbufChainAppendFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // enqueue队列id, 这里只有一个outqueue， 所有mubf会连起来
    uint32_t outQueueIdListSp[] = {11};
    uint64_t mbufPtrlistSp[sizeof(outQueueIdListSp) / sizeof(outQueueIdListSp[0])] = {0};

    // 前4个是enqueue的mbuf的长度，后一个是dequeue的mbuf的长度
    chainNumReturnValues = {1, 1, 1, 1, 3};
    mbufChainGetNumReturnValues = chainNumReturnValues;

    info.outQueueNum = sizeof(outQueueIdListSp) / sizeof(outQueueIdListSp[0]);
    info.outQueueIdList = reinterpret_cast<uint64_t>(outQueueIdListSp);
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlistSp);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;
    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    for (uint32_t i = 0; i < info.inputAddrNum; i++) {
        void *dataPtr = *(reinterpret_cast<void **>(inputAddrList[i]));
        void *checkDataPtr =
            calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(dequeueFakeMBuf[inQueueIdList[inputIndexList[i]]]), 0);
        EXPECT_EQ(dataPtr, checkDataPtr);
    }

    for (uint32_t i = 0; i < info.outputAddrNum; i++) {
        void *dataPtr = *(reinterpret_cast<void **>(outputAddrList[i]));
        void *checkDataPtr = calcMbufDataPtrFack(reinterpret_cast<Mbuf *>(allocFakeMBuf[outputIndexList[i]]), 0);
        EXPECT_EQ(dataPtr, checkDataPtr);
    }

    for (uint32_t i = 0; i < info.outQueueNum; i++) {
        void *mbufPtr = reinterpret_cast<void *>(mbufPtrlistSp[i]);
        EXPECT_EQ(mbufPtr, allocFakeMBuf[i]);
    }

    // 链接的mbuf检查
    for (size_t i = 0; i < singeMbufListIndex; i++) {
        EXPECT_EQ(singleMbufList[i], allocFakeMBuf[i]);
    }
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(true));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Error_InputIndexError)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(invoke(halMbufChainAppendFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // error 这里mbuf总计有4个，index 4超出范围
    uint32_t inputIndexListError[] = {0, 2, 3, 1, 4};
    info.inputIndexList = reinterpret_cast<uint64_t>(inputIndexListError);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Error_OutputIndex)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(invoke(halMbufChainAppendFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // error 这里只申请了三个mbuf， index 3超长
    uint32_t outputIndexListError[] = {0, 1, 2, 3};
    info.outputIndexList = reinterpret_cast<uint64_t>(outputIndexListError);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_CopyOutputDataPtrToOutputAddr_Error)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(invoke(halMbufChainAppendFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // error 前4次是input的返回, 第5次是alloc的mbuf去返回
    MOCKER(halMbufChainGetMbuf)
        .stubs()
        .will(invoke(halMbufChainGetMbufFake))
        .then(invoke(halMbufChainGetMbufFake))
        .then(invoke(halMbufChainGetMbufFake))
        .then(invoke(halMbufChainGetMbufFake))
        .then(returnValue(1));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_DequeueMbufList_Error)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // error DequeueMbufList中获取mbuf失败
    MOCKER(halMbufChainGetMbuf).stubs().will(returnValue(1));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Nullptr_Dataptr)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = 0;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_halMbufGetPrivInfo_Error3)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halQueueEnQueue).stubs().will(invoke(halQueueEnQueueFake));
    // error 四次出队的mbuf 正常获取信息，给alloc copy 的mbuf获取失败
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake))
        .then(invoke(halMbufGetPrivInfoFake))
        .then(invoke(halMbufGetPrivInfoFake))
        .then(invoke(halMbufGetPrivInfoFake))
        .then(invoke(halMbufGetPrivInfoFake))
        .then(returnValue(1));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetMbufListDataPtr_AllocOutputMbufList_Error)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halQueueEnQueue).stubs().will(invoke(halQueueEnQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    // error
    MOCKER(halMbufAllocEx).stubs().will(returnValue(1));
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    info.inputAddrList = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error2)
{
    BUILD_SUCC_PREPARE_INFO();
    info.inputIndexList = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error3)
{
    BUILD_SUCC_PREPARE_INFO();
    info.outputAddrList = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error4)
{
    BUILD_SUCC_PREPARE_INFO();
    info.outputAddrNum = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error5)
{
    BUILD_SUCC_PREPARE_INFO();
    info.outputIndexList = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error6)
{
    BUILD_SUCC_PREPARE_INFO();
    info.outputMbufNum = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error7)
{
    BUILD_SUCC_PREPARE_INFO();
    info.outDataSizeList = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error8)
{
    BUILD_SUCC_PREPARE_INFO();
    info.inQueueIdList = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_Error10)
{
    BUILD_SUCC_PREPARE_INFO();
    info.inputAddrNum = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_MbufChainGetMbufNum_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    // error
    MOCKER(halMbufChainGetMbufNum).stubs().will(returnValue(1));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_MbufChainGetMbufNum_Error2)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));

    // error set
    chainNumReturnValues = {0};
    mbufChainGetNumReturnValues = chainNumReturnValues;
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_QueueDeQueue_Error1)
{
    printf("ModelPrepare_QueueDeQueue_Error1 0\n");
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    MOCKER(halQueueDeQueue).stubs().will(returnValue(1));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_HalMbufGetPrivInfo_Error)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halQueueEnQueue).stubs().will(invoke(halQueueEnQueueFake));
    // error
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_OneOutput_BuildEnqueueMbufPtrList_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    // error
    MOCKER(halMbufChainAppend).stubs().will(returnValue(1));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // enqueue队列id, 这里只有一个outqueue， 所有mubf会连起来
    uint32_t outQueueIdListSp[] = {11};
    uint64_t mbufPtrlistSp[sizeof(outQueueIdListSp) / sizeof(outQueueIdListSp[0])] = {0};

    info.outQueueNum = sizeof(outQueueIdListSp) / sizeof(outQueueIdListSp[0]);
    info.outQueueIdList = reinterpret_cast<uint64_t>(outQueueIdListSp);
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlistSp);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_OneOutput_MallocBuf_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    // error
    MOCKER(halMbufAllocEx).stubs().will(returnValue(1));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // enqueue队列id, 这里只有一个outqueue， 所有mubf会连起来
    uint32_t outQueueIdListSp[] = {11};
    uint64_t mbufPtrlistSp[sizeof(outQueueIdListSp) / sizeof(outQueueIdListSp[0])] = {0};

    info.outQueueNum = sizeof(outQueueIdListSp) / sizeof(outQueueIdListSp[0]);
    info.outQueueIdList = reinterpret_cast<uint64_t>(outQueueIdListSp);
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlistSp);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_OneOutput_GuardBuf_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFake));
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    // error 先给dequeue的4个buff GuardBuf 再给alloc的buf GuardBuf
    MOCKER_CPP(&BufManager::GuardBuf)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(-1));
    // eror 连续error 走进异常分支
    MOCKER(halMbufFree).stubs().will(returnValue(1));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    // enqueue队列id, 这里只有一个outqueue， 所有mubf会连起来
    uint32_t outQueueIdListSp[] = {11};
    uint64_t mbufPtrlistSp[sizeof(outQueueIdListSp) / sizeof(outQueueIdListSp[0])] = {0};

    info.outQueueNum = sizeof(outQueueIdListSp) / sizeof(outQueueIdListSp[0]);
    info.outQueueIdList = reinterpret_cast<uint64_t>(outQueueIdListSp);
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlistSp);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_GuardBuf_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    MOCKER(halQueueDeQueue).stubs().will(invoke(halQueueDeQueueFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFake));
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    // error 先给dequeue的4个buff GuardBuf 再给alloc的buf GuardBuf
    MOCKER_CPP(&BufManager::GuardBuf)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(-1));
    // error 连续走进异常分支
    MOCKER(halMbufFree).stubs().will(returnValue(1));
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    // GuardBuf return error
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_BuildEnqueueMbufPtrList_Warn1)
{
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER_CPP(&BufManager::GuardBuf).stubs().will(returnValue(-1));

    BUILD_SUCC_PREPARE_INFO();
    // 3 output buf
    info.outputMbufNum = 3;
    // one output queue
    info.outQueueNum = 1;
    uint64_t mbufPtrlistSp[3] = {0};
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlistSp);

    Mbuf *mbufPtrStore[128U] = {(Mbuf *)allocFakeMBuf[0], (Mbuf *)allocFakeMBuf[1], (Mbuf *)allocFakeMBuf[2]};

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.BuildEnqueueMbufPtrList(info, mbufPtrStore);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_BuildEnqueueMbufPtrList_Warn2)
{
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER_CPP(&BufManager::GuardBuf).stubs().will(returnValue(-1));

    BUILD_SUCC_PREPARE_INFO();
    // 3 output buf
    info.outputMbufNum = 3;
    // 3 output queue
    info.outQueueNum = 3;
    uint64_t mbufPtrlistSp[3] = {0};
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlistSp);

    Mbuf *mbufPtrStore[128U] = {(Mbuf *)allocFakeMBuf[0], (Mbuf *)allocFakeMBuf[1], (Mbuf *)allocFakeMBuf[2]};

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.BuildEnqueueMbufPtrList(info, mbufPtrStore);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_BuildEnqueueMbufPtrList_Error2)
{
    MOCKER(halMbufChainAppend).stubs().will(returnValue(0));
    MOCKER_CPP(&BufManager::GuardBuf).stubs().will(returnValue(-1));

    BUILD_SUCC_PREPARE_INFO();
    // 3 output buf
    info.outputMbufNum = 3;
    // 2 output queue
    info.outQueueNum = 2;
    uint64_t mbufPtrlistSp[3] = {0};
    info.mbufPtrlist = reinterpret_cast<uint64_t>(mbufPtrlistSp);
    Mbuf *mbufPtrStore[128U] = {(Mbuf *)allocFakeMBuf[0], (Mbuf *)allocFakeMBuf[1], (Mbuf *)allocFakeMBuf[2]};

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.BuildEnqueueMbufPtrList(info, mbufPtrStore);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_MAX_SIZE_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    info.inputAddrNum = MAX_SIZE_NUM + 1;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_MAX_SIZE_Error2)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    info.outputAddrNum = MAX_SIZE_NUM + 1;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_MAX_SIZE_Error3)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    info.outputMbufNum = MAX_SIZE_NUM + 1;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_MAX_SIZE_Error4)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    info.inQueueNum = MAX_SIZE_NUM + 1;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_MAX_SIZE_Error5)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    info.outQueueNum = MAX_SIZE_NUM + 1;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_List_Error1)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    auto addrList = (uint64_t *)info.inputAddrList;
    addrList[1] = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_List_Error2)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    auto addrList = (uint64_t *)info.outputAddrList;
    addrList[1] = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, ModelPrepare_Param_Nullptr_List_Error3)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    // error
    auto addrList = (uint64_t *)info.mbufPtrlist;
    addrList[1] = 0;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)&info;

    int ret = preKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetMbufListDataPtr_succ)
{
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    void *mbufPtr = (void *)dequeueFakeMBuf[0];
    void *dataPtr = nullptr;
    halMbufGetBuffAddrFake((Mbuf *)mbufPtr, &dataPtr);
    uint32_t index = 0;

    int ret = preKernel_.GetMbufListDataPtr(mbufPtr, &dataPtr, index);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetMbufListDataPtr_error1)
{
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    void *mbufPtr = (void *)dequeueFakeMBuf[0];
    void *dataPtr = nullptr;
    halMbufGetBuffAddrFake((Mbuf *)mbufPtr, &dataPtr);
    uint32_t index = 0;

    int ret = preKernel_.GetMbufListDataPtr(nullptr, &dataPtr, index);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetMbufListDataPtr_error2)
{
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    void *mbufPtr = (void *)dequeueFakeMBuf[0];
    void *dataPtr = nullptr;
    halMbufGetBuffAddrFake((Mbuf *)mbufPtr, &dataPtr);
    uint32_t index = 0;

    int ret = preKernel_.GetMbufListDataPtr(mbufPtr, nullptr, index);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetMbufListDataPtr_error3)
{
    MOCKER(halMbufChainGetMbuf).stubs().will(returnValue(1));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    void *mbufPtr = (void *)dequeueFakeMBuf[0];
    void *dataPtr = nullptr;
    halMbufGetBuffAddrFake((Mbuf *)mbufPtr, &dataPtr);
    uint32_t index = 0;

    int ret = preKernel_.GetMbufListDataPtr(mbufPtr, &dataPtr, index);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetMbufListDataPtr_error4)
{
    // error ，出参未赋值，直接返回成功
    MOCKER(halMbufChainGetMbuf).stubs().will(returnValue(0));

    void *mbufPtr = (void *)dequeueFakeMBuf[0];
    void *dataPtr = nullptr;
    halMbufGetBuffAddrFake((Mbuf *)mbufPtr, &dataPtr);
    uint32_t index = 0;

    int ret = preKernel_.GetMbufListDataPtr(mbufPtr, &dataPtr, index);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetMbufListDataPtr_error5)
{
    MOCKER(halMbufChainGetMbuf).stubs().will(invoke(halMbufChainGetMbufFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(1));

    void *mbufPtr = (void *)dequeueFakeMBuf[0];
    void *dataPtr = nullptr;
    halMbufGetBuffAddrFake((Mbuf *)mbufPtr, &dataPtr);
    uint32_t index = 0;

    int ret = preKernel_.GetMbufListDataPtr(mbufPtr, &dataPtr, index);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, DoComputeFail1)
{
    AicpuPrepareInfo info = {};
    RunContext ctx = {};
    ctx.pending = false;
    AicpuModel model;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));
    MOCKER_CPP(&OperatorKernelModelPrepare::DequeueMbufList).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelModelPrepare::CopyDequeueDataPtrToInputAddr).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelModelPrepare::AllocOutputMbufList).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelModelPrepare::GetDataPtrsFromMbufs).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_FROM_DRV));
    int ret = preKernel_.DoCompute(info, ctx);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, DoComputeFail2)
{
    AicpuPrepareInfo info = {};
    RunContext ctx = {};
    ctx.pending = false;
    AicpuModel model;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));
    MOCKER_CPP(&OperatorKernelModelPrepare::DequeueMbufList).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelModelPrepare::CopyDequeueDataPtrToInputAddr).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelModelPrepare::AllocOutputMbufList).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelModelPrepare::GetDataPtrsFromMbufs).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelModelPrepare::CopyOutputDataPtrToOutputAddr).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelModelPrepare::BuildEnqueueMbufPtrList).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_FROM_DRV));
    int ret = preKernel_.DoCompute(info, ctx);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, AllocOutputMbufListFail)
{
    AicpuPrepareInfo info = {};
    info.outQueueNum = 2;
    info.outputMbufNum = 1;
    RunContext ctx = {};
    Mbuf *lastInputMbuflist = nullptr;
    Mbuf *mbufPtrStore[MAX_SIZE_NUM] = {};
    int ret = preKernel_.AllocOutputMbufList(info, &lastInputMbuflist, mbufPtrStore, ctx);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, AllocOutputMbufListFail2)
{
    AicpuPrepareInfo info = {};
    info.outQueueNum = 1;
    info.outputMbufNum = 1;
    RunContext ctx = {};
    Mbuf *lastInputMbuflist = nullptr;
    Mbuf *mbufPtrStore[MAX_SIZE_NUM] = {};

    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue((int32_t)DRV_ERROR_NONE));
    MOCKER_CPP(&BufManager::MallocAndGuardBufList).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCommon::CopyMbufHeadInfo).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
    int ret = preKernel_.AllocOutputMbufList(info, &lastInputMbuflist, mbufPtrStore, ctx);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetDataPtrsFromMbufsDrvFail)
{
    AicpuPrepareInfo info = {};
    info.outQueueNum = 1;
    info.outputMbufNum = 1;
    Mbuf *mbufPtrStore[MAX_SIZE_NUM] = {};
    void *dataPtrStore[MAX_SIZE_NUM] = {};

    MOCKER(halMbufChainGetMbufNum).stubs().will(returnValue((int32_t)DRV_ERROR_INVALID_VALUE));
    int ret = preKernel_.GetDataPtrsFromMbufs(info, mbufPtrStore, dataPtrStore);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetDataPtrsFromMbufsNoData)
{
    AicpuPrepareInfo info = {};
    info.outQueueNum = 1;
    info.outputMbufNum = 1;
    Mbuf *mbufPtrStore[MAX_SIZE_NUM] = {};
    void *dataPtrStore[MAX_SIZE_NUM] = {};

    MOCKER(halMbufChainGetMbufNum).stubs().will(returnValue((int32_t)DRV_ERROR_NONE));
    int ret = preKernel_.GetDataPtrsFromMbufs(info, mbufPtrStore, dataPtrStore);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetDataPtrsFromMbufsFail2)
{
    AicpuPrepareInfo info = {};
    info.outQueueNum = 1;
    info.outputMbufNum = 1;
    Mbuf *mbufPtrStore[MAX_SIZE_NUM] = {};
    void *dataPtrStore[MAX_SIZE_NUM] = {};

    mbufChainGetNumReturnValues = {1, 1, 2};

    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));
    MOCKER_CPP(&OperatorKernelModelPrepare::GetMbufListDataPtr).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
    int ret = preKernel_.GetDataPtrsFromMbufs(info, mbufPtrStore, dataPtrStore);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetDataPtrsFromMbufsFail3)
{
    AicpuPrepareInfo info = {};
    info.outQueueNum = 2;
    info.outputMbufNum = 2;
    Mbuf *mbufPtrStore[MAX_SIZE_NUM] = {};
    void *dataPtrStore[MAX_SIZE_NUM] = {};

    mbufChainGetNumReturnValues = {1, 1, 2};

    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataPtr).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
    int ret = preKernel_.GetDataPtrsFromMbufs(info, mbufPtrStore, dataPtrStore);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPreAndPostpareTest, GetDataPtrsFromMbufsFail4)
{
    AicpuPrepareInfo info = {};
    info.outQueueNum = 2;
    info.outputMbufNum = 1;
    Mbuf *mbufPtrStore[MAX_SIZE_NUM] = {};
    void *dataPtrStore[MAX_SIZE_NUM] = {};

    mbufChainGetNumReturnValues = {1, 1, 2};

    MOCKER(halMbufChainGetMbufNum).stubs().will(invoke(halMbufChainGetMbufNumFack));
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataPtr).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
    int ret = preKernel_.GetDataPtrsFromMbufs(info, mbufPtrStore, dataPtrStore);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}