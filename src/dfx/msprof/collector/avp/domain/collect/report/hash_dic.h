/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_COLLECT_REPORT_HASH_DIC_H
#define DOMAIN_COLLECT_REPORT_HASH_DIC_H

#include <stdint.h>
#include <stdbool.h>
#include "osal/osal.h"

#ifdef __cplusplus
extern "C" {
#endif

#define INTEGER_NUMBER_TWO 2
#define INTEGER_NUMBER_THREE 3
#define INTEGER_NUMBER_TEN 10
#define QUEUE_BUFFER_SIZE 1024

typedef struct HashDataListNode {
    uint64_t hashId;
    CHAR *hashInfo;
    struct HashDataListNode *next;
} HashDataNode;

typedef struct {
    uint64_t size;
    HashDataNode *head;
} HashDataList;

int32_t HashDataInit(void);
uint64_t GeneratedHashId(const char *hashInfo);
void SaveHashData(bool isLastChunk);
void HashDataStop(void);
void HashDataUninit(void);

#ifdef __cplusplus
}
#endif
#endif