/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_LEVEL_PARSE_H
#define LOG_LEVEL_PARSE_H
#include <stddef.h>
#include <string.h>
#include "log_level.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define SLOGD_GLOBAL_TYPE_MASK        0U

// global level
void SlogdSetGlobalLevel(int32_t value, int32_t typeMask);
void SlogdSetEventLevel(int32_t value);
int32_t SlogdGetGlobalLevel(uint32_t typeMask);
int32_t SlogdGetEventLevel(void);

// module level
bool IsMultipleModule(int32_t moduleId);
bool SlogdSetModuleLevel(int32_t moduleId, int32_t value, int32_t typeMask);
bool SlogdSetModuleLevelByDevId(int32_t devId, int32_t moduleId, int32_t value, int32_t typeMask);
int32_t SlogdGetModuleLevel(int32_t moduleId, uint32_t typeMask);
int32_t SlogdGetModuleLevelByDevId(int32_t devId, int32_t moduleId, uint32_t typeMask);

const ModuleInfo *GetModuleInfos(void);
const char *GetModuleNameById(int32_t moduleId);
const ModuleInfo *GetModuleInfoByName(const char *name);
const ModuleInfo *GetModuleInfoById(int32_t moduleId);

// level info
int32_t GetLevelIdByName(const char *name);
const char *GetLevelNameById(int64_t level);
const char *GetBasicLevelNameById(int32_t level);

// group info
void SetGroupIdToUninitModule(int32_t id);
void SetGroupIdToAllModule(int32_t id);
bool SetGroupIdByModuleId(int32_t moduleId, int32_t value);
int32_t GetGroupIdByModuleId(int32_t moduleId);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif