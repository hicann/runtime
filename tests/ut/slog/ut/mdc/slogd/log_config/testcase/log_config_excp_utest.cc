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

#include "log_config_group.h"
#include "self_log_stub.h"
#include "slogd_config_mgr.h"
#include "slogd_group_log.h"
#include "log_config_block.h"

using namespace std;
using namespace testing;

#define SLOG_CONF_FILE  "slog_excp_A1SUs28SDBwhdcus.conf"
#define SLOG_LACKGENELCONF_FILE  "slog_lackgernel_A1SUs28SDBwhdcus.conf"

extern GeneralGroupInfo g_groupInfo;

extern "C" LogConfClass g_logConfClass[LOG_TYPE_MAX_NUM];

class MDC_LOG_CONFIG_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("> " BOOTARGS_FILE_PATH);
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("mkdir -p " FILE_DIR);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    static void DlogConstructor()
    {
    }

    static void DlogDestructor()
    {
        (void)memset_s(&g_groupInfo, sizeof(GeneralGroupInfo), 0, sizeof(GeneralGroupInfo));
    }
};

TEST_F(MDC_LOG_CONFIG_EXCP_UTEST, LogConfigGroupInit)
{
    // 初始化
    DlogConstructor();
    char file[256] = { 0 };
    sprintf(file, "%s%s", SLOG_CONF_FILE_DIR, SLOG_CONF_FILE);
    LogConfGroupInit(file);
    EXPECT_NE(0, GetErrLogNum());
    EXPECT_NE(0, CheckErrLog("unrecognizable config name"));

    // 释放
    DlogDestructor();
}

static void *LogMallocStub(size_t size)
{
    return malloc(size);
}

TEST_F(MDC_LOG_CONFIG_EXCP_UTEST, LogConfigGroupInitMallocFailed)
{
    // 初始化
    DlogConstructor();
    SlogdConfigMgrInit();
    MOCKER(LogMalloc)
        .stubs()
        .will(invoke(LogMallocStub))
        .then(invoke(LogMallocStub))
        .then(returnValue((void*)NULL))
        .then(invoke(LogMallocStub));

    SlogdGroupLogInit();
    EXPECT_EQ(1, CheckErrLog("Add now group failed. Group Id is 0"));

    // 释放
    SlogdGroupLogExit();
    SlogdConfigMgrExit();
    DlogDestructor();
}

TEST_F(MDC_LOG_CONFIG_EXCP_UTEST, LogConfigGroupInitFileInvalid)
{
    // 初始化
    DlogConstructor();
    char file[256] = { 0 };
    sprintf(file, "%s%s", SLOG_CONF_FILE_DIR, SLOG_LACKGENELCONF_FILE);
    LogConfGroupInit(file);
    EXPECT_EQ(1, CheckErrLog("null symbol"));

    // 释放
    DlogDestructor();
}

TEST_F(MDC_LOG_CONFIG_EXCP_UTEST, SlogdEventLogToFileStorageWithTimeInvalid)
{
    system("sed -i 's/class *= *.*/class=event_test/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/storage_rule *= *.*/storage_rule=-1/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/output_rule *= *.*/output_rule=file;1048576;-1;2097152/g' " SLOG_CONF_FILE_PATH);
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    EXPECT_EQ(nullptr, LogConfGetClass(-1));
    EXPECT_EQ(nullptr, LogConfGetClass(LOG_TYPE_MAX_NUM));
    LogConfClass *confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(0, confClass->storageRule.storagePeriod);
    EXPECT_EQ(DEFAULT_MAX_FILE_NUM, confClass->outputRule.fileNum);
    SlogdConfigMgrExit();

    system("sed -i 's/class *= *.*/class=event_test/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/storage_rule *= *.*/storage_rule=-1/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/output_rule *= *.*/output_rule=file;1048576;10;524290/g' " SLOG_CONF_FILE_PATH);
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    EXPECT_EQ(nullptr, LogConfGetClass(-1));
    EXPECT_EQ(nullptr, LogConfGetClass(LOG_TYPE_MAX_NUM));
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(0, confClass->storageRule.storagePeriod);
    EXPECT_EQ(1048576, confClass->outputRule.totalSize);
    SlogdConfigMgrExit();

    system("sed -i 's/storage_rule *= *.*/storage_rule=25/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/output_rule *= *.*/output_rule=file;1048576;1.2;2097152/g' " SLOG_CONF_FILE_PATH);
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(24 * 3600, confClass->storageRule.storagePeriod);
    EXPECT_EQ(DEFAULT_MAX_FILE_NUM, confClass->outputRule.fileNum);
    SlogdConfigMgrExit();

    system("sed -i 's/storage_rule *= *.*/storage_rule=20.1/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/output_rule *= *.*/output_rule=file;1048576;0;2097152/g' " SLOG_CONF_FILE_PATH);
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(0, confClass->storageRule.storagePeriod);
    EXPECT_EQ(MIN_FILE_NUM, confClass->outputRule.fileNum);
    SlogdConfigMgrExit();

    system("sed -i 's/output_rule *= *.*/output_rule=file;1048576;10000;2097152/g' " SLOG_CONF_FILE_PATH);
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(MAX_FILE_NUM, confClass->outputRule.fileNum);
    SlogdConfigMgrExit();

    system("sed -i 's/output_rule *= *.*/output_rule=test;1048576;10000;2097152/g' " SLOG_CONF_FILE_PATH);
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(MAX_FILE_NUM, confClass->outputRule.fileNum);
    SlogdConfigMgrExit();

    system("sed -i 's/output_rule *= *.*/output_rule=file;1048576;10000;2097152/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/input_rule *= *.*/input_rule=test/g' " SLOG_CONF_FILE_PATH);
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(0, confClass->outputRule.fileNum);
    SlogdConfigMgrExit();

    system("sed -i 's/input_rule *= *.*/     input_test1111=test/g' " SLOG_CONF_FILE_PATH);
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(0, confClass->outputRule.fileNum);
    SlogdConfigMgrExit();

    system("sed '83a\\[   debug   ]' " SLOG_CONF_FILE_PATH);
    system("sed '84a\\[   eventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventeventevent   ]' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/input_test1111 *= *.*/  input_test/g' " SLOG_CONF_FILE_PATH);
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(0, confClass->outputRule.fileNum);
    SlogdConfigMgrExit();
}

