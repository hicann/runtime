/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_config_group.h"
#include "securec.h"
#include "log_common.h"
#include "log_print.h"
#include "log_level_parse.h"
#include "log_file_util.h"

#ifdef GROUP_LOG

// group config
#define SLOG_SYMBOL_GENERAL_STR "GENERAL"
#define SLOG_SYMBOL_GROUP_STR "GROUP"
#define SLOG_MAX_SIZE_CFG_STR "MaxSize"
#define SLOG_BUF_SIZE_CFG_STR "LogBufSize"
#define SLOG_FILE_DIR_CFG_STR "LogAgentFileDir"
#define SLOG_GROUP_NAME_CFG_STR "GroupName"
#define SLOG_MODULE_NAME_CFG_STR "Module"
#define SLOG_RATIO_CFG_STR "Ratio"
#define SLOG_FILE_SIZE_CFG_STR "FileSize"
#define SLOG_DEFAULT_GROUP_SYMBOL "IsDefaultGroup"

#define MIN_GROUP_FILE_NUM  2   // at least one for .log, one for .log.gz
#define MAX_GROUP_FILE_NUM  500
#define MIN_GROUP_FILE_SIZE (1 * 1024)
#define MAX_GROUP_FILE_SIZE (20 * 1024)

STATIC bool g_groupLogEnabled = false;
STATIC GeneralGroupInfo g_groupInfo = { 0 };
STATIC BlockSymbolInfo g_symbolInfo[] = {
    { (int32_t)SLOGD,      { "SLOGD", "ALOG", NULL, NULL }, 2 },
    { (int32_t)ALOG,       { "ALOG", NULL, NULL, NULL }, 1 },
    { (int32_t)PLOG,       { "PLOG", NULL, NULL, NULL }, 1 },
    { (int32_t)LOGDAEMON,  { "LOG_DAEMON", NULL, NULL, NULL }, 1 },
};

STATIC int32_t GetConfVal(char *valStr, uint32_t len)
{
    ONE_ACT_NO_LOG(((valStr == NULL) || (*valStr == '\0')), return 0);
    char *val = valStr;
    for (uint32_t i = 0; i < len; i++) {
        if ((val[i] > '9') || (val[i] < '0')) {
            val[i] = '\0';
            break;
        }
    }
    if (*val == '\0') {
        SELF_LOG_ERROR("convert str %s to num fail, will return 0 as default.", valStr);
        return 0;
    }
    int64_t ret = -1;
    if ((LogStrToInt(val, &ret) != LOG_SUCCESS) || (ret > (int64_t)INT_MAX)) {
        SELF_LOG_ERROR("convert str %s to int fail, will return 0 as default.", valStr);
        return 0;
    }
    return (int32_t)ret;
}

STATIC int GetDefaultGroupSymbol(char *valStr, int len)
{
    int ret;
    char *valTemp = valStr;
    (void)len;
    char upDiff = 'a' - 'A';
    ONE_ACT_NO_LOG(valStr == NULL, return 0);
    while (*valTemp != '\0') {
        ONE_ACT_NO_LOG(((*valTemp >= 'a') && (*valTemp <= 'z')), (*valTemp -= upDiff));
        valTemp++;
    }
    if ((strcmp(valStr, "TRUE") == 0) || (strcmp(valStr, "YES") == 0) || (strcmp(valStr, "1") == 0)) {
        ret = 1;
    } else if ((strcmp(valStr, "FALSE") == 0) || (strcmp(valStr, "NO") == 0) || \
               (strcmp(valStr, "0") == 0)) {
        ret = 0;
    } else {
        SELF_LOG_ERROR("can't identify str %s as default group symbol.", valStr);
        ret = 0;
    }

    return ret;
}

/**
* @brief IsTargetSymbol: check curr symbol whether meet request.
* @param [in] buf: config file one line content
* @param [in] groupTypeStr: target symbol string
* @param [out] res: reslut of checking
* @return: SUCCEES: succeed; others: failed
*/
STATIC bool IsTargetSymbol(const char *symbol, const char *groupTypeStr)
{
    if (strcmp(symbol, groupTypeStr) == 0) {
        return true;
    }
    return false;
}

STATIC LogRt IsParseTarget(const char *buf, bool *res)
{
    char symbol[SYMBOL_NAME_MAX_LEN + 1] = { 0 };

    LogRt ret = GetSymbol(buf, symbol, SYMBOL_NAME_MAX_LEN);
    ONE_ACT_ERR_LOG(ret != SUCCESS, return ret, "fail to get symbol in this line %s", buf);

    uint32_t symbolNum = LOG_SIZEOF(g_symbolInfo) / LOG_SIZEOF(BlockSymbolInfo);
    for (uint32_t num = 0; num < symbolNum; num++) {
        for (int32_t symbolIdx = 0; symbolIdx < g_symbolInfo[num].tNum; symbolIdx++) {
            if (strcmp(symbol, g_symbolInfo[num].target[symbolIdx]) == 0) {
                SELF_LOG_INFO("slog module %s is find.", g_symbolInfo[num].target[symbolIdx]);
                *res = true;
                return SUCCESS;
            }
        }
    }

    *res = false;
    return SUCCESS;
}

