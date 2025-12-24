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
using namespace std;
using namespace testing;

#include <dlfcn.h>
#include "slog.h"
#include "plog.h"
#include "alog_pub.h"
#include "slog_api.h"
#include "plog_drv.h"
#include "plog_file_mgr.h"
#include "self_log_stub.h"
#include "ascend_hal_stub.h"
#include "system_api_stub.h"
#include "plog_driver_log.h"
#include "plog_stub.h"
#include "alog_to_slog.h"
#include "plog_to_dlog.h"

extern "C" {
    void DllMain(void);
    void DlogFree(void);
    int32_t ProcessLogInit(void);
    int32_t ProcessLogFree(void);
    void PlogDriverLog(int32_t moduleId, int32_t level, const char *fmt, ...);
    extern bool g_dlogLevelChanged;
    extern int32_t g_plogSyncMode;
}

class EP_ALOG_HOST_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("rm -rf " PATH_ROOT "/*");
        MOCKER(dlopen).stubs().will(invoke(logDlopen));
        MOCKER(dlclose).stubs().will(invoke(logDlclose));
        MOCKER(dlsym).stubs().will(invoke(logDlsym));
        g_dlogLevelChanged = false;
        g_plogSyncMode = 0;

        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        EXPECT_EQ(0, GetErrLogNum());
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
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
        (void)ProcessLogInit();
    }

    static void DlogDestructor()
    {
        (void)ProcessLogFree();
        DlogFree();
    }

    bool DlogCheckPrint()
    {
    }

    int DlogCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/EP_ALOG_HOST_FUNC_STEST_cmd_result.txt", path);

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

    int32_t DlogCheckHostPrintNum(const char *path, const char *dir)
    {
        char plogPath[200] = {0};
        sprintf(plogPath, "%s/%s/plog", path, dir);
        // 目录不存在，日志数量为 0
        if (access(plogPath, F_OK) != 0) {
            printf("dir does not exist.");
            return 0;
        }

        char cmd[200] = {0};
        sprintf(cmd, "ls -lR %s/%s/plog/* | grep \"^-\" | wc -l", path, dir);
        int32_t ret = DlogCmdGetIntRet(path, cmd);
        if (ret == 1) {
            sprintf(cmd, "wc -l %s/%s/plog/* | awk '{print $1}'", path, dir);
            ret = DlogCmdGetIntRet(path, cmd);
        } else {
            sprintf(cmd, "wc -l %s/%s/plog/* | grep total | awk '{print $1}'", path, dir);
            ret = DlogCmdGetIntRet(path, cmd);
        }
        return ret;
    }

    bool DlogCheckDevicePrintNum(const char *path, int32_t devId, const char *dir, int32_t num)
    {
        char devLogPath[200] = {0};
        sprintf(devLogPath, "%s/%s/device-%d", path, dir, devId);
        // 目录不存在，日志数量为 0
        if (access(devLogPath, F_OK) != 0) {
            printf("dir does not exist.");
            return (num == 0) ? true : false;
        }

        char cmd[200] = {0};
        sprintf(cmd, "ls -lR %s/* | grep \"^-\" | wc -l", devLogPath);

        int ret = DlogCmdGetIntRet(path, cmd);
        if (ret == 1) {
            sprintf(cmd, "wc -l %s/* | awk '{print $1}'", devLogPath);
            ret = DlogCmdGetIntRet(path, cmd);
        } else {
            sprintf(cmd, "wc -l %s/* | grep total | awk '{print $1}'", devLogPath);
            ret = DlogCmdGetIntRet(path, cmd);
        }

        if (ret != num) {
            printf("log num=%d.\n", ret);
            return false;
        }
        return true;
    }

    bool DlogCheckFileValue()
    {
    }
};

