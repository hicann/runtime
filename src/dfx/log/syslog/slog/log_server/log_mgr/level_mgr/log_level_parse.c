/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_level_parse.h"
#include "log_system_api.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

STATIC DEFINE_LOG_LEVEL_CTRL(g_logLevel);
STATIC DEFINE_MODULE_LEVEL(g_moduleInfo);
STATIC DEFINE_LEVEL_TYPES(g_levelName);

void SlogdSetGlobalLevel(int32_t value, int32_t typeMask)
{
    (void)typeMask;
    g_logLevel.globalLogLevel = (int8_t)value;
}

void SlogdSetEventLevel(int32_t value)
{
    g_logLevel.enableEvent = (value == 1) ? true : false;
}

int32_t SlogdGetGlobalLevel(uint32_t typeMask)
{
    if (typeMask == RUN_LOG_MASK) {
        return GLOABLE_DEFAULT_RUN_LOG_LEVEL;
    } else {
        return (int32_t)g_logLevel.globalLogLevel;
    }
}

int32_t SlogdGetEventLevel(void)
{
    return (g_logLevel.enableEvent == true) ? 1 : 0;
}

// module level
STATIC INLINE bool IsModuleIdValid(int32_t moduleId)
{
    return ((moduleId >= 0) && (moduleId < INVLID_MOUDLE_ID)) ? true : false;
}

STATIC INLINE bool IsDevIdValid(int32_t devId)
{
    return ((devId >= 0) && (devId < MAX_DEVICE_NUM)) ? true : false;
}


bool IsMultipleModule(int32_t moduleId)
{
    if (!IsModuleIdValid(moduleId)) {
        return false;
    }

    return g_moduleInfo[moduleId].multiFlag;
}

bool SlogdSetModuleLevel(int32_t moduleId, int32_t value, int32_t typeMask)
{
    (void)typeMask;
    if (!IsModuleIdValid(moduleId)) {
        return false;
    }
    g_moduleInfo[moduleId].moduleLevel = (int8_t)value;
    if (g_moduleInfo[moduleId].multiFlag) {
        for (int32_t i = 0; i < MAX_DEVICE_NUM; i++) {
            g_moduleInfo[moduleId].moduleLevels[i] = (int8_t)value;
        }
    }
    return true;
}

bool SlogdSetModuleLevelByDevId(int32_t devId, int32_t moduleId, int32_t value, int32_t typeMask)
{
    (void)typeMask;
    if (!IsDevIdValid(devId)) {
        return false;
    }
    if (!IsModuleIdValid(moduleId)) {
        return false;
    }
    g_moduleInfo[moduleId].moduleLevel = (int8_t)value;
    if (g_moduleInfo[moduleId].multiFlag) {
        g_moduleInfo[moduleId].moduleLevels[devId] = (int8_t)value;
    }
    return true;
}

int32_t SlogdGetModuleLevel(int32_t moduleId, uint32_t typeMask)
{
    if (!IsModuleIdValid(moduleId)) {
        return MODULE_DEFAULT_LOG_LEVEL;
    }
 
    if (g_moduleInfo[moduleId].multiFlag) {
        if (typeMask == RUN_LOG_MASK) {
            return GLOABLE_DEFAULT_RUN_LOG_LEVEL;
        } else {
            return (int32_t)g_moduleInfo[moduleId].moduleLevels[0];
        }
    } else {
        if (typeMask == RUN_LOG_MASK) {
            return GLOABLE_DEFAULT_RUN_LOG_LEVEL;
        } else {
            return (int32_t)g_moduleInfo[moduleId].moduleLevel;
        }
    }
}

int32_t SlogdGetModuleLevelByDevId(int32_t devId, int32_t moduleId, uint32_t typeMask)
{
    if (!IsDevIdValid(devId)) {
        return MODULE_DEFAULT_LOG_LEVEL;
    }
 
    if (g_moduleInfo[moduleId].multiFlag) {
        if (typeMask == RUN_LOG_MASK) {
            return GLOABLE_DEFAULT_RUN_LOG_LEVEL;
        } else {
            return (int32_t)g_moduleInfo[moduleId].moduleLevels[devId];
        }
    } else {
        if (typeMask == RUN_LOG_MASK) {
            return GLOABLE_DEFAULT_RUN_LOG_LEVEL;
        } else {
            return (int32_t)g_moduleInfo[moduleId].moduleLevel;
        }
    }
}

