/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "david_platform.h"
#include "david_analyzer.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
constexpr char DAVID_PIPEUTILIZATION[] = "0x501,0x301,0x1,0x701,0x202,0x203,0x34,0x35,0x714";
constexpr char DAVID_MEMORY[] = "0x400,0x401,0x56f,0x571,0x570,0x572,0x707,0x709";
constexpr char DAVID_MEMORYL0[] = "0x304,0x703,0x306,0x705,0x712,0x30a,0x308";
constexpr char DAVID_MEMORYUB[] = "0x3,0x5,0x70c,0x206,0x204,0x571,0x572";
constexpr char DAVID_AIRTHMETICUTILIZATION[] = "0x323,0x324";
constexpr char DAVID_RESOURCECONFLICTRATIO[] = "0x540,0x556,0x502,0x528";
constexpr char DAVID_L2CACHE[] = "0x424,0x425,0x426,0x42a,0x42b,0x42c";
constexpr char DAVID_L2CACHEEVENT[] = "0x00,0x81,0x82,0x83,0x74,0x75";
constexpr uint16_t MAX_QOS_MONITOR_NUM = 8;

PLATFORM_REGISTER(CHIP_CLOUD_V3, DavidPlatform);
DavidPlatform::DavidPlatform()
{
    supportedFeature_ = {
        // TASK
        PLATFORM_TASK_ASCENDCL,
        PLATFORM_TASK_RUNTIME_API,
        PLATFORM_TASK_METRICS,
        PLATFORM_TASK_AIC_METRICS,
        PLATFORM_TASK_AIV_METRICS,
        PLATFORM_TASK_AICORE_LPM,
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
        PLATFORM_TASK_DELAY_DURATION,
        PLATFORM_TASK_BLOCK,
        PLATFORM_TASK_CCU_INSTRUTION,
        PLATFORM_TASK_CCU_STATISTIC,
        PLATFORM_TASK_INSTR_PROFILING,
        PLATFORM_TASK_PC_SAMPLING,
        // PMU
        PLATFORM_TASK_AU_PMU,
        PLATFORM_TASK_PU_PMU,
        PLATFORM_TASK_PUEXCT_PMU,
        PLATFORM_TASK_MEMORY_PMU,
        PLATFORM_TASK_MEMORYL0_PMU,
        PLATFORM_TASK_MEMORYUB_PMU,
        PLATFORM_TASK_L2_CACHE_PMU,
        PLATFORM_TASK_RCR_PMU,
        PLATFORM_TASK_SOC_PMU,
        PLATFORM_TASK_SOC_PMU_NOC,
        // Device
        PLATFORM_SYS_DEVICE_UB,
        PLATFORM_SYS_DEVICE_US,
        // Feature
        PLATFORM_MC2,
        PLATFORM_AICPU_HCCL,
        PLATFORM_DIAGNOSTIC_COLLECTION,
        PLATFORM_AICSCALE_ACP,
        PLATFORM_STARS_QOS,
        PLATFORM_SYS_MEM_SERVICEFLOW,
        PLATFORM_ACLAPI_SETDEVICE_ENABLE
    };
    InsertSysFeature();
}

uint16_t DavidPlatform::GetMaxMonitorNumber() const
{
    return MAX_DAVID_MONITOR_NUM;
}

uint16_t DavidPlatform::GetQosMonitorNumber() const
{
    return MAX_QOS_MONITOR_NUM;
}

std::string DavidPlatform::GetPipeUtilizationMetrics()
{
    return DAVID_PIPEUTILIZATION;
}

std::string DavidPlatform::GetMemoryMetrics()
{
    return DAVID_MEMORY;
}

std::string DavidPlatform::GetMemoryL0Metrics()
{
    return DAVID_MEMORYL0;
}

std::string DavidPlatform::GetMemoryUBMetrics()
{
    return DAVID_MEMORYUB;
}

std::string DavidPlatform::GetArithmeticUtilizationMetrics()
{
    return DAVID_AIRTHMETICUTILIZATION;
}

std::string DavidPlatform::GetResourceConflictRatioMetrics()
{
    return DAVID_RESOURCECONFLICTRATIO;
}

std::string DavidPlatform::GetL2CacheMetrics()
{
    return DAVID_L2CACHE;
}

void DavidPlatform::InsertSysFeature()
{
    const auto sysFeature =  {
        // System-device
        PLATFORM_SYS_DEVICE_SYS_CPU_MEM_USAGE,
        PLATFORM_SYS_DEVICE_ALL_PID_CPU_MEM_USAGE,
        PLATFORM_SYS_DEVICE_TS_CPU_HOT_FUNC_PMU,
        PLATFORM_SYS_DEVICE_AI_CTRL_CPU_HOT_FUNC_PMU,
        PLATFORM_SYS_DEVICE_NPU_MODULE_MEM,
        PLATFORM_SYS_DEVICE_LLC,
        PLATFORM_SYS_DEVICE_HBM,
        PLATFORM_SYS_DEVICE_NIC,
        PLATFORM_SYS_DEVICE_ROCE,
        PLATFORM_SYS_DEVICE_HCCS,
        PLATFORM_SYS_DEVICE_PCIE,
        PLATFORM_SYS_DEVICE_DVPP,
        PLATFORM_SYS_DEVICE_DVPP_EX,
        PLATFORM_SYS_DEVICE_LOW_POWER,
        PLATFORM_SYS_DEVICE_QOS,
        // System-host
        PLATFORM_SYS_HOST_ONE_PID_CPU,
        PLATFORM_SYS_HOST_ALL_PID_CPU,
        PLATFORM_SYS_HOST_ONE_PID_MEM,
        PLATFORM_SYS_HOST_ALL_PID_MEM,
        PLATFORM_SYS_HOST_ONE_PID_DISK,
        PLATFORM_SYS_HOST_ONE_PID_OSRT,
        PLATFORM_SYS_HOST_NETWORK,
        PLATFORM_SYS_HOST_SYS_CPU,
        // Feature collection
        PLATFORM_COLLECTOR_ACP,
    };
    supportedFeature_.insert(sysFeature.begin(), sysFeature.end());
}

int32_t DavidPlatform::InitOnlineAnalyzer()
{
    MSVP_MAKE_SHARED0(analyzer_, DavidAnalyzer, return -1);
    return 0;
}

std::string DavidPlatform::GetL2CacheEvents()
{
    return DAVID_L2CACHEEVENT;
}
}
}
}
