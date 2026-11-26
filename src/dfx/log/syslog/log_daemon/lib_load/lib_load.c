/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "lib_load.h"
#include "log_print.h"
#include "log_common.h"
#include "log_drv.h"
#include "library_load.h"
#include "server_mgr.h"
#include "ascend_hal.h"
#include "adx_component_api_c.h"
#include "adcore_api.h"
#include "dlfcn.h"

#define LIB_LOAD_REPLY_INVALID_INPUT "check input validity failed"
#define LIB_LOAD_REPLY_SYSTEM_FUNCTION "system function failed"
#define LIB_LOAD_REPLY_SUCCESS "load library successfully"
#define LIB_LOAD_REPLY_PROHIBIT_CONTAINER "prohibit container operate lib load"
#define LIB_LOAD_REPLY_PROHIBIT_POWER_GROUP "prohibit compute power group operate lib load"

#define LIB_LOAD_DEFAULT_LIBRARY_PATH "/usr/lib64/"
#define LIB_LOAD_DEVICE_DRIVER_EXTEND_PATH "/usr/lib64/device-compat-plugin/"
#define LIB_LOAD_DEVICE_DRIVER_EXTEND_PATH_OLD "/usr/lib64/device-sw-plugin/"
#define LIB_LOAD_DEVICE_DRIVER_SUB_PATH "/device-sw-plugin/"
#define OS_SPLIT_STR "/"
#define LIB_LOAD_MAGIC_NUM 0x0F0F0F0FU
#define LIB_LOAD_VERSION 0x1000U
#define LIB_LOAD_MAX_FILE_LEN 1024
#define LIB_LOAD_MAX_VERSION_LEN 256
// a normal hbmtester run (--run -t 8) already takes about 8s: the upgrade drain must cover it,
// otherwise every upgrade concurrent with a normal detection would fail
#define LIB_LOAD_UPGRADE_DRAIN_TIMEOUT_MS 15000U
// the destroy path runs at daemon exit: keep the shutdown delay bounded, an undrained library
// is simply kept mapped (leaking at process exit is harmless, unloading it would crash slogd)
#define LIB_LOAD_DESTROY_DRAIN_TIMEOUT_MS 5000U

typedef int32_t (*DfxDetectInit)(void*);
typedef void (*DfxDetectExit)(void);

// classification of one lib load request: the enum decides BOTH the reply payload
// (LibLoadSendReply) and the function return code (SUCCESS, also for the served refusals,
// vs FAILURE)
typedef enum {
    LIB_LOAD_RESULT_SUCCESS = 0,
    LIB_LOAD_RESULT_INVALID_INPUT,
    LIB_LOAD_RESULT_SYSTEM_FUNCTION,
    LIB_LOAD_RESULT_PROHIBIT_CONTAINER,
    LIB_LOAD_RESULT_PROHIBIT_POWER_GROUP,
} LibLoadResult;

typedef struct LibOpenInfo {
    const char* name;
    char version[LIB_LOAD_MAX_VERSION_LEN];
    uint32_t size;
    ComponentType type;
    void* dlHandle;
    DfxDetectInit init;
    DfxDetectExit libExit;
} LibOpenInfo;

STATIC LibOpenInfo g_libRecord[] = {
    {"libhbm_detect.so", "", 0, COMPONENT_HBM_DETECT, NULL, NULL, NULL},
    {"libcpu_detect_server.so", "", 0, COMPONENT_CPU_DETECT, NULL, NULL, NULL},
};
STATIC ToolMutex g_libLoadMutex = TOOL_MUTEX_INITIALIZER;

/**
 * @brief       : search the upgrade package in the device plugin paths only; the default
 *                library loaded by LibLoadServerInit from /usr/lib64 is NOT an upgrade
 *                source; LOG_INVALID_DATA means no upgrade package exists, the caller keeps
 *                the default library and reports success with the warning logged inside this
 *                function; the host sends this request only when the device driver is >= 9
 *                and the library has not been updated in the current host process
 * @param [in]  : devId       device id
 * @param [in]  : libName     library name
 * @param [out] : outPath     resolved library path
 * @param [in]  : outPathLen  capacity of outPath
 * @return      : LOG_SUCCESS: found; LOG_FAILURE: sprintf_s failed; LOG_INVALID_DATA: no
 *                upgrade package exists
 */
