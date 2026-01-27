/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "bqs_so_manager.h"

#include <dlfcn.h>
#include "bqs_log.h"

namespace bqs {
void *SoManager::GetFuncHandle(const std::string &funcName)
{
    if (soHandle_ == nullptr) {
        BQS_LOG_ERROR("Get func handle failed by so handle is nullptr, soName=%s, funcName=%s.",
                      soName_.c_str(), funcName.c_str());
        return nullptr;
    }

    const auto &iter = funcHandleMap_.find(funcName);
    if (iter == funcHandleMap_.end()) {
        void *funcHandle = GetFuncHandleFromSo(funcName);
        if (funcHandle == nullptr) {
            return nullptr;
        }
        (void)funcHandleMap_.emplace(funcName, funcHandle);
        return funcHandle;
    }

    return iter->second;
}

bool SoManager::IsSoLoad() const
{
    return soHandle_ != nullptr;
}

void SoManager::OpenSo()
{
    if (soName_.empty()) {
        BQS_LOG_ERROR("Open so failed by so name is empty.");
        return;
    }

    soHandle_ = dlopen(soName_.c_str(), RTLD_LAZY);
    if (soHandle_ == nullptr) {
        BQS_LOG_ERROR("Open so failed, soName=%s, reason=%s.", soName_.c_str(), dlerror());
    }

    return;
}

void SoManager::CloseSo()
{
    if (soHandle_ == nullptr) {
        return;
    }

    const int32_t ret = dlclose(soHandle_);
    if (ret != 0) {
        BQS_LOG_WARN("Close so failed, soName=%s, reason=%s.", soName_.c_str(), dlerror());
    }

    soHandle_ = nullptr;
    return;
}

void SoManager::BatchLoadFunc(const std::vector<std::string> &funcNames)
{
    if (soHandle_ == nullptr) {
        BQS_LOG_ERROR("Get func handle failed by so handle is nullptr, soName=%s.", soName_.c_str());
        return;
    }

    for (const std::string &funcName: funcNames) {
        void *funcPtr = GetFuncHandleFromSo(funcName);
        if (funcPtr != nullptr) {
            (void)funcHandleMap_.emplace(funcName, funcPtr);
        }
    }

    return;
}

void *SoManager::GetFuncHandleFromSo(const std::string &funcName) const
{
    void *funcPtr = dlsym(soHandle_, funcName.c_str());
    if (funcPtr == nullptr) {
        BQS_LOG_ERROR("Get func handle from so failed, soName=%s, funcName=%s, error=%s.",
                      soName_.c_str(), funcName.c_str(), dlerror());
        return nullptr;
    }

    return funcPtr;
}
} // namespace bqs
