/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dlog_attr.h"
#include "dlfcn.h"
#include "log_file_util.h"
#include "log_print.h"
#include "mmpa_api.h"
#include "ascend_hal.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define DLOG_ENV_MODE_UNI   "1"
#define DLOG_ENV_MODE_SEP   "2"

#define DRV_HAL_LIBRARY_NAME "libascend_hal.so"
typedef drvError_t (*DRV_HAL_GET_DEVICE_INFO)(uint32_t, int32_t, int32_t, int64_t *);
typedef struct LogSystemAttr {
    int32_t serverType;
    int32_t pid;
    AosType aosType;
    uint32_t uid;
    uint32_t gid;
} LogSystemAttr;

typedef struct DlogAttr {
    ToolMutex rwlock;
    LogSystemAttr systemAttr;
    LogAttr userAttr;
} DlogAttr;

STATIC DlogAttr g_dlogAttr = { TOOL_MUTEX_INITIALIZER, { -1, 0, AOS_GEA, 0, 0 }, { APPLICATION, 0, 0, 0, "" } };

static inline void DlogAttrWriteLock(void)
{
    LOCK_WARN_LOG(&g_dlogAttr.rwlock);
}

static inline void DlogAttrUnlock(void)
{
    UNLOCK_WARN_LOG(&g_dlogAttr.rwlock);
}

/**
 * @brief       : init aos type
 * @return      : NA
 */
STATIC INLINE void DlogInitAosType(void)
{
    const char *aosEnv = NULL;
    MM_SYS_GET_ENV(MM_ENV_AOS_TYPE, (aosEnv));
    if ((aosEnv != NULL) && (strcmp(aosEnv, "AOS_SEA") == 0)) {
        g_dlogAttr.systemAttr.aosType = AOS_SEA;
        return;
    }
    g_dlogAttr.systemAttr.aosType = AOS_GEA;
    return;
}

/**
 * @brief       : init server type
 * @return      : NA
 */
STATIC void DlogInitServerType(void)
{
#ifdef _LOG_UT_
#define INFO_TYPE_PRODUCT_TYPE 100
    void *soHandle = dlopen(DRV_HAL_LIBRARY_NAME, RTLD_LAZY);
    if (soHandle == NULL) {
        SELF_LOG_WARN("cannot load hal driver library.");
        return;
    }

    void *funcSymbol = dlsym(soHandle, "halGetDeviceInfo");
    if (funcSymbol == NULL) {
        SELF_LOG_WARN("cannot load hal driver library.");
        return;
    }

    DRV_HAL_GET_DEVICE_INFO func = (DRV_HAL_GET_DEVICE_INFO)funcSymbol;
    int64_t value = -1;
    uint32_t devId = 0;
    drvError_t ret = func(devId, MODULE_TYPE_SYSTEM, INFO_TYPE_PRODUCT_TYPE, &value);
    if (ret == DRV_ERROR_NOT_SUPPORT) {
        SELF_LOG_INFO("cannot get device info.");
    } else if (ret == 0) {
        g_dlogAttr.systemAttr.serverType = (int32_t)value;
        SELF_LOG_INFO("get device type=%d.", (int32_t)value);
    } else {
        SELF_LOG_WARN("cannot get device info, ret = %d.", (int32_t)ret);
    }

    (void)dlclose(soHandle);
#endif
    g_dlogAttr.systemAttr.serverType = -1; // stub for esl
}

bool DlogIsPoolingDevice(void)
{
    return (g_dlogAttr.systemAttr.serverType == 0);
}

STATIC void DlogInitUserGroupId(void)
{
    (void)ToolGetUserGroupId(&g_dlogAttr.systemAttr.uid, &g_dlogAttr.systemAttr.gid);
}

uint32_t DlogGetUid(void)
{
    return g_dlogAttr.systemAttr.uid;
}

uint32_t DlogGetGid(void)
{
    return g_dlogAttr.systemAttr.gid;
}

/**
 * @brief       : check aoscore or not by env
 * @return      : true: aoscore; false: other
 */
bool DlogIsAosCore(void)
{
    return (g_dlogAttr.systemAttr.aosType == AOS_SEA);
}

AosType DlogGetAosType(void)
{
    return g_dlogAttr.systemAttr.aosType;
}

int32_t DlogGetCurrPid(void)
{
    return g_dlogAttr.systemAttr.pid;
}

void DlogSetCurrPid(void)
{
    g_dlogAttr.systemAttr.pid = ToolGetPid();
}

bool DlogCheckCurrPid(void)
{
    if (g_dlogAttr.systemAttr.pid == ToolGetPid()) {
        return true;
    }
    return false;
}

/**
 * @brief       : check alog.so or not
 * @return      : true: alog.so; false: slog.so
 */
STATIC INLINE bool DlogIsAlog(void)
{
#if defined LOG_CPP || defined APP_LOG
    return true;
#else
    return false;
#endif
}

/**
 * @brief       : get process type
 * @return      : SYSTEM/APPLICATION
 */
ProcessType DlogGetProcessType(void)
{
    return g_dlogAttr.userAttr.type;
}

/**
 * @brief       : check log type is system log or not
 * @return      : true: system log; false: other
 */
