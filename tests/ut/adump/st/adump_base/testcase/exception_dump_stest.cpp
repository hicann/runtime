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
#include <thread>
#include "case_workspace.h"
#include "gert_tensor_builder.h"
#include "dump_param_builder.h"
#include "dump_file_checker.h"
#include "runtime/rt.h"
#include "adump_pub.h"
#include "dump_manager.h"
#include "dump_memory.h"
#include "sys_utils.h"
#include "file.h"
#include "ascend_hal.h"
#include "file.h"

using namespace Adx;

class RuntimeExceptionCallback {
public:
    static RuntimeExceptionCallback &Instance()
    {
        static RuntimeExceptionCallback inst;
        return inst;
    }

    rtTaskFailCallback &MutableCallback()
    {
        return callback_;
    }

    void Invoke(rtExceptionInfo *const exception)
    {
        if (callback_) {
            callback_(exception);
        }
    }

private:
    rtTaskFailCallback callback_;
};

static rtError_t rtRegTaskFailCallbackByModuleStub(const char_t *moduleName, rtTaskFailCallback callback)
{
    RuntimeExceptionCallback::Instance().MutableCallback() = callback;
    return RT_ERROR_NONE;
}

class ExceptionDumpStest : public testing::Test {
protected:
    virtual void SetUp()
    {
        SubRuntimeRegExceptionCallback();
    }

    virtual void TearDown()
    {
        ResetExceptionCallback();
        GlobalMockObject::verify();
    }

    void SubRuntimeRegExceptionCallback()
    {
        MOCKER(rtRegTaskFailCallbackByModule).stubs().will(invoke(rtRegTaskFailCallbackByModuleStub));
    }

    void ResetExceptionCallback()
    {
        DumpManager::Instance().Reset();
        RuntimeExceptionCallback::Instance().MutableCallback() = nullptr;
    }

    void InvokeException(uint32_t deviceId, uint32_t taskId, uint32_t streamId, uint32_t retCode = 0,
                         uint32_t contextId = UINT32_MAX)
    {
        rtExceptionInfo exception = BuildRtException(deviceId, taskId, streamId, retCode, contextId);
        char hostKernel[] = "host kernel bin file stub";
        std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
        if (contextId == UINT32_MAX) {
            exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
            exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
            exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
            exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
        } else {
            exception.expandInfo.u.fftsPlusInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
            exception.expandInfo.u.fftsPlusInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
            exception.expandInfo.u.fftsPlusInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
            exception.expandInfo.u.fftsPlusInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
        }
        RuntimeExceptionCallback::Instance().Invoke(&exception);
    }
};

TEST_F(ExceptionDumpStest, Test_ExceptionDump_Close)
{
    ExceptionDumper dumper;
    DumpConfig dumpConf;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(ADUMP_SUCCESS, dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf));
    dumpConf.dumpStatus = "off";
    EXPECT_EQ(ADUMP_SUCCESS, dumper.ExceptionDumperInit(DumpType::EXCEPTION, dumpConf));
    rtExceptionInfo exception;
    EXPECT_EQ(ADUMP_FAILED, dumper.DumpException(exception));   // not enable dump
}

TEST_F(ExceptionDumpStest, Test_EnableExceptionDump_ByEnv)
{
    DumpConfig dumpConf;
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), false);

    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_DumpData)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData");

    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

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

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    InvokeException(deviceId, taskId, streamId);

    std::string expectDumpFilePath = ExpectedDumpFilePath(dumpPath, deviceId, opType, opName, taskId, stubNowTime);

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
    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);
    InvokeException(deviceId, taskId, streamId);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_DumpData_LongName)
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
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
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

TEST_F(ExceptionDumpStest, Test_ExceptionDump_DumpData_Exception)
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

TEST_F(ExceptionDumpStest, Test_ExceptionDump_DumpData_RealPath)
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

