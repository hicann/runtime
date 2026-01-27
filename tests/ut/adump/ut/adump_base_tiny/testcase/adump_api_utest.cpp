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
#include "adump_pub.h"
#include "adump_api.h"
#include "sys_utils.h"
#include "dump_manager.h"
#include "dump_printf.h"

using namespace Adx;
#define JSON_BASE ADUMP_BASE_DIR "ut/adump_base/stub/data/json/"

// test adump_api.cpp
// test dump_manager.cpp
class TinyAdumpApiUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }

    void EnableOperatorDump();
};

void TinyAdumpApiUtest::EnableOperatorDump()
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
}

TEST_F(TinyAdumpApiUtest, Test_EnableOperatorDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR), false);
    uint64_t dumpSwitch = 0;
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR, dumpSwitch), false);
    EXPECT_EQ(dumpSwitch, dumpConf.dumpSwitch);
}

TEST_F(TinyAdumpApiUtest, Test_EnableOperatorOverflowDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OP_OVERFLOW), false);
}

TEST_F(TinyAdumpApiUtest, Test_DisableOperatorDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "";
    dumpConf.dumpStatus = "off";
    dumpConf.dumpMode = "";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR), false);
}

TEST_F(TinyAdumpApiUtest, Test_DisableOperatorOverflowDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "";
    dumpConf.dumpStatus = "off";
    dumpConf.dumpMode = "";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OP_OVERFLOW), false);
}

TEST_F(TinyAdumpApiUtest, Test_AdumpDumpTensor)
{
    EnableOperatorDump();

    auto inputTensor =
        gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();
    auto outputTensor =
        gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();

    TensorInfo inputTensorInfo = BuildTensorInfo(inputTensor.GetTensor(), TensorType::INPUT);
    TensorInfo outputTensorInfo = BuildTensorInfo(outputTensor.GetTensor(), TensorType::OUTPUT);

    std::vector<TensorInfo> tensorInfos = {inputTensorInfo, outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_SUCCESS);
}

TEST_F(TinyAdumpApiUtest, Test_AdumpDumpTensor_With_TensorNotOnDevice)
{
    EnableOperatorDump();

    auto inputTensor = gert::TensorBuilder().Placement(gert::kFollowing).DataType(ge::DT_INT32).Build();
    auto outputTensor = gert::TensorBuilder().Placement(gert::kOnHost).DataType(ge::DT_INT32).Build();

    TensorInfo inputTensorInfo = BuildTensorInfo(inputTensor.GetTensor(), TensorType::INPUT);
    TensorInfo outputTensorInfo = BuildTensorInfo(outputTensor.GetTensor(), TensorType::OUTPUT);

    std::vector<TensorInfo> tensorInfos = {inputTensorInfo, outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_SUCCESS);
}

TEST_F(TinyAdumpApiUtest, Test_AdumpDumpTensor_with_DumpStatus_off)
{
    DumpConfig dumpConf;
    dumpConf.dumpStatus = "off";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", {}, stream), ADUMP_SUCCESS);
}

////////////// test exception dump //////////////////////
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

static void ExceptionOccur(uint32_t deviceId, uint32_t taskId, uint32_t streamId, uint32_t retCode)
{
    rtExceptionInfo exception = BuildRtException(deviceId, taskId, streamId, retCode);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    exception.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = 0;
    char hostKernel[] = "host kernel bin file stub";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exception.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    RuntimeExceptionCallback::Instance().Invoke(&exception);
}

TEST_F(TinyAdumpApiUtest, Test_ExceptionDump_Async)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_Async");

    // enable exception dump
    MOCKER(rtRegTaskFailCallbackByModule).stubs().will(invoke(rtRegTaskFailCallbackByModuleStub));
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
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

    OperatorInfo opInfo = OperatorInfoBuilder(opType, opName)
                              .Task(deviceId, taskId, streamId)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    std::thread t(ExceptionOccur, deviceId, taskId, streamId, 0);
    t.join();

    // 期望dump成功
    std::string expectDumpFilePath = ExpectedDumpFilePath(ws.Root(), deviceId, opType, opName, taskId, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), true);
}

