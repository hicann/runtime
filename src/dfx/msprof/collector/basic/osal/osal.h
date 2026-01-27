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
#include <stdint.h>

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

#ifdef OSAL
/************************************* Linux Macro Definition *************************************/
#define OSAL_MAX_PATH PATH_MAX
#define OSAL_PATH_SIZE 256

#define OSAL_WAIT_NOHANG WNOHANG  // Non blocking waiting

// If the subprocess enters the suspended state, it will return immediately
// But the end state of the subprocess is ignored
#define OSAL_WAIT_UNTRACED WUNTRACED
#define OSAL_MSEC_TO_USEC                       1000ULL
#define OSAL_MAX_SLEEP_MILLSECOND_USING_USLEEP  1000U
#define OSAL_MAX_SLEEP_MICROSECOND_USING_USLEEP 1000000U
#define OSAL_IRUSR                              S_IRUSR
#define OSAL_IWUSR                              S_IWUSR
#define OSAL_W_OK                               W_OK
#define OSAL_X_OK                               X_OK
#define OSAL_THREAD_SCHED_RR                    SCHED_RR
#define OSAL_THREAD_SCHED_FIFO                  SCHED_FIFO
#define OSAL_THREAD_SCHED_OTHER                 SCHED_OTHER
#define OSAL_MEM_MAX_LEN                        (0x7fffffff)
#define OSAL_CPUPROC_BUF_SIZE                   256
#define OSAL_CPUINFO_DEFAULT_SIZE               64
#define OSAL_CPUINFO_DOUBLE_SIZE                128
#define OSAL_CPUDESC_DEFAULT_SIZE               64
#define OSAL_MIN_OS_VERSION_SIZE                128
#define OSAL_MIN_OS_NAME_SIZE                   64
#define OSAL_MAX_PHYSICALCPU_COUNT              4096
#define OSAL_MIN_PHYSICALCPU_COUNT              1
#define OSAL_MAX_THREAD_PIO                     99
#define OSAL_MIN_THREAD_PIO                     1
#define OSAL_RTLD_LAZY                          RTLD_LAZY
#define OSAL_NO_ARG                             no_argument
#define OSAL_REQUIRED_ARG                       required_argument
#define OSAL_OPTIONAL_ARG                       optional_argument
#ifdef LITE_OS
#define OSAL_THREAD_POOL_STACK_SIZE             3072
#define OSAL_THREAD_MIN_STACK_SIZE              8192 // 8k
#define VOID                                    void
#define CLOCK_MONOTONIC_RAW                     4
#else
#define OSAL_THREAD_MIN_STACK_SIZE              PTHREAD_STACK_MIN
typedef void VOID;
#endif
/********************************* Linux Data Structure Definition *********************************/
typedef pthread_mutex_t OsalMutex;
typedef pthread_cond_t OsalCond;
typedef void* OsalVoidPtr;
typedef char CHAR;
typedef ssize_t OsalSsize;
typedef size_t OsalSize;
typedef int32_t OsalProcess;
typedef pthread_t OsalThread;
#ifndef LITE_OS
typedef struct sockaddr OsalSockAddr;
typedef int32_t OsalSockHandle;
typedef socklen_t OsalSocklen;
typedef struct stat OsalStat;
#endif
typedef mode_t OsalMode;
typedef int32_t OsalErrorMsg;
typedef struct option OsalStructOption;
typedef struct dirent OsalDirent;

typedef struct {
    int32_t detachFlag;    // Determine whether to set separation property 0, not to separate 1
    int32_t priorityFlag;  // Determine whether to set priority 0 and not set 1
    int32_t priority;      // Priority value range to be set 1-99
    int32_t policyFlag;    // Set scheduling policy or not 0 do not set 1 setting
    int32_t policy;        // Scheduling policy value value
                              //  OSAL_THREAD_SCHED_RR
                              //  OSAL_THREAD_SCHED_OTHER
                              //  OSAL_THREAD_SCHED_FIFO
    int32_t stackFlag;     // Set stack size or not: 0 does not set 1 setting
    uint32_t stackSize;    // The stack size unit bytes to be set cannot be less than OSAL_THREAD_STACK_MIN
} OsalThreadAttr;

typedef VOID *(*UserProcFunc)(VOID *pulArg);
typedef int32_t (*OsalFilter)(const OsalDirent *entry);
typedef int32_t (*OsalSort)(const OsalDirent **a, const OsalDirent **b);

typedef struct {
    UserProcFunc procFunc;  // Callback function pointer
    VOID *pulArg;           // Callback function parameters
} OsalUserBlock;

typedef struct {
    const CHAR *dli_fname;
    VOID *dli_fbase;
    const CHAR *dli_sname;
    VOID *dli_saddr;
    size_t dli_size; /* ELF only */
    int32_t dli_bind; /* ELF only */
    int32_t dli_type;
} OsalDlInfo;

typedef struct {
    int32_t tz_minuteswest;  // How many minutes is it different from Greenwich
    int32_t tz_dsttime;      // type of DST correction
} OsalTimezone;

#ifdef LITE_OS
typedef struct {
    int32_t tv_sec;
    int32_t tv_usec;
} OsalTimeval;
#else
typedef struct {
    int64_t tv_sec;
    int64_t tv_usec;
} OsalTimeval;
#endif

typedef struct {
    int64_t tv_sec;
    int64_t tv_nsec;
} OsalTimespec;

typedef struct {
    uint64_t totalSize;
    uint64_t freeSize;
    uint64_t availSize;
} OsalDiskSize;

typedef struct {
    CHAR **argv;
    int32_t argvCount;
    CHAR **envp;
    int32_t envpCount;
} OsalArgvEnv;

typedef struct {
    int32_t wSecond;             // Seconds. [0-60] (1 leap second)
    int32_t wMinute;             // Minutes. [0-59]
    int32_t wHour;               // Hours. [0-23]
    int32_t wDay;                // Day. [1-31]
    int32_t wMonth;              // Month. [1-12]
    int32_t wYear;               // Year
    int32_t wDayOfWeek;          // Day of week. [0-6]
    int32_t tm_yday;             // Days in year.[0-365]
    int32_t tm_isdst;            // DST. [-1/0/1]
    int64_t wMilliseconds;       // milliseconds
} OsalSystemTime;

typedef struct {
    CHAR arch[OSAL_CPUDESC_DEFAULT_SIZE];
    CHAR manufacturer[OSAL_CPUDESC_DEFAULT_SIZE];  // vendor
    CHAR version[OSAL_CPUDESC_DEFAULT_SIZE];       // modelname
    int32_t frequency;                               // cpu frequency
    int32_t maxFrequency;                            // max speed
    int32_t ncores;                                  // cpu cores
    int32_t nthreads;                                // cpu thread count
    int32_t ncounts;                                 // logical cpu nums
} OsalCpuDesc;

#else
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
#endif

/*********************************** Osal Interface Declaration ***********************************/
OSAL_FUNC_VISIBILITY int32_t OsalSleep(uint32_t milliSecond);
OSAL_FUNC_VISIBILITY int32_t OsalGetPid(void);
OSAL_FUNC_VISIBILITY int32_t OsalGetTid(void);
#ifndef LITE_OS
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
#endif
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