// host日志落盘
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLog)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    Dlog(SLOG | DEBUG_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint] test for mask_debug, error_level.");
    dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, error_level.");

    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, warn_level.");

    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    dlog_info(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, info_level.");

    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, debug_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    dlog_error(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, error_level.");

    // 打印 DLOG_WARN | RUN_LOG_MASK
    dlog_warn(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, warn_level.");

    // 打印 DLOG_INFO | RUN_LOG_MASK
    dlog_info(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, info_level.");

    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    dlog_debug(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, debug_level.");

    // 打印 DLOG_ERROR | SECURITY_LOG_MASK

    // 打印 DLOG_WARN | SECURITY_LOG_MASK

    // 打印 DLOG_INFO | SECURITY_LOG_MASK

    // 打印 DLOG_DEBUG | SECURITY_LOG_MASK

    // 打印 EVENT

    // 打印 STDOUT

    // 释放
    DlogDestructor();
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 5);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "run"), 3);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// host日志通过接口打屏
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLogInterface_Stdout)
{
    // 初始化
    DlogConstructor();
    // 打印 DLOG_ERROR | STDOUT_LOG_MASK
    DlogRecord(SLOG | STDOUT_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_stdout, error_level.");
    // 打印 DLOG_WARN | STDOUT_LOG_MASK
    DlogRecord(SLOG | STDOUT_LOG_MASK, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_stdout, warn_level.");
    // 打印 DLOG_INFO | STDOUT_LOG_MASK
    DlogRecord(SLOG | STDOUT_LOG_MASK, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_stdout, info_level.");
    // 打印 DLOG_DEBUG | STDOUT_LOG_MASK
    DlogRecord(SLOG | STDOUT_LOG_MASK, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_stdout, debug_level.");

    // 释放
    DlogDestructor();
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 0);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "run"), 0);
    EXPECT_EQ(0, GetErrLogNum());
}

// host日志通过接口落盘
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLogInterface)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    DlogRecord(SLOG | DEBUG_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, error_level.");

    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    DlogRecord(SLOG | DEBUG_LOG_MASK, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, warn_level.");

    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    DlogRecord(SLOG | DEBUG_LOG_MASK, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, info_level.");

    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    DlogRecord(SLOG | DEBUG_LOG_MASK, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, debug_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    DlogRecord(SLOG | RUN_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, error_level.");

    // 打印 DLOG_WARN | RUN_LOG_MASK
    DlogRecord(SLOG | RUN_LOG_MASK, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, warn_level.");

    // 打印 DLOG_INFO | RUN_LOG_MASK
    DlogRecord(SLOG | RUN_LOG_MASK, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, info_level.");

    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    DlogRecord(SLOG | RUN_LOG_MASK, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, debug_level.");

    // 释放
    DlogDestructor();
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 4);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "run"), 3);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// host日志落盘
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLogForC)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    DlogForC(SLOG | DEBUG_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint] test for mask_debug, error_level.");

    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    DlogForC(SLOG | DEBUG_LOG_MASK, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, warn_level.");

    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    DlogForC(SLOG | DEBUG_LOG_MASK, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, info_level.");

    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    DlogForC(SLOG | DEBUG_LOG_MASK, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, debug_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    DlogForC(SLOG | RUN_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, error_level.");

    // 打印 DLOG_WARN | RUN_LOG_MASK
    DlogForC(SLOG | RUN_LOG_MASK, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, warn_level.");

    // 打印 DLOG_INFO | RUN_LOG_MASK
    DlogForC(SLOG | RUN_LOG_MASK, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, info_level.");

    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    DlogForC(SLOG | RUN_LOG_MASK, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, debug_level.");

    // 释放
    DlogDestructor();
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 4);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "run"), 3);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// host日志通过接口落盘
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLogForCInterface)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    DlogRecordForC(SLOG | DEBUG_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint] test for mask_debug, error_level.");

    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    DlogRecordForC(SLOG | DEBUG_LOG_MASK, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, warn_level.");

    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    DlogRecordForC(SLOG | DEBUG_LOG_MASK, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, info_level.");

    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    DlogRecordForC(SLOG | DEBUG_LOG_MASK, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, debug_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    DlogRecordForC(SLOG | RUN_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, error_level.");

    // 打印 DLOG_WARN | RUN_LOG_MASK
    DlogRecordForC(SLOG | RUN_LOG_MASK, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, warn_level.");

    // 打印 DLOG_INFO | RUN_LOG_MASK
    DlogRecordForC(SLOG | RUN_LOG_MASK, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, info_level.");

    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    DlogRecordForC(SLOG | RUN_LOG_MASK, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, debug_level.");

    // 释放
    DlogDestructor();
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 4);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "run"), 3);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// host日志落盘——DlogFlush
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLog_DlogFlush)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    DlogForC(SLOG | DEBUG_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint] test for mask_debug, error_level.");

    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    DlogForC(SLOG | DEBUG_LOG_MASK, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, warn_level.");

    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    DlogForC(SLOG | DEBUG_LOG_MASK, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, info_level.");

    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    DlogForC(SLOG | DEBUG_LOG_MASK, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, debug_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    DlogForC(SLOG | RUN_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, error_level.");

    // 打印 DLOG_WARN | RUN_LOG_MASK
    DlogForC(SLOG | RUN_LOG_MASK, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, warn_level.");

    // 打印 DLOG_INFO | RUN_LOG_MASK
    DlogForC(SLOG | RUN_LOG_MASK, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, info_level.");

    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    DlogForC(SLOG | RUN_LOG_MASK, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, debug_level.");

    DlogFlush();

    // 释放
    DlogDestructor();
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 4);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "run"), 3);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// host日志落盘——ASCEND_WORK_PATH
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLog_WorkPath)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_WORK_PATH", PATH_ROOT, 1);
    DlogConstructor();

    // 向debug目录下打印日志
    dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_WorkPath] test for mask_debug, error_level.");
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_WorkPath] test for mask_debug, warn_level.");
    dlog_info(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_WorkPath] test for mask_debug, info_level.");
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_WorkPath] test for mask_debug, debug_level.");

    // 向run目录下打印日志
    dlog_error(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_WorkPath] test for mask_run, error_level.");
    dlog_warn(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_WorkPath] test for mask_run, warn_level.");
    dlog_info(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_WorkPath] test for mask_run, info_level.");
    dlog_debug(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_WorkPath] test for mask_run, debug_level.");
    dlog_event(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_WorkPath] test for mask_run, debug_event.");

    // 释放
    DlogDestructor();

    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT "/log", "debug"), 4);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT "/log", "run"), 4);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_WORK_PATH");
}


// host日志落盘——ASCEND_WORK_PATH & ASCEND_PROCESS_LOG_PATH
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLog_ProcessLogPath_WorkPath)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    setenv("ASCEND_WORK_PATH", PATH_ROOT, 1);
    DlogConstructor();

    // 向debug目录下打印日志
    dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_ProcessLogPath_WorkPath] test for mask_debug, error_level.");
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_ProcessLogPath_WorkPath] test for mask_debug, warn_level.");
    dlog_info(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_ProcessLogPath_WorkPath] test for mask_debug, info_level.");
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_ProcessLogPath_WorkPath] test for mask_debug, debug_level.");

    // 向run目录下打印日志
    dlog_error(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_ProcessLogPath_WorkPath] test for mask_run, error_level.");
    dlog_warn(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_ProcessLogPath_WorkPath] test for mask_run, warn_level.");
    dlog_info(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_ProcessLogPath_WorkPath] test for mask_run, info_level.");
    dlog_debug(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_ProcessLogPath_WorkPath] test for mask_run, debug_level.");
    dlog_event(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog_ProcessLogPath_WorkPath] test for mask_run, debug_event.");


    // 释放
    DlogDestructor();

    // ASCEND_PROCESS_LOG_PATH优先级更高
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT "/log", "debug"), 0);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT "/log", "run"), 0);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 4);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "run"), 4);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    unsetenv("ASCEND_WORK_PATH");
}