STATIC int32_t LibLoadFindLibraryPath(int32_t devId, const char* libName, char* outPath, size_t outPathLen)
{
    int32_t ret = -1;
    // try to find lib in new path
    ret = sprintf_s(outPath, outPathLen, "%s%d%s%s", LIB_LOAD_DEVICE_DRIVER_EXTEND_PATH, devId, OS_SPLIT_STR, libName);
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s path failed for library %s", libName);
        return LOG_FAILURE;
    }
    if (ToolAccess(outPath) == SYS_OK) {
        SELF_LOG_INFO("find library %s in path: %s", libName, outPath);
        return LOG_SUCCESS;
    }
    SELF_LOG_INFO("library %s not exist in path: %s", libName, outPath);

    // try to find lib in old path
    ret = sprintf_s(
        outPath, outPathLen, "%s%d%s%s", LIB_LOAD_DEVICE_DRIVER_EXTEND_PATH_OLD, devId, LIB_LOAD_DEVICE_DRIVER_SUB_PATH,
        libName);
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s path failed for library %s", libName);
        return LOG_FAILURE;
    }
    if (ToolAccess(outPath) == SYS_OK) {
        SELF_LOG_INFO("find library %s in path: %s", libName, outPath);
        return LOG_SUCCESS;
    }
    SELF_LOG_INFO("library %s not exist in path: %s", libName, outPath);

    SELF_LOG_WARN("failed to find library %s in both new and old path", libName);
    return LOG_INVALID_DATA;
}

STATIC void LibLoadDlclose(void** handle, DfxDetectExit* libExit)
{
    if (*libExit != (DfxDetectExit)NULL) {
        (*libExit)();
        *libExit = (DfxDetectExit)NULL;
    }
    if (*handle != (void*)NULL) {
        int32_t ret = dlclose(*handle);
        if (ret != SYS_OK) {
            SELF_LOG_WARN("dlclose failed, %s.", dlerror());
        }
        *handle = (void*)NULL;
    }
}

int32_t LibLoadServerInit(void)
{
    // initialize the mutex before any registration action
    int32_t ret = ToolMutexInit(&g_libLoadMutex);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return LOG_FAILURE, "Lib load mutex init failed.");

    // dlopen default_detect.so
    char path[LIB_LOAD_MAX_FILE_LEN] = {0};
    for (size_t i = 0U; i < sizeof(g_libRecord) / sizeof(LibOpenInfo); ++i) {
        (void)memset_s(path, (size_t)LIB_LOAD_MAX_FILE_LEN, 0, (size_t)LIB_LOAD_MAX_FILE_LEN);
        ret = sprintf_s(path, LIB_LOAD_MAX_FILE_LEN, "%s%s", LIB_LOAD_DEFAULT_LIBRARY_PATH, g_libRecord[i].name);
        if (ret == -1) {
            SELF_LOG_ERROR("sprintf_s file %s failed, result: %d", path, ret);
            return LOG_FAILURE;
        }
        char realPath[TOOL_MAX_PATH] = {0};
        ret = ToolRealPath(path, realPath, TOOL_MAX_PATH);
        if (ret != SYS_OK) {
            SELF_LOG_ERROR("real path library %s failed, result: %d", realPath, ret);
            return LOG_FAILURE;
        }
        g_libRecord[i].dlHandle = LoadRuntimeDll(realPath);
        if (g_libRecord[i].dlHandle == NULL) {
            SELF_LOG_INFO("dlopen default library %s result: %s", realPath, dlerror());
            return LOG_SUCCESS;
        }
    }
    g_libRecord[0].init = (DfxDetectInit)dlsym(g_libRecord[0].dlHandle, "HbmDetectServerInit");
    ONE_ACT_ERR_LOG(g_libRecord[0].init == NULL, ret = LOG_FAILURE, "Dlsym api HbmDetectServerInit failed.");
    g_libRecord[1].init = (DfxDetectInit)dlsym(g_libRecord[1].dlHandle, "CpuDetectServerInit");
    ONE_ACT_ERR_LOG(g_libRecord[1].init == NULL, ret = LOG_FAILURE, "Dlsym api CpuDetectServerInit failed.");
    g_libRecord[1].libExit = (DfxDetectExit)dlsym(g_libRecord[1].dlHandle, "CpuDetectServerExit");
    ONE_ACT_ERR_LOG(g_libRecord[1].libExit == NULL, ret = LOG_FAILURE, "Dlsym api CpuDetectServerExit failed.");

    // call init only when all symbols are resolved, otherwise the null function pointer crashes slogd
    if (ret == LOG_SUCCESS) {
        g_libRecord[0].init(ServerCreateEx);
        g_libRecord[1].init(ServerCreate);
    }
    if (ret == LOG_FAILURE) {
        LibLoadDlclose(&g_libRecord[0].dlHandle, &g_libRecord[0].libExit);
        LibLoadDlclose(&g_libRecord[1].dlHandle, &g_libRecord[1].libExit);
    }
    return ret;
}

