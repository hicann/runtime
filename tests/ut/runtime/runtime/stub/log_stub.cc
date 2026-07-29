/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "toolchain/slog.h"
#include "toolchain/plog.h"
#include "securec.h"
#include "base.hpp"
#include "runtime.hpp"
#include <mutex>
#define MAX_LOG_BUF_SIZE 2048
using namespace cce::runtime;

static const char* logLevel[] = {
    "DEBUG", "INFO", "WARNING", "ERR", "RESERVED",
};

int CheckLogLevel(int moduleId, int logLevel) { return 0; }

// 全局缓冲区：存储最近一条 DlogRecord 渲染后的完整日志行，供 UT 正则看护使用
// 多线程并发调用 DlogRecord 时通过 mutex 保护，避免数据竞争
std::string g_lastDlogRecordLine;
// 累积所有 DlogRecord 日志行，供 UT 搜索历史日志（g_lastDlogRecordLine 只保留最后一行会被覆盖）
std::string g_allDlogRecordLines;
static std::mutex g_dlogRecordMutex;
void ClearLastDlogRecordLine()
{
    const std::lock_guard<std::mutex> lock(g_dlogRecordMutex);
    g_lastDlogRecordLine.clear();
    g_allDlogRecordLines.clear();
}
bool DlogRecordContains(const std::string& keyword)
{
    const std::lock_guard<std::mutex> lock(g_dlogRecordMutex);
    return g_allDlogRecordLines.find(keyword) != std::string::npos;
}

void DlogRecord(int moduleId, int level, const char* fmt, ...)
{
    if (level < 0 || level > 4) {
        return;
    }

    char buf[MAX_LOG_BUF_SIZE] = {0};
    va_list arg;
    va_start(arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end(arg);

    {
        const std::lock_guard<std::mutex> lock(g_dlogRecordMutex);
        g_lastDlogRecordLine = std::string(buf);
        g_allDlogRecordLines += g_lastDlogRecordLine + "\n";
    }
    syslog(level, "%u %lu [%s]: %s\n", getpid(), syscall(SYS_gettid), logLevel[level], buf);
    if (level > 1) {
        printf("%u %lu [%s]: %s\n", getpid(), syscall(SYS_gettid), logLevel[level], buf);
    }

    return;
}

void DlogErrorInner(int module_id, const char* fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start(arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end(arg);

    syslog(RT_LOG_ERROR, "%u %lu [%s]: %s\n", getpid(), syscall(SYS_gettid), logLevel[RT_LOG_ERROR], buf);

    printf("%u %lu [%s]: %s\n", getpid(), syscall(SYS_gettid), logLevel[RT_LOG_ERROR], buf);
    return;
}

void DlogWarnInner(int module_id, const char* fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start(arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end(arg);

    syslog(RT_LOG_WARNING, "%u %lu [%s]: %s\n", getpid(), syscall(SYS_gettid), logLevel[RT_LOG_WARNING], buf);
    return;
}
void DlogInfoInner(int module_id, const char* fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start(arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end(arg);

    syslog(RT_LOG_INFO, "%u %lu [%s]: %s\n", getpid(), syscall(SYS_gettid), logLevel[RT_LOG_INFO], buf);
    return;
}
void DlogDebugInner(int module_id, const char* fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start(arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end(arg);

    /*syslog(RT_LOG_DEBUG, "%u %lu [%s]: %s\n",
           getpid(),syscall(SYS_gettid),logLevel[RT_LOG_DEBUG], buf);*/
    return;
}

void DlogEventInner(int module_id, const char* fmt, ...)
{
    char buf[MAX_LOG_BUF_SIZE] = {0};

    va_list arg;
    va_start(arg, fmt);
    vsnprintf(buf, MAX_LOG_BUF_SIZE, fmt, arg);
    va_end(arg);

    syslog(RT_LOG_EVENT, "%u %lu [%s]: %s\n", getpid(), syscall(SYS_gettid), logLevel[RT_LOG_EVENT], buf);
    return;
}

int dlog_getlevel(int module_id, int* enable_event)
{
    if (enable_event != nullptr) {
        *enable_event = true;
    }

    return 0;
}

int DlogReportStart(int devId, int mode) { return DRV_ERROR_NONE; }

void DlogReportStop(int devId) { return; }