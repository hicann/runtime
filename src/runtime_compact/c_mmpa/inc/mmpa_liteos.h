/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_MMPA_MMPA_LITEOS_H
#define C_MMPA_MMPA_LITEOS_H
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "securec.h"
#include "hal_ts.h"
#include "los_atomic.h"
#include "los_mux.h"
#include "los_task.h"
#include "file_if.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif  // __cpluscplus
#endif  // __cpluscplus

typedef uint32_t mmMutex_t;
typedef Atomic mmAtomicType;
typedef Atomic64 mmAtomicType64;
typedef file_t mmFileHandle;

#define EN_OK LOS_OK
#define EN_ERROR (-1)
#define EN_INVALID_PARAM (-2)
#define LITEOS_PATH_MAX 128
#define MMPA_MAX_PATH 4096
#define MM_R_OK 4 /* Test for read permission. */
#define MM_W_OK 2 /* Test for write permission. */
#define MM_X_OK 1 /* Test for execute permission. */
#define MM_F_OK 0 /* Test for existence. */
#define MM_SEEK_FILE_BEGIN SEEK_FILE_BEGIN
#define MM_SEEK_CUR_POS SEEK_CUR_POS
#define MM_SEEK_FILE_END SEEK_FILE_END
#define MM_TASK_ID_INVALID LOS_ERRNO_TSK_ID_INVALID

typedef enum {
    FILE_READ = 0,
    FILE_READ_BIN,
    FILE_MODE_BUTT
} MM_FILE_MODE;

static inline int32_t mmSetData(mmAtomicType *ptr, int32_t value)
{
    return LOS_AtomicXchg32bits(ptr, value);
}

static inline int64_t mmSetData64(mmAtomicType64 *ptr, int64_t value)
{
    return LOS_AtomicXchg64bits(ptr, value);
}

static inline int32_t mmValueInc(mmAtomicType *ptr, int32_t value)
{
    return LOS_AtomicAdd(ptr, value);
}

static inline bool mmCompareAndSwap(mmAtomicType *ptr, int32_t oldval, int32_t newval)
{
    return !LOS_AtomicCmpXchg32bits(ptr, newval, oldval);
}

static inline bool mmCompareAndSwap64(mmAtomicType64 *ptr, int64_t oldval, int64_t newval)
{
    return !LOS_AtomicCmpXchg64bits(ptr, newval, oldval);
}

static inline void mmValueStore(mmAtomicType *ptr, int32_t value)
{
    LOS_AtomicSet(ptr, value);
}

static inline int32_t mmMutexInit(mmMutex_t *mutex)
{
    return (LOS_MuxCreate(mutex) != EN_OK) ? EN_ERROR : EN_OK;
}

static inline int32_t mmMutexLock(mmMutex_t *mutex)
{
    return (LOS_MuxPend(*mutex, LOS_WAIT_FOREVER) != EN_OK) ? EN_ERROR : EN_OK;
}

static inline int32_t mmMutexUnLock(mmMutex_t *mutex)
{
    return (LOS_MuxPost(*mutex) != EN_OK) ? EN_ERROR : EN_OK;
}

static inline int32_t mmMutexDestroy(mmMutex_t *mutex)
{
    return (LOS_MuxDelete(*mutex) != EN_OK) ? EN_ERROR : EN_OK;
}

static inline void mmSchedYield(void)
{
    (void)LOS_TaskYield();
}

static inline uint64_t mmGetTaskId(void)
{
    return LOS_CurTaskIDGet();
}

static inline size_t mmReadFile(void *ptr, int32_t size, int32_t nitems, mmFileHandle *fd)
{
    return file_read(ptr, size, nitems, fd);
}

static inline mmFileHandle *mmOpenFile(const char *fileName, int32_t mode)
{
    mmFileHandle *fd = NULL;
    if (fileName == NULL || strlen(fileName) == 0) {
        return fd;
    }
    if (mode == FILE_READ || mode == FILE_READ_BIN) {
        fd = file_open(fileName, "r");
    }
    return fd;
}

static inline int32_t mmCloseFile(mmFileHandle *fd)
{
    return file_close(fd);
}

static inline int32_t mmRealPath(const char *path, char *realPath, int32_t realPathLen)
{
    int32_t ret  = strcpy_s(realPath, realPathLen, path);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

static inline int32_t mmAccess(const char *pathName, int32_t mode)
{
    (void)mode;
    return (strlen(pathName) > LITEOS_PATH_MAX) ? EN_ERROR : EN_OK;
}

static inline int32_t mmSeekFile(mmFileHandle *fd, int64_t offset, int32_t seekFlag)
{
    return file_seek(fd, (long)offset, seekFlag);
}

static inline long mmTellFile(mmFileHandle *fd)
{
    return file_tell(fd);
}

static inline void *mmMalloc(unsigned long long size)
{
    void *ptr = NULL;
    return (halHostMemAlloc(&ptr, size, 0) == EN_OK) ? ptr : NULL;
}

static inline void mmFree(void *ptr)
{
    halHostMemFree(ptr);
}
#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif // __cpluscplus

#endif // C_MMPA_MMPA_LITEOS_H