int32_t LibLoadServerDestroy(void)
{
    int32_t ret = LOG_SUCCESS;
    for (uint32_t i = 0U; i < sizeof(g_libRecord) / sizeof(LibOpenInfo); ++i) {
        // release and drain before dlclose: in-flight process threads may still run inside the library
        ServerRelease(g_libRecord[i].type);
        int32_t drainRet = AdxWaitComponentDrained(
            (int32_t)HDC_SERVICE_TYPE_IDE_FILE_TRANS, g_libRecord[i].type, LIB_LOAD_DESTROY_DRAIN_TIMEOUT_MS);
        if (drainRet != IDE_DAEMON_OK) {
            // keep the still busy library mapped: leaking at process exit is harmless,
            // unloading it would crash the exiting daemon
            SELF_LOG_ERROR(
                "component(%d) not drained after %ums, skip dlclose of %s.", (int32_t)g_libRecord[i].type,
                LIB_LOAD_DESTROY_DRAIN_TIMEOUT_MS, g_libRecord[i].name);
            ret = LOG_FAILURE;
        } else {
            LibLoadDlclose(&g_libRecord[i].dlHandle, &g_libRecord[i].libExit);
        }
        (void)memset_s(g_libRecord[i].version, (size_t)LIB_LOAD_MAX_VERSION_LEN, 0, (size_t)LIB_LOAD_MAX_VERSION_LEN);
        g_libRecord[i].size = 0U;
    }
    (void)ToolMutexDestroy(&g_libLoadMutex);
    return ret;
}

/**
 * @brief       : send specified message and end message to host
 * @param [in]  : handle     handle for communicating with the peer end
 * @param [in]  : msg        message to be sent
 * @param [in]  : len        length of message
 */
STATIC void LibLoadReplyMsg(const CommHandle* handle, const char* msg, size_t len)
{
    if (handle == NULL) {
        // need not send message this time
        return;
    }
    int32_t ret = AdxSendMsg(handle, msg, (uint32_t)len);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "reply message to host failed, ret=%d, message=%s", ret, msg);
    ret = AdxSendMsg(handle, HDC_END_MSG, (uint32_t)strlen(HDC_END_MSG));
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "reply end message to host failed, ret=%d", ret);
}

/**
 * @brief       : map the request result to the reply message and send the terminal
 *                reply: exactly one payload message followed by one HDC_END_MSG
 * @param [in]  : handle     handle for communicating with the peer end
 * @param [in]  : result     classification of the finished request
 */
STATIC void LibLoadSendReply(const CommHandle* handle, LibLoadResult result)
{
    const char* msg = LIB_LOAD_REPLY_SYSTEM_FUNCTION;
    if (result == LIB_LOAD_RESULT_SUCCESS) {
        msg = LIB_LOAD_REPLY_SUCCESS;
    } else if (result == LIB_LOAD_RESULT_INVALID_INPUT) {
        msg = LIB_LOAD_REPLY_INVALID_INPUT;
    } else if (result == LIB_LOAD_RESULT_PROHIBIT_CONTAINER) {
        msg = LIB_LOAD_REPLY_PROHIBIT_CONTAINER;
    } else if (result == LIB_LOAD_RESULT_PROHIBIT_POWER_GROUP) {
        msg = LIB_LOAD_REPLY_PROHIBIT_POWER_GROUP;
    }
    LibLoadReplyMsg(handle, msg, strlen(msg));
}

/**
 * @brief       : check if the loadInfo got from host is valid by field comparison
 * @param [in]  : loadInfo    detect loadInfo to be checked
 * @return      : LOG_SUCCESS: valid; LOG_FAILURE: invalid
 */
