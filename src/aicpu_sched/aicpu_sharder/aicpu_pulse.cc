/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_pulse.h"

#include <mutex>
#include <string>
#include <unordered_map>

#include "aicpu_sharder_log.h"

namespace {
    static std::unordered_map<std::string, PulseNotifyFunc> pulseNotifyFuncMap;
    static std::mutex g_mtx;
}


__attribute__((visibility("default"))) void AicpuPulseNotify()
{
    const std::unique_lock<std::mutex> lck(g_mtx);
    for (auto &notifyFunc:pulseNotifyFuncMap) {
        AICPUE_LOGD("Aicpu pulse notify %s start.", notifyFunc.first.c_str());
        notifyFunc.second();
        AICPUE_LOGD("Aicpu pulse notify %s end.", notifyFunc.first.c_str());
    }
}

__attribute__((visibility("default"))) int32_t RegisterPulseNotifyFunc(const char_t * const name,
                                                                       const PulseNotifyFunc func)
{
    if (name == nullptr) {
        AICPUE_LOGE("Register pulse notify func failed as param name is null");
        return -1;
    }

    if (func == nullptr) {
        AICPUE_LOGE("Register pulse notify func for %s failed as param func is null", name);
        return -1;
    }

    const std::unique_lock<std::mutex> lck(g_mtx);
    const auto ret = pulseNotifyFuncMap.emplace(name, func);
    if (!ret.second) {
        AICPUE_LOGE("Register pulse notify func for %s failed.", name);
        return -1;
    }
    AICPUE_LOGI("Register pulse notify func for %s success.", name);
    return 0;
}

__attribute__((visibility("default"))) void ClearPulseNotifyFunc()
{
    AICPUE_LOGI("Clear pulse notify func.");
    const std::unique_lock<std::mutex> lck(g_mtx);
    pulseNotifyFuncMap.clear();
}
