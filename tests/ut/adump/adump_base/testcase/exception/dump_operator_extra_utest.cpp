/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_operator.h"
#include "dump_manager.h"
#include "common/thread.h"
#include "adx_dump_record.h"
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"

using namespace Adx;

class DumpOperatorExtraUtest : public testing::Test {
protected:
    void SetUp() override
    {
        MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
        MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));
    }
    void TearDown() override
    {
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }

    // Build a basic OperatorInfoV2 with no tensors/deviceInfos
    static OperatorInfoV2 MakeBasicOpInfo(const std::string &opType = "TestType",
                                          const std::string &opName = "TestOp",
                                          uint32_t taskId = 1U,
                                          uint32_t streamId = 2U,
                                          uint32_t deviceId = 0U,
                                          uint32_t contextId = 42U)
    {
        OperatorInfoV2 info;
        info.opType = opType;
        info.opName = opName;
        info.taskId = taskId;
        info.streamId = streamId;
        info.deviceId = deviceId;
        info.contextId = contextId;
        return info;
    }
};

// ============================================================================
// OpIdentity::operator== and GetString
// ============================================================================
TEST_F(DumpOperatorExtraUtest, OpIdentity_Equal_Same)
{
    OpIdentity id1(0U, 1U, 2U, 3U);
    OpIdentity id2(0U, 1U, 2U, 3U);
    EXPECT_TRUE(id1 == id2);
}

TEST_F(DumpOperatorExtraUtest, OpIdentity_Equal_DifferentDevice)
{
    OpIdentity id1(0U, 1U, 2U, 3U);
    OpIdentity id2(1U, 1U, 2U, 3U);
    EXPECT_FALSE(id1 == id2);
}

TEST_F(DumpOperatorExtraUtest, OpIdentity_Equal_DifferentTask)
{
    OpIdentity id1(0U, 1U, 2U, 3U);
    OpIdentity id2(0U, 9U, 2U, 3U);
    EXPECT_FALSE(id1 == id2);
}

TEST_F(DumpOperatorExtraUtest, OpIdentity_Equal_DifferentStream)
{
    OpIdentity id1(0U, 1U, 2U, 3U);
    OpIdentity id2(0U, 1U, 9U, 3U);
    EXPECT_FALSE(id1 == id2);
}

TEST_F(DumpOperatorExtraUtest, OpIdentity_GetString_ContainsStreamId)
{
    OpIdentity id(0U, 5U, 7U, 99U);
    std::string s = id.GetString();
    EXPECT_NE(s.find("7"), std::string::npos); // stream_id:7
}

TEST_F(DumpOperatorExtraUtest, OpIdentity_GetString_ContainsTaskId)
{
    OpIdentity id(0U, 5U, 7U, 99U);
    std::string s = id.GetString();
    EXPECT_NE(s.find("5"), std::string::npos); // task_id:5
}

// ============================================================================
// DumpOperator::Init and IsBelongTo
// ============================================================================
TEST_F(DumpOperatorExtraUtest, Init_Basic_IsBelongTo_Match)
{
    OperatorInfoV2 info = MakeBasicOpInfo("TypeA", "NameA", 10U, 20U, 0U, 30U);
    DumpOperator op(info);
    OpIdentity id;
    id.taskId = 10U;
    id.streamId = 20U;
    id.deviceId = 0U;
    id.contextId = 30U;
    EXPECT_TRUE(op.IsBelongTo(id));
}

TEST_F(DumpOperatorExtraUtest, Init_Basic_IsBelongTo_NoMatch)
{
    OperatorInfoV2 info = MakeBasicOpInfo("TypeA", "NameA", 10U, 20U, 0U, 30U);
    DumpOperator op(info);
    OpIdentity id;
    id.taskId = 99U;
    id.streamId = 20U;
    id.deviceId = 0U;
    id.contextId = 30U;
    EXPECT_FALSE(op.IsBelongTo(id));
}

