/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_monitor.h"
#include <stdbool.h>
#include "log_system_api.h"
#include "log_config_api.h"
#include "log_common.h"
#include "log_print.h"
#include "log_pm.h"

#ifdef SCRIPT_MONITOR
#include "appmon_lib.h"
#include "log_path_mgr.h"
#include "start_single_process.h"
#include "log_file_info.h"

#define HEART_BEART_RECORD 20
#define MONITOR_REGISTER_WAIT_TIME 1000
#define MONITOR_HEARTBEAT_WAIT_TIME 3000
#define MONITOR_INIT_WAIT_TIME 1000
#define MONITOR_TIMEOUT 9000
#define NUM_MONITOR_PROC 3
#define NUM_INIT_APPMOND 3
#define NUM_REGISTER_APPMOND 15
#define LOG_MONITOR_DEFAULT_THREAD_ATTR { 0, 0, 0, 0, 0, 1, 128 * 1024 }

#define SLOGD_DAEMON_SCRIPT "/var/slogd_daemon_monitor.sh"
#define SKLOGD_DAEMON_SCRIPT "/var/sklogd_daemon_monitor.sh"
#define LOG_DAEMON_SCRIPT "/var/log_daemon_monitor.sh"

enum LOG_MONITOR_STATUS {
    LOG_MONITOR_INIT = 0,
    LOG_MONITOR_RUNNING,
    LOG_MONITOR_HEARTBEAT,
    LOG_MONITOR_EXIT,
};

struct LogMonitorMgr {
    enum LOG_MONITOR_STATUS status;
    ToolThread tid;
    client_info_t clnt;
};

STATIC struct LogMonitorMgr g_logMonitorMgr = { 0 };
STATIC unsigned int g_flag = 0;
STATIC char g_logMonitorPidFile[WORKSPACE_PATH_MAX_LENGTH] = { 0 };

STATIC void LogMonitorSetStatus(enum LOG_MONITOR_STATUS status)
{
    g_logMonitorMgr.status = status;
}

STATIC bool LogMonitorIsRun(void)
{
    return (g_logMonitorMgr.status == LOG_MONITOR_RUNNING ||
            g_logMonitorMgr.status == LOG_MONITOR_HEARTBEAT);
}

STATIC bool LogMonitorIsInit(void)
{
    return (g_logMonitorMgr.status == LOG_MONITOR_INIT);
}

STATIC bool GetLogDaemonScript(char *logDaemonScript, uint32_t len)
{
    if (logDaemonScript == NULL) {
        return false;
    }
    errno_t ret = EOK;
    if (g_flag == SLOGD_MONITOR_FLAG) {
        ret = strcpy_s(logDaemonScript, len, SLOGD_DAEMON_SCRIPT);
    } else if (g_flag == SKLOGD_MONITOR_FLAG) {
        ret = strcpy_s(logDaemonScript, len, SKLOGD_DAEMON_SCRIPT);
    } else if (g_flag == LOGDAEMON_MONITOR_FLAG) {
        ret = strcpy_s(logDaemonScript, len, LOG_DAEMON_SCRIPT);
    } else {
        SELF_LOG_ERROR("monitor does not exist, flag=%u, Thread(LogMonitor) quit.", g_flag);
        return false;
    }
    ONE_ACT_ERR_LOG(ret != EOK, return false, "strcpy_s daemon script failed, ret = %d.", (int32_t)ret);
    return true;
}

STATIC bool AppMonInit(void)
{
    int32_t i = 0;
    int32_t ret = 0;
    LogMonitorSetStatus(LOG_MONITOR_EXIT);
    while (i < NUM_INIT_APPMOND) {
        if (!LogMonitorIsInit()) {
            ret = appmon_client_init(&g_logMonitorMgr.clnt, APPMON_SERVER_PATH);
            if (ret != 0) {
                SELF_LOG_ERROR("appmon client(%u) init failed, result=%d.", g_flag, ret);
                (void)ToolSleep(MONITOR_INIT_WAIT_TIME);
                i += 1;
                continue;
            }
        }
        SELF_LOG_INFO("appmon client(%u) init succeed.", g_flag);
        LogMonitorSetStatus(LOG_MONITOR_INIT);
        break;
    }

    return LogMonitorIsInit();
}

/**
 * @brief       : register to ascend_monitor
 * @param [in]  : script         register script, it will be execute when process exit
 * @return      : true success; false failure
 */
