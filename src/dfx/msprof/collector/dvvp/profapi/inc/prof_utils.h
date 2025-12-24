/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_UTILS_H
#define PROF_UTILS_H
#include "pthread.h"
namespace ProfAPI {
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
using PTHREAD_ONCE_T = bool;
inline void PthreadOnce(bool *flag, void (*func)(void))
{
    if (*flag == false) {
        *flag = true;
        func();
    }
}
#else
using PTHREAD_ONCE_T = pthread_once_t;
inline void PthreadOnce(pthread_once_t *flag, void (*func)(void))
{
    (void)pthread_once(flag, func);
}
#endif
}
#endif