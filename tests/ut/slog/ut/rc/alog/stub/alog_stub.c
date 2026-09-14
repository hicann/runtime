/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "alog_stub.h"
#include "library_load.h"
#include "slog.h"
#include "ascend_hal.h"

int32_t g_handle = 0;
#define MAP_SIZE 3
static SymbolInfo g_drvMap[MAP_SIZE] = {
    {"drvGetPlatformInfo", (void*)drvGetPlatformInfo},
    {"drv_log_set_module_log_level", (void*)drv_log_set_module_log_level},
    {"halCtl", (void*)halCtl},
};

drvError_t drvGetPlatformInfo(uint32_t* info)
{
    *info = 0; // DEVICE_SIDE
    return DRV_ERROR_NONE;
}

/* record what the device-side level dispatch hands the driver. */
static DrvLevelCallRecord g_drvLevelCall;

int32_t drv_log_set_module_log_level(int32_t level, int32_t* moduleIds, int32_t size)
{
    g_drvLevelCall.callCount++;
    g_drvLevelCall.level = level;
    g_drvLevelCall.size = size;
    for (int32_t i = 0; (i < size) && (i < DRV_LEVEL_REC_MAX); i++) {
        g_drvLevelCall.mods[i] = moduleIds[i];
    }
    if (g_drvLevelCall.jNum < DRV_LEVEL_REC_MAX) {
        g_drvLevelCall.jLevels[g_drvLevelCall.jNum] = level;
        g_drvLevelCall.jMods[g_drvLevelCall.jNum] = (size > 0) ? moduleIds[0] : -1;
        g_drvLevelCall.jSizes[g_drvLevelCall.jNum] = size;
        g_drvLevelCall.jNum++;
    }
    return 0;
}

/* capture what the device-side registration hands the driver. */
static DrvRegCallRecord g_drvRegCall;

void ResetDrvRegCall(void) { (void)memset_s(&g_drvRegCall, sizeof(g_drvRegCall), 0, sizeof(g_drvRegCall)); }

const DrvRegCallRecord* GetDrvRegCall(void) { return &g_drvRegCall; }

static void DlogDriverLogSink(int moduleId, int level, const char* fmt, ...)
{
    (void)level;
    (void)fmt;
    g_drvRegCall.callbackCalls++;
    g_drvRegCall.lastModuleId = moduleId;
}

drvError_t halCtl(int cmd, void* param_value, size_t param_value_size, void* out_value, size_t* out_size_ret)
{
    (void)param_value_size;
    (void)out_value;
    (void)out_size_ret;
    if ((cmd == HAL_CTL_REGISTER_RUN_LOG_OUT_HANDLE) || (cmd == HAL_CTL_REGISTER_LOG_OUT_HANDLE)) {
        g_drvRegCall.registerCalls++;
        g_drvRegCall.lastCmd = cmd;
        struct log_out_handle* handle = (struct log_out_handle*)param_value;
        if (handle != NULL) {
            g_drvRegCall.lastLogLevel = handle->logLevel;
            g_drvRegCall.callback = handle->DlogInner;
            /* Behave like the real driver: probe the new callback
             * synchronously from inside the register call. */
            g_drvRegCall.probeCalls++;
            handle->DlogInner(10, 3, "[probe] drv log register test.");
        }
        return DRV_ERROR_NONE;
    }
    if (cmd == HAL_CTL_UNREGISTER_LOG_OUT_HANDLE) {
        return DRV_ERROR_NONE;
    }
    return DRV_ERROR_NOT_SUPPORT;
}

void ResetDrvLevelCall(void) { (void)memset_s(&g_drvLevelCall, sizeof(g_drvLevelCall), 0, sizeof(g_drvLevelCall)); }

const DrvLevelCallRecord* GetDrvLevelCall(void) { return &g_drvLevelCall; }

static int32_t g_slogFuncCount[DLOG_FUNC_MAX];

static void SlogDlogInit(void) { g_slogFuncCount[DLOG_INIT]++; }

