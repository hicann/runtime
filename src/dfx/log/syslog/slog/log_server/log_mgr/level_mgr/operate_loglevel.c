/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operate_loglevel.h"
#include "securec.h"
#include "log_common.h"
#include "log_config_api.h"
#include "log_common.h"
#include "log_level_parse.h"
#include "log_print.h"
#include "slogd_flush.h"
#include "slogd_dev_mgr.h"
#include "slogd_shm_mgr.h"
#include "slogd_firmware_level.h"
#include "slogd_dynamic_level.h"
#include "share_mem.h"

/**
 * @brief ConstructEvent: constuct global level
 * @param [in]tmp: level char tmp value, > 0
 * @param [in]level: level value
 * @return: level char
 *      debug: 0001x000
 *       info: 0010x000
 *    warning: 0011x000
 *      error: 0100x000
 *       null: 0101x000
 *    invalid: 0110x000
 */
STATIC char ConstructGlobal(char tmp, int32_t *level)
{
    ONE_ACT_NO_LOG(level == NULL, return tmp);
    ONE_ACT_NO_LOG(tmp < 0, return tmp);

    if ((*level > LOG_MAX_LEVEL) || (*level < LOG_MIN_LEVEL)) {
        *level = LOG_INVALID_LEVEL;
    }
    uint32_t ret = ((((uint32_t)(*level) + 1U) & 0x7U) << 4U) | ((uint32_t)tmp); // high 6~4bit
    return (char)ret;
}

/**
 * @brief ConstructEvent: constuct event level
 * @param [in]tmp: level char tmp value, > 0
 * @param [in]level: level value
 * @return: level char
 *     enable: 0xxx1000
 *    disable: 0xxx0100
 */
STATIC char ConstructEvent(char tmp, char *level)
{
    ONE_ACT_NO_LOG(level == NULL, return tmp);
    ONE_ACT_NO_LOG(tmp < 0, return tmp);

    if ((*level != (char)EVENT_ENABLE_VALUE) && (*level != (char)EVENT_DISABLE_VALUE)) {
        *level = (char)EVENT_ENABLE_VALUE;
    }
    uint32_t ret = ((((uint32_t)(*level) + 1U) & 0x3U) << 2U) | ((uint32_t)tmp); // low 3~2bit
    return (char)ret;
}

/**
 * @brief           : constuct global debug level
 * @param [in]      : tmp   level char tmp value, > 0
 * @param [in]      : level level value
 * @return          : level char
 *      debug: 0001x000
 *       info: 0010x000
 *    warning: 0011x000
 *      error: 0100x000
 *       null: 0101x000
 *    invalid: 0110x000
 */
STATIC char ConstructDebug(char tmp, int32_t *level)
{
    ONE_ACT_NO_LOG(level == NULL, return tmp);
    ONE_ACT_NO_LOG(tmp < 0, return tmp);

    if ((*level > LOG_MAX_LEVEL) || (*level < LOG_MIN_LEVEL)) {
        *level = LOG_INVALID_LEVEL;
    }
    uint32_t ret = ((((uint32_t)(*level) + 1U) & 0x7U) << 4U) | ((uint32_t)tmp); // high 6~4bit
    return (char)ret;
}

/**
 * @brief           : constuct global run level
 * @param [in]      : tmp   level char tmp value, > 0
 * @param [in]      : level level value
 * @return          : level char
 *      debug: x0000001
 *       info: x0000010
 *    warning: x0000011
 *      error: x0000100
 *       null: x0000101
 *    invalid: x0000110
 */
STATIC char ConstructRun(char tmp, int32_t *level)
{
    ONE_ACT_NO_LOG(level == NULL, return tmp);
    ONE_ACT_NO_LOG(tmp < 0, return tmp);

    if ((*level > LOG_MAX_LEVEL) || (*level < LOG_MIN_LEVEL)) {
        *level = LOG_INVALID_LEVEL;
    }
    uint32_t ret = (((uint32_t)(*level) + 1U) & 0x7U) | ((uint32_t)tmp); // low 2~0bit
    return (char)ret;
}

/**
 * @brief           : constuct module level
 * @param [in]      : tmp       level char tmp value, > 0
 * @param [in]      : levell    module debug level value
 * @param [in]      : levelr    module run level value
 * @return          : level char
 *      debug: 00010xxx/0xxx0001
 *       info: 00100xxx/0xxx0010
 *    warning: 00110xxx/0xxx0011
 *      error: 01000xxx/0xxx0100
 *       null: 01010xxx/0xxx0101
 *    invalid: 01100xxx/0xxx0110
 */
