/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_MMPA_MMPA_LINUX_H
#define C_MMPA_MMPA_LINUX_H
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
extern "C" {
#endif  // __cpluscplus
#endif  // __cpluscplus
#define EN_OK 0
#define EN_ERROR (-1)
#define EN_INVALID_PARAM (-2)
#define MMPA_MAX_PATH PATH_MAX
#define MM_R_OK R_OK  /* Test for read permission. */
#define MM_W_OK W_OK  /* Test for write permission. */
#define MM_X_OK X_OK  /* Test for execute permission. */
#define MM_F_OK F_OK  /* Test for existence. */
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

static inline uint32_t mmSetData(mmAtomicType *ptr, uint32_t value)
{
    return __sync_lock_test_and_set(ptr, value);
}

static inline uint64_t mmSetData64(mmAtomicType64 *ptr, uint64_t value)
{
    return __sync_lock_test_and_set(ptr, value);
}

static inline uint32_t mmValueInc(mmAtomicType *ptr, uint32_t value)
{
    return __sync_fetch_and_add(ptr, value);
}

static inline bool mmCompareAndSwap(mmAtomicType *ptr, uint32_t oldval, uint32_t newval)
{
    return __sync_bool_compare_and_swap(ptr, oldval, newval);
}

static inline bool mmCompareAndSwap64(mmAtomicType64 *ptr, uint64_t oldval, uint64_t newval)
{
    return __sync_bool_compare_and_swap(ptr, oldval, newval);
}

static inline void mmValueStore(mmAtomicType *ptr, uint32_t value)
{
    __atomic_store(ptr, &value,  __ATOMIC_SEQ_CST);
}

static inline int32_t mmMutexInit(mmMutex_t *mutex)
{
    return pthread_mutex_init(mutex, NULL);
}

static inline int32_t mmMutexLock(mmMutex_t *mutex)
{
    return pthread_mutex_lock(mutex);
}

static inline int32_t mmMutexUnLock(mmMutex_t *mutex)
{
    return pthread_mutex_unlock(mutex);
}

static inline int32_t mmMutexDestroy(mmMutex_t *mutex)
{
    return pthread_mutex_destroy(mutex);
}

static inline void mmSchedYield(void)
{
    (void)sched_yield();
}

static inline uint64_t mmGetTaskId(void)
{
    return (uint64_t)(syscall(SYS_gettid));
}

static inline size_t mmReadFile(void *ptr, int32_t size, int32_t nitems, mmFileHandle *fd)
{
    return fread(ptr, (size_t)size, (size_t)nitems, fd);
}

static inline mmFileHandle *mmOpenFile(const char *fileName, int32_t mode)
{
    mmFileHandle *fd = NULL;
    if (mode == FILE_READ) {
        fd = fopen(fileName, "r");
    }
    if (mode == FILE_READ_BIN) {
        fd = fopen(fileName, "rb");
    }
    return fd;
}

static inline int32_t mmCloseFile(mmFileHandle *fd)
{
    return fclose(fd);
}

static inline int32_t mmRealPath(const char *path, char *realPath, int32_t realPathLen)
{
    (void)realPathLen;
    return realpath(path, realPath) == NULL ? EN_ERROR : EN_OK;
}

static inline int32_t mmAccess(const char *pathName, int32_t mode)
{
    return access(pathName, mode);
}

static inline int32_t mmSeekFile(mmFileHandle *fd, int64_t offset, int32_t seekFlag)
{
    return fseek(fd, (long)offset, seekFlag);
}

static inline long mmTellFile(mmFileHandle *fd)
{
    return ftell(fd);
}

static inline void *mmMalloc(unsigned long long size)
{
    return malloc(size);
}

static inline void mmFree(void *ptr)
{
    free(ptr);
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif // __cpluscplus

#endif // C_MMPA_MMPA_LINUX_H