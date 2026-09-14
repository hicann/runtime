/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdint.h>
#include <stdbool.h>
#include "library_load.h"

bool g_stubLibLoadable = false;
int32_t g_stubLoadDllFuncRet = 0;
int32_t g_stubLoadDllFuncCallNum = 0;
int32_t g_stubUnloadCallNum = 0;

ArgPtr LoadRuntimeDll(const char* dllName)
{
    (void)dllName;
    return g_stubLibLoadable ? (ArgPtr)1 : NULL;
}

int32_t UnloadRuntimeDll(ArgPtr handle)
{
    g_stubUnloadCallNum++;
    return (handle == NULL) ? -1 : 0;
}

int32_t LoadDllFunc(ArgPtr handle, SymbolInfo* symbolInfos, uint32_t symbolNum)
{
    g_stubLoadDllFuncCallNum++;
    if ((handle == NULL) || (symbolInfos == NULL) || (symbolNum == 0)) {
        return -1;
    }
    return g_stubLoadDllFuncRet;
}

void* LoadDllFuncSingle(ArgPtr handle, const char* symbol)
{
    (void)handle;
    (void)symbol;
    return NULL;
}
