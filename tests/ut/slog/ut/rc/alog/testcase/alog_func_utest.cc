/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slog.h"
#include "log_file_info.h"
#include "self_log_stub.h"
#include "alog_stub.h"
#include "dlog_attr.h"
#include "alog_to_slog.h"
#include "ascend_hal.h"
#include "dlfcn.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

extern "C" {
    void DllMain(void);
    void DlogFree(void);
}

class RC_ALOG_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        MOCKER(ShMemRead).stubs().will(invoke(ShMemRead_stub));
        MOCKER(CreatSocket).stubs().will(invoke(CreatSocket_stub));

        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("echo > " PATH_ROOT "/socket/rc_alog_socket"); // 清空socket文件
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT "/log");
        system("mkdir -p " PATH_ROOT "/socket");
        system("touch " PATH_ROOT "/socket/rc_alog_socket"); // 创建socket文件
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
        DllMain();
    }

    static void DlogDestructor()
    {
        DlogFree();
    }

    int DlogCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/RC_ALOG_FUNC_UTEST_cmd_result.txt", path);

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

    int DlogCheckSocket(const char *str)
    {
        if (access(PATH_ROOT "/socket/rc_alog_socket", F_OK) != 0) {
            return 0;
        }

        char cmd[200] = {0};
        sprintf(cmd, "grep -oa %s " PATH_ROOT "/socket/rc_alog_socket" " | wc -l", str);
        int ret = DlogCmdGetIntRet(PATH_ROOT, cmd);
        return ret;
    }
};

// alog构造旧的消息格式写socket
TEST_F(RC_ALOG_FUNC_UTEST, AlogWrite_TagMsg)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    SetShmem(MSGTYPE_TAG);
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_TagMsg] test for mask_debug, error_level.");
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_TagMsg] test for mask_debug, warn_level.");
    dlog_info(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_TagMsg] test for mask_debug, info_level.");
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_TagMsg] test for mask_debug, debug_level.");

    // 释放
    DlogDestructor();
    EXPECT_EQ(1, DlogCheckSocket("ERROR"));
    EXPECT_EQ(1, DlogCheckSocket("WARNING"));
    EXPECT_EQ(1, DlogCheckSocket("INFO"));
    EXPECT_EQ(1, DlogCheckSocket("DEBUG"));
    EXPECT_EQ(1, GetErrLogNum());
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
}

// alog构造新的消息格式（LogHead）写socket
TEST_F(RC_ALOG_FUNC_UTEST, AlogWrite_HeadMsg)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    SetShmem(MSGTYPE_STRUCT);
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_HeadMsg] test for mask_debug, error_level.");
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_HeadMsg] test for mask_debug, warn_level.");
    dlog_info(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_HeadMsg] test for mask_debug, info_level.");
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_HeadMsg] test for mask_debug, debug_level.");

    // 释放
    DlogDestructor();
    EXPECT_EQ(1, DlogCheckSocket("ERROR"));
    EXPECT_EQ(1, DlogCheckSocket("WARNING"));
    EXPECT_EQ(1, DlogCheckSocket("INFO"));
    EXPECT_EQ(1, DlogCheckSocket("DEBUG"));
    EXPECT_EQ(0, GetErrLogNum());
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
}

TEST_F(RC_ALOG_FUNC_UTEST, AlogWrite_Failed)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    SetShmem(MSGTYPE_STRUCT);
    DlogConstructor();
    MOCKER(ToolWrite).stubs().will(returnValue(-1));

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    dlog_error(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_HeadMsg] test for mask_debug, error_level.");
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_HeadMsg] test for mask_debug, warn_level.");
    dlog_info(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_HeadMsg] test for mask_debug, info_level.");
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[RC_ALOG_FUNC_UTEST][AlogWrite_HeadMsg] test for mask_debug, debug_level.");

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, DlogCheckSocket("ERROR"));
    EXPECT_EQ(0, DlogCheckSocket("WARNING"));
    EXPECT_EQ(0, DlogCheckSocket("INFO"));
    EXPECT_EQ(0, DlogCheckSocket("DEBUG"));
    EXPECT_EQ(1, GetErrLogNum());
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
}

