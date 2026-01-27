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
#include <unistd.h>
#include "case_workspace.h"
#include "gert_tensor_builder.h"
#include "dump_param_builder.h"
#include "dump_file_checker.h"
#include "path.h"
#include "sys_utils.h"
#include "exception_dumper.h"
#include "dump_manager.h"
#include "dump_args.h"
#include "file.h"
#include "exception_info_common.h"

using namespace Adx;

class TinyExceptionDumperUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
};

TEST_F(TinyExceptionDumperUtest, Test_ExceptionDump_DumpData)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData");

    uint32_t deviceId = 1;
    uint32_t taskId = 2;
    uint32_t streamId = 3;
    std::string opType = "CONV2D";
    std::string opName = "TestName";

    std::vector<int32_t> inputValue{4 * 2, 5};
    std::vector<int32_t> outputValue{4 * 2, 6};
    std::vector<int32_t> workspaceValue{4 * 2, 7};
    auto input = gert::TensorBuilder()
                     .Placement(gert::kOnDeviceHbm)
                     .DataType(ge::DT_INT32)
                     .Shape({4, 2})
                     .Format(ge::FORMAT_ND)
                     .Value(inputValue)
                     .Build();
    auto output = gert::TensorBuilder()
                      .Placement(gert::kOnDeviceHbm)
                      .DataType(ge::DT_INT32)
                      .Shape({4, 2})
                      .Format(ge::FORMAT_ND)
                      .Value(outputValue)
                      .Build();
    auto workspace = gert::TensorBuilder()
                         .Placement(gert::kOnDeviceHbm)
                         .DataType(ge::DT_INT32)
                         .Shape({4, 2})
                         .Value(workspaceValue)
                         .Build();

    // device args
    uintptr_t inputAddr = reinterpret_cast<uintptr_t>(input.GetTensor()->GetAddr());
    uintptr_t outputAddr = reinterpret_cast<uintptr_t>(output.GetTensor()->GetAddr());
    std::vector<uintptr_t> args = {inputAddr, outputAddr};
    OperatorInfo opInfo = OperatorInfoBuilder(opType, opName)
                              .Task(deviceId, taskId, streamId)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT, AddressType::TRADITIONAL, 0)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT, AddressType::TRADITIONAL, 1)
                              .TensorInfo(workspace.GetTensor(), TensorType::WORKSPACE)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .AdditionInfo(DUMP_ADDITIONAL_IS_HOST_ARGS, "false")
                              .DeviceInfo(DEVICE_INFO_NAME_ARGS, args.data(), args.size() * sizeof(uintptr_t))
                              .Build();

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    dumper.AddDumpOperator(opInfo);
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    rtExceptionInfo exception = BuildRtException(deviceId, taskId, streamId);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = args.size() * sizeof(uintptr_t);
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    int32_t ret = dumper.DumpException(exception);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedDumpFilePath(ws.Root(), deviceId, opType, opName, taskId, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    EXPECT_EQ(checker.CheckHead(opName), true);
    EXPECT_EQ(checker.CheckInputTensorNum(1), true);
    EXPECT_EQ(checker.CheckOutputTensorNum(1), true);
    EXPECT_EQ(checker.CheckWorkspaceNum(1), true);

    EXPECT_EQ(checker.CheckInputTensorSize(0, input.GetTensor()->GetSize()), true);
    EXPECT_EQ(checker.CheckInputTensorData(0, input.GetData()), true);
    EXPECT_EQ(checker.CheckInputTensorShape(0, {4, 2}), true);
    EXPECT_EQ(checker.CheckInputTensorDatatype(0, toolkit::dump::OutputDataType::DT_INT32), true);
    EXPECT_EQ(checker.CheckInputTensorFormat(0, toolkit::dump::OutputFormat::FORMAT_ND), true);

    EXPECT_EQ(checker.CheckOutputTensorSize(0, output.GetTensor()->GetSize()), true);
    EXPECT_EQ(checker.CheckOutputTensorData(0, output.GetData()), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(0, {4, 2}), true);
    EXPECT_EQ(checker.CheckOutputTensorDatatype(0, toolkit::dump::OutputDataType::DT_INT32), true);
    EXPECT_EQ(checker.CheckOutputTensorFormat(0, toolkit::dump::OutputFormat::FORMAT_ND), true);

    EXPECT_EQ(checker.CheckWorkspaceSize(0, workspace.GetTensor()->GetSize()), true);
    EXPECT_EQ(checker.CheckWorkspaceData(0, workspace.GetData()), true);

    // test CopyDeviceToHost fail
    MOCKER(rtMemcpy).stubs().will(returnValue(-1));
    dumper.AddDumpOperator(opInfo);
    ret = dumper.DumpException(exception);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyExceptionDumperUtest, Test_ExceptionDump_DumpData_LongName)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData_LongName");

    uint32_t deviceId = 1;
    uint32_t taskId = 2;
    uint32_t streamId = 3;
    std::string opType = "CONV2D";
    std::string opName = "TestName";

    std::vector<int32_t> inputValue{4 * 2, 5};
    std::vector<int32_t> outputValue{4 * 2, 6};
    std::vector<int32_t> workspaceValue{4 * 2, 7};
    auto input = gert::TensorBuilder()
                     .Placement(gert::kOnDeviceHbm)
                     .DataType(ge::DT_INT32)
                     .Shape({4, 2})
                     .Format(ge::FORMAT_ND)
                     .Value(inputValue)
                     .Build();
    auto output = gert::TensorBuilder()
                      .Placement(gert::kOnDeviceHbm)
                      .DataType(ge::DT_INT32)
                      .Shape({4, 2})
                      .Format(ge::FORMAT_ND)
                      .Value(outputValue)
                      .Build();
    auto workspace = gert::TensorBuilder()
                         .Placement(gert::kOnDeviceHbm)
                         .DataType(ge::DT_INT32)
                         .Shape({4, 2})
                         .Value(workspaceValue)
                         .Build();

    // device args
    uintptr_t inputAddr = reinterpret_cast<uintptr_t>(input.GetTensor()->GetAddr());
    uintptr_t outputAddr = reinterpret_cast<uintptr_t>(output.GetTensor()->GetAddr());
    std::vector<uintptr_t> args = {inputAddr, outputAddr};
    OperatorInfo opInfo = OperatorInfoBuilder(opType, opName)
                              .Task(deviceId, taskId, streamId)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT, AddressType::TRADITIONAL, 0)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT, AddressType::TRADITIONAL, 1)
                              .TensorInfo(workspace.GetTensor(), TensorType::WORKSPACE)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .AdditionInfo(DUMP_ADDITIONAL_IS_HOST_ARGS, "true")
                              .DeviceInfo(DEVICE_INFO_NAME_ARGS, args.data(), args.size() * sizeof(uintptr_t))
                              .Build();

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    dumper.AddDumpOperator(opInfo);
    // test clean args before execute after AddDumpOperator
    args.clear();
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    std::string longName = "generator_LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_Neggenerator_"
                           "LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_mul_1generator_LayoutGenerator_"
                           "19_conv_block_InstanceNorm_1_instancenorm_add_1generator_LayoutGenerator_19_conv_block_add";
    MOCKER_CPP(&Path::GetFileName).stubs().will(returnValue(longName));

    rtExceptionInfo exception = BuildRtException(deviceId, taskId, streamId);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = args.size() * sizeof(uintptr_t);
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    int32_t ret = dumper.DumpException(exception);
    EXPECT_EQ(ADUMP_SUCCESS, ret);
}

