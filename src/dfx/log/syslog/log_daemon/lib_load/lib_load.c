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
#include "dlfcn.h"

#define LIB_LOAD_REPLY_INVALID_INPUT "check input validity failed"
#define LIB_LOAD_REPLY_SYSTEM_FUNCTION "system function failed"
#define LIB_LOAD_REPLY_DEVICE_LIBRARY "the library does not exist"
#define LIB_LOAD_REPLY_SUCCESS "load library successfully"

#define LIB_LOAD_DEFAULT_LIBRARY_PATH "/usr/lib64/"
#define LIB_LOAD_DEVICE_DRIVER_EXTEND_PATH "/usr/lib64/device-compat-plugin/"
#define LIB_LOAD_DEVICE_DRIVER_EXTEND_PATH_OLD "/usr/lib64/device-sw-plugin/"
#define LIB_LOAD_DEVICE_DRIVER_SUB_PATH "/device-sw-plugin/"
#define OS_SPLIT_STR "/"
#define LIB_LOAD_MAGIC_NUM 0x0F0F0F0FU
#define LIB_LOAD_VERSION 0x1000U
#define LIB_LOAD_MAX_FILE_LEN 1024
#define LIB_LOAD_MAX_VERSION_LEN 256

typedef int32_t (*DfxDetectInit)(void*);
typedef void (*DfxDetectExit)(void);

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
    // dlopen default_detect.so
    int32_t ret = LOG_SUCCESS;
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

    g_libRecord[0].init(ServerCreateEx);
    g_libRecord[1].init(ServerCreate);
    ONE_ACT_ERR_LOG(ToolMutexInit(&g_libLoadMutex) != SYS_OK, ret = LOG_FAILURE, "Lib load mutex init failed.");
    if (ret == LOG_FAILURE) {
        LibLoadDlclose(&g_libRecord[0].dlHandle, &g_libRecord[0].libExit);
        LibLoadDlclose(&g_libRecord[1].dlHandle, &g_libRecord[1].libExit);
    }
    return ret;
}

int32_t LibLoadServerDestroy(void)
{
    for (uint32_t i = 0U; i < sizeof(g_libRecord) / sizeof(LibOpenInfo); ++i) {
        LibLoadDlclose(&g_libRecord[i].dlHandle, &g_libRecord[i].libExit);
        ServerRelease(g_libRecord[i].type);
        (void)memset_s(g_libRecord[i].version, (size_t)LIB_LOAD_MAX_VERSION_LEN, 0, (size_t)LIB_LOAD_MAX_VERSION_LEN);
        g_libRecord[i].size = 0U;
    }
    (void)ToolMutexDestroy(&g_libLoadMutex);
    return LOG_SUCCESS;
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
 * @brief       : check if the loadInfo got from host is valid by field comparison
 * @param [in]  : loadInfo    detect loadInfo to be checked
 * @return      : LOG_SUCCESS: valid; LOG_FAILURE: invalid
 */
STATIC int32_t LibLoadCheckInfoValid(const LibLoadInfo* loadInfo)
{
    if (loadInfo->magic != LIB_LOAD_MAGIC_NUM) {
        SELF_LOG_ERROR("check field magic failed, configure: %u, current: %u", LIB_LOAD_MAGIC_NUM, loadInfo->magic);
        return LOG_FAILURE;
    }
    if (loadInfo->version < LIB_LOAD_VERSION) {
        SELF_LOG_ERROR("check field version failed, configure: %u, current: %u", LIB_LOAD_VERSION, loadInfo->version);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC int32_t LibLoadIsLibraryFileExist(const CommHandle* handle, const LibLoadInfo* loadInfo, int32_t devId)
{
    char path[LIB_LOAD_MAX_FILE_LEN] = {"0"};
    int32_t ret = LibLoadFindLibraryPath(devId, loadInfo->name, path, LIB_LOAD_MAX_FILE_LEN);
    if (ret == LOG_FAILURE) {
        if (strlen(path) == 0) {
            LibLoadReplyMsg(handle, LIB_LOAD_REPLY_SYSTEM_FUNCTION, strlen(LIB_LOAD_REPLY_SYSTEM_FUNCTION));
        } else {
            LibLoadReplyMsg(handle, LIB_LOAD_REPLY_DEVICE_LIBRARY, strlen(LIB_LOAD_REPLY_DEVICE_LIBRARY));
        }
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC int32_t LibLoadUpgradeLibrary(LibOpenInfo* openInfo, char* path, char* version, uint32_t libSize)
{
    SELF_LOG_INFO("library %s upgrade", openInfo->name);
    ServerRelease(openInfo->type);
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

STATIC int32_t LibLoadCheckInfo(const CommHandle* handle, LibOpenInfo* openInfo, int32_t devId)
{
    char path[LIB_LOAD_MAX_FILE_LEN] = {0};
    int32_t ret = LibLoadFindLibraryPath(devId, openInfo->name, path, LIB_LOAD_MAX_FILE_LEN);
    if (ret == LOG_INVALID_DATA) {
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_SUCCESS, strlen(LIB_LOAD_REPLY_SUCCESS));
        return LOG_SUCCESS;
    } else if (ret == LOG_FAILURE) {
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_SYSTEM_FUNCTION, strlen(LIB_LOAD_REPLY_SYSTEM_FUNCTION));
        return LOG_FAILURE;
    }

    ToolStat statBuff = {0};
    if (ToolStatGet(path, &statBuff) != SYS_OK) {
        SELF_LOG_ERROR("stat new library %s failed", openInfo->name);
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_SYSTEM_FUNCTION, strlen(LIB_LOAD_REPLY_SYSTEM_FUNCTION));
        return LOG_FAILURE;
    }

    int32_t size = LIB_LOAD_MAX_VERSION_LEN;
    char buffer[LIB_LOAD_MAX_VERSION_LEN] = {0};
    drvError_t err =
        halGetDeviceInfoByBuff((uint32_t)devId, MODULE_TYPE_SYSTEM, INFO_TYPE_SDK_EX_VERSION, buffer, &size);
    if (err != DRV_ERROR_NONE) {
        SELF_LOG_ERROR("get library %s info failed, result: %d", openInfo->name, (int32_t)err);
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_SYSTEM_FUNCTION, strlen(LIB_LOAD_REPLY_SYSTEM_FUNCTION));
        return LOG_FAILURE;
    }
    SELF_LOG_INFO("get current package version: %s", buffer);
    uint32_t libSize = (uint32_t)statBuff.st_size;
    if ((strcmp(openInfo->version, buffer) == 0) && (libSize == openInfo->size)) {
        SELF_LOG_INFO("library %s needn't upgrade", openInfo->name);
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_SUCCESS, strlen(LIB_LOAD_REPLY_SUCCESS));
        return LOG_SUCCESS;
    }

    return LibLoadUpgradeLibrary(openInfo, path, buffer, libSize);
}

STATIC int32_t LibLoadUpgradeProcess(const CommHandle* handle, const LibLoadInfo* loadInfo, int32_t devId)
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
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_INVALID_INPUT, strlen(LIB_LOAD_REPLY_INVALID_INPUT));
        return LOG_FAILURE;
    }

    if (LibLoadIsLibraryFileExist(handle, loadInfo, devId) != LOG_SUCCESS) {
        return LOG_FAILURE;
    }

    (void)ToolMutexLock(&g_libLoadMutex);
    if (LibLoadCheckInfo(handle, currOpenInfo, devId) != LOG_SUCCESS) {
        (void)ToolMutexUnLock(&g_libLoadMutex);
        return LOG_FAILURE;
    }
    (void)ToolMutexUnLock(&g_libLoadMutex);

    return LOG_SUCCESS;
}

