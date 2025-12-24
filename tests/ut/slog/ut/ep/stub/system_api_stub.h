/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <unistd.h>
#include <stdbool.h>
#include <time.h>
#include <pthread.h>

#ifdef __cplusplus
extern "C" {
#endif

// stub for time
int usleep_stub(unsigned int microSeconds);
int clock_gettime_stub(clockid_t clock_id, struct timespec *tp);
// stub for thread
int pthread_mutex_lock_stub(pthread_mutex_t *mutex);
int pthread_mutex_unlock_stub(pthread_mutex_t *mutex);
int pthread_cond_signal_stub(pthread_cond_t *cond);
bool CheckMutex(void);

#ifdef __cplusplus
}
#endif