TEST_F(TinyExceptionDumperUtest, Test_ExceptionDump_DumpData_Exception)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData_Exception");

    uint32_t deviceId = 1;
    uint32_t taskId = 2;
    uint32_t streamId = 3;
    std::string opType = "CONV2D";
    std::string opName = "TestName";

    std::vector<int32_t> inputValue{4 * 2, 5};
    std::vector<int32_t> outputValue{4 * 2, 6};
    std::vector<int32_t> workspaceValue{4 * 2, 7};
    auto input = gert::TensorBuilder()
                     .Placement(gert::kOnDeviceHbm)
                     .DataType(ge::DT_INT32)
                     .Shape({4, 2})
                     .Format(ge::FORMAT_ND)
                     .Value(inputValue)
                     .Build();
    auto output = gert::TensorBuilder()
                      .Placement(gert::kOnDeviceHbm)
                      .DataType(ge::DT_INT32)
                      .Shape({4, 2})
                      .Format(ge::FORMAT_ND)
                      .Value(outputValue)
                      .Build();
    auto workspace = gert::TensorBuilder()
                         .Placement(gert::kOnDeviceHbm)
                         .DataType(ge::DT_INT32)
                         .Shape({4, 2})
                         .Value(workspaceValue)
                         .Build();

    OperatorInfo opInfo = OperatorInfoBuilder(opType, opName)
                              .Task(deviceId, taskId, streamId)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .TensorInfo(workspace.GetTensor(), TensorType::WORKSPACE)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    dumper.AddDumpOperator(opInfo);
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf);

    rtExceptionInfo exception = BuildRtException(deviceId, taskId, streamId);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    std::string longName = "generator_LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_Neggenerator_"
                           "LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_mul_1generator_LayoutGenerator_"
                           "19_conv_block_InstanceNorm_1_instancenorm_add_1generator_LayoutGenerator_19_conv_block_add";
    MOCKER_CPP(&Path::GetFileName).stubs().will(returnValue(longName));

    MOCKER(mmGetErrorCode).stubs().will(returnValue(-1)).then(returnValue(ENAMETOOLONG));
    EXPECT_EQ(ADUMP_FAILED, dumper.DumpException(exception));
    EXPECT_EQ(ADUMP_SUCCESS, dumper.DumpException(exception));
}

