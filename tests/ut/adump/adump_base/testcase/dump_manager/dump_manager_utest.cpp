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
#include "utils.h"

using namespace Adx;
#define JSON_BASE ADUMP_BASE_DIR "stub/data/json/"
class DumpManagerUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
};

TEST_F(DumpManagerUtest, Test_SetDumpConfig)
{
    int32_t ret = DumpManager::Instance().SetDumpConfig(nullptr, 0);
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = DumpManager::Instance().SetDumpConfig("", 0);
    EXPECT_EQ(ret, ADUMP_FAILED);

    std::string invalidConfigData = ReadFileToString(JSON_BASE "common/bad_path.json");
    ret = DumpManager::Instance().SetDumpConfig(invalidConfigData.c_str(), invalidConfigData.size());
    EXPECT_EQ(ret, ADUMP_INPUT_FAILED);

    std::string validConfigData = ReadFileToString(JSON_BASE "common/only_path.json");
    ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpManagerUtest, Test_UnSetDumpConfig)
{
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    MOCKER(&DumpSetting::Init).stubs().will(returnValue(ADUMP_FAILED));
    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_FAILED);
}