TEST_F(ExceptionDumpStest, Test_ExceptionDump_FFTS_PLUS_Task)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_FFTS_PLUS_Task");

    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    OperatorInfo opInfo = OperatorInfoBuilder("ffts_type", "ffts_name").Task(1, 2, 3, 4).Build();
    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    InvokeException(1, 2, 3, 0, 4);

    std::string expectDumpFilePath = ExpectedDumpFilePath(dumpPath, 1, "ffts_type", "ffts_name", 2, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), true);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_Resident_Op)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_Resident_Op");

    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    OperatorInfo opInfo = OperatorInfoBuilder("resident_op", "resident_op", false).Task(1, 2, 3).Build();
    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    InvokeException(1, 2, 3);

    std::string expectDumpFilePath = ExpectedDumpFilePath(dumpPath, 1, "resident_op", "resident_op", 2, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), true);

    // test delete exception op
    EXPECT_EQ(AdumpDelExceptionOperatorInfo(1, 3), ADUMP_SUCCESS);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_With_OverFlow)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_With_OverFlow");

    uint32_t retModeOverflow = 207003;
    // can't enable exception dump, when retcode type is overflow
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    OperatorInfo opInfo = OperatorInfoBuilder("resident_op", "resident_op", false).Task(1, 2, 3).Build();
    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    InvokeException(1, 2, 3, retModeOverflow);

    std::string expectDumpFilePath = ExpectedDumpFilePath(dumpPath, 1, "resident_op", "resident_op", 2, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), false);

    // only handle aic error
    rtExceptionInfo exception = {0};
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = 0;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = 0;
    MOCKER_CPP(&DumpManager::DumpExceptionInfo).expects(never());
    RuntimeExceptionCallback::Instance().Invoke(&exception);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_With_EmptyDumpPath)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_With_EmptyDumpPath");
    std::string dumpPath = "";
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    OperatorInfo opInfo = OperatorInfoBuilder("Type", "Name").Task(1, 2, 3).Build();
    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));
    InvokeException(1, 2, 3);

    std::string expectDumpFilePath = ExpectedDumpFilePath(dumpPath, 1, "Type", "Name", 2, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), false);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_DumpData_With_CreateDumpDir_Fail)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData_With_CreateDumpDir_Fail");
    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    OperatorInfo opInfo = OperatorInfoBuilder("Type", "Name").Task(1, 2, 3).Build();
    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    MOCKER(mmMkdir).stubs().will(returnValue((int32_t)EN_ERROR));
    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));
    InvokeException(1, 2, 3);

    std::string expectDumpFilePath = ExpectedDumpFilePath(dumpPath, 1, "Type", "Name", 2, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), false);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_DumpData_With_CreateDumpDir_Fail_SetDeivce)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData_With_CreateDumpDir_Fail_SetDeivce");

    MOCKER(rtCtxGetCurrent).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(rtCtxCreate).stubs().will(returnValue(1)).then(returnValue(RT_ERROR_NONE));
    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    OperatorInfo opInfo = OperatorInfoBuilder("Type", "Name").Task(1, 2, 3).Build();
    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    MOCKER(mmMkdir).stubs().will(returnValue((int32_t)EN_ERROR));
    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));
    InvokeException(1, 2, 3);
    InvokeException(1, 2, 3);

    std::string expectDumpFilePath = ExpectedDumpFilePath(dumpPath, 1, "Type", "Name", 2, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), false);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_DumpData_With_ErrorAddress)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData_With_ErrorAddress");
    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

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

    OperatorInfo opInfo =
        OperatorInfoBuilder(opType, opName)
            .Task(deviceId, taskId, streamId)
            .TensorInfo(input.GetTensor(), TensorType::INPUT)
            .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
            .TensorInfo(workspace.GetTensor(), TensorType::WORKSPACE)
            .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE, std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))
            .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
            .Build();

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    MOCKER(rtMallocHost).stubs().will(returnValue(1));
    InvokeException(1, 2, 3);

    void *nullHostMem = nullptr;
    MOCKER(&DumpMemory::CopyDeviceToHost).stubs().will(returnValue(nullHostMem));
    MOCKER(memset_s).stubs().will(returnValue(1));
    InvokeException(1, 2, 3);

    MOCKER(rtMemGetInfoByType).stubs().will(returnValue(1));
    InvokeException(1, 2, 3);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_DumpData_With_IsOtherDeviceAddress_Fail)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_DumpData_With_IsOtherDeviceAddress_Fail");
    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

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

    OperatorInfo opInfo =
        OperatorInfoBuilder(opType, opName)
            .Task(deviceId, taskId, streamId)
            .TensorInfo(input.GetTensor(), TensorType::INPUT)
            .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
            .TensorInfo(workspace.GetTensor(), TensorType::WORKSPACE)
            .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE, std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))
            .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
            .Build();

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    MOCKER(rtMemGetInfoByType).stubs().will(returnValue(1));
    InvokeException(1, 2, 3);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_With_DeviceArgs)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_LogArgs");

    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    uint32_t deviceId = 1;
    uint32_t taskId = 2;
    uint32_t streamId = 3;
    std::string opType = "CONV2D";
    std::string opName = "TestName";

    auto input = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto output = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();

    // device args
    uintptr_t inputAddr = reinterpret_cast<uintptr_t>(input.GetTensor()->GetAddr());
    uintptr_t outputAddr = reinterpret_cast<uintptr_t>(output.GetTensor()->GetAddr());
    std::vector<uintptr_t> args = {inputAddr, outputAddr};

    OperatorInfo opInfo =
        OperatorInfoBuilder(opType, opName)
            .Task(deviceId, taskId, streamId)
            .TensorInfo(input.GetTensor(), TensorType::INPUT, AddressType::TRADITIONAL, 3)
            .TensorInfo(output.GetTensor(), TensorType::OUTPUT, AddressType::TRADITIONAL, 3)
            .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                          std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
            .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
            .AdditionInfo(DUMP_ADDITIONAL_BLOCK_DIM, "32")
            .AdditionInfo(DUMP_ADDITIONAL_WORKSPACE_BYTES, "[]")
            .AdditionInfo(DUMP_ADDITIONAL_WORKSPACE_ADDRS, "[]")
            .AdditionInfo(
                DUMP_ADDITIONAL_ALL_ATTRS,
                "GatherV2_kernelname:Wte_gatherv2_35abc66352c0e2c007f751dcfe625a26e58c5a3d61244f7458257b920f5a49ae_1__"
                "kernel0;GatherV2_pattern:Opaque;INPUT_IS_VAR:")
            .AdditionInfo(DUMP_ADDITIONAL_TILING_KEY, "0")
            .AdditionInfo(DUMP_ADDITIONAL_IS_HOST_ARGS, "true")
            .DeviceInfo(DEVICE_INFO_NAME_ARGS, args.data(), args.size() * sizeof(uintptr_t))
            .Build();

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    InvokeException(deviceId, taskId, streamId);

    std::string expectDumpFilePath = ExpectedDumpFilePath(dumpPath, deviceId, opType, opName, taskId, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), true);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_CopyOpKernal)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_CopyOpKernal");

    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    std::string kernalMeta = "kernal_meta";
    std::string kernalName = "this_is_a_stub_kernal_name";

    // create kernal file
    std::string KernalMetaPath = ws.Mkdir(kernalMeta);
    std::string kernalFilePath = ws.Touch(kernalMeta + "/" + kernalName + ".o");

    // set dev func
    std::string devFunc = kernalName + "__dev_suffix";

    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName")
                              .Task(1, 2, 3)
                              .AdditionInfo(DUMP_ADDITIONAL_DEV_FUNC, devFunc)  // set dev func
                              .AdditionInfo(DUMP_ADDITIONAL_OP_FILE_PATH, KernalMetaPath)
                              .Build();

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));
    MOCKER_CPP(&SysUtils::GetCurrentWorkDir).stubs().will(returnValue(ws.Root()));

    InvokeException(1, 2, 3);

    std::string expectDumpFilePath = ExpectedDumpFilePath(ws.Root(), 1, "CONV2D", "TestName", 2, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), true);

    std::string expectKernalFile = ws.Root() + "/" + kernalName + ".o";
    EXPECT_EQ(IsFileExist(expectKernalFile), true);
}

