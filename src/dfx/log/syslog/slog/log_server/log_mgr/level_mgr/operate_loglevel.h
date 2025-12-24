/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATE_LOGLEVEL_H
#define OPERATE_LOGLEVEL_H

#include <stdbool.h>
#include "log_error_code.h"
#include "log_system_api.h"
#include "msg_queue.h"
#include "slog.h"

#define LEVEL_ERR (-1) // level setting failed
#define SET_LOG_LEVEL_STR "SetLogLevel"
#define GET_LOG_LEVEL_STR "GetLogLevel"
#define GET_LOG_LEVEL_TABLE_FORMAT "GetLogLevelTableFormat"
#define EVENT_ENABLE "ENABLE"
#define EVENT_DISABLE "DISABLE"
#define MAX_LEVEL_STR_LEN 2048
#define LOG_EVENT_WRAP_NUM 4
#define EVENT_ENABLE_VALUE 1
#define EVENT_DISABLE_VALUE 0
#define CONFIG_NAME_MAX_LENGTH 1024
#define GLOBAL_ENABLE_MAX_LEN 8
#define SINGLE_MODULE_MAX_LEN 24

#ifdef __cplusplus
extern "C" {
#endif

LogStatus SlogdLevelInit(int32_t devId, int32_t level, bool isDocker);
void SlogdLevelExit(void);

void HandleLogLevelChange(bool setDlogFlag);
int InitModuleArrToShMem(void);
int32_t UpdateLevelToShMem(void);

#ifdef __cplusplus
}
#endif
#endif /* OPERATE_LOGLEVEL_H */

