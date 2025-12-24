/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifdef APP_LOG_REPORT
#include "slogd_dynamic_level.h"
#include "operate_loglevel.h"
#include "log_system_api.h"
#include "slogd_firmware_level.h"
#include "log_level_parse.h"
#include "log_print.h"
#include "log_config_api.h"
#include "ascend_hal.h"
#include "log_pm_sig.h"

typedef struct TagFileDataBuf {
    int len;
    char *data;
} FileDataBuf;

typedef struct {
    int32_t devId;
    int32_t moduleNum;
    char *globalLevel;
    char *eventLevel;
    char *moduleLevel;
} GetLevelInfo; // level info for cmd "GetLogLevel"

STATIC ToolUserBlock g_stOperateloglevel;
STATIC ToolMutex g_levelMutex = TOOL_MUTEX_INITIALIZER;

STATIC int32_t ThreadLock(void)
{
    int32_t result = ToolMutexLock(&g_levelMutex);
    if (result != SYS_OK) {
        SELF_LOG_ERROR("lock failed, strerr=%s.", strerror(ToolGetErrorCode()));
    }
    return result;
}

STATIC int32_t ThreadUnLock(void)
{
    int32_t result = ToolMutexUnLock(&g_levelMutex);
    if (result != SYS_OK) {
        SELF_LOG_ERROR("unlock failed, strerr=%s.", strerror(ToolGetErrorCode()));
    }
    return result;
}

/**
 * @brief ReadFileToBuffer: read config file to buffer, only used in the function 'ReadFileAll'
 * @param [in]fp: config file handle, it mustn't null
 * @param [in]cfgFile: config file path with fileName, it mustn't null
 * @param [out]dataBuf: conif file file data, it mustn't null
 * @return: ARGV_NULL/MALLOC_FAILED/SUCCESS/others
 */
