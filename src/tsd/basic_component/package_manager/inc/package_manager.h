/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_MANAGER_H
#define TSD_PACKAGE_MANAGER_H

#include "capability_manager.h"
#include "device_comm_agent.h"
#include "package_env_info.h"
#include "package_hash_store.h"
#include "package_process_config.h"
#include "plugin_pkg_version.h"
#include "plugin_version_manager.h"
#include "package_context.h"
#include "package_sender.h"
#include "package_check_code_service.h"
#include "package_loader.h"
#include "hdc_message_builder.h"
#include "driver/ascend_hal.h"
#include "proto/tsd_message.pb.h"
#include "basic_define.h"

#include <string>

namespace tsd {

class PackageManager {
public:
    PackageManager(
        uint32_t logicDeviceId, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, uint32_t platInfoMode,
        bool isAdcEnv, uint32_t chipType);
    ~PackageManager() = default;

    // === Open 流程入口 ===
    TSD_StatusT LoadPackageConfigInfoToDevice(const bool hasPluginVersion)
    {
        return loader_.LoadPackageConfigInfoToDevice(hasPluginVersion);
    }
    TSD_StatusT LoadSysOpKernel() { return loader_.LoadSysOpKernel(); }
    TSD_StatusT LoadPackageToDeviceByConfig() { return loader_.LoadPackageToDeviceByConfig(); }

    TSD_StatusT LoadFileToDevice(
        const char_t* const filePath, const uint64_t pathLen, const char_t* const fileName, const uint64_t fileNameLen,
        const MessageContext& baseCtx)
    {
        return loader_.LoadFileToDevice(filePath, pathLen, fileName, fileNameLen, baseCtx);
    }

    // === 设备响应处理（由 ProcessModeManager 静态回调转发）===
    void SaveDeviceCheckCode(const HDCMessage& msg) { checkCodeSvc_.SaveDeviceCheckCode(msg); }
    void StoreAllPkgHashValue(const HDCMessage& msg) { hashStore_.StoreAllPkgHashValue(msg); }

    // === 状态管理 ===
    void ResetOnClose();
    uint32_t GetHostCheckCode(TsdLoadPackageType type) const { return checkCodeSvc_.GetHostCheckCode(type); }
    void GetAscendLatestIntallPath(std::string& pkgBasePath) const { envInfo_.GetAscendLatestIntallPath(pkgBasePath); }
    void HandleDevicePluginVersionRsp(const HDCMessage& msg) { pluginVersion_.HandleDevicePluginVersionRsp(msg); }

private:
    PackageEnvInfo envInfo_;
    PackageHashStore hashStore_;

    PackageContext ctx_;

    PluginVersionManager pluginVersion_;

    DeviceCommAgent& commAgent_;
    CapabilityManager& capabilityMgr_;

    PackageCheckCodeService checkCodeSvc_;
    PackageSender sender_;
    PackageLoader loader_;
};

} // namespace tsd

#endif // TSD_PACKAGE_MANAGER_H
