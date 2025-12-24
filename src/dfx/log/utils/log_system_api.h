/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_SYSTEM_API_H
#define LOG_SYSTEM_API_H

#include "log_platform.h"

#if (OS_TYPE_DEF == LINUX)

#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <net/if.h>
#include <dirent.h>
#include <signal.h>
#include <limits.h>
#include <syslog.h>
#include <arpa/inet.h>
#include <string.h>
#include <time.h>
#include <sys/inotify.h>
#include <sys/klog.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/un.h>
#include <sys/file.h>
#include <semaphore.h>
#include <pwd.h>
#include <stdlib.h>
#include <grp.h>
#include "securec.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE 1
#endif

typedef void* ArgPtr;
typedef void Buff;
typedef void* (*ThreadFunc)(ArgPtr);

typedef unsigned char UINT8;
typedef unsigned int UINT32;
typedef signed int INT32;
typedef unsigned long long UINT64;
typedef void VOID;
typedef char CHAR;
typedef long LONG;

#define TOOL_MAX_THREAD_PIO 99
#define TOOL_MIN_THREAD_PIO 1
#define TOOL_MAX_SLEEP_MILLSECOND 4294967
#define TOOL_ONE_THOUSAND 1000
#define TOOL_COMPUTER_BEGIN_YEAR 1900
#define TOOL_THREADNAME_SIZE 16

#define TOOL_THREAD_SCHED_RR SCHED_RR
#define TOOL_THREAD_SCHED_FIFO SCHED_FIFO
#define TOOL_THREAD_SCHED_OTHER SCHED_OTHER
#define TOOL_THREAD_MIN_STACK_SIZE PTHREAD_STACK_MIN

#define TOOL_MAX_PATH PATH_MAX
#define TOOL_MUTEX_INITIALIZER PTHREAD_MUTEX_INITIALIZER

#define SYS_OK 0
#define SYS_ERROR (-1)
#define SYS_INVALID_PARAM (-2)

#define M_FILE_RDONLY O_RDONLY
#define M_FILE_WRONLY O_WRONLY
#define M_FILE_RDWR O_RDWR
#define M_FILE_CREAT O_CREAT

#define M_RDONLY O_RDONLY
#define M_WRONLY O_WRONLY
#define M_RDWR O_RDWR
#define M_CREAT O_CREAT

#define M_IREAD S_IREAD
#define M_IRUSR S_IRUSR
#define M_IWRITE S_IWRITE
#define M_IWUSR S_IWUSR
#define M_IXUSR S_IXUSR
#define FDSIZE 64


// system
typedef pthread_t ToolThread ;
typedef pthread_mutex_t ToolMutex;
typedef pthread_cond_t ToolCond;

typedef struct {
    INT32 detachFlag;
    INT32 priorityFlag;
    INT32 priority;
    INT32 policyFlag;
    INT32 policy;
    INT32 stackFlag;
    UINT32 stackSize;
} ToolThreadAttr;

typedef int toolKey;
typedef int toolMsgid;

typedef signed int toolProcess;
typedef mode_t toolMode;
typedef struct stat ToolStat;

typedef struct dirent ToolDirent;
typedef int (*ToolFilter)(const ToolDirent *entry);
typedef int (*ToolSort)(const ToolDirent **a, const ToolDirent **b);

typedef VOID *(*ToolProcFunc)(VOID *pulArg);

typedef struct {
    ToolProcFunc procFunc;
    VOID *pulArg;
} ToolUserBlock;

typedef int toolSockHandle;
typedef struct sockaddr ToolSockAddr;
typedef socklen_t toolSocklen;

typedef struct {
    time_t tvSec;
    LONG tvUsec;
} ToolTimeval;

typedef struct {
    INT32 tzMinuteswest;
    INT32 tzDsttime;
} ToolTimezone;

// multi thread interface
INT32 ToolMutexInit(ToolMutex *mutex);
INT32 ToolMutexLock(ToolMutex *mutex);
INT32 ToolMutexUnLock(ToolMutex *mutex);
INT32 ToolMutexDestroy(ToolMutex *mutex);
INT32 ToolCreateTaskWithThreadAttr(ToolThread *threadHandle, const ToolUserBlock *funcBlock,
                                   const ToolThreadAttr *threadAttr);
