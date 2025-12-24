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
#include "plog_file_mgr.h"
#include "dlog_level_mgr.h"
using namespace std;
using namespace testing;

#include <dlfcn.h>
#include <cstdlib>
#include "slog.h"
#include "plog.h"
#include "alog_pub.h"
#include "slog_api.h"
#include "plog_drv.h"
#include "plog_core.h"
#include "self_log_stub.h"
#include "ascend_hal_stub.h"
#include "dlog_console.h"
#include "dlog_attr.h"
#include "plog_stub.h"
#include "log_file_util.h"

extern "C" {
    void DllMain(void);
    void DlogFree(void);
    void PlogDriverLog(int32_t moduleId, int32_t level, const char *fmt, ...);
    void DlogInitServerType(void);
}

class EP_ALOG_HOST_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("rm -rf " PATH_ROOT "/*");
        MOCKER(dlopen).stubs().will(invoke(logDlopen));
        MOCKER(dlclose).stubs().will(invoke(logDlclose));
        MOCKER(dlsym).stubs().will(invoke(logDlsym));

        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start exception test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End exception test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start exception test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End exception test suite");
    }

public:
    void DlogConstructor()
    {
        DllMain();
        (void)ProcessLogInit();
    }

    void DlogDestructor()
    {
        (void)ProcessLogFree();
        DlogFree();
    }
    bool DlogCheckPrint()
    {
    }
    bool DlogCheckPrintNum()
    {
    }
    bool DlogCheckFileValue()
    {
    }
};

// init host file list failed(malloc failed)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogFileMgrInitHostFailed)
{
    void *space = malloc(TOOL_MAX_PATH + 1);
    MOCKER(LogMalloc).stubs().will(repeat(space, 4)).then(returnValue((void *)NULL));
    MOCKER(LogFree).expects(exactly(4));
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    EXPECT_EQ(LOG_FAILURE, PlogFileMgrInit());
    EXPECT_EQ(4, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("malloc filename array failed"));
    EXPECT_EQ(1, CheckErrLog("init host file list failed"));
    free(space);
    space = NULL;
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    PlogFileMgrExit();
}

// init host file list failed(no permission)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogFileMgrInitHostFailedNoPemission)
{
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(-1));
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    EXPECT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    EXPECT_EQ(1, CheckErrLog("get valid path failed"));
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    PlogFileMgrExit();
    GlobalMockObject::verify();
    ResetErrLog();

    char path[256] = { 0 };
    (void)sprintf_s(path, 256, "%s/log", PATH_ROOT);
    setenv("ASCEND_PROCESS_LOG_PATH", path, 1);
    EXPECT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    PlogFileMgrExit();
    EXPECT_EQ(0, GetErrLogNum());
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    GlobalMockObject::verify();
}

// device日志回传落盘session异常关闭
TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogPrint_DeviceLogSessionClose)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    int32_t devId = 0;
    MOCKER(DrvBufRead).stubs().will(invoke(DrvBufReadSessionClose));
    EXPECT_EQ(SYS_OK, DlogReportStart(devId, 0));
    MOCKER(drvHdcSessionConnect).stubs().will(invoke(drvHdcSessionConnectClose));
    DlogReportStop(devId);
    DlogDestructor();
    EXPECT_LE(1, CheckErrLog("create session failed, drvErr=34"));
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// plog初始化 hdc服务失败
TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogInit_CreateHdcClientFailed)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    MOCKER(drvHdcClientCreate).stubs().will(invoke(drvHdcClientCreate_failed));
    DlogConstructor();

    DlogDestructor();
    EXPECT_LE(1, CheckErrLog("create hdc client failed."));
    EXPECT_EQ(0, CheckErrLog("pthread(alogFlush) join failed"));
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// plog获取platform失败
TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogInit_GetPaltformFailed)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    MOCKER(DrvGetPlatformInfo).stubs().will(returnValue(-1)); // can not mocker drvGetPlatformInfo because of g_platform
    EXPECT_EQ(-1, DlogReportInitialize());

    EXPECT_EQ(0, DlogReportFinalize());
    EXPECT_EQ(1, CheckErrLog("get platform info failed."));
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// 日志级别控制
// 接口入参异常
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_setlevel_ByIntf)
{
    // 初始化级别
    int32_t enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));

    // moduleId非法
    EXPECT_EQ(SYS_ERROR, dlog_getlevel(-1, &enableEvent));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(INVLID_MOUDLE_ID + 1, DLOG_ERROR, 0));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(INVLID_MOUDLE_ID + 1, &enableEvent));

    // level非法
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(SLOG, -1, 0));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(SLOG, LOG_INVALID_LEVEL + 1, 0));

    // 恢复级别至初始化
    EXPECT_EQ(SYS_OK, dlog_setlevel(ALL_MODULE, DLOG_ERROR, 1));
}