TEST_F(TinyAdumpApiUtest, Test_ExceptionDump_Async_OverFlow)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_Async_OverFlow");

    // enable exception dump
    MOCKER(rtRegTaskFailCallbackByModule).stubs().will(invoke(rtRegTaskFailCallbackByModuleStub));
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::EXCEPTION), true);

    uint32_t deviceId = 1;
    uint32_t taskId = 2;
    uint32_t streamId = 3;
    uint32_t retModeOverflow = 207003;
    std::string opType = "CONV2D";
    std::string opName = "TestName";

    auto input = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();
    auto output = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 2}).Build();

    OperatorInfo opInfo = OperatorInfoBuilder(opType, opName)
                              .Task(deviceId, taskId, streamId)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    std::thread t(ExceptionOccur, deviceId, taskId, streamId, retModeOverflow);
    t.join();

    // 溢出场景不走exception dump流程，不落盘文件
    std::string expectDumpFilePath = ExpectedDumpFilePath(ws.Root(), deviceId, opType, opName, taskId, stubNowTime);
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

TEST_F(TinyAdumpApiUtest, Test_ExceptionDump_Async_SetDevice)
{
    Tools::CaseWorkspace ws("Test_ExceptionDump_Async_SetDevice");

    MOCKER(rtCtxGetCurrent).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(rtCtxCreate).stubs().will(returnValue(1)).then(returnValue(RT_ERROR_NONE));

    // enable exception dump
    MOCKER(rtRegTaskFailCallbackByModule).stubs().will(invoke(rtRegTaskFailCallbackByModuleStub));
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
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

    OperatorInfo opInfo = OperatorInfoBuilder(opType, opName)
                              .Task(deviceId, taskId, streamId)
                              .TensorInfo(input.GetTensor(), TensorType::INPUT)
                              .TensorInfo(output.GetTensor(), TensorType::OUTPUT)
                              .AdditionInfo(DUMP_ADDITIONAL_IMPLY_TYPE,
                                            std::to_string(static_cast<int32_t>(domi::ImplyType::TVM)))  // must be tvm
                              .AdditionInfo(DUMP_ADDITIONAL_TILING_DATA, "")
                              .Build();

    EXPECT_EQ(AdumpAddExceptionOperatorInfo(opInfo), ADUMP_SUCCESS);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    std::thread t(ExceptionOccur, deviceId, taskId, streamId, 0);
    t.join();

    // 期望dump成功
    std::string expectDumpFilePath = ExpectedDumpFilePath(ws.Root(), deviceId, opType, opName, taskId, stubNowTime);
    EXPECT_EQ(IsFileExist(expectDumpFilePath), true);
}

uint64_t mmGetClockMonotonicTime()
{
    mmTimespec now = mmGetTickCount();
    return (static_cast<uint64_t>(now.tv_sec) * 1000000000) + static_cast<uint64_t>(now.tv_nsec);
}