STATIC bool AppMonRegister(const char *script)
{
    int32_t retryTime = 0;
    int32_t ret = 0;
    while (retryTime < NUM_REGISTER_APPMOND) {
        ret = appmon_client_register(&g_logMonitorMgr.clnt, MONITOR_TIMEOUT, script);
        if (ret == EAGAIN) {
            (void)ToolSleep(MONITOR_REGISTER_WAIT_TIME);
            retryTime++;
            continue;
        } else if (ret != 0) {
            SELF_LOG_ERROR("appmon client(%u) register failed, result=%d.", g_flag, ret);
            return false;
        } else {
            SELF_LOG_INFO("appmon client(%u) register succeed.", g_flag);
            return true;
        }
    }
    SELF_LOG_ERROR("appmon client(%u) register failed more than %d times, result=%d.", g_flag, retryTime, ret);
    return false;
}

STATIC int32_t LogMonitorRegister(void)
{
    char logDaemonScript[CONF_FILE_MAX_LINE] = { 0 };
    if (!GetLogDaemonScript(logDaemonScript, CONF_FILE_MAX_LINE)) {
        SELF_LOG_ERROR("get log daemon script failed");
        return SYS_ERROR;
    }
    if (!AppMonInit()) {
        SELF_LOG_ERROR("appmon client(%u) init failed, Thread(LogMonitor) quit.", g_flag);
        return SYS_ERROR;
    }
    if (!AppMonRegister(logDaemonScript)) {
        return SYS_ERROR;
    }

    int32_t ret = appmon_client_heartbeat(&g_logMonitorMgr.clnt);
    if (ret != 0) {
        SELF_LOG_ERROR("appmon client(%u) send heartbeat failed, result=%d.", g_flag, ret);
        return SYS_ERROR;
    }
    SELF_LOG_INFO("appmon client(%u) send heartbeat to appmon succeed.", g_flag);
    LogMonitorSetStatus(LOG_MONITOR_HEARTBEAT);
    return SYS_OK;
}

/**
 * @brief LogMonitorThread: monitor thread, appmon register and appmon client heartbeat
 * @param [in]args: arg list
 * @return: NULL
 */
STATIC void *LogMonitorThread(const ArgPtr args)
{
    (void)args;
    NO_ACT_WARN_LOG(ToolSetThreadName("LogMonitor") != SYS_OK, "can not set thread_name(LogMonitor).");
    int32_t ret;
    int32_t count = 0;
    int32_t countFailed = 0;

    char logDaemonScript[CONF_FILE_MAX_LINE] = { 0 };
    if (!GetLogDaemonScript(logDaemonScript, CONF_FILE_MAX_LINE)) {
        return NULL;
    }
    SELF_LOG_INFO("Thread(LogMonitor) start with the appmon client(%u).", g_flag);

    while (LogMonitorIsRun()) {
        ret = appmon_client_heartbeat(&g_logMonitorMgr.clnt);
        if (ret != 0) {
            countFailed += 1;
            SELF_LOG_ERROR("appmon client(%u) send heartbeat failed for %d time(s), result=%d.",
                           g_flag, countFailed, ret);
            (void)ToolSleep(MONITOR_HEARTBEAT_WAIT_TIME);
            continue;
        }
        countFailed = 0;
        (void)ToolSleep(MONITOR_HEARTBEAT_WAIT_TIME);
        count += 1;
        if (count == HEART_BEART_RECORD) {
            SELF_LOG_INFO("appmon client(%u) send heartbeat to appmon succeed.", g_flag);
            count = 0;
        }
    }
    SELF_LOG_ERROR("Thread(LogMonitor) quit.");
    return NULL;
}

STATIC void LogMonitorInit(void)
{
    if (g_flag >= NUM_MONITOR_PROC) {
        SELF_LOG_ERROR("invalid monitor flag=%u.", g_flag);
        return;
    }

    SELF_LOG_INFO("log monitor init with %u.", g_flag);
    ToolUserBlock funcBlock;
    funcBlock.procFunc = LogMonitorThread;
    funcBlock.pulArg = (void *)NULL;
    ToolThreadAttr threadAttr = LOG_MONITOR_DEFAULT_THREAD_ATTR;
    int ret = ToolCreateTaskWithThreadAttr(&g_logMonitorMgr.tid, &funcBlock, &threadAttr);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("create thread(%u) failed, result=%d.", g_flag, ret);
        return;
    }

    SELF_LOG_INFO("log monitor init succeed with %u.", g_flag);
    return;
}

STATIC void LogMonitorExit(void)
{
    LogMonitorSetStatus(LOG_MONITOR_EXIT);
    if (g_logMonitorMgr.tid != 0) {
        ToolJoinTask(&g_logMonitorMgr.tid);
    }
    SELF_LOG_INFO("log monitor thread exit.");
    return;
}

