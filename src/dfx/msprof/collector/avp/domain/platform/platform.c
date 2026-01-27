/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform.h"
#include "logger/logger.h"
#include "errno/error_code.h"
#include "platform_table.h"
#include "hal/hal_dsmi.h"
#include "osal/osal_mem.h"
#include "utils/utils.h"

static const uint32_t SUPPORT_OSC_FREQ_API_VERSION = 0x071905;
static const char PROF_VERSION_INFO[] = "1.0";
static PlatformAttribute g_platformAttribute = {false, false, 1, 0, NULL};

/**
 * @brief Perform uint32_t-to-PlatformType conversion
 * @return PlatformType
 */
PlatformType PlatformTypeConversion(void)
{
    uint32_t chipType = HalGetChipVersion();
    if (chipType == NANO_CHIP_TYPE) {
        return CHIP_NANO_V1;
    }
    return CHIP_END;
}

/**
 * @brief Init platform attributes and interface
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t PlatformInitialize(uint32_t *repeatCount)
{
    if (HalGetApiVersion() >= SUPPORT_OSC_FREQ_API_VERSION) {
#ifndef CPU_CYCLE_NO_SUPPORT
        g_platformAttribute.hostOscFreq = HalGetHostFreq();
#else
        g_platformAttribute.hostOscFreq = 0;
#endif
    } else {
        g_platformAttribute.hostOscFreq = 0;
    }
    PlatformType platType = PlatformTypeConversion();
    g_platformAttribute.interface = CreatePlatform(platType);
    if (g_platformAttribute.interface == NULL) {
        MSPROF_LOGE("Failed to create platform: %d.", platType);
        return PROFILING_FAILED;
    }
    if (HalGetPlatformInfo(&g_platformAttribute.platformInfo) != PROFILING_SUCCESS) {
        OSAL_MEM_FREE(g_platformAttribute.interface);
        MSPROF_LOGE("Failed to get platform info.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Success to init platform, version: %s, type: %d, info:%d.",
        PROF_VERSION_INFO, platType, g_platformAttribute.platformInfo);
    (*repeatCount) = 1;
    return PROFILING_SUCCESS;
}

/**
 * @brief Finalize platform interface
 */
void PlatformFinalize(uint32_t *repeatCount)
{
    if (g_platformAttribute.interface == NULL) {
        MSPROF_LOGI("Repeat finalize platform.");
        return;
    }
    OSAL_MEM_FREE(g_platformAttribute.interface);
    MSPROF_LOGI("Success to finalize platform.");
    (*repeatCount) = 0;
}

/**
 * @brief Get default ai core freq on platform
 * @return freq : default ai core freq
           0    : platform is not init
 */
uint32_t PlatformGetAicFreq(void)
{
    if (g_platformAttribute.interface == NULL) {
        return 0;
    }
    return g_platformAttribute.interface->GetAicFreq();
}

/**
 * @brief Get default ai vector core freq on platform
 * @return freq : default ai vector core freq
           0    : platform is not init
 */
uint32_t PlatformGetAivFreq(void)
{
    if (g_platformAttribute.interface == NULL) {
        return 0;
    }
    return g_platformAttribute.interface->GetAivFreq();
}

/**
 * @brief Get exist device number on platform
 * @return number : exist device number
           0      : platform is not init
 */
uint32_t PlatformGetDevNum(void)
{
    if (g_platformAttribute.interface == NULL) {
        return 0;
    }
    return g_platformAttribute.interface->GetDevNum();
}

/**
 * @brief Check if feature support on platform
 * @param [in] feature : platform feature
 * @return true  : platform feature is support
           false : platform feature is not support
 */
bool IsSupportFeature(const PlatformFeature feature)
{
    if (g_platformAttribute.interface == NULL) {
        MSPROF_LOGE("Platform is not init.");
        return false;
    }
    if (feature == PLATFORM_FEATURE_INVALID) {
        MSPROF_LOGE("Invalid platform feature.");
        return false;
    }
    return g_platformAttribute.interface->FeatureIsSupport(feature);
}

/**
 * @brief Check if switch or metric string support on platform
 * @param [in] sw : switch or metric string
 * @return true  : switch or metric string is support
           false : switch or metric string is not support
 */
bool IsSupportSwitch(const CHAR *sw)
{
    PlatformFeature feature = TransformFeature(sw);
    return IsSupportFeature(feature);
}

/**
 * @brief Check if switch or metric string support on platform
 * @param [in] dataConfig : data config of bit switch
 * @return true  : bit switch is support
           false : bit switch is not support
 */
bool IsSupportBit(const uint64_t dataConfig)
{
    if (g_platformAttribute.interface == NULL) {
        MSPROF_LOGE("Platform is not init.");
        return false;
    }
    return CheckBitFeature(dataConfig, g_platformAttribute.interface);
}

/**
 * @brief Check if metric string match pmu events on platform
 * @param [in] sw        : metric string
 * @param [out] events   : output pmu events
 * @param [in] eventsLen : output space len
 * @return true  : match pmu events
           false : failed to match pmu events
 */
bool PlatformGetMetricsEvents(const CHAR *sw, CHAR *events, size_t eventsLen)
{
    if (g_platformAttribute.interface == NULL) {
        MSPROF_LOGE("Platform is not init.");
        return false;
    }
    PlatformFeature feature = TransformFeature(sw);
    if (!IsSupportFeature(feature)) {
        MSPROF_LOGE("Metrics feature not support.");
        return false;
    }
    return g_platformAttribute.interface->GetPmuEvents(feature, events, eventsLen);
}

/**
 * @brief Get default metric string on platform
 * @return default metric string
 */
CHAR* PlatformGetDefaultMetrics(void)
{
    if (g_platformAttribute.interface == NULL) {
        MSPROF_LOGE("Platform is not init.");
        return NULL;
    }
    return g_platformAttribute.interface->GetDefaultMetrics();
}

/**
 * @brief Get default device freq on platform
 * @return default device freq
 */
uint64_t PlatformGetDefaultDevFreq(void)
{
    if (g_platformAttribute.interface == NULL) {
        return 0;
    }
    return g_platformAttribute.interface->GetDefaultFreq();
}

/**
 * @brief Get device freq on platform
 * @param [in] deviceId : device id
 * @return device freq
 */
float PlatformGetDevFreq(uint32_t deviceId)
{
    float deviceOscFreq = 0.0f;
    if (HalGetApiVersion() >= SUPPORT_OSC_FREQ_API_VERSION) {
        deviceOscFreq = (float)HalGetDeviceFreq(deviceId);
    }
    float epsilon = 0.000001f;
    if (deviceOscFreq < epsilon) {
        deviceOscFreq = (float)PlatformGetDefaultDevFreq();
    }
    deviceOscFreq /= (float)FREQUENCY_KHZ_TO_MHZ;
    return deviceOscFreq;
}

/**
 * @brief Get host freq on platform
 * @return host freq
 */
uint64_t PlatformGetHostFreq(void)
{
    if (g_platformAttribute.interface == NULL) {
        return 0;
    }
    return (g_platformAttribute.hostOscFreq / FREQUENCY_KHZ_TO_MHZ);
}

/**
 * @brief Get profiling version info
 * @return profiling version info string
 */
const CHAR* PlatformGetVersionInfo(void)
{
    return PROF_VERSION_INFO;
}

bool PlatformHostFreqIsEnable(void)
{
    if (g_platformAttribute.interface == NULL) {
        return false;
    }
    if (g_platformAttribute.hostOscFreq == 0) {
        return false;
    }
    return true;
}