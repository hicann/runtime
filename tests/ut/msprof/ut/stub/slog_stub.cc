/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slog.h"
#include <map>
#include <cstdio>
#include <string>
#include <unistd.h>

const std::map<int, std::string> LOG_LEVEL_INFO = {
    {DLOG_DEBUG, "DEBUG"},
    {DLOG_INFO,  "INFO"},
    {DLOG_WARN,  "WARING"},
    {DLOG_ERROR, "ERROR"},
    {DLOG_EVENT, "EVENT"},
};

int g_log_level = DLOG_INFO;

void DlogErrorInner(int moduleId, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[ERROR][pid:%d]%s", getpid(), buffer);
    va_end(args);
}

void DlogInfoInner(int moduleId, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[INFO][pid:%d]%s", getpid(), buffer);
    va_end(args);
}

void DlogWarnInner(int moduleId, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[WARN][pid:%d]%s", getpid(), buffer);
    va_end(args);
}

void DlogDebugInner(int moduleId, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[DEBUG][pid:%d]%s", getpid(), buffer);
    va_end(args);
}

void DlogRecord(int module_id, int level, const char *fmt, ...){
    if (level < g_log_level) {
        return;
    }
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

void ide_log(int priority, const char *format, ...) {
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("%s", buffer);
    va_end(args);
}

void RecordLog(int level, char *buffer)
{
    return;
}

void DlogInnerForC(int moduleId, int level, const char *fmt, ...)
{
    va_list args;

    char buffer[4096] = {0};

    va_start(args, fmt);
    vsnprintf(buffer, sizeof(buffer), fmt, args);
    auto iter = LOG_LEVEL_INFO.find(level);
    std::string levelStr;

    if(iter != LOG_LEVEL_INFO.end())
    {
        levelStr = iter->second;
    }
    RecordLog(level, buffer);
    printf("[%s][pid:%d]%s", levelStr.c_str(), getpid(), buffer);
    va_end(args);

}

void DlogRecordForC(int moduleId, int level, const char *fmt, ...)
{
    va_list args;

    char buffer[4096] = {0};

    va_start(args, fmt);
    vsnprintf(buffer, sizeof(buffer), fmt, args);
    auto iter = LOG_LEVEL_INFO.find(level);
    std::string levelStr;

    if(iter != LOG_LEVEL_INFO.end())
    {
        levelStr = iter->second;
    }
    RecordLog(level, buffer);
    printf("[%s][pid:%d]%s", levelStr.c_str(), getpid(), buffer);
    va_end(args);
}

void DlogFlush(void)
{
}

int CheckLogLevelForC(int moduleId, int level)
{
    if (moduleId & RUN_LOG_MASK) {
        return 1;
    }
    if (level >= g_log_level) {
        return 1;
    }
    return 0;
}

int CheckLogLevel(int moduleId, int level)
{
    if (moduleId & RUN_LOG_MASK) {
        return 1;
    }
    if (level >= g_log_level) {
        return 1;
    }
    return 0;
}
