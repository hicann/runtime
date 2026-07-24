/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PLUGIN_VERSION_MANAGER_H
#define TSD_PLUGIN_VERSION_MANAGER_H

#include "plugin_pkg_version.h"
#include "package_process_config.h"
#include "package_env_info.h"
#include "package_hash_store.h"
#include "hdc_message_builder.h"
#include "inc/client_manager.h"
#include "proto/tsd_message.pb.h"

#include <map>
#include <string>

namespace tsd {

class PluginVersionManager {
public:
    PluginVersionManager(PackageEnvInfo& envInfo, PackageHashStore& hashStore, ResponseCode& pkgRspCode);
    ~PluginVersionManager() = default;

    bool IsCompatPluginPackage(const PackConfDetail& detail) const;
    PluginUpdateStrategy GetPluginUpdateStrategy();
    bool ShouldLoadCompatPluginPkg(const std::string& pkgPureName);
    bool CompareHostDeviceCompatPluginVersion(const std::string& pkgPureName);
    void HandleDevicePluginVersionRsp(const HDCMessage& msg);

    // 状态（public 供 Facade 引用别名访问）
    std::map<std::string, PluginPkgVersion> devicePluginVersions_;
    PluginUpdateStrategy pluginUpdateStrategy_ = PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    bool hasComputedPluginStrategy_ = false;

private:
    PackageEnvInfo& envInfo_;
    PackageHashStore& hashStore_;
    ResponseCode& pkgRspCode_;
};

} // namespace tsd

#endif // TSD_PLUGIN_VERSION_MANAGER_H
