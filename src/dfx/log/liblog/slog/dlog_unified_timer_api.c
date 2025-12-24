/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlog_unified_timer_api.h"
#include "library_load.h"
#include "log_print.h"

// timer library
#if (OS_TYPE_DEF == 0)
#define TIMER_LIBRARY_NAME "libunified_timer.so"
#else
#define TIMER_LIBRARY_NAME "libunified_timer.dll"
#endif

#define UNIFIED_TIMER_FUNCTION_NUM              3
static ArgPtr g_timerLibHandle = NULL;
static SymbolInfo g_timerFuncInfo[UNIFIED_TIMER_FUNCTION_NUM] = {
    { "AddUnifiedTimer", NULL },
    { "RemoveUnifiedTimer", NULL },
    { "CloseUnifiedTimer", NULL },
};

LogStatus DlogLoadTimerDll(void)
{
    if (g_timerLibHandle != NULL) {
        return LOG_SUCCESS;
    }
    g_timerLibHandle = LoadRuntimeDll(TIMER_LIBRARY_NAME);
    if (g_timerLibHandle == NULL) {
        SELF_LOG_ERROR("load unified_timer library failed.");
        return LOG_FAILURE;
    }
    SELF_LOG_INFO("load unified_timer library succeed.");
    int32_t ret = LoadDllFunc(g_timerLibHandle, g_timerFuncInfo, UNIFIED_TIMER_FUNCTION_NUM);
    if (ret != 0) {
        SELF_LOG_ERROR("load unified_timer library function failed.");
        return LOG_FAILURE;
    }
    SELF_LOG_INFO("load unified_timer library function succeed.");
    return LOG_SUCCESS;
}

LogStatus DlogCloseTimerDll(void)
{
    ONE_ACT_NO_LOG(g_timerLibHandle == NULL, return LOG_SUCCESS);
    int32_t ret = UnloadRuntimeDll(g_timerLibHandle);
    if (ret != 0) {
        SELF_LOG_ERROR("close unified_timer library handle failed.");
    } else {
        SELF_LOG_INFO("close unified_timer library handle succeed.");
    }
    g_timerLibHandle = NULL;
    return ret;
}

typedef uint32_t (*UNIFIED_TIMER_ADD)(const char *, void (*)(void), int64_t, enum TimerType);
uint32_t DlogAddUnifiedTimer(const char *timerName, void (*callback)(void), int64_t period, enum TimerType type)
{
    UNIFIED_TIMER_ADD func = (UNIFIED_TIMER_ADD)g_timerFuncInfo[0].handle;
    ONE_ACT_WARN_LOG(func == NULL, return 1, "Can not find unified timer func.");
    return func(timerName, callback, period, type);
}

typedef uint32_t (*UNIFIED_TIMER_REMOVE)(const char *);
uint32_t DlogRemoveUnifiedTimer(const char *timerName)
{
    UNIFIED_TIMER_REMOVE func = (UNIFIED_TIMER_REMOVE)g_timerFuncInfo[1].handle;
    ONE_ACT_WARN_LOG(func == NULL, return 1, "Can not find unified timer func.");
    return func(timerName);
}