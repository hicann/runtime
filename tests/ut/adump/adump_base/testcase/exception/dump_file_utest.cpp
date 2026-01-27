/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#include "case_workspace.h"
#include "dump_file_checker.h"
#include "adump_pub.h"
#include "dump_tensor.h"
#include "dump_memory.h"
#include "dump_datatype.h"
#include "dump_file.h"
#include "ascend_hal.h"
#include "adump_dsmi.h"
#include "hccl_mc2_define.h"
#include "dump_manager.h"

using namespace Adx;
static std::vector<std::string> logRecord;
class DumpFileUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DumpFileUtest, Test_DumpData)
{
    Tools::CaseWorkspace ws("Test_Dump_Success");
    std::string dumpFilePath = ws.Root() + "/dump_file.bin";

    // new gert tensor
    // std::vector<int32_t> tensorValue = {1, 2, 3, 4, 5, 6, 7, 8};
    // auto th = gert::TensorBuilder()
    //               .Placement(gert::kOnDeviceHbm)
    //               .DataType(ge::DT_INT32)
    //               .StorageShape({2, 4})
    //               .OriginShape({2, 4})
    //               .StorageFormat(ge::FORMAT_ND)
    //               .Value(tensorValue)
    //               .Build();

    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;
    std::vector<DumpWorkspace> dumpWorkspaces;

    // TensorInfoV2 tensorV2 = {};
    // tensorV2.addrType = AddressType::TRADITIONAL;
    // tensorV2.argsOffSet = 0U;

    TensorInfoV2 tensorV2 = {};
    tensorV2.addrType = AddressType::TRADITIONAL;
    tensorV2.type = TensorType::INPUT;
    tensorV2.dataType = static_cast<int32_t>(GeDataType::DT_INT32);
    tensorV2.argsOffSet = 0;
    tensorV2.format = 3; // FORMAT_NC1HWC0
    tensorV2.shape = {2, 4};
    tensorV2.tensorAddr = nullptr;
    tensorV2.tensorSize = 5;
    tensorV2.originShape = {2, 4};
    tensorV2.placement = TensorPlacement::kOnDeviceHbm;

    // TensorInfo tensor1 = {th.GetTensor(), TensorType::INPUT, AddressType::TRADITIONAL};
    // DumpManager::Instance().ConvertTensorInfo(tensor1, tensorV2);

    inputTensors.emplace_back(tensorV2);
    outputTensors.emplace_back(tensorV2);
    dumpWorkspaces.emplace_back(tensorV2.tensorAddr, tensorV2.tensorSize, 0U);

    std::vector<InputBuffer> inputBuffer;
    inputBuffer.emplace_back(nullptr, 1, 1);
    std::vector<TensorBuffer> tensorBuffer;
    TensorBuffer tensor(nullptr, 0, (DfxTensorType)0, (DfxPointerType)0);
    tensor.size = 1;
    tensorBuffer.emplace_back(tensor);
    DumpFile dumpFile(0, dumpFilePath);
    dumpFile.SetInputBuffer(inputBuffer);
    dumpFile.SetTensorBuffer(tensorBuffer);
    dumpFile.SetHeader("test_op");
    dumpFile.SetInputTensors(inputTensors);
    dumpFile.SetOutputTensors(outputTensors);
    dumpFile.SetWorkspaces(dumpWorkspaces);

    int32_t ret = dumpFile.Dump(logRecord);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(dumpFilePath), true);
    EXPECT_EQ(checker.CheckHead("test_op"), true);
    EXPECT_EQ(checker.CheckInputTensorNum(1), true);
    EXPECT_EQ(checker.CheckOutputTensorNum(1), true);
    EXPECT_EQ(checker.CheckWorkspaceNum(1), true);

    // EXPECT_EQ(checker.CheckInputTensorSize(0, th.GetTensor()->GetSize()), true);
    // EXPECT_EQ(checker.CheckInputTensorData(0, th.GetData()), true);
    EXPECT_EQ(checker.CheckInputTensorShape(0, {2, 4}), true);
    EXPECT_EQ(checker.CheckInputTensorDatatype(0, toolkit::dump::OutputDataType::DT_INT32), true);
    EXPECT_EQ(checker.CheckInputTensorFormat(0, toolkit::dump::OutputFormat::FORMAT_ND), true);

    // EXPECT_EQ(checker.CheckOutputTensorSize(0, th.GetTensor()->GetSize()), true);
    // EXPECT_EQ(checker.CheckOutputTensorData(0, th.GetData()), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(0, {2, 4}), true);
    EXPECT_EQ(checker.CheckOutputTensorDatatype(0, toolkit::dump::OutputDataType::DT_INT32), true);
    EXPECT_EQ(checker.CheckOutputTensorFormat(0, toolkit::dump::OutputFormat::FORMAT_ND), true);

    // EXPECT_EQ(checker.CheckWorkspaceSize(0, th.GetTensor()->GetSize()), true);
    // EXPECT_EQ(checker.CheckWorkspaceData(0, th.GetData()), true);
}

// TEST_F(DumpFileUtest, Test_Dump_With_CopyDeviceData_Fail)
// {
//     Tools::CaseWorkspace ws("Test_Dump_With_CopyDeviceData_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     // create a stub data
//     std::vector<int32_t> stubTensor = {1, 2, 3, 4, 5, 6, 7, 8};

//     // new gert tensor
//     auto th = gert::TensorBuilder()
//                   .Placement(gert::kOnDeviceHbm)
//                   .DataType(ge::DT_INT32)
//                   .StorageShape({2, 4})
//                   .OriginShape({2, 4})
//                   .StorageFormat(ge::FORMAT_ND)
//                   .Value(stubTensor)
//                   .Build();

//     std::vector<DumpTensor> inputTensors;
//     std::vector<DumpTensor> outputTensors;
//     std::vector<DumpWorkspace> dumpWorkspaces;
//     TensorInfoV2 tensor = {};
//     tensor.addrType = AddressType::TRADITIONAL;
//     tensor.argsOffSet = 0U;
//     TensorInfo tensor1 = {th.GetTensor(), TensorType::INPUT, AddressType::TRADITIONAL};
//     DumpManager::Instance().ConvertTensorInfo(tensor1, tensor);

//     inputTensors.emplace_back(tensor);
//     outputTensors.emplace_back(tensor);
//     dumpWorkspaces.emplace_back(tensor.tensorAddr, tensor.tensorSize, 0U);

//     DumpFile dumpFile(0, dumpFilePath);
//     dumpFile.SetHeader("test_op");
//     dumpFile.SetInputTensors(inputTensors);
//     dumpFile.SetOutputTensors(outputTensors);
//     dumpFile.SetWorkspaces(dumpWorkspaces);

//     //Stub write failed.
//     void *nullHostMem = nullptr;
//     MOCKER(&DumpMemory::CopyDeviceToHost).stubs().will(returnValue(nullHostMem));
//     MOCKER(memset_s).stubs().will(returnValue(1));
//     EXPECT_EQ(ADUMP_FAILED, dumpFile.Dump(logRecord));

//     MOCKER(rtMallocHost).stubs().will(returnValue(1));
//     EXPECT_EQ(ADUMP_FAILED, dumpFile.Dump(logRecord));

//     // rtMemGetInfoByType check the device address failed
//     MOCKER(rtMemGetInfoByType).stubs().will(returnValue(1));
//     EXPECT_EQ(ADUMP_FAILED, dumpFile.Dump(logRecord));
// }

// TEST_F(DumpFileUtest, Test_Dump_With_Check_Address_Fail)
// {
//     Tools::CaseWorkspace ws("Test_Dump_With_CopyDeviceData_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     // create a stub data
//     std::vector<int32_t> stubTensor = {1, 2, 3, 4, 5, 6, 7, 8};

//     // new gert tensor
//     auto th = gert::TensorBuilder()
//                   .Placement(gert::kOnDeviceHbm)
//                   .DataType(ge::DT_INT32)
//                   .StorageShape({2, 4})
//                   .OriginShape({2, 4})
//                   .StorageFormat(ge::FORMAT_ND)
//                   .Value(stubTensor)
//                   .Build();

//     std::vector<DumpTensor> inputTensors;
//     std::vector<DumpTensor> outputTensors;
//     std::vector<DumpWorkspace> dumpWorkspaces;
//     TensorInfoV2 tensor = {};
//     tensor.addrType = AddressType::TRADITIONAL;
//     tensor.argsOffSet = 0U;
//     TensorInfo tensor1 = {th.GetTensor(), TensorType::INPUT, AddressType::TRADITIONAL};
//     DumpManager::Instance().ConvertTensorInfo(tensor1, tensor);

//     inputTensors.emplace_back(tensor);
//     outputTensors.emplace_back(tensor);
//     dumpWorkspaces.emplace_back(tensor.tensorAddr, tensor.tensorSize, 0U);

//     uint32_t deviceId = 7;
//     DumpFile dumpFile(deviceId, dumpFilePath);
//     dumpFile.SetHeader("test_op");
//     dumpFile.SetInputTensors(inputTensors);
//     dumpFile.SetOutputTensors(outputTensors);
//     dumpFile.SetWorkspaces(dumpWorkspaces);

//     EXPECT_EQ(ADUMP_SUCCESS, dumpFile.Dump(logRecord));

