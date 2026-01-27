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
#include "operator_kernel_model_prepare_output.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

namespace {}  // namespace

class OperatorKernelModelPrepareOutputTest : public OperatorKernelTest {
protected:
    OperatorKernelPrepareOutputBase baseKernel_;
    OperatorKernelModelPrepareOutput prepareKernel_;
    OperatorKernelModelPrepareOutputWithTensorDesc prepareTensorKernel_;
    OperatorKernelBufferPrepareOutput buffPrepareKernel_;
    OperatorKernelBufferPrepareOutputWithTensorDesc buffPrepareTensorKernel_;
};

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepareOutputTaskKernel_failed1)
{
    int *mbuf = nullptr;
    BUILD_SUCC_PREPARE_INFO();
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    ProcessOutputInfo outputInfoT;
    outputInfoT.inMBuf = (uint64_t)mbuf;

    int ret = baseKernel_.PrepareOutput(outputInfoT, runContextT, true, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepare_Alloc_Error)
{
    Mbuf *inMbuf = nullptr;
    Mbuf *outMbuf = nullptr;
    MOCKER(halMbufAllocEx).stubs().will(returnValue(1));

    ProcessOutputInfo prepareOutputInfo;
    prepareOutputInfo.inMBuf = (uint64_t)&inMbuf;
    prepareOutputInfo.srcPtr = 0UL;
    prepareOutputInfo.outMBuf = (uint64_t)&outMbuf;
    prepareOutputInfo.dataSize = 128;

    int ret = baseKernel_.PrepareOutput(prepareOutputInfo, runContextT, true, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepare_halMbufSetDataLen_Error)
{
    Mbuf *inMbuf = nullptr;
    Mbuf *outMbuf = nullptr;

    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFake));
    MOCKER(halMbufFree).stubs().will(returnValue(1));
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(1));

    ProcessOutputInfo prepareOutputInfo;
    prepareOutputInfo.inMBuf = (uint64_t)&inMbuf;
    prepareOutputInfo.srcPtr = 0UL;
    prepareOutputInfo.outMBuf = (uint64_t)&outMbuf;
    prepareOutputInfo.dataSize = 128;

    int ret = baseKernel_.PrepareOutput(prepareOutputInfo, runContextT, true, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    // alloc成功一次，但free失败，所以未Guard
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), 0);
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepare_halMbufGetPrivInfo_Error1)
{
    Mbuf *inMbuf = nullptr;
    Mbuf *outMbuf = nullptr;
    MOCK_MBUF_ALLOCK_FAKE()
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(0));
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));

    ProcessOutputInfo prepareOutputInfo;
    prepareOutputInfo.inMBuf = (uint64_t)&inMbuf;
    prepareOutputInfo.srcPtr = 0UL;
    prepareOutputInfo.outMBuf = (uint64_t)&outMbuf;
    prepareOutputInfo.dataSize = 128;

    int ret = baseKernel_.PrepareOutput(prepareOutputInfo, runContextT, true, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepareOutputNonZeroCpy_failed1)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(1));
    ProcessOutputInfo outputInfoT;
    int ret = baseKernel_.PrepareOutputNonZeroCpy(outputInfoT, nullptr, nullptr);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepareOut_MEM_FAIL)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    Mbuf *inMbuf = nullptr;
    Mbuf *outMbuf = nullptr;
    ProcessOutputInfo output;
    output.inMBuf = (uint64_t)&inMbuf;
    output.outMBuf = (uint64_t)&outMbuf;
    taskT.paraBase = (uint64_t)&output;
    int ret = prepareKernel_.Compute(taskT, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepareOut_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCK_MBUF_ALLOCK_FAKE()
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int32_t srcVal = 1;
    int32_t dstVal = 1;
    Mbuf *inMbuf = (Mbuf *)&srcVal;
    Mbuf *outMbuf = (Mbuf *)&dstVal;
    ProcessOutputInfo preOutputInfo;
    preOutputInfo.dataSize = sizeof(int32_t);
    preOutputInfo.outMBuf = (uint64_t)&outMbuf;
    preOutputInfo.srcPtr = (uint64_t)&srcVal;
    preOutputInfo.inMBuf = (uint64_t)&inMbuf;
    taskT.paraBase = (uint64_t)&preOutputInfo;
    int ret = prepareKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepareOut_failed1)
{
    TsAicpuNotify *aicpuNotify = nullptr;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)aicpuNotify;
    int ret = prepareKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepareOutWithTensorDesc_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCK_MBUF_ALLOCK_FAKE()
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int32_t srcVal = 1;
    int32_t dstVal = 1;
    Mbuf *inMbuf = (Mbuf *)&srcVal;
    Mbuf *outMbuf = (Mbuf *)&dstVal;
    uint8_t buff[sizeof(ProcessOutputInfo) + sizeof(RuntimeTensorDesc)] = {0};
    ProcessOutputInfo *preOutputInfo = (ProcessOutputInfo *)(buff);
    preOutputInfo->dataSize = sizeof(int32_t);
    preOutputInfo->outMBuf = (uint64_t)&outMbuf;
    preOutputInfo->srcPtr = (uint64_t)&srcVal;
    preOutputInfo->inMBuf = (uint64_t)&inMbuf;
    RuntimeTensorDesc *tensorDesc = (RuntimeTensorDesc *)(&buff[sizeof(ProcessOutputInfo)]);
    taskT.paraBase = (uint64_t)buff;
    int ret = prepareTensorKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelPrepareOutWithTensorDesc_Failed)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCK_MBUF_ALLOCK_FAKE()
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = 0;
    int ret = prepareTensorKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelBufferPrepareOutput_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCK_MBUF_ALLOCK_FAKE()
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int32_t srcVal = 1;
    int32_t dstVal = 1;
    Mbuf *inMbuf = (Mbuf *)&srcVal;
    Mbuf *outMbuf = (Mbuf *)&dstVal;
    ProcessOutputInfo preOutputInfo;
    preOutputInfo.dataSize = sizeof(int32_t);
    preOutputInfo.outMBuf = (uint64_t)&outMbuf;
    preOutputInfo.srcPtr = (uint64_t)&srcVal;
    preOutputInfo.inMBuf = (uint64_t)&inMbuf;
    taskT.paraBase = (uint64_t)&preOutputInfo;
    int ret = buffPrepareKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelModelPrepareOutputTest, ModelBufferPrepareOutputWithTensorDesc_Failed)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCK_MBUF_ALLOCK_FAKE()
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = UINT64_MAX;
    int ret = buffPrepareTensorKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}