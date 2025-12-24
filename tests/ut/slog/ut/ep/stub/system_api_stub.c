/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "system_api_stub.h"

int usleep_stub(unsigned int microSeconds)
{
    return 0;
}

int clock_gettime_stub(clockid_t clock_id, struct timespec *tp)
{
    static long nsec = 0;
    nsec += 200 * 1000000; // 200ms
    tp->tv_nsec = nsec;
    return 0;
}

int g_mutexCount = 0;
int pthread_mutex_lock_stub(pthread_mutex_t *mutex)
{
    g_mutexCount++;
    return 0;
}

int pthread_mutex_unlock_stub(pthread_mutex_t *mutex)
{
    if (g_mutexCount <= 0) {
        return -1;
    }
    g_mutexCount--;
    return 0;
}

bool CheckMutex(void)
{
    return (g_mutexCount == 0) ? true : false;
}

int pthread_cond_signal_stub(pthread_cond_t *cond)
{
    return 0;
}