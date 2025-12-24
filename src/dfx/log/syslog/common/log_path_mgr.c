/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_path_mgr.h"
#include "log_print.h"
#include "log_config_api.h"
#include "log_file_info.h"
#include "log_file_util.h"

#ifndef DEFAULT_LOG_WORKSPACE
#define DEFAULT_LOG_WORKSPACE       "/usr/slog"
#endif
#define SLOGD_LOG_LOCK              "/tmp.lock"

#ifdef IAM
#define DEFAULT_SLOGD_LOG_FILE      "/home/mdc/var/log/slogd/slogdlog"
#define DEFAULT_SLOGD_LOG_OLD_FILE  "/home/mdc/var/log/slogd/slogdlog.old"
#define DEFAULT_SLOGD_LOG_LOCK      "/home/mdc/var/log/slogd/tmp.lock"
#else
#define DEFAULT_SLOGD_LOG_FILE      "/var/log/npu/slog/slogd/slogdlog"
#define DEFAULT_SLOGD_LOG_OLD_FILE  "/var/log/npu/slog/slogd/slogdlog.old"
#define DEFAULT_SLOGD_LOG_LOCK      "/var/log/npu/slog/slogd/tmp.lock"
#endif

#define LOG_FOR_SELF_MAX_FILE_LENGTH 8U
#define LOG_DIR_FOR_SELF_LENGTH (CFG_LOGAGENT_PATH_MAX_LENGTH + LOG_FOR_SELF_MAX_FILE_LENGTH)
#define SELF_MAX_NAME_LENGTH  16U
#define SELF_LOG_FILES_LENGTH (LOG_DIR_FOR_SELF_LENGTH + SELF_MAX_NAME_LENGTH)

typedef struct {
    char selfLogFile[SELF_LOG_FILES_LENGTH + 1U];
    char selfLogOldFile[SELF_LOG_FILES_LENGTH + 1U];
    char selflogLockFile[SELF_LOG_FILES_LENGTH + 1U];
} SelfLogFiles;

STATIC char g_selfLogPath[LOG_DIR_FOR_SELF_LENGTH + 1U] = { 0 };
STATIC char g_rootLogPath[CFG_LOGAGENT_PATH_MAX_LENGTH + 1U] = { 0 };
STATIC char g_workSpacePath[CFG_WORKSPACE_PATH_MAX_LENGTH + 1U] = DEFAULT_LOG_WORKSPACE;
STATIC SelfLogFiles *g_selfLogFiles = NULL;

char *LogGetWorkspacePath(void)
{
    return g_workSpacePath;
}

char *LogGetRootPath(void)
{
    return g_rootLogPath;
}

char *LogGetSelfPath(void)
{
    return g_selfLogPath;
}

const char *LogGetSelfFile(void)
{
    if (g_selfLogFiles != NULL) {
        return g_selfLogFiles->selfLogFile;
    }
    return DEFAULT_SLOGD_LOG_FILE;
}

const char *LogGetSelfOldFile(void)
{
    if (g_selfLogFiles != NULL) {
        return g_selfLogFiles->selfLogOldFile;
    }
    return DEFAULT_SLOGD_LOG_OLD_FILE;
}

const char *LogGetSelfLockFile(void)
{
    if (g_selfLogFiles != NULL) {
        return g_selfLogFiles->selflogLockFile;
    }
    return DEFAULT_SLOGD_LOG_LOCK;
}

/**
 * @brief CheckLogPath: mkdir log root path and slogd path
 * @return: SYS_OK/SYS_ERROR
 */
