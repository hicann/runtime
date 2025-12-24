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
#include "mmpa_stub.h"
#include <getopt.h>
#include "ide_daemon_hdc.h"

extern struct IdeGlobalCtrlInfo g_ideGlobalInfo;
int g_mmSemwait_time = 0;
int g_ide_create_task_time = 0;
int g_mmCreateTaskWitchDeatchFlag = 0;
int g_mmCreateTaskFlag = 0;
int g_mmCreateTaskWithDetachTime = 0;
int g_mmCreateTaskWithDetachThreahHold = 0;
int g_ide_create_task_time_threadhold = 0;

INT32 mmCreateTask(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock)
{
    if (g_ide_create_task_time == 1) {
        pstFuncBlock->procFunc(pstFuncBlock->pulArg);
        return 0;
    }

    return 0;
}

INT32 mmCreateTaskWithDetach(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock)
{
    if (g_mmCreateTaskWitchDeatchFlag == 1) {
        pstFuncBlock->procFunc(pstFuncBlock->pulArg);
        return 0;
    } else if (g_mmCreateTaskWitchDeatchFlag == 2) {
        return -1;
    }
    return 0;
}

INT32 mmMutexInit(mmMutex_t *mutex)
{
    return 0;
}

INT32 mmMutexLock(mmMutex_t *mutex)
{
    return 0;
}

INT32 mmMutexUnLock(mmMutex_t *mutex)
{
    return 0;
}

INT32 mmMutexDestroy(mmMutex_t *mutex)
{
    return 0;
}

INT32 mmSetThreadName(mmThread *pstThreadHandle, const CHAR *name)
{
    return 0;
}

INT32 mmSemInit(mmSem_t *sem, UINT32 value)
{
    return 0;
}

INT32 mmSemWait(mmSem_t *sem)
{
    return 0;
}

INT32 mmSemPost(mmSem_t *sem)
{
    return 0;
}

INT32 mmSemDestroy(mmSem_t *sem)
{
    return 0;
}

INT32 mmJoinTask(mmThread *pstThreadHandle)
{
    return 0;
}

INT32 mmChdir(const CHAR *path)
{
    return 0;
}