STATIC bool IsMatchAnySymbol(const char *symbol)
{
    uint32_t symbolNum = LOG_SIZEOF(g_symbolInfo) / LOG_SIZEOF(BlockSymbolInfo);
    for (uint32_t symbolIdx = 0; symbolIdx < symbolNum; symbolIdx++) {
        if (strcmp(symbol, g_symbolInfo[symbolIdx].target[0]) == 0) {
            return TRUE;
        }
    }

    return FALSE;
}

STATIC int32_t GetTabCount(const char *buf)
{
    int32_t ret = 0;
    int32_t idx = 0;

    ONE_ACT_ERR_LOG(buf == NULL, return 0, "buf is null!");
    while (buf[idx] != '\0') {
        if (buf[idx] == '\t') {
            ret++;
        }
        idx++;
    }

    return ret;
}

/**
* @brief MoveToTargetSymbol: move fp to target position
* @param [in] fp: file handle for slog.conf
* @param [in] groupTypeStr: target slog module string
* @return: SUCCEES: succeed; others: failed
*/
STATIC LogRt MoveToTargetSymbol(FILE *fp, const char *groupTypeStr)
{
    char buf[CONF_FILE_MAX_LINE + 1] = { 0 };

    while (fgets(buf, CONF_FILE_MAX_LINE, fp) != NULL) {
        char symbol[SYMBOL_NAME_MAX_LEN + 1] = { 0 };
        ONE_ACT_NO_LOG(IsBlankline(*buf), continue);
        ONE_ACT_NO_LOG(!IsBlockSymbol(buf), continue);
        // get symbol name
        LogRt ret = GetSymbol(buf, symbol, SYMBOL_NAME_MAX_LEN);
        ONE_ACT_ERR_LOG(ret != SUCCESS, return ret, "fail to get symbol in this line %s", buf);
        bool res = IsTargetSymbol(symbol, groupTypeStr);
        ONE_ACT_INFO_LOG(res == TRUE, return SUCCESS, "get target symbol %s.", groupTypeStr);
    }
    SELF_LOG_INFO("not find target symbol %s, errno=%d.", groupTypeStr, (int)NO_MATCH_TARGET_SYMBOL);
    return NO_MATCH_TARGET_SYMBOL;
}

STATIC void OptimizeGroupCfg(int32_t groupId)
{
    int32_t minSize = MIN_GROUP_FILE_SIZE;
    int32_t maxSize = (g_groupInfo.map[groupId].fileRatio * g_groupInfo.maxSize) / FULL_RATIO;
    // is size inited or not
    if (g_groupInfo.map[groupId].fileSize < minSize) {
        SELF_LOG_WARN("group %s fileSize(%dKB) is illegal, scope is [%d, %d)", \
                      g_groupInfo.map[groupId].name, g_groupInfo.map[groupId].fileSize, \
                      minSize, maxSize);
        g_groupInfo.map[groupId].fileSize = minSize;
        SELF_LOG_WARN("critical value will be configed: fileSize %d KB.", \
                      g_groupInfo.map[groupId].fileSize);
    } else if (g_groupInfo.map[groupId].fileSize >= maxSize) {
        SELF_LOG_WARN("group %s fileSize(%dKB) is illegal, scope is [%d, %d)", \
                      g_groupInfo.map[groupId].name, g_groupInfo.map[groupId].fileSize, \
                      minSize, maxSize);
        // if config fileSize > group maxSize, set fileSize minSize because of no fileNum for reference now
        g_groupInfo.map[groupId].fileSize = minSize;
        SELF_LOG_WARN("critical value will be configed: fileSize %d KB.", \
                      g_groupInfo.map[groupId].fileSize);
    }
    int32_t size = maxSize - g_groupInfo.map[groupId].fileSize;
    g_groupInfo.map[groupId].totalMaxFileSize = (size < 0) ? 0U : (uint32_t)size;
}

