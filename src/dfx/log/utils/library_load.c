/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "library_load.h"
#include "log_print.h"

/**
 * @brief LoadRuntimeDll: load library
 * @param [in]dllName: library name
 * @return: library handle
 */
ArgPtr LoadRuntimeDll(const char *dllName)
{
    ONE_ACT_NO_LOG(dllName == NULL, return NULL);

#if (OS_TYPE_DEF == LINUX)
    ArgPtr handle = dlopen(dllName, RTLD_LAZY);
#else
    ArgPtr handle = LoadLibrary(dllName);
#endif
    if (handle == NULL) {
        SELF_LOG_WARN("load %s, strerr=%s.", dllName, strerror(ToolGetErrorCode()));
        return NULL;
    }
    return handle;
}

/**
 * @brief UnloadRuntimeDll: free library load handle
 * @param [in]handle: library handle
 * @return: 0: succeed, -1: failed
 */
int32_t UnloadRuntimeDll(ArgPtr handle)
{
    ONE_ACT_NO_LOG(handle == NULL, return -1);

#if (OS_TYPE_DEF == LINUX)
    ONE_ACT_NO_LOG(dlclose(handle) != 0, return -1);
#else
    ONE_ACT_NO_LOG(!FreeLibrary(handle), return -1);
#endif
    return 0;
}

/**
* @brief LoadDllFunc: find library symbols and load it
* @param [in]handle: library load handle
* @param [in]symbolInfos: symbol info and handle
* @param [in]symbolNum: symbol nums
* @return: On success, return 0
*     On failure, return -1
*/
int32_t LoadDllFunc(ArgPtr handle, SymbolInfo *symbolInfos, uint32_t symbolNum)
{
    ONE_ACT_NO_LOG((handle == NULL) || (symbolInfos == NULL), return -1);
    ONE_ACT_NO_LOG(symbolNum == 0, return -1);

    for (uint32_t i = 0; i < symbolNum; i++) {
        const char *symbol = symbolInfos[i].symbol;
        if (symbol == NULL) {
            continue;
        }
#if (OS_TYPE_DEF == LINUX)
        ArgPtr value = dlsym(handle, symbol);
#else
        ArgPtr value = GetProcAddress(handle, symbol);
#endif
        if (value == NULL) {
            SELF_LOG_INFO("can not find function %s symbol, strerr=%s.", symbol, strerror(ToolGetErrorCode()));
            continue;
        }
        symbolInfos[i].handle = value;
    }
    return 0;
}

/**
* @brief LoadDllFuncSingle: find one library symbol and load it
* @param [in]handle: library load handle
* @param [in]symbol: function name
* @return: On success, return the address associated with symbol
*     On failure, return NULL
*/
ArgPtr LoadDllFuncSingle(ArgPtr handle, const char *symbol)
{
    ONE_ACT_NO_LOG((handle == NULL) || (symbol == NULL), return NULL);

#if (OS_TYPE_DEF == LINUX)
    ArgPtr function = dlsym(handle, symbol);
#else
    ArgPtr function = GetProcAddress(handle, symbol);
#endif
    if (function == NULL) {
        SELF_LOG_WARN("can not find function %s symbol, strerr=%s.", symbol, strerror(ToolGetErrorCode()));
    }
    return function;
}
