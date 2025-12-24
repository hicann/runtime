/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlog_common.h"
#include "dlog_time.h"
#include "log_common.h"
#include "slog.h"
#include "dlog_level_mgr.h"
#include "dlog_attr.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#define DEFAULT_LOG_LEVEL 3

extern "C" LogRt DlogInitModuleLogLevelByEnv(void);
extern "C" LogLevelCtrl g_dlogLevel;
extern "C" ModuleInfo g_dlogModuleInfo[];

class LIBALOG_TEST : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};
void LIBALOG_TEST::SetUp()
{
    const ModuleInfo *moduleInfo1 = DlogGetModuleInfoByName("CCE");
    DlogSetLogTypeLevelByModuleId(moduleInfo1->moduleId, DEFAULT_LOG_LEVEL, DEBUG_LOG_MASK);
    const ModuleInfo *moduleInfo2 = DlogGetModuleInfoByName("GE");
    DlogSetLogTypeLevelByModuleId(moduleInfo2->moduleId, DEFAULT_LOG_LEVEL, DEBUG_LOG_MASK);
}

void LIBALOG_TEST::TearDown()
{
    GlobalMockObject::reset();
}

static void SetUpTestCase()
{
}

static void TearDownTestCase()
{
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest1)
{
    char *moduleEnv = NULL;
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("GE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest2)
{
    char *moduleEnv = "GE=0"; // null
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));

    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("GE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(0, level);
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest3)
{
    char *moduleEnv = "GE=0:";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("GE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(0, level);
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest4)
{
    char *moduleEnv = "CCE=0:GE=2";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo1 = DlogGetModuleInfoByName("CCE");
    int32_t level1 = DlogGetLogTypeLevelByModuleId(moduleInfo1->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(0, level1);

    const ModuleInfo *moduleInfo2 = DlogGetModuleInfoByName("GE");
    int32_t level2 = DlogGetLogTypeLevelByModuleId(moduleInfo2->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(2, level2);
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest5)
{
    char *moduleEnv = "";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("GE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}


TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest6)
{
    char *moduleEnv = "CCE=";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("CCE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}


TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest7)
{
    char *moduleEnv = "=0";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("CCE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest8)
{
    char *moduleEnv = "=";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("CCE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest9)
{
    char *moduleEnv = "CCE";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("CCE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest10)
{
    char *moduleEnv = "0";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("CCE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}


TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest11)
{
    char *moduleEnv = "unknowName=3";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("CCE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}


TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest12)
{
    char *moduleEnv = "CCE=unknowValue";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("CCE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest13)
{
    char *moduleEnv = "CCE=10";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("CCE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}

TEST_F(LIBALOG_TEST, InitLogLevelByModuleEnvTest14)
{
    char *moduleEnv = "";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(moduleEnv));
    DlogInitModuleLogLevelByEnv();
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName("GE");
    int32_t level = DlogGetLogTypeLevelByModuleId(moduleInfo->moduleId, DEBUG_LOG_MASK);
    EXPECT_EQ(DEFAULT_LOG_LEVEL, level);
}

TEST_F(LIBALOG_TEST, DlogLevelInit)
{
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_MODULE_LOG_LEVEL", "SLOG=0", 1);
    setenv("ASCEND_GLOBAL_EVENT_ENABLE", "1", 1);
    DlogLevelInit();
    EXPECT_EQ(g_dlogLevel.globalLogLevel, 0);
    EXPECT_EQ(g_dlogLevel.enableEvent, true);
    EXPECT_EQ(g_dlogModuleInfo[SLOG].moduleLevel, 0);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_MODULE_LOG_LEVEL");
    unsetenv("ASCEND_GLOBAL_EVENT_ENABLE");
    GlobalMockObject::reset();
}