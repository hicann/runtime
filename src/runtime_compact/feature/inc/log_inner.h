/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_C_FEATURE_LOG_INNER_H
#define RUNTIME_C_FEATURE_LOG_INNER_H

#include <stdlib.h>
#include <stdio.h>
#ifndef RUN_TEST
#include "toolchain/slog.h"
#endif
#include "error_manager.h"
#include "mmpa_api.h"
#if defined(__cplusplus)
extern "C" {
#endif

#define LIMIT_PER_MESSAGE 1024
#define RT_INVALID_ARGUMENT_ERROR "EE1001"
#define RT_INNER_ERROR "EE9999"
#define RT_DRV_INNER_ERROR "EL9999"
#define RT_GE_INNER_ERROR "EE8888"
#define RT_PROFILE_INNER_ERROR "EK9999"
#define RT_SYSTEM_INNER_ERROR "EE9999"

static inline int32_t GetTid(void)
{
    return (int32_t)(mmGetTaskId());
}
#ifdef RUN_TEST
#define RT_LOG_EVENT(format, ...)                                                                    \
    do {                                                                                             \
        printf("[EVENT][%s:%d]%d " #format "\n", __FILE__, __LINE__, GetTid(), ##__VA_ARGS__);       \
    } while (false)

#define RT_LOG_ERROR(format, ...)                                                                    \
    do {                                                                                             \
        printf("[ERROR][%s:%d]%d " #format "\n", __FILE__, __LINE__, GetTid(), ##__VA_ARGS__);       \
    } while (false)

#define RT_LOG_WARNING(format, ...)                                                                  \
    do {                                                                                             \
        printf("[WARNING][%s:%d]%d " #format "\n", __FILE__, __LINE__, GetTid(), ##__VA_ARGS__);     \
    } while (false)

#define RT_LOG_INFO(format, ...)                                                                     \
    do {                                                                                             \
        printf("[INFO][%s:%d]%d " #format "\n", __FILE__, __LINE__, GetTid(), ##__VA_ARGS__);        \
    } while (false)

#define RT_LOG_DEBUG(format, ...)                                                                    \
    do {                                                                                             \
        printf("[DEBUG][%s:%d]%d " #format "\n", __FILE__, __LINE__, GetTid(), ##__VA_ARGS__);       \
    } while (false)
#else
#define RT_LOG_EVENT(format, ...)                                                                    \
    do {                                                                                             \
        DlogRecord((int32_t)RUNTIME, DLOG_EVENT, "[Event][%s:%d]%d " format "\n", __FILE__, __LINE__, \
            GetTid(), ##__VA_ARGS__);                                                     \
    } while (false)

#define RT_LOG_ERROR(format, ...)                                                                    \
    do {                                                                                             \
        DlogRecord((int32_t)RUNTIME, DLOG_ERROR, "[ERROR][%s:%d]%d " format "\n", __FILE__, __LINE__, \
            GetTid(), ##__VA_ARGS__);                                                     \
    } while (false)

#define RT_LOG_WARNING(format, ...)                                                                   \
    do {                                                                                              \
        DlogRecord((int32_t)RUNTIME, DLOG_WARN, "[WARNING][%s:%d]%d " format "\n", __FILE__, __LINE__, \
            GetTid(), ##__VA_ARGS__);                                                      \
    } while (false)

#define RT_LOG_INFO(format, ...)                                                                     \
    do {                                                                                             \
        DlogRecord((int32_t)RUNTIME, DLOG_INFO, "[INFO][%s:%d]%d " format "\n", __FILE__, __LINE__,   \
            GetTid(), ##__VA_ARGS__);                                                      \
    } while (false)

#define RT_LOG_DEBUG(format, ...)                                                                    \
    do {                                                                                             \
        DlogRecord((int32_t)RUNTIME, DLOG_DEBUG, "[DEBUG][%s:%d]%d " format "\n", __FILE__, __LINE__, \
            GetTid(), ##__VA_ARGS__);                                                     \
    } while (false)
#endif

#if defined(__cplusplus)
}
#endif

#endif  // RUNTIME_C_FEATURE_LOG_INNER_H
