/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AWATCHDOG_TYPES_H
#define AWATCHDOG_TYPES_H
#include <stdint.h>

#define AWD_EXPORT __attribute__((visibility("default")))
typedef void (*AwatchdogCallbackFunc) (void *);
typedef int32_t  AwdStatus;
typedef intptr_t AwdHandle;

// value of AwdStatus
#define AWD_SUCCESS              0
#define AWD_FAILURE              (-1)
#define AWD_INVLIAD_PARAM        (-2)

// value of AwdHandle
#define AWD_INVALID_HANDLE      (-1)
#define AWD_ALL_HANDLE          (0)

// watchdog status
#define AWD_STATUS_DESTROYED -2
#define AWD_STATUS_INIT -1
#define AWD_STATUS_STARTED 0

typedef struct AwdThreadWatchdog {
    uint32_t dogId;          // [31:16] watchdog type, [15:0] moduleId
    uint32_t timeout;        // timeout, s
    int32_t runCount;
    int32_t startCount;
    int32_t tid;
    int32_t pid;
    AwatchdogCallbackFunc callback;
} AwdThreadWatchdog;

#endif