STATIC int32_t CheckProcessExist(void)
{
    LogStatus ret = JustStartAProcess(g_logMonitorPidFile);
    if (ret == LOG_PROCESS_REPEAT) {
        SELF_LOG_ERROR("maybe the process has bean started and quit current process.");
        return LOG_PROCESS_REPEAT;
    }
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("current process quit.");
        return SYS_ERROR;
    }
    return SYS_OK;
}

STATIC int32_t LogMonitorProcessExist(void)
{
    // check if LogGetWorkspacePath() exist or not
    char pidFile[CONF_NAME_MAX_LEN + 1] = { 0 };
    int32_t ret = 0;
    if (g_flag == SLOGD_MONITOR_FLAG) {
        ret = strcpy_s(pidFile, CONF_NAME_MAX_LEN, SLOGD_PID_FILE);
    } else if (g_flag == SKLOGD_MONITOR_FLAG) {
        ret = strcpy_s(pidFile, CONF_NAME_MAX_LEN, SKLOGD_PID_FILE);
    } else if (g_flag == LOGDAEMON_MONITOR_FLAG) {
        ret = strcpy_s(pidFile, CONF_NAME_MAX_LEN, LOGDAEMON_PID_FILE);
    } else {
        SELF_LOG_ERROR("monitor does not exist, flag=%u, Thread(LogMonitor) quit.", g_flag);
        return SYS_ERROR;
    }
    ONE_ACT_ERR_LOG(ret != EOK, return SYS_ERROR, "strcpy_s pid file failed.");
    if (StrcatDir(g_logMonitorPidFile, pidFile, LogGetWorkspacePath(), WORKSPACE_PATH_MAX_LENGTH) != SYS_OK) {
        SELF_LOG_ERROR("StrcatDir g_logMonitorPidFile failed.");
        return SYS_ERROR;
    }
    return CheckProcessExist();
}

/**
 * @brief       : log process monitor start
 * @param [in]  : flagLog         process type
 * @return      : == LOG_SUCCESS: sucess; others: failures
 */
LogStatus LogMonitorStart(uint32_t flagLog)
{
    g_flag = flagLog;
    int32_t ret = LogMonitorProcessExist();
    ONE_ACT_NO_LOG(ret == LOG_PROCESS_REPEAT, return LOG_FAILURE);
    TWO_ACT_NO_LOG(ret != SYS_OK, SingleResourceCleanup(g_logMonitorPidFile), return LOG_FAILURE);

    // register the monitor using script
    ret = LogMonitorRegister();
    ONE_ACT_ERR_LOG(ret != 0, return LOG_FAILURE, "log monitor register failed, flag=%u", g_flag);
    LogMonitorInit();
    return LOG_SUCCESS;
}

/**
 * @brief       : log process monitor stop
 * @return      : NA
 */
void LogMonitorStop(void)
{
    SingleResourceCleanup(g_logMonitorPidFile);
    LogMonitorExit();
    return;
}
#elif defined (IAM_MONITOR)
#include "log_iam_pub.h"

STATIC int IamReady(void)
{
    int retry = 0;
    int ret = SYS_ERROR;
    while ((ret != SYS_OK) && (retry < IAM_RETRY_TIMES)) {
        ret = IAMResMgrReady();
        retry++;
    }
    return (ret == SYS_OK) ? SYS_OK : SYS_ERROR;
}

/**
 * @brief       : log process monitor start
 * @param [in]  : flagLog         process type
 * @return      : == LOG_SUCCESS: sucess; others: failures
 */
LogStatus LogMonitorStart(uint32_t flagLog)
{
    (void)flagLog;
    if (IamReady() != SYS_OK) {
        SELF_LOG_ERROR("iam resource manager ready failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    SELF_LOG_INFO("iam resource manager ready.");
    return LOG_SUCCESS;
}

/**
 * @brief       : log process monitor stop
 * @return      : NA
 */
void LogMonitorStop(void)
{
    (void)IAMRetrieveService();
    return;
}
#else
/**
 * @brief       : log process monitor start
 * @param [in]  : flagLog         process type
 * @return      : == LOG_SUCCESS: sucess; others: failures
 */
LogStatus LogMonitorStart(uint32_t flagLog)
{
    (void)flagLog;
    return LOG_SUCCESS;
}

/**
 * @brief       : log process monitor stop
 * @return      : NA
 */
void LogMonitorStop(void)
{
    return;
}
#endif
