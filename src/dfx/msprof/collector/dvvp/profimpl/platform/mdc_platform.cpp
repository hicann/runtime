/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mdc_platform.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
constexpr char MDC_L2CACHEEVENT[] = "0x78,0x79,0x77,0x71,0x6a,0x6c,0x74,0x62";

PLATFORM_REGISTER(CHIP_MDC, MdcPlatform);
MdcPlatform::MdcPlatform()
{
    supportedFeature_ = {
        // TASK
        PLATFORM_TASK_AICPU,
        PLATFORM_TASK_ASCENDCL,
        PLATFORM_TASK_AIC_METRICS,
        PLATFORM_TASK_AIV_METRICS,
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
        PLATFORM_TASK_MEMORY_PMU,
        PLATFORM_TASK_MEMORYL0_PMU,
        PLATFORM_TASK_MEMORYUB_PMU,
        PLATFORM_TASK_RCR_PMU,
        // Device
        PLATFORM_SYS_DEVICE_NPU_MODULE_MEM,
        PLATFORM_SYS_DEVICE_DVPP_EX,
        PLATFORM_SYS_DEVICE_DDR,
        PLATFORM_SYS_DEVICE_HBM,
        PLATFORM_SYS_DEVICE_LLC
    };
}

std::string MdcPlatform::GetL2CacheEvents()
{
    return MDC_L2CACHEEVENT;
}
}
}
}
