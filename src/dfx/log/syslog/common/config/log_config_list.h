/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_CONFIG_LIST_H
#define LOG_CONFIG_LIST_H

#include <stdbool.h>
#include "log_config_common.h"
#include "log_error_code.h"
#include "log_system_api.h"
#include "log_common.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct TagConfList {
    char confName[CONF_NAME_MAX_LEN + 1];
    char confValue[CONF_VALUE_MAX_LEN + 1];
    struct TagConfList *next;
} ConfList;

typedef int32_t (*LogListFindFunc)(const Buff *, ArgPtr, bool);
int32_t LogConfListTraverse(const LogListFindFunc func, ArgPtr arg, bool isNewStyle);
LogRt LogConfListGetValue(const char *confName, uint32_t nameLen, char *confValue, uint32_t valueLen);
uint32_t LogConfListGetDigit(const char *confName, uint32_t minValue, uint32_t maxValue, uint32_t defaultValue);
LogRt LogConfListUpdate(const char *file);

LogRt LogConfListInit(const char *file);
void LogConfListFree(void);

#ifdef __cplusplus
}
#endif
#endif

