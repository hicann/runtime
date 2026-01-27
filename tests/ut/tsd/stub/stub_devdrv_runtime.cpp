/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include "driver/ascend_hal.h"
#include "runtime/dev.h"

pid_t drvDeviceGetBareTgid(void)
{
    return getpid();
}

drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *devIndex)
{
    *devIndex = phyId;
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    *phyId = devIndex;
    return DRV_ERROR_NONE;
}

drvError_t drvGetProcessSign(struct process_sign *sign)
{
    sign->tgid = 1000;
    sign->sign[0] = 'a';
    sign->sign[1] = '\0';
    sign->resv[0] = '\0';
    return DRV_ERROR_NONE;
}
drvError_t drvGetPlatformInfo(uint32_t *info)
{
    char *is_start = getenv("RUN_MODE");
    if (is_start != nullptr && strcmp("THREAD", is_start) == 0) {
        *info = 0; // OFFLINE
    } else {
        *info = 1; //ONLINE
    }
    return DRV_ERROR_NONE;
}
int InitAICPUScheduler(const uint32_t a, const pid_t b, const uint32_t c)
{
    return 0;
}
int StopAICPUScheduler(const uint32_t a, const pid_t b)
{
    return 0;
}

rtError_t rtGetDeviceIndexByPhyId(uint32_t phyId, uint32_t *devIndex)
{
    *devIndex = phyId;
    return RT_ERROR_NONE;
}
