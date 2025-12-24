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
#include <stddef.h>
#include <string.h>
#include "log_platform.h"


#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

STATIC DEFINE_LOG_LEVEL_CTRL(g_dlogLevel);
STATIC DEFINE_MODULE_LEVEL(g_dlogModuleInfo);
STATIC DEFINE_LEVEL_TYPES(g_dlogLevelName);
STATIC bool g_dlogLevelChanged = false;

void DlogSetLevelStatus(bool levelStatus)
{
    g_dlogLevelChanged = levelStatus;
}

bool DlogGetLevelStatus(void)
{
    return g_dlogLevelChanged;
}

/**
 * @brief        : get global log level
 * @param [in]   : typeMask   log type msak
 * @return       : global log level with log type
 */
int32_t GetGlobalLogTypeLevelVar(uint32_t typeMask)
{
    if (typeMask == RUN_LOG_MASK) {
        return GLOABLE_DEFAULT_RUN_LOG_LEVEL;
    } else if (typeMask == SECURITY_LOG_MASK) {
        return GLOABLE_DEFAULT_SECURITY_LOG_LEVEL;
    } else {
        return (int32_t)g_dlogLevel.globalLogLevel;
    }
}

/**
 * @brief        : set global log level
 * @param [in]   : level      current log level
 * @param [in]   : typeMask   log type msak
 * @return       : NA
 */
void SetGlobalLogTypeLevelVar(int32_t level, uint32_t typeMask)
{
    (void)typeMask;
    g_dlogLevel.globalLogLevel = (int8_t)level;
}

/**
 * @brief        : get event log level
 * @return       : event log level
 */
bool GetGlobalEnableEventVar(void)
{
    return g_dlogLevel.enableEvent;
}

/**
 * @brief        : set event log level
 * @param [in]   : enableEvent      current event log level
 * @return       : NA
 */
void SetGlobalEnableEventVar(bool enableEvent)
{
    g_dlogLevel.enableEvent = enableEvent;
}

/**
 * @brief        : is global log level setted
 * @return       : global log level setted
 */
bool GetGlobalLevelSettedVar(void)
{
    return g_dlogLevel.levelSetted;
}

/**
 * @brief        : set global log level setted
 * @param [in]   : levelSetted      current level setted
 * @return       : NA
 */
void SetGlobalLevelSettedVar(bool levelSetted)
{
    g_dlogLevel.levelSetted = levelSetted;
}

/**
 * @brief        : get log level status
 * @return       : log level status
 */
int32_t GetLevelStatus(void)
{
    return g_dlogLevel.levelStatus;
}

/**
 * @brief        : set log level status
 * @param [in]   : levelStatus      current level status
 * @return       : NA
 */
void SetLevelStatus(int32_t levelStatus)
{
    g_dlogLevel.levelStatus = levelStatus;
}

/**
 * @brief        : set debug level to module info
 * @param [in]   : set      module need to set
 * @param [in]   : level    module log level
 * @return       : true success; false  fail
 */
STATIC bool DlogSetDebugLevelByModuleId(int32_t moduleId, int32_t level)
{
    ModuleInfo *set = g_dlogModuleInfo;
    if ((moduleId >= 0) && (moduleId < INVLID_MOUDLE_ID)) {
        set[moduleId].moduleLevel = (int8_t)level;
        return true;
    }
    return false;
}

/**
 * @brief        : set level to module info
 * @param [in]   : moduleId     module need to set
 * @param [in]   : level        module log level
 * @param [in]   : typeMask     log type msak. if no mask, set to both debug and run
 * @return       : true success; false fail
 */
bool DlogSetLogTypeLevelByModuleId(int32_t moduleId, int32_t level, uint32_t typeMask)
{
    (void)typeMask;
    return DlogSetDebugLevelByModuleId(moduleId, level);
}

/**
 * @brief        : set level to all module info
 * @param [in]   : level        module log level
 * @param [in]   : typeMask     log type msak. if no type, set to both debug and run
 * @return       : true success; false fail
 */
