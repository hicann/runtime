/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "plog_stub.h"
#include "library_load.h"
#include "slog.h"
#include "ascend_hal.h"
#include "plog_to_dlog.h"
#include "alog_to_slog.h"
#include "plog_device_log.h"
#include "dlog_level_mgr.h"
#include "dlog_core.h"
#include "dlog_attr.h"
#include "plog_core.h"

static bool g_isUnifiedSwitch = false;

static int32_t g_plogFuncCount[PLOG_FUNC_MAX];

static int32_t PlogDlogReportInitialize(void)
{
    g_plogFuncCount[DLOG_REPORT_INITIALIZE]++;
    return 0;
}

static int32_t PlogDlogReportFinalize(void)
{
    g_plogFuncCount[DLOG_REPORT_FINALIZE]++;
    return 0;
}

static int32_t PlogDlogReportStart(int32_t devId, int32_t mode)
{
    g_plogFuncCount[DLOG_REPORT_START]++;
    return 0;
}

static void PlogDlogReportStop(int32_t devId)
{
    g_plogFuncCount[DLOG_REPORT_STOP]++;
    return;
}

static SymbolInfo g_plogFuncMap[PLOG_FUNC_MAX] = {
    {"DlogReportInitialize", (ArgPtr)PlogDlogReportInitialize},
    {"DlogReportFinalize", (ArgPtr)PlogDlogReportFinalize},
    {"DlogReportStart", (ArgPtr)PlogDlogReportStart},
    {"DlogReportStop", (ArgPtr)PlogDlogReportStop}
};

int32_t g_drvHandle = 0;
int32_t g_dlogHandle = 1;
int32_t g_slogHandle = 2;
#define MAP_SIZE 17
static SymbolInfo g_drvMap[MAP_SIZE] = {
    { "drvHdcClientCreate", (void *)drvHdcClientCreate },
    { "drvHdcClientDestroy", (void *)drvHdcClientDestroy },
    { "drvHdcSessionConnect", (void *)drvHdcSessionConnect },
    { "drvHdcSessionClose", (void *)drvHdcSessionClose },
    { "drvHdcAllocMsg", (void *)drvHdcAllocMsg },
    { "drvHdcFreeMsg", (void *)drvHdcFreeMsg },
    { "drvHdcReuseMsg", (void *)drvHdcReuseMsg },
    { "drvHdcAddMsgBuffer", (void *)drvHdcAddMsgBuffer },
    { "drvHdcGetMsgBuffer", (void *)drvHdcGetMsgBuffer },
    { "drvHdcSetSessionReference", (void *)drvHdcSetSessionReference },
    { "drvGetPlatformInfo", (void *)drvGetPlatformInfo },
    { "drvHdcGetCapacity", (void *)drvHdcGetCapacity },
    { "halHdcSend", (void *)halHdcSend },
    { "halHdcRecv", (void *)halHdcRecv },
    { "halCtl", (void *)halCtl },
    { "drvGetDevNum", (void *)drvGetDevNum },
    { "halGetDeviceInfo", (void *)halGetDeviceInfo }
};

static int32_t g_slogFuncCount[DLOG_FUNC_MAX];
 
static void SlogDlogInit(void)
{
    g_slogFuncCount[DLOG_INIT]++;
}

static int32_t SlogDlogGetLevel(int32_t moduleId, int32_t *enableEvent)
{
    g_slogFuncCount[DLOG_GET_LEVEL]++;
    return 0;
}

static int32_t SlogDlogSetLevel(int32_t moduleId, int32_t level, int32_t enableEvent)
{
    g_slogFuncCount[DLOG_SET_LEVEL]++;
    return 0;
}
 
static int32_t SlogCheckLogLevel(int32_t moduleId, int32_t logLevel)
{
    g_slogFuncCount[CHECK_LOG_LEVEL]++;
    return 1;
}

static int32_t SlogDlogGetAttr(LogAttr *logAttrInfo)
{
    g_slogFuncCount[DLOG_GET_ATTR]++;
    return 0;
}

static int32_t SlogDlogSetAttr(LogAttr logAttrInfo)
{
    g_slogFuncCount[DLOG_SET_ATTR]++;
    return 0;
}

static void SlogDlogVaList(int32_t moduleId, int32_t level, const char *fmt, va_list list)
{
    g_slogFuncCount[DLOG_VA_LIST]++;
}
 
static void SlogDlogFlush(void)
{
    g_slogFuncCount[DLOG_FLUSH]++;
}
 
static SymbolInfo g_slogFuncMap[DLOG_FUNC_MAX] = {
    {"dlog_init", (ArgPtr)SlogDlogInit},
    {"dlog_getlevel", (ArgPtr)SlogDlogGetLevel},
    {"dlog_setlevel", (ArgPtr)SlogDlogSetLevel},
    {"CheckLogLevel", (ArgPtr)SlogCheckLogLevel},
    {"DlogGetAttr", (ArgPtr)SlogDlogGetAttr},
    {"DlogSetAttr", (ArgPtr)SlogDlogSetAttr},
    {"DlogVaList", (ArgPtr)SlogDlogVaList},
    {"DlogFlush", (ArgPtr)SlogDlogFlush},
};

void *logDlopen(const char *fileName, int mode)
{
    if (strcmp(fileName, "libascend_hal.so") == 0) {
        return &g_drvHandle;
    }
    if (!g_isUnifiedSwitch) {
        MOCKER(PlogTransferToUnifiedlog).stubs().will(returnValue(-1));
        return NULL;
    }
    static bool status = false;
    if (strcmp(fileName, "libunified_dlog.so") == 0) {
        if (status) {
            MOCKER(PlogTransferToUnifiedlog).stubs().will(returnValue(-1));
            ProcessLogInit();
        }
        status = !status;
        return &g_dlogHandle;    // not NULL
    }
    if (strcmp(fileName, "libslog.so") == 0) {
        return &g_slogHandle;    // not NULL
    }
    return NULL;
}

int logDlclose(void *handle)
{
    if (!g_isUnifiedSwitch) {
        MOCKER(PlogCloseUnifiedlog).stubs().will(returnValue(-1));
        return 0;
    }
    static bool status = false;
    if (handle == &g_dlogHandle) {
        if (status) {
            MOCKER(PlogCloseUnifiedlog).stubs().will(returnValue(-1));
            ProcessLogFree();
        }
        status = !status;
    }
    return 0;
}

void *logDlsym(void *handle, const char* funcName)
{
    for (int32_t i = 0; i < MAP_SIZE; i++) {
        if (strcmp(funcName, g_drvMap[i].symbol) == 0) {
            return g_drvMap[i].handle;
        }
    }
    if (!g_isUnifiedSwitch) {
        return NULL;
    }
    for (int32_t i = 0; i < PLOG_FUNC_MAX; i++) {
        if (strcmp(funcName, g_plogFuncMap[i].symbol) == 0) {
            return g_plogFuncMap[i].handle;
        }
    }
    for (int32_t i = 0; i < DLOG_FUNC_MAX; i++) {
        if (strcmp(funcName, g_slogFuncMap[i].symbol) == 0) {
            return g_slogFuncMap[i].handle;
        }
    }
    return NULL;
}

int32_t GetSlogFuncCallCount(int32_t index)
{
    return g_slogFuncCount[index];
}

int32_t GetPlogFuncCallCount(int32_t index)
{
    return g_plogFuncCount[index];
}

void SetUnifiedSwitch(bool swtich)
{
    g_isUnifiedSwitch = swtich;
}