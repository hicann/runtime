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
#include "dump_setting.h"
#include "sys_utils.h"

using namespace Adx;

class DumpSettingUtest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DumpSettingUtest, Test_InitDumpConfig)
{
    struct DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);

    MOCKER(SysUtils::GetCurrentTime).stubs().will(returnValue(std::string("now")));

    DumpSetting setting;
    EXPECT_EQ(setting.Init(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(setting.GetDumpPath(), std::string("/path/to/dump/dir/now/"));
    EXPECT_EQ(setting.GetDumpMode(), DUMP_MODE_INPUT | DUMP_MODE_OUTPUT | DUMP_MODE_WORKSPACE);
    EXPECT_EQ(setting.GetDumpStatus(), true);
}

TEST_F(DumpSettingUtest, Test_InitDumpConfig_off)
{
    struct DumpConfig dumpConf;
    dumpConf.dumpStatus = "off";

    DumpSetting setting;
    EXPECT_EQ(setting.Init(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(setting.GetDumpPath(), std::string(""));
    EXPECT_EQ(setting.GetDumpMode(), 0U);
    EXPECT_EQ(setting.GetDumpStatus(), false);
}

TEST_F(DumpSettingUtest, Test_InitDumpConfig_With_InvalidDumpStatus)
{
    struct DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "invalid_status";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    DumpSetting setting;
    EXPECT_EQ(setting.Init(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
}

TEST_F(DumpSettingUtest, Test_InitDumpConfig_With_InvalidDumpMode)
{
    struct DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "invalid_mode";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    DumpSetting setting;
    EXPECT_EQ(setting.Init(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
}

TEST_F(DumpSettingUtest, Test_InitDumpConfig_With_EmptyDumpPath)
{
    struct DumpConfig dumpConf;
    dumpConf.dumpPath = "";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    DumpSetting setting;
    EXPECT_EQ(setting.Init(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
}

TEST_F(DumpSettingUtest, Test_InitDumpConfig_With_DumpStats)
{
    struct DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    dumpConf.dumpStatsItem.push_back("Negative Inf");
    dumpConf.dumpStatsItem.push_back("Positive Inf");

    MOCKER(SysUtils::GetCurrentTime).stubs().will(returnValue(std::string("now")));

    DumpSetting setting;
    EXPECT_EQ(setting.Init(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(setting.GetDumpStatsItem(), 48);
}

TEST_F(DumpSettingUtest, Test_InitDumpConfig_With_InvalidStats)
{
    struct DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    dumpConf.dumpStatsItem.push_back("what is this");

    MOCKER(SysUtils::GetCurrentTime).stubs().will(returnValue(std::string("now")));

    DumpSetting setting;
    EXPECT_EQ(setting.Init(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
}
