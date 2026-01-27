/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BASE_JSON_JSON_GENERATOR_H
#define BASE_JSON_JSON_GENERATOR_H
#include "json_parser.h"
#include "osal/osal.h"

#ifdef __cplusplus
extern "C" {
#endif

#define TRANSFER_BUFFER_LEN 32U

typedef struct {
    const char *json;
    CHAR *stack;
    size_t top;
    size_t size;
} JsonContext;

CHAR *JsonToString(const JsonObj *obj);

#ifdef __cplusplus
}
#endif
#endif