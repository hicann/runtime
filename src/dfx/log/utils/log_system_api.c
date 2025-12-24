/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_system_api.h"

#if (OS_TYPE_DEF == LINUX)
#include <sys/prctl.h>

#define SYS_SECOND_TO_MSEC                     1000
#define SYS_MSEC_TO_NSEC                       1000000
#define SYS_SECOND_TO_NSEC                     1000000000

INT32 ToolSetThreadName(const char *threadName)
{
    return (prctl(PR_SET_NAME, (unsigned long)(uintptr_t)threadName) == EOK) ? SYS_OK : SYS_ERROR;
}

/*
 * @brief: init mutex with default attribute
 * @param [in]mutex: ToolMutex struct pointer
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: param invalid;
 */
INT32 ToolMutexInit(ToolMutex *mutex)
{
    if (mutex == NULL) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = pthread_mutex_init(mutex, NULL);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }

    return ret;
}

/*
 * @brief: lock mutex, need to free lock by ToolMutexUnLock
 * @param [in]mutex: ToolMutex struct pointer
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: param invalid;
 */
INT32 ToolMutexLock(ToolMutex *mutex)
{
    if (mutex == NULL) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = pthread_mutex_lock(mutex);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }

    return ret;
}

/*
 * @brief: unlock mutex, the mutex must has bean locked
 * @param [in]mutex: ToolMutex struct pointer
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: param invalid;
 */
INT32 ToolMutexUnLock(ToolMutex *mutex)
{
    if (mutex == NULL) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = pthread_mutex_unlock(mutex);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }

    return ret;
}

/*
 * @brief: delete mutex which created by ToolMutexInit
 * @param [in]mutex: ToolMutex struct pointer
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: param invalid;
 */
INT32 ToolMutexDestroy(ToolMutex *mutex)
{
    if (mutex == NULL) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = pthread_mutex_destroy(mutex);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }

    return ret;
}

/*
 * @brief: set thread schedule attribute
 * @param [in]attr: thread attribute struct
 * @param [in]threadAttr: thread attribute, include shcedule policy, priority, stack
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: param invalid;
 */
STATIC INT32 LocalSetSchedThreadAttr(pthread_attr_t *attr, const ToolThreadAttr *threadAttr)
{
    // set PTHREAD_EXPLICIT_SCHED
    if ((threadAttr->policyFlag == TRUE) || (threadAttr->priorityFlag == TRUE)) {
        if (pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED) != SYS_OK) {
            return SYS_ERROR;
        }
    }

    // set schedule policy
    if (threadAttr->policyFlag == TRUE) {
        if ((threadAttr->policy != TOOL_THREAD_SCHED_FIFO) && (threadAttr->policy != TOOL_THREAD_SCHED_OTHER) &&
            (threadAttr->policy != TOOL_THREAD_SCHED_RR)) {
            return SYS_INVALID_PARAM;
        }
        if (pthread_attr_setschedpolicy(attr, threadAttr->policy) != SYS_OK) {
            return SYS_ERROR;
        }
    }

    // set priority
    if (threadAttr->priorityFlag == TRUE) {
        if ((threadAttr->priority < TOOL_MIN_THREAD_PIO) || (threadAttr->priority > TOOL_MAX_THREAD_PIO)) {
            return SYS_INVALID_PARAM;
        }
        struct sched_param param;
        (void)memset_s(&param, sizeof(param), 0, sizeof(param));
        param.sched_priority = threadAttr->priority;
        if (pthread_attr_setschedparam(attr, &param) != SYS_OK) {
            return SYS_ERROR;
        }
    }

    return SYS_OK;
}

/*
 * @brief: set thread attribute, include schedule policy, priority, stack
 * @param [in]attr: thread attribute struct
 * @param [in]threadAttr: thread attribute, include shcedule policy, priority, stack
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: param invalid;
 */