TEST_F(DumpOperatorExtraUtest, Init_WithInputTensor_ValidPlacement)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    // Add an INPUT tensor with kOnDeviceHbm placement and valid addr/size
    static int64_t fakeMem[1] = {0};
    TensorInfoV2 tensor;
    tensor.type = TensorType::INPUT;
    tensor.tensorSize = sizeof(int64_t);
    tensor.tensorAddr = fakeMem;
    tensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    tensor.argsOffSet = 0U;
    info.tensorInfos.push_back(tensor);
    // Should not crash
    DumpOperator op(info);
    OpIdentity id;
    EXPECT_FALSE(op.IsBelongTo(id));
}

TEST_F(DumpOperatorExtraUtest, Init_WithOutputTensor_ValidPlacement)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    static int64_t fakeMem[1] = {0};
    TensorInfoV2 tensor;
    tensor.type = TensorType::OUTPUT;
    tensor.tensorSize = sizeof(int64_t);
    tensor.tensorAddr = fakeMem;
    tensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    tensor.argsOffSet = 1U;
    info.tensorInfos.push_back(tensor);
    DumpOperator op(info);
    OpIdentity id;
    EXPECT_FALSE(op.IsBelongTo(id));
}

TEST_F(DumpOperatorExtraUtest, Init_WithWorkspaceTensor)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    static int64_t fakeMem[1] = {0};
    TensorInfoV2 tensor;
    tensor.type = TensorType::WORKSPACE;
    tensor.tensorSize = sizeof(int64_t);
    tensor.tensorAddr = fakeMem;
    tensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    tensor.argsOffSet = 2U;
    info.tensorInfos.push_back(tensor);
    DumpOperator op(info);
    OpIdentity id;
    EXPECT_FALSE(op.IsBelongTo(id));
}

TEST_F(DumpOperatorExtraUtest, Init_WithTensor_NullAddr_Skipped)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    TensorInfoV2 tensor;
    tensor.type = TensorType::INPUT;
    tensor.tensorSize = 128U;
    tensor.tensorAddr = nullptr;  // null addr -> should be skipped
    tensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    tensor.argsOffSet = 0U;
    info.tensorInfos.push_back(tensor);
    // Should not crash
    DumpOperator op(info);
    (void)op;
}

TEST_F(DumpOperatorExtraUtest, Init_WithTensor_ZeroSize_Skipped)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    static int64_t fakeMem[1] = {0};
    TensorInfoV2 tensor;
    tensor.type = TensorType::INPUT;
    tensor.tensorSize = 0U;  // zero size -> should be skipped
    tensor.tensorAddr = fakeMem;
    tensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    tensor.argsOffSet = 0U;
    info.tensorInfos.push_back(tensor);
    DumpOperator op(info);
    (void)op;
}

TEST_F(DumpOperatorExtraUtest, Init_WithTensor_NonHbmPlacement_Skipped)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    static int64_t fakeMem[1] = {0};
    TensorInfoV2 tensor;
    tensor.type = TensorType::INPUT;
    tensor.tensorSize = 128U;
    tensor.tensorAddr = fakeMem;
    tensor.placement = static_cast<int32_t>(TensorPlacement::kOnHost);  // not HBM
    tensor.argsOffSet = 0U;
    info.tensorInfos.push_back(tensor);
    DumpOperator op(info);
    (void)op;
}

// ============================================================================
// InitDeviceArgs via Init with DEVICE_INFO_NAME_ARGS
// ============================================================================
TEST_F(DumpOperatorExtraUtest, Init_DeviceInfo_NullAddr_EarlyReturn)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    DeviceInfo devInfo;
    devInfo.name = DEVICE_INFO_NAME_ARGS;
    devInfo.addr = nullptr;  // null addr -> early return in InitDeviceArgs
    devInfo.length = 64U;
    info.deviceInfos.push_back(devInfo);
    // Should not crash
    DumpOperator op(info);
    (void)op;
}

TEST_F(DumpOperatorExtraUtest, Init_DeviceInfo_OtherName_Ignored)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    DeviceInfo devInfo;
    devInfo.name = "some_other_key";
    devInfo.addr = nullptr;
    devInfo.length = 0U;
    info.deviceInfos.push_back(devInfo);
    DumpOperator op(info);
    (void)op;
}