// device日志回传落盘
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_DeviceLog)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    setenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT", "1000", 1);
    DlogConstructor();


    int32_t devId = 0;
    MOCKER(DrvBufRead).expects(exactly(2)).will(invoke(readEndMsg));
    EXPECT_EQ(SYS_OK, DlogReportStart(devId, 0));
    DlogReportStop(devId);

    EXPECT_EQ(SYS_OK, DlogReportStart(devId, 0));
    DlogReportStop(devId);

    DlogDestructor();
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 0);
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "run"), 0);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    unsetenv("ASCEND_LOG_DEVICE_FLUSH_TIMEOUT");
}

// plog日志老化
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogAge_HostFile)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    setenv("ASCEND_HOST_LOG_FILE_NUM", "1", 1);
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    for (int i = 0; i < 10000000; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, error_level.");
    }
    // 释放
    DlogDestructor();
    EXPECT_LT(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 10000000);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    unsetenv("ASCEND_HOST_LOG_FILE_NUM");
}

TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogAge_HostFileFailed)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    setenv("ASCEND_HOST_LOG_FILE_NUM", "1", 1);
    DlogConstructor();
    MOCKER(ToolUnlink).stubs().will(returnValue(-1));

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    for (int i = 0; i < 10000000; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, error_level.");
    }
    // 释放
    DlogDestructor();
    EXPECT_EQ(DlogCheckHostPrintNum(PATH_ROOT, "debug"), 10000000);
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    unsetenv("ASCEND_HOST_LOG_FILE_NUM");
}

