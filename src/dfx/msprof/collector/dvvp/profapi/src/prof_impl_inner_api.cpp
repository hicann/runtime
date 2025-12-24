/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <ctime>
#include <cstring>
#include "prof_inner_api.h"
#include "msprof_dlog.h"
#include "prof_plugin_manager.h"
#include "errno/error_code.h"
#include "prof_api.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// API for cann & atlas using
MSVP_PROF_API int32_t MsprofSetConfig(uint32_t configType, const char *config, size_t configLength)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfSetConfig(configType, config, configLength);
}

MSVP_PROF_API int32_t MsprofReportData(uint32_t moduleId, uint32_t type, void *data, uint32_t len)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfReportData(moduleId, type, data, len);
}

MSVP_PROF_API int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfRegisterCallback(moduleId, handle);
}

MSVP_PROF_API int32_t MsprofReportApi(uint32_t nonPersistantFlag, const MsprofApi *api)
{
    if (api == nullptr) {
        MSPROF_LOGE("MsprofReportApi interface input invalid data.");
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfReportApi(nonPersistantFlag, api);
}

MSVP_PROF_API int32_t MsprofReportCompactInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    if (data == nullptr) {
        MSPROF_LOGE("MsprofReportCompactInfo interface input invalid data.");
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfReportCompactInfo(nonPersistantFlag, data, length);
}

MSVP_PROF_API int32_t MsprofNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfNotifySetDevice(chipId, deviceId, isOpen);
}

MSVP_PROF_API bool MsprofHostFreqIsEnable()
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfHostFreqIsEnable();
}

MSVP_PROF_API int32_t MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName)
{
    if (typeName == nullptr) {
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfReportRegTypeInfo(level, typeId, typeName, strlen(typeName));
}

MSVP_PROF_API int32_t MsprofRegDataFormat(uint16_t level, uint32_t typeId, const char *dataFormat)
{
    if (dataFormat == nullptr) {
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfReportRegDataFormat(level, typeId, dataFormat, strlen(dataFormat));
}

MSVP_PROF_API uint64_t MsprofGetHashId(const char *hashInfo, size_t length)
{
    if (hashInfo == nullptr || length == 0) {
        MSPROF_LOGW("The hashInfo[%zu] is invalid, thus unable to get hash id.", length);
        return std::numeric_limits<uint64_t>::max();
    }
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfReportGetHashId(hashInfo, length);
}

MSVP_PROF_API uint64_t MsprofStr2Id(const char *hashInfo, size_t length)
{
    return MsprofGetHashId(hashInfo, length);
}

MSVP_PROF_API int32_t MsprofReportEvent(uint32_t nonPersistantFlag, const MsprofEvent *event)
{
    if (event == nullptr) {
        MSPROF_LOGE("MsprofReportEvent interface input invalid data.");
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfReportEvent(nonPersistantFlag, event);
}

MSVP_PROF_API int32_t MsprofReportAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    if (data == nullptr) {
        MSPROF_LOGE("MsprofReportAdditionalInfo interface input invalid data.");
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfReportAdditionalInfo(nonPersistantFlag, data, length);
}

MSVP_PROF_API int32_t MsprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    if (data == nullptr) {
        MSPROF_LOGE("MsprofReportBatchAdditionalInfo interface input invalid data.");
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }
    static uint32_t maxReportBatchAddSize = 131072; // 512 * sizeof(MsprofAdditionalInfo)
    if (length % sizeof(MsprofAdditionalInfo) != 0 || length > maxReportBatchAddSize) {
        MSPROF_LOGE("MsprofReportBatchAdditionalInfo length [%u bytes] is invalid.", length);
        return analysis::dvvp::common::error::PROFILING_FAILED;
    }
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfReportBatchAdditionalInfo(nonPersistantFlag, data, length);
}

MSVP_PROF_API size_t MsprofGetBatchReportMaxSize(uint32_t type)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfGetBatchReportMaxSize(type);
}

MSVP_PROF_API int32_t MsprofSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfSetDeviceIdByGeModelIdx(geModelIdx, deviceId);
}

MSVP_PROF_API int32_t MsprofUnsetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfUnSetDeviceIdByGeModelIdx(geModelIdx, deviceId);
}

MSVP_PROF_API int32_t MsprofInit(uint32_t dataType, void *data, uint32_t dataLen)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfInit(dataType, data, dataLen);
}

MSVP_PROF_API int32_t MsprofStart(uint32_t dataType, const void *data, uint32_t length)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfStart(dataType, data, length);
}
 
MSVP_PROF_API int32_t MsprofStop(uint32_t dataType, const void *data, uint32_t length)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfStop(dataType, data, length);
}

MSVP_PROF_API int32_t MsprofFinalize()
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfFinalize();
}

// prof tx
MSVP_PROF_API uint64_t MsprofSysCycleTime()
{
#ifndef CPU_CYCLE_NO_SUPPORT
    static const bool IS_SUPPORTED_SYS_COUNTER = MsprofHostFreqIsEnable();
    if (IS_SUPPORTED_SYS_COUNTER) {
        uint64_t cycles;
#if defined(__aarch64__)
        asm volatile("mrs %0, cntvct_el0" : "=r"(cycles));
#elif defined(__x86_64__)
        constexpr uint32_t uint32Bits = 32;  // 32 is uint bit count
        uint32_t hi = 0;
        uint32_t lo = 0;
        __asm__ __volatile__("rdtsc" : "=a"(lo), "=d"(hi));
        cycles = (static_cast<uint64_t>(lo)) | ((static_cast<uint64_t>(hi)) << uint32Bits);
#elif defined(__arm__)
        const uint32_t uint32Bits = 32;  // 32 is uint bit count
        uint32_t hi = 0;
        uint32_t lo = 0;
        asm volatile("mrrc p15, 1, %0, %1, c14" : "=r"(lo), "=r"(hi));
        cycles = (static_cast<uint64_t>(lo)) | ((static_cast<uint64_t>(hi)) << uint32Bits);
#else
        cycles = 0;
#endif
        return cycles;
    } else {
#endif
        static constexpr uint64_t changeFromSecToNs = 1000000000;
        struct timespec now = {0, 0};
        (void)clock_gettime(CLOCK_MONOTONIC_RAW, &now);
        return (static_cast<uint64_t>(now.tv_sec) * changeFromSecToNs) + static_cast<uint64_t>(now.tv_nsec);
#ifndef CPU_CYCLE_NO_SUPPORT
    }
#endif
}

#ifdef __cplusplus
}
#endif