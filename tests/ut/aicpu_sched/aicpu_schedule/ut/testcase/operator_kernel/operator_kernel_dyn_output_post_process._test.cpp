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
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_dyn_output_post_process.h"
#undef private
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;


class OperatorKernelDynOutputPostProcessTest : public OperatorKernelTest {
protected:
    OperatorKernelDynOutputPostProcess kernel_;
};

TEST_F(OperatorKernelDynOutputPostProcessTest, ModelDynOutputPostProcess_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));
    MOCK_MBUF_ALLOCK_FAKE()
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int32_t srcVal = 1;
    RuntimeTensorDesc srcDesc;
    srcDesc.dataAddr = (uint64_t)&srcVal;
    srcDesc.dtype = 3;  // DT_INT32
    srcDesc.shape[0] = 1;
    srcDesc.shape[1] = 1;
    int32_t dstVal = 1;
    Mbuf *inMbuf = (Mbuf *)&srcVal;
    Mbuf *outMbuf = (Mbuf *)&dstVal;
    ProcessOutputInfo process;
    process.dataSize = sizeof(int32_t);
    process.outMBuf = (uint64_t)&outMbuf;
    process.srcPtr = (uint64_t)&srcDesc;
    process.inMBuf = (uint64_t)&inMbuf;
    taskT.paraBase = (uint64_t)&process;
    AicpuModel fakeModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&fakeModel));
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(BufManager::GetInstance().modelBufs_[modelId].size(), calcGuardBufSize(false));
}

TEST_F(OperatorKernelDynOutputPostProcessTest, ModelDynOutputPostProcess_Failed1)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t) nullptr;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelDynOutputPostProcessTest, ModelDynOutputPostProcess_Failed2)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int32_t srcVal = 1;
    int32_t dstVal = 1;
    Mbuf *inMbuf = (Mbuf *)&srcVal;
    Mbuf *outMbuf = (Mbuf *)&dstVal;
    ProcessOutputInfo process;
    process.dataSize = sizeof(int32_t);
    process.outMBuf = (uint64_t)&outMbuf;
    process.srcPtr = (uint64_t) nullptr;
    process.inMBuf = (uint64_t)&inMbuf;
    taskT.paraBase = (uint64_t)&process;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelDynOutputPostProcessTest, ModelDynOutputPostProcess_Failed3)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    int32_t srcVal = 1;
    RuntimeTensorDesc srcDesc;
    srcDesc.dataAddr = (uint64_t)&srcVal;
    srcDesc.dtype = 3;  // DT_INT32
    srcDesc.shape[0] = 1;
    srcDesc.shape[1] = -1;  // invalid shape
    int32_t dstVal = 1;
    Mbuf *inMbuf = (Mbuf *)&srcVal;
    Mbuf *outMbuf = (Mbuf *)&dstVal;
    ProcessOutputInfo process;
    process.dataSize = sizeof(int32_t);
    process.outMBuf = (uint64_t)&outMbuf;
    process.srcPtr = (uint64_t)&srcDesc;
    process.inMBuf = (uint64_t)&inMbuf;
    taskT.paraBase = (uint64_t)&process;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelDynOutputPostProcessTest, CopyTensorDescAndDataBufFail)
{
    const RuntimeTensorDesc srcTensorDesc = {};
    uint32_t srcDataSize = 0U;
    Mbuf *outMBuf = nullptr;
    uint32_t dstdataSize = 0U;
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue((int32_t)DRV_ERROR_BAD_ADDRESS));
    int ret = kernel_.CopyTensorDescAndDataBuf(&srcTensorDesc, srcDataSize, outMBuf, dstdataSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(OperatorKernelDynOutputPostProcessTest, CopyTensorDescAndDataBufMemcpyFail)
{
    const RuntimeTensorDesc srcTensorDesc = {};
    uint32_t srcDataSize = 0U;
    Mbuf *outMBuf = nullptr;
    uint32_t dstdataSize = 0U;
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    int ret = kernel_.CopyTensorDescAndDataBuf(&srcTensorDesc, srcDataSize, outMBuf, dstdataSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR);
}

TEST_F(OperatorKernelDynOutputPostProcessTest, CopyTensorDescAndDataBufMemcpyFail2)
{
    const RuntimeTensorDesc srcTensorDesc = {};
    uint32_t srcDataSize = 1U;
    Mbuf *outMBuf = nullptr;
    uint32_t dstdataSize = 0U;
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(memcpy_s).stubs().will(returnValue(0)).then(returnValue(1));
    int ret = kernel_.CopyTensorDescAndDataBuf(&srcTensorDesc, srcDataSize, outMBuf, dstdataSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR);
}