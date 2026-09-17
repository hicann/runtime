/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime_thread_aicpu_so_manager.hpp"

#include <cstdlib>
#include <dlfcn.h>

#include "aicpu_sched/aicpu_schedule/common/aicpusd_status.h"

namespace cce {
namespace runtime_thread_aicpu {
namespace {

constexpr char OPERATOR_SO_PATH_ENV[] = "RUNTIME_THREAD_AICPU_SO_PATH";

} // namespace

std::string SoManager::ResolvePath(const std::string& soName) const
{
    const char* const searchPath = std::getenv(OPERATOR_SO_PATH_ENV);
    if ((searchPath == nullptr) || (searchPath[0] == '\0') || (soName.find('/') != std::string::npos)) {
        return soName;
    }
    return std::string(searchPath) + "/" + soName;
}

RuntimeThreadAicpuStatus SoManager::GetFunction(
    const std::string& soName, const std::string& functionName, void** const function, std::string& errorDetail)
{
    errorDetail.clear();
    if ((soName.empty()) || (functionName.empty()) || (function == nullptr)) {
        errorDetail = "invalid operator library, function name, or output address";
        aicpusd_err("Get AICPU operator function failed: %s.", errorDetail.c_str());
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }

    const std::string functionKey = soName + '\n' + functionName;
    std::lock_guard<std::mutex> lock(mutex_);
    const auto functionIt = functions_.find(functionKey);
    if (functionIt != functions_.end()) {
        *function = functionIt->second;
        aicpusd_debug(
            "Reuse cached AICPU operator function, so_name=%s, function_name=%s.", soName.c_str(),
            functionName.c_str());
        return RuntimeThreadAicpuStatus::OK;
    }

    void* libraryHandle = nullptr;
    const auto handleIt = handles_.find(soName);
    if (handleIt == handles_.end()) {
        const std::string resolvedPath = ResolvePath(soName);
        aicpusd_info("Open AICPU operator so begin, path=%s.", resolvedPath.c_str());
        libraryHandle = dlopen(resolvedPath.c_str(), RTLD_NOW | RTLD_GLOBAL);
        if (libraryHandle == nullptr) {
            const char* const loadError = dlerror();
            errorDetail = (loadError == nullptr) ? "dlopen returned a null handle" : loadError;
            aicpusd_err(
                "Open AICPU operator so failed, path=%s, reason=%s.", resolvedPath.c_str(), errorDetail.c_str());
            return RuntimeThreadAicpuStatus::OPEN_SO_FAILED;
        }
        handles_.emplace(soName, libraryHandle);
        aicpusd_info("Open AICPU operator so success, path=%s.", resolvedPath.c_str());
    } else {
        libraryHandle = handleIt->second;
        aicpusd_debug("Reuse cached AICPU operator so, so_name=%s.", soName.c_str());
    }

    (void)dlerror();
    void* const functionAddress = dlsym(libraryHandle, functionName.c_str());
    const char* const symbolError = dlerror();
    if ((functionAddress == nullptr) || (symbolError != nullptr)) {
        errorDetail = (symbolError == nullptr) ? "dlsym returned a null address" : symbolError;
        aicpusd_err(
            "Resolve AICPU operator symbol failed, so_name=%s, function_name=%s, reason=%s.", soName.c_str(),
            functionName.c_str(), errorDetail.c_str());
        return RuntimeThreadAicpuStatus::SYMBOL_NOT_FOUND;
    }
    functions_.emplace(functionKey, functionAddress);
    *function = functionAddress;
    aicpusd_info(
        "Resolve AICPU operator symbol success, so_name=%s, function_name=%s.", soName.c_str(), functionName.c_str());
    return RuntimeThreadAicpuStatus::OK;
}

} // namespace runtime_thread_aicpu
} // namespace cce