// buffer申请失败
TEST_F(EP_ALOG_HOST_EXCP_UTEST, plog_buffer_init_failed)
{
    MOCKER(DrvBufRead).stubs().will(invoke(DrvBufReadSessionClose));
    // 初始化级别
    int32_t enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));

    // moduleId非法
    EXPECT_EQ(SYS_ERROR, dlog_getlevel(-1, &enableEvent));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(INVLID_MOUDLE_ID + 1, DLOG_ERROR, 0));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(INVLID_MOUDLE_ID + 1, &enableEvent));

    // level非法
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(SLOG, -1, 0));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(SLOG, LOG_INVALID_LEVEL + 1, 0));

    // 恢复级别至初始化
    EXPECT_EQ(SYS_OK, dlog_setlevel(ALL_MODULE, DLOG_ERROR, 1));
}

// getenv ASCEND_SLOG_PRINT_TO_STDOUT only once
TEST_F(EP_ALOG_HOST_EXCP_UTEST, dlog_check_env_stdout)
{
    unsetenv("ASCEND_SLOG_PRINT_TO_STDOUT");
    bool ret = DlogCheckEnvStdout();
    EXPECT_EQ(false, ret);

    ret = DlogCheckEnvStdout();
    EXPECT_EQ(false, ret);
}

TEST_F(EP_ALOG_HOST_EXCP_UTEST, AlogInterfaceError)
{
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_ERROR, nullptr);
    EXPECT_EQ(0, AlogCheckDebugLevel(0, 100));
    EXPECT_EQ(0, AlogCheckDebugLevel(0, -1));
}

TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogInvalidModuleId)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();
    DlogInner(-1, DLOG_INFO, "test invalid module id");
    DlogErrorInner(-1, "test invalid module id");
    DlogWarnInner(-1, "test invalid module id");
    DlogInfoInner(-1, "test invalid module id");
    DlogDebugInner(-1, "test invalid module id");
    DlogEventInner(-1, "test invalid module id");

    KeyValue stKeyValue[1];
    stKeyValue[0].kname = "game";
    stKeyValue[0].value = "over";

    DlogWithKVInner(-1, DLOG_INFO, stKeyValue, 1, "test invalid module id");

    DlogRecord(-1, DLOG_INFO, "test invalid module id");
    va_list list;
    DlogVaList(-1, DLOG_INFO, "test invalid module id", list);

    DlogInnerForC(-1, DLOG_INFO, "test invalid module id");
    DlogWithKVInnerForC(-1, DLOG_INFO, stKeyValue, 1, "test invalid module id");
    DlogRecordForC(-1, DLOG_INFO, "test invalid module id");

    PlogDriverLog(-1, DLOG_INFO, "test invalid module id");

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    EXPECT_NE(0, access(PATH_ROOT "/debug",F_OK));
    EXPECT_NE(0, access(PATH_ROOT "/run",F_OK));
    EXPECT_NE(0, access(PATH_ROOT "/security",F_OK));
}

TEST_F(EP_ALOG_HOST_EXCP_UTEST, DlogInitServerType)
{
    SetServerType(0, 0);
    DlogInitServerType();
    EXPECT_EQ(false, DlogIsPoolingDevice());

    SetServerType(0, 1);
    DlogInitServerType();
    EXPECT_EQ(false, DlogIsPoolingDevice());


    ReSetServerType();
    DlogInitServerType();
}

// init host file list failed(no permission to open)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogOpenNoPemission)
{
    // 初始化
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    MOCKER(ToolOpenWithMode).stubs().will(returnValue(-1));
    dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_EXCP_UTEST][DlogPrint_HostLogBuffFull] test for mask_debug, error_level.");

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    EXPECT_EQ(2, GetErrLogNum());
}

// init host file list failed(no permission to write)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogWriteNoPemission)
{
    // 初始化
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    MOCKER(ToolWrite).stubs().will(returnValue(-1));
    dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_EXCP_UTEST][DlogPrint_HostLogBuffFull] test for mask_debug, error_level.");

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    EXPECT_EQ(1, GetErrLogNum());
}

// init host file list failed(no permission to write)
TEST_F(EP_ALOG_HOST_EXCP_UTEST, PlogMkdirNoPemission)
{
    // 初始化
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    MOCKER(LogMkdirRecur).stubs().will(returnValue(1));
    dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_EXCP_UTEST][DlogPrint_HostLogBuffFull] test for mask_debug, error_level.");

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    EXPECT_EQ(1, GetErrLogNum());
}