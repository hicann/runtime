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
#include "operator_kernel_post_process_dynamic_output.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelPostProcessDynamicOutputTest : public OperatorKernelTest {
protected:
    OperatorKernelPostProcessDynamicOutput kernel_;
};

TEST_F(OperatorKernelPostProcessDynamicOutputTest, PostprocessCopyTensorDesc_success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    PostprocessDynamicOutputKernelArgs param = {};
    param.outputsNum = 2U;
    std::vector<uint32_t> dynamicFlags;
    dynamicFlags.emplace_back(0U);
    dynamicFlags.emplace_back(1U);
    param.outputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());

    char placeHolder0[1500U] = {};
    Mbuf *mbuf0 = reinterpret_cast<Mbuf *>(&placeHolder0[0U]);
    Mbuf **mbufPtr0 = &mbuf0;
    char placeHolder1[1500U] = {};
    Mbuf *mbuf1 = reinterpret_cast<Mbuf *>(&placeHolder1[0U]);
    Mbuf **mbufPtr1 = &mbuf1;
    std::vector<uint64_t> outputMbufAddrs;
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr0));
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr1));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());

    RuntimeTensorDesc statisticTensorDesc = {};
    statisticTensorDesc.dataSize = 16U;
    param.outputStaticTensorDescAddr = PtrToValue(&statisticTensorDesc);

    char placeHolderResp[1280U] = {};
    RuntimeTensorDesc *dynamicTensorDesc = reinterpret_cast<RuntimeTensorDesc *>(&placeHolderResp[mbufDataOffSet]);
    dynamicTensorDesc->dataSize = 32U;
    Mbuf *mbufResp = reinterpret_cast<Mbuf *>(&placeHolderResp[0U]);
    param.respMsgMbufAddr = PtrToValue(&mbufResp);

    EXPECT_EQ(kernel_.CopyTensorDesc(&param, runContextT), AICPU_SCHEDULE_OK);

    RuntimeTensorDesc *tensorDesc0 = reinterpret_cast<RuntimeTensorDesc *>(&placeHolder0[mbufDataOffSet]);
    RuntimeTensorDesc *tensorDesc1 = reinterpret_cast<RuntimeTensorDesc *>(&placeHolder1[mbufDataOffSet]);
    EXPECT_EQ(tensorDesc0->dataSize, 16U);
    EXPECT_EQ(tensorDesc1->dataSize, 32U);
}

