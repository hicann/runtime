/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "trace_attr.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "trace_driver_api.h"
#include "trace_system_api.h"

#define DEFAULT_ENV_TIMEOUT    0 // timeout default is 0
#define MAX_ENV_TIMEOUT        (3 * 60 * 1000) // max timeout 180s

STATIC TraceInnerAttr g_traceAttr = { 0 };

STATIC void TraceAttrPlatformInit(void)
{
    g_traceAttr.systemAttr.platform = PLATFORM_INVALID_VALUE;
    TraStatus ret = TraceDriverInit();
    if (ret != TRACE_SUCCESS) {
        return;
    }

    uint32_t platform = PLATFORM_INVALID_VALUE;
    ret = TraceDrvGetPlatformInfo(&platform);
    if (ret != TRACE_SUCCESS) {
        return;
    }

    uint32_t devNum = 0;
    ret = TraceDrvGetDevNum(&devNum);
    if (ret != TRACE_SUCCESS) {
        return;
    }

    if ((platform == PLATFORM_HOST_SIDE) && (devNum != 0)) {
        g_traceAttr.systemAttr.platform = PLATFORM_HOST_SIDE; // EP host
    } else {
        g_traceAttr.systemAttr.platform = platform;
    }
}

#ifdef ATRACE_API
STATIC uint32_t TraceAttrGetPlatform(void)
{
    return g_traceAttr.systemAttr.platform;
}
#endif

/**
 * @brief       check atrace is supported or not
 * @return      true for support, false for not support
 */
bool AtraceCheckSupported(void)
{
#ifdef ATRACE_API
    if (TraceAttrGetPlatform() != PLATFORM_HOST_SIDE) {
        return false;
    }
#endif
    return true;
}

STATIC TraStatus TraceAttrIdInit(void)
{
    g_traceAttr.systemAttr.pid = getpid();
    uint32_t uid = getuid();
    const struct passwd *userInfo = getpwuid(uid);
    if (userInfo != NULL) {
        g_traceAttr.systemAttr.uid = userInfo->pw_uid;
        g_traceAttr.systemAttr.gid = userInfo->pw_gid;
        g_traceAttr.systemAttr.pgid = getpgrp();
        return TRACE_SUCCESS;
    }
    ADIAG_ERR("get uid and gid failed, uid=%u, strerr=%s.", uid, strerror(AdiagGetErrorCode()));
    return TRACE_FAILURE;
}

STATIC TraStatus TraceAttrTimeInit(void)
{
    AdiagStatus ret = TraceTimeDstInit();
    ADIAG_CHK_EXPR_ACTION(ret != ADIAG_SUCCESS, return TRACE_FAILURE, "init time DST failed, ret=%d.", ret);
    ret = TimestampToFileStr(GetRealTime(), g_traceAttr.systemAttr.timeStamp, TIMESTAMP_MAX_LENGTH);
    ADIAG_CHK_EXPR_ACTION(ret != ADIAG_SUCCESS, return TRACE_FAILURE, "get timestamp string failed, ret=%d.", ret);
    return TRACE_SUCCESS;
}

STATIC void TraceAttrEnvInit(void)
{
    g_traceAttr.systemAttr.envTimeout = DEFAULT_ENV_TIMEOUT;
    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_LOG_DEVICE_FLUSH_TIMEOUT, (env));
    if (env == NULL) {
        ADIAG_INF("doesn't set env ASCEND_LOG_DEVICE_FLUSH_TIMEOUT, use default timeout=%dms.", g_traceAttr.systemAttr.envTimeout);
        return;
    }

    int32_t value = -1;
    if ((AdiagStrToInt(env, &value) == TRACE_SUCCESS) && (value <= MAX_ENV_TIMEOUT) && (value >= 0)) {
        ADIAG_INF("set timeout %dms by env ASCEND_LOG_DEVICE_FLUSH_TIMEOUT.", g_traceAttr.systemAttr.envTimeout);
        g_traceAttr.systemAttr.envTimeout = value;
    } else {
        ADIAG_WAR("env ASCEND_LOG_DEVICE_FLUSH_TIMEOUT is invalid, use default timeout=%dms.", g_traceAttr.systemAttr.envTimeout);
    }
}

int32_t TraceGetTimeout(void)
{
    return g_traceAttr.systemAttr.envTimeout;
}

int32_t TraceAttrGetPid(void)
{
    return g_traceAttr.systemAttr.pid;
}

int32_t TraceAttrGetPgid(void)
{
    return g_traceAttr.systemAttr.pgid;
}

const char *TraceAttrGetTime(void)
{
    return (const char *)g_traceAttr.systemAttr.timeStamp;
}

uint32_t TraceAttrGetUid(void)
{
    return g_traceAttr.systemAttr.uid;
}

uint32_t TraceAttrGetGid(void)
{
    return g_traceAttr.systemAttr.gid;
}

TraStatus TraceSetGlobalAttr(const TraceGlobalAttr *attr)
{
    if (attr == NULL) {
        return TRACE_FAILURE;
    }
    g_traceAttr.userAttr.saveMode = attr->saveMode;
    g_traceAttr.userAttr.deviceId = attr->deviceId;
    g_traceAttr.userAttr.pid = attr->pid;
    ADIAG_INF("set global attr successfully, saveMode=%u, device id=%u, pid=%u.", attr->saveMode, attr->deviceId, attr->pid);
    return TRACE_SUCCESS;
}
 
uint8_t TraceAttrGetSaveMode(void)
{
    return g_traceAttr.userAttr.saveMode;
}
 
uint8_t TraceAttrGetGlobalDevId(void)
{
    return g_traceAttr.userAttr.deviceId;
}
 
uint32_t TraceAttrGetGlobalPid(void)
{
    return g_traceAttr.userAttr.pid;
}

TraStatus TraceAttrInit(void)
{
    TraceAttrPlatformInit();

    if (!AtraceCheckSupported()) {
        return TRACE_SUCCESS;
    }
    TraStatus ret = TraceAttrIdInit();
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("init attr id failed.");
        return TRACE_FAILURE;
    }

    ret = TraceAttrTimeInit();
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("init attr time failed.");
        return TRACE_FAILURE;
    }

    TraceAttrEnvInit();
    ADIAG_INF("attr init successfully, timeout=%dms.", g_traceAttr.systemAttr.envTimeout);
    return TRACE_SUCCESS;
}

void TraceAttrExit(void)
{
    TraceDriverExit();
}