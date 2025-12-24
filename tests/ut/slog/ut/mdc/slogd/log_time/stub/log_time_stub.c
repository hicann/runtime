/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_time_stub.h"

int32_t clock_gettime_stub(clockid_t clockId, struct timespec *currentTv)
{
    if (clockId == 0) {
        currentTv->tv_sec = 0;
        currentTv->tv_nsec = 0;
    } else if (clockId == 100) {
        currentTv->tv_sec = 100;
        currentTv->tv_nsec = 100;
    } else {
        currentTv->tv_sec = 1;
        currentTv->tv_nsec = 1;
    }
    return 0;
}