STATIC LogRt InitGernelCfgItem(const char *confName, unsigned int nameLen, char *confValue, unsigned int valueLen)
{
    ONE_ACT_WARN_LOG(confName == NULL, return ARGV_NULL, "[input] config name is null.");
    ONE_ACT_WARN_LOG(confValue == NULL, return ARGV_NULL, "[input] config value is null.");
    ONE_ACT_WARN_LOG(nameLen > CONF_NAME_MAX_LEN, return ARGV_NULL,
                     "[input] config name length is invalid, length=%u, max_length=%d.",
                     nameLen, CONF_NAME_MAX_LEN);
    ONE_ACT_WARN_LOG(valueLen > CONF_VALUE_MAX_LEN, return ARGV_NULL,
                     "[input] config value length is invalid, length=%u, max_length=%d.",
                     valueLen, CONF_VALUE_MAX_LEN);

    if (strcmp(confName, SLOG_MAX_SIZE_CFG_STR) == 0) {
        const int convertValueToSize = 1024;
        g_groupInfo.maxSize = GetConfVal(confValue, valueLen) * convertValueToSize;
    } else if (strcmp(confName, SLOG_BUF_SIZE_CFG_STR) == 0) {
        g_groupInfo.bufSize = GetConfVal(confValue, valueLen);
    } else if (strcmp(confName, SLOG_FILE_DIR_CFG_STR) == 0) {
        int ret = strcpy_s(g_groupInfo.agentFileDir, SLOG_AGENT_FILE_DIR + 1, confValue);
        ONE_ACT_ERR_LOG(ret != EOK, return STR_COPY_FAILED, "strcpy_s failed, errno=%d, strerr=%s.", \
                        ret, strerror(ToolGetErrorCode()));
    } else {
        SELF_LOG_ERROR("unrecognizable config name %s, errno=%d.", confName, (int32_t)KEYVALUE_NOT_FIND);
        return KEYVALUE_NOT_FIND;
    }

    return SUCCESS;
}

/**
* @brief CheckGernelConfig: check gernel config.
*/
STATIC LogRt CheckGernelConfig(void)
{
    // maxSize、bufSize、logdir must be init
    if ((g_groupInfo.maxSize <= 0) || (g_groupInfo.maxSize > DEFAULT_LOG_SIZE)) {
        SELF_LOG_ERROR("illegal config MaxSize %d, will be set to default value %d.", \
                       g_groupInfo.maxSize, DEFAULT_LOG_SIZE);
        g_groupInfo.maxSize = DEFAULT_LOG_SIZE;
    }
    if ((g_groupInfo.bufSize <= 0) || (g_groupInfo.bufSize > DEFAULT_BUF_SIZE)) {
        SELF_LOG_ERROR("illegal config LogBufSize %d,  will be set to default value %d.", \
                       g_groupInfo.bufSize, DEFAULT_BUF_SIZE);
        g_groupInfo.bufSize = DEFAULT_BUF_SIZE;
    }
    size_t dirLen = strnlen(g_groupInfo.agentFileDir, SLOG_AGENT_FILE_DIR + 1);
    if (dirLen == 0) {
        SELF_LOG_ERROR("agentFileDir isn't config, default %s will be used.", DEFAULT_FILE_DIR);
        int ret = strcpy_s(g_groupInfo.agentFileDir, SLOG_AGENT_FILE_DIR + 1, DEFAULT_FILE_DIR);
        if (ret != EOK) {
            SELF_LOG_ERROR("strcpy_s config value to buffer failed, result=%d, strerr=%s.", \
                           ret, strerror(ToolGetErrorCode()));
        }
        dirLen = strnlen(g_groupInfo.agentFileDir, SLOG_AGENT_FILE_DIR + 1);
    }
    char finalSymbol = g_groupInfo.agentFileDir[dirLen - 1U];
    if (finalSymbol != '/') {
        if (dirLen == SLOG_AGENT_FILE_DIR) {
            g_groupInfo.agentFileDir[dirLen - 1U] = '/';
        } else {
            g_groupInfo.agentFileDir[dirLen] = '/';
        }
    }

    SELF_LOG_INFO("parse gernel config done.");
    return SUCCESS;
}

/**
* @brief ParseGernelGroupMsg: read gernel info for grouping
* @param [in] fp: file handle for slog.conf
* @param [in] buf: buffer for save info in the previous line
* @return: SUCCEES: succeed; others: failed
*/
STATIC LogRt ParseGernelGroupMsg(FILE *fp, char **buf)
{
    char confName[CONF_NAME_MAX_LEN + 1] = { 0 };
    char confValue[CONF_VALUE_MAX_LEN + 1] = { 0 };
    char tmpBuf[CONF_FILE_MAX_LINE + 1] = { 0 };

    LogRt res = MoveToTargetSymbol(fp, SLOG_SYMBOL_GENERAL_STR);
    ONE_ACT_NO_LOG(res != SUCCESS, return res);

    while (fgets(*buf, CONF_FILE_MAX_LINE, fp) != NULL) {
        unsigned int start = 0;
        ONE_ACT_NO_LOG(IsBlankline(**buf), continue);
        ONE_ACT_NO_LOG(IsBlockSymbol(*buf), break);
        ONE_ACT_NO_LOG(!IsEquation(*buf), continue);
        while (IsBlank((*buf)[start])) {
            start++;
        }
        int32_t ret = strcpy_s(tmpBuf, sizeof(tmpBuf) - 1U, (*buf + start));
        ONE_ACT_ERR_LOG(ret != EOK, continue, "strcpy_s config item failed, errno=%d, strerr=%s.",
                        (int32_t)STR_COPY_FAILED, strerror(ToolGetErrorCode()));
        res = LogConfParseLine(tmpBuf, confName, CONF_NAME_MAX_LEN, confValue, CONF_VALUE_MAX_LEN);
        ONE_ACT_ERR_LOG(res != SUCCESS, continue, "parse line config item failed, line:%s", *buf);
        res = InitGernelCfgItem(confName, CONF_NAME_MAX_LEN, confValue, CONF_VALUE_MAX_LEN);
        ONE_ACT_ERR_LOG(res != SUCCESS, continue, "init config list failed, line:%s", *buf);
    }

    if (CheckGernelConfig() != SUCCESS) {
        SELF_LOG_ERROR("fail to check gernel config.");
    }

    return SUCCESS;
}