INT32 ToolCreateTaskWithDetach(ToolThread *threadHandle, const ToolUserBlock *funcBlock);
INT32 ToolSetThreadName(const char *threadName);

// I/O interface
INT32 ToolOpen(const CHAR *pathName, INT32 flags);
INT32 ToolOpenWithMode(const CHAR *pathName, INT32 flags, toolMode mode);
INT32 ToolClose(INT32 fd);
INT32 ToolWrite(INT32 fd, const VOID *buf, UINT32 bufLen);
INT32 ToolRead(INT32 fd, VOID *buf, UINT32 bufLen);
INT32 ToolMkdir(const CHAR *pathName, toolMode mode);
INT32 ToolRmdir(const CHAR *pathName);
INT32 ToolRename(const CHAR *oldName, const CHAR *newName);
INT32 ToolAccess(const CHAR *pathName);
INT32 ToolAccessWithMode(const CHAR *pathName, INT32 mode);
INT32 ToolRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen);
INT32 ToolUnlink(const CHAR *filename);
INT32 ToolChmod(const CHAR *filename, INT32 mode);
INT32 ToolChown(const char *filename, uid_t owner, gid_t group);
INT32 ToolScandir(const CHAR *path, ToolDirent ***entryList, ToolFilter filterFunc, ToolSort sort);
VOID ToolScandirFree(ToolDirent **entryList, INT32 count);
INT32 ToolStatGet(const CHAR *path,  ToolStat *buffer);
INT32 ToolFsync(toolProcess fd);
INT32 ToolFileno(FILE *stream);
INT32 ToolGetUserGroupId(UINT32 *uid, UINT32 *gid);
INT32 ToolChownPath(const CHAR *path);
INT32 ToolLChownPath(const CHAR *path);
INT32 ToolFChownPath(INT32 fd);

// socket interface
toolSockHandle ToolSocket(INT32 sockFamily, INT32 type, INT32 protocol);
INT32 ToolBind(toolSockHandle sockFd, const ToolSockAddr *addr, toolSocklen addrLen);
toolSockHandle ToolAccept(toolSockHandle sockFd, ToolSockAddr *addr, toolSocklen *addrLen);
INT32 ToolConnect(toolSockHandle sockFd, const ToolSockAddr *addr, toolSocklen addrLen);
INT32 ToolCloseSocket(toolSockHandle sockFd);

// others
INT32 ToolGetPid(void);
INT32 ToolSleep(UINT32 milliSecond);
VOID ToolMemBarrier(void);
INT32 ToolGetErrorCode(void);
INT32 ToolGetTimeOfDay(ToolTimeval *timeVal, ToolTimezone *timeZone);
INT32 ToolLocalTimeR(const time_t *timep, struct tm *result);
INT32 ToolJoinTask(const ToolThread *threadHandle);
INT32 ToolCondInit(ToolCond *cond);
INT32 ToolCondTimedWait(ToolCond *cond, ToolMutex *mutex, UINT32 milliSecond);
INT32 ToolCondNotify(ToolCond *cond);

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

#else

#include "mmpa_api.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

#define SYS_OK 0
#define SYS_ERROR (-1)
#define SYS_INVALID_PARAM (-2)

#define TOOL_MAX_PATH MAX_PATH

#ifndef EOK
#define EOK 0
#endif // !EOK

#define TOOL_MUTEX_INITIALIZER MM_MUTEX_INITIALIZER

typedef void* ArgPtr;
typedef void Buff;
typedef void* (*ThreadFunc)(ArgPtr);

typedef HANDLE ToolMutex;
typedef HANDLE ToolThread ;
typedef HANDLE toolProcess;
typedef CONDITION_VARIABLE ToolCond;
typedef VOID *(*ToolProcFunc)(VOID *pulArg);
typedef struct {
    ToolProcFunc procFunc;
    VOID *pulArg;
} ToolUserBlock;

typedef DWORD toolThreadKey;

typedef SOCKET toolSockHandle;
typedef struct sockaddr ToolSockAddr;
typedef int toolSocklen;
typedef int toolKey;
typedef HANDLE toolMsgid;

typedef struct {
    unsigned char d_type;
    char d_name[MAX_PATH]; // file name
} ToolDirent;

