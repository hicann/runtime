/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __PLATFORM_PLUGIN_MANAGER_H__
#define __PLATFORM_PLUGIN_MANAGER_H__

#include <mutex>
#include "driver/ascend_hal_base.h"

namespace fe {
class PlatformPluginManager {
public:
    PlatformPluginManager(const PlatformPluginManager&) = delete;
    PlatformPluginManager& operator=(const PlatformPluginManager&) = delete;

    PlatformPluginManager();
    ~PlatformPluginManager();

    static PlatformPluginManager& GetInstance();

    drvError_t DrvGetDevIDs(uint32_t* devices, uint32_t len);
    drvError_t HalGetSocVersion(uint32_t devId, char* socVersion, uint32_t len);
    drvError_t HalGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t* value);

private:
    void EnsureInit();
    void LoadApi();
    void ClosePlugin();

    std::mutex init_mutex_;
    bool initialized_{false};
    void* plugin_handle_{nullptr};

    drvError_t (*drv_get_dev_ids_func_)(uint32_t*, uint32_t){nullptr};
    drvError_t (*hal_get_soc_version_func_)(uint32_t, char*, uint32_t){nullptr};
    drvError_t (*hal_get_device_info_func_)(uint32_t, int32_t, int32_t, int64_t*){nullptr};
};
} // namespace fe
#endif // __PLATFORM_PLUGIN_MANAGER_H__