//     // rtMemGetInfoByType check the device address failed
//     MOCKER(rtMemGetInfoByType).stubs().will(returnValue(1));
//     EXPECT_EQ(ADUMP_SUCCESS, dumpFile.Dump(logRecord));

//     MOCKER(rtGetDeviceIDs).stubs().will(returnValue(1));
//     EXPECT_EQ(ADUMP_SUCCESS, dumpFile.Dump(logRecord));

//     MOCKER(rtGetDeviceCount).stubs().will(returnValue(1));
//     EXPECT_EQ(ADUMP_SUCCESS, dumpFile.Dump(logRecord));
// }

// TEST_F(DumpFileUtest, Test_Dump_With_Serialize_Fail)
// {
//     Tools::CaseWorkspace ws("Test_Dump_With_Serialize_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     MOCKER_CPP(&toolkit::dump::DumpData::SerializeToString).stubs().will(returnValue(false));
//     DumpFile dumpFile(0, dumpFilePath);
//     int32_t ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);
// }

// TEST_F(DumpFileUtest, Test_Dump_With_OpenFile_Fail)
// {
//     Tools::CaseWorkspace ws("Test_Dump_With_OpenFile_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     MOCKER_CPP(&File::Open).stubs().will(returnValue(ADUMP_FAILED));
//     DumpFile dumpFile(0, dumpFilePath);
//     int32_t ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);
// }

// TEST_F(DumpFileUtest, Test_Dump_With_Write_ProtoHeaderSize_Fail)
// {
//     Tools::CaseWorkspace ws("Test_Dump_With_Write_ProtoHeaderSize_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     int64_t enError = EN_ERROR;
//     MOCKER_CPP(&File::Write).stubs().will(returnValue((int64_t)EN_ERROR));  // write proto msg size fail
//     DumpFile dumpFile(0, dumpFilePath);
//     dumpFile.SetHeader("test_op");
//     int32_t ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);
// }

// TEST_F(DumpFileUtest, Test_Dump_With_Write_ProtoHeaderData_Fail)
// {
//     Tools::CaseWorkspace ws("Test_Dump_With_Write_ProtoHeaderData_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     MOCKER_CPP(&File::Write)
//         .stubs()
//         .will(returnValue((int64_t)EN_OK))      // write proto msg size success
//         .then(returnValue((int64_t)EN_ERROR));  // write proto msg fail
//     DumpFile dumpFile(0, dumpFilePath);
//     dumpFile.SetHeader("test_op");
//     int32_t ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);
// }

// TEST_F(DumpFileUtest, Test_Dump_With_Write_InputTensor_Fail)
// {
//     Tools::CaseWorkspace ws("Test_Dump_With_Write_InputTensor_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     auto th = gert::TensorBuilder()
//                   .Placement(gert::kOnDeviceHbm)
//                   .DataType(ge::DT_INT32)
//                   .StorageShape({2, 4})
//                   .OriginShape({2, 4})
//                   .StorageFormat(ge::FORMAT_ND)
//                   .Build();

//     MOCKER_CPP(&File::Write)
//         .stubs()
//         .will(returnValue((int64_t)EN_OK))      // write proto msg size success
//         .then(returnValue((int64_t)EN_OK))      // write proto msg success
//         .then(returnValue((int64_t)EN_ERROR));  // write input tensor fail

//     TensorInfoV2 tensor = {};
//     tensor.addrType = AddressType::TRADITIONAL;
//     tensor.argsOffSet = 0U;
//     TensorInfo tensor1 = {th.GetTensor(), TensorType::INPUT, AddressType::TRADITIONAL};
//     DumpManager::Instance().ConvertTensorInfo(tensor1, tensor);

//     DumpFile dumpFile(0, dumpFilePath);
//     dumpFile.SetHeader("test_op");
//     dumpFile.SetInputTensors({DumpTensor(tensor)});
//     int32_t ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);
// }

// TEST_F(DumpFileUtest, Test_Dump_With_Write_OutputTensor_Fail)
// {
//     Tools::CaseWorkspace ws("Test_Dump_With_Write_OutputTensor_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     auto th = gert::TensorBuilder()
//                   .Placement(gert::kOnDeviceHbm)
//                   .DataType(ge::DT_INT32)
//                   .StorageShape({2, 4})
//                   .OriginShape({2, 4})
//                   .StorageFormat(ge::FORMAT_ND)
//                   .Build();

//     MOCKER_CPP(&File::Write)
//         .stubs()
//         .will(returnValue((int64_t)EN_OK))      // write proto msg size success
//         .then(returnValue((int64_t)EN_OK))      // write proto msg success
//         .then(returnValue((int64_t)EN_ERROR));  // write output tensor fail

