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
#include "gert_tensor_builder.h"
#include "dump_param_builder.h"
#include "dump_file_checker.h"
#include "runtime/rt_error_codes.h"
#include "adump_pub.h"
#include "sys_utils.h"
#include "file_utils.h"
#include "file.h"
#include "dump_memory.h"
#include "dump_file.h"
#include "dump_operator.h"
#include "dump_manager.h"
#include "ascend_hal.h"

using namespace Adx;

class DumpOperatorUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DumpOperatorUtest, Test_OpIdentify)
{
    uint32_t deviceId = 1;
    uint32_t taskId = 2;
    uint32_t streamId = 3;
    uint32_t contextId = 4;

    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName").Task(deviceId, taskId, streamId, contextId).Build();

    OperatorInfoV2 opInfoV2 = {};
    DumpManager::Instance().ConvertOperatorInfo(opInfo, opInfoV2);
    DumpOperator dumpOp(opInfoV2);

    OpIdentity identity(deviceId, taskId, streamId, contextId);

    EXPECT_EQ(dumpOp.IsBelongTo(OpIdentity(deviceId, taskId, streamId, contextId)), true);
    EXPECT_EQ(dumpOp.IsBelongTo(OpIdentity(deviceId + 1, taskId, streamId, contextId)), false);
    EXPECT_EQ(dumpOp.IsBelongTo(OpIdentity(deviceId, taskId + 1, streamId, contextId)), false);
    EXPECT_EQ(dumpOp.IsBelongTo(OpIdentity(deviceId, taskId, streamId + 1, contextId)), false);
    EXPECT_EQ(dumpOp.IsBelongTo(OpIdentity(deviceId, taskId, streamId, contextId + 1)), false);
}

TEST_F(DumpOperatorUtest, Test_Log_TvmOp_ExceptionInfo)
{
    auto input = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto output = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    std::vector<uintptr_t> args = {1, 2, 3, 4};

    OperatorInfo opInfo =
        OperatorInfoBuilder("CONV2D", "TestName")
            .Task(1, 2, 3, 4)
            .TensorInfo(input.GetTensor(), TensorType::INPUT)
            .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
            .TensorInfo(nullptr, TensorType::INPUT)
            .DeviceInfo(DEVICE_INFO_NAME_ARGS, args.data(), args.size() * sizeof(uintptr_t))
            .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE, std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))
            .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "tiling_data_xxxx")
            .AdditionInfo(DUMP_ADDITIONAL_BLOCK_DIM, "32")
            .AdditionInfo(DUMP_ADDITIONAL_WORKSPACE_BYTES, "[]")
            .AdditionInfo(DUMP_ADDITIONAL_WORKSPACE_ADDRS, "[]")
            .AdditionInfo(
                DUMP_ADDITIONAL_ALL_ATTRS,
                "GatherV2_kernelname:Wte_gatherv2_35abc66352c0e2c007f751dcfe625a26e58c5a3d61244f7458257b920f5a49ae_1__"
                "kernel0;GatherV2_pattern:Opaque;INPUT_IS_VAR:")
            .AdditionInfo(DUMP_ADDITIONAL_TILING_KEY, "0")
            .Build();

    OperatorInfoV2 opInfoV2 = {};
    DumpManager::Instance().ConvertOperatorInfo(opInfo, opInfoV2);
    DumpOperator dumpOp(opInfoV2);

    rtExceptionArgsInfo exceptionArgs;
    exceptionArgs.argAddr = args.data();
    exceptionArgs.argsize = args.size() * sizeof(uintptr_t);
    char hostKernel[] = "host kernel bin file stub";
    exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    int32_t ret = dumpOp.LogExceptionInfo(exceptionArgs);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpOperatorUtest, Test_Log_Non_TvmOp_ExceptionInfo)
{
    std::vector<uintptr_t> addrArgs = {1, 2, 3, 4};
    rtExceptionArgsInfo exceptionArgs;
    exceptionArgs.argAddr = addrArgs.data();
    exceptionArgs.argsize = addrArgs.size() * sizeof(uintptr_t);
    char hostKernel[] = "host kernel bin file stub";
    exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    OperatorInfo opInfoWithoutAdditionInfo;
    OperatorInfoV2 opInfoV2 = {};
    DumpManager::Instance().ConvertOperatorInfo(opInfoWithoutAdditionInfo, opInfoV2);
    DumpOperator dumpOp1(opInfoV2);
    EXPECT_EQ(dumpOp1.LogExceptionInfo(exceptionArgs), ADUMP_SUCCESS);

    OperatorInfo opInfoNotTvm;
    opInfoNotTvm.additionalInfo[DUMP_ADDITIONAL_IMPLY_TYPE] =
        std::to_string(static_cast<int32_t>(domi::ImplyType::BUILDIN));
    DumpManager::Instance().ConvertOperatorInfo(opInfoNotTvm, opInfoV2);
    DumpOperator dumpOp2(opInfoV2);
    EXPECT_EQ(dumpOp2.LogExceptionInfo(exceptionArgs), ADUMP_SUCCESS);

    OperatorInfo opInfoWithInvalidImplyType;
    opInfoWithInvalidImplyType.additionalInfo[DUMP_ADDITIONAL_IMPLY_TYPE] = "abc";
    DumpManager::Instance().ConvertOperatorInfo(opInfoWithInvalidImplyType, opInfoV2);
    DumpOperator dumpOp3(opInfoV2);
    EXPECT_EQ(dumpOp3.LogExceptionInfo(exceptionArgs), ADUMP_SUCCESS);
}

