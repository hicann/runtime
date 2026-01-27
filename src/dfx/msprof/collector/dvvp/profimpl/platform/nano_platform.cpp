/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "nano_platform.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
constexpr char NANO_PIPEUTILIZATION[] = "0x300,0x400,0x100,0x200,0x201,0x202,0x302,0x203,0x101,0x102";
constexpr char NANO_PIPESTALLCYCLE[] = "0x406,0x305,0x600,0x601,0x602,0x603,0x604,0x605,0x606,0x607";
constexpr char NANO_MEMORY[] = "0x201,0x202,0x204,0x205";
constexpr char NANO_MEMORYUB[] = "0x206,0x207,0x208,0x209,0x303,0x304,0x106,0x107";
constexpr char NANO_SCALAR_RATIO[] = "0x103,0x104,0x105";

PLATFORM_REGISTER(CHIP_NANO_V1, NanoPlatform);
NanoPlatform::NanoPlatform()
{
    supportedFeature_ = {PLATFORM_TASK_SCALAR_RATIO_PMU, PLATFORM_TASK_PU_PMU, PLATFORM_TASK_PSC_PMU,
        PLATFORM_TASK_MEMORY_PMU, PLATFORM_TASK_MEMORYUB_PMU, PLATFORM_TASK_TRACE, PLATFORM_TASK_METRICS,
        PLATFORM_TASK_SWITCH};
}

std::string NanoPlatform::GetScalarMetrics()
{
    return NANO_SCALAR_RATIO;
}

std::string NanoPlatform::GetPipeUtilizationMetrics()
{
    return NANO_PIPEUTILIZATION;
}

std::string NanoPlatform::GetPipeStallCycleMetrics()
{
    return NANO_PIPESTALLCYCLE;
}

std::string NanoPlatform::GetMemoryMetrics()
{
    return NANO_MEMORY;
}

std::string NanoPlatform::GetMemoryUBMetrics()
{
    return NANO_MEMORYUB;
}
}
}
}