// 日志级别控制
// dlog_getlevel、dlog_setlevel不支持掩码，默认为debug_level
TEST_F(EP_ALOG_HOST_FUNC_UTEST, dlog_setlevel_ByIntf)
{
    // 初始化级别
    int32_t enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));

    // 设置全局日志级别，对全局（global、debug）及所有模块（debug）生效
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_ERROR, 0));
    // 校验设置结果
    EXPECT_EQ(SYS_ERROR, dlog_getlevel(-1, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | RUN_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(0, enableEvent);

    // 恢复级别至初始化
    enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));

    // 设置模块日志级别，对该模块debug生效
    EXPECT_EQ(SYS_OK, dlog_setlevel(SLOG, DLOG_ERROR, 0));
    // 校验设置结果
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | RUN_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD | RUN_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD, &enableEvent));
    EXPECT_EQ(SYS_ERROR, dlog_getlevel(-1, &enableEvent));
    EXPECT_EQ(0, enableEvent);

    // 恢复级别至初始化
    enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));

    // 设置模块调试日志级别，对该模块debug生效
    EXPECT_EQ(SYS_OK, dlog_setlevel(SLOG | DEBUG_LOG_MASK, DLOG_ERROR, 0));
    // 校验设置结果
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | RUN_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD | RUN_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD, &enableEvent));
    EXPECT_EQ(SYS_ERROR, dlog_getlevel(-1, &enableEvent));
    EXPECT_EQ(0, enableEvent);

    // 恢复级别至初始化
    enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));

    // 设置模块运行日志级别（暂不支持），对该模块debug生效
    EXPECT_EQ(SYS_OK, dlog_setlevel(SLOG | RUN_LOG_MASK, DLOG_ERROR, 0));
    // 校验设置结果
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | RUN_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD | RUN_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD, &enableEvent));
    EXPECT_EQ(SYS_ERROR, dlog_getlevel(-1, &enableEvent));
    EXPECT_EQ(0, enableEvent);

    // 恢复级别至初始化
    enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));

    // 设置模块日志级别，不带掩码默认对该模块debug生效
    EXPECT_EQ(SYS_OK, dlog_setlevel(SLOG, DLOG_ERROR, 0));
    // 校验设置结果
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG | RUN_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(SLOG, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD | RUN_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(IDEDD, &enableEvent));
    EXPECT_EQ(SYS_ERROR, dlog_getlevel(-1, &enableEvent));
    EXPECT_EQ(0, enableEvent);

    // 恢复级别至初始化
    enableEvent = -1;
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_NULL, 0));
    // 设置小核模块日志级别
    EXPECT_EQ(SYS_OK, dlog_setlevel(ISP, DLOG_ERROR, 0));
    // 校验设置结果
    EXPECT_EQ(DLOG_ERROR, dlog_getlevel(ISP | DEBUG_LOG_MASK, &enableEvent));
    EXPECT_EQ(DLOG_NULL, dlog_getlevel(SLOG | DEBUG_LOG_MASK, &enableEvent));

    // 恢复级别至初始化
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, DLOG_ERROR, 1));
}

