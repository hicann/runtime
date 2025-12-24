/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_COMMON_H
#define LOG_COMMON_H

#include <stdbool.h>
#include "log_error_code.h"
#include "log_system_api.h"
#include "slog.h"

#define INVALID (-1)
#define ONE_SECOND 1000U // 1 second
#define BASE_NUM 10

#define MAX_MODULE_VALUE_LEN                32
#define MAX_MODULE_NAME_LEN                 32 // the max length of module name

#define HOST_MAX_DEV_NUM    1024
#define DEVICE_MAX_DEV_NUM  64
#define GLOBAL_MAX_DEV_NUM  HOST_MAX_DEV_NUM
#define MAX_DEV_NUM         64
#define HOST_AI_DEVID       64

#define FILTER_OK 1
#define FILTER_NOK 0

// level setting result flag
#define LEVEL_SETTING_SUCCESS    "++OK++"
// level setting result message for user
#define SLOGD_ERROR_MSG                  "send message to slogd failed, maybe slogd has been stoped"
#define SLOGD_RCV_ERROR_MSG              "receive message from slogd failed, maybe slogd has been stoped"
#define SLOG_CONF_ERROR_MSG              "open file 'slog.conf' failed, maybe the file doesn't exist or path is error"
#define LEVEL_INFO_ERROR_MSG             "level infomtion is illegal"
#define UNKNOWN_ERROR_MSG                "unknown error, please check log file"
#define MALLOC_ERROR_MSG                 "malloc failed"
#define STR_COPY_ERROR_MSG               "str copy failed"
#define COMPUTE_POWER_GROUP              "multiple hosts use one device, prohibit operating log level"
#define VIRTUAL_ENV_NOT_SUPPORT_MSG      "not support in virtual env."

// log type
#define DEBUG_SYS_LOG_TYPE      0
#define SEC_SYS_LOG_TYPE        1
#define RUN_SYS_LOG_TYPE        2
#define EVENT_LOG_TYPE          3
#define FIRM_LOG_TYPE           4   // match with drv log, numbers before this cannot change order
#define GROUP_LOG_TYPE          5
#define DEBUG_APP_LOG_TYPE      6
#define SEC_APP_LOG_TYPE        7
#define RUN_APP_LOG_TYPE        8
#define LOG_TYPE_MAX_NUM        9

typedef enum {
    DEBUG_LOG = 0,
    SECURITY_LOG,
    RUN_LOG,
    LOG_TYPE_NUM
} LogType;

typedef struct {
    int appPid;
} FlushInfo;

#ifdef _CLOUD_DOCKER
#define OPERATE_MODE 0770
#else
#define OPERATE_MODE 0750
#endif

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define LOG_SIZEOF(type)   ((uint32_t)sizeof(type))
#define NUM_MIN(a, b) (((a) < (b)) ? (a) : (b))
#define NUM_MAX(a, b) (((a) > (b)) ? (a) : (b))

#define LOG_CLOSE_FD(fd) do {   \
    (void)ToolClose((fd));      \
    (fd) = -1;                  \
} while (0)

#define LOG_CLOSE_FILE(fp) do { \
    if ((fp) != NULL) {         \
        (void)fclose((fp));     \
        (fp) = NULL;            \
    }                           \
} while (0)

#define XFREE(ps) do {  \
    LogFree(ps);        \
    (ps) = NULL;        \
} while (0)

void *LogMalloc(size_t size);
void LogFree(void *buffer);

bool LogStrStartsWith(const char *str, const char *pattern);
LogStatus LogStrToInt(const char *str, int64_t *num);
LogStatus LogStrToUint(const char *str, uint32_t *num);
LogStatus LogStrToUlong(const char *str, uint64_t *num);
bool LogStrCheckNaturalNum(const char *str);
void LogStrTrimEnd(char *str, int32_t len);
uint32_t LogStrlen(const char *str);
int32_t StrcatDir(char *path, const char *filename, const char *dir, uint32_t maxlen);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif

