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
#include <vector>
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "case_workspace.h"
#include "dump_args_callback.h"
#include "dfx_args_parser.h"
#include "dump_manager.h"
#include "dump_exception_stub.h"
#include "runtime/rt.h"
#include "adump_pub.h"
#include "dump_file.h"
#include "kernel_info_collector.h"
#include "kernel_symbol_locator.h"
#include "exception_info_common.h"

using namespace Adx;

namespace {
void AppendBigEndian16(std::vector<uint8_t> &data, uint16_t value)
{
    constexpr uint32_t byteBits = 8U;
    data.push_back(static_cast<uint8_t>(value >> byteBits));
    data.push_back(static_cast<uint8_t>(value));
}

void AppendBigEndian64(std::vector<uint8_t> &data, uint64_t value)
{
    constexpr uint32_t byteBits = 8U;
    for (int32_t i = 7; i >= 0; --i) {
        data.push_back(static_cast<uint8_t>(value >> (static_cast<uint32_t>(i) * byteBits)));
    }
}

std::vector<uint8_t> BuildTilingDfxInfo(uint64_t tilingDataSize)
{
    std::vector<uint8_t> dfxInfo;
    const uint64_t tilingType = static_cast<uint16_t>(DfxTensorType::TILING_DATA) |
        (static_cast<uint64_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);

    AppendBigEndian16(dfxInfo, TYPE_L0_EXCEPTION_DFX_ARGS_INFO);
    AppendBigEndian16(dfxInfo, 2U);
    AppendBigEndian64(dfxInfo, tilingType);
    AppendBigEndian64(dfxInfo, tilingDataSize);
    return dfxInfo;
}

rtError_t RtBinaryGetFunctionByNameFailed(rtBinHandle binHandle, const char *kernelName, rtFuncHandle *funcHandle)
{
    (void)binHandle;
    (void)kernelName;
    (void)funcHandle;
    return static_cast<rtError_t>(-1);
}

rtError_t RtFunctionGetDfxMetaInfoSizeFailed(rtFuncHandle funcHandle, rtFunctionMetaType type, size_t *size)
{
    (void)funcHandle;
    (void)type;
    if (size != nullptr) {
        *size = 0;
    }
    return static_cast<rtError_t>(-1);
}

rtError_t RtFunctionGetDfxMetaInfoSizeTooLarge(rtFuncHandle funcHandle, rtFunctionMetaType type, size_t *size)
{
    (void)funcHandle;
    (void)type;
    if (size != nullptr) {
        *size = static_cast<size_t>(UINT16_MAX) + 1U;
    }
    return RT_ERROR_NONE;
}

rtError_t RtFunctionGetDfxMetaInfoFailed(const rtFuncHandle funcHandle, const rtFunctionMetaType type,
    void *data, const uint32_t length)
{
    (void)funcHandle;
    (void)type;
    (void)data;
    (void)length;
    return static_cast<rtError_t>(-1);
}

rtError_t RtFunctionGetIsTikMetaInfoSizeFailed(rtFuncHandle funcHandle, rtFunctionMetaType type, size_t *size)
{
    (void)funcHandle;
    if (size == nullptr) {
        return static_cast<rtError_t>(-1);
    }
    if (type == RT_FUNCTION_TYPE_DFX_TYPE) {
        *size = sizeof(uint64_t);
        return RT_ERROR_NONE;
    }
    *size = sizeof(uint32_t) - 1U;
    return RT_ERROR_NONE;
}

rtError_t RtFunctionGetIsTikMetaInfoFailed(const rtFuncHandle funcHandle, const rtFunctionMetaType type,
    void *data, const uint32_t length)
{
    (void)funcHandle;
    if (data == nullptr) {
        return static_cast<rtError_t>(-1);
    }
    if (type == RT_FUNCTION_TYPE_DFX_TYPE) {
        (void)memset_s(data, length, 0, length);
        return RT_ERROR_NONE;
    }
    return static_cast<rtError_t>(-1);
}
}

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

    void InitKernelBinInfo(ExceptionDumpInfo &info) {
        info = {0};
        info.bin = (rtBinHandle)0x5f;
        SetKernelName(info, "test_kernel");
    }

    void InitDfxArgsDumpInfo(ExceptionDumpInfo &info, uint64_t *args, size_t argSize) {
        InitKernelBinInfo(info);
        info.argAddr = args;
        info.argSize = argSize;
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

TEST_F(DumpArgsCallbackUtest, Test_InitTensorModeInfo_TilingShapeMagicInvalid)
{
    std::vector<uint8_t> tilingData(sizeof(uint64_t), 0U);
    uint64_t args[] = {reinterpret_cast<uint64_t>(tilingData.data())};
    std::vector<uint8_t> dfxInfo = BuildTilingDfxInfo(tilingData.size());
    uint64_t dynamicChunk = 0U;
    uint64_t *dynamicChunkBak = g_dynamicChunk;
    g_dynamicChunk = &dynamicChunk;

    DfxArgsParser parser;
    int32_t ret = parser.Init(args, sizeof(args), dfxInfo.data(), static_cast<uint16_t>(dfxInfo.size()));
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(parser.InitTensorModeInfo(), ADUMP_FAILED);

    g_dynamicChunk = dynamicChunkBak;
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

TEST_F(DumpArgsCallbackUtest, Test_DumpKernelErrorSymbols_Basic)
{
    Tools::CaseWorkspace ws("Test_DumpKernelErrorSymbols_Basic");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};

    DumpArgsCallback callback(exception, info, ws.Root());
    ErrorLocation location;
    EXPECT_EQ(callback.DumpKernelErrorSymbols(location), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpKernelErrorSymbols_InitFailed)
{
    Tools::CaseWorkspace ws("Test_DumpKernelErrorSymbols_InitFailed");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    InitKernelBinInfo(info);

    MOCKER(&KernelSymbolLocator::InitFromBinHandle).stubs().will(returnValue(ADUMP_FAILED));

    DumpArgsCallback callback(exception, info, ws.Root());
    ErrorLocation location;
    EXPECT_EQ(callback.DumpKernelErrorSymbols(location), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpKernelErrorSymbols_GetRegInfoFailed)
{
    Tools::CaseWorkspace ws("Test_DumpKernelErrorSymbols_GetRegInfoFailed");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    InitKernelBinInfo(info);

    MOCKER(&KernelSymbolLocator::InitFromBinHandle).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER_CPP(&ExceptionInfoCommon::GetExceptionRegInfo).stubs().will(returnValue(ADUMP_FAILED));

    DumpArgsCallback callback(exception, info, ws.Root());
    ErrorLocation location;
    EXPECT_EQ(callback.DumpKernelErrorSymbols(location), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpKernelErrorSymbols_LocateFailed)
{
    Tools::CaseWorkspace ws("Test_DumpKernelErrorSymbols_LocateFailed");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    InitKernelBinInfo(info);

    MOCKER(&KernelSymbolLocator::InitFromBinHandle).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER_CPP(&ExceptionInfoCommon::GetExceptionRegInfo).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER(&KernelSymbolLocator::LocateErrorSymbolsForCore).stubs().will(returnValue(ADUMP_FAILED));

    DumpArgsCallback callback(exception, info, ws.Root());
    ErrorLocation location;
    EXPECT_EQ(callback.DumpKernelErrorSymbols(location), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpKernelErrorSymbols_LocateSuccess)
{
    Tools::CaseWorkspace ws("Test_DumpKernelErrorSymbols_LocateSuccess");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);
    ExceptionDumpInfo info = {0};
    InitKernelBinInfo(info);

    MOCKER(&KernelSymbolLocator::InitFromBinHandle).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER_CPP(&ExceptionInfoCommon::GetExceptionRegInfo).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER(&KernelSymbolLocator::LocateErrorSymbolsForCore).stubs().will(returnValue(ADUMP_SUCCESS));

    DumpArgsCallback callback(exception, info, ws.Root());
    ErrorLocation location;
    EXPECT_EQ(callback.DumpKernelErrorSymbols(location), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpDfxArgs_QueryDfxInfoGetFunctionFailed)
{
    Tools::CaseWorkspace ws("Test_DumpDfxArgs_QueryDfxInfoGetFunctionFailed");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);

    uint64_t args[] = {0U};
    ExceptionDumpInfo info = {0};
    InitDfxArgsDumpInfo(info, args, sizeof(args));

    MOCKER(rtBinaryGetFunctionByName).stubs().will(invoke(RtBinaryGetFunctionByNameFailed));

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpDfxArgs(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpDfxArgs_QueryDfxInfoSizeFailed)
{
    Tools::CaseWorkspace ws("Test_DumpDfxArgs_QueryDfxInfoSizeFailed");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);

    uint64_t args[] = {0U};
    ExceptionDumpInfo info = {0};
    InitDfxArgsDumpInfo(info, args, sizeof(args));

    MOCKER(rtFunctionGetMetaInfoSize).stubs().will(invoke(RtFunctionGetDfxMetaInfoSizeFailed));

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpDfxArgs(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpDfxArgs_QueryDfxInfoSizeTooLarge)
{
    Tools::CaseWorkspace ws("Test_DumpDfxArgs_QueryDfxInfoSizeTooLarge");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);

    uint64_t args[] = {0U};
    ExceptionDumpInfo info = {0};
    InitDfxArgsDumpInfo(info, args, sizeof(args));

    MOCKER(rtFunctionGetMetaInfoSize).stubs().will(invoke(RtFunctionGetDfxMetaInfoSizeTooLarge));

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpDfxArgs(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpDfxArgs_QueryDfxInfoMetaFailed)
{
    Tools::CaseWorkspace ws("Test_DumpDfxArgs_QueryDfxInfoMetaFailed");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);

    uint64_t args[] = {0U};
    ExceptionDumpInfo info = {0};
    InitDfxArgsDumpInfo(info, args, sizeof(args));

    MOCKER(rtFunctionGetMetaInfo).stubs().will(invoke(RtFunctionGetDfxMetaInfoFailed));

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpDfxArgs(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpDfxArgs_QueryDfxIsTikSizeFailed)
{
    Tools::CaseWorkspace ws("Test_DumpDfxArgs_QueryDfxIsTikSizeFailed");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);

    uint64_t args[] = {0U};
    ExceptionDumpInfo info = {0};
    InitDfxArgsDumpInfo(info, args, sizeof(args));

    MOCKER(rtFunctionGetMetaInfoSize).stubs().will(invoke(RtFunctionGetIsTikMetaInfoSizeFailed));

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpDfxArgs(), ADUMP_FAILED);
}

TEST_F(DumpArgsCallbackUtest, Test_DumpDfxArgs_QueryDfxIsTikMetaFailed)
{
    Tools::CaseWorkspace ws("Test_DumpDfxArgs_QueryDfxIsTikMetaFailed");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);

    uint64_t args[] = {0U};
    ExceptionDumpInfo info = {0};
    InitDfxArgsDumpInfo(info, args, sizeof(args));

    MOCKER(rtFunctionGetMetaInfo).stubs().will(invoke(RtFunctionGetIsTikMetaInfoFailed));

    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.DumpDfxArgs(), ADUMP_FAILED);
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

    // 无 dfx args / extra tensor / 日志时，Dump 应跳过并返回成功，且不生成空文件
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.Dump(), ADUMP_SUCCESS);
}

TEST_F(DumpArgsCallbackUtest, Test_Constructor_EmptyDisplayName)
{
    Tools::CaseWorkspace ws("Test_Constructor_EmptyDisplayName");
    rtExceptionInfo exception = {0};
    InitExceptionInfo(exception);

    ExceptionDumpInfo info = {0};
    SetKernelName(info, "test");
    info.kernelDisplayName[0] = '\0';

    // 无数据无日志的空 dump 跳过，返回成功且不落盘
    DumpArgsCallback callback(exception, info, ws.Root());
    EXPECT_EQ(callback.Dump(), ADUMP_SUCCESS);
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
