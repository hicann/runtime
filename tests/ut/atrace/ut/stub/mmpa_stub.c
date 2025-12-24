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
#include <dlfcn.h>
#include "ascend_hal.h"

#define MAP_SIZE 3U
int32_t g_drvHandle = 0;
typedef void* ArgPtr;
typedef struct {
    const char *symbol;
    ArgPtr handle;
} SymbolInfo;

static SymbolInfo g_drvMap[MAP_SIZE] = {
    { "drvGetPlatformInfo", (void *)drvGetPlatformInfo },
    { "drvGetDevNum", (void *)drvGetDevNum },
    { "halGetAPIVersion", (void *)halGetAPIVersion },
};

void * mmDlopen(const char *fileName, int mode)
{
    if (strcmp(fileName, "libascend_hal.so") == 0)
    {
        return &g_drvHandle;
    }
    return NULL;
}

int32_t mmDlclose(void *handle)
{
    return 0;
}

void *mmDlsym(void *handle, const char* funcName)
{
    for (int32_t i = 0; i < MAP_SIZE; i++) {
        if (strcmp(funcName, g_drvMap[i].symbol) == 0) {
            return g_drvMap[i].handle;
        }
    }
    return NULL;
}

int32_t mmGetErrorCode()
{
    return 0;
}

int32_t mmMutexInit(mmMutex_t *lock)
{
    if (lock == NULL) {
        return -1;
    }

    int32_t ret = pthread_mutex_init(lock, NULL);
    if (ret != 0) {
        ret = -1;
    }

    return ret;
}
 
int32_t mmMutexDestroy(mmMutex_t *lock)
{
    if (lock == NULL) {
        return -1;
    }

    INT32 ret = pthread_mutex_destroy(lock);
    if (ret != 0) {
        ret = -1;
    }

    return ret;
}
 
int32_t mmMutexLock(mmMutex_t *lock)
{
    if (lock == NULL) {
        return -1;
    }

    int32_t ret = pthread_mutex_lock(lock);
    if (ret != 0) {
        ret = -1;
    }

    return ret;
}
 
int32_t mmMutexUnLock(mmMutex_t *lock)
{
    if (lock == NULL) {
        return -1;
    }

    int32_t ret = pthread_mutex_unlock(lock);
    if (ret != 0) {
        ret = -1;
    }

    return ret;
}

int32_t mmRmdir(const char *pathName)
{
    char cmd[1024] = { 0 };
    snprintf_s(cmd, 1024, 1023, "rm -rf %s", pathName);
    system(cmd);
    return 0;
}

mmTimespec mmGetTickCount(VOID)
{
    mmTimespec rts = {0};
    struct timespec ts = {0};
    (VOID)clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
    rts.tv_sec = ts.tv_sec;
    rts.tv_nsec = ts.tv_nsec;
    return rts;
}

INT32 mmGetTimeOfDay(mmTimeval *timeVal, mmTimezone *timeZone)
{
    if (timeVal == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = gettimeofday((struct timeval *)timeVal, (struct timezone *)timeZone);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

INT32 mmLocalTimeR(const time_t *timep, struct tm *result)
{
    if ((timep == NULL) || (result == NULL)) {
        return EN_INVALID_PARAM;
    } else {
        time_t ts = *timep;
        struct tm nowTime = {0};
        const struct tm *tmp = localtime_r(&ts, &nowTime);
        if (tmp == NULL) {
            return EN_ERROR;
        }

        result->tm_year = nowTime.tm_year + MMPA_COMPUTER_BEGIN_YEAR;
        result->tm_mon = nowTime.tm_mon + 1;
        result->tm_mday = nowTime.tm_mday;
        result->tm_hour = nowTime.tm_hour;
        result->tm_min = nowTime.tm_min;
        result->tm_sec = nowTime.tm_sec;
    }
    return EN_OK;
}

INT32 mmRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    strcpy(realPath, path);
    return EN_OK;
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

int mmGetPid()
{
    return getpid();
}

static int32_t LocalSetSchedThreadAttr(pthread_attr_t *attr, const mmThreadAttr *threadAttr)
{
    // set PTHREAD_EXPLICIT_SCHED
    if ((threadAttr->policyFlag == TRUE) || (threadAttr->priorityFlag == TRUE)) {
        if (pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED) != 0) {
            return -1;
        }
    }

    // set schedule policy
    if (threadAttr->policyFlag == TRUE) {
        if ((threadAttr->policy != MMPA_THREAD_SCHED_FIFO) && (threadAttr->policy != MMPA_THREAD_SCHED_OTHER) &&
            (threadAttr->policy != MMPA_THREAD_SCHED_RR)) {
            return -1;
        }
        if (pthread_attr_setschedpolicy(attr, threadAttr->policy) != 0) {
            return -1;
        }
    }

    // set priority
    if (threadAttr->priorityFlag == TRUE) {
        if ((threadAttr->priority < MMPA_MIN_THREAD_PIO) || (threadAttr->priority > MMPA_MAX_THREAD_PIO)) {
            return -1;
        }
        struct sched_param param;
        (void)memset_s(&param, sizeof(param), 0, sizeof(param));
        param.sched_priority = threadAttr->priority;
        if (pthread_attr_setschedparam(attr, &param) != 0) {
            return -1;
        }
    }

    return 0;
}

static int32_t LocalSetToolThreadAttr(pthread_attr_t *attr, const mmThreadAttr *threadAttr)
{
    // set thread schedule attribute
    int32_t ret = LocalSetSchedThreadAttr(attr, threadAttr);
    if (ret != 0) {
        return ret;
    }

    // set thread stack
    if (threadAttr->stackFlag == TRUE) {
        if (threadAttr->stackSize < MMPA_THREAD_MIN_STACK_SIZE) {
            return -1;
        }
        if (pthread_attr_setstacksize(attr, threadAttr->stackSize) != 0) {
            return -1;
        }
    }
    if (threadAttr->detachFlag == TRUE) {
        // set default detach state
        if (pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED) != 0) {
            return -1;
        }
    }
    return 0;
}

