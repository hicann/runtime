/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hccl/hccl_so_manager.h"
#include <vector>
#include <mutex>
#include <dlfcn.h>
#include "common/bqs_log.h"

namespace dgw {

HcclSoManager *HcclSoManager::GetInstance()
{
    static HcclSoManager hcclSoIns;
    return &hcclSoIns;
}

void HcclSoManager::LoadSo()
{
    if (soHandle_ != nullptr) {
        DGW_LOG_INFO("Already load libhccd.so");
        return;
    }
    soHandle_ = dlopen("libhccd.so", RTLD_LAZY);
    if (soHandle_ == nullptr) {
        DGW_LOG_RUN_WARN("Failed to dlopen libhccd.so for: %s", dlerror());
        return;
    }
    const std::vector<std::string> funcName = {"HcclInitComm", "HcclFinalizeComm",
                                               "HcclIsend", "HcclImrecv", "HcclImprobe", "HcclGetCount",
                                               "HcclTestSome", "HcclRegisterMemory", "HcclUnregisterMemory",
                                               "HcclSetGrpIdCallback"};
    for (auto iter = funcName.begin(); iter != funcName.end(); iter++) {
        void *func = dlsym(soHandle_, iter->c_str());
        if (func != nullptr) {
            (void) funcMap_.insert(make_pair(*iter, func));
        } else {
            DGW_LOG_ERROR("Failed to get function [%s]", iter->c_str());
        }
    }
    DGW_LOG_INFO("Load libhccd.so success");
}

void HcclSoManager::UnloadSo()
{
    funcMap_.clear();
    if (soHandle_ != nullptr) {
        (void)dlclose(soHandle_);
        soHandle_ = nullptr;
    }
}

void *HcclSoManager::GetFunc(const std::string &name) const
{
    const auto it = funcMap_.find(name);
    if (it != funcMap_.end()) {
        return it->second;
    }
    return nullptr;
}

HcclSoManager::~HcclSoManager()
{
    UnloadSo();
}
}