STATIC INT32 LocalSetToolThreadAttr(pthread_attr_t *attr, const ToolThreadAttr *threadAttr)
{
    // set thread schedule attribute
    INT32 ret = LocalSetSchedThreadAttr(attr, threadAttr);
    if (ret != SYS_OK) {
        return ret;
    }

    // set thread stack
    if (threadAttr->stackFlag == TRUE) {
        if (threadAttr->stackSize < TOOL_THREAD_MIN_STACK_SIZE) {
            return SYS_INVALID_PARAM;
        }
        if (pthread_attr_setstacksize(attr, threadAttr->stackSize) != SYS_OK) {
            return SYS_ERROR;
        }
    }
    if (threadAttr->detachFlag == TRUE) {
        // set default detach state
        if (pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED) != SYS_OK) {
            return SYS_ERROR;
        }
    }
    return SYS_OK;
}

/*
 * @brief: create thread with thread attribute
 * @param [in]threadHandle: pthread_t object
 * @param [in]funcBlock: function info
 * @param [in]threadAttr: thread attr
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: param invalid;
 */
INT32 ToolCreateTaskWithThreadAttr(ToolThread *threadHandle, const ToolUserBlock *funcBlock,
                                   const ToolThreadAttr *threadAttr)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) ||
        (funcBlock->procFunc == NULL) || (threadAttr == NULL)) {
        return SYS_INVALID_PARAM;
    }

    pthread_attr_t attr;
    (void)memset_s(&attr, sizeof(attr), 0, sizeof(attr));

    // init thread attribute
    INT32 ret = pthread_attr_init(&attr);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }

    ret = LocalSetToolThreadAttr(&attr, threadAttr);
    if (ret != SYS_OK) {
        (void)pthread_attr_destroy(&attr);
        return ret;
    }

    ret = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (void)pthread_attr_destroy(&attr);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }
    return ret;
}

/*
 * @brief: create thread with datach
 * @param [in]threadHandle: pthread_t object
 * @param [in]funcBlock: function info
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: param invalid;
 */
INT32 ToolCreateTaskWithDetach(ToolThread *threadHandle, const ToolUserBlock *funcBlock)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) || (funcBlock->procFunc == NULL)) {
        return SYS_INVALID_PARAM;
    }
    pthread_attr_t attr;
    (void)memset_s(&attr, sizeof(attr), 0, sizeof(attr));

    // init thread attribute
    INT32 ret = pthread_attr_init(&attr);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    // set default detach state
    ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
    if (ret != SYS_OK) {
        (void)pthread_attr_destroy(&attr);
        return SYS_ERROR;
    }

    ret = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (void)pthread_attr_destroy(&attr);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }
    return ret;
}

