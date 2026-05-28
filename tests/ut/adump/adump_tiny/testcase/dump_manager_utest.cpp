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
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "dump_manager.h"
#include "dump_config_converter.h"

using namespace Adx;
#define JSON_BASE ADUMP_BASE_DIR "ut/adump_base/stub/data/json/"
class TinyDumpManagerUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TinyDumpManagerUtest, Test_SetDumpConfig_WithMemory)
{
    std::string configData = "{\"dump_path\":\"/tmp\"}";
    int32_t ret = DumpManager::Instance().SetDumpConfig(configData.c_str(), configData.size(), "/tmp");
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_SetDumpConfig_WithMemory_NullParams)
{
    int32_t ret = DumpManager::Instance().SetDumpConfig(nullptr, 0, "/tmp");
    EXPECT_EQ(ret, ADUMP_FAILED);
    
    ret = DumpManager::Instance().SetDumpConfig("data", 0, nullptr);
    EXPECT_EQ(ret, ADUMP_FAILED);
    
    ret = DumpManager::Instance().SetDumpConfig(nullptr, 10, nullptr);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(TinyDumpManagerUtest, Test_UnSetDumpConfig)
{
    int32_t ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_KFCResourceInit)
{
    DumpManager::Instance().KFCResourceInit();
}

TEST_F(TinyDumpManagerUtest, Test_IsEnableDump)
{
    EXPECT_EQ(DumpManager::Instance().IsEnableDump(DumpType::OPERATOR), false);
    EXPECT_EQ(DumpManager::Instance().IsEnableDump(DumpType::OP_OVERFLOW), false);
}

TEST_F(TinyDumpManagerUtest, Test_DumpOperator)
{
    std::vector<TensorInfo> tensors;
    rtStream_t stream = nullptr;
    int32_t ret = DumpManager::Instance().DumpOperator("", "", tensors, stream);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_DumpOperatorV2)
{
    std::vector<TensorInfoV2> tensors;
    rtStream_t stream = nullptr;
    int32_t ret = DumpManager::Instance().DumpOperatorV2("", "", tensors, stream);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_RegisterExceptionDumpCallback)
{
    auto callback = [](void*, ExceptionDumpInfo*, uint32_t, uint32_t*, ExceptionDumpMode*) -> uint32_t { return 0; };
    int32_t ret = DumpManager::Instance().RegisterExceptionDumpCallback(callback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_UnregisterExceptionDumpCallback_Null)
{
    int32_t ret = DumpManager::Instance().UnregisterExceptionDumpCallback(nullptr);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_UnregisterExceptionDumpCallback_NotRegistered)
{
    auto callback = [](void*, ExceptionDumpInfo*, uint32_t, uint32_t*, ExceptionDumpMode*) -> uint32_t { return 0; };
    int32_t ret = DumpManager::Instance().UnregisterExceptionDumpCallback(callback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_UnregisterExceptionDumpCallback_Success)
{
    auto callback = [](void*, ExceptionDumpInfo*, uint32_t, uint32_t*, ExceptionDumpMode*) -> uint32_t { return 0; };
    int32_t ret = DumpManager::Instance().RegisterExceptionDumpCallback(callback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    
    ret = DumpManager::Instance().UnregisterExceptionDumpCallback(callback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_GetDumpSetting)
{
    DumpManager::Instance().GetDumpSetting();
}

TEST_F(TinyDumpManagerUtest, Test_AdumpGetDumpSwitch)
{
    uint64_t switchVal = DumpManager::Instance().AdumpGetDumpSwitch();
    EXPECT_EQ(switchVal, 0);
}

TEST_F(TinyDumpManagerUtest, Test_RegisterCallback_NullFunc)
{
    int32_t ret = DumpManager::Instance().RegisterCallback(1, nullptr, nullptr);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(TinyDumpManagerUtest, Test_RegisterCallback_Success)
{
    auto func = [](uint64_t, const char*, int32_t) -> int32_t { return 0; };
    int32_t ret = DumpManager::Instance().RegisterCallback(1, func, func);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}