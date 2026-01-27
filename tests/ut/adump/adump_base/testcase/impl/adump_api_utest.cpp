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
#include <fstream>
#include <cassert>
#include <filesystem>
#include "case_workspace.h"
#include "dump_file_checker.h"
#include "acl_op.h"
#include "adump_pub.h"
#include "adump_api.h"
#include "sys_utils.h"
#include "dump_manager.h"
#include "acl/acl_base.h"
#include "acl/acl_dump.h"
#include "sys_utils.h"
#include "common/file.h"
#include "common/path.h"
#include "utils.h"

using namespace Adx;
#define JSON_BASE ADUMP_BASE_DIR "stub/data/json/"

// test adump_api.cpp
// test dump_manager.cpp
class AdumpApiUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }

    void EnableOperatorDump();
};

void AdumpApiUtest::EnableOperatorDump()
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
}

TEST_F(AdumpApiUtest, Test_EnableOperatorDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR), true);
    uint64_t dumpSwitch = 0;
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR, dumpSwitch), true);
    EXPECT_EQ(dumpSwitch, dumpConf.dumpSwitch);
}

TEST_F(AdumpApiUtest, Test_EnableOperatorDumpDsmiFail)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    MOCKER(rtGetDeviceIDs).stubs().will(returnValue((rtError_t)1));
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR), true);
    uint64_t dumpSwitch = 0;
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR, dumpSwitch), true);
    EXPECT_EQ(dumpSwitch, dumpConf.dumpSwitch);
}

TEST_F(AdumpApiUtest, Test_EnableOperatorDumpStats)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    dumpConf.dumpData = "stats";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR), true);
}

TEST_F(AdumpApiUtest, Test_EnableOperatorOverflowDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OP_OVERFLOW), true);
}

TEST_F(AdumpApiUtest, Test_DisableOperatorDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "";
    dumpConf.dumpStatus = "off";
    dumpConf.dumpMode = "";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR), false);
}

TEST_F(AdumpApiUtest, Test_DisableOperatorOverflowDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "";
    dumpConf.dumpStatus = "off";
    dumpConf.dumpMode = "";
    dumpConf.dumpSwitch = 0;
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OP_OVERFLOW), false);
}

TEST_F(AdumpApiUtest, Test_SetOperatorDumpConf_fail)
{
    DumpConfig invalidDumpConf;

    // invalid dump status
    invalidDumpConf.dumpPath = "/path/to/dump/";
    invalidDumpConf.dumpStatus = "invalid";
    invalidDumpConf.dumpMode = "all";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, invalidDumpConf), ADUMP_FAILED);

    // invalid dump mode
    invalidDumpConf.dumpPath = "/path/to/dump/";
    invalidDumpConf.dumpStatus = "on";
    invalidDumpConf.dumpMode = "invalid";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, invalidDumpConf), ADUMP_FAILED);

    // invalid dump path
    invalidDumpConf.dumpPath = "";
    invalidDumpConf.dumpStatus = "on";
    invalidDumpConf.dumpMode = "all";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, invalidDumpConf), ADUMP_FAILED);
}

TEST_F(AdumpApiUtest, Test_SetOperatorOverflowDumpConf_fail)
{
    DumpConfig invalidDumpConf;

    // invalid dump status
    invalidDumpConf.dumpPath = "/path/to/dump/";
    invalidDumpConf.dumpStatus = "invalid";
    invalidDumpConf.dumpMode = "all";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, invalidDumpConf), ADUMP_FAILED);

    // invalid dump mode
    invalidDumpConf.dumpPath = "/path/to/dump/";
    invalidDumpConf.dumpStatus = "on";
    invalidDumpConf.dumpMode = "invalid";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, invalidDumpConf), ADUMP_SUCCESS);

    // invalid dump path
    invalidDumpConf.dumpPath = "";
    invalidDumpConf.dumpStatus = "on";
    invalidDumpConf.dumpMode = "all";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, invalidDumpConf), ADUMP_FAILED);
}

TEST_F(AdumpApiUtest, Test_AdumpDumpTensor_with_DumpStatus_off)
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

uint64_t mmGetClockMonotonicTime()
{
    mmTimespec now = mmGetTickCount();
    return (static_cast<uint64_t>(now.tv_sec) * 1000000000) + static_cast<uint64_t>(now.tv_nsec);
}

TEST_F(AdumpApiUtest, Test_ArgsException_AdumpGetDFXInfoAddr)
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

TEST_F(AdumpApiUtest, Test_ArgsException_GetSizeInfoAddr)
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

TEST_F(AdumpApiUtest, Test_ArgsException_GetSizeInfoAddr_With_Right_Addr)
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

TEST_F(AdumpApiUtest, Test_GetEnv_Exception)
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

