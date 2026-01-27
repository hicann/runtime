/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_COLLECT_REPORT_START_TIME_H
#define DOMAIN_COLLECT_REPORT_START_TIME_H

#include <stdint.h>
#include <stdbool.h>
#include "osal/osal.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MAX_TIME_DATA_LENGTH 128
#define ITER_TIME_COUNT 5

typedef struct TimeListCollectorTag {
    uint64_t hostCntvctStart;
    uint64_t hostMonotonicStart;
    uint64_t hostCntvctDiff;
    uint64_t devMonotonic;
    uint64_t devCntvct;
} TimeListCollector;

typedef struct TimeDataTag {
    CHAR deviceData[MAX_TIME_DATA_LENGTH];
    CHAR hostData[MAX_TIME_DATA_LENGTH];
} TimeData;

int32_t CreateStartTimeFile(uint32_t deviceId);

#ifdef __cplusplus
}
#endif
#endif