/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CPU_DETECT_PRINT_H
#define CPU_DETECT_PRINT_H

#include <unistd.h>
#include <sys/syscall.h>
#include "securec.h"
#include "cpu_detect_types.h"
#include "slog.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if defined _CPU_DETECT_LLT_
#define STATIC
#define INLINE
#else
#define STATIC static
#define INLINE inline
#endif

#define ADETECT_RUN_INF(msg, ...) \
    Dlog((int32_t)((uint32_t)ADETECT | RUN_LOG_MASK), DLOG_INFO, \
    "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)
#define ADETECT_ERR(msg, ...) \
    Dlog(ADETECT, DLOG_ERROR, "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)
#define ADETECT_WAR(msg, ...) \
    Dlog(ADETECT, DLOG_WARN, "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)
#define ADETECT_INF(msg, ...) \
    Dlog(ADETECT, DLOG_INFO, "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)
#define ADETECT_DBG(msg, ...) \
    Dlog(ADETECT, DLOG_DEBUG, "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)

#define ADETECT_CHK_EXPR(expr, msg, ...) do { \
    if (expr) { \
        ADETECT_ERR(msg, ##__VA_ARGS__); \
    } \
} while (0)

#define ADETECT_CHK_EXPR_ACTION(expr, ACTION, msg, ...) do { \
    if (expr) { \
        ADETECT_ERR(msg, ##__VA_ARGS__); \
        ACTION; \
    } \
} while (0)

#define ADETECT_CHK_NULL_PTR(PTR, ACTION) do { \
    if ((PTR) == NULL) { \
        ADETECT_ERR("invalid ptr parameter [" #PTR "](NULL)."); \
        ACTION; \
    } \
} while (0)

#ifdef __cplusplus
}
#endif // __cplusplus

#endif
