/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <libgen.h>
#include "common-utils-stub.h"
#include "errno/error_code.h"

#include "securec.h"

int g_sprintf_s_flag = 0;
int g_sprintf_s_flag1 = 1;

extern "C" {
int sprintf_s(char* strDest, size_t count, const char* format, ...)
{
    snprintf(strDest, count, "s");
    if(g_sprintf_s_flag == 0) {
        g_sprintf_s_flag --;
        return 1;
    }
    else {
        g_sprintf_s_flag = 0;
        return -1;
    }
  
}

int vsnprintf_s(char* strDest, size_t destMax, size_t count, const char* format, va_list arglist) 
{
    vsnprintf(strDest, count, format, arglist);
    if(g_sprintf_s_flag1 > 0) {
        return 0;
    }
    else {
        return -1;
    }
}

mmTimespec mmGetTickCount()
{
    mmTimespec rts;
    struct timespec ts = {0};
    clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
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

INT32 mmGetEnv(const CHAR *name, CHAR *value, UINT32 len)
{
    INT32 result;
    UINT32 envLen = 0;
    CHAR *envPtr = NULL;
    if (name == NULL || value == NULL || len == 0) {
        return EN_INVALID_PARAM;
    }
    envPtr = getenv(name);
    if (envPtr == NULL) {
        return EN_ERROR;
    }

    UINT32 lenOfRet = (UINT32)strlen(envPtr);
    if( lenOfRet < (MMPA_MEM_MAX_LEN - 1)) {
        envLen = lenOfRet + 1;
    }

    if (envLen != 0 && len < envLen) {
        return EN_INVALID_PARAM;
    } else {
        result = memcpy_s(value, len, envPtr, envLen); //lint !e613
        if (result != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

CHAR *mmDirName(CHAR *path)
{
    if (path == NULL) {
        return NULL;
    }
    CHAR *dir = dirname(path);
    return dir;
}

CHAR *mmBaseName(CHAR *path)
{
    if (path == NULL) {
        return NULL;
    }
    CHAR *dir = basename(path);
    return dir;
}

INT32 mmGetFileSize(const CHAR *fileName, ULONGLONG *length)
{
    if(fileName == NULL || length == NULL){
        return EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (void)memset(&fileStat, 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    int ret = lstat(fileName, &fileStat);
    if (ret < 0) {
        return EN_ERROR;
    }
    *length = (ULONGLONG)fileStat.st_size;
    return EN_OK;
}

INT32 mmIsDir(const CHAR *fileName)
{
    if (fileName == NULL) {
        return EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (void)memset(&fileStat, 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    int ret = lstat(fileName, &fileStat);
    if (ret < 0) {
        return EN_ERROR;
    }

    if (!S_ISDIR(fileStat.st_mode)) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmAccess(const CHAR *lpPathName)
{
    if (lpPathName == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = access(lpPathName, F_OK);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmRmdir(const CHAR *lpPathName)
{
    INT32 ret;
    DIR *pDir = NULL;
    DIR *pChildDir = NULL;

    if (lpPathName == NULL) {
        return EN_INVALID_PARAM;
    }
    pDir = opendir(lpPathName);
    if (pDir == NULL) {
        return EN_INVALID_PARAM;
    }

    struct dirent *entry = NULL;
    while ((entry = readdir(pDir)) != NULL) {
        if (strcmp(".", entry->d_name) == MMPA_ZERO || strcmp("..", entry->d_name) == MMPA_ZERO) {
            continue;
        }
        CHAR buf[PATH_SIZE] = {0};
        ret = snprintf_s(buf, sizeof(buf), sizeof(buf) - 1, "%s/%s", lpPathName, entry->d_name);
        if (ret == EN_ERROR) {
            break;
        }
        pChildDir = opendir(buf);
        if (pChildDir != NULL) {
            closedir(pChildDir);
            ret = mmRmdir(buf);
            continue;
        } else {
            ret = unlink(buf);
            if (ret == EN_OK) {
                continue;
            }
        }
    }
    closedir(pDir);

    ret = rmdir(lpPathName);
    if (ret == EN_ERROR) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmMkdir(const CHAR *lpPathName, mmMode_t mode)
{
    if (lpPathName == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = mkdir(lpPathName, mode);

    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}
INT32  mmAccess2(const CHAR *path, INT32 mode) {
    return EN_OK;
}

INT32 mmGetDiskFreeSpace(const char* path, mmDiskSize *diskSize)
{
    if (path == NULL || diskSize == NULL) {
        return EN_INVALID_PARAM;
    }
    struct statvfs buf;// 把文件系统信息读入 struct statvfs buf 中
    (void)memset(&buf,0,sizeof(buf)); /* unsafe_function_ignore: memset */

    INT32 ret = statvfs(path,&buf);
    if (ret == 0) {
        diskSize->totalSize = (ULONGLONG)(buf.f_blocks * buf.f_bsize);
        diskSize->availSize = (ULONGLONG)(buf.f_bavail * buf.f_bsize);
        diskSize->freeSize = (ULONGLONG)(buf.f_bfree * buf.f_bsize);
        return EN_OK;
    }
    return EN_ERROR;
}

INT32 mmRealPath(const CHAR *path, CHAR *realPath,INT32 realPathLen)
{
    INT32 ret = EN_OK;
    if (realPath == NULL || path == NULL || realPathLen < MMPA_MAX_PATH) {
        return EN_INVALID_PARAM;
    }
    char *pRet = realpath(path, realPath);  /* [false alarm]:realpath默认的系统调用 */
    if (pRet == NULL) {
        ret = EN_ERROR;
    }
    return ret;
}

INT32 mmGetLocalTime(mmSystemTime_t *sysTime)
{
    if (sysTime == NULL) {
        return EN_INVALID_PARAM;
    }

    struct timeval timeVal;
    (void)memset(&timeVal,0,sizeof(timeVal)); /* unsafe_function_ignore: memset */

    INT32 ret = gettimeofday(&timeVal,NULL);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    struct tm nowTime = {0};
    if(localtime_r(&timeVal.tv_sec,&nowTime) == NULL) {
        return EN_ERROR;
    }

    sysTime->wSecond = nowTime.tm_sec;
    sysTime->wMinute = nowTime.tm_min;
    sysTime->wHour = nowTime.tm_hour;
    sysTime->wDay = nowTime.tm_mday;
    sysTime->wMonth = nowTime.tm_mon + 1; // in localtime month is [0,11],but in fact month is [1,12]
    sysTime->wYear = nowTime.tm_year + MMPA_COMPUTER_BEGIN_YEAR;
    sysTime->wDayOfWeek = nowTime.tm_wday;
    sysTime->tm_yday = nowTime.tm_yday;
    sysTime->tm_isdst = nowTime.tm_isdst;
    sysTime->wMilliseconds = timeVal.tv_usec / MMPA_ONE_THOUSAND;

    return EN_OK;
}

INT32 mmSleep(UINT32 milliSecond)
{
    if (milliSecond == MMPA_ZERO) {
        return(EN_INVALID_PARAM);
    }
    unsigned int microSecond;
    if (milliSecond <= MMPA_MAX_SLEEP_MILLSECOND) {
        microSecond = milliSecond * MMPA_ONE_THOUSAND;
    } else { // 防止截断
        microSecond = 0xffffffff;
    }
    INT32 ret = usleep(microSecond);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmCreateProcess(const CHAR* fileName, const mmArgvEnv *env, const char* stdoutRedirectFile, mmProcess *id)
{
    return EN_OK;
}

INT32 mmWaitPid(mmProcess pid, int *status, int options)
{
    return EN_OK;
}

INT32 mmGetMac(mmMacInfo **list, INT32 *count)
{
    return EN_OK;
}

INT32 mmGetMacFree(mmMacInfo *list, INT32 count)
{
    return EN_OK;
}

INT32 mmScandir(const CHAR *path, mmDirent ***entryList, mmFilter filterFunc, mmSort sort)
{
    if (path == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 count = scandir(path, entryList, filterFunc, sort);
    if (count < 0) {
        return EN_ERROR;
    }
    return count;
}

void mmScandirFree(mmDirent **entryList, INT32 count)
{
    if (entryList == NULL) {
        return;
    }
    int j;
    for (j = 0; j < count; j++) {
        if (entryList[j] != NULL) {
            free(entryList[j]);
            entryList[j] = NULL;
        }
    }
    free(entryList);
}

INT32 mmGetOsName(CHAR* name, INT32 nameSize)
{
    return EN_OK;
}

INT32 mmGetOsVersion(CHAR* versionInfo, INT32 versionLength)
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

INT32 mmGetPidHandle(mmProcess *pstProcessHandle)
{
    if (pstProcessHandle == NULL) {
        return EN_INVALID_PARAM;
    }
    *pstProcessHandle = (mmProcess)getpid();
    return EN_OK;
}

INT32 mmUnlink(const CHAR *filename)
{
    if (filename == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = unlink(filename);
    if (ret == EN_ERROR) {
    }
    return ret;
}

INT32 mmChdir(const CHAR *path)
{
    if (path == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = chdir(path);
    if (ret == EN_ERROR) {
        return EN_ERROR;
    }
    return ret;
}

INT32 mmSetCurrentThreadName(const CHAR* name)
{
    if (name == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = prctl(PR_SET_NAME, name);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmOpen2(const CHAR *pathName, INT32 flags, MODE mode)
{
    UINT32 flag = (UINT32)flags;

    if (pathName == NULL) {
        return EN_INVALID_PARAM;
    }
    if (((flag & (O_TRUNC | O_WRONLY | O_RDWR | O_CREAT)) == MMPA_ZERO) && (flags != O_RDONLY)) {
        return EN_INVALID_PARAM;
    }
    if (((mode & (S_IRUSR | S_IREAD)) == MMPA_ZERO) &&
        ((mode & (S_IWUSR | S_IWRITE)) == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 fd = open(pathName, flags, mode); /* [false alarm]:ignore fortity */
    if (fd < MMPA_ZERO) {
        return EN_ERROR;
    }
    return fd;
}

mmSsize_t mmRead(INT32 fd, VOID *buf, UINT32 bufLen)
{
    if ((fd < MMPA_ZERO) || (buf == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = (INT32)read(fd, buf,(size_t)bufLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

mmSsize_t mmWrite(INT32 fd, VOID *buf, UINT32 bufLen)
{
    if ((fd < MMPA_ZERO) || (buf == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = (INT32)write(fd, buf,(size_t)bufLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return ret;
}

INT32 mmClose(INT32 fd)
{
    if (fd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = close(fd);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmCloseSocket(mmSockHandle sockFd)
{
    if (sockFd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = close(sockFd);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

mmSsize_t mmSocketSend(mmSockHandle sockFd,VOID *pstSendBuf,INT32 sendLen,INT32 sendFlag)
{
    if ((sockFd < MMPA_ZERO) || (pstSendBuf == NULL) || (sendLen <= MMPA_ZERO) || (sendFlag < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 sndLen = (UINT32)sendLen;
    INT32 ret = (INT32)send(sockFd, pstSendBuf, sndLen, sendFlag);
    if (ret <= MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

mmSsize_t mmSocketRecv(mmSockHandle sockFd, VOID *pstRecvBuf,INT32 recvLen,INT32 recvFlag)
{
    if ((sockFd < MMPA_ZERO) || (pstRecvBuf == NULL) || (recvLen <= MMPA_ZERO) || (recvFlag < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 rcvLen = (UINT32)recvLen;
    INT32 ret = (INT32)recv(sockFd, pstRecvBuf, rcvLen, recvFlag);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

mmSockHandle mmSocket(INT32 sockFamily, INT32 type, INT32 protocol)
{
    INT32 socketHandle = socket(sockFamily, type, protocol);
    if (socketHandle < MMPA_ZERO) {
        return EN_ERROR;
    }
    return socketHandle;
}

INT32 mmBind(mmSockHandle sockFd, mmSockAddr* addr, mmSocklen_t addrLen)
{
    if ((sockFd < MMPA_ZERO) || (addr == NULL) || (addrLen == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = bind(sockFd, addr, addrLen);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmListen(mmSockHandle sockFd, INT32 backLog)
{
    if ((sockFd < MMPA_ZERO) || (backLog <= MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = listen(sockFd, backLog);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

mmSockHandle mmAccept(mmSockHandle sockFd, mmSockAddr *addr, mmSocklen_t *addrLen)
{
    if (sockFd < MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = accept(sockFd, addr, addrLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

INT32 mmConnect(mmSockHandle sockFd, mmSockAddr* addr, mmSocklen_t addrLen)
{
    if ((sockFd < MMPA_ZERO) || (addr == NULL) || (addrLen == MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = connect(sockFd, addr, addrLen);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmSAStartup()
{
    return EN_OK;
}

INT32 mmSACleanup()
{
    return EN_OK;
}

INT32 mmGetPid()
{
    return (INT32)getpid();
}

INT32 mmCreateTask(mmThread *threadHandle, mmUserBlock_t *funcBlock)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) || (funcBlock->procFunc == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_create(threadHandle, NULL, funcBlock->procFunc, funcBlock->pulArg);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }

    return ret;
}

INT32 LocalSetThreadAttr(pthread_attr_t *attr,const mmThreadAttr *threadAttr)
{
#ifndef __ANDROID__
        // 设置默认继承属性 PTHREAD_EXPLICIT_SCHED 使得调度属性生效
        if(threadAttr->policyFlag == true || threadAttr->priorityFlag == true) {
            if (pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED) != EN_OK) {
                return EN_ERROR;
            }
        }
#endif

    // 设置调度策略
    if (threadAttr->policyFlag == true) {
        if (threadAttr->policy != MMPA_THREAD_SCHED_FIFO && threadAttr->policy != MMPA_THREAD_SCHED_OTHER &&
            threadAttr->policy != MMPA_THREAD_SCHED_RR) {
            return EN_INVALID_PARAM;
        }
        if (pthread_attr_setschedpolicy(attr, threadAttr->policy) != EN_OK) {
            return EN_ERROR;
        }
    }

    // 设置优先级
    if (threadAttr->priorityFlag == true) {
        if (threadAttr->priority < MMPA_MIN_THREAD_PIO || threadAttr->priority > MMPA_MAX_THREAD_PIO) {
            return EN_INVALID_PARAM;
        }
        struct sched_param param;
        (void)memset_s(&param, sizeof(param), 0, sizeof(param));
        param.sched_priority = threadAttr->priority;
        if (pthread_attr_setschedparam(attr, &param) != EN_OK) {
            return EN_ERROR;
        }
    }

    // 设置堆栈
    if (threadAttr->stackFlag == true) {
        if (threadAttr->stackSize < MMPA_THREAD_MIN_STACK_SIZE) {
            return EN_INVALID_PARAM;
        }
        if (pthread_attr_setstacksize(attr, threadAttr->stackSize) != EN_OK) {
            return EN_ERROR;
        }
    }
    if (threadAttr->detachFlag == true) {
        // 设置默认线程分离属性
        if (pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED) != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}


INT32 mmCreateTaskWithThreadAttr(mmThread *threadHandle, const mmUserBlock_t *funcBlock,
                                         const mmThreadAttr *threadAttr)
{
    if (threadHandle == NULL || funcBlock == NULL ||
        funcBlock->procFunc == NULL || threadAttr == NULL) {
        return EN_INVALID_PARAM;
    }

    pthread_attr_t attr;
    (void)memset_s(&attr, sizeof(attr), 0, sizeof(attr));

    // 初始化线程属性
    INT32 ret = pthread_attr_init(&attr);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    ret = LocalSetThreadAttr(&attr,threadAttr);
    if (ret != EN_OK) {
        (void)pthread_attr_destroy(&attr);
        return ret;
    }

    ret = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (void)pthread_attr_destroy(&attr);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

INT32 mmJoinTask(mmThread *threadHandle)
{
    if (threadHandle == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_join(*threadHandle, NULL);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

INT32 mmGetErrorCode()
{
    return 0;
}

INT32 mmChmod(const CHAR *fileName,INT32 mode)
{
    return 0;
}


}

std::string GetAdxWorkPath()
{
    return "~/";
}

INT32 mmMutexInit(mmMutex_t *mutex)
 {
     if (mutex == NULL) {
         return EN_INVALID_PARAM;
     }
 
     INT32 ret = pthread_mutex_init(mutex, NULL);
     if (ret != EN_OK) {
         ret = EN_ERROR;
     }
 
     return ret;
 }

INT32 mmMutexLock(mmMutex_t *mutex)
 {
     if (mutex == NULL) {
         return EN_INVALID_PARAM;
     }
 
     INT32 ret = pthread_mutex_lock(mutex);
     if (ret != EN_OK) {
         ret = EN_ERROR;
     }
     return ret;
 }

 INT32 mmMutexUnLock(mmMutex_t *mutex)
 {
     if (mutex == NULL) {
         return EN_INVALID_PARAM;
     }
 
     INT32 ret = pthread_mutex_unlock(mutex);
     if (ret != EN_OK) {
         ret = EN_ERROR;
     }
     return ret;
 }

INT32 mmGetTid()
{
    INT32 ret = (INT32)syscall(SYS_gettid);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
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

INT32 mmGetOptLong(INT32 argc, CHAR * const * argv, const CHAR *opts, const mmStructOption *longopts, INT32 *longindex)
{
    return getopt_long(argc, argv, opts, longopts, longindex);
}

INT32 mmGetOpt(INT32 argc, CHAR * const * argv, const CHAR *opts)
{
    return getopt(argc, argv, opts);
}

char *mmGetOptArg()
{
    return optarg;
}

INT32 mmGetOptInd()
{
    return optind;
}

CHAR *mmGetErrorFormatMessage(int errnum, CHAR *buf, size_t  size)
{
    if (buf == NULL || size <= 0) {
        return NULL;
    }
    return strerror_r(errnum, buf, size);
}

INT32 mmGetCwd(CHAR *buffer, INT32 maxLen)
{
    if ((buffer == NULL) || (maxLen < MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    const CHAR *ptr = getcwd(buffer, (UINT32)maxLen);
    if (ptr != NULL) {
        return EN_OK;
    } else {
        return EN_ERROR;
    }
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
