/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_config_list.h"
#include "log_common.h"
#include "log_print.h"
#include "log_config_block.h"
#include "log_file_util.h"

STATIC ConfList *g_confList = NULL;
STATIC ToolMutex g_confMutex = TOOL_MUTEX_INITIALIZER;

STATIC void LogConfListPrint(void)
{
    SELF_LOG_INFO("============= config list=========");
    ConfList *confListTmp = g_confList;
    while (confListTmp != NULL) {
        SELF_LOG_INFO("%s = %s", confListTmp->confName, confListTmp->confValue);
        confListTmp = confListTmp->next;
    }
    SELF_LOG_INFO("====================================");
}

/**
* @brief : insert config item to global list
* @param [in] confName: config name string
* @param [in] nameLen: config item string length
* @param [in] confValue: config value string
* @param [in] valueLen: config value string length
* @return: SUCCEES: succeed; others: failed
*/
STATIC LogRt LogConfListInsert(const char *confName, uint32_t nameLen, const char *confValue, uint32_t valueLen)
{
    ONE_ACT_WARN_LOG(confName == NULL, return ARGV_NULL, "[input] config name is null.");
    ONE_ACT_WARN_LOG(confValue == NULL, return ARGV_NULL, "[input] config value is null.");
    ONE_ACT_WARN_LOG(nameLen > CONF_NAME_MAX_LEN, return ARGV_NULL,
                     "[input] config name length is invalid, length=%u, max_length=%d.",
                     nameLen, CONF_NAME_MAX_LEN);
    ONE_ACT_WARN_LOG(valueLen > CONF_VALUE_MAX_LEN, return ARGV_NULL,
                     "[input] config value length is invalid, length=%u, max_length=%d.",
                     valueLen, CONF_VALUE_MAX_LEN);

    ConfList *confListTemp = g_confList;
    ConfList *confListNode = (ConfList *)LogMalloc(sizeof(ConfList));
    if (confListNode == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }

    int32_t ret1 = strcpy_s(confListNode->confName, CONF_NAME_MAX_LEN, confName);
    int32_t ret2 = strcpy_s(confListNode->confValue, CONF_VALUE_MAX_LEN, confValue);
    if ((ret1 != EOK) || (ret2 != EOK)) {
        SELF_LOG_ERROR("strcpy_s failed, errno_1=%d, errno_2=%d.", ret1, ret2);
        XFREE(confListNode);
        return STR_COPY_FAILED;
    }
    confListNode->next = confListTemp;
    g_confList = confListNode;
    return SUCCESS;
}


static void LogConfParseCommon(FILE *fp)
{
    // parse common config item
    char confName[CONF_NAME_MAX_LEN + 1] = { 0 };
    char confValue[CONF_VALUE_MAX_LEN + 1] = { 0 };
    char buf[CONF_FILE_MAX_LINE + 1] = { 0 };
    char tmpBuf[CONF_FILE_MAX_LINE + 1] = { 0 };
    int64_t pos = LogFileTell(fp);
    while (LogFileGets(buf, CONF_FILE_MAX_LINE, fp) == LOG_SUCCESS) {
        uint32_t start = 0;
        if (IsBlankline(*buf)) {
            continue;
        }
        if (IsBlockSymbol(buf)) {
            break;
        }
        while (IsBlank(buf[start])) {
            start++;
        }

        int32_t ret = strcpy_s(tmpBuf, sizeof(tmpBuf) - 1U, (buf + start));
        ONE_ACT_ERR_LOG(ret != EOK, continue, "strcpy_s config item failed, result=%d, strerr=%s.",
                        ret, strerror(ToolGetErrorCode()));

        LogRt res = LogConfParseLine(tmpBuf, confName, CONF_NAME_MAX_LEN, confValue, CONF_VALUE_MAX_LEN);
        ONE_ACT_WARN_LOG(res != SUCCESS, continue, "parse one line config item failed, result=%d, strerr=%s.",
                         (int32_t)res, strerror(ToolGetErrorCode()));

        res = LogConfListInsert(confName, CONF_NAME_MAX_LEN, confValue, CONF_VALUE_MAX_LEN);
        ONE_ACT_ERR_LOG(res != SUCCESS, continue, "init config list failed, result=%d, strerr=%s.",
                        (int32_t)res, strerror(ToolGetErrorCode()));
        pos = LogFileTell(fp);
    }
    // if not goto file end, reset for next parse
    if (feof(fp) == 0) {
        (void)fseek(fp, pos, SEEK_SET);
    }
}

/**
* @brief LogConfListInit: config item list init from config file
* @param [in] file: config file realpath include filename, it can be NULL
* @return: SUCCEES: succeed; others: failed
*/
LogRt LogConfListInit(const char *file)
{
    FILE *fp = NULL;
    // if file is NULL, then use default config file path
    LogRt res = LogConfOpenFile(&fp, file);
    if (res != SUCCESS) {
        SELF_LOG_ERROR("open config file failed, file=%s, result=%d, strerr=%s.",
                       file, (int32_t)res, strerror(ToolGetErrorCode()));
        fp = NULL;
        return OPEN_FILE_FAILED;
    }

    LogConfParseCommon(fp);

    LogConfParseBlock(fp);

    LOG_CLOSE_FILE(fp);
    LogConfListPrint();
    return SUCCESS;
}