void DlogSetLogTypeLevelToAllModule(int32_t level, uint32_t typeMask)
{
    ModuleInfo *set = g_dlogModuleInfo;
    if (typeMask == RUN_LOG_MASK) {
        return;
    } else {
        for (; set->moduleName != NULL; set++) {
            (void)DlogSetDebugLevelByModuleId(set->moduleId, level);
        }
    }
}

/**
 * @brief        : get module level by moduleId with log type, if no type, return debug level
 * @param [in]   : moduleId     module need to set
 * @return       : module log level with log type
 */
int32_t DlogGetLogTypeLevelByModuleId(uint32_t moduleId, uint32_t typeMask)
{
    if ((typeMask == DEBUG_LOG_MASK) || (typeMask == 0U)) {
        if (moduleId < (uint32_t)INVLID_MOUDLE_ID) {
            return (int32_t)g_dlogModuleInfo[moduleId].moduleLevel;
        } else {
            return (int32_t)g_dlogLevel.globalLogLevel;
        }
    } else if (typeMask == RUN_LOG_MASK) {
        return GLOABLE_DEFAULT_RUN_LOG_LEVEL;
    } else if (typeMask == SECURITY_LOG_MASK) {
        return GLOABLE_DEFAULT_SECURITY_LOG_LEVEL;
    } else if (typeMask == STDOUT_LOG_MASK) {
        return GLOABLE_DEFAULT_STDOUT_LOG_LEVEL;
    }
    return (int32_t)g_dlogLevel.globalLogLevel;
}

int32_t DlogGetDebugLogLevelByModuleId(uint32_t moduleId)
{
    if (moduleId < (uint32_t)INVLID_MOUDLE_ID) {
        return (int32_t)g_dlogModuleInfo[moduleId].moduleLevel;
    } else {
        return (int32_t)g_dlogLevel.globalLogLevel;
    }
}

/**
* @brief : get g_moduleInfo
* @return: g_moduleInfo
*/
const ModuleInfo *DlogGetModuleInfos(void)
{
    return (const ModuleInfo *)g_dlogModuleInfo;
}

static const ModuleInfo *DlogGetInfoByName(const char *name, const ModuleInfo *set)
{
    if (name == NULL) {
        return NULL;
    }
    const ModuleInfo *info = set;
    for (; (info != NULL) && (info->moduleName != NULL); info++) {
        if (strcmp(name, info->moduleName) == 0) {
            return info;
        }
    }
    return NULL;
}
/**
* @brief : get module info by module name
* @param [in]name: module name
* @return: module info struct
*/
const ModuleInfo *DlogGetModuleInfoByName(const char *name)
{
    return DlogGetInfoByName(name, g_dlogModuleInfo);
}

/**
* @brief : get module name by module id
* @param [in]moduleId: module id
* @return: module name
*/
const char *DlogGetModuleNameById(uint32_t moduleId)
{
    if (moduleId < (uint32_t)INVLID_MOUDLE_ID) {
        return g_dlogModuleInfo[moduleId].moduleName;
    }
    return NULL;
}

/**
* @brief : get level name by level
* @param [in]level: log level, include debug, info, warning, error, null, event
* @return: level name
*/
const char *DlogGetLevelNameById(int32_t level)
{
    if (((level >= DLOG_DEBUG) && (level <= DLOG_NULL)) || (level == DLOG_EVENT)) {
        return g_dlogLevelName[level].levelName;
    }
    return NULL;
}

/**
* @brief : get level name by level
* @param [in]level: log level, include debug, info, warning, error, null
* @return: level name
*/
const char *DlogGetBasicLevelNameById(int32_t level)
{
    if ((level >= DLOG_DEBUG) && (level <= DLOG_NULL)) {
        return g_dlogLevelName[level].levelName;
    }
    return "INVALID";
}

#ifdef __cplusplus
}
#endif // __cplusplus