TEST_F(TinyExceptionDumperUtest, Test_ExceptionDump_DumpData_RealPath)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData_RealPath");

    uint32_t deviceId = 1;
    uint32_t taskId = 2;
    uint32_t streamId = 3;
    std::string opType = "CONV2D";
    std::string opName = "TestName";

    std::vector<int32_t> inputValue{4 * 2, 5};
    std::vector<int32_t> outputValue{4 * 2, 6};
    std::vector<int32_t> workspaceValue{4 * 2, 7};
    auto input = gert::TensorBuilder()
                     .Placement(gert::kOnDeviceHbm)
                     .DataType(ge::DT_INT32)
                     .Shape({4, 2})
                     .Format(ge::FORMAT_ND)
                     .Value(inputValue)
                     .Build();
    auto output = gert::TensorBuilder()
                      .Placement(gert::kOnDeviceHbm)
                      .DataType(ge::DT_INT32)
                      .Shape({4, 2})
                      .Format(ge::FORMAT_ND)
                      .Value(outputValue)
                      .Build();
    auto workspace = gert::TensorBuilder()
                         .Placement(gert::kOnDeviceHbm)
                         .DataType(ge::DT_INT32)
                         .Shape({4, 2})
                         .Value(workspaceValue)
                         .Build();

    OperatorInfo opInfo = OperatorInfoBuilder(opType, opName)
                              .Task(deviceId, taskId, streamId)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .TensorInfo(workspace.GetTensor(), TensorType::WORKSPACE)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    dumper.AddDumpOperator(opInfo);
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf);

    rtExceptionInfo exception = BuildRtException(deviceId, taskId, streamId);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    std::string longName = "generator_LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_Neggenerator_"
                           "LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_mul_1generator_LayoutGenerator_"
                           "19_conv_block_InstanceNorm_1_instancenorm_add_1generator_LayoutGenerator_19_conv_block_add";
    MOCKER_CPP(&Path::GetFileName).stubs().will(returnValue(longName));

    MOCKER(mmRealPath).stubs().will(returnValue(0)).then(returnValue(-1));
    EXPECT_EQ(ADUMP_FAILED, dumper.DumpException(exception));
}