INT32 mmGetEnv(const CHAR *name, CHAR *value, UINT32 len)
{
    INT32 result;
    UINT32 envLen = 0;
    CHAR *envPtr = nullptr;
    if (name == nullptr || value == nullptr || len == 0) {
        return EN_INVALID_PARAM;
    }
    envPtr = getenv(name);
    if (envPtr == nullptr) {
        return EN_ERROR;
    }

    UINT32 lenOfRet = (UINT32)strlen(envPtr);
    if (lenOfRet < (MMPA_MEM_MAX_LEN - 1)) {
        envLen = lenOfRet + 1;
    }

    if (envLen != 0 && len < envLen) {
        return EN_INVALID_PARAM;
    } else {
        result = memcpy_s(value, len, envPtr, envLen);  // lint !e613
        if (result != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

INT32 mmGetCwd(CHAR *buffer, INT32 maxLen)
{
    return 0;
}

INT32 mmRmdir(const CHAR *lpPathName)
{
    return 0;
}

INT32 mmMkdir(const CHAR *lpPathName, mmMode_t mode)
{
    return 0;
}

INT32 mmAccess2(const CHAR *pathName, INT32 mode)
{
    return 0;
}

INT32 mmAccess(CHAR *pathName)
{
    return 0;
}

INT32 mmSleep(UINT32 millseconds)
{
    return 0;
}

INT32 mmCreateProcess(const CHAR *fileName, const mmArgvEnv *env, const char *stdoutRedirectFile, mmProcess *id)
{
    return EN_OK;
}

INT32 mmWaitPid(mmProcess pid, int *status, int options)
{
    return EN_OK;
}

INT32 mmGetLocalTime(mmSystemTime_t *sysTime)
{
    if (sysTime == nullptr) {
        return EN_INVALID_PARAM;
    }

    struct timeval timeVal;
    (void)memset(&timeVal, 0, sizeof(timeVal)); /* unsafe_function_ignore: memset */

    INT32 ret = gettimeofday(&timeVal, nullptr);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    struct tm nowTime = {0};
    if (localtime_r(&timeVal.tv_sec, &nowTime) == nullptr) {
        return EN_ERROR;
    }

    sysTime->wSecond = nowTime.tm_sec;
    sysTime->wMinute = nowTime.tm_min;
    sysTime->wHour = nowTime.tm_hour;
    sysTime->wDay = nowTime.tm_mday;
    sysTime->wMonth = nowTime.tm_mon + 1;  // in localtime month is [0,11],but in fact month is [1,12]
    sysTime->wYear = nowTime.tm_year + MMPA_COMPUTER_BEGIN_YEAR;
    sysTime->wDayOfWeek = nowTime.tm_wday;
    sysTime->tm_yday = nowTime.tm_yday;
    sysTime->tm_isdst = nowTime.tm_isdst;
    sysTime->wMilliseconds = timeVal.tv_usec / MMPA_ONE_THOUSAND;

    return EN_OK;
}

LONG mmLseek(INT32 fd, INT64 offset, INT32 seekFlag)
{
    return 0;
}

INT32 mmFtruncate(mmProcess fd, UINT32 length)
{
    return 0;
}

INT32 mmClose(INT32 fd)
{
    return 0;
}

INT32 mmOpen2(const CHAR *pathName, INT32 flags, MODE mode)
{
    return 1;
}

mmSsize_t mmWrite(INT32 fd, VOID *mmBuf, UINT32 mmCount)
{
    return mmCount;
}

mmSsize_t mmRead(INT32 fd, VOID *mmBuf, UINT32 mmCount)
{
    return mmCount;
}

INT32 mmUnlink(const CHAR *pathName)
{
    return 0;
}

mmSockHandle mmSocket(INT32 sockFamily, INT32 type, INT32 protocol)
{
    return 1;
}

INT32 mmBind(mmSockHandle sockfd, mmSockAddr *addr, mmSocklen_t addrlen)
{
    return 0;
}

INT32 mmListen(mmSockHandle sockfd, INT32 backlog)
{
    return 0;
}

mmSockHandle mmAccept(mmSockHandle sockfd, mmSockAddr *addr, mmSocklen_t *addrlen)
{
    return 1;
}

INT32 mmConnect(mmSockHandle sockfd, mmSockAddr *addr, mmSocklen_t addrlen)
{
    return 0;
}

INT32 mmCloseSocket(mmSockHandle sockfd)
{
    return 0;
}

INT32 mmSAStartup()
{
    return 0;
}

INT32 mmSACleanup()
{
    return 0;
}

mmSsize_t mmSocketSend(mmSockHandle sockfd, VOID *pstSendBuf, INT32 sendLen, INT32 sendFlag)
{
    return 0;
}

mmSsize_t mmSocketRecv(mmSockHandle sockfd, VOID *pstRecvBuf, INT32 recvLen, INT32 recvFlag)
{
    return 1;
}

mmProcess mmOpenFile(const CHAR *Filename, UINT32 access, mmCreateFlag createFlag)
{
    return 1;
}

mmSsize_t mmReadFile(mmProcess fileId, VOID *buffer, INT32 len)
{
    return len;
}

mmSsize_t mmWriteFile(mmProcess fileId, VOID *buffer, INT32 len)
{
    return len;
}

INT32 mmCloseFile(mmProcess fileId)
{
    return 0;
}

INT32 mmFsync(mmProcess fd)
{
    return EN_OK;
}

INT32 mmSemWait_stub(mmSem_t *sem)
{
    g_mmSemwait_time++;
    if (g_mmSemwait_time == 1) {
        g_ideGlobalInfo.hdcServerProcFlag = true;
    } else {
        g_ideGlobalInfo.hdcServerProcFlag = false;
    }

    return 0;
}

INT32 mmCreateTask_stub(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock)
{
    g_ide_create_task_time++;
    if (g_ide_create_task_time < g_ide_create_task_time_threadhold) {
        pstFuncBlock->procFunc(pstFuncBlock->pulArg);
        return 0;
    } else {
        return -1;
    }
}

INT32 mmCreateTask_stub1(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock)
{
    if (g_ide_create_task_time == 1) {
        if (pstFuncBlock != nullptr) {
            free(pstFuncBlock);
        }
        return 0;
    }

    return -1;
}

INT32 mmCreateTaskWithDetach_stub(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock)
{
    g_mmCreateTaskWithDetachTime++;
    if (g_mmCreateTaskWithDetachTime < g_mmCreateTaskWithDetachThreahHold) {
        pstFuncBlock->procFunc(pstFuncBlock->pulArg);
        return 0;
    } else {
        return -1;
    }
}

INT32 mmIoctl(mmProcess fd, INT32 ioctlCode, mmIoctlBuf *bufPtr)
{
    return 0;
}

INT32 mmRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    strcpy(realPath, path);
    return EN_OK;
}

INT32 mmUmask(INT32 pmode)
{
    return 0;
}

CHAR *mmStrTokR(CHAR *str, const CHAR *delim, CHAR **saveptr)
{
    if (delim == nullptr) {
        return nullptr;
    }
    char *ptr = strtok_r(str, delim, saveptr);
    if (ptr != nullptr) {
        return ptr;
    } else {
        return nullptr;
    }
}

INT32 mmLocalTimeR(const time_t *timep, struct tm *result)
{
    if (timep == nullptr || result == nullptr) {
        return EN_INVALID_PARAM;
    } else {
        time_t time = *timep;
        struct tm nowTime = {0};
        if (localtime_r(&time, &nowTime) == nullptr) {
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

INT32 mmGetOptLong(INT32 argc, CHAR *const *argv, const CHAR *opts, const mmStructOption *longopts, INT32 *longindex)
{
    return getopt_long(argc, argv, opts, longopts, longindex);
}

INT32 mmAccess(const CHAR *pathName)
{
    return EN_OK;
}

INT32 mmGetDiskFreeSpace(const char *path, mmDiskSize *diskSize)
{
    diskSize->availSize = 10;
    diskSize->freeSize = 10;
    return EN_OK;
}

CHAR *mmDirName(CHAR *path)
{
    return dirname(path);
}

CHAR *mmBaseName(CHAR *path)
{
    return basename(path);
}

INT32 mmSetCurrentThreadName(const CHAR *name)
{
    return EN_OK;
}

INT32 mmCreateTaskWithThreadAttr(mmThread *threadHandle, const mmUserBlock_t *funcBlock, const mmThreadAttr *threadAttr)
{
    if (g_ide_create_task_time == 1) {
        funcBlock->procFunc(funcBlock->pulArg);
        return 0;
    }

    return 0;
}

INT32 mmCreateTaskWithThreadAttr_stub(
    mmThread *threadHandle, const mmUserBlock_t *funcBlock, const mmThreadAttr *threadAttr)
{
    g_ide_create_task_time++;
    if (g_ide_create_task_time < g_ide_create_task_time_threadhold) {
        return 0;
    } else {
        return -1;
    }
}

INT32 mmGetErrorCode()
{
    return 0;
}

CHAR *mmGetErrorFormatMessage(mmErrorMsg errnum, CHAR *buf, mmSize size)
{
    return "unknow error!";
}

INT32 mmChmod(const CHAR *filename, INT32 mode)
{
    return 0;
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

INT32 mmIsDir(const char *fileName)
{
    return -1;
}

INT32 mmGetFileSize(const CHAR *fileName, ULONGLONG *length)
{
    *length = 1024;
    return 0;
}

int mmGetPid()
{
    return getpid();
}

int mmGetTid()
{
    return syscall(SYS_gettid);
}

int mmGetOsType()
{
    return 0;
}

INT32 mmGetOptInd()
{
    return optind;
}

CHAR *mmGetOptArg()
{
    return optarg;
}

int mmScandir(const CHAR *path, mmDirent ***entryList, mmFilter filterFunc, mmSort sort)
{
    if ((path == nullptr) || (entryList == nullptr)) {
        return EN_INVALID_PARAM;
    }
    INT32 count = scandir(path, entryList, filterFunc, sort);
    if (count < MMPA_ZERO) {
        return EN_ERROR;
    }
    return count;
}

void mmScandirFree(mmDirent **entryList, INT32 count)
{
    if (entryList == nullptr) {
        return;
    }
    int j;
    for (j = 0; j < count; j++) {
        if (entryList[j] != nullptr) {
            free(entryList[j]);
            entryList[j] = nullptr;
        }
    }
    free(entryList);
    entryList = nullptr;
}

INT32 mmStatGet(const CHAR *path, mmStat_t *buffer)
{
    if ((path == nullptr) || (buffer == nullptr)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = stat(path, buffer);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmGetTimeOfDay(mmTimeval *timeVal, mmTimezone *timeZone)
{
    if (timeVal == nullptr) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = gettimeofday((struct timeval *)timeVal, (struct timezone *)timeZone);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

void *mmDlsym(void *handle, const char *funcName)
{
    return nullptr;
}

int32_t mmDlclose(void *handle)
{
    return 0;
}

void *mmDlopen(const char *fileName, int mode)
{
    return nullptr;
}

char *mmDlerror(void)
{
    return nullptr;
}

INT32 mmGetOsName(CHAR *name, INT32 nameSize)
{
    return EN_OK;
}

INT32 mmGetOsVersion(CHAR *versionInfo, INT32 versionLength)
{
    return EN_OK;
}

INT32 mmGetCpuInfo(mmCpuDesc **cpuInfo, INT32 *count)
{
    return EN_OK;
}

INT32 mmCpuInfoFree(mmCpuDesc *cpuInfo, INT32 count)
{
    return EN_OK;
}
