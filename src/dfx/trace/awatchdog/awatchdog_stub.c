/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "awatchdog.h"

AwdHandle AwdCreateThreadWatchdog(uint32_t dogId, uint32_t timeout, AwatchdogCallbackFunc callback)
{
    (void)dogId;
    (void)timeout;
    (void)callback;
    return AWD_INVALID_HANDLE;
}

void AwdDestroyThreadWatchdog(AwdHandle handle)
{
    if (handle == AWD_INVALID_HANDLE) {
        return;
    }
    AwdThreadWatchdog *dog = (AwdThreadWatchdog *)handle;
    AWD_ATOMIC_TEST_AND_SET(&dog->startCount, AWD_STATUS_DESTROYED);
}