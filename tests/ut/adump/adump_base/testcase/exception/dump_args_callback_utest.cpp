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
#include <cstring>
#include "mockcpp/mockcpp.hpp"
#include "case_workspace.h"
#include "dump_args_callback.h"
#include "dump_manager.h"
#include "dump_exception_stub.h"
#include "runtime/rt.h"
#include "adump_pub.h"
#include "dump_file.h"
#include "kernel_info_collector.h"

using namespace Adx;

class DumpArgsCallbackUtest : public testing::Test {
protected:
    void SetUp() {}
    void TearDown() {
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
    
    void InitExceptionInfo(rtExceptionInfo &exception) {
        exception.deviceid = 1;
        exception.streamid = 1;
        exception.taskid = 1;
    }
    
    void InitTensorInfo(TensorInfo &tensor, TensorType type, void *addr, size_t size) {
        tensor = {};
        tensor.type = type;
        tensor.tensorAddr = reinterpret_cast<int64_t*>(addr);
        tensor.tensorSize = size;
    }
    
    void SetKernelName(ExceptionDumpInfo &info, const std::string &name) {
        SafeStrCopy(info.kernelName, name.c_str(), MAX_KERNELNAME_LEN);
    }
    
    void SetDisplayName(ExceptionDumpInfo &info, const std::string &name) {
        SafeStrCopy(info.kernelDisplayName, name.c_str(), MAX_KERNELNAME_LEN);
    }
};

TEST_F(DumpArgsCallbackUtest, Test_DumpDfxArgs_InvalidArgs)
{
    Tools::CaseWorkspace ws("Test_DumpDfxArgs_InvalidArgs");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);

    ExceptionDumpInfo info = {0};
    SetKernelName(info, "test_kernel");
    
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpDfxArgs(), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpDfxArgs_WithStub)
{
    Tools::CaseWorkspace ws("Test_DumpDfxArgs_WithStub");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);

    char data[] = "test";
    uint64_t args[] = {reinterpret_cast<uint64_t>(data)};
    ExceptionDumpInfo info = {0};
    info.argAddr = args;
    info.argSize = sizeof(args);
    info.bin = (rtBinHandle)0x5f;
    SetKernelName(info, "test_kernel");
    
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpDfxArgs(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpExtraTensors_Basic)
{
    Tools::CaseWorkspace ws("Test_DumpExtraTensors_Basic");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    SetKernelName(info, "test_kernel");

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpExtraTensors(), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpExtraTensors_ExceedMax)
{
    Tools::CaseWorkspace ws("Test_DumpExtraTensors_ExceedMax");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    info.extraTensorNum = EXCEPTION_DUMP_MAX_TENSOR_NUM + 1;
    SetKernelName(info, "test_kernel");
    
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpExtraTensors(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpExtraTensors_TensorTypes)
{
    Tools::CaseWorkspace ws("Test_DumpExtraTensors_TensorTypes");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    
    char data[] = "test";
    TensorInfo tensors[3];
    InitTensorInfo(tensors[0], TensorType::INPUT, data, sizeof(data));
    InitTensorInfo(tensors[1], TensorType::OUTPUT, data, sizeof(data));
    InitTensorInfo(tensors[2], TensorType::WORKSPACE, data, sizeof(data));
    
    ExceptionDumpInfo info = {0};
    info.extraTensorNum = 3;
    info.extraTensor[0] = tensors[0];
    info.extraTensor[1] = tensors[1];
    info.extraTensor[2] = tensors[2];
    SetKernelName(info, "test_kernel");

    MOCKER(&DumpFile::SetInputTensors).stubs();
    MOCKER(&DumpFile::SetOutputTensors).stubs();
    MOCKER(&DumpFile::SetWorkspaces).stubs();
    
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpExtraTensors(), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_Dump_Basic)
{
    Tools::CaseWorkspace ws("Test_Dump_Basic");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    SetKernelName(info, "test_kernel");

    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER(mmChmod).stubs().will(returnValue(0));
    
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.Dump(), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_Dump_Failed)
{
    Tools::CaseWorkspace ws("Test_Dump_Failed");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    SetKernelName(info, "test_kernel");

    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_FAILED));
    
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.Dump(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpKernelBin_Basic)
{
    Tools::CaseWorkspace ws("Test_DumpKernelBin_Basic");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    info.bin = nullptr;
    info.kernelName[0] = '\0';

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpKernelBin(), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpKernelBin_WithBin)
{
    Tools::CaseWorkspace ws("Test_DumpKernelBin_WithBin");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    info.bin = (rtBinHandle)0x5f;
    SetKernelName(info, "test_kernel");

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpKernelBin(), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_Constructor_WithDisplayName)
{
    Tools::CaseWorkspace ws("Test_Constructor_WithDisplayName");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    
    ExceptionDumpInfo info = {0};
    info.coreId = 0;
    info.coreType = 1;
    SetKernelName(info, "test");
    SetDisplayName(info, "display");

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.Dump(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_Constructor_EmptyDisplayName)
{
    Tools::CaseWorkspace ws("Test_Constructor_EmptyDisplayName");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    
    ExceptionDumpInfo info = {0};
    SetKernelName(info, "test");
    info.kernelDisplayName[0] = '\0';
    
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.Dump(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpExtraTensors_SkipNull)
{
    Tools::CaseWorkspace ws("Test_DumpExtraTensors_SkipNull");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    
    char data[] = "valid";
    TensorInfo validTensor = {};
    validTensor.type = TensorType::INPUT;
    validTensor.tensorAddr = reinterpret_cast<int64_t*>(data);
    validTensor.tensorSize = sizeof(data);
    
    TensorInfo nullTensor = {};
    
    ExceptionDumpInfo info = {0};
    info.extraTensorNum = 2;
    info.extraTensor[0] = nullTensor;
    info.extraTensor[1] = validTensor;
    SetKernelName(info, "test_kernel");

    MOCKER(&DumpFile::SetInputTensors).stubs();
    
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpExtraTensors(), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_FullWorkflow)
{
    Tools::CaseWorkspace ws("Test_FullWorkflow");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    
    ExceptionDumpInfo info = {0};
    info.coreId = 0;
    info.coreType = RT_CORE_TYPE_AIC;
    SetKernelName(info, "test_kernel");
    
    char tensorData[] = "tensor";
    TensorInfo inputTensor = {};
    inputTensor.type = TensorType::INPUT;
    inputTensor.tensorAddr = reinterpret_cast<int64_t*>(tensorData);
    inputTensor.tensorSize = sizeof(tensorData);
    info.extraTensorNum = 1;
    info.extraTensor[0] = inputTensor;

    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER(&DumpFile::SetInputTensors).stubs();
    MOCKER(mmChmod).stubs().will(returnValue(0));
    
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpExtraTensors(), ADUMP_SUCCESS);
    EXPECT_EQ(callback.DumpKernelBin(), ADUMP_SUCCESS);
    EXPECT_EQ(callback.Dump(), ADUMP_SUCCESS);
}