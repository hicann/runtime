/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_PRINT_H
#define LOG_PRINT_H
#include <inttypes.h>
#include "log_system_api.h"
#include "log_common.h"
#include "log_print_syslog.h"

#define GENERAL_PRINT_NUM 200U

#ifdef __cplusplus
extern "C" {
#endif

#define SYSLOG_WARN(format, ...)                                                                           \
    do {                                                                                                   \
            LogPrintSys(LOG_WARNING, "(%d)%s:%d: " format "\n", getpid(), __FILE__, __LINE__, ##__VA_ARGS__); \
    } while (0)

#define LOG_WARN_FPRINTF_ONCE(format, ...)                                                          \
    do {                                                                                            \
        static bool isFprintf = true;                                                               \
        if (__sync_lock_test_and_set(&isFprintf, false)) {                                          \
            (void)fprintf(stdout, "[LOG_WARNING] " format, ##__VA_ARGS__);                          \
        }                                                                                           \
    } while (0)
    
#ifdef WRITE_TO_SYSLOG
#define SELF_LOG_INFO(format, ...)                                                                         \
    do {                                                                                                   \
            LogPrintSys(LOG_INFO, "(%d)%s:%d: " format "\n", getpid(), __FILE__, __LINE__, ##__VA_ARGS__); \
    } while (0)

#define SELF_LOG_WARN(format, ...)                                                                            \
    do {                                                                                                      \
            LogPrintSys(LOG_WARNING, "(%d)%s:%d: " format "\n", getpid(), __FILE__, __LINE__, ##__VA_ARGS__); \
    } while (0)

#define SELF_LOG_ERROR(format, ...)                                                                         \
    do {                                                                                                    \
            LogPrintSys(LOG_ERR, "(%d)%s:%d: " format "\n", getpid(), __FILE__, __LINE__, ##__VA_ARGS__); \
    } while (0)

// Output warn selfLog every N times, ptrX point to x time to print
#define SELF_LOG_WARN_N(ptrX, N, format, ...)                                                                  \
    do {                                                                                                       \
            if (((*(ptrX)) == 0U) || ((*(ptrX)) >= N)) {                                                        \
                (*(ptrX)) = ((*(ptrX)) != 0U) ? 0U : ((*(ptrX)) + 1U);                                            \
                LogPrintSys(LOG_WARNING, "(%d)%s:%d: " format "\n", getpid(), __FILE__, __LINE__, ##__VA_ARGS__); \
            } else {                                                                                           \
                (*(ptrX)) = (*(ptrX)) + 1U;                                                                     \
            }                                                                                                  \
    } while (0)

// Output warn selfLog every N times, ptrX point to x time to print, ptrX may be accessed concurrently.
#define SELF_LOG_WARN_N_AO(ptrX, N, format, ...)                                                                  \
    do {                                                                                                       \
            if (((*(ptrX)) == 0) || ((*(ptrX)) >= N)) {                                                        \
                if (*(ptrX) != 0) {                                                                            \
                    (void)__sync_lock_test_and_set((ptrX), 0);                                                  \
                } else {                                                                                        \
                    (void)__sync_fetch_and_add((ptrX), 1);                                                 \
                }                                                                                               \
                LogPrintSys(LOG_WARNING, "(%d)%s:%d: " format "\n", getpid(), __FILE__, __LINE__, ##__VA_ARGS__); \
            } else {                                                                                           \
                (void)__sync_fetch_and_add((ptrX), 1);                                                         \
            }                                                                                                  \
    } while (0)

// Output error selfLog every N times, ptrX point to x time to print
#define SELF_LOG_ERROR_N(ptrX, N, format, ...)                                                                 \
    do {                                                                                                       \
            if (((*(ptrX)) == 0) || ((*(ptrX)) >= N)) {                                                        \
                (*(ptrX)) = ((*(ptrX)) != 0) ? 0 : ((*(ptrX)) + 1);                                            \
                LogPrintSys(LOG_ERR, "(%d)%s:%d: " format "\n", getpid(), __FILE__, __LINE__, ##__VA_ARGS__); \
            } else {                                                                                           \
                (*(ptrX)) = (*(ptrX)) + 1;                                                                     \
            }                                                                                                  \
    } while (0)
#else
void LogPrintSelf(const char *format, ...) __attribute__((format(printf, 1, 2)));

#define SELF_LOG_INFO(format, ...)                                                                         \
    do {                                                                                                   \
            LogPrintSelf("[INFO] %s:%d: " format "\n", __FILE__, __LINE__, ##__VA_ARGS__); \
    } while (0)

#define SELF_LOG_WARN(format, ...)                                                                              \
    do {                                                                                                        \
            LogPrintSelf("[WARNING] %s:%d: " format "\n", __FILE__, __LINE__, ##__VA_ARGS__);     \
    } while (0)

#define SELF_LOG_ERROR(format, ...)                                                                             \
    do {                                                                                                        \
            LogPrintSelf("[ERROR] %s:%d: " format "\n", __FILE__, __LINE__, ##__VA_ARGS__);       \
    } while (0)

// Output warn selfLog every N times, ptrX point to x time to print
#define SELF_LOG_WARN_N(ptrX, N, format, ...)                                                                   \
    do {                                                                                                        \
            if (((*(ptrX)) % (N)) == 0U) {                                                                 \
                LogPrintSelf("[WARNING] %s:%d: " format "\n", __FILE__, __LINE__, ##__VA_ARGS__); \
            }                                                                                                  \
            (*(ptrX)) = (*(ptrX)) + 1U;                                                                             \
    } while (0)

// Output error selfLog every N times, ptrX point to x time to print
#define SELF_LOG_ERROR_N(ptrX, N, format, ...)                                                                  \
    do {                                                                                                        \
            if (((*(ptrX)) % (N)) == 0U) {                                                                 \
                LogPrintSelf("[ERROR] %s:%d: " format "\n", __FILE__, __LINE__, ##__VA_ARGS__);   \
            }                                                                                                  \
            (*(ptrX)) = (*(ptrX)) + 1U;                                                                             \
    } while (0)
#endif

#define NO_ACT_WARN_LOG(expr, fmt, ...)                         \
    if (expr) {                                                 \
        SELF_LOG_WARN(fmt, ##__VA_ARGS__);        \
    }                                                           \

#define NO_ACT_ERR_LOG(expr, fmt, ...)                          \
    if (expr) {                                                 \
        SELF_LOG_ERROR(fmt, ##__VA_ARGS__);       \
    }                                                           \

// no do-while(0) because action maybe continue or break
#define ONE_ACT_NO_LOG(expr, action)                            \
    if (expr) {                                                 \
        action;                                                 \
    }                                                           \

#define ONE_ACT_INFO_LOG(expr, action, fmt, ...)                \
    if (expr) {                                                 \
        SELF_LOG_INFO(fmt, ##__VA_ARGS__);        \
        action;                                                 \
    }                                                           \

#define ONE_ACT_WARN_LOG(expr, action, fmt, ...)                \
    if (expr) {                                                 \
        SELF_LOG_WARN(fmt, ##__VA_ARGS__);        \
        action;                                                 \
    }                                                           \

#define ONE_ACT_ERR_LOG(expr, action, fmt, ...)                 \
    if (expr) {                                                 \
        SELF_LOG_ERROR(fmt, ##__VA_ARGS__);       \
        action;                                                 \
    }                                                           \

#define TWO_ACT_NO_LOG(expr, action1, action2)                  \
    if (expr) {                                                 \
        action1;                                                \
        action2;                                                \
    }                                                           \

#define TWO_ACT_INFO_LOG(expr, action1, action2, fmt, ...)      \
    if (expr) {                                                 \
        SELF_LOG_INFO(fmt, ##__VA_ARGS__);        \
        action1;                                                \
        action2;                                                \
    }                                                           \

#define TWO_ACT_WARN_LOG(expr, action1, action2, fmt, ...)      \
    if (expr) {                                                 \
        SELF_LOG_WARN(fmt, ##__VA_ARGS__);        \
        action1;                                                \
        action2;                                                \
    }                                                           \

#define TWO_ACT_ERR_LOG(expr, action1, action2, fmt, ...)       \
    if (expr) {                                                 \
        SELF_LOG_ERROR(fmt, ##__VA_ARGS__);       \
        action1;                                                \
        action2;                                                \
    }                                                           \

// prevent self log print if mutex is null by judge return value
#define LOCK_WARN_LOG(mutex) do {                                                   \
    if (ToolMutexLock((mutex)) == SYS_ERROR) {                                      \
        SELF_LOG_WARN("can not lock, strerr=%s", strerror(ToolGetErrorCode()));     \
    }                                                                               \
} while (0)                                                                         \

#define UNLOCK_WARN_LOG(mutex) do {                                                 \
    if (ToolMutexUnLock((mutex)) == SYS_ERROR) {                                    \
        SELF_LOG_WARN("can not unlock, strerr=%s", strerror(ToolGetErrorCode()));   \
    }                                                                               \
} while (0)                                                                         \

#ifdef __cplusplus
}
#endif
#endif  // PRINT_LOG_H
