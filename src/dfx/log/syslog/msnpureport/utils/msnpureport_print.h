/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSNPUREPORT_PRINT_H
#define MSNPUREPORT_PRINT_H

#include <stdio.h>
#include <stdint.h>
#include <sys/syslog.h>
#include <sys/syscall.h>

#define PRINT_SYSLOG 0
#define PRINT_STDOUT 1
#define INVALID_PRINT_MODE -1
#define LOG_LEVEL_ERROR_STR "error"
#define LOG_LEVEL_WARNING_STR "warning"
#define LOG_LEVEL_INFO_STR "info"
#define LOG_LEVEL_DEBUG_STR "debug"
#define SYSLOG_MAX_LEVEL (LOG_DEBUG + 1)

#ifdef __cplusplus
extern "C" {
#endif

#define MSNPU_FPRINTF(format, ...) do {                                                     \
    (void)fprintf(stdout, "%s " format, MsnpuGetLocalTimeForLog(), ##__VA_ARGS__);          \
    (void)fflush(stdout);                                                                   \
} while (0)

#define MSNPU_INF(msg, ...)     MSNPU_FPRINTF("[MSNPUREPORT][INFO] " msg "\n", ##__VA_ARGS__)
#define MSNPU_WAR(msg, ...)     MSNPU_FPRINTF("[MSNPUREPORT][WARNING] " msg "\n", ##__VA_ARGS__)
#define MSNPU_ERR(msg, ...)     MSNPU_FPRINTF("[MSNPUREPORT][ERROR] " msg "\n", ##__VA_ARGS__)
#define MSNPU_DBG(msg, ...)     MSNPU_FPRINTF("[MSNPUREPORT][DEBUG] " msg "\n", ##__VA_ARGS__)

#define MSNPU_CHK_NULL_PTR(PTR, ACTION) do {                            \
    if ((PTR) == NULL) {                                                \
        MSNPU_ERR("Invalid ptr parameter [" #PTR "](NULL).");           \
        ACTION;                                                         \
    }                                                                   \
} while (0)

#define MSNPU_CHK_EXPR_ACT(expr, ACTION) do {                           \
    if (expr) {                                                         \
        ACTION;                                                         \
    }                                                                   \
} while (0)

#define MSNPU_CHK_EXPR_CTRL(expr, ACTION, msg, ...) do {                \
    if (expr) {                                                         \
        MSNPU_ERR(msg, ##__VA_ARGS__);                                  \
        ACTION;                                                         \
    }                                                                   \
} while (0)

const char *MsnpuGetLocalTimeForLog(void);

#define MSNPU_PRINT(format, ...) do {                           \
    (void)fprintf(stdout, format "\n", ##__VA_ARGS__);          \
    (void)fflush(stdout);                                       \
} while (0)

#define MSNPU_PRINT_ERROR(format, ...) do {                           \
    (void)fprintf(stdout, "ERROR: " format "\n", ##__VA_ARGS__);      \
    (void)fflush(stdout);                                             \
} while (0)

#define SELF_LOG_DEBUG(format, ...) do {                                        \
    if (MsnPrintGetLogLevel() >= LOG_DEBUG) {                                   \
        if (MsnGetLogPrintMode() == PRINT_SYSLOG) {                             \
            syslog(LOG_DEBUG, "[tid:%ld] %s:%d: " format "\n",                  \
                   syscall(SYS_gettid), __FILE__, __LINE__, ##__VA_ARGS__);     \
        } else {                                                                \
            MSNPU_FPRINTF("[MSNPUREPORT][DEBUG] "format "\n", ##__VA_ARGS__);   \
        }                                                                       \
    }                                                                           \
} while(0)

#define SELF_LOG_INFO(format, ...) do {                                         \
    if (MsnPrintGetLogLevel() >= LOG_INFO) {                                    \
        if (MsnGetLogPrintMode() == PRINT_SYSLOG) {                             \
            syslog(LOG_INFO, "[tid:%ld] %s:%d: " format "\n",                   \
                   syscall(SYS_gettid), __FILE__, __LINE__, ##__VA_ARGS__);     \
        } else {                                                                \
            MSNPU_FPRINTF("[MSNPUREPORT][INFO] "format "\n", ##__VA_ARGS__);    \
        }                                                                       \
    }                                                                           \
} while(0)

#define SELF_LOG_WARN(format, ...) do {                                         \
    if (MsnPrintGetLogLevel() >= LOG_WARNING) {                                 \
        if (MsnGetLogPrintMode() == PRINT_SYSLOG) {                             \
            syslog(LOG_WARNING, "[tid:%ld] %s:%d: " format "\n",                \
                   syscall(SYS_gettid), __FILE__, __LINE__, ##__VA_ARGS__);     \
        } else {                                                                \
            MSNPU_FPRINTF("[MSNPUREPORT][WARNING] "format "\n", ##__VA_ARGS__); \
        }                                                                       \
    }                                                                           \
} while(0)

#define SELF_LOG_ERROR(format, ...) do {                                        \
    if (MsnPrintGetLogLevel() >= LOG_ERR) {                                     \
        if (MsnGetLogPrintMode() == PRINT_SYSLOG) {                             \
            syslog(LOG_ERR, "[tid:%ld] %s:%d: " format "\n",                    \
                   syscall(SYS_gettid), __FILE__, __LINE__, ##__VA_ARGS__);     \
        } else {                                                                \
            MSNPU_FPRINTF("[MSNPUREPORT][ERROR] "format "\n", ##__VA_ARGS__);   \
        }                                                                       \
    }                                                                           \
} while(0)

#define NO_ACT_WARN_LOG(expr, fmt, ...)                         \
    if (expr) {                                                 \
        SELF_LOG_WARN(fmt, ##__VA_ARGS__);        \
    }                                                           \

#define ONE_ACT_INFO_LOG(expr, action, fmt, ...)                \
    if (expr) {                                                 \
        SELF_LOG_INFO(fmt, ##__VA_ARGS__);                      \
        action;                                                 \
    }                                                           \

#define ONE_ACT_WARN_LOG(expr, action, fmt, ...)                \
    if (expr) {                                                 \
        SELF_LOG_WARN(fmt, ##__VA_ARGS__);                      \
        action;                                                 \
    }                                                           \

#define ONE_ACT_ERR_LOG(expr, action, fmt, ...)                 \
    if (expr) {                                                 \
        SELF_LOG_ERROR(fmt, ##__VA_ARGS__);                     \
        action;                                                 \
    }                                                           \

#define TWO_ACT_ERR_LOG(expr, action1, action2, fmt, ...)       \
    if (expr) {                                                 \
        SELF_LOG_ERROR(fmt, ##__VA_ARGS__);       \
        action1;                                                \
        action2;                                                \
    }                                                           \

void MsnPrintInfo(uint16_t devId, char *info);
void MsnPrintSetLogLevel(int32_t level);
void MsnSetLogPrintMode(int32_t mode);
int32_t MsnPrintGetLogLevel(void);
int32_t MsnGetLogPrintMode(void);

#ifdef __cplusplus
}
#endif
#endif // MSNPUREPORT_PRINT_H