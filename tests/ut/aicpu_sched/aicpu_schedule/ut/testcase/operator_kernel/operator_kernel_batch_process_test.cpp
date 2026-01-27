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
#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_batch_process.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelBatchProcessTest : public OperatorKernelTest {
protected:
    OperatorKernelBatchRecv batchRecvKernel_;
    OperatorKernelBatchSend batchSendKernel_;
    OperatorKernelBatchProcess batchProcessBase_;
};

TEST_F(OperatorKernelBatchProcessTest, ModelBatchRecv_Success)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    std::vector<HcomP2pOpInfo> opVec = {HcomP2pOpInfo(), HcomP2pOpInfo()};
    BatchSendRecvTaskParam param = {};
    param.ioNum = 2U;
    param.hcomP2pOpList = PtrToValue(opVec.data());
    AicpuTaskInfo taskT;
    taskT.paraBase = PtrToValue(&param);

    MOCKER(StubHcomReceiveByOS).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(batchRecvKernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_OK));
}

TEST_F(OperatorKernelBatchProcessTest, ModelBatchSend_Success)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    std::vector<HcomP2pOpInfo> opVec = {HcomP2pOpInfo(), HcomP2pOpInfo()};
    BatchSendRecvTaskParam param = {};
    param.ioNum = 2U;
    param.hcomP2pOpList = PtrToValue(opVec.data());
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    MOCKER(StubHcomSendByOS).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(batchSendKernel_.Compute(taskT, runContextT), static_cast<int32_t>(AICPU_SCHEDULE_OK));
}

TEST_F(OperatorKernelBatchProcessTest, BatchProcess_Failed_InvalidOpType)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    std::vector<HcomP2pOpInfo> opVec = {HcomP2pOpInfo(), HcomP2pOpInfo()};
    BatchSendRecvTaskParam param = {};
    param.ioNum = 2U;
    param.hcomP2pOpList = PtrToValue(opVec.data());
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    MOCKER(StubHcomSendByOS).stubs().will(returnValue(HCCL_SUCCESS));
    EXPECT_EQ(batchProcessBase_.BatchProcess(taskT, runContextT, HCOM_OP_TYPE_NUM),
        static_cast<int32_t>(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
}

TEST_F(OperatorKernelBatchProcessTest, BatchProcess_Failed_HcclError)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    std::vector<HcomP2pOpInfo> opVec = {HcomP2pOpInfo(), HcomP2pOpInfo()};
    BatchSendRecvTaskParam param = {};
    param.ioNum = 2U;
    param.hcomP2pOpList = PtrToValue(opVec.data());
    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);

    MOCKER(StubHcomSendByOS).stubs().will(returnValue(HCCL_E_NETWORK));
    EXPECT_EQ(batchProcessBase_.BatchProcess(taskT, runContextT, HCOM_OP_TYPE_SEND),
        static_cast<int32_t>(AICPU_SCHEDULE_ERROR_CALL_HCCL));
}

TEST_F(OperatorKernelBatchProcessTest, BatchProcess_Failed_MissingModel)
{
    AicpuTaskInfo taskT = {};
    EXPECT_EQ(batchProcessBase_.BatchProcess(taskT, runContextT, HCOM_OP_TYPE_RECV),
        static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR));
}

TEST_F(OperatorKernelBatchProcessTest, BatchProcess_Failed_MissingParam)
{
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    AicpuTaskInfo taskT = {};
    EXPECT_EQ(batchProcessBase_.BatchProcess(taskT, runContextT, HCOM_OP_TYPE_RECV),
        static_cast<int32_t>(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
}