static int32_t SlogDlogGetLevel(int32_t moduleId, int32_t* enableEvent)
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
    return 0;
}

static int32_t SlogDlogGetAttr(LogAttr* logAttrInfo)
{
    g_slogFuncCount[DLOG_GET_ATTR]++;
    return 0;
}

static int32_t SlogDlogSetAttr(LogAttr logAttrInfo)
{
    g_slogFuncCount[DLOG_SET_ATTR]++;
    return 0;
}

static void SlogDlogVaList(int32_t moduleId, int32_t level, const char* fmt, va_list list)
{
    g_slogFuncCount[DLOG_VA_LIST]++;
}

static void SlogDlogFlush(void) { g_slogFuncCount[DLOG_FLUSH]++; }

static SymbolInfo g_slogFuncMap[DLOG_FUNC_MAX] = {
    {"dlog_init", (ArgPtr)SlogDlogInit},         {"dlog_getlevel", (ArgPtr)SlogDlogGetLevel},
    {"dlog_setlevel", (ArgPtr)SlogDlogSetLevel}, {"CheckLogLevel", (ArgPtr)SlogCheckLogLevel},
    {"DlogGetAttr", (ArgPtr)SlogDlogGetAttr},    {"DlogSetAttr", (ArgPtr)SlogDlogSetAttr},
    {"DlogVaList", (ArgPtr)SlogDlogVaList},      {"DlogFlush", (ArgPtr)SlogDlogFlush},
};

void* logDlopen(const char* fileName, int mode)
{
    if (strcmp(fileName, "libascend_hal.so") == 0) {
        return &g_handle; // not NULL
    }
    if (strcmp(fileName, "libslog.so") == 0) {
        return &g_handle; // not NULL
    }
    return NULL;
}

int logDlclose(void* handle) { return 0; }

void* logDlsym(void* handle, const char* funcName)
{
    for (int32_t i = 0; i < MAP_SIZE; i++) {
        if (strcmp(funcName, g_drvMap[i].symbol) == 0) {
            return g_drvMap[i].handle;
        }
    }
    for (int32_t i = 0; i < DLOG_FUNC_MAX; i++) {
        if (strcmp(funcName, g_slogFuncMap[i].symbol) == 0) {
            return g_slogFuncMap[i].handle;
        }
    }
    return NULL;
}

int32_t GetSlogFuncCallCount(int32_t index) { return g_slogFuncCount[index]; }

int32_t shmget(key_t key, size_t size, int32_t shmflg)
{
    int32_t shmemId = 1;
    return shmemId;
}

void* shmat(int32_t shmid, const void* shmaddr, int32_t shmflg) { return (void*)1; }

int32_t shmdt(const void* shmaddr)
{
    return 0; // succeed
}

int32_t shmctl(int32_t shmid, int32_t cmd, struct shmid_ds* buf)
{
    return 0; // succeed
}

static uint8_t g_msgType = MSGTYPE_TAG;
void SetShmem(uint8_t msgType) { g_msgType = msgType; }

ShmErr ShMemRead_stub(int32_t shmId, char* value, size_t len, size_t offset)
{
    if (offset == CONFIG_PATH_LEN) {
        if (g_msgType == MSGTYPE_STRUCT) {
            GloablArr global;
            (void)memset_s(&global, sizeof(GloablArr), 0, sizeof(GloablArr));
            global.magicHead = MAGIC_HEAD;
            global.magicTail = MAGIC_TAIL;
            global.msgType = MSGTYPE_STRUCT;
            memcpy_s(value, len, (const char*)&global, sizeof(GloablArr));
            return SHM_SUCCEED;
        } else {
            return SHM_ERROR;
        }
    }

    return SHM_ERROR;
}

int32_t CreatSocket_stub(uint32_t devId)
{
    int32_t fd = open(PATH_ROOT "/socket/rc_alog_socket", O_CREAT | O_WRONLY);
    return fd;
}