/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_CONFIG_COMMON_H
#define LOG_CONFIG_COMMON_H

#include <stdbool.h>
#include "log_error_code.h"
#include "log_system_api.h"
#include "log_common.h"
#include "log_config.h"

#define SYMBOL_NAME_MAX_LEN 127

#ifdef __cplusplus
extern "C" {
#endif

bool LogConfCheckPath(const char *ppath, size_t pathLen);
LogRt LogConfOpenFile(FILE **fp, const char *file);
LogRt LogConfParseLine(const char *lineBuf, char *confName, uint32_t nameLen, char *confValue, uint32_t valueLen);
LogRt GetSymbol(const char *buf, char *symbol, size_t symbolLen);
uint32_t LogConfGetDigit(const char *confName, const char *confValue,
    uint32_t minValue, uint32_t maxValue, uint32_t defaultValue);

static inline bool IsBlankline(char ch)
{
    return (ch == '#') || (ch == '\n') || (ch == '\r');
}

static inline bool IsBlank(char ch)
{
    return (ch == ' ') || (ch == '\t');
}

/**
* @brief IsBlockSymbol: check whether buf is the starting point of an unit
* @param [in] buf: line in slog.conf
* @return: TRUE/FALSE
*/
static inline bool IsBlockSymbol(const char* buf)
{
    const char *bracketFront = strchr(buf, '[');
    const char *bracketBack = strchr(buf, ']');
    if ((bracketFront == NULL) || (bracketBack == NULL)) {
        return false;
    }
    return true;
}

static inline bool IsEquation(const char* buf)
{
    return strchr(buf, '=') == NULL ? false : true;
}

#ifdef __cplusplus
}
#endif
#endif

