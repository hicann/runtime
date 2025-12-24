/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SYS_MONITOR_PRINT_H
#define SYS_MONITOR_PRINT_H

#include <sys/syscall.h>
#include "slog.h"

#define MONITOR_MODULE_NAME SYSMONITOR
#define MONITOR_LOGD(format, ...) do {                                                                  \
    dlog_debug(MONITOR_MODULE_NAME, "[tid:%d] " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);       \
} while (0)
#define MONITOR_LOGI(format, ...) do {                                                                  \
    dlog_info(MONITOR_MODULE_NAME, "[tid:%d] " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);        \
} while (0)

#define  MONITOR_LOGW(format, ...) do {                                                                 \
    dlog_warn(MONITOR_MODULE_NAME, "[tid:%d] " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);        \
} while (0)

#define  MONITOR_LOGE(format, ...) do {                                                                 \
    dlog_error(MONITOR_MODULE_NAME, "[tid:%d] " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);       \
} while (0)

#define  MONITOR_RUN(format, ...) do {                                                                           \
    dlog_info(MONITOR_MODULE_NAME | RUN_LOG_MASK, "[tid:%d] " format "\n", syscall(SYS_gettid), ##__VA_ARGS__);  \
} while (0)

#define NO_ACT_WARN_LOG(expr, fmt, ...)                         \
    if (expr) {                                                 \
        MONITOR_LOGW(fmt, ##__VA_ARGS__);                       \
    }                                                           \

#define ONE_ACT_NO_LOG(expr, action)                            \
    if (expr) {                                                 \
        action;                                                 \
    }                                                           \

#define ONE_ACT_INFO_LOG(expr, action, fmt, ...)                \
    if (expr) {                                                 \
        MONITOR_LOGI(fmt, ##__VA_ARGS__);                       \
        action;                                                 \
    }                                                           \

#define ONE_ACT_WARN_LOG(expr, action, fmt, ...)                \
    if (expr) {                                                 \
        MONITOR_LOGW(fmt, ##__VA_ARGS__);                       \
        action;                                                 \
    }                                                           \

#define ONE_ACT_ERR_LOG(expr, action, fmt, ...)                 \
    if (expr) {                                                 \
        MONITOR_LOGE(fmt, ##__VA_ARGS__);                       \
        action;                                                 \
    }                                                           \

#endif