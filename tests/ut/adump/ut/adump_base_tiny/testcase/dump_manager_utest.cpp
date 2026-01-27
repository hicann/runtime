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
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
};

TEST_F(TinyDumpManagerUtest, Test_SetDumpConfig)
{
    int32_t ret = DumpManager::Instance().SetDumpConfig(nullptr);
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = DumpManager::Instance().SetDumpConfig("");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = DumpManager::Instance().SetDumpConfig(JSON_BASE "common/bad_path.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = DumpManager::Instance().SetDumpConfig(JSON_BASE "common/only_path.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = DumpManager::Instance().SetDumpConfig(JSON_BASE "datadump/dump_data_stats.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    EXPECT_EQ(DumpManager::Instance().GetBinName(), "");
    EXPECT_EQ(DumpManager::Instance().CheckBinValidation(), false);
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
    std::vector<TensorInfo> inputTensors;
    rtStream_t stream;
    ret = DumpManager::Instance().DumpOperator("", "", inputTensors, stream);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_UnSetDumpConfig)
{
    int32_t ret = DumpManager::Instance().SetDumpConfig(JSON_BASE "datadump/dump_data_stats.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    MOCKER_CPP(&Adx::DumpManager::IsEnableDump).stubs().will(returnValue(true));
    MOCKER_CPP(&Adx::DumpManager::SetDumpConfig, int(Adx::DumpManager::*)(DumpType, const DumpConfig &))
        .stubs()
        .will(returnValue(ADUMP_FAILED))
        .then(returnValue(ADUMP_SUCCESS));
    EXPECT_EQ(DumpManager::Instance().UnSetDumpConfig(), ADUMP_FAILED);
    EXPECT_EQ(DumpManager::Instance().UnSetDumpConfig(), ADUMP_SUCCESS);
}

TEST_F(TinyDumpManagerUtest, Test_GetKFCInitStatus)
{
    DumpManager::Instance().SetKFCInitStatus(false);
    EXPECT_EQ(DumpManager::Instance().GetKFCInitStatus(), false);
}

TEST_F(TinyDumpManagerUtest, Test_ExceptionModeDowngrade)
{
    DumpManager::Instance().GetDumpSetting();
    DumpManager::Instance().ExceptionModeDowngrade();
}