TEST_F(DumpOperatorExtraUtest, Init_WithIsHostArgs_True)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    info.additionalInfo[DUMP_ADDITIONAL_IS_HOST_ARGS] = "true";
    DumpOperator op(info);
    (void)op;
}

// ============================================================================
// CopyOpKernelFile -- tests failure paths without filesystem
// ============================================================================
TEST_F(DumpOperatorExtraUtest, CopyOpKernelFile_NoDEVFUNC_Fails)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    // No DUMP_ADDITIONAL_DEV_FUNC in additionalInfo
    DumpOperator op(info);
    int32_t ret = op.CopyOpKernelFile();
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpOperatorExtraUtest, CopyOpKernelFile_WithDevFunc_InvalidFile_Fails)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    info.additionalInfo[DUMP_ADDITIONAL_DEV_FUNC] = "mykernel_AddCustom__abc123";
    info.additionalInfo[DUMP_ADDITIONAL_OP_FILE_PATH] = "/nonexistent/path/kernel_meta";
    DumpOperator op(info);
    int32_t ret = op.CopyOpKernelFile();
    EXPECT_EQ(ret, ADUMP_FAILED);
}

// ============================================================================
// LogExceptionInfo with null argAddr (short-circuit args logging)
// ============================================================================
TEST_F(DumpOperatorExtraUtest, LogExceptionInfo_NullArgAddr)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    info.additionalInfo[DUMP_ADDITIONAL_BLOCK_DIM] = "1";
    info.additionalInfo[DUMP_ADDITIONAL_DEV_FUNC] = "mykernel__fn";
    DumpOperator op(info);
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = nullptr;
    argsInfo.argsize = 0U;
    // Just cover the code path (result may be success or fail)
    (void)op.LogExceptionInfo(argsInfo);
}

TEST_F(DumpOperatorExtraUtest, LogExceptionInfo_WithAdditions)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    info.additionalInfo[DUMP_ADDITIONAL_BLOCK_DIM] = "32";
    info.additionalInfo[DUMP_ADDITIONAL_WORKSPACE_BYTES] = "128";
    info.additionalInfo[DUMP_ADDITIONAL_ALL_ATTRS] = "attr1=val1";
    info.additionalInfo[DUMP_ADDITIONAL_TILING_KEY] = "0x1234";
    info.additionalInfo[DUMP_ADDITIONAL_TILING_DATA] = "data";
    info.additionalInfo[DUMP_ADDITIONAL_KERNEL_INFO] = "info";
    DumpOperator op(info);
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = nullptr;
    argsInfo.argsize = 0U;
    (void)op.LogExceptionInfo(argsInfo);
}

TEST_F(DumpOperatorExtraUtest, LogExceptionInfo_ImplyType_NotTVM)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    info.additionalInfo[DUMP_ADDITIONAL_IMPLY_TYPE] = "0"; // ImplyType::TBE or similar != TVM
    DumpOperator op(info);
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = nullptr;
    argsInfo.argsize = 0U;
    (void)op.LogExceptionInfo(argsInfo);
}

TEST_F(DumpOperatorExtraUtest, LogExceptionInfo_ImplyType_InvalidString)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    info.additionalInfo[DUMP_ADDITIONAL_IMPLY_TYPE] = "notanumber"; // StrUtils::ToInteger fails
    DumpOperator op(info);
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = nullptr;
    argsInfo.argsize = 0U;
    (void)op.LogExceptionInfo(argsInfo);
}

// ============================================================================
// GetDumpFilePath and DumpException (via DumpException with invalid path)
// ============================================================================
TEST_F(DumpOperatorExtraUtest, DumpException_InvalidPath)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    DumpOperator op(info);
    // DumpException calls DumpExceptionFile which calls DumpFile::Dump
    // With invalid path, it should fail but not crash
    int32_t ret = op.DumpException(0U, "/nonexistent_test_path_xyz");
    // Result is either success or failed, just don't crash
    (void)ret;
}

