/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BASIC_LOGGER_LOGGER_H
#define BASIC_LOGGER_LOGGER_H

#include "osal/osal.h"
#include "slog.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MSPROF_MODULE_NAME PROFILING
#define MSPROF_LOGD(format, ...) do {                                                                      \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_DEBUG, "[DEBUG][%s:%d]" format "\n", __FILE__, __LINE__, ##__VA_ARGS__);  \
} while (0)
#define MSPROF_LOGI(format, ...) do {                                                                      \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_INFO, "[INFO][%s:%d]" format "\n", __FILE__, __LINE__, ##__VA_ARGS__);   \
} while (0)
#define MSPROF_LOGW(format, ...) do {                                                                      \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_WARN, "[WARNING][%s:%d]" format "\n", __FILE__, __LINE__, ##__VA_ARGS__);   \
} while (0)
#define MSPROF_LOGE(format, ...) do {                                                                      \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_ERROR, "[ERROR][%s:%d]" format "\n", __FILE__, __LINE__, ##__VA_ARGS__);  \
} while (0)
#define MSPROF_EVENT(format, ...) do {                                                                     \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_EVENT, "[EVENT][%s:%d]" format "\n", __FILE__, __LINE__, ##__VA_ARGS__);  \
} while (0)

#define PROF_CHK_EXPR_NO_ACTION(expr, msg, ...) do { \
    if (expr) { \
        MSPROF_LOGE(msg, ##__VA_ARGS__); \
    } \
} while (0)

#define PROF_CHK_EXPR_ACTION(expr, ACTION, msg, ...) do { \
    if (expr) { \
        MSPROF_LOGE(msg, ##__VA_ARGS__); \
        ACTION; \
    } \
} while (0)

#define PROF_CHK_EXPR_ACTION_TWICE(expr, ACTION, ACTION2, msg, ...) do { \
    if (expr) { \
        MSPROF_LOGE(msg, ##__VA_ARGS__); \
        ACTION; \
        ACTION2; \
    } \
} while (0)

#define PROF_CHK_EXPR_ACTION_NODO(expr, ACTION, msg, ...) \
    if (expr) { \
        MSPROF_LOGE(msg, ##__VA_ARGS__); \
        ACTION; \
    } \

#define PROF_CHK_WARN_ACTION(expr, ACTION, msg, ...) \
    if (expr) { \
        MSPROF_LOGW(msg, ##__VA_ARGS__); \
        ACTION; \
    } \

#define PROF_CHK_WARN_NO_ACTION(expr, msg, ...) do { \
    if (expr) { \
        MSPROF_LOGW(msg, ##__VA_ARGS__); \
    } \
} while (0)

#ifdef __cplusplus
}
#endif // __cplusplus

#endif  // BASIC_LOGGER_LOGGER_H
