/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_config_common.h"
#include "log_config_api.h"
#include "log_common.h"
#include "log_print.h"
#include "log_file_util.h"

#define CFG_FILE_BUFFIX1 ".cfg"
#define CFG_FILE_BUFFIX2 ".conf"
#define CFG_FILE_BUFFIX3 ".info"

bool LogConfCheckPath(const char *ppath, size_t pathLen)
{
    ONE_ACT_WARN_LOG(ppath == NULL, return false, "[input] file realpath is null.");
    ONE_ACT_WARN_LOG(pathLen == 0, return false,
                     "[input] filepath length is invalid, path_length=%zu.", pathLen);

    const char *buffix1 = strstr(ppath, CFG_FILE_BUFFIX1);
    const char *buffix2 = strstr(ppath, CFG_FILE_BUFFIX2);
    const char *buffix3 = strstr(ppath, CFG_FILE_BUFFIX3);
    if (((buffix1 != NULL) && (strcmp(buffix1, CFG_FILE_BUFFIX1) == 0)) ||
        ((buffix2 != NULL) && (strcmp(buffix2, CFG_FILE_BUFFIX2) == 0)) ||
        ((buffix3 != NULL) && (strcmp(buffix3, CFG_FILE_BUFFIX3) == 0))) {
        return true;
    }
    return false;
}

STATIC char *LogConfRealPath(const char *file, const char *homeDir, size_t dirLen)
{
    if (homeDir == NULL) {
        SELF_LOG_WARN("[input] home directory is null.");
        return NULL;
    }

    if ((dirLen > TOOL_MAX_PATH) || (dirLen == 0)) {
        SELF_LOG_WARN("[input] directory length is invalid, " \
                      "directory_length=%zu, max_length=%d.", dirLen, TOOL_MAX_PATH);
        return NULL;
    }

    char *ppath = (char *)LogMalloc(dirLen + 1U);
    if (ppath == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return NULL;
    }

    if (ToolRealPath((file != NULL) ? homeDir : SLOG_CONF_FILE_PATH, ppath, (INT32)dirLen + 1) != SYS_OK) {
        SELF_LOG_ERROR("get realpath failed, file=%s, strerr=%s.", file, strerror(ToolGetErrorCode()));
        XFREE(ppath);
        return NULL;
    }

    size_t cfgFileLen = strlen(ppath);
    if (LogConfCheckPath(ppath, cfgFileLen) == false) {
        SELF_LOG_WARN("realpath is invalid, realpath=%s.", ppath);
        XFREE(ppath);
        return NULL;
    }

    return ppath;
}

// truncate string from first blank char or '#' after given position
STATIC void LogConfTrimString(char *str)
{
    ONE_ACT_NO_LOG(str == NULL, return);

    const char *head = str;
    while (*str != '\0') {
        if ((*str == '\t') || (*str == '#')) {
            *str = '\0';
            break;
        }
        str++;
    }
    if (head == str) {
        return;
    }
    str--;
    while ((head <= str) && (*str == ' ')) {
        *str = '\0';
        str--;
    }
}

/**
 * @brief : replace ~ with home dir path
 * @param [in]path: path to be replaced
 * @param [in]homeDir: home dir path
 * @param [in]len: max length of path
 * @return: SYS_OK/SYS_ERROR
 */
STATIC int32_t LogReplaceDefaultByDir(const char *path, char *homeDir, uint32_t len)
{
    ONE_ACT_WARN_LOG(path == NULL, return SYS_ERROR, "[input] path is null.");
    ONE_ACT_WARN_LOG(homeDir == NULL, return SYS_ERROR, "[input] home directory path is null.");
    ONE_ACT_WARN_LOG((len == 0) || (len > (uint32_t)(TOOL_MAX_PATH + 1)), return SYS_ERROR,
                      "[input] path length is invalid, length=%u, max_length=%d.", len, TOOL_MAX_PATH);
    const char *filePath = path;
    if (filePath[0] != '~') {
        int err = strcpy_s(homeDir, len, filePath);
        if (err != EOK) {
            SELF_LOG_ERROR("strcpy_s path failed, result=%d, strerr=%s.", err, strerror(ToolGetErrorCode()));
            return SYS_ERROR;
        }
        return SYS_OK;
    }

    int32_t ret = LogGetHomeDir(homeDir, len);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("get home directory failed.");
        return SYS_ERROR;
    }
    filePath++;

    if (len < (uint32_t)(strlen(homeDir) + strlen(filePath) + 1U)) {
        SELF_LOG_WARN("path length more than upper limit, upper_limit=%u, homeDir=%s, path=%s.",
                      len, homeDir, filePath);
        return SYS_ERROR;
    }
    ret = strcat_s(homeDir, len, filePath);
    if (ret != EOK) {
        SELF_LOG_ERROR("strcat_s failed, home_directory=%s, path=%s, result=%d, strerr=%s.",
                       homeDir, filePath, ret, strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }

    return SYS_OK;
}

/**
* @brief : open config file and return file pointer
* @param [out] fp: pointer to file pointer
* @param [in] file: config file realpath include filename, it can be NULL! file length should be less than 256(PATH_MAX)
* @return: SUCCEES: succeed; others: failed
*/
LogRt LogConfOpenFile(FILE **fp, const char *file)
{
    char *homeDir = (char *)LogMalloc((size_t)TOOL_MAX_PATH + 1U);
    if (homeDir == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }

    if (file != NULL) {
        if (LogReplaceDefaultByDir(file, homeDir, TOOL_MAX_PATH) != SYS_OK) {
            XFREE(homeDir);
            return CFG_FILE_INVALID;
        }
    }

    // if file is NULL, then use default config file path
    char *ppath = LogConfRealPath(file, homeDir, TOOL_MAX_PATH);
    if (ppath == NULL) {
        SELF_LOG_ERROR("get realpath failed or filepath is invalid, file=%s.", file);
        XFREE(homeDir);
        return CFG_FILE_INVALID;
    }
    XFREE(homeDir);

    *fp = fopen(ppath, "r");
    if (*fp == NULL) {
        SELF_LOG_ERROR("open file failed, file=%s.", ppath);
        XFREE(ppath);
        return OPEN_FILE_FAILED;
    }
    XFREE(ppath);

    int32_t ret = fseek(*fp, 0L, SEEK_SET);
    if (ret < 0) {
        SELF_LOG_ERROR("fseek config file failed, file=%s, result=%d, strerr=%s.",
                       file, ret, strerror(ToolGetErrorCode()));
        LOG_CLOSE_FILE(*fp);
        return OPEN_FILE_FAILED;
    }
    return SUCCESS;
}

/**
* @brief : get config name from lineBuf
* @param [in] lineBuf: config file one line content
* @param [out] confName: config name string
* @param [in] nameLen: config name string length
* @param [out] pos: '=' position
* @return: SUCCEES: succeed; others: failed
*/
STATIC LogRt LogConfParseName(const char *lineBuf, char *confName, uint32_t nameLen, char **pos)
{
    ONE_ACT_WARN_LOG(lineBuf == NULL, return ARGV_NULL, "[input] one line is null from config file.");
    ONE_ACT_WARN_LOG(confName == NULL, return ARGV_NULL, "[output] config name is null.");
    ONE_ACT_WARN_LOG(pos == NULL, return ARGV_NULL, "[output] file position pointer is null.");
    ONE_ACT_WARN_LOG(nameLen > CONF_NAME_MAX_LEN, return ARGV_NULL,
                     "[input] config name length is invalid, length=%u, max_length=%d.",
                     nameLen, CONF_NAME_MAX_LEN);

    *pos = strchr(lineBuf, '=');
    if (*pos == NULL) {
        SELF_LOG_WARN("config item has no symbol(=).");
        return LINE_NO_SYMBLE;
    }

    // ignore configName end blank before '='(eg: zip_swtich  = 1)
    // Do not convert len to unsigned, or SIGSEGV error may occurr because len reverse
    long distance = *pos - lineBuf;
    int32_t len = (int32_t)distance;
    while (((len - 1) >= 0) && ((len - 1) <= CONF_FILE_MAX_LINE) && (lineBuf[len - 1] == ' ')) {
        len = len - 1;
    }
    if ((len <= 0) || ((uint32_t)len > nameLen)) {
        SELF_LOG_WARN("config item has no config name.");
        return CONF_VALUE_NULL;
    }

    int32_t ret = strncpy_s(confName, nameLen, lineBuf, (size_t)len);
    if (ret != EOK) {
        SELF_LOG_ERROR("strncpy_s config name failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return STR_COPY_FAILED;
    }

    return SUCCESS;
}

/**
* @brief : get config name and its value
* @param [in] lineBuf: config file one line content
* @param [out] confName: config name string
* @param [in] nameLen: config name string length
* @param [out] confValue: config vaulue string
* @param [in] valueLen: config vaulue string length
* @return: SUCCEES: succeed; others: failed
*/
LogRt LogConfParseLine(const char *lineBuf, char *confName, uint32_t nameLen,
                       char *confValue, uint32_t valueLen)
{
    char *pos = NULL;
    LogRt res = LogConfParseName(lineBuf, confName, nameLen, &pos);
    if (res != SUCCESS) {
        return CONF_VALUE_NULL;
    }

    ++pos;
    while ((*pos != '\0') && ((*pos == ' ') || (*pos == '\t'))) {
        pos++;
    }
    ONE_ACT_ERR_LOG(strlen(pos) == 0, return CONF_VALUE_NULL, "handle invalid value failed, confName=%s.", confName);

    char buff[CONF_VALUE_MAX_LEN + 1] = { 0 };
    int32_t ret = strcpy_s(buff, CONF_VALUE_MAX_LEN, pos);
    ONE_ACT_ERR_LOG(ret != EOK, return STR_COPY_FAILED,
                    "strcpy_s config value to buffer failed, result=%d, strerr=%s.",
                    ret, strerror(ToolGetErrorCode()));

    // delete end invalid char
    size_t strLen = strlen(buff);
    while (((strLen > 0) && (strLen <= CONF_VALUE_MAX_LEN)) &&
           ((buff[strLen - 1U] == '\r') || (buff[strLen - 1U] == '\n') || (buff[strLen - 1U] == '\t'))) {
        buff[strlen(buff) - 1U] = '\0';
        strLen = strlen(buff);
        ONE_ACT_ERR_LOG(strLen == 0, return CONF_VALUE_NULL, "handle invalid value failed, confName=%s.", confName);
    }

    // ignore comment and value split by space after config value
    LogConfTrimString(buff);
    ONE_ACT_ERR_LOG(strlen(buff) == 0, return CONF_VALUE_NULL, "handle invalid value failed, confName=%s.", confName);

    ret = strcpy_s(confValue, valueLen, buff);
    ONE_ACT_ERR_LOG(ret != EOK, return NO_ENOUTH_SPACE, "copy config value failed, result=%d, strerr=%s.",
                    ret, strerror(ToolGetErrorCode()));

    return SUCCESS;
}

/**
* @brief ParseBlockSymbol: Parses symbols str in [].
* @param [in] buf: config file one line content
* @param [out] symbol: reslut of parses
* @param [in] symbolLen: symbol vaulue string length
* @return: SUCCEES: succeed; others: failed
*/
STATIC LogRt ParseBlockSymbol(const char *buf, char *symbol, size_t symbolLen)
{
    char *bracketFront = strchr(buf, '[');
    char *bracketBack = strchr(buf, ']');
    // find section by looking for '[' ']'
    if ((bracketFront != NULL) && (bracketBack != NULL)) {
        char *sectionHead = bracketFront + 1;
        char *sectionTail = (bracketBack > (bracketFront + 1)) ? (bracketBack - 1) : bracketBack;
        // remove blanks
        while (sectionHead <= sectionTail) {
            if (*sectionHead == ' ') {
                sectionHead++;
            } else if (*sectionTail == ' ') {
                sectionTail--;
            } else {
                break;
            }
        }
        if (sectionHead > sectionTail) {
            SELF_LOG_ERROR("null symbol, please check block symbol, errno=%d.", (int32_t)GET_CFG_VALUE_ERR);
            return GET_CFG_VALUE_ERR;
        }
        sectionTail = (sectionTail < bracketBack) ? (sectionTail + 1) : sectionTail;
        *sectionTail = '\0';
        if ((sectionTail - sectionHead) >= (SYMBOL_NAME_MAX_LEN - 1)) {
            SELF_LOG_ERROR("The symbol is longer than %d, please check.", SYMBOL_NAME_MAX_LEN);
            return GET_CFG_VALUE_ERR;
        }
        errno_t ret = strcpy_s(symbol, symbolLen, sectionHead);
        ONE_ACT_ERR_LOG(ret != EOK, return STR_COPY_FAILED, "copy block symbol failed, ret=%d.", (int32_t)ret);
    }
    // current row is not a block name, will return success
    return SUCCESS;
}

LogRt GetSymbol(const char *buf, char *symbol, size_t symbolLen)
{
    char tempBuf[CONF_FILE_MAX_LINE + 1] = { 0 };

    // get symbol name
    errno_t err = strcpy_s(tempBuf, CONF_FILE_MAX_LINE, buf);
    if (err != EOK) {
        SELF_LOG_ERROR("strcpy_s failed, err=%d.", err);
        return STR_COPY_FAILED;
    }
    LogRt ret = ParseBlockSymbol(tempBuf, symbol, symbolLen);
    ONE_ACT_NO_LOG(ret != SUCCESS, return ret);

    return SUCCESS;
}

uint32_t LogConfGetDigit(const char *confName, const char *confValue,
    uint32_t minValue, uint32_t maxValue, uint32_t defaultValue)
{
    uint32_t value = 0;
    if (LogStrToUint(confValue, &value) != LOG_SUCCESS) {
        SELF_LOG_WARN("can not convert to uint32_t, config value:%s, config name:%s, use default value:%u",
                      confValue, confName, defaultValue);
        return defaultValue;
    }
    if (value < minValue) {
        SELF_LOG_WARN("get %s=%u less than lower limit, use lower_limit=%u.", confName, value, minValue);
        return minValue;
    } else if (value > maxValue) {
        SELF_LOG_WARN("get %s=%u more than upper limit, use upper_limit=%u.", confName, value, maxValue);
        return maxValue;
    } else {
        SELF_LOG_INFO("get config %s=%u", confName, value);
        return value;
    }
}