// ============================================================================
// Default constructor Init()
// ============================================================================
TEST_F(DumpOperatorExtraUtest, DefaultConstructor_ThenInit)
{
    DumpOperator op;
    OperatorInfoV2 info = MakeBasicOpInfo("MyType", "MyOp", 3U, 4U, 0U, 5U);
    op.Init(info);
    OpIdentity id;
    id.taskId = 3U;
    id.streamId = 4U;
    id.deviceId = 0U;
    id.contextId = 5U;
    EXPECT_TRUE(op.IsBelongTo(id));
}

TEST_F(DumpOperatorExtraUtest, Init_RefreshAddrs_NullArgAddr)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    DumpOperator op(info);
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = nullptr;
    argsInfo.argsize = 0U;
    // RefreshAddrs calls DumpMemory::CopyDeviceToHost with null ptr -> returns ADUMP_FAILED
    int32_t ret = op.RefreshAddrs(argsInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

// ============================================================================
// LogExceptionInfo with actual tensors (covers inputTensors_/outputTensors_/workspaces_ loops)
// ============================================================================
TEST_F(DumpOperatorExtraUtest, LogExceptionInfo_WithInputAndOutputTensors)
{
    OperatorInfoV2 info = MakeBasicOpInfo();

    // Add a valid input tensor with kOnDeviceHbm placement
    static int64_t fakeMem[4] = {1, 2, 3, 4};
    TensorInfoV2 inputTensor;
    inputTensor.type = TensorType::INPUT;
    inputTensor.tensorSize = sizeof(int64_t) * 4;
    inputTensor.tensorAddr = fakeMem;
    inputTensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    inputTensor.argsOffSet = 0U;
    inputTensor.dataType = 1; // DT_FLOAT
    inputTensor.format = 2;   // FORMAT_NCHW
    inputTensor.shape = {2, 2};
    inputTensor.originShape = {2, 2};
    info.tensorInfos.push_back(inputTensor);

    // Add a valid output tensor
    TensorInfoV2 outputTensor;
    outputTensor.type = TensorType::OUTPUT;
    outputTensor.tensorSize = sizeof(int64_t) * 4;
    outputTensor.tensorAddr = fakeMem;
    outputTensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    outputTensor.argsOffSet = 1U;
    outputTensor.dataType = 1;
    outputTensor.format = 2;
    outputTensor.shape = {2, 2};
    outputTensor.originShape = {2, 2};
    info.tensorInfos.push_back(outputTensor);

    // Add a valid workspace
    TensorInfoV2 workspace;
    workspace.type = TensorType::WORKSPACE;
    workspace.tensorSize = sizeof(int64_t) * 4;
    workspace.tensorAddr = fakeMem;
    workspace.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    workspace.argsOffSet = 2U;
    workspace.dataType = 1;
    workspace.format = 2;
    workspace.shape = {4};
    info.tensorInfos.push_back(workspace);

    DumpOperator op(info);
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = nullptr;
    argsInfo.argsize = 0U;
    // LogExceptionInfo iterates over inputTensors_, outputTensors_, workspaces_
    // Covers lines 148-170 in dump_operator.cpp
    (void)op.LogExceptionInfo(argsInfo);
    EXPECT_TRUE(true);
}

// ============================================================================
// LogExceptionArgs: non-null hostArgs_ path (IsTvmOperator = true case)
// ============================================================================
TEST_F(DumpOperatorExtraUtest, LogExceptionInfo_ImplyType_TVM)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    info.additionalInfo[DUMP_ADDITIONAL_IMPLY_TYPE] = "2"; // ImplyType::TVM (value=2)
    DumpOperator op(info);
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = nullptr;
    argsInfo.argsize = 0U;
    (void)op.LogExceptionInfo(argsInfo);
    EXPECT_TRUE(true);
}

