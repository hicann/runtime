/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_FILE_INFO_H
#define LOG_FILE_INFO_H

#include "log_common.h"

// file length
#define MAX_NAME_HEAD_LEN       20U
#define MAX_FILENAME_LEN        64U
#define MAX_FILEDIR_LEN         CFG_LOGAGENT_PATH_MAX_LENGTH
#define MAX_FILEPATH_LEN        (MAX_FILEDIR_LEN + MAX_NAME_HEAD_LEN)
#define MAX_FULLPATH_LEN        (MAX_FILEPATH_LEN + MAX_FILENAME_LEN)

// file mode
#define LOG_FILE_RDWR_MODE 0640
#define LOG_FILE_ARCHIVE_MODE 0440

// file size
#define MAX_FILE_SIZE (100U * 1024U * 1024U)
#define MIN_FILE_SIZE (1024U * 1024U)
#define MAX_FILE_NUM 1000
#define MIN_FILE_NUM 1
#define HOST_APP_FILE_MIN_SIZE (512U * 1024U)
#define HOST_APP_FILE_MAX_SIZE (100U * 1024U * 1024U)

#define DEFAULT_MAX_NDEBUG_FILE_SIZE (10 * 1024 * 1024)
#define DEFAULT_MAX_NDEBUG_FILE_NUM 3

#define EVENT_FILE_SIZE (1U * 1024U * 1024U)
#define SECURITY_FILE_SIZE (1U * 1024U * 1024U)
#define SECURITY_FILE_NUM 2U

#define LOG_OUTPUT_MAX_FILE_SIZE        (100U * 1024U * 1024U)
#define LOG_OUTPUT_MIN_FILE_SIZE        (512U * 1024U)
#define LOG_OUTPUT_DEFAULT_FILE_SIZE    (1024U * 1024U)

#define LOG_OUTPUT_MAX_FILE_NUM         1000
#define LOG_OUTPUT_MIN_FILE_NUM         1
#define LOG_OUTPUT_DEFAULT_FILE_NUM     8

#if defined(RC_MODE)
#define DEFAULT_MAX_APP_FILE_SIZE (1 * 1024 * 1024)
#define DEFAULT_MAX_APP_FILE_NUM 3
#define EVENT_FILE_NUM 4U
#else
#define DEFAULT_MAX_APP_FILE_SIZE (512 * 1024)
#define DEFAULT_MAX_APP_FILE_NUM 2
#define EVENT_FILE_NUM 2U
#endif

#ifdef IAM
#define DEFAULT_MAX_FILE_SIZE (10 * 1024 * 1024)
#define DEFAULT_MAX_OS_FILE_SIZE (10 * 1024 * 1024)
#define DEFAULT_MAX_FILE_NUM 8
#define DEFAULT_MAX_OS_FILE_NUM 8
#else
#define DEFAULT_MAX_FILE_SIZE (2 * 1024 * 1024)
#define DEFAULT_MAX_OS_FILE_SIZE (2 * 1024 * 1024)
#define DEFAULT_MAX_FILE_NUM 10
#define DEFAULT_MAX_OS_FILE_NUM 3
#endif

#define ONE_MEGABYTE (1U * 1024U * 1024U)
#ifdef DRIVER_STATIC_BUFFER
#define DEFAULT_OS_RUN_FILE_NUM     3U
#define DEFAULT_OS_RUN_FILE_SIZE    ONE_MEGABYTE
#define DEFAULT_OS_DEBUG_FILE_NUM   3U
#define DEFAULT_OS_DEBUG_FILE_SIZE  ONE_MEGABYTE
#define DEFAULT_FIRM_FILE_NUM       20U
#define DEFAULT_FIRM_FILE_SIZE      ONE_MEGABYTE
#endif

#define CFG_LOGAGENT_PATH_MAX_LENGTH    255U
#define CFG_WORKSPACE_PATH_MAX_LENGTH   64U
#define WORKSPACE_FILE_MAX_LENGTH       32U
#define WORKSPACE_PATH_MAX_LENGTH       (CFG_WORKSPACE_PATH_MAX_LENGTH + WORKSPACE_FILE_MAX_LENGTH)

// file name
#define RUN_DIR_NAME        "run"
#define DEBUG_DIR_NAME      "debug"
#define SECURITY_DIR_NAME   "security"
#define SLOGD_LOG_FILE      "/slogdlog"
#define SLOGD_LOG_OLD_FILE  "/slogdlog.old"

#define DEVICE_HEAD                   "device-"
#define EVENT_DIR_NAME                "event"
#define EVENT_HEAD                    "event"
#define LOG_FILE_SUFFIX               ".log"
#define LOG_ACTIVE_FILE_GZ_SUFFIX     "_act.log.gz"
#define LOG_ACTIVE_STR                "_act"

#define DEVICE_APP_HEAD                      "device-app"
#define AOS_CORE_DEVICE_APP_HEAD             "aos-core-app"
#define DEVICE_APP_DIR_NAME                  "device-app-all"
#define DEVICE_OS_HEAD                       "device-os"

#ifndef LOG_FILE_PATH
#if (OS_TYPE_DEF == LINUX)
    #ifdef IAM
        #define LOG_FILE_PATH "/home/mdc/var/log"
    #else
        #define LOG_FILE_PATH "/var/log/npu/slog"
    #endif
#else
    #define LOG_FILE_PATH "C:\\Program Files\\Huawei\\Ascend\\slog"
#endif
#endif

#if (OS_TYPE_DEF == LINUX)
    #define LOG_DIR_FOR_SELF_LOG "/slogd"
    #define SOCKET_FILE "/slog"
    #define CUST_SOCKET_FILE "/slog_app"
    #define PROCESS_SUB_LOG_PATH "ascend/log"
    #define OS_SPLIT '/'
    #define FILE_SEPARATOR "/"
#else
    #define PROCESS_SUB_LOG_PATH "alog"
    #define LOG_HOME_DIR ("C:\\Program Files\\Huawei\\Ascend")
    #define LOG_DIR_FOR_SELF_LOG "\\slogd"
    #define SOCKET_FILE "\\slog"
    #define CUST_SOCKET_FILE "\\slog_app"
    #define OS_SPLIT '\\'
    #define FILE_SEPARATOR "\\"
    #define EOK 0 /* no error */
    #define R_OK 0
    #define F_OK 0
    #define W_OK 0
    #define X_OK 0
#endif

typedef struct { // log data block paramter
    unsigned int ucDeviceID;
    unsigned int ulDataLen;
    char *paucData;
} StLogDataBlock;

#endif