STATIC LogRt ReadFileToBuffer(FILE *fp, const char *cfgFile, FileDataBuf *dataBuf)
{
    // Get cfg file size
    struct stat st;
    if (fstat(fileno(fp), &st) != 0) {
        SELF_LOG_ERROR("get file state failed, file=%s, strerr=%s.", cfgFile, strerror(ToolGetErrorCode()));
        return READ_FILE_ERR;
    }

    if ((st.st_size <= 0) || (st.st_size > SLOG_CONFIG_FILE_SIZE)) {
        SELF_LOG_WARN("file size is invalid, file=%s, file_size=%ld.", cfgFile, st.st_size);
        return READ_FILE_ERR;
    }

    char *fileBuf = (char *)LogMalloc((size_t)st.st_size + 1U);
    if (fileBuf == NULL) {
        SELF_LOG_ERROR("malloc failed, size=%ld, strerr=%s.", st.st_size, strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }

    size_t ret = fread(fileBuf, 1, (size_t)st.st_size, fp);
    if (ret != (size_t)st.st_size) {
        SELF_LOG_ERROR("read file failed, file=%s, result=%zu, strerr=%s.", cfgFile, ret, strerror(ToolGetErrorCode()));
        XFREE(fileBuf);
        return READ_FILE_ERR;
    }

    fileBuf[st.st_size] = '\0';
    dataBuf->len = (int32_t)ret;
    dataBuf->data = fileBuf;
    return SUCCESS;
}

/**
 * @brief ReadFileAll: read config file
 * @param [in]cfgFile: config file path with fileName
 * @param [out]dataBuf: conif file file data
 * @return: ARGV_NULL/MALLOC_FAILED/SUCCESS/others
 */
STATIC LogRt ReadFileAll(const char *cfgFile, FileDataBuf *dataBuf)
{
    ONE_ACT_WARN_LOG(cfgFile == NULL, return ARGV_NULL, "[input] config file is null.");
    ONE_ACT_WARN_LOG(dataBuf == NULL, return ARGV_NULL, "[input] file data buffer is null.");

    char *pPath = (char *)LogMalloc(TOOL_MAX_PATH + 1U);
    if (pPath == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }

    // Get cfg file absolute path
    if (ToolRealPath(cfgFile, pPath, TOOL_MAX_PATH + 1) != SYS_OK) {
        SELF_LOG_ERROR("get file realpath failed, file=%s, strerr=%s.", cfgFile, strerror(ToolGetErrorCode()));
        XFREE(pPath);
        return GET_CONF_FILEPATH_FAILED;
    }

    size_t fileLen = strlen(pPath);
    if (!LogConfCheckPath(pPath, fileLen)) {
        SELF_LOG_WARN("file realpath is invalid, file=%s, realpath=%s.", cfgFile, pPath);
        XFREE(pPath);
        return CONF_FILEPATH_INVALID;
    }

    FILE *fp = fopen(pPath, "r");
    if (fp == NULL) {
        SELF_LOG_ERROR("open file failed, file=%s, strerr=%s.", cfgFile, strerror(ToolGetErrorCode()));
        XFREE(pPath);
        return OPEN_CONF_FAILED;
    }
    XFREE(pPath);

    LogRt res = ReadFileToBuffer(fp, cfgFile, dataBuf);
    LOG_CLOSE_FILE(fp);
    return res;
}

/**
 * @brief WriteToSlogCfg: write buf to override config file
 * @param [in]cfgFile: config file info
 * @param [in]fileBuf: file content after modified
 * @return SUCCESS: succeed; others: failed;
 */
STATIC LogRt WriteToSlogCfg(const char *cfgFile, const FileDataBuf fileBuf)
{
    char *pPath =  NULL;
    LogRt res = SUCCESS;

    do {
        pPath = (char *)LogMalloc(TOOL_MAX_PATH + 1U);
        if (pPath == NULL) {
            SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
            res = MALLOC_FAILED;
            break;
        }
        if (ToolRealPath(cfgFile, pPath, TOOL_MAX_PATH + 1) != SYS_OK) {
            SELF_LOG_ERROR("get file realpath failed, file=%s.", cfgFile);
            res = GET_CONF_FILEPATH_FAILED;
            break;
        }

        size_t fileLen = strlen(pPath);
        if (!LogConfCheckPath(pPath, fileLen)) {
            SELF_LOG_WARN("file realpath is invalid, file=%s, realpath=%s.", cfgFile, pPath);
            res = CONF_FILEPATH_INVALID;
            break;
        }

        int fd = ToolOpenWithMode((const char *)pPath, M_WRONLY, M_IRUSR | M_IWUSR);
        if (fd < 0) {
            SELF_LOG_ERROR("open file failed, file=%s.", cfgFile);
            res = OPEN_CONF_FAILED;
            break;
        }

        int ret = ToolWrite(fd, fileBuf.data, (unsigned int)fileBuf.len);
        if (ret != fileBuf.len) {
            SELF_LOG_ERROR("write to file failed, file=%s, result=%d, file_buffer_size=%d.", cfgFile, ret, fileBuf.len);
            res = SET_LEVEL_ERR;
        }
        LOG_CLOSE_FD(fd);
    } while (0);

    XFREE(pPath);
    return res;
}

/**
 * @brief SetSlogCfgLevel: set level to config file
 * @param [in]cfgFile: config file info
 * @param [in]cfgName: config file name
 * @param [in]level: level id
 * @return SUCCESS: succeed; others: failed;
 */
STATIC LogRt SetSlogCfgLevel(const char *cfgFile, const char *cfgName, int level)
{
    FileDataBuf fileBuf = { 0, NULL };
    char *fullCfgName = NULL;
    const size_t levelConfigLen = 2;

    ONE_ACT_WARN_LOG(cfgFile == NULL, return ARGV_NULL, "[input] config file is null.");
    ONE_ACT_WARN_LOG(cfgName == NULL, return ARGV_NULL, "[input] config name is null.");

    LogRt res = ReadFileAll(cfgFile, &fileBuf);
    ONE_ACT_ERR_LOG(res != SUCCESS, return res, "read file all to buffer failed, file=%s.", cfgFile);

    do {
        size_t cfgNameLen = strlen(cfgName);
        if ((cfgNameLen <= 0) || (cfgNameLen > CONFIG_NAME_MAX_LENGTH)) {
            SELF_LOG_WARN("config name is empty or to long. length=%zu.", cfgNameLen);
            res = INPUT_INVALID;
            break;
        }
        fullCfgName = (char *)LogMalloc(cfgNameLen + levelConfigLen + 1U);
        if (fullCfgName == NULL) {
            SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
            res = MALLOC_FAILED;
            break;
        }
        fullCfgName[0] = '\n';
        size_t i = 1;
        for (; i < (cfgNameLen + 1); i++) {
            fullCfgName[i] = cfgName[i - 1];
        }
        fullCfgName[i] = '=';

        // find cfgName pos in cfgFile
        char *ptr = strstr(fileBuf.data, fullCfgName);
        if (ptr == NULL) {
            break;
        }

        // ptr point to 'cfgName=' after
        ptr = ptr + 1 + strlen(cfgName) + 1; // +1 represents '\n' and '='

        // clear all string after 'cfgName=' except comment
        char *endCfgPtr = ptr;
        while ((*endCfgPtr != '\r') && (*endCfgPtr != '\n') && (*endCfgPtr != '#') && (*endCfgPtr != '\0')) {
            *endCfgPtr = ' ';
            endCfgPtr++;
        }
        // change cfgName val
        *ptr = '0' + level;

        res = WriteToSlogCfg(cfgFile, fileBuf);
    } while (0);

    XFREE(fullCfgName);
    XFREE(fileBuf.data);

    return res;
}

/**
 * @brief       : set all module level to config file
 * @param [in]  : devId         device id
 * @param [in]  : logLevel      level
 * @return      : SUCCESS: succeed; others: failed
 */
STATIC LogRt SetAllModuleLevel(int32_t devId, int32_t logLevel)
{
    const ModuleInfo *moduleInfo = GetModuleInfos();
    ONE_ACT_NO_LOG(moduleInfo == NULL, return ARGV_NULL);
    // modify all module loglevel in slog.conf
    LogRt ret = SUCCESS;
    for (; moduleInfo->moduleId != INVALID; moduleInfo++) {
        if (!SlogdSetModuleLevelByDevId(devId, moduleInfo->moduleId, logLevel, SLOGD_GLOBAL_TYPE_MASK)) {
            SELF_LOG_ERROR("set module level failed, devId=%d, moduleId=%d, level=%d.",
                           devId, moduleInfo->moduleId, logLevel);
        }
        LogRt setRes = SetSlogCfgLevel(LogConfGetPath(), moduleInfo->moduleName, logLevel);
        if (setRes != SUCCESS) {
            ret = (ret == SUCCESS) ? setRes : ret;
            SELF_LOG_ERROR("set module level to file failed, module_name=%s, file=%s.",
                           moduleInfo->moduleName, LogConfGetPath());
        }
    }

    return ret;
}

STATIC void ToUpper(char *str)
{
    if (str == NULL) {
        return;
    }

    char *ptr = str;
    while (*ptr != '\0') {
        if ((*ptr <= 'z') && (*ptr >= 'a')) {
            *ptr = 'A' - 'a' + *ptr;
        }
        ptr++;
    }
}

/**
 * @brief       : set global log level
 * @param [in]  : data      level setting info, format: "[info]"
 * @param [in]  : devId     device id
 * @return      : SUCCESS: succeed; others: failed;
 */
STATIC LogRt SetGlobalLogLevel(char *data, int32_t devId)
{
    ONE_ACT_WARN_LOG(data == NULL, return ARGV_NULL, "[input] global level string is null.");

    char *levelStr = data;
    ONE_ACT_WARN_LOG(*levelStr != '[', return LEVEL_INFO_ILLEGAL, \
                     "global level info has no '[', level_string=%s.", levelStr);

    size_t len = strlen(levelStr);
    ONE_ACT_WARN_LOG(levelStr[len - 1] != ']', return LEVEL_INFO_ILLEGAL, \
                     "global level info has no ']', level_string=%s.", levelStr);

    levelStr[len - 1] = '\0';
    levelStr++;
    ToUpper(levelStr);
    int32_t level = GetLevelIdByName(levelStr);
    ONE_ACT_WARN_LOG((level < LOG_MIN_LEVEL) || (level > LOG_MAX_LEVEL), return LEVEL_INFO_ILLEGAL,
                     "global level is invalid, str=%s.", levelStr);

    int result = ThreadLock();
    ONE_ACT_NO_LOG(result != 0, return FAILED);
    SlogdSetGlobalLevel(level, SLOGD_GLOBAL_TYPE_MASK);

    // set global level to slog.conf
    LogRt res = SetSlogCfgLevel(LogConfGetPath(), GLOBALLEVEL_KEY, level);
    NO_ACT_ERR_LOG(res != SUCCESS, "set global level to file(%s) failed, result=%d.", LogConfGetPath(), (int32_t)res);

    // set all module level to slog.conf
    LogRt moduleSettingRes = SetAllModuleLevel(devId, level);
    if (moduleSettingRes != SUCCESS) {
        SELF_LOG_ERROR("set all module level failed, result=%d.", (int32_t)moduleSettingRes);
        res = (res == SUCCESS) ? moduleSettingRes : res;
    }
    // update key-value config list, especially loglevel
    LogRt err = LogConfListUpdate(LogConfGetPath());
    (void)ThreadUnLock();
    ONE_ACT_ERR_LOG(err != SUCCESS, return res, "update config list failed, result=%d.", (int32_t)err);

    LogRt deviceSettingRes = SetDlogLevel(devId);
    if (deviceSettingRes != SUCCESS) {
        SELF_LOG_ERROR("set device level failed, result=%d.", (int32_t)deviceSettingRes);
        res = (res == SUCCESS) ? deviceSettingRes : res;
    }

    // write level info to shmem
    int ret = UpdateLevelToShMem();
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("update level info to shmem failed.");
        res = (res == SUCCESS) ? LEVEL_NOTIFY_FAILED : res;
    }
    return res;
}