/*
 * @brief: open or create file
 * @param [in]pathName: file absolute path
 * @param [in]flags: file mode
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolOpen(const CHAR *pathName, INT32 flags)
{
    if ((pathName == NULL) || (flags < 0)) {
        return SYS_INVALID_PARAM;
    }

    UINT32 tmp = (UINT32)flags;
    if (((tmp & (O_TRUNC | O_WRONLY | O_RDWR | O_CREAT)) == 0) && (flags != O_RDONLY)) {
        return SYS_INVALID_PARAM;
    }
    // default user and group 770
    INT32 fd = open(pathName, flags, S_IRWXU | S_IRWXG);
    if (fd < 0) {
        return SYS_ERROR;
    }
    return fd;
}

/*
 * @brief: open or create file with mode
 * @param [in]pathName: file absolute path
 * @param [in]flags: file mode
 * @param [in]mode: setting mode
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolOpenWithMode(const CHAR *pathName, INT32 flags, toolMode mode)
{
    if ((pathName == NULL) || (flags < 0)) {
        return SYS_INVALID_PARAM;
    }

    UINT32 tmp = (UINT32)flags;
    if (((tmp & (O_TRUNC | O_WRONLY | O_RDWR | O_CREAT)) == 0) && (flags != O_RDONLY)) {
        return SYS_INVALID_PARAM;
    }
    // default user 600
    if (((mode & (S_IRUSR | S_IREAD)) == 0) &&
        ((mode & (S_IWUSR | S_IWRITE)) == 0)) {
        return SYS_INVALID_PARAM;
    }

    INT32 fd = open(pathName, flags, mode);
    if (fd < 0) {
        return SYS_ERROR;
    }
    return fd;
}

/*
 * @brief: close file
 * @param [in]fd: file handle
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolClose(INT32 fd)
{
    if (fd < 0) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = close(fd);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: write buf to file
 * @param [in]fd: file handle
 * @param [in]buf: data buffer
 * @param [in]bufLen: data buffer length
 * @return: buffer length with write; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolWrite(INT32 fd, const VOID *buf, UINT32 bufLen)
{
    if ((fd < 0) || (buf == NULL)) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = (INT32)write(fd, buf, (size_t)bufLen);
    if (ret < 0) {
        return SYS_ERROR;
    }
    return ret;
}

/*
 * @brief: read data from file
 * @param [in]fd: file handle
 * @param [in]buf: read data buffer
 * @param [in]bufLen: read data length
 * @return: buffer length with read; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolRead(INT32 fd, VOID *buf, UINT32 bufLen)
{
    if ((fd < 0) || (buf == NULL)) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = (INT32)read(fd, buf, (size_t)bufLen);
    if (ret < 0) {
        return SYS_ERROR;
    }
    return ret;
}

/*
 * @brief: create directory
 * @param [in]pathName: directory path name
 * @param [in]mode: new directory mode
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolMkdir(const CHAR *pathName, toolMode mode)
{
    if (pathName == NULL) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = mkdir(pathName, mode);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: remove directory
 * @param [in]pathName: directory path name
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolRmdir(const CHAR *pathName)
{
    if (pathName == NULL) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = rmdir(pathName);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: rename file
 * @param [in]oldName: old file name
 * @param [in]newName: new file name
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolRename(const CHAR *oldName, const CHAR *newName)
{
    if ((oldName == NULL) || (newName == NULL)) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = rename(oldName, newName);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: determine the file priority or if the file exists
 * @param [in]pathName: directory path name
 * @param [in]mode: file mode
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolAccessWithMode(const CHAR *pathName, INT32 mode)
{
    if (pathName == NULL) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = access(pathName, mode);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: determine if the file directory exists
 * @param [in]pathName: directory path name
 * @return: SYS_OK: succeed; SYS_ERROR: failed;
 */
INT32 ToolAccess(const CHAR *pathName)
{
    return ToolAccessWithMode(pathName, F_OK);
}

/*
 * @brief: get file absolute path
 * @param [in]path: original path
 * @param [in]realPath: absolute path
 * @param [in]realPathLen: absolute path length
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    if ((realPath == NULL) || (path == NULL) || (realPathLen < TOOL_MAX_PATH)) {
        return SYS_INVALID_PARAM;
    }

    const CHAR *ptr = realpath(path, realPath);
    if (ptr == NULL) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: delete file, delete one reference
 * @param [in]filename: file path
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolUnlink(const CHAR *filename)
{
    if (filename == NULL) {
        return SYS_INVALID_PARAM;
    }

    return unlink(filename);
}

/*
 * @brief: modify file mode, only support read and write mode
 * @param [in]filename: file path
 * @param [in]mode: new file mode
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolChmod(const CHAR *filename, INT32 mode)
{
    if ((filename == NULL) || (strlen(filename) == 0)) {
        return SYS_INVALID_PARAM;
    }

    return chmod(filename, (mode_t)mode);
}

/*
 * @brief: modify file owner
 * @param [in]filename: file path
 * @param [in]owner: new file mode owner uid
 * @param [in]owner: new file mode group uid
 * @return: SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolChown(const char *filename, uid_t owner, gid_t group)
{
    if (filename == NULL) {
        return SYS_INVALID_PARAM;
    }

    return chown(filename, owner, group);
}

/*
 * @brief: scandir directory, get all subdirectory
 * @param [in]path: directory path
 * @param [in]entryList: directory structure pointer, it's malloced in the function,
                         and need to free it with the function 'ToolScandirFree'
 * @param [in]filterFunc: filter callback function
 * @param [in]sort: sort callback function
 * @return: subdirectory size; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolScandir(const CHAR *path, ToolDirent ***entryList, ToolFilter filterFunc, ToolSort sort)
{
    if ((path == NULL) || (entryList == NULL)) {
        return SYS_INVALID_PARAM;
    }

    INT32 count = scandir(path, entryList, filterFunc, sort);
    if (count < 0) {
        return SYS_ERROR;
    }
    return count;
}

/*
 * @brief: free scandir directory memory
 * @param [in]entryList: directory structure pointer
 * @param [in]count: subdirectory size
 */
