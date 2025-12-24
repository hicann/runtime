/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlog_level_mgr.h"
#include "dlog_common.h"
#include "mmpa_api.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define INVALID_NUM (-1)

typedef struct {
    int32_t key;
    int32_t value;
} IdValueInfo;

STATIC void DlogInitEventLevelByEnv(void)
{
    const char *eventEnv = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_GLOBAL_EVENT_ENABLE, (eventEnv));
    if (eventEnv != NULL) {
        int64_t tmpL = -1;
        if ((LogStrToInt(eventEnv, &tmpL) == LOG_SUCCESS) && ((tmpL == TRUE) || (tmpL == FALSE))) {
            bool enbale = (tmpL == TRUE) ? true : false;
            SetGlobalEnableEventVar(enbale);
            SELF_LOG_INFO("get right env ASCEND_GLOBAL_EVENT_ENABLE(%" PRId64 ").", tmpL);
            return;
        }
    }
    SetGlobalEnableEventVar(true);
    SELF_LOG_INFO("set default global event level true.");
}

STATIC void DlogUpdateLevelStatus(int64_t level)
{
    if (level < DLOG_ERROR) {
        DlogSetLevelStatus(true);
    }
}

STATIC void DlogInitGlobalLogLevelByEnv(void)
{
    SetGlobalLogTypeLevelVar(DLOG_GLOABLE_DEFAULT_LEVEL, DLOG_GLOBAL_TYPE_MASK);
    DlogSetLogTypeLevelToAllModule(DLOG_GLOABLE_DEFAULT_LEVEL, DLOG_GLOBAL_TYPE_MASK);
    // global level env is prior to config file
    const char *globalLevelEnv = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_GLOBAL_LOG_LEVEL, (globalLevelEnv));
    if (globalLevelEnv != NULL) {
        int64_t globalLevel = -1;
        if ((LogStrToInt(globalLevelEnv, &globalLevel) == LOG_SUCCESS) &&
            (globalLevel >= LOG_MIN_LEVEL) && (globalLevel <= LOG_MAX_LEVEL)) {
            SetGlobalLogTypeLevelVar((int32_t)globalLevel, DLOG_GLOBAL_TYPE_MASK);
            DlogSetLogTypeLevelToAllModule((int32_t)globalLevel, DLOG_GLOBAL_TYPE_MASK);
            DlogUpdateLevelStatus(globalLevel);
            SELF_LOG_INFO("get env ASCEND_GLOBAL_LOG_LEVEL(%" PRId64 ") and it is prior to conf file.", globalLevel);
            return;
        }
    }
    SELF_LOG_INFO("set default global log level (%d), debug log level (%d), run log level (%d).",
                  DLOG_GLOABLE_DEFAULT_LEVEL, DLOG_DEBUG_DEFAULT_LEVEL, DLOG_RUN_DEFAULT_LEVEL);
}

STATIC LogStatus DlogCheckItem(const char *token, int32_t *moduleIdPtr, int32_t *logLevelPtr)
{
    ONE_ACT_NO_LOG(strlen(token) == 0, return LOG_FAILURE);
    char itemStr[MAX_MODULE_LOG_LEVEL_OPTION_LEN];
    (void)memset_s(itemStr, MAX_MODULE_LOG_LEVEL_OPTION_LEN, '\0', MAX_MODULE_LOG_LEVEL_OPTION_LEN);
    int32_t retCopy = strcpy_s(itemStr, MAX_MODULE_LOG_LEVEL_OPTION_LEN, token);
    ONE_ACT_ERR_LOG(retCopy != EOK, return LOG_FAILURE, "strcpy_s failed.");
    ONE_ACT_ERR_LOG((strchr(itemStr, '=') == NULL) || (strchr(itemStr, '=') != strrchr(itemStr, '=')),
        return LOG_FAILURE, "option string: \"%s\" is not valid", itemStr); // check if only have one "="
    char *nameStr = NULL;
    char *valueStr = NULL;
    char *ptr = itemStr;
    int32_t i;
    for (i = 0; i < (MAX_MODULE_LOG_LEVEL_OPTION_LEN - 1); i++) {
        if (*(ptr + i) == '\0') {
            break;
        }
        if ((*(ptr + i) == '=') && (*(ptr + i + 1) != '\0')) {
            *(ptr + i) = '\0';
            nameStr = ptr;          // id start pos
            valueStr = ptr + i + 1; // value start pos
            break;
        }
    }
    ONE_ACT_ERR_LOG((nameStr == NULL) || (valueStr == NULL) || (strlen(nameStr) == 0) || (strlen(valueStr) == 0),
        return LOG_FAILURE, "Empty value exists in ASCEND_MODULE_LOG_LEVEL.");
    const ModuleInfo *moduleInfo = DlogGetModuleInfoByName(nameStr); // check if has this module
    ONE_ACT_ERR_LOG(moduleInfo == NULL, return LOG_FAILURE, "The module is not supported.");
    const int32_t id = moduleInfo->moduleId;
    int64_t value = 0;
    LogStatus ret = LogStrToInt(valueStr, &value);
    ONE_ACT_ERR_LOG((ret != LOG_SUCCESS) || (value < LOG_MIN_LEVEL) || (value > LOG_MAX_LEVEL),
        return LOG_FAILURE, "Parse the log value failed, valueStr: %s", valueStr); // check if value is valid
    *moduleIdPtr = id;
    *logLevelPtr = (int32_t)value;
    return LOG_SUCCESS;
}