STATIC LogRt ParseConfigModule(char *modStr, int groupId)
{
    char delim[2] = ",";
    char *nameStr = NULL;
    char *nextToken = NULL;
    size_t len = strnlen(modStr, GROUP_NAME_MAX_LEN + 1);
    ONE_ACT_ERR_LOG(len == 0, return NO_MATCH_MODULE_NAME, "get none module.");

    nameStr = strtok_s(modStr, delim, &nextToken);
    while (nameStr != NULL) {
        const ModuleInfo *modInfo = NULL;

        modInfo = GetModuleInfoByName(nameStr);
        TWO_ACT_ERR_LOG(modInfo == NULL, nameStr = strtok_s(NULL, delim, &nextToken), \
                        continue, "group %s, module name for %s is invaild.", \
                        g_groupInfo.map[groupId].name, nameStr);
        if ((modInfo->groupId != INVAILD_GROUP_ID) && \
            (modInfo->groupId != g_groupInfo.defGroupId)) {
            SELF_LOG_ERROR("group %s, repeat grouping module %s, please check.", \
                           g_groupInfo.map[groupId].name, nameStr);
            nameStr = strtok_s(NULL, delim, &nextToken);
            continue;
        }
        bool ret = SetGroupIdByModuleId(modInfo->moduleId, groupId);
        if (ret != true) {
            SELF_LOG_ERROR("set module %s group id fail.", nameStr);
        }

        g_groupInfo.map[groupId].moduleNum++;
        nameStr = strtok_s(NULL, delim, &nextToken);
    }
    ONE_ACT_ERR_LOG(g_groupInfo.map[groupId].moduleNum == 0, return NO_MATCH_MODULE_NAME, \
                    "get none module.");

    return SUCCESS;
}

STATIC LogRt InitGroupItem(const char *confName, unsigned int nameLen, char *confValue, \
                           unsigned int valueLen, int groupId)
{
    ONE_ACT_WARN_LOG(confName == NULL, return ARGV_NULL, "[input] config name is null.");
    ONE_ACT_WARN_LOG(confValue == NULL, return ARGV_NULL, "[input] config value is null.");
    ONE_ACT_WARN_LOG(nameLen > CONF_NAME_MAX_LEN, return ARGV_NULL,
                     "[input] config name length is invalid, length=%u, max_length=%d.",
                     nameLen, CONF_NAME_MAX_LEN);
    ONE_ACT_WARN_LOG(valueLen > CONF_VALUE_MAX_LEN, return ARGV_NULL,
                     "[input] config value length is invalid, length=%u, max_length=%d.",
                     valueLen, CONF_VALUE_MAX_LEN);

    if (strcmp(confName, SLOG_GROUP_NAME_CFG_STR) == 0) {
        int32_t ret = strcpy_s(g_groupInfo.map[groupId].name, GROUP_NAME_MAX_LEN, confValue);
        ONE_ACT_ERR_LOG(ret != EOK, return STR_COPY_FAILED, "strcpy_s failed, errno=%d.", ret);
    } else if (strcmp(confName, SLOG_MODULE_NAME_CFG_STR) == 0) {
        int32_t ret = strcpy_s(g_groupInfo.map[groupId].moduleStr, CONF_VALUE_MAX_LEN, confValue);
        ONE_ACT_ERR_LOG(ret != EOK, return STR_COPY_FAILED, "strcpy_s failed, errno=%d.", ret);
    } else if (strcmp(confName, SLOG_RATIO_CFG_STR) == 0) {
        g_groupInfo.map[groupId].fileRatio = GetConfVal(confValue, valueLen);
    } else if (strcmp(confName, SLOG_FILE_SIZE_CFG_STR) == 0) {
        const int32_t convertValueToSize = 1024;
        g_groupInfo.map[groupId].fileSize = GetConfVal(confValue, valueLen) * convertValueToSize;
    }  else if (strcmp(confName, SLOG_DEFAULT_GROUP_SYMBOL) == 0) {
        g_groupInfo.map[groupId].isDefGroup = GetDefaultGroupSymbol(confValue, CONF_VALUE_MAX_LEN + 1);
    } else {
        SELF_LOG_ERROR("unrecognizable config name %s, errno=%d.", confName, (int32_t)KEYVALUE_NOT_FIND);
        return KEYVALUE_NOT_FIND;
    }

    return SUCCESS;
}

