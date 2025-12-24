/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "self_log_stub.h"
#include "ascend_hal_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "log_common.h"
#include "slogd_eventlog.h"
#include "log_path_mgr.h"
#include "log_level_parse.h"

using namespace std;
using namespace testing;

extern "C" {
void SlogdEventlogReceive(void *args);
int32_t SlogdEventlogRegister(void);
int32_t SlogdEventlogWrite(const char *msg, uint32_t msgLen, const LogInfo *info);
}

class EP_SLOGD_EVENT_LOG_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
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
        EXPECT_EQ(0, SlogdEventlogRegister());
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        SlogdEventlogExit();
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    int DlogCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/EP_SLOGD_FUNC_STEST_cmd_result.txt", path);

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

    int DlogCheckLog(const char *path, const char *str)
    {
        if (access(path, F_OK) != 0) {
            return 0;
        }

        char cmd[200] = {0};
        sprintf(cmd, "cat %s | grep -i %s | wc -l", path, str);
        int ret = DlogCmdGetIntRet(PATH_ROOT, cmd);
        return ret;
    }
};

static int32_t g_eventFileFd = -1;
int32_t SlogdEventlogWrite_stub(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    (void)info;
    if (g_eventFileFd == -1) {
        g_eventFileFd = open(LOG_FILE_PATH "/event/event_2025022835702082.log", O_CREAT | O_RDWR, 0644);
        EXPECT_LT(0, g_eventFileFd);
    }
    write(g_eventFileFd, msg, msgLen);
    return 0;
}

static void ClearFd(void)
{
    if (g_eventFileFd != -1) {
        close(g_eventFileFd);
        g_eventFileFd = -1;
    }
}

TEST_F(EP_SLOGD_EVENT_LOG_FUNC_UTEST, SlogdEventLogReceive_malloc_failed)
{
    system("mkdir -p " LOG_FILE_PATH "/event");
    system("touch " LOG_FILE_PATH "/event/event_2025022835702082.log");
    int32_t devId = 0;
    void *args = (void *)&devId;
    MOCKER(SlogdEventlogWrite).stubs().will(invoke(SlogdEventlogWrite_stub));
    MOCKER(LogMalloc).stubs().will(returnValue((void *)0));
    SlogdEventlogReceive(args);

    EXPECT_EQ(0, DlogCheckLog(LOG_FILE_PATH "/event/event_2025022835702082.log", "EVENT"));
    ClearFd();
}

TEST_F(EP_SLOGD_EVENT_LOG_FUNC_UTEST, SlogdEventLogReceive_no_data)
{
    system("mkdir -p " LOG_FILE_PATH "/event");
    system("touch " LOG_FILE_PATH "/event/event_2025022835702082.log");
    int32_t devId = 0;
    void *args = (void *)&devId;

    MOCKER(log_read_by_type).stubs().will(invoke(log_read_by_type_stub_no_data));
    MOCKER(SlogdEventlogWrite).stubs().will(invoke(SlogdEventlogWrite_stub));
    for (int32_t cnt = 0; cnt < 10; cnt++) {
        SlogdEventlogReceive(args);
    }
    EXPECT_EQ(0, DlogCheckLog(LOG_FILE_PATH "/event/event_2025022835702082.log", "EVENT"));
    ClearFd();
}

TEST_F(EP_SLOGD_EVENT_LOG_FUNC_UTEST, SlogdEventLogReceive_success)
{
    system("mkdir -p " LOG_FILE_PATH "/event");
    system("touch " LOG_FILE_PATH "/event/event_2025022835702082.log");
    int32_t devId = 0;
    void *args = (void *)&devId;

    int32_t exceptNums = 10;
    MOCKER(log_read_by_type).stubs().will(invoke(log_read_by_type_stub_data));
    MOCKER(SlogdEventlogWrite).stubs().will(invoke(SlogdEventlogWrite_stub));
    for (int32_t cnt = 0; cnt < exceptNums; cnt++) {
        SlogdEventlogReceive(args);
    }
    EXPECT_EQ(exceptNums, DlogCheckLog(LOG_FILE_PATH "/event/event_2025022835702082.log", "EVENT"));
    ClearFd();
}

TEST_F(EP_SLOGD_EVENT_LOG_FUNC_UTEST, SlogdEventLogReceive_disable_event)
{
    SlogdSetEventLevel(0);
    system("mkdir -p " LOG_FILE_PATH "/event");
    system("touch " LOG_FILE_PATH "/event/event_2025022835702082.log");
    int32_t devId = 0;
    void *args = (void *)&devId;

    int32_t exceptNums = 10;
    MOCKER(log_read_by_type).stubs().will(invoke(log_read_by_type_stub_data));
    MOCKER(SlogdEventlogWrite).stubs().will(invoke(SlogdEventlogWrite_stub));
    for (int32_t cnt = 0; cnt < exceptNums; cnt++) {
        SlogdEventlogReceive(args);
    }
    EXPECT_EQ(0, DlogCheckLog(LOG_FILE_PATH "/event/event_2025022835702082.log", "EVENT"));
    ClearFd();
    SlogdSetEventLevel(1);
}

TEST_F(EP_SLOGD_EVENT_LOG_FUNC_UTEST, SlogdEventlogRegister_mallocFailed)
{
    SlogdEventlogExit();
    MOCKER(LogMalloc).stubs().will(returnValue((void *)0));
    EXPECT_EQ(LOG_FAILURE, SlogdEventlogRegister());
}