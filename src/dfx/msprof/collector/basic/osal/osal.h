/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_OSAL_H
#define ANALYSIS_DVVP_COMMON_OSAL_H
#include "osal_include.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cpluscplus

#define OSAL_ZERO 0
#define OSAL_EN_OK 0
#define OSAL_EN_ERR 1
#define OSAL_EN_ERROR -1
#define OSAL_EN_INVALID_PARAM -2
#define OSAL_EN_TIMEOUT -3
#define OSAL_TIMES_THOUSANDS 1000
#define OSAL_COMPUTER_BEGIN_YEAR 1900
#define OSAL_TIMES_MILLIONS 1000000

/************************************* MMPA Macro Definition *************************************/
#define OSAL_MAX_PATH                           MMPA_MAX_PATH
#define OSAL_WAIT_UNTRACED                      M_WAIT_UNTRACED
#define OSAL_THREAD_SCHED_RR                    MMPA_THREAD_SCHED_RR
#define OSAL_THREAD_SCHED_FIFO                  MMPA_THREAD_SCHED_FIFO
#define OSAL_THREAD_SCHED_OTHER                 MMPA_THREAD_SCHED_OTHER
#define OSAL_THREAD_MIN_STACK_SIZE              MMPA_THREAD_MIN_STACK_SIZE
#define OSAL_MEM_MAX_LEN                        MMPA_MEM_MAX_LEN
#define OSAL_CPUINFO_DEFAULT_SIZE               MMPA_CPUINFO_DEFAULT_SIZE
#define OSAL_CPUINFO_DOUBLE_SIZE                MMPA_CPUINFO_DOUBLE_SIZE
#define OSAL_CPUDESC_DEFAULT_SIZE               MMPA_CPUDESC_DEFAULT_SIZE
#define OSAL_CPUPROC_BUF_SIZE                   MMPA_CPUPROC_BUF_SIZE
#define OSAL_MIN_OS_VERSION_SIZE                MMPA_MIN_OS_VERSION_SIZE
#define OSAL_MIN_OS_NAME_SIZE                   MMPA_MIN_OS_NAME_SIZE
#define OSAL_RTLD_LAZY                          MMPA_RTLD_LAZY
#define OSAL_WAIT_NOHANG                        M_WAIT_NOHANG
#define OSAL_IRUSR                              M_IRUSR
#define OSAL_IWUSR                              M_IWUSR
#define OSAL_W_OK                               M_W_OK
#define OSAL_X_OK                               M_X_OK
#define OSAL_NO_ARG                             mm_no_argument
#define OSAL_REQUIRED_ARG                       mm_required_argument
#define OSAL_OPTIONAL_ARG                       mm_optional_argument
#define OSAL_MAX_PHYSICALCPU_COUNT              MMPA_MAX_PHYSICALCPU_COUNT
#define OSAL_MIN_PHYSICALCPU_COUNT              MMPA_MIN_PHYSICALCPU_COUNT
#define OSAL_MAX_THREAD_PIO                     MMPA_MAX_THREAD_PIO
#define OSAL_MIN_THREAD_PIO                     MMPA_MIN_THREAD_PIO
#define OSAL_MSEC_TO_USEC                       1000ULL
#define OSAL_MAX_SLEEP_MILLSECOND_USING_USLEEP  1000U
#define OSAL_MAX_SLEEP_MICROSECOND_USING_USLEEP 1000000U

/********************************* MMPA Data Structure Definition *********************************/
typedef mmSsize_t OsalSsize;
typedef mmSize_t OsalSize;
typedef mmProcess OsalProcess;
typedef mmThread OsalThread;
typedef mmSockAddr OsalSockAddr;
typedef mmSocklen_t OsalSocklen;
typedef mmSockHandle OsalSockHandle;
typedef mmMode_t OsalMode;
typedef mmDirent OsalDirent;
typedef mmStat_t OsalStat;
typedef mmSystemTime_t OsalSystemTime;
typedef mmErrorMsg  OsalErrorMsg;
typedef mmStructOption OsalStructOption;
typedef mmFilter OsalFilter;
typedef mmSort OsalSort;
typedef mmThreadAttr OsalThreadAttr;
typedef mmUserBlock_t OsalUserBlock;
typedef mmDlInfo OsalDlInfo;
typedef mmTimezone OsalTimezone;
typedef mmTimeval OsalTimeval;
typedef mmTimespec OsalTimespec;
typedef mmDiskSize OsalDiskSize;
typedef mmDirent OsalDirent;
typedef mmArgvEnv OsalArgvEnv;
typedef mmCpuDesc OsalCpuDesc;

/*********************************** Osal Interface Declaration ***********************************/
OSAL_FUNC_VISIBILITY int32_t OsalSleep(uint32_t milliSecond);
OSAL_FUNC_VISIBILITY int32_t OsalGetPid(void);
OSAL_FUNC_VISIBILITY int32_t OsalGetTid(void);

