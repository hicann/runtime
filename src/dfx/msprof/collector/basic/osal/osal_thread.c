/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "osal_thread.h"

int32_t OsalMutexInit(OsalMutex *mutex)
{
    return pthread_mutex_init(mutex, NULL);
}

int32_t OsalMutexLock(OsalMutex *mutex)
{
    return pthread_mutex_lock(mutex);
}

int32_t OsalMutexUnlock(OsalMutex *mutex)
{
    return pthread_mutex_unlock(mutex);
}

int32_t OsalMutexDestroy(OsalMutex *mutex)
{
    return pthread_mutex_destroy(mutex);
}

int32_t OsalCondInit(OsalCond *condition)
{
    return pthread_cond_init(condition, NULL);
}

int32_t OsalCondDestroy(OsalCond *condition)
{
    return pthread_cond_destroy(condition);
}

int32_t OsalCondSignal(OsalCond *condition)
{
    return pthread_cond_signal(condition);
}

VOID OsalCondWait(OsalCond *condition, OsalMutex *mutex)
{
    (void)pthread_cond_wait(condition, mutex);
}

int32_t OsalCreateThread(OsalThread *threadHandle, UserProcFunc func)
{
    if ((threadHandle == NULL) || (func == NULL)) {
        return OSAL_EN_INVALID_PARAM;
    }
#ifdef LITE_OS
    pthread_attr_t attr;
    (VOID)memset_s(&attr, sizeof(attr), 0, sizeof(attr));
    int32_t ret = pthread_attr_init(&attr);
    if (ret != OSAL_EN_OK) {
        return OSAL_EN_ERROR;
    }

    ret = pthread_attr_setstacksize(&attr, OSAL_THREAD_POOL_STACK_SIZE);
    if (ret != OSAL_EN_OK) {
        (VOID)pthread_attr_destroy(&attr);
        return OSAL_EN_ERROR;
    }

    ret = pthread_create(threadHandle, &attr, func, NULL);
    (VOID)pthread_attr_destroy(&attr);
#else
    int32_t ret = pthread_create(threadHandle, NULL, func, NULL);
#endif
    if (ret != OSAL_EN_OK) {
        ret = OSAL_EN_ERROR;
    }

    return ret;
}
