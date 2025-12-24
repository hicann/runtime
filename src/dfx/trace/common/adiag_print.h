/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADIAG_PRINT_H
#define ADIAG_PRINT_H

#include <unistd.h>
#include <sys/syscall.h>
#include "slog.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if defined _ADIAG_LLT_
#define STATIC
#define INLINE
#define CONSTRUCTOR
#define DESTRUCTOR
#else
#define STATIC static
#define INLINE inline
#define CONSTRUCTOR __attribute__((constructor))
#define DESTRUCTOR __attribute__((destructor))
#endif

#define ADIAG_MODULE_NAME ATRACE

#define ADIAG_RUN_INF(msg, ...) Dlog((int32_t)((uint32_t)ADIAG_MODULE_NAME | RUN_LOG_MASK), DLOG_INFO, \
    "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)
#define ADIAG_ERR(msg, ...) \
    Dlog(ADIAG_MODULE_NAME, DLOG_ERROR, "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)
#define ADIAG_WAR(msg, ...) \
    Dlog(ADIAG_MODULE_NAME, DLOG_WARN, "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)
#define ADIAG_INF(msg, ...) \
    Dlog(ADIAG_MODULE_NAME, DLOG_INFO, "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)
#define ADIAG_DBG(msg, ...) \
    Dlog(ADIAG_MODULE_NAME, DLOG_DEBUG, "(tid:%ld) " msg "\n", syscall(SYS_gettid), ##__VA_ARGS__)

#define ADIAG_CHK_EXPR_ACTION(expr, ACTION, msg, ...) do { \
    if (expr) { \
        ADIAG_ERR(msg, ##__VA_ARGS__); \
        ACTION; \
    } \
} while (0)

#define ADIAG_CHK_NULL_PTR(PTR, ACTION) do { \
    if ((PTR) == NULL) { \
        ADIAG_ERR("invalid ptr parameter [" #PTR "](NULL)."); \
        ACTION; \
    } \
} while (0)

#ifdef __cplusplus
}
#endif // __cplusplus

#endif