extern "C" {
    int32_t GetSlogSocketPath(const uint32_t devId, char *socketPath, const uint32_t pathLen);
}
class GetSlogSocketPathTest : public testing::Test
{
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::reset();
    }
};

TEST_F(GetSlogSocketPathTest, GetSlogSocketPath_syslog)
{
    MOCKER(DlogCheckAttrSystem).stubs().will(returnValue(true));

    char path[WORKSPACE_PATH_MAX_LENGTH + 1] = { 0 };
    EXPECT_EQ(0, GetSlogSocketPath(0, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog", path);

    memset_s(path, WORKSPACE_PATH_MAX_LENGTH, 0, WORKSPACE_PATH_MAX_LENGTH);
    EXPECT_EQ(0, GetSlogSocketPath(32, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog_32", path);
    GlobalMockObject::reset();
}

TEST_F(GetSlogSocketPathTest, GetSlogSocketPath_alogWithSameUser)
{
    struct passwd curInfo;
    curInfo.pw_name = "HwHiAiUser";
    curInfo.pw_uid = (uid_t)12345;
    MOCKER(DlogCheckAttrSystem).stubs().will(returnValue(false));
    MOCKER(DlogGetUid).stubs().will(returnValue(uint32_t(12345)));
    MOCKER(getpwuid).stubs().with(any()).will(returnValue(&curInfo));

    ToolStat dirStat = {0};
    dirStat.st_uid = (uid_t)12345;
    MOCKER(ToolStatGet).stubs().with(any(), outBoundP(&dirStat)).will(returnValue(0));

    char path[WORKSPACE_PATH_MAX_LENGTH + 1] = { 0 };
    EXPECT_EQ(0, GetSlogSocketPath(0, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog", path);

    memset_s(path, WORKSPACE_PATH_MAX_LENGTH, 0, WORKSPACE_PATH_MAX_LENGTH);
    EXPECT_EQ(0, GetSlogSocketPath(32, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog_32", path);
}

TEST_F(GetSlogSocketPathTest, GetSlogSocketPath_alogWithDiffUser)
{
    struct passwd curInfo;
    curInfo.pw_name = "CustAiCpuUser";
    curInfo.pw_uid = (uid_t)54321;
    MOCKER(DlogCheckAttrSystem).stubs().will(returnValue(false));
    MOCKER(DlogGetUid).stubs().will(returnValue(uint32_t(54321)));
    MOCKER(getpwuid).stubs().with(any()).will(returnValue(&curInfo));

    ToolStat dirStat = {0};
    dirStat.st_uid = (uid_t)12345;
    MOCKER(ToolStatGet).stubs().with(any(), outBoundP(&dirStat)).will(returnValue(0));
    MOCKER(ToolAccess).stubs().will(returnValue(0));

    char path[WORKSPACE_PATH_MAX_LENGTH + 1] = { 0 };
    EXPECT_EQ(0, GetSlogSocketPath(0, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog_app", path);

    memset_s(path, WORKSPACE_PATH_MAX_LENGTH, 0, WORKSPACE_PATH_MAX_LENGTH);
    EXPECT_EQ(0, GetSlogSocketPath(32, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog_32", path);
}

TEST_F(GetSlogSocketPathTest, GetSlogSocketPath_alogWithDiffUserInvalidPath)
{
    struct passwd curInfo;
    curInfo.pw_name = "CustAiCpuUser";
    curInfo.pw_uid = (uid_t)54321;
    MOCKER(DlogCheckAttrSystem).stubs().will(returnValue(false));
    MOCKER(DlogGetUid).stubs().will(returnValue(uint32_t(54321)));
    MOCKER(getpwuid).stubs().with(any()).will(returnValue(&curInfo));

    ToolStat dirStat = {0};
    dirStat.st_uid = (uid_t)12345;
    MOCKER(ToolStatGet).stubs().with(any(), outBoundP(&dirStat)).will(returnValue(0));
    MOCKER(ToolAccess).stubs().will(returnValue(-1));

    char path[WORKSPACE_PATH_MAX_LENGTH + 1] = { 0 };
    EXPECT_EQ(0, GetSlogSocketPath(0, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog", path);

    memset_s(path, WORKSPACE_PATH_MAX_LENGTH, 0, WORKSPACE_PATH_MAX_LENGTH);
    EXPECT_EQ(0, GetSlogSocketPath(32, path, WORKSPACE_PATH_MAX_LENGTH));
    EXPECT_STREQ("/usr/slog/slog_32", path);
}

TEST_F(RC_ALOG_FUNC_UTEST, TransferToSlog)
{
    MOCKER(dlopen).stubs().will(invoke(logDlopen));
    MOCKER(dlclose).stubs().will(invoke(logDlclose));
    MOCKER(dlsym).stubs().will(invoke(logDlsym));
    DlogConstructor();

    DlogInner(1, DLOG_INFO, "test %s", "dlog");
    DlogErrorInner(1, "test %s", "dlog");
    DlogWarnInner(1, "test %s", "dlog");
    DlogInfoInner(1, "test %s", "dlog");
    DlogDebugInner(1, "test %s", "dlog");
    DlogEventInner(1, "test %s", "dlog");
    DlogRecord(1, DLOG_INFO, "test %s", "dlog");
    va_list list;
    DlogVaList(1, DLOG_INFO, "test %s", list);
    DlogInnerForC(1, DLOG_INFO, "test %s", "dlog");
    DlogRecordForC(1, DLOG_INFO, "test %s", "dlog");

    dlog_init();
    int32_t enableEvent;
    dlog_getlevel(1, &enableEvent);
    dlog_setlevel(-1, DLOG_INFO, 1);
    CheckLogLevel(1, DLOG_INFO);
    LogAttr getLogAttr;
    DlogGetAttr(&getLogAttr);
    LogAttr logAttr;
    (void)memset_s(&(logAttr), sizeof(logAttr), DLOG_ATTR_INIT_VALUE, sizeof(logAttr));
    logAttr.type = APPLICATION;
    DlogSetAttr(logAttr);
    DlogFlush();

    EXPECT_EQ(1, GetSlogFuncCallCount(DLOG_INIT));
    EXPECT_EQ(1, GetSlogFuncCallCount(DLOG_GET_LEVEL));
    EXPECT_EQ(1, GetSlogFuncCallCount(DLOG_SET_LEVEL));
    EXPECT_EQ(1, GetSlogFuncCallCount(CHECK_LOG_LEVEL));
    EXPECT_EQ(1, GetSlogFuncCallCount(DLOG_GET_ATTR));
    EXPECT_EQ(2, GetSlogFuncCallCount(DLOG_SET_ATTR));  // alog so 构造函数中会调用一次
    EXPECT_EQ(10, GetSlogFuncCallCount(DLOG_VA_LIST));
    EXPECT_EQ(1, GetSlogFuncCallCount(DLOG_FLUSH));
    DlogDestructor();
}

TEST_F(RC_ALOG_FUNC_UTEST, compatibility)
{
    MOCKER(dlopen).stubs().will(invoke(logDlopen));
    MOCKER(dlclose).stubs().will(invoke(logDlclose));
    MOCKER(dlsym).stubs().will(returnValue((void*)nullptr));

    EXPECT_EQ(LOG_FAILURE, AlogTryUseSlog());

    GlobalMockObject::verify();
    MOCKER(dlopen).stubs().will(invoke(logDlopen)).then(invoke(logDlopen)).then(invoke(logDlopen)).then(returnValue((void*)nullptr));
    MOCKER(dlclose).stubs().will(invoke(logDlclose));
    MOCKER(dlsym).stubs().will(invoke(logDlsym)).then(invoke(logDlsym)).then(returnValue((void*)nullptr));
    MOCKER(DlogSetAttr).stubs().will(returnValue(LOG_FAILURE));
    EXPECT_EQ(LOG_FAILURE, AlogTransferToSlog());
    EXPECT_EQ(LOG_FAILURE, AlogTransferToSlog());
    EXPECT_EQ(LOG_FAILURE, AlogTransferToSlog());
}