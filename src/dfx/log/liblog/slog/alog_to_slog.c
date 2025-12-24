/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "alog_to_slog.h"
#include "library_load.h"
#include "log_print.h"
#include "ascend_hal.h"

#define DRV_HDC_LIBRARY_NAME "libascend_hal.so"
#define DRV_GET_PLATFORM_INFO "drvGetPlatformInfo"
typedef drvError_t (*DrvGetPlatformInfoFunc)(uint32_t *);
static ArgPtr g_drvLibHandle = NULL;

#ifdef PROCESS_LOG
int32_t AlogTryUseSlog(void)
{
    return AlogTransferToUnifiedlog();
}
#else
static bool IsAtDeviceSide(void)
{
    if (g_drvLibHandle == NULL) {
        g_drvLibHandle = LoadRuntimeDll(DRV_HDC_LIBRARY_NAME);
    }
    if (g_drvLibHandle == NULL) {
        return false;
    }
    ArgPtr drvGetPlatformInfoFunc = LoadDllFuncSingle(g_drvLibHandle, DRV_GET_PLATFORM_INFO);
    if (drvGetPlatformInfoFunc == NULL) {
        return false;
    }

    uint32_t platform = 0;
    drvError_t ret = ((DrvGetPlatformInfoFunc)drvGetPlatformInfoFunc)(&platform);
    ONE_ACT_ERR_LOG(ret != DRV_ERROR_NONE, return false, "get platform info failed, ret=%d.", (int32_t)ret);
    const uint32_t deviceSide = 0;
    return (platform == deviceSide);
}

/**
 * @brief        : alog at device will transfer to slog
 */
int32_t AlogTryUseSlog(void)
{
    if (IsAtDeviceSide()) {
        return AlogTransferToSlog();
    }
    return LOG_FAILURE;
}
#endif

void AlogCloseDrvLib(void)
{
    (void)UnloadRuntimeDll(g_drvLibHandle);
}