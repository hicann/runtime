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
#include "operator_kernel_prepare_dynamic_input_output.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelPrepareDynamicInputOutputTest : public OperatorKernelTest {
protected:
    OperatorKernelPrepareDynamicInputOutput kernel_;
    OperatorKernelPrepareDynamicInputOutputV2 kernelV2_;
};

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, AllocateAndInitOutput_success)
{
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    PrepareDynamicInputOutputKernelArgs param = {};
    std::vector<Mbuf *> mbufVec;
    param.inputsNum = 1U;
    char placeHolder[1500U] = {};
    Mbuf *mbuf = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    Mbuf **mbufPtr = &mbuf;
    std::vector<uint64_t> inputMbufAddrs;
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());
    param.outputsNum = 2U;

    std::vector<int64_t> outputSizes;
    outputSizes.emplace_back(16);
    outputSizes.emplace_back(128);
    param.outputTensorSizesAddr = PtrToValue(outputSizes.data());

    std::vector<uint64_t> outputMbufAddrs;
    Mbuf *outputMbuf0 = nullptr;
    outputMbufAddrs.emplace_back(PtrToValue(&outputMbuf0));
    Mbuf *outputMbuf1 = nullptr;
    outputMbufAddrs.emplace_back(PtrToValue(&outputMbuf1));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());
    EXPECT_EQ(kernel_.AllocateAndInitOutput(&param, runContextT, mbufVec, false), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, AllocateAndInitOutput_success_zero_outputs)
{
    PrepareDynamicInputOutputKernelArgs param = {};
    std::vector<Mbuf *> mbufVec;
    param.outputsNum = 0U;
    EXPECT_EQ(kernel_.AllocateAndInitOutput(&param, runContextT, mbufVec, false), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, AllocateAndInitOutput_fail_zero_inputs)
{
    PrepareDynamicInputOutputKernelArgs param = {};
    std::vector<Mbuf *> mbufVec;
    param.outputsNum = 1U;
    param.inputsNum = 0U;
    EXPECT_EQ(
        kernel_.AllocateAndInitOutput(&param, runContextT, mbufVec, false), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, AllocateAndInitOutput_fail_driver)
{
    PrepareDynamicInputOutputKernelArgs param = {};
    std::vector<Mbuf *> mbufVec;
    param.inputsNum = 1U;
    char placeHolder[1500U] = {};
    Mbuf *mbuf = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    Mbuf **mbufPtr = &mbuf;
    std::vector<uint64_t> inputMbufAddrs;
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());
    param.outputsNum = 2U;
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));
    EXPECT_EQ(kernel_.AllocateAndInitOutput(&param, runContextT, mbufVec, false), AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, AllocateAndInitOutput_fail_invalidOutputSize)
{
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    PrepareDynamicInputOutputKernelArgs param = {};
    std::vector<Mbuf *> mbufVec;
    param.inputsNum = 1U;
    char placeHolder[1500U] = {};
    Mbuf *mbuf = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    Mbuf **mbufPtr = &mbuf;
    std::vector<uint64_t> inputMbufAddrs;
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());

    param.outputsNum = 2U;
    std::vector<int64_t> outputSizes;
    outputSizes.emplace_back(-1);
    outputSizes.emplace_back(128);
    param.outputTensorSizesAddr = PtrToValue(outputSizes.data());

    std::vector<uint64_t> outputMbufAddrs;
    Mbuf *outputMbuf0 = nullptr;
    outputMbufAddrs.emplace_back(PtrToValue(&outputMbuf0));
    Mbuf *outputMbuf1 = nullptr;
    outputMbufAddrs.emplace_back(PtrToValue(&outputMbuf1));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());
    EXPECT_EQ(
        kernel_.AllocateAndInitOutput(&param, runContextT, mbufVec, false), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, PrepareReqMsg_success)
{
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    uint64_t dataLen = 2500U;
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    char placeHolder[dataLen] = {};
    placeHolder[0U] = 1;
    uint64_t firstDataSize = 10U;
    RuntimeTensorDesc *inputTensorDesc = reinterpret_cast<RuntimeTensorDesc *>(&placeHolder[mbufDataOffSet]);
    inputTensorDesc->dataSize = firstDataSize;
    uint64_t inputDataAddr0 = PtrToValue(&placeHolder[mbufDataOffSet]) + sizeof(RuntimeTensorDesc);
    uint64_t inputDataAddr1 = inputDataAddr0 + firstDataSize + sizeof(RuntimeTensorDesc);
    Mbuf *mbuf = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    Mbuf **mbufPtr = &mbuf;

    PrepareDynamicInputOutputKernelArgs param = {};
    param.inputsNum = 2U;

    std::vector<uint32_t> dynamicFlags;
    dynamicFlags.emplace_back(0U);
    dynamicFlags.emplace_back(1U);
    param.inputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());

    std::vector<uint64_t> inputMbufAddrs;
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());

    std::vector<uint32_t> fusionOffsets = {0U, 1U};
    param.inputFusionOffsetsAddr = PtrToValue(fusionOffsets.data());

    param.outputsNum = 1U;
    std::vector<uint64_t> outputMbufAddrs;
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());

    Mbuf *reqMbuf = nullptr;
    param.reqMsgMbufAddr = PtrToValue(&reqMbuf);

    std::vector<Mbuf *> mbufVec;
    EXPECT_EQ(kernel_.PrepareReqMsg(&param, runContextT, mbufVec, false), AICPU_SCHEDULE_OK);
    ASSERT_TRUE(reqMbuf != nullptr);
    char *reqPtr = reinterpret_cast<char *>(reqMbuf);
    EXPECT_EQ(reqPtr[0U], 1);
    uint64_t *input0DataAddrPtr = reinterpret_cast<uint64_t *>(&reqPtr[mbufDataOffSet]);
    EXPECT_EQ(*input0DataAddrPtr, inputDataAddr0);
    RuntimeTensorDesc *input1TensorDesc =
        reinterpret_cast<RuntimeTensorDesc *>(&reqPtr[mbufDataOffSet + sizeof(uint64_t)]);
    EXPECT_EQ(input1TensorDesc->dataAddr, inputDataAddr1);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, PrepareReqMsg_fail_fusion)
{
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    uint64_t dataLen = 2500U;
    char placeHolder[dataLen] = {};
    placeHolder[0U] = 1;
    uint64_t firstDataSize = 10U;
    RuntimeTensorDesc *inputTensorDesc = reinterpret_cast<RuntimeTensorDesc *>(&placeHolder[mbufDataOffSet]);
    inputTensorDesc->dataSize = firstDataSize;
    uint64_t inputDataAddr0 = PtrToValue(&placeHolder[mbufDataOffSet]) + sizeof(RuntimeTensorDesc);
    uint64_t inputDataAddr1 = inputDataAddr0 + firstDataSize + sizeof(RuntimeTensorDesc);
    Mbuf *mbuf = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    Mbuf **mbufPtr = &mbuf;

    PrepareDynamicInputOutputKernelArgs param = {};
    param.inputsNum = 2U;

    std::vector<uint32_t> dynamicFlags;
    dynamicFlags.emplace_back(0U);
    dynamicFlags.emplace_back(1U);
    param.inputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());

    std::vector<uint64_t> inputMbufAddrs;
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());

    std::vector<uint32_t> fusionOffsets = {0U, 1U};
    param.inputFusionOffsetsAddr = PtrToValue(fusionOffsets.data());

    param.outputsNum = 1U;
    std::vector<uint64_t> outputMbufAddrs;
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());

    Mbuf *reqMbuf = nullptr;
    param.reqMsgMbufAddr = PtrToValue(&reqMbuf);

    std::vector<Mbuf *> mbufVec;
    EXPECT_EQ(kernel_.PrepareReqMsg(&param, runContextT, mbufVec, false), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, PrepareReqMsg_fail)
{
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_NO_DEVICE)));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    char placeHolder[1500U] = {};
    Mbuf *mbuf = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    Mbuf **mbufPtr = &mbuf;

    PrepareDynamicInputOutputKernelArgs param = {};
    param.inputsNum = 2U;

    std::vector<uint32_t> dynamicFlags;
    dynamicFlags.emplace_back(0U);
    dynamicFlags.emplace_back(1U);
    param.inputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());

    std::vector<uint64_t> inputMbufAddrs;
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());

    param.outputsNum = 1U;
    std::vector<uint64_t> outputMbufAddrs;
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());

    Mbuf *reqMbuf = nullptr;
    param.reqMsgMbufAddr = PtrToValue(&reqMbuf);

    std::vector<Mbuf *> mbufVec;
    EXPECT_EQ(kernel_.PrepareReqMsg(&param, runContextT, mbufVec, false), AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, UpdateReqMsgHead_fail_nullbuf)
{
    EXPECT_EQ(kernel_.UpdateReqMsgHead(nullptr, nullptr, 2U, runContextT), AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, ModelPrepareDynamicInputOutput_success)
{
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    AicpuModel aicpuModel;
    aicpuModel.retCode_ = 2;
    aicpuModel.nullDataFlag_ = true;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    char placeHolder[1500U] = {};
    Mbuf *mbuf = reinterpret_cast<Mbuf *>(&placeHolder[0U]);
    Mbuf **mbufPtr = &mbuf;

    char placeHolder1[1500U] = {};
    MbufHeadMsg *const inputMsg =
        PtrToPtr<uint8_t, MbufHeadMsg>(PtrAdd<uint8_t>(PtrToPtr<char, uint8_t>(&placeHolder1[0U]),
            mbufDataOffSet,
            static_cast<size_t>(mbufDataOffSet) - sizeof(MbufHeadMsg)));
    inputMsg->retCode = 1;
    inputMsg->dataFlag |= MBUF_HEAD_DATA_FLAG_MASK;
    uint8_t *const endOfSequence = PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(&placeHolder1[0U]), 256U, 128U);
    *endOfSequence = 0x5AU;
    Mbuf *mbuf1 = reinterpret_cast<Mbuf *>(&placeHolder1[0U]);
    Mbuf **mbufPtr1 = &mbuf1;

    PrepareDynamicInputOutputKernelArgs param = {};
    param.inputsNum = 2U;
    std::vector<uint64_t> inputMbufAddrs;
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr));
    inputMbufAddrs.emplace_back(PtrToValue(mbufPtr1));
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());
    std::vector<uint32_t> dynamicFlags;
    dynamicFlags.emplace_back(0U);
    dynamicFlags.emplace_back(1U);
    param.inputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());

    std::vector<int64_t> outputSizes;
    outputSizes.emplace_back(16);
    outputSizes.emplace_back(128);
    param.outputTensorSizesAddr = PtrToValue(outputSizes.data());

    param.outputsNum = 2U;
    std::vector<uint64_t> outputMbufAddrs;
    Mbuf *outputMbuf0 = nullptr;
    Mbuf *outputMbuf1 = 1;
    outputMbufAddrs.emplace_back(PtrToValue(&outputMbuf0));
    outputMbufAddrs.emplace_back(PtrToValue(&outputMbuf1));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());

    Mbuf *reqMbuf = nullptr;
    param.reqMsgMbufAddr = PtrToValue(&reqMbuf);

    AicpuTaskInfo taskT = {};
    taskT.paraBase = PtrToValue(&param);
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
    ASSERT_TRUE(reqMbuf != nullptr);
    MbufHeadMsg *const msg = PtrToPtr<uint8_t, MbufHeadMsg>(PtrAdd<uint8_t>(
        PtrToPtr<Mbuf, uint8_t>(reqMbuf), mbufDataOffSet, static_cast<size_t>(mbufDataOffSet) - sizeof(MbufHeadMsg)));
    EXPECT_EQ(msg->retCode, 1);
    EXPECT_TRUE((msg->dataFlag & MBUF_HEAD_DATA_FLAG_MASK) == static_cast<uint8_t>(DataFlag::DFLOW_NULL_DATA_FLAG));
    EXPECT_EQ(aicpuModel.GetModelRetCode(), 0);
    EXPECT_FALSE(aicpuModel.GetNullDataFlag());

    // skip alloc when size is 0 on condition of v2
    outputSizes[1] = 0;
    EXPECT_EQ(kernelV2_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
    EXPECT_EQ(outputMbuf1, nullptr);
}

TEST_F(OperatorKernelPrepareDynamicInputOutputTest, ModelPrepareDynamicInputOutput_fail_invalidParam)
{
    AicpuTaskInfo taskT = {};
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    PrepareDynamicInputOutputKernelArgs param = {};
    taskT.paraBase = PtrToValue(&param);
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}
