/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "alog_to_slog.h"
#include "dlog_common.h"
#include "dlog_unified_timer_api.h"
#include "iam.h"
#include "log_iam_pub.h"
#include "log_level.h"
#include "log_print_syslog.h"

#include <errno.h>
#include <stdarg.h>

static bool g_servicePrepared = true;
static int32_t g_registerRet = SYS_OK;
static int32_t g_unregisterRet = SYS_OK;
static int32_t g_ioctlRet = SYS_OK;
static int32_t g_ioctlError = 0;
static int32_t g_globalLevel = DLOG_DEBUG;
static int32_t g_eventLevel = EVENT_DISABLE_VALUE;
static int32_t g_moduleLevel = DLOG_DEBUG;
static void (*g_resourceCallback)(struct IAMVirtualResourceStatus*, const int32_t) = NULL;
static void (*g_periodicTimerCallback)(void) = NULL;

void IamSlogStubReset(void)
{
    g_servicePrepared = true;
    g_registerRet = SYS_OK;
    g_unregisterRet = SYS_OK;
    g_ioctlRet = SYS_OK;
    g_ioctlError = 0;
    g_globalLevel = DLOG_DEBUG;
    g_eventLevel = EVENT_DISABLE_VALUE;
    g_moduleLevel = DLOG_DEBUG;
    g_resourceCallback = NULL;
    g_periodicTimerCallback = NULL;
}

void IamSlogStubSetServicePreparation(bool ready)
{
    g_servicePrepared = ready;
}

void IamSlogStubSetRegisterRet(int32_t ret)
{
    g_registerRet = ret;
}

void IamSlogStubSetUnregisterRet(int32_t ret)
{
    g_unregisterRet = ret;
}

void IamSlogStubSetIoctlResult(int32_t ret, int32_t errorCode)
{
    g_ioctlRet = ret;
    g_ioctlError = errorCode;
}

void IamSlogStubSetIoctlLevels(int32_t globalLevel, int32_t eventLevel, int32_t moduleLevel)
{
    g_globalLevel = globalLevel;
    g_eventLevel = eventLevel;
    g_moduleLevel = moduleLevel;
}

void IamSlogStubNotifyResource(enum IAMResourceStatus status)
{
    if (g_resourceCallback == NULL) {
        return;
    }
    struct IAMVirtualResourceStatus resource = { LOGOUT_IAM_SERVICE_PATH, status };
    g_resourceCallback(&resource, 1);
}

void IamSlogStubFirePeriodicTimer(void)
{
    if (g_periodicTimerCallback != NULL) {
        g_periodicTimerCallback();
    }
}

void LogPrintSys(int32_t priority, const char* format, ...)
{
    (void)priority;
    (void)format;
}

void AlogCloseSlogLib(void) {}

int32_t AlogTransferToSlog(void) { return LOG_FAILURE; }

bool IAMCheckServicePreparation(void) { return g_servicePrepared; }

int32_t IAMRegResStatusChangeCb(
    void (*resourceStatusChangeCb)(struct IAMVirtualResourceStatus* resList, const int32_t listNum),
    struct IAMResourceSubscribeConfig config)
{
    (void)config;
    g_resourceCallback = resourceStatusChangeCb;
    return g_registerRet;
}

int32_t IAMUnregAssignedResStatusChangeCb(char* resName)
{
    (void)resName;
    return g_unregisterRet;
}

int ioctl(int fd, unsigned long request, ...)
{
    (void)fd;
    if ((request != IAM_CMD_GET_LEVEL) && (request != IAM_CMD_FLUSH_LOG)) {
        errno = ENOTTY;
        return SYS_ERROR;
    }
    struct IAMIoctlArg* arg = NULL;
    if (request == IAM_CMD_GET_LEVEL) {
        va_list args;
        va_start(args, request);
        arg = va_arg(args, struct IAMIoctlArg*);
        va_end(args);
    }
    if ((g_ioctlRet == SYS_OK) && (request == IAM_CMD_GET_LEVEL) && (arg != NULL) && (arg->argData != NULL)) {
        LogLevelConfInfo* levelInfo = (LogLevelConfInfo*)arg->argData;
        if (strcmp(levelInfo->configName, "global_level") == 0) {
            levelInfo->configValue[0] = g_globalLevel;
            levelInfo->configValue[1] = g_eventLevel;
        } else {
            levelInfo->configValue[SLOG] = g_moduleLevel;
        }
    }
    errno = g_ioctlError;
    return g_ioctlRet;
}

LogStatus DlogLoadTimerDll(void) { return LOG_SUCCESS; }

LogStatus DlogCloseTimerDll(void) { return LOG_SUCCESS; }

uint32_t DlogAddUnifiedTimer(const char* timerName, void (*callback)(void), int64_t period, enum TimerType type)
{
    (void)timerName;
    (void)period;
    if (type == PERIODIC_TIMER) {
        g_periodicTimerCallback = callback;
    }
    return 0;
}

uint32_t DlogRemoveUnifiedTimer(const char* timerName)
{
    (void)timerName;
    return 0;
}
