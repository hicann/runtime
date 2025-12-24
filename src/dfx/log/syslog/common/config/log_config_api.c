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
#include "securec.h"
#include "log_common.h"
#include "log_print.h"
#include "log_file_info.h"

#define LOG_CONFIG_FILE "slog.conf"

// interface inner
STATIC char g_configFilePath[SLOG_CONF_PATH_MAX_LENGTH] = { 0 };

/**
* @brief : return config file path
* @return: return config file path
*/
char *LogConfGetPath(void)
{
    return g_configFilePath;
}

STATIC int32_t LogConfInitPath(void)
{
    // use defualt path
    (void)snprintf_truncated_s(g_configFilePath, SLOG_CONF_PATH_MAX_LENGTH, "%s", SLOG_CONF_FILE_PATH);
    if (ToolAccess(g_configFilePath) != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
 * @brief : get current process directory
 * @param [out]processDir: buffer to stor current process directory path
 * @param [in]len: max length of process dir path
 * @return: SYS_OK/SYS_ERROR
 */
STATIC int LogConfGetProcessPath(char *processDir, uint32_t len)
{
    if (processDir == NULL) {
        SYSLOG_WARN("[input] process directory path is null.");
        return SYS_ERROR;
    }
    const char *selfBin = "/proc/self/exe";
    int32_t selflen = (int32_t)readlink(selfBin, processDir, len); // read self path of store
    if ((selflen < 0) || (selflen > TOOL_MAX_PATH)) {
        SYSLOG_WARN("can not get self bin directory, selflen=%d, strerr=%s.", selflen,
                    strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }
    // please make sure tmp end with '\0'
    processDir[selflen] = '\0';
    return SYS_OK;
}

/**
 * @brief : get config file from current process directory
 * @param [out]configPath: buffer to stor config path
 * @param [in]len: max length of process dir path
 * @return: SYS_OK/SYS_ERROR
 */
STATIC int LogConfGetProcessFile(char *configPath, uint32_t len)
{
    if (configPath == NULL) {
        SYSLOG_WARN("[input] config path is null.\n");
        return SYS_ERROR;
    }
    char *tmp = (char *)LogMalloc(TOOL_MAX_PATH + 1);
    if (tmp == NULL) {
        SYSLOG_WARN("can not malloc for tmp, strerr=%s.\n", strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }

    int32_t ret = LogConfGetProcessPath(tmp, TOOL_MAX_PATH);
    if (ret != SYS_OK) {
        SYSLOG_WARN("can not get process path.\n");
        XFREE(tmp);
        return SYS_ERROR;
    }
    const char *pend = strrchr(tmp, OS_SPLIT);
    if (pend == NULL) {
        SYSLOG_WARN("Config path has no \"\\\".\n");
        XFREE(tmp);
        return SYS_ERROR;
    }
    off_t endLen = (pend - tmp) + 1;
    ret = strncpy_s(configPath, len, tmp, (size_t)endLen);
    if (ret != EOK) {
        SYSLOG_WARN("can not strcpy_s, result=%d, strerr=%s.\n", ret, strerror(ToolGetErrorCode()));
        XFREE(tmp);
        return SYS_ERROR;
    }
    XFREE(tmp);
    if (len < (LogStrlen(configPath) + LogStrlen(LOG_CONFIG_FILE) + 1U)) {
        SYSLOG_WARN("Path length more than upper limit, upper_limit=%u, configPath=%s.\n", len, configPath);
        return SYS_ERROR;
    }
    ret = strcat_s(configPath, len, LOG_CONFIG_FILE);
    if (ret != EOK) {
        SYSLOG_WARN("can not strcat_s, configPath=%s, result=%d, strerr=%s.\n",
                    configPath, ret, strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
* @brief        : slogd\sklogd\log-daemon get config file path and assign to g_configFilePath
* @return:      : SYS_OK: succeed; SYS_ERROR: failed
*/
int32_t LogConfInit(void)
{
    if (LogConfInitPath() != SYS_OK) {
        // slogd try to get config file from the current process directory.
        (void)LogConfGetProcessFile(g_configFilePath, SLOG_CONF_PATH_MAX_LENGTH);
    }
    if (LogConfListInit(g_configFilePath) != SUCCESS) {
        return SYS_ERROR;
    }

    return SYS_OK;
}