TEST_F(MDC_LOG_CONFIG_EXCP_UTEST, SlogdBlockParseSscanfFailed)
{
    MOCKER(vsscanf_s).stubs().will(returnValue(0));
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    LogConfClass *confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(0, confClass->storageRule.storagePeriod);
    SlogdConfigMgrExit();
    GlobalMockObject::verify();

    MOCKER(vsscanf_s).stubs().will(returnValue(1)).then(returnValue(0));
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(0, confClass->storageRule.storagePeriod);
    SlogdConfigMgrExit();
    GlobalMockObject::verify();

    MOCKER(vsscanf_s).stubs().will(returnValue(1)).then(returnValue(4)).then(returnValue(0));
    (void)memset_s(&g_logConfClass, sizeof(g_logConfClass), 0, sizeof(g_logConfClass));
    SlogdConfigMgrInit();
    confClass = LogConfGetClass(EVENT_LOG_TYPE);
    EXPECT_EQ(0, confClass->storageRule.storagePeriod);
    SlogdConfigMgrExit();
    GlobalMockObject::verify();
}

TEST_F(MDC_LOG_CONFIG_EXCP_UTEST, SlogdBlockParseFailed)
{
    system("sed -i 's/DeviceOsMaxFileNum *= *.*/  DeviceOsMaxFileNum111/g' " SLOG_CONF_FILE_PATH);
    FILE *fp = fopen(SLOG_CONF_FILE_PATH, "r");
    LogConfParseBlock(fp);
    EXPECT_NE(0, GetErrLogNum());
    fclose(fp);
}

TEST_F(MDC_LOG_CONFIG_EXCP_UTEST, LogConfigGroupInitWriteFileSwitch)
{
    // 初始化
    DlogConstructor();
    SlogdConfigMgrInit();
    SlogdGroupLogInit();
    EXPECT_EQ(true, SlogdConfigMgrGetWriteFileLimit());
    // 释放
    SlogdGroupLogExit();
    SlogdConfigMgrExit();
    DlogDestructor();
    GlobalMockObject::verify();

    system("sed -i 's/WriteLimitSwitch=1/WriteLimitSwitch=0/g' " SLOG_CONF_FILE_PATH);
    // 初始化
    DlogConstructor();
    SlogdConfigMgrInit();
    SlogdGroupLogInit();
    EXPECT_EQ(false, SlogdConfigMgrGetWriteFileLimit());
    // 释放
    SlogdGroupLogExit();
    SlogdConfigMgrExit();
    DlogDestructor();
    GlobalMockObject::verify();

    system("sed -i 's/WriteLimitSwitch=0/WriteLimitSwitch=abc/g' " SLOG_CONF_FILE_PATH);
    // 初始化
    DlogConstructor();
    SlogdConfigMgrInit();
    SlogdGroupLogInit();
    EXPECT_EQ(true, SlogdConfigMgrGetWriteFileLimit());
    // 释放
    SlogdGroupLogExit();
    SlogdConfigMgrExit();
    DlogDestructor();
    GlobalMockObject::verify();

    system("sed -i 's/WriteLimitSwitch=abc/WriteLimitNoSwitch=abc/g' " SLOG_CONF_FILE_PATH);
    // 初始化
    DlogConstructor();
    SlogdConfigMgrInit();
    SlogdGroupLogInit();
    EXPECT_EQ(false, SlogdConfigMgrGetWriteFileLimit());
    // 释放
    SlogdGroupLogExit();
    SlogdConfigMgrExit();
    DlogDestructor();
    GlobalMockObject::verify();

    system("sed -i 's/WriteLimitNoSwitch=abc/WriteLimitSwitch=1/g' " SLOG_CONF_FILE_PATH);
    // 初始化
    DlogConstructor();
    SlogdConfigMgrInit();
    SlogdGroupLogInit();
    EXPECT_EQ(true, SlogdConfigMgrGetWriteFileLimit());
    // 释放
    SlogdGroupLogExit();
    SlogdConfigMgrExit();
    DlogDestructor();
    GlobalMockObject::verify();
}

TEST_F(MDC_LOG_CONFIG_EXCP_UTEST, LogConfigEventInitNullConfig)
{
    LogConfClass confClass = { 0 };
    confClass.outputRule.fileSize = 0;
    confClass.outputRule.totalSize = 0;
    MOCKER(LogConfGetClass).stubs().will(returnValue(&confClass));
    // 初始化
    DlogConstructor();
    SlogdConfigMgrInit();
    SlogdGroupLogInit();
    EXPECT_EQ(true, SlogdConfigMgrGetWriteFileLimit());
    // 释放
    SlogdGroupLogExit();
    SlogdConfigMgrExit();
    DlogDestructor();
    GlobalMockObject::verify();
}