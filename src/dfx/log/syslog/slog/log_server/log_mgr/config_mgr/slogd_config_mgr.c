/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_config_mgr.h"
#include "log_config_list.h"
#include "log_print.h"
#include "log_path_mgr.h"
#include "log_file_info.h"
#include "log_level.h"
#include "log_level_parse.h"
#include "slogd_buffer.h"
#include "log_compress/log_compress.h"

#define DEVICE_MAX_FILE_NUM_STR             "DeviceMaxFileNum"
#define DEVICE_OS_MAX_FILE_NUM_STR          "DeviceOsMaxFileNum"
#define DEVICE_NDEBUG_MAX_FILE_NUM_STR      "DeviceOsNdebugMaxFileNum"
#define DEVICE_APP_MAX_FILE_NUM_STR         "DeviceAppMaxFileNum"
#define DEVICE_MAX_FILE_SIZE_STR            "DeviceMaxFileSize"
#define DEVICE_OS_MAX_FILE_SIZE_STR         "DeviceOsMaxFileSize"
#define DEVICE_NDEBUG_MAX_FILE_SIZE_STR     "DeviceOsNdebugMaxFileSize"
#define DEVICE_APP_MAX_FILE_SIZE_STR        "DeviceAppMaxFileSize"
#define WRITE_LIMIT_SWITCH                  "WriteLimitSwitch"

#define EP_MIN_BUFF_SIZE                    (2U * 1024U * 1024U)
#define DEFAULT_LOG_BUF_SIZE                (256U * 1024U) // 256KB
#define EVENT_LOG_BUF_SIZE                  DEFAULT_LOG_BUF_SIZE
#define FIRM_LOG_BUF_SIZE                   ONE_MEGABYTE
#define MIN_LOG_BUF_SIZE                    (64U * 1024U) // 64KB
#define MAX_LOG_BUF_SIZE                    (1024U * 1024U) // 1024KB
#define MIN_RESERVE_DEVICE_APP_DIR_NUMS     1
#define MAX_RESERVE_DEVICE_APP_DIR_NUMS     96
#define WRITE_LIMIT_SWITCH_ON               1U
#define WRITE_LIMIT_SWITCH_OFF              0U
#ifdef APP_LOG_REPORT
#define DEFAULT_RESERVE_DEVICE_APP_DIR_NUMS 24
#else
#define DEFAULT_RESERVE_DEVICE_APP_DIR_NUMS 48
#endif

typedef struct {
    uint32_t maxFileNum;
    uint32_t maxFileSize;
    int32_t dirNum;
    int32_t storageMode;
} LogTypeConfig;

typedef struct {
    bool writeLimitSwitch; // true: on; false: off
    LogTypeConfig logConfig[LOG_TYPE_MAX_NUM];
    uint32_t sysLogBufSize;
    uint32_t appLogBufSize;
    uint32_t spaceRecordList[LOG_TYPE_NUM];
    char aucFilePath[MAX_FILEPATH_LEN + 1U];
} ConfigMgr;

STATIC ConfigMgr g_configMgr;

/**
* @brief : get global level from config list
* @return: void
*/
STATIC void SlogdConfigMgrSetGlobalLevel(void)
{
    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };
    LogRt ret = LogConfListGetValue(GLOBALLEVEL_KEY, LogStrlen(GLOBALLEVEL_KEY), val, CONF_VALUE_MAX_LEN);
    if (ret == SUCCESS) {
        int64_t tmpL = -1;
        if ((LogStrToInt(val, &tmpL) == LOG_SUCCESS) && (tmpL >= LOG_MIN_LEVEL) && (tmpL <= LOG_MAX_LEVEL)) {
            SlogdSetGlobalLevel((int32_t)tmpL, SLOGD_GLOBAL_TYPE_MASK);
            SELF_LOG_INFO("get global level succeed, level=%s.", GetBasicLevelNameById((int32_t)tmpL));
        } else {
            SELF_LOG_WARN("global level is invalid, use default=%s.",
                          GetBasicLevelNameById(SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK)));
        }
    } else {
        SELF_LOG_WARN("can not get global level, use default=%s.",
                      GetBasicLevelNameById(SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK)));
    }
}

