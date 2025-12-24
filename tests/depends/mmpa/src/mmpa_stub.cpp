/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mmpa/mmpa_api.h"
#include "acl_stub.h"
#include <string.h>

INT32 aclStub::mmAccess2(const CHAR *pathName, INT32 mode)
{
    return 0;
}

void* aclStub::mmAlignMalloc(mmSize mallocSize, mmSize alignSize)
{
    return malloc(mallocSize);
}

INT32 aclStub::mmDladdr(VOID *addr, mmDlInfo *info)
{
    return 0;
}

INT32 mmScandir(const CHAR *path, mmDirent ***entryList, mmFilter filterFunc,  mmSort sort)
{
    return 0;
}

VOID mmScandirFree(mmDirent **entryList, INT32 count)
{
}

INT32 mmScandir2(const CHAR *path, mmDirent2 ***entryList, mmFilter2 filterFunc,  mmSort2 sort)
{
    if ((path == NULL) || (entryList == NULL)) {
        return EN_INVALID_PARAM;
    }
    INT32 count = scandir(path, entryList, filterFunc, sort);
    if (count < 0) {
        return EN_ERROR;
    }
    return count;
}

VOID mmScandirFree2(mmDirent2 **entryList, INT32 count)
{
    if (entryList == NULL) {
        return;
    }
    for (int j = 0; j < count; ++j) {
        if (entryList[j] != NULL) {
            free(entryList[j]);
            entryList[j] = NULL;
        }
    }
    free(entryList);
}

INT32 mmAccess2(const CHAR *pathName, INT32 mode)
{
    return MockFunctionTest::aclStubInstance().mmAccess2(pathName, mode);
}

INT32 mmRealPath(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    INT32 ret = EN_OK;
    if (path == nullptr || realPath == nullptr || realPathLen < MMPA_MAX_PATH) {
        return EN_INVALID_PARAM;
    }
    char *ptr = realpath(path, realPath);
    if (ptr == nullptr) {
        ret = EN_ERROR;
    }
    return ret;
}

INT32 mmStatGet(const CHAR *path,  mmStat_t *buffer)
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

INT32 mmGetErrorCode()
{
    return 0;
}

mmTimespec mmGetTickCount()
{
    mmTimespec time;
    time.tv_nsec = 1;
    time.tv_sec = 1;
    return time;
}

INT32 mmGetTid()
{
    INT32 ret = (INT32)syscall(SYS_gettid);

    if (ret < MMPA_ZERO) {
        return EN_ERROR;
    }

    return ret;
}

INT32 mmIsDir(const CHAR *fileName)
{
    if (fileName == nullptr) {
        return EN_ERR;
    }

    DIR *pDir = opendir (fileName);
    if (pDir != nullptr) {
        (void) closedir (pDir);
        return EN_OK;
    }
    return EN_ERR;
}

INT32 mmGetPid()
{
    return (INT32)getpid();
}

INT32 mmGetTimeOfDay(mmTimeval *timeVal, mmTimezone *timeZone)
{
    if (timeVal == nullptr) {
        return -1;
    }
    int32_t ret = gettimeofday((struct timeval *)timeVal, (struct timezone *)timeZone);
    return ret;
}

INT32 mmSleep(UINT32 milliSecond)
{
    usleep(milliSecond);
    return 0;
}

mmSize mmGetPageSize()
{
    return 2;
}

void *mmAlignMalloc(mmSize mallocSize, mmSize alignSize)
{
    return MockFunctionTest::aclStubInstance().mmAlignMalloc(mallocSize, alignSize);
}

VOID mmAlignFree(VOID *addr)
{
    if (addr != nullptr) {
        free(addr);
    }
}

INT32 mmRWLockInit(mmRWLock_t *rwLock)
{
    return 0;
}

INT32 mmRWLockDestroy(mmRWLock_t *rwLock)
{
    return 0;
}

INT32 mmRWLockRDLock(mmRWLock_t *rwLock)
{
    return 0;
}

INT32 mmRDLockUnLock(mmRWLock_t *rwLock)
{
    return 0;
}

INT32 mmRWLockWRLock(mmRWLock_t *rwLock)
{
    return 0;
}

INT32 mmWRLockUnLock(mmRWLock_t *rwLock)
{
    return 0;
}

CHAR *mmGetErrorFormatMessage(mmErrorMsg errnum, CHAR *buf, mmSize size)
{
    static char errInfo[10] = "ErrorMsg";
    return errInfo;
}

CHAR *mmDlerror()
{
    static char errInfo[10] = "ErrorInfo";
    return errInfo;
}

INT32 mmDladdr(VOID *addr, mmDlInfo *info)
{
    return MockFunctionTest::aclStubInstance().mmDladdr(addr, info);
}