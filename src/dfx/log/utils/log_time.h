/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_TIME_H
#define LOG_TIME_H

#include <time.h>
#include <stdbool.h>
#include "log_error_code.h"

#define LOG_CLOCK_ID_0          0
#define LOG_CLOCK_ID_100        100
#define LOG_CLOCK_ID_DEFAULT    100
#define TIME_STR_SIZE           32
#define US_TO_MS                1000U
#define US_TO_MS_SIGNED         1000
#define US_TO_NS                1000U
#define MS_TO_NS                1000000L
#define SEC_TO_NS               1000000000ULL
#define NS_TO_MS                1000000
#define S_TO_MS                 1000
#define FREQ_GHZ_TO_KHZ         1000000ULL
#define TICK_TO_US              (FREQ_GHZ_TO_KHZ / US_TO_NS)

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

LogStatus LogGetTime(struct timespec *currentTimeval, bool *isInit, clockid_t *clockId);
LogStatus LogGetMonotonicTime(struct timespec *currentTimeval);
LogStatus LogGetTimeStr(char *timeStr, uint32_t len);
uint64_t LogGetCpuCycleCounter(void);
uint64_t LogGetCpuFrequency(void);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif