/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "bqs_util.h"
#include <sys/time.h>

namespace bqs {
RunContext GetRunContext()
{
    return RunContext::DEVICE;
}

uint64_t GetNowTime()
{
    uint64_t timestamp = 0UL;
    struct timeval tv;
    if (gettimeofday(&tv, nullptr) == 0) {
        timestamp = (static_cast<uint64_t>(tv.tv_sec) * 1000000UL) + static_cast<uint64_t>(tv.tv_usec);
    }
    return timestamp;
}
}