OSAL_FUNC_VISIBILITY OsalSockHandle OsalSocket(int32_t sockFamily, int32_t type, int32_t protocol);
OSAL_FUNC_VISIBILITY int32_t OsalBind(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen addrLen);
OSAL_FUNC_VISIBILITY int32_t OsalListen(OsalSockHandle sockFd, int32_t backLog);
OSAL_FUNC_VISIBILITY OsalSockHandle OsalAccept(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen *addrLen);
OSAL_FUNC_VISIBILITY int32_t OsalConnect(OsalSockHandle sockFd, OsalSockAddr *addr, OsalSocklen addrLen);
OSAL_FUNC_VISIBILITY OsalSsize OsalSocketSend(OsalSockHandle sockFd, VOID *sendBuf, int32_t sendLen, int32_t sendFlag);
OSAL_FUNC_VISIBILITY OsalSsize OsalSocketRecv(OsalSockHandle sockFd, VOID *recvBuf, int32_t recvLen, int32_t recvFlag);
OSAL_FUNC_VISIBILITY int32_t OsalGetFileSize(const CHAR *fileName, uint64_t *length);
OSAL_FUNC_VISIBILITY int32_t OsalGetDiskFreeSpace(const CHAR *path, OsalDiskSize *diskSize);
OSAL_FUNC_VISIBILITY int32_t OsalIsDir(const CHAR *fileName);
OSAL_FUNC_VISIBILITY int32_t OsalAccess(const CHAR *pathName);
OSAL_FUNC_VISIBILITY int32_t OsalAccess2(const CHAR *pathName, int32_t mode);
OSAL_FUNC_VISIBILITY CHAR *OsalDirName(CHAR *path);
OSAL_FUNC_VISIBILITY CHAR *OsalBaseName(CHAR *path);
OSAL_FUNC_VISIBILITY int32_t OsalGetCwd(CHAR *buffer, int32_t maxLen);
OSAL_FUNC_VISIBILITY int32_t OsalMkdir(const CHAR *pathName, OsalMode mode);
OSAL_FUNC_VISIBILITY int32_t OsalChmod(const CHAR *filename, int32_t mode);
OSAL_FUNC_VISIBILITY int32_t OsalChdir(const CHAR *path);
OSAL_FUNC_VISIBILITY int32_t OsalScandir(const CHAR *path,
    OsalDirent ***entryList, OsalFilter filterFunc, OsalSort sort);
OSAL_FUNC_VISIBILITY VOID OsalScandirFree(OsalDirent **entryList, int32_t count);
OSAL_FUNC_VISIBILITY int32_t OsalRmdir(const CHAR *pathName);
OSAL_FUNC_VISIBILITY int32_t OsalUnlink(const CHAR *filename);
OSAL_FUNC_VISIBILITY int32_t OsalRealPath(const CHAR *path, CHAR *realPath, int32_t realPathLen);
OSAL_FUNC_VISIBILITY CHAR *OsalGetErrorFormatMessage(OsalErrorMsg errnum, CHAR *buf, OsalSize size);
OSAL_FUNC_VISIBILITY int32_t OsalStatGet(const CHAR *path, OsalStat *buffer);
OSAL_FUNC_VISIBILITY int32_t OsalGetOptInd(void);
OSAL_FUNC_VISIBILITY CHAR *OsalGetOptArg(void);
OSAL_FUNC_VISIBILITY int32_t OsalGetOsName(CHAR *name, int32_t nameSize);
OSAL_FUNC_VISIBILITY VOID *OsalDlopen(const CHAR *fileName, int32_t mode);
OSAL_FUNC_VISIBILITY VOID *OsalDlsym(VOID *handle, const CHAR *funcName);
OSAL_FUNC_VISIBILITY int32_t OsalDlclose(VOID *handle);
OSAL_FUNC_VISIBILITY CHAR *OsalDlerror(void);

OSAL_FUNC_VISIBILITY int32_t OsalGetErrorCode(void);
OSAL_FUNC_VISIBILITY int32_t OsalCreateProcess(const CHAR *fileName,
    const OsalArgvEnv *env, const CHAR *stdoutRedirectFile, OsalProcess *id);
OSAL_FUNC_VISIBILITY int32_t OsalCreateTaskWithThreadAttr(OsalThread *threadHandle,
    const OsalUserBlock *funcBlock, const OsalThreadAttr *threadAttr);
OSAL_FUNC_VISIBILITY int32_t OsalWaitPid(OsalProcess pid, int32_t *status, int32_t options);
OSAL_FUNC_VISIBILITY int32_t OsalJoinTask(OsalThread *threadHandle);
OSAL_FUNC_VISIBILITY OsalTimespec OsalGetTickCount(void);
OSAL_FUNC_VISIBILITY int32_t OsalSetCurrentThreadName(const CHAR *name);
OSAL_FUNC_VISIBILITY int32_t OsalGetOptLong(int32_t argc, CHAR *const *argv, const CHAR *opts,
    const OsalStructOption *longOpts, int32_t *longIndex);
OSAL_FUNC_VISIBILITY int32_t OsalGetOsVersion(CHAR *versionInfo, int32_t versionLength);
OSAL_FUNC_VISIBILITY int32_t OsalGetCpuInfo(OsalCpuDesc **cpuInfo, int32_t *count);
OSAL_FUNC_VISIBILITY int32_t OsalCpuInfoFree(OsalCpuDesc *cpuInfo, int32_t count);
OSAL_FUNC_VISIBILITY int32_t OsalGetLocalTime(OsalSystemTime *sysTimePtr);
OSAL_FUNC_VISIBILITY int32_t OsalOpen(const CHAR *pathName, int32_t flags, OsalMode mode);
OSAL_FUNC_VISIBILITY int32_t OsalClose(int32_t fd);
OSAL_FUNC_VISIBILITY OsalSsize OsalWrite(int32_t fd, VOID *buf, uint32_t bufLen);
OSAL_FUNC_VISIBILITY int32_t OsalGetTimeOfDay(OsalTimeval *timeVal, OsalTimezone *timeZone);

#ifdef __cplusplus
}
#endif // __cpluscplus

#endif /* ANALYSIS_DVVP_COMMON_OSAL_H */