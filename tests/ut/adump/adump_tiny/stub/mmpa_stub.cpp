/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mmpa_api.h"
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int g_mmSemwait_time = 0;
int g_ide_create_task_time = 0;
int g_mmCreateTaskWitchDeatchFlag = 0;
int g_mmCreateTaskFlag=0;
int g_mmCreateTaskWithDetachTime = 0;
int g_mmCreateTaskWithDetachThreahHold = 0;
int g_ide_create_task_time_threadhold = 0;

INT32 mmCreateTask(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock)
{
    if(g_ide_create_task_time == 1)
    {
        return 0;
    }

    return 0;
}

INT32 mmCreateTaskWithDetach(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock)
{
    if(g_mmCreateTaskWitchDeatchFlag == 1)
    {
        return 0;
    } else if(g_mmCreateTaskWitchDeatchFlag == 2)
    {
        return -1;
    }
    return 0;
}

INT32 mmCreateTaskWithThreadAttr(mmThread *threadHandle, const mmUserBlock_t *funcBlock, const mmThreadAttr *threadAttr)
{
    if(g_ide_create_task_time == 1) {
        funcBlock->procFunc(funcBlock->pulArg);
        return 0;
    }

    return 0;
}

INT32 mmCreateTaskWithThreadAttr_stub(mmThread *threadHandle, const mmUserBlock_t *funcBlock, const mmThreadAttr *threadAttr)
{
    g_ide_create_task_time++;
    if(g_ide_create_task_time < g_ide_create_task_time_threadhold)
    {
        return 0;
    } else {
        return -1;
    }
}

INT32 mmJoinTask( mmThread *pstThreadHandle)
{
    return 0;
}

INT32 mmSetCurrentThreadName(const CHAR* name)
{
    return EN_OK;
}

INT32 mmGetCwd(CHAR *buffer, INT32 maxLen)
{
    CHAR *ptr = getcwd(buffer, (UINT32)maxLen);
    if (ptr != NULL) {
        return EN_OK;
    } else {
        return EN_ERROR;
    }
    return 0;
}

