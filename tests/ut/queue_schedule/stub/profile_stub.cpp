/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "profiler.h"

int shm_open(const char *name, int oflag, mode_t mode)
{
    return 0;
}

namespace Hiva {
    ProfilerAgent::ProfilerAgent() {}
    ProfilerAgent::~ProfilerAgent() {}
namespace Utility {
static int CreateSharedRegion(const std::string& name, const std::size_t size,
    uint32_t op, uint32_t mode, void *&start, int &handle)
{
    return 0;
}
}

}

uint64_t GetCntVct()
{
    uint64_t  cntvct;
    return cntvct;
}