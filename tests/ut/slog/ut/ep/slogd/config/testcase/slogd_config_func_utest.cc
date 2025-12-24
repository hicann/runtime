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
    extern ToolMutex g_confMutex;
}

class EP_SLOGD_CONFIG_FUNC_UTEST : public testing::Test
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
        EXPECT_EQ(0, GetErrLogNum());
        system("rm -rf " DEFAULT_LOG_WORKSPACE "/*");
        system("rm -rf " LOG_FILE_PATH "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
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

// log_config_api.h
TEST_F(EP_SLOGD_CONFIG_FUNC_UTEST, LogConfInit)
{
    EXPECT_EQ(SYS_OK, LogConfInit());
    EXPECT_STREQ(SLOG_CONF_FILE_PATH, LogConfGetPath());
    LogConfListFree();
}

// log_config_list.h
TEST_F(EP_SLOGD_CONFIG_FUNC_UTEST, LogConfListInit)
{
    EXPECT_EQ(SUCCESS, LogConfListInit(SLOG_CONF_FILE_PATH));
    LogConfListFree();
}

static int32_t LogConfListTraverseFunc(const Buff *node, ArgPtr arg, bool isNewStyle)
{
    return SYS_OK;
}

TEST_F(EP_SLOGD_CONFIG_FUNC_UTEST, LogConfListTraverse)
{
    EXPECT_EQ(SYS_OK, LogConfInit());
    EXPECT_EQ(SYS_OK, LogConfListTraverse(LogConfListTraverseFunc, NULL, false));
    LogConfListFree();
}

TEST_F(EP_SLOGD_CONFIG_FUNC_UTEST, LogConfListGetValue)
{
    EXPECT_EQ(SYS_OK, LogConfInit());
    char confStr[][CONF_VALUE_MAX_LEN + 1] = {
        LOG_AGENT_FILE_DIR_STR, GLOBALLEVEL_KEY, DEVICE_MAX_FILE_NUM_STR, DEVICE_MAX_FILE_SIZE_STR, DEVICE_OS_MAX_FILE_NUM_STR,
        DEVICE_OS_MAX_FILE_SIZE_STR, DEVICE_APP_MAX_FILE_NUM_STR, DEVICE_APP_MAX_FILE_SIZE_STR, DEVICE_NDEBUG_MAX_FILE_NUM_STR,
        DEVICE_NDEBUG_MAX_FILE_SIZE_STR, ENABLEEVENT_KEY, PERMISSION_FOR_ALL
    };
    char value[][CONF_VALUE_MAX_LEN + 1] = {
        LOG_FILE_PATH, "0", "8", "2097152", "2", "1048576", "2", "524288", "2", "1048576", "1", "0"
    };
    
    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };

    for (int i = 0; i < sizeof(value)/sizeof(value[0]); i++) {
        EXPECT_EQ(SUCCESS, LogConfListGetValue(confStr[i], LogStrlen(confStr[i]), val, CONF_VALUE_MAX_LEN));
        EXPECT_STREQ(value[i], val);
        memset_s(val, CONF_VALUE_MAX_LEN + 1, 0, CONF_VALUE_MAX_LEN + 1);
    }

    EXPECT_STREQ("", val);
    memset_s(val, CONF_VALUE_MAX_LEN + 1, 0, CONF_VALUE_MAX_LEN + 1);

    LogConfListFree();
}

TEST_F(EP_SLOGD_CONFIG_FUNC_UTEST, LogConfListUpdate)
{
    EXPECT_EQ(SYS_OK, LogConfInit());
    EXPECT_EQ(SUCCESS, LogConfListUpdate(SLOG_CONF_FILE_PATH));
    LogConfListFree();
}

TEST_F(EP_SLOGD_CONFIG_FUNC_UTEST, SlogdConfigMgrGetList)
{
    SlogdConfigMgrInit();
    StLogFileList logList = { 0 };
    EXPECT_EQ(SUCCESS, SlogdConfigMgrGetList(&logList));
    EXPECT_EQ(8, logList.maxFileNum);
    EXPECT_EQ(2097152, logList.ulMaxFileSize);
    EXPECT_EQ(2, logList.maxOsFileNum);
    EXPECT_EQ(1048576, logList.ulMaxOsFileSize);
    EXPECT_EQ(2, logList.maxAppFileNum);
    EXPECT_EQ(524288, logList.ulMaxAppFileSize);
    EXPECT_EQ(2, logList.maxNdebugFileNum);
    EXPECT_EQ(1048576, logList.ulMaxNdebugFileSize);
    EXPECT_STREQ(LOG_FILE_PATH, logList.aucFilePath);
    LogConfListFree();
}

// slogd_config_mgr.h
TEST_F(EP_SLOGD_CONFIG_FUNC_UTEST, SlogdConfigGetItem)
{
    SlogdConfigMgrInit();
    EXPECT_EQ(2097152, SlogdConfigMgrGetBufSize(DEBUG_SYS_LOG_TYPE));
    EXPECT_EQ(65536, SlogdConfigMgrGetBufSize(DEBUG_APP_LOG_TYPE));
    EXPECT_EQ(8, SlogdConfigMgrGetDeviceAppDirNums());
    SlogdConfigMgrExit();
}