STATIC char ConstructModule(char tmp, int32_t *levell, int32_t *levelr)
{
    char retChar = tmp;
    ONE_ACT_NO_LOG(retChar < 0, return retChar);
    uint32_t ret = 0;

    if (levell != NULL) {
        if ((*levell > LOG_MAX_LEVEL) || (*levell < LOG_MIN_LEVEL)) {
            *levell = LOG_INVALID_LEVEL;
        }
        ret = ((uint32_t)retChar) | ((((uint32_t)(*levell) + 1U) & 0x7U) << 4U); // high 6~4bit
        retChar = (char)ret;
    }

    if (levelr != NULL) {
        if ((*levelr > LOG_MAX_LEVEL) || (*levelr < LOG_MIN_LEVEL)) {
            *levelr = LOG_INVALID_LEVEL;
        }
        ret = ((uint32_t)retChar) | (((uint32_t)(*levelr) + 1U) & 0x7U); // low 2~0bit
        retChar = (char)ret;
    }
    return retChar;
}

/**
 * @brief ConstructLevelStr: constuct all level info to string,
 *  format:      0111|         11|         00|        0111|       0111|                 0111|               0111|...
 *             global|      event|    reserve| debug_level|  run_level| module[0].debugLevel| module[0].runLevel|...
 *        high 6~4bit| low 3~2bit| low 1~0bit| high 6~4bit| low 2~0bit| high 6~4bit         | low 2~0bit        |...
 * @param [in/out]str: module name string
 * @param [in]strLen: str max length
 * @return: STR_COPY_FAILED: construct failed;
 *          ARGV_NULL: str is null;
 *          INPUT_INVALID: strLen is invalid;
 */
STATIC LogRt ConstructLevelStr(char *str, size_t strLen)
{
    ONE_ACT_NO_LOG(str == NULL, return ARGV_NULL);
    ONE_ACT_NO_LOG((strLen == 0) || (strLen > LEVEL_ARR_LEN), return INPUT_INVALID);

    char level = '\0';
    // global + event level
    char event = (SlogdGetEventLevel() == 0) ? (char)EVENT_DISABLE_VALUE : (char)EVENT_ENABLE_VALUE;
    int32_t global = SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK);

    level = ConstructEvent(level, &event);
    level = ConstructGlobal(level, &global);
    int32_t ret = strncpy_s(str, strLen - 1U, (const char *)&level, 1U);
    ONE_ACT_ERR_LOG(ret != EOK, return STR_COPY_FAILED,
                    "copy failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    // debug_level + run_level
    level = '\0';
    int32_t debugLevel = SlogdGetGlobalLevel(DEBUG_LOG_MASK);
    int32_t runLevel = SlogdGetGlobalLevel(RUN_LOG_MASK);
    level = ConstructDebug(level, &debugLevel);
    level = ConstructRun(level, &runLevel);
    ret = strncat_s(str, strLen - 1U, (const char *)&level, 1U);
    ONE_ACT_ERR_LOG(ret != EOK, return STR_COPY_FAILED,
                    "copy failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    // module
    for (int32_t i = 0; i < INVLID_MOUDLE_ID; i++) {
        level = '\0';
        int32_t levell = SlogdGetModuleLevel(i, DEBUG_LOG_MASK);
        int32_t levelr = SlogdGetModuleLevel(i, RUN_LOG_MASK);
        level = ConstructModule(level, &levell, &levelr);
        ret = strncat_s(str, strLen - 1U, (const char *)&level, 1U);
        ONE_ACT_ERR_LOG(ret != EOK, return STR_COPY_FAILED,
                        "copy failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    }
    return SUCCESS;
}

/**
 * @brief ConstructModuleStr: constuct all module name to string,
 *                              format: SLOG;IDEDD;IDEDH;...;FV;
 * @param [in/out]str: module name string
 * @param [in]strLen: str max length
 * @return: STR_COPY_FAILED: construct module name failed;
 *          ARGV_NULL: str is null;
 *          INPUT_INVALID: strLen is invalid;
 */
STATIC LogRt ConstructModuleStr(char *str, size_t strLen)
{
    ONE_ACT_NO_LOG(str == NULL, return ARGV_NULL);
    ONE_ACT_NO_LOG((strLen == 0) || (strLen > MODULE_ARR_LEN), return INPUT_INVALID);

    size_t len = 0;
    const ModuleInfo *moduleInfos = GetModuleInfos();
    ONE_ACT_NO_LOG(moduleInfos == NULL, return ARGV_NULL);
    for (int32_t i = 0; i < INVLID_MOUDLE_ID; i++) {
        int32_t ret = sprintf_s(str + len, strLen - 1U, "%s;", moduleInfos[i].moduleName);
        if ((ret == -1) || ((unsigned)ret != (strlen(moduleInfos[i].moduleName) + 1U))) {
            SELF_LOG_ERROR("copy failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
            return STR_COPY_FAILED;
        }
        len += strlen(moduleInfos[i].moduleName) + 1;
    }

    return SUCCESS;
}

#ifndef IAM
#include "log_path_mgr.h"

/**
 * @brief UpdateNotifyFile: write level notify file
 * @return: SYS_OK/SYS_ERROR
 */
STATIC int32_t UpdateNotifyFile(void)
{
    char notifyFile[WORKSPACE_PATH_MAX_LENGTH + 1U] = { 0 };
    size_t len = strlen(LogGetWorkspacePath()) + strlen(LEVEL_NOTIFY_FILE) + 1;
    int32_t res = sprintf_s(notifyFile, WORKSPACE_PATH_MAX_LENGTH, "%s/%s", LogGetWorkspacePath(), LEVEL_NOTIFY_FILE);
    if ((unsigned int)res != (unsigned int)len) {
        SELF_LOG_ERROR("copy failed, res=%d, strerr=%s.", res, strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }

    int32_t fd = ToolOpen((const char *)notifyFile, O_CREAT | O_WRONLY);
    if (fd < 0) {
        SELF_LOG_ERROR("open notify file failed, strerr=%s, file=%s.", strerror(ToolGetErrorCode()), notifyFile);
        return SYS_ERROR;
    }

    res = ToolChmod((const char *)notifyFile, (int)SyncGroupToOther(S_IRUSR | S_IWUSR | S_IRGRP)); // 0640
    if (res != 0) {
        SELF_LOG_ERROR("chmod %s failed , strerr=%s.", notifyFile, strerror(ToolGetErrorCode()));
        LOG_CLOSE_FD(fd);
        return SYS_ERROR;
    }

    res = ToolWrite(fd, LEVEL_NOTIFY_FILE, LogStrlen(LEVEL_NOTIFY_FILE));
    if ((res < 0) || (res != (int32_t)strlen(LEVEL_NOTIFY_FILE))) {
        SELF_LOG_ERROR("write notify file failed, res=%d, strerr=%s, file=%s.",
                       res, strerror(ToolGetErrorCode()), notifyFile);
        LOG_CLOSE_FD(fd);
        return SYS_ERROR;
    }
    LOG_CLOSE_FD(fd);
    return SYS_OK;
}
#endif

/**
 * @brief       : update level info to shmem, and write file /usr/slog/level_notify
 * @return      : SYS_OK    success;
 *                SYS_ERROR failure
 */
int32_t UpdateLevelToShMem(void)
{
    char *levelStr = (char *)LogMalloc(LEVEL_ARR_LEN);
    if (levelStr == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }

    // construct level info
    LogRt err = ConstructLevelStr(levelStr, LEVEL_ARR_LEN);
    if (err != SUCCESS) {
        SELF_LOG_ERROR("construct level str failed, log_err=%d.", (int32_t)err);
        XFREE(levelStr);
        return SYS_ERROR;
    }

    int32_t ret = SlogdShmWriteLevelAttr(levelStr, LogStrlen(levelStr));
    if (ret != LOG_SUCCESS) {
        XFREE(levelStr);
        return SYS_ERROR;
    }

    XFREE(levelStr);

    // update ${workpath}/level_notify
#ifndef IAM
    ret = UpdateNotifyFile();
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
#endif

    return SYS_OK;
}

/**
 * @brief InitModuleArrToShMem: write module name to shmem
 * @return: SYS_OK: write to shmem succeed
 */
int InitModuleArrToShMem(void)
{
    char *moduleStr = (char *)LogMalloc(MODULE_ARR_LEN);
    if (moduleStr == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }

    // construct module
    LogRt err = ConstructModuleStr(moduleStr, MODULE_ARR_LEN);
    if (err != SUCCESS) {
        SELF_LOG_ERROR("construct module str failed, log_err=%d.", (int32_t)err);
        XFREE(moduleStr);
        return SYS_ERROR;
    }

    // write module info to shmem
    LogStatus ret = SlogdShmWriteModuleAttr(moduleStr, LogStrlen(moduleStr));
    if (ret != LOG_SUCCESS) {
        XFREE(moduleStr);
        return SYS_ERROR;
    }

    XFREE(moduleStr);
    return SYS_OK;
}

/**
 * @brief ConvertLevelStrToNum: check config level item string and convert it to numeric value;
 * @param [in] confName: config name string
 * @param [in] valStr: option string
 * @param [out] val: option value
 * @param [in] minBound: min value
 * @param [in] maxBound: max value
 * @return: LogRt SUCCESS/others
 */
STATIC LogRt ConvertLevelStrToNum(const char *confName, const char *valStr, int *val, const int minBound,
    const int maxBound)
{
    ONE_ACT_NO_LOG((valStr == NULL) || (val == NULL), return FAILED);
    int64_t res = -1;
    LogStatus ret = LogStrToInt(valStr, &res);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return FAILED, "config value of %s is not a numeric string", confName);
    ONE_ACT_ERR_LOG((res > INT_MAX) || (res < minBound) || (res > maxBound), return FAILED,
        "config value of %s is out of range", confName);
    *val = (int32_t)res;
    return SUCCESS;
}

/**
 * @brief ConvertEnableStrToNum: check config enable item string and convert it to numeric value;
 * @param [in] confName: config name string
 * @param [in] valStr: option string
 * @param [out] val: option value
 * @param [in] disableValue: disable value
 * @param [in] enableValue: enable value
 * @return: LogRt SUCCESS/others
 */
STATIC LogRt ConvertEnableStrToNum(const char *confName, const char *valStr, int *val, const int disableValue,
    const int enableValue)
{
    ONE_ACT_NO_LOG((valStr == NULL) || (val == NULL), return FAILED);
    int64_t res = -1;
    LogStatus ret = LogStrToInt(valStr, &res);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return FAILED, "config value of %s is not a numeric string", confName);
    ONE_ACT_ERR_LOG((res > INT_MAX) || ((res != disableValue) && (res != enableValue)),
        return FAILED, "config value of %s is out of range", confName);
    *val = (int32_t)res;
    return SUCCESS;
}

/**
 * @brief           : update global level from config file
 * @param [in]      : confName      config name in config list
 * @param [in]      : nameLen       length of confName
 * @param [in]      : mask          global level mask
 */
STATIC void SlogdUpdateGlobalLogLevel(const char *confName, uint32_t nameLen)
{
    ONE_ACT_WARN_LOG(confName == NULL, return, "[input] config name is null.");
    ONE_ACT_WARN_LOG(nameLen > CONF_NAME_MAX_LEN, return,
                     "[input] config name length is invalid, length=%u, max_length=%d.",
                     nameLen, CONF_NAME_MAX_LEN);
    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };
    int32_t level = SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK);
    LogRt ret = LogConfListGetValue(confName, nameLen, val, CONF_VALUE_MAX_LEN);
    ONE_ACT_WARN_LOG(ret != SUCCESS, return, "can not get config item, config_name=%s, ret=%d, use default=%d",
        confName, (int32_t)ret, level);
    ret = ConvertLevelStrToNum(confName, val, &level, LOG_MIN_LEVEL, LOG_MAX_LEVEL);
    ONE_ACT_WARN_LOG(ret != SUCCESS, return, "can not get allowed value, config_name=%s, ret=%d, use default=%d.",
        confName, (int32_t)ret, SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK));
    SELF_LOG_INFO("%s = %s.", confName, GetBasicLevelNameById(level));
    SlogdSetGlobalLevel(level, SLOGD_GLOBAL_TYPE_MASK);
}