/**
* @brief : set module loglevel by moduleId
* @param [in]moduleId: module id
* @param [in]value: module group id
* @return: true: SUCCEED, false: FAILED
*/
bool SetGroupIdByModuleId(int32_t moduleId, int32_t value)
{
    ModuleInfo *set = g_moduleInfo;
    if ((moduleId >= 0) && (moduleId < INVLID_MOUDLE_ID)) {
        set[moduleId].groupId = value;
        return true;
    }
    return false;
}

/**
* @brief SetGroupIdToAllModule: module of "eating together"
* @return: void
*/
void SetGroupIdToAllModule(int32_t id)
{
    ModuleInfo *set = g_moduleInfo;
    for (; set->moduleName != NULL; set++) {
        set->groupId = id;
    }
}

void SetGroupIdToUninitModule(int32_t id)
{
    ModuleInfo *set = g_moduleInfo;
    for (; set->moduleName != NULL; set++) {
        if (set->groupId == INVAILD_GROUP_ID) {
            set->groupId = id;
        }
    }
}

/**
* @brief GetGroupIdByModuleId: get group id by moduleId
* @param [in]moduleId: module id
* @return: module log level
*/
int32_t GetGroupIdByModuleId(int32_t moduleId)
{
    const ModuleInfo *set = g_moduleInfo;
    if ((moduleId >= 0) && (moduleId < INVLID_MOUDLE_ID)) {
        return set[moduleId].groupId;
    }
    return -1;
}

/**
* @brief GetModuleInfos: get g_moduleInfo
* @return: g_moduleInfo
*/
const ModuleInfo *GetModuleInfos(void)
{
    return (const ModuleInfo *)g_moduleInfo;
}

/**
* @brief GetModuleInfoByName: get module info by module name
* @param [in]name: module name
* @return: module info struct
*/
const ModuleInfo *GetModuleInfoByName(const char *name)
{
    if (name == NULL) {
        return NULL;
    }
    const ModuleInfo *info = g_moduleInfo;
    for (; (info != NULL) && (info->moduleName != NULL); info++) {
        if (strcmp(name, info->moduleName) == 0) {
            return info;
        }
    }
    return NULL;
}

/**
* @brief GetModuleInfoById: get module info by module id
* @param [in]moduleId: module id
* @return: module info struct ptr
*/
const ModuleInfo *GetModuleInfoById(int32_t moduleId)
{
    if ((moduleId >= 0) && (moduleId < INVLID_MOUDLE_ID)) {
        return &(g_moduleInfo[moduleId]);
    }
    return NULL;
}

/**
* @brief GetModuleNameById: get module name by module id
* @param [in]moduleId: module id
* @return: module name
*/
const char *GetModuleNameById(int32_t moduleId)
{
    if ((moduleId >= 0) && (moduleId < INVLID_MOUDLE_ID)) {
        return g_moduleInfo[moduleId].moduleName;
    }
    return NULL;
}

/**
 * @brief       : get level by name
 * @param [in]  : name      string of level name
 * @return      : level
 */
int32_t GetLevelIdByName(const char *name)
{
    if (name == NULL) {
        return -1;
    }

    for (int32_t level = DLOG_DEBUG; level <= DLOG_EVENT; level++) {
        if (g_levelName[level].levelName != NULL) {
            if (strcmp(name, g_levelName[level].levelName) == 0) {
                return g_levelName[level].levelId;
            }
        }
    }
    return -1;
}

/**
* @brief GetLevelNameById: get level name by level
* @param [in]level: log level, include debug, info, warning, error, null, trace, oplog, event
* @return: level name
*/
const char *GetLevelNameById(int64_t level)
{
    if (((level >= DLOG_DEBUG) && (level <= DLOG_NULL)) || (level == DLOG_EVENT)) {
        return g_levelName[level].levelName;
    }
    return NULL;
}

/**
* @brief GetBasicLevelNameById: get level name by level
* @param [in]level: log level, include debug, info, warning, error, null
* @return: level name
*/
const char *GetBasicLevelNameById(int32_t level)
{
    if ((level >= DLOG_DEBUG) && (level <= DLOG_NULL)) {
        return g_levelName[level].levelName;
    }
    return "INVALID";
}

#ifdef __cplusplus
}
#endif // __cplusplus
