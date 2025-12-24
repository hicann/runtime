/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DLOG_COMMON_H
#define DLOG_COMMON_H
#include "log_system_api.h"
#include "log_file_util.h"
#include "share_mem.h"
#include "log_print.h"
#include "slog_api.h"

#ifdef __cplusplus
extern "C" {
#endif

#define WRITE_E_PRINT_NUM                   10000
#define FSTAT_E_PRINT_NUM                   2000
#define CONN_W_PRINT_NUM                    50000
#define EVENT_ENABLE_VALUE                  1
#define EVENT_DISABLE_VALUE                 0
#define TIME_LOOP_READ_CONFIG               1000
#define TIMESTAMP_LEN                       128
#define TIME_ONE_THOUSAND_MS                1000
#define LOG_WARN_INTERVAL                   (2 * 1000)          // 2s
#define LOG_INFO_INTERVAL                   (4 * 1000)          // 4s
#define LOG_CTRL_TOTAL_INTERVAL             (8 * 1000)          // 8s
#define WRITE_MAX_RETRY_TIMES               3
#define SIZE_TWO_MB                         (2 * 1024 * 1024)   // 2MB
#define MAX_MODULE_LOG_LEVEL_OPTION_LEN     (MAX_MODULE_NAME_LEN + MAX_MODULE_VALUE_LEN + 2)
#define MAX_ASCEND_MODULE_LOG_ENV_LEN       ((MAX_MODULE_LOG_LEVEL_OPTION_LEN) * 64)
#define MAX_MODULE_NUM                      64

typedef struct {
    const KeyValue *pstKVArray;
    int kvNum;
} KeyValueArg;

typedef enum {
    LOG_WRITE,
    LOG_FLUSH,
    LOG_FORK,
    LOG_ATFORK
} CallbackType;

#define ATFORK_PREPARE  0
#define ATFORK_PARENT   1
#define ATFORK_CHILD    2

typedef void (*ThreadAtFork)(void);
typedef int32_t (*DlogWriteCallback) (const char *, uint32_t, int32_t);
typedef void (*DlogFlushCallback) (void);
typedef void (*DlogForkCallback) (void);
typedef void (*DlogAtForkCallback) (int32_t);

typedef struct {
    DlogWriteCallback funcWrite;
    DlogFlushCallback funcFlush;
    DlogForkCallback funcFork;
    DlogAtForkCallback funcAtFork;
} DlogCallback;

int32_t RegisterCallback(const ArgPtr callback, const CallbackType funcType);

#if (OS_TYPE_DEF == LINUX)
extern char *__progname;
static inline const char *DlogGetPidName(void)
{
    return (__progname != NULL) ? __progname : "None";
}
#else
static inline const char *DlogGetPidName(void)
{
    return "None";
}
#endif

#ifdef __cplusplus
}
#endif
#endif
