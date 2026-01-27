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
#define private public
#include "aicpusd_event_process.h"
#include "hwts_kernel_model_process.h"
#include "operator_kernel_check_input_tensor_desc.h"
#undef private
#include "operator_kernel_stub.h"
#include "operator_kernel_common.h"

using namespace AicpuSchedule;

namespace {
int32_t GetMbufDataPtrForCheckInput(const uint64_t srcAddr, void **dataAddrPtr)
{
    *dataAddrPtr = &mbuf;
    return AICPU_SCHEDULE_OK;
}
}

class OperatorKernelCheckInputTensorDescTest : public OperatorKernelTest {
protected:
    OperatorKernelCheckInputTensorDesc checkInputKernel_;
    ShapeConfigTsKernel shapeConfigKernel_;
};

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_Success01)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;

    RuntimeTensorDesc desc;
    desc.shape[0] = 4;
    desc.shape[1] = 1;
    desc.shape[2] = 1;
    desc.shape[3] = 224;
    desc.shape[4] = 224;
    desc.dtype = static_cast<int64_t>(1);
    auto descP = &desc;
    MOCKER(halMbufGetBuffAddr)
        .stubs()
        .with(mockcpp::any(), outBoundP(((void **)&descP), sizeof(void **)))
        .will(returnValue(0));

    ShapeValidation shapevalidation;
    shapevalidation.mbufAddrs = descP;
    shapevalidation.offset = 0;
    uint8_t allTensorData[sizeof(ShapeValidationInfo)] = {0};
    ShapeValidationInfo *allTensor = (ShapeValidationInfo *)allTensorData;
    allTensor->inputNums =1;
    allTensor->shapeValidationAddr = &shapevalidation;
    taskT.paraBase = (uint64_t)&allTensorData;
    printf("shapevalidation.mbufAddrs[%p], allTensor->shapeValidationAddr[%p], shapevalidation addr[%p]\n",
        shapevalidation.mbufAddrs, allTensor->shapeValidationAddr, &shapevalidation);

    int ret = checkInputKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_Success02)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 1;
    cfg->tensortlvLen = 36;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shapeConfigKernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    RuntimeTensorDesc desc;
    desc.shape[0] = 2;
    desc.shape[1] = 1;
    desc.shape[2] = 2;
    desc.dtype = static_cast<int64_t>(1);
    auto descP = &desc;
    MOCKER(halMbufGetBuffAddr)
        .stubs()
        .with(mockcpp::any(), outBoundP(((void **)&descP), sizeof(void **)))
        .will(returnValue(0));
    ShapeValidation shapevalidation;
    shapevalidation.mbufAddrs = PtrToValue(&descP);
    shapevalidation.offset = 0;
    uint64_t dataLen = sizeof(RuntimeTensorDesc) + shapevalidation.offset;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    uint32_t headSize = sizeof(MbufHeadMsg) + 10U;
    char_t mbufHead[headSize] = {};
    void *headPtr = reinterpret_cast<void *>(&mbufHead[0U]);
    MbufHeadMsg *headMsg = PtrToPtr<char_t, MbufHeadMsg>(&mbufHead[10U]);
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .with(mockcpp::any(), outBoundP(&headPtr), outBoundP(&headSize))
        .will(returnValue(0));

    uint8_t allTensorData[sizeof(ShapeValidationInfo)] = {0};
    ShapeValidationInfo *allTensor = (ShapeValidationInfo *)allTensorData;
    allTensor->inputNums = 1;
    allTensor->shapeValidationAddr = &shapevalidation;
    taskT.paraBase = (uint64_t)&allTensorData;

    ret = checkInputKernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_Failed01)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 1;
    cfg->tensortlvLen = 36;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shapeConfigKernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    RuntimeTensorDesc desc;
    desc.shape[0] = 4;
    desc.shape[1] = 1;
    desc.shape[2] = 1;
    desc.shape[3] = 224;
    desc.shape[4] = 224;
    desc.dtype = static_cast<int64_t>(1);
    auto descP = &desc;
    MOCKER(halMbufGetBuffAddr)
        .stubs()
        .with(mockcpp::any(), outBoundP(((void **)&descP), sizeof(void **)))
        .will(returnValue(0));
    ShapeValidation shapevalidation;
    shapevalidation.mbufAddrs = descP;
    shapevalidation.offset = 0;
    uint32_t headSize = sizeof(MbufHeadMsg) + 10U;
    char_t mbufHead[headSize] = {};
    void *headPtr = reinterpret_cast<void *>(&mbufHead[0U]);
    MbufHeadMsg *headMsg = PtrToPtr<char_t, MbufHeadMsg>(&mbufHead[10U]);
    headMsg->msgType = 2U;
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .with(mockcpp::any(), outBoundP(&headPtr), outBoundP(&headSize))
        .will(returnValue(0));

    uint8_t allTensorData[sizeof(ShapeValidationInfo)] = {0};
    ShapeValidationInfo *allTensor = (ShapeValidationInfo *)allTensorData;
    allTensor->inputNums =1;
    allTensor->shapeValidationAddr = &shapevalidation;
    taskT.paraBase = (uint64_t)&allTensorData;

    ret = checkInputKernel_.Compute(taskT, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_Failed02)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[56] = {-24, 3, 0, 0, 8, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 3, 0, 0, 0,
        -24, 3, 0, 0, 8, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 3, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 1;
    cfg->tensortlvLen = 56;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shapeConfigKernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;

    uint8_t buff[sizeof(RuntimeTensorDesc)] = {0};
    RuntimeTensorDesc *desc = (RuntimeTensorDesc *)buff;
    desc->shape[0] = 2;
    desc->shape[1] = 1;
    desc->shape[2] = 2;
    desc->dtype = static_cast<int64_t>(1);

    ShapeValidation shapevalidation;
    shapevalidation.mbufAddrs = &buff;
    shapevalidation.offset = 0;

    uint8_t allTensorData[sizeof(ShapeValidationInfo)] = {0};
    ShapeValidationInfo *allTensor = (ShapeValidationInfo *)allTensorData;
    allTensor->inputNums =1;
    allTensor->shapeValidationAddr = &shapevalidation;
    taskT.paraBase = (uint64_t)&allTensorData;

    ret = checkInputKernel_.Compute(taskT, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_Failed03)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 1;
    cfg->tensortlvLen = 36;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = shapeConfigKernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    RuntimeTensorDesc desc;
    desc.shape[0] = 2;
    desc.shape[1] = 1;
    desc.shape[2] = 2;
    desc.dtype = static_cast<int64_t>(1);
    auto descP = &desc;
    MOCKER(halMbufGetBuffAddr)
        .stubs()
        .with(mockcpp::any(), outBoundP(((void **)&descP), sizeof(void **)))
        .will(returnValue(0));
    ShapeValidation shapevalidation;
    shapevalidation.mbufAddrs = descP;
    shapevalidation.offset = 1;
    uint64_t dataLen = sizeof(RuntimeTensorDesc) + shapevalidation.offset;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    uint32_t headSize = sizeof(MbufHeadMsg) + 10U;
    char_t mbufHead[headSize] = {};
    void *headPtr = reinterpret_cast<void *>(&mbufHead[0U]);
    MbufHeadMsg *headMsg = PtrToPtr<char_t, MbufHeadMsg>(&mbufHead[10U]);
    headMsg->msgType = 2023U;
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .with(mockcpp::any(), outBoundP(&headPtr), outBoundP(&headSize))
        .will(returnValue(0));

    uint8_t allTensorData[sizeof(ShapeValidationInfo)] = {0};
    ShapeValidationInfo *allTensor = (ShapeValidationInfo *)allTensorData;
    allTensor->inputNums = 1;
    allTensor->shapeValidationAddr = &shapevalidation;
    taskT.paraBase = (uint64_t)&allTensorData;

    ret = checkInputKernel_.Compute(taskT, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_NullData)
{
    AicpuTaskInfo task = {};
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModel::GetNullDataFlag).stubs().will(returnValue(true));
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    const int32_t ret = checkInputKernel_.Compute(task, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_TensorDescNull)
{
    AicpuTaskInfo task = {};
    AicpuModel aicpuModel;
    MOCKER_CPP(&AicpuModel::GetNullDataFlag).stubs().will(returnValue(false));
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    const int32_t ret = checkInputKernel_.Compute(task, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_ShapeNull)
{
    const uint64_t shapeValidationAddr = 0UL;
    const uint64_t index = 0UL;
    const ModelConfigTensorDesc modelTensorDesc = {};
    uint64_t curSize = 0UL;
    const int32_t ret = checkInputKernel_.CheckInputTensorDesc(shapeValidationAddr, index, modelTensorDesc, curSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_CheckMsgTypeFail)
{
    ShapeValidation data = {};
    const uint64_t shapeValidationAddr = reinterpret_cast<uint64_t>(&data);
    const ModelConfigTensorDesc modelTensorDesc = {};
    uint64_t curSize = 0UL;
    EXPECT_EQ(checkInputKernel_.CheckInputTensorDesc(shapeValidationAddr, 0U, modelTensorDesc, curSize),
              AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_GetMbufDataPtrFail)
{
    ShapeValidation data = {};
    const uint64_t shapeValidationAddr = reinterpret_cast<uint64_t>(&data);
    const uint64_t index = 0UL;
    const ModelConfigTensorDesc modelTensorDesc = {};
    uint64_t curSize = 0UL;
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataSize).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCheckInputTensorDesc::CheckMsgType).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    const int32_t ret = checkInputKernel_.CheckInputTensorDesc(shapeValidationAddr, index, modelTensorDesc, curSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_UpdateDataPtrFail)
{
    ShapeValidation data = {};
    data.offset = 1;
    const uint64_t shapeValidationAddr = reinterpret_cast<uint64_t>(&data);
    const uint64_t index = 0UL;
    const ModelConfigTensorDesc modelTensorDesc = {};
    uint64_t curSize = 0UL;
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataSize).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataPtr).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCommon::UpdateDataPtr).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
    MOCKER_CPP(&OperatorKernelCheckInputTensorDesc::CheckMsgType).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    const int32_t ret = checkInputKernel_.CheckInputTensorDesc(shapeValidationAddr, index, modelTensorDesc, curSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_UpdateDataPtrSucc)
{
    ShapeValidation data = {};
    data.offset = 1;
    const uint64_t shapeValidationAddr = reinterpret_cast<uint64_t>(&data);
    const uint64_t index = 0UL;
    const ModelConfigTensorDesc modelTensorDesc = {};
    uint64_t curSize = 0UL;
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataSize).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataPtr).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCommon::UpdateDataPtr).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCheckInputTensorDesc::CheckMsgType).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    const int32_t ret = checkInputKernel_.CheckInputTensorDesc(shapeValidationAddr, index, modelTensorDesc, curSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_CheckShapeInfoFail)
{
    ShapeValidation data = {};
    data.offset = 1;
    data.mbufAddrs = 1;
    const uint64_t shapeValidationAddr = reinterpret_cast<uint64_t>(&data);
    const uint64_t index = 0UL;
    const ModelConfigTensorDesc modelTensorDesc = {};
    uint64_t curSize = 0UL;
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataSize).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCommon::UpdateDataPtr).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataPtr).stubs().will(invoke(GetMbufDataPtrForCheckInput));
    MOCKER_CPP(&OperatorKernelCheckInputTensorDesc::CheckMsgType).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(&OperatorKernelCheckInputTensorDesc::CheckShapeInfo).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID));
    const int32_t ret = checkInputKernel_.CheckInputTensorDesc(shapeValidationAddr, index, modelTensorDesc, curSize);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_CheckShapeInfoShapeLarge)
{
    ModelConfigTensorDesc modelTensorDesc = {};
    modelTensorDesc.shape[0] = MAX_DIM_SIZE*2;
    RuntimeTensorDesc tensorDesc = {};
    const int32_t ret = checkInputKernel_.CheckShapeInfo(modelTensorDesc, tensorDesc);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, ModelCheckInputTensorDesc_CheckShapeInfoShapeNotEqual)
{
    ModelConfigTensorDesc modelTensorDesc = {};
    modelTensorDesc.shape[0] = 1;
    RuntimeTensorDesc tensorDesc = {};
    tensorDesc.shape[0] = 2;
    const int32_t ret = checkInputKernel_.CheckShapeInfo(modelTensorDesc, tensorDesc);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCheckInputTensorDescTest, CheckMsgTypeFail_InvalidMsgType)
{
    uint32_t headSize = sizeof(MbufHeadMsg) + 10U;
    char_t mbufHead[headSize] = {};
    void *headPtr = reinterpret_cast<void *>(&mbufHead[0U]);
    MbufHeadMsg *headMsg = PtrToPtr<char_t, MbufHeadMsg>(&mbufHead[10U]);
    headMsg->msgType = 1U;
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .with(mockcpp::any(), outBoundP(&headPtr), outBoundP(&headSize))
        .will(returnValue(0));
    EXPECT_EQ(checkInputKernel_.CheckMsgType(&headPtr), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}