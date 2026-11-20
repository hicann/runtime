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
#include <stdlib.h>
#include <syslog.h>
#include <map>
#include <string>
#include <atomic>
#include "securec.h"

const std::map<int, std::string> LOG_LEVEL_INFO = {
    {DLOG_DEBUG, "DEBUG"}, {DLOG_INFO, "INFO"}, {DLOG_WARN, "WARING"}, {DLOG_ERROR, "ERROR"}, {DLOG_EVENT, "EVENT"},
};

static std::atomic<int32_t> g_dlogRecordCount{0};
static std::atomic<int32_t> g_dlogEventCount{0};

// 设置 UT_DLOG_SILENT=1 时关闭日志格式化与打印，降低外部压测工具复用本二进制时的日志噪声
static bool DlogSilent() { return getenv("UT_DLOG_SILENT") != nullptr; }

namespace {
constexpr int LOG_MSG_MAX = 4096;
char g_lastDlogRecordMsg[LOG_MSG_MAX] = {0};
char g_lastDlogEventMsg[LOG_MSG_MAX] = {0};
} // namespace

void ResetDlogRecordCount() { g_dlogRecordCount.store(0); }
int32_t GetDlogRecordCount() { return g_dlogRecordCount.load(); }
void ResetDlogEventCount() { g_dlogEventCount.store(0); }
int32_t GetDlogEventCount() { return g_dlogEventCount.load(); }

void ResetLastDlogRecordMsg() { g_lastDlogRecordMsg[0] = '\0'; }
void ResetLastDlogEventMsg() { g_lastDlogEventMsg[0] = '\0'; }

const char* GetLastDlogRecordMsg() { return g_lastDlogRecordMsg; }
const char* GetLastDlogEventMsg() { return g_lastDlogEventMsg; }

void DlogErrorInner(int moduleId, const char* format, ...)
{
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[ERROR]%s\n", buffer);
    va_end(args);
}

void DlogInfoInner(int moduleId, const char* format, ...)
{
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[INFO]%s\n", buffer);
    va_end(args);
}

void DlogWarnInner(int moduleId, const char* format, ...)
{
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[WARN]%s\n", buffer);
    va_end(args);
}

void DlogEventInner(int moduleId, const char* format, ...)
{
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[EVENT]%s\n", buffer);
    va_end(args);
}

void DlogDebugInner(int moduleId, const char* format, ...)
{
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[DEBUG]%s\n", buffer);
    va_end(args);
}

void DlogRecord(int module_id, int level, const char* fmt, ...)
{
    if (DlogSilent()) {
        return;
    }
    g_dlogRecordCount.fetch_add(1, std::memory_order_relaxed);
    auto iter = LOG_LEVEL_INFO.find(level);
    std::string levelStr;
    if (iter != LOG_LEVEL_INFO.end()) {
        levelStr = iter->second;
    }

    va_list args;
    char buffer[4096] = {0};
    va_start(args, fmt);
    vsnprintf(buffer, sizeof(buffer), fmt, args);
    int32_t ret =
        snprintf_s(g_lastDlogRecordMsg, sizeof(g_lastDlogRecordMsg), sizeof(g_lastDlogRecordMsg) - 1U, "%s", buffer);
    if (ret < 0) {
        g_lastDlogRecordMsg[0] = '\0';
    }
    // In the non-OSAL build, MSPROF_EVENT maps to dlog_info with RUN_LOG_MASK.
    if (level == DLOG_INFO && (static_cast<uint32_t>(module_id) & RUN_LOG_MASK) != 0U) {
        g_dlogEventCount.fetch_add(1, std::memory_order_relaxed);
        (void)snprintf_s(g_lastDlogEventMsg, sizeof(g_lastDlogEventMsg), sizeof(g_lastDlogEventMsg) - 1U, "%s", buffer);
    }
    printf("[%s][pid:%d]%s", levelStr.c_str(), getpid(), buffer);
    va_end(args);
}

void DlogFlush(void) {}

void ide_log(int priority, const char* format, ...)
{
    va_list args;

    char buffer[4096] = {0};

    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    printf("[IDE]%s\n", buffer);
    va_end(args);
}

int CheckLogLevel(int moduleId, int level) { return DlogSilent() ? 0 : 1; }
