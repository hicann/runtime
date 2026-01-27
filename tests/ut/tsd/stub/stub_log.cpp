/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdint.h>
#include <stdlib.h>

#include "log_writer.h"

#include <stdarg.h>
#include <queue>
#include <string.h>
#include <cstdarg>
#include <cstdio>

#define RESERVERD_LENGTH 52

enum ELogLevel {
    LOG_LEVEL_DEBUG,
    LOG_LEVEL_INFO,
    LOG_LEVEL_WARN,
    LOG_LEVEL_ERROR,
    LOG_LEVEL_EVENT,
    LOG_LEVEL_OPLOG,
    LOG_LEVEL_TRACE
};

typedef enum {
    APPLICATION = 0,
    SYSTEM
} ProcessType;

typedef struct {
    ProcessType type;
    int pid;
    int deviceId;
    char reserved[RESERVERD_LENGTH];
} LogAttr;

typedef struct tagKV {
    char *kname;
    char *value;
} KeyValue;

#define LOG_THREAD_WRITE(logLevel)                  \
do {                                                            \
    char szInfo[Max_Trace_Len + 1];                             \
                                                                \
    va_list valist;                                             \
    memset(&valist, 0, sizeof(valist));                         \
    va_start(valist, fmt);                                      \
    vsnprintf(szInfo, Max_Trace_Len + 1, fmt, valist);          \
    va_end(valist);                                             \
                                                                \
    LogThread::addDebugLog(logLevel, module_id, szInfo);        \
} while (0)

#ifdef __cplusplus
extern "C" {
#endif

void dlog_init()
{
}

int  dlog_getlevel(int module_id, int* enable_event)
{
    return 2;
}

int CheckLogLevel(int moduleId, int logLevel)
{
    return 1;
}

void Dlog(int module_id,int level ,const char *fmt, ...)
{
    LOG_THREAD_WRITE(LOG_LEVEL_OPLOG);
}

void DlogWithKV(int module_id, int level, KeyValue *pstKVArray, int kvNum, const char *fmt, ...)
{
    LOG_THREAD_WRITE(LOG_LEVEL_TRACE);
}

void DlogErrorInner(int moduleId, const char *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    printf("[ERROR][TDT]");
    vprintf(fmt, args);
    printf("\n");
    va_end(args);
}

void DlogWarnInner(int moduleId, const char *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    printf("[WARN][TDT]");
    vprintf(fmt, args);
    printf("\n");
    va_end(args);
}

void DlogInfoInner(int moduleId, const char *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    printf("[INFO][TDT]");
    vprintf(fmt, args);
    printf("\n");
    va_end(args);
}

static const char *LOGLEVEL[] =
{
    "DEBUG",
    "INFO",
    "WARNING",
    "ERROR",
    "NULL",
};

void DlogWrite(int moduleId, int level, const char *fmt, ...)
{
    if(level >= 5) {
        return;
    }
    va_list args;
    va_start(args, fmt);
    printf("[%s][TDT]", LOGLEVEL[level]);
    vprintf(fmt, args);
    printf("\n");
    va_end(args);
}

void DlogRecord(int moduleId, int level, const char *fmt, ...)
{
    if(level >= 5) {
        return;
    }
    va_list args;
    va_start(args, fmt);
    printf("[%s][TDT]", LOGLEVEL[level]);
    vprintf(fmt, args);
    printf("\n");
    va_end(args);
}

void DlogDebugInner(int moduleId, const char *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    printf("[DEBUG][TDT]");
    vprintf(fmt, args);
    printf("\n");
    va_end(args);;
}

void DlogEventInner(int moduleId, const char *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    printf("[EVENT][TDT]");
    vprintf(fmt, args);
    printf("\n");
    va_end(args);;
}

void DlogInner(int moduleId, int level, const char *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    printf("[OPLOG][TDT]");
    vprintf(fmt, args);
    printf("\n");
    va_end(args);;
}

void DlogWithKVInner(int moduleId, int level, KeyValue *pstKVArray, int kvNum, const char *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    printf("[TRACE][TDT]");
    vprintf(fmt, args);
    printf("\n");
    va_end(args);;
}

int DlogSetAttr(LogAttr logAttr) {
    return 0;
}

int dlog_setlevel(int moduleId, int level, int enableEvent)
{
    return 0;
}

int setlogattr(int input)
{
    return 0;
}

void DlogFlush()
{
    
}
#ifdef __cplusplus
}
#endif