TEST_F(DumpOperatorUtest, Test_Log_ExceptionArgs)
{
    OperatorInfoBuilder builder("CONV2D", "TestName");
    builder.Task(1, 2, 3, 4);
    std::vector<uintptr_t> addrArgs = {1, 2, 3, 4};
    rtExceptionArgsInfo exceptionArgs;
    exceptionArgs.argAddr = addrArgs.data();
    exceptionArgs.argsize = addrArgs.size() * sizeof(uintptr_t);
    char hostKernel[] = "host kernel bin file stub";
    exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    // only log tvm op
    builder.AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE, std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)));

    // nullptr
    builder.DeviceInfo(DEVICE_INFO_NAME_ARGS, nullptr, 0);
    OperatorInfoV2 opInfoV2 = {};
    DumpManager::Instance().ConvertOperatorInfo(builder.Build(), opInfoV2);
    EXPECT_EQ(DumpOperator(opInfoV2).LogExceptionInfo(exceptionArgs), ADUMP_SUCCESS);

    // normal args
    std::vector<uintptr_t> args = {1, 2, 3, 4};
    builder.DeviceInfo(DEVICE_INFO_NAME_ARGS, args.data(), args.size() * sizeof(uintptr_t));
    DumpManager::Instance().ConvertOperatorInfo(builder.Build(), opInfoV2);
    EXPECT_EQ(DumpOperator(opInfoV2).LogExceptionInfo(exceptionArgs), ADUMP_SUCCESS);

    //copy device memory to host failed
    void *hostMem = nullptr;
    MOCKER_CPP(&DumpMemory::CopyDeviceToHost).stubs().will(returnValue(hostMem));
    DumpManager::Instance().ConvertOperatorInfo(builder.Build(), opInfoV2);
    EXPECT_EQ(DumpOperator(opInfoV2).LogExceptionInfo(exceptionArgs), ADUMP_FAILED);
}

TEST_F(DumpOperatorUtest, Test_RefreshAddr)
{
    // set a input tensor and a output tensor
    auto input = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto output = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();

    OperatorInfoBuilder builder("CONV2D", "TestName");
    builder.Task(1, 2, 3, 4);
    builder.TensorInfo(input.GetTensor(), TensorType::INPUT);
    builder.TensorInfo(output.GetTensor(), TensorType::OUTPUT);

    uintptr_t argOfInputAddr = 0x1234;
    uintptr_t argOfOutputAddr = 0x4321;
    std::vector<uintptr_t> args = {argOfInputAddr, argOfOutputAddr};
    rtExceptionArgsInfo exceptionArgs;
    exceptionArgs.argAddr = nullptr;
    exceptionArgs.argsize = args.size() * sizeof(uintptr_t);
    // refresh with args is nullptr
    builder.DeviceInfo(DEVICE_INFO_NAME_ARGS, nullptr, 0);
    OperatorInfoV2 opInfoV2 = {};
    DumpManager::Instance().ConvertOperatorInfo(builder.Build(), opInfoV2);
    DumpOperator dumpOpWithNullArgs(opInfoV2);
    EXPECT_EQ(ADUMP_FAILED, dumpOpWithNullArgs.RefreshAddrs(exceptionArgs));

    // refresh addr success
    exceptionArgs.argAddr = args.data();
    builder.DeviceInfo(DEVICE_INFO_NAME_ARGS, args.data(), args.size() * sizeof(uintptr_t));
    builder.AdditionInfo(DUMP_ADDITIONAL_IS_HOST_ARGS, "true");
    DumpManager::Instance().ConvertOperatorInfo(builder.Build(), opInfoV2);
    DumpOperator dumpOpWithArgs(opInfoV2);
    EXPECT_EQ(ADUMP_SUCCESS, dumpOpWithArgs.RefreshAddrs(exceptionArgs));

    // tensor with wrong args offset
    OperatorInfoBuilder builder1("CONV2D", "TestName");
    builder1.Task(1, 2, 3, 4);
    builder1.TensorInfo(input.GetTensor(), TensorType::INPUT, AddressType::TRADITIONAL, 3);
    builder1.TensorInfo(output.GetTensor(), TensorType::OUTPUT, AddressType::TRADITIONAL, 3);
    builder1.DeviceInfo(DEVICE_INFO_NAME_ARGS, args.data(), args.size() * sizeof(uintptr_t));
    builder1.AdditionInfo(DUMP_ADDITIONAL_IS_HOST_ARGS, "false");
    DumpManager::Instance().ConvertOperatorInfo(builder1.Build(), opInfoV2);
    DumpOperator dumpOpWithWrongOffset(opInfoV2);
    EXPECT_EQ(ADUMP_SUCCESS, dumpOpWithWrongOffset.RefreshAddrs(exceptionArgs));
}

