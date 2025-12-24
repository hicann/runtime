/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BASIC_OSAL_OSAL_MEM_H
#define BASIC_OSAL_OSAL_MEM_H
#include "osal.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cpluscplus

OsalVoidPtr OsalMalloc(size_t size);
OsalVoidPtr OsalCalloc(size_t size);
VOID OsalFree(OsalVoidPtr ptr);
VOID OsalConstFree(const void* ptr);

#define OSAL_MEM_FREE(ptr) do {  \
    OsalFree(ptr);               \
    (ptr) = NULL;                  \
} while (0)

#ifdef __cplusplus
}
#endif  // __cpluscplus
#endif