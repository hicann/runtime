/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */


#include "prof_dev_api.h"
#include "devprof_drv_aicpu.h"
#include "hash_data.h"

using namespace analysis::dvvp::common::error;

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

MSVP_PROF_API int32_t AdprofCheckFeatureIsOn(uint64_t feature)
{
    return DevprofDrvAicpu::instance()->CheckFeatureIsOn(feature);
}

MSVP_PROF_API uint64_t AdprofGetHashId(const char *hashInfo, size_t length)
{
    if (hashInfo == nullptr || length == 0) {
        MSPROF_LOGW("The hashInfo[%zu] is invalid, thus unable to get hash id.", length);
        return PROFILING_FAILED;
    }
    return analysis::dvvp::transport::HashData::instance()->GenHashId(std::string(hashInfo, length));
}

MSVP_PROF_API int32_t AdprofReportAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length)
{
    return DevprofDrvAicpu::instance()->ReportAdditionalInfo(nonPersistantFlag, data, length);
}

MSVP_PROF_API int32_t AdprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length)
{
    return DevprofDrvAicpu::instance()->ReportAdditionalInfo(nonPersistantFlag, data, length);
}

MSVP_PROF_API size_t AdprofGetBatchReportMaxSize(uint32_t type)
{
    return DevprofDrvAicpu::instance()->GetBatchReportMaxSize(type);
}

MSVP_PROF_API int32_t AdprofAicpuStartRegister(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para)
{
    const int32_t ret = DevprofDrvAicpu::instance()->AdprofInit(para);
    if (ret == PROFILING_CONTINUE) {
        (void)aicpuStartCallback(); // aicpu callback only return 0
        MSPROF_LOGI("Aicpu register finish");
        return PROFILING_SUCCESS;
    }
    return ret;
}

MSVP_PROF_API int32_t AdprofReportData(ConstVoidPtr data, uint32_t length)
{
    (void)data;
    (void)length;
    return PROFILING_FAILED;
}

MSVP_PROF_API int32_t AdprofAicpuStop()
{
    return PROFILING_FAILED;
}

#ifdef __cplusplus
}
#endif