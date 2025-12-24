/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "trace_load_library.h"
#include "adiag_print.h"
#include "trace_system_api.h"

/**
 * @brief       dlopen library
 * @param [in]  libPath:    library path
 * @return      handle
 */
ArgPtr TraceOpenLibrary(const char *libPath)
{
    if (libPath == NULL) {
        return NULL;
    }

    void *handle = TraceDlopen(libPath, RTLD_LAZY);
    if (handle == NULL) {
        return NULL;
    }

    return handle;
}

/**
 * @brief       dlclose library
 * @param [in]  handle:     library handle
 * @return      TraStatus
 */
TraStatus TraceCloseLibrary(ArgPtr handle)
{
    if (handle == NULL) {
        return TRACE_INVALID_PARAM;
    }

    if (TraceDlclose(handle) != 0) {
        return TRACE_FAILURE;
    }

    return TRACE_SUCCESS;
}

/**
 * @brief       load function symbol
 * @param [in]  handle:         library handle
 * @param [out] symbolInfos:    symbol info and handle
 * @param [in]  symbolNum:      symbol nums
 * @return      TraStatus
 */
TraStatus TraceLoadFunc(ArgPtr handle, SymbolInfo *symbolInfos, uint32_t symbolNum)
{
    if ((handle == NULL) || (symbolInfos == NULL) || (symbolNum == 0)) {
        return TRACE_INVALID_PARAM;
    }

    for (uint32_t i = 0; i < symbolNum; i++) {
        const char *symbol = symbolInfos[i].symbol;
        if (symbol == NULL) {
            continue;
        }
        void *value = TraceDlsym(handle, symbol);
        if (value == NULL) {
            ADIAG_WAR("can not find function\"%s\" symbol.", symbol);
            continue;
        }
        symbolInfos[i].handle = value;
    }

    return TRACE_SUCCESS;
}
