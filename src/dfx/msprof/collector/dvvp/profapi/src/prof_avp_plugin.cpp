/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_avp_plugin.h"
#include <dlfcn.h>
#include "msprof_dlog.h"
#include "prof_api.h"

namespace ProfAPI {
const std::string MSPROFIMPL_LIB_PATH = "libprofimpl.so";

ProfAvpPlugin::~ProfAvpPlugin()
{
    if (avpLibHandle_ != nullptr) {
        dlclose(avpLibHandle_);
    }
}

/**
 * @name  ProfApiInit
 * @brief load avp plugin
 * @return void
 */
void ProfAvpPlugin::ProfApiInit()
{
    if (avpLibHandle_ == nullptr) {
        avpLibHandle_ = dlopen(MSPROFIMPL_LIB_PATH.c_str(), RTLD_LAZY | RTLD_NODELETE);
    }
    if (avpLibHandle_ != nullptr) {
        PthreadOnce(&profApiLoadFlag_, []() -> void { ProfAvpPlugin::instance()->LoadProfApi(); });
    } else {
        MSPROF_LOGE("AVP API Open Failed, dlopen error: %s\n", dlerror());
    }
    return;
}

void ProfAvpPlugin::LoadProfApi()
{
    profInit_ = reinterpret_cast<ProfInitFunc>(dlsym(avpLibHandle_, "MsprofInit"));
    profRegisterCallback_ = reinterpret_cast<ProfRegisterCallbackFunc>(dlsym(avpLibHandle_, "MsprofRegisterCallback"));
    profReportRegTypeInfo_ = reinterpret_cast<ProfRegTypeInfoFunc>(dlsym(avpLibHandle_, "MsprofRegTypeInfo"));
    profReportGetHashId_ = reinterpret_cast<ProfGetHashIdFunc>(dlsym(avpLibHandle_, "MsprofGetHashId"));
    profNotifySetDevice_ = reinterpret_cast<ProfNotifySetDeviceFunc>(dlsym(avpLibHandle_, "MsprofNotifySetDevice"));
    profFinalize_ = reinterpret_cast<ProfFinalizeFunc>(dlsym(avpLibHandle_, "MsprofFinalize"));
    profReportEvent_ = reinterpret_cast<ProfReportEventFunc>(dlsym(avpLibHandle_, "MsprofReportEvent"));
    profReportApi_ = reinterpret_cast<ProfReportApiFunc>(dlsym(avpLibHandle_, "MsprofReportApi"));
    profReportCompact_ = reinterpret_cast<ProfReportCompactInfoFunc>(dlsym(avpLibHandle_, "MsprofReportCompactInfo"));
    profReportAdditional_ =
        reinterpret_cast<ProfReportAdditionalInfoFunc>(dlsym(avpLibHandle_, "MsprofReportAdditionalInfo"));
    profProfSysCycleTime_ = reinterpret_cast<ProfSysCycleTimeFunc>(dlsym(avpLibHandle_, "MsprofSysCycleTime"));
    LoadProfInfo();
}

void ProfAvpPlugin::LoadProfInfo()
{
    if (profRegisterCallback_ != nullptr) {
        for (const auto &model : moduleCallbacks_) {
            profRegisterCallback_(model.first, model.second);
        }
    }

    if (profNotifySetDevice_ != nullptr) {
        for (const auto &device : deviceStates_) {
            profNotifySetDevice_(device.first & 0xFFFFFFFFULL, device.first >> 32ULL, device.second);
        }
    }
}

int32_t ProfAvpPlugin::ProfInit(uint32_t type, void *data, uint32_t dataLen)
{
    // Init api
    ProfApiInit();
    if (profInit_ != nullptr) {
        return profInit_(type, data, dataLen);
    } else {
        MSPROF_LOGW("MSPROF API Has Not Been Load!");
    }
    return 0;
}

int32_t ProfAvpPlugin::ProfRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    if (handle == nullptr) {
        MSPROF_LOGE("Register callback with invalid handle nullptr, module[%u]", moduleId);
        return -1;
    }
    if (profRegisterCallback_ != nullptr) {
        MSPROF_LOGI("Register module[%u] callback with handle.", moduleId);
        profRegisterCallback_(moduleId, handle);
    } else {
        MSPROF_LOGI("Register module[%u] callback.", moduleId);
        const std::unique_lock<std::mutex> lock(callbackMutex_);
        moduleCallbacks_.insert(std::make_pair(moduleId, handle));
    }
    return 0;
}

int32_t ProfAvpPlugin::ProfReportApi(uint32_t agingFlag, const MsprofApi &api) const
{
    if (profReportApi_ != nullptr) {
        return profReportApi_(agingFlag, api);
    }
    return 0;
}

int32_t ProfAvpPlugin::ProfReportEvent(uint32_t agingFlag, const MsprofEvent &event) const
{
    if (profReportEvent_ != nullptr) {
        return profReportEvent_(agingFlag, event);
    }
    return 0;
}

int32_t ProfAvpPlugin::ProfReportCompactInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len) const
{
    if (profReportCompact_ != nullptr) {
        return profReportCompact_(agingFlag, data, len);
    }
    return 0;
}

int32_t ProfAvpPlugin::ProfReportAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len) const
{
    if (profReportAdditional_ != nullptr) {
        return profReportAdditional_(agingFlag, data, len);
    }
    return 0;
}

int32_t ProfAvpPlugin::ProfReportRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName) const
{
    if (profReportRegTypeInfo_ != nullptr) {
        return profReportRegTypeInfo_(level, typeId, typeName);
    }
    return 0;
}

uint64_t ProfAvpPlugin::ProfReportGetHashId(const char *hashInfo, size_t length) const
{
    if (profReportGetHashId_ != nullptr) {
        return profReportGetHashId_(hashInfo, length);
    }
    return 0;
}

int32_t ProfAvpPlugin::ProfNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen)
{
    if (profNotifySetDevice_ != nullptr) {
        return profNotifySetDevice_(chipId, deviceId, isOpen);
    } else {
        uint64_t id = deviceId;
        id = (id << 32ULL) | chipId;
        const std::unique_lock<std::mutex> lock(deviceStateMutex_);
        deviceStates_[id] = isOpen;
    }
    return 0;
}

int32_t ProfAvpPlugin::ProfFinalize() const
{
    if (profFinalize_ != nullptr) {
        return profFinalize_();
    }
    return 0;
}

uint64_t ProfAvpPlugin::ProfSysCycleTime() const
{
    if (profProfSysCycleTime_ != nullptr) {
        return profProfSysCycleTime_();
    }
    return 0;
}
}