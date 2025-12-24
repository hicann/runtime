/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AWATCHDOG_CORE_H
#define AWATCHDOG_CORE_H

#include "awatchdog.h"
#include "adiag_list.h"
#include "awatchdog_types.h"

typedef struct AwdWatchDog {
    struct AdiagList runList;
    struct AdiagList newList;
} AwdWatchDog;

typedef struct AwdWatchdogMgr {
    AwdWatchDog awd[AWD_WATCHDOG_TYPE_MAX];
    bool enable; // watchdog feature is support on current platform or not
    bool monitorStarted;  // monitor thread start or not
} AwdWatchdogMgr;

AwdThreadWatchdog *AwdWatchdogCreate(uint32_t dogId, uint32_t timeout, AwatchdogCallbackFunc callback,
    enum AwdWatchdogType type);
struct AwdWatchDog* AwdGetWatchDog(enum AwdWatchdogType type);

#endif