int32_t LibLoadServerProcess(const CommHandle* handle, const void* value, uint32_t len)
{
    SELF_LOG_INFO("the lib_load process start");
    if (handle == NULL) {
        SELF_LOG_ERROR("invalid input, handle is null");
        return LOG_FAILURE;
    }
    if (value == NULL) {
        SELF_LOG_ERROR("invalid input, value is null");
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_INVALID_INPUT, strlen(LIB_LOAD_REPLY_INVALID_INPUT));
        return LOG_FAILURE;
    }
    if (len < sizeof(LibLoadInfo)) {
        SELF_LOG_ERROR("invalid input, length of value is %u", len);
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_INVALID_INPUT, strlen(LIB_LOAD_REPLY_INVALID_INPUT));
        return LOG_FAILURE;
    }

    const LogDataMsg* msg = (const LogDataMsg*)value;
    const LibLoadInfo* loadInfo = (const LibLoadInfo*)msg->data;
    if (LibLoadCheckInfoValid(loadInfo) != LOG_SUCCESS) {
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_INVALID_INPUT, strlen(LIB_LOAD_REPLY_INVALID_INPUT));
        return LOG_FAILURE;
    }

    int32_t devId = -1;
    if (AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_DEV_ID, &devId) != IDE_DAEMON_OK) {
        SELF_LOG_ERROR("get device id failed");
        LibLoadReplyMsg(handle, LIB_LOAD_REPLY_SYSTEM_FUNCTION, strlen(LIB_LOAD_REPLY_SYSTEM_FUNCTION));
        return LOG_FAILURE;
    }
    SELF_LOG_INFO("the lib_load process devId: %d", devId);

    if (LibLoadUpgradeProcess(handle, loadInfo, devId) != LOG_SUCCESS) {
        return LOG_FAILURE;
    }

    LibLoadReplyMsg(handle, LIB_LOAD_REPLY_SUCCESS, strlen(LIB_LOAD_REPLY_SUCCESS));
    SELF_LOG_INFO("the lib_load process finished");
    return LOG_SUCCESS;
}