/**
 * @brief           : update event level from config file
 */
STATIC void SlogdUpdateEventLogLevel(void)
{
    // get value of enableEvent
    int32_t level = SlogdGetEventLevel();
    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };
    LogRt ret = LogConfListGetValue(ENABLEEVENT_KEY, LogStrlen(ENABLEEVENT_KEY), val, CONF_VALUE_MAX_LEN);
    ONE_ACT_WARN_LOG(ret != SUCCESS, return,
        "can not get config item, config_name=%s, ret=%d, use default=%d, 0:disable, 1:enable.", ENABLEEVENT_KEY,
        (int32_t)ret, level);
    ret = ConvertEnableStrToNum(ENABLEEVENT_KEY, val, &level, EVENT_DISABLE_VALUE, EVENT_ENABLE_VALUE);
    ONE_ACT_WARN_LOG(ret != SUCCESS, return,
        "can not get allowed value, config_name=%s, ret=%d, use default=%d, 0:disable, 1:enable.", ENABLEEVENT_KEY,
        (int32_t)ret, SlogdGetEventLevel());
    SELF_LOG_INFO("event level = %d, 0:disable, 1:enable.", level);
    SlogdSetEventLevel(level);
}

/**
 * @brief           : update module level from config file
 */
STATIC void SlogdUpdateModuleLogLevel(void)
{
    int32_t level = SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK);
    for (int32_t moduleId = 0; moduleId < INVLID_MOUDLE_ID; ++moduleId) {
        (void)SlogdSetModuleLevel(moduleId, level, SLOGD_GLOBAL_TYPE_MASK);
    }
    const ModuleInfo *moduleInfo = GetModuleInfos();
    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };
    for (; (moduleInfo != NULL) && (moduleInfo->moduleName != NULL); moduleInfo++) {
        (void)memset_s(val, CONF_VALUE_MAX_LEN + 1, 0, CONF_VALUE_MAX_LEN + 1);
        LogRt ret = LogConfListGetValue(moduleInfo->moduleName, LogStrlen(moduleInfo->moduleName),
            val, CONF_VALUE_MAX_LEN);
        if (ret != SUCCESS) {
            SELF_LOG_INFO("no config_name=%s in config file, result=%d, use default_config_value=%s",
                          moduleInfo->moduleName, (int32_t)ret,
                          GetBasicLevelNameById(SlogdGetModuleLevel(moduleInfo->moduleId, DEBUG_LOG_MASK)));
            continue;
        }

        int64_t moduleLevel = -1;
        if ((LogStrToInt(val, &moduleLevel) == LOG_SUCCESS) &&
            (moduleLevel >= LOG_MIN_LEVEL) && (moduleLevel <= LOG_MAX_LEVEL)) {
            SELF_LOG_INFO("module level changed, module=%s, origin=%s, current=%s.",
                          GetModuleNameById(moduleInfo->moduleId),
                          GetBasicLevelNameById(SlogdGetModuleLevel(moduleInfo->moduleId, DEBUG_LOG_MASK)),
                          GetBasicLevelNameById((int32_t)moduleLevel));
            (void)SlogdSetModuleLevel(moduleInfo->moduleId, (int32_t)moduleLevel, SLOGD_GLOBAL_TYPE_MASK);
        }
    }
}

