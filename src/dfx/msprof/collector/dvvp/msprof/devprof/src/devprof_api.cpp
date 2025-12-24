/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "devprof_api.h"
#include <dlfcn.h>
#include "msprof_dlog.h"
#include "error_code.h"

using namespace analysis::dvvp::common::error;

namespace {
const std::string LIB_PROF_IMPL_SO = "libprofimpl.so";
const std::string ADPROF_CHECK_FEATURE_IS_ON = "AdprofCheckFeatureIsOn";
const std::string ADPROF_START = "AdprofStart";
const std::string ADPROF_STOP = "AdprofStop";
const std::string ADPROF_GET_IS_EXIT = "GetIsExit";
const std::string ADPROF_GET_HASH_ID = "AdprofGetHashId";
const std::string ADPROF_AICPU_START_REGISTER = "AdprofAicpuStartRegister";
const std::string ADPROF_REPORT_ADDITIONAL_INFO = "AdprofReportAdditionalInfo";
const std::string ADPROF_REPORT_BATCH_ADDITIONAL_INFO = "AdprofReportBatchAdditionalInfo";
const std::string ADPROF_GET_BATCH_REPORT_MAX_SIZE = "AdprofGetBatchReportMaxSize";

using AdprofCheckFeatureIsOnFunc = int32_t (*)(uint64_t);
using AdprofStartFunc = int32_t (*)(int32_t, const char *[]);
using AdprofStopFunc = int32_t (*)();
using AdprofGetHashIdFunc = uint64_t (*)(const char *, size_t);
using AdprofAicpuStartRegisterFunc = int32_t (*)(AicpuStartFunc, const struct AicpuStartPara *);
using AdprofReportAdditionalInfoFunc = int32_t (*)(uint32_t, const void *, uint32_t);
using AdprofReportBatchAdditionalInfoFunc = int32_t (*)(uint32_t, const void *, uint32_t);
using AdprofGetBatchReportMaxSizeFunc = size_t (*)(uint32_t);
}

DevprofApi DevprofApi::item_;

DevprofApi::DevprofApi()
{
    MSPROF_LOGI("Start to load api from %s", LIB_PROF_IMPL_SO.c_str());
    if (libHandle_ == nullptr) {
        libHandle_ = dlopen(LIB_PROF_IMPL_SO.c_str(), RTLD_LAZY | RTLD_NODELETE);
    }
    if (libHandle_ != nullptr) {
        funcMap_[ADPROF_CHECK_FEATURE_IS_ON] = dlsym(libHandle_, ADPROF_CHECK_FEATURE_IS_ON.c_str());
        funcMap_[ADPROF_START] = dlsym(libHandle_, ADPROF_START.c_str());
        funcMap_[ADPROF_STOP] = dlsym(libHandle_, ADPROF_STOP.c_str());
        funcMap_[ADPROF_GET_IS_EXIT] = dlsym(libHandle_, ADPROF_GET_IS_EXIT.c_str());
        funcMap_[ADPROF_GET_HASH_ID] = dlsym(libHandle_, ADPROF_GET_HASH_ID.c_str());
        funcMap_[ADPROF_AICPU_START_REGISTER] = dlsym(libHandle_, ADPROF_AICPU_START_REGISTER.c_str());
        funcMap_[ADPROF_REPORT_ADDITIONAL_INFO] = dlsym(libHandle_, ADPROF_REPORT_ADDITIONAL_INFO.c_str());
        funcMap_[ADPROF_REPORT_BATCH_ADDITIONAL_INFO] = dlsym(libHandle_, ADPROF_REPORT_BATCH_ADDITIONAL_INFO.c_str());
        funcMap_[ADPROF_GET_BATCH_REPORT_MAX_SIZE] = dlsym(libHandle_, ADPROF_GET_BATCH_REPORT_MAX_SIZE.c_str());
        MSPROF_LOGI("Load api finish.");
    } else {
        MSPROF_LOGE("Unable to open %s, return code: %s", LIB_PROF_IMPL_SO.c_str(), dlerror());
    }
}

DevprofApi::~DevprofApi()
{
    if (libHandle_ != nullptr) {
        dlclose(libHandle_);
    }
}

int32_t DevprofApi::CheckFeatureIsOn(uint64_t feature)
{
    AdprofCheckFeatureIsOnFunc func = reinterpret_cast<AdprofCheckFeatureIsOnFunc>(
        funcMap_[ADPROF_CHECK_FEATURE_IS_ON]);
    if (func == nullptr) {
        MSPROF_LOGE("AdprofCheckFeatureIsOn func is nullptr");
        return PROFILING_FAILED;
    }
    return func(feature);
}

