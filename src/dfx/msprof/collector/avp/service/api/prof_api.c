/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "toolchain/prof_api.h"
#include <time.h>
#include "errno/error_code.h"
#include "impl/service_impl.h"
#include "impl/service_report.h"
#include "logger/logger.h"
#include "utils/utils.h"
#include "platform/platform.h"

/**
 * @brief      profiling module init
 * @param [in] dataType: profiling type: ACL Env/ACL Json/GE Option
 * @param [in] data: profiling switch data
 * @param [in] dataLen: length of data
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
AVP_PROF_API int32_t MsprofInit(uint32_t dataType, OsalVoidPtr data, uint32_t dataLen)
{
    int32_t ret = ServiceImplInitialize();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Initialize service implement failed, ret : %d", ret);
        return ret;
    }
    return ServiceImplSetConfig(dataType, data, dataLen);
}

/**
 * @brief      notify set/reset device
 * @param [in] chipId: multi die's chipId
 * @param [in] deviceId: device id
 * @param [in] isOpen: device is open or close
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
AVP_PROF_API int32_t MsprofNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen)
{
    if (isOpen) {
        return ServiceImplStart(chipId, deviceId);
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief      register profiling switch callback for module
 * @param [in] moduleId: module Id
 * @param [in] handle: prof start callback handle
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
AVP_PROF_API int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    return ServiceImplRegisterCallback(moduleId, handle);
}

/**
 * @brief      report data of type MsprofApi
 * @param [in] nonPersistantFlag: 0 isn't aging, !0 is aging
 * @param [in] api: api data
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
AVP_PROF_API int32_t MsprofReportApi(uint32_t nonPersistantFlag, const struct MsprofApi *api)
{
    return ServiceReportApiPush((uint8_t)nonPersistantFlag, api);
}

/**
 * @brief      report data of type MsprofEvent
 * @param [in] nonPersistantFlag: 0 isn't aging, !0 is aging
 * @param [in] event: event data
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
AVP_PROF_API int32_t MsprofReportEvent(uint32_t nonPersistantFlag, const struct MsprofEvent *event)
{
    return ServiceReportApiPush((uint8_t)nonPersistantFlag, (const struct MsprofApi *)event);
}

/**
 * @brief      report data of type MsprofCompactInfo
 * @param [in] nonPersistantFlag: 0 isn't aging, !0 is aging
 * @param [in] data: compact info data
 * @param [in] length: compact info data length
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
AVP_PROF_API int32_t MsprofReportCompactInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    return ServiceReportCompactPush((uint8_t)nonPersistantFlag, (const struct MsprofCompactInfo *)data, length);
}

/**
 * @brief      report data of type MsprofAdditionalInfo
 * @param [in] nonPersistantFlag: 0 isn't aging, !0 is aging
 * @param [in] data: additional info data
 * @param [in] length: additional info data length
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
AVP_PROF_API int32_t MsprofReportAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    return ServiceReportAdditionalPush((uint8_t)nonPersistantFlag, (const struct MsprofAdditionalInfo *)data, length);
}

/**
 * @brief reg mapping info of type id and type name
 * @param [in] level: level is the report struct's level
 * @param [in] typeId: type id is the report struct's type
 * @param [in] typeName: label of type id for presenting user
 * @return 0:SUCCESS, !0:FAILED
 */
AVP_PROF_API int32_t MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName)
{
    return RegisterTypeInfo(level, typeId, typeName);
}

/**
 * @brief return hash id of hash info
 * @param [in] hashInfo: infomation to be hashed
 * @param [in] length: the length of infomation to be hashed
 * @return hash id
 */
AVP_PROF_API uint64_t MsprofGetHashId(const char *hashInfo, size_t length)
{
    return ServiceHashId(hashInfo, length);
}

/**
 * @brief      profiling module finalize
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
AVP_PROF_API int32_t MsprofFinalize(void)
{
    int32_t ret = ServiceImplFinalize();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Finalize service implement failed, ret : %d", ret);
        return ret;
    }
    return PROFILING_SUCCESS;
}

AVP_PROF_API uint64_t MsprofSysCycleTime(void)
{
#ifndef CPU_CYCLE_NO_SUPPORT
    if (PlatformHostFreqIsEnable()) {
        uint64_t cycles = 0;
#if defined(__aarch64__)
        asm volatile("mrs %0, cntvct_el0" : "=r"(cycles));
#elif defined(__x86_64__)
        const uint32_t uint32Bits = 32;  // 32 is uint bit count
        uint32_t hi = 0;
        uint32_t lo = 0;
        __asm__ __volatile__("rdtsc" : "=a"(lo), "=d"(hi));
        cycles = ((uint64_t)lo) | (((uint64_t)hi) << uint32Bits);
#elif defined(__arm__)
        const uint32_t uint32Bits = 32;  // 32 is uint bit count
        uint32_t hi = 0;
        uint32_t lo = 0;
        asm volatile("mrrc p15, 1, %0, %1, c14" : "=r"(lo), "=r"(hi));
        cycles = ((uint64_t)lo) | (((uint64_t)hi) << uint32Bits);
#else
        cycles = 0;
#endif
        return cycles;
    } else {
#endif
        static const uint64_t CHANGE_FROM_SEC_TO_NS = 1000000000;
        struct timespec now = {0, 0};
        (void)clock_gettime(CLOCK_MONOTONIC_RAW, &now);
        return ((uint64_t)now.tv_sec * CHANGE_FROM_SEC_TO_NS) + (uint64_t)now.tv_nsec;
#ifndef CPU_CYCLE_NO_SUPPORT
    }
#endif
}