TEST_F(DumpOperatorUtest, Test_CopyOpKernelFile)
{
    Tools::CaseWorkspace ws("Test_CopyOpKernelFile");
    std::string kernalMeta = "kernal_meta";
    std::string kernalName = "this_is_a_stub_kernal_name";

    // create kernal file
    std::string KernalMetaPath = ws.Mkdir(kernalMeta);
    std::string kernalFilePath = ws.Touch(kernalMeta + "/" + kernalName + ".o");

    // set dev func
    std::string devFunc = kernalName + "__dev_suffix";

    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName")
                              .Task(1, 2, 3, 4)
                              .AdditionInfo(DUMP_ADDITIONAL_DEV_FUNC, devFunc)  // set dev func
                              .AdditionInfo(DUMP_ADDITIONAL_OP_FILE_PATH, KernalMetaPath)
                              .Build();

    MOCKER_CPP(&SysUtils::GetCurrentWorkDir).stubs().will(returnValue(ws.Root()));
    OperatorInfoV2 opInfoV2 = {};
    DumpManager::Instance().ConvertOperatorInfo(opInfo, opInfoV2);
    EXPECT_EQ(DumpOperator(opInfoV2).CopyOpKernelFile(), ADUMP_SUCCESS);

    std::string expectKernalFile = ws.Root() + "/" + kernalName + ".o";
    EXPECT_EQ(IsFileExist(expectKernalFile), true);
}

TEST_F(DumpOperatorUtest, Test_CopyOpKernelFile_With_Error)
{
    Tools::CaseWorkspace ws("Test_CopyOpKernelFile_With_Error");
    std::string kernalMeta = "kernal_meta";
    std::string kernalName = "this_is_a_stub_kernal_name";

    OperatorInfoBuilder builder("CONV2D", "TestName");
    builder.Task(1, 2, 3, 4);

    // Copy op kernal file with out set additional dev func
    OperatorInfoV2 opInfoV2 = {};
    DumpManager::Instance().ConvertOperatorInfo(builder.Build(), opInfoV2);
    EXPECT_EQ(DumpOperator(opInfoV2).CopyOpKernelFile(), ADUMP_FAILED);  // no dev func.

    // set dev func
    std::string devFunc = kernalName + "__dev_suffix";
    builder.AdditionInfo(DUMP_ADDITIONAL_DEV_FUNC, devFunc);

    // no src kernal file
    DumpManager::Instance().ConvertOperatorInfo(builder.Build(), opInfoV2);
    EXPECT_EQ(DumpOperator(opInfoV2).CopyOpKernelFile(), ADUMP_FAILED);  // src file path realpath failed.

    // create kernal dir and file
    std::string KernalMetaPath = ws.Mkdir(kernalMeta);
    std::string kernalFilePath = ws.Touch(kernalMeta + "/" + kernalName + ".o");
    builder.AdditionInfo(DUMP_ADDITIONAL_OP_FILE_PATH, KernalMetaPath);

    // stub get dst file fail
    std::string emptyDstFileDir = "";
    std::string existDstFileDir = KernalMetaPath;
    MOCKER_CPP(&SysUtils::GetCurrentWorkDir)
        .stubs()
        .will(returnValue(emptyDstFileDir))
        .then(returnValue(existDstFileDir));
    DumpManager::Instance().ConvertOperatorInfo(builder.Build(), opInfoV2);
    EXPECT_EQ(DumpOperator(opInfoV2).CopyOpKernelFile(), ADUMP_FAILED);  // GetCurrentWorkDir failed

    // stub copy file fail
    MOCKER_CPP(&File::Copy).stubs().will(returnValue(ADUMP_FAILED)).then(returnValue(ADUMP_SUCCESS));
    DumpManager::Instance().ConvertOperatorInfo(builder.Build(), opInfoV2);
    EXPECT_EQ(DumpOperator(opInfoV2).CopyOpKernelFile(), ADUMP_FAILED);   // copy file fail
    EXPECT_EQ(DumpOperator(opInfoV2).CopyOpKernelFile(), ADUMP_SUCCESS);  // success
}

