/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "osal_mem.h"
#include "securec.h"
OsalVoidPtr OsalMalloc(size_t size)
{
    if (size <= 0) {
        return NULL;
    }
    return malloc(size);
}

OsalVoidPtr OsalCalloc(size_t size)
{
    OsalVoidPtr val = NULL;
    val = OsalMalloc(size);
    if (val == NULL) {
        return NULL;
    }

    errno_t err = memset_s(val, size, 0, size);
    if (err != EOK) {
        OSAL_MEM_FREE(val);
        return NULL;
    }

    return val;
}

VOID OsalFree(OsalVoidPtr ptr)
{
    if (ptr != NULL) {
        free(ptr);
    }
}

VOID OsalConstFree(const void* ptr)
{
    if (ptr != NULL) {
        free(ptr);
    }
}