int32_t DevprofApi::Start(int32_t argc, const char *argv[])
{
    AdprofStartFunc func = reinterpret_cast<AdprofStartFunc>(funcMap_[ADPROF_START]);
    if (func == nullptr) {
        MSPROF_LOGE("AdprofStart func is nullptr");
        return PROFILING_FAILED;
    }
    return func(argc, argv);
}

int32_t DevprofApi::Stop()
{
    AdprofStopFunc func = reinterpret_cast<AdprofStopFunc>(funcMap_[ADPROF_STOP]);
    if (func == nullptr) {
        MSPROF_LOGE("AdprofStop func is nullptr");
        return PROFILING_FAILED;
    }
    return func();
}

int32_t DevprofApi::GetIsExit()
{
    AdprofStopFunc func = reinterpret_cast<AdprofStopFunc>(funcMap_[ADPROF_GET_IS_EXIT]);
    if (func == nullptr) {
        MSPROF_LOGE("GetIsExit func is nullptr");
        return PROFILING_FAILED;
    }
    return func();
}

uint64_t DevprofApi::GetHashId(const char *hashInfo, size_t length)
{
    AdprofGetHashIdFunc func = reinterpret_cast<AdprofGetHashIdFunc>(funcMap_[ADPROF_GET_HASH_ID]);
    if (func == nullptr) {
        MSPROF_LOGE("AdprofGetHashId func is nullptr");
        return PROFILING_FAILED;
    }
    return func(hashInfo, length);
}

int32_t DevprofApi::AicpuStartRegister(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para)
{
    AdprofAicpuStartRegisterFunc func = reinterpret_cast<AdprofAicpuStartRegisterFunc>(
        funcMap_[ADPROF_AICPU_START_REGISTER]);
    if (func == nullptr) {
        MSPROF_LOGE("AdprofAicpuStartRegister func is nullptr");
        return PROFILING_FAILED;
    }
    return func(aicpuStartCallback, para);
}

int32_t DevprofApi::ReportAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length)
{
    AdprofReportAdditionalInfoFunc func = reinterpret_cast<AdprofReportAdditionalInfoFunc>(
        funcMap_[ADPROF_REPORT_ADDITIONAL_INFO]);
    if (func == nullptr) {
        MSPROF_LOGE("AdprofReportAdditionalInfo is nullptr");
        return PROFILING_FAILED;
    }
    return func(nonPersistantFlag, data, length);
}

int32_t DevprofApi::ReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length)
{
    AdprofReportBatchAdditionalInfoFunc func = reinterpret_cast<AdprofReportBatchAdditionalInfoFunc>(
        funcMap_[ADPROF_REPORT_BATCH_ADDITIONAL_INFO]);
    if (func == nullptr) {
        MSPROF_LOGE("AdprofReportBatchAdditionalInfo is nullptr");
        return PROFILING_FAILED;
    }
    return func(nonPersistantFlag, data, length);
}

size_t DevprofApi::GetBatchReportMaxSize(uint32_t type)
{
    AdprofGetBatchReportMaxSizeFunc func = reinterpret_cast<AdprofGetBatchReportMaxSizeFunc>(
        funcMap_[ADPROF_GET_BATCH_REPORT_MAX_SIZE]);
    if (func == nullptr) {
        MSPROF_LOGE("AdprofGetBatchReportMaxSize func is nullptr");
        return 0;
    }
    return func(type);
}

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

MSVP_PROF_API int32_t AdprofCheckFeatureIsOn(uint64_t feature)
{
    return DevprofApi::Instance()->CheckFeatureIsOn(feature);
}

MSVP_PROF_API uint64_t AdprofGetHashId(const char *hashInfo, size_t length)
{
    return DevprofApi::Instance()->GetHashId(hashInfo, length);
}

MSVP_PROF_API int32_t AdprofReportAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length)
{
    return DevprofApi::Instance()->ReportAdditionalInfo(nonPersistantFlag, data, length);
}

MSVP_PROF_API int32_t AdprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length)
{
    return DevprofApi::Instance()->ReportAdditionalInfo(nonPersistantFlag, data, length);
}

MSVP_PROF_API size_t AdprofGetBatchReportMaxSize(uint32_t type)
{
    return DevprofApi::Instance()->GetBatchReportMaxSize(type);
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

MSVP_PROF_API int32_t AdprofStart(int32_t argc, const char *argv[])
{
    return DevprofApi::Instance()->Start(argc, argv);
}

MSVP_PROF_API int32_t AdprofStop()
{
    return DevprofApi::Instance()->Stop();
}

MSVP_PROF_API bool GetIsExit(void)
{
    return DevprofApi::Instance()->GetIsExit();
}

MSVP_PROF_API int32_t AdprofAicpuStartRegister(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para)
{
    return DevprofApi::Instance()->AicpuStartRegister(aicpuStartCallback, para);
}

#ifdef __cplusplus
}
#endif