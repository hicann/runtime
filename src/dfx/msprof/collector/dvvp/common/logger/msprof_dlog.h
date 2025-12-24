/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MSPROF_DLOG_H
#define MSPROF_DLOG_H

#include <sys/syscall.h>
#include <unistd.h>
#include <cstring>
#include "slog.h"

#if (defined(linux) || defined(__linux__))
#include <syslog.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define MSPROF_MODULE_NAME PROFILING
#define FILENAME (strrchr("/" __FILE__, '/') + 1)
#ifdef OSAL

#define MSPROF_EVENT(format, ...) do {                                                                     \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_EVENT, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__);  \
} while (0)
#define MSPROF_LOGE(format, ...) do {                                                                      \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_ERROR, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__);  \
} while (0)
#define MSPROF_LOGW(format, ...) do {                                                                      \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_WARN, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__);   \
} while (0)
#define MSPROF_LOGI(format, ...) do {                                                                      \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_INFO, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__);   \
} while (0)
#define MSPROF_LOGD(format, ...) do {                                                                      \
    DlogRecord(MSPROF_MODULE_NAME, DLOG_DEBUG, "[%s:%d]" format "\n", FILENAME, __LINE__, ##__VA_ARGS__);  \
} while (0)

#else

#define MSPROF_LOGD(format, ...) do {                                                                      \
    dlog_debug(MSPROF_MODULE_NAME, " (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);         \
} while (0)
#define MSPROF_LOGI(format, ...) do {                                                                      \
    dlog_info(MSPROF_MODULE_NAME, " (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);          \
} while (0)
#define MSPROF_LOGW(format, ...) do {                                                                      \
    dlog_warn(MSPROF_MODULE_NAME, " (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);          \
} while (0)
#define MSPROF_LOGE(format, ...) do {                                                                      \
    dlog_error(MSPROF_MODULE_NAME, " (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);         \
} while (0)
#define MSPROF_EVENT(format, ...) do {                                                                     \
    dlog_info(static_cast<int32_t>(static_cast<uint32_t>(MSPROF_MODULE_NAME) | RUN_LOG_MASK),              \
        " (tid:%ld) " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);                                    \
} while (0)

#endif

#ifdef __cplusplus
}
#endif

#endif  // MSPROF_LOG_H