/**
 * @brief       : refresh log level when detect modifications in config file.
 *                if tmp variables are different with memory variables,
 *                update memory variables and send signal to corresponding processess
 * @param [in]  : setDlogFlag         set dlog level or not
 * @return      : NA
 */
void HandleLogLevelChange(bool setDlogFlag)
{
#ifdef _CLOUD_DOCKER
    LogRt err = LogConfListUpdate(LogConfGetPath()); // update key-value config list, especially loglevel
    NO_ACT_ERR_LOG(err != SUCCESS, "update config list failed, result=%d.", (int32_t)err);
#endif
    // set global log level
    SlogdUpdateGlobalLogLevel(GLOBALLEVEL_KEY, LogStrlen(GLOBALLEVEL_KEY));
    // set event level
    SlogdUpdateEventLogLevel();
    // set module level
    SlogdUpdateModuleLogLevel();

    int32_t ret = UpdateLevelToShMem();
    NO_ACT_ERR_LOG(ret != SYS_OK, "update level info to shmm failed, ret=%d.", ret);
    // only update dlog level at end
    if (setDlogFlag) {
        NO_ACT_ERR_LOG(SetDlogLevel(-1) != SUCCESS, "set device level failed.");
    }
}

LogStatus SlogdLevelInit(int32_t devId, int32_t level, bool isDocker)
{
    if (level != 0) {   // not equal to zero denotes level cmd in slogd arv is set
        SlogdSetGlobalLevel(level, SLOGD_GLOBAL_TYPE_MASK);
    }

    LogStatus ret = SlogdShmInit(devId);
    ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return LOG_FAILURE);

#ifdef APP_LOG_REPORT
    // create thread to dynamic set log level, only support for pf slogd
    ONE_ACT_NO_LOG((devId == -1) && (isDocker == false), SlogdInitDynamicSetLevel());
#else
    TWO_ACT_ERR_LOG(InitModuleArrToShMem() != SYS_OK, SlogdShmExit(), return LOG_FAILURE,
                    "init module arr to shmem failed, quit slogd process.");
    // if not in docker, set dlog level
    HandleLogLevelChange(!isDocker);
#endif

    return LOG_SUCCESS;
}

void SlogdLevelExit(void)
{
    SlogdShmExit();
}