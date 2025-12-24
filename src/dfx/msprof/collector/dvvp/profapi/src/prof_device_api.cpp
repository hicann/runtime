/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_device_api.h"
#include <dlfcn.h>
#include "msprof_dlog.h"
#include "error_code.h"

namespace ProfAPI {
namespace {
const std::string LIB_PROF_IMPL_SO = "libprofimpl.so";
const std::string MSPROF_INIT = "MsprofInit";
const std::string MSPROF_REGISTER_CALLBACK = "MsprofRegisterCallback";
const std::string MSPROF_FINALIZE = "MsprofFinalize";
const std::string MSPROF_STR_TO_ID = "MsprofStr2Id";
const std::string MSPROF_REPORT_ADDITIONAL_INFO = "MsprofReportAdditionalInfo";
const std::string MSPROF_REPORT_BATCH_ADDITIONAL_INFO = "MsprofReportBatchAdditionalInfo";
const std::string MSPROF_GET_BATCH_REPORT_MAX_SIZE = "MsprofGetBatchReportMaxSize";

using ProfInitFunc = int32_t (*)(uint32_t, void *, uint32_t);
using ProfRegisterCallbackFunc = int32_t (*)(uint32_t, ProfCommandHandle);
using ProfFinalizeFunc = int32_t (*)();
using ProfReportAdditionalInfoFunc = int32_t (*)(uint32_t, const void *, uint32_t);
using ProfStr2IdFunc = uint64_t (*)(const char *, size_t);
using ProfReportBatchAdditionalInfoFunc = int32_t (*)(uint32_t, const void *, uint32_t);
using ProfGetBatchReportMaxSizeFunc = size_t (*)(uint32_t);
}

using namespace analysis::dvvp::common::error;

ProfDevApi::ProfDevApi()
{
    MSPROF_LOGI("Start to load api from %s", LIB_PROF_IMPL_SO.c_str());
    if (libHandle_ == nullptr) {
        libHandle_ = dlopen(LIB_PROF_IMPL_SO.c_str(), RTLD_LAZY | RTLD_GLOBAL);
    }
    if (libHandle_ != nullptr) {
        funcMap_[MSPROF_INIT] = dlsym(libHandle_, MSPROF_INIT.c_str());
        funcMap_[MSPROF_REGISTER_CALLBACK] = dlsym(libHandle_, MSPROF_REGISTER_CALLBACK.c_str());
        funcMap_[MSPROF_FINALIZE] = dlsym(libHandle_, MSPROF_FINALIZE.c_str());
        funcMap_[MSPROF_STR_TO_ID] = dlsym(libHandle_, MSPROF_STR_TO_ID.c_str());
        funcMap_[MSPROF_REPORT_ADDITIONAL_INFO] = dlsym(libHandle_, MSPROF_REPORT_ADDITIONAL_INFO.c_str());
        funcMap_[MSPROF_REPORT_BATCH_ADDITIONAL_INFO] = dlsym(libHandle_, MSPROF_REPORT_BATCH_ADDITIONAL_INFO.c_str());
        funcMap_[MSPROF_GET_BATCH_REPORT_MAX_SIZE] = dlsym(libHandle_, MSPROF_GET_BATCH_REPORT_MAX_SIZE.c_str());
        MSPROF_LOGI("Load api finish.");
    } else {
        MSPROF_LOGW("Unable to open %s, return code: %s", LIB_PROF_IMPL_SO.c_str(), dlerror());
    }
}

ProfDevApi::~ProfDevApi()
{
    if (libHandle_ != nullptr) {
        dlclose(libHandle_);
    }
}

int32_t ProfDevApi::ProfInit(uint32_t dataType, void *data, uint32_t dataLen)
{
    ProfInitFunc func = reinterpret_cast<ProfInitFunc>(funcMap_[MSPROF_INIT]);
    if (func == nullptr) {
        MSPROF_LOGE("AdprofCheckFeatureIsOn func is nullptr");
        return PROFILING_FAILED;
    }
    return func(dataType, data, dataLen);
}

int32_t ProfDevApi::ProfRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    ProfRegisterCallbackFunc func = reinterpret_cast<ProfRegisterCallbackFunc>(funcMap_[MSPROF_REGISTER_CALLBACK]);
    if (func == nullptr) {
        MSPROF_LOGE("MsprofRegisterCallback func is nullptr");
        return PROFILING_FAILED;
    }
    return func(moduleId, handle);
}

