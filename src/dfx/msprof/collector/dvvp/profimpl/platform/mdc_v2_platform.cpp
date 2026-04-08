/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mdc_v2_platform.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
constexpr char MDC_V2_PIPEUTILIZATION[] = "0x501,0x301,0x1,0x701,0x202,0x203,0x34,0x35,0x714";
constexpr char MDC_V2_MEMORY[] = "0x400,0x401,0x56f,0x571,0x570,0x572,0x707,0x709";
constexpr char MDC_V2_MEMORYL0[] = "0x304,0x703,0x306,0x705,0x712,0x30a,0x308";
constexpr char MDC_V2_MEMORYUB[] = "0x3,0x5,0x70c,0x206,0x204,0x571,0x572";
constexpr char MDC_V2_AIRTHMETICUTILIZATION[] = "0x323,0x324";
constexpr char MDC_V2_RESOURCECONFLICTRATIO[] = "0x540,0x556,0x502,0x528";
constexpr char MDC_V2_L2CACHE[] = "0x424,0x425,0x426,0x42a,0x42b,0x42c";
constexpr char MDC_V2_L2CACHEEVENT[] = "0x00,0x81,0x82,0x83,0x74,0x75";
constexpr uint16_t MAX_QOS_MONITOR_NUM = 8;

PLATFORM_REGISTER(CHIP_MDC_V2, MdcV2Platform);
MdcV2Platform::MdcV2Platform()
{
    supportedFeature_ = {
        // TASK
        PLATFORM_TASK_ASCENDCL,
        PLATFORM_TASK_RUNTIME_API,
        PLATFORM_TASK_METRICS,
        PLATFORM_TASK_AIV_METRICS,
        PLATFORM_TASK_AIC_METRICS,
        PLATFORM_TASK_GE_API,
        PLATFORM_TASK_HCCL,
        PLATFORM_TASK_TSFW,
        PLATFORM_TASK_L2_CACHE_REG,
        PLATFORM_TASK_MEMORY,
        PLATFORM_TASK_MSPROFTX,
        PLATFORM_TASK_SWITCH,
        PLATFORM_TASK_TRACE,
        PLATFORM_TASK_STARS_ACSQ,
        PLATFORM_TASK_TS_KEYPOINT,
        PLATFORM_TASK_TS_MEMCPY,
        PLATFORM_TASK_TRAINING_TRACE,
        PLATFORM_TASK_AICPU,
        PLATFORM_TASK_DYNAMIC,
        PLATFORM_TASK_BLOCK,
        PLATFORM_TASK_DELAY_DURATION,
        PLATFORM_TASK_INSTR_PROFILING,
        // PMU
        PLATFORM_TASK_AU_PMU,
        PLATFORM_TASK_PU_PMU,
        PLATFORM_TASK_PUEXCT_PMU,
        PLATFORM_TASK_MEMORYL0_PMU,
        PLATFORM_TASK_MEMORY_PMU,
        PLATFORM_TASK_MEMORYUB_PMU,
        PLATFORM_TASK_L2_CACHE_PMU,
        PLATFORM_TASK_RCR_PMU,
        PLATFORM_TASK_SOC_PMU,
        PLATFORM_TASK_SOC_PMU_NOC,
        // Device
        PLATFORM_SYS_DEVICE_US,
        // Feature
        PLATFORM_MC2,
        PLATFORM_AICPU_HCCL,
        PLATFORM_DIAGNOSTIC_COLLECTION,
        PLATFORM_SYS_MEM_SERVICEFLOW,
        PLATFORM_STARS_QOS,
        PLATFORM_ACLAPI_SETDEVICE_ENABLE
    };
    InsertSysFeature();
}

uint16_t MdcV2Platform::GetMaxMonitorNumber() const
{
    return MAX_DAVID_MONITOR_NUM;
}

uint16_t MdcV2Platform::GetQosMonitorNumber() const
{
    return MAX_QOS_MONITOR_NUM;
}

std::string MdcV2Platform::GetPipeUtilizationMetrics()
{
    return MDC_V2_PIPEUTILIZATION;
}

std::string MdcV2Platform::GetMemoryMetrics()
{
    return MDC_V2_MEMORY;
}

std::string MdcV2Platform::GetMemoryL0Metrics()
{
    return MDC_V2_MEMORYL0;
}

std::string MdcV2Platform::GetMemoryUBMetrics()
{
    return MDC_V2_MEMORYUB;
}

std::string MdcV2Platform::GetArithmeticUtilizationMetrics()
{
    return MDC_V2_AIRTHMETICUTILIZATION;
}

std::string MdcV2Platform::GetResourceConflictRatioMetrics()
{
    return MDC_V2_RESOURCECONFLICTRATIO;
}

std::string MdcV2Platform::GetL2CacheMetrics()
{
    return MDC_V2_L2CACHE;
}

std::string MdcV2Platform::GetL2CacheEvents()
{
    return MDC_V2_L2CACHEEVENT;
}

void MdcV2Platform::InsertSysFeature()
{
    const auto sysFeature =  {
        // System-device
        PLATFORM_SYS_DEVICE_SYS_CPU_MEM_USAGE,
        PLATFORM_SYS_DEVICE_ALL_PID_CPU_MEM_USAGE,
        PLATFORM_SYS_DEVICE_TS_CPU_HOT_FUNC_PMU,
        PLATFORM_SYS_DEVICE_AI_CTRL_CPU_HOT_FUNC_PMU,
        PLATFORM_SYS_DEVICE_NPU_MODULE_MEM,
        PLATFORM_SYS_DEVICE_LLC,
        PLATFORM_SYS_DEVICE_NIC,
        PLATFORM_SYS_DEVICE_DDR,
        PLATFORM_SYS_DEVICE_HBM,
        PLATFORM_SYS_DEVICE_ROCE,
        PLATFORM_SYS_DEVICE_HCCS,
        PLATFORM_SYS_DEVICE_QOS,
        PLATFORM_SYS_DEVICE_LOW_POWER
    };
    supportedFeature_.insert(sysFeature.begin(), sysFeature.end());
}
}
}
}