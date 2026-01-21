/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef UT_TESTCASE_C_MMPA_API_H
#define UT_TESTCASE_C_MMPA_API_H
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <pthread.h>
#include <ctype.h>
#include <stddef.h>
#include <stdint.h>
#include <sched.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <stdbool.h>
#include <limits.h>
#include <stdlib.h>
#ifdef __cplusplus
#if __cplusplus
#include <vector>
#include <dlfcn.h>
#include <gtest/gtest.h>
#include <gmock/gmock.h>

extern "C" {
#endif // __cplusplus
#endif // __cplusplus
#define EN_OK 0
#define EN_ERROR (-1)
#define EN_INVALID_PARAM (-2)
#define MMPA_MAX_PATH PATH_MAX
#define MM_R_OK R_OK /* Test for read permission. */
#define MM_W_OK W_OK /* Test for write permission. */
#define MM_X_OK X_OK /* Test for execute permission. */
#define MM_F_OK F_OK /* Test for existence. */
typedef FILE mmFileHandle;
#define MM_SEEK_FILE_BEGIN SEEK_SET
#define MM_SEEK_CUR_POS SEEK_CUR
#define MM_SEEK_FILE_END SEEK_END
#define MM_TASK_ID_INVALID 0

typedef enum {
  FILE_READ = 0,
  FILE_READ_BIN,
  FILE_MODE_BUTT
} MM_FILE_MODE;

typedef pthread_mutex_t mmMutex_t;
typedef uint32_t mmAtomicType;
typedef uint64_t mmAtomicType64;

uint32_t mmSetData(mmAtomicType *ptr, uint32_t value);
uint64_t mmSetData64(mmAtomicType64 *ptr, uint64_t value);
uint32_t mmValueInc(mmAtomicType *ptr, uint32_t value);
bool mmCompareAndSwap(mmAtomicType *ptr, uint32_t oldval, uint32_t newval);
bool mmCompareAndSwap64(mmAtomicType64 *ptr, uint32_t oldval, uint32_t newval);
void mmValueStore(mmAtomicType *ptr, uint32_t value);
int32_t mmMutexInit(mmMutex_t *mutex);
int32_t mmMutexLock(mmMutex_t *mutex);
int32_t mmMutexUnLock(mmMutex_t *mutex);
int32_t mmMutexDestroy(mmMutex_t *mutex);
void mmSchedYield(void);
uint64_t mmGetTaskId(void);
size_t mmReadFile(void *ptr, int32_t size, int32_t nitems, mmFileHandle *fd);
mmFileHandle *mmOpenFile(const char *fileName, int32_t mode);
int32_t mmCloseFile(mmFileHandle *fd);
int32_t mmRealPath(const char *path, char *realPath, int32_t realPathLen);
int32_t mmAccess(const char *pathName, int32_t mode);
int32_t mmSeekFile(mmFileHandle *fd, int64_t offset, int32_t seekFlag);
long mmTellFile(mmFileHandle *fd);
void *mmMalloc(unsigned long long size);
void mmFree(void *ptr);
#ifdef __cplusplus
#if __cplusplus
}

class MmpaStubMock {
public:
  static MmpaStubMock& GetInstance() {
    static MmpaStubMock mock;
    return mock;
  }
  MOCK_METHOD1(mmMalloc, void*(unsigned long long size));
};

void *mmMalloc_Normal_Invoke(unsigned long long size);
void *mmMalloc_Abnormal_Invoke(unsigned long long size);
#endif /* __cplusplus */
#endif // __cplusplus

#endif // UT_TESTCASE_C_MMPA_API_H