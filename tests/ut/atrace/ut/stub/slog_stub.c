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
#include <unistd.h>

int g_log_level = DLOG_WARN;

char *GetLevelString(int level)
{
    switch(level) {
        case DLOG_DEBUG:
            return "DEBUG";
        case DLOG_INFO:
            return "INFO";
        case DLOG_WARN:
            return "WARING";
        case DLOG_ERROR:
            return "ERROR";
        case DLOG_EVENT:
            return "EVENT";
    }
    return "";
}

void DlogRecord(int moduleId, int level, const char *fmt, ...)
{
    va_list args;
    char buffer[4096] = {0};
    va_start(args, fmt);
    vsnprintf(buffer, sizeof(buffer), fmt, args);
    printf("[%s][pid:%d]%s", GetLevelString(level), getpid(), buffer);
    va_end(args);
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