#ifdef DRIVER_STATIC_BUFFER

static void SlogdConfigMgrGetLogConfig(void)
{
    g_configMgr.logConfig[DEBUG_SYS_LOG_TYPE].maxFileNum = DEFAULT_OS_DEBUG_FILE_NUM;
    g_configMgr.logConfig[DEBUG_SYS_LOG_TYPE].maxFileSize = DEFAULT_OS_DEBUG_FILE_SIZE;
    g_configMgr.logConfig[RUN_SYS_LOG_TYPE].maxFileNum = DEFAULT_OS_RUN_FILE_NUM;
    g_configMgr.logConfig[RUN_SYS_LOG_TYPE].maxFileSize = DEFAULT_OS_RUN_FILE_SIZE;
    g_configMgr.logConfig[FIRM_LOG_TYPE].maxFileNum = DEFAULT_FIRM_FILE_NUM;
    g_configMgr.logConfig[FIRM_LOG_TYPE].maxFileSize = DEFAULT_FIRM_FILE_SIZE;
}
#else

static void SlogdConfigMgrGetLogConfig(void)
{
    g_configMgr.logConfig[DEBUG_SYS_LOG_TYPE].maxFileNum =
        LogConfListGetDigit(DEVICE_OS_MAX_FILE_NUM_STR, MIN_FILE_NUM, MAX_FILE_NUM, DEFAULT_MAX_OS_FILE_NUM);

    g_configMgr.logConfig[DEBUG_SYS_LOG_TYPE].maxFileSize =
        LogConfListGetDigit(DEVICE_OS_MAX_FILE_SIZE_STR, MIN_FILE_SIZE, MAX_FILE_SIZE, DEFAULT_MAX_OS_FILE_SIZE);

    g_configMgr.logConfig[FIRM_LOG_TYPE].maxFileNum =
        LogConfListGetDigit(DEVICE_MAX_FILE_NUM_STR, MIN_FILE_NUM, MAX_FILE_NUM, DEFAULT_MAX_FILE_NUM);

    g_configMgr.logConfig[FIRM_LOG_TYPE].maxFileSize =
        LogConfListGetDigit(DEVICE_MAX_FILE_SIZE_STR, MIN_FILE_SIZE, MAX_FILE_SIZE, DEFAULT_MAX_FILE_SIZE);

    g_configMgr.logConfig[RUN_SYS_LOG_TYPE].maxFileNum =
        LogConfListGetDigit(DEVICE_NDEBUG_MAX_FILE_NUM_STR, MIN_FILE_NUM, MAX_FILE_NUM, DEFAULT_MAX_NDEBUG_FILE_NUM);

    g_configMgr.logConfig[RUN_SYS_LOG_TYPE].maxFileSize =
        LogConfListGetDigit(DEVICE_NDEBUG_MAX_FILE_SIZE_STR, MIN_FILE_SIZE,
        MAX_FILE_SIZE, DEFAULT_MAX_NDEBUG_FILE_SIZE);
}

#endif

/**
* @brief        : calculate current type log total file size without active file
* @param [in]   : fileSize      log file max size
* @param [in]   : fileNum       file number
* @return       : total file size without active file
*/
STATIC uint32_t SlogdConfigMgrCalTotalFileSize(uint32_t fileSize, uint32_t fileNum)
{
    if (fileNum <= 0) {
        return 0U;
    }
    return fileSize * ((uint32_t)fileNum - 1U);
}