TEST_F(OperatorKernelPostProcessDynamicOutputTest, PostprocessCopyTensorDesc_fail_invalidOutput)
{
    PostprocessDynamicOutputKernelArgs param = {};
    param.outputsNum = 1U;
    std::vector<uint32_t> dynamicFlags;
    dynamicFlags.emplace_back(1U);
    param.outputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());
    RuntimeTensorDesc outputStaticTensor;
    param.outputStaticTensorDescAddr = PtrToValue(&outputStaticTensor);

    Mbuf *mbuf0 = nullptr;
    Mbuf **mbufPtr0 = &mbuf0;
    std::vector<uint64_t> outputMbufAddrs;
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr0));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());
    EXPECT_EQ(kernel_.CopyTensorDesc(&param, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    outputMbufAddrs.clear();
    outputMbufAddrs.emplace_back(0U);
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());
    EXPECT_EQ(kernel_.CopyTensorDesc(&param, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelPostProcessDynamicOutputTest, PostprocessCopyTensorDesc_fail_setLen)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    PostprocessDynamicOutputKernelArgs param = {};
    param.outputsNum = 1U;
    std::vector<uint32_t> dynamicFlags;
    dynamicFlags.emplace_back(1U);
    param.outputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());

    char placeHolder0[1500U] = {};
    Mbuf *mbuf0 = reinterpret_cast<Mbuf *>(&placeHolder0[0U]);
    Mbuf **mbufPtr0 = &mbuf0;
    std::vector<uint64_t> outputMbufAddrs;
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr0));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());

    uint64_t dataLen = mbufDataOffSet + sizeof(RuntimeTensorDesc);
    char placeHolderResp[dataLen] = {};
    RuntimeTensorDesc *runtimeTensor = reinterpret_cast<RuntimeTensorDesc *>(&placeHolderResp[mbufDataOffSet]);
    runtimeTensor->dataSize = mbufDataOffSet + 1;
    Mbuf *respMbuf = reinterpret_cast<Mbuf *>(&placeHolderResp[0U]);
    param.respMsgMbufAddr = PtrToValue(&respMbuf);

    RuntimeTensorDesc outputStaticTensor;
    param.outputStaticTensorDescAddr = PtrToValue(&outputStaticTensor);

    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_NO_DEVICE)));

    EXPECT_EQ(kernel_.CopyTensorDesc(&param, runContextT), AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelPostProcessDynamicOutputTest, PostprocessCopyTensorDesc_dynamic2_fail)
{
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));

    PostprocessDynamicOutputKernelArgs param = {};
    param.outputsNum = 1U;

    char placeHolder1[1500U] = {};
    Mbuf *mbuf1 = reinterpret_cast<Mbuf *>(&placeHolder1[0U]);
    Mbuf **mbufPtr1 = &mbuf1;
    std::vector<uint64_t> outputMbufAddrs = {PtrToValue(mbufPtr1)};
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());

    std::vector<uint32_t> dynamicFlags = {2U};
    param.outputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());
    MOCKER_CPP(&OperatorKernelPostProcessDynamicOutput::IsSupportSdmaCopy).stubs().will(returnValue(false));

    // fail for resp mbuf is null
    EXPECT_EQ(kernel_.CopyTensorDesc(&param, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    Mbuf *mbuf = BufManager::GetInstance().MallocAndGuardBuf(1024U, modelId);
    param.respMsgMbufAddr = &mbuf;
    char head[256U] = {};
    void *headPtr = reinterpret_cast<void *>(&head[0U]);
    uint32_t headSize = 256;
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .with(mockcpp::any(), outBoundP(&headPtr), outBoundP(&headSize))
        .will(returnValue(1))
        .then(returnValue(0));
    // fail for halMbufGetPrivInfo fail
    EXPECT_EQ(kernel_.CopyTensorDesc(&param, runContextT), AICPU_SCHEDULE_ERROR_FROM_DRV);

    MOCKER_CPP(&kernel_.PostProcessForOutputToAllocate)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
    // fail for PostProcessForOutputToAllocate fail
    EXPECT_EQ(kernel_.CopyTensorDesc(&param, runContextT), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelPostProcessDynamicOutputTest, PostProcessForAllocatedOutput_fail)
{
    // fail for null outputMbuf
    EXPECT_EQ(
        kernel_.AllocatedOutput(nullptr, nullptr, 0, 0, nullptr, nullptr), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    // fail for halMbufGetBuffAddr fail
    Mbuf *outputMbuf = 1;
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(1)).then(returnValue(0));
    EXPECT_EQ(kernel_.AllocatedOutput(nullptr, outputMbuf, 0, 0, nullptr, nullptr), AICPU_SCHEDULE_ERROR_FROM_DRV);
    // fail for memcpy
    RuntimeTensorDesc tensorDesc = {};
    RuntimeTensorDesc *descPtr = &tensorDesc;
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    EXPECT_EQ(
        kernel_.AllocatedOutput(nullptr, outputMbuf, 0, 0, nullptr, &descPtr), AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR);
}

TEST_F(OperatorKernelPostProcessDynamicOutputTest, PostProcessForOutputToAllocate_fail)
{
    AicpuModel aicpuModel;
    aicpuModel.modelId_ = modelId;
    aicpuModel.isValid = true;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER_CPP(&OperatorKernelPostProcessDynamicOutput::IsSupportSdmaCopy).stubs().will(returnValue(false));

    char placeHolder0[1500U] = {};
    Mbuf *mbuf0 = reinterpret_cast<Mbuf *>(&placeHolder0[0U]);
    Mbuf **mbufPtr0 = &mbuf0;

    char head[256U] = {};
    // fail for null runtimeTensorDesc
    RuntimeTensorDesc *desc = nullptr;
    MOCKER_CPP(&OperatorKernelPostProcessDynamicOutput::GetRuntimeTensor)
        .stubs()
        .with(mockcpp::any(), outBoundP(&desc))
        .will(returnValue(AICPU_SCHEDULE_OK));
    EXPECT_EQ(kernel_.PostProcessForOutputToAllocate(nullptr, mbufPtr0, 0, &desc, &head[0U], 256U, runContextT),
        AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // fail for alloc mbuf
    RuntimeTensorDesc dynamicTensorDesc = {};
    dynamicTensorDesc.dataSize = 10;
    char data[10] = {};
    dynamicTensorDesc.dataAddr = PtrToValue(&data[0U]);
    RuntimeTensorDesc descs[] = {
        dynamicTensorDesc, dynamicTensorDesc, dynamicTensorDesc, dynamicTensorDesc, dynamicTensorDesc};
    desc = &descs[0];
    EXPECT_EQ(kernel_.PostProcessForOutputToAllocate(nullptr, mbufPtr0, 0, &desc, &head[0U], 256U, runContextT),
        AICPU_SCHEDULE_ERROR_FROM_DRV);

    // fail for CopyMbufHeadInfo
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));
    MOCKER_CPP(&OperatorKernelCommon::CopyMbufHeadInfo)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID))
        .then(returnValue(AICPU_SCHEDULE_OK));
    EXPECT_EQ(kernel_.PostProcessForOutputToAllocate(nullptr, mbufPtr0, 0, &desc, &head[0U], 256U, runContextT),
        AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // fail for halMbufGetBuffAddr
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(1)).then(returnValue(0));
    EXPECT_EQ(kernel_.PostProcessForOutputToAllocate(nullptr, mbufPtr0, 0, &desc, &head[0U], 256U, runContextT),
        AICPU_SCHEDULE_ERROR_FROM_DRV);
    // fail for memcpy tensordesc
    MOCKER(memcpy_s).stubs().will(returnValue(1)).then(returnValue(0)).then(returnValue(1));
    EXPECT_EQ(kernel_.PostProcessForOutputToAllocate(nullptr, mbufPtr0, 0, &desc, &head[0U], 256U, runContextT),
        AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR);
    // fail for memcpy data
    EXPECT_EQ(kernel_.PostProcessForOutputToAllocate(nullptr, mbufPtr0, 0, &desc, &head[0U], 256U, runContextT),
        AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR);
}