TEST_F(EP_ALOG_HOST_FUNC_UTEST, PlogWriteDeviceLogNull)
{
    char msg[1024] = { 0 };
    PlogDeviceLogInfo info = { 0 };
    EXPECT_EQ(LOG_SUCCESS, PlogFileMgrInit());
    EXPECT_EQ(LOG_SUCCESS, PlogWriteDeviceLog(msg, &info));
    PlogFileMgrExit();
}

TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogRegisterToDriver)
{
    DlogConstructor();
    SetDrvCrlCmd(HAL_CTL_REGISTER_LOG_OUT_HANDLE);
    PlogRegisterDriverLog();

    SetDrvCrlCmd(HAL_CTL_REGISTER_RUN_LOG_OUT_HANDLE);
    PlogRegisterDriverLog();

    PlogUnregisterDriverLog();
    DlogDestructor();
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogWriteDeviceLog)
{
    MOCKER(DrvBufRead).expects(atLeast(1)).will(invoke(readDeviceMsg));
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();
    EXPECT_EQ(SYS_OK, DlogReportStart(0, 0));
    DlogDestructor();
    EXPECT_TRUE(DlogCheckDevicePrintNum(PATH_ROOT, 0, "debug", 10));
    EXPECT_TRUE(DlogCheckDevicePrintNum(PATH_ROOT, 0, "run", 0));
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

static int32_t GetLogLossNum(char *msg)
{
    char resultFile[200] = {0};
    sprintf(resultFile, "%s/LogLossResult.txt", PATH_ROOT);
    char cmd[200] = {0};
    sprintf(cmd, "cat %s/LogFile.txt | grep -a \"%s\" | awk '{print $(NF-4)}' > %s", PATH_ROOT, msg, resultFile);
    system(cmd);
    char buf[MSG_LENGTH] = {0};
    FILE *fp = fopen(resultFile, "r");
    if (fp == NULL) {
        return false;
    }
    int32_t num = 0;
    while (fgets(buf, MSG_LENGTH, fp) != NULL) {
        num += atoi(buf);
        (void)memset_s(buf, MSG_LENGTH, 0, MSG_LENGTH);
    }
    return num;
}
 
// host日志触发缓冲区满
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLogBuffFull)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();
 
    int32_t num = 6000;
    for (int i = 0; i < num; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_STEST][DlogPrint_HostLogBuffFull] test for mask_debug, error_level[%d].", i);
    }
    for (int i = 0; i < num; i++) {
        dlog_info(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_STEST][DlogPrint_HostLogBuffFull] test for mask_run, info_level[%d].", i);
    }
 
    for (int i = 0; i < num; i++) {
        dlog_info(SLOG | SECURITY_LOG_MASK, "[EP_ALOG_HOST_FUNC_STEST][DlogPrint_HostLogBuffFull] test for mask_security, info_level[%d].", i);
    }
 
    // 释放
    DlogDestructor();
    int32_t debugLoss = GetLogLossNum("debug log loss num");
    int32_t runLoss = GetLogLossNum("run log loss num");
    int32_t securityLoss = GetLogLossNum("security log loss num");
    printf("log loss num debug : %d.\n", debugLoss);
    printf("log loss num run : %d.\n", runLoss);
    printf("log loss num security : %d.\n", securityLoss);
    EXPECT_LT(0, debugLoss + runLoss + securityLoss);
    EXPECT_EQ(num, DlogCheckHostPrintNum(PATH_ROOT, "debug") + debugLoss);
    EXPECT_EQ(num, DlogCheckHostPrintNum(PATH_ROOT, "run") + runLoss);
    EXPECT_EQ(num, DlogCheckHostPrintNum(PATH_ROOT, "security") + securityLoss);

    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

