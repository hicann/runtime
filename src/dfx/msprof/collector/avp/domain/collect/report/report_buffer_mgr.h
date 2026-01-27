/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_COLLECT_REPORT_BUFFER_MANAGER_H
#define DOMAIN_COLLECT_REPORT_BUFFER_MANAGER_H

#include "toolchain/prof_api.h"
#include "transport/transport.h"
#include "osal/osal_thread.h"

#ifdef __cplusplus
extern "C" {
#endif

#define REPORT_API_INDEX           0
#define REPORT_COMPACT_INDEX       1
#define REPORT_ADDITIONAL_INDEX    2
#define REPORT_TYPE_MAX            3
#define UNAGING_INDEX              0
#define AGING_INDEX                1
#define AGING_MAX_INDEX            2
#define REPORT_NAME_LEN            12
#define AGING_TITLE_MAX_LENGTH     20
#define REPORT_BUFFER_MAX_CYCLES 512U
#define REPORT_BUFFER_MAX_BATCH 32U

typedef struct ReportBuffer {
    volatile int32_t wIndex;
    volatile int32_t rIndex;
    volatile int32_t idleWriteIndex;
    uint32_t mask;
    uint32_t capacity;
    uint8_t *avails;
    uint8_t *aging;
    void *buffer;
    OsalCond bufCond;
    OsalMutex bufMtx;
} ReportBuffer;

typedef struct ApiVectorTag {
    uint32_t ageFlag;
    uint32_t quantity;
    struct MsprofApi apiData[REPORT_BUFFER_MAX_BATCH];
} ApiVector;

typedef struct UnionVectorTag {
    uint16_t level;
    uint32_t typeId;
    uint32_t ageFlag;
    uint32_t quantity;
    char TypeName[MAX_FILE_CHUNK_NAME_LENGTH];
    union {
        struct MsprofCompactInfo compactData[REPORT_BUFFER_MAX_BATCH];
        struct MsprofAdditionalInfo additionalData[REPORT_BUFFER_MAX_BATCH];
    } typeInfo;
    struct UnionVectorTag *next;
} UnionVector;

typedef struct {
    uint32_t quantity;
    UnionVector *head;
} UnionList;

typedef struct {
    uint64_t totalPopCount;
    uint64_t totalPopSize;
    bool finishTag;
    OsalCond sizeCond;
    OsalMutex sizeMtx;
} SizeCount;

int32_t ReportInitialize(uint32_t length);
int32_t ReportStart(void);
int32_t ReportApiPush(uint8_t aging, const struct MsprofApi *data);
int32_t ReportCompactPush(uint8_t aging, const struct MsprofCompactInfo *data);
int32_t ReportAdditionalPush(uint8_t aging, const struct MsprofAdditionalInfo *data);
void ReportStop(void);
void ReportUninitialize(void);
void AddCompactNode(struct MsprofCompactInfo *data, uint8_t ageFlag);
void AddAdditionalNode(struct MsprofAdditionalInfo *data, uint8_t ageFlag);
void DumpApi(void);
void DumpCompact(void);
void DumpAdditional(void);
#ifdef __cplusplus
}
#endif
#endif