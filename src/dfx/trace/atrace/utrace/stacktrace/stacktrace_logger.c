/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_logger.h"
#include <fcntl.h>
#include "trace_system_api.h"
#include "scd_util.h"

#define STACKTRACE_LOG_TITLE_SIZE   32U
#define STACKTRACE_LOG_MAX_NUM      200
#define STACKTRACE_LOG_SIZE         128U

#define AO_F_ADD(ptr, value)        ((__typeof__(*(ptr)))__sync_fetch_and_add((ptr), (value)))

typedef struct {
    char title[STACKTRACE_LOG_TITLE_SIZE];
    char path[SCD_MAX_FULLPATH_LEN + 1U];
    volatile int32_t logIndex;
    char logContent[STACKTRACE_LOG_MAX_NUM][STACKTRACE_LOG_SIZE];
} StacktraceLogMgr;

STATIC StacktraceLogMgr *g_stackLogMgr = NULL;

void StacktraceLogSetPath(const char *path, const char *name)
{
    if (g_stackLogMgr == NULL) {
        return;
    }
    if ((strstr(path, "../") != NULL) || (strstr(name, "../") != NULL)) {
        LOGE("file path [%s] or file name [%s] is not allowed", path, name);
        return;
    }
    int32_t ret = snprintf_s(g_stackLogMgr->path, SCD_MAX_FULLPATH_LEN + 1U, SCD_MAX_FULLPATH_LEN, "%s/%s.txt", path, name);
    if (ret == -1) {
        LOGE("snprintf_s file path failed");
        return;
    }
}

void StacktraceLogInner(const char *format, ...)
{
    if (g_stackLogMgr == NULL) {
        return;
    }
    int32_t writeIdx = AO_F_ADD(&g_stackLogMgr->logIndex, 1); 
    if (writeIdx >= STACKTRACE_LOG_MAX_NUM) {
       return;
    }

    va_list args;
    va_start(args, format);
    (void)vsnprintf_s(g_stackLogMgr->logContent[writeIdx], STACKTRACE_LOG_SIZE, STACKTRACE_LOG_SIZE, format, args) ;
    va_end(args);
}

void StackcoreLogSave(void)
{
    if (g_stackLogMgr == NULL) {
        return;
    }

    int32_t fd = TraceOpen(g_stackLogMgr->path, (uint32_t)O_CREAT | (uint32_t)O_RDWR | (uint32_t)O_APPEND, 0640);
    if (fd < 0) {
        LOGE("open log file \"%s\" failed, fd=%d.", g_stackLogMgr->path, fd);
        return;
    }

    ScdUtilWriteTitle(fd, g_stackLogMgr->title);
    int32_t logNum = g_stackLogMgr->logIndex;
    for (int32_t i = 0; i < logNum; i++) {
        (void)ScdUtilWrite(fd, g_stackLogMgr->logContent[i], strlen(g_stackLogMgr->logContent[i]));
    }
    ScdUtilWriteNewLine(fd);
    TraceClose(&fd);
}

TraStatus StacktraceLogInit(const char *title)
{
    g_stackLogMgr = AdiagMalloc(sizeof(StacktraceLogMgr));
    if (g_stackLogMgr == NULL) {
        LOGE("malloc for stacktrace log failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    errno_t err = strcpy_s(g_stackLogMgr->title, STACKTRACE_LOG_TITLE_SIZE, title);
    STACK_CHK_EXPR_ACTION(err != EOK, return TRACE_FAILURE,
        "strcpy_s failed, result=%d, strerr=%s.", (int32_t)err, strerror(AdiagGetErrorCode()));
    return TRACE_SUCCESS;
}

void StackcoreLogExit(void)
{
    if (g_stackLogMgr != NULL) {
        ADIAG_SAFE_FREE(g_stackLogMgr);
    }
}