/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_TRANSPORT_FLASH_TRANSPORT_H
#define DOMAIN_TRANSPORT_FLASH_TRANSPORT_H
#include "transport.h"
#include "errno/error_code.h"
#include "utils/utils.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MAX_DATA_FLASH_SIZE 20480U // 20k
#define MAX_CTRL_FLASH_SIZE 5120U  // 5k
#define MAX_INDEX_LENGTH 4U // max 1000 slice
#define MAX_INDEX_NUMBER 999U

typedef struct {
    uint16_t devIdx;
    uint16_t devFile;
} IndexAttribute;

int32_t FlashInitTransport(Transport* transport);
int32_t FlashSendBuffer(ProfFileChunk *chunk, const char* dir);

#ifdef __cplusplus
}
#endif
#endif