// alloc a group id
STATIC int AllocGroupId(void)
{
    for (int32_t groupId = 0; groupId < GROUP_MAP_SIZE; groupId++) {
        if (g_groupInfo.map[groupId].isInit == 0) {
            g_groupInfo.map[groupId].totalMaxFileSize = 0U;
            g_groupInfo.map[groupId].fileRatio = 0;
            g_groupInfo.map[groupId].fileSize = 0;
            g_groupInfo.map[groupId].id = 0;
            g_groupInfo.map[groupId].moduleNum = 0;
            g_groupInfo.map[groupId].isDefGroup = 0;
            g_groupInfo.map[groupId].name[0] = '\0';
            g_groupInfo.map[groupId].moduleStr[0] = '\0';
            return groupId;
        }
    }
    return -1;
}

STATIC LogRt CheckRepeatName(int groupId)
{
    // check group name is repeat
    for (int32_t idx = 0; idx < GROUP_MAP_SIZE; idx++) {
        if (g_groupInfo.map[idx].isInit == 0) {
            continue;
        }
        if (strcmp(g_groupInfo.map[idx].name, g_groupInfo.map[groupId].name) == 0) {
            SELF_LOG_ERROR("group name %s is repeat, this group will be abandon, errno=%d.", \
                           g_groupInfo.map[groupId].name, (int32_t)REPEAT_GROUP_NAME);
            return REPEAT_GROUP_NAME;
        }
    }
    return SUCCESS;
}

STATIC LogRt CheckGroupRatio(int groupId)
{
    ONE_ACT_ERR_LOG((g_groupInfo.map[groupId].fileRatio > FULL_RATIO) || \
                    (g_groupInfo.map[groupId].fileRatio <= 0), return ILLEGAL_GROUP_PARA,
                    "illegal group fileRatio = %d or uninitialized, group will be abandon, errno=%d.", \
                    g_groupInfo.map[groupId].fileRatio, (int32_t)ILLEGAL_GROUP_PARA);
    ONE_ACT_ERR_LOG((g_groupInfo.allRatio + g_groupInfo.map[groupId].fileRatio) > FULL_RATIO, \
                    return GROUP_RATIO_OVER_MAX, \
                    "curr ratio is %d, no enough space for ratio %d, parse fail, errno=%d.", \
                    g_groupInfo.allRatio, g_groupInfo.map[groupId].fileRatio, (int32_t)GROUP_RATIO_OVER_MAX);

    return SUCCESS;
}

STATIC LogRt CheckGroupModules(int groupId)
{
    if ((strnlen(g_groupInfo.map[groupId].moduleStr, GROUP_NAME_MAX_LEN + 1) == 0) || \
        (ParseConfigModule(g_groupInfo.map[groupId].moduleStr, groupId) != SUCCESS)) {
        SELF_LOG_ERROR("group %s doesn't config moduleId, this group will be abandon, errno=%d.", \
                       g_groupInfo.map[groupId].name, (int32_t)MISSING_KEY_INFO);
        return MISSING_KEY_INFO;
    }

    return SUCCESS;
}

STATIC LogRt CheckUnitGroupCfg(int groupId)
{
    if ((g_groupInfo.map[groupId].isDefGroup == 1) && \
        (g_groupInfo.defGroupId != INVAILD_GROUP_ID)) {
            SELF_LOG_ERROR("default group has been inited, group will be abandon, errno=%d.", \
                           (int32_t)REPEAT_GROUP_NAME);
            return REPEAT_GROUP_NAME;
    }
    // is illegal for don't init fileSize and fileRatio
    LogRt ret = CheckGroupRatio(groupId);
    ONE_ACT_NO_LOG(ret != SUCCESS, return ret);
    // check group name is init or not
    size_t len = strnlen(g_groupInfo.map[groupId].name, GROUP_NAME_MAX_LEN + 1);
    if (len == 0) {
        if (g_groupInfo.map[groupId].isDefGroup == 1) {
            errno_t err = strcpy_s(g_groupInfo.map[groupId].name, \
                                   GROUP_NAME_MAX_LEN, SLOG_DEFAULT_GROUP_NAME);
            NO_ACT_ERR_LOG(err != EOK, "strcpy_s default group name failed.");
        } else {
            SELF_LOG_ERROR("group name isn't config, will be abandon, errno=%d.", \
                           (int32_t)MISSING_KEY_INFO);
            return MISSING_KEY_INFO;
        }
    }
    ret = CheckRepeatName(groupId);
    ONE_ACT_NO_LOG(ret != SUCCESS, return ret);
    // check finish for default group
    if (g_groupInfo.map[groupId].isDefGroup == 1) {
        return SUCCESS;
    }
    // is any module alloced for this group
    ret = CheckGroupModules(groupId);
    ONE_ACT_NO_LOG(ret != SUCCESS, return ret);

    return SUCCESS;
}