typedef int(*ToolFilter)(const ToolDirent *entry);
typedef int(*ToolSort)(const ToolDirent **a, const ToolDirent **b);

typedef struct {
    LONG  tvSec;
    LONG  tvUsec;
} ToolTimeval;

typedef struct {
    INT32 tzMinuteswest;
    INT32 tzDsttime;
} ToolTimezone;

typedef struct {
    LONG  tvSec;
    LONG  tv_nsec;
} ToolTimespec;

typedef struct stat ToolStat;
typedef int toolMode;

// Windows only support detachFlag
typedef struct {
    INT32 detachFlag;
    INT32 priorityFlag;
    INT32 priority;
    INT32 policyFlag;
    INT32 policy;
    INT32 stackFlag;
    UINT32 stackSize;
} ToolThreadAttr;

// multi thread interface
INT32 ToolMutexInit (ToolMutex *mutex);
INT32 ToolMutexLock(ToolMutex *mutex);
INT32 ToolMutexUnLock(ToolMutex *mutex);
INT32 ToolMutexDestroy(ToolMutex *mutex);
INT32 ToolCreateTaskWithThreadAttr(ToolThread *threadHandle, const ToolUserBlock *funcBlock,
                                   const ToolThreadAttr *threadAttr);
INT32 ToolCreateTaskWithDetach(ToolThread *threadHandle, const ToolUserBlock *funcBlock);
INT32 ToolSetThreadName(const char *threadName);

// I/O interface
INT32 ToolOpen(const CHAR *pathName, INT32 flags);
INT32 ToolOpenWithMode(const CHAR *pathName, INT32 flags, toolMode mode);
INT32 ToolClose(INT32 fd);
INT32 ToolWrite(INT32 fd, const VOID *buf, UINT32 bufLen);
INT32 ToolRead(INT32 fd, VOID *buf, UINT32 bufLen);
INT32 ToolMkdir(const CHAR *pathName, toolMode mode);
INT32 ToolRmdir(const CHAR *pathName);
INT32 ToolRename(const CHAR *oldName, const CHAR *newName);
INT32 ToolAccess(const CHAR *pathName);
INT32 ToolAccessWithMode(const CHAR *pathName, INT32 mode);
INT32 ToolRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen);
INT32 ToolUnlink(const CHAR *filename);
INT32 ToolChmod(const CHAR *filename, INT32 mode);
INT32 ToolScandir(const CHAR *path, ToolDirent ***entryList, ToolFilter filterFunc, ToolSort sort);
VOID ToolScandirFree(ToolDirent **entryList, INT32 count);
INT32 ToolStatGet(const CHAR *path,  ToolStat *buffer);
INT32 ToolFsync(toolProcess fd);
INT32 ToolFileno(FILE *stream);
INT32 ToolGetUserGroupId(UINT32 *uid, UINT32 *gid);
INT32 ToolChownPath(const CHAR *path);
INT32 ToolLChownPath(const CHAR *path);
INT32 ToolFChownPath(INT32 fd);

// socket interface
toolSockHandle ToolSocket(INT32 sockFamily, INT32 type, INT32 protocol);
INT32 ToolBind(toolSockHandle sockFd, const ToolSockAddr *addr, toolSocklen addrLen);
toolSockHandle ToolAccept(toolSockHandle sockFd, ToolSockAddr *addr, toolSocklen *addrLen);
INT32 ToolConnect(toolSockHandle sockFd, const ToolSockAddr *addr, toolSocklen addrLen);
INT32 ToolCloseSocket(toolSockHandle sockFd);

// others
INT32 ToolGetPid(void);
INT32 ToolSleep(UINT32 milliSecond);
VOID ToolMemBarrier(void);
INT32 ToolGetErrorCode(void);
INT32 ToolGetTimeOfDay(ToolTimeval *timeVal, ToolTimezone *timeZone);
INT32 ToolLocalTimeR(const time_t *timep, struct tm *result);
INT32 ToolJoinTask(const ToolThread *tid);
INT32 ToolCondInit(ToolCond *cond);
INT32 ToolCondTimedWait(ToolCond *cond, ToolMutex *mutex, UINT32 milliSecond);
INT32 ToolCondNotify(ToolCond *cond);

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

#endif /* OS_TYPE_DEF */

#endif
