/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdlib>
#include "adcore_api.h"

extern "C" {
int32_t g_adcoreReturnError = 0;

int32_t AdxRecvMsg(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    return 0;
}

int32_t AdxGetAttrByCommHandle(AdxCommConHandle handle, int32_t attr, int32_t *value)
{
    (void)handle;
    if (attr == 6) { // HDC_SESSION_ATTR_STATUS
        *value = 1; // connect
    } else if (attr == 2) { // HDC_SESSION_ATTR_RUN_ENV
        *value = 1; // NON_DOCKER
    } else {
        *value = 0;
    }
    return g_adcoreReturnError;
}

void AdxDestroyCommHandle(AdxCommHandle handle)
{
    if (handle != NULL) {
        free(handle);
    }
}

}