/**
* @brief ParseUnitGroupCfg: parse all group msg under one slog module
* @param [in] fp: handle for slog.conf
* @param [in] groupId: group id for this unit
* @param [in] lineBuf: line buffer for previous line of msg
* @return: SUCCEES: succeed; others: failed
*/
STATIC LogRt ParseUnitGroupCfg(FILE *fp, int groupId, char **lineBuf)
{
    LogRt res;
    char *buf = *lineBuf;
    char confName[CONF_NAME_MAX_LEN + 1] = { 0 };
    char confValue[CONF_VALUE_MAX_LEN + 1] = { 0 };
    char tmpBuf[CONF_FILE_MAX_LINE + 1] = { 0 };

    while (fgets(buf, CONF_FILE_MAX_LINE, fp) != NULL) {
        uint32_t start = 0;

        ONE_ACT_NO_LOG(IsBlankline(*buf), continue);
        ONE_ACT_NO_LOG(IsBlockSymbol(buf), break);
        while (IsBlank(buf[start])) {
            start++;
        }

        int32_t ret = strcpy_s(tmpBuf, sizeof(tmpBuf) - 1U, (buf + start));
        ONE_ACT_ERR_LOG(ret != EOK, continue, "strcpy_s config item failed, result=%d, errno=%d.",
                        ret, (int32_t)STR_COPY_FAILED);
        res = LogConfParseLine(tmpBuf, confName, CONF_NAME_MAX_LEN, confValue, CONF_VALUE_MAX_LEN);
        ONE_ACT_ERR_LOG(res != SUCCESS, continue, "parse one line config item failed.");
        res = InitGroupItem(confName, CONF_NAME_MAX_LEN, confValue, CONF_VALUE_MAX_LEN, groupId);
        ONE_ACT_ERR_LOG(res != SUCCESS, continue, "init config list failed.");
    }
    res = CheckUnitGroupCfg(groupId);
    ONE_ACT_NO_LOG(res != SUCCESS, return res);

    g_groupInfo.map[groupId].id = groupId;
    g_groupInfo.allRatio += g_groupInfo.map[groupId].fileRatio;
    if (g_groupInfo.map[groupId].isDefGroup == 1) {
        g_groupInfo.defGroupId = groupId;
        SetGroupIdToUninitModule(groupId);
    }

    return SUCCESS;
}

/**
* @brief InsertGroupMapItem: insert a slog module config to map
* @param [in] fp: handle for slog.conf
* @param [in] lineBuf: line buffer for previous line of msg
*/
STATIC LogRt InsertGroupMapItem(FILE *fp, char **lineBuf)
{
    char *buf = *lineBuf;
    char symbol[SYMBOL_NAME_MAX_LEN + 1] = { 0 };

    ONE_ACT_NO_LOG(LogFileGets(buf, CONF_FILE_MAX_LINE, fp) != LOG_SUCCESS, return SUCCESS);
    while (feof(fp) == 0) {
        while (!IsBlockSymbol(buf)) { // Find the parsing start point
            ONE_ACT_NO_LOG(LogFileGets(buf, CONF_FILE_MAX_LINE, fp) != LOG_SUCCESS, return SUCCESS);
        }
        LogRt ret = GetSymbol(buf, symbol, SYMBOL_NAME_MAX_LEN);
        if (ret != SUCCESS) { // fail: give up this line & switch next line & return
            if (GetTabCount(buf) != 0) {
                ONE_ACT_NO_LOG(fgets(buf, CONF_FILE_MAX_LINE, fp) == NULL, return SUCCESS);
                continue;
            }
            ONE_ACT_NO_LOG(fgets(buf, CONF_FILE_MAX_LINE, fp) == NULL, return SUCCESS);
            SELF_LOG_ERROR("fail to get symbol in this line %s", buf);
            return ret;
        }
        if (!IsTargetSymbol(symbol, SLOG_SYMBOL_GROUP_STR)) {
            bool isOtherSymbol = IsMatchAnySymbol(symbol);
            bool hasAnyTab = (GetTabCount(buf) == 0) ? FALSE : TRUE;
            if ((!isOtherSymbol) && (!hasAnyTab)) { // neither GROUP nor other symbol
                ONE_ACT_NO_LOG(fgets(buf, CONF_FILE_MAX_LINE, fp) == NULL, return SUCCESS);
                return SUCCESS;
            } else if (isOtherSymbol) { // other symbol is matched
                return SUCCESS;
            }
        }
        int32_t groupId = AllocGroupId();
        ONE_ACT_ERR_LOG(groupId < 0, return ILLEGAL_GROUP_PARA, "fail to alloc group id.");
        ret = ParseUnitGroupCfg(fp, groupId, &buf);
        ONE_ACT_NO_LOG(ret == GROUP_RATIO_OVER_MAX, return ret);
        ONE_ACT_NO_LOG(ret != SUCCESS, continue);
        g_groupInfo.map[groupId].isInit = 1;
    }

    return SUCCESS;
}