TEST_F(OperatorKernelPostProcessDynamicOutputTest, PostprocessFreeMbuf_success)
{
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));

    AicpuModel aicpuModel;
    aicpuModel.modelId_ = modelId;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    PostprocessDynamicOutputKernelArgs param = {};
    Mbuf *mbuf = BufManager::GetInstance().MallocAndGuardBuf(16U, modelId);
    param.respMsgMbufAddr = &mbuf;

    param.inputsNum = 1U;
    std::vector<uint64_t> inputMbufAddrs;
    Mbuf *inputMbuf = BufManager::GetInstance().MallocAndGuardBuf(16U, modelId);
    inputMbufAddrs.emplace_back(&inputMbuf);
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());
    EXPECT_EQ(kernel_.FreeMbuf(&param, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelPostProcessDynamicOutputTest, ModelPostprocessDynamicOutput_success)
{
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    AicpuModel aicpuModel;
    aicpuModel.modelId_ = modelId;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    PostprocessDynamicOutputKernelArgs param = {};
    param.outputsNum = 2U;
    std::vector<uint32_t> dynamicFlags;
    dynamicFlags.emplace_back(0U);
    dynamicFlags.emplace_back(1U);
    param.outputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());

    char placeHolder0[1500U] = {};
    Mbuf *mbuf0 = reinterpret_cast<Mbuf *>(&placeHolder0[0U]);
    Mbuf **mbufPtr0 = &mbuf0;
    char placeHolder1[1500U] = {};
    Mbuf *mbuf1 = reinterpret_cast<Mbuf *>(&placeHolder1[0U]);
    Mbuf **mbufPtr1 = &mbuf1;
    std::vector<uint64_t> outputMbufAddrs;
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr0));
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr1));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());

    RuntimeTensorDesc statisticTensorDesc = {};
    statisticTensorDesc.dataSize = 16U;
    param.outputStaticTensorDescAddr = PtrToValue(&statisticTensorDesc);

    Mbuf *mbuf = BufManager::GetInstance().MallocAndGuardBuf(1024U, modelId);
    param.respMsgMbufAddr = &mbuf;

    param.inputsNum = 1U;
    std::vector<uint64_t> inputMbufAddrs;
    Mbuf *inputMbuf = BufManager::GetInstance().MallocAndGuardBuf(16U, modelId);
    inputMbufAddrs.emplace_back(&inputMbuf);
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());
    EXPECT_NE(inputMbuf, nullptr);
}

