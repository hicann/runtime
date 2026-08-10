/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "modena_platform.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
constexpr char MODENA_PIPEUTILIZATION[] = "0x501,0x301,0x1,0x202,0x203,0x34,0x35";
constexpr char MODENA_MEMORY[] = "0x400,0x401,0x56f,0x570";
constexpr char MODENA_MEMORYUB[] = "0x3,0x5,0x204,0x206,0x571,0x572";
constexpr char MODENA_ARITHMETICUTILIZATION[] = "0x32c,0x32d";
constexpr char MODENA_RESOURCECONFLICTRATIO[] = "0x540,0x556";
constexpr uint16_t MAX_MODENA_MONITOR_NUM = 8;

PLATFORM_REGISTER(CHIP_5162A, ModenaPlatform);
ModenaPlatform::ModenaPlatform()
{
    supportedFeature_ = {PLATFORM_TASK_AU_PMU,       PLATFORM_TASK_PU_PMU,  PLATFORM_TASK_MEMORY_PMU,
                         PLATFORM_TASK_MEMORYUB_PMU, PLATFORM_TASK_RCR_PMU, PLATFORM_TASK_TRACE,
                         PLATFORM_TASK_METRICS,      PLATFORM_TASK_SWITCH,  PLATFORM_TASK_AIC_METRICS};
}

std::string ModenaPlatform::GetPipeUtilizationMetrics() { return MODENA_PIPEUTILIZATION; }

std::string ModenaPlatform::GetMemoryMetrics() { return MODENA_MEMORY; }

std::string ModenaPlatform::GetMemoryUBMetrics() { return MODENA_MEMORYUB; }

std::string ModenaPlatform::GetArithmeticUtilizationMetrics() { return MODENA_ARITHMETICUTILIZATION; }

std::string ModenaPlatform::GetResourceConflictRatioMetrics() { return MODENA_RESOURCECONFLICTRATIO; }

uint16_t ModenaPlatform::GetMaxMonitorNumber() const { return MAX_MODENA_MONITOR_NUM; }
} // namespace Platform
} // namespace Collect
} // namespace Dvvp
