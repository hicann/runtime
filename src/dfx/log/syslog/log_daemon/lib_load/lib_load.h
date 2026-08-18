/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LIB_LOAD_H
#define LIB_LOAD_H
#include "adcore_api.h"

#ifdef __cplusplus
extern "C" {
#endif

#define LIB_MAX_LENGTH_OF_NAME 128U

typedef struct LibLoadInfo {
    uint32_t magic;
    uint32_t version;
    uint32_t length;
    char name[LIB_MAX_LENGTH_OF_NAME]; // 加载so的名称
    uint8_t reserve[36];
} LibLoadInfo;

int32_t LibLoadServerInit(void);

int32_t LibLoadServerProcess(const CommHandle* handle, const void* value, uint32_t len);

int32_t LibLoadServerDestroy(void);

#ifdef __cplusplus
}
#endif
#endif