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
#include "ascend_hal_stub.h"
#include "self_log_stub.h"
#include "slogd_flush.h"
#include "log_path_mgr.h"
#include "slogd_appnum_watch.h"
#include "slogd_config_mgr.h"
#include "log_sys_report.h"
#include "log_sys_get.h"
#include "adcore_api.h"
#include "log_communication.h"
#include "log_drv.h"

using namespace std;
using namespace testing;

extern "C" {
extern ToolMutex g_confMutex;
extern SlogdStatus g_slogdStatus;
extern StLogFileList g_fileList;
}

class EP_SLOGD_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        DlogConstructor();
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        MOCKER(CreateAppLogWatchThread).stubs();
    }

    virtual void TearDown()
    {
        DlogDestructor();
        system("rm -rf " DEFAULT_LOG_WORKSPACE "/*");
        system("rm -rf " LOG_FILE_PATH "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " DEFAULT_LOG_WORKSPACE);
        system("mkdir -p " LOG_FILE_PATH);
        system("touch " KERNEL_LOG_PATH);
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " DEFAULT_LOG_WORKSPACE);
        system("rm -rf " LOG_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    static void DlogConstructor()
    {
        g_confMutex = TOOL_MUTEX_INITIALIZER;
        g_slogdStatus = SLOGD_RUNNING;
        LogRecordSigNo(0);
    }

    int SlogdCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/MDC_SLOGD_FLUSH_FUNC_UTEST_cmd_result.txt", path);

        char cmdToFile[400] = {0};
        sprintf(cmdToFile, "%s > %s", cmd, resultFile);
        system(cmdToFile);

        char buf[100] = {0};
        FILE *fp = fopen(resultFile, "r");
        if (fp == NULL) {
            return 0;
        }
        int size = fread(buf, 1, 100, fp);
        fclose(fp);
        if (size == 0) {
            return 0;
        }
        return atoi(buf);
    }
    static void DlogDestructor() {
        log_release_buffer();
    }
    int32_t SlogdGetPrintNum(const char *path, const char *dir)
    {
        char cmd[200] = {0};
        sprintf(cmd, " cat %s/%s/* | wc -l", path, dir);

        int ret = SlogdCmdGetIntRet(path, cmd);
        return ret;
    }
};

static void *MallocStub(size_t len)
{
    void *buf = malloc(len);
    (void)memset_s(buf, len, 0, len);
    return buf;
}

TEST_F(EP_SLOGD_EXCP_UTEST, FlushLogMallocFailed)
{
    // 初始化
    LogRecordSigNo(0);
    char *path = LOG_FILE_PATH;
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogGetRootPath).stubs().will(returnValue(path));
    SlogdConfigMgrInit();
    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    sleep(1);
    EXPECT_LT(0, GetErrLogNum());
    // 释放
    LogRecordSigNo(15);
    SlogdFlushExit();
    SlogdConfigMgrExit();
}