TEST_F(TinyAdumpApiUtest, Test_ArgsException_AdumpGetDFXInfoAddr)
{
    constexpr uint64_t MAGIC_NUM = 0xA5A5A5A500000000;
    constexpr uint64_t FLIP_NUM_MASK = 0b01111111;
    constexpr uint16_t FLIP_NUM_SHIFT_BITS = 24;
    constexpr uint16_t RESERVE_SPACE = 2;
    constexpr uint64_t STATIC_BUFFER_ID = 0x080000000;
    std::atomic<uint64_t> dynamicWriteIdx{0};
    std::atomic<uint64_t> staticWriteIdx{0};

    uint64_t dynamicIndex = 0;
    uint64_t staticIndex = 0;
    DumpConfig DumpConf;
    DumpConf.dumpPath = "";
    DumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, DumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), true);

    for (int32_t i = 0; i < 6000; i++) {
        uint32_t needSpace = (i % DFX_MAX_TENSOR_NUM) + 1;
        uint64_t *dynamicAddr = static_cast<uint64_t *>(AdumpGetDFXInfoAddrForDynamic(needSpace, dynamicIndex));
        uint64_t *staticAddr = static_cast<uint64_t *>(AdumpGetDFXInfoAddrForStatic(needSpace, staticIndex));
        uint64_t writeCursor = dynamicWriteIdx.fetch_add(needSpace + 2);
        uint64_t flipNum = writeCursor / DYNAMIC_RING_CHUNK_SIZE;
        uint64_t offset = writeCursor % DYNAMIC_RING_CHUNK_SIZE;
        uint64_t atomicIndex = MAGIC_NUM | ((flipNum & FLIP_NUM_MASK) << FLIP_NUM_SHIFT_BITS) | offset;
        EXPECT_EQ(dynamicIndex, atomicIndex);
        EXPECT_EQ(dynamicIndex, *(dynamicAddr - 1));
        uint32_t space = *(dynamicAddr - 2) & 0x0FFFFFFFF;
        EXPECT_EQ(space, needSpace);

        writeCursor = staticWriteIdx.fetch_add(needSpace + 2);
        flipNum = writeCursor / STATIC_RING_CHUNK_SIZE;
        offset = writeCursor % STATIC_RING_CHUNK_SIZE;
        atomicIndex = MAGIC_NUM | STATIC_BUFFER_ID | ((flipNum & FLIP_NUM_MASK) << FLIP_NUM_SHIFT_BITS) | offset;
        EXPECT_EQ(staticIndex, atomicIndex);
        EXPECT_EQ(staticIndex, *(staticAddr - 1));
        space = *(staticAddr - 2) & 0x0FFFFFFFF;
        EXPECT_EQ(space, needSpace);
    }

    auto addr1 = AdumpGetDFXInfoAddrForDynamic(1000, dynamicIndex);
    auto addr2 = AdumpGetDFXInfoAddrForDynamic(300, dynamicIndex);
    auto addr3 = AdumpGetDFXInfoAddrForDynamic(50, dynamicIndex);
    EXPECT_EQ(1002, (reinterpret_cast<uint64_t>(addr2) - reinterpret_cast<uint64_t>(addr1)) / sizeof(uint64_t));
    EXPECT_EQ(302, (reinterpret_cast<uint64_t>(addr3) - reinterpret_cast<uint64_t>(addr2)) / sizeof(uint64_t));

    auto addr4 = AdumpGetDFXInfoAddrForStatic(1000, dynamicIndex);
    auto addr5 = AdumpGetDFXInfoAddrForStatic(300, dynamicIndex);
    auto addr6 = AdumpGetDFXInfoAddrForStatic(50, dynamicIndex);
    EXPECT_EQ(1002, (reinterpret_cast<uint64_t>(addr5) - reinterpret_cast<uint64_t>(addr4)) / sizeof(uint64_t));
    EXPECT_EQ(302, (reinterpret_cast<uint64_t>(addr6) - reinterpret_cast<uint64_t>(addr5)) / sizeof(uint64_t));

    uint16_t retryTimes = 50000;
    uint64_t atomicIndex = 0;
    auto t1 = mmGetClockMonotonicTime();
    for (uint16_t i = 0; i < retryTimes; i++) {
        AdumpGetDFXInfoAddrForDynamic(1000, atomicIndex);
    }

    auto t2 = mmGetClockMonotonicTime();
    for (uint16_t i = 0; i < retryTimes; i++) {
        AdumpGetDFXInfoAddrForStatic(1000, atomicIndex);
    }
    auto t3 = mmGetClockMonotonicTime();

    DumpConf.dumpPath = "";
    DumpConf.dumpStatus = "off";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, DumpConf), ADUMP_SUCCESS);
}