STATIC LogRt UpdateGroupRatio(const char *buf)
{
    int32_t start = 0;
    char confName[CONF_NAME_MAX_LEN + 1] = { 0 };
    char confValue[CONF_VALUE_MAX_LEN + 1] = { 0 };
    char tmpBuf[CONF_FILE_MAX_LINE + 1] = { 0 };

    while (IsBlank(buf[start])) {
        start++;
    }
    int32_t ret = strcpy_s(tmpBuf, sizeof(tmpBuf) - 1U, (buf + start));
    ONE_ACT_ERR_LOG(ret != EOK, return STR_COPY_FAILED, \
                    "strcpy_s config item failed, result=%d, strerr=%s.",
                    ret, strerror(ToolGetErrorCode()));

    LogRt res = LogConfParseLine(tmpBuf, confName, CONF_NAME_MAX_LEN, confValue, CONF_VALUE_MAX_LEN);
    ONE_ACT_NO_LOG(res != SUCCESS, return res);

    if (strcmp(confName, SLOG_RATIO_CFG_STR) == 0) {
        int fileRatio = GetConfVal(confValue, CONF_VALUE_MAX_LEN);
        ONE_ACT_ERR_LOG((g_groupInfo.allRatio + fileRatio) > FULL_RATIO, return GROUP_RATIO_OVER_MAX, \
                        "curr ratio is %d, no enough space for ratio %d, parse fail, errno=%d.", \
                        g_groupInfo.allRatio, fileRatio, (int32_t)GROUP_RATIO_OVER_MAX);
        g_groupInfo.allRatio += fileRatio;
    }

    return SUCCESS;
}

STATIC void DeinitGroup(void)
{
    for (int32_t groupId = 0; groupId < GROUP_MAP_SIZE; groupId++) {
        g_groupInfo.map[groupId].isInit = 0;
        g_groupInfo.map[groupId].fileSize = 0;
        g_groupInfo.map[groupId].fileRatio = 0;
    }
}

STATIC void ResetGroupInfo(void)
{
    g_groupInfo.maxSize = 0;
    g_groupInfo.bufSize = 0;
    g_groupInfo.allRatio = 0;
    g_groupInfo.defGroupId = INVAILD_GROUP_ID;
    g_groupInfo.agentFileDir[0] = '\0';

    DeinitGroup();
    SetGroupIdToAllModule(INVAILD_GROUP_ID);
}

STATIC void SetAllLogToOthersGroup(void)
{
    g_groupInfo.map[DEFAULT_GROUP_ID].isInit = 1;
    g_groupInfo.map[DEFAULT_GROUP_ID].moduleNum = INVLID_MOUDLE_ID;
    uint32_t ratio = (unsigned int)FULL_RATIO >> 1;
    g_groupInfo.map[DEFAULT_GROUP_ID].fileRatio = (int)ratio;
    g_groupInfo.allRatio = FULL_RATIO;
    g_groupInfo.map[DEFAULT_GROUP_ID].fileSize = MIN_GROUP_FILE_SIZE;
    g_groupInfo.map[DEFAULT_GROUP_ID].totalMaxFileSize =
        (g_groupInfo.maxSize > 0) ? (uint32_t)g_groupInfo.maxSize : 0U;
    int32_t ret = strcpy_s(g_groupInfo.map[DEFAULT_GROUP_ID].name, GROUP_NAME_MAX_LEN, SLOG_DEFAULT_GROUP_NAME);
    NO_ACT_ERR_LOG(ret != EOK, "strcpy_s default group name failed.");
    g_groupInfo.defGroupId = DEFAULT_GROUP_ID;
    SetGroupIdToAllModule(DEFAULT_GROUP_ID);
}

STATIC void ParseCommonGroupMsg(FILE *fp, char **lineBuf)
{
    LogRt ret;
    char *buf = *lineBuf;

    // Accumulate the value of ratio and find the configuration module of the target.
    while (feof(fp) == 0) {
        // skip null line
        if (IsBlankline(*buf)) {
            ONE_ACT_NO_LOG(LogFileGets(buf, CONF_FILE_MAX_LINE, fp) != LOG_SUCCESS, break);
            continue;
        }
        // Is a new starting point of block
        if (IsBlockSymbol(buf)) {
            bool isTarget;
            ret = IsParseTarget(buf, &isTarget);
            if ((ret == SUCCESS) && (isTarget == TRUE)) {
                ret = InsertGroupMapItem(fp, &buf);
                ONE_ACT_NO_LOG(ret == GROUP_RATIO_OVER_MAX, goto HANDLE_RATIO_OVER_MAX);
                continue;
            }
        } else if (IsEquation(buf)) {
            ret = UpdateGroupRatio(buf);
            ONE_ACT_NO_LOG(ret == GROUP_RATIO_OVER_MAX, goto HANDLE_RATIO_OVER_MAX);
        } else {
            SELF_LOG_ERROR("unrecognizable lines %s", buf);
        }
        ONE_ACT_NO_LOG(LogFileGets(buf, CONF_FILE_MAX_LINE, fp) != LOG_SUCCESS, break);
    }

    return;
HANDLE_RATIO_OVER_MAX:
    SELF_LOG_ERROR("fail to parse common config.");
    DeinitGroup();
    SetAllLogToOthersGroup();
}