TEST_F(AdumpApiUtest, Test_AdumpSetDump)
{
    int32_t ret = AdumpSetDump(nullptr, 0);
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump("", 0);
    EXPECT_EQ(ret, ADUMP_FAILED);

    std::string invalidConfigData = ReadFileToString(JSON_BASE "common/bad_path.json");
    ret = AdumpSetDump(invalidConfigData.c_str(), invalidConfigData.size());
    EXPECT_EQ(ret, ADUMP_INPUT_FAILED);

    std::string validConfigData = ReadFileToString(JSON_BASE "common/only_path.json");
    ret = AdumpSetDump(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    ret = AdumpSetDump(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    MOCKER(memcpy_s)
    .stubs()
    .will(returnValue(EINVAL));
    validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    ret = AdumpSetDump(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(AdumpApiUtest, Test_AdumpUnSetDump)
{
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = AdumpSetDump(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpUnSetDump();
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    ret = AdumpSetDump(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    MOCKER(&DumpSetting::Init).stubs().will(returnValue(ADUMP_FAILED));
    ret = AdumpUnSetDump();
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(AdumpApiUtest, Test_AdumpGetDumpSwitch)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), dumpConf.dumpSwitch);
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
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), dumpConf.dumpSwitch);
}

static int32_t AdumpCallbackTest(uint64_t dumpSwitch, const char *dumpConfig, int32_t size)
{
    if ((dumpSwitch & OP_INFO_RECORD_DUMP) == 0) {
        std::string testData("test op info record");
        AdumpSaveToFile(testData.c_str(), testData.size(), "12323/test_op_info.json", SaveType::OVERWRITE);
        AdumpSaveToFile(testData.c_str(), testData.size(), "12323/test_op_info.json", SaveType::APPEND);
    }
    return 0;
}

static int32_t AdumpCallbackFuncTest(uint64_t dumpSwitch, const char *dumpConfig, int32_t size)
{
    if (dumpConfig == nullptr || size <= 0) {
        return -1;
    }
    return 0;
}

TEST_F(AdumpApiUtest, Test_OP_Dump_Save)
{
    EXPECT_EQ(0, AdumpRegisterCallback(1, AdumpCallbackTest, AdumpCallbackTest));
    std::string path("./UTest_EmptyJsonSuccess");
    EXPECT_EQ(ACL_SUCCESS, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    std::string jsonPath = path + "/12323/test_op_info.json";
    std::ifstream jsonFile(jsonPath);
    EXPECT_EQ(true, jsonFile.is_open());
    std::string data;
    std::getline(jsonFile, data);
    EXPECT_STREQ("test op info recordtest op info record", data.c_str());
    system("rm -r ./UTest_EmptyJsonSuccess");
}

TEST_F(AdumpApiUtest, Test_OP_Dump_Save_Error)
{
    EXPECT_EQ(0, AdumpRegisterCallback(1, AdumpCallbackTest, AdumpCallbackTest));
    std::string path("./UTest_EmptyJsonSuccess");
    EXPECT_EQ(ACL_SUCCESS, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    MOCKER(&File::IsFileOpen).stubs().will(returnValue(ADUMP_FAILED));
    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    MOCKER(&Path::RealPath).stubs().will(returnValue(false));
    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    MOCKER(&Path::CreateDirectory).stubs().will(returnValue(false));
    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    std::string jsonPath = path + "/12323/test_op_info.json";
    std::ifstream jsonFile(jsonPath);
    EXPECT_EQ(true, jsonFile.is_open());
    std::string data;
    std::getline(jsonFile, data);
    EXPECT_STREQ("", data.c_str());
    system("rm -r ./UTest_EmptyJsonSuccess");
}

TEST_F(AdumpApiUtest, Test_OP_Dump_Api_Error)
{
    EXPECT_EQ(0, AdumpRegisterCallback(1, AdumpCallbackTest, AdumpCallbackTest));

    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    MOCKER_CPP(&DumpManager::StopDumpArgs).stubs().will(returnValue(-1));
    EXPECT_EQ(ACL_ERROR_FAILURE, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));

    std::string path("./UTest_EmptyJsonSuccess");
    EXPECT_EQ(ACL_ERROR_FAILURE, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, ""));
    MOCKER_CPP(&Path::IsDirectory).stubs().will(returnValue(false)).then(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FAILURE, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    EXPECT_EQ(ACL_SUCCESS, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    EXPECT_EQ(ACL_ERROR_FAILURE, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    system("rm -r ./UTest_EmptyJsonSuccess");
}

TEST_F(AdumpApiUtest, Test_Callback_AdumpSetDump_AdumpUnSetDump)
{
    EXPECT_EQ(ADUMP_SUCCESS, AdumpRegisterCallback(11, AdumpCallbackFuncTest, AdumpCallbackFuncTest));
    std::string configData = ReadFileToString(JSON_BASE "datadump/dump_ge_tensor.json");
    int32_t ret = AdumpSetDump(configData.c_str(), configData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    ret = AdumpUnSetDump();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    system("rm -rf ./ge/test_callback_info.json");
}

TEST_F(AdumpApiUtest, Test_AdumpSetDump_Callback_AdumpUnSetDump)
{
    std::string configData = ReadFileToString(JSON_BASE "datadump/dump_ge_tensor.json");
    int32_t ret = AdumpSetDump(configData.c_str(), configData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(ADUMP_SUCCESS, AdumpRegisterCallback(12, AdumpCallbackFuncTest, AdumpCallbackFuncTest));
    ret = AdumpUnSetDump();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    system("rm -rf ./ge/test_callback_info.json");
}

TEST_F(AdumpApiUtest, Test_Invalid_Callback_AdumpSetDump_AdumpUnSetDump)
{
    EXPECT_EQ(DumpManager::Instance().HandleDumpEvent(100, DumpEnableAction::DISABLE), ADUMP_FAILED);
    EXPECT_EQ(DumpManager::Instance().HandleDumpEvent(100, static_cast<DumpEnableAction>(10)), ADUMP_FAILED);
    EXPECT_EQ(ADUMP_FAILED, AdumpRegisterCallback(13, AdumpCallbackFuncTest, nullptr));
    EXPECT_EQ(ADUMP_FAILED, AdumpRegisterCallback(14, nullptr, nullptr));
    std::string configData = ReadFileToString(JSON_BASE "datadump/dump_ge_tensor.json");
    int32_t ret = AdumpSetDump(configData.c_str(), configData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    ret = AdumpUnSetDump();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    system("rm -rf ./ge/test_callback_info.json");
}
