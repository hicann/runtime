/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_daemon.h"
#include "log_config_api.h"
#include "log_common.h"
#include "log_pm.h"
#include "log_print.h"
#include "start_single_process.h"
#include "log_pm_sig.h"
#include "log_path_mgr.h"
#include "event_process_core.h"
#include "stackcore_file_monitor.h"
#ifdef IAM_MONITOR
#include "iam.h"
#endif

struct Options {
    int n;
    int l;
};

STATIC void ParseLogdaemonArgv(int argc, char * const *argv, struct Options *opt)
{
    ONE_ACT_NO_LOG(argv == NULL, return);
    ONE_ACT_NO_LOG(opt == NULL, return);
    int opts = getopt(argc, argv, "nh:");
    while (opts != -1) {  // no use in multi-thread
        switch (opts) {
            case 'n':
                opt->n = 1;
                break;
            case 'h':
            default:
                break;
        }
        opts = getopt(argc, argv, "nh:");
    }
}

#ifdef EP_MODE
#include "sys_monitor_frame.h"
#include "log_daemon_server.h"
STATIC void InitFileServer(void)
{
    if (LogDaemonServersInit() != LOG_SUCCESS) {
        SELF_LOG_ERROR("init log daemon server failed");
    }
}

STATIC void ExitFileServer(void)
{
    LogDaemonServersExit();
}

STATIC void StartSysmonitorThread(void)
{
    if (SysmonitorInit() != LOG_SUCCESS) {
        SELF_LOG_ERROR("init sys monitor failed");
        return;
    }
    if (SysmonitorProcess() != LOG_SUCCESS) {
        SELF_LOG_ERROR("start sys monitor failed");
    }
}

STATIC void ExitSysmonitorThread(void)
{
    SysmonitorExit();
}
#elif defined LOG_COREDUMP
STATIC void InitFileServer(void)
{
    int32_t ret = EventThreadCreate();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return, "create event thread failed, ret = %d.", ret);

    ret = StackcoreMonitorInit(NULL);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return, "init stackcore monitor failed, ret = %d.", ret);
}

STATIC void ExitFileServer(void)
{
    EventThreadRelease();
    StackcoreMonitorExit();
    return;
}

STATIC void StartSysmonitorThread(void)
{
    return;
}

STATIC void ExitSysmonitorThread(void)
{
    return;
}

#else
STATIC void InitFileServer(void)
{
    return;
}

STATIC void ExitFileServer(void)
{
    return;
}

STATIC void StartSysmonitorThread(void)
{
    return;
}

STATIC void ExitSysmonitorThread(void)
{
    return;
}
#endif

/**
* @brief    : log-daemon init config file path and self log path
* @return   : LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC void LogDaemonConfigInit(void)
{
    if (LogConfInit() != LOG_SUCCESS) {
        SYSLOG_WARN("can not conf and continue.....");
    }

    if (LogPathMgrInit() != LOG_SUCCESS) {
        SYSLOG_WARN("can not init file path for self log and continue....\n");
    }
}

STATIC void LogDaemonConfigExit(void)
{
    LogConfListFree();
    LogPathMgrExit();
    ExitFileServer();
}

STATIC void MainUninit(void)
{
    LogDaemonConfigExit();
    LogPmStop();
}

STATIC int MainInit(int argc, char * const *argv)
{
    int nochdir = 1;
    int noclose = 1;
    struct Options opt = { 0, 0 };

    // Set up signal handlers (so that they interrupt read())
    LogSignalRecord(SIGTERM);
    LogSignalRecord(SIGINT);
    LogSignalIgn(SIGHUP);
#ifdef IAM_MONITOR
    LogSignalIgn(SIGPIPE);
#endif
    LogDaemonConfigInit();
    bool isFinished = false;
    do {
        ParseLogdaemonArgv(argc, argv, &opt);
        // create daemon
        if ((opt.n == 0) && (daemon(nochdir, noclose) < 0)) {
            SELF_LOG_ERROR("create daemon failed, strerr=%s, quit log-daemon process.", strerror(ToolGetErrorCode()));
            break;
        }
        if (LogPmStart(LOGDAEMON_MONITOR_FLAG, false) != LOG_SUCCESS) {
            break;
        }

        isFinished = true;
    } while (0);

    TWO_ACT_NO_LOG(!isFinished, MainUninit(), return LOG_FAILURE);
    return LOG_SUCCESS;
}

STATIC void ReleaseResource(void)
{
    // Stop bbox main thread here.
    BboxStopMainThread();
    LogDaemonConfigExit();
    LogPmStop();
    ExitSysmonitorThread();
}

#ifndef __IDE_UT
int32_t main(int32_t argc, char **argv)
#else
int32_t LogDaemonTest(int32_t argc, char **argv)
#endif
{
    SELF_LOG_INFO("log-daemon process init...");
    ONE_ACT_NO_LOG(MainInit(argc, argv) != LOG_SUCCESS, return LOG_FAILURE);

    // Start bbox main thread here.
    BboxStartMainThread();

    // init server to export file
    InitFileServer();

    // start sys resourse monitor thread
    StartSysmonitorThread();

    // wait until exit
    SELF_LOG_INFO("log-daemon process started...");
    while (LogGetSigNo() == 0) {
        (void)ToolSleep(ONE_SECOND);
    }
    SELF_LOG_ERROR("log-daemon process quit...");
    ReleaseResource();
    return LOG_SUCCESS;
}
