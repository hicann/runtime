/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "devprof_drv_aicpu.h"
#include "hash_data.h"

using namespace analysis::dvvp::common::error;

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

MSVP_PROF_API int32_t MsprofInit(uint32_t dataType, void *data, uint32_t dataLen)
{
    (void)dataType;
    FUNRET_CHECK_EXPR_ACTION(dataLen != sizeof(AicpuStartPara), return PROFILING_FAILED,
        "Input size %u is different form AicpuStartPara size %lld", dataLen, sizeof(AicpuStartPara));
 
    const int32_t ret = DevprofDrvAicpu::instance()->AdprofInit(static_cast<const AicpuStartPara*>(data));
    if (ret == PROFILING_CONTINUE) {
        MSPROF_LOGI("AdprofInit execution finished.");
        return PROFILING_SUCCESS;
    }
    return ret;
}
 
MSVP_PROF_API int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    const int32_t ret = DevprofDrvAicpu::instance()->ModuleRegisterCallback(moduleId, handle);
    MSPROF_LOGI("AdprofRegisterCallback execution finished for module %u.", moduleId);
    return ret;
}
 
MSVP_PROF_API int32_t MsprofFinalize()
{
    DevprofDrvAicpu::instance()->DeviceReportStop();
    MSPROF_LOGI("AdprofFinalize execution finished.");
    return PROFILING_SUCCESS;
}
 
MSVP_PROF_API uint64_t MsprofStr2Id(const char *hashInfo, size_t length)
{
    if (hashInfo == nullptr || length == 0) {
        MSPROF_LOGW("The hashInfo[%zu] is invalid, thus unable to get hash id.", length);
        return PROFILING_FAILED;
    }
    return analysis::dvvp::transport::HashData::instance()->GenHashId(std::string(hashInfo, length));
}
 
MSVP_PROF_API int32_t MsprofReportAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    return DevprofDrvAicpu::instance()->ReportAdditionalInfo(nonPersistantFlag, data, length);
}
 
MSVP_PROF_API int32_t MsprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    return DevprofDrvAicpu::instance()->ReportAdditionalInfo(nonPersistantFlag, data, length);
}
 
MSVP_PROF_API size_t MsprofGetBatchReportMaxSize(uint32_t type)
{
    return DevprofDrvAicpu::instance()->GetBatchReportMaxSize(type);
}

#ifdef __cplusplus
}
#endif