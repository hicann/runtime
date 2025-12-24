/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_COLLECT_LOG_H
#define SLOGD_COLLECT_LOG_H

#include <limits.h>
#include "log_config_group.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct {
    char rootPath[PATH_MAX];
    char groupPath[PATH_MAX];
    char groupName[GROUP_MAP_SIZE][NAME_MAX];
} LogConfigInfo;

void SlogdStartCollectThread(void);
void SlogdCollectNotify(const char *path, uint32_t len);
void SlogdCollectThreadExit(void);
bool SlogdCheckCollectValid(const char *path, uint32_t len);
LogStatus SlogdGetLogPatterns(LogConfigInfo *info);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif