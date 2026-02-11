/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_runtime_plugin.h"
#include <dlfcn.h>
#include "msprof_dlog.h"
#include "errno/error_code.h"
#include "prof_api.h"
#include "utils/utils.h"

namespace ProfAPI {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

const std::string RUNTIME_LIB_PATH = "libruntime.so";

static std::set<std::string> g_runtimeApiSet = {
    "rtProfilerTraceEx",
    "rtsStreamGetAttribute",
    "rtCacheLastTaskOpInfo"
};

ProfRuntimePlugin::~ProfRuntimePlugin()
{
    if (runtimeLibHandle_ != nullptr) {
        dlclose(runtimeLibHandle_);
    }
}

void ProfRuntimePlugin::LoadRuntimeApi()
{
    for (auto &it : g_runtimeApiSet) {
        auto addr = dlsym(runtimeLibHandle_, it.c_str());
        if (addr == nullptr) {
            MSPROF_LOGW("Unable to load api[%s] from %s.", it.c_str(), RUNTIME_LIB_PATH.c_str());
            continue;
        }
        MSPROF_LOGI("Load api[%s] from %s successfully.", it.c_str(), RUNTIME_LIB_PATH.c_str());
        runtimeApiInfoMap_.insert({it, {it, addr}});
    }
}

int32_t ProfRuntimePlugin::RuntimeApiInit()
{
    if (runtimeLibHandle_ == nullptr) {
        MSPROF_LOGD("Init api handle from %s", RUNTIME_LIB_PATH.c_str());
        runtimeLibHandle_ = dlopen(RUNTIME_LIB_PATH.c_str(), RTLD_NOW | RTLD_GLOBAL | RTLD_NODELETE);
    }
    if (runtimeLibHandle_ == nullptr) {
        MSPROF_LOGW("Unable to dlopen api from %s, return code: %s\n", RUNTIME_LIB_PATH.c_str(), dlerror());
        return PROFILING_FAILED;
    }
    ProfAPI::PthreadOnce(&runtimeApiloadFlag_, []() -> void { ProfRuntimePlugin::instance()->LoadRuntimeApi(); });
    return PROFILING_SUCCESS;
}

void *ProfRuntimePlugin::GetPluginApiFunc(const std::string funcName)
{
    auto it = runtimeApiInfoMap_.find(funcName);
    if (it == runtimeApiInfoMap_.cend()) {
        MSPROF_LOGE("Can't find api %s", funcName.c_str());
        return nullptr;
    }

    return it->second.funcAddr;
}

int32_t ProfRuntimePlugin::ProfMarkEx(uint64_t indexId, uint64_t modelId, uint16_t tagId, void *stm)
{
    auto func = GetPluginApiFunc("rtProfilerTraceEx");
    if (func == nullptr) {
        MSPROF_LOGE("Failed to get api stub[rtProfilerTraceEx] func.");
        return PROFILING_FAILED;
    }
    rtError_t ret = reinterpret_cast<RtProfilerTraceExFunc>(func)(indexId, modelId, tagId,
        static_cast<rtStream_t>(stm));
    if (ret != RT_ERROR_NONE) {
        MSPROF_LOGE("Failed to call rtProfilerTraceEx, ret: %d.", ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfRuntimePlugin::ProfRtsStreamGetAttribute(
    rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue)
{
    auto func = GetPluginApiFunc("rtsStreamGetAttribute");
    if (func == nullptr) {
        MSPROF_LOGE("Failed to get api stub[rtsStreamGetAttribute] func.");
        return PROFILING_FAILED;
    }
    rtError_t ret = reinterpret_cast<RtsStreamGetAttributeFunc>(func)(stm, stmAttrId, attrValue);
    if (ret != RT_ERROR_NONE) {
        MSPROF_LOGE("Failed to call rtsStreamGetAttribute, ret: %d.", ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfRuntimePlugin::ProfRtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    auto func = GetPluginApiFunc("rtCacheLastTaskOpInfo");
    if (func == nullptr) {
        MSPROF_LOGE("Failed to get api stub[rtCacheLastTaskOpInfo] func.");
        return PROFILING_FAILED;
    }
    rtError_t ret = reinterpret_cast<RtCacheLastTaskOpInfoFunc>(func)(infoPtr, infoSize);
    if (ret != RT_ERROR_NONE) {
        MSPROF_LOGE("Failed to call rtCacheLastTaskOpInfo, ret: %d.", ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}
}