VOID ToolScandirFree(ToolDirent **entryList, INT32 count)
{
    if (entryList == NULL) {
        return;
    }

    INT32 j;
    for (j = 0; j < count; j++) {
        if (entryList[j] != NULL) {
            free(entryList[j]);
            entryList[j] = NULL;
        }
    }
    free(entryList);
}

/*
 * @brief: get file state
 * @param [in]path: file path
 * @param [in]buffer: file state buffer, need user to malloc
 * @return SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolStatGet(const CHAR *path,  ToolStat *buffer)
{
    if ((path == NULL) || (buffer == NULL)) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = stat(path, buffer);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: sync buffer to the file
 * @param [in]fd: file handle
 * @return SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolFsync(toolProcess fd)
{
    if (fd == 0) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = fsync(fd);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: get file handle by file stream
 * @param [in]stream: file stream pointer
 * @return file handle; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolFileno(FILE *stream)
{
    if (stream == NULL) {
        return SYS_INVALID_PARAM;
    }

    return fileno(stream);
}

/*
 * @brief: create socket
 * @param [in]sockFamily: socket protocol family
 * @param [in]type: socket type
 * @param [in]protocol: socket protocol
 * @return socket handle; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
toolSockHandle ToolSocket(INT32 sockFamily, INT32 type, INT32 protocol)
{
    INT32 socketHandle = socket(sockFamily, type, protocol);
    if (socketHandle < 0) {
        return SYS_ERROR;
    }
    return socketHandle;
}

/*
 * @brief: bind socket with address
 * @param [in]sockFd: socket id
 * @param [in]addr: address to bind
 * @param [in]addrLen: address length
 * @return SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolBind(toolSockHandle sockFd, const ToolSockAddr *addr, toolSocklen addrLen)
{
    if ((sockFd < 0) || (addr == NULL) || (addrLen == 0)) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = bind(sockFd, addr, addrLen);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: send connect request to the address
 * @param [in]sockFd: socket id
 * @param [in]addr: server address
 * @param [in]addrLen: address length
 * @return SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolConnect(toolSockHandle sockFd, const ToolSockAddr *addr, toolSocklen addrLen)
{
    if ((sockFd < 0) || (addr == NULL) || (addrLen == 0)) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = connect(sockFd, addr, addrLen);
    if (ret < 0) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: close socket by socket id
 * @param [in]sockFd: socket id
 * @return SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolCloseSocket(toolSockHandle sockFd)
{
    if (sockFd < 0) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = close(sockFd);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: get process id
 * @return process id; SYS_ERROR: failed;
 */
INT32 ToolGetPid(void)
{
    return (INT32)getpid();
}

/*
 * @brief: sleep
 * @param [in]milliSecond: sleep time, unit: ms, linux support max 4294967 ms
 * @return SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolSleep(UINT32 milliSecond)
{
    if (milliSecond == 0) {
        return SYS_INVALID_PARAM;
    }

    UINT32 microSecond;
    if (milliSecond <= TOOL_MAX_SLEEP_MILLSECOND) {
        microSecond = milliSecond * ((unsigned int)TOOL_ONE_THOUSAND);
    } else {
        microSecond = 0xffffffffU;
    }

    INT32 ret = usleep(microSecond);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

/*
 * @brief: create memmory barrier
 */