// host日志触发缓冲区满
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLogBuffFullSyncEnv)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
    setenv("ASCEND_LOG_SYNC_SAVE", "1", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();
 
    int32_t num = 6000;
    for (int i = 0; i < num; i++) {
        dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_STEST][DlogPrint_HostLogBuffFull] test for mask_debug, error_level[%d].", i);
    }
    for (int i = 0; i < num; i++) {
        dlog_info(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_STEST][DlogPrint_HostLogBuffFull] test for mask_run, info_level[%d].", i);
    }
 
    for (int i = 0; i < num; i++) {
        dlog_info(SLOG | SECURITY_LOG_MASK, "[EP_ALOG_HOST_FUNC_STEST][DlogPrint_HostLogBuffFull] test for mask_security, info_level[%d].", i);
    }
 
    // 释放
    DlogDestructor();
    int32_t debugLoss = GetLogLossNum("debug log loss num");
    int32_t runLoss = GetLogLossNum("run log loss num");
    int32_t securityLoss = GetLogLossNum("security log loss num");
    printf("log loss num debug : %d.\n", debugLoss);
    printf("log loss num run : %d.\n", runLoss);
    printf("log loss num security : %d.\n", securityLoss);
    EXPECT_EQ(0, debugLoss + runLoss + securityLoss);
    EXPECT_EQ(num, DlogCheckHostPrintNum(PATH_ROOT, "debug") + debugLoss);
    EXPECT_EQ(num, DlogCheckHostPrintNum(PATH_ROOT, "run") + runLoss);
    EXPECT_EQ(num, DlogCheckHostPrintNum(PATH_ROOT, "security") + securityLoss);

    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_LOG_SYNC_SAVE");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

TEST_F(EP_ALOG_HOST_FUNC_UTEST, AlogPrint_HostLogInterface)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, error_level.");

    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, warn_level.");

    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, info_level.");

    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, debug_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, error_level.");

    // 打印 DLOG_WARN | RUN_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, warn_level.");

    // 打印 DLOG_INFO | RUN_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, info_level.");

    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, debug_level.");

    // 释放
    DlogDestructor();
    EXPECT_EQ(4, DlogCheckHostPrintNum(PATH_ROOT, "debug"));
    EXPECT_EQ(3, DlogCheckHostPrintNum(PATH_ROOT, "run"));
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

TEST_F(EP_ALOG_HOST_FUNC_UTEST, AlogCheckDebugLogLevelInterface)
{
    // global debug
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    for (uint32_t i = 0; i < INVLID_MOUDLE_ID + 1; i++) {   // invalid module id use global level
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_DEBUG));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_INFO));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_WARN));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_ERROR));
    }

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");

    // global info
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "1", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    for (uint32_t i = 0; i < INVLID_MOUDLE_ID + 1; i++) {
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_DEBUG));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_INFO));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_WARN));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_ERROR));
    }

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");

    // global warning
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "2", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    for (uint32_t i = 0; i < INVLID_MOUDLE_ID + 1; i++) {
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_DEBUG));
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_INFO));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_WARN));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_ERROR));
    }

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");

    // global error
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    for (uint32_t i = 0; i < INVLID_MOUDLE_ID + 1; i++) {
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_DEBUG));
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_INFO));
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_WARN));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_ERROR));
    }

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");

    // global error
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "4", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    for (uint32_t i = 0; i < INVLID_MOUDLE_ID + 1; i++) {
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_DEBUG));
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_INFO));
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_WARN));
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_ERROR));
    }

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");

    // global error, module debug
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
    setenv("ASCEND_MODULE_LOG_LEVEL", "SLOG=0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    for (uint32_t i = 0; i < INVLID_MOUDLE_ID + 1; i++) {
        if (i == SLOG) {
            EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_DEBUG));
            EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_INFO));
            EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_WARN));
            EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_ERROR));
            continue;
        }
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_DEBUG));
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_INFO));
        EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_WARN));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_ERROR));
    }

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_MODULE_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");

    // global debug, module warning
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_MODULE_LOG_LEVEL", "SLOG=2", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    for (uint32_t i = 0; i < INVLID_MOUDLE_ID + 1; i++) {
        if (i == SLOG) {
            EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_DEBUG));
            EXPECT_EQ(0, AlogCheckDebugLevel(i, DLOG_INFO));
            EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_WARN));
            EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_ERROR));
            continue;
        }
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_DEBUG));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_INFO));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_WARN));
        EXPECT_EQ(1, AlogCheckDebugLevel(i, DLOG_ERROR));
    }

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_MODULE_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
}

TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogAllInterface)
{
    // 初始化
    setenv("ASCEND_GLOBAL_LOG_LEVEL", "0", 1);
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();

    DlogInner(0, DLOG_INFO, "test log interface");
    DlogErrorInner(0, "test log interface");
    DlogWarnInner(0, "test log interface");
    DlogInfoInner(0, "test log interface");
    DlogDebugInner(0, "test log interface");
    DlogEventInner(0, "test log interface");

    KeyValue stKeyValue[1];
    stKeyValue[0].kname = "game";
    stKeyValue[0].value = "over";
    DlogWithKVInner(0, DLOG_INFO, stKeyValue, 1, "test log interface");

    DlogRecord(0, DLOG_INFO, "test log interface");
    va_list list;
    DlogVaList(0, DLOG_INFO, "test log interface", list);

    DlogInnerForC(0, DLOG_INFO, "test log interface");
    DlogWithKVInnerForC(0, DLOG_INFO, stKeyValue, 1, "test log interface");
    DlogRecordForC(0, DLOG_INFO, "test log interface");

    PlogDriverLog(0, DLOG_INFO, "test log interface");

    // 释放
    DlogDestructor();
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    EXPECT_EQ(12, DlogCheckHostPrintNum(PATH_ROOT, "debug"));
    EXPECT_EQ(1, DlogCheckHostPrintNum(PATH_ROOT, "run"));
    EXPECT_EQ(0, DlogCheckHostPrintNum(PATH_ROOT, "security"));
}

// host日志落盘
TEST_F(EP_ALOG_HOST_FUNC_UTEST, DlogPrint_HostLogWithUnifiedSwitch)
{
    SetUnifiedSwitch(true);
    // 初始化
    setenv("ASCEND_PROCESS_LOG_PATH", PATH_ROOT, 1);
    DlogConstructor();
    DlogReportInitialize();
    DlogReportStart(0, 0);
 
    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    Dlog(SLOG | DEBUG_LOG_MASK, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint] test for mask_debug, error_level.");
    dlog_error(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, error_level.");
 
    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    dlog_warn(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, warn_level.");
 
    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    dlog_info(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, info_level.");
 
    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    dlog_debug(SLOG | DEBUG_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, debug_level.");
 
    // 打印 DLOG_ERROR | RUN_LOG_MASK
    dlog_error(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, error_level.");
 
    // 打印 DLOG_WARN | RUN_LOG_MASK
    dlog_warn(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, warn_level.");
 
    // 打印 DLOG_INFO | RUN_LOG_MASK
    dlog_info(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, info_level.");
 
    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    dlog_debug(SLOG | RUN_LOG_MASK, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, debug_level.");

    EXPECT_EQ(1, AlogCheckDebugLevel(SLOG, DLOG_ERROR));
    // 打印 DLOG_ERROR | DEBUG_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, error_level.");

    // 打印 DLOG_WARN | DEBUG_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, warn_level.");

    // 打印 DLOG_INFO | DEBUG_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, info_level.");

    // 打印 DLOG_DEBUG | DEBUG_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_debug, debug_level.");

    // 打印 DLOG_ERROR | RUN_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_ERROR, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, error_level.");

    // 打印 DLOG_WARN | RUN_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_WARN, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, warn_level.");

    // 打印 DLOG_INFO | RUN_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_INFO, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, info_level.");

    // 打印 DLOG_DEBUG | RUN_LOG_MASK
    AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_DEBUG, "[EP_ALOG_HOST_FUNC_UTEST][DlogPrint_HostLog] test for mask_run, debug_level.");
 
    DlogReportStop(0);
    DlogReportFinalize();
    // 释放
    DlogDestructor();
    EXPECT_EQ(17, GetSlogFuncCallCount(DLOG_VA_LIST));
    EXPECT_EQ(1, GetPlogFuncCallCount(DLOG_REPORT_INITIALIZE));
    EXPECT_EQ(1, GetPlogFuncCallCount(DLOG_REPORT_FINALIZE));
    EXPECT_EQ(1, GetPlogFuncCallCount(DLOG_REPORT_START));
    EXPECT_EQ(1, GetPlogFuncCallCount(DLOG_REPORT_STOP));
    unsetenv("ASCEND_GLOBAL_LOG_LEVEL");
    unsetenv("ASCEND_PROCESS_LOG_PATH");
    SetUnifiedSwitch(false);
}