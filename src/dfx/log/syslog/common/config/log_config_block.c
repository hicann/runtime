/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_config_block.h"
#include "log_config_common.h"
#include "log_file_info.h"
#include "log_print.h"
#include "log_file_util.h"

#define LOG_CONF_CLASS_NAM                  "class"
#define LOG_CONF_CLASS_INPUT_RULE_NAM       "input_rule"
#define LOG_CONF_CLASS_OUTPUT_RULE_NAME     "output_rule"
#define LOG_CONF_CLASS_STORAGE_RULE_NAME    "storage_rule"
#define LOG_CONF_BLOCK_NUM                  5
#define LOG_SAVE_FILE                       0
#define LOG_SAVE_BUFFER                     1
#define LOG_MAX_STORAGE_PERIOD              24U
#define HOUR_TO_S                           3600U

typedef struct {
    char blockName[CONF_VALUE_MAX_LEN];
    char inputName[CONF_VALUE_MAX_LEN];
    int32_t logType;
} LogConfClassMap;

typedef struct {
    char ruleName[CONF_VALUE_MAX_LEN];
    int32_t ruleValue;
} LogConfRuleMap;

typedef struct {
    const char *ruleName;
    void (*logConfRuleFunc)(const char *, LogConfClass *);
} LogConfRuleOperate;

static const char * const LOG_CONF_BLOCK_CLASS[LOG_CONF_BLOCK_NUM] = { "debug", "run", "event", "security", "daemon" };

static const LogConfClassMap LOG_CONF_CLASS_MAP[] = {
    { "debug", "system", DEBUG_SYS_LOG_TYPE },
    { "debug", "app", DEBUG_APP_LOG_TYPE },
    { "debug", "firmware", FIRM_LOG_TYPE },
    { "run", "system", RUN_SYS_LOG_TYPE },
    { "run", "app", RUN_APP_LOG_TYPE },
    { "event", "event", EVENT_LOG_TYPE },
    { "security", "system", SEC_SYS_LOG_TYPE },
    { "security", "app", SEC_APP_LOG_TYPE }
};

static const LogConfRuleMap LOG_CONF_RULE_MAP[] = {
    { "file", LOG_SAVE_FILE },
    { "buffer", LOG_SAVE_BUFFER }
};

static void LogConfInputRuleFunc(const char *symbol, LogConfClass *confClass);
static void LogConfOutputRuleFunc(const char *symbol, LogConfClass *confClass);
static void LogConfStorageRuleFunc(const char *symbol, LogConfClass *confClass);
static LogConfRuleOperate g_logConfRuleOperate[] = {
    { LOG_CONF_CLASS_INPUT_RULE_NAM, LogConfInputRuleFunc },
    { LOG_CONF_CLASS_OUTPUT_RULE_NAME, LogConfOutputRuleFunc },
    { LOG_CONF_CLASS_STORAGE_RULE_NAME, LogConfStorageRuleFunc }
};

STATIC LogConfClass g_logConfClass[LOG_TYPE_MAX_NUM] = {0};

static int32_t LogConfGetClassify(const char *blockName, const char *inputType)
{
    for (size_t i = 0; i < sizeof(LOG_CONF_CLASS_MAP) / sizeof(LogConfClassMap); i++) {
        if ((strcmp(LOG_CONF_CLASS_MAP[i].blockName, blockName) == 0) &&
            (strcmp(LOG_CONF_CLASS_MAP[i].inputName, inputType) == 0)) {
            return LOG_CONF_CLASS_MAP[i].logType;
        }
    }
    return -1;
}

static int32_t LogConfGetSaveMode(const char *saveMode)
{
    for (size_t i = 0; i < sizeof(LOG_CONF_RULE_MAP) / sizeof(LogConfRuleMap); i++) {
        if (strcmp(LOG_CONF_RULE_MAP[i].ruleName, saveMode) == 0) {
            return LOG_CONF_RULE_MAP[i].ruleValue;
        }
    }
    return LOG_SAVE_FILE;
}