/**
* @brief : config item list update from config file
* @param [in] file: config file realpath include filename, it can be NULL
* @return: SUCCEES: succeed; others: failed
*/
LogRt LogConfListUpdate(const char *file)
{
    LOCK_WARN_LOG(&g_confMutex);
    ConfList *confListTmp = g_confList;
    ConfList *confListNode = NULL;

    while (confListTmp != NULL) {
        confListNode = confListTmp;
        confListTmp = confListTmp->next;
        XFREE(confListNode);
    }
    g_confList = NULL;
    LogRt result = LogConfListInit(file);
    UNLOCK_WARN_LOG(&g_confMutex);
    return result;
}

void LogConfListFree(void)
{
    LOCK_WARN_LOG(&g_confMutex);
    ConfList *confListTmp = g_confList;
    ConfList *confListNode = NULL;

    while (confListTmp != NULL) {
        confListNode = confListTmp;
        confListTmp = confListTmp->next;
        XFREE(confListNode);
    }
    g_confList = NULL;
    UNLOCK_WARN_LOG(&g_confMutex);
    (void)ToolMutexDestroy(&g_confMutex);
    return;
}

/**
* @brief : get config value
* @param [in] confName: config name string
* @param [in] nameLen: config item string length
* @param [out] confValue: config value string
* @param [in] valueLen: config value string length
* @return: SUCCEES: succeed; others: failed
*/
LogRt LogConfListGetValue(const char *confName, uint32_t nameLen, char *confValue, uint32_t valueLen)
{
    ONE_ACT_WARN_LOG(confName == NULL, return ARGV_NULL, "[input] config name is null.");
    ONE_ACT_WARN_LOG(confValue == NULL, return ARGV_NULL, "[output] config value is null.");
    ONE_ACT_WARN_LOG(nameLen > CONF_NAME_MAX_LEN, return ARGV_NULL,
                     "[input] config name length is invalid, length=%u, max_length=%d.",
                     nameLen, CONF_NAME_MAX_LEN);
    ONE_ACT_WARN_LOG(valueLen > CONF_VALUE_MAX_LEN, return ARGV_NULL,
                     "[input] config value length is invalid, length=%u, max_length=%d.",
                     valueLen, CONF_VALUE_MAX_LEN);

    LOCK_WARN_LOG(&g_confMutex);
    const ConfList *confListTmp = g_confList;
    while (confListTmp != NULL) {
        if (strcmp(confName, confListTmp->confName) == 0) {
            int ret = strcpy_s(confValue, valueLen, confListTmp->confValue);
            if (ret != EOK) {
                SELF_LOG_ERROR("strcpy_s config value failed, result=%d, strerr=%s.",
                               ret, strerror(ToolGetErrorCode()));
                UNLOCK_WARN_LOG(&g_confMutex);
                return STR_COPY_FAILED;
            }
            UNLOCK_WARN_LOG(&g_confMutex);
            return SUCCESS;
        }
        confListTmp = confListTmp->next;
    }
    UNLOCK_WARN_LOG(&g_confMutex);
    return CONF_VALUE_NULL;
}

/**
 * @brief       : get config item digital value from slog.conf
 * @param [in]  : confName          string of config name
 * @param [in]  : minValue          lower_limit value
 * @param [in]  : maxValue          upper_limit value
 * @param [in]  : defaultValue      default value
 * @return      : config value
 */
uint32_t LogConfListGetDigit(const char *confName, uint32_t minValue, uint32_t maxValue, uint32_t defaultValue)
{
    char confValue[CONF_VALUE_MAX_LEN + 1] = { 0 };
    LogRt ret = LogConfListGetValue(confName, (uint32_t)strlen(confName), confValue, CONF_VALUE_MAX_LEN);
    if (ret != SUCCESS) {
        SELF_LOG_WARN("can not get config, config name:%s, use default value:%u", confName, defaultValue);
        return defaultValue;
    }
    return LogConfGetDigit(confName, confValue, minValue, maxValue, defaultValue);
}

/**
 * @brief       : traverse list, apply specified function on every node.
 * @param [in]  : func          function to be applied
 * @param [out] : arg           extra argument for function
 * @return      : SYS_OK   succeed; others   failed;
 */
int32_t LogConfListTraverse(const LogListFindFunc func, ArgPtr arg, bool isNewStyle)
{
    if (func == NULL) {
        return SYS_ERROR;
    }
    LOCK_WARN_LOG(&g_confMutex);
    const ConfList *confListTmp = g_confList;
    while (confListTmp != NULL) {
        int32_t ret = func(confListTmp, arg, isNewStyle);
        if (ret != SYS_OK) {
            UNLOCK_WARN_LOG(&g_confMutex);
            return ret;
        }
        confListTmp = confListTmp->next;
    }
    UNLOCK_WARN_LOG(&g_confMutex);
    return SYS_OK;
}

