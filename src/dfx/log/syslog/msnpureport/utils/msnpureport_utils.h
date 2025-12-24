/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSNPUREPORT_UTILS_H
#define MSNPUREPORT_UTILS_H

#include <stdlib.h>
#include <stdbool.h>
#include "log_system_api.h"

#define MAX_DEV_NUM 64

#ifdef __cplusplus
extern "C" {
#endif

void *MsnMalloc(size_t size);
void MsnFree(void *buffer);
void MsnToUpper(char *str, uint32_t len);
bool MsnIsDockerEnv(void);
int32_t MsnGetDevIDs(uint32_t *devNum, uint32_t *idArray, uint32_t length);
int32_t MsnCheckDeviceId(uint32_t deviceId);
int32_t MsnGetDevMasterId(uint32_t devLogicId, uint32_t *phyId, int64_t *devMasterId);
int32_t MsnGetTimeStr(char *timeBuffer, uint32_t bufLen);
int32_t MsnMkdir(const char *path);
int32_t MsnMkdirMulti(const char *path);
bool MsnIsPoolEnv(void);

#ifdef __cplusplus
}
#endif
#endif