/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_CONFIG_API_H
#define LOG_CONFIG_API_H

#include <stdint.h>
#include "log_common.h"
#include "log_system_api.h"
#include "log_level.h"
#include "log_config_list.h"
#include "log_config_group.h"

#define SLOG_CONFIG_FILE_LENGTH 16
#define SLOG_CONF_PATH_MAX_LENGTH (TOOL_MAX_PATH + SLOG_CONFIG_FILE_LENGTH)
#define SLOG_CONFIG_FILE_SIZE (10 * 1024)
#define FILE_VERSION        0

#ifdef __cplusplus
extern "C" {
#endif

int32_t LogConfInit(void);
char *LogConfGetPath(void);

#ifdef __cplusplus
}
#endif
#endif