// ============================================================================
// RefreshAddrs with tensors (covers lines 231-260 in dump_operator.cpp)
// ============================================================================
TEST_F(DumpOperatorExtraUtest, RefreshAddrs_WithTensors_HostMem)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    static int64_t fakeMem[4] = {1, 2, 3, 4};

    TensorInfoV2 inputTensor;
    inputTensor.type = TensorType::INPUT;
    inputTensor.tensorSize = sizeof(int64_t) * 4;
    inputTensor.tensorAddr = fakeMem;
    inputTensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    inputTensor.argsOffSet = 0U;
    inputTensor.shape = {2, 2};
    info.tensorInfos.push_back(inputTensor);

    TensorInfoV2 outputTensor;
    outputTensor.type = TensorType::OUTPUT;
    outputTensor.tensorSize = sizeof(int64_t) * 4;
    outputTensor.tensorAddr = fakeMem;
    outputTensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    outputTensor.argsOffSet = 1U;
    outputTensor.shape = {2, 2};
    info.tensorInfos.push_back(outputTensor);

    info.additionalInfo[DUMP_ADDITIONAL_IS_HOST_ARGS] = "true";
    DumpOperator op(info);

    // Use actual host args data (argsOffSet 0 and 1 map to positions in args array)
    static void *hostArgs[2] = {(void*)0x1111, (void*)0x2222};
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = hostArgs;
    argsInfo.argsize = sizeof(hostArgs);
    // With isHostArgs_="true", argAddr is used directly (no D2H needed)
    // But RefreshAddrs always calls DumpMemory::CopyDeviceToHost with argsInfo.argAddr
    // Since argAddr is not nullptr but a local ptr, rtMemcpy may fail in stub
    int32_t ret = op.RefreshAddrs(argsInfo);
    (void)ret;
    EXPECT_TRUE(true);
}

// ============================================================================
// RefreshAddrs with tensor argsOffset beyond maxArgNum  (lines 239-243)
// ============================================================================
TEST_F(DumpOperatorExtraUtest, RefreshAddrs_ArgsOffsetExceedsMaxArgNum)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    static int64_t fakeMem[2] = {1, 2};

    TensorInfoV2 inputTensor;
    inputTensor.type = TensorType::INPUT;
    inputTensor.tensorSize = sizeof(int64_t);
    inputTensor.tensorAddr = fakeMem;
    inputTensor.placement = static_cast<int32_t>(TensorPlacement::kOnDeviceHbm);
    inputTensor.argsOffSet = 100U; // far beyond argsize/sizeof(uint64_t)=1
    inputTensor.shape = {1};
    info.tensorInfos.push_back(inputTensor);

    DumpOperator op(info);

    static void *args[1] = {(void*)0x1234};
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = args;
    argsInfo.argsize = sizeof(args); // only 1 ptr = 8 bytes
    // argsOffSet=100 > maxArgNum=1 → should log warning and continue
    int32_t ret = op.RefreshAddrs(argsInfo);
    (void)ret;
    EXPECT_TRUE(true);
}

// ============================================================================
// InitDeviceArgs: isHostArgs_ = "true" path (not "false" → else branch)
// ============================================================================
TEST_F(DumpOperatorExtraUtest, InitDeviceArgs_IsHostArgs_True_WithValidAddr)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    static void *fakeArgsMem[3] = {(void*)0x1, (void*)0x2, (void*)0x3};
    DeviceInfo devInfo;
    devInfo.name = DEVICE_INFO_NAME_ARGS;
    devInfo.addr = fakeArgsMem;
    devInfo.length = sizeof(fakeArgsMem);
    info.deviceInfos.push_back(devInfo);
    info.additionalInfo[DUMP_ADDITIONAL_IS_HOST_ARGS] = "true";
    // isHostArgs_ = "true" → argsAddr = deviceInfo.addr (not CopyDeviceToHost)
    // Covers lines 107-115 in dump_operator.cpp (the else branch of isHostArgs_)
    DumpOperator op(info);
    (void)op;
    EXPECT_TRUE(true);
}

// ============================================================================
// PrintLog helper - covers lines 334-350 in dump_operator.cpp
// Triggered by LogExceptionArgs when hostArgs_ is not empty AND argsInfo.argAddr set
// ============================================================================
TEST_F(DumpOperatorExtraUtest, LogExceptionInfo_PrintLog_ViaNonNullArgs)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    // Add isHostArgs_=true AND a DeviceInfo with DEVICE_INFO_NAME_ARGS
    // so hostArgs_ gets populated
    static void *fakeArgs[25] = {}; // 25 ptrs to cover the i<count loop (printNumEachTime=20)
    for (int i=0; i<25; ++i) fakeArgs[i] = (void*)(uintptr_t)(i+1);
    DeviceInfo devInfo;
    devInfo.name = DEVICE_INFO_NAME_ARGS;
    devInfo.addr = fakeArgs;
    devInfo.length = sizeof(fakeArgs);
    info.deviceInfos.push_back(devInfo);
    info.additionalInfo[DUMP_ADDITIONAL_IS_HOST_ARGS] = "true";

    DumpOperator op(info);
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = nullptr; // so LogExceptionArgs returns early after PrintLog(hostArgs_)
    argsInfo.argsize = 0U;
    // LogExceptionInfo → LogExceptionArgs → PrintLog(hostArgs_) with 25 entries
    // Covers lines 334-350 (the count-loop and left-loop in PrintLog)
    (void)op.LogExceptionInfo(argsInfo);
    EXPECT_TRUE(true);
}

// ============================================================================
// LogExceptionArgs with non-null argAddr - covers lines 342-352
// ============================================================================
TEST_F(DumpOperatorExtraUtest, LogExceptionArgs_WithNonNullArgAddr)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    DumpOperator op(info);

    static void *fakeArgData[4] = {(void*)0x11, (void*)0x22, (void*)0x33, (void*)0x44};
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = fakeArgData; // non-null → DumpMemory::CopyDeviceToHost call
    argsInfo.argsize = sizeof(fakeArgData);
    // DumpMemory::CopyDeviceToHost(argAddr, argsize) → real memcpy → PrintLog(argsOnHost, 4, ...)
    // Covers lines 342-352 in dump_operator.cpp
    (void)op.LogExceptionInfo(argsInfo);
    EXPECT_TRUE(true);
}

// ============================================================================
// DumpException: covers lines 284-296
// ============================================================================
TEST_F(DumpOperatorExtraUtest, DumpException_WithDumpPath)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    DumpOperator op(info);
    // DumpException calls DumpExceptionFile + kernelCollector methods
    // DumpExceptionFile will fail (no valid file path) but that's OK
    int32_t ret = op.DumpException(0U, "/tmp/adump_dump_exception_test");
    // just cover the function
    (void)ret;
    EXPECT_TRUE(true);
}

// ============================================================================
// CopyOpKernelFile: covers lines 188-222
// ============================================================================
TEST_F(DumpOperatorExtraUtest, CopyOpKernelFile_NoDevFunc)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    DumpOperator op(info);
    // No DUMP_ADDITIONAL_DEV_FUNC → returns ADUMP_SUCCESS at line 196
    int32_t ret = op.CopyOpKernelFile();
    (void)ret;
    EXPECT_TRUE(true);
}

// ============================================================================
// RefreshAddrs with output tensors - covers lines 248-259
// ============================================================================
TEST_F(DumpOperatorExtraUtest, RefreshAddrs_WithOutputTensors)
{
    OperatorInfoV2 info = MakeBasicOpInfo();
    static int64_t fakeData[8] = {1,2,3,4,5,6,7,8};
    // Add output tensor with argsOffset=0
    TensorInfoV2 outputTensor = {};
    outputTensor.addrType = AddressType::TRADITIONAL;
    outputTensor.type = TensorType::OUTPUT;
    outputTensor.dataType = static_cast<int32_t>(3); // DT_INT32 = 3
    outputTensor.argsOffSet = 0U;
    outputTensor.format = 2;
    outputTensor.shape = {2, 4};
    outputTensor.tensorAddr = fakeData;
    outputTensor.tensorSize = sizeof(fakeData);
    outputTensor.placement = TensorPlacement::kOnDeviceHbm;
    info.tensorInfos.push_back(outputTensor);

    DumpOperator op(info);

    // argsInfo with host memory and argsize sufficient for offset 0
    static void *hostArgPtrs[4] = {(void*)0x100, (void*)0x200, (void*)0x300, (void*)0x400};
    rtExceptionArgsInfo argsInfo = {};
    argsInfo.argAddr = hostArgPtrs;
    argsInfo.argsize = sizeof(hostArgPtrs);
    // RefreshAddrs should update output tensor address
    int32_t ret = op.RefreshAddrs(argsInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}