int32_t ProfDevApi::ProfFinalize()
{
    ProfFinalizeFunc func = reinterpret_cast<ProfFinalizeFunc>(funcMap_[MSPROF_FINALIZE]);
    if (func == nullptr) {
        MSPROF_LOGE("MsprofFinalize func is nullptr");
        return PROFILING_FAILED;
    }
    return func();
}

uint64_t ProfDevApi::ProfStr2Id(const char *hashInfo, size_t length)
{
    ProfStr2IdFunc func = reinterpret_cast<ProfStr2IdFunc>(funcMap_[MSPROF_STR_TO_ID]);
    if (func == nullptr) {
        MSPROF_LOGE("MsprofStr2Id func is nullptr");
        return PROFILING_FAILED;
    }
    return func(hashInfo, length);
}

int32_t ProfDevApi::ProfReportAdditionalInfo(uint32_t agingFlag, const void *data, uint32_t length)
{
    ProfReportAdditionalInfoFunc func = reinterpret_cast<ProfReportAdditionalInfoFunc>(
        funcMap_[MSPROF_REPORT_ADDITIONAL_INFO]);
    if (func == nullptr) {
        MSPROF_LOGE("MsprofReportAdditionalInfo func is nullptr");
        return PROFILING_FAILED;
    }
    return func(agingFlag, data, length);
}

int32_t ProfDevApi::ProfReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length)
{
    ProfReportBatchAdditionalInfoFunc func = reinterpret_cast<ProfReportBatchAdditionalInfoFunc>(
        funcMap_[MSPROF_REPORT_BATCH_ADDITIONAL_INFO]);
    if (func == nullptr) {
        MSPROF_LOGE("MsprofReportBatchAdditionalInfo func is nullptr");
        return PROFILING_FAILED;
    }
    return func(nonPersistantFlag, data, length);
}

size_t ProfDevApi::ProfGetBatchReportMaxSize(uint32_t type)
{
    ProfGetBatchReportMaxSizeFunc func = reinterpret_cast<ProfGetBatchReportMaxSizeFunc>(
        funcMap_[MSPROF_GET_BATCH_REPORT_MAX_SIZE]);
    if (func == nullptr) {
        MSPROF_LOGE("MsprofGetBatchReportMaxSize func is nullptr");
        return PROFILING_FAILED;
    }
    return func(type);
}
}

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

int32_t MsprofInit(uint32_t dataType, void *data, uint32_t dataLen)
{
    return ProfAPI::ProfDevApi::instance()->ProfInit(dataType, data, dataLen);
}

int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    return ProfAPI::ProfDevApi::instance()->ProfRegisterCallback(moduleId, handle);
}

int32_t MsprofFinalize()
{
    return ProfAPI::ProfDevApi::instance()->ProfFinalize();
}

uint64_t MsprofStr2Id(const char *hashInfo, size_t length)
{
    return ProfAPI::ProfDevApi::instance()->ProfStr2Id(hashInfo, length);
}

int32_t MsprofReportAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    return ProfAPI::ProfDevApi::instance()->ProfReportAdditionalInfo(nonPersistantFlag, data, length);
}

int32_t MsprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    return ProfAPI::ProfDevApi::instance()->ProfReportBatchAdditionalInfo(nonPersistantFlag, data, length);
}

size_t MsprofGetBatchReportMaxSize(uint32_t type)
{
    return ProfAPI::ProfDevApi::instance()->ProfGetBatchReportMaxSize(type);
}

#ifdef __cplusplus
}
#endif

