/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msnpureport_level.h"
#include "log_system_api.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

STATIC DEFINE_MODULE_LEVEL(g_moduleInfo);
STATIC DEFINE_LEVEL_TYPES(g_levelName);

/**
* @brief       : get module info by module name
* @param [in]  : name   module name
* @return      : module info struct
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
 * @brief       : get level by name
 * @param [in]  : name      string of level name
 * @return      : level
 */
int32_t GetLevelIdByName(const char *name)
{
    if (name == NULL) {
        return -1;
    }
    int32_t level = DLOG_DEBUG;
    for (; level <= DLOG_EVENT; level++) {
        if (g_levelName[level].levelName != NULL) {
            if (strcmp(name, g_levelName[level].levelName) == 0) {
                return g_levelName[level].levelId;
            }
        }
    }
    return -1;
}

#ifdef __cplusplus
}
#endif // __cplusplus