int32_t mmCreateTaskWithThreadAttr(mmThread *threadHandle, const mmUserBlock_t *funcBlock,
    const mmThreadAttr *threadAttr)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) ||
        (funcBlock->procFunc == NULL) || (threadAttr == NULL)) {
        return -1;
    }

    pthread_attr_t attr;
    (void)memset_s(&attr, sizeof(attr), 0, sizeof(attr));

    // init thread attribute
    int32_t ret = pthread_attr_init(&attr);
    if (ret != 0) {
        return -1;
    }

    ret = LocalSetToolThreadAttr(&attr, threadAttr);
    if (ret != 0) {
        (void)pthread_attr_destroy(&attr);
        return ret;
    }

    ret = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (void)pthread_attr_destroy(&attr);
    if (ret != 0) {
        ret = -1;
    }
    return ret;
}

int32_t mmJoinTask(mmThread *threadHandle)
{
    if (threadHandle == NULL) {
        return -1;
    }

    return pthread_join(*threadHandle, NULL);
}

int32_t mmSetCurrentThreadName(const char* name)
{
    if (name == NULL) {
        return EN_INVALID_PARAM;
    }
    signed int ret = prctl(PR_SET_NAME, name);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

int32_t mmCondInit(mmCond *cond)
{
    pthread_condattr_t condAttr;
    pthread_condattr_init(&condAttr);
    pthread_condattr_setclock(&condAttr, CLOCK_MONOTONIC);
    pthread_cond_init(cond, &condAttr);
    pthread_condattr_destroy(&condAttr);
    return 0;
}

int32_t mmCondNotify(mmCond *cond)
{
    return pthread_cond_signal(cond);
}

int32_t mmCondTimedWait(mmCond *cond, mmMutexFC *mutex, uint32_t milliSecond)
{
    struct timespec tmpTime = {0};
    clock_gettime(CLOCK_MONOTONIC, &tmpTime);
    tmpTime.tv_nsec += (milliSecond % 1000) * 1000000;
    tmpTime.tv_sec += milliSecond / 1000 + tmpTime.tv_nsec / 1000000000;
    tmpTime.tv_nsec %= 1000000000;
    return pthread_cond_timedwait(cond, mutex, &tmpTime);
}

int32_t mmSocket(int32_t sockFamily, int32_t type, int32_t protocol)
{
    int32_t socketHandle = socket(sockFamily, type, protocol);
    if (socketHandle < MMPA_ZERO) {
        return EN_ERROR;
    }
    return socketHandle;
}
 
int32_t mmBind(mmSockHandle sockFd, mmSockAddr * addr, mmSocklen_t addrLen)
{
    if ((sockFd < MMPA_ZERO) || (addr == NULL) || (addrLen == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
 
    int32_t ret = bind(sockFd, addr, addrLen);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}
 
int32_t mmConnect(mmSockHandle sockFd, mmSockAddr * addr, mmSocklen_t addrLen)
{
    if ((sockFd < MMPA_ZERO) || (addr == NULL) || (addrLen == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
 
    int32_t ret = connect(sockFd, addr, addrLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return EN_OK;
}
 
int32_t mmCloseSocket(mmSockHandle sockFd)
{
    if (sockFd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
 
    int32_t ret = close(sockFd);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

int32_t mmDladdr(void *addr, mmDlInfo *info)
{
    info->dli_fname = "/tmp/libascend_trace.so";
    return 0;
}

char *mmDlerror(void) {
  return dlerror();
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
    return NULL;
}

CHAR *mmSysGetEnv(mmEnvId id)
{
    mmEnvInfo *envInfo = GetEnvInfoById(id);
    if (NULL != envInfo) {
        return getenv(envInfo->name);
    }
    return NULL;
}

INT32 mmSysSetEnv(mmEnvId id, const CHAR *value, INT32 overwrite)
{
    mmEnvInfo *envInfo = GetEnvInfoById(id);
    if (NULL == envInfo) {
        return EN_INVALID_PARAM;
    }
    return setenv(envInfo->name, value, overwrite);
}