TEST_F(TinyAdumpApiUtest, Test_ArgsException_GetSizeInfoAddr)
{
    Tools::CaseWorkspace ws("Test_ArgsException_GetSizeInfoAddr");
    uint32_t index = 0;
    // 默认关闭测试
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), false);
    EXPECT_EQ(nullptr, AdumpGetSizeInfoAddr(1001, index));

    // 测试开启
    DumpConfig DumpConf;
    DumpConf.dumpPath = "";
    DumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, DumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), true);
    auto t1 = mmGetClockMonotonicTime();
    for (int16_t i = 0; i < 5000; i++) {
        AdumpGetSizeInfoAddr(1, index);
    }

    auto t2 = mmGetClockMonotonicTime();
    for (int16_t i = 0; i < 5000; i++) {
        AdumpGetSizeInfoAddr(1000, index);
    }
    auto t3 = mmGetClockMonotonicTime();
    // 测试关闭
    DumpConf;
    DumpConf.dumpPath = "";
    DumpConf.dumpStatus = "off";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, DumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), false);
}

TEST_F(TinyAdumpApiUtest, Test_ArgsException_GetSizeInfoAddr_With_Right_Addr)
{
    uint32_t index = 0;
    DumpConfig DumpConf;
    DumpConf.dumpPath = "";
    DumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, DumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), true);

    for (int16_t i = 0; i < 5000; i++) {
        AdumpGetSizeInfoAddr(1000, index);
        uint32_t atomicIndex = 0x2000;
        EXPECT_EQ(index, atomicIndex + 10000 + i);
    }

    auto addr1 = AdumpGetSizeInfoAddr(1000, index);
    auto addr2 = AdumpGetSizeInfoAddr(300, index);
    auto addr3 = AdumpGetSizeInfoAddr(50, index);
    EXPECT_EQ(1000, (reinterpret_cast<uint64_t>(addr2) - reinterpret_cast<uint64_t>(addr1)) / sizeof(uint64_t));
    EXPECT_EQ(300, (reinterpret_cast<uint64_t>(addr3) - reinterpret_cast<uint64_t>(addr2)) / sizeof(uint64_t));
}

TEST_F(TinyAdumpApiUtest, Test_GetEnv_Exception)
{
    const char* env = "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    "1111111111";
    EXPECT_EQ(SysUtils::HandleEnv(env), "");
}

TEST_F(TinyAdumpApiUtest, Test_AdumpSetDump)
{
    int32_t ret = AdumpSetDump(nullptr);
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump("");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/bad_path.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/only_path.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_stats.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyAdumpApiUtest, Test_AdumpUnSetDump)
{
    int32_t ret = AdumpSetDump(JSON_BASE "datadump/dump_data_stats.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpUnSetDump();
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_stats.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpUnSetDump();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyAdumpApiUtest, Test_AdumpGetDumpSwitch)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 0U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 0U);

    dumpConf.dumpStatus = "off";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 0U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 0U);

    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 0U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 0U);

    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 1U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 0U);

    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 1U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 0U);
}

TEST_F(TinyAdumpApiUtest, Test_AdumpPrintWorkSpace)
{
    void *workSpaceAddr = nullptr;
    size_t dumpWorkSpaceSize = 0;
    void *stream = nullptr; 
    char *opType = "op";
    std::vector<MsprofAicTimeStampInfo> timeStampInfo;
    AdumpPrintConfig config;
    AdumpPrintWorkSpace(workSpaceAddr, dumpWorkSpaceSize, stream, opType);
    AdumpPrintWorkSpace(workSpaceAddr, dumpWorkSpaceSize, stream, opType, false);
    MOCKER_CPP(&AdxPrintTimeStamp).stubs();
    AdumpPrintAndGetTimeStampInfo(workSpaceAddr, dumpWorkSpaceSize, stream, opType, timeStampInfo);
    MOCKER_CPP(&AdxPrintSetConfig).stubs();
    AdumpPrintSetConfig(config);
}
