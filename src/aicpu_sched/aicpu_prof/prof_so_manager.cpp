/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <dlfcn.h>
#include <vector>
#include "aicpu_prof/profiling_adp.h"
#include "prof_so_manager.h"
#include "aicpu_prof.h"

namespace aicpu {

ProfSoManager *ProfSoManager::GetInstance()
{
    static ProfSoManager msprofSoInstance;
    return &msprofSoInstance;
}

void ProfSoManager::LoadSo()
{
    const std::lock_guard<std::mutex> loadSoLock(profMtx_);
    if (soHandle_ != nullptr) {
        AICPU_LOG_INFO("Already load libascend_devprof.so");
        return;
    }
    bool isProfApiSo = false;
    soHandle_ = dlopen("libprofapi.so", static_cast<int32_t>((static_cast<uint32_t>(RTLD_LAZY))|(static_cast<uint32_t>(RTLD_GLOBAL))));
    if (soHandle_ != nullptr) {
        void *func = dlsym(soHandle_, "MsprofReportBatchAdditionalInfo");
        if (func != nullptr) {
            isProfApiSo = true;
            AICPU_RUN_INFO("The new profiling so had taken effect.");
        } else {
            dlclose(soHandle_);
            soHandle_ = nullptr;
            AICPU_RUN_INFO("The new profiling so hadn't taken effect. try another old one.");
        }
    } else {
        AICPU_RUN_INFO("dlopen libprofapi.so not success. reason: %s", dlerror());
    }
    if (isProfApiSo == false) {
        soHandle_ = dlopen("libascend_devprof.so", static_cast<int32_t>(
            (static_cast<uint32_t>(RTLD_LAZY))|(static_cast<uint32_t>(RTLD_GLOBAL))));
        if (soHandle_ == nullptr) {
            AICPU_RUN_INFO("dlopen libascend_devprof.so not success. reason: %s", dlerror());
            return;
        }
        const std::vector<std::string> funcName = {
            "AdprofAicpuStartRegister",
            "AdprofReportData",
            "AdprofReportAdditionalInfo",
            "AdprofAicpuStop"
        };
        InitFunctionMap(funcName);
        return;
    }
    ProfilingAdp::GetInstance().SetNewSoFlag(true);
    const std::vector<std::string> funcName = {
        "MsprofInit",
        "MsprofReportAdditionalInfo",
    };
    InitFunctionMap(funcName);
    AICPU_LOG_INFO("Load profiling so success. [%u]", isProfApiSo);
}

void ProfSoManager::InitFunctionMap(const std::vector<std::string> &funcName)
{
    if (soHandle_ == nullptr) {
        AICPU_LOG_ERROR("soHandle is nullptr");
        return;
    }
    for (auto iter = funcName.begin(); iter != funcName.end(); iter++) {
        void *func = dlsym(soHandle_, iter->c_str());
        if (func != nullptr) {
            (void) funcMap_.insert(make_pair(*iter, func));
        } else {
            AICPU_LOG_ERROR("Failed to get function [%s]", iter->c_str());
        }
    }
    return;
}

void ProfSoManager::UnloadSo()
{
    funcMap_.clear();
    if (soHandle_ != nullptr) {
        (void)dlclose(soHandle_);
        soHandle_ = nullptr;
    }
}

void *ProfSoManager::GetFunc(const std::string &name) const
{
    const auto it = funcMap_.find(name);
    if (it != funcMap_.end()) {
        return it->second;
    }
    return nullptr;
}

ProfSoManager::~ProfSoManager()
{
    UnloadSo();
}

int32_t AdprofAicpuStartRegisterFunc(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para)
{
    void * const func = aicpu::ProfSoManager::GetInstance()->GetFunc("AdprofAicpuStartRegister");
    if (func == nullptr) {
        AICPU_LOG_ERROR("Failed to get function AdprofAicpuStartRegister");
        return static_cast<int32_t>(ProfStatusCode::PROFILINE_FAILED);
    }
    return (reinterpret_cast<ProfAicpuStartRegisterFunc>(func))(aicpuStartCallback, para);
}

int32_t AdprofReportDataFunc(VOID_PTR data, uint32_t len)
{
    void * const func = aicpu::ProfSoManager::GetInstance()->GetFunc("AdprofReportData");
    if (func == nullptr) {
        AICPU_LOG_ERROR("Failed to get function AdprofReportData");
        return static_cast<int32_t>(ProfStatusCode::PROFILINE_FAILED);
    }
    return (reinterpret_cast<ProfReportDataFunc>(func))(data, len);
}

int32_t AdprofReportAdditionalInfoFunc(uint32_t agingFlag, const VOID_PTR data, uint32_t length)
{
    void * const func = aicpu::ProfSoManager::GetInstance()->GetFunc("AdprofReportAdditionalInfo");
    if (func == nullptr) {
        AICPU_LOG_ERROR("Failed to get function AdprofReportAdditionalInfo");
        return static_cast<int32_t>(ProfStatusCode::PROFILINE_FAILED);
    }
    return (reinterpret_cast<ProfReportAdditionalInfoFunc>(func))(agingFlag, data, length);
}

int32_t AdprofAicpuStopFunc()
{
    void * const func = aicpu::ProfSoManager::GetInstance()->GetFunc("AdprofAicpuStop");
    if (func == nullptr) {
        AICPU_LOG_ERROR("Failed to get function AdprofAicpuStop.");
        return static_cast<int32_t>(ProfStatusCode::PROFILINE_FAILED);
    }
    return (reinterpret_cast<ProfAdprofAicpuStopFunc>(func))();
}
using ProfMsprofInitFunc = int32_t (*)(uint32_t dataType, VOID_PTR data, uint32_t dataLen);
using ProfMsprofReportAdditionalInfoFunc = int32_t (*)(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length);

int32_t MsprofInitFunc(uint32_t dataType, VOID_PTR data, uint32_t dataLen)
{
    void * const func = aicpu::ProfSoManager::GetInstance()->GetFunc("MsprofInit");
    if (func == nullptr) {
        AICPU_LOG_ERROR("Failed to get function MsprofInit.");
        return static_cast<int32_t>(ProfStatusCode::PROFILINE_FAILED);
    }
    return (PtrToFunctionPtr<void, ProfMsprofInitFunc>(func))(dataType, data, dataLen);
}

int32_t MsprofReportAdditionalInfoFunc(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    void * const func = aicpu::ProfSoManager::GetInstance()->GetFunc("MsprofReportAdditionalInfo");
    if (func == nullptr) {
        AICPU_LOG_ERROR("Failed to get function MsprofReportAdditionalInfo.");
        return static_cast<int32_t>(ProfStatusCode::PROFILINE_FAILED);
    }
    return (PtrToFunctionPtr<void, ProfMsprofReportAdditionalInfoFunc>(func))(nonPersistantFlag, data, length);
}
} // namespace aicpu