static void LogConfInputRuleFunc(const char *symbol, LogConfClass *confClass)
{
    int32_t num = sscanf_s(symbol, "%s", confClass->inputRule.inputClassify, CONF_VALUE_MAX_LEN);
    if (num <= 0) {
        SELF_LOG_ERROR("fail to parse input rule, config value = %s", symbol);
        return;
    }
    confClass->logClassify = LogConfGetClassify(confClass->blockName, confClass->inputRule.inputClassify);
}

static void LogConfOutputRuleFunc(const char *symbol, LogConfClass *confClass)
{
    char modeStr[CONF_VALUE_MAX_LEN] = { 0 };
    char maxSizeStr[CONF_VALUE_MAX_LEN] = { 0 };
    char maxNumStr[CONF_VALUE_MAX_LEN] = { 0 };
    char totalSizeStr[CONF_VALUE_MAX_LEN] = { 0 };
    int32_t num = sscanf_s(symbol, "%[^;];%[^;];%[^;];%s", modeStr, CONF_VALUE_MAX_LEN, maxSizeStr, CONF_VALUE_MAX_LEN,
        maxNumStr, CONF_VALUE_MAX_LEN, totalSizeStr, CONF_VALUE_MAX_LEN);
    if (num <= 0) {
        SELF_LOG_ERROR("fail to parse output rule, config value = %s", symbol);
        return;
    }
    confClass->outputRule.saveMode = LogConfGetSaveMode(modeStr);
    confClass->outputRule.fileSize = LogConfGetDigit("max_size", maxSizeStr,
        LOG_OUTPUT_MIN_FILE_SIZE, LOG_OUTPUT_MAX_FILE_SIZE, LOG_OUTPUT_DEFAULT_FILE_SIZE);
    confClass->outputRule.fileNum = LogConfGetDigit("max_num", maxNumStr,
        LOG_OUTPUT_MIN_FILE_NUM, LOG_OUTPUT_MAX_FILE_NUM, LOG_OUTPUT_DEFAULT_FILE_NUM);
    // totalSize must greater than fileSize
    confClass->outputRule.totalSize = LogConfGetDigit("total_size", totalSizeStr,
        LOG_OUTPUT_MIN_FILE_SIZE, LOG_OUTPUT_MAX_FILE_SIZE, LOG_OUTPUT_DEFAULT_FILE_SIZE);
    if (confClass->outputRule.totalSize < confClass->outputRule.fileSize) {
        confClass->outputRule.totalSize = confClass->outputRule.fileSize;
    }
}

static void LogConfStorageRuleFunc(const char *symbol, LogConfClass *confClass)
{
    char rulePeriod[CONF_VALUE_MAX_LEN] = { 0 };
    int32_t num = sscanf_s(symbol, "%s", rulePeriod, CONF_VALUE_MAX_LEN);
    if (num <= 0) {
        SELF_LOG_ERROR("fail to parse storage rule, config value = %s", symbol);
        return;
    }
    confClass->storageRule.storagePeriod =
        LogConfGetDigit("period_storage", rulePeriod, 0, LOG_MAX_STORAGE_PERIOD, 0) * HOUR_TO_S;
}

static void LogConfParseRule(const char* confName, const char* confValue, LogConfClass *confClass)
{
    for (size_t i = 0; i < sizeof(g_logConfRuleOperate) / sizeof(LogConfRuleOperate); i++) {
        if (strcmp(confName, g_logConfRuleOperate[i].ruleName) == 0) {
            g_logConfRuleOperate[i].logConfRuleFunc(confValue, confClass);
            return;
        }
    }
    SELF_LOG_WARN("invalid rule name %s", confName);
}

static void LogConfSaveClass(LogConfClass *confClass)
{
    int32_t logType = confClass->logClassify;
    if ((logType < 0) || (logType >= LOG_TYPE_MAX_NUM)) {
        return;
    }
    errno_t err = memcpy_s(&g_logConfClass[logType], sizeof(LogConfClass), confClass, sizeof(LogConfClass));
    if (err != EOK) {
        SELF_LOG_ERROR("memcpy for log class fail, log type = %d.", logType);
    }
}

