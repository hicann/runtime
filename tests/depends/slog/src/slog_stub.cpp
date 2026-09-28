/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dlog_pub.h"
#include "plog.h"

#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <securec.h>
#include "acl_stub.h"
#include "slog/inc/slog_stub_log_capture.h"

void dlog_init() {}

int aclStub::dlog_getlevel(int module_id, int* enable_event) { return DLOG_DEBUG; }

int dlog_getlevel(int module_id, int* enable_event)
{
    return MockFunctionTest::aclStubInstance().dlog_getlevel(module_id, enable_event);
}

namespace {
constexpr int LOG_MSG_MAX = 4096;
char g_lastLogMsg[LOG_MSG_MAX] = {0};
} // namespace

int g_logLevel = DLOG_ERROR;
void DlogRecord(int moduleId, int level, const char* fmt, ...)
{
    g_logLevel = level;
    va_list args;
    va_start(args, fmt);
    int ret = vsnprintf_s(g_lastLogMsg, sizeof(g_lastLogMsg), sizeof(g_lastLogMsg) - 1U, fmt, args);
    va_end(args);
    if (ret < 0) {
        g_lastLogMsg[0] = '\0';
    }
}

const char* DlogStubGetLastLogMsg() { return g_lastLogMsg; }

void DlogErrorInner(int module_id, const char* fmt, ...) {}

void DlogWarnInner(int module_id, const char* fmt, ...) {}

void DlogInfoInner(int module_id, const char* fmt, ...) {}

void DlogDebugInner(int module_id, const char* fmt, ...) {}

void DlogEventInner(int module_id, const char* fmt, ...) {}

int CheckLogLevel(int moduleId, int logLevel) { return 1; }

int DlogReportFinalize() { return 1; }

int DlogReportInitialize() { return 1; }