bool DlogCheckAttrSystem(void)
{
    return (g_dlogAttr.userAttr.type == SYSTEM);
}

/**
 * @brief       : get device id attr
 * @return      : device id
 */
uint32_t DlogGetAttrDeviceId(void)
{
    return g_dlogAttr.userAttr.deviceId;
}

/**
 * @brief       : get user attr
 * @return      : user attr
 */
void DlogGetUserAttr(LogAttr *attr)
{
    if (attr != NULL) {
        *attr = g_dlogAttr.userAttr;
    }
}

/**
 * @brief       : get host pid(set by user)
 * @return      : host pid
 */
uint32_t DlogGetHostPid(void)
{
    return g_dlogAttr.userAttr.pid;
}


STATIC INLINE bool DlogCheckMode(uint32_t mode)
{
    return ((mode == LOG_SAVE_MODE_UNI) || (mode == LOG_SAVE_MODE_SEP));
}

STATIC void DlogSetHostPid(uint32_t pid)
{
    if (pid != 0) {
        g_dlogAttr.userAttr.pid = pid;
        return;
    }

    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_HOSTPID, (env));
    if (env != NULL) {
        uint32_t tmpL = 0;
        if ((LogStrToUint(env, &tmpL) == LOG_SUCCESS) && (tmpL > 0)) {
            g_dlogAttr.userAttr.pid = tmpL;
            SELF_LOG_INFO("set pid by env ASCEND_HOSTPID(%u).", tmpL);
            return;
        }
    }
    SELF_LOG_INFO("can't set pid by env ASCEND_HOSTPID, use original value.");
}

STATIC void DlogSetMode(uint32_t mode)
{
    if (DlogCheckMode(mode)) {
        g_dlogAttr.userAttr.mode = mode;
        return;
    }

    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_LOG_SAVE_MODE, (env));
    if (env != NULL) {
        if (strcmp(env, DLOG_ENV_MODE_UNI) == 0) {
            g_dlogAttr.userAttr.mode = LOG_SAVE_MODE_UNI;
            SELF_LOG_INFO("set mode(unify) by env ASCEND_LOG_SAVE_MODE.");
            return;
        } 
        if (strcmp(env, DLOG_ENV_MODE_SEP) == 0) {
            g_dlogAttr.userAttr.mode = LOG_SAVE_MODE_SEP;
            SELF_LOG_INFO("set mode(separate) by env ASCEND_LOG_SAVE_MODE.");
            return;
        }
    }
    SELF_LOG_INFO("can't set mode by env ASCEND_LOG_SAVE_MODE, use original value.");
}

/**
 * @brief       : set user attr
 * @param [in]  : logAttr       user attr
 * @return      : NA
 */
void DlogSetUserAttr(const LogAttr *logAttr)
{
    LogAttr initAttr;
    (void)memset_s(&(initAttr), sizeof(initAttr), DLOG_ATTR_INIT_VALUE, sizeof(initAttr));
    DlogAttrWriteLock();
    if (logAttr->type != initAttr.type) {
        g_dlogAttr.userAttr.type = logAttr->type;
    }
    if (logAttr->pid != initAttr.pid) {
        DlogSetHostPid(logAttr->pid);
    }
    if (logAttr->deviceId != initAttr.deviceId) {
        g_dlogAttr.userAttr.deviceId = logAttr->deviceId;
    }
    if (logAttr->mode != initAttr.mode) {
        DlogSetMode(logAttr->mode);
    }

    SELF_LOG_INFO("set log attr, type(%d), deviceId(%u), host pid(%u), save mode(%u).",
                  (int32_t)g_dlogAttr.userAttr.type, g_dlogAttr.userAttr.deviceId,
                  g_dlogAttr.userAttr.pid, g_dlogAttr.userAttr.mode);
    DlogAttrUnlock();
}

STATIC void DlogInitUserAttr(void)
{
    g_dlogAttr.userAttr.deviceId = 0;
    g_dlogAttr.userAttr.pid = (uint32_t)ToolGetPid();
    g_dlogAttr.userAttr.mode = (uint32_t)LOG_SAVE_MODE_UNI;

    // alog default type: APPLICATION
    // slog default type: SYSTEM
    // aos_core alog/slog default type: APPLICATION
    if (DlogIsAlog()) {
        g_dlogAttr.userAttr.type = APPLICATION;
    } else {
        if (DlogIsAosCore()) {
            g_dlogAttr.userAttr.type = APPLICATION;
        } else {
            g_dlogAttr.userAttr.type = SYSTEM;
        }
    }
}

STATIC void DlogInitSystemAttr(void)
{
    DlogSetCurrPid();
    DlogInitAosType();
    DlogInitServerType();
    DlogInitUserGroupId();
}

/**
 * @brief       : init global attr
 * @return      : NA
 */
void DlogInitGlobalAttr(void)
{
    int32_t ret = pthread_atfork(DlogAttrWriteLock, DlogAttrUnlock, DlogAttrUnlock);
    NO_ACT_WARN_LOG(ret != 0, "attr can not register fork, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    DlogAttrWriteLock();
    DlogInitSystemAttr();
    DlogInitUserAttr();
    DlogAttrUnlock();
}

#ifdef __cplusplus
}
#endif // __cplusplus