/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "trace_driver_api.h"
#include "ascend_hal.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "trace_load_library.h"

#define DRIVER_FUNCTION_NUM 2U
#define DRIVER_LIBRARY_NAME "libascend_hal.so"

STATIC ArgPtr g_libHandle = NULL;
STATIC SymbolInfo g_drvFuncInfo[DRIVER_FUNCTION_NUM] = {
    { "drvGetPlatformInfo", NULL },
    { "drvGetDevNum", NULL },
};

TraStatus TraceDriverInit(void)
{
    g_libHandle = TraceOpenLibrary(DRIVER_LIBRARY_NAME);
    ADIAG_CHK_EXPR_ACTION(g_libHandle == NULL, return TRACE_FAILURE,
        "dlopen library %s failed, strerr=%s.", DRIVER_LIBRARY_NAME, strerror(AdiagGetErrorCode()));

    TraStatus ret = TraceLoadFunc(g_libHandle, g_drvFuncInfo, DRIVER_FUNCTION_NUM);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return TRACE_FAILURE, "load function symbol failed, ret=%d.", ret);

    return TRACE_SUCCESS;
}

void TraceDriverExit(void)
{
    if (g_libHandle == NULL) {
        return;
    }
    if (TraceCloseLibrary(g_libHandle) != TRACE_SUCCESS) {
        ADIAG_WAR("can not dlclose library %s, strerr=%s.", DRIVER_LIBRARY_NAME, strerror(AdiagGetErrorCode()));
    }
}

typedef drvError_t (*DrvGetPlatformInfo)(uint32_t *);
TraStatus TraceDrvGetPlatformInfo(uint32_t *info)
{
    DrvGetPlatformInfo func = (DrvGetPlatformInfo)g_drvFuncInfo[0].handle;
    ADIAG_CHK_EXPR_ACTION(func == NULL, return TRACE_FAILURE, "can not find function\"%s\".", g_drvFuncInfo[0].symbol);

    drvError_t drvErr = func(info);
    ADIAG_CHK_EXPR_ACTION(drvErr != DRV_ERROR_NONE, return TRACE_FAILURE,
        "get platform info failed, drvErr=%d.", (int32_t)drvErr);

    return TRACE_SUCCESS;
}

typedef drvError_t (*DrvGetDevNum)(uint32_t *);
TraStatus TraceDrvGetDevNum(uint32_t *num)
{
    DrvGetDevNum func = (DrvGetDevNum)g_drvFuncInfo[1].handle;
    ADIAG_CHK_EXPR_ACTION(func == NULL, return TRACE_FAILURE, "can not find function\"%s\".", g_drvFuncInfo[1].symbol);

    drvError_t drvErr = func(num);

    if (drvErr == DRV_ERROR_NOT_SUPPORT) {
        return TRACE_FAILURE;
    }
    ADIAG_CHK_EXPR_ACTION(drvErr != DRV_ERROR_NONE, return TRACE_FAILURE,
        "get device num failed, drvErr=%d.", (int32_t)drvErr);

    return TRACE_SUCCESS;
}