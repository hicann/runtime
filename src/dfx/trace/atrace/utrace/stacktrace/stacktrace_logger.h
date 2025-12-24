/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKTRACE_LOGGER_H
#define STACKTRACE_LOGGER_H

#include <stdarg.h>
#include <sys/syscall.h>
#include "securec.h"
#include "slog.h"
#include "atrace_types.h"
#include "stacktrace_common.h"
#include "adiag_utils.h"

#if defined _ADIAG_LLT_
#define STATIC
#define INLINE
#else
#define STATIC static
#define INLINE inline
#endif

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if defined _ADIAG_LLT_
#define DLOG_LEVEL DLOG_ERROR
#else
#define DLOG_LEVEL (DLOG_EVENT + 1)
#endif
#define LOG_BUFFER_SIZE 4096
static inline void TraceDlogInner(int level, const char *extendStr, const char *format, ...)
{
    if (level < DLOG_LEVEL) {
        return;
    }
    va_list args;
    char buffer[LOG_BUFFER_SIZE] = {0};
    va_start(args, format);
    if (vsnprintf_s(buffer, sizeof(buffer), sizeof(buffer), format, args) != -1) {
        (void)printf("%s%s\n", extendStr, buffer);
        (void)fflush(stdout);
    }
    va_end(args);
}

#define LOGI(format, ...) do {                                                          \
    TraceDlogInner(DLOG_INFO, "[INFO]", format,  ##__VA_ARGS__);                        \
} while (0)

#define LOGR(format, ...) do {                                                          \
    TraceDlogInner(DLOG_EVENT, "[RUN]", format,  ##__VA_ARGS__);                        \
} while (0)
 
#define LOGW(format, ...) do {                                                          \
    TraceDlogInner(DLOG_WARN, "[WARN] ", format,  ##__VA_ARGS__);                       \
} while (0)
 
#define LOGE(format, ...) do {                                                          \
    TraceDlogInner(DLOG_ERROR, "[ERROR] ", format,  ##__VA_ARGS__);                     \
} while (0)

#define STACK_CHK_EXPR_ACTION(expr, ACTION, msg, ...) do { \
    if (expr) { \
        LOGE(msg, ##__VA_ARGS__); \
        ACTION; \
    } \
} while (0)

#define STACKTRACE_LOG_TITLE_MAIN   "[main logcat]"
#define STACKTRACE_LOG_TITLE_SUB    "[sub logcat]"

void StacktraceLogSetPath(const char *path, const char *name);
void StackcoreLogSave(void);
void StacktraceLogInner(const char *format, ...);

TraStatus StacktraceLogInit(const char *title);
void StackcoreLogExit(void);


#define STACKTRACE_LOG_RUN(fmt, ...) do { \
    StacktraceLogInner("%lu(%ld): " fmt "\n", GetRealTime(), syscall(__NR_gettid), ##__VA_ARGS__);   \
} while (0)

#define STACKTRACE_LOG_ERR(fmt, ...) do { \
    StacktraceLogInner("%lu(%ld): [FAIL]" fmt "\n", GetRealTime(), syscall(__NR_gettid), ##__VA_ARGS__);   \
} while (0)

#ifdef __cplusplus
}
#endif // __cplusplus

#endif
