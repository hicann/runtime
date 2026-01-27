/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "chip_nano_v1.h"
#include "errno/error_code.h"
#include "logger/logger.h"
#include "hal/hal_dsmi.h"

static const PlatformFeature NANO_FEATURE_LIST[] = {
    PLATFORM_TASK_SCALAR_RATIO_PMU,
    PLATFORM_TASK_PU_PMU,
    PLATFORM_TASK_PSC_PMU,
    PLATFORM_TASK_MEMORY_PMU,
    PLATFORM_TASK_MEMORYUB_PMU,
    PLATFORM_TASK_TRACE,
    PLATFORM_TASK_AIC_METRICS,
    PLATFORM_TASK_SWITCH,
    PLATFORM_TASK_OUTPUT
};

static const PlatformMetrics NANO_METRIC_EVENTS[] = {
    {PLATFORM_TASK_SCALAR_RATIO_PMU, "0x103,0x104,0x105"},
    {PLATFORM_TASK_PU_PMU, "0x300,0x400,0x100,0x200,0x201,0x202,0x302,0x203,0x101,0x102"},
    {PLATFORM_TASK_PSC_PMU, "0x406,0x305,0x600,0x601,0x602,0x603,0x604,0x605,0x606,0x607"},
    {PLATFORM_TASK_MEMORY_PMU, "0x201,0x202,0x204,0x205"},
    {PLATFORM_TASK_MEMORYUB_PMU, "0x206,0x207,0x208,0x209,0x303,0x304,0x106,0x107"},
};

/**
 * @brief Get default aic freq on nano platform
 * @return default aic freq
 */
static uint32_t GetAicFreq(void)
{
    return NANO_AICORE_DEFAULT_FREQ;
}

/**
 * @brief Get default aiv freq on nano platform
 * @return default aiv freq
 */
static uint32_t GetAivFreq(void)
{
    return NANO_AICORE_DEFAULT_FREQ;
}

/**
 * @brief Get default host freq on nano platform
 * @return default host freq
 */
static uint64_t GetDefaultFreq(void)
{
    return NANO_HWTS_DEFAULT_FREQ;
}

/**
 * @brief Check feature is support or not
 * @param [in] feature: platform feature
 * @return true
           false
 */
static bool FeatureIsSupport(const PlatformFeature feature)
{
    for (uint32_t id = 0; id < sizeof(NANO_FEATURE_LIST)/sizeof(NANO_FEATURE_LIST[0]); ++id) {
        if (feature == NANO_FEATURE_LIST[id]) {
            return true;
        }
    }
    return false;
}

/**
 * @brief Get detail pmu events
 * @param [in] feature   : platform feature
 * @param [out] events   : output string of pmu events
 * @param [in] eventsLen : output string len
 * @return true : find metrics feature and output pmu events
           false
 */
static bool GetPmuEvents(const PlatformFeature feature, char *events, size_t eventsLen)
{
    // search in nano metrics map
    for (uint32_t id = 0; id < sizeof(NANO_METRIC_EVENTS)/sizeof(NANO_METRIC_EVENTS[0]); ++id) {
        if (feature == NANO_METRIC_EVENTS[id].pmuType) {
            errno_t ret = memcpy_s(events, eventsLen,
                NANO_METRIC_EVENTS[id].pmuEvents, sizeof(NANO_METRIC_EVENTS[id].pmuEvents));
            if (ret != EOK) {
                MSPROF_LOGE("Failed to memcpy_s for NANO_METRIC_EVENTS, eventsLen: %u, pmuLen: %zu, ret:%d.",
                    eventsLen, sizeof(NANO_METRIC_EVENTS[id].pmuEvents), (int32_t)ret);
                return false;
            }
            return true;
        }
    }
    // search in common metrics map
    return GetCommonPmuEvents(feature, events, eventsLen);
}

/**
 * @brief Get default metrics on nano platform
 * @return default metrics string
 */
static char* GetDefaultMetrics(void)
{
    static char defaultMetrics[] = "PipeUtilization";
    return defaultMetrics;
}

/**
 * @brief Register nano function to platform interface
 */
void CreateNanoPlatform(PlatformInterface *interface)
{
    interface->GetDefaultMetrics = GetDefaultMetrics;
    interface->FeatureIsSupport = FeatureIsSupport;
    interface->GetAicFreq = GetAicFreq;
    interface->GetAivFreq = GetAivFreq;
    interface->GetDevNum = HalGetDeviceNumber;
    interface->GetPmuEvents = GetPmuEvents;
    interface->GetDefaultFreq = GetDefaultFreq;
}