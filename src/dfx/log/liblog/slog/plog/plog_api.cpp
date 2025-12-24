/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include "plog.h"
#include "plog_device_log.h"
#include "plog_to_dlog.h"
#include "library_load.h"
#include "log_print.h"

namespace {
    ArgPtr g_dloglibHandle = nullptr;
    SymbolInfo g_dlogFuncInfo[PLOG_FUNC_MAX] = {
        {"DlogReportInitialize", nullptr},
        {"DlogReportFinalize", nullptr},
        {"DlogReportStart", nullptr},
        {"DlogReportStop", nullptr}
    };

    using DlogReportInitializeFunc = decltype(DlogReportInitialize)*;
    using DlogReportFinalizeFunc = decltype(DlogReportFinalize)*;
    using DlogReportStartFunc = decltype(DlogReportStart)*;
    using DlogReportStopFunc = decltype(DlogReportStop)*;
};

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#ifdef LOG_CPP
int32_t PlogTransferToUnifiedlog(void)
{
    const std::string DLOG_LIBRARY_NAME = "libunified_dlog.so";
    g_dloglibHandle = LoadRuntimeDll(DLOG_LIBRARY_NAME.c_str());
    ONE_ACT_NO_LOG(g_dloglibHandle == nullptr, return LOG_FAILURE);

    int32_t ret = LoadDllFunc(g_dloglibHandle, &g_dlogFuncInfo[0], PLOG_FUNC_MAX);
    ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return ret);

    SELF_LOG_INFO("plog transfer to unified_dlog success");
    return LOG_SUCCESS;
}

int32_t PlogCloseUnifiedlog(void)
{
    (void)UnloadRuntimeDll(g_dloglibHandle);
    return LOG_SUCCESS;
}

#else
int32_t PlogTransferToUnifiedlog(void)
{
    (void)g_dloglibHandle;
    return LOG_FAILURE;
}

int32_t PlogCloseUnifiedlog(void)
{
    return LOG_FAILURE;
}
#endif

#ifdef __cplusplus
}
#endif // __cplusplus

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus
int32_t DlogReportStart(int32_t devId, int32_t mode)
{
    if (g_dlogFuncInfo[DLOG_REPORT_START].handle != nullptr) {
        return reinterpret_cast<DlogReportStartFunc>(g_dlogFuncInfo[DLOG_REPORT_START].handle)(devId, mode);
    }
    return DlogReportStartInner(devId, mode);
}

void DlogReportStop(int32_t devId)
{
    if (g_dlogFuncInfo[DLOG_REPORT_STOP].handle != nullptr) {
        return reinterpret_cast<DlogReportStopFunc>(g_dlogFuncInfo[DLOG_REPORT_STOP].handle)(devId);
    }
    DlogReportStopInner(devId);
}

int32_t DlogReportInitialize(void)
{
    if (g_dlogFuncInfo[DLOG_REPORT_INITIALIZE].handle != nullptr) {
        return reinterpret_cast<DlogReportInitializeFunc>(g_dlogFuncInfo[DLOG_REPORT_INITIALIZE].handle)();
    }
    return DlogReportInitializeInner();
}

int32_t DlogReportFinalize(void)
{
    if (g_dlogFuncInfo[DLOG_REPORT_FINALIZE].handle != nullptr) {
        return reinterpret_cast<DlogReportFinalizeFunc>(g_dlogFuncInfo[DLOG_REPORT_FINALIZE].handle)();
    }
    return DlogReportFinalizeInner();
}
#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus