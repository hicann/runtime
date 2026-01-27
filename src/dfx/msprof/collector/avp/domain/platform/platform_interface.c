/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform_interface.h"
#include "errno/error_code.h"
#include "logger/logger.h"

static const PlatformMetrics COMMON_METRIC_EVENTS[] = {
    {PLATFORM_TASK_AU_PMU,       "0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f"},
    {PLATFORM_TASK_PU_PMU,       "0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55"},
    {PLATFORM_TASK_RCR_PMU,      "0x64,0x65,0x66"},
    {PLATFORM_TASK_MEMORY_PMU,   "0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13"},
    {PLATFORM_TASK_MEMORYL0_PMU, "0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a"},
    {PLATFORM_TASK_MEMORYUB_PMU, "0x10,0x13,0x37,0x38,0x3d,0x3e,0x43,0x44"},
    {PLATFORM_TASK_L2_CACHE_PMU, "0x500,0x502,0x504,0x506,0x508,0x50a"},
};

static const PlatformSwitch SWITCH_FEATURE_MAP[] = {
    // switch
    {PLATFORM_TASK_OUTPUT,                "output"},
    {PLATFORM_TASK_SWITCH,                "switch"},
    {PLATFORM_TASK_ASCENDCL,              "ascendcl"},
    {PLATFORM_TASK_AICPU,                 "aicpu"},
    {PLATFORM_TASK_HCCL,                  "hccl"},
    {PLATFORM_TASK_AIC_METRICS,           "aic_metrics"},
    {PLATFORM_TASK_FWK_SCHEDULE,          "fwk_schedule"},
    {PLATFORM_TASK_TRACE,                 "task_trace"},
    {PLATFORM_TASK_MSPROFTX,              "msproftx"},
    {PLATFORM_TASK_TSFW,                  "task_tsfw"},
    {PLATFORM_TASK_FRAMEWORK,             "task_framework"},
    {PLATFORM_TASK_RUNTIME_API,           "runtime_api"},
    {PLATFORM_TASK_BLOCK,                 "task_block"},
    {PLATFORM_TASK_TRAINING_TRACE,        "training_trace"},
    {PLATFORM_SYS_DEVICE_INSTR_PROFILING, "instr_profiling"},
    {PLATFORM_SYS_DEVICE_LLC,             "llc_profiling"},
    {PLATFORM_SYS_HARDWARE_MEM_FREQ,      "sys_hardware_mem_freq"},
    {PLATFORM_SYS_IO_SAMPLING_FREQ,      "sys_io_sampling_freq"},
    {PLATFORM_SYS_INTERCONNECTION_FREQ,   "sys_interconnection_freq"},
    {PLATFORM_SYS_DEVICE_POWER,           "power"},
    {PLATFORM_HOST_SYS,                   "host_sys"},
    {PLATFORM_HOST_SYS_USAGE,             "host_sys_usage"},
    {PLATFORM_TASK_L2_CACHE_REG,          "l2"},
    // metrics
    {PLATFORM_TASK_L2_CACHE_PMU,          "L2Cache"},
    {PLATFORM_TASK_AU_PMU,                "ArithmeticUtilization"},
    {PLATFORM_TASK_PU_PMU,                "PipeUtilization"},
    {PLATFORM_TASK_PEU_PMU,               "PipelineExecuteUtilization"},
    {PLATFORM_TASK_PUEXCT_PMU,            "PipeUtilizationExct"},
    {PLATFORM_TASK_RCR_PMU,               "ResourceConflictRatio"},
    {PLATFORM_TASK_PSC_PMU,               "PipeStallCycle"},
    {PLATFORM_TASK_SCALAR_RATIO_PMU,      "ScalarRatio"},
    {PLATFORM_TASK_MEMORY_PMU,            "Memory"},
    {PLATFORM_TASK_MEMORYL0_PMU,          "MemoryL0"},
    {PLATFORM_TASK_MEMORYUB_PMU,          "MemoryUB"},
};

static const PlatformBitMap BIT_FEATURE_MAP[] = {
    {PLATFORM_TASK_ASCENDCL,       PROF_ACL_API},
    {PLATFORM_TASK_AICPU,          PROF_AICPU_TRACE},
    {PLATFORM_TASK_AIC_METRICS,    PROF_AICORE_METRICS},
    {PLATFORM_TASK_L2_CACHE_REG,   PROF_L2CACHE},
    {PLATFORM_TASK_HCCL,           PROF_HCCL_TRACE},
    {PLATFORM_TASK_TRAINING_TRACE, PROF_TRAINING_TRACE},
    {PLATFORM_TASK_MSPROFTX,       PROF_MSPROFTX},
    {PLATFORM_TASK_RUNTIME_API,    PROF_RUNTIME_API},
    {PLATFORM_TASK_TSFW,           PROF_TASK_TSFW},
    {PLATFORM_TASK_MEMORY,         PROF_TASK_MEMORY},
    {PLATFORM_TASK_RUNTIME_TRACE,  PROF_RUNTIME_TRACE},
};

/**
 * @brief Get common detail pmu events
 * @param [in] feature   : platform feature
 * @param [out] events   : output string of pmu events
 * @param [in] eventsLen : output space len
 * @return true : find metric feature and output pmu events
           false
 */
bool GetCommonPmuEvents(const PlatformFeature feature, CHAR *events, size_t eventsLen)
{
    for (uint32_t id = 0; id < sizeof(COMMON_METRIC_EVENTS)/sizeof(COMMON_METRIC_EVENTS[0]); ++id) {
        if (feature == COMMON_METRIC_EVENTS[id].pmuType) {
            errno_t ret = memcpy_s(events, eventsLen,
                COMMON_METRIC_EVENTS[id].pmuEvents, sizeof(COMMON_METRIC_EVENTS[id].pmuEvents));
            if (ret != EOK) {
                MSPROF_LOGE("Failed to memcpy_s for COMMON_METRIC_EVENTS, ret: %d.", ret);
                return false;
            }
            return true;
        }
    }
    return false;
}

/**
 * @brief Transfer switch or metric string to feature
 * @param [in] sw : switch or metric string
 * @return platform feature
 */
PlatformFeature TransformFeature(const CHAR *sw)
{
    for (uint32_t id = 0; id < sizeof(SWITCH_FEATURE_MAP)/sizeof(SWITCH_FEATURE_MAP[0]); ++id) {
        if (strcmp(sw, SWITCH_FEATURE_MAP[id].sw) == 0) {
            return SWITCH_FEATURE_MAP[id].feature;
        }
    }
    MSPROF_LOGE("Failed to transfer switch %s to feature.", sw);
    return PLATFORM_FEATURE_INVALID;
}

/**
 * @brief Check if bit config is support on the platform
 * @param [in] dataConfig : data config of bit switch
 * @param [in] interface  : the interface pointer of platform
 * @return true : bit switch support
           false
 */
bool CheckBitFeature(const uint64_t dataConfig, PlatformInterface *interface)
{
    for (uint32_t id = 0; id < sizeof(BIT_FEATURE_MAP)/sizeof(BIT_FEATURE_MAP[0]); ++id) {
        if ((dataConfig & BIT_FEATURE_MAP[id].bitSwitch) == 0) {
            continue;
        }
        if (!interface->FeatureIsSupport(BIT_FEATURE_MAP[id].feature)) {
            MSPROF_LOGE("Bit feature %u is not support.", (uint32_t)BIT_FEATURE_MAP[id].feature);
            return false;
        }
        break;
    }
    return true;
}