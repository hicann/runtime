/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_WRITE_LIMIT_H
#define SLOGD_WRITE_LIMIT_H
#include "log_common.h"
#include "log_time.h"

#ifdef __cplusplus
extern "C" {
#endif

#define WRITE_LIMIT_PERIOD_NUM 5U

typedef struct {
    bool isLimit; // true: limited ,false: free
    uint32_t totalSize; 
    uint32_t usedSize;
    uint32_t dropSize;
} PeriodConfig;

typedef struct {
    uint32_t periodIndex;
    uint32_t writeSpecification;
    struct {
        uint32_t totalSize;
        uint32_t usedSize;
    } sharedConfig;
    PeriodConfig periodConfig[WRITE_LIMIT_PERIOD_NUM];
    struct timespec startTime;
} WriteFileLimit;

LogStatus WriteFileLimitInit(WriteFileLimit **limit, int32_t type, uint32_t totalSize, uint32_t currSize);
void WriteFileLimitUnInit(WriteFileLimit **limit);
bool WriteFileLimitCheck(WriteFileLimit *limit, uint32_t dataLen, const char* label);

#ifdef __cplusplus
}
#endif
#endif /* SLOGD_WRITE_LIMIT_H */