STATIC void SlogdConfigMgrGetSpaceList(void)
{
    uint32_t eventTotalMaxFileSize = 0U;
    uint32_t eventMaxFileSize = 0U;
    LogConfClass *confClass = LogConfGetClass(EVENT_LOG_TYPE);
    if (confClass != NULL) {
        eventTotalMaxFileSize = confClass->outputRule.totalSize - confClass->outputRule.fileSize;
        eventMaxFileSize = confClass->outputRule.fileSize;
    }
    if ((eventTotalMaxFileSize == 0U) && (eventMaxFileSize == 0U)) {
        eventTotalMaxFileSize = SlogdConfigMgrCalTotalFileSize(EVENT_FILE_SIZE, EVENT_FILE_NUM);
        eventMaxFileSize = EVENT_FILE_SIZE;
    }

    uint32_t runDevOsTotalMaxFileSize = SlogdConfigMgrCalTotalFileSize(
        g_configMgr.logConfig[RUN_SYS_LOG_TYPE].maxFileSize,
        g_configMgr.logConfig[RUN_SYS_LOG_TYPE].maxFileNum);
    uint32_t runDevOsFileSize = g_configMgr.logConfig[RUN_SYS_LOG_TYPE].maxFileSize;

    uint32_t runDevAppTotalMaxFileSize =  SlogdConfigMgrCalTotalFileSize(
        g_configMgr.logConfig[RUN_APP_LOG_TYPE].maxFileSize,
        g_configMgr.logConfig[RUN_APP_LOG_TYPE].maxFileNum);
    uint32_t runDevAppMaxFileSize = g_configMgr.logConfig[RUN_APP_LOG_TYPE].maxFileSize;

    uint32_t securityTotalMaxFileSize = SlogdConfigMgrCalTotalFileSize(SECURITY_FILE_SIZE, SECURITY_FILE_NUM);
    uint32_t securityMaxFileSize = SECURITY_FILE_SIZE;

    g_configMgr.spaceRecordList[SECURITY_LOG] = securityTotalMaxFileSize + securityMaxFileSize;

    g_configMgr.spaceRecordList[RUN_LOG] = eventTotalMaxFileSize + eventMaxFileSize +
        runDevOsTotalMaxFileSize + runDevOsFileSize +
        runDevAppTotalMaxFileSize + runDevAppMaxFileSize;
}

STATIC void SlogdConfigMgrGetLimitConfig(void)
{
    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };
    LogRt ret = LogConfListGetValue(WRITE_LIMIT_SWITCH, LogStrlen(WRITE_LIMIT_SWITCH), val, CONF_VALUE_MAX_LEN);
    if (ret != SUCCESS) {
        NO_ACT_WARN_LOG(ret != CONF_VALUE_NULL, "the limit switch is disabled, result=%d.", (int32_t)ret);
        g_configMgr.writeLimitSwitch = false;
        return;
    }
    uint32_t switchConfig = LogConfGetDigit(WRITE_LIMIT_SWITCH, val, WRITE_LIMIT_SWITCH_OFF, WRITE_LIMIT_SWITCH_ON,
        WRITE_LIMIT_SWITCH_ON);
    if (switchConfig != WRITE_LIMIT_SWITCH_ON) {
        g_configMgr.writeLimitSwitch = false;
        return;
    }
    g_configMgr.writeLimitSwitch = true;
    SELF_LOG_INFO("set write limit switch on succeed.");
}

/**
* @brief : get config from config list
* @return: void
*/
static void SlogdConfigMgrParseLogConfig(void)
{
    SlogdConfigMgrGetLogConfig();
    SlogdConfigMgrGetLimitConfig();

    g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].maxFileNum =
        LogConfListGetDigit(DEVICE_APP_MAX_FILE_NUM_STR, MIN_FILE_NUM, MAX_FILE_NUM, DEFAULT_MAX_APP_FILE_NUM);
    g_configMgr.logConfig[RUN_APP_LOG_TYPE].maxFileNum =
        g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].maxFileNum;

    g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].maxFileSize =
        LogConfListGetDigit(DEVICE_APP_MAX_FILE_SIZE_STR, HOST_APP_FILE_MIN_SIZE,
        HOST_APP_FILE_MAX_SIZE, DEFAULT_MAX_APP_FILE_SIZE);
    g_configMgr.logConfig[RUN_APP_LOG_TYPE].maxFileSize =
        g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].maxFileSize;

    g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].dirNum = (int32_t)LogConfListGetDigit(RESERVE_DEVICE_APP_DIR_NUMS,
        MIN_RESERVE_DEVICE_APP_DIR_NUMS, MAX_RESERVE_DEVICE_APP_DIR_NUMS, DEFAULT_RESERVE_DEVICE_APP_DIR_NUMS);
    g_configMgr.logConfig[RUN_APP_LOG_TYPE].dirNum = g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].dirNum;

    // preferentially read storage mode from the configuration, currently, macro isolation is used first.
