/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_CONFIG_GROUP_H
#define LOG_CONFIG_GROUP_H
#include <stdbool.h>
#include <stdint.h>
#include "log_config_common.h"
#include "slog.h"

#ifdef __cplusplus
extern "C" {
#endif

#define FULL_RATIO          100
#define GROUP_MAP_SIZE      (INVLID_MOUDLE_ID + 1)
#define GROUP_NAME_MAX_LEN  127
#define SLOG_AGENT_FILE_DIR 255

#define SLOG_DEFAULT_GROUP_NAME "device-os"
#define DEFAULT_LOG_SIZE (800 * 1024)
#define DEFAULT_BUF_SIZE 256
#define DEFAULT_FILE_DIR "/home/mdc/var/log/"

// slog module type
typedef enum {
    SLOGD, ALOG, PLOG, LOGDAEMON, MODULE_MAX
} SymbolEnum;

typedef struct {
    int isInit;
    int id;
    int isDefGroup;
    char name[GROUP_NAME_MAX_LEN + 1];
    int fileRatio;
    uint32_t totalMaxFileSize;
    char moduleStr[CONF_VALUE_MAX_LEN + 1];
    int fileSize;
    int moduleNum;
} UnitGroupInfo;

typedef struct {
    int maxSize;
    int bufSize;
    int allRatio;
    int defGroupId;
    char agentFileDir[SLOG_AGENT_FILE_DIR + 1];
    UnitGroupInfo map[GROUP_MAP_SIZE];
} GeneralGroupInfo;

typedef struct {
    int symbolE;
    const char *target[(int32_t)MODULE_MAX];
    int tNum;
} BlockSymbolInfo;

void LogConfGroupInit(const char *file);
const GeneralGroupInfo *LogConfGroupGetInfo(void);
bool LogConfGroupGetSwitch(void);
void LogConfGroupSetSwitch(bool enabled);


#ifdef __cplusplus
}
#endif
#endif