STATIC void PrintGroupConfig(void)
{
    const ModuleInfo *modSet = GetModuleInfos();

    SELF_LOG_INFO("Log max size = %dKB", g_groupInfo.maxSize);
    SELF_LOG_INFO("Log buffer size = %dKB", g_groupInfo.bufSize);
    for (int32_t groupId = 0; groupId < GROUP_MAP_SIZE; groupId++) {
        char moduleStr[CONF_VALUE_MAX_LEN + 1] = { 0 };

        ONE_ACT_NO_LOG(g_groupInfo.map[groupId].isInit == 0, continue);
        SELF_LOG_INFO("====================================");
        SELF_LOG_INFO("group id %d, name %s.", g_groupInfo.map[groupId].id, g_groupInfo.map[groupId].name);
        SELF_LOG_INFO("group active file size %dKB.", g_groupInfo.map[groupId].fileSize);
        SELF_LOG_INFO("group rotate file total size %uKB.", g_groupInfo.map[groupId].totalMaxFileSize);
        SELF_LOG_INFO("group contains the following modules:");
        for (int32_t moduleId = 0; moduleId < INVLID_MOUDLE_ID; moduleId++) {
            if (modSet[moduleId].groupId == groupId) {
                char tmpStr[CONF_VALUE_MAX_LEN + 1] = { 0 };
                int32_t ret = sprintf_s(tmpStr, CONF_VALUE_MAX_LEN, " %s", modSet[moduleId].moduleName);
                ONE_ACT_ERR_LOG(ret < 0, break, "sprintf fail for %s.", modSet[moduleId].moduleName);
                errno_t err = strncat_s(moduleStr, CONF_VALUE_MAX_LEN, tmpStr, strlen(tmpStr));
                ONE_ACT_ERR_LOG(err != EOK, break, "strncat_s fail.");
            }
        }
        SELF_LOG_INFO("%s", moduleStr);
    }
    SELF_LOG_INFO("====================================");
}

STATIC void UpdateFileGroupCfg(void)
{
    int32_t groupCnt = 0;

    for (int32_t groupId = 0; groupId < GROUP_MAP_SIZE; groupId++) {
        ONE_ACT_NO_LOG(g_groupInfo.map[groupId].isInit == 0, continue);
        groupCnt++;
        OptimizeGroupCfg(groupId);
    }
    if (g_groupInfo.allRatio == 0) {
        SetAllLogToOthersGroup();
        SELF_LOG_ERROR("none group is init, all log will flush into default group.");
    }
    NO_ACT_WARN_LOG(groupCnt == 0, "this log belong to slog module will be abandon.");
}

STATIC void SetGroupCfgToDefaultMode(void)
{
    LogConfGroupSetSwitch(false);
    SELF_LOG_WARN("parse grouping config fail, group mode will be disabled.");
}

/**
* @brief : read group info in slog.conf and parse them
* @param [in] file: config file realpath include filename, it can't be NULL
*/
void LogConfGroupInit(const char *file)
{
    LogRt res;
    FILE *fp = NULL;
    char *buf = NULL;

    ResetGroupInfo();
    // if file is NULL, then use default config file path
    res = LogConfOpenFile(&fp, file);
    if (res != SUCCESS) {
        SetGroupCfgToDefaultMode();
        return;
    }
    // Allocate a buffer to save the content of the previous line.
    buf = (char *)LogMalloc(CONF_FILE_MAX_LINE + 1);
    if (buf == NULL) {
        SELF_LOG_ERROR("malloc failed, errno=%d, strerr=%s.", (int32_t)MALLOC_FAILED, strerror(ToolGetErrorCode()));
        SetGroupCfgToDefaultMode();
        LOG_CLOSE_FILE(fp);
        return;
    }
    // Parsing Gernel Information
    res = ParseGernelGroupMsg(fp, &buf);
    if (res != SUCCESS) {
        SetGroupCfgToDefaultMode();
        LOG_CLOSE_FILE(fp);
        XFREE(buf);
        return;
    }
    LogConfGroupSetSwitch(true);
    SELF_LOG_INFO("parse gernel grouping config success, group mode will be used.");
    // Accumulate the value of ratio and find the configuration module of the target.
    ParseCommonGroupMsg(fp, &buf);
    UpdateFileGroupCfg();
    PrintGroupConfig();
    SELF_LOG_INFO("grouping config parse done.");
    LOG_CLOSE_FILE(fp);
    XFREE(buf);
}

const GeneralGroupInfo *LogConfGroupGetInfo(void)
{
    return &g_groupInfo;
}

bool LogConfGroupGetSwitch(void)
{
    return g_groupLogEnabled;
}

void LogConfGroupSetSwitch(bool enabled)
{
    g_groupLogEnabled = enabled;
    return;
}
#else
void LogConfGroupInit(const char *file)
{
    (void)file;
    return;
}

const GeneralGroupInfo *LogConfGroupGetInfo(void)
{
    return NULL;
}

bool LogConfGroupGetSwitch(void)
{
    return false;
}

#endif