STATIC LogStatus DlogInitModuleLogLevelByEnv(void)
{
    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_MODULE_LOG_LEVEL, (env));
    if (env == NULL) {
        SELF_LOG_WARN("get the null ASCEND_MODULE_LOG_LEVEL env");
        return LOG_FAILURE;
    }
    size_t size = strlen(env);
    ONE_ACT_ERR_LOG((size == 0U) || (size > (size_t)MAX_ASCEND_MODULE_LOG_ENV_LEN), return LOG_FAILURE,
        "env ASCEND_MODULE_LOG_LEVEL lenth is not allowed, not use the ASCEND_MODULE_LOG_LEVEL env.");
    char moduleEnv[MAX_ASCEND_MODULE_LOG_ENV_LEN + 1] = {0};
    ONE_ACT_ERR_LOG(strcpy_s(moduleEnv, MAX_ASCEND_MODULE_LOG_ENV_LEN + 1, env) != EOK, return LOG_FAILURE,
        "strcpy_s failed.");

    // get log level
    char *nextToken = NULL;
    char *token = strtok_s(moduleEnv, ":", &nextToken);
    if (token == NULL) {
        SELF_LOG_ERROR("no string to search.");
        return LOG_FAILURE;
    }
    IdValueInfo setBuf[INVLID_MOUDLE_ID];
    (void)memset_s(setBuf, sizeof(setBuf), 0, sizeof(setBuf));
    int32_t itemNum = 0;
    while (token != NULL) {
        // INVLID_MOUDLE_ID
        ONE_ACT_ERR_LOG(itemNum >= INVLID_MOUDLE_ID, return LOG_FAILURE,
            "env ASCEND_MODULE_LOG_LEVEL number exceed the limit");
        int32_t moduleId = INVALID_NUM;
        int32_t logLevel = INVALID_NUM;
        LogStatus res = DlogCheckItem(token, &moduleId, &logLevel); // check one item
        ONE_ACT_ERR_LOG((res == LOG_FAILURE) || (moduleId == INVALID_NUM) || (logLevel == INVALID_NUM),
            return LOG_FAILURE, "Init log level by ASCEND_MODULE_LOG_LEVEL abort");
        IdValueInfo item = { moduleId, logLevel };
        setBuf[itemNum] = item;
        token = strtok_s(NULL, ":", &nextToken);
        itemNum++;
    }
    // set log level
    int32_t i;
    for (i = 0; i < itemNum; i++) {
        int32_t moduleId = setBuf[i].key;
        int32_t logLevel = setBuf[i].value;
        DlogUpdateLevelStatus(logLevel);
        if (DlogSetLogTypeLevelByModuleId(moduleId, logLevel, DLOG_GLOBAL_TYPE_MASK) == false) {
            SELF_LOG_ERROR("set log level %d to module id %d failed", logLevel, moduleId);
        }
    }
    return LOG_SUCCESS;
}

void DlogLevelInitByEnv(void)
{
    DlogInitGlobalLogLevelByEnv();
    LogStatus ret = DlogInitModuleLogLevelByEnv();
    NO_ACT_WARN_LOG(ret == LOG_FAILURE,
        "can not init log level by ASCEND_MODULE_LOG_LEVEL env, use global log level for all modules");
    DlogInitEventLevelByEnv();
}

#if defined LOG_CPP || defined APP_LOG
void DlogLevelInit(void)
{
    DlogLevelInitByEnv();
}
#endif  // ifdef LOG_CPP

#ifdef __cplusplus
}
#endif // __cplusplus