TEST_F(ExceptionDumpStest, Test_ExceptionDump_CopyOpKernal_WithError)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_CopyOpKernal");

    // enable exception dump
    std::string dumpPath = ws.Root();
    DumpConfig dumpConf;
    dumpConf.dumpPath = dumpPath;
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    std::string kernalMeta = "kernal_meta";
    std::string kernalName = "this_is_a_stub_kernal_name";

    // create kernal file
    std::string KernalMetaPath = ws.Mkdir(kernalMeta);
    std::string kernalFilePath = ws.Touch(kernalMeta + "/" + kernalName + ".o");

    // Add a valid kernal path
    std::string devFunc = kernalName + "__dev_suffix";
    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName")
                              .Task(1, 2, 3)
                              .AdditionInfo(DUMP_ADDITIONAL_DEV_FUNC, devFunc)  // set dev func
                              .AdditionInfo(DUMP_ADDITIONAL_OP_FILE_PATH, KernalMetaPath)
                              .Build();

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string inValidDevFunc = kernalName + "invalid__dev_suffix";
    OperatorInfo inValidOpInfo = OperatorInfoBuilder("CONV2D", "TestName")
                                     .Task(2, 3, 4)
                                     .AdditionInfo(DUMP_ADDITIONAL_DEV_FUNC, inValidDevFunc)  // set invalid dev func
                                     .AdditionInfo(DUMP_ADDITIONAL_OP_FILE_PATH, KernalMetaPath)
                                     .Build();

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(inValidOpInfo), ADUMP_SUCCESS);

    std::string expectKernalFile = ws.Root() + "/" + kernalName + ".o";

    // test invalid dev func path
    InvokeException(2, 3, 4);
    EXPECT_EQ(IsFileExist(expectKernalFile), false);  // kernal file is not exist cause src file is invalid

    // test valid op exception
    rtExceptionInfo exception = BuildRtException(1, 2, 3);
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    // stub get cwd failed
    MOCKER_CPP(&SysUtils::GetCurrentWorkDir).stubs().will(returnValue(std::string(""))).then(returnValue(ws.Root()));
    InvokeException(1, 2, 3);
    EXPECT_EQ(IsFileExist(expectKernalFile), false);

    // stub copy file error
    MOCKER_CPP(&File::Copy).stubs().will(returnValue(ADUMP_FAILED));
    InvokeException(1, 2, 3);
    EXPECT_EQ(IsFileExist(expectKernalFile), false);
}