static void LogConfInitClassItem(FILE *fp, const char *blockName)
{
    char buf[CONF_FILE_MAX_LINE + 1] = { 0 };
    char confName[CONF_NAME_MAX_LEN + 1] = { 0 };
    char confValue[CONF_VALUE_MAX_LEN + 1] = { 0 };
    char tmpBuf[CONF_FILE_MAX_LINE + 1] = { 0 };
    int64_t pos = LogFileTell(fp);
    LogConfClass confClass;
    (void)memset_s(&confClass, sizeof(LogConfClass), 0, sizeof(LogConfClass));
    errno_t err = EOK;

    while (LogFileGets(buf, CONF_FILE_MAX_LINE, fp) == LOG_SUCCESS) {
        // skip null line
        if (IsBlankline(*buf)) {
            continue;
        }
        if (IsBlockSymbol(buf)) {
            break;
        }
        int32_t start = 0;
        while ((start < CONF_FILE_MAX_LINE) && IsBlank(buf[start])) {
            start++;
        }
        (void)memset_s(tmpBuf, CONF_FILE_MAX_LINE + 1, 0, CONF_FILE_MAX_LINE + 1);
        err = strcpy_s(tmpBuf, CONF_FILE_MAX_LINE + 1, (buf + start));
        ONE_ACT_ERR_LOG(err != EOK, continue, "strcpy_s config item failed, result=%d.", (int32_t)err);
        LogRt ret = LogConfParseLine(tmpBuf, confName, CONF_NAME_MAX_LEN, confValue, CONF_VALUE_MAX_LEN);
        if (ret != SUCCESS) {
            continue;
        }
        SELF_LOG_INFO("get config %s=%s", confName, confValue);
        if (strcmp(confName, LOG_CONF_CLASS_NAM) == 0) {
            // save config class before next class
            LogConfSaveClass(&confClass);
            (void)memset_s(&confClass, sizeof(LogConfClass), 0, sizeof(LogConfClass));
            err = strcpy_s(confClass.blockName, CONF_VALUE_MAX_LEN + 1, blockName);
            if (err != EOK) {
                SELF_LOG_ERROR("copy block name fail, block name = %s.", blockName);
                continue;
            }
            err = strcpy_s(confClass.className, CONF_VALUE_MAX_LEN + 1, confValue);
            if (err != EOK) {
                SELF_LOG_ERROR("copy class name fail, class name = %s.", confValue);
                continue;
            }
        } else {
            LogConfParseRule(confName, confValue, &confClass);
        }
        pos = LogFileTell(fp);
    }
    LogConfSaveClass(&confClass);
    // if not goto file end, reset for next parse
    ONE_ACT_NO_LOG(feof(fp) == 0, ((void)fseek(fp, pos, SEEK_SET)));
}

static bool LogConfCheckBlockClass(const char *symbol)
{
    for (uint32_t num = 0; num < LOG_CONF_BLOCK_NUM; num++) {
        if (strcmp(symbol, LOG_CONF_BLOCK_CLASS[num]) == 0) {
            SELF_LOG_INFO("class block %s is find.", symbol);
            return true;
        }
    }
    return false;
}

void LogConfParseBlock(FILE *fp)
{
    char buf[CONF_FILE_MAX_LINE + 1] = { 0 };

    // check block name
    while (LogFileGets(buf, CONF_FILE_MAX_LINE, fp) == LOG_SUCCESS) {
        // skip null line
        if (IsBlankline(*buf) || IsEquation(buf)) {
            continue;
        }
        // Is a new starting point of block
        if (!IsBlockSymbol(buf)) {
            SELF_LOG_ERROR("unrecognizable lines %s", buf);
            continue;
        }
        char blockName[SYMBOL_NAME_MAX_LEN + 1] = { 0 };
        if ((GetSymbol(buf, blockName, SYMBOL_NAME_MAX_LEN) == SUCCESS) && (LogConfCheckBlockClass(blockName))) {
            LogConfInitClassItem(fp, blockName);
        }
    }
}

LogConfClass *LogConfGetClass(int32_t logType)
{
    if ((logType < 0) || (logType >= LOG_TYPE_MAX_NUM)) {
        return NULL;
    }
    return &g_logConfClass[logType];
}