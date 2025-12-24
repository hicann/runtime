/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_pm_sig.h"
#include "securec.h"
#include "log_print.h"
#include "log_system_api.h"

STATIC int32_t g_gotSignal = 0;

void LogRecordSigNo(int32_t sigNo)
{
    g_gotSignal = sigNo;
}

int32_t LogGetSigNo(void)
{
    return g_gotSignal;
}

STATIC void LogSignalActionSet(int32_t sig, void (*handler)(int32_t))
{
    if (handler != NULL) {
        struct sigaction sa;
        (void)memset_s(&sa, sizeof(sa), 0, sizeof(sa));
        sa.sa_handler = handler;
        int32_t ret = sigaction(sig, &sa, NULL);
        ONE_ACT_ERR_LOG(ret < 0, return, "SigActionSet failed, result is %d.", ret);
        SELF_LOG_INFO("examine and change a signal action, signal_type=%d.", sig);
    }
}

void LogSignalRecord(int32_t sig)
{
    LogSignalActionSet(sig, LogRecordSigNo);
}

STATIC void LogSignal(int32_t sigNo, void(*func)(int32_t))
{
    if (func != NULL) {
        (void)signal(sigNo, func);
    }
}

void LogSignalIgn(int32_t sig)
{
    LogSignal(sig, SIG_IGN);
}
