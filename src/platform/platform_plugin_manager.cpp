/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "platform_plugin_manager.h"
#include "platform_log.h"
#include "mmpa/mmpa_api.h"

namespace fe {
namespace {
const std::string kPluginLibName = "libascend_hal.so";

template <class T>
inline T LoadPluginApi(void* handle, const char_t* name)
{
    if (handle == nullptr) {
        return nullptr;
    }
    return reinterpret_cast<T>(mmDlsym(handle, name));
}
} // namespace

PlatformPluginManager::PlatformPluginManager() {}

PlatformPluginManager::~PlatformPluginManager()
{
    std::lock_guard<std::mutex> lock(init_mutex_);
    ClosePlugin();
}

PlatformPluginManager& PlatformPluginManager::GetInstance()
{
    static PlatformPluginManager plugin_manager;
    return plugin_manager;
}

void PlatformPluginManager::ClosePlugin()
{
    if (plugin_handle_ != nullptr) {
        (void)mmDlclose(plugin_handle_);
        plugin_handle_ = nullptr;
    }
    drv_get_dev_ids_func_ = nullptr;
    hal_get_soc_version_func_ = nullptr;
    hal_get_device_info_func_ = nullptr;
    initialized_ = false;
}

void PlatformPluginManager::LoadApi()
{
    drv_get_dev_ids_func_ = LoadPluginApi<drvError_t (*)(uint32_t*, uint32_t)>(plugin_handle_, "drvGetDevIDs");
    hal_get_soc_version_func_ =
        LoadPluginApi<drvError_t (*)(uint32_t, char*, uint32_t)>(plugin_handle_, "halGetSocVersion");
    hal_get_device_info_func_ =
        LoadPluginApi<drvError_t (*)(uint32_t, int32_t, int32_t, int64_t*)>(plugin_handle_, "halGetDeviceInfo");
}

void PlatformPluginManager::EnsureInit()
{
    std::lock_guard<std::mutex> lock(init_mutex_);
    if (initialized_) {
        return;
    }

    plugin_handle_ = mmDlopen(kPluginLibName.c_str(), RTLD_LAZY | RTLD_NODELETE);
    if (plugin_handle_ == nullptr) {
        const char_t* dlErrMsg = mmDlerror();
        PF_LOGI(
            "Unable to open %s, running as general server scenario. dlopen info: %s", kPluginLibName.c_str(),
            (dlErrMsg != nullptr) ? dlErrMsg : "unknown");
    }
    LoadApi();
    initialized_ = true;
}

drvError_t PlatformPluginManager::DrvGetDevIDs(uint32_t* devices, uint32_t len)
{
    EnsureInit();
    if (drv_get_dev_ids_func_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return drv_get_dev_ids_func_(devices, len);
}

drvError_t PlatformPluginManager::HalGetSocVersion(uint32_t devId, char* socVersion, uint32_t len)
{
    EnsureInit();
    if (hal_get_soc_version_func_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return hal_get_soc_version_func_(devId, socVersion, len);
}

drvError_t PlatformPluginManager::HalGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t* value)
{
    EnsureInit();
    if (hal_get_device_info_func_ == nullptr) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return hal_get_device_info_func_(devId, moduleType, infoType, value);
}
} // namespace fe