VOID ToolMemBarrier(void)
{
    __asm__ __volatile__ ("" : : : "memory");
}

/*
 * @brief: get system error code
 * @return error code;
 */
INT32 ToolGetErrorCode(void)
{
    return (INT32)errno;
}

/*
 * @brief: get system time and time zone
 * @param [in]timeVal: system time, not NULL
 * @param [in]timeZone: system zone, NULL is available
 * @return SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolGetTimeOfDay(ToolTimeval *timeVal, ToolTimezone *timeZone)
{
    if (timeVal == NULL) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = gettimeofday((struct timeval *)timeVal, (struct timezone *)timeZone);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }
    return ret;
}

/*
 * @brief: change time to local time format
 * @param [in]timep: original time
 * @param [in]result: new time with format 'tm'
 * @return SYS_OK: succeed; SYS_ERROR: failed; SYS_INVALID_PARAM: invalid param;
 */
INT32 ToolLocalTimeR(const time_t *timep, struct tm *result)
{
    if ((timep == NULL) || (result == NULL)) {
        return SYS_INVALID_PARAM;
    } else {
        time_t stTime = *timep;
        struct tm nowTime = {0};
        const struct tm *tmp = localtime_r(&stTime, &nowTime);
        if (tmp == NULL) {
            return SYS_ERROR;
        }

        result->tm_year = nowTime.tm_year + TOOL_COMPUTER_BEGIN_YEAR;
        result->tm_mon = nowTime.tm_mon + 1;
        result->tm_mday = nowTime.tm_mday;
        result->tm_hour = nowTime.tm_hour;
        result->tm_min = nowTime.tm_min;
        result->tm_sec = nowTime.tm_sec;
        result->tm_isdst = nowTime.tm_isdst;
    }
    return SYS_OK;
}

INT32 ToolJoinTask(const ToolThread *threadHandle)
{
    if (threadHandle == NULL) {
        return SYS_INVALID_PARAM;
    }

    INT32 ret = pthread_join(*threadHandle, NULL);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }
    return ret;
}

INT32 ToolCondTimedWait(ToolCond *cond, ToolMutex *mutex, UINT32 milliSecond)
{
    if ((cond == NULL) || (mutex == NULL) || (milliSecond == 0)) {
        return SYS_INVALID_PARAM;
    }
    struct timespec absoluteTime = {0};
    INT32 ret = clock_gettime(CLOCK_MONOTONIC, &absoluteTime);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }

    absoluteTime.tv_sec = absoluteTime.tv_sec + ((LONG)milliSecond / SYS_SECOND_TO_MSEC);
    absoluteTime.tv_nsec = absoluteTime.tv_nsec +
                           (((LONG)milliSecond % SYS_SECOND_TO_MSEC) * SYS_MSEC_TO_NSEC);
    // 判断是否进位
    if (absoluteTime.tv_nsec > SYS_SECOND_TO_NSEC) {
        ++absoluteTime.tv_sec;
        absoluteTime.tv_nsec = absoluteTime.tv_nsec % SYS_SECOND_TO_NSEC;
    }

    return pthread_cond_timedwait(cond, mutex, &absoluteTime); // 睡眠相对时间
}

INT32 ToolCondInit(ToolCond *cond)
{
    if (cond == NULL) {
        return SYS_INVALID_PARAM;
    }
    pthread_condattr_t condAttr;
    // 初始化cond 属性
    INT32 ret = pthread_condattr_init(&condAttr);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    // 为了使 CondTimedWait 使用开机时间而不是系统当前时间
    ret = pthread_condattr_setclock(&condAttr, CLOCK_MONOTONIC);
    if (ret != SYS_OK) {
        (VOID)pthread_condattr_destroy(&condAttr);
        return SYS_ERROR;
    }

    // 使用带属性的初始化
    ret = pthread_cond_init(cond, &condAttr);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }
    (VOID)pthread_condattr_destroy(&condAttr);

    return ret;
}