INT32 mmGetTid(void)
{
    INT32 ret = (INT32)syscall(SYS_gettid);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

INT32 mmGetTimeOfDay(mmTimeval *timeVal, mmTimezone *timeZone)
{
    return gettimeofday((struct timeval *)timeVal, (struct timezone *)timeZone);
}

INT32 mmAccess2(const CHAR *pathName, INT32 mode)
{
    if (pathName == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = access(pathName, mode);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmIsDir(const CHAR *fileName)
{
    if (fileName == NULL) {
        return EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (VOID)memset_s(&fileStat, sizeof(fileStat), 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    INT32 ret = lstat(fileName, &fileStat);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    if (S_ISDIR(fileStat.st_mode) == 0) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    if ((path == nullptr) || (realPath == nullptr)) {
        return EN_INVALID_PARAM;
    }

    CHAR *ret = realpath(path, realPath);
    if (ret == nullptr) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmMkdir(const CHAR *pathName, mmMode_t mode)
{
    mode_t oldMask;
    oldMask = umask(0);
    INT32 ret = mkdir(pathName, mode);
    umask(oldMask);
    return ret;
}

INT32 mmOpen2(const char *pathName, INT32 flags, MODE mode)
{
    int ret;
    mode_t old_mask;
    old_mask = umask(0);
    ret = open(pathName, flags, mode);
    umask(old_mask);
    return ret;
}

INT32 mmClose(INT32 fd)
{
    return close(fd);
}

mmSsize_t mmWrite(INT32 fd, VOID* mmBuf, UINT32 mmCount)
{
    return write(fd, mmBuf, mmCount);
}

mmSsize_t mmRead(INT32 fd, VOID* mmBuf, UINT32 mmCount)
{
    return read(fd, mmBuf, mmCount);
}

INT32 mmGetEnv(const CHAR *name, CHAR *value, UINT32 len)
{
    INT32 ret;
    UINT32 envLen = 0;
    if ((name == NULL) || (value == NULL) || (len == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    CHAR *envPtr = getenv(name);
    if (envPtr == NULL) {
        return EN_ERROR;
    }

    UINT32 lenOfRet = (UINT32)strlen(envPtr);
    if (lenOfRet < (MMPA_MEM_MAX_LEN - 1)) {
        envLen = lenOfRet + 1;
    }

    if (envLen != MMPA_ZERO && len < envLen) {
        return EN_INVALID_PARAM;
    } else {
        ret = memcpy_s(value, len, envPtr, envLen); //lint !e613
        if (ret != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

INT32 mmGetErrorCode()
{
    INT32 ret = (INT32)errno;
    return ret;
}

INT32 mmGetPid()
{
    return 12345;
}

mmTimespec mmGetTickCount()
{
    mmTimespec rts = {0};
    struct timespec ts = {0};
    (void)clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
    rts.tv_sec = ts.tv_sec;
    rts.tv_nsec = ts.tv_nsec;
    return rts;
}

INT32 mmChmod(const CHAR *filename, INT32 mode)
{
    return 0;
}

INT32 mmDladdr(void *addr, mmDlInfo *info)
{
    info->dli_fname = "/tmp/dl_addr_stub";
    return 0;
}

CHAR *mmGetErrorFormatMessage(mmErrorMsg errnum, CHAR *buf, mmSize size) {
    return "unknow error!";
}

LONG mmLseek(INT32 fd, INT64 offset, INT32 seekFlag)
{
    return 0;
}

INT32 mmAccess(const CHAR *pathName)
{
    return EN_OK;
}

INT32 mmGetDiskFreeSpace(const char* path, mmDiskSize *diskSize)
{
    diskSize->availSize = 10;
    diskSize->freeSize = 10;
    return EN_OK;
}

INT32 mmSleep(UINT32 millseconds)
{
    return 0;
}

typedef struct {
    mmEnvId id;
    const CHAR *name;
} mmEnvInfo;

static mmEnvInfo s_envList[] = {
    {MM_ENV_DUMP_GRAPH_PATH, "DUMP_GRAPH_PATH"},
    {MM_ENV_ACLNN_CACHE_LIMIT, "ACLNN_CACHE_LIMIT"},
    {MM_ENV_ASCEND_WORK_PATH, "ASCEND_WORK_PATH"},
    {MM_ENV_ASCEND_HOSTPID, "ASCEND_HOSTPID"},
    {MM_ENV_RANK_ID, "RANK_ID"},
    {MM_ENV_ASCEND_RT_VISIBLE_DEVICES, "ASCEND_RT_VISIBLE_DEVICES"},
    {MM_ENV_ASCEND_COREDUMP_SIGNAL, "ASCEND_COREDUMP_SIGNAL"},
    {MM_ENV_ASCEND_CACHE_PATH, "ASCEND_CACHE_PATH"},
    {MM_ENV_ASCEND_OPP_PATH, "ASCEND_OPP_PATH"},
    {MM_ENV_ASCEND_CUSTOM_OPP_PATH, "ASCEND_CUSTOM_OPP_PATH"},
    {MM_ENV_ASCEND_LOG_DEVICE_FLUSH_TIMEOUT, "ASCEND_LOG_DEVICE_FLUSH_TIMEOUT"},
    {MM_ENV_ASCEND_LOG_SAVE_MODE, "ASCEND_LOG_SAVE_MODE"},
    {MM_ENV_ASCEND_SLOG_PRINT_TO_STDOUT, "ASCEND_SLOG_PRINT_TO_STDOUT"},
    {MM_ENV_ASCEND_GLOBAL_EVENT_ENABLE, "ASCEND_GLOBAL_EVENT_ENABLE"},
    {MM_ENV_ASCEND_GLOBAL_LOG_LEVEL, "ASCEND_GLOBAL_LOG_LEVEL"},
    {MM_ENV_ASCEND_MODULE_LOG_LEVEL, "ASCEND_MODULE_LOG_LEVEL"},
    {MM_ENV_ASCEND_HOST_LOG_FILE_NUM, "ASCEND_HOST_LOG_FILE_NUM"},
    {MM_ENV_ASCEND_PROCESS_LOG_PATH, "ASCEND_PROCESS_LOG_PATH"},
    {MM_ENV_ASCEND_LOG_SYNC_SAVE, "ASCEND_LOG_SYNC_SAVE"},
    {MM_ENV_PROFILER_SAMPLECONFIG, "PROFILER_SAMPLECONFIG"},
    {MM_ENV_ACP_PIPE_FD, "ACP_PIPE_FD"},
    {MM_ENV_PROFILING_MODE, "PROFILING_MODE"},
    {MM_ENV_DYNAMIC_PROFILING_KEY_PID, "DYNAMIC_PROFILING_KEY_PID"},
    {MM_ENV_HOME, "HOME"},
    {MM_ENV_AOS_TYPE, "AOS_TYPE"},
    {MM_ENV_LD_LIBRARY_PATH, "LD_LIBRARY_PATH"},
};

static mmEnvInfo *GetEnvInfoById(mmEnvId id)
{
    ULONG i = 0;
    for (i = 0; i < sizeof(s_envList)/sizeof(s_envList[0]); ++i) {
        if (s_envList[i].id == id) {
            return &s_envList[i];
        }
    }
    return nullptr;
}

CHAR *mmSysGetEnv(mmEnvId id)
{
    mmEnvInfo *envInfo = GetEnvInfoById(id);
    if (envInfo != nullptr) {
        return getenv(envInfo->name);
    }
    return nullptr;
}

INT32 mmSysSetEnv(mmEnvId id, const CHAR *value, INT32 overwrite)
{
    mmEnvInfo *envInfo = GetEnvInfoById(id);
    if (envInfo == nullptr) {
        return EN_INVALID_PARAM;
    }
    return setenv(envInfo->name, value, overwrite);
}

INT32 mmStatGet(const CHAR *path, mmStat_t *buffer)
{
    if ((path == NULL) || (buffer == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = stat(path, buffer);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}