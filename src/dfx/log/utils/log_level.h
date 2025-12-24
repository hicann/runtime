/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_LEVEL_H
#define LOG_LEVEL_H

#include <stdbool.h>
#include "log_error_code.h"
#include "log_config.h"
#include "slog.h"

#define LEVEL_NOTIFY_FILE "level_notify"
#define IOCTL_MODULE_NAME "module"

#define GLOABLE_DEFAULT_LOG_LEVEL           (DLOG_ERROR)
#define GLOABLE_DEFAULT_DEBUG_LOG_LEVEL     (DLOG_ERROR)
#define GLOABLE_DEFAULT_RUN_LOG_LEVEL       (DLOG_INFO)
#define GLOABLE_DEFAULT_STDOUT_LOG_LEVEL    (DLOG_DEBUG)
#define GLOABLE_DEFAULT_SECURITY_LOG_LEVEL  (DLOG_DEBUG)
#define MODULE_DEFAULT_LOG_LEVEL            (DLOG_ERROR)

#define MODULE_INIT_LOG_LEVEL   3
#define DEFAULT_GROUP_ID        0
#define INVAILD_GROUP_ID        (-1)
#define MAX_DEVICE_NUM          4 // the max device number of one OS

#define LOG_LEVEL_DEFAULT   0b00000001
#define LOG_LEVEL_SYNC      0b00000010
#define LOG_LEVEL_USER      0b00000100

// log level
enum { // use as constant
    LOG_LEVEL_DEBUG,
    LOG_LEVEL_INFO,
    LOG_LEVEL_WARN,
    LOG_LEVEL_ERROR,
    LOG_LEVEL_NULL,
    LOG_INVALID_LEVEL,
};

#define LOG_MIN_LEVEL       LOG_LEVEL_DEBUG
#define LOG_MAX_LEVEL       LOG_LEVEL_NULL

typedef struct {
    char configName[CONF_NAME_MAX_LEN + 1];
    int32_t configValue[INVLID_MOUDLE_ID];
} LogLevelConfInfo;

// log level type
typedef enum {
    LOGLEVEL_GLOBAL = 0,
    LOGLEVEL_MODULE,
    LOGLEVEL_EVENT
} LogLevelType;

typedef struct LogLevelCtrl {
    bool levelSetted;
    bool enableEvent;
    int8_t globalLogLevel;
    int32_t levelStatus;
} LogLevelCtrl;

#define DEFINE_LOG_LEVEL_CTRL(var)   LogLevelCtrl var = {   \
    false, true, GLOABLE_DEFAULT_LOG_LEVEL,           \
    LOG_LEVEL_DEFAULT       \
}

typedef struct TagModuleInfo {
    const char *moduleName;
    const int32_t moduleId;
    bool multiFlag;             // single or multiple module
    int8_t moduleLevel;         // use for single module
    int8_t moduleLevels[MAX_DEVICE_NUM]; // use for multiple module
    int32_t groupId;
} ModuleInfo;

// init for normal module
#define SINGL_MODULE_MAP(x, y) { #x, x, false, y, {-1, -1, -1, -1}, INVAILD_GROUP_ID }

// init for firmware module
#define MULTI_MODULE_MAP(x, y) { #x, x, true, -1, {y, y, y, y}, INVAILD_GROUP_ID }