STATIC int32_t LibLoadValidateLoadInfo(const LibLoadInfo* loadInfo)
{
    if (loadInfo->magic != LIB_LOAD_MAGIC_NUM) {
        SELF_LOG_ERROR("check field magic failed, configure: %u, current: %u", LIB_LOAD_MAGIC_NUM, loadInfo->magic);
        return LOG_FAILURE;
    }
    if (loadInfo->version < LIB_LOAD_VERSION) {
        SELF_LOG_ERROR("check field version failed, configure: %u, current: %u", LIB_LOAD_VERSION, loadInfo->version);
        return LOG_FAILURE;
    }
    // name is a fixed 128-byte remote field with no NUL guarantee: require termination here
    // so every downstream consumer (strcmp, %s print, path search) stays in bounds
    if (memchr(loadInfo->name, '\0', LIB_MAX_LENGTH_OF_NAME) == NULL) {
        SELF_LOG_ERROR("check field name failed, library name is not NUL terminated.");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC int32_t LibLoadUpgradeLibrary(LibOpenInfo* openInfo, char* path, char* version, uint32_t libSize)
{
    SELF_LOG_INFO("library %s upgrade", openInfo->name);
    ServerRelease(openInfo->type);
    // drain the in-flight process threads of this component before dlclose, otherwise the threads
    // keep executing code in the library that is about to be unloaded (use-after-free)
    int32_t drainRet = AdxWaitComponentDrained(
        (int32_t)HDC_SERVICE_TYPE_IDE_FILE_TRANS, openInfo->type, LIB_LOAD_UPGRADE_DRAIN_TIMEOUT_MS);
    if (drainRet != IDE_DAEMON_OK) {
        // unloading a still busy library crashes slogd: keep the old library mapped and fail this
        // upgrade instead, the next upgrade attempt retries once the component is idle again
        SELF_LOG_ERROR(
            "component(%d) not drained after %ums, keep library %s loaded, upgrade aborted.", (int32_t)openInfo->type,
            LIB_LOAD_UPGRADE_DRAIN_TIMEOUT_MS, openInfo->name);
        return LOG_FAILURE;
    }
    LibLoadDlclose(&openInfo->dlHandle, &openInfo->libExit);
    (void)memset_s(openInfo->version, (size_t)LIB_LOAD_MAX_VERSION_LEN, 0, (size_t)LIB_LOAD_MAX_VERSION_LEN);
    openInfo->size = 0U;

    char realPath[TOOL_MAX_PATH] = {0};
    int32_t ret = ToolRealPath(path, realPath, TOOL_MAX_PATH);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("real path library %s failed, result: %d", path, ret);
        return LOG_FAILURE;
    }

    openInfo->dlHandle = LoadRuntimeDll(realPath);
    if (openInfo->dlHandle == NULL) {
        SELF_LOG_ERROR("dlopen new library %s failed, result: %s", realPath, dlerror());
        return LOG_FAILURE;
    }
    if (openInfo->type == COMPONENT_HBM_DETECT) {
        openInfo->init = (DfxDetectInit)dlsym(openInfo->dlHandle, "HbmDetectServerInit");
        if (openInfo->init == NULL) {
            SELF_LOG_ERROR("Dlsym api HbmDetectServerInit failed, %s.", dlerror());
            LibLoadDlclose(&openInfo->dlHandle, &openInfo->libExit);
            return LOG_FAILURE;
        }
        openInfo->init(ServerCreateEx);
    } else if (openInfo->type == COMPONENT_CPU_DETECT) {
        openInfo->init = (DfxDetectInit)dlsym(openInfo->dlHandle, "CpuDetectServerInit");
        if (openInfo->init == NULL) {
            SELF_LOG_ERROR("Dlsym api CpuDetectServerInit failed, %s.", dlerror());
            LibLoadDlclose(&openInfo->dlHandle, &openInfo->libExit);
            return LOG_FAILURE;
        }
        openInfo->libExit = (DfxDetectExit)dlsym(openInfo->dlHandle, "CpuDetectServerExit");
        if (openInfo->libExit == NULL) {
            SELF_LOG_ERROR("Dlsym api CpuDetectServerExit failed, %s.", dlerror());
            LibLoadDlclose(&openInfo->dlHandle, &openInfo->libExit);
            return LOG_FAILURE;
        }
        openInfo->init(ServerCreate);
    } else {
        SELF_LOG_ERROR("invalid library type %d", (int32_t)openInfo->type);
        LibLoadDlclose(&openInfo->dlHandle, &openInfo->libExit);
        return LOG_FAILURE;
    }

    ret = strncpy_s(openInfo->version, LIB_LOAD_MAX_VERSION_LEN, version, LIB_LOAD_MAX_VERSION_LEN - 1);
    if (ret != EOK) {
        SELF_LOG_ERROR("strncpy_s library version %s failed, result: %d", version, ret);
        LibLoadDlclose(&openInfo->dlHandle, &openInfo->libExit);
        return LOG_FAILURE;
    }
    openInfo->size = libSize;
    return LOG_SUCCESS;
}

STATIC LibLoadResult LibLoadCheckAndUpgradeLibrary(LibOpenInfo* openInfo, int32_t devId)
{
    char path[LIB_LOAD_MAX_FILE_LEN] = {0};
    // no upgrade package on the device paths: the host's upgrade intent cannot be
    // fulfilled, so keep the default library loaded and report success; the warning
    // is already logged inside LibLoadFindLibraryPath
    int32_t ret = LibLoadFindLibraryPath(devId, openInfo->name, path, LIB_LOAD_MAX_FILE_LEN);
    if (ret == LOG_INVALID_DATA) {
        return LIB_LOAD_RESULT_SUCCESS;
    }
    if (ret == LOG_FAILURE) {
        return LIB_LOAD_RESULT_SYSTEM_FUNCTION;
    }

    ToolStat statBuff = {0};
    if (ToolStatGet(path, &statBuff) != SYS_OK) {
        SELF_LOG_ERROR("stat new library %s failed", openInfo->name);
        return LIB_LOAD_RESULT_SYSTEM_FUNCTION;
    }

    int32_t size = LIB_LOAD_MAX_VERSION_LEN;
    char buffer[LIB_LOAD_MAX_VERSION_LEN] = {0};
    drvError_t err =
        halGetDeviceInfoByBuff((uint32_t)devId, MODULE_TYPE_SYSTEM, INFO_TYPE_SDK_EX_VERSION, buffer, &size);
    if (err != DRV_ERROR_NONE) {
        SELF_LOG_ERROR("get library %s info failed, result: %d", openInfo->name, (int32_t)err);
        return LIB_LOAD_RESULT_SYSTEM_FUNCTION;
    }
    SELF_LOG_INFO("get current package version: %s", buffer);
    uint32_t libSize = (uint32_t)statBuff.st_size;
    if ((strcmp(openInfo->version, buffer) == 0) && (libSize == openInfo->size)) {
        SELF_LOG_INFO("library %s needn't upgrade", openInfo->name);
        return LIB_LOAD_RESULT_SUCCESS;
    }

    if (LibLoadUpgradeLibrary(openInfo, path, buffer, libSize) != LOG_SUCCESS) {
        return LIB_LOAD_RESULT_SYSTEM_FUNCTION;
    }
    return LIB_LOAD_RESULT_SUCCESS;
}

STATIC LibLoadResult LibLoadUpgradeProcess(const LibLoadInfo* loadInfo, int32_t devId)
{
    LibOpenInfo* currOpenInfo = NULL;
    for (uint32_t i = 0U; i < sizeof(g_libRecord) / sizeof(LibOpenInfo); ++i) {
        if ((loadInfo->length == strlen(g_libRecord[i].name)) && (strcmp(loadInfo->name, g_libRecord[i].name) == 0)) {
            currOpenInfo = &g_libRecord[i];
            break;
        }
    }
    if (currOpenInfo == NULL) {
        SELF_LOG_ERROR("invalid input, library name is %s", loadInfo->name);
        return LIB_LOAD_RESULT_INVALID_INPUT;
    }

    LibLoadResult result = LIB_LOAD_RESULT_SYSTEM_FUNCTION;
    (void)ToolMutexLock(&g_libLoadMutex);
    result = LibLoadCheckAndUpgradeLibrary(currOpenInfo, devId);
    (void)ToolMutexUnLock(&g_libLoadMutex);
    return result;
}

/**
 * @brief       : gate the request by the peer run environment before any upgrade action:
 *                only the physical machine, the container deployed directly on it and a
 *                virtual machine directly connected to the device may drive the upgrade.
 *                This component is registered via ServerCreateEx and never passes the
 *                ServerCheckContainer gate of ServerProcess, while the upgrade path
 *                (ServerRelease plus the drain inside LibLoadCheckAndUpgradeLibrary) lets
 *                one forbidden request make every detect service on slogd unavailable for
 *                up to 15000ms
 * @param [in]  : handle     handle for communicating with the peer end
 * @param [out] : result     terminal classification when the stage fails
 * @return      : LOG_SUCCESS: peer allowed; LOG_FAILURE: prohibited or attr unavailable
 */
STATIC int32_t LibLoadCheckPeerEnv(const CommHandle* handle, LibLoadResult* result)
{
    int32_t runEnv = RUN_ENV_UNKNOW;
    int32_t ret = AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_RUN_ENV, &runEnv);
    if (ret != IDE_DAEMON_OK) {
        SELF_LOG_ERROR("get run env failed, %d.", ret);
        *result = LIB_LOAD_RESULT_SYSTEM_FUNCTION;
        return LOG_FAILURE;
    }
    if ((runEnv != RUN_ENV_PHYSICAL) && (runEnv != RUN_ENV_PHYSICAL_CONTAINER) && (runEnv != RUN_ENV_VIRTUAL)) {
        SELF_LOG_WARN("prohibit container operate lib load, runEnv=%d.", runEnv);
        *result = LIB_LOAD_RESULT_PROHIBIT_CONTAINER;
        return LOG_FAILURE;
    }

    // compute power group (vfId != 0): several hosts share one device, the peer is not
    // directly connected to it and an upgrade would disturb every other host of the group
    int32_t vfId = -1;
    ret = AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_VFID, &vfId);
    if (ret != IDE_DAEMON_OK) {
        SELF_LOG_ERROR("get vfId failed, %d.", ret);
        *result = LIB_LOAD_RESULT_SYSTEM_FUNCTION;
        return LOG_FAILURE;
    }
    if (vfId != 0) {
        SELF_LOG_WARN("prohibit compute power group operate lib load, vfId=%d.", vfId);
        *result = LIB_LOAD_RESULT_PROHIBIT_POWER_GROUP;
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

int32_t LibLoadServerProcess(const CommHandle* handle, const void* value, uint32_t len)
{
    SELF_LOG_INFO("the lib_load process start");
    if (handle == NULL) {
        // no communication handle: the host cannot be reached at all
        SELF_LOG_ERROR("invalid input, handle is null");
        return LOG_FAILURE;
    }

    LibLoadResult result = LIB_LOAD_RESULT_INVALID_INPUT;
    do {
        // the peer environment is the first gate: no untrusted payload is parsed before it,
        // a container request must never reach the release and drain of the upgrade path
        if (LibLoadCheckPeerEnv(handle, &result) != LOG_SUCCESS) {
            break;
        }
        if (value == NULL) {
            SELF_LOG_ERROR("invalid input, value is null");
            break;
        }
        if (len < sizeof(LogDataMsg) + sizeof(LibLoadInfo)) {
            SELF_LOG_ERROR("invalid input, length of value is %u", len);
            break;
        }
        const LogDataMsg* msg = (const LogDataMsg*)value;
        const LibLoadInfo* loadInfo = (const LibLoadInfo*)msg->data;
        if (LibLoadValidateLoadInfo(loadInfo) != LOG_SUCCESS) {
            break;
        }

        int32_t devId = -1;
        if (AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_DEV_ID, &devId) != IDE_DAEMON_OK) {
            SELF_LOG_ERROR("get device id failed");
            result = LIB_LOAD_RESULT_SYSTEM_FUNCTION;
            break;
        }
        SELF_LOG_INFO("the lib_load process devId: %d", devId);

        result = LibLoadUpgradeProcess(loadInfo, devId);
    } while (0);

    // single reply point: the host tears down the session on the first HDC_END_MSG,
    // so every request must send exactly one payload message + one HDC_END_MSG here
    LibLoadSendReply(handle, result);
    SELF_LOG_INFO("the lib_load process finished, result: %d", (int32_t)result);
    if ((result == LIB_LOAD_RESULT_PROHIBIT_CONTAINER) || (result == LIB_LOAD_RESULT_PROHIBIT_POWER_GROUP)) {
        // legacy contract shared with ServerCheckContainer and HbmDetectCheckContainer: a
        // refused peer counts as a served request, the reply payload carries the reason
        return LOG_SUCCESS;
    }
    return (result == LIB_LOAD_RESULT_SUCCESS) ? LOG_SUCCESS : LOG_FAILURE;
}