/**
 * @brief       : judge is only one device or not
 * @return      : true   one device;
 *                false  multiple device;
 */
STATIC bool IsOnlyOneDevice(void)
{
    int32_t deviceId[LOG_DEVICE_ID_MAX] = { 0 };
    int32_t deviceNum = 0;
    int32_t ret = log_get_device_id(deviceId, &deviceNum, LOG_DEVICE_ID_MAX);
    if ((ret != SYS_OK) || (deviceNum > LOG_DEVICE_ID_MAX)) {
        SELF_LOG_ERROR("get device id failed, result=%d, device_number=%d, max_device_id=%d.",
                       ret, deviceNum, LOG_DEVICE_ID_MAX);
        return false;
    } else if (deviceNum == 1) {
        return true;
    } else {
        return false;
    }
}

/**
 * @brief       : set module level
 * @param [in]  : data      level setting info, format: "[module:level]"
 * @param [in]  : devId     device id
 * @return      : SUCCESS: succeed; others: failed;
 */
STATIC LogRt SetModuleLogLevel(char *data, int32_t devId)
{
    ONE_ACT_WARN_LOG(data == NULL, return ARGV_NULL, "[input] module level string is null.");
    char *levelStr = data;
    size_t len = strlen(levelStr);

    ONE_ACT_WARN_LOG((levelStr[0] != '[') || (levelStr[len - 1] != ']'), return LEVEL_INFO_ILLEGAL, \
                     "module level info has no '[' or ']', level_string=%s.", levelStr);

    levelStr[len - 1] = '\0';
    levelStr++;
    char *pend = strchr(levelStr, ':');
    ONE_ACT_WARN_LOG(pend == NULL, return LEVEL_INFO_ILLEGAL, \
                     "module level info has no ':', level_string=%s.", levelStr);

    ToUpper(levelStr);
    char modName[MAX_MODULE_NAME_LEN] = { 0 };
    int retValue = memcpy_s(modName, MAX_MODULE_NAME_LEN, levelStr, pend - levelStr);
    ONE_ACT_ERR_LOG(retValue != EOK, return STR_COPY_FAILED, \
                    "memcpy_s failed, result=%d, strerr=%s.", retValue, strerror(ToolGetErrorCode()));

    const ModuleInfo *moduleInfo = GetModuleInfoByName((const char *)modName);
    ONE_ACT_WARN_LOG(moduleInfo == NULL, return LEVEL_INFO_ILLEGAL, \
                     "module name does not exist, module=%s.", modName);

    int32_t level = GetLevelIdByName(pend + 1);
    ONE_ACT_WARN_LOG((level < LOG_MIN_LEVEL) || (level > LOG_MAX_LEVEL), return LEVEL_INFO_ILLEGAL,
                     "module level is invalid, level_string=%s.", levelStr);

    if (!SlogdSetModuleLevelByDevId(devId, moduleInfo->moduleId, level, SLOGD_GLOBAL_TYPE_MASK)) {
        SELF_LOG_ERROR("set module level failed, devId=%d, moduleId=%d, level=%d.", devId, moduleInfo->moduleId, level);
        return FAILED;
    }

    LogRt res;
    if (IsMultipleModule(moduleInfo->moduleId)) {
        res = SetDlogLevel(devId);
        ONE_ACT_ERR_LOG(res != SUCCESS, return FAILED,
                        "set firmware level failed, module=%s, result=%d.", modName, (int32_t)res);
        // multiple devices one OS, no need to update level to slog.conf
        if (!IsOnlyOneDevice()) {
            return SUCCESS;
        }
    }

    int result = ThreadLock();
    ONE_ACT_NO_LOG(result != 0, return FAILED);
    // set module level to config file
    res = SetSlogCfgLevel(LogConfGetPath(), modName, level);
    NO_ACT_ERR_LOG(res != SUCCESS, "set module level to file failed, file=%s, module=%s, result=%d.", \
                   LogConfGetPath(), modName, (int32_t)res);
    // update key-value config list, especially loglevel
    LogRt err = LogConfListUpdate(LogConfGetPath());
    (void)ThreadUnLock();
    ONE_ACT_ERR_LOG(err != SUCCESS, return res, "update config list failed, result=%d.", (int32_t)err);

    // write level info to shmem
    int ret = UpdateLevelToShMem();
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("update level info to shmem failed.");
        res = (res == SUCCESS) ? LEVEL_NOTIFY_FAILED : res;
    }
    return res;
}

