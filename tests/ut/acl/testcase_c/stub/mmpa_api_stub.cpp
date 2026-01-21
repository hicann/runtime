/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include "mmpa_api.h"

uint32_t mmSetData(mmAtomicType *ptr, uint32_t value) {
  return __sync_lock_test_and_set(static_cast<uint32_t *>(ptr), value);
}

uint64_t mmSetData64(mmAtomicType64 *ptr, uint64_t value) {
  return __sync_lock_test_and_set(static_cast<uint64_t *>(ptr), value);
}

uint32_t mmValueInc(mmAtomicType *ptr, uint32_t value) {
  return __sync_fetch_and_add(static_cast<uint32_t *>(ptr), value);
}

bool mmCompareAndSwap(mmAtomicType *ptr, uint32_t oldval, uint32_t newval) {
  return __sync_bool_compare_and_swap(static_cast<uint32_t *>(ptr), oldval, newval);
}

bool mmCompareAndSwap64(mmAtomicType64 *ptr, uint32_t oldval, uint32_t newval) {
  return __sync_bool_compare_and_swap(static_cast<uint64_t *>(ptr), static_cast<uint64_t>(oldval), static_cast<uint64_t>(newval));
}

void mmValueStore(mmAtomicType *ptr, uint32_t value) {
  __atomic_store(ptr, &value, __ATOMIC_SEQ_CST);
}

int32_t mmMutexInit(mmMutex_t *mutex) {
  return pthread_mutex_init(mutex, nullptr);
}

int32_t mmMutexLock(mmMutex_t *mutex) {
  return pthread_mutex_lock(mutex);
}

int32_t mmMutexUnLock(mmMutex_t *mutex) {
  return pthread_mutex_unlock(mutex);
}

int32_t mmMutexDestroy(mmMutex_t *mutex) {
  return pthread_mutex_destroy(mutex);
}

void mmSchedYield(void) {
  (void)sched_yield();
}

uint64_t mmGetTaskId(void) {
  return static_cast<uint64_t>(syscall(SYS_gettid));
}

mmFileHandle *mmOpenFile(const char *fileName, int32_t mode) {
  mmFileHandle *fd = nullptr;
  if (mode == FILE_READ) {
    fd = fopen(fileName, "r");
  }
  if (mode == FILE_READ_BIN) {
    fd = fopen(fileName, "rb");
  }
  return fd;
}

size_t mmReadFile(void *ptr, int32_t size, int32_t nitems, mmFileHandle *fd) {
  return fread(ptr, static_cast<size_t>(size), static_cast<size_t>(nitems), fd);
}

int32_t mmCloseFile(mmFileHandle *fd) {
  return fclose(fd);
}
int32_t mmRealPath(const char *path, char *realPath, int32_t realPathLen) {
  (void)realPathLen;
  if ( path == nullptr || realPath == nullptr)
    return EN_INVALID_PARAM;
  return realpath(path, realPath) == nullptr ? EN_ERROR : EN_OK;
}
int32_t mmAccess(const char *pathName, int32_t mode) {
  return access(pathName, mode);
}

int32_t mmSeekFile(mmFileHandle *fd, int64_t offset, int32_t seekFlag) {
  return fseek(fd, static_cast<long>(offset), seekFlag);
}

long mmTellFile(mmFileHandle *fd) {
  return ftell(fd);
}

void *mmMalloc(unsigned long long size) {
  return MmpaStubMock::GetInstance().mmMalloc(size);
}

void *mmMalloc_Normal_Invoke(unsigned long long size) {
  std::cout<<"called mmMalloc_Normal_Invoke!"<<std::endl;
  return malloc(size);
}

void *mmMalloc_Abnormal_Invoke(unsigned long long size) {
  std::cout<<"called mmMalloc_AbNormal_Invoke!"<<std::endl;
  size++;
  return nullptr;
}

void mmFree(void *ptr) {
  free(ptr);
}