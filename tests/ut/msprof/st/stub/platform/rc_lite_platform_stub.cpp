/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rc_lite_platform_stub.h"
#include "rc_hidden_cli_args.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
constexpr char RC_LITE_STUB_PIPEUTILIZATION[] = "0x500,0x301,0x1,0x701,0x202,0x203,0x34,0x35";
constexpr char RC_LITE_STUB_PIPELINEEXECUTEUTILIZATION[] = "0x500,0x301,0x1,0x701,0x202,0x203,0x714";
constexpr char RC_LITE_STUB_MEMORY[] = "0x404,0x406,0x566,0x567,0x707,0x709";
constexpr char RC_LITE_STUB_MEMORYL0[] = "0x304,0x702,0x306,0x703,0x712,0x30a,0x308";
constexpr char RC_LITE_STUB_MEMORYUB[] = "0x3,0x5,0x70c,0x206,0x204,0x57b,0x57c";
constexpr char RC_LITE_STUB_AIRTHMETICUTILIZATION[] = "0x302,0x303";
constexpr char RC_LITE_STUB_RESOURCECONFLICTRATIO[] = "0x54f,0x551,0x552,0x561,0x563,0x564,0x557";
constexpr char RC_LITE_STUB_L2CACHEEVENT[] = "0x78,0x79,0x77,0x71,0x6a,0x6c,0x74,0x62";
constexpr int32_t RC_LITE_STUB_MAX_AIPMU_EVENT = 1813;
constexpr char RC_LITE_STUB_DEVICE_OSC_FREQ[] = "38.4";
constexpr char RC_LITE_STUB_AIC_FREQ[] = "1250";

PLATFORM_REGISTER(static_cast<PlatformTypeEnum>(12), RcLitePlatformStub);

RcLitePlatformStub::RcLitePlatformStub()
{
    supportedFeature_ = {
        // Task
        PLATFORM_TASK_ASCENDCL,
        PLATFORM_TASK_AIC_METRICS,
        PLATFORM_TASK_GE_API,
        PLATFORM_TASK_HCCL,
        PLATFORM_TASK_L2_CACHE_REG,
        PLATFORM_TASK_MSPROFTX,
        PLATFORM_TASK_RUNTIME_API,
        PLATFORM_TASK_SWITCH,
        PLATFORM_TASK_TRACE,
        PLATFORM_TASK_TSFW,
        PLATFORM_TASK_TS_MEMCPY,
        PLATFORM_TASK_TS_KEYPOINT,
        PLATFORM_TASK_TRAINING_TRACE,
        PLATFORM_TASK_METRICS,
        PLATFORM_TASK_MEMORY,
        // PMU
        PLATFORM_TASK_AU_PMU,
        PLATFORM_TASK_PU_PMU,
        PLATFORM_TASK_PEU_PMU,
        PLATFORM_TASK_MEMORY_PMU,
        PLATFORM_TASK_MEMORYL0_PMU,
        PLATFORM_TASK_MEMORYUB_PMU,
        PLATFORM_TASK_RCR_PMU,
        // Device
        PLATFORM_SYS_DEVICE_NPU_MODULE_MEM,
        PLATFORM_SYS_DEVICE_DVPP_EX,
        PLATFORM_SYS_DEVICE_DDR,
        PLATFORM_SYS_DEVICE_HBM,
        PLATFORM_SYS_DEVICE_LLC,
        // 扩展形态能力
        PLATFORM_AICORE_EXCT_DEFAULT,
        PLATFORM_SYS_DEVICE_LLC_EXT,
    };
}

int32_t RcLitePlatformStub::GetMaxAiPmuEvent() const { return RC_LITE_STUB_MAX_AIPMU_EVENT; }

std::string RcLitePlatformStub::GetPipeUtilizationMetrics() { return RC_LITE_STUB_PIPEUTILIZATION; }

std::string RcLitePlatformStub::GetPipelineExecuteUtilizationMetrics()
{
    return RC_LITE_STUB_PIPELINEEXECUTEUTILIZATION;
}

std::string RcLitePlatformStub::GetMemoryMetrics() { return RC_LITE_STUB_MEMORY; }

std::string RcLitePlatformStub::GetMemoryL0Metrics() { return RC_LITE_STUB_MEMORYL0; }

std::string RcLitePlatformStub::GetMemoryUBMetrics() { return RC_LITE_STUB_MEMORYUB; }

std::string RcLitePlatformStub::GetArithmeticUtilizationMetrics() { return RC_LITE_STUB_AIRTHMETICUTILIZATION; }

std::string RcLitePlatformStub::GetResourceConflictRatioMetrics() { return RC_LITE_STUB_RESOURCECONFLICTRATIO; }

std::string RcLitePlatformStub::GetL2CacheEvents() { return RC_LITE_STUB_L2CACHEEVENT; }

std::string RcLitePlatformStub::GetDeviceOscDefaultFreq() { return RC_LITE_STUB_DEVICE_OSC_FREQ; }

std::string RcLitePlatformStub::GetAicDefaultFreq() { return RC_LITE_STUB_AIC_FREQ; }

std::vector<std::string> RcLitePlatformStub::GetHiddenCliArgs() const { return RcLiteHiddenCliArgs(); }
} // namespace Platform
} // namespace Collect
} // namespace Dvvp
