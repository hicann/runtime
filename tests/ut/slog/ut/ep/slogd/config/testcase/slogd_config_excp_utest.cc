/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_config_api.h"
#include "log_config_list.h"
#include "log_to_file.h"
#include "slogd_config_mgr.h"
#include "self_log_stub.h"
#include "config_stub.h"
#include "slogd_buffer.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;


extern "C" {
typedef struct {
    uint32_t maxFileNum;
    uint32_t maxFileSize;
    int32_t dirNum;
    int32_t storageMode;
} LogTypeConfig;

typedef struct {
    LogTypeConfig logConfig[LOG_TYPE_MAX_NUM];
    uint32_t sysLogBufSize;
    uint32_t appLogBufSize;
    char aucFilePath[MAX_FILEPATH_LEN + 1U];
} ConfigMgr;

extern ToolMutex g_confMutex;
extern ConfigMgr g_configMgr;
}

class EP_SLOGD_CONFIG_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        g_confMutex = TOOL_MUTEX_INITIALIZER;
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " DEFAULT_LOG_WORKSPACE "/*");
        system("rm -rf " LOG_FILE_PATH "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
        g_configMgr = {
            {{DEFAULT_MAX_OS_FILE_NUM, DEFAULT_MAX_OS_FILE_SIZE, 0, 0},
            {DEFAULT_MAX_NDEBUG_FILE_NUM, DEFAULT_MAX_NDEBUG_FILE_SIZE, 0, 0},
            {DEFAULT_MAX_NDEBUG_FILE_NUM, DEFAULT_MAX_NDEBUG_FILE_SIZE, 0, 0},
            {EVENT_FILE_NUM, EVENT_FILE_SIZE, 0, 0},
            {DEFAULT_MAX_FILE_NUM, DEFAULT_MAX_FILE_SIZE, 0, 0},
            {0, 0, 0, 0},
            {DEFAULT_MAX_APP_FILE_NUM, DEFAULT_MAX_APP_FILE_SIZE, DEFAULT_RESERVE_DEVICE_APP_DIR_NUMS, 0},
            {DEFAULT_MAX_APP_FILE_NUM, DEFAULT_MAX_APP_FILE_SIZE, DEFAULT_RESERVE_DEVICE_APP_DIR_NUMS, 0},
            {DEFAULT_MAX_APP_FILE_NUM, DEFAULT_MAX_APP_FILE_SIZE, DEFAULT_RESERVE_DEVICE_APP_DIR_NUMS, 0}},
            .sysLogBufSize = DEFAULT_LOG_BUF_SIZE,
            .appLogBufSize = DEFAULT_LOG_BUF_SIZE,
            .aucFilePath = {0}
        };
        strcpy_s(g_configMgr.aucFilePath, MAX_FILEPATH_LEN, LOG_FILE_PATH);
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " DEFAULT_LOG_WORKSPACE);
        system("mkdir -p " LOG_FILE_PATH);
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:

};

static void MoveConfFile(void)
{
    system("rm " SLOG_CONF_FILE_PATH);
}

static void RecoverConfFile(void)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
}

static void GetConfPath(char *configPath)
{
    const char *selfBin = "/proc/self/exe";
    char processDir[TOOL_MAX_PATH + 1] = { 0 };
    int32_t selflen = (int32_t)readlink(selfBin, processDir, TOOL_MAX_PATH); // read self path of store
    const char *pend = strrchr(processDir, OS_SPLIT);
    off_t endLen = (pend - processDir) + 1;
    strncpy_s(configPath, TOOL_MAX_PATH, processDir, (size_t)endLen);
    strcat_s(configPath, TOOL_MAX_PATH, LOG_CONFIG_FILE);
}

// log_config_api.h
TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, LogConfInitWithoutConf)
{
    MoveConfFile();
    EXPECT_EQ(SYS_ERROR, LogConfInit());
    char configPath[TOOL_MAX_PATH + 1] = { 0 };
    GetConfPath(configPath);
    EXPECT_STREQ(configPath, LogConfGetPath());
    LogConfListFree();
    RecoverConfFile();
    EXPECT_EQ(3, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("open config file failed"));
    EXPECT_EQ(2, CheckErrLog("get realpath failed"));
}

// log_config_list.h
TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, LogConfListInitNull)
{
    // if file is null, use default conf path
    EXPECT_EQ(SUCCESS, LogConfListInit(NULL));
    LogConfListFree();
    EXPECT_EQ(0, GetErrLogNum());
}

static int32_t LogConfListTraverseFuncError(const Buff *node, ArgPtr arg, bool isNewStyle)
{
    return SYS_ERROR;
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, LogConfListTraverseFuncNull)
{
    EXPECT_EQ(SYS_OK, LogConfInit());
    EXPECT_EQ(SYS_ERROR, LogConfListTraverse(NULL, NULL, false));
    LogConfListFree();
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, LogConfListTraverseFuncFail)
{
    EXPECT_EQ(SYS_OK, LogConfInit());
    EXPECT_EQ(SYS_ERROR, LogConfListTraverse(LogConfListTraverseFuncError, NULL, false));
    LogConfListFree();
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, LogConfListGetValue)
{
    // get value from conflist when config not init
    char confStr[][CONF_VALUE_MAX_LEN + 1] = {
        LOG_AGENT_FILE_DIR_STR, GLOBALLEVEL_KEY, DEVICE_MAX_FILE_NUM_STR, DEVICE_MAX_FILE_SIZE_STR, DEVICE_OS_MAX_FILE_NUM_STR,
        DEVICE_OS_MAX_FILE_SIZE_STR, DEVICE_APP_MAX_FILE_NUM_STR, DEVICE_APP_MAX_FILE_SIZE_STR, DEVICE_NDEBUG_MAX_FILE_NUM_STR,
        DEVICE_NDEBUG_MAX_FILE_SIZE_STR, ENABLEEVENT_KEY, PERMISSION_FOR_ALL
    };
    char value[][CONF_VALUE_MAX_LEN + 1] = {
        "", "", "", "", "", "", "", "", "", "", "", ""
    };
    
    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };

    for (int i = 0; i < sizeof(value)/sizeof(value[0]); i++) {
        EXPECT_EQ(CONF_VALUE_NULL, LogConfListGetValue(confStr[i], LogStrlen(confStr[i]), val, CONF_VALUE_MAX_LEN));
        EXPECT_STREQ(value[i], val);
        memset_s(val, CONF_VALUE_MAX_LEN + 1, 0, CONF_VALUE_MAX_LEN + 1);
    }
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, LogConfListGetDigit)
{
    system("sed -i 's/DeviceOsMaxFileNum *= *.*/DeviceOsMaxFileNum=test/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceMaxFileNum *= *.*/=test/g' " SLOG_CONF_FILE_PATH);
    EXPECT_EQ(SYS_OK, LogConfInit());
    EXPECT_EQ(DEFAULT_MAX_OS_FILE_NUM, LogConfListGetDigit(DEVICE_OS_MAX_FILE_NUM_STR, MIN_FILE_NUM, MAX_FILE_NUM,
        DEFAULT_MAX_OS_FILE_NUM));
    EXPECT_EQ(DEFAULT_MAX_FILE_NUM, LogConfListGetDigit(DEVICE_MAX_FILE_NUM_STR, MIN_FILE_NUM, MAX_FILE_NUM,
        DEFAULT_MAX_FILE_NUM));
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, LogConfListUpdateNull)
{
    EXPECT_EQ(SYS_OK, LogConfInit());
    EXPECT_EQ(SUCCESS, LogConfListUpdate(NULL));
    LogConfListFree();
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, SlogdConfigMgrGetListNull)
{
    EXPECT_EQ(LOG_INVALID_PTR, SlogdConfigMgrGetList(NULL));
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, SlogdConfigMgrGetListError)
{
    StLogFileList logList = { 0 };
    MOCKER(strcpy_s).stubs().will(returnValue(EOVERLAP_AND_RESET));
    EXPECT_EQ(LOG_FAILURE, SlogdConfigMgrGetList(&logList));
    EXPECT_EQ(1, GetErrLogNum());
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, SlogdConfigMgrGetListWithInvalidValueUpper)
{
    system("sed -i 's/DeviceMaxFileNum *= *.*/DeviceMaxFileNum=1001/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceMaxFileSize *= *.*/DeviceMaxFileSize=1048576000/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsMaxFileNum *= *.*/DeviceOsMaxFileNum=1001/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsMaxFileSize *= *.*/DeviceOsMaxFileSize=1048576000/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceAppMaxFileNum *= *.*/DeviceAppMaxFileNum=1001/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceAppMaxFileSize *= *.*/DeviceAppMaxFileSize=1048576000/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsNdebugMaxFileNum *= *.*/DeviceOsNdebugMaxFileNum=1001/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsNdebugMaxFileSize *= *.*/DeviceOsNdebugMaxFileSize=1048576000/g' " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList = { 0 };
    EXPECT_EQ(LOG_SUCCESS, SlogdConfigMgrGetList(&logList));
    EXPECT_EQ(MAX_FILE_NUM, logList.maxFileNum);
    EXPECT_EQ(MAX_FILE_SIZE, logList.ulMaxFileSize);
    EXPECT_EQ(MAX_FILE_NUM, logList.maxOsFileNum);
    EXPECT_EQ(MAX_FILE_SIZE, logList.ulMaxOsFileSize);
    EXPECT_EQ(MAX_FILE_NUM, logList.maxAppFileNum);
    EXPECT_EQ(HOST_APP_FILE_MAX_SIZE, logList.ulMaxAppFileSize);
    EXPECT_EQ(MAX_FILE_NUM, logList.maxNdebugFileNum);
    EXPECT_EQ(MAX_FILE_SIZE, logList.ulMaxNdebugFileSize);
    EXPECT_STREQ(LOG_FILE_PATH, logList.aucFilePath);
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, SlogdConfigMgrGetListWithInvalidValueLower)
{
    system("sed -i 's/DeviceMaxFileNum *= *.*/DeviceMaxFileNum=0/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceMaxFileSize *= *.*/DeviceMaxFileSize=1024/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsMaxFileNum *= *.*/DeviceOsMaxFileNum=0/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsMaxFileSize *= *.*/DeviceOsMaxFileSize=1024/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceAppMaxFileNum *= *.*/DeviceAppMaxFileNum=0/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceAppMaxFileSize *= *.*/DeviceAppMaxFileSize=1024/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsNdebugMaxFileNum *= *.*/DeviceOsNdebugMaxFileNum=0/g' " SLOG_CONF_FILE_PATH);
    system("sed -i 's/DeviceOsNdebugMaxFileSize *= *.*/DeviceOsNdebugMaxFileSize=1024/g' " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList = { 0 };
    EXPECT_EQ(LOG_SUCCESS, SlogdConfigMgrGetList(&logList));
    EXPECT_EQ(MIN_FILE_NUM, logList.maxFileNum);
    EXPECT_EQ(MIN_FILE_SIZE, logList.ulMaxFileSize);
    EXPECT_EQ(MIN_FILE_NUM, logList.maxOsFileNum);
    EXPECT_EQ(MIN_FILE_SIZE, logList.ulMaxOsFileSize);
    EXPECT_EQ(MIN_FILE_NUM, logList.maxAppFileNum);
    EXPECT_EQ(HOST_APP_FILE_MIN_SIZE, logList.ulMaxAppFileSize);
    EXPECT_EQ(MIN_FILE_NUM, logList.maxNdebugFileNum);
    EXPECT_EQ(MIN_FILE_SIZE, logList.ulMaxNdebugFileSize);
    EXPECT_STREQ(LOG_FILE_PATH, logList.aucFilePath);
}

TEST_F(EP_SLOGD_CONFIG_EXCP_UTEST, SlogdConfigMgrGetBufSizeInvalid)
{
    EXPECT_EQ(0, SlogdConfigMgrGetBufSize(LOG_TYPE_MAX_NUM));
    EXPECT_EQ(1, GetErrLogNum());
}