/**
 * @brief       : set event level
 * @param [in]  : data      level setting info, format: "[enable]"/"[disable]"
 * @return      : SUCCESS: succeed; others: failed
 */
STATIC LogRt SetEventLevelValue(char *data)
{
    if (data == NULL) {
        SELF_LOG_WARN("[input] event level info is null.");
        return ARGV_NULL;
    }

    char *levelStr = data;
    if (*levelStr != '[') {
        SELF_LOG_WARN("event level info has no '[', level=%s.", levelStr);
        return LEVEL_INFO_ILLEGAL;
    }

    size_t len = strlen(levelStr);
    if (levelStr[len - 1] != ']') {
        SELF_LOG_WARN("event level info has no ']', level=%s.", levelStr);
        return LEVEL_INFO_ILLEGAL;
    }
    levelStr[len - 1] = '\0';
    levelStr++;

    ToUpper(levelStr);

    int levelValue = (strcmp(EVENT_ENABLE, levelStr) == 0) ? 1 : ((strcmp(EVENT_DISABLE, levelStr) == 0) ? 0 : -1);
    if (levelValue == -1) {
        SELF_LOG_WARN("event level is invalid, level=%s.", levelStr);
        return LEVEL_INFO_ILLEGAL;
    }

    int result = ThreadLock();
    ONE_ACT_NO_LOG(result != 0, return FAILED);
    LogRt res = SetSlogCfgLevel(LogConfGetPath(), ENABLEEVENT_KEY, levelValue);
    if (res != SUCCESS) {
        SELF_LOG_ERROR("write event level to file failed, file=%s, result=%d.", LogConfGetPath(), (int32_t)res);
    }
    LogRt err = LogConfListUpdate(LogConfGetPath());
    (void)ThreadUnLock();
    ONE_ACT_ERR_LOG(err != SUCCESS, return res, "update config list failed, result=%d.", (int32_t)err);

    SlogdSetEventLevel(levelValue);

    // write level info to shmem
    int ret = UpdateLevelToShMem();
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("update level info to shmem failed.");
        res = (res == SUCCESS) ? LEVEL_NOTIFY_FAILED : res;
    }
    return res;
}