//     TensorInfoV2 tensor = {};
//     tensor.addrType = AddressType::TRADITIONAL;
//     tensor.argsOffSet = 0U;
//     TensorInfo tensor1 = {th.GetTensor(), TensorType::INPUT, AddressType::TRADITIONAL};
//     DumpManager::Instance().ConvertTensorInfo(tensor1, tensor);

//     DumpFile dumpFile(0, dumpFilePath);
//     dumpFile.SetHeader("test_op");
//     dumpFile.SetOutputTensors({DumpTensor(tensor)});
//     int32_t ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);
// }

// TEST_F(DumpFileUtest, Test_Dump_With_Write_Workspace_Fail)
// {
//     Tools::CaseWorkspace ws("Test_Dump_With_Write_Workspace_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     std::vector<int32_t> stubWorkspace = {1, 2, 3, 4};
//     DumpWorkspace workspace(stubWorkspace.data(), stubWorkspace.size() * sizeof(int32_t), 0);

//     MOCKER_CPP(&File::Write)
//         .stubs()
//         .will(returnValue((int64_t)EN_OK))      // write proto msg size success
//         .then(returnValue((int64_t)EN_OK))      // write proto msg success
//         .then(returnValue((int64_t)EN_ERROR));  // write workspace  fail

//     DumpFile dumpFile(0, dumpFilePath);
//     dumpFile.SetHeader("test_op");
//     dumpFile.SetWorkspaces({workspace});
//     int32_t ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);
// }

// static HcclCombinOpParam g_combinOpParam;
// static uint8_t workSpaceData[128] = {1,2,3,4,5};
// static IbVerbsData g_ibVerbsData;

// TEST_F(DumpFileUtest, Test_Dump_With_Write_MC2_CTX_Fail)
// {
//     g_combinOpParam.mc2WorkSpace =  {(uint64_t)&workSpaceData, 128};
//     g_combinOpParam.rankId = 33;     // out of range
//     g_combinOpParam.winSize = 128;
//     g_ibVerbsData.localInput = {128, (uint64_t)&workSpaceData, 0};
//     g_ibVerbsData.localOutput = {128, (uint64_t)&workSpaceData, 0};
//     g_combinOpParam.ibverbsData = (uint64_t)&g_ibVerbsData;
//     g_combinOpParam.ibverbsDataSize = sizeof(g_ibVerbsData);

//     Tools::CaseWorkspace ws("Test_Dump_With_Write_MC2_CTX_Fail");
//     std::string dumpFilePath = ws.Root() + "/dump_file.bin";

//     std::vector<int32_t> stubWorkspace = {1, 2, 3, 4};
//     DumpWorkspace mc2Space(stubWorkspace.data(), stubWorkspace.size() * sizeof(int32_t), 0);

//     DumpFile dumpFile(0, dumpFilePath);
//     uint64_t opParamSize = 0;
//     EXPECT_EQ(sizeof(HcclCombinOpParam) + 128 + 128 * 2 + sizeof(IbVerbsData),
//         dumpFile.GetMc2DataSize((const void*)&g_combinOpParam, 0, opParamSize));

//     void *nullHostMem = nullptr;
//     int32_t returnVal = 0;
//     MOCKER(&DumpMemory::CopyDeviceToHost).stubs().will(returnValue(nullHostMem)).then(returnValue(&returnVal));
//     dumpFile.SetHeader("test_op");
//     dumpFile.SetMc2spaces({mc2Space});

//     MOCKER(rtMemGetInfoByType).stubs().will(returnValue(1));
//     MOCKER_CPP(&File::Write)
//         .stubs()
//         .will(returnValue((int64_t)EN_OK))      // write proto msg size success
//         .then(returnValue((int64_t)EN_OK))      // write proto msg success
//         .then(returnValue((int64_t)EN_ERROR));  // write workspace  fail

//     dumpFile.SetMc2spaces({mc2Space});
//     int32_t ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_SUCCESS);

//     ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);

//     EXPECT_EQ(0, dumpFile.GetMc2DataSize(nullptr, 0, opParamSize));
//     MOCKER(rtGetSocVersion).stubs().will(returnValue(1));
//     EXPECT_EQ(0, dumpFile.GetMc2DataSize((const void*)&returnVal, 0, opParamSize));

//     MOCKER(&DumpFile::GetMc2DataSize).stubs().will(returnValue(0));
//     ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);

//     MOCKER(&DumpFile::WriteDeviceDataToFile).stubs().will(returnValue(ADUMP_FAILED));
//     ret = dumpFile.Dump(logRecord);
//     EXPECT_EQ(ret, ADUMP_FAILED);
// }