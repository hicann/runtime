/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <mmpa/mmpa_api.h>
#include <unistd.h>
#include <iostream>
#include <dirent.h>

INT32 mmGetPid()
{
    return (INT32)1;
}

INT32 mmGetTid()
{
    return (INT32)1;
}

INT32 mmRealPath(const CHAR *path, CHAR *exactPath, INT32 realPathLen)
{
    if(path == nullptr||exactPath == nullptr)
    {
        return EN_INVALID_PARAM;
    }
    if (nullptr == realpath(path, exactPath))
    {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmUnlink(const CHAR *filename) {
    return unlink(filename);
}

mmTimespec mmGetTickCount()
{
    mmTimespec spec;
    spec.tv_sec=1;
    spec.tv_nsec=1;
    return spec;
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

INT32 mmCreateTask(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock)
{
    return 0;
}

INT32 mmJoinTask(mmThread *pstThreadHandle)
{
    return 0;
}

INT32 mmCreateTaskWithAttr(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock)
{
    return 0;
}

INT32 mmSetThreadPrio(mmThread *pstThreadHandle, INT32 threadPrio)
{
    return 0;
}

INT32 mmSetThreadName(mmThread *pstThreadHandle, const CHAR* name)
{
    return 0;
}

INT32 mmGetThreadName(mmThread *pstThreadHandle, CHAR* name,INT32 size)
{
    return 0;
}

INT32 mmSleep(UINT32 millseconds)
{
    return 0;
}


INT32 mmMutexInit( mmMutex_t* mutex )
{
    return 0;
}

INT32 mmMutexLock( mmMutex_t* mutex )
{
    return 0;
}

INT32 mmMutexUnLock( mmMutex_t* mutex )
{
    return 0;
}

INT32 mmMutexDestory( mmMutex_t* mutex )
{
    return 0;
}

INT32 mmMutexDestroy( mmMutex_t* mutex )
{
    return 0;
}

INT32 mmDlclose(VOID *handle)
{
    if (handle == NULL) {
        return EN_INVALID_PARAM;
    }
    free(handle);
    return EN_OK;
}

VOID *mmDlopen(const CHAR *fileName, INT32 mode)
{
    if ((fileName == NULL) || (mode < MMPA_ZERO)) {
        return NULL;
    }
    return malloc(10);
    //return dlopen(fileName, mode);
}

VOID *mmDlsym(VOID *handle, const CHAR *funcName)
{
    if ((handle == NULL) || (funcName == NULL)) {
        return NULL;
    }
    return handle;
    return dlsym(handle, funcName);
}

CHAR* mmDlerror(void)
{
    return nullptr;
}

INT32 mmOpen(const CHAR *pathName, INT32 flags)
{
    return open(pathName,flags);
}

INT32 mmClose(INT32 fd)
{
    return close(fd);
}

mmSsize_t mmRead (INT32 fd, VOID* mmBuf, UINT32 mmCount)
{
    return read(fd,mmBuf,mmCount);
}

mmSsize_t mmWrite (INT32 fd, VOID* mmBuf, UINT32 mmCount)
{
    return write(fd,mmBuf,mmCount);
}

INT32 mmOpen2(const CHAR *pathName, INT32 flags, MODE mode)
{
    return open(pathName,flags,mode);
}

INT32 mmStatGet(const CHAR *path,  mmStat_t *buffer)
{
    return stat(path,buffer);
}

INT32 mmGetLocalTime(mmSystemTime_t * st)
{
    time_t raw_time = time(NULL);    // ��ȡԭʼʱ��
    struct tm *timeinfo;
    timeinfo = localtime(&raw_time);    // ת��Ϊtimeinfo

    if(nullptr == st)
        return -1;
    else
    {
        st->wSecond = timeinfo->tm_sec;
        st->wMinute = timeinfo->tm_min;
        st->wHour = timeinfo->tm_hour;
        st->wDay = timeinfo->tm_mday;
        st->wMonth = timeinfo->tm_mon;
        st->wYear = timeinfo->tm_year;
        st->wDayOfWeek = timeinfo->tm_wday;
        st->tm_yday = timeinfo->tm_yday;
        st->tm_isdst = timeinfo->tm_isdst;
    }

    return 0;
}

INT32 mmMkdir(const CHAR* lpPathName, mmMode_t mode)
{
    return mkdir(lpPathName,mode);
}

INT32 mmAccess(const CHAR* lpPathName)
{
    return access(lpPathName, F_OK);
}

INT32 mmRmdir(const CHAR* lpPathName)
{
    char cmd[4096] = { '\0' };
    sprintf_s(cmd, 4096, "rm -rf %s", lpPathName);
    system(cmd);
    return EN_OK;
}

LONG mmLseek(INT32 fd, INT64 offset, INT32 seekFlag)
{
    return lseek(fd, offset, seekFlag);
}

INT32 mmSetEnv(const CHAR *name, const CHAR *value, INT32 overwrite)
{
    return setenv(name, value, overwrite);
}

INT32 mmGetEnv(const CHAR *name, CHAR *value, UINT32 len)
{
    INT32 ret;
    UINT32 envLen = 0;
    if (name == NULL || value == NULL || len == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    CHAR *envPtr = getenv(name);
    if (envPtr == NULL || strlen(envPtr) == 0) {
        return EN_ERROR;
    }

    UINT32 lenOfRet = (UINT32)strlen(envPtr);
    if( lenOfRet < (MMPA_MEM_MAX_LEN - 1)) {
        envLen = lenOfRet + 1;
    }

    if (envLen != MMPA_ZERO && len < envLen) {
        return EN_INVALID_PARAM;
    } else {
        ret = memcpy_s(value, len, envPtr, envLen);
        if (ret != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

INT32 mmUmask(INT32 pmode)
{
    mode_t mode = (mode_t)pmode;
    return (INT32)umask(mode);
}

INT32 mmChmod(const CHAR *filename, INT32 mode)
{
    if (filename == NULL) {
        return EN_INVALID_PARAM;
    }

    return chmod(filename, mode);
}

INT32 mmGetDiskFreeSpace(const CHAR *path, mmDiskSize *diskSize)
{
    if ((path == NULL) || (diskSize == NULL)) {
        return EN_INVALID_PARAM;
    }

    // 把文件系统信息读入 struct statvfs buf 中
    struct statvfs buf;
    (void)memset(&buf, 0, sizeof(buf)); /* unsafe_function_ignore: memset */

    INT32 ret = statvfs(path, &buf);
    if (ret == MMPA_ZERO) {
        diskSize->totalSize = (ULONGLONG)(buf.f_blocks * buf.f_bsize);
        diskSize->availSize = (ULONGLONG)(buf.f_bavail * buf.f_bsize);
        diskSize->freeSize = (ULONGLONG)(buf.f_bfree * buf.f_bsize);
        return EN_OK;
    }
    return EN_ERROR;
}

INT32 mmIsDir(const CHAR *fileName)
{
    if (fileName == NULL) {
        return EN_INVALID_PARAM;
    }
    struct stat fileStat;
    (void)memset_s(&fileStat, sizeof(fileStat), 0, sizeof(fileStat)); /* unsafe_function_ignore: memset */
    INT32 ret = lstat(fileName, &fileStat);
    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    if (!S_ISDIR(fileStat.st_mode)) {
        return EN_ERROR;
    }
    return EN_OK;
}

INT32 mmLocalTimeR(const time_t *timep, struct tm *result)
{
    if ((timep == NULL) || (result == NULL)) {
        return EN_INVALID_PARAM;
    } else {
        time_t time = *timep;
        struct tm nowTime = {0};
        struct tm *tmp = localtime_r(&time, &nowTime);
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

INT32 mmScandir2(const CHAR *path, mmDirent2 ***entryList, mmFilter2 filterFunc, mmSort2 sort)
{
    if ((path == NULL) || (entryList == NULL)) {
        return EN_INVALID_PARAM;
    }
    INT32 count = scandir(path, entryList, filterFunc, sort);
    if (count < MMPA_ZERO) {
        return EN_ERROR;
    }
    return count;
}

void mmScandirFree2(mmDirent2 **entryList, INT32 count)
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
    entryList = NULL;
}

CHAR *mmSysGetEnv(mmEnvId id)
{
   return nullptr;
}

INT32 mmSysSetEnv(mmEnvId id, const CHAR *value, INT32 overwrite)
{
    return 0;
}