// number id means discarded id, can be reused in the future
#define DEFINE_MODULE_LEVEL(var)   ModuleInfo (var)[INVLID_MOUDLE_ID + 1] = {  \
    SINGL_MODULE_MAP(SLOG, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(IDEDD, MODULE_INIT_LOG_LEVEL),         \
    SINGL_MODULE_MAP(SCC, MODULE_INIT_LOG_LEVEL),             \
    SINGL_MODULE_MAP(HCCL, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(FMK, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(CCU, MODULE_INIT_LOG_LEVEL),             \
    SINGL_MODULE_MAP(DVPP, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(RUNTIME, MODULE_INIT_LOG_LEVEL),       \
    SINGL_MODULE_MAP(CCE, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(HDC, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(DRV, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(NET, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(12, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(13, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(14, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(15, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(16, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(17, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(18, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(19, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(20, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(21, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(DEVMM, MODULE_INIT_LOG_LEVEL),         \
    SINGL_MODULE_MAP(KERNEL, MODULE_INIT_LOG_LEVEL),        \
    SINGL_MODULE_MAP(LIBMEDIA, MODULE_INIT_LOG_LEVEL),      \
    SINGL_MODULE_MAP(CCECPU, MODULE_INIT_LOG_LEVEL),        \
    SINGL_MODULE_MAP(26, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(ROS, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(HCCP, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(ROCE, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(TEFUSION, MODULE_INIT_LOG_LEVEL),      \
    SINGL_MODULE_MAP(PROFILING, MODULE_INIT_LOG_LEVEL),     \
    SINGL_MODULE_MAP(DP, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(APP, MODULE_INIT_LOG_LEVEL),           \
    MULTI_MODULE_MAP(TS, MODULE_INIT_LOG_LEVEL),            \
    MULTI_MODULE_MAP(TSDUMP, MODULE_INIT_LOG_LEVEL),        \
    SINGL_MODULE_MAP(AICPU, MODULE_INIT_LOG_LEVEL),         \
    MULTI_MODULE_MAP(LP, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(TDT, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(FE, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(MD, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(MB, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(ME, MODULE_INIT_LOG_LEVEL),            \
    MULTI_MODULE_MAP(IMU, MODULE_INIT_LOG_LEVEL),           \
    MULTI_MODULE_MAP(IMP, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(GE, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(46, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(CAMERA, MODULE_INIT_LOG_LEVEL),        \
    SINGL_MODULE_MAP(ASCENDCL, MODULE_INIT_LOG_LEVEL),      \
    SINGL_MODULE_MAP(TEEOS, MODULE_INIT_LOG_LEVEL),         \
    MULTI_MODULE_MAP(ISP, MODULE_INIT_LOG_LEVEL),           \
    MULTI_MODULE_MAP(SIS, MODULE_INIT_LOG_LEVEL),           \
    MULTI_MODULE_MAP(HSM, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(DSS, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(PROCMGR, MODULE_INIT_LOG_LEVEL),       \
    SINGL_MODULE_MAP(BBOX, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(AIVECTOR, MODULE_INIT_LOG_LEVEL),      \
    SINGL_MODULE_MAP(TBE, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(FV, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(59, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(TUNE, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(HSS, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(FFTS, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(OP, MODULE_INIT_LOG_LEVEL),            \
    SINGL_MODULE_MAP(UDF, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(HICAID, MODULE_INIT_LOG_LEVEL),        \
    SINGL_MODULE_MAP(TSYNC, MODULE_INIT_LOG_LEVEL),         \
    SINGL_MODULE_MAP(AUDIO, MODULE_INIT_LOG_LEVEL),         \
    SINGL_MODULE_MAP(TPRT, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(ASCENDCKERNEL, MODULE_INIT_LOG_LEVEL), \
    SINGL_MODULE_MAP(ASYS, MODULE_INIT_LOG_LEVEL),          \
    SINGL_MODULE_MAP(ATRACE, MODULE_INIT_LOG_LEVEL),        \
    MULTI_MODULE_MAP(RTC, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(SYSMONITOR, MODULE_INIT_LOG_LEVEL),    \
    SINGL_MODULE_MAP(AML, MODULE_INIT_LOG_LEVEL),           \
    SINGL_MODULE_MAP(ADETECT, MODULE_INIT_LOG_LEVEL),       \
    {NULL, -1, false, -1, {-1, -1, -1, -1}, -1}             \
}

typedef struct TagLevelInfo {
    const char *levelName;
    const int32_t levelId;
} LevelInfo;

#define DEFINE_LEVEL_TYPES(var)   LevelInfo var[] = {           \
    { "DEBUG",   DLOG_DEBUG },                                  \
    { "INFO",    DLOG_INFO  },                                  \
    { "WARNING", DLOG_WARN  },                                  \
    { "ERROR",   DLOG_ERROR },                                  \
    { "NULL",    DLOG_NULL  },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { NULL,      -1,        },                                  \
    { "EVENT",   DLOG_EVENT },                                  \
}

#endif