/**
 * @brief       : set log level
 * @param [in]  : data          level setting info, format: 'SetLogLevel(scope)[levelInfo]'.
 * @return      : SUCCESS   succeed; others  failed;
 */
STATIC LogRt SetLogLevelValue(LogCmdMsg data)
{
    LogRt ret = LEVEL_INFO_ILLEGAL;
    char *levelStr = NULL;

    if (LogStrStartsWith(data.msgData, SET_LOG_LEVEL_STR) == false) {
        SELF_LOG_WARN("level data is invalid, default prefix is %s.", SET_LOG_LEVEL_STR);
        return ret;
    }

    levelStr = data.msgData + strlen(SET_LOG_LEVEL_STR);
    if (*levelStr != '(') {
        SELF_LOG_WARN("level command is invalid, level_command=%s.", data.msgData);
        return ret;
    }
    levelStr++;

    int globalMode = *levelStr - '0';
    levelStr++;
    if (*levelStr != ')') {
        SELF_LOG_WARN("level command is invalid, level_command=%s.", data.msgData);
        return ret;
    }
    levelStr++;

    switch (globalMode) {
        case LOGLEVEL_GLOBAL:
            ret = SetGlobalLogLevel(levelStr, data.phyDevId);
            break;
        case LOGLEVEL_MODULE:
            ret = SetModuleLogLevel(levelStr, data.phyDevId);
            break;
        case LOGLEVEL_EVENT:
            ret = SetEventLevelValue(levelStr);
            break;
        default:
            SELF_LOG_WARN("level command type is invalid, level_command=%s.", data.msgData);
            break;
    }
    return ret;
}

/**
 * @brief       : response level setting result by msg queue
 * @param [in]  : res               level setting error code
 * @param [in]  : queueId           message queue id
 * @param [in]  : logLevelResult    log level result
 * @return      : NA
 */
STATIC void RespSettingResult(LogRt res, toolMsgid queueId, const char *logLevelResult)
{
    LogCmdMsg resMsg = { 0, -1, "" };

    int32_t ret;
    resMsg.msgType = FEEDBACK_MSG_TYPE;
    switch (res) {
        case SUCCESS:
            ret = strcpy_s(resMsg.msgData, MSG_MAX_LEN, logLevelResult);
            break;
        case CONF_FILEPATH_INVALID:
        case GET_CONF_FILEPATH_FAILED:
        case OPEN_CONF_FAILED:
            ret = strcpy_s(resMsg.msgData, MSG_MAX_LEN, SLOG_CONF_ERROR_MSG);
            break;
        case LEVEL_INFO_ILLEGAL:
            ret = strcpy_s(resMsg.msgData, MSG_MAX_LEN, LEVEL_INFO_ERROR_MSG);
            break;
        case MALLOC_FAILED:
            ret = strcpy_s(resMsg.msgData, MSG_MAX_LEN, MALLOC_ERROR_MSG);
            break;
        case STR_COPY_FAILED:
            ret = strcpy_s(resMsg.msgData, MSG_MAX_LEN, STR_COPY_ERROR_MSG);
            break;
        default:
            ret = strcpy_s(resMsg.msgData, MSG_MAX_LEN, UNKNOWN_ERROR_MSG);
            break;
    }
    if (ret != EOK) {
        SELF_LOG_ERROR("strcpy_s failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    }

    LogStatus err = MsgQueueSend(queueId, (void *)(&resMsg), MSG_MAX_LEN, false);
    if (err != LOG_SUCCESS) {
        SELF_LOG_ERROR("response message to daemon client error, strerr=%s, response=%s.",
                       strerror(ToolGetErrorCode()), resMsg.msgData);
    }
}

/**
 * @brief IsModule: judge whether it belongs to modules
 * @param [in]confName: conf name
 * @return true: true; others: false;
 */
STATIC bool IsModule(const char *confName)
{
    const ModuleInfo *moduleInfo = GetModuleInfoByName(confName);
    return moduleInfo != NULL;
}

/**
 * @brief       : construct valid value to moduleLevel
 * @param [out] : level         pointer to save level string and module number
 * @param [in]  : listNode      pointer of list node
 * @return      : SYS_OK   succeed; SYS_ERROR   failed;
 */
STATIC int32_t ConstructModuleLevel(GetLevelInfo *level, const ConfList *listNode, bool isNewStyle)
{
    if ((level == NULL) || (listNode == NULL)) {
        return SYS_ERROR;
    }

    int64_t value = -1;
    int32_t ret;
    const ModuleInfo *moduleInfo = GetModuleInfoByName(listNode->confName);
    if ((moduleInfo != NULL) && IsMultipleModule(moduleInfo->moduleId)) {
        // get level from moduleInfo
        value = SlogdGetModuleLevelByDevId(level->devId, moduleInfo->moduleId, DEBUG_LOG_MASK);
    } else {
        // get level from confList
        ret = LogStrToInt(listNode->confValue, &value);
        if ((ret!= LOG_SUCCESS) || (value < LOG_MIN_LEVEL) || (value > LOG_MAX_LEVEL)) {
            value = MODULE_DEFAULT_LOG_LEVEL;
        }
    }
    const char *levelName = GetLevelNameById(value);
    ONE_ACT_ERR_LOG(levelName == NULL, return SYS_ERROR, "get level name failed, level=%ld.", value);

    char moduleStr[SINGLE_MODULE_MAX_LEN] = { 0 };
    if (isNewStyle) {
        ret = snprintf_s(moduleStr, SINGLE_MODULE_MAX_LEN, SINGLE_MODULE_MAX_LEN - 1,
                         "%s:%s,", listNode->confName, levelName);
    } else {
        ret = snprintf_s(moduleStr, SINGLE_MODULE_MAX_LEN, SINGLE_MODULE_MAX_LEN - 1,
                         "%s:%s ", listNode->confName, levelName);
    }
    ONE_ACT_ERR_LOG(ret == -1, return SYS_ERROR,
                    "snprintf_s single module failed, strerr=%s.", strerror(ToolGetErrorCode()));
    ret = strcat_s(level->moduleLevel, INVLID_MOUDLE_ID * SINGLE_MODULE_MAX_LEN, moduleStr);
    ONE_ACT_ERR_LOG(ret != EOK, return SYS_ERROR,
                    "strcat_s single module failed, strerr=%s.", strerror(ToolGetErrorCode()));
    level->moduleNum++;
    if (((level->moduleNum % LOG_EVENT_WRAP_NUM) == 0) && !isNewStyle) {
        ret = strcat_s(level->moduleLevel, INVLID_MOUDLE_ID * SINGLE_MODULE_MAX_LEN, "\n");
        ONE_ACT_ERR_LOG(ret != EOK, return SYS_ERROR,
                        "strcat_s failed, strerr=%s.", strerror(ToolGetErrorCode()));
    }
    return SYS_OK;
}

/**
 * @brief       : construct valid value to eventLevel
 * @param [out] : dst           pointer to save level string
 * @param [in]  : valueString   pointer of level value
 * @return      : SYS_OK   succeed; SYS_ERROR   failed;
 */
STATIC int32_t ConstructEventLevel(char *dst, const char *valueString)
{
    if ((dst == NULL) || (valueString == NULL)) {
        return SYS_ERROR;
    }
    int64_t value = -1;
    int32_t ret = LogStrToInt(valueString, &value);
    if ((ret!= LOG_SUCCESS) || (value != EVENT_DISABLE_VALUE)) {
        value = EVENT_ENABLE_VALUE;
    }
    const char *eventStr = (value == EVENT_ENABLE_VALUE) ? EVENT_ENABLE : EVENT_DISABLE;
    ret = strncpy_s(dst, GLOBAL_ENABLE_MAX_LEN, eventStr, strlen(eventStr));
    ONE_ACT_ERR_LOG(ret != EOK, return SYS_ERROR,
                    "strncpy_s event level failed, strerr=%s.", strerror(ToolGetErrorCode()));
    return SYS_OK;
}

/**
 * @brief       : construct valid value to globalLevel
 * @param [out] : dst           pointer to save level string
 * @param [in]  : valueString   pointer of level value
 * @param [in]  : mask          level mask
 * @return      : SYS_OK   succeed; SYS_ERROR   failed;
 */
STATIC int32_t ConstructGlobalLevel(char *dst, const char *valueString, int32_t mask)
{
    if ((dst == NULL) || (valueString == NULL)) {
        return SYS_ERROR;
    }
    int64_t value = -1;
    int32_t ret = LogStrToInt(valueString, &value);
    if ((ret!= LOG_SUCCESS) || (value < LOG_MIN_LEVEL) || (value > LOG_MAX_LEVEL)) {
        if (mask == DEBUG_LOG_MASK) {
            value = GLOABLE_DEFAULT_DEBUG_LOG_LEVEL;
        } else if (mask == RUN_LOG_MASK) {
            value = GLOABLE_DEFAULT_RUN_LOG_LEVEL;
        } else {
            value = GLOABLE_DEFAULT_LOG_LEVEL;
        }
    }
    const char *levelName = GetLevelNameById(value);
    ONE_ACT_ERR_LOG(levelName == NULL, return SYS_ERROR, "get level name failed, level=%ld.", value);
    ret = strncpy_s(dst, GLOBAL_ENABLE_MAX_LEN, levelName, strlen(levelName));
    ONE_ACT_ERR_LOG(ret != EOK, return SYS_ERROR,
                    "strncpy_s global level failed, strerr=%s.", strerror(ToolGetErrorCode()));
    return SYS_OK;
}

/**
 * @brief       : compare with node's confName, if it's level, save the string
 * @param [in]  : node          pointer of list node
 * @param [out] : arg           pointer to save level string
 * @return      : SYS_OK   succeed; SYS_ERROR   failed;
 */
STATIC int32_t FindLevelFunc(const Buff *node, ArgPtr arg, bool isNewStyle)
{
    if ((node == NULL) || (arg == NULL)) {
        return SYS_ERROR;
    }
    const ConfList *listNode = (const ConfList *)node;
    GetLevelInfo *level = (GetLevelInfo *)arg;

    int32_t ret = SYS_OK;
    if (strcmp(GLOBALLEVEL_KEY, listNode->confName) == 0) {
        ret = ConstructGlobalLevel(level->globalLevel, listNode->confValue, SLOGD_GLOBAL_TYPE_MASK);
    } else if (strcmp(ENABLEEVENT_KEY, listNode->confName) == 0) {
        ret = ConstructEventLevel(level->eventLevel, listNode->confValue);
    } else if (IsModule(listNode->confName)) {
        ret = ConstructModuleLevel(level, listNode, isNewStyle);
    }

    return ret;
}

/**
 * @brief       : get string of log level
 * @param [out] : logLevelResult    pointer to save result
 * @param [in]  : devId             device physics id
 * @return      : SUCCESS   succeed; others  failed;
 */
STATIC LogRt GetLogLevelValue(char *logLevelResult, int32_t devId, bool isNewStyle)
{
    char globalLevel[GLOBAL_ENABLE_MAX_LEN] = { 0 };
    char eventLevel[GLOBAL_ENABLE_MAX_LEN] = { 0 };
    char *moduleLevel = (char *)calloc(1, INVLID_MOUDLE_ID * SINGLE_MODULE_MAX_LEN);
    if (moduleLevel == NULL) {
        XFREE(moduleLevel);
        SELF_LOG_ERROR("calloc moduleLevel failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return CALLOC_FAILED;
    }

    GetLevelInfo levelValue;
    levelValue.devId = devId;
    levelValue.moduleNum = 0;
    levelValue.globalLevel = globalLevel;
    levelValue.eventLevel = eventLevel;
    levelValue.moduleLevel = moduleLevel;
    // traverse list to find level, save level value string
    int32_t ret = LogConfListTraverse(FindLevelFunc, (ArgPtr)&levelValue, isNewStyle);
    if (ret != SYS_OK) {
        XFREE(moduleLevel);
        SELF_LOG_ERROR("find level string failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return STR_COPY_FAILED;
    }

    // construct result string
    if (isNewStyle) {
        ret = snprintf_s(logLevelResult, MSG_MAX_LEN + 1, MSG_MAX_LEN, "Global:%s,Event:%s,%s",
                         globalLevel, eventLevel, moduleLevel);
    } else {
        const char *global = "[global]\n";
        const char *event = "[event]\n";
        const char *module = "[module]\n";
        ret = snprintf_s(logLevelResult, MSG_MAX_LEN + 1, MSG_MAX_LEN, "%s%s%s%s%s%s%s%s",
                         global, globalLevel, "\n", event, eventLevel, "\n", module, moduleLevel);
    }
    if (ret == -1) {
        XFREE(moduleLevel);
        SELF_LOG_ERROR("construct result and copy to logLevelResult failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return STR_COPY_FAILED;
    }
    XFREE(moduleLevel);
    return SUCCESS;
}

/**
 * @brief       : receive and process cmd
 * @return      : NA
 */
STATIC void ReceiveAndProcessLogLevel(void)
{
    LogStatus result = LOG_FAILURE;
    toolMsgid queueId = INVALID;
    LogCmdMsg data = { 0, -1, "" };
    LogRt res = LEVEL_INFO_ILLEGAL;
    while (LogGetSigNo() == 0) {
        if (queueId == INVALID) {
            result = MsgQueueOpen(&queueId);
            TWO_ACT_WARN_LOG(result != LOG_SUCCESS, (void)ToolSleep(ONE_SECOND), continue,
                             "can not create message queue, then try to create again, strerr=%s.",
                             strerror(ToolGetErrorCode()));
        }

        result = MsgQueueRecv(queueId, (void *)(&data), MSG_MAX_LEN, false, FORWARD_MSG_TYPE);
        if (result != LOG_SUCCESS) {
            // Interrupted system call
            ONE_ACT_NO_LOG(ToolGetErrorCode() == EINTR, continue);
            SELF_LOG_WARN("can not receive message, result=%d, strerr=%s.", result, strerror(ToolGetErrorCode()));
            queueId = INVALID;
            (void)ToolSleep(10); // sleep 10ms
            continue;
        }

        char responseString[MSG_MAX_LEN + 1] = LEVEL_SETTING_SUCCESS;
        if (strcmp(GET_LOG_LEVEL_STR, data.msgData) == 0) {
            res = GetLogLevelValue(responseString, data.phyDevId, false);
            SELF_LOG_INFO("get log level, phyDevId=%d, receive_data=%s, level_getting_result=%d, logLevelResult=%s",
                          data.phyDevId, data.msgData, (int32_t)res, responseString);
        } else if (strcmp(GET_LOG_LEVEL_TABLE_FORMAT, data.msgData) == 0) {
            res = GetLogLevelValue(responseString, data.phyDevId, true);
            SELF_LOG_INFO("get log level, phyDevId=%d, receive_data=%s, level_getting_result=%d, logLevelResult=%s",
                          data.phyDevId, data.msgData, (int32_t)res, responseString);
        } else {
            res = SetLogLevelValue(data);
            SELF_LOG_INFO("set log level, phyDevId=%d, receive_data=%s, level_setting_result=%d.",
                          data.phyDevId, data.msgData, (int32_t)res);
        }
        RespSettingResult(res, queueId, responseString);
    }

    MsgQueueRemove();
}

/**
 * @brief       : set or get log level by msg queue
 * @param [in]  : args      ptr passed by pthread func
 * @return      : NA
 */
STATIC void *OperateLogLevel(const ArgPtr args)
{
    (void)args;
    NO_ACT_WARN_LOG(ToolSetThreadName("LogLevelOperate") != SYS_OK, "can not set thread name(LogLevelOperate).");

    ONE_ACT_ERR_LOG(InitModuleArrToShMem() != SYS_OK, return NULL,
                    "init module arr to shmem failed, Thread(operateLogLevel) quit.");
    // it's nessary to set dlog level if thread start
    HandleLogLevelChange(true);

    // thread main loop
    ReceiveAndProcessLogLevel();
    SELF_LOG_ERROR("Thread(setLogLevel) quit, signal=%d.", LogGetSigNo());
    return NULL;
}

/**
 * @brief       : slogd init adx hdc server, will create thread to dynamic set log level
 * @return      : NA
 */
void SlogdInitDynamicSetLevel(void)
{
    g_stOperateloglevel.procFunc = OperateLogLevel;
    ToolThreadAttr threadAttr = {1, 0, 0, 0, 0, 1, 128 * 1024}; // Default ThreadSize(128KB)
    ToolThread tid = 0;
    NO_ACT_ERR_LOG(ToolCreateTaskWithThreadAttr(&tid, &g_stOperateloglevel, &threadAttr) != SYS_OK,
                   "create task(setLevel) failed, strerr=%s, then quit slogd process.",
                   strerror(ToolGetErrorCode()));
}
#endif