TEST_F(OperatorKernelPostProcessDynamicOutputTest, ModelPostprocessDynamicOutput2_success)
{
    MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFakeByAlloc));
    MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFakeByFree));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuModel aicpuModel;
    aicpuModel.modelId_ = modelId;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));

    PostprocessDynamicOutputKernelArgs param = {};
    param.outputsNum = 2U;
    std::vector<uint32_t> dynamicFlags;
    dynamicFlags.emplace_back(0U);
    dynamicFlags.emplace_back(2U);
    param.outputDynamicFlagsAddr = PtrToValue(dynamicFlags.data());
    MOCKER_CPP(&OperatorKernelPostProcessDynamicOutput::IsSupportSdmaCopy).stubs().will(returnValue(false));

    char placeHolder0[1500U] = {};
    Mbuf *mbuf0 = reinterpret_cast<Mbuf *>(&placeHolder0[0U]);
    Mbuf **mbufPtr0 = &mbuf0;
    char placeHolder1[1500U] = {};
    Mbuf *mbuf1 = reinterpret_cast<Mbuf *>(&placeHolder1[0U]);
    Mbuf **mbufPtr1 = &mbuf1;
    std::vector<uint64_t> outputMbufAddrs;
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr0));
    outputMbufAddrs.emplace_back(PtrToValue(mbufPtr1));
    param.outputMbufAddrsAddr = PtrToValue(outputMbufAddrs.data());

    RuntimeTensorDesc statisticTensorDesc = {};
    statisticTensorDesc.dataSize = 16U;
    param.outputStaticTensorDescAddr = PtrToValue(&statisticTensorDesc);

    Mbuf *mbuf = BufManager::GetInstance().MallocAndGuardBuf(1024U, modelId);
    param.respMsgMbufAddr = &mbuf;
    RuntimeTensorDesc *dynamicTensorDesc =
        reinterpret_cast<RuntimeTensorDesc *>(reinterpret_cast<char *>(mbuf) + mbufDataOffSet);
    dynamicTensorDesc->dataSize = 10;
    char data[10] = {};
    dynamicTensorDesc->dataAddr = PtrToValue(&data[0U]);

    param.inputsNum = 1U;
    std::vector<uint64_t> inputMbufAddrs;
    Mbuf *inputMbuf = BufManager::GetInstance().MallocAndGuardBuf(16U, modelId);
    inputMbufAddrs.emplace_back(&inputMbuf);
    param.inputMbufAddrsAddr = PtrToValue(inputMbufAddrs.data());

    AicpuTaskInfo taskT;
    taskT.paraBase = PtrToValue(&param);
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
    BufManager::GetInstance().UnGuardBuf(modelId, mbuf);
}

TEST_F(OperatorKernelPostProcessDynamicOutputTest, OptimizedMemCopy_fail)
{
    MOCKER(halSdmaCopy).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    char a[1] = {'a'};
    char b[1] = {'b'};
    EXPECT_FALSE(kernel_.OptimizedMemCopy(&a[0U], 0U, &b[0U], 0U));
}