#ifdef GROUP_LOG
    g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].storageMode = STORAGE_RULE_FILTER_MODULEID;
#else
    g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].storageMode = STORAGE_RULE_FILTER_PID;
#endif

#ifdef APP_LOG_PID_RECORD
    g_configMgr.logConfig[RUN_APP_LOG_TYPE].storageMode = STORAGE_RULE_FILTER_PID;
#else
    g_configMgr.logConfig[RUN_APP_LOG_TYPE].storageMode = STORAGE_RULE_COMMON;
#endif
    g_configMgr.logConfig[SEC_APP_LOG_TYPE].storageMode = STORAGE_RULE_FILTER_PID;

#ifndef STATIC_BUFFER
    g_configMgr.sysLogBufSize = LogConfListGetDigit(SYS_LOG_BUF_SIZE_STR, MIN_LOG_BUF_SIZE, MAX_LOG_BUF_SIZE,
        DEFAULT_LOG_BUF_SIZE);
#endif

    g_configMgr.appLogBufSize = LogConfListGetDigit(APP_LOG_BUF_SIZE_STR, MIN_LOG_BUF_SIZE, MAX_LOG_BUF_SIZE,
        DEFAULT_LOG_BUF_SIZE);

    g_configMgr.logConfig[SEC_SYS_LOG_TYPE].maxFileNum = SECURITY_FILE_NUM;
    g_configMgr.logConfig[SEC_SYS_LOG_TYPE].maxFileSize = SECURITY_FILE_SIZE;

    SlogdConfigMgrGetSpaceList();
}

/**
* @brief : get root log directory from config list
* @return: void
*/
STATIC void SlogdConfigMgrGetFileDir(void)
{
    char val[CONF_VALUE_MAX_LEN + 1] = {0};
    LogRt logRt = LogConfListGetValue(LOG_AGENT_FILE_DIR_STR, LogStrlen(LOG_AGENT_FILE_DIR_STR), val,
                                      CONF_VALUE_MAX_LEN);
    if (logRt == SUCCESS) {
        (void)snprintf_truncated_s(g_configMgr.aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", val);
    } else {
        (void)snprintf_truncated_s(g_configMgr.aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
        SELF_LOG_WARN("can not get log root path, use default_path=%s, result=%d.", LOG_FILE_PATH, (int32_t)logRt);
    }
}

/**
* @brief : init config manager
* @return: void
*/
void SlogdConfigMgrInit(void)
{
    if (LogConfInit() != SYS_OK) {
        SYSLOG_WARN("can not init conf and continue.....");
    }

    if (LogPathMgrInit() != SYS_OK) {
        SYSLOG_WARN("can not init file path for self log and continue....\n");
    }

#ifdef GROUP_LOG
    LogConfGroupInit(LogConfGetPath());
#endif

    SlogdConfigMgrSetGlobalLevel();
    SlogdConfigMgrParseLogConfig();
    SlogdConfigMgrGetFileDir();
}

/**
 * @brief save config to StLogFileList
 * @param [in\out]logList: StLogFileList struct pointer
 * @return: LOG_SUCCESS  success; others  failure
 */
int32_t SlogdConfigMgrGetList(StLogFileList *logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return LOG_INVALID_PTR, "[input] log file list info is null.");

    logList->maxFileNum = (int32_t)g_configMgr.logConfig[FIRM_LOG_TYPE].maxFileNum;
    logList->maxOsFileNum = (int32_t)g_configMgr.logConfig[DEBUG_SYS_LOG_TYPE].maxFileNum;
    logList->maxAppFileNum = (int32_t)g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].maxFileNum;
    logList->maxNdebugFileNum = (int32_t)g_configMgr.logConfig[RUN_SYS_LOG_TYPE].maxFileNum;
    logList->ulMaxFileSize = g_configMgr.logConfig[FIRM_LOG_TYPE].maxFileSize;
    logList->ulMaxOsFileSize = g_configMgr.logConfig[DEBUG_SYS_LOG_TYPE].maxFileSize;
    logList->ulMaxAppFileSize = g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].maxFileSize;
    logList->ulMaxNdebugFileSize = g_configMgr.logConfig[RUN_SYS_LOG_TYPE].maxFileSize;
    errno_t ret = strcpy_s(logList->aucFilePath, MAX_FILEPATH_LEN, g_configMgr.aucFilePath);
    if (ret != EOK) {
        SELF_LOG_ERROR("strcpy for aucFilePath failed.");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

int32_t SlogdConfigMgrGetDeviceAppDirNums(void)
{
    return g_configMgr.logConfig[DEBUG_APP_LOG_TYPE].dirNum;
}

#ifdef STATIC_BUFFER

static uint32_t NormalizeBuffSize(uint32_t buffSize)
{
    if (buffSize < EP_MIN_BUFF_SIZE) {
        return EP_MIN_BUFF_SIZE;
    }
    uint32_t remainder = buffSize % ONE_MEGABYTE;
    return buffSize - remainder;
}

uint32_t SlogdConfigMgrGetBufSize(int32_t buffType)
{
    if (buffType >= LOG_TYPE_MAX_NUM) {
        SELF_LOG_ERROR("invalid buffType:%d", buffType);
        return 0;
    }
    if ((buffType == DEBUG_APP_LOG_TYPE) || (buffType == SEC_APP_LOG_TYPE) || (buffType == RUN_APP_LOG_TYPE)) {
        return g_configMgr.appLogBufSize;
    }
    uint32_t maxFileNum = g_configMgr.logConfig[buffType].maxFileNum;
    uint32_t maxFileSize = g_configMgr.logConfig[buffType].maxFileSize;
    return NormalizeBuffSize(maxFileNum * maxFileSize);
}

#else

uint32_t SlogdConfigMgrGetBufSize(int32_t buffType)
{
    uint32_t bufsize = 0;
    switch (buffType) {
        case DEBUG_SYS_LOG_TYPE:
        case SEC_SYS_LOG_TYPE:
        case RUN_SYS_LOG_TYPE:
            bufsize = g_configMgr.sysLogBufSize;
            break;
        case EVENT_LOG_TYPE:
            bufsize = EVENT_LOG_BUF_SIZE;
            break;
        case FIRM_LOG_TYPE:
            bufsize = FIRM_LOG_BUF_SIZE;
            break;
        case DEBUG_APP_LOG_TYPE:
        case SEC_APP_LOG_TYPE:
        case RUN_APP_LOG_TYPE:
            bufsize = g_configMgr.appLogBufSize;
            break;
        default:
            SELF_LOG_ERROR("invalid buffType:%d", buffType);
            break;
    }
    return bufsize;
}

#endif

void SlogdConfigMgrExit(void)
{
    LogConfListFree();
    LogPathMgrExit();
}

int32_t SlogdConfigMgrGetStorageMode(int32_t buffType)
{
    ONE_ACT_ERR_LOG(buffType >= LOG_TYPE_MAX_NUM, return 0, "invalid buffType:%d", buffType);
    return g_configMgr.logConfig[buffType].storageMode;
}

bool SlogdConfigMgrGetWriteFileLimit(void)
{
    return g_configMgr.writeLimitSwitch;
}

uint32_t SlogdConfigMgrGetTypeSpace(int32_t type)
{
    ONE_ACT_ERR_LOG(type >= (int32_t)LOG_TYPE_NUM, return 0, "[input] invalid log type: %d", type);
    return g_configMgr.spaceRecordList[type];
}