/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BASIC_OSAL_OSAL_THREAD_H
#define BASIC_OSAL_OSAL_THREAD_H
#include <pthread.h>
#include "osal.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cpluscplus

typedef pthread_mutex_t OsalMutex;
typedef pthread_cond_t OsalCond;

int32_t OsalMutexInit(OsalMutex *mutex);
int32_t OsalMutexLock(OsalMutex *mutex);
int32_t OsalMutexUnlock(OsalMutex *mutex);
int32_t OsalMutexDestroy(OsalMutex *mutex);
int32_t OsalCondInit(OsalCond *condition);
int32_t OsalCondDestroy(OsalCond *condition);
int32_t OsalCondSignal(OsalCond *condition);
VOID OsalCondWait(OsalCond *condition, OsalMutex *mutex);
int32_t OsalCreateThread(OsalThread *threadHandle, UserProcFunc func);

#ifdef __cplusplus
}
#endif  // __cpluscplus
#endif