INT32 ToolCondNotify(ToolCond *cond)
{
    if (cond == NULL) {
        return SYS_INVALID_PARAM;
    }
    INT32 ret = pthread_cond_signal(cond);
    if (ret != SYS_OK) {
        ret = SYS_ERROR;
    }
    return ret;
}

INT32 ToolGetUserGroupId(UINT32 *uid, UINT32 *gid)
{
    if ((uid == NULL) || (gid == NULL)) {
        return SYS_INVALID_PARAM;
    }

    const struct passwd *secuWord = getpwuid(getuid());
    if (secuWord != NULL) {
        *uid = secuWord->pw_uid;
        *gid = secuWord->pw_gid;
        return SYS_OK;
    } else {
        return SYS_ERROR;
    }
}

INT32 ToolChownPath(const CHAR *path)
{
    if ((path == NULL) || (strlen(path) == 0)) {
        return SYS_INVALID_PARAM;
    }

    uint32_t uid = 0;
    uint32_t gid = 0;
    INT32 ret = ToolGetUserGroupId(&uid, &gid);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }

    ret = ToolChown(path, uid, gid);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

INT32 ToolLChownPath(const CHAR *path)
{
    if ((path == NULL) || (strlen(path) == 0)) {
        return SYS_INVALID_PARAM;
    }

    uint32_t uid = 0;
    uint32_t gid = 0;
    INT32 ret = ToolGetUserGroupId(&uid, &gid);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }

    ret = lchown(path, uid, gid);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }
    return SYS_OK;
}

INT32 ToolFChownPath(INT32 fd)
{
    if (fd <= 0) {
        return SYS_INVALID_PARAM;
    }

    uint32_t uid = 0;
    uint32_t gid = 0;
    INT32 ret = ToolGetUserGroupId(&uid, &gid);
    if (ret != SYS_OK) {
        return SYS_ERROR;
    }

    ret = fchown(fd, uid, gid);
    if (ret < 0) {
        return SYS_ERROR;
    }
    return SYS_OK;
}
#else

INT32 ToolSetThreadName(const char *threadName)
{
    return (mmSetCurrentThreadName(threadName) == EN_OK) ? SYS_OK : SYS_ERROR;
}

INT32 ToolMutexInit(ToolMutex *mutex)
{
    return mmMutexInit((mmMutex_t *)mutex);
}

INT32 ToolMutexLock(ToolMutex *mutex)
{
    return mmMutexLock((mmMutex_t *)mutex);
}

INT32 ToolMutexUnLock(ToolMutex *mutex)
{
    return mmMutexUnLock((mmMutex_t *)mutex);
}

INT32 ToolMutexDestroy(ToolMutex *mutex)
{
    return mmMutexDestroy((mmMutex_t *)mutex);
}

INT32 ToolCreateTaskWithThreadAttr(ToolThread *threadHandle, const ToolUserBlock *funcBlock,
                                   const ToolThreadAttr *threadAttr)
{
    return mmCreateTaskWithThreadAttr((mmThread *)threadHandle, (const mmUserBlock_t *)funcBlock,
                                      (const mmThreadAttr *)threadAttr);
}

INT32 ToolCreateTaskWithDetach(ToolThread *threadHandle, ToolUserBlock *funcBlock)
{
    return mmCreateTaskWithDetach((mmThread *)threadHandle, (mmUserBlock_t *)funcBlock);
}

INT32 ToolOpen(const CHAR *pathName, INT32 flags)
{
    return mmOpen(pathName, flags);
}

INT32 ToolOpenWithMode(const CHAR *pathName, INT32 flags, toolMode mode)
{
    return mmOpen2(pathName, flags, (MODE)mode);
}

INT32 ToolClose(INT32 fd)
{
    return mmClose(fd);
}

INT32 ToolWrite(INT32 fd, VOID *buf, UINT32 bufLen)
{
    return mmWrite(fd, buf, bufLen);
}

INT32 ToolRead(INT32 fd, VOID *buf, UINT32 bufLen)
{
    return mmRead(fd, buf, bufLen);
}

