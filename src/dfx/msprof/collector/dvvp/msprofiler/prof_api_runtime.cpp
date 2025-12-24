/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_api_runtime.h"
#include <dlfcn.h>
#include <string>
#include "msprof_dlog.h"
#include "errno/error_code.h"

namespace ProfRtAPI {
using namespace analysis::dvvp::common::error;
const std::string RUNTIME_LIB_PATH = "libruntime.so";

ExtendPlugin::~ExtendPlugin()
{
    if (msRuntimeLibHandle_ != nullptr) {
        dlclose(msRuntimeLibHandle_);
    }
}

void ExtendPlugin::RuntimeApiInit()
{
    if (msRuntimeLibHandle_ == nullptr) {
        msRuntimeLibHandle_ = dlopen(RUNTIME_LIB_PATH.c_str(), RTLD_NOW | RTLD_GLOBAL | RTLD_NODELETE);
    }
    if (msRuntimeLibHandle_ != nullptr) {
        ProfAPI::PthreadOnce(&loadFlag_, []() -> void { ExtendPlugin::instance()->LoadProfApi(); });
    } else {
        MSPROF_LOGE("RUNTIME API Open Failed, dlopen error: %s\n", dlerror());
    }
    return;
}

void ExtendPlugin::LoadProfApi()
{
    do {
        rtGetVisibleDeviceIdByLogicDeviceId_ = reinterpret_cast<RtGetVisibleDeviceIdByLogicDeviceIdFunc>(
            dlsym(msRuntimeLibHandle_, "rtGetVisibleDeviceIdByLogicDeviceId"));
    } while (0);
}

int32_t ExtendPlugin::ProfGetVisibleDeviceIdByLogicDeviceId(int32_t logicDeviceId,
    int32_t* visibleDeviceId) const
{
    if (rtGetVisibleDeviceIdByLogicDeviceId_ == nullptr) {
        MSPROF_LOGW("RuntimePlugin rtGetVisibleDeviceIdByLogicDeviceId function is null.");
        return PROFILING_NOTSUPPORT;
    }
    return rtGetVisibleDeviceIdByLogicDeviceId_(logicDeviceId, visibleDeviceId);
}

}