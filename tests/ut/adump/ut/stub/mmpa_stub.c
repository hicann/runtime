/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mmpa_api.h"

int mmWaitPid(mmProcess pid, int *status, int options)
{
    return EN_OK;
}
int mmCreateProcess(const char* fileName, const mmArgvEnv *env, const char* stdoutRedirectFile, mmProcess *id)
{
    return EN_OK;
}

INT32 mmGetEnv(const CHAR *name, CHAR *value, UINT32 len)
{
    INT32 result;
    UINT32 envLen = 0;
    CHAR *envPtr = NULL;
    if (name == NULL || value == NULL || len == 0) {
        return EN_INVALID_PARAM;
    }
    envPtr = getenv(name);
    if (envPtr == NULL) {
        return EN_ERROR;
    }

    UINT32 lenOfRet = (UINT32)strlen(envPtr);
    if( lenOfRet < (MMPA_MEM_MAX_LEN - 1)) {
        envLen = lenOfRet + 1;
    }

    if (envLen != 0 && len < envLen) {
        return EN_INVALID_PARAM;
    } else {
        result = memcpy_s(value, len, envPtr, envLen); //lint !e613
        if (result != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

INT32 mmGetTimeOfDay(mmTimeval *timeVal, mmTimezone *timeZone)
{
    if (timeVal == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = gettimeofday((struct timeval *)timeVal, (struct timezone *)timeZone);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}