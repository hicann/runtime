/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DEVPROF_PUB_H
#define DEVPROF_PUB_H

#include <stdint.h>
#include <stddef.h>
#include "aprof_pub.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef int32_t (*AicpuStartFunc)();

struct AicpuStartPara {
    uint32_t devId;
    uint32_t hostPid;
    uint32_t channelId;
    uint32_t profConfig;
};

enum AdprofReportType {
    ADPROF_ADDITIONAL_INFO = 0
};

/**
 * @ingroup libascend_devprof
 * @name  AdprofRegisterCallback
 * @brief Callback function for registered components
 * @param[in] moduleId       Report ID of the component
 * @param[in] commandHandle  Callback function for component registration
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t AdprofRegisterCallback(uint32_t moduleId, ProfCommandHandle commandHandle);

/**
 * @ingroup libascend_devprof
 * @name  AdprofAicpuStartRegister
 * @brief regist aicpu start report func
 * @param[in] aicpuStartCallback  aicpu start report func
 * @param[in] para                aicpu start para
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t AdprofAicpuStartRegister(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para);

/**
 * @ingroup libascend_devprof
 * @name  AdprofReportAdditionalInfo
 * @brief aicpu report profiling data func
 * @param[in] agingFlag  0 isn't aging, !0 is aging
 * @param[in] data       profiling data of additional infomation
 * @param[in] length     length of profiling data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t AdprofReportAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length);

/**
 * @ingroup libascend_devprof
 * @name  AdprofReportBatchAdditionalInfo
 * @brief aicpu report batch profiling data func
 * @param[in] agingFlag  0 isn't aging, !0 is aging
 * @param[in] data       profiling data of additional infomation
 * @param[in] length     length of profiling data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t AdprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length);

/**
 * @ingroup libascend_devprof
 * @name  AdprofGetBatchReportMaxSize
 * @brief get max batch report size
 * @param[in] type  type of batch report
 * @return >0:SUCCESS, <=0:FAILED
 */
MSVP_PROF_API size_t AdprofGetBatchReportMaxSize(uint32_t type);

/**
 * @ingroup libascend_devprof
 * @name  AdprofStr2Id
 * @brief return hash id of hash info
 * @param[in] hashInfo  infomation to be hashed
 * @param[in] length    the length of infomation to be hashed
 * @return hash id
 */
MSVP_PROF_API uint64_t AdprofStr2Id(const char *hashInfo, size_t length);

#ifdef __cplusplus
}
#endif
#endif