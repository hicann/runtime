/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hdc-log-stub.h"
#include <unistd.h>
#include <stdio.h>
#include <stdarg.h>
#include <syslog.h>
#include <map>
#include <string>

const std::map<int, std::string> LOG_LEVEL_INFO = {
    {DLOG_DEBUG, "DEBUG"},
    {DLOG_INFO,  "INFO"},
    {DLOG_WARN,  "WARING"},
    {DLOG_ERROR, "ERROR"},
    {DLOG_EVENT, "EVENT"},
};

void DlogErrorInner(int moduleId, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[ERROR]%s\n", buffer);
    va_end(args);
}

void DlogInfoInner(int moduleId, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[INFO]%s\n", buffer);
    va_end(args);
}

void DlogWarnInner(int moduleId, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[WARN]%s\n", buffer);
    va_end(args);
}

void DlogEventInner(int moduleId, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[EVENT]%s\n", buffer);
    va_end(args);
}

void DlogDebugInner(int moduleId, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[DEBUG]%s\n", buffer);
    va_end(args);
}

void DlogRecord(int module_id, int level, const char *fmt, ...){
    auto iter = LOG_LEVEL_INFO.find(level);
    std::string levelStr;
    if (iter != LOG_LEVEL_INFO.end())
    {
        levelStr = iter->second;
    }

    va_list args;
    char buffer[4096] = {0};
    va_start(args, fmt);
    vsnprintf(buffer, sizeof(buffer), fmt, args);
    printf("[%s][pid:%d]%s", levelStr.c_str(), getpid(), buffer);
    va_end(args);
}

void DlogFlush(void)
{
}

void ide_log(int priority, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[IDE]%s\n", buffer);
    va_end(args);
}

int CheckLogLevel(int moduleId, int level)
{
    return 1;
}
