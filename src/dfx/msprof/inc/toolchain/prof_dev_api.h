/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROF_DEV_API_H
#define PROF_DEV_API_H

#include <stdint.h>
#include <string>
#include <map>
#include "devprof_pub.h"
#include "prof_common.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define MSVP_PROF_API __declspec(dllexport)
#else
#define MSVP_PROF_API __attribute__((visibility("default")))
#endif

/**
 * @ingroup libascend_devprof
 * @name  AdprofReportData
 * @brief aicpu report profiling data func
 * @param [in] data: profiling data of additional infomation
 * @param [in] length: length of profiling data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t AdprofReportData(ConstVoidPtr data, uint32_t length);

/**
 * @ingroup libascend_devprof
 * @name  AdprofAicpuStop
 * @brief aicpu stop report data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t AdprofAicpuStop();

/**
 * @ingroup libascend_devprof
 * @name  AdprofCheckFeatureIsOn
 * @brief aicpu check feature is on
 * @param [in] feature: which feature want to check
 * @return 1:on, 0:off
 */
MSVP_PROF_API int32_t AdprofCheckFeatureIsOn(uint64_t feature);

/**
 * @ingroup libascend_devprof
 * @name  AdprofStart
 * @brief start adprof collect
 * @param [in] argc: argument count
 * @param [in] argv: argument value
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t AdprofStart(int32_t argc, const char *argv[]);
MSVP_PROF_API bool GetDeviceId(const std::map<std::string, std::string> &kvPairs, uint32_t &devId);
MSVP_PROF_API bool GetHostPid(const std::map<std::string, std::string> &kvPairs, int32_t &hostPid);

/**
 * @ingroup libascend_devprof
 * @name  AdprofStop
 * @brief stop adprof collect
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t AdprofStop();

/*
 * @ingroup libascend_devprof
 * @name  AdprofGetHashId
 * @brief return hash id of hash info
 * @param [in] hashInfo: infomation to be hashed
 * @param [in] length: the length of infomation to be hashed
 * @return hash id
 */
MSVP_PROF_API uint64_t AdprofGetHashId(const char *hashInfo, size_t length);

/**
 * @ingroup libprofimpl
 * @name  AdprofReportStart
 * @brief callback start signal to aicpu, hccl and mc2
 * @return
 */
MSVP_PROF_API void AdprofReportStart();

/**
 * @ingroup libprofimpl
 * @name  AdprofReportStop
 * @brief callback stop signal to aicpu, hccl and mc2
 * @return
 */
MSVP_PROF_API void AdprofReportStop();

/**
 * @ingroup libprofimpl
 * @name  AdprofSetProfConfig
 * @brief set profiling config in adprof
 * @return
 */
MSVP_PROF_API void AdprofSetProfConfig(uint64_t profConfig);

/**
 * @ingroup libprofimpl
 * @name  AdprofGetProfConfig
 * @brief get profiling config in adprof
 * @return
 */
MSVP_PROF_API uint64_t AdprofGetProfConfig();
#ifdef __cplusplus
}
#endif

#endif