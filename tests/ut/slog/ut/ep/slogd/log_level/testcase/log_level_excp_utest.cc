/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "log_level_parse.h"
#include "self_log_stub.h"
using namespace std;
using namespace testing;

extern "C" {

}

class EP_LOG_LEVEL_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        EXPECT_EQ(0, GetErrLogNum());
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:

};

// log_level_parse.h
TEST_F(EP_LOG_LEVEL_EXCP_UTEST, SlogdLevelInvalidId)
{
    // module level
    EXPECT_EQ(false, SlogdSetModuleLevel(-1, DLOG_DEBUG, DEBUG_LOG_MASK));
    EXPECT_EQ(MODULE_DEFAULT_LOG_LEVEL, SlogdGetModuleLevel(-1, DEBUG_LOG_MASK));
    EXPECT_EQ(false, SlogdSetModuleLevel(-1, DLOG_DEBUG, RUN_LOG_MASK));
    EXPECT_EQ(MODULE_DEFAULT_LOG_LEVEL, SlogdGetModuleLevel(-1, RUN_LOG_MASK));
    EXPECT_EQ(false, SlogdSetModuleLevel(-1, DLOG_DEBUG, SLOGD_GLOBAL_TYPE_MASK));
    EXPECT_EQ(MODULE_DEFAULT_LOG_LEVEL, SlogdGetModuleLevel(-1, SLOGD_GLOBAL_TYPE_MASK));

    EXPECT_EQ(false, SlogdSetModuleLevelByDevId(INVLID_MOUDLE_ID, SLOG, DLOG_DEBUG, DEBUG_LOG_MASK));
    EXPECT_EQ(MODULE_DEFAULT_LOG_LEVEL, SlogdGetModuleLevelByDevId(INVLID_MOUDLE_ID, SLOG, DEBUG_LOG_MASK));
    EXPECT_EQ(false, SlogdSetModuleLevelByDevId(INVLID_MOUDLE_ID, SLOG, DLOG_DEBUG, RUN_LOG_MASK));
    EXPECT_EQ(MODULE_DEFAULT_LOG_LEVEL, SlogdGetModuleLevelByDevId(INVLID_MOUDLE_ID, SLOG, RUN_LOG_MASK));
    EXPECT_EQ(false, SlogdSetModuleLevelByDevId(INVLID_MOUDLE_ID, SLOG, DLOG_DEBUG, SLOGD_GLOBAL_TYPE_MASK));
    EXPECT_EQ(MODULE_DEFAULT_LOG_LEVEL, SlogdGetModuleLevelByDevId(INVLID_MOUDLE_ID, SLOG, SLOGD_GLOBAL_TYPE_MASK));
}

TEST_F(EP_LOG_LEVEL_EXCP_UTEST, MultipleModuleInvalidId)
{
    EXPECT_EQ(false, IsMultipleModule(-1));
    EXPECT_EQ(false, IsMultipleModule(INVLID_MOUDLE_ID));
}

TEST_F(EP_LOG_LEVEL_EXCP_UTEST, ModuleInfoInvalidId)
{
    EXPECT_EQ(NULL, GetModuleNameById(-1));
    EXPECT_EQ(NULL, GetModuleNameById(INVLID_MOUDLE_ID));

    EXPECT_EQ(NULL, GetModuleInfoByName(NULL));
    EXPECT_EQ(NULL, GetModuleInfoByName("INVALID"));

    EXPECT_EQ(NULL, GetModuleInfoById(-1));
    EXPECT_EQ(NULL, GetModuleInfoById(INVLID_MOUDLE_ID));
}

TEST_F(EP_LOG_LEVEL_EXCP_UTEST, LevelInfoInvalidId)
{
    EXPECT_EQ(-1, GetLevelIdByName(NULL));
    EXPECT_EQ(-1, GetLevelIdByName("INVALID"));

    EXPECT_EQ(NULL, GetLevelNameById(-1));
    EXPECT_EQ(NULL, GetLevelNameById(DLOG_EVENT + 1));

    EXPECT_STREQ("INVALID", GetBasicLevelNameById(DLOG_EVENT));
    EXPECT_STREQ("INVALID", GetBasicLevelNameById(DLOG_EVENT + 1));
    EXPECT_STREQ("INVALID", GetBasicLevelNameById(DLOG_NULL + 1));
    EXPECT_STREQ("INVALID", GetBasicLevelNameById(DLOG_DEBUG - 1));
}