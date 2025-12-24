/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef STACKCORE_COMMON_H
#define STACKCORE_COMMON_H
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/syslog.h>
#include "securec.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cpluscplus */

#ifdef LLT_TEST
#define STATIC
#else
#define STATIC              static
#endif

// stackcore file default path
#ifndef CORE_DEFAULT_PATH
#define CORE_DEFAULT_PATH   "/var/log/npu/coredump/"
#endif

#define STACK_OK                0
#define STACK_ERR               (-1)
#define STACK_ERROR             (-1)
#define STACK_INVALID_PARAM     (-2)

#define STACK_PATH_MAX_LEN 4096U // Max Length(4096 bytes)
#define STACK_LOG_MAX_LEN 1023

int32_t ToolGetErrorCode(void);
uint32_t LogStrlen(const char *str);
#ifdef STACKCORE_DEBUG
void StackSysLog(int32_t priority, const char *format, ...);

// print log to message : stackcore init and write file
#define LOGI(format, ...) do {                                                                  \
    StackSysLog(LOG_INFO, "[%s][%d][STACKCORE] %s:%d: " format "\n",                            \
                program_invocation_short_name, getpid(), __FILE__, __LINE__, ##__VA_ARGS__);    \
} while (0)

#define LOGW(format, ...) do {                                                                  \
    StackSysLog(LOG_WARNING, "[%s][%d][STACKCORE] %s:%d: " format "\n",                         \
                program_invocation_short_name, getpid(), __FILE__, __LINE__, ##__VA_ARGS__);    \
} while (0)

#define LOGE(format, ...) do {                                                                   \
    StackSysLog(LOG_ERR, "[%s][%d][STACKCORE] %s:%d: " format "\n",                              \
                program_invocation_short_name, getpid(), __FILE__, __LINE__, ##__VA_ARGS__);     \
} while (0)

#else

#define LOGI(format, ...) do {                              \
} while (0)

#define LOGW(format, ...) do {                              \
} while (0)

#define LOGE(format, ...) do {                              \
} while (0)

#endif

#define ONE_ACT_WARN(expr, action, fmt, ...)                \
    if (expr) {                                             \
        LOGW(fmt, ##__VA_ARGS__);        \
        action;                                             \
    }

#define ONE_ACT_ERR(expr, action, fmt, ...)                 \
    if (expr) {                                             \
        LOGE(fmt, ##__VA_ARGS__);                           \
        action;                                             \
    }

#define ONE_ACT_NO_LOG(expr, action)                            \
    if (expr) {                                                 \
        action;                                                 \
    }                                                           \                                                        \

#ifdef __cplusplus
}
#endif /* __cpluscplus */

#endif // STACKCORE_COMMON_H