int CheckSelfLogPath(void)
{
    const char *logPath = LogGetRootPath();
    if ((logPath == NULL) || (strlen(logPath) == 0)) {
        return SYS_ERROR;
    }
    LogRt ret = LogMkdir(logPath);
    if (ret != SUCCESS) {
        return SYS_ERROR;
    }

    const char *slogdPath = LogGetSelfPath();
    if ((slogdPath == NULL) || (strlen(slogdPath) == 0)) {
        return SYS_ERROR;
    }
    ret = LogMkdir(slogdPath);
    if (ret != SUCCESS) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
 * @brief : get workspace path from config file
 * @return: SYS_OK/SYS_ERROR
 */
STATIC int LogInitWorkspacePath(void)
{
    if (ToolAccessWithMode(g_workSpacePath, (uint32_t)F_OK | (uint32_t)R_OK | (uint32_t)X_OK) != SYS_OK) {
        SELF_LOG_WARN("Not access workspace path, g_workSpacePath=%s.", g_workSpacePath);
        return SYS_ERROR;
    }
    SELF_LOG_INFO("logWorkspace = %s.", g_workSpacePath);
    return SYS_OK;
}

/**
 * @brief LogCheckPathPermission: check log path permission and try to create if path not exist
 * @param [in]dirPath: log root path
 * @return: void
 */
STATIC void LogCheckPathPermission(const char *dirPath)
{
    ONE_ACT_NO_LOG(dirPath == NULL, return);

    if (ToolAccess(dirPath) == SYS_OK) {
        // check log path permission
        if (ToolAccessWithMode(dirPath, F_OK | W_OK | R_OK | X_OK) != SYS_OK) {
            SYSLOG_WARN("log path permission denied, strerr=%s.\n", strerror(ToolGetErrorCode()));
        }
    } else {
        // check log path create permission
        LogRt ret = LogMkdir(dirPath);
        if (ret != SUCCESS) {
            SYSLOG_WARN("can not create log path, ret=%d, strerr=%s.\n", (int32_t)ret, strerror(ToolGetErrorCode()));
        }
    }
}

/**
 * @brief : get self log dir from config file
 * @return: SYS_OK/SYS_ERROR
 */
STATIC int LogInitRootPath(void)
{
    int ret;
    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };
    LogRt err = LogConfListGetValue(LOG_AGENT_FILE_DIR_STR, LogStrlen(LOG_AGENT_FILE_DIR_STR),
                                    val, CONF_VALUE_MAX_LEN);
    if (err != SUCCESS) {
        ret = snprintf_s(g_rootLogPath, CFG_LOGAGENT_PATH_MAX_LENGTH + 1U,
                         CFG_LOGAGENT_PATH_MAX_LENGTH, "%s", LOG_FILE_PATH);
        if (ret == -1) {
            SYSLOG_WARN("can not snprintf_s, log_path=%s, strerr=%s.\n", LOG_FILE_PATH, strerror(ToolGetErrorCode()));
            return SYS_ERROR;
        }
    } else {
        char *path = (char *)LogMalloc((size_t)TOOL_MAX_PATH + 1U);
        if (path == NULL) {
            SYSLOG_WARN("can not malloc, strerr=%s.", strerror(ToolGetErrorCode()));
            return SYS_ERROR;
        }
        // if create root path by conf failed or get real root path failed
        if (GetValidPath(val, CONF_VALUE_MAX_LEN + 1, path, TOOL_MAX_PATH + 1) != SYS_OK) {
            SYSLOG_WARN("can not get root realpath from conf, val=%s, strerr=%s.", val, strerror(ToolGetErrorCode()));
            XFREE(path);
            return SYS_ERROR;
        }
        ret = strncpy_s(g_rootLogPath, CFG_LOGAGENT_PATH_MAX_LENGTH + 1U, path, CFG_LOGAGENT_PATH_MAX_LENGTH);
        if (ret != EOK) {
            SYSLOG_WARN("can not get log dir realpath, ret=%d, strerr=%s.\n", ret, strerror(ToolGetErrorCode()));
            XFREE(path);
            return SYS_ERROR;
        }
        XFREE(path);
    }
    LogCheckPathPermission((const char *)g_rootLogPath);

    return (int32_t)LogMkdir(g_rootLogPath);
}

STATIC int LogInitSelfPath(void)
{
    int32_t ret = snprintf_s(g_selfLogPath, LOG_DIR_FOR_SELF_LENGTH + 1U, LOG_DIR_FOR_SELF_LENGTH,
                             "%s%s", g_rootLogPath, LOG_DIR_FOR_SELF_LOG);
    if (ret == -1) {
        SYSLOG_WARN("can not snprintf_s, slogd_log_path=%s, strerr=%s.\n", g_rootLogPath, strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }
    return (int32_t)LogMkdir(g_selfLogPath);
}

STATIC int LogInitSelfFiles(void)
{
    // g_selfLogFiles has already been initialize."
    if (g_selfLogFiles != NULL) {
        return SYS_OK;
    }

    g_selfLogFiles = (SelfLogFiles *)LogMalloc(sizeof(SelfLogFiles));
    if (g_selfLogFiles == NULL) {
        return SYS_ERROR;
    }

    // init selfLogFiles
    int ret1 = StrcatDir(g_selfLogFiles->selfLogFile, SLOGD_LOG_FILE, LogGetSelfPath(), SELF_LOG_FILES_LENGTH);
    int ret2 = StrcatDir(g_selfLogFiles->selfLogOldFile, SLOGD_LOG_OLD_FILE, LogGetSelfPath(), SELF_LOG_FILES_LENGTH);
    int ret3 = StrcatDir(g_selfLogFiles->selflogLockFile, SLOGD_LOG_LOCK, LogGetSelfPath(), SELF_LOG_FILES_LENGTH);
    if ((ret1 != SYS_OK) || (ret2 != SYS_OK) || (ret3 != SYS_OK)) {
        XFREE(g_selfLogFiles);
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
 * @brief LogPathMgrInit: init log dir from slog.conf "logAgentdir" to store slef log
 * @return:SYS_OK:succeed;SYS_ERROR:failed;
 */
int LogPathMgrInit(void)
{
    if (LogInitRootPath() != SYS_OK) {
        return SYS_ERROR;
    }

    if (LogInitSelfPath() != SYS_OK) {
        return SYS_ERROR;
    }

    if (LogInitSelfFiles() != SYS_OK) {
        return SYS_ERROR;
    }

    if (LogInitWorkspacePath() != SYS_OK) {
        return SYS_ERROR;
    }

    return SYS_OK;
}

void LogPathMgrExit(void)
{
    XFREE(g_selfLogFiles);
}

