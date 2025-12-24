/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_CONFIG_BLOCK_H
#define LOG_CONFIG_BLOCK_H

#include "log_common.h"
#include "log_config.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    char inputClassify[CONF_VALUE_MAX_LEN];
} LogConfInputRule;

typedef struct {
    int32_t saveMode; // LOG_SAVE_FILE/LOG_SAVE_BUFFER
    uint32_t fileSize;
    uint32_t fileNum;
    uint32_t totalSize;
} LogConfOutputRule;

typedef struct {
    uint32_t storagePeriod;
} LogConfStorageRule;

typedef struct {
    char blockName[CONF_VALUE_MAX_LEN + 1];
    char className[CONF_VALUE_MAX_LEN + 1];
    int32_t logClassify;
    LogConfInputRule inputRule;
    LogConfOutputRule outputRule;
    LogConfStorageRule storageRule;
} LogConfClass;

void LogConfParseBlock(FILE *fp);
LogConfClass *LogConfGetClass(int32_t logType);

#ifdef __cplusplus
}
#endif
#endif