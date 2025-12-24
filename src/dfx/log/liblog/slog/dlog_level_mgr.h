/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_LEVEL_MGR_H
#define LOG_LEVEL_MGR_H

#include <stdbool.h>
#include "log_error_code.h"
#include "log_level.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if !defined LOG_CPP && defined IAM
#define LEVEL_FILTER                 1
#else
#define LEVEL_FILTER                 0
#endif

#define DLOG_IAM_DEFAULT_LEVEL       (DLOG_INFO)
#define DLOG_GLOABLE_DEFAULT_LEVEL   (DLOG_ERROR)
#define DLOG_MODULE_DEFAULT_LEVEL    (DLOG_ERROR)
#define DLOG_DEBUG_DEFAULT_LEVEL     (DLOG_ERROR)
#define DLOG_RUN_DEFAULT_LEVEL       (DLOG_INFO)

#define DLOG_GLOBAL_TYPE_MASK        0U
// level ctrl
int32_t GetGlobalLogTypeLevelVar(uint32_t typeMask);
void SetGlobalLogTypeLevelVar(int32_t level, uint32_t typeMask);
bool GetGlobalEnableEventVar(void);
void SetGlobalEnableEventVar(bool enableEvent);
bool GetGlobalLevelSettedVar(void);
void SetGlobalLevelSettedVar(bool levelSetted);
int32_t GetLevelStatus(void);
void SetLevelStatus(int32_t levelStatus);

// module level
const ModuleInfo *DlogGetModuleInfos(void);
const char *DlogGetModuleNameById(uint32_t moduleId);
const ModuleInfo *DlogGetModuleInfoByName(const char *name);
bool DlogSetLogTypeLevelByModuleId(int32_t moduleId, int32_t level, uint32_t typeMask);
int32_t DlogGetLogTypeLevelByModuleId(uint32_t moduleId, uint32_t typeMask);
void DlogSetLogTypeLevelToAllModule(int32_t level, uint32_t typeMask);
int32_t DlogGetDebugLogLevelByModuleId(uint32_t moduleId);

// level info
const char *DlogGetLevelNameById(int32_t level);
const char *DlogGetBasicLevelNameById(int32_t level);

// level status
void DlogSetLevelStatus(bool levelStatus);
bool DlogGetLevelStatus(void);

void DlogLevelInit(void);
void DlogLevelReInit(void);
void DlogLevelInitByEnv(void);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif
