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
#include "operate_loglevel.h"
#include "log_pm_sig.h"
#include "self_log_stub.h"
#include "log_level_stub.h"
#include "log_config_api.h"
using namespace std;
using namespace testing;

extern "C" {

}

class EP_LOG_LEVEL_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm " PATH_ROOT "/*");
        system("rm -rf " DEFAULT_LOG_WORKSPACE "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " PATH_ROOT);
        system("mkdir -p " DEFAULT_LOG_WORKSPACE);
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
TEST_F(EP_LOG_LEVEL_FUNC_UTEST, SlogdLevel)
{
    // global log level
    SlogdSetGlobalLevel(DLOG_DEBUG, DEBUG_LOG_MASK);
    EXPECT_EQ(DLOG_DEBUG, SlogdGetGlobalLevel(DEBUG_LOG_MASK));
    SlogdSetGlobalLevel(DLOG_DEBUG, RUN_LOG_MASK);
    EXPECT_EQ(DLOG_INFO, SlogdGetGlobalLevel(RUN_LOG_MASK));
    SlogdSetGlobalLevel(DLOG_DEBUG, SLOGD_GLOBAL_TYPE_MASK);
    EXPECT_EQ(DLOG_DEBUG, SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK));

    // module level
    EXPECT_EQ(true, SlogdSetModuleLevel(SLOG, DLOG_DEBUG, DEBUG_LOG_MASK));
    EXPECT_EQ(DLOG_DEBUG, SlogdGetModuleLevel(SLOG, DEBUG_LOG_MASK));
    EXPECT_EQ(true, SlogdSetModuleLevel(SLOG, DLOG_DEBUG, RUN_LOG_MASK));
    EXPECT_EQ(DLOG_INFO, SlogdGetModuleLevel(SLOG, RUN_LOG_MASK));
    EXPECT_EQ(true, SlogdSetModuleLevel(SLOG, DLOG_DEBUG, SLOGD_GLOBAL_TYPE_MASK));
    EXPECT_EQ(DLOG_DEBUG, SlogdGetModuleLevel(SLOG, SLOGD_GLOBAL_TYPE_MASK));

    EXPECT_EQ(true, SlogdSetModuleLevelByDevId(0, SLOG, DLOG_DEBUG, DEBUG_LOG_MASK));
    EXPECT_EQ(DLOG_DEBUG, SlogdGetModuleLevelByDevId(0, SLOG, DEBUG_LOG_MASK));
    EXPECT_EQ(true, SlogdSetModuleLevelByDevId(0, SLOG, DLOG_DEBUG, RUN_LOG_MASK));
    EXPECT_EQ(DLOG_INFO, SlogdGetModuleLevelByDevId(0, SLOG, RUN_LOG_MASK));
    EXPECT_EQ(true, SlogdSetModuleLevelByDevId(0, SLOG, DLOG_DEBUG, SLOGD_GLOBAL_TYPE_MASK));
    EXPECT_EQ(DLOG_DEBUG, SlogdGetModuleLevelByDevId(0, SLOG, SLOGD_GLOBAL_TYPE_MASK));

    EXPECT_EQ(true, SlogdSetModuleLevelByDevId(0, ISP, DLOG_DEBUG, DEBUG_LOG_MASK));
    EXPECT_EQ(DLOG_DEBUG, SlogdGetModuleLevelByDevId(0, ISP, DEBUG_LOG_MASK));
    EXPECT_EQ(true, SlogdSetModuleLevelByDevId(0, ISP, DLOG_DEBUG, RUN_LOG_MASK));
    EXPECT_EQ(DLOG_INFO, SlogdGetModuleLevelByDevId(0, ISP, RUN_LOG_MASK));
    EXPECT_EQ(true, SlogdSetModuleLevelByDevId(0, ISP, DLOG_DEBUG, SLOGD_GLOBAL_TYPE_MASK));
    EXPECT_EQ(DLOG_DEBUG, SlogdGetModuleLevelByDevId(0, ISP, SLOGD_GLOBAL_TYPE_MASK));

    SlogdSetEventLevel(1);
    EXPECT_EQ(true, SlogdGetEventLevel());

    SlogdSetEventLevel(0);
    EXPECT_EQ(false, SlogdGetEventLevel());

    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_LOG_LEVEL_FUNC_UTEST, MultipleModule)
{
    EXPECT_EQ(false, IsMultipleModule(SLOG));
    EXPECT_EQ(false, IsMultipleModule(AICPU));
    EXPECT_EQ(true, IsMultipleModule(TS));
    EXPECT_EQ(true, IsMultipleModule(TSDUMP));
    EXPECT_EQ(true, IsMultipleModule(LP));
    EXPECT_EQ(true, IsMultipleModule(IMU));
    EXPECT_EQ(true, IsMultipleModule(IMP));
    EXPECT_EQ(true, IsMultipleModule(ISP));
    EXPECT_EQ(true, IsMultipleModule(SIS));
    EXPECT_EQ(true, IsMultipleModule(HSM));

    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_LOG_LEVEL_FUNC_UTEST, ModuleInfo)
{
    EXPECT_STREQ("SLOG", GetModuleNameById(0));
    EXPECT_STREQ("IDEDD", GetModuleNameById(1));
    EXPECT_STREQ("DVPP", GetModuleNameById(6));
    EXPECT_STREQ("PROFILING", GetModuleNameById(31));
    EXPECT_STREQ("BBOX", GetModuleNameById(55));
    EXPECT_STREQ("ATRACE", GetModuleNameById(71));

    const ModuleInfo *module = GetModuleInfoByName("SLOG");
    EXPECT_EQ(0, module->moduleId);
    EXPECT_EQ(false, module->multiFlag);

    module = GetModuleInfoById(0);
    EXPECT_STREQ("SLOG", module->moduleName);
    EXPECT_EQ(false, module->multiFlag);

    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_LOG_LEVEL_FUNC_UTEST, LevelInfo)
{
    EXPECT_EQ(DLOG_DEBUG, GetLevelIdByName("DEBUG"));
    EXPECT_EQ(DLOG_INFO, GetLevelIdByName("INFO"));
    EXPECT_EQ(DLOG_WARN, GetLevelIdByName("WARNING"));
    EXPECT_EQ(DLOG_ERROR, GetLevelIdByName("ERROR"));
    EXPECT_EQ(DLOG_NULL, GetLevelIdByName("NULL"));
    EXPECT_EQ(DLOG_EVENT, GetLevelIdByName("EVENT"));

    EXPECT_STREQ("DEBUG", GetLevelNameById(DLOG_DEBUG));
    EXPECT_STREQ("INFO", GetLevelNameById(DLOG_INFO));
    EXPECT_STREQ("WARNING", GetLevelNameById(DLOG_WARN));
    EXPECT_STREQ("ERROR", GetLevelNameById(DLOG_ERROR));
    EXPECT_STREQ("NULL", GetLevelNameById(DLOG_NULL));
    EXPECT_STREQ("EVENT", GetLevelNameById(DLOG_EVENT));

    EXPECT_STREQ("DEBUG", GetBasicLevelNameById(DLOG_DEBUG));
    EXPECT_STREQ("INFO", GetBasicLevelNameById(DLOG_INFO));
    EXPECT_STREQ("WARNING", GetBasicLevelNameById(DLOG_WARN));
    EXPECT_STREQ("ERROR", GetBasicLevelNameById(DLOG_ERROR));
    EXPECT_STREQ("NULL", GetBasicLevelNameById(DLOG_NULL));

    EXPECT_EQ(0, GetErrLogNum());
}

static void ShmMock(void)
{
    MOCKER(shmget).stubs().will(invoke(shmgetStub));
    MOCKER(shmat).stubs().will(invoke(shmatStub));
    MOCKER(shmdt).stubs().will(invoke(shmdtStub));
    MOCKER(shmctl).stubs().will(invoke(shmctlStub));

    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_LOG_LEVEL_FUNC_UTEST, SlogdLevelInit)
{
    ShmMock();
    
    system("> " DEFAULT_LOG_WORKSPACE "/" LEVEL_NOTIFY_FILE);
    // pf and not in docker
    LogConfInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdLevelInit(-1, 0, FALSE));
    EXPECT_EQ(0, GetErrLogNum());
    LogRecordSigNo(15);
    sleep(1);
    SlogdLevelExit();
    system("rm " DEFAULT_LOG_WORKSPACE "/" LEVEL_NOTIFY_FILE);
}

TEST_F(EP_LOG_LEVEL_FUNC_UTEST, SlogdLevelExitFailed)
{
    ShmMock();

    system("> " DEFAULT_LOG_WORKSPACE "/" LEVEL_NOTIFY_FILE);
    // pf and not in docker
    LogConfInit();
    EXPECT_EQ(LOG_SUCCESS, SlogdLevelInit(-1, 0, FALSE));
    EXPECT_EQ(0, GetErrLogNum());
    LogRecordSigNo(15);
    sleep(1);
    MOCKER(shmctl).stubs().will(returnValue(-1));
    SlogdLevelExit();
    system("rm " DEFAULT_LOG_WORKSPACE "/" LEVEL_NOTIFY_FILE);
}