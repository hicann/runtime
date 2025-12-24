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
#include <cstdlib>
#include <cstdio>
#include <stdarg.h>
#include <string>
#include <map>

const std::map<int, std::string> LOG_LEVEL_INFO = {
    {DLOG_DEBUG, "DEBUG"},
    {DLOG_INFO,  "INFO"},
    {DLOG_WARN,  "WARING"},
    {DLOG_ERROR, "ERROR"},
    {DLOG_EVENT, "EVENT"},
};

static int g_logLevelStub = DLOG_INFO;

extern "C" int dlog_setlevel(int moduleId, int level, int enableEvent)
{
    (void) moduleId;
    (void) enableEvent;
    g_logLevelStub = level;
    return 0;
}

extern "C" int CheckLogLevel(int moduleId, int logLevel)
{
    return logLevel >= g_logLevelStub;
}

#define CHECK_LOG_FMT(format)   if (format == nullptr) { return; }

std::string FormatWithEndline(const char *fmt)
{
    std::string format(fmt);
    if (!format.empty() && format.back() != '\n') {
        format += '\n';
    }
    return format;
}

extern "C" void DlogDebugInner(int moduleId, const char *fmt, ...)
{
    CHECK_LOG_FMT(fmt);
    printf("[DEBUG] ");

    std::string format = FormatWithEndline(fmt);
    va_list args;
    va_start(args, format.c_str());
    vfprintf(stdout, format.c_str(), args);
    va_end(args);
    fflush(stdout);
}

extern "C" void DlogInfoInner(int moduleId, const char *fmt, ...)
{
    CHECK_LOG_FMT(fmt);
    printf("[INFO] ");

    std::string format = FormatWithEndline(fmt);
    va_list args;
    va_start(args, format.c_str());
    vfprintf(stdout, format.c_str(), args);
    va_end(args);
    fflush(stdout);
}

extern "C" void DlogWarnInner(int moduleId, const char *fmt, ...)
{
    CHECK_LOG_FMT(fmt);
    printf("[WARN] ");

    std::string format = FormatWithEndline(fmt);
    va_list args;
    va_start(args, format.c_str());
    vfprintf(stdout, format.c_str(), args);
    va_end(args);
    fflush(stdout);
}

extern "C" void DlogErrorInner(int moduleId, const char *fmt, ...)
{
    CHECK_LOG_FMT(fmt);
    printf("[ERROR] ");

    std::string format = FormatWithEndline(fmt);
    va_list args;
    va_start(args, format.c_str());
    vfprintf(stdout, format.c_str(), args);
    va_end(args);
    fflush(stdout);
}

extern "C" void DlogEventInner(int moduleId, const char *fmt, ...)
{
    CHECK_LOG_FMT(fmt);
    printf("[EVENT] ");

    std::string format = FormatWithEndline(fmt);
    va_list args;
    va_start(args, format.c_str());
    vfprintf(stdout, format.c_str(), args);
    va_end(args);
    fflush(stdout);
}

void DlogRecord(int moduleId, int level, const char *fmt, ...)
{
    if (level < g_logLevelStub) {
        return;
    }
    CHECK_LOG_FMT(fmt);
    auto iter = LOG_LEVEL_INFO.find(level);
    std::string levelStr;
    if (iter != LOG_LEVEL_INFO.end())
    {
        levelStr = iter->second;
    }
    printf("[%s] ", levelStr.c_str());

    std::string format = FormatWithEndline(fmt);
    va_list args;
    va_start(args, format.c_str());
    vfprintf(stdout, format.c_str(), args);
    va_end(args);
    fflush(stdout);
}

extern "C" void DlogFlush(void)
{
}