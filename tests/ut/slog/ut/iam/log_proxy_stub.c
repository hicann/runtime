/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "high_mem.h"
#include "iam.h"
#include "log_print_syslog.h"

static int32_t g_iamReadyRet = SYS_ERROR;
static int32_t g_registerRet = SYS_OK;
static int32_t g_unregisterRet = SYS_OK;
static LogStatus g_hiMemInitRet = LOG_FAILURE;
static uint32_t g_hiMemReadNodes = 0;
static int32_t g_logBufInitRet = SYS_ERROR;

void LogProxyStubReset(void)
{
    g_iamReadyRet = SYS_ERROR;
    g_registerRet = SYS_OK;
    g_unregisterRet = SYS_OK;
    g_hiMemInitRet = LOG_FAILURE;
    g_hiMemReadNodes = 0;
    g_logBufInitRet = SYS_ERROR;
}

void LogProxyStubSetIamReady(int32_t ret)
{
    g_iamReadyRet = ret;
}

void LogProxyStubSetRegisterRet(int32_t ret)
{
    g_registerRet = ret;
}

void LogProxyStubSetUnregisterRet(int32_t ret)
{
    g_unregisterRet = ret;
}

void LogProxyStubSetHiMemInitRet(LogStatus ret)
{
    g_hiMemInitRet = ret;
}

void LogProxyStubSetHiMemReadNodes(uint32_t nodes)
{
    g_hiMemReadNodes = nodes;
}

void LogProxyStubSetLogBufInitRet(int32_t ret)
{
    g_logBufInitRet = ret;
}

void LogPrintSys(int32_t priority, const char* format, ...)
{
    (void)priority;
    (void)format;
}

int32_t IAMResMgrReady(void) { return g_iamReadyRet; }

int32_t IAMRegResStatusChangeCb(
    void (*resourceStatusChangeCb)(struct IAMVirtualResourceStatus* resList, const int32_t listNum),
    struct IAMResourceSubscribeConfig config)
{
    (void)resourceStatusChangeCb;
    (void)config;
    return g_registerRet;
}

int32_t IAMUnregAssignedResStatusChangeCb(char* resName)
{
    (void)resName;
    return g_unregisterRet;
}

int32_t IAMRetrieveService(void) { return SYS_OK; }

int32_t HiMemInit(int32_t* fd)
{
    if (g_hiMemInitRet == LOG_SUCCESS) {
        *fd = 1;
    }
    return g_hiMemInitRet;
}

void HiMemFree(int32_t* fd) { *fd = 0; }

uint32_t HiMemReadIamLog(int32_t fd, RingBufferStat* logBuf)
{
    (void)fd;
    (void)logBuf;
    return g_hiMemReadNodes;
}

int32_t LogBufInitHead(RingBufferCtrl* ringBufferCtrl, uint32_t size, uint32_t dataOffset)
{
    (void)dataOffset;
    if (g_logBufInitRet == SYS_OK) {
        (void)memset(ringBufferCtrl, 0, size);
    }
    return g_logBufInitRet;
}