INT32 ToolMkdir(const CHAR *pathName, toolMode mode)
{
    return mmMkdir(pathName, (mmMode_t)mode);
}

INT32 ToolRmdir(const CHAR *pathName)
{
    return mmRmdir(pathName);
}

INT32 ToolRename(const CHAR *oldName, const CHAR *newName)
{
    return SYS_OK;
}

INT32 ToolAccess(const CHAR *pathName)
{
    return mmAccess(pathName);
}

INT32 ToolAccessWithMode(const CHAR *pathName, INT32 mode)
{
    return mmAccess2(pathName, mode);
}

INT32 ToolRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    return mmRealPath(path, realPath, realPathLen);
}

INT32 ToolUnlink(const CHAR *filename)
{
    return mmUnlink(filename);
}

INT32 ToolChmod(const CHAR *filename, INT32 mode)
{
    return mmChmod(filename, mode);
}

INT32 ToolScandir(const CHAR *path, ToolDirent ***entryList, ToolFilter filterFunc, ToolSort sort)
{
    return mmScandir(path, (mmDirent ***)entryList, (mmFilter)filterFunc, (mmSort)sort);
}

VOID ToolScandirFree(ToolDirent **entryList, INT32 count)
{
    mmScandirFree((mmDirent **)entryList, count);
}

INT32 ToolStatGet(const CHAR *path,  ToolStat *buffer)
{
    return mmStatGet(path, (mmStat_t *)buffer);
}

INT32 ToolFsync(toolProcess fd)
{
    return mmFsync((mmProcess)fd);
}

INT32 ToolFileno(FILE *stream)
{
    return mmFileno(stream);
}

toolSockHandle ToolSocket(INT32 sockFamily, INT32 type, INT32 protocol)
{
    return mmSocket(sockFamily, type, protocol);
}

INT32 ToolBind(toolSockHandle sockFd, ToolSockAddr *addr, toolSocklen addrLen)
{
    return mmBind((mmSockHandle)sockFd, (mmSockAddr *)addr, (mmSocklen_t)addrLen);
}

INT32 ToolConnect(toolSockHandle sockFd, ToolSockAddr *addr, toolSocklen addrLen)
{
    return mmConnect((mmSockHandle)sockFd, (mmSockAddr *)addr, (mmSocklen_t)addrLen);
}

INT32 ToolCloseSocket(toolSockHandle sockFd)
{
    return mmCloseSocket((mmSockHandle)sockFd);
}

INT32 ToolGetPid(void)
{
    return mmGetPid();
}

INT32 ToolSleep(UINT32 milliSecond)
{
    return mmSleep(milliSecond);
}

VOID ToolMemBarrier(void)
{
    mmMb();
}

INT32 ToolGetErrorCode(void)
{
    return mmGetErrorCode();
}

INT32 ToolGetTimeOfDay(ToolTimeval *timeVal, ToolTimezone *timeZone)
{
    return mmGetTimeOfDay((mmTimeval *)timeVal, (mmTimezone *)timeZone);
}

INT32 ToolLocalTimeR(const time_t *timep, struct tm *result)
{
    return mmLocalTimeR(timep, result);
}

INT32 ToolJoinTask(const ToolThread *threadHandle)
{
    return mmJoinTask(threadHandle);
}

INT32 ToolCondTimedWait(ToolCond *cond, ToolMutex *mutex, UINT32 milliSecond)
{
    return mmCondTimedWait(cond, mutex, milliSecond);
}

INT32 ToolCondInit(ToolCond *cond)
{
    return mmCondInit(cond);
}

INT32 ToolCondNotify(ToolCond *cond)
{
    return mmCondNotify(cond);
}

INT32 ToolGetUserGroupId(UINT32 *uid, UINT32 *gid)
{
    return SYS_ERROR;
}

INT32 ToolChownPath(const CHAR *path)
{
    return SYS_OK;
}

INT32 ToolLChownPath(const CHAR *path)
{
    return SYS_OK;
}

INT32 ToolFChownPath(INT32 fd)
{
    return SYS_OK;
}

#endif