TEST_F(DumpOperatorUtest, Test_DumpException)
{
    Tools::CaseWorkspace ws("Test_DumpException");
    std::string dumpPath = ws.Root();

    auto input = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto output = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto workspace = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();

    OperatorInfo opInfo = OperatorInfoBuilder("CONV2D", "TestName")
                              .Task(1, 2, 3, 4)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .TensorInfo(workspace.GetTensor(), TensorType::WORKSPACE)
                              .Build();

    OperatorInfoV2 opInfoV2 = {};
    DumpManager::Instance().ConvertOperatorInfo(opInfo, opInfoV2);
    EXPECT_EQ(DumpOperator(opInfoV2).DumpException(0, dumpPath), ADUMP_SUCCESS);

    // Test dump file failed.
    MOCKER_CPP(&DumpFile::Dump).stubs().will(returnValue(ADUMP_FAILED));
    EXPECT_EQ(DumpOperator(opInfoV2).DumpException(0, dumpPath), ADUMP_FAILED);
}

TEST_F(DumpOperatorUtest, Test_DumpOpreaterStatsConfig)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpMode = "input";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    dumpConf.dumpStatus = "on";
    dumpConf.dumpData = "stats";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(true, DumpManager::Instance().GetDumpSetting().GetDumpData().compare("stats") == 0);
}

int32_t g_halSuccessCnt = 0;
rtError_t rtGetDeviceInfoStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    (void)devId;
    (void)moduleType;
    (void)infoType;
    *value = 1280;

    if (g_halSuccessCnt > 8) {
        return RT_ERROR_NONE;  // 9+
    } else if (g_halSuccessCnt > 7) {
        g_halSuccessCnt++;
        return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;  // 8
    }
    g_halSuccessCnt++;
    return ACL_ERROR_RT_NO_DEVICE;  // 0
}

int32_t g_versionStubCount = -1;
drvError_t halGetAPIVersionStub(int32_t *halAPIVersion)
{
    *halAPIVersion = 467734;
    g_versionStubCount++;
    if (g_versionStubCount < 1) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return DRV_ERROR_NONE;
}

TEST_F(DumpOperatorUtest, Test_DumpOpreaterStatsConfigInMilan)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpData = "stats";
    dumpConf.dumpMode = "output";
    DumpManager::Instance().Reset();

    MOCKER(rtGetDeviceInfo).stubs().will(invoke(rtGetDeviceInfoStub));
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);

    // unsupported
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    // success
    MOCKER(Adx::FileUtils::IsFileExist).stubs().will(returnValue(true));
    EXPECT_FALSE(DumpManager::Instance().GetKFCInitStatus());

    // halGetAPIVersion version not support
    MOCKER_CPP(&halGetAPIVersion).stubs().will(invoke(halGetAPIVersionStub));
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_TRUE(DumpManager::Instance().GetKFCInitStatus());
    DumpManager::Instance().SetKFCInitStatus(false);
    EXPECT_FALSE(DumpManager::Instance().GetKFCInitStatus());

    // halGetAPIVersion failed
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_TRUE(DumpManager::Instance().GetKFCInitStatus());
    DumpManager::Instance().SetKFCInitStatus(false);

    MOCKER(&Adx::OperatorPreliminary::OperatorInit)
        .stubs()
        .will(returnValue(ADUMP_FAILED))
        .then(returnValue(ADUMP_SUCCESS));
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
    // first init
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    // double init
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    DumpManager::Instance().KFCResourceInit();
    EXPECT_EQ(DumpManager::operatorMap_.size(), 8);
}


TEST_F(DumpOperatorUtest, Test_DumpOpreaterStatsConfigKfcNotExisted)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpData = "stats";
    dumpConf.dumpMode = "output";
    DumpManager::Instance().Reset();
    MOCKER(rtGetDeviceInfo).stubs().will(invoke(rtGetDeviceInfoStub));
    MOCKER(&FileUtils::IsFileExist).stubs().will(returnValue(false));
    EXPECT_EQ(DumpManager::Instance().SetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(DumpManager::Instance().GetBinName(), "kfc_dump_stat_ascend910B.o");
    EXPECT_FALSE(DumpManager::Instance().CheckBinValidation());
}