TEST_F(TinyExceptionDumperUtest, Test_ExceptionDump_DumpData_AddMapping_Failed)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData_AddMapping_Failed");

    uint32_t deviceId = 1;
    uint32_t taskId = 2;
    uint32_t streamId = 3;
    std::string opType = "CONV2D";
    std::string opName = "TestName";

    std::vector<int32_t> inputValue{4 * 2, 5};
    std::vector<int32_t> outputValue{4 * 2, 6};
    std::vector<int32_t> workspaceValue{4 * 2, 7};
    auto input = gert::TensorBuilder()
                     .Placement(gert::kOnDeviceHbm)
                     .DataType(ge::DT_INT32)
                     .Shape({4, 2})
                     .Format(ge::FORMAT_ND)
                     .Value(inputValue)
                     .Build();
    auto output = gert::TensorBuilder()
                      .Placement(gert::kOnDeviceHbm)
                      .DataType(ge::DT_INT32)
                      .Shape({4, 2})
                      .Format(ge::FORMAT_ND)
                      .Value(outputValue)
                      .Build();
    auto workspace = gert::TensorBuilder()
                         .Placement(gert::kOnDeviceHbm)
                         .DataType(ge::DT_INT32)
                         .Shape({4, 2})
                         .Value(workspaceValue)
                         .Build();

    OperatorInfo opInfo = OperatorInfoBuilder(opType, opName)
                              .Task(deviceId, taskId, streamId)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .TensorInfo(workspace.GetTensor(), TensorType::WORKSPACE)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    dumper.AddDumpOperator(opInfo);
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf);

    rtExceptionInfo exception = BuildRtException(deviceId, taskId, streamId);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    std::string longName = "generator_LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_Neggenerator_"
                           "LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_mul_1generator_LayoutGenerator_"
                           "19_conv_block_InstanceNorm_1_instancenorm_add_1generator_LayoutGenerator_19_conv_block_add";
    MOCKER_CPP(&Path::GetFileName).stubs().will(returnValue(longName));

    MOCKER_CPP(&Path::RealPath).stubs().will(returnValue(true));
    EXPECT_EQ(ADUMP_SUCCESS, dumper.DumpException(exception));
}

TEST_F(TinyExceptionDumperUtest, Test_ExceptionDump_DumpData_Write_Mapping_Failed)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData_Write_Failed");

    uint32_t deviceId = 1;
    uint32_t taskId = 2;
    uint32_t streamId = 3;
    std::string opType = "CONV2D";
    std::string opName = "TestName";

    std::vector<int32_t> inputValue{4 * 2, 5};
    std::vector<int32_t> outputValue{4 * 2, 6};
    std::vector<int32_t> workspaceValue{4 * 2, 7};
    auto input = gert::TensorBuilder()
                     .Placement(gert::kOnDeviceHbm)
                     .DataType(ge::DT_INT32)
                     .Shape({4, 2})
                     .Format(ge::FORMAT_ND)
                     .Value(inputValue)
                     .Build();
    auto output = gert::TensorBuilder()
                      .Placement(gert::kOnDeviceHbm)
                      .DataType(ge::DT_INT32)
                      .Shape({4, 2})
                      .Format(ge::FORMAT_ND)
                      .Value(outputValue)
                      .Build();
    auto workspace = gert::TensorBuilder()
                         .Placement(gert::kOnDeviceHbm)
                         .DataType(ge::DT_INT32)
                         .Shape({4, 2})
                         .Value(workspaceValue)
                         .Build();

    OperatorInfo opInfo = OperatorInfoBuilder(opType, opName)
                              .Task(deviceId, taskId, streamId)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .TensorInfo(workspace.GetTensor(), TensorType::WORKSPACE)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    dumper.AddDumpOperator(opInfo);
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf);

    rtExceptionInfo exception = BuildRtException(deviceId, taskId, streamId);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    std::string longName = "generator_LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_Neggenerator_"
                           "LayoutGenerator_19_conv_block_InstanceNorm_1_instancenorm_mul_1generator_LayoutGenerator_"
                           "19_conv_block_InstanceNorm_1_instancenorm_add_1generator_LayoutGenerator_19_conv_block_add";
    MOCKER_CPP(&Path::GetFileName).stubs().will(returnValue(longName));

    MOCKER(write).stubs().will(returnValue(-1));
    MOCKER_CPP(&File::Write).stubs().will(returnValue((int64_t)0));

    MOCKER_CPP(&Path::RealPath).stubs().will(returnValue(true));
    EXPECT_EQ(ADUMP_SUCCESS, dumper.DumpException(exception));
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException)
{
    Tools::CaseWorkspace ws("Test_DumpException");

    auto input = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto output = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();

    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName")
                              .Task(1, 2, 3)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    dumper.AddDumpOperator(opInfo);
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf);

    rtExceptionInfo exception = BuildRtException(1, 2, 3);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    int32_t ret = dumper.DumpException(exception);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    rtExceptionInfo notExistException = BuildRtException(1, 20, 3);
    notExistException.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    notExistException.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    notExistException.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    notExistException.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    EXPECT_EQ(dumper.DumpException(notExistException), ADUMP_SUCCESS);
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException_ResidentOp)
{
    Tools::CaseWorkspace ws("Test_DumpException_ResidentOp");

    auto input = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto output = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();

    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName", false)
                              .Task(1, 2, 3)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();

    // test error dumpStatus
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "normal";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), false);

    // test twice enable
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    rtExceptionInfo exception = BuildRtException(1, 2, 3);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exception);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // test delete exception op
    EXPECT_EQ(AdumpDelExceptionOperatorInfo(1, 3), ADUMP_SUCCESS);
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException_FFTS_PLUS)
{
    Tools::CaseWorkspace ws("Test_DumpException_FFTS_PLUS");

    auto input = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto output = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();

    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName")
                              .Task(1, 2, 3, 4)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();
    ;

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    dumper.AddDumpOperator(opInfo);
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf);

    rtExceptionInfo exception = BuildRtException(1, 2, 3, 0, 4, 5);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    int32_t ret = dumper.DumpException(exception);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException_With_CreateDumpDirector_Fail)
{
    Tools::CaseWorkspace ws("Test_DumpException_FFTS_PLUS");
    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName").Task(1, 2, 3).Build();

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    ExceptionDumper dumper;
    dumper.SetDumpPath(ws.Root());
    dumper.AddDumpOperator(opInfo);
    dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf);

    MOCKER_CPP(&Path::CreateDirectory).stubs().will(returnValue(false));
    rtExceptionInfo exception = BuildRtException(1, 2, 3);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    int32_t ret = dumper.DumpException(exception);
    EXPECT_EQ(ret, ADUMP_FAILED);
}
TEST_F(TinyExceptionDumperUtest, Test_DumpException_ResidentOp_Coredump)
{
    Tools::CaseWorkspace ws("Test_DumpException_ResidentOp");

    uint32_t type = 5;  // CHIP_CLOUD_V2
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));

    auto input = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto output = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();

    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName", false)
                              .Task(1, 2, 3)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();

    // test error dumpStatus
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::AIC_ERR_DETAIL_DUMP), true);

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    rtExceptionInfo exception = BuildRtException(1, 2, 3);
    char fftsAddr[] = "ffts addr";
    uint64_t args[1] = {0};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;
    exception.expandInfo.type = RT_EXCEPTION_AICORE;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exception);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // test delete exception op
    EXPECT_EQ(AdumpDelExceptionOperatorInfo(1, 3), ADUMP_SUCCESS);
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException_Coredump_SetConfig_Failed)
{
    Tools::CaseWorkspace ws("Test_DumpException_Coredump_SetConfig_Failed");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";

    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), Adx::ADUMP_SUCCESS);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), Adx::ADUMP_SUCCESS);
    DumpManager::Instance().Reset();
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException_ExceptionDumperInit)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "";
    dumpConf.dumpStatus = "off";
    ExceptionDumper dumper;
    EXPECT_EQ(dumper.ExceptionDumperInit(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), Adx::ADUMP_SUCCESS);
    DumpManager::Instance().Reset();
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException_DumpException_ExceptionFail)
{
    rtExceptionInfo exception = BuildRtException(1, 2, 3);
    ExceptionDumper dumper;
    dumper.destructionFlag_ = false;
    dumper.coredumpStatus_ = false;
    dumper.exceptionStatus_ = true;
    dumper.dumpPath_ = "";
    MOCKER_CPP(&Adx::ExceptionDumper::FindExceptionOperator).stubs().will(returnValue(true));
    MOCKER_CPP(&Adx::ExceptionInfoCommon::GetExceptionInfo).stubs().will(returnValue(1));
    EXPECT_EQ(dumper.DumpException(exception), Adx::ADUMP_FAILED);
    DumpManager::Instance().Reset();
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException_DumpException_ArgsException)
{
    rtExceptionInfo exception = BuildRtException(1, 2, 3);
    ExceptionDumper dumper;
    dumper.destructionFlag_ = false;
    dumper.coredumpStatus_ = false;
    dumper.exceptionStatus_ = false;
    dumper.argsExceptionStatus_ = true;
    MOCKER_CPP(&Adx::DumpArgs::LoadArgsExceptionInfo)
        .stubs()
        .will(returnValue(Adx::ADUMP_FAILED))
        .then(returnValue(Adx::ADUMP_SUCCESS))
        .then(returnValue(Adx::ADUMP_SUCCESS));
    MOCKER_CPP(&Adx::DumpArgs::DumpArgsExceptionInfo)
        .stubs()
        .will(returnValue(Adx::ADUMP_FAILED))
        .then(returnValue(Adx::ADUMP_SUCCESS));
    EXPECT_EQ(dumper.DumpException(exception), Adx::ADUMP_FAILED);
    EXPECT_EQ(dumper.DumpException(exception), Adx::ADUMP_FAILED);
    EXPECT_EQ(dumper.DumpException(exception), Adx::ADUMP_SUCCESS);
    DumpManager::Instance().Reset();
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException_DumpException_NotSupport)
{
    rtExceptionInfo exception = BuildRtException(1, 2, 3);
    ExceptionDumper dumper;
    dumper.destructionFlag_ = false;
    dumper.coredumpStatus_ = false;
    dumper.exceptionStatus_ = false;
    dumper.argsExceptionStatus_ = false;
    dumper.dumpPath_ = "";
    EXPECT_EQ(dumper.DumpException(exception), Adx::ADUMP_FAILED);
    DumpManager::Instance().Reset();
}


TEST_F(TinyExceptionDumperUtest, Test_DumpException_ExceptionModeDowngrade)
{
    ExceptionDumper dumper;
    dumper.destructionFlag_ = false;
    dumper.coredumpStatus_ = false;
    dumper.exceptionStatus_ = false;
    dumper.argsExceptionStatus_ = false;
    dumper.dumpPath_ = "";
    dumper.ExceptionModeDowngrade();
    DumpManager::Instance().Reset();
}

TEST_F(TinyExceptionDumperUtest, Test_DumpException_Exit)
{
    ExceptionDumper dumper;
    dumper.destructionFlag_ = false;
    dumper.coredumpStatus_ = false;
    dumper.exceptionStatus_ = false;
    dumper.argsExceptionStatus_ = false;
    dumper.dumpPath_ = "";
    MOCKER_CPP(&DlogFlush).stubs();
    